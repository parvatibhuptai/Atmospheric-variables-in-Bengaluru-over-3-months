# Load required libraries
library(readxl)
library(psych)
library(ggplot2)

# Step 1: Load Dataset
# Dataset contains atmospheric variables for Bengaluru (2019)
data <- read_excel("/Users/asmitabaul/Downloads/bengaluru_2019_data.xlsx")

# View first few rows
head(data)


# Step 2: Data Cleaning
# Remove irrelevant variables (time-related and non-informative variables)
data_clean <- data[, !names(data) %in% c(
  "Year", "Month", "Day", "Hour", "Minute",
  "Fill Flag", "Cloud Type"
)]

# Remove missing values (PCA cannot handle NA values)
data_clean <- na.omit(data_clean)

# Check structure of cleaned data
str(data_clean)


# Step 3: Correlation Matrix
# Purpose: To check relationships among variables (PCA requires correlated variables)
cor_matrix <- cor(data_clean)
print(cor_matrix)

# NOTE:
# No formal hypothesis test here
# Interpretation:
# Strong correlations indicate multicollinearity → PCA is appropriate


# Step 4: KMO Test (Sampling Adequacy)
# Purpose: To check if data has enough shared variance for PCA

# H0: Data is NOT suitable for PCA (low shared variance)
# H1: Data IS suitable for PCA (adequate shared variance)

KMO(data_clean)

# Interpretation:
# KMO > 0.6 → acceptable for PCA
# Our result (~0.74) → data is suitable


# Step 5: Bartlett’s Test of Sphericity
# Purpose: To test whether variables are significantly correlated

# H0: Variables are NOT correlated (correlation matrix is identity)
# H1: Variables ARE correlated

cortest.bartlett(cor_matrix, n = nrow(data_clean))

# Interpretation:
# p < 0.05 → Reject H0 → variables are correlated → PCA applicable


# Step 6: Standardization
# Purpose: Ensure all variables contribute equally (remove scale differences)
data_scaled <- scale(data_clean)


# Step 7: Apply PCA
# prcomp() performs PCA using standardized data
pca_result <- prcomp(data_scaled, center = TRUE, scale. = TRUE)

# Summary of PCA (variance explained)
summary(pca_result)


# Step 8: Scree Plot
# Purpose: To determine number of principal components
plot(pca_result, type = "l", main = "Scree Plot")

# Interpretation:
# Look for "elbow point" → optimal number of components


# Step 9: Variance Explained
summary(pca_result)$importance

# Interpretation:
# PC1 explains highest variance, followed by PC2, PC3, etc.
# First few PCs capture majority of information


# Step 10: Loadings (Variable Contribution)
loadings <- pca_result$rotation
print(loadings)

# Interpretation:
# Loadings show how strongly each variable contributes to each component


# Step 11: Biplot
# Shows both observations and variable directions
biplot(pca_result, scale = 0)

# Interpretation:
# Variables in same direction → positive correlation
# Opposite direction → negative correlation


# Step 12: PCA Scatter Plot (Clean Visualization)
# Convert PCA scores into dataframe
pca_data <- as.data.frame(pca_result$x)

# Plot first two principal components
ggplot(pca_data, aes(x = PC1, y = PC2)) +
  geom_point(alpha = 0.3) +
  theme_minimal() +
  ggtitle("PCA Scatter Plot")

# Interpretation:
# Shows distribution of data along principal components