CREATE TABLE expenses (
  id serial PRIMARY KEY,
  amount decimal(8, 2),
  memo text,
  created_on date
);

ALTER TABLE expenses
  ADD CHECK (amount > 0.0);
