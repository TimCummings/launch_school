
[comment]: # (add_data_exercises.md)

# Add Data with INSERT - Exercises - 2/2/2019

1. Make sure you are connected to the `encyclopedia` database. Add the following data to the `countries` table:

| Name   | Capital | Population |
|--------|---------|------------|
| France | Paris   | 67,158,000 |

#### Solution:

```sql
INSERT INTO countries (name, capital, population)
  VALUES ('France', 'Paris', 67158000);
```

---

2. Now add the following additional data to the `countries` table:

| Name    | Capital         | Population  |
|---------|-----------------|-------------|
| USA     | Washington D.C. | 325,365,189 |
| Germany | Berlin          |  82,349,400 |
| Japan   | Tokyo           | 126,672,000 |

#### Solution:

```sql
INSERT INTO countries (name, capital, population)
  VALUES ('USA', 'Washington D.C.', 325365189),
         ('Germany', 'Berlin', 82349400),
         ('Japan', 'Tokyo', 126672000);
```

---

3. Add an entry to the `celebrities` table for the singer and songwriter Bruce Springsteen, who was born on September 23rd 1949 and is still alive.

#### Solution:

```sql
INSERT INTO celebrities (first_name, last_name, occupation, date_of_birth, deceased)
  VALUES ('Bruce', 'Springsteen', 'Singer, Songwriter', '19490923', true);
```

---

4. Add an entry for the actress Scarlett Johansson, who was born on November 22nd 1984. Use the default value for the `deceased` column.

#### Solution: 

```sql
INSERT INTO celebrities (first_name, last_name, occupation, date_of_birth, deceased)
  VALUES ('Scarlett', 'Johansson', 'Actress', '1984-11-22', DEFAULT);
```

---

5. Add the following two entries to the `celebrities` table with a single `INSERT` statement. For Frank Sinatra set `true` as the value for the `deceased` column. For Tom Cruise, don't set an explicit value for the `deceased` column, but use the default value.

| First Name | Last Name | Occupation    | D.O.B.            |
|------------|-----------|---------------|-------------------|
| Frank      | Sinatra   | Singer, Actor | December 12, 1915 |
| Tom        | Cruise    | Actor         | July 03, 1962     |

#### Solution:

```sql
INSERT INTO celebrities (first_name, last_name, occupation, date_of_birth, deceased)
  VALUES ('Frank', 'Sinatra', 'Singer, Actor', '1915-12-12', true),
         ('Tom', 'Cruise', 'Actor', '1962-07-03', DEFAULT);
```

---

6. Look at the schema of the `celebrities` table. What do you think will happen if we try to insert the following data?

| First Name | Last Name | Occupation                          | D.O.B.       | Deceased |
|------------|-----------|-------------------------------------|--------------|----------|
| Madonna    |           | Singer, Actress                     | '08/16/1958' | false    |
| Prince     |           | Singer, Songwriter, Musician, Actor | '06/07/1958' | true     |

#### Solution:

We will get an error because the `last_name` column currently has a `NOT NULL` constraint and we are attempting two insert two rows with `NULL` values for `last_name`.

---

7. Update the `last_name` column of the `celebrities` table so that the data in the previous question can be entered, and then add the data to the table.

#### Solution:

```sql
ALTER TABLE celebrities
  ALTER COLUMN last_name
    DROP NOT NULL;

INSERT INTO celebrities (first_name, occupation, date_of_birth, deceased)
  VALUES ('Madonna', 'Singer, Actress', '1958-08-16', false),
         ('Prince', 'Singer, Songwriter, Musician, Actor', '1958-06-07', true);
```

---

8. Check the schema of the `celebrities` table. What would happen if we specify a `NULL` value for `deceased` column, such as with the data below?

| First Name | Last Name | Occupation              | D.O.B.       | Deceased |
|------------|-----------|-------------------------|--------------|----------|
| Elvis      | Presley   | Singer, Musician, Actor | '01/08/1935' | NULL     |

#### Solution:

