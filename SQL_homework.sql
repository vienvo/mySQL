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

-- 7a. Use subqueries to display movies start with letters 'K' and 'Q' whose language is English
SELECT title, language_id FROM film
WHERE title LIKE "K%" OR title LIKE "Q%"
AND language_id IN (SELECT language_id FROM language WHERE name = "English");

-- 7b. Use subqueries to display all actors who appear in the film `Alone Trip`.
SELECT first_name, last_name FROM actor
WHERE actor_id IN
(SELECT actor_id FROM film_actor
WHERE film_id IN 
(SELECT film_id FROM film
WHERE title = "Alone Trip"));

-- 7c. Use JOIN to list names and email addresses for all Canadian customers
SELECT first_name, last_name, email FROM customer WHERE address_id IN
(SELECT address_id FROM address WHERE city_id IN
(SELECT city_id FROM city WHERE country_id IN 
(SELECT country_id FROM country WHERE country = "Canada")));

-- 7d. Identify all movies categorized as _family_ films
SELECT * FROM film WHERE film_id IN
(SELECT film_id FROM film_category WHERE category_id IN
(SELECT category_id FROM category WHERE name = "Family"));

-- 7e. Display the most frequently rented movies in descending order.
SELECT a.title, COUNT(c.inventory_id) AS "Count of rental"
FROM film a
JOIN inventory b
ON a.film_id = b.film_id
JOIN rental c
ON b.inventory_id = c.inventory_id
GROUP BY a.title
ORDER BY COUNT(c.inventory_id) DESC;

-- 7f. Write a query to display how much business, in dollars, each store brought in.
SELECT a.store_id, SUM(b.amount) AS "Rental Amount"
FROM payment b
INNER JOIN store a
ON a.manager_staff_id = b.staff_id
GROUP BY staff_id;

-- 7g. Write a query to display for each store its store ID, city, and country.
SELECT a.store_id, c.city, d.country
FROM store a
JOIN address b
ON a.address_id = b.address_id
JOIN city c
ON b.city_id = c.city_id
JOIN country d
ON c.country_id = d.country_id
GROUP BY store_id;

-- 7h. List the top five genres in gross revenue in descending order.
SELECT a.name, SUM(e.amount) AS "Total Rental Amount"
FROM category a
JOIN film_category b
ON a.category_id = b.category_id
JOIN inventory c
ON b.film_id = c.film_id
JOIN rental d
ON c.inventory_id = d.inventory_id
JOIN payment e
ON d.rental_id = e.rental_id
GROUP BY a.name
ORDER BY SUM(e.amount) DESC
LIMIT 5;

-- 8a. Create view for top 5 category by gross revenue
CREATE VIEW Top_5_Category AS
SELECT a.name, SUM(e.amount) AS "Total Rental Amount"
FROM category a
JOIN film_category b
ON a.category_id = b.category_id
JOIN inventory c
ON b.film_id = c.film_id
JOIN rental d
ON c.inventory_id = d.inventory_id
JOIN payment e
ON d.rental_id = e.rental_id
GROUP BY a.name
ORDER BY SUM(e.amount) DESC
LIMIT 5;

-- 8b. How would you display the view that you created in 8a?
-- -- In Navigator panel, select Views, select top_5_category, right_click, choose option Select Rows or use below query.
SELECT * FROM sakila.top_5_category;

-- 8c. Delete view Top_5_Category
DROP VIEW Top_5_Category;

