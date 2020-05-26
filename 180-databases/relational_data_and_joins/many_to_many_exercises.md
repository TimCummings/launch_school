
[comment]: # (many_to_many_exercises.md)

# Many to Many Exercises - 4/28/2020

1. Set Up Database

In this set of exercises, we will work with a billing database for a company that provides web hosting services to its customers. The database will contain information about its customers and the services each customer uses. Each customer can have any number of services, and every service can have any number of customers. Thus, there will be a many-to-many (M:M) relationship between the customers and the services. Some customers don't presently have any services, and not every service must be in use by any customers.

Initially, we need to create a billing database with a `customers` table and a `services` table. The `customers` table should include the following columns:

* `id` is a unique numeric customer id that auto-increments and serves as a primary key for this table.
* `name` is the customer's name. This value must be present in every record and may contain names of any length.
* `payment_token` is an 8-character string that consists of solely uppercase alphabetic letters. It identifies each customer's payment information with the payment processor the company uses.

The `services` table should include the following columns:

* `id` is a unique numeric service id that auto-increments and serves as a primary key for this table.
* `description` is the service description. This value must be present and may contain any text.
* `price` is the annual service price. It must be present, must be greater than or equal to `0.00`. The data type is `numeric(10, 2)`.

Once you've created these tables, here is some data that you can enter into them (feel free to enter some data of your own as well):

```
-- Data for the customers table

id | name          | payment_token
--------------------------------
1  | Pat Johnson   | XHGOAHEQ
2  | Nancy Monreal | JKWQPJKL
3  | Lynn Blake    | KLZXWEEE
4  | Chen Ke-Hua   | KWETYCVX
5  | Scott Lakso   | UUEAPQPS
6  | Jim Pornot    | XKJEYAZA
```

```
-- Data for the services table

id | description         | price
---------------------------------
1  | Unix Hosting        | 5.95
2  | DNS                 | 4.95
3  | Whois Registration  | 1.95
4  | High Bandwidth      | 15.00
5  | Business Support    | 250.00
6  | Dedicated Hosting   | 50.00
7  | Bulk Email          | 250.00
8  | One-to-one Training | 999.00
```

Once you have entered the data into your tables, create a join table that associates customers with services and vice versa. The join table should have columns for both the services id and the customers id, as well as a primary key named `id` that auto-increments.

Enter some data in the join table that shows which services each customer uses as follows:

* Pat Johnson uses Unix Hosting, DNS, and Whois Registration
* Nancy Monreal doesn't have any active services
* Lynn Blake uses Unix Hosting, DNS, Whois Registration, High Bandwidth, and Business Support
* Chen Ke-Hua uses Unix Hosting and High Bandwidth
* Scott Lakso uses Unix Hosting, DNS, and Dedicated Hosting
* Jim Pornot uses Unix Hosting, Dedicated Hosting, and Bulk Email

The customer id in this table should have the property that deleting the corresponding customer record from the `customers` table will automatically delete all rows from the join table that have that customer_id. Do **not** apply this same property to the service id.

#### Solution:

In terminal:

```
createdb billing
psql -d billing
```

```sql
CREATE TABLE customers (
  id serial PRIMARY KEY,
  name text NOT NULL,
  payment_token char(8) CHECK (payment_token SIMILAR TO '[A-Z]+')
);

CREATE TABLE services (
  id serial PRIMARY KEY,
  description text NOT NULL,
  price numeric(10, 2) NOT NULL CHECK (price >= 0.00)
);

INSERT INTO customers (name, payment_token) VALUES
  ('Pat Johnson', 'XHGOAHEQ'),
  ('Nancy Monreal', 'JKWQPJKL'),
  ('Lynn Blake', 'KLZXWEEE'),
  ('Chen Ke-Hua', 'KWETYCVX'),
  ('Scott Lakso', 'UUEAPQPS'),
  ('Jim Pornot', 'XKJEYAZA');

INSERT INTO services (description, price) VALUES
  ('Unix Hosting', 5.95),
  ('DNS', 4.95),
  ('Whois Registration', 1.95),
  ('High Bandwidth', 15.00),
  ('Business Support', 250.00),
  ('Dedicated Hosting', 50.00),
  ('Bulk Email', 250.00),
  ('One-to-one Training', 999.00);

CREATE TABLE customers_services (
  id serial PRIMARY KEY,
  customer_id integer NOT NULL REFERENCES customers(id) ON DELETE CASCADE,
  service_id integer NOT NULL REFERENCES services(id)
);

INSERT INTO customers_services (customer_id, service_id) VALUES
  (1, 1),
  (1, 2),
  (1, 3),
  (3, 1),
  (3, 2),
  (3, 3),
  (3, 4),
  (3, 5),
  (4, 1),
  (4, 4),
  (5, 1),
  (5, 2),
  (5, 6),
  (6, 1),
  (6, 6),
  (6, 7);
```

