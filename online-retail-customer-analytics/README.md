# Online Retail — Customer & Revenue Analysis

UCI Online Retail II dataset · UK gift retailer · Dec 2009 – Dec 2011  
**Stack:** Python (pandas) · DuckDB SQL · matplotlib / seaborn

---

## What this covers

Four linked analyses built on a single cleaned transaction table:

| Module | What it answers |
|---|---|
| **Revenue Trends** | Where did growth come from — volume, frequency, or basket size? |
| **RFM Segmentation** | Which customers are worth protecting vs. writing off? |
| **Cohort Retention** | Are newer customers sticking at the same rate as early ones? |
| **Simple CLV** | Which segments are worth the most based on past behaviour? |

---

## Data decisions worth knowing

Started with 1,067,371 rows. Removed in order:

- **Duplicates** — exact row-level duplicates removed first, leaving 1,033,036 rows
- **235,151 null Customer IDs (~22.8%)** — no ID means no behaviour tracking; dropped entirely
- **Null descriptions** — rows with no product description removed
- **Service/admin codes** — `POST`, `D`, `M`, `ADJUST`, `DOT`, `CRUK` are fees and internal codes, not sales
- **Cancellations (~2.2%)** — C-prefix invoices; invoice mismatch made matched-pair reconstruction unreliable, so dropped rather than guess
- **63 zero-price rows** — no transaction value, no useful signal
- **Final clean dataset: 776,888 rows**
- **Dec 2011 excluded from MoM/YoY** — dataset ends Dec 9th; the partial month creates a -54% drop that isn't real
- **YoY comparisons exclude December both years** — ensures like-for-like months

---

## Key findings and where to act

### Revenue: volume is the lever, not price

Median Order Value (MOV) stays flat around £300 year-round while revenue swings from £443k to £1.16M. YoY revenue (Jan–Nov like-for-like): £7.66M in 2010 vs £7.67M in 2011 (+0.08%) — virtually flat, with MOV also unchanged (£303.64 → £303.01).

→ **Pricing changes alone won't move the needle.** Frequency and reactivation programs are the actual growth lever here.

### RFM: 23% of customers drive 80% of revenue

Champions and Loyals together — 46.66% of the base — generate 84.91% of revenue, over 5.6x the value of all other segments combined.

![RFM Segment Concentration](screenshots/rfm_segment_concentration.png)

→ **Size the risk before acting on growth.** Losing 10% of Champions represents a £1,172,540 revenue hit — larger than the entire Potential and Hibernating segment revenue combined. Retention investment for Champions has a clear ceiling to work from.

→ **Upgrade Loyals before chasing new customers.** If 20% of Loyals reach Champion-level behaviour, that's £1,914,341 in incremental revenue from the existing base with zero acquisition cost.

→ **55 At-Risk high-spenders flagged at median £4,417 each — already lapsing, individual account size justifies direct outreach over a bulk campaign.**

### Cohort: Dec 2010 is the outlier to learn from

Dec 2010 had the worst 12-month retention of any cohort at 2.63%. Dec 2009 (the earliest cohort, 952 customers) holds the strongest retention at every time period measured.

![Customer Retention Heatmap](screenshots/customer_retention_heatmap.png)

→ **Holiday cohorts need their own acquisition ROI calc.** Dec 2010 had the worst 12-month retention of any cohort (2.63%) — if acquisition cost was elevated during peak season, that cohort likely destroyed value. Worth quantifying before repeating the same channel mix.

### CLV: At-Risk customers carry higher order value than Loyals

At-Risk customers have a median order value of £300.35 vs £258.68 for Loyals — meaning each At-Risk transaction is worth more than a Loyal one. The business is losing its higher-value buyers while retaining its lower-value ones.

Two deliberate modelling choices keep the estimates grounded: purchase rate uses the full observation window (first purchase to dataset end) rather than each customer's own active span — this prevents single-purchase customers from inflating their rate to `1.0/month`. Order value uses the median per-invoice spend rather than the mean, so one large bulk order doesn't distort a customer's typical behaviour.

→ **At-Risk is the higher-ROI retention target.** Each recovered At-Risk customer protects more revenue per transaction than a Loyal. Their segment size understates their impact.

> **CLV model scope:** this is a deterministic formula, not a probabilistic model (e.g. BG/NBD). It estimates value from observed behaviour and is best used for segment-level prioritisation, not individual-level forecasting.

---

## Structure

```
notebook/
└── Online_Retail_Customer___Revenue_Analysis.ipynb
    ├── 1. Data loading & cleaning
    ├── 2. Revenue analysis (monthly trends, MoM, YoY, geography)
    ├── 3. RFM segmentation + segment revenue concentration
    ├── 4. Cohort retention heatmap + cohort-to-segment mapping
    └── 5. Simple CLV by segment
```

---

## Data source

[UCI Online Retail II Dataset](https://archive.ics.uci.edu/dataset/502/online+retail+ii) — publicly available, no PII.
