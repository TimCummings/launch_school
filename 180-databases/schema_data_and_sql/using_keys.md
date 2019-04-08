
[comment]: # (using_keys.md)

# Using Keys - 3/4/2019

1. Write a SQL statement that makes a new sequence called "counter".

#### Solution:

```sql
CREATE SEQUENCE counter;
```

---

2. Write a SQL statement to retrieve the next value from the sequence created in #1.

#### Solution:

```sql
SELECT nextval('counter');
```

---

3. Write a SQL statement that removes a sequence called "counter".

#### Solution:

```sql
DROP SEQUENCE counter;
```

---

4. Is it possible to create a sequence that returns only even numbers? [The documentation for sequence might be useful](http://www.postgresql.org/docs/9.5/static/sql-createsequence.html).

#### Solution:

It looks like you can provide a `minvalue` and define `INCREMENT BY`; those two together should allow you to generate a sequence that returns on even numbers:

```sql
   CREATE SEQUENCE evens
INCREMENT BY 2
 MINVALUE 2;
```

---

5. What will the name of the sequence created by the following SQL statement be?

```sql
CREATE TABLE regions (id serial PRIMARY KEY, name text, area integer);
```

#### Solution:

`regions_id_seq`

---

6. Write a SQL statement to add an auto-incrementing integer primary key column to the `films` table.

#### Solution:

```sql
ALTER TABLE films
  ADD COLUMN id serial PRIMARY KEY;
```

---

7. What error do you receive if you attempt to update a row to have a value for `id` that is used by another row?

#### Solution:

```sql
UPDATE films
   SET id = 1 WHERE name = '1984';

ERROR:  duplicate key value violates unique constraint "films_pkey"
DETAIL:  Key (id)=(1) already exists.
```

---

8. What error do you receive if you attempt to add another primary key column to the `films` table?

#### Solution:

```sql
ALTER TABLE films
  ADD COLUMN id_2 serial PRIMARY KEY;

ERROR:  multiple primary keys for table "films" are not allowed
```

---

9. Write a SQL statement that modifies the table `films` to remove its primary key while preserving the `id` column and the values it contains.

#### Solution:

```sql
ALTER TABLE films
 DROP CONSTRAINT films_pkey;
```
