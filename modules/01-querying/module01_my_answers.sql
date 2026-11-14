USE sakila;
GO

SELECT DISTINCT name
FROM dbo.category
ORDER BY name;

SELECT
    title,
    release_year,
    length,
    rental_duration,
    rental_rate,
    rating
FROM dbo.film
WHERE release_year > 2005
ORDER BY release_year, title;


SELECT
    payment_id,
    customer_id,
    staff_id,
    rental_id,
    amount,
    payment_date,
    last_update
FROM dbo.payment;

