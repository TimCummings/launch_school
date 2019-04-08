
[comment]: # (loading_database_dumps.md)

# Loading Database Dumps - Practice Problems - 3/2/2019

1. Load [films1.sql](./films1.sql) into your database.

```sql
\i ~/launch_school/180-databases/films1.sql
```

a. What does the file do?

The file creates a new table named `films` and performs three individual insertions into that table.

b. What is the output of the command? What does each line in this output mean?

```sql
psql:/Users/tjc/launch_school/180-databases/films1.sql:1: NOTICE:  table "films" does not exist, skipping DROP TABLE
/*
If there was already a `films` table, this command would delete it. But there isn't already a `films` table so the `DROP TABLE` command is skipped.
*/

CREATE TABLE /* a table was created */
INSERT 0 1   /* a row was inserted into a table */
INSERT 0 1   /* a row was inserted into a table */
INSERT 0 1   /* a row was inserted into a table */
```

c. Open up the file and look at its contents. What does the first line do?

The first line drops the public table `films` if it currently exists in the database.

---

2. Write a SQL statement that returns all rows in the **films** table.

#### Solution:

```sql
SELECT * FROM films;
``` 

---

3. Write a SQL statement that returns all rows in the **films** table with a title shorter than 12 letters.

#### Solution

```sql
SELECT * FROM films
 WHERE LENGTH(title) < 12;
```

---

4. Write the SQL statements needed to add two additional columns to the **films** table: `director`, which will hold a director's full name, and `duration`, which will hold the length of the film in minutes.

#### Solution:

```sql
ALTER TABLE films
 ADD COLUMN director varchar(50),
 ADD COLUMN duration integer;
```

---

5. Write SQL statements to update the existing rows in the database with values for the new columns:

| title            | director             | duration |
|------------------|----------------------|----------|
| Die Hard         | John McTiernan       | 132      |
| Casablanca       | Michael Curtiz       | 102      |
| The Conversation | Francis Ford Coppola | 113      |

#### Solution:

```sql
UPDATE films
   SET director = 'John McTiernan',
       duration = 132
 WHERE title = 'Die Hard';

UPDATE films
   SET director = 'Michael Curtiz',
       duration = 102
 WHERE title = 'Casablanca';

UPDATE films
   SET director = 'Francis Ford Coppola'
       duration = 113
 WHERE title = 'The Conversation';
```

---

6. Write SQL statements to insert the following data into the films table:

| title                     | year | genre     | director         | duration |
|---------------------------|------|-----------|------------------|----------|
| 1984                      | 1956 | scifi     | Michael Anderson | 90       |
| Tinker Tailor Soldier Spy | 2011 | espionage | Tomas Alfredson  | 127      |
| The Birdcage              | 1996 | comedy    | Mike Nichols     | 118      |

#### Solution:

```sql
INSERT INTO films
VALUES ('1984', 1956, 'scifi', 'Michael Anderson', 90),
       ('Tinker Tailor Soldier Spy', 2011, 'espionage', 'Tomas Alfredson', 127),
       ('The Birdcage', 1996, 'comedy', 'Mike Nichols', 118);
```

---

7. Write a SQL statement that will return the title and age in years of each movie, with newest movies listed first:

#### Solution:

```sql
SELECT title,
       (2019 - "year") AS "age in years"
  FROM films
 ORDER BY "age in years";
```

---

8. Write a SQL statement that will return the title and duration of each movie longer than two hours, with the longest movies first.

#### Solution:

```sql
SELECT title, duration
  FROM films
 WHERE duration > (2 * 60)
 ORDER BY duration DESC;
```

---

9. Write a SQL statement that returns the title of the longest film.

#### Solution:

```sql
SELECT title FROM films
 ORDER BY duration DESC
 LIMIT 1;
```
