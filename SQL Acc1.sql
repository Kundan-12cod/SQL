create database Assignment;
use assignment;
use sakila;
use world;

#1. Create a table called employees with the following structure?

CREATE TABLE employees (
    emp_id INT PRIMARY KEY NOT NULL,
    emp_name TEXT NOT NULL,
    age INTEGER CHECK (age >= 18),
    email ,
    salary DECIMAL DEFAULT 30000
);


#2. Explain the purpose of constraints and how they help maintain data integrity in a database. Provide examples of common types of constraints.
Ans- : Purpose of Constraints in Databases
Constraints in databases are rules or restrictions that are applied to the data within tables. Their primary purpose is to maintain data integrity, ensuring that the data stored is accurate, consistent, and reliable. By enforcing these rules at the database level, constraints help prevent the entry of invalid or inconsistent data, leading to a more robust and trustworthy database.
How Constraints Help Maintain Data Integrity
Prevent Invalid Data: Constraints define specific rules for data values, such as data types, allowed ranges, or required values. This prevents the entry of data that violates these rules, ensuring that only valid data is stored in the database.
Maintain Consistency: Constraints can be used to enforce relationships between different tables, ensuring that data in one table is consistent with related data in other tables. For example, foreign key constraints ensure that every value in a foreign key column refers to a valid value in the primary key of another table.
Improve Data Quality: By enforcing rules and restrictions, constraints help to improve the overall quality of the data stored in the database. This leads to more accurate and reliable information, which is essential for decision-making and other data-driven processes.
Common Types of Constraints
NOT NULL: Ensures that a column cannot have null values.
UNIQUE: Ensures that all values in a column are unique.
PRIMARY KEY: Uniquely identifies each row in a table. It is a combination of NOT NULL and UNIQUE constraints.
FOREIGN KEY: Defines a relationship between two tables, ensuring referential integrity.
CHECK: Enforces a specific condition on the data in a column.
DEFAULT: Specifies a default value for a column if no value is provided.
Example:
Consider an Employees table with columns like EmployeeID, FirstName, LastName, and DepartmentID. We can apply the following constraints:
NOT NULL on EmployeeID, FirstName, and LastName to ensure that these fields are always filled.
UNIQUE on EmployeeID to ensure that each employee has a unique identifier.
FOREIGN KEY on DepartmentID referencing the DepartmentID in the Departments table to maintain the relationship between employees and departments.
CHECK on EmployeeID to ensure that it follows a specific format or pattern.



#3.Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values? Justify your answer
Ans-:Why Apply the NOT NULL Constraint?
The NOT NULL constraint is applied to a column to ensure that every row in the table must have a value for that specific column. It prevents the insertion of rows where the specified column is left empty or contains a NULL value.
Reasons for Applying NOT NULL:
Data Integrity: By enforcing the presence of a value, the NOT NULL constraint helps maintain the accuracy and completeness of your data. It prevents missing or incomplete information, which can lead to errors in analysis or reporting.
Business Rules: In many cases, certain fields are essential for business operations. For example, a customer's name or a product's price cannot be left blank. The NOT NULL constraint ensures that these critical fields are always populated.
Foreign Key Relationships: When a column is part of a foreign key constraint, it should typically be NOT NULL. This ensures that every row in the referencing table has a valid link to the referenced table.
Query Performance: Having NOT NULL columns can sometimes improve query performance, as the database engine can optimize queries more effectively when it knows that certain columns always contain values.
Can a Primary Key Contain NULL Values?
No, a primary key cannot contain NULL values.
A primary key is a unique identifier for each row in a table. It must satisfy the following conditions:
Uniqueness: Each row must have a unique primary key value.
NOT NULL: The primary key column(s) cannot contain NULL values.



