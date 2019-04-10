USE sakila;

-- 1a. Display the first and last names of all actors from the table `actor`.
SELECT first_name, last_name
FROM actor;

-- 1b. Display the first and last name of each actor in a single column.
SELECT concat(first_name, " ", last_name) AS "Actor Name"
FROM actor;

-- 2a. You need to find the ID number, first name, and last name where is first name, "Joe."
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = "Joe";

-- 2b. Find all actors whose last name contain the letters `GEN`:
SELECT * FROM actor
WHERE last_name LIKE "%Gen%";

-- 2c. Find all actors whose last names contain the letters `LI`.
SELECT * FROM actor
WHERE last_name LIKE "%Li%"
ORDER BY last_name, first_name;

-- 2d. Using `IN`, Afghanistan, Bangladesh, and China:
SELECT country_id, country FROM country
WHERE country IN ("Afghanistan", "Bangladesh", "China");

-- 3a. Create column description in actor datatype BLOB
ALTER TABLE actor
ADD COLUMN description BLOB AFTER last_name;

-- 3b.Delete the `description` column
ALTER TABLE actor
DROP COLUMN description;

-- 4a. Last names of and how many actors have that last name
SELECT last_name, COUNT(last_name)
FROM actor
GROUP BY last_name;

-- 4b. Last names of and how many actors have that last name, shared by at least two actors
SELECT last_name, COUNT(last_name)
FROM actor
GROUP BY last_name
HAVING COUNT(last_name)>=2;

-- 4c. Edit field 'GROUCHO Williams' to 'Harpo Williams'
UPDATE actor SET first_name = 'HARPO' WHERE first_name = 'groucho' and last_name = 'williams';
SELECT * FROM actor
WHERE first_name = 'Harpo' AND last_name = 'WILLIAMS';

-- 4D. Edit field 'Harpo Williams' to 'GROUCHO Williams'
UPDATE actor SET first_name = 'groucho' WHERE first_name = 'Harpo' and last_name = 'williams';
SELECT * FROM actor
WHERE first_name = 'groucho' AND last_name = 'WILLIAMS';