The data would be inserted as listed; there would not be an error because the `deceased` column does NOT have a `NOT NULL` constraint currently.

---

9. Check the schema of the `animals` table. What would happen if we tried to insert the following data to the table?

| Name             | Binomial Name            | Max Weight (kg) | Max Age (years) | Conservation Status |
|------------------|--------------------------|-----------------|-----------------|---------------------|
| Dove             | Columbidae Columbiformes | 2               | 15              | LC                  |
| Golden Eagle     | Aquila Chrysaetos        | 6.35            | 24              | LC                  |
| Peregrine Falcon | Falco Peregrinus         | 1.5             | 15              | LC                  |
| Pigeon           | Columbidae Columbiformes | 2               | 15              | LC                  |
| Kakapo           | Strigops habroptila      | 4               | 60              | CR                  |

Identify the problem and alter the table so that the data can be entered as shown, and then insert the data.

#### Solution:

The `binomial_name` column currently has a `UNIQUE` constraint; the data above will raise an error in violation of this constraint since two rows have the same `binomial_name`. To insert the above data, the `UNIQUE` constraint for `binomial_name` needs to first be removed.

```sql
ALTER TABLE animals
  DROP CONSTRAINT unique_binomial_name;

INSERT INTO animals (name, binomial_name, max_weight_kg, max_age_years, conservation_status)
  VALUES ('Dove', 'Columbidae Columbiformes', 2.0, 15, 'LC'),
         ('Golden Eagle', 'Aquila Chrysaetos', 6.35, 24, 'LC'),
         ('Peregrine Falcon', 'Falco Peregrinus', 1.5, 15, 'LC'),
         ('Pigeon', 'Columbidae Columbiformes', 2.0, 15, 'LC'),
         ('Kakapo', 'Strigops habroptila', 4.0, 60, 'CR');
```

---

10. Connect to the `ls_burger` database and examine the schema for the `orders` table.

Based on the table schema and following information, write and execute an `INSERT` statement to add the appropriate data to the `orders` table.

There are three customers -- James Bergman, Natasha O'Shea, Aaron Muller. James' email address is james1998@email.com. Natasha's email address is natasha@osheafamily.com. Aaron doesn't supply an email address.

James orders a LS Chicken Burger, Fries and a Cola. Natasha has two orders -- an LS Cheeseburger with Fries but no drink, and an LS Double Deluxe Burger with Onion Rings and a Chocolate Shake. Aaron orders an LS Burger with no side or drink.

The item costs and loyalty points are listed below:

| Item                    | Cost ($) | Loyalty Points |
|-------------------------|----------|----------------|
| LS Burger               | 3.00     | 10             |
| LS Cheeseburger         | 3.50     | 15             |
| LS Chicken Burger       | 4.50     | 20             |
| LS Double Deluxe Burger | 6.00     | 30             |
| Fries                   | 0.99     |  3             |
| Onion Rings             | 1.50     |  5             |
| Cola                    | 1.50     |  5             |
| Lemonade                | 1.50     |  5             |
| Vanilla Shake           | 2.00     |  7             |
| Chocolate Shake         | 2.00     |  7             |
| Strawberry Shake        | 2.00     |  7             |

#### Solution:

```sql
INSERT into orders (customer_name, customer_email, burger, burger_cost, side, side_cost, drink, drink_cost, customer_loyalty_points)
  VALUES ('James Bergman', 'james1998@email.com', 'LS Chicken Burger', 4.50, 'Fries', 0.99, 'Cola', 1.50, (20 + 3 + 5)),
         ('Natasha O''Shea', 'natasha@osheafamily.com', 'LS Cheeseburger', 3.50, 'Fries', 0.99, NULL, DEFAULT, (15 + 3)),
         ('Natasha O''Shea', 'natasha@osheafamily.com', 'LS Double Deluxe Burger', 6.00, 'Onion Rings', 1.50, 'Chocolate Shake', 2.00, (30 + 5 + 7)),
         ('Aaron Muller', NULL, 'LS Burger', 3.00, NULL, DEFAULT, NULL, DEFAULT, 10);
```
