CREATE OR REPLACE VIEW cohort_monthly AS
SELECT
    customer_id,
    DATE_FORMAT(MIN(invoicedate), '%Y-%m-01') AS cohort_month
FROM fact_sales_net
WHERE customer_id IS NOT NULL AND customer_id <> ''
GROUP BY customer_id;

SELECT
    c.cohort_month,
    DATE_FORMAT(f.invoicedate, '%Y-%m-01') AS month,
    SUM(f.net_revenue) AS revenue
FROM cohort_monthly c
JOIN fact_sales_net f
  ON c.customer_id = f.customer_id
WHERE f.customer_id IS NOT NULL AND f.customer_id <> ''
GROUP BY c.cohort_month, month
ORDER BY c.cohort_month, month;



-- Customer & Revenue Retention by Cohort

WITH cohort_activity AS (
    SELECT
        c.cohort_month,
        TIMESTAMPDIFF(
            MONTH,
            c.cohort_month,
            DATE_FORMAT(f.invoicedate, '%Y-%m-01')
        ) AS month_offset,
        COUNT(DISTINCT f.customer_id) AS active_customers,
        SUM(f.net_revenue) AS revenue
    FROM cohort_monthly c
    JOIN fact_sales_net f
        ON c.customer_id = f.customer_id
    WHERE f.customer_id IS NOT NULL 
      AND f.customer_id <> ''
    GROUP BY c.cohort_month, month_offset
),

base AS (
    SELECT
        cohort_month,
        active_customers AS cohort_size,
        revenue AS month0_revenue
    FROM cohort_activity
    WHERE month_offset = 0
)

SELECT
    ca.cohort_month,
    ca.month_offset,
    ca.active_customers,
    ROUND(ca.active_customers / b.cohort_size * 100, 2) AS customer_retention_pct,
    ROUND(ca.revenue / b.month0_revenue * 100, 2) AS revenue_retention_pct
FROM cohort_activity ca
JOIN base b
    ON ca.cohort_month = b.cohort_month
ORDER BY ca.cohort_month, ca.month_offset;



-- Champion Conversion per Cohort

WITH cohort_totals AS (
    SELECT 
        cohort_month, 
        COUNT(customer_id) AS total_joined_in_cohort
    FROM cohort_monthly
    GROUP BY cohort_month
),

cohort_champions AS (
    SELECT 
        c.cohort_month,
        COUNT(DISTINCT r.customer_id) AS current_champions_count
    FROM cohort_monthly c
    INNER JOIN rfm_segmented r 
        ON c.customer_id = r.customer_id
    WHERE r.segment = 'Champions'
    GROUP BY c.cohort_month
)

SELECT 
    ct.cohort_month,
    ct.total_joined_in_cohort,
    COALESCE(cc.current_champions_count, 0) AS champions_count,
    ROUND(
        COALESCE(cc.current_champions_count, 0) / ct.total_joined_in_cohort * 100, 
        2
    ) AS champion_conversion_pct
FROM cohort_totals ct
LEFT JOIN cohort_champions cc 
    ON ct.cohort_month = cc.cohort_month
ORDER BY ct.cohort_month;

