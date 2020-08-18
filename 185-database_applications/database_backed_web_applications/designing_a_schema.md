
# Designing a Schema - 8/16/2020

We're going to need to design a database schema that will hold the data for our todo lists and items. The following tables describe the attributes of these entities that we'll need to store:

* List
  * Has a *unique* name
* Todo
  * Has a name
  * Belongs to a list
  * Can be completed, but should default to *not* being completed

We'll also want each table to have an `id` column so we can easily identify specific rows in it.

### Practice Problems

1. Write the SQL statements necessary to create a schema that will hold the data for lists and todos as described above. Include any constraints that are appropriate.

#### Solution

```sql
CREATE TABLE lists (
  id serial PRIMARY KEY,
  name text UNIQUE
);

CREATE TABLE todos (
  id serial PRIMARY KEY,
  name text,
  list_id int REFERENCES lists (id),
  completed boolean DEFAULT false
);
```

* It's appropriate for the `id` columns in both tables to have `NOT NULL`, `UNIQUE`, and `DEFAULT` constraints via `serial` and `PRIMARY KEY`.
* It's appropriate for `lists.name` to have a `UNIQUE` constraint as specified.
* It's appropriate for `todos.list_id` to have a `FOREIGN KEY` constraint to establish a relationship with `lists`.
* It's appropriate for `todos.completed` to have a `DEFAULT false` constraint so todos default to not being completed.

#### Adjustments based on provided solution

All fields should have `NOT NULL` constraints.

```sql
CREATE TABLE lists (
  id serial PRIMARY KEY,
  name text NOT NULL UNIQUE
);

CREATE TABLE todos (
  id serial PRIMARY KEY,
  name text NOT NULL,
  completed boolean NOT NULL DEFAULT false,
  list_id int NOT NULL REFERENCES lists (id)
);
```

---

2. Create a new file, `schema.sql`, in the project directory. Save the statements written in #1 in this file.

---

3. Create a new database for this project called `todos`. Execute the SQL file created in #2 in this database using `psql`.

#### Solution

```
createdb todos
psql -d todos < schema.sql
```
