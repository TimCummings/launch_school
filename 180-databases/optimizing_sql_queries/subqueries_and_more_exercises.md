
[comment]: # (subqueries_and_more_exercises.md)

# Subqueries and More Exercises - 5/16/2020

1. Set Up Database using \copy

This set of exercises will focus on an auction. Create a new database called `auction`. In this database there will be three tables, `bidders`, `items`, and `bids`.

After creating the database, set up the 3 tables using the following specifications:

###### bidders

* `id` of type SERIAL: this should be a primary key
* `name` of type text: this should be `NOT NULL`

###### items

* `id` of type SERIAL: this should be a primary key
* `name` of type text: this should be `NOT NULL`
* `initial_price` and `sales_price`: These two columns should both be of type numeric. Each column should be able to hold a number as high as 1000 dollars with 2 decimal points of precision.
* The `initial_price` represents the starting price of an item when it is first put up for auction. This column should never be NULL.
* The `sales_price` represents the final price at which the item was sold. This column may be NULL, as it is possible to have an item that was never sold off.

###### bids

* `id` of type SERIAL: this should be a primary key
* `bidder_id`, `item_id`: These will be of type integer and should not be NULL. This table connects a bidder with an item and each row represents an individual bid. There should never be a column that has `bidder_id` or `item_id` unknown or NULL. Nor should there ever be a bid that references a nonexistent item or bidder. If the item or bidder associated with a bid is removed, that bid should also be removed from the database.
* Create your `bids` table so that both `bidder_id` and `item_id` together form a composite index for faster lookup.
* amount - The amount of money placed for each individual bid by a bidder. This column should be of the same type as `items.initial_price` and have the same constraints.

Finally, use the `\copy` meta-command to import the below files into your `auction` database. You'll have to create these files yourself before you can import them with `\copy`.

**bidders.csv**

```
id, name
1,Alison Walker
2,James Quinn
3,Taylor Williams
4,Alexis Jones
5,Gwen Miller
6,Alan Parker
7,Sam Carter
```

**items.csv**

```
id, name, initial_price, sales_price
1,Video Game, 39.99, 70.87
2,Outdoor Grill, 51.00, 83.25
3,Painting, 100.00, 250.00
4,Tent, 220.00, 300.00
5,Vase, 20.00, 42.00
6,Television, 550.00,
```

**bids.csv**

```
id, bidder_id, item_id, amount
1,1, 1, 40.00
2,3, 1, 52.00
3,1, 1, 53.00
4,3, 1, 70.87
5,5, 2, 83.25
6,2, 3, 110.00
7,4, 3, 140.00
8,2, 3, 150.00
9,6, 3, 175.00
10,4, 3, 185.00
11,2, 3, 200.00
12,6, 3, 225.00
13,4, 3, 250.00
14,1, 4, 222.00
15,2, 4, 262.00
16,1, 4, 290.00
17,1, 4, 300.00
18,2, 5, 21.72
19,6, 5, 23.00
20,2, 5, 25.00
21,6, 5, 30.00
22,2, 5, 32.00
23,6, 5, 33.00
24,2, 5, 38.00
25,6, 5, 40.00
26,2, 5, 42.00
```

### Approach/Algorithm

`psql` provides a useful command, `\copy` which allows you to import `csv` files. Read the [documentation](https://www.postgresql.org/docs/10/static/app-psql.html) for `\copy` before proceeding with this exercise. Notice that the data files are of type csv and they have headers. Keep this in mind when deciding how to write the `\copy` command.

#### Solution:

```
createdb auction
psql -d auction
```

```sql
CREATE TABLE bidders (
  id serial PRIMARY KEY,
  name text NOT NULL
);

CREATE TABLE items (
  id serial PRIMARY KEY,
  name text NOT NULL,
  initial_price numeric(6, 2) NOT NULL,
  sales_price numeric(6, 2)
);

CREATE TABLE bids (
  id serial PRIMARY KEY,
  bidder_id integer NOT NULL REFERENCES bidders(id) ON DELETE CASCADE,
  item_id integer NOT NULL REFERENCES items(id) ON DELETE CASCADE,
  amount numeric(6, 2) NOT NULL,
);

CREATE INDEX ON bids (bidder_id, item_id);

\copy bidders FROM bidders.csv WITH (FORMAT csv, HEADER)
\copy items FROM items.csv WITH (FORMAT csv, HEADER)
\copy bids FROM bids.csv WITH (FORMAT csv, HEADER)
```

#### Adjustments based on provided solution:

Use `CHECK` constraints to enforce price ranges:

```sql
ALTER TABLE items
ADD CHECK (initial_price BETWEEN 0.01 AND 1000.00),
ADD CHECK (sales_price BETWEEN 0.01 AND 1000.00);

ALTER TABLE bids
ADD CHECK (amount BETWEEN 0.01 AND 1000.00);
```

---

2. Write a SQL query that shows all items that have had bids put on them. Use the logical operator IN for this exercise, as well as a subquery.

Here is the expected output:

```
 Bid on Items
---------------
 Video Game
 Outdoor Grill
 Painting
 Tent
 Vase
(5 rows)
```

### Approach/Algorithm

This [assignment on subqueries](https://launchschool.com/lessons/e752508c/assignments/2009d549) should be of use for this exercise. This section on [subqueries](https://www.postgresql.org/docs/current/static/functions-subquery.html) in the PostgreSQL documentation should be helpful as well.

The output for this exercise should also have an alias in place for the column we need to select.

#### Solution:

```sql
SELECT name AS "Bid on Items"
  FROM items
 WHERE id IN
       (SELECT DISTINCT item_id
          FROM bids);
```

---

3. Conditional Subqueries: NOT IN

Write a SQL query that shows all items that have not had bids put on them. Use the logical operator `NOT IN` for this exercise, as well as a subquery.

Here is the expected output:

```
 Not Bid On
------------
 Television
(1 row)
```

### Approach/Algorithm

This [assignment on subqueries](https://launchschool.com/lessons/3e910d5f/assignments/d9754368) should be of use for this exercise. This section on [subqueries](https://www.postgresql.org/docs/current/static/functions-subquery.html) in the PostgreSQL documentation should be helpful as well.

The output for this exercise should also have an alias in place for the column we need to select.


#### Solution:

```sql
SELECT name AS "Not Bid On"
  FROM items
 WHERE id NOT IN
       (SELECT DISTINCT item_id
          FROM bids);
```

---

4. Conditional Subqueries: EXISTS

Write a `SELECT` query that returns a list of names of everyone who has bid in the auction. While it is possible (and perhaps easier) to do this with a `JOIN` clause, we're going to do things differently: use a subquery with the `EXISTS` clause instead. Here is the expected output:

```
      name
-----------------
 Alison Walker
 James Quinn
 Taylor Williams
 Alexis Jones
 Gwen Miller
 Alan Parker
(6 rows)
```

### Approach/Algorithm

This [assignment on subqueries](https://launchschool.com/lessons/e752508c/assignments/2009d549) should be of use for this exercise. This section on [subqueries](https://www.postgresql.org/docs/current/static/functions-subquery.html) in the PostgreSQL documentation should be helpful as well.

#### Solution:

```sql
SELECT name
  FROM bidders
 WHERE EXISTS
       (SELECT bidder_id
          FROM bids
         WHERE bidder_id = bidders.id);
```

#### Further Exploration

More often than not, we can get an equivalent result by using a `JOIN` clause, instead of a subquery. Can you figure out a `SELECT` query that uses a `JOIN` clause that returns the same output as our solution above?

#### FE Solution:

```sql
SELECT DISTINCT bidders.name
  FROM bidders
 INNER JOIN bids ON bidders.id = bids.bidder_id;
```

---

5. Query From a Virtual Table

For this exercise, we'll make a slight departure from *how* we've been using subqueries. We have so far used subqueries to filter our results using a WHERE clause. In this exercise, we will build that filtering into the table that we will query. Write an SQL query that finds the largest number of bids from an individual bidder.

For this exercise, you must use a subquery to generate a result table (or virtual table), and then query that table for the largest number of bids.

Your output should look like this:

```
  max
------
    9
(1 row)
```

### Approach/Algorithm

Here is the general form of syntax you'll want to use:

```sql
SELECT column_name FROM
  (SELECT column_name FROM a_table) AS alias_name
```

We can use a subquery within the `FROM` clause to generate a table, then use the outer `SELECT` to query data from that table.

We highly recommend that you first run the subquery by itself. That way, you will know what column names you can use in the outer `SELECT` statement and can ensure that the subquery will work as expected.

#### Solution:

```sql
SELECT max(count)
  FROM
       (SELECT count(id)
          FROM bids
         GROUP BY bidder_id)
    AS number_of_bids;

SELECT count(id)
  FROM bids
 GROUP BY bidder_id
 ORDER BY count(id) DESC
 LIMIT 1;
```

---

6. Scalar Subqueries

For this exercise, use a scalar subquery to determine the number of bids on each item. The entire query should return a table that has the `name` of each item along with the number of bids on an item.

Here is the expected output:

```
    name      | count
--------------+-------
Video Game    |     4
Outdoor Grill |     1
Painting      |     8
Tent          |     4
Vase          |     9
Television    |     0
(6 rows)
```

### Approach/Algorithm

Refer to the PostgreSQL documentation on [scalar subqueries](https://www.postgresql.org/docs/9.5/static/sql-expressions.html#SQL-SYNTAX-SCALAR-SUBQUERIES) to solve this exercise. Keep a few key facts in mind:

* You may reference columns within your subquery from the outer `SELECT` query. Those values will act as constants for the current subquery evaluation.
* A scalar subquery must only return one column and one row.

#### Solution:

```sql
SELECT items.name,
       (SELECT count(bids.item_id)
          FROM bids
         WHERE bids.item_id = items.id)
  FROM items;
```

### Further Exploration

If we wanted to get an equivalent result, without using a subquery, then we would have to use a `LEFT OUTER JOIN`. Can you come up with the equivalent query that uses a `JOIN` clause?

#### FE Solution:

```sql
SELECT name, count(item_id)
  FROM items
  LEFT OUTER JOIN bids ON items.id = item_id
 GROUP BY name;
```

---

7. Row Comparison

We want to check that a given item is in our database. There is one problem though: we have all of the data for the item, but we don't know the `id` number. Write an SQL query that will display the `id` for the item that matches all of the data that we know, but does not use the `AND` keyword. Here is the data we know:

`'Painting', 100.00, 250.00`

### Approach/Algorithm

The following links should be of use for solving this exercise:

* [Row Constructors](https://www.postgresql.org/docs/9.5/static/sql-expressions.html#SQL-SYNTAX-ROW-CONSTRUCTORS)
* [Row-wise Comparison](https://www.postgresql.org/docs/9.5/static/functions-comparisons.html#ROW-WISE-COMPARISON)

You don't need to use a subquery to solve this problem.

#### Solution:

```sql
SELECT id
  FROM items
 WHERE ROW('Painting', 100.00, 250.00) = ROW(name, initial_price, sales_price);
```

---

8. EXPLAIN

For this exercise, let's explore the `EXPLAIN` PostgreSQL statement. It's a very useful SQL statement that lets us analyze the efficiency of our SQL statements. More specifically, use `EXPLAIN` to check the efficiency of the query statement we used in the exercise on `EXISTS`:

```sql
SELECT name FROM bidders
WHERE EXISTS (SELECT 1 FROM bids WHERE bids.bidder_id = bidders.id);
```

First use just `EXPLAIN`, then include the `ANALYZE` option as well. For your answer, list any SQL statements you used, along with the output you get back, and your thoughts on what is happening in both cases.

### Approach/Algorithm

To solve this exercise, you can refer to [this assignment](https://launchschool.com/lessons/e752508c/assignments/87715c5f) on `EXPLAIN`, and also the [documentation](https://www.postgresql.org/docs/9.5/static/sql-explain.html) for the `EXPLAIN` statement. Note, that there is no `EXPLAIN` statement in the SQL standard, but it is implemented in other RDBMSs.

Also, keep in mind that when using `ANALYZE`, the sql statement gets executed. When not using `ANALYZE`, the SQL statement isn't executed. Be careful when using `EXPLAIN` on a SQL statement that alters data or database schema.

#### Solution:

```sql
EXPLAIN SELECT name FROM bidders
WHERE EXISTS (SELECT 1 FROM bids WHERE bids.bidder_id = bidders.id);
```

This statement produces the following output:

```sql
                                QUERY PLAN
--------------------------------------------------------------------------
 Hash Join  (cost=33.38..66.47 rows=635 width=32)
   Hash Cond: (bidders.id = bids.bidder_id)
   ->  Seq Scan on bidders  (cost=0.00..22.70 rows=1270 width=36)
   ->  Hash  (cost=30.88..30.88 rows=200 width=4)
         ->  HashAggregate  (cost=28.88..30.88 rows=200 width=4)
               Group Key: bids.bidder_id
               ->  Seq Scan on bids  (cost=0.00..25.10 rows=1510 width=4)
(7 rows)
```

```sql
EXPLAIN ANALYZE SELECT name FROM bidders
WHERE EXISTS (SELECT 1 FROM bids WHERE bids.bidder_id = bidders.id);
```

This statement produces the following output:

```sql
                                                    QUERY PLAN
---------------------------------------------------------------------------------------------------------------------
Hash Join  (cost=33.38..66.47 rows=635 width=32) (actual time=0.046..0.050 rows=6 loops=1)
  Hash Cond: (bidders.id = bids.bidder_id)
  ->  Seq Scan on bidders  (cost=0.00..22.70 rows=1270 width=36) (actual time=0.009..0.010 rows=7 loops=1)
  ->  Hash  (cost=30.88..30.88 rows=200 width=4) (actual time=0.027..0.027 rows=6 loops=1)
        Buckets: 1024  Batches: 1  Memory Usage: 9kB
        ->  HashAggregate  (cost=28.88..30.88 rows=200 width=4) (actual time=0.021..0.024 rows=6 loops=1)
              Group Key: bids.bidder_id
              ->  Seq Scan on bids  (cost=0.00..25.10 rows=1510 width=4) (actual time=0.005..0.009 rows=26 loops=1)
Planning Time: 0.134 ms
Execution Time: 0.096 ms
(10 rows)
```

The `EXPLAIN` statement is estimating the total cost of the query; `EXPLAIN ANALYZE` actually runs the query and tells us how long it took to run.

---

9. Comparing SQL Statements

In this exercise, we'll use `EXPLAIN ANALYZE` to compare the efficiency of two SQL statements. These two statements are actually from the "Query From a Virtual Table" exercise in this set. In that exercise, we stated that our subquery-based solution:

```sql
SELECT MAX(bid_counts.count) FROM
  (SELECT COUNT(bidder_id) FROM bids GROUP BY bidder_id) AS bid_counts;
```

was actually faster than the simpler equivalent without subqueries:

```sql
SELECT COUNT(bidder_id) AS max_bid FROM bids
  GROUP BY bidder_id
  ORDER BY max_bid DESC
  LIMIT 1;
```

In this exercise, we will demonstrate this fact.

Run `EXPLAIN ANALYZE` on the two statements above. Compare the planning time, execution time, and the total time required to run these two statements. Also compare the total "costs". Which statement is more efficient and why?

### Approach/Algorithm

These assignments and PostgreSQL documents should prove useful for this exercise:

* [Assignment on EXPLAIN](https://launchschool.com/lessons/e752508c/assignments/87715c5f)
* [Documentation on SELECT](https://www.postgresql.org/docs/current/static/sql-select.html)
* [Documentation about using EXPLAIN](https://www.postgresql.org/docs/9.6/static/using-explain.html)

#### Solution:

```sql
EXPLAIN ANALYZE SELECT MAX(bid_counts.count) FROM
  (SELECT COUNT(bidder_id) FROM bids GROUP BY bidder_id) AS bid_counts;

                                                  QUERY PLAN
---------------------------------------------------------------------------------------------------------------
 Aggregate  (cost=37.15..37.16 rows=1 width=8) (actual time=0.026..0.027 rows=1 loops=1)
   ->  HashAggregate  (cost=32.65..34.65 rows=200 width=12) (actual time=0.022..0.024 rows=6 loops=1)
         Group Key: bids.bidder_id
         ->  Seq Scan on bids  (cost=0.00..25.10 rows=1510 width=4) (actual time=0.007..0.010 rows=26 loops=1)
 Planning Time: 0.086 ms
 Execution Time: 0.074 ms
(6 rows)
```

```sql
EXPLAIN ANALYZE SELECT COUNT(bidder_id) AS max_bid FROM bids
  GROUP BY bidder_id
  ORDER BY max_bid DESC
  LIMIT 1;

                                                     QUERY PLAN
---------------------------------------------------------------------------------------------------------------------
 Limit  (cost=35.65..35.65 rows=1 width=12) (actual time=0.051..0.051 rows=1 loops=1)
   ->  Sort  (cost=35.65..36.15 rows=200 width=12) (actual time=0.050..0.050 rows=1 loops=1)
         Sort Key: (count(bidder_id)) DESC
         Sort Method: top-N heapsort  Memory: 25kB
         ->  HashAggregate  (cost=32.65..34.65 rows=200 width=12) (actual time=0.021..0.023 rows=6 loops=1)
               Group Key: bidder_id
               ->  Seq Scan on bids  (cost=0.00..25.10 rows=1510 width=4) (actual time=0.005..0.008 rows=26 loops=1)
 Planning Time: 0.507 ms
 Execution Time: 0.083 ms
```

|                | Subquery | No Subquery |
|----------------|----------|-------------|
| planning time  | 0.086ms  | 0.507ms     |
| execution time | 0.074ms  | 0.083ms     |
| total time     | 0.16ms   | 0.59ms      |
| cost           | 37.16    | 35.65       |

The subquery statement is more efficient in every metric but one, sometimes significantly. In `cost`, the subquery statement is more expensive, but only by 4%. As this cost is an arbitrary unit, the significantly faster time of the subquery statement makes it the preferable query. If we were in a situation in which we valued system resources over execution time, we at least have the knowledge to make an informed choice.

### Further Exploration

We mentioned earlier that using a scalar subquery was faster than using an equivalent `JOIN` clause. Determining that `JOIN` statement was part of the "Further Exploration" for that exercise. For this "Further Exploration", compare the times and costs of those two statements. The SQL statement that uses a scalar subquery is listed below.

Scalar Subquery:

```sql
SELECT name,
(SELECT COUNT(item_id) FROM bids WHERE item_id = items.id)
FROM items;
```

#### FE Solution:

```sql
EXPLAIN ANALYZE SELECT name,
(SELECT COUNT(item_id) FROM bids WHERE item_id = items.id)
FROM items;

                                                 QUERY PLAN
-------------------------------------------------------------------------------------------------------------
 Seq Scan on items  (cost=0.00..25455.20 rows=880 width=40) (actual time=0.018..0.043 rows=6 loops=1)
   SubPlan 1
     ->  Aggregate  (cost=28.89..28.91 rows=1 width=8) (actual time=0.005..0.005 rows=1 loops=6)
           ->  Seq Scan on bids  (cost=0.00..28.88 rows=8 width=4) (actual time=0.002..0.003 rows=4 loops=6)
                 Filter: (item_id = items.id)
                 Rows Removed by Filter: 22
 Planning Time: 0.075 ms
 Execution Time: 0.064 ms
(8 rows)
```

```sql
EXPLAIN ANALYZE SELECT name, count(item_id)
  FROM items
  LEFT OUTER JOIN bids ON items.id = item_id
 GROUP BY name;

                                                     QUERY PLAN
---------------------------------------------------------------------------------------------------------------------
 HashAggregate  (cost=66.44..68.44 rows=200 width=40) (actual time=0.047..0.049 rows=6 loops=1)
   Group Key: items.name
   ->  Hash Right Join  (cost=29.80..58.89 rows=1510 width=36) (actual time=0.026..0.037 rows=27 loops=1)
         Hash Cond: (bids.item_id = items.id)
         ->  Seq Scan on bids  (cost=0.00..25.10 rows=1510 width=4) (actual time=0.002..0.005 rows=26 loops=1)
         ->  Hash  (cost=18.80..18.80 rows=880 width=36) (actual time=0.012..0.012 rows=6 loops=1)
               Buckets: 1024  Batches: 1  Memory Usage: 9kB
               ->  Seq Scan on items  (cost=0.00..18.80 rows=880 width=36) (actual time=0.007..0.008 rows=6 loops=1)
 Planning Time: 0.086 ms
 Execution Time: 0.095 ms
(10 rows)

```

|                | Scalar  | JOIN    |
|----------------|---------|---------|
| planning time  | 0.075ms | 0.086ms |
| execution time | 0.064ms | 0.095ms |
| total time     | 0.139ms | 0.181ms |
| cost           | 25455.2 | 68.44   |

The scalar subquery query is significantly faster but also significantly costlier.
