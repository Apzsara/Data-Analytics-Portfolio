CREATE OR REPLACE VIEW fact_sales_net AS
SELECT
    invoice,
    stockcode,
    MIN(invoicedate) AS invoicedate,
    customer_id,
    MIN(country) AS country,       
    SUM(quantity) AS net_quantity,
    SUM(total_price) AS net_revenue
FROM (
    SELECT 
        invoice,
        stockcode,
        invoicedate,
        customer_id,
        country,
        quantity,
        total_price
    FROM valid_sales
    WHERE quantity < 0 OR is_reconstructed = 1

    UNION ALL

    SELECT 
        invoice,
        stockcode,
        invoicedate,
        customer_id,
        country,
        MAX(quantity) AS quantity,
        MAX(total_price) AS total_price
    FROM valid_sales
    WHERE quantity > 0 AND is_cancelled = 0 AND is_reconstructed = 0
    GROUP BY invoice, stockcode, customer_id, country
) cleaned
GROUP BY invoice, stockcode, customer_id;


-- Total revenue by year

select year(invoicedate) as year,sum(net_revenue) from fact_sales_net group by year(invoicedate) order by year;


-- Top 5 countries by total revenue

SELECT country, SUM(net_revenue) AS Revenue
FROM fact_sales_net
GROUP BY country
ORDER BY Revenue DESC
LIMIT 5;


-- Top 5 countries by revenue per year

SELECT year, country, total_revenue
FROM (
    SELECT YEAR(invoicedate) AS year,
           country,
           SUM(net_revenue) AS total_revenue,
           ROW_NUMBER() OVER (PARTITION BY YEAR(invoicedate) ORDER BY SUM(net_revenue) DESC) AS rn
    FROM fact_sales_net
    GROUP BY YEAR(invoicedate), country
) t
WHERE rn <= 5
ORDER BY year, total_revenue DESC;