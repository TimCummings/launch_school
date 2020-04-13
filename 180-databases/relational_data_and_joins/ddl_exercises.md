
[comment]: # (ddl_exercises.md)

# DDL Exercises - 3/30/2020

### 1. Create an Extrasolar Planetary Database

For this exercise set, we will be working with the DDL statements to create and modify tables in a database that tracks planets around stars other than our Sun. To get started, first create a postgresql database named "extrasolar", and then create two tables in the database as follows:

`stars` table

* `id`: a unique serial number that auto-increments and serves as a primary key for this table.
* `name`: the name of the star,e,g., "Alpha Centauri A". Allow room for 25 characters. Must be unique and non-null.
* `distance`: the distance in light years from Earth. Define this as a whole number (e.g., 1, 2, 3, etc) that must be non-null and greater than 0.
* `spectral_type`: the spectral type of the star: O, B, A, F, G, K, and M. Use a one character string.
* `companions`: how many companion stars does the star have? A whole number will do. Must be non-null and non-negative.

`planets` table

* `id`: a unique serial number that auto-increments and serves as a primary key for this table.
* `designation`: a single alphabetic character that uniquely identifies the planet in its star system ('a', 'b', 'c', etc.)
* `mass`: estimated mass in terms of Jupiter masses; use an integer for this value.

#### Solution:

Create the database: `createdb extrasolar`.

Connect to it: `psql -d extrasolar`.

```sql
-- create stars table
CREATE TABLE stars (
  id serial PRIMARY KEY,
  name varchar(25) UNIQUE NOT NULL,
  distance integer NOT NULL CHECK (distance > 0),
  spectral_type char(1),
  companions integer NOT NULL CHECK (companions >= 0)
);

-- create planets table
CREATE TABLE planets (
  id serial PRIMARY KEY,
  designation char(1) UNIQUE,
  mass integer
);
```

#### Adjustments based on provided solution:

I was over-eager in making `planets.designation` `UNIQUE`; the wording implies it, but it wasn't directly specified. Corrected with: `ALTER TABLE planets DROP CONSTRAINT planets_designation_key;`

---

### 2. Relating Stars and Planets

You may have noticed that, when we created the `stars` and `planets` tables, we did not do anything to establish a relationship between the two tables. They are simply standalone tables that are related only by the fact that they both belong to the `extrasolar` database. However, there is no relationship between the rows of each table.

To correct this problem, add a `star_id` column to the `planets` table; this column will be used to relate each planet in the `planets` table to its home star in the `stars` table. Make sure the row is defined in such a way that it is required and must have a value that is present as an `id` in the `stars` table.

#### Solution:

```sql
ALTER TABLE planets
  ADD COLUMN star_id integer NOT NULL REFERENCES stars (id);
```

---

### 3. Increase Star Name Length

Hmm... it turns out that 25 characters isn't enough room to store a star's complete name. For instance, the star "Epsilon Trianguli Australis A" requires 30 characters. Modify the column so that it allows star names as long as 50 characters.

#### Solution:

```sql
ALTER TABLE stars
ALTER COLUMN name TYPE varchar(50);
```

#### Further Exploration

Assume the stars table already contains one or more rows of data. What will happen when you try to run the above command? To test this, revert the modification and add a row or two of data:

```sql
ALTER TABLE stars
ALTER COLUMN name TYPE varchar(25);

INSERT INTO stars (name, distance, spectral_type, companions)
           VALUES ('Alpha Centauri B', 4, 'K', 3);

ALTER TABLE stars
ALTER COLUMN name TYPE varchar(50);
```

#### FE Solution:

The alteration from `varchar(25)` to `varchar(50)` should work even with data in the table, since data conforming to the type and max length of `varchar(25)` will inherently conform to the type and max length of `varchar(50)`. If we were making a different alteration, e.g. the reverse of this one (`varchar(50)` to `varchar(25)`), we might encounter an error if we had data in this column larger than 25 characters.

Attempting to run the provided SQL statements verifies my answer: it works with no errors. I further tested the rest of my answer with:

```sql
ALTER TABLE stars
ALTER COLUMN name TYPE varchar(50);

-- insert a name longer than 25 characters
INSERT INTO stars (name, distance, spectral_type, companions)
           VALUES ('Alpha Centauri BBBBBBBBBBBBBBB', 4, 'L', 3);

ALTER TABLE stars
ALTER COLUMN name TYPE varchar(25);
-- produces: ERROR: value too long for type character varying(25)
```

---

### 4. Stellar Distance Precision

For many of the closest stars, we know the distance from Earth fairly accurately; for instance, Proxima Centauri is roughly 4.3 light years away. Our database, as currently defined, only allows integer distances, so the most accurate value we can enter is 4. Modify the `distance` column in the `stars` table so that it allows fractional light years to any degree of precision required.

#### Solution:

```sql
ALTER TABLE stars
ALTER COLUMN distance TYPE float;
```

