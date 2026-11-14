
-- Module 04 — JOINs


-- Exercise 1: Payments and rentals
-- Connect each payment to its rental information.

SELECT
    p.payment_id,
    p.rental_id,
    p.amount,
    r.rental_date,
    p.payment_date
FROM dbo.payment AS p
INNER JOIN dbo.rental AS r
    ON p.rental_id = r.rental_id;


-- Exercise 2: Every category, including empty categories
-- Include categories with zero films.

SELECT
    c.category_id,
    c.name AS category_name,
    COUNT(fc.film_id) AS film_count
FROM dbo.category AS c
LEFT JOIN dbo.film_category AS fc
    ON c.category_id = fc.category_id
GROUP BY
    c.category_id,
    c.name
ORDER BY c.name;


-- Exercise 3: Customers and their latest rental
-- Include customers who have never rented a film.

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    MAX(r.rental_date) AS latest_rental_date
FROM dbo.customer AS c
LEFT JOIN dbo.rental AS r
    ON c.customer_id = r.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY c.customer_id;


-- Exercise 4: Controlled FULL OUTER JOIN
-- Include matched rows and unmatched rows from both tables.
-- Requires sql/01_create_course_lab.sql to be run first.

SELECT
    l.left_id,
    l.label AS left_label,
    r.right_id,
    r.left_id AS right_left_id,
    r.label AS right_label
FROM course_lab.join_left AS l
FULL OUTER JOIN course_lab.join_right AS r
    ON l.left_id = r.left_id
ORDER BY
    COALESCE(l.left_id, r.left_id),
    r.right_id;


-- Exercise 5: Controlled RIGHT JOIN
-- Include all rows from join_right, even without a match.

SELECT
    l.left_id,
    l.label AS left_label,
    r.right_id,
    r.left_id AS right_left_id,
    r.label AS right_label
FROM course_lab.join_left AS l
RIGHT JOIN course_lab.join_right AS r
    ON l.left_id = r.left_id
ORDER BY r.right_id;


-- Exercise 6: Film, category, and actors
-- Return each film with its category and comma-separated actors.

SELECT
    f.film_id,
    f.title,
    c.name AS category_name,
    STRING_AGG(
        CASE
            WHEN a.actor_id IS NOT NULL
            THEN CONVERT(NVARCHAR(MAX),
                 CONCAT(a.first_name, N' ', a.last_name))
        END,
        N', '
    ) WITHIN GROUP (
        ORDER BY a.last_name, a.first_name, a.actor_id
    ) AS actor_list
FROM dbo.film AS f
LEFT JOIN dbo.film_category AS fc
    ON f.film_id = fc.film_id
LEFT JOIN dbo.category AS c
    ON fc.category_id = c.category_id
LEFT JOIN dbo.film_actor AS fa
    ON f.film_id = fa.film_id
LEFT JOIN dbo.actor AS a
    ON fa.actor_id = a.actor_id
GROUP BY
    f.film_id,
    f.title,
    c.category_id,
    c.name
ORDER BY f.title;