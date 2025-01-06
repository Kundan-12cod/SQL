## DDL = Data Defination langauge


use test1;
 
 
create table Class
(Roll_no int,
 Name varchar(100),
 Marks int,
 Grade varchar(100));
insert into Class (Roll_no,Name,Marks,Grade)
values (1,'Karma',98,'A'),
 (2 , 'shyam', 78,'A'),
 (3,'jay',85.,'A'),
 (4,'yesh',56.6,'B'), 
 (5,'Rish',60,'B'),
 (6,'krishna',49,'C'),
 (7,'Rohit',45,'C'),
 (8,'lsha',60.9,'B');
 
 
 alter table Class add (Class varchar (100))
 select * from Class;
 
 -- Add Primary Key constraint to product_id
ALTER TABLE products
ADD PRIMARY KEY (product_id);

-- Add Default value of 50.00 to price
ALTER TABLE products
ALTER COLUMN price DECIMAL(10, 2) DEFAULT 50.00;


use assignment;

create table students(student_id int,
student_name text ,
class_id int);

insert into students(student_id,student_name,class_id)
values(1,'Alice',101),
(2,'Bob',102),
(3,'Charlie',103);

create table Classes(class_id int,class_name text);
insert into Classes(class_id ,class_name)
values(101,'Math'),
(102,'Science'),
(103,'History');

SELECT 
    students.student_name, 
    classes.class_name
FROM 
    students
INNER JOIN 
    classes ON students.class_id = classes.class_id;

        
create table orders(order_id int,
order_data date,
customer_id int);

insert into orders(order_id,order_data, customer_id)
values(1,'2024-01-01',101),
(2,'2024-01-03',102);

create table customers(customer_id int,customer_name char(40));

insert into customers(customer_id,customer_name)
values(101,'Alice'),
(102,'Bob');

create table products(product_id int,product_name char(40),order_id int);

insert into products(product_id,product_name,order_id)
values(1 , 'Laptop',1),
(2,'phone',null);

SELECT 
    orders.order_id, 
    customers.customer_name, 
    products.product_name
FROM 
    products
LEFT JOIN 
    order_items ON products.product_id = order_items.product_id
LEFT JOIN 
    orders ON order_items.order_id = orders.order_id
LEFT JOIN 
    customers ON orders.customer_id = customers.customer_id;
SELECT * FROM actors;

use sakila;
SELECT COUNT(*) AS total_rentals
FROM rental;


SELECT AVG(DATEDIFF(return_date, rental_date)) AS avg_rental_duration
FROM rental;

	SELECT UPPER(first_name) AS first_name, UPPER(last_name) AS last_name
	FROM customer;

SELECT rental_id, MONTH(rental_date) AS rental_month
FROM rental;

SELECT customer_id, COUNT(*) AS rental_count
FROM rental
GROUP BY customer_id;

SELECT store_id, SUM(amount) AS total_revenue
FROM payment
GROUP BY store_id;

SELECT film_category.name AS category, COUNT(r.rental_id) AS total_rentals
FROM film_category fc
JOIN film f ON film_category.category_id = f.category_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY film_category.name;

SELECT c.name, COUNT(r.rental_id) AS total_rentals
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN rental r ON f.film_id = r.inventory_id  -- Assuming inventory_id in rental table references film_id
GROUP BY c.name;

SELECT
    s.store_id,
    s.manager_staff_id,
    SUM(p.amount) AS total_revenue
FROM
    payment p
JOIN
    rental r ON p.rental_id = r.rental_id
JOIN
    inventory i ON r.inventory_id = i.inventory_id
JOIN
    store s ON i.store_id = s.store_id
GROUP BY
    s.store_id,
    s.manager_staff_id;
    
    SELECT l.name, AVG(f.rental_rate) AS avg_rental_rate
FROM language l
JOIN film f ON l.language_id = f.language_id
GROUP BY l.name;

SELECT f.title, c.first_name, c.last_name
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN customer c ON r.customer_id = c.customer_id;

SELECT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.title = 'Gone with the Wind';

SELECT DISTINCT actor.name
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON film_actor.film_id = film.film_id
WHERE film.title = 'Gone with the Wind';


SELECT c.first_name, c.last_name, SUM(p.amount) AS total_spent
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.customer_id, c.first_name, c.last_name;	

SELECT c.first_name, c.last_name, f.title
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE ci.city = 'London'
GROUP BY c.customer_id, c.first_name, c.last_name, f.title;


SELECT f.title, COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY rental_count DESC
LIMIT 5;

SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
WHERE i.store_id IN (1, 2)
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT i.store_id) = 2;	

SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount) AS total_spent
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC;

SELECT 
    f.film_id, 
    f.title, 
    r.rental_date, 
    p.amount, 
    SUM(p.amount) OVER (PARTITION BY f.film_id ORDER BY r.rental_date) AS cumulative_revenue
FROM 
    film f
JOIN 
    inventory i ON f.film_id = i.film_id
JOIN 
    rental r ON i.inventory_id = r.inventory_id
JOIN 
    payment p ON r.rental_id = p.rental_id
ORDER BY 
    f.film_id, r.rental_date;
    
    SELECT 
    f.film_id, 
    f.title, 
    f.length, 
    AVG(DATEDIFF(r.return_date, r.rental_date)) AS avg_rental_duration
FROM 
    film f
JOIN 
    inventory i ON f.film_id = i.film_id
JOIN 
    rental r ON i.inventory_id = r.inventory_id
GROUP BY 
    f.film_id, f.title, f.length
ORDER BY 
    f.length, avg_rental_duration;
    
    SELECT 
    c.name AS category, 
    f.title, 
    COUNT(r.rental_id) AS rental_count
FROM 
    category c
JOIN 
    film_category fc ON c.category_id = fc.category_id
JOIN 
    film f ON fc.film_id = f.film_id
JOIN 
    inventory i ON f.film_id = i.film_id
JOIN 
    rental r ON i.inventory_id = r.inventory_id
GROUP BY 
    c.name, f.title
ORDER BY 
    c.name, rental_count DESC
LIMIT 3;

SELECT 
    c.name AS film_category, 
    f.title, 
    COUNT(r.rental_id) AS rental_count
FROM 
    category c
JOIN 
    film_category fc ON c.category_id = fc.category_id
JOIN 
    film f ON fc.film_id = f.film_id
JOIN 
    inventory i ON f.film_id = i.film_id
JOIN 
    rental r ON i.inventory_id = r.inventory_id
GROUP BY 
    c.name, f.title
ORDER BY 
    c.name, rental_count DESC
LIMIT 3;

use world;
use sakila;

SELECT 
    c.customer_id, 
    c.first_name, 
    c.last_name, 
    COUNT(r.rental_id) AS customer_rentals, 
    (COUNT(r.rental_id) - AVG(COUNT(r.rental_id)) OVER ()) AS rental_count_diff
FROM 
    customer c
JOIN 
    rental r ON c.customer_id = r.customer_id
GROUP BY 
    c.customer_id, c.first_name, c.last_name;
    
    
    SELECT 
    c.name AS category, 
    f.title, 
    COUNT(r.rental_id) AS rental_count
FROM 
    category c
JOIN 
    film_category fc ON c.category_id = fc.category_id
JOIN 
    film f ON fc.film_id = f.film_id
JOIN 
    inventory i ON f.film_id = i.film_id
JOIN 
    rental r ON i.inventory_id = r.inventory_id
GROUP BY 
    c.name, f.title
ORDER BY 
    c.name, rental_count DESC
LIMIT 3;

SELECT 
    DATE_FORMAT(r.rental_date, '%Y-%m') AS rental_month, 
    SUM(p.amount) AS monthly_revenue
FROM 
    rental r
JOIN 
    payment p ON r.rental_id = p.rental_id
GROUP BY 
    rental_month
ORDER BY 
    rental_month;
    
    SELECT 
    c.customer_id, 
    c.first_name, 
    c.last_name, 
    SUM(p.amount) AS total_spent
FROM 
    customer c
JOIN 
    rental r ON c.customer_id = r.customer_id
JOIN 
    payment p ON r.rental_id = p.rental_id
GROUP BY 
    c.customer_id, c.first_name, c.last_name
HAVING 
    SUM(p.amount) >= (
        SELECT 
            PERCENTILE_DISC(0.8) WITHIN GROUP (ORDER BY SUM(p.amount))
        FROM 
            customer c2
        JOIN 
            rental r2 ON c2.customer_id = r2.customer_id
        JOIN 
            payment p2 ON r2.rental_id = p2.rental_id
        GROUP BY 
            c2.customer_id
    );
    
    WITH CustomerTotalSpending AS (
    SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount) AS total_spent
    FROM customer c
    JOIN rental r ON c.customer_id = r.customer_id
    JOIN payment p ON r.rental_id = p.rental_id
    GROUP BY c.customer_id, c.first_name, c.last_name
),
Top20PercentThreshold AS (
    SELECT NTILE(5) OVER (ORDER BY total_spent DESC) AS spending_percentile
    FROM CustomerTotalSpending
)
SELECT c.first_name, c.last_name
FROM CustomerTotalSpending c
JOIN Top20PercentThreshold t ON c.customer_id = t.customer_id
WHERE t.spending_percentile = 1;



