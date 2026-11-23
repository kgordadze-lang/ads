USE sakila;
GO

-- Exercise 1: Create a view of customers

CREATE OR ALTER VIEW course_lab.v_clients AS
SELECT
    customer_id,
    first_name,
    last_name
FROM dbo.customer;
GO

-- Display the contents of the view

SELECT
    customer_id,
    first_name,
    last_name
FROM course_lab.v_clients;

-- Exercise 2: Customer rentals

GO

CREATE OR ALTER VIEW course_lab.v_client_rentals AS
SELECT
    r.rental_id,
    r.rental_date,
    r.return_date,
    c.first_name,
    c.last_name
FROM dbo.rental AS r
JOIN dbo.customer AS c
    ON r.customer_id = c.customer_id;
GO

-- Display the view

SELECT *
FROM course_lab.v_client_rentals;

-- Exercise 3: Films and categories

GO

CREATE OR ALTER VIEW course_lab.v_films_categories AS
SELECT
    f.film_id,
    f.title,
    c.name AS category_name,
    f.release_year
FROM dbo.film AS f
JOIN dbo.film_category AS fc
    ON f.film_id = fc.film_id
JOIN dbo.category AS c
    ON fc.category_id = c.category_id;
GO

-- Display the view

SELECT *
FROM course_lab.v_films_categories;

-- Exercise 4: Add email to the customer view

GO

ALTER VIEW course_lab.v_clients AS
SELECT
    customer_id,
    first_name,
    last_name,
    email
FROM dbo.customer;
GO

-- Check the updated view

SELECT *
FROM course_lab.v_clients;

-- Exercise 4: Drop the customer view

DROP VIEW IF EXISTS course_lab.v_clients;
GO