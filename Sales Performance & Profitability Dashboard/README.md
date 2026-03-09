# Sales Performance & Profitability Dashboard

### Project Objective
To provide an interactive analysis of sales performance across North America, focusing on regional trends, product-level profitability, and year-over-year (YoY) growth.

### Key Technical Features
* **Dynamic KPIs:** Tracks Revenue ($2.3M), Profit ($286.4K), and YoY Change (46.9%) using Time Intelligence DAX.
* **Drill-through Architecture:** Detailed "Order Details" page providing granular customer-level data and geographic distribution.
* **Visual Formatting:** Implemented conditional formatting in matrices (Red/Green profit indicators) and scrollable bar charts for sub-category volume.
* **Interactivity:** Cross-filtering across Region, Year, and Category slicers for multi-dimensional analysis.

### Tech Stack & DAX Implementation
* **Tool:** Power BI Desktop
* **Data Modeling:** Star schema approach with simulated retail data.
* **Key DAX Patterns:**
    * **Time Intelligence:** SAMEPERIODLASTYEAR, TOTALYTD for growth tracking.
    * **Context Control:** CALCULATE, ALL, and REMOVEFILTERS for percentage-of-total calculations.
    * **Measures:** DIVIDE for Profit Margin and SUMX for row-level accuracy.

### Key Insights & Impact
* **Revenue Growth:** 46.9% YoY increase (2014–2017), showing sales expansion over the four-year period.
* **Profitability:** 12.47% overall profit margin across 4 regions, 3 product categories, and 17 subcategories.
* **Regional & Product Insights:** Identifies top-performing regions and categories via interactive slicers.
* **Customer-Level Analysis:** Drillthrough matrix highlights high-value customers and order patterns.
* **Decision Support:** Enables data-driven decisions through interactive visuals and conditional formatting.

### Files Included
* **AdvancedSalesDashboard.pbix** – Power BI file
* **screenshots/** – Preview images of main and drillthrough pages
* **README.md** – This file
