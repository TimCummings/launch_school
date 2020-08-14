CREATE TABLE expenses (
  id serial PRIMARY KEY,
  amount decimal(8, 2) CHECK (amount > 0.0),
  memo text,
  created_on date
);
