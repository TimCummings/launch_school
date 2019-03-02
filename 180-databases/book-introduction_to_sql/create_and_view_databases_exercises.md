
[comment]: # (create_and_view_databases_exercises.md)

# Create and View Databases - Exercises - 2/1/2019

1. From the Terminal, create a database called `database_one`.

#### Solution:

`createdb database_one`

---

2. From the Terminal, connect via the psql console to the database that you created in the previous question.

#### Solution:

`psql -d database_one`

---

3. From the psql console, create a database called `database_two`.

#### Solution:

`CREATE DATABASE database_two;`

---

4. From the psql console, connect to `database_two`.

#### Solution:

`\c database_two`

---

5. Display all of the databases that currently exist.

#### Solution:

`\l`

---

6. From the psql console, delete `database_two`.

#### Solution:

```sql
\c database_one;
DROP DATABASE database_two;
```

---

7. From the Terminal, delete the `database_one` and `ls_burger` databases.

#### Solution:

```
\q

dropdb database_one
dropdb ls_burger
```
