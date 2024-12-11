# Step 1: Install required packages
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("DESeq2")
BiocManager::install("TCGAbiolinks")
install.packages("clusterProfiler")

# Step 2: Load required libraries
library(DESeq2)
library(TCGAbiolinks)
library(clusterProfiler)

# Step 3: Query TCGA for the Hepatocellular Carcinoma (HCC) Dataset
query <- GDCquery(project = "TCGA-LIHC", 
                  data.category = "Gene expression", 
                  data.type = "Gene expression quantification", 
                  workflow.type = "STAR - Counts")
GDCdownload(query)
data <- GDCprepare(query)

# Step 4: Extract and Prepare Count and Clinical Data
countData <- data$counts
clinicalData <- data$clinical

# Step 5: Separate Tumor and Normal Samples
clinicalData$sample_type <- as.factor(clinicalData$sample_type)
tumorSamples <- clinicalData[clinicalData$sample_type == "Tumor",]
normalSamples <- clinicalData[clinicalData$sample_type == "Solid Tissue Normal",]
countData <- countData[, colnames(countData) %in% c(tumorSamples$barcode, normalSamples$barcode)]

# Step 6: Create DESeq2 Dataset and Perform Differential Expression Analysis
dds <- DESeqDataSetFromMatrix(countData = countData, 
                              colData = clinicalData, 
                              design = ~sample_type)
dds <- DESeq(dds)

# Step 7: Filter Results to Identify Differentially Expressed Genes (DEGs)
res <- results(dds)
res <- res[!is.na(res$padj),]
DEGs <- subset(res, padj < 0.05 & abs(log2FoldChange) > 1)

# Step 8: Gene Set Enrichment Analysis (GSEA)
gsea <- gseKEGG(geneList = DEGs$log2FoldChange, 
                organism = "hsa", 
                pvalueCutoff = 0.05)

# Step 9: Transcription Factor Analysis
enrichR::enrichr(DEGs$gene, database = "ChEA_2016")

# Step 10: Biomarker Identification
biomarkers <- DEGs[DEGs$padj < 0.01 & abs(DEGs$log2FoldChange) > 2,]

# Step 11: Volcano Plot of DEGs
volcanoData <- data.frame(log2FoldChange = DEGs$log2FoldChange, 
                          -log10P = -log10(DEGs$padj))
ggplot(volcanoData, aes(x = log2FoldChange, y = -log10P)) + 
  geom_point(aes(color = ifelse(padj < 0.05, "red", "black"))) +
  theme_minimal()

# Step 12: Heatmap of Top 20 DEGs
top20DEGs <- DEGs[1:20,]
heatmapData <- countData[top20DEGs$gene, ]
pheatmap(heatmapData)

# Step 13: Detailed Volcano Plot with Sample Type Color Coding
volcanoData$sampleType <- ifelse(tumorSamples$sample_type == "Tumor", "red", "blue")
ggplot(volcanoData, aes(x = log2FoldChange, y = -log10P, color = sampleType)) +
  geom_point() + 
  scale_color_manual(values = c("blue", "red")) +
  theme_minimal()

# Step 14: Heatmap with Detailed Axis Labels
pheatmap(heatmapData, cluster_rows = T, cluster_cols = T)
