# Fraud Risk & Transaction Health Analysis

## Overview
This project analyzes **13M financial transactions ($706.87M)** from 2010–2019 to identify fraud patterns, high-risk customer segments, and merchant categories driving fraud losses.

* **Reporting Period:** The dashboard defaults to the latest available year (2019) to reflect real-world reporting practices.
* **Strategy:** The focus is on **loss-based fraud prioritization**, rather than relying on fraud frequency alone.

## Business Objectives
* Identify where fraud is concentrated across customers, merchants, and transaction types.
* Highlight high-risk customer segments for proactive monitoring.
* Support data-driven allocation of fraud prevention resources.

## Dashboard Highlights (2019 View)
* **Total Transaction Value:** $61.16M
* **Fraud Rate:** 0.12% (↑ 0.01% YoY)
* **Fraud Loss:** $128K (↑ 10% YoY)
* **High-Risk Customers:** 442 (~37% of customer base)
* **Avg Fraud Transaction:** $94 (1.8x normal transaction)

## Core Visuals & Findings
* **Fraud Rate by Amount:** Transactions $300+ show a 0.60% fraud rate, driving 42% ($54K) of total fraud loss.
* **Card Type Analysis:** Credit cards have the highest rate (0.16%), but Debit cards generate higher total losses ($66K).
* **Customer Risk Matrix:** Scatter plot of Debt-to-Income (DTI) vs. Credit Score identifying 442 high-risk clusters.
* **Merchant Impact:** Department Stores lead losses with $26K (20%). The top three categories drive 38% of total loss.

## Technical Workflow

### Python (Pandas)
* Data validation and merging JSON fraud labels with CSV datasets.
* **Feature Engineering:** Calculated DTI ratios and standardized transaction classifications.

### SQL (MySQL)
* Orchestrated joins across 13M+ rows.
* Created aggregated views to optimize Power BI dashboard performance.

### Power BI (DAX)
* `SWITCH`: Dynamic amount bucketing.
* `SAMEPERIODLASTYEAR`: YoY trend analysis.
* `CALCULATE` & `FILTER`: Risk segmentation logic.
* `DIVIDE`: Safe percentage calculations.

## Recommended Actions
1. **Prioritize Monitoring:** Focus on Department Stores ($26K loss).
2. **Flag High-Value Risk:** Immediate review for all $300+ transactions.
3. **Risk Mitigation:** Proactively review the 442 customers in the high DTI / low credit score quadrant.
4. **Strategic Shift:** Reallocate prevention focus toward Debit cards based on total loss volume.

## Files Included
* `screenshots/` – Dashboard preview images
* `README.md` – This file
* **[Download PBIX File](https://drive.google.com/file/d/1x7qqMFZzxFh84mV8_W4GOmnB9DRVPFxs/view?usp=sharing)** – Hosted on Google Drive due to GitHub file size limits.

## Dataset Notes
* `user.csv`: Customer attributes
* `card.csv`: Card-level details
* `transaction.csv`: 13M transaction rows
* `fraud_labels.json` & `mcc.json`: Indicators and mappings
