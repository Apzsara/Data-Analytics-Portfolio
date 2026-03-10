CREATE OR REPLACE VIEW products_dedup AS
SELECT
    stockcode,
    MIN(description) AS description
FROM products
GROUP BY stockcode;

CREATE OR REPLACE VIEW customers_dedup AS
SELECT
    customer_id,
    MIN(country) AS country
FROM customers
GROUP BY customer_id;

CREATE OR REPLACE VIEW valid_sales AS
SELECT
    oi.invoice,
    oi.stockcode,
    p.description,
    oi.quantity,
    oi.price,
    oi.total_price,
    oi.is_cancelled,
    oi.is_reconstructed,
    o.customer_id,
    c.country,
    o.invoicedate,
    o.total_amount,
    o.total_items
FROM order_items oi
INNER JOIN orders o
    ON oi.invoice = o.invoice
LEFT JOIN customers_dedup c
    ON o.customer_id = c.customer_id
LEFT JOIN products_dedup p
    ON oi.stockcode = p.stockcode
WHERE NOT (oi.is_cancelled = 1 AND oi.quantity > 0 AND oi.total_price > 0);

