CREATE OR REPLACE VIEW rfm_scored AS
WITH customer_metrics AS (
    SELECT
        customer_id,
        DATEDIFF((SELECT MAX(invoicedate) FROM fact_sales_net), MAX(invoicedate)) AS recency,
        COUNT(DISTINCT invoice) AS frequency,
        SUM(net_revenue) AS monetary
    FROM fact_sales_net
   WHERE customer_id IS NOT NULL
      AND customer_id != ''
      AND customer_id != 0
    GROUP BY customer_id
),
rfm_ranked AS (
    SELECT *,
        PERCENT_RANK() OVER (ORDER BY recency DESC) AS r_rank,
        PERCENT_RANK() OVER (ORDER BY frequency ASC) AS f_rank,
        PERCENT_RANK() OVER (ORDER BY monetary ASC) AS m_rank
    FROM customer_metrics
)
SELECT *,
       CASE WHEN r_rank >= 0.8 THEN 5
            WHEN r_rank >= 0.6 THEN 4
            WHEN r_rank >= 0.4 THEN 3
            WHEN r_rank >= 0.2 THEN 2
            ELSE 1 END AS r_score,

       CASE WHEN f_rank >= 0.8 THEN 5
            WHEN f_rank >= 0.6 THEN 4
            WHEN f_rank >= 0.4 THEN 3
            WHEN f_rank >= 0.2 THEN 2
            ELSE 1 END AS f_score,

       CASE WHEN m_rank >= 0.8 THEN 5
            WHEN m_rank >= 0.6 THEN 4
            WHEN m_rank >= 0.4 THEN 3
            WHEN m_rank >= 0.2 THEN 2
            ELSE 1 END AS m_score
FROM rfm_ranked;

SELECT *,
       (r_score + f_score + m_score) AS total_rfm
FROM rfm_scored
ORDER BY total_rfm DESC, monetary DESC
LIMIT 10;

CREATE OR REPLACE VIEW rfm_segmented AS
SELECT *,
       CASE
           WHEN r_score >= 4 AND f_score >= 4 AND m_score >= 4 THEN 'Champions'
           WHEN r_score >= 3 AND f_score >= 4 AND m_score BETWEEN 2 AND 4 THEN 'Loyal'
           WHEN m_score >= 4 AND (f_score BETWEEN 2 AND 3 OR r_score BETWEEN 2 AND 3) THEN 'Big Spenders'
           WHEN r_score <= 2 AND (f_score >= 3 OR m_score >= 3) THEN 'At-Risk'
           WHEN r_score <= 2 AND f_score <= 2 AND m_score <= 2 THEN 'Hibernating'
           WHEN r_score >= 4 AND f_score <= 2 AND m_score <= 2 THEN 'New / Promising'
           ELSE 'Regular'
       END AS segment
FROM rfm_scored;

SELECT segment, SUM(monetary) AS total_revenue FROM rfm_segmented GROUP BY segment ORDER BY total_revenue DESC;
SELECT * FROM rfm_segmented WHERE segment IN ('Big Spenders','At-Risk') ORDER BY monetary DESC;
SELECT segment, AVG(frequency) AS avg_frequency, COUNT(*) AS cust_count FROM rfm_segmented GROUP BY segment ORDER BY avg_frequency DESC;
SELECT segment, SUM(monetary) AS revenue, SUM(monetary)/ (SELECT SUM(monetary) FROM rfm_segmented) AS pct_revenue FROM rfm_segmented GROUP BY segment ORDER BY revenue DESC;
SELECT * FROM rfm_segmented WHERE segment IN ('At-Risk','New / Promising') ORDER BY recency ASC, monetary DESC;
SELECT customer_id,monetary,recency,m_score,r_score FROM rfm_segmented WHERE segment='At-Risk' ORDER BY monetary DESC limit 5;


-- Customers generating top 40% of revenue

WITH ranked AS (
    SELECT 
        customer_id,
        monetary,
        SUM(monetary) OVER (ORDER BY monetary DESC) AS cumulative_revenue,
        SUM(monetary) OVER () AS total_revenue,
        COUNT(*) OVER () AS total_customers,
        ROW_NUMBER() OVER (ORDER BY monetary DESC) AS rn
    FROM rfm_segmented
)
SELECT 
    COUNT(*) AS customers_needed,
    ROUND(COUNT(*) / MAX(total_customers) * 100, 2) AS pct_of_customers
FROM ranked
WHERE cumulative_revenue <= total_revenue * 0.40;


-- Customers generating top 80% of revenue

WITH ranked AS (
    SELECT 
        customer_id,
        monetary,
        SUM(monetary) OVER (ORDER BY monetary DESC) AS cumulative_revenue,
        SUM(monetary) OVER () AS total_revenue,
        COUNT(*) OVER () AS total_customers
    FROM rfm_segmented
)
SELECT 
    COUNT(*) AS customers_needed,
    ROUND(COUNT(*) / MAX(total_customers) * 100, 2) AS pct_of_customers
FROM ranked
WHERE cumulative_revenue <= total_revenue * 0.80;


-- Distribution of top 40% revenue across RFM segments

WITH ranked AS (
    SELECT 
        customer_id,
        segment,
        monetary,
        SUM(monetary) OVER (ORDER BY monetary DESC) AS cumulative_revenue,
        SUM(monetary) OVER () AS total_revenue
    FROM rfm_segmented
)
SELECT 
    segment,
    COUNT(*) AS customer_count,
    ROUND(COUNT(*) / SUM(COUNT(*)) OVER () * 100, 2) AS pct_within_top40
FROM ranked
WHERE cumulative_revenue <= total_revenue * 0.40
GROUP BY segment
ORDER BY customer_count DESC;


-- Revenue at risk from 'At-Risk' customers

WITH ranked AS (
    SELECT 
        customer_id,
        segment,
        monetary,
        SUM(monetary) OVER (ORDER BY monetary DESC) AS cumulative_revenue,
        SUM(monetary) OVER () AS total_revenue
    FROM rfm_segmented
)
SELECT 
    SUM(monetary) AS revenue_at_risk,
    ROUND(
        SUM(monetary) / MAX(total_revenue) * 100,
        2
    ) AS pct_of_total_revenue
FROM ranked
WHERE cumulative_revenue <= total_revenue * 0.40
AND segment = 'At-Risk';


-- Revenue at risk from 'At-Risk' + 'Hibernating' customers

SELECT 
    SUM(monetary) AS risky_revenue,
    ROUND(
        SUM(monetary) / (SELECT SUM(monetary) FROM rfm_segmented) * 100,
        2
    ) AS pct_of_total_revenue
FROM rfm_segmented
WHERE segment IN ('At-Risk', 'Hibernating');


-- Revenue contribution from top 5 customers

SELECT 
    SUM(monetary) AS top5_revenue,
    ROUND(
        SUM(monetary) / (SELECT SUM(monetary) FROM rfm_segmented) * 100,
        2
    ) AS pct_of_total_revenue
FROM (
    SELECT monetary
    FROM rfm_segmented
    ORDER BY monetary DESC
    LIMIT 5
) t;


-- Revenue contribution from 'Champions' segment

SELECT 
    SUM(monetary) AS champion_revenue,
    ROUND(
        SUM(monetary) / (SELECT SUM(monetary) FROM rfm_segmented) * 100,
        2
    ) AS pct_of_total_revenue
FROM rfm_segmented
WHERE segment = 'Champions';


-- Estimated revenue loss if 10% of Champions churn (percentage)

SELECT 
    ROUND(
        (SUM(monetary) * 0.10) / 
        (SELECT SUM(monetary) FROM rfm_segmented) * 100,
        2
    ) AS revenue_loss_if_10pct_champions_churn
FROM rfm_segmented
WHERE segment = 'Champions';


-- Estimated revenue loss if 10% of Champions churn (absolute and percentage)

SELECT 
    ROUND(SUM(monetary) * 0.10, 2) AS absolute_revenue_loss,
    ROUND(
        (SUM(monetary) * 0.10) / (SELECT SUM(monetary) FROM rfm_segmented) * 100, 
        2
    ) AS pct_impact_on_total_revenue
FROM rfm_segmented
WHERE segment = 'Champions';
