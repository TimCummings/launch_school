
[comment]: # (more_constraints.md)

# More Constraints - 3/4/2019

1. Import [this file](https://raw.githubusercontent.com/launchschool/sql_course_data/master/sql-and-relational-databases/schema-data-and-sql/more-constraints/films2.sql) into a PostgreSQL database.

#### Solution:

```
curl -O https://raw.githubusercontent.com/launchschool/sql_course_data/master/sql-and-relational-databases/schema-data-and-sql/more-constraints/films2.sql
psql -d sql_course < films2.sql
```

---

2. Modify all of the columns to be `NOT NULL`.

#### Solution:

```sql
ALTER TABLE films
ALTER COLUMN title SET NOT NULL,
ALTER COLUMN year SET NOT NULL,
ALTER COLUMN genre SET NOT NULL,
ALTER COLUMN director SET NOT NULL,
ALTER COLUMN duration SET NOT NULL;
```

---

3. How does modifying a column to be `NOT NULL` affect how it is displayed by `\d films`?

#### Solution:

Modifying a column to be `NOT NULL` results in the `Nullable` column of the output from `\d films` to be `not null` instead of being empty.

----

4. Add a constraint to the table **films** that ensures that all films have a unique title.

#### Solution:

```sql
ALTER TABLE films
  ADD CONSTRAINT unique_title UNIQUE (title);
```

#### Corrections based on provided solution:

Swap order of words in constraint name: `title_unique` instead of `unique_title`; correct with:

```sql
ALTER TABLE films
 DROP CONSTRAINT unique_title;

ALTER TAB films
  ADD CONSTRAINT title_unique UNIQUE (title);
```

---

5. How is the constraint added in #4 displayed by `\d films`?

#### Solution:

The `UNIQUE` constraint is displayed under the table output of `\d films` in an `Indexes:` section as `"title_unique" UNIQUE CONSTRAINT, btree (title)`

---

6. Write a SQL statement to remove the constraint added in #4.

#### Solution:

```sql
ALTER TABLE films
 DROP CONSTRAINT title_unique;
```

---

7. Add a constraint to **films** that requires all rows to have a value for `title` that is at least 1 character long.

#### Solution:

```sql
ALTER TABLE films
  ADD CONSTRAINT title_length CHECK (length(title) >= 1);
```

---

8. What error is shown if the constraint created in #7 is violated? Write a SQL `INSERT` statement that demonstrates this.

#### Solution:

```sql
INSERT INTO films
VALUES ('', 1990, 'action', 'Stanley Kubrick', 60);
```

The error shown for violating the `CHECK` constraint is:
```
ERROR:  new row for relation "films" violates check constraint "title_length"
DETAIL:  Failing row contains (, 2019, action, Stanley Kubrick, 60).
```

---

9. How is the constraint added in #7 displayed by `\d films`?

Similar to Indexes, the `CHECK` constraint is displayed below the table in a `Check constraints:` section as `"title_length" CHECK (length(title::text) >= 1)`

---

10. Write a SQL statement to remove the constraint added in #7.

#### Solution:

```sql
ALTER TABLE films
 DROP CONSTRAINT title_length;
```

---

11. Add a constraint to the table **films** that ensures that all films have a year between 1900 and 2100.

#### Solution:

```sql
ALTER TABLE films
  ADD CONSTRAINT year_range
      CHECK (year BETWEEN 1900 AND 2100);
```

---

12. How is the constraint added in #11 displayed by `\d films`?

#### Solution:

This is displayed like the previous `CHECK` constraint, beneath the table in a `Check constraints:` section as `"year_range" CHECK (year >= 1900 AND year <= 2100)`

---

13. Add a constraint to **films** that requires all rows to have a value for `director` that is at least 3 characters long and contains at least one space character (` `).

#### Solution:

```sql
ALTER TABLE films
  ADD CONSTRAINT director_length CHECK ((LENGTH(director) >= 3) AND director LIKE '% %')
```

---

14. How does the constraint created in #13 appear in `\d films`?

#### Solution:

This appears as another `CHECK` constraint: `"director_length" CHECK (length(director::text) >= 3 AND director::text ~~ '% %'::text)`

---

15. Write an `UPDATE` statement that attempts to change the director for "Die Hard" to "Johnny". Show the error that occurs when this statement is executed.

#### Solution:

```sql
UPDATE films
   SET director = 'Johnny' WHERE title = 'Die Hard';
```

```sql
ERROR:  new row for relation "films" violates check constraint "director_length"
DETAIL:  FAiling row contains (Die Hard, 1988, action, Johnny, 132).
```

---

16. List three ways to use the schema to restrict what values can be stored in a column.

#### Solution:

1. data type, e.g. `integer`, `varchar`
2. `NOT NULL` constraint
3. `CHECK` constraints

---

17. Is it possible to define a default value for a column that will be considered invalid by a constraint? Create a table that tests this.

```sql
CREATE TABLE default_constraint_test (
  id serial PRIMARY KEY,
  name varchar(50) CHECK (name LIKE '% %')
);
/* CREATE TABLE */

ALTER TABLE default_constraint_test
ALTER COLUMN name
  SET DEFAULT 'no_spaces';
/*
  ALTER TABLE
  this works - it created the table
*/

INSERT INTO default_constraint_test (name)
  VALUES ('this name has spaces');
/* INSERT 0 1 */

INSERT INTO default_constraint_test (name)
  VALUES ('this_name_has_no_spaces');
/*
  ERROR:  new row for relation "default_constraint_test" violates check constraint "default_constraint_test_name_check"
  DETAIL:  Failing row contains (2, this_name_has_no_spaces).
*/

INSERT INTO default_constraint_test (id)
  VALUES (2);
/*
  ERROR:  new row for relation "default_constraint_test" violates check constraint "default_constraint_test_name_check"
  DETAIL:  Failing row contains (2, no_spaces).
*/
```

It **is** possible to define a default value for a column that will be considered invalid by a constraint, but doing so will cause an error when trying to insert a row with the violating default value.

---

18. How can you see a list of all of the constraints on a table?

#### Solution:

Constraints will appear beneath the schema table in the output of `\d table_name`.
