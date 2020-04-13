
[comment]: # (using_foreign_keys.md)

# Using Foreign Keys - 3/23/2020

1. Import [this file](https://raw.githubusercontent.com/launchschool/sql_course_data/master/sql-and-relational-databases/relational-data-and-joins/foreign-keys/orders_products1.sql) into a new database.

#### Solution:

```
createdb using_foreign_keys
curl -O https://raw.githubusercontent.com/launchschool/sql_course_data/master/sql-and-relational-databases/relational-data-and-joins/foreign-keys/orders_products1.sql
psql -d using_foreign_keys < orders_products1.sql
```

---

2. Update the `orders` table so that referential integrity will be preserved for the data between `orders` and `products`.

#### Solution:

```psql
ALTER TABLE orders
  ADD CONSTRAINT orders_product_id_fkey FOREIGN KEY (product_id) REFERENCES products (id);
```

---

3. Use `psql` to insert the data shown in the following table into the database:

| Quantity | Product    |
|----------|------------|
| 10 	     | small bolt |
| 25 	     | small bolt |
| 15 	     | large bolt |

#### Solution:

```sql
INSERT INTO products (name) VALUES
  ('small bolt'),
  ('large bolt');

SELECT * FROM products;

INSERT INTO orders (product_id, quantity) VALUES
  (1, 10),
  (1, 25),
  (2, 15);
```

---

4. Write a SQL statement that returns a result like this:

```sql
 quantity |    name
----------+------------
       10 | small bolt
       25 | small bolt
       15 | large bolt
(3 rows)
```

#### Solution:

```sql
SELECT orders.quantity, products.name
  FROM orders
 INNER JOIN products ON products.id = orders.product_id;
```

---

5. Can you insert a row into `orders` without a `product_id`? Write a SQL statement to prove your answer.

#### Solution:

Based upon the current schema, it looks like a row *can* be inserted into `orders` without a `product_id` due to the `product_id` column missing a `NOT NULL` constraint. This can be tested with: `INSERT INTO orders (product_id, quantity) VALUES (NULL, 1);` This statement works.

---

6. Write a SQL statement that will prevent NULL values from being stored in `orders.product_id`. What happens if you execute that statement?

#### Solution:

```sql
ALTER TABLE orders
ALTER COLUMN product_id SET NOT NULL;
```

Executing this statement will cause an error due to the `orders` table currently containg a `NULL` value in the `product_id` column: `ERROR:  column "product_id" contains null values`

---

7. Make any changes needed to avoid the error message encountered in #6.

#### Solution:

```sql
DELETE FROM orders WHERE product_id IS NULL;

ALTER TABLE orders
ALTER COLUMN product_id SET NOT NULL;
```

---

8. Create a new table called `reviews` to store the data shown below. This table should include a primary key and a reference to the `products` table.

| Product 	  | Review                  |
|-------------|-------------------------|
| small bolt 	| a little small          |
| small bolt 	| very round!             |
| large bolt 	| could have been smaller |

#### Solution:

```sql
CREATE TABLE reviews (
  id serial PRIMARY KEY,
  product_id integer,
  review text,
  FOREIGN KEY (product_id) REFERENCES products (id);
);
```

#### Adjustments based on provided solution:

```sql
ALTER TABLE reviews
RENAME COLUMN review TO body;

ALTER TABLE reviews
ALTER COLUMN body SET NOT NULL;
```

---

9. Write SQL statements to insert the data shown in the table in #8.

#### Solution:

```sql
SELECT * FROM products;

INSERT INTO reviews (product_id, body) VALUES
  (1, 'a little small'),
  (1, 'very round!'),
  (2, 'could have been smaller');
```

---

10. **True** or **false**: A foreign key constraint prevents NULL values from being stored in a column.

#### Solution:

False: a foreign key constraint does NOT prevent NULL values from being stored in a column.