#4. Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an example for both adding and removing a constraint.
Ans-: 
Certainly, lets break down how to add or remove constraints on an existing table using SQL.
1. Adding Constraints
Understanding Constraints
Constraints are rules that enforce data integrity within a database table. They ensure data accuracy and consistency.
Common types of constraints include:
Primary Key: Uniquely identifies each row in the table.
Foreign Key: Establishes a link between two tables.
Unique: Ensures that a column or set of columns has unique values.
Not Null: Prevents null values from being inserted into a column.
Check: Verifies that values in a column meet specific conditions.
Default: Specifies a default value for a column if no value is provided during insertion.
Adding Constraints with ALTER TABLE
The ALTER TABLE statement is used to modify the structure of an existing table, including adding constraints.
Example: Adding a NOT NULL constraint to the 'Name' column of the 'Customers' table
SQL
ALTER TABLE Customers
MODIFY Name VARCHAR(255) NOT NULL;
Example: Adding a UNIQUE constraint to the 'Email' column of the 'Employees' table
SQL
ALTER TABLE Employees
ADD UNIQUE (Email); 
2. Removing Constraints
Removing Constraints with ALTER TABLE
The ALTER TABLE statement is also used to remove existing constraints.
Example: Removing the UNIQUE constraint from the 'Phone' column of the 'Contacts' table
SQL
ALTER TABLE Contacts
DROP INDEX Unique_Phone; 




#5. Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints. Provide an example of an error message that might occur when violating a constraint.
Ans-; Consequences of Violating Constraints
When you attempt to insert, update, or delete data that violates a constraint, the database system will typically:
Prevent the operation: The operation will be rejected, and the database will not be modified. This is the most common outcome to maintain data integrity.
Raise an error: The database system will generate an error message, indicating the specific constraint that was violated and the reason for the failure. This allows you to identify and correct the issue.
Example Error Message
Here an example of an error message that might occur when violating a FOREIGN KEY constraint:
SQL Error [23000]: Integrity constraint violation: FOREIGN KEY constraint
'FK_Orders_Customers' failed. The insert/update/delete statement 
referenced a foreign key that does not exist in the referenced table.

This message clearly states:
The type of constraint violated (FOREIGN KEY)
The name of the constraint (FK_Orders_Customers)
The specific issue (a non-existent foreign key reference)
Additional Notes:
The exact wording and format of error messages can vary depending on the database system you are using.
Some database systems might offer options to handle constraint violations in different ways, such as by triggering specific actions or allowing the operation to proceed with warnings. However, preventing the operation is generally the default and most robust approach.




#6. You created a products table without constraints as follows: 
CREATE TABLE products (     product_id INT,     product_name VARCHAR(50),     price DECIMAL(10, 2));   Now, you realise that? : 
The product_id should be a primary keyQ : 
The price should have a default value of 50.00

Ans-;-- Add Primary Key constraint to product_id
ALTER TABLE products
ADD PRIMARY KEY (product_id);

-- Add Default value of 50.00 to price
ALTER TABLE products
ALTER COLUMN price D(10 , 2) DEFAULT 50.00 ;




#7. You have two tables:
SELECT 
    students.student_name, 
    classes.class_name
FROM 
    students
INNER JOIN 
    classes ON students.class_id = classes.class_id;
    
   
   
   #8. Consider the following three tables: 
   # Write a query that shows all order_id, customer_name, and product_name, ensuring that all products are listed even if they are not associated with an order  Hint: (use INNER JOIN and LEFT JOIN)

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
    
  
  
  #9. Given the following tables:
#Write a query to find the total sales amount for each product using an INNER JOIN and the SUM() function.
SELECT p.product_id, p.product_name, SUM(s.amount) as total_sales
FROM Products p
INNER JOIN Sales s ON p.product_id = s.product_id
GROUP BY p.product_id, p.product_name;


#10. You are given three tables: 
#Write a query to display the order_id, customer_name, and the quantity of products ordered by each customer using an INNER JOIN between all three tables.
 SELECT 
    orders.order_id, 
    customers.customer_name, 
    SUM(order_items.quantity) AS total_quantity_ordered
FROM 
    orders
INNER JOIN 
    customers ON orders.customer_id = customers.customer_id
INNER JOIN 
    order_items ON orders.order_id = order_items.order_id
GROUP BY 
    orders.order_id, 
    customers.customer_name;
    
    
    # SQL Commands
   
   #1-Identify the primary keys and foreign keys in maven movies db. Discuss the differences
   Ans - Primary Keys and Foreign Keys in the Maven Movies Database
Primary Keys:
movies table: movie_id


Uniquely identifies each movie in the database.
customers table: customer_id


Uniquely identifies each customer in the database.
genres table: genre_id


Uniquely identifies each genre in the database.
actors table: actor_id


Uniquely identifies each actor in the database.
directors table: director_id


Uniquely identifies each director in the database.
Foreign Keys:
movies table:


