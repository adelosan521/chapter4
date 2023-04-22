## Chi-square test for comparing TF footprint frequency at VGCC loci versus random genes. It was run individually for each TF.
# Define the observed counts
observed_counts <- matrix(c(5, 7, 27, 21), nrow = 2)

# Define the row and column names
rownames(observed_counts) <- c("VGCC loci", "Random genes")
colnames(observed_counts) <- c("TF motif present", "TF motif absent")

# Perform the chi-square test
result <- chisq.test(observed_counts)

# Print the chi-square statistic and p-value
cat("Chi-squared statistic: ", result$statistic, "\n")
cat("p-value: ", result$p.value, "\n")

# Check for significance at 0.05 level (i.e. alpha is set at 0.05)
if(result$p.value < 0.05){
  cat("The difference in TF motif frequency between VGCC loci and random genes is significant.\n")
}else{
  cat("There is no significant difference in TF motif frequency between VGCC loci and random genes.\n")
}
