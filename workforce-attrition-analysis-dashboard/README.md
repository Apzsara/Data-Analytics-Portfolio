# Workforce Attrition Analysis Dashboard

**Tools:** Power BI Desktop, Python (Pandas)  
**Domain:** HR Analytics / Employee Attrition  

---

## Overview
This dashboard analyzes employee attrition across multiple dimensions, including tenure, job roles, satisfaction levels, and demographics.  

The goal is to help HR teams **identify top attrition drivers** and focus retention efforts on high-risk employees.  

---

## Key Objectives
- Track attrition patterns across departments, job roles, and demographics  
- Identify high-risk employee groups to inform targeted retention strategies  
- Examine tenure, satisfaction, and demographic correlations with attrition  
- Enable drill-through to employee-level insights for operational decisions  

---

## Dashboard Contents

### KPI Cards
| Metric | Value |
|--------|-------|
| Total Employees | 1,470 |
| Average Salary | $6,500 |
| Attrition Rate | 16.12% |
| Average Tenure | 7.01 years |

### Visuals
- **Area Chart:** Attrition by Tenure  
- **Vertical Bar Chart:** Attrition by Job Satisfaction Level  
- **Horizontal Bar Chart:** Attrition Rate by Job Role (top 3 high-attrition roles highlighted)  
- **Horizontal Bar Chart:** Attrition by Gender  

### Filters & Interactivity
- Page-level slicer: Department  
- Visual-level filtering: Clicking on charts updates related visuals dynamically  

---

## Technical Workflow

### Python (Pandas)
- Data cleaning: removed redundant and constant columns to ensure accurate metrics  
- Prepared data for Power BI modeling and analysis  

### Power BI & DAX
- **Interactive visuals:** KPI cards, charts, drillthrough pages  
- **Conditional formatting:** Highlights high-risk roles and critical trends  
- **DAX measures:** `CALCULATE`, `FILTER`, `DIVIDE`, `COUNTROWS`, `DISTINCTCOUNT`, `SWITCH`  
- Calculations for tenure bands, average salary, attrition metrics, and role-specific insights  
- Tooltips and data labels for clarity  

---

## Key Insights
- **High-Risk Roles:** Sales Representatives identified as the top-risk group with low tenure and low job satisfaction  
- **Tenure Critical Point:** Significant attrition spike occurs within the first two years, highlighting areas for early-career retention initiatives  
- **Satisfaction Correlation:** Inverse relationship between satisfaction scores and attrition, particularly in Research & Development and Sales departments  
- **Demographic Trends:** Attrition patterns by gender help monitor diversity and inclusion metrics  

---

## Recommended Use / Impact
- Prioritize retention strategies for high-risk roles and departments  
- Enhance onboarding and early-career engagement programs to reduce early attrition  
- Monitor employee satisfaction and demographics to guide HR interventions  
- Use drill-through analysis to identify high-value employees at risk  

---

## Files Included
- `WorkforceAttritionDashboard.pbix` – Power BI file  
- `screenshots/` – Preview images of dashboard pages  
- `README.md` – This file  

---

## Dataset Notes
- Sample HR dataset with fields including Job Role, Tenure, Salary, Job Satisfaction, Attrition status, Department, Gender, and other employee demographics  
- Data was cleaned and validated prior to analysis  

---

## Conclusion
This dashboard provides a **clear view of attrition trends**, enabling HR teams to make data-driven decisions for retention strategies. By combining KPIs, interactive visuals, and drill-through analysis, stakeholders can identify high-risk employees, understand the drivers of attrition, and implement targeted interventions.
