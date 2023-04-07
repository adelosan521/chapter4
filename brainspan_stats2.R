##This code reads in TF expression data from Brainspan (shown is code for ASCL1), finds rows with "frontal cortex" in the brain_region column (for analysis of frontal cortex samples). It checks normality using Shapiro-Wilk Test. It then calculates the median and interquartile range for the rows before row 76 ("early" fetal data) and after 160 but before row 239 ("late" fetal data), and performs a Mann-Whitney U test for comparison. It also counts the number of samples in the early fetal group and the late fetal group. It prints all of the above mentioned values as well.

data <- read.csv("/home/a/aangeles/Downloads/ASCL1_data.csv")
head(data)

# use grep to find rows with "frontal cortex"
fc_rows <- grep("frontal", data$brain_region)
fc_rows_early_prenatal <- fc_rows[fc_rows <= 76] # early prenatal rows
fc_rows_late_prenatal <- fc_rows[fc_rows >= 160 & fc_rows <= 239] # late prenatal rows

# Subset the data for early prenatal and late prenatal samples separately
early_prenatal_data <- data$RPKM[fc_rows_early_prenatal]
late_prenatal_data <- data$RPKM[fc_rows_late_prenatal]

num_early_prenatal <- length(early_prenatal_data)
num_late_prenatal <- length(late_prenatal_data)

library(nortest)

# Test normality of early prenatal data
if (ad.test(early_prenatal_data)$p.value < 0.05) {
  print("Early prenatal data is not normally distributed")
} else {
  print("Early prenatal data is normally distributed")
}

# Test normality of late prenatal data
if (ad.test(late_prenatal_data)$p.value < 0.05) {
  print("Late prenatal data is not normally distributed")
} else {
  print("Late prenatal data is normally distributed")
}

# Calculate median and IQR for each group
early_prenatal_med <- median(early_prenatal_data)
early_prenatal_iqr <- IQR(early_prenatal_data)
late_prenatal_med <- median(late_prenatal_data)
late_prenatal_iqr <- IQR(late_prenatal_data)

# Print median and IQR for each group
cat("Early prenatal group median:", early_prenatal_med, "\n")
cat("Early prenatal group IQR:", early_prenatal_iqr, "\n")
cat("Number of samples in early prenatal group:", num_early_prenatal, "\n")
cat("Late prenatal group median:", late_prenatal_med, "\n")
cat("Late prenatal group IQR:", late_prenatal_iqr, "\n")
cat("Number of samples in late prenatal group:", num_late_prenatal, "\n")

# Mann-Whitney U test
mwu <- wilcox.test(early_prenatal_data, late_prenatal_data)

# Print test results
cat("\nMann-Whitney U test:\n")
cat("U statistic:", mwu$statistic, "\n")
cat("p-value:", mwu$p.value, "\n")
cat("Significant:", ifelse(mwu$p.value < 0.05, "Yes", "No"), "\n")