#### Adjustments based on provided solution:

I didn't realize that `numeric`'s scale and precision were optional and chose `float` (`double precision`) instead. Corrected with:

```psql
ALTER TABLE stars
ALTER COLUMN distance TYPE numeric;
```

#### Further Exploration

Assume the `stars` table already contains one or more rows of data. What will happen when you try to run the above command? To test this, revert the modification and add a row or two of data:

```sql
ALTER TABLE stars
ALTER COLUMN distance TYPE integer;

INSERT INTO stars (name, distance, spectral_type, companions)
           VALUES ('Alpha Orionis', 643, 'M', 9);

ALTER TABLE stars
ALTER COLUMN distance TYPE numeric ;
```

#### FE Solution:

As with #3, we are changing the column from a more strict type to a less strict type, so it should work without error or data corruption; also as before, if the change were different (from a less strict type to a more strict type) we would expect potential errors or data corruption (probably truncation of decimals in this case.)

As expected, this works without error or data corruption in this case. Also as expected, doing the reverse causes problems: in this case there is no error, but decimals are discarded:

```sql
INSERT INTO stars (name, distance, spectral_type, companions) VALUES
  ('Sun', 456.132, 'A', 8);

SELECT * FROM stars;
-- we care about this row:  4 | Sun | 456.132 | A | 8

ALTER TABLE stars
ALTER COLUMN distance TYPE integer;

SELECT * FROM stars;
-- decimals are discarded:  4 | Sun | 456 | A | 8
```

---

5. The `spectral_type` column in the `stars` table is currently defined as a one-character string that contains one of the following 7 values: `'O'`, `'B'`, `'A'`, `'F'`, `'G'`, `'K'`, and `'M'`. However, there is currently no enforcement on the values that may be entered. Add a constraint to the table `stars` that will enforce the requirement that a row must hold one of the 7 listed values above. Also, make sure that a value is required for this column.

#### Solution:

```sql
ALTER TABLE stars
ALTER COLUMN spectral_type SET NOT NULL;

ALTER TABLE stars
ADD CONSTRAINT check_spectral_type
    CHECK (spectral_type IN ('O', 'B', 'A', 'F', 'G', 'K', 'M'));
```

#### Further Exploration:

Assume the `stars` table contains one or more rows that are missing a `spectral_type` value, or that have an illegal value. What will happen when you try to alter the table schema? How would you go about adjusting the data to work around this problem. To test this, revert the modification and add some data:

```sql
ALTER TABLE stars
DROP CONSTRAINT stars_spectral_type_check,
ALTER COLUMN spectral_type DROP NOT NULL;

INSERT INTO stars (name, distance, companions)
           VALUES ('Epsilon Eridani', 10.5, 0);

INSERT INTO stars (name, distance, spectral_type, companions)
           VALUES ('Lacaille 9352', 10.68, 'X', 0);

ALTER TABLE stars
ADD CHECK (spectral_type IN ('O', 'B', 'A', 'F', 'G', 'K', 'M')),
ALTER COLUMN spectral_type SET NOT NULL;
```

#### FE Solution:

I would expect an error when trying to add the CHECK constraint if the table contained data with illegal values. Rows with illegal values would have to be deleted or have valid values entered into the `spectral_type` column before adding the CHECK constraint.

Executing the provided code verifies this: `ERROR: column "spectral_type" contains null values`. Removing the addition of the `NOT NULL` constraint and attempting to add only the CHECK constraint results in: `ERROR: check constraint "stars_spectral_type_check" is violated by some row`.

---

6. Enumerated Types

In the previous exercise, we added a `CHECK` constraint to the `stars` table to enforce that the value stored in the `spectral_type` column for each row is valid. In this exercise, we will use an alternate approach to the same problem.

PostgreSQL provides what is called an enumerated data type; that is, a data type that must have one of a finite set of values. For instance, a traffic light can be red, green, or yellow: these are enumerate values for the color of the currently lit signal light.

Modify the `stars` table to remove the `CHECK` constraint on the `spectral_type` column, and then modify the `spectral_type` column so it becomes an enumerated type that restricts it to one of the following 7 values: `'O'`, `'B'`, `'A'`, `'F'`, `'G'`, `'K'`, and `'M'`.

#### Solution:

```sql
ALTER TABLE stars
 DROP CONSTRAINT check_spectral_type;

CREATE TYPE spectral_type AS ENUM ('O', 'B', 'A', 'F', 'G', 'K', 'M');

ALTER TABLE stars
ALTER COLUMN spectral_type TYPE spectral_type USING spectral_type::spectral_type;
```

---

7. Planetary Mass Precision

We will measure Planetary masses in terms of the mass of Jupiter. As such, the current data type of `integer` is inappropriate; it is only really useful for planets as large as Jupiter or larger. These days, we know of many extrasolar planets that are smaller than Jupiter, so we need to be able to record fractional parts for the mass. Modify the `mass` column in the `planets` table so that it allows fractional masses to any degree of precision required. In addition, make sure the mass is required and positive.

