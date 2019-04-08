
[comment]: # (more_single_table_queries.md)

# More Single Table Queries - Practice Problems - 3/2/2019

1. Create a new database called `residents` using the PostgreSQL command line tools.

`createdb residents`

---

2. Load [residents_with_data.sql](residents_with_data.sql) into the database created in #1.

```
curl -O https://raw.githubusercontent.com/launchschool/sql_course_data/master/sql-and-relational-databases/schema-data-and-sql/more-single-table-queries/residents_with_data.sql

psql -d residents < residents_with_data.sql
```

---

3. Write a SQL query to list the ten states with the most rows in the `people` table in descending order.

#### Solution:

```sql
SELECT state, count(id)
  FROM people
 GROUP BY state
 ORDER BY count(id) DESC
 LIMIT 10;
```

---

4. Write a SQL query that lists each domain used in an email address in the `people` table and how many people in the database have an email address containing that domain. Domains should be listed with the most popular first.

#### Solution:

```sql
SELECT substring(email from position('@' in email)) AS domain,
       count(id)
  FROM people
 GROUP BY domain
 ORDER BY count(id) DESC;
```

#### Correction based on provided solution:

The domain is not supposed to include the @. Remove it by incrementing position by 1; `substr` and `strpos` save a little space:

```sql
SELECT substr(email, strpos(email, '@') + 1) AS domain,
       count(id)
  FROM people
 GROUP BY domain
 ORDER BY count(id) DESC;
```

---

5. Write a SQL statement that will delete the person with ID `3399` from the `people` table.

#### Solution:

```sql
/* verify what we're deleting first */
SELECT * FROM people WHERE id = 3399;

DELETE FROM people WHERE id = 3399;
```

---

6. Write a SQL statement that will delete all users that are located in the state of California (`CA`).

#### Solution:

```sql
/* verify what we're deleting first */
SELECT COUNT(id) FROM people WHERE state LIKE 'CA';

DELETE FROM people WHERE state LIKE 'CA';
```

---

7. Write a SQL statement that will update the `given_name` values to be all uppercase for all users with an email address that contains `teleworm.us`.

#### Solution:

```sql
/* verify what we're changing first */
SELECT COUNT(id) FROM people WHERE email LIKE '%@teleworm.us';


UPDATE people
   SET given_name = UPPER(given_name)
 WHERE email LIKE '%@teleworm.us';
```

---

8. Write a SQL statement that will delete all rows from the `people` table.

#### Solution:

```sql
DELETE FROM people;
```
