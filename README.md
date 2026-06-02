# Atmospheric-variables

## Dimensionality Reduction of Atmospheric Variables (Bengaluru)

A statistical analysis project utilizing Principal Component Analysis (PCA) to identify the underlying drivers of weather patterns in Bengaluru by reducing highly collinear atmospheric data into uncorrelated principal components.

## Team & My Contribution
This was a collaborative academic project completed with Asmita Baul and Aditya Agrawal for an Advanced Statistics course. 
* **My Role:** I sourced the real-world 2019 Bengaluru atmospheric dataset, supported the R-based data analysis workflow, and assisted in compiling the final statistical interpretations and report.

## Project Objective
Atmospheric datasets often contain interrelated variables (e.g., temperature, solar radiation, humidity) exhibiting high multicollinearity. The goal of this analysis was to reduce 19 meteorological variables into a few significant factors while retaining maximum variance, aiming to create a more efficient model for environmental forecasting.

## Tech Stack & Methodology
* **Language:** R
* **Libraries:** `readxl`, `psych` (for KMO/Bartlett tests), `ggplot2` (for visualizations).
* **Workflow:**
  * **Assumption Validation:** Verified sampling adequacy using the KMO Test (scored 0.74, indicating suitability) and confirmed significant variable correlation using Bartlett’s Test of Sphericity.
  * **Standardization:** Applied Z-score normalization (`scale()`) to ensure equal contribution across varying units like Celsius and hPa.
  * **PCA Execution:** Extracted orthogonal principal components using the `prcomp()` function and visualized the variable relationships using Scree plots, scatter plots, and Biplots.

## Key Findings
The PCA successfully simplified the 19 original variables into 3 primary dimensions, accounting for 64.7% of the total dataset information:
* **PC1 (Solar Radiation Factor - 40.7% variance):** Driven by high positive loadings for GHI, DNI, DHI, and Temperature, representing overall solar energy intensity.
* **PC2 (Moisture & Atmospheric Factor - 14.8% variance):** Represented by Precipitable Water, Dew Point, and Aerosol Optical Depth, indicating air composition and moisture levels.
* **PC3 (Wind & Pressure Factor - 9.1% variance):** Driven by Pressure and Wind Speed, reflecting atmospheric dynamics.
