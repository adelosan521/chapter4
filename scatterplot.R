## This script was used to analyze the relationship between TF frequency at VGCC loci and at randomly selected genes. It prints the correlation coefficient, p-value, and makes a scatterplot using ggplot2.

##load ggplot2 and ggrepel libraries
library(ggplot2)
library(ggrepel)

# create a data frame with TF footprints at VGCC loci and randomly selected genes
df <- data.frame(
  TF = c("ASCL1", "EBF1", "EBF3", "KLF15", "KLF7", "PLAG1", "REST", "SP1", "SP8", "TCF3", "TCF4", "TFAP2A", "TFAP2C", "ZIC2", "ZIC3", "ZIC5", "ZNF93"),
  VGCC_freq = c(5, 7, 6, 10, 9, 5, 6, 8, 6, 6, 7, 9, 9, 5, 5, 6, 9),
  gene_freq = c(27, 21, 19, 42, 42, 29, 28, 39, 32, 26, 23, 37, 37, 28, 30, 31, 40)
)

# calculate the correlation between VGCC and gene frequencies
correlation <- cor(df$VGCC_freq, df$gene_freq)
p_value <- cor.test(df$VGCC_freq, df$gene_freq)$p.value

# create a scatterplot using ggplot2
ggplot(df, aes(x = VGCC_freq, y = gene_freq, label = TF)) +
  geom_point(size = 4, color = "#5f9ea0") +
  xlab("TF Footprint Frequency at VGCC Loci") +
  ylab("TF Footprint Frequency at Randomly Selected Genes") +
  ggtitle(paste0("Correlation: ", round(correlation, 2), ", p-value: ", format.pval(p_value, digits = 2, eps = 0.001))) +
  geom_text_repel(size = 4, min.segment.length = 0.2, box.padding = 0.5) +
  theme_bw()


# save the plot as a PNG
ggsave("/home/a/aangeles/Downloads/TF_footprints1.png", width = 10, height = 8, dpi = 300)
