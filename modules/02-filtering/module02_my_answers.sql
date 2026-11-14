USE sakila;
GO

-- Exercise 1: Target categories

SELECT name
FROM dbo.category
WHERE name IN ('Animation', 'Family', 'Children');

-- Exercise 2: Films between 90 and 120 minutes

SELECT
    title,
    length
FROM dbo.film
WHERE length BETWEEN 90 AND 120;

-- Exercise 3: Combine conditions

SELECT
    title,
    release_year,
    rental_duration
FROM dbo.film
WHERE title LIKE 'A%'
    AND release_year BETWEEN 2005 AND 2010
    AND rental_duration IN (4, 5, 7);

    -- Exercise 4: Find open rentals

SELECT
    rental_id,
    rental_date,
    customer_id,
    inventory_id,
    return_date
FROM dbo.rental
WHERE return_date IS NULL;