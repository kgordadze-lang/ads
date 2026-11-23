SELECT SCHEMA_ID('course_lab') AS schema_id;
GO

-- Schema course_lab was created during setup.

-- Exercise 1: Create a permanent table

CREATE TABLE course_lab.clients (
    id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

-- Verify the table

SELECT
    id,
    first_name,
    last_name
FROM course_lab.clients;

-- Exercise 2: Create a temporary table

DROP TABLE IF EXISTS #tmp_table;

CREATE TABLE #tmp_table (
    id INT,
    title VARCHAR(100),
    published_date INT
);

-- Verify the temporary table exists
SELECT name
FROM tempdb.sys.tables
WHERE object_id = OBJECT_ID('tempdb..#tmp_table');

-- Exercise 3: Create a table from a query

SELECT
    film_id,
    title,
    length,
    release_year,
    rental_rate
INTO course_lab.long_film
FROM dbo.film
WHERE length > 120;

-- Count the films in the new table

SELECT COUNT(*) AS long_film_count
FROM course_lab.long_film;

-- Exercise 4: Temporary table from a query

DROP TABLE IF EXISTS #tmp_actor_nick;

SELECT
    actor_id,
    first_name,
    last_name
INTO #tmp_actor_nick
FROM dbo.actor
WHERE first_name = 'NICK';

-- Check the contents of our temporary table

SELECT
    actor_id,
    first_name,
    last_name
FROM #tmp_actor_nick;

SELECT @@SPID AS session_id;