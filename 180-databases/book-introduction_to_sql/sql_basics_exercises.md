
[comment]: # (sql_basics_exercises.md)

# SQL Basics - Exercises - 2/1/2019

1. Write a query that returns all of the customer names from the `orders` table.

#### Solution:

`SELECT customer_name FROM orders;`

---

2. Write a query that returns all of the orders that include a Chocolate Shake.

#### Solution:

```sql
SELECT * FROM orders
WHERE drink LIKE 'Chocolate Shake';
```

---

3. Write a query that returns the burger, side, and drink for the order with an `id` of `2`.

#### Solution:

```sql
SELECT burger, side, drink FROM orders
WHERE id = 2;
```

---

4. Write a query that returns the name of anyone who ordered Onion Rings.

#### Solution:

```sql
SELECT customer_name FROM orders
WHERE side = 'Onion Rings';
```
