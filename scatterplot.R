## This script was used to generate the scatterplot comparing TF footprint frequency at VGCC loci and at randomly selected genes. It chooses between Pearson and Spearman correlation based on the normality of the data. The normality of the data is first checked using Shapiro-Wilk test. If the data is normal, Pearson's correlation is calculated; if the data is not normal, Spearman's correlation is calculated. It generates a scatterplot that can then be saved as a PNG.

# Load ggplot2 library
library(ggplot2)
library(ggrepel)

# Create a data frame with TF footprints at VGCC loci and randomly selected genes
df <- data.frame(
  TF = c("ASCL1", "EBF1", "EBF3", "KLF15", "KLF7", "PLAG1", "REST", "SP1", "SP8", "TCF3", "TCF4", "TFAP2A", "TFAP2C", "ZIC2", "ZIC3", "ZIC5", "ZNF93"),
  VGCC_freq = c(5, 7, 6, 10, 9, 5, 6, 8, 6, 6, 7, 9, 9, 5, 5, 6, 9),
  gene_freq = c(27, 21, 19, 42, 42, 29, 28, 39, 32, 26, 23, 37, 37, 28, 30, 31, 40)
)

# Test normality using the Shapiro-Wilk test
vgcc_shapiro <- shapiro.test(df$VGCC_freq)
gene_shapiro <- shapiro.test(df$gene_freq)

# Check if the data is normal
if (vgcc_shapiro$p.value < 0.05 || gene_shapiro$p.value < 0.05) {
  # If data is not normal, use Spearman's correlation
  correlation_test <- cor.test(df$VGCC_freq, df$gene_freq, method = "spearman")
  cat("Using Spearman's correlation\n")
} else {
  # If data is normal, use Pearson's correlation
  correlation_test <- cor.test(df$VGCC_freq, df$gene_freq, method = "pearson")
  cat("Using Pearson's correlation\n")
}

correlation <- correlation_test$estimate
p_value <- correlation_test$p.value

# Create a scatterplot using ggplot2
ggplot(df, aes(x = VGCC_freq, y = gene_freq, label = TF)) +
  geom_point(size = 4, color = "#5f9ea0") +
  xlab("TF Footprint Frequency at VGCC Loci") +
  ylab("TF Footprint Frequency at Randomly Selected Genes") +
  ggtitle(paste0("Correlation: ", round(correlation, 2), ", p-value: ", format.pval(p_value, digits = 2, eps = 0.001))) +
  geom_text_repel(size = 4, min.segment.length = 0.2, box.padding = 0.5) +
  geom_smooth(method = "lm", formula = y ~ x, se = FALSE, linetype = "dashed", color = "blue", size = 1) +
  theme_bw()

# Save the plot as a PNG
ggsave("/home/a/aangeles/Downloads/TF_footprints1.png", width = 10, height = 8, dpi = 300)