SELECT 
    c.name AS category, 
    COUNT(r.rental_id) AS rental_count, 
    SUM(COUNT(r.rental_id)) OVER (ORDER BY COUNT(r.rental_id)) AS running_total
FROM 
    category c
JOIN 
    film_category fc ON c.category_id = fc.category_id
JOIN 
    film f ON fc.film_id = f.film_id
JOIN 
    inventory i ON f.film_id = i.film_id
JOIN 
    rental r ON i.inventory_id = r.inventory_id
GROUP BY 
    c.name
ORDER BY 
    rental_count DESC;
    
    SELECT 
    f.film_id, 
    f.title, 
    c.name AS category, 
    COUNT(r.rental_id) AS film_rentals, 
    AVG(COUNT(r.rental_id)) OVER (PARTITION BY c.name) AS avg_category_rentals
FROM 
    film f
JOIN 
    film_category fc ON f.film_id = fc.film_id
JOIN 
    category c ON fc.category_id = c.category_id
JOIN 
    inventory i ON f.film_id = i.film_id
JOIN 
    rental r ON i.inventory_id = r.inventory_id
GROUP BY 
    f.film_id, f.title, c.name
HAVING 
    COUNT(r.rental_id) < AVG(COUNT(r.rental_id)) OVER (PARTITION BY c.name);
    
    SELECT 
    DATE_FORMAT(r.rental_date, '%Y-%m') AS rental_month, 
    SUM(p.amount) AS monthly_revenue
FROM 
    rental r
JOIN 
    payment p ON r.rental_id = p.rental_id
GROUP BY 
    rental_month
ORDER BY 
    monthly_revenue DESC
LIMIT 5;

CREATE TABLE film_special_features (
    film_id SMALLINT UNSIGNED NOT NULL,
    special_feature VARCHAR(255) NOT NULL,
    PRIMARY KEY (film_id, special_feature),
    FOREIGN KEY (film_id) REFERENCES film(film_id)
);

CREATE TABLE store_inventory (
    store_id SMALLINT UNSIGNED NOT NULL,
    inventory_id SMALLINT UNSIGNED NOT NULL,
    PRIMARY KEY (store_id, inventory_id),
    FOREIGN KEY (store_id) REFERENCES store(store_id),
    FOREIGN KEY (inventory_id) REFERENCES inventory(inventory_id)
);

