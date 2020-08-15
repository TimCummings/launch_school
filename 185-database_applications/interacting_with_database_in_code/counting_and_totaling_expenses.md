
# Counting and Totaling Expenses - 8/13/2020

### Requirements

1. The `list` command should display a count of expenses in addition to the total of all expenses:

```
$ ./expense list
There are 4 expenses.
  1 | 2016-04-07 |        14.56 | Pencils
  2 | 2016-04-07 |         3.29 | Coffee
  3 | 2016-04-07 |        49.99 | Text Editor
  4 | 2016-04-07 |         3.59 | More Coffee
--------------------------------------------------
Total                     71.43
```

2. Additionally, if there are no expenses (which is much more possible now that we've implemented the `clear` command), an appropriate message should be shown:

```
$ ./expense list
There are no expenses.
```

The same behavior should be provided by the search command:

```
$ ./expense search coffee
There are 2 expenses.
  6 | 2016-04-07 |         3.29 | Coffee
  8 | 2016-04-07 |         3.59 | More Coffee
--------------------------------------------------
Total                      6.88
$ ./expense search bananas
There are no expenses.
```

> Remember that you're working with floating point numbers when you calculate totals, and floating point numbers are inexact approximations of the values used. Thus, `0.1 + 0.2 != 0.3`. Don't be surprised if your totals have more digits after the decimal point than you expect. The results may be a little different from the values shown, but should be very, very close.

### My Implementation

1. Add a `sum_expenses` method for calculating the sum of a collection of expenses; per the floating point warning, make sure the total is rounded to two decimals.
2. `sum_expenses` should accept a query result as an argument.
3. Add a `display_total` method that formats and prints the total.
4. `display_total` should accept one argument: the total from `sum_expenses`.
5. Update `list` to also show a total.
6. Update `search` to also show a total.
7. Update `list` to display a message if there are no expenses.
8. Update `search` to display a message if there are no expenses.

#### Solution

```ruby
#! /usr/bin/env ruby

require 'pg'
require 'dotenv/load'
require 'io/console'

class ExpenseData
  def initialize
    @connection = PG.connect(dbname: 'expenses', password: ENV['DB_PASSWORD'])
  end

  def add_expense(amount, memo)
    sql = 'INSERT INTO expenses (amount, memo, created_on) VALUES ($1, $2, $3);'
    @connection.exec_params sql, [amount, memo, Date.today]
  end

  def delete_all_expenses
    @connection.exec 'DELETE FROM expenses;'
    puts 'All expenses have been deleted.'
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
    display_expenses(result)
  end

  private

  def display_expenses(result)
    if result.ntuples > 0
      puts "There are #{result.ntuples} expenses."
      result.each { |tuple| puts format_expense(tuple) }
      display_total sum_expenses(result)
    else
      puts 'There are no expenses.'
    end
  end

  def display_total(total)
    line_break = '-' * 50
    label = 'Total'.ljust(19)
    total = total.to_s.rjust(13)
    puts line_break
    puts label + total
  end

  def format_expense(tuple)
    [
      tuple['id'].rjust(4),
      tuple['created_on'].rjust(10),
      tuple['amount'].rjust(12),
      tuple['memo']
    ].join(' | ')
  end

  def sum_expenses(result)
    sum = result.reduce(0) { |sum, tuple| sum + tuple['amount'].to_f }
    sum.round(2)
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
    when 'clear'
      puts 'This will remove all expenses. Are you sure? (y/n)'
      confirmation = STDIN.getch
      @application.delete_all_expenses if confirmation.downcase == 'y'
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
