
# Listing Expenses - 8/11/2020

Our next step is to connect to the database, execute a query, and print out the results to the screen.

Go ahead and add a few rows to the `expenses` table using `psql` so that there will be some data to work with (you can, of course, use whatever expenses you'd like):

```sql
INSERT INTO expenses (amount, memo, created_on) VALUES (14.56, 'Pencils', NOW());
INSERT INTO expenses (amount, memo, created_on) VALUES (3.29, 'Coffee', NOW());
INSERT INTO expenses (amount, memo, created_on) VALUES (49.99, 'Text Editor', NOW());
```

### Requirements

1. Connect to the `expenses` database and print out the information for all expenses in the system.

### Implementation

1. Create a connection to the database.
2. Execute a query to retrieve all rows from the expenses table, ordered from oldest to newest.
3. Iterate through each result row and print it to the screen. The result should look like this:

```
$ ./expense
  1 | 2016-04-05 |        14.56 | Pencils
  2 | 2016-04-05 |         3.29 | Coffee
  3 | 2016-04-05 |        49.99 | Text Editor
```

#### Solution

```ruby
#! /usr/bin/env ruby

require 'pg'
require 'dotenv/load'

db = PG.connect(dbname: 'expenses', password: ENV['DB_PASSWORD'])

result = db.exec 'SELECT * FROM expenses ORDER BY created_on'

result.values.each do |row|
  puts [row[0], row[3], row[1].rjust(12), row[2]].join(' | ')
end
```
