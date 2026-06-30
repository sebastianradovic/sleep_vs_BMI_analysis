# Sleep Duration and BMI Analysis Using NHANES

## Overview

This project explores the relationship between sleep duration and body mass index (BMI) among U.S. adults using data from the National Health and Nutrition Examination Survey (NHANES). The analysis was completed in R and demonstrates data cleaning, transformation, visualization, and summary statistics using the tidyverse.

---

## Research Question

**How does sleep duration differ across BMI categories among U.S. adults?**

---

## Dataset

**Dataset:** NHANES

The National Health and Nutrition Examination Survey (NHANES) is a nationally representative survey conducted by the Centers for Disease Control and Prevention (CDC) that collects demographic, health, nutrition, laboratory, and examination data from the U.S. population.

Variables used in this analysis include:

- BMI
- BMI Category (created during data cleaning)
- Sleep Hours per Night
- Gender

---

## Methods

The analysis included:

- Importing and cleaning NHANES data
- Removing observations with missing BMI or sleep values
- Creating BMI categories using `case_when()`
- Reordering BMI categories using `factor()`
- Calculating summary statistics with `group_by()` and `summarise()`
- Creating visualizations with **ggplot2**

---

## Results

## Figure 1. Average Sleep Duration by BMI Category

![Average Sleep Duration](sleep_vs_BMI_barchart.png)

---

## Figure 2. Distribution of Sleep Duration by BMI Category

![Sleep Distribution](sleep_vs_BMI_boxplot.png)

---
## Summary Statistics

The complete summary statistics table is available here:

| BMI Category | Sample Size | Mean Sleep | Median | SD | Q1 | Q3 | IQR |
|--------------|------------:|-----------:|--------:|---:|---:|---:|----:|
| Underweight | 157 | 7.22 | 7 | 1.42 | 6 | 8 | 2 |
| Healthy Weight | 2359 | 7.00 | 7 | 1.33 | 6 | 8 | 2 |
| Overweight | 2489 | 6.92 | 7 | 1.27 | 6 | 8 | 2 |
| Obese | 2678 | 685 | 7 | 1.42 | 6 | 8 | 2 |
---

## Figure 3. Distribution of Sleep Duration by BMI Category and Gender

![Sleep Distribution by Gender](sleep_vs_BMI_gender_boxplot.png)


## Skills Demonstrated

- R Programming
- dplyr
- ggplot2
- Data Cleaning
- Data Wrangling
- Exploratory Data Analysis (EDA)
- Data Visualization
- Summary Statistics

---

## Future Improvements

Potential extensions of this project include:

- Statistical hypothesis testing
- Linear regression
- Logistic regression
- Additional demographic comparisons
- Interactive visualizations

---

## Author

Sebastian Radovic
