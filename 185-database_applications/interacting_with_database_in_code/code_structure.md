
# Code Structure - 8/12/2020

It's helpful to intermittently take a step back and consider the overall structure of our program as we write it. Currently, we have no separation of concerns: our main scope is handling user input, communicating with the database, and formatting/displaying output to the user. Let's break some of those concerns out into separate classes:

### Implementation


1. Move the `add_expense` and `list_expenses` methods into a new class, `ExpenseData`.
2. Change the `CONNECTION` constant to an instance variable. We want to have a clear separation of responsibilities for our application. We want to ensure that access to the database connection is restricted to `ExpenseData`, since we're encapsulating database interaction within `ExpenseData`.
3. Move the parameter handling into a new class, `CLI`. Create an instance of `ExpenseData` in `CLI#initialize`.
4. Create a new instance of `CLI` and call `run` on it, passing `ARGV`.

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
    result.values.each do |row|
      puts [row[0].rjust(4), row[3], row[1].rjust(12), row[2]].join(' | ')
    end
  end
end

class CLI
  def initialize
    @expense_data = ExpenseData.new
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
      @expense_data.add_expense(amount, memo)
    when 'list'
      @expense_data.list_expenses
    else
      display_help
    end
  end
end

CLI.new.run(ARGV)
```