CREATE TABLE city_country (
    city_id SMALLINT UNSIGNED NOT NULL,
    country_id SMALLINT UNSIGNED NOT NULL,
    PRIMARY KEY (city_id, country_id), 
    FOREIGN KEY (city_id) REFERENCES city(city_id),
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

WITH ActorFilmCounts AS (
    SELECT 
        a.actor_id, 
        a.first_name, 
        a.last_name, 
        COUNT(fa.film_id) AS film_count
    FROM 
        actor a
    JOIN 
        film_actor fa ON a.actor_id = fa.actor_id
    GROUP BY 
        a.actor_id, a.first_name, a.last_name
)
SELECT 
    first_name, 
    last_name, 
    film_count
FROM 
    ActorFilmCounts;
    
    WITH FilmLanguage AS (
    SELECT 
        f.title, 
        l.name AS language_name, 
        f.rental_rate
    FROM 
        film f
    JOIN 
        language l ON f.language_id = l.language_id
)
SELECT 
    * 
FROM 
    FilmLanguage;
    
    WITH CustomerRevenue AS (
    SELECT 
        c.customer_id, 
        c.first_name, 
        c.last_name, 
        SUM(p.amount) AS total_revenue
    FROM 
        customer c
    JOIN 
        rental r ON c.customer_id = r.customer_id
    JOIN 
        payment p ON r.rental_id = p.rental_id
    GROUP BY 
        c.customer_id, c.first_name, c.last_name
)
SELECT 
    * 
FROM 
    CustomerRevenue;
    
    WITH FilmRentalDurations AS (
    SELECT 
        f.film_id, 
        f.title, 
        AVG(DATEDIFF(r.return_date, r.rental_date)) AS avg_rental_duration,
        RANK() OVER (ORDER BY AVG(DATEDIFF(r.return_date, r.rental_date)) DESC) AS film_rank
    FROM 
        film f
    JOIN 
        inventory i ON f.film_id = i.film_id
    JOIN 
        rental r ON i.inventory_id = r.inventory_id
    GROUP BY 
        f.film_id, f.title
)
SELECT 
    * 
FROM 
    FilmRentalDurations
ORDER BY 
    film_rank;
    
    WITH FrequentRenters AS (
    SELECT 
        c.customer_id
    FROM 
        customer c
    JOIN 
        rental r ON c.customer_id = r.customer_id
    GROUP BY 
        c.customer_id
    HAVING 
        COUNT(r.rental_id) > 2
)
SELECT 
    c.customer_id, 
    c.first_name, 
    c.last_name, 
    c.email
FROM 
    customer c
JOIN 
    FrequentRenters fr ON c.customer_id = fr.customer_id;
    
    WITH MonthlyRentalCounts AS (
    SELECT 
        DATE_FORMAT(r.rental_date, '%Y-%m') AS rental_month, 
        COUNT(r.rental_id) AS rental_count
    FROM 
        rental r
    GROUP BY 
        rental_month
)
SELECT 
    rental_month, 
    rental_count
FROM 
    MonthlyRentalCounts
ORDER BY 
    rental_month;
    
    WITH ActorPairs AS (
    SELECT 
        fa1.actor_id AS actor1_id, 
        fa2.actor_id AS actor2_id
    FROM 
        film_actor fa1
    JOIN 
        film_actor fa2 ON fa1.film_id = fa2.film_id AND fa1.actor_id < fa2.actor_id
)
SELECT 
    a1.first_name AS actor1_first_name, 
    a1.last_name AS actor1_last_name, 
    a2.first_name AS actor2_first_name, 
    a2.last_name AS actor2_last_name
FROM 
    ActorPairs ap
JOIN 
    actor a1 ON ap.actor1_id = a1.actor_id
JOIN 
    actor a2 ON ap.actor2_id = a2.actor_id;
    
    WITH RECURSIVE EmployeeHierarchy AS (
    SELECT 
        staff_id, 
        first_name, 
        last_name, 
        reports_to
    FROM 
        staff
    WHERE 
        reports_to = <Manager_Staff_ID> 
    UNION ALL
    SELECT 
        s.staff_id, 
        s.first_name, 
        s.last_name, 
        s.reports_to
    FROM 
        staff s
    JOIN 
        EmployeeHierarchy eh ON s.reports_to = eh.staff_id
)
SELECT 
    * 
FROM 
    EmployeeHierarchy;
    
    WITH RECURSIVE EmployeeHierarchy AS (
    SELECT 
        staff_id, 
        first_name, 
        last_name, 
        reports_to
    FROM 
        staff
    WHERE 
        reports_to = <Manager_Staff_ID> 
    UNION ALL
    SELECT 
        s.staff_id, 
        s.first_name, 
        s.last_name, 
        s.reports_to
    FROM 
        staff s
    JOIN 
        EmployeeHierarchy eh ON s.reports_to = eh.staff_id
)
SELECT 
    * 
FROM 
    EmployeeHierarchy;
    
    SELECT 
    c.customer_id, 
    c.first_name, 
    c.last_name
FROM 
    customer c
WHERE 
    c.active = 1;
    
    SELECT 
    rental_id 
FROM 
    rental 
WHERE 
    customer_id = 1;
    
    SELECT 
    film_id, 
    title 
FROM 
    film 
WHERE 
    rental_duration > 5;
    
    SELECT 
    COUNT(*) 
FROM 
    film 
WHERE 
    replacement_cost > 15 
    AND replacement_cost < 20;
    
    SELECT 
    COUNT(DISTINCT first_name) 
FROM 
    actor;
    
    SELECT * 
FROM customer 
LIMIT 10;

SELECT 
    * 
FROM 
    customer 
WHERE 
    first_name LIKE 'b%' 
LIMIT 3;

SELECT 
    title 
FROM 
    film 
WHERE 
    rating = 'G' 
LIMIT 5;

SELECT 
    * 
FROM 
    customer 
WHERE 
    first_name LIKE 'a%';
    SELECT 
    * 
FROM 
    customer 
WHERE 
    first_name LIKE '%a';
    
    SELECT 
    city 
FROM 
    city 
WHERE 
    city LIKE 'a%' 
    AND city LIKE '%a' 
LIMIT 4;

SELECT 
    * 
FROM 
    customer 
WHERE 
    first_name LIKE '%NI%';
    
    SELECT * 
FROM customer 
WHERE first_name LIKE '_r%';

SELECT * 
FROM customer 
WHERE first_name LIKE 'a%' 
AND LENGTH(first_name) >= 5;