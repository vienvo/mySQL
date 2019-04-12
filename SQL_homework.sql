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

-- 4d. Edit field 'Harpo Williams' to 'GROUCHO Williams'
UPDATE actor SET first_name = 'groucho' WHERE first_name = 'Harpo' and last_name = 'williams';
SELECT * FROM actor
WHERE first_name = 'groucho' AND last_name = 'WILLIAMS';

-- 5a. Query to re-create schema 'address'
CREATE SCHEMA address;

-- 6a. Using JOIN to display fist name, last name, and address
SELECT a.first_name, a.last_name, b.address
FROM staff a
INNER JOIN address b
ON a.address_id = b.address_id;

-- 6b. Using JOIN to display total amount rung up by each staff member in August of 2005
SELECT a.first_name, a.last_name, SUM(b.amount) AS 'Rental Amount'
FROM staff a
INNER JOIN payment b
ON a.staff_id = b.staff_id
WHERE b.payment_date >= DATE('2005-08-01') AND b.payment_date <= DATE('2005-08-31')
GROUP BY b.staff_id;

-- 6c. List each film and the number of actors who are listed for that film.
SELECT a.film_id, b.title, COUNT(a.actor_id) AS "Actor Count"
FROM film_actor a
INNER JOIN film b
ON a.film_id = b.film_id
GROUP BY film_id;

-- 6d. How many copies of the film `Hunchback Impossible` exist in the inventory system?
SELECT a.film_id, a.title, COUNT(b.film_id) AS "Number of copies"
FROM film a
INNER JOIN inventory b
ON a.film_id = b.film_id
WHERE a.title = "Hunchback Impossible"
GROUP BY film_id;

-- 6e. Total Paid by each customer
SELECT a.first_name, a.last_name, SUM(b.amount) AS "Total Paid"
FROM customer a
INNER JOIN payment b
ON a.customer_id = b.customer_id
GROUP BY a.customer_id
ORDER BY a.last_name;