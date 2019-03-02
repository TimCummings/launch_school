
[comment]: # (sql_joins_exercises.md)

# SQL Joins - Exercises - 2/5/2019

1. Connect to the `encyclopedia` database. Write a query to return all of the country names along with their appropriate continent names.

#### Solution:

```sql
/* slight adjustment first, to satiate my OCD */
ALTER TABLE continents
  RENAME COLUMN continent_name TO name;

/* now answer the question */
SELECT countries.name, continents.name
  FROM countries
  JOIN continents ON (countries.continent_id = continents.id);
```

#### Correction based on provided solution:

Spacing looks better as follows (and parentheses are unnecessary):

```sql
SELECT countries.name, continents.name
  FROM countries JOIN continents
  ON countries.continent_id = continents.id;
```

---

2. Write a query to return all of the names and capitals of the European countries.

#### Solution:

```sql
SELECT c.name, c.capital
  FROM countries AS c
  JOIN continents ON c.continent_id = continents.id
  WHERE continents.name = 'Europe';
```

---

3. Write a query to return the first name of any singer who had an album released under the Warner Bros label.

#### Solution:

```sql
SELECT s.first_name
  FROM singers AS s
  JOIN albums AS a
  ON s.id = a.singer_id
  WHERE a.label LIKE '%'Warner Bros%';
```

#### Correction from provided solution:

Use `DISTINCT` so results are not duplicated:

```sql
SELECT DISTINCT s.first_name
  FROM singers AS s
  JOIN albums AS a
  ON s.id = a.singer_id
  WHERE a.label LIKE '%'Warner Bros%';
```

---

4. Write a query to return the first name and last name of any singer who released an album in the 80s and who is still living, along with the names of the album that was released and the release date. Order the results by the singer's age (youngest first).

#### Solution:

```sql
SELECT s.first_name, s.last_name, a.name, a.released
  FROM singers AS s
  JOIN albums AS a
  ON s.id = a.singer_id
  WHERE a.released BETWEEN '01-01-1980' AND '12-31-1989'
  AND s.deceased = false
  ORDER BY s.date_of_birth DESC;
```

---

5. Write a query to return the first name and last name of any singer without an associated album entry.

#### Solution:

```sql
SELECT s.first_name, s.last_name FROM singers AS s
  LEFT JOIN albums AS a ON s.id = a.singer_id
  WHERE a.singer_id IS NULL;
```

---

6. Rewrite the query for the last question as a sub-query.

#### Solution:

```sql
SELECT s.first_name, s.last_name FROM singers AS s
  WHERE s.id NOT IN (SELECT a.singer_id FROM albums AS a);
```

---

7. Connect to the `ls_burger` database. Return a list of all orders and their associated product items.

#### Solution:

```sql
SELECT o.id, p.name
  FROM orders AS o
  JOIN order_items AS oi ON o.id = oi.order_id
  JOIN products AS p ON p.id = oi.product_id;
```

#### Correction based on provided solution:

Select all columns from `orders` and `products`:

```sql
SELECT orders.*, products.* FROM orders
  JOIN order_items ON orders.id = order_items.order_id
  JOIN products ON products.id = order_items.product_id;
```

---

8. Return the id of any order that includes Fries. Use table aliasing in your query.

#### Solution:

```sql
SELECT DISTINCT o.id FROM orders AS o
  JOIN order_items AS oi ON o.id = oi.order_id
  JOIN products AS p ON p.id = oi.product_id
  WHERE p.name = 'Fries';
```

---

9. Build on the query from the previous question to return the name of any customer who ordered fries. Return this in a column called 'Customers who like Fries'. Don't repeat the same customer name more than once in the results.

#### Solution:

```sql
SELECT DISTINCT c.name AS "Customers who like Fries"
  FROM customers AS c
    JOIN orders AS o ON c.id = o.customer_id
    JOIN order_items AS oi ON o.id = oi.order_id
    JOIN products AS p ON p.id = oi.product_id
  WHERE p.name = 'Fries';
```

---

10. Write a query to return the total cost of Natasha O'Shea's orders.

#### Solution:

```sql
SELECT sum(p.cost) FROM products AS p
  JOIN order_items AS oi ON oi.product_id = p.id
  JOIN orders AS o ON o.id = oi.order_id
  JOIN customers AS c ON c.id = o.customer_id
  WHERE c.name = 'Natasha O''Shea';
```

---

11. Write a query to return the name of every product included in an order alongside the number of times it has been ordered.

#### Solution:

```sql
SELECT p.name, count(p.id) FROM orders AS o
  JOIN order_items AS oi ON oi.order_id = o.id
  JOIN products AS p ON p.id = oi.product_id
  GROUP BY p.name;
```
