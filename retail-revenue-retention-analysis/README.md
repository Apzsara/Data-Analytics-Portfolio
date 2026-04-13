# Online Retail — Customer & Revenue Analysis

*UCI Online Retail II dataset. UK gift retailer, Dec 2009–Dec 2011. Cleaned in Python, analysed in DuckDB SQL.*

---

## What This Project Does

Analyses transactional retail data to understand who drives revenue, which customers are at risk, and how retention evolves over time. The focus is on connecting data findings to actual business implications rather than just reporting numbers.

**Total revenue:** ~£9.7M (post-cleaning) | **Customers:** ~5,900 | **Transactions:** ~800K rows

---

## Stack

Python (pandas) · DuckDB SQL · Matplotlib · Seaborn

---

## Data Cleaning

Dropped ~23% of rows — 235K had no Customer ID (no way to link behaviour), 4K had no description. Also removed:
- Service/admin codes: `POST`, `D`, `M`, `ADJUST`, `DOT`, `CRUK` — fees and adjustments, not real sales
- Cancellations (~2.2% of rows, invoices starting with `C`) — sequential mismatch made matched-pair reconstruction unreliable
- 63 rows with Price = 0 including test entries
- 518 rows with `Country = Unspecified` — left in place, country isn't used in any analysis

---

## Analysis

### 1. Revenue Trends

Monthly revenue with MoM % change, seasonal breakdown, and per-customer and AOV metrics over time. Dec 2011 excluded from trend analysis — dataset ends 9 Dec, making the MoM drop an artefact, not a real decline.

YoY comparison done on Jan–Nov only (excluding December from both years for a fair like-for-like).

**UK contributes ~87% of total revenue.** EIRE, Netherlands, Germany, and France are the next four but at a fraction of the UK's volume. The business is geographically concentrated — strong in its core market, but structurally exposed if that market softens.

---

### 2. RFM Segmentation

Customers scored on Recency, Frequency, and Monetary value using NTILE(5) percentile bands, then assigned to five segments:

| Segment | Logic |
|---|---|
| Champions | R ≥ 4, F ≥ 4, M ≥ 4 |
| Loyal | F ≥ 3 and M ≥ 3 |
| At Risk | R ≤ 2 and F ≥ 3 — previously active, now lapsed |
| Needs Attention | R ≥ 3 and F ≤ 2 — recent but shallow history |
| Lost | Everyone else |

**Champions are ~22% of customers but generate ~68% of revenue.** The Lost segment is the largest group (~30%) but contributes only ~4% of revenue.

Win-back targets: customers inactive 180+ days with above-average spend. The At Risk segment dominates this list — they have purchase history worth recovering.

Recency distribution shows the customer base is almost evenly split: ~28% bought within the last 30 days, ~27% haven't bought in over a year. Retention is the core structural problem.

---

### 3. Simple CLV

Estimated 12-month CLV per customer: `avg_order_value × monthly_purchase_rate × 12`, joined to RFM segments.

Champions average ~£5,946 CLV. The formula has a known limitation: Lost customers look similar to Champions in purchase rate because the formula uses historical behaviour and doesn't know they've churned. At Risk is the more actionable segment — reachable, with real spend history.

---

### 4. Cohort Retention

Customers grouped by first purchase month and tracked monthly. Retention measured at periods 1, 3, 6, and 12 months.

Retention drops sharply after the first month — typically from 100% to 20–35% by Month 1–2. After that, a stable base forms at around 15–21%. Whoever passes month 7 tends to stick around.

The Dec 2009 cohort consistently outperforms — earliest customers had the strongest long-term retention. Dec 2010 cohort drops to ~2.63% by month 12, likely driven by one-time seasonal gift buyers.

Across all cohorts, average retention stabilises between 15–21% from month 7 onward — the point where transient customers have already churned out.

---

## Key Takeaways

**Revenue is highly concentrated.** Champions and high-value segments carry the business. Losing even a small number of them creates disproportionate impact — retention isn't optional, it's the main revenue protection lever.

**At Risk customers are the priority win-back group.** High historical spend, but inactive 180+ days. They know the brand and have bought before — easier to recover than acquiring new customers to the same value.

**Cohort longevity is achievable, but front-loaded.** Most churn happens in the first two months. Getting customers past that window is the inflection point. Early cohorts prove long-term loyalty is possible — the question is what made them different.

**Geographic concentration is a structural risk.** ~87% from one market is fine when that market is stable. It's worth tracking as a long-term diversification question.

---

## Files

| File | Description |
|---|---|
| `online_retail_II.xlsx` | Raw data (UCI dataset, two sheets) |
| `online_retail.ipynb` | Full analysis — cleaning, SQL, visualisations |
