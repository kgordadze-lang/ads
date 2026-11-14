
-- Module 03b — Grouping Functions


-- Exercise 1: Customer payment report
-- Create a reusable view with payment statistics for every customer.

-- Create the course_lab schema if it does not exist.
IF SCHEMA_ID('course_lab') IS NULL
    EXEC('CREATE SCHEMA course_lab');
GO

CREATE OR ALTER VIEW course_lab.v_customer_payment_report AS
SELECT
    c.first_name,
    c.last_name,
    c.email,
    COUNT(p.payment_id) AS payment_count,
    COALESCE(SUM(p.amount), 0) AS total_amount,
    AVG(CAST(p.amount AS DECIMAL(12,2))) AS average_payment,
    MAX(p.payment_date) AS last_payment_date
FROM dbo.customer AS c
LEFT JOIN dbo.payment AS p
    ON c.customer_id = p.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email;
GO

-- Verify the saved view.
SELECT TOP (10) *
FROM course_lab.v_customer_payment_report
ORDER BY total_amount DESC;
GO


-- Exercise 2: Actors per film
-- Include films without actors and save results in a temporary table.

DROP TABLE IF EXISTS #tmp_film_actors;

SELECT
    f.film_id,
    f.title,
    COUNT(fa.actor_id) AS actor_count
INTO #tmp_film_actors
FROM dbo.film AS f
LEFT JOIN dbo.film_actor AS fa
    ON f.film_id = fa.film_id
GROUP BY
    f.film_id,
    f.title;

-- Verify the temporary table.
SELECT *
FROM #tmp_film_actors
ORDER BY actor_count DESC, film_id;


-- Exercise 3: Rentals per film
-- Count rentals across all inventory copies of each film.

DROP TABLE IF EXISTS #tmp_film_rentals;

SELECT
    f.film_id,
    f.title,
    COUNT(r.rental_id) AS rental_count
INTO #tmp_film_rentals
FROM dbo.film AS f
LEFT JOIN dbo.inventory AS i
    ON f.film_id = i.film_id
LEFT JOIN dbo.rental AS r
    ON i.inventory_id = r.inventory_id
GROUP BY
    f.film_id,
    f.title;

-- Verify the temporary table.
SELECT *
FROM #tmp_film_rentals
ORDER BY rental_count DESC, film_id;


-- Exercise 4: Average film length by category
-- Use decimal values to prevent integer truncation.

SELECT
    c.name AS category_name,
    AVG(CAST(f.length AS DECIMAL(10,2))) AS average_length
FROM dbo.category AS c
LEFT JOIN dbo.film_category AS fc
    ON c.category_id = fc.category_id
LEFT JOIN dbo.film AS f
    ON fc.film_id = f.film_id
GROUP BY
    c.category_id,
    c.name
ORDER BY average_length DESC;