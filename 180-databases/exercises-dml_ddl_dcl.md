


# DML, DDL, and DCL (2/14/2019)

1. Other than DCL, name and define the remaining two SQL sublanguages and give at least two examples of each.

#### Solution

DDL: Data Definition Language - used to define the schema (structure) of a database and the tables and columns within it.

```sql
CREATE TABLE animals(
  id serial PRIMARY KEY,
  name varchar(30),
  family varchar(30)
);
```

```sql
ALTER TABLE animals
ALTER COLUMN name SET NOT NULL;
```

DML: Data Manipulation Language - used to retrieve or modify data stored in a relational database.

```sql
INSERT INTO animals (name, family)
  VALUES ('dog', 'Canidae'),
         ('cat', 'Felidae');
```

```sql
SELECT * FROM animals;
```

```sql
UPDATE animals
  SET name = 'wolf'
  WHERE name = 'dog';
```

---

2. Does the following statemnet use DDL or DML? `SELECT column_name FROM my_table;`

#### Solution

DML

---

3. Does the following statement use DDL or DML?

```sql
CREATE TABLE things (
  id serial PRIMARY KEY,
  item text NOT NULL UNIQUE,
  material text NOT NULL
);
```

#### Solution

DDL

---

4. Does the following statement use DDL or DML?

```sql
ALTER TABLE things
DROP CONSTRAINT things_item_key;
```

#### Solution

DDL

---

5. Does the following statement use DDL or DML? `INSERT INTO things VALUES (3, 'Scissors', 'Metal');`

#### Solution

DML

---

6. Does the following statement use DDL or DML?

```sql
UPDATE things
SET material = 'plastic'
WHERE item = 'cup';
```

#### Solution

DML

---

7. Does the following statement use DDL, DML, or DCL? `\d things`

#### Solution

None of the above. That is a psql console command.

---

8. Does the following statement use DDL or DML? `DELETE FROM things WHERE item = 'Cup';`

#### Solution

DML

---

9. Does the following statement use DDL or DML? `DROP DATABASE xyzzy;`

#### Solution

DDL

#### Corrections from provided solution

`DROP DATABASE` is ambiguous: it's arguably both DDL and DML since it removes all data from the specified database and also deletes everything about the structure of the database. `DROP` statements of all kinds are generally considered DDL.

---

10. Does the following statement use DDL or DML? `CREATE SEQUENCE part_number_sequence;`

#### Solution

I will argue that this statement uses both DDL and DML, since it (per the psql documentation) creates a new special single-row table, and populates it with data.

#### Corrections from povided solution

My answer is acknowledged, but the solution also mentions that all `CREATE` statements are generally considered DDL.
