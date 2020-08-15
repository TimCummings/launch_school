
# Searching Expenses - 8/12/2020

### Requirements

Allow users to search for expenses that match a specified term:

```
$ ./expense search Coffee
  2 | 2016-04-05 |         3.29 | Coffee
  4 | 2016-04-06 |         3.59 | Coffee
  5 | 2016-04-06 |         3.59 | Coffee
```

### My Implementation

1. Add a `search_expenses` method to the `ExpenseData` class (since searching will need to interact with the database.)
2. Start with a simple text search (with `LIKE`?); this can possibly be improved later. **Make sure to use `exec_params`!**
3. Limit selection to rows with matching (`LIKE`) memos via `WHERE`.
4. If no search query is provided, fallback to listing all expenses.

#### Solution

```ruby
#! /usr/bin/env ruby

require 'pg'
require 'dotenv/load'

class ExpenseData
  def initialize
    @connection = PG.connect(dbname: 'expenses', password: ENV['DB_PASSWORD'])
  end

  def add_expense(amount, memo)
    sql = 'INSERT INTO expenses (amount, memo, created_on) VALUES ($1, $2, $3);'
    @connection.exec_params sql, [amount, memo, Date.today]
  end

  def list_expenses
    result = @connection.exec 'SELECT * FROM expenses ORDER BY created_on;'
    format_and_print(result)
  end

  def search_expenses(query)
    sql = 'SELECT * FROM expenses WHERE memo LIKE $1;'
    result = @connection.exec_params sql, [query]
    format_and_print(result)
  end

  def format_and_print(result)
    result.values.each do |row|
      puts [row[0].rjust(4), row[3], row[1].rjust(12), row[2]].join(' | ')
    end
  end
end

class CLI
  def initialize
    @application = ExpenseData.new
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

  def run(argv)
    case argv[0]
    when 'add'
      amount, memo = argv[1], argv[2]
      abort 'You must provide an amount and memo.' unless amount && memo
      @application.add_expense(amount, memo)
    when 'list'
      @application.list_expenses
    when 'search'
      query = argv[1]
      query ? @application.search_expenses(query) : @application.list_expenses
    else
      display_help
    end
  end
end

CLI.new.run(ARGV)
```

#### Adjustments based on provided Implementation

* use `ILIKE` instead of `LIKE` (it's case insensitive)

#### Adjustments based on provided Solution

* Wildcard matching can be done with string interpolation **before** passing into `exec_params`:

```ruby
  def search_expenses(query)
    sql = 'SELECT * FROM expenses WHERE memo LIKE $1;'
    result = @connection.exec_params sql, ["%#{query}%"]
    format_and_print(result)
  end
```

* method for displaying expenses should be private
