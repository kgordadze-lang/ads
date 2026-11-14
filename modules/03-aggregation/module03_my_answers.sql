USE sakila;
GO

-- Exercise 1: Rental count per customer

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(r.rental_id) AS rental_count
FROM dbo.customer AS c
LEFT JOIN dbo.rental AS r
    ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY rental_count DESC, c.customer_id;

-- Exercise 2: Deterministic sorting

SELECT
    rental_id,
    rental_date,
    return_date,
    customer_id,
    inventory_id
FROM dbo.rental
ORDER BY
    CASE WHEN return_date IS NULL THEN 1 ELSE 0 END,
    return_date ASC,
    rental_date DESC,
    rental_id ASC;

    -- Exercise 3: Payment activity

SELECT
    customer_id,
    COUNT(payment_id) AS payment_count,
    SUM(amount) AS total_paid
FROM dbo.payment
GROUP BY customer_id
HAVING COUNT(payment_id) >= 30
    AND SUM(amount) > 200
ORDER BY total_paid DESC;

-- Exercise 4: Average film length by category

SELECT
    c.name AS category_name,
    AVG(CAST(f.length AS DECIMAL(10,2))) AS average_length
FROM dbo.category AS c
JOIN dbo.film_category AS fc
    ON c.category_id = fc.category_id
JOIN dbo.film AS f
    ON fc.film_id = f.film_id
GROUP BY c.category_id, c.name
ORDER BY c.name;

-- Exercise 5: Actors with large filmographies

SELECT
    a.actor_id,
    a.first_name,
    a.last_name,
    COUNT(fa.film_id) AS film_count
FROM dbo.actor AS a
JOIN dbo.film_actor AS fa
    ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
HAVING COUNT(fa.film_id) >= 35
ORDER BY film_count DESC, a.actor_id;