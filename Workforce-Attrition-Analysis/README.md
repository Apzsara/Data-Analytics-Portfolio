# Workforce Attrition Analysis Dashboard

### Project Objective
To identify key drivers of employee turnover across various departments and demographics, enabling HR teams to implement targeted retention strategies.

### Key Technical Features
* **Strategic KPIs:** Monitors Total headcount, Average Salary, Attrition Rate (16.12%), and Average Tenure (7.01 years).
* **High-Risk Highlighting:** Used conditional formatting in bar charts to automatically flag the top three job roles with the highest attrition rates.
* **Multi-Dimensional Filtering:** Integrated department-level slicers and cross-filtering to isolate attrition patterns by satisfaction level and gender.
* **Predictive Indicators:** Analyzed the relationship between tenure and attrition peaks to identify the "critical window" where employees are most likely to leave.

### Tech Stack & DAX Implementation
* **Tool:** Power BI Desktop
* **Data Preparation:** Used Python (Pandas) for data cleaning, specifically removing redundant columns and constant variables to improve model performance.
* **DAX Measures:**
    * **Calculations:** Used `DIVIDE` and `COUNTROWS` for accurate attrition rate percentages.
    * **Logic:** Implemented `SWITCH` for dynamic tenure grouping and `CALCULATE` with `FILTER` for department-specific metrics.

### Key Insights & Impact
* **Role-Specific Risk:** Identified Sales Representatives as the highest-risk group, characterized by low tenure and low job satisfaction.
* **Tenure Critical Point:** The data reveals a significant attrition spike within the first two years of employment, suggesting a need for improved onboarding or early-career engagement.
* **Satisfaction Correlation:** A direct inverse relationship exists between job satisfaction scores and attrition counts, particularly within the Research & Development and Sales departments.
* **Demographic Trends:** Visualized attrition distribution by gender to ensure diversity and inclusion metrics are monitored alongside turnover.

### Files Included
* **WorkforceAttritionDashboard.pbix** – Power BI file
* **screenshots/** – Preview images of dashboard pages
* **README.md** – This file
