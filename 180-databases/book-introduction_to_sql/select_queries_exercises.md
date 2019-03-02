
[comment]: # (select_queries_exercises.md)

# Select Queries - Exercises - 2/2/2019

1. Make sure you are connected to the `encyclopedia` database. Write a query to retrieve the population of the USA.

#### Solution:

```sql
SELECT population FROM countries
  WHERE name = 'USA';
```

---

2. Write a query to return the population and the capital (with the columns in that order) of all the countries in the table.

#### Solution:

```sql
SELECT population, capital FROM countries;
```

---

3. Write a query to return the names of all the countries ordered alphabetically.

#### Solution:

```sql
SELECT name FROM countries
  ORDER BY name;
```

---

4. Write a query to return the names and the capitals of all the countries in order of population, from lowest to highest.

#### Solution:

```sql
SELECT name, capital FROM countries
  ORDER BY population;
```

---

5. Write a query to return the same information as the previous query, but ordered from highest to lowest.

#### Solution:

```sql
SELECT name, capital FROM countries
  ORDER BY population DESC;
```

---

6. Write a query on the `animals` table, using `ORDER BY`, that will return the following output:

```
       name       |      binomial_name       | max_weight_kg | max_age_years
------------------+--------------------------+---------------+---------------
 Peregrine Falcon | Falco Peregrinus         |        1.5000 |            15
 Pigeon           | Columbidae Columbiformes |        2.0000 |            15
 Dove             | Columbidae Columbiformes |        2.0000 |            15
 Golden Eagle     | Aquila Chrysaetos        |        6.3500 |            24
 Kakapo           | Strigops habroptila      |        4.0000 |            60
(5 rows)
```

Use only the columns that can be seen in the above output for ordering purposes.

#### Solution:

```sql
SELECT name, binomial_name, max_weight_kg, max_age_years FROM animals
  ORDER BY max_age_years, max_weight_kg, name DESC;
```

---

7. Write a query that returns the names of all the countries with a population greater than 70 million.

#### Solution:

```sql
SELECT name FROM countries
  WHERE population > 70000000;
```

---

8. Write a query that returns the names of all the countries with a population greater than 70 million but less than 200 million.

#### Solution:

```sql
SELECT name FROM countries
  WHERE population > 70000000
    AND population < 200000000;
```

---

9. Write a query that will return the first name and last name of all entries in the celebrities table where the value of the deceased column is not true.

#### Solution:

```sql
SELECT first_name, last_name FROM celebrities
  WHERE deceased IS NOT true;
```

---

10. Write a query that will return the first and last names of all the celebrities who sing.

#### Solution:

```sql
SELECT first_name, last_name FROM celebrities
  WHERE occupation LIKE '%Singer%';
```

---

11. Write a query that will return the first and last names of all the celebrities who act.

#### Solution:

```sql
SELECT first_name, last_name FROM celebrities
  WHERE occupation LIKE '%Actor%'
     OR occupation LIKE '%Actress%';
```

---

12. Write a query that will return the first and last names of all the celebrities who both sing and act.

#### Solution:

```sql
SELECT first_name, last_name FROM celebrities
  WHERE occupation LIKE '%Singer%'
    AND (occupation LIKE '%Actor%' OR occupation LIKE '%Actress%');
```

---

13. Connect to the `ls_burger` database. Write a query that lists all of the burgers that have been ordered, from cheapest to most expensive, where the cost of the burger is less than $5.00.

#### Solution:

```sql
SELECT burger FROM orders
  WHERE burger_cost < 5.00
  ORDER BY burger_cost;
```

---

14. Write a query to return the customer name and email address and loyalty points from any order worth 20 or more loyalty points. List the results from the highest number of points to the lowest.

#### Solution:

```sql
SELECT customer_name, customer_email, customer_loyalty_points
  FROM orders
  WHERE customer_loyalty_points >= 20
  ORDER BY customer_loyalty_points DESC;
```

---

15. Write a query that returns all the burgers ordered by Natasha O'Shea.

#### Solution:

```sql
SELECT burger FROM orders
  WHERE customer_name = 'Natasha O''Shea';
```

---

16. Write a query that returns the customer name from any order which does not include a drink item.

#### Solution:

```sql
SELECT customer_name FROM orders
  WHERE drink IS NULL;
```

---

17. Write a query that returns the three meal items for any order which does not include fries.

#### Solution:

```sql
SELECT burger, side, drink FROM orders
  WHERE side != 'Fries'
  OR side IS NULL;
```

---

18. Write a query that returns the three meal items for any order that includes both a side and a drink.

#### Solution:

```sql
SELECT burger, side, drink FROM orders
  WHERE side IS NOT NULL
  AND drink IS NOT NULL;
```
