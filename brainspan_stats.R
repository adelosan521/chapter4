## This code reads in TF expression data from Brainspan, finds rows with "frontal" in the brain_region column, and checks normality using Shapiro-Wilk Test. It then calculates the median and interquartile range for the rows before row 239 (prenatal data) and after row 239 (postnatal data), and performs a Mann-Whitney U test for comparison. Although not used in the thesis, code for calculating mean and standard error, as well as conducting a t-test is also provided. 

#read data (example is ASCL1 data from Brainspan)
data <- read.csv("/home/a/aangeles/Downloads/ASCL1_data.csv")
head(data)
# use grep to find rows with "frontal cortex"
fc_rows <- grep("frontal", data$brain_region)
head(fc_rows)
print(fc_rows)

library(nortest)
# Subset the data for fetal and postnatal samples separately
fetal_data <- data$RPKM[fc_rows[fc_rows < 239]]
postnatal_data <- data$RPKM[fc_rows[fc_rows >= 239]]

if (ad.test(fetal_data)$p.value < 0.05) {
  print("Fetal data is not normally distributed")
} else {
  print("Fetal data is normally distributed")
}

# Test normality of postnatal data
if (ad.test(postnatal_data)$p.value < 0.05) {
  print("Postnatal data is not normally distributed")
} else {
  print("Postnatal data is normally distributed")
}
#subset for median and IQR calculation
fetal <- data$RPKM[fc_rows[fc_rows < 239]]
postnatal <- data$RPKM[fc_rows[fc_rows >= 239]]

# Calculate median and IQR for each group
fetal_med <- median(fetal)
fetal_iqr <- IQR(fetal)
postnatal_med <- median(postnatal)
postnatal_iqr <- IQR(postnatal)

# Print median and IQR for each group
cat("Fetal group median:", fetal_med, "\n")
cat("Fetal group IQR:", fetal_iqr, "\n")
cat("Postnatal group median:", postnatal_med, "\n")
cat("Postnatal group IQR:", postnatal_iqr, "\n")

# Mann-Whitney U test
mwu <- wilcox.test(fetal, postnatal)

# Print test results
cat("\nMann-Whitney U test:\n")
cat("U statistic:", mwu$statistic, "\n")
cat("p-value:", mwu$p.value, "\n")
cat("Significant:", ifelse(mwu$p.value < 0.05, "Yes", "No"), "\n")

# calculate mean and SE for "frontal cortex" rows before row 239 (i.e. the rows containing the prenatal data)
prenatal_mean <- mean(data$RPKM[fc_rows[fc_rows < 239]])
prenatal_se <- sd(data$RPKM[fc_rows[fc_rows < 239]]) / sqrt(length(fc_rows[fc_rows < 239]))

# calculate mean and SE for "frontal cortex" rows after row 239 (i.e. the rows containing the postnatal data)
postnatal_mean <- mean(data$RPKM[fc_rows[fc_rows >= 239]])
postnatal_se <- sd(data$RPKM[fc_rows[fc_rows >= 239]]) / sqrt(length(fc_rows[fc_rows >= 239]))

fc_before <- data$RPKM[fc_rows[fc_rows < 239]]
fc_after <- data$RPKM[fc_rows[fc_rows >= 239]]
ttest <- t.test(fc_before, fc_after)

# print results
cat("Prenatal mean:", prenatal_mean, "\n")
cat("Prenatal SE:", prenatal_se, "\n")
cat("Postnatal mean:", postnatal_mean, "\n")
cat("Postnatal SE:", postnatal_se, "\n")
cat("t-value:", ttest$statistic, "\n")
cat("p-value:", ttest$p.value, "\n")