director_id: References the director_id in the directors table, indicating the director of the movie.
order_items table:


order_id: References the order_id in the orders table, linking order items to their respective orders.
product_id: References the product_id in the products table, linking order items to the specific products ordered.
orders table:


customer_id: References the customer_id in the customers table, linking orders to the customers who placed them.
movie_genres table:


movie_id: References the movie_id in the movies table, establishing the relationship between movies and genres.
genre_id: References the genre_id in the genres table, establishing the relationship between movies and genres.
movie_actors table:


movie_id: References the movie_id in the movies table, linking actors to the movies they appear in.
actor_id: References the actor_id in the actors table, linking actors to the movies they appear in.
Differences Between Primary Keys and Foreign Keys:
Purpose:


Primary Key: Uniquely identifies each row within a specific table.
Foreign Key: Establishes a link between two tables, ensuring referential integrity.
Uniqueness:


Primary Key: Must be unique within its own table.
Foreign Key: Does not have to be unique within its own table but must match a value in the primary key of the referenced table.
Relationship:


Primary Key: Defines the primary identity of a table.
Foreign Key: Represents a relationship between two tables.
In essence:
A primary key is like a unique ID card for each row within a table.

use sakila;


#2.- List all details of actors
SELECT * FROM actor;



#3 -List all customer information from DB.
SELECT * FROM customer;



#4 -List different countries.
SELECT DISTINCT country FROM customers;

#5 -Display all active customers.
SELECT
c.customer_id,
c.first_name,
c.last_name
FROM
customer c
WHERE
c.active = 1;



#6 -List of all rental IDs for customer with ID 1.
SELECT
rental_id
FROM
rental
WHERE
customer_id = 1;



#7 - Display all the films whose rental duration is greater than 5 .
SELECT
film_id,
title
FROM
film
WHERE
rental_duration > 5;



#8 - List the total number of films whose replacement cost is greater than $15 and less than $20.
SELECT
COUNT(*)
FROM
film
WHERE
replacement_cost > 15
AND replacement_cost < 20;



#9 - Display the count of unique first names of actors.
SELECT
COUNT(DISTINCT first_name)
FROM
actor;



#10- Display the first 10 records from the customer table .
SELECT *
FROM customer
LIMIT 10;

#11 - Display the first 3 records from the customer table whose first name starts with ‘b’.
SELECT
*
FROM
customer
WHERE
first_name LIKE 'b%'
LIMIT 3;

#12 -Display the names of the first 5 movies which are rated as ‘G’.
SELECT
title
FROM
film
WHERE
rating = 'G'
LIMIT 5;


#13-Find all customers whose first name starts with "a".
SELECT
*
FROM
customer
WHERE
first_name LIKE 'a%';



#14- Find all customers whose first name ends with "a".
SELECT
*
FROM
customer
WHERE
first_name LIKE '%a';


#15- Display the list of first 4 cities which start and end with ‘a’ .
SELECT
city
FROM
city
WHERE
city LIKE 'a%'
AND city LIKE '%a'
LIMIT 4;


#16- Find all customers whose first name have "NI" in any position.
SELECT
*
FROM
customer
WHERE
first_name LIKE '%NI%';


#17- Find all customers whose first name have "r" in the second position .
SELECT *
FROM customer
WHERE first_name LIKE '_r%';


#18 - Find all customers whose first name starts with "a" and are at least 5 characters in length.

SELECT *
FROM customer
WHERE first_name LIKE 'a%'
AND LENGTH(first_name) >= 5;


#Functions
Basic Aggregate Functions:

#1 Retrieve the total number of rentals made in the Sakila database. Hint: Use the COUNT() function.

SELECT COUNT(*) AS total_rentals
          FROM rental;


# 2 Find the average rental duration (in days) of movies rented from the Sakila database. Hint: Utilize the AVG() function.
SELECT AvG(datediff(return_date, rental_date))AS avg_rental_duration
FROM rental;


#3 Display the first name and last name of customers in uppercase. Hint: Use the UPPER () function.
SELECT UPPER(first_name) AS first_name, UPPER(last_name) AS last_name
FROM customer;

#4.Extract the month from the rental date and display it alongside the rental ID. Hint: Employ the MONTH() function.
SELECT rental_id, MONTH(rental_date) AS rental_month
FROM rental;

