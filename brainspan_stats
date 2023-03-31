#read data (example is ASCL1 data from Brainspan)
data <- read.csv("/home/a/aangeles/Downloads/ASCL1_data.csv")
head(data)
# use grep to find rows with "frontal cortex"
fc_rows <- grep("frontal", data$brain_region)
head(fc_rows)
print(fc_rows)

# calculate mean and SE for "frontal cortex" rows before row 239 (i.e. the rows containing the prenatal data)
prenatal_mean <- mean(data$RPKM[fc_rows[fc_rows < 239]])
prenatal_se <- sd(data$RPKM[fc_rows[fc_rows < 239]]) / sqrt(length(fc_rows[fc_rows < 239]))

# calculate median and SE for "frontal cortex" rows after row 239 (i.e. the rows containing the postnatal data)
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
