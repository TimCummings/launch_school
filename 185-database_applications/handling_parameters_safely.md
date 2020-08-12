
# Handling Parameters Safely - 8/12/2020

Recall what happened last lesson when including a quote in our memo string:

```
$ ./expense add 43.23 "Gas for Karen's Car"
./expense:22:in `exec': ERROR:  syntax error at or near "s" (PG::SyntaxError)
LINE 1: ..., memo, created_on) VALUES (43.23, 'Gas for Karen's Car', '2...
                                                             ^
from ./expense:22:in `add_expense'
from ./expense:46:in `<main>'
```

Because we're interpolating user input directly into our SQL statement:

```ruby
"INSERT INTO expenses (amount, memo, created_on) VALUES (#{amount}, '#{memo}', '#{date}')"
```

The single quote within the memo ends up closing the string early, which causes the above error:

```sql
INSERT INTO expenses (amount, memo, created_on)
  VALUES (43.23, 'Gas for Karen's Car', '2016-06-22')
```

While this causes a relatively benign error, clever and malicious users can use such a vulnerability to execute arbitrary commands on your database. Consider the following, which deletes our `expenses` table and all of its data!!

```
$ ./expense add 0.01 "', '2015-01-01'); DROP TABLE expenses; --"
```

Thankfully, Postgresql provides functionality to mitigate such vulnerabilities. Language adapters, like the `pg` gem, make use of these. The solution for `pg` is to replace `PG::Connection#exec` with `PG::Connection#exec_params` (see documentation [here](https://deveiate.org/code/pg/PG/Connection.html#method-i-exec_params).)

Consider this code with `exec`:

```ruby
connection.exec('SELECT 1 + 1').values
# [["2"]]
```

To execute similar code with `exec_params`, replace one of the values with the placeholder `$1` and then pass a value to replace the placeholder using an array:

```ruby
connection.exec_params("SELECT 1 + $1", [1]).values
# [["2"]]
```

Strings are handled a similar way - notice we are **NOT** placing quotes around the placeholder!!

```ruby
connection.exec_params("SELECT upper($1)", ['test']).values
# [["TEST"]]
```

You can use as many placeholders as needed, as long as the same number of values are passed in the following array:

```ruby
connection.exec_params("SELECT position($1 in $2)", ['t', 'test']).values
# [["1"]]
```

### Practice Problems

1. What happens if you use two placeholders in the first argument to `PG::Connection#exec_params`, but only one in the Array of values used to fill in those placeholders?

#### Solution

I suspect that this will cause an error; let's try:

```ruby
connection.exec_params("SELECT 1 + $1 + $2;", [2]).values
# PG::ProtocolViolation: ERROR:  bind message supplies 1 parameters, but prepared statement "" requires 2
```

---

2. Update the code within the `add_expense` method to use `exec_params` instead of `exec`.

#### Solution

```ruby
def add_expense(amount, memo)
  db = PG.connect(dbname: 'expenses', password: ENV['DB_PASSWORD'])
  sql = 'INSERT INTO expenses (amount, memo, created_on) VALUES ($1, $2, $3);'
  db.exec_params sql, [amount, memo, Date.today]
end
```

---

3. What happens when the same malicious arguments are passed to the program now?

#### Solution

They will be inserted as strings without causing any adverse side-effects:

```
./expense add 0.01 "', '2015-01-01'); DROP TABLE expenses; --"
./expense list
#   1 | 2020-08-12 |         0.01 | ', '2015-01-01'); DROP TABLE expenses; --
```