#5. Retrieve the count of rentals for each customer (display customer ID and the count of rentals). Hint: Use COUNT () in conjunction with GROUP BY.
SELECT customer_id, COUNT(*) AS rental_count
FROM rental
GROUP BY customer_id;


#6. Find the total revenue generated by each store. Hint: Combine SUM() and GROUP BY.
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
    
    #7.Determine the total number of rentals for each category of movies. Hint: JOIN film_category, film, and rental tables, then use cOUNT () and GROUP BY.
SELECT c.name, COUNT(r.rental_id) AS total_rentals
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN rental r ON f.film_id = r.inventory_id  -- Assuming inventory_id in rental table references film_id
GROUP BY c.name;

#8: Find the average rental rate of movies in each language. Hint: JOIN film and language tables, then use AVG () and GROUP BY.
SELECT l.name, AVG(f.rental_rate) AS avg_rental_rate
FROM language l
JOIN film f ON l.language_id = f.language_id
GROUP BY l.name;

#9 - Display the title of the movie, customer s first name, and last name who rented it. Hint: Use JOIN between the film, inventory, rental, and customer tables.
SELECT f.title, c.first_name, c.last_name
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN customer c ON r.customer_id = c.customer_id;

#10: Retrieve the names of all actors who have appeared in the film "Gone with the Wind." Hint: Use JOIN between the film actor, film, and actor tables.
SELECT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.title = 'Gone with the Wind';	

#11.Retrieve the customer names along with the total amount they've spent on rentals.

#Hint: JOIN customer, payment, and rental tables, then use SUM() and GROUP BY
SELECT c.first_name, c.last_name, SUM(p.amount) AS total_spent
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.customer_id, c.first_name, c.last_name;

#12.List the titles of movies rented by each customer in a particular city (e.g., 'London'). Hint: JOIN customer, address, city, rental, inventory, and film tables, then use GROUP BY.
SELECT c.first_name, c.last_name, f.title
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE ci.city = 'London'
GROUP BY c.customer_id, c.first_name, c.last_name, f.title;

#13. Display the top 5 rented movies along with the number of times they've been rented. Hint: JOIN film, inventory, and rental tables, then use COUNT () and GROUP BY, and limit the results.
SELECT f.title, COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY rental_count DESC
LIMIT 5;

#14 . Determine the customers who have rented movies from both stores (store ID 1 and store ID 2). Hint: Use JOINS with rental, inventory, and customer tables and consider COUNT() and GROUP BY.
SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
WHERE i.store_id IN (1, 2)
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT i.store_id) = 2;


# Windows Function:


#1. Rank the customers based on the total amount they've spent on rentals.
SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount) AS total_spent
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC;


#2. Calculate the cumulative revenue generated by each film over time.
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
    
    #3. Determine the average rental duration for each film, considering films with similar lengths
    
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
    
    
#4. Identify the top 3 films in each category based on their rental counts.
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

#5. Calculate the difference in rental counts between each customer's total rentals and the average rentals across all customers.
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
    
    
 #6. Find the monthly revenue trend for the entire rental store over time.
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
    
#7. Identify the customers whose total spending on rentals falls within the top 20% of all customers.
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
            PERCENTILE_DISC(0.8) WITHIN GROUP(ORDER BY SUM(p.amount)) 
        FROM 
            customer c2
        JOIN 
            rental r2 ON c2.customer_id = r2.customer_id
        JOIN 
            payment p2 ON r2.rental_id = p2.rental_id
        GROUP BY 
            c2.customer_id
    );
    
    

#8. Calculate the running total of rentals per category, ordered by rental count.
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
    
    #9. Find the films that have been rented less than the average rental count for their respective categories.
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
    
    #10. Identify the top 5 months with the highest revenue and display the revenue generated in each month.
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


#Normalisation & CTE
#1. First Normal Form (1NF): 
#a. Identify a table in the Sakila database that violates 1NF. Explain how you would normalize it to achieve 1NF.

CREATE TABLE film_special_features (
    film_id SMALLINT UNSIGNED NOT NULL,
    special_feature VARCHAR(255) NOT NULL,
    PRIMARY KEY (film_id, special_feature),
    FOREIGN KEY (film_id) REFERENCES film(film_id)
);
 
 
 
# 2. Second Normal Form (2NF):
 #a. Choose a table in Sakila and describe how you would determine whether it is in 2NF. If it violates 2NF, explain the steps to normalize it.
