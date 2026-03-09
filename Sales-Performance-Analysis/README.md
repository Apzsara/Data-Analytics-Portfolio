# Sales Performance & Profitability Analysis (Power BI)

## Overview
This Power BI dashboard provides a clean and interactive view of sales performance, analyzing revenue, profit, orders, regions, and time.
**Purpose:** To help business teams and stakeholders monitor trends, assess profitability, and make data-driven decisions with optimized visuals and DAX measures.

## Dashboard Contents

### KPI Cards
* **Total Revenue:** $2.3M
* **Total Profit:** $286.4K
* **Total Orders:** 5,009
* **Profit Margin:** 12.47%
* **YoY Change:** 46.9% (2014–2017)

### Visuals
* **Cumulative Revenue Trend** with YoY % tooltip
* **Region-wise Sales by Category:** Stacked bar chart
* **Sub-Category Sales & Profit:** Scrollable horizontal bars
* **Slicers:** Year, Region, Product Category
* **Drillthrough Page – Order Details:**
    * Region-wise Revenue Trend (Area Chart with YoY tooltip)
    * Sales by State Map (gradient conditional formatting)
    * Customer-level Matrix showing Order Count, Revenue, and Profit (conditional formatting: Green = positive profit, Red = negative profit)

### Filters & Interactivity
* Page-level & visual-level filtering
* Drillthrough filters for deeper analysis
* Scrollable visual layout for faster insights

## Tools & Features Used
* **Power BI Desktop:** KPI Cards, Interactive Charts, Conditional Formatting, Drillthrough pages, Scrollable visuals
* **DAX Measures:** `CALCULATE`, `FILTER`, `ALL`, `REMOVEFILTERS`, `SAMEPERIODLASTYEAR`, `SUMX`, `DIVIDE`, `TOTALYTD` (used for revenue trends, profit, and YoY calculations)
* Tooltip customizations and visual-level filtering

## Key Insights & Impact
* **Revenue Growth:** 46.9% YoY increase (2014–2017), showing strong sales expansion
* **Profitability:** 12.47% overall profit margin across 4 regions, 3 product categories, and 17 subcategories
* **Regional & Product Insights:** Allows stakeholders to identify top-performing regions and categories
* **Customer-Level Analysis:** Drillthrough matrix highlights high-value customers and order patterns
* Enables quick business decision-making through interactive slicers, scrollable visuals, and conditional formatting

## Files Included
* `AdvancedSalesDashboard.pbix` – Power BI file
* `screenshots/` – Preview images of main and drillthrough pages
* `README.md` – This file

## Dataset Note
The dataset is a simulated sales dataset with fields such as Region, Product Category, Sub-Category, Revenue, Profit, Orders, and Customer IDs.
