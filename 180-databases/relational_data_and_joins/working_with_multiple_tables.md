
[comment]: # (working_with_multiple_tables.md)

# Working with Multiple Tables - 3/23/2020

1. Import [this file](https://raw.githubusercontent.com/launchschool/sql_course_data/master/sql-and-relational-databases/relational-data-and-joins/working-with-multiple-tables/theater_full.sql) into an empty PostgreSQL database. Note: the file contains a lot of data and may take a while to run; your terminal should return to the command prompt once the import is complete.

#### Solution:

```
createdb working_with_multiple_tables
curl -O https://raw.githubusercontent.com/launchschool/sql_course_data/master/sql-and-relational-databases/relational-data-and-joins/working-with-multiple-tables/theater_full.sql
psql -d working_with_multiple_tables < theater_full.sql
```

---

2. Write a query that determines how many tickets have been sold.

**Expected Output**

```sql
count
-------
3783
(1 row)
```

#### Solution:

`SELECT COUNT(*) FROM tickets;`

---

3. Write a query that determines how many different customers purchased tickets to at least one event.

**Expected Output**

```sql
  count
-------
  1652
(1 row)
```

#### Solution:

`SELECT COUNT(DISTINCT customer_id) FROM tickets;`

---

4. Write a query that determines what percentage of the customers in the database have purchased a ticket to one or more of the events.

**Expected Output**

```sql
  percent
----------
    16.52
(1 row)
```

#### Solution:

```sql
SELECT ROUND((COUNT(DISTINCT t.customer_id)::decimal / COUNT(c.*)* 100), 2) AS percent
  FROM customers AS c
  LEFT OUTER JOIN tickets AS t ON t.customer_id = c.id;
```

This doesn't match the expected output, but I couldn't figure out the difference.

#### Corrections based on provided solution:

I misunderstood left outer joins; I didn't realize they could duplicate rows from the left table, as long as there were multiple matches in the right table. To account for this, customer_id needs to be distinct:

```sql
SELECT COUNT(DISTINCT t.customer_id)::float / COUNT(DISTINCT c.id) * 100
    AS percent
  FROM customers AS c
  LEFT OUTER JOIN tickets AS t ON t.customer_id = c.id;
```

---

5. Write a query that returns the name of each event and how many tickets were sold for it, in order from most popular to least popular.

**Expected Output**

```sql
             name            | popularity
-----------------------------+------------
  A-Bomb                     |        555
  Captain Deadshot Wolf      |        541
  Illustrious Firestorm      |        521
  Siren I                    |        457
  Kool-Aid Man               |        439
  Green Husk Strange         |        414
  Ultra Archangel IX         |        359
  Red Hope Summers the Fated |        307
  Magnificent Stardust       |        134
  Red Magus                  |         56
(10 rows)
```

#### Solution:

```sql
SELECT e.name, COUNT(t.event_id) AS popularity
  FROM events AS e
  LEFT OUTER JOIN tickets AS t ON t.event_id = e.id
 GROUP BY e.name
 ORDER BY popularity DESC;
```

---

6. Write a query that returns the user id, email address, and number of events for all customers that have purchased tickets to three events.

**Expected Output**

```sql
  id   |                email                 | count
-------+--------------------------------------+-------
  141  | isac.hayes@herzog.net                |     3
  326  | tatum.mraz@schinner.org              |     3
  624  | adelbert.yost@kleinwisozk.io         |     3
  1719 | lionel.feeney@metzquitzon.biz        |     3
  2058 | angela.ruecker@reichert.co           |     3
  3173 | audra.moore@beierlowe.biz            |     3
  4365 | ephraim.rath@rosenbaum.org           |     3
  6193 | gennaro.rath@mcdermott.co            |     3
  7175 | yolanda.hintz@binskshlerin.com       |     3
  7344 | amaya.goldner@stoltenberg.org        |     3
  7975 | ellen.swaniawski@schultzemmerich.net |     3
  9978 | dayana.kessler@dickinson.io          |     3
(12 rows)
```

#### Solution: 

```sql
SELECT c.id, c.email, COUNT(DISTINCT t.event_id)
  FROM customers AS c
  JOIN tickets AS t ON t.customer_id = c.id
 GROUP BY c.id
HAVING COUNT(DISTINCT t.event_id) = 3;
```

---

7. Write a query to print out a report of all tickets purchased by the customer with the email address 'gennaro.rath@mcdermott.co'. The report should include the event name and starts_at and the seat's section name, row, and seat number.

**Expected Output**

```sql
        event        |      starts_at      |    section    | row | seat
 --------------------+---------------------+---------------+-----+------
  Kool-Aid Man       | 2016-06-14 20:00:00 | Lower Balcony | H   |   10
  Kool-Aid Man       | 2016-06-14 20:00:00 | Lower Balcony | H   |   11
  Green Husk Strange | 2016-02-28 18:00:00 | Orchestra     | O   |   14
  Green Husk Strange | 2016-02-28 18:00:00 | Orchestra     | O   |   15
  Green Husk Strange | 2016-02-28 18:00:00 | Orchestra     | O   |   16
  Ultra Archangel IX | 2016-05-23 18:00:00 | Upper Balcony | G   |    7
  Ultra Archangel IX | 2016-05-23 18:00:00 | Upper Balcony | G   |    8
(7 rows)
```

#### Solution:

```sql
SELECT e.name AS event, e.starts_at, sections.name AS section, seats.row,
       seats.number AS seat
  FROM customers AS c
  JOIN tickets AS t ON t.customer_id = c.id
  JOIN events AS e ON e.id = t.event_id
  JOIN seats ON seats.id = t.seat_id
  JOIN sections ON sections.id = seats.section_id
 WHERE c.email = 'gennaro.rath@mcdermott.co';
```