CREATE TABLE store_inventory (
    store_id SMALLINT UNSIGNED NOT NULL,
    inventory_id SMALLINT UNSIGNED NOT NULL,
    PRIMARY KEY (store_id, inventory_id),
    FOREIGN KEY (store_id) REFERENCES store(store_id),
    FOREIGN KEY (inventory_id) REFERENCES inventory(inventory_id)
);


#3. Third Normal Form (3NF):
 #a. Identify a table in Sakila that violates 3NF. Describe the transitive dependencies present and outline the steps to normalize the table to 3NF.
CREATE TABLE city_country (
    city_id SMALLINT UNSIGNED NOT NULL,
    country_id SMALLINT UNSIGNED NOT NULL,
    PRIMARY KEY (city_id, country_id), 
    FOREIGN KEY (city_id) REFERENCES city(city_id),
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);


#4. Normalization Process: 
#a. Take a specific table in Sakila and guide through the process of normalizing it from the initial unnormalized form up to at least 2NF
1. Choose a Table:
Let's use the customer table as an example.
2. Initial (Unnormalized) Table (Hypothetical Scenario)
Assumptions:


We'll assume that the customer table initially also stores the city and country directly, violating 1NF and potentially higher normal forms.


customer_id
first_name
last_name
email
address
city
country
1
John
Doe
[email address removed]
123 Main St
New York
USA
2
Jane
Smith
[email address removed]
456 Oak Ave
London
UK
3
David
Lee
[email address removed]
789 Elm St
Paris
France

3. Normalization to 1NF
Identify and Address 1NF Violations: In this hypothetical scenario, the address field might contain multiple lines (e.g., "123 Main St, Apt 2"). This violates 1NF.


Normalization Steps:


Create a new table: address (if it doesnt  exist) with columns: address_id (primary key), address, address2 (for optional additional lines).
Modify the customer table: Remove the original address column and add a new column address_id as a foreign key referencing the address table.
4. Normalization to 2NF
#Identify Potential 2NF Violations: Analyze if any non-key attributes are partially dependent on the primary key. In this case, city and country might be partially dependent on address_id (if an address can only belong to one city and country).


Normalization Steps (if necessary):


Create new tables:


city with columns: city_id (primary key), city.
country with columns: country_id (primary key), country.
Modify the address table:


Remove the city and country columns.
Add city_id as a foreign key referencing the city table.
Modify the city table:


Add country_id as a foreign key referencing the country table.
5. Resulting Tables (After 2NF)
customer:


customer_id (primary key)
first_name
last_name
email
address_id (foreign key referencing address)
address:


address_id (primary key)
address
address2
city_id (foreign key referencing city)
city:


city_id (primary key)
city
country_id (foreign key referencing country)
country:


country_id (primary key)
country;

#5. CTE Basics:
 #a. Write a query using a CTE to retrieve the distinct list of actor names and the number of films they have acted in from the actor and film_actor tables.
  
  
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
    
    
#6. CTE with Joins:
 #a. Create a CTE that combines information from the film and language tables to display the film title, language name, and rental rate. 
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
    
#7. CTE for Aggregation: 
#a. Write a query using a CTE to find the total revenue generated by each customer (sum of payments) from the customer and payment tables.
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
    
    
#8 CTE with Window Functions:
# a. Utilize a CTE with a window function to rank films based on their rental duration from the film table. 
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
    Film_rank;
    
#9 CTE and Filtering:
# a. Create a CTE to list customers who have made more than two rentals, and then join this CTE with the customer table to retrieve additional customer details.
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
    


#    10 CTE for Date Calculations:
 #a. Write a query using a CTE to find the total number of rentals made each month, considering the rental_date from the rental table
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
    Rental_month;
    
#11. CTE and Self-Join:
 #a. Create a CTE to generate a report showing pairs of actors who have appeared in the same film together, using the film_actor table.
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
    
    
#12. CTE for Recursive Search: 
#a. Implement a recursive CTE to find all employees in the staff table who report to a specific manager, considering the reports_to column
WITH RECURSIVE EmployeeHierarchy AS (
    SELECT 
        staff_id, 
        first_name, 
        last_name, 
        reports_to
    FROM 
        staff
    WHERE 
        reports_to =Manager_Staff_ID
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


  
  