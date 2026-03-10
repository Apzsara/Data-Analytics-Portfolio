# Fraud Risk & Transaction Health Dashboard

**Tools:** Python, SQL (MySQL), Power BI  
**Domain:** Financial Transactions & Fraud Analytics  

---

## Overview
This project analyzes **13M financial transactions ($706.87M)** from 2010–2019 to identify fraud patterns, high-risk customer segments, and merchant categories driving fraud losses.

The dashboard defaults to the latest available year (**2019**) to reflect real-world reporting practices. All KPIs and insights referenced below are based on the 2019 view, while the full dataset is retained for historical analysis.

The focus is on **loss-based fraud prioritization**, rather than relying solely on fraud rate.

---

## Business Objectives
- Identify where fraud is concentrated across customers, merchants, and transaction types  
- Highlight high-risk customer segments for proactive monitoring  
- Support data-driven allocation of fraud prevention resources  

---

## Dashboard Highlights (2019 View)

**Key KPIs**  
KPI cards dynamically respond to Card Type and Transaction Type selections.

| KPI | Value | Notes |
|-----|-------|-------|
| Total Transaction Value | $61.16M | Total transactions in 2019 |
| Fraud Rate | 0.12% (↑ 0.01% YoY) | Percentage of transactions flagged as fraud |
| Fraud Loss | $128K (↑ 10% YoY) | Monetary impact of fraudulent transactions |
| High-Risk Customers | 442 (~37% of 2019 customer base) | Identified via Debt-to-Income and credit score |
| Avg Fraud Transaction | $94 (1.8× normal transaction) | Indicates higher exposure per fraud case |

---

## Core Visuals & Insights

### Fraud Rate by Transaction Amount
- Transactions **$300+** show the highest fraud rate (0.60%)  
- This segment drives **42% of total fraud loss ($54K)**  
- *Insight:* High-value transactions carry disproportionate financial risk; monitoring here yields the biggest ROI.

### Fraud Rate vs Fraud Loss by Card Type
- **Credit cards** have the highest fraud rate (0.16%)  
- **Debit cards** generate higher total losses ($66K), despite a lower fraud rate  
- *Insight:* Highest frequency does not equal highest financial impact. Prevention strategy should consider total loss.

### Customer Risk Matrix
- Scatter plot of customers by **Debt-to-Income ratio vs Credit Score**  
- Highlights **442 high-risk customers** clustered in the critical risk zone  
- *Insight:* Focused monitoring on these customers enables proactive fraud mitigation.

### Top Fraud Loss by Merchant Category
- **Department Stores** lead with $26K (20% of total fraud loss)  
- Top three merchant categories contribute **38% of total fraud losses**  
- *Insight:* Losses are highly concentrated; targeted merchant monitoring can reduce exposure significantly.

---

## Recommended Actions
- **Prioritize monitoring** for Department Stores ($26K loss, 20% of total)  
- **Flag $300+ transactions** (42% of fraud loss, 0.60% fraud rate)  
- **Proactively review** 442 high-risk customers (high DTI + low credit score)  
- **Reallocate fraud prevention focus** from Credit to Debit cards based on loss volume  

*By targeting these high-risk segments, the analysis supports strategic, high-ROI fraud prevention.*

---

## Technical Workflow

### Python (Pandas)
- Data cleaning and validation across core datasets  
- Merged fraud labels and merchant category mappings  
- Feature engineering for:
  - Debt-to-Income ratio  
  - Transaction type classification (debit, refund)  
  - Transaction date attributes (year, month)  

### SQL (MySQL)
- Joined customer, card, and transaction tables into a single enriched dataset (13M+ rows)  
- Resolved merchant location data quality issues  
- Created aggregated views for Power BI performance optimization  

### Power BI & DAX
- Dynamic KPIs using `SWITCH` for amount bucketing and metric logic  
- Year-over-Year analysis using `SAMEPERIODLASTYEAR`  
- Risk segmentation using `CALCULATE` and `FILTER`  
- Percentage calculations using `DIVIDE`  

---

## Files Included
- `screenshots/` — Dashboard preview images  
- PBIX File: [Download here](https://drive.google.com/file/d/1x7qqMFZzxFh84mV8_W4GOmnB9DRVPFxs/view) *(hosted externally due to file size constraints)*  

---

## Dataset Notes
- `user.csv` — Customer attributes  
- `card.csv` — Card-level details  
- `transaction.csv` — Transaction-level data  
- `fraud_labels.json` — Fraud indicators  
- `mcc.json` — Merchant category mappings  

*All datasets were cleaned, validated, and enriched prior to analysis.*

---

## Conclusion
By focusing on **high-value transactions, high-risk customers, and merchant hotspots**, this analysis enables **targeted fraud prevention**, maximizing impact while minimizing operational effort. The dashboard serves as a **decision-support tool** for fraud monitoring and resource allocation.
