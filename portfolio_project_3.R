# =========================================
# Sleep Duration and Obesity Analysis (NHANES)

# Relationship Between Sleep Duration and BMI Across U.S. Citizens
# =========================================

# 1. Load and install packages
library(dplyr)
library(ggplot2)
install.packages("NHANES")
library(NHANES)
View(NHANES)

# 2. Explore variables in data set
names(NHANES)

# 3. Make a smaller data set with only the variables I need
sleep_bmi_data <- NHANES %>%
  select(Age, Gender, BMI, SleepHrsNight)

names(sleep_bmi_data)
dim(sleep_bmi_data)
head(sleep_bmi_data)

# 4. Look for missing values
sum(is.na(sleep_bmi_data$Age))
sum(is.na(sleep_bmi_data$Gender))
sum(is.na(sleep_bmi_data$BMI))
sum(is.na(sleep_bmi_data$SleepHrsNight))

# 5. Remove rows with missing values
sleep_bmi_data <- sleep_bmi_data %>% 
  filter(!is.na(BMI) & !is.na(SleepHrsNight))

nrow(sleep_bmi_data)

# 6. Add BMI Category column
sleep_bmi_data <- sleep_bmi_data %>% 
  mutate(BMI_category = case_when(BMI < 18.5 ~ "Underweight",
                                  BMI >= 18.5 & BMI <= 24.99 ~ "Healthy Weight",
                                  BMI >= 25 & BMI <= 29.99 ~ "Overweight",
                                  BMI >= 30 ~ "Obese"))


# 7. Calculate the average BMI for each BMI category
sleep_bmi_data <- sleep_bmi_data %>% 
  group_by(BMI_category) %>% 
  mutate(Average_BMI = mean(BMI)) %>% 
  ungroup()

BMI_summary <- sleep_bmi_data %>% 
  group_by(BMI_category) %>% 
  summarise(Average_BMI = mean(BMI)) %>% 
  ungroup()


# 7. Calculate the average sleep hours for each BMI category
sleep_bmi_data <- sleep_bmi_data %>% 
  group_by(BMI_category) %>% 
  mutate(Average_sleep = mean(SleepHrsNight)) %>% 
  ungroup()


sleep_data_summary <- sleep_bmi_data %>% 
  group_by(BMI_category) %>% 
  summarise(Average_sleep = mean(SleepHrsNight)) %>% 
  ungroup()

# 8. Reorder BMI category
sleep_bmi_data <- sleep_bmi_data %>% 
  mutate(BMI_category = factor(
    BMI_category, levels = c("Underweight", "Healthy Weight", "Overweight", "Obese")
  ))

sleep_data_summary <- sleep_data_summary %>% 
  mutate(BMI_category = factor(
    BMI_category, levels = c("Underweight", "Healthy Weight", "Overweight", "Obese")
  ))

# 9. Graph the relationship between sleep hours and BMI category (Bar chart)
sleep_vs_BMI_barchart <- ggplot(sleep_data_summary, aes(x = BMI_category,
                                                    y = Average_sleep)) +
  geom_col(aes(fill = BMI_category)) +
  labs(
    title = "Average Sleep Duration by BMI Category",
    x = "BMI Category",
    y = "Average Sleep (Hours per Night)") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(legend.position = "none") +
  geom_text(aes(label = round(Average_sleep, 2)),
    vjust = -0.5)

sleep_vs_BMI_barchart

# 10. Graph the relationship between sleep hours and BMI category (Box plot)
sleep_vs_BMI_boxplot <- ggplot(sleep_bmi_data, aes(x = BMI_category,
                           y = SleepHrsNight)) +
  geom_boxplot(aes(fill = BMI_category)) +
  labs(
    title = "Distribution of Sleep Duration Across BMI Categories",
    x = "BMI Category",
    y = "Sleep (Hours per Night)") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(legend.position = "none")

sleep_vs_BMI_boxplot

# 11. Build summary table
sleep_summary_table <- sleep_bmi_data %>% 
  group_by(BMI_category) %>% 
  summarise(Sample_Size = n(),
            Mean_Sleep_Hours = round(mean(SleepHrsNight, na.rm = TRUE), 2),
            Median_Sleep_Hours = round(median(SleepHrsNight, na.rm = TRUE), 2),
            SD_Sleep_Hours = round(sd(SleepHrsNight, na.rm = TRUE), 2),
            Q1_Sleep_Hours = round(quantile(SleepHrsNight, 0.25, na.rm = TRUE), 2),
            Q3_Sleep_Hours = round(quantile(SleepHrsNight, 0.75, na.rm = TRUE), 2),
            IQR_Sleep_Hours = round(IQR(SleepHrsNight, na.rm = TRUE), 2))

# 12. Graph the relationship between sleep hours and BMI category across genders (Box plot)
sleep_vs_BMI_gender_boxplot <- ggplot(sleep_bmi_data, aes(x = BMI_category,
                                                   y = SleepHrsNight)) +
  geom_boxplot(aes(fill = BMI_category)) +
  labs(
    title = "Distribution of Sleep Duration Across BMI Categories",
    x = "BMI Category",
    y = "Sleep (Hours per Night)") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(legend.position = "none") +
  facet_wrap(~Gender)

sleep_vs_BMI_gender_boxplot

# 13. Reorder gender category
sleep_bmi_data <- sleep_bmi_data %>% 
  mutate(Gender = factor(Gender,
                         levels = c("male", "female"),
                         labels = c("Male", "Female")))

# 14. Save plots using ggsave
ggsave("sleep_vs_BMI_barchart.png",
       plot = sleep_vs_BMI_barchart,
       width = 10,
       height = 6)

ggsave("sleep_vs_BMI_boxplot.png",
       plot = sleep_vs_BMI_boxplot,
       width = 10,
       height = 6)

ggsave("sleep_vs_BMI_gender_boxplot.png",
       plot = sleep_vs_BMI_gender_boxplot,
       width = 10,
       height = 6)

#15. Save summary table as CSV
write.csv(sleep_summary_table,
          "sleep_summary_table.csv",
          row.names = FALSE)

