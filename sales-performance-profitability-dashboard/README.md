# Sales Performance & Profitability Dashboard

**Tools:** Power BI Desktop  
**Domain:** Retail / Sales Analytics  

---

## Overview
This project provides an **interactive analysis of sales performance** across four regions from 2014–2017, focusing on revenue, profit, sub-category performance, and year-over-year (YoY) growth.  

The dashboard is designed to help stakeholders **monitor trends, assess profitability, and make data-driven decisions** using dynamic visuals and DAX measures.  

---

## Key Objectives
- Track sales performance and profit across regions, categories, and subcategories  
- Identify top-performing products and regions for informed decision-making  
- Support year-over-year growth analysis and trend monitoring  
- Enable drill-through to customer- and order-level insights  

---

## Dashboard Highlights

### KPIs (2014–2017)
| Metric | Value | Notes |
|--------|-------|-------|
| Total Revenue | $2.3M | Across all regions and categories |
| Total Profit | $286.4K | Aggregate profit across 4 regions |
| Total Orders | 5,009 | Number of transactions analyzed |
| Profit Margin | 12.47% | Overall across regions and product categories |
| YoY Change | 46.9% | Percentage growth in revenue over the period |

### Core Visuals
- **Cumulative Revenue Trend:** Tracks revenue over time, with YoY percentages in tooltips  
- **Region-wise Sales by Category:** Stacked bar chart showing performance across regions  
- **Sub-Category Sales & Profit:** Scrollable horizontal bars for easy comparison  
- **Drillthrough – Order Details:**  
  - Region-wise revenue trend (area chart)  
  - Sales by state map with gradient conditional formatting  
  - Customer-level matrix showing order count, revenue, and profit (conditional formatting: Green = positive profit, Red = negative profit)  

### Interactivity
- Page-level and visual-level filtering  
- Drillthrough for granular customer/order analysis  
- Cross-filtering across Year, Region, and Product Category slicers  

---

## Technical Workflow

### Power BI & DAX
- **KPI Cards, Interactive Charts, Drillthrough Pages, Conditional Formatting** for clear visualization  
- **DAX Measures**: `CALCULATE`, `FILTER`, `ALL`, `REMOVEFILTERS`, `SAMEPERIODLASTYEAR`, `SUMX`, `DIVIDE`, `TOTALYTD`  
- Time intelligence and context control to calculate YoY growth, profit margin, and row-level measures  
- Tooltip customizations and scrollable visuals to support fast insights  

---

## Key Insights
- **Revenue Growth:** 46.9% YoY increase indicates expanding sales across the period  
- **Profitability:** 12.47% overall profit margin, showing stable returns across regions and categories  
- **Regional & Product Insights:** Interactive visuals allow stakeholders to identify top-performing regions, categories, and subcategories  
- **Customer-Level Analysis:** Drillthrough matrix highlights high-value customers and order patterns for operational insights  
- **Decision Support:** Enables stakeholders to make data-driven decisions through slicers, drillthrough, and clear visual cues  

---

## Recommended Use / Impact
- Monitor trends in revenue and profit to inform regional strategy  
- Focus on high-performing product categories and subcategories for inventory and promotion planning  
- Use drillthrough analysis to identify high-value customers and sales patterns  

---

## Files Included
- `AdvancedSalesDashboard.pbix` – Power BI file  
- `screenshots/` – Preview images of main and drillthrough pages  
- `README.md` – This file  

---

## Dataset Notes
- Simulated dataset including: Region, Product Category, Sub-Category, Revenue, Profit, Orders, Customer IDs  
- Data was cleaned, validated, and prepared for interactive analysis  

---

## Conclusion
This dashboard provides a **clear view of sales and profitability patterns**, allowing stakeholders to track performance, identify trends, and make informed business decisions. The combination of KPIs, visuals, and drillthroughs provides actionable insights without adding unnecessary complexity.