#### Adjustments based on provided solution:

My `SIMILAR TO` check on the `customers` table is not sufficient; it won't guard against uppercase alphabetical strings with fewer than eight characters.

```sql
ALTER TABLE customers
 DROP CONSTRAINT customers_payment_token_check;

ALTER TABLE customers
  ADD CHECK (payment_token SIMILAR TO '[A-Z]{8}');
```

`customers.payment_token` should be unique. This was not explicitly stated in the table's specification but was implied by the nature of the column. It should also not be null.

```sql
ALTER TABLE customers
  ADD CONSTRAINT unique_payment_token UNIQUE (payment_token),
ALTER COLUMN payment_token SET NOT NULL;
```

The `customers_services` join table should have a combined unique coinstraint on the foreign key columns `customer_id` and `service_id`.

```sql
ALTER TABLE customers_services
  ADD UNIQUE (customer_id, service_id);
```

---

2. Get Customers With Services

Write a query to retrieve the `customer` data for every customer who currently subscribes to at least one service.

#### Solution:

```sql
SELECT * FROM customers
 WHERE customers.id IN
       (SELECT DISTINCT customer_id
          FROM customers_services)
 ORDER BY customers.id;

SELECT DISTINCT * FROM customers
INNER JOIN customers_services
        ON customer_id = customers.id;
```

---

3. Get Customers With No Services

Write a query to retrieve the `customer` data for every customer who does not currently subscribe to any services.

#### Solution:

```sql
SELECT customers.* FROM customers
  LEFT OUTER JOIN customers_services ON customers.id = customers_services.customer_id
 WHERE customers_services.id IS NULL;
```

#### Further Exploration

Can you write a query that displays all customers with no services and all services that currently don't have any customers? The output should look like this:

```
 id |     name      | payment_token | id |     description     | price
----+---------------+---------------+----+---------------------+--------
  2 | Nancy Monreal | JKWQPJKL      |    |                     |
    |               |               |  8 | One-to-one Training | 999.00
(2 rows)
```

#### FE Solution:

```sql
SELECT customers.*, services.* FROM customers
  FULL OUTER JOIN customers_services ON customers.id = customers_services.customer_id
  FULL OUTER JOIN services ON services.id = customers_services.service_id
 WHERE customers_services.id IS NULL
 ORDER BY customers.id;
```

---

4. Get Services With No Customers

Using RIGHT OUTER JOIN, write a query to display a list of all services that are not currently in use. Your output should look like this:

```
 description
-------------
 One-to-one Training
(1 row)
```

#### Solution:

```sql
SELECT services.description FROM customers_services
 RIGHT OUTER JOIN services on services.id = customers_services.service_id
 WHERE customers_services.customer_id IS NULL;
```

---

5. Services for each Customer

Write a query to display a list of all customer names together with a comma-separated list of the services they use. Your output should look like this:

```sql
     name      |                                services
---------------+-------------------------------------------------------------------------
 Pat Johnson   | Unix Hosting, DNS, Whois Registration
 Nancy Monreal |
 Lynn Blake    | DNS, Whois Registration, High Bandwidth, Business Support, Unix Hosting
 Chen Ke-Hua   | High Bandwidth, Unix Hosting
 Scott Lakso   | DNS, Dedicated Hosting, Unix Hosting
 Jim Pornot    | Unix Hosting, Dedicated Hosting, Bulk Email
(6 rows)
```

#### Solution:

```sql
SELECT customers.name, string_agg(services.description, ', ') AS services
  FROM customers
  LEFT OUTER JOIN customers_services ON customers.id = customers_services.customer_id
  LEFT OUTER JOIN services ON services.id = customers_services.service_id
 GROUP BY customers.name;
```

#### Further Exploration

Can you modify the above command so the output looks like this?

```
     name      |    description
---------------+--------------------
 Chen Ke-Hua   | High Bandwidth
               | Unix Hosting
 Jim Pornot    | Dedicated Hosting
               | Unix Hosting
               | Bulk Email
 Lynn Blake    | Whois Registration
               | High Bandwidth
               | Business Support
               | DNS
               | Unix Hosting
 Nancy Monreal |
 Pat Johnson   | Whois Registration
               | DNS
               | Unix Hosting
 Scott Lakso   | DNS
               | Dedicated Hosting
               | Unix Hosting
(17 rows)
```

This won't be easy! Hint: you will need to use the [window lag function](https://www.postgresql.org/docs/9.5/static/functions-window.html) together with a [CASE condition](https://www.postgresql.org/docs/9.5/static/functions-conditional.html) in your `SELECT`. To get you started, try this command:

```sql
SELECT customers.name,
       lag(customers.name)
         OVER (ORDER BY customers.name)
         AS previous,
       services.description
FROM customers
LEFT OUTER JOIN customers_services
             ON customer_id = customers.id
LEFT OUTER JOIN services
             ON services.id = service_id;
```

Examine the relationship between the `previous` column and the rest of the table to get a handle on what `lag` does.

#### FE Solution:

```sql
SELECT CASE
       WHEN name = lag(name) OVER (ORDER BY name) THEN NULL
       ELSE name
       END,
       description
  FROM customers
  LEFT OUTER JOIN customers_services ON customers.id = customer_id
  LEFT OUTER JOIN services ON services.id = service_id;
```

---

6. Services With At Least 3 Customers

Write a query that displays the description for every service that is subscribed to by at least 3 customers. Include the customer count for each description in the report. The report should look like this:

```
 description  | count
--------------+-------
 DNS          |     3
 Unix Hosting |     5
(2 rows)
```

#### Solution:

```sql
SELECT description, COUNT(customer_id)
  FROM services
 INNER JOIN customers_services ON services.id = service_id
 GROUP BY description
HAVING COUNT(customer_id) >= 3
 ORDER BY description;
```

---

7. Total Gross Income

Assuming that everybody in our database has a bill coming due, and that all of them will pay on time, write a query to compute the total gross income we expect to receive.

Answer:

```
  gross
 --------
 678.50
(1 row)
```

#### Solution:

```sql
SELECT SUM(price) AS gross
  FROM services
 INNER JOIN customers_services ON services.id = service_id;
```

---

8. Add New Customer

A new customer, 'John Doe', has signed up with our company. His payment token is 'EYODHLCN'. Initially, he has signed up for UNIX hosting, DNS, and Whois Registration. Create any SQL statement(s) needed to add this record to the database.


#### Solution:

```sql
INSERT INTO customers (name, payment_token) VALUES
  ('John Doe', 'EYODHLCN');

SELECT * FROM customers
 WHERE name = 'John Doe';

INSERT INTO customers_services (customer_id, service_id) VALUES
  (7, 1),
  (7, 2),
  (7, 3);
```

---

9. Hypothetically

The company president is looking to increase revenue. As a prelude to his decision making, he asks for two numbers: the amount of expected income from "big ticket" services (those services that cost more than $100) and the maximum income the company could achieve if it managed to convince all of its customers to select all of the company's big ticket items.

For simplicity, your solution should involve two separate SQL queries: one that reports the current expected income level, and one that reports the hypothetical maximum. The outputs should look like this:

```
 sum
--------
 500.00
(1 row)
```

```
   sum
---------
 10493.00
(1 row)
```

#### Solution:

```sql
-- current expected "big ticket" income
SELECT SUM(price)
  FROM services
 INNER JOIN customers_services ON services.id = service_id
 WHERE price > 100.00;

-- hypothetical maximum "big ticket" income
SELECT SUM(price)
  FROM customers
 CROSS JOIN services
 WHERE price > 100.00;
```

#### Further Exploration

This exercise is really contrived: it just shows how hard it is to come up with a possible use case for `CROSS JOIN`. `CROSS JOIN` is generally best suited to generating test data rather than production queries.

Can you think of any other situations where a `CROSS JOIN` might be useful?

#### FE Solution:

I've seen `CROSS JOIN` used for scoring and matching algorithms such as [Jaro-Winkler](https://en.wikipedia.org/wiki/Jaro%E2%80%93Winkler_distance). For example, assume you have a set of `n` records and a matching set of `n` files (which are supposed to be similarly named). Your task is to link each file with its matching record. To do so:
1. `CROSS JOIN` record names and file names, computing a matching score (such as Jaro-Winkler) for each possible match.
2. Sort the list of scores from best match to worst.
3. Link the record and file with the best score.
4. Remove all other scores computed from that record or file.
5. Repeat steps 3 and 4 until everything is matched.

---

10. Deleting Rows

Write the necessary SQL statements to delete the "Bulk Email" service and customer "Chen Ke-Hua" from the database.

#### Solution:

For the customer "Chen Ke-Hua", we don't have to worry about removing associated join table records first, since the `customers_services.customer_id` foreign key has `ON DELETE CASCADE`.

```sql
DELETE FROM customers
 WHERE name = 'Chen Ke-Hua';
```

However, for the "Bulk Email" service, `ON DELETE CASCADE` is not set, so associated join table records must first be deleted.

```sql
DELETE FROM services
 WHERE description = 'Bulk Email';
-- ERROR:  update or delete on table "services" violates foreign key constraint "customers_services_service_id_fkey" on table "customers_services"
-- DETAIL:  Key (id)=(7) is still referenced from table "customers_services".

DELETE FROM customers_services
 WHERE service_id = 7;

DELETE FROM services
 WHERE description = 'Bulk Email';
```