While we're at it, also make the `designation` column required.

#### Solution:

```sql
ALTER TABLE planets
ALTER COLUMN mass TYPE numeric,
ALTER COLUMN mass SET NOT NULL,
  ADD CHECK (mass > 0),
ALTER COLUMN designation SET NOT NULL;
```

---

8. Add a Semi-Major Axis Column

Add a `semi_major_axis` column for the semi-major axis of each planet's orbit; the semi-major axis is the average distance from the planet's star as measured in astronomical units (1 AU is the average distance of the Earth from the Sun). Use a data type of `numeric`, and require that each planet have a value for the `semi_major_axis`.

#### Solution:

```sql
ALTER TABLE planets
  ADD COLUMN semi_major_axis numeric NOT NULL;
```

#### Further Exploration

Assume the `planets` table already contains one or more rows of data. What will happen when you try to run the above command? What will you need to do differently to obtain the desired result? To test this, delete the `semi_major_axis` column and then add a row or two of data (note: your `stars` table will also need some data that corresponds to the `star_id` values):

```sql
ALTER TABLE planets
DROP COLUMN semi_major_axis;

DELETE FROM stars;
INSERT INTO stars (name, distance, spectral_type, companions)
           VALUES ('Alpha Centauri B', 4.37, 'K', 3);
INSERT INTO stars (name, distance, spectral_type, companions)
           VALUES ('Epsilon Eridani', 10.5, 'K', 0);

INSERT INTO planets (designation, mass, star_id)
           VALUES ('b', 0.0036, 9); -- check star_id; see note below
INSERT INTO planets (designation, mass, star_id)
           VALUES ('c', 0.1, 10); -- check star_id; see note below

ALTER TABLE planets
ADD COLUMN semi_major_axis numeric NOT NULL;
```

NOTE: The `semi_major_axis` for Alpha Centauri B planet b is 0.04 AU while that for Epsilon Eridani planet c is about 40 AU. Note also that the `star_id` values shown above may be different from what is in your database. Check your `stars` table to see which `star_id` values to use.

#### FE Solution:

If the `planets` table already has one or more rows of data, the above solution will result in an error that we are violating the `NOT NULL` constraint. We are adding a new column and making it required at the same time; none of our existing rows will have values for this newly created column yet.

The above solution needs to be divided into multiple steps: first create the new column, then update our existing rows with values for the `semi_major_axis` column, then finally add the `NOT NULL` constraint. Alternatively, we could drop all existing rows from the table, add the `semi_major_axis` column with its `NOT NULL` constraint, and then re-insert our data with `semi_major_axis` values. However, this approach becomes harder and more dangerous the more rows of data we have.

Running the provided FE code produces: `ERROR:  column "semi_major_axis" contains null values`. To fix this:

```sql
ALTER TABLE planets
  ADD COLUMN semi_major_axis numeric;

UPDATE planets
   SET semi_major_axis = 0.04
 WHERE id = 1;

UPDATE planets
   SET semi_major_axis = 40
 WHERE id = 2;

ALTER TABLE planets
ALTER COLUMN semi_major_axis SET NOT NULL;
```

---

9. Add a Moons Table

Someday in the future, technology will allow us to start observing the moons of extrasolar planets. At that point, we're going to need a `moons` table in our `extrasolar` database. For this exercise, your task is to add that table to the database. The table should include the following data:

* `id`: a unique serial number that auto-increments and serves as a primary key for this table.
* `designation`: the designation of the moon. We will assume that moon designations will be numbers, with the first moon discovered for each planet being moon 1, the second moon being moon 2, etc. The designation is required.
* `semi_major_axis`: the average distance in kilometers from the planet when a moon is farthest from its corresponding planet. This field must be a number greater than 0, but is not required; it may take some time before we are able to measure moon-to-planet distances in extrasolar systems.
* `mass`: the mass of the moon measured in terms of Earth Moon masses. This field must be a numeric value greater than 0, but is not required.

Make sure you also specify any foreign keys necessary to tie each moon to other rows in the database.

#### Solution:

```sql
CREATE TABLE moons (
  id serial PRIMARY KEY,
  planet_id integer NOT NULL REFERENCES planets (id),
  designation integer NOT NULL,
  semi_major_axis numeric CHECK (semi_major_axis > 0.0),
  mass numeric CHECK (mass > 0.0)
);
```

#### Adjustments based on provided solution

Check that `designation` is positive. Correct with:

```sql
ALTER TABLE moons
  ADD CHECK (designation > 0);
```

---

10. Delete the Database

Delete the `extrasolar` database. Use the `psql` console -- don't use the terminal level commands.

#### Solution:

```sql
\c sql_course

DROP DATABASE extrasolar;
```
