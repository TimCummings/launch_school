
[comment]: # (one_to_many_relationships.md)

# One to Many Relationships - 3/23/2020

1. Write a SQL statement to add the following call data to the database:

| when                | duration | first_name  | last_name | number    |
|---------------------|----------|-------------|-----------|-----------|
| 2016-01-18 14:47:00 | 632      | William     | Swift     |7204890809 |

#### Solution:

```sql
SELECT * FROM contacts
 WHERE first_name = 'William'
   AND last_name = 'Swift'
   AND number = '7204890809';

INSERT INTO calls ("when", duration, contact_id) VALUES
  ('2016-01-18 14:47:00', 632, 6);
```

---

2. Write a SQL statement to retrieve the call times, duration, and first name for all calls **not** made to William Swift.

#### Solution:

```sql
SELECT * FROM contacts
 WHERE first_name = 'William'
   AND last_name = 'Swift';

SELECT "when", duration, first_name
  FROM calls
 INNER JOIN contacts ON contacts.id = calls.contact_id
 WHERE contacts.id != 6;
```

---

3. Write SQL statements to add the following call data to the database:

| when                | duration | first_name | last_name | number     |
|---------------------|----------|------------|-----------|------------|
| 2016-01-17 11:52:00 | 175      | Merve      | Elk       | 6343511126 |
| 2016-01-18 21:22:00 | 79       | Sawa       | Fyodorov  | 6125594874 |

#### Solution:

```sql
SELECT * FROM contacts
 WHERE (first_name = 'Merve' AND last_name = 'Elk')
    OR (first_name = 'Sawa' AND last_name = 'Fyodorov');

INSERT INTO contacts (first_name, last_name, number) VALUES
  ('Merve', 'Elk', '6343511126'),
  ('Sawa', 'Fyodorov', '6125594874');

SELECT * FROM contacts
 WHERE (first_name = 'Merve' AND last_name = 'Elk')
    OR (first_name = 'Sawa' AND last_name = 'Fyodorov');

INSERT INTO calls ("when", duration, contact_id) VALUES
  ('2016-01-17 11:52:00', 175, 26),
  ('2016-01-18 21:22:00', 175, 27);
```

---

4. Add a constraint to **contacts** that prevents a duplicate value being added in the column `number`.

#### Solution:

```sql
ALTER TABLE contacts
  ADD CONSTRAINT unique_number UNIQUE (number);
```

---

5. Write a SQL statement that attempts to insert a duplicate number for a new contact but fails. What error is shown?

#### Solution:

`INSERT INTO contacts (first_name, last_name, number) VALUES ('John', 'Smith', '6343511126');`

This statement results in:

```
ERROR: duplicate key value violates unique constraint "unique_number"
DETAIL: Key (number)=(6343511126) already exists.
```

---

6. Why does "when" need to be quoted in many of the queries in this lesson?

#### Solution:

`When` is a reserved keyword in PostgreSQL, meaning PostgreSQL recognizes `when` as a word with special meaning, not simply an identifier. In order to use `when` as an identifier, e.g. as a column name, it must double quoted: `"when"`. This signals PostgreSQL to treat `"when"` as an identifier.

#### Solution:

[ERD](erd.pdf)
