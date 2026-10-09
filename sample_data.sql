-- Sales report: revenue per genre, ranked, keeping only genres above 100.
WITH genre_revenue AS (
    -- Step 1: one row per genre, with its revenue and number of sales rows
    SELECT
        genre,
        SUM(copies * unit_price) AS revenue,
        COUNT(*)                 AS sales_count
    FROM sales
    GROUP BY genre
),
ranked_genres AS (
    -- Step 2: rank every genre, highest revenue first
    SELECT
        genre,
        revenue,
        sales_count,
        RANK() OVER (ORDER BY revenue DESC) AS revenue_rank
    FROM genre_revenue
)
-- Step 3: keep the genres above 100, best first
SELECT genre, revenue, sales_count, revenue_rank
FROM ranked_genres
WHERE revenue > 100
ORDER BY revenue_rank, genre;