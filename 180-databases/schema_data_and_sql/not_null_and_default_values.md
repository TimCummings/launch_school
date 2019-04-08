
[comment]: # (not_null_and_default_values.md)

# NOT NULL and Default Values - Practice Problems - 3/2/2019

1. What is the result of using an operator on a `NULL` value?

#### Solution:

Using an operator on a `NULL` value results in `NULL`.

---

2. Set the default value of column `department` to "unassigned". Then set the value of the `department` column to "unassigned" for any rows where it has a `NULL` value. Finally, add a `NOT NULL` constraint to the `department` column.

#### Solution:

```sql
ALTER TABLE employees
ALTER COLUMN department
  SET DEFAULT 'unassigned';

UPDATE employees
   SET department = 'unassigned'
 WHERE department IS NULL;

ALTER TABLE employees
ALTER COLUMN department
  SET NOT NULL;
```

---

3. Write the SQL statement to create a table called **temperatures** to hold the following data:

| date       | low | high |
|------------|-----|------|
| 2016-03-01 | 34  | 43   |
| 2016-03-02 | 32  | 44   |
| 2016-03-03 | 31  | 47   |
| 2016-03-04 | 33  | 42   |
| 2016-03-05 | 39  | 46   |
| 2016-03-06 | 32  | 43   |
| 2016-03-07 | 29  | 32   |
| 2016-03-08 | 23  | 31   |
| 2016-03-09 | 17  | 28   |

Keep in mind that all rows in the table should always contain all three values.

#### Solution:

```sql
CREATE TABLE temperatures (
  "date" date NOT NULL,
  low integer NOT NULL,
  high integer NOT NULL
);
```

---

4. Write the SQL statements needed to insert the data shown in #3 into the **temperatures** table.

#### Solution:

```sql
INSERT INTO temperatures
VALUES ('2016-03-01', 34, 43),
       ('2016-03-02', 32, 44),
       ('2016-03-03', 31, 47),
       ('2016-03-04', 33, 42),
       ('2016-03-05', 39, 46),
       ('2016-03-06', 32, 43),
       ('2016-03-07', 29, 32),
       ('2016-03-08', 23, 31),
       ('2016-03-09', 17, 28);
```

---

5. Write a SQL statement to determine the average (mean) temperature for the days from March 2, 2016 through March 8, 2016. Make sure that average values are decimals rounded to one decimal place.

#### Solution:

```sql
SELECT date, ((low::numeric + high::numeric) / 2)::numeric(3,1)
  FROM temperatures
 WHERE date BETWEEN '2016-03-02' AND '2016-03-08';
```

---

6. Write a SQL statement to add a new column, `rainfall`, to the **temperatures** table. It should store millimeters of rain as integers and have a default value of `0`.

#### Solution:

```sql
UPDATE TABLE temperatures
   ADD COLUMN rainfall integer DEFAULT 0;
```

---

7. Each day, it rains one millimeter for every degree the average temperature goes above 35. Write a SQL statement to update the data in the table **temperatures** to reflect this.

#### Solution:

```sql
UPDATE temperatures
   SET rainfall = ((low + high) / 2) - 35
 WHERE (low + high) / 2 > 35;
```

---

8. A decision has been made to store rainfall data in inches. Write the SQL statements required to modify the rainfall column to reflect these new requirements.

#### Solution:

```sql
ALTER TABLE temperatures
ALTER COLUMN rainfall
 TYPE decimal(4,3);

UPDATE temperatures
   SET rainfall = rainfall * 0.0393701;
```

---

9. Write a SQL statement that renames the **temperatures** table to **weather**.

#### Solution:

```sql
ALTER TABLE temperatures
RENAME TO weather;
```

---

10. What `psql` meta command shows the structure of a table? Use it to describe the structure of **weather**.

#### Solution:

The `\d` `psql` command, when provided the name of a table, will show that table's schema.

```sql
\d weather
```

---

11. What PostgreSQL program can be used to create a SQL file that contains the SQL commands needed to recreate the current structure and data of the **weather** table?

#### Solution:

The `pg_dump` program will generate a file containing SQL commands that can recreate the schema and data of a database at the time of the dump. It can specify a table as such:

```
pg_dump sql_course -t weather > weather_dump.sql
```

#### Corrections based on provided solution:

```
pg_dump -d sql_course -t weather --inserts > weather_dump.sql
```

The `--inserts` flag will use `INSERT` statements in the dump instead of copying from `stdin`, although copying from `stdin` may be more efficient for larger datasets.
