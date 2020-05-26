
[comment]: # (converting_1m_to_mm.md)

# Convering a 1:M Relationship to a M:M Relationship - 4/25/2020

1. Import [this file](https://raw.githubusercontent.com/launchschool/sql_course_data/master/sql-and-relational-databases/relational-data-and-joins/converting-a-1m-relationship-to-a-mm-relationship/films7.sql) into a database using `psql`.

#### Solution:

```
curl -O https://raw.githubusercontent.com/launchschool/sql_course_data/master/sql-and-relational-databases/relational-data-and-joins/converting-a-1m-relationship-to-a-mm-relationship/films7.sql

createdb films
psql -d films < films7.sql
```

---

2. Write the SQL statement needed to create a join table that will allow a film to have multiple directors, and directors to have multiple films. Include an `id` column in this table, and add foreign key constraints to the other columns.

#### Solution:

```sql
CREATE TABLE films_directors (
  id serial PRIMARY KEY,
  film_id integer REFERENCES films(id),
  director_id integer REFERENCES directors(id)
);
```

#### Adjustments based on provided solution:

Join table names should be in alphabetical order:

```sql
ALTER TABLE films_directors
RENAME TO directors_films;
```

---

3. Write the SQL statements needed to insert data into the new join table to represent the existing one-to-many relationships.

#### Solution:

```sql
INSERT INTO directors_films (film_id, director_id) VALUES
  (1, 1),
  (2, 2),
  (3, 3),
  (4, 4),
  (5, 5),
  (6, 6),
  (7, 3),
  (8, 7),
  (9, 8),
  (10, 4);
```

---

4. Write a SQL statement to remove any unneeded columns from `films`.

#### Solution:

```sql
ALTER TABLE films
 DROP COLUMN director_id;
```

---

5. Write a SQL statement that will return the following result:

```
           title           |         name
---------------------------+----------------------
 12 Angry Men              | Sidney Lumet
 1984                      | Michael Anderson
 Casablanca                | Michael Curtiz
 Die Hard                  | John McTiernan
 Let the Right One In      | Michael Anderson
 The Birdcage              | Mike Nichols
 The Conversation          | Francis Ford Coppola
 The Godfather             | Francis Ford Coppola
 Tinker Tailor Soldier Spy | Tomas Alfredson
 Wayne's World             | Penelope Spheeris
(10 rows)
```

#### Solution:

```sql
SELECT films.title, directors.name
  FROM films
 INNER JOIN directors_films ON films.id = directors_films.film_id
 INNER JOIN directors ON directors.id = directors_films.director_id
 ORDER BY films.title;
```

---

6. Write SQL statements to insert data for the following films into the database:

| Film                   | Year | Genre   | Duration | Directors                      |
|------------------------|------|---------|----------|--------------------------------|
| Fargo                  | 1996 | comedy  | 98       | Joel Coen                      |
| No Country for Old Men | 2007 | western | 122      | Joel Coen, Ethan Coen          |
| Sin City               | 2005 | crime   | 124      | Frank Miller, Robert Rodriguez |
| Spy Kids               | 2001 | scifi   | 88       | Robert Rodriguez               |

#### Solution:

```sql
INSERT INTO films (title, year, genre, duration) VALUES
  ('Fargo', 1996, 'comedy', 98),
  ('No Country for Old Men', 2007, 'western', 122),
  ('Sin City', 2005, 'crime', 124),
  ('Spy Kids', 2001, 'scifi', 88);

INSERT INTO directors (name) VALUES
  ('Joel Coen'),
  ('Ethan Coen'),
  ('Frank Miller'),
  ('Robert Rodriguez');

INSERT INTO directors_films (film_id, director_id) VALUES
  (11, 9),
  (12, 9),
  (12, 10),
  (13, 11),
  (13, 12),
  (14, 12);
```

---

7. Write a SQL statement that determines how many films each director in the database has directed. Sort the results by number of films (greatest first) and then name (in alphabetical order). This should output:

```
       director       | films
----------------------+-------
 Francis Ford Coppola |     2
 Joel Coen            |     2
 Michael Anderson     |     2
 Robert Rodriguez     |     2
 Ethan Coen           |     1
 Frank Miller         |     1
 John McTiernan       |     1
 Michael Curtiz       |     1
 Mike Nichols         |     1
 Penelope Spheeris    |     1
 Sidney Lumet         |     1
 Tomas Alfredson      |     1
(12 rows)
```

#### Solution:

```sql
SELECT directors.name AS director, count(films.id) AS films FROM directors
 INNER JOIN directors_films ON directors.id = directors_films.director_id
 INNER JOIN films ON films.id = directors_films.film_id
 GROUP BY directors.name
 ORDER BY count(films.id) DESC, directors.name;
```

#### Adjustments based on provided solution:

Since we don't need specific data from the `films` table, only a count of films, the specified query can be performed with a single join instead of two. Also, we can save some typing by using our defined aliases in the `ORDER BY` clause:

```sql
SELECT directors.name AS director, count(directors_films.film_id) AS films FROM directors
 INNER JOIN directors_films ON directors.id = directors_films.director_id
 GROUP BY directors.name
 ORDER BY films DESC, director;
```
