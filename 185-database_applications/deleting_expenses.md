
# Deleting Expenses - 8/13/2020

### Requirements

1. Allow users to delete specific expenses from the system.

```
$ ./expense list
  1 | 2016-04-05 |        14.56 | Pencils
  2 | 2016-04-05 |         3.29 | Coffee
  3 | 2016-04-05 |        49.99 | Text Editor
  4 | 2016-04-06 |         3.59 | Coffee
  5 | 2016-04-06 |        43.23 | Gas for Karen's Car
$ ./expense delete 5
The following expense has been deleted:
  5 | 2016-04-06 |        43.23 | Gas for Karen's Car
$ ./expense list
  1 | 2016-04-05 |        14.56 | Pencils
  2 | 2016-04-05 |         3.29 | Coffee
  3 | 2016-04-05 |        49.99 | Text Editor
  4 | 2016-04-06 |         3.59 | Coffee
```

2. If a user attempts to delete an expense that doesn't exist, an appropriate message should be displayed:

```
$ ./expense delete 5
There is no expense with the id '5'.
```

### My Implementation

1. Add a `delete_expense` method to the `ExpenseData` class.
2. `delete_expense` should accept one argument: the `id` of the expense to be deleted
3. If an expense with the provided `id` is found, delete the expense and print its information
4. If an expense with the provided `id` is not found, display the provided message.
5. Refactor `CLI#run` to route to `ExpenseData#delete_expense`.
6. If no additional argument (`id`) is provided, display an appropriate message.

#### Solution

```ruby
#! /usr/bin/env ruby

require 'pg'
require 'dotenv/load'
require 'pry'

class ExpenseData
  def initialize
    @connection = PG.connect(dbname: 'expenses', password: ENV['DB_PASSWORD'])
  end

  def add_expense(amount, memo)
    sql = 'INSERT INTO expenses (amount, memo, created_on) VALUES ($1, $2, $3);'
    @connection.exec_params sql, [amount, memo, Date.today]
  end

  def delete_expense(id)
    sql = 'SELECT * FROM expenses WHERE id = $1;'
    result = @connection.exec_params sql, [id]

    abort "There is no expense with the id '#{id}'." unless result.any?
    sql = 'DELETE FROM expenses WHERE id = $1;'
    @connection.exec_params sql, [id]
    puts 'The following expense has been deleted:'
    puts format_expense(result.first)
  end

  def list_expenses
    result = @connection.exec 'SELECT * FROM expenses ORDER BY created_on;'
    display_expenses(result)
  end

  def search_expenses(query)
    sql = 'SELECT * FROM expenses WHERE memo ILIKE $1;'
    result = @connection.exec_params sql, ["%#{query}%"]
    format_and_print(result)
  end

  private

  def display_expenses(result)
    result.each { |tuple| puts format_expense(tuple) }
  end

  def format_expense(tuple)
    [
      tuple['id'].rjust(4),
      tuple['created_on'].rjust(10),
      tuple['amount'].rjust(12),
      tuple['memo']
    ].join(' | ')
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
    when 'delete'
      id = argv[1]
      abort 'You must provide an id for the expense to be deleted.' unless id
      @application.delete_expense(id)
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
