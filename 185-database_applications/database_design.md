
# Database Design - 8/11/2020

As we saw in the video, expenses have the following attributes:

* When the expense was created
* How much the expense was
* What the expense was for

In this assignment, we're going to setup a database that we will use throughout the project to persist expense data.

### Requirements

Create a database to store the expenses managed by this project.

### Implementation

1. Design a table called `expenses` that can hold the data for expenses.
2. This table should have columns named `id`, `amount`, `memo`, and `created_on`.
3. Write the SQL to create that table into a file called `schema.sql`.
4. Create a database and use `schema.sql` to setup the database for the application.

#### Solution

```sql
-- schema.sql
CREATE TABLE expenses (
  id serial PRIMARY KEY,
  amount decimal(8, 2),
  memo text,
  created_on timestamp
);
```

```
createdb expenses
psql -d expenses < schema.sql
```

#### Adjustments based on provided solution

* no columns should allow `NULL` values
* `amount` precision should only be 6 digits
* `created_on` should be a date

```sql
-- corrections:

ALTER TABLE expenses
ALTER COLUMN amount TYPE numeric(6,2),
ALTER COLUMN created_on TYPE date,
ALTER COLUMN amount SET NOT NULL,
ALTER COLUMN memo SET NOT NULL,
ALTER COLUMN created_on SET NOT NULL;
```

---

### Practice Problems

1. What is the largest value that can be stored in the `amount` column? Use `psql` to illustrate what it is.

#### Solution

Since `amount` has a precision (total number of digits) of 6, and a scale of 2 (two of the six digits are decimals), the largest `amount`value is `9999.99`:

```sql
INSERT INTO expenses (amount, memo, created_on) VALUES (19999.99, 'invalid: too many digits', NOW());
--ERROR:  numeric field overflow
--DETAIL:  A field with precision 6, scale 2 must round to an absolute value less than 10^4.

INSERT INTO expenses (amount, memo, created_on) VALUES (9999.99, 'largest valid value', NOW());
--INSERT 0 1
```

---

2. What is the smallest value that can be stored in the `amount` column? Use `psql` to illustrate what it is.

#### Solution

Numerically, the smallest value is zero. The smallest non-zero value is `0.01` since the scale of 2 limits values to two decimals:

```sql
INSERT INTO expenses (amount, memo, created_on) VALUES (0.001, 'too small, invalid', NOW());
-- I was wrong; this actually works, but addition decimals beyond two are rounded/truncated

INSERT INTO expenses (amount, memo, created_on) VALUES (0, 'smallest numerical value', NOW());
INSERT INTO expenses (amount, memo, created_on) VALUES (0.01, 'smallest non-zero numerical value', NOW());
```

#### Adjustments based on provided solution

Numeric values can be negative!! The smallest value is `-9999.99` for the same reasons as question #1.

```sql
INSERT INTO expenses (amount, memo, created_on) VALUES (-19999.99, 'invalid: too many digits', NOW());
--ERROR:  numeric field overflow
--DETAIL:  A field with precision 6, scale 2 must round to an absolute value less than 10^4.

INSERT INTO expenses (amount, memo, created_on) VALUES (-9999.99, 'smallest valid value', NOW());
--INSERT 0 1
```

---


3. Add a check constraint to the `expenses` table to ensure that `amount` only holds a positive value.

#### Solution

```sql
-- remove existing negative rows
DELETE FROM expenses
 WHERE amount < 0.01;

ALTER TABLE expenses
  ADD CHECK (amount > 0.0);
```

**Add this change to `schema.sql`!
