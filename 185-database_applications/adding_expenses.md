
# Adding Expenses - 8/11/2020

Now let's add the ability to add additional expenses through the `expense` program.

### Requirements

1. Add a command, `add`, that can be used to add new expenses to the system. It should look like this in use:

```
$ ./expense add 3.59 "More Coffee"
$ ./expense list
  1 | 2016-04-05 |        14.56 | Pencils
  2 | 2016-04-05 |         3.29 | Coffee
  3 | 2016-04-05 |        49.99 | Text Editor
  4 | 2016-04-06 |         3.59 | More Coffee
```

2. Make sure that this command is always passed any additional parameters needed to add an expense. If it isn't display an error message:

```
$ ./expense add
You must provide an amount and memo.
```

### Implementation

1. Check to see if the first argument passed to the program is `add`. If it is, check to make sure that two more arguments were also passed. If they weren't, print out an error message and exit.
2. Call a new method, `add_expense`, that accepts the two passed arguments. This method should execute a SQL statement to insert a new row into the `expenses` table.

#### Solution

```ruby
#! /usr/bin/env ruby

require 'pg'
require 'dotenv/load'

def add_expense(amount, memo)
  db = PG.connect(dbname: 'expenses', password: ENV['DB_PASSWORD'])
  db.exec "INSERT INTO expenses (amount, memo, created_on) VALUES (#{amount}, '#{memo}', NOW());"
end

def display_help
  puts <<~HELP
    An expense recording system

    Commands:

    add AMOUNT MEMO [DATE] - record a new expense
    clear - delete all expenses
    list - list all expenses
    delete NUMBER - remove expense with id NUMBER
    search QUERY - list expenses with a matching memo field
  HELP
end

def list_expenses
  db = PG.connect(dbname: 'expenses', password: ENV['DB_PASSWORD'])

  result = db.exec 'SELECT * FROM expenses ORDER BY created_on'

  result.values.each do |row|
    puts [row[0].rjust(4), row[3], row[1].rjust(12), row[2]].join(' | ')
  end
end

command = ARGV[0]
if command == 'add'
  amount = ARGV[1]
  memo = ARGV[2]
  unless amount && memo
    puts 'You must provide an amount and memo.'
    return
  else
    add_expense(amount, memo)
  end
elsif command == 'list'
  list_expenses
else
  display_help
end
```

#### Adjustments based on provided solution

* early return with a message can be accomplished on a single with with `abort`:

```ruby
command = ARGV[0]
if command == 'add'
  amount = ARGV[1]
  memo = ARGV[2]
  abort 'You must provide an amount and memo.' unless amount && memo
  add_expense(amount, memo)
elsif command == 'list'
  list_expenses
else
  display_help
end
```

### Practice Problems

1. Can you see any potential issues with the Solution code above?

##### Hint

Try adding an expense with the memo `Gas for Karen's Car`.

#### Solution

There is no validation being done on user input (other than making sure it exists) before inserting it into the database. At best, this can lead to invalid data; at worst, this is a gaping security vulnerability.
