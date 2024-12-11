# **Transcriptional Analysis of Hepatocellular Carcinoma (HCC) Data**

--- 

## **Objective**
This pipeline performs differential gene expression analysis on Hepatocellular Carcinoma (HCC) using TCGA data. It includes steps for identifying differentially expressed genes (DEGs), conducting gene set enrichment analysis (GSEA), transcription factor analysis, and visualizing results through volcano plots and heatmaps.

--- 

## **Required Libraries**
- **DESeq2**: for differential expression analysis
- **TCGAbiolinks**: for querying TCGA data
- **clusterProfiler**: for gene set enrichment analysis

--- 

## **Steps**
1. **Install Required Packages**  
   Install `DESeq2`, `TCGAbiolinks`, and `clusterProfiler` packages using `BiocManager`.
   
2. **Load Libraries**  
   Load the necessary libraries for differential expression and TCGA data handling.
   
3. **Query TCGA**  
   Download and prepare Hepatocellular Carcinoma (HCC) data from TCGA.
   
4. **Prepare Data**  
   Extract count and clinical data and filter the samples to separate tumor and normal tissues.
   
5. **DESeq2 Analysis**  
   Create a DESeq2 dataset, perform differential expression analysis, and identify DEGs.
   
6. **Gene Set Enrichment**  
   Conduct Gene Set Enrichment Analysis (GSEA) using the DEGs.
   
7. **Transcription Factor Analysis**  
   Perform enrichment analysis to identify relevant transcription factors.
   
8. **Biomarker Identification**  
   Identify potential biomarkers by filtering DEGs based on significant p-values and fold changes.
   
9. **Visualization**  
   Create volcano plots to visualize DEGs and heatmaps for expression patterns.

--- 

## **Outputs**

**Volcano plots** showing the distribution of DEGs with Log2 Fold Change and adjusted p-values.

<img src="https://github.com/user-attachments/assets/9ee858e2-3b78-4492-b036-bb9e4ef2c0ca" alt="Volcano_plot_HCC" width="70%">

Distribution of differentially expressed genes (DEGs) based on their Log2 Fold Change (x-axis) and -Log10 Adjusted p-value (y-axis) for tumor and normal samples in HCC.

X-axis (Log2 Fold Change):

- Positive values indicate genes that are more highly expressed in tumor samples.
- Negative values indicate genes that are more highly expressed in normal samples.

Y-axis (-Log10 Adjusted p-value):

- This axis shows the significance of the differential expression.
- Higher values (further up) indicate more statistically significant differences between tumor and normal samples.

Color coding:

- Red dots: genes that are significantly upregulated in tumor samples (high fold change in tumor).
- Blue dots: genes that are significantly upregulated in normal samples (high fold change in normal).

**Heatmap** of top DEGs for visualizing gene expression differences between tumor and normal samples.

<img src="https://github.com/user-attachments/assets/b2d12829-d4eb-480c-8726-a02b130a024b" alt="Heatmap_HCC" width="70%">

The heatmap represents the expression levels of the top 20 differentially expressed genes (DEGs) in a dataset from TCGA for Hepatocellular Carcinoma (HCC).

Rows: Each row represents a gene, identified by unique Ensembl Gene IDs (the "ENSG..." codes you see on the right). 

Columns: Each column corresponds to a sample in the dataset. 

Colors:
- Green: lower expression.
- Red: higher expression.
- Black: median expression.

--- 

## **References**
- Hepatocellular carcinoma data sourced from TCGA.
- Key biomarkers and literature references: AFP, DCP, CK19, GP73, and HSP70.

## **Conclusion**

This study highlights the intricate interplay of genetic mutations, signaling disruptions, and transcriptional changes in HCC progression. The identification of frequently mutated genes like TP53, CTNNB1, and ARID1A, along with their associated pathways, underscores their pivotal roles in tumorigenesis. Differential expression analysis and biomarker discovery further enhance our understanding of HCC at the molecular level, paving the way for advancements in precision oncology. By integrating genetic and transcriptional data, this research provides a robust foundation for developing diagnostic tools and therapeutic strategies aimed at improving outcomes for HCC patients.

## **Note:**

Go through the documentation file for complete project details
