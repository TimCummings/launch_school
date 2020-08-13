
# Clearing Expenses - 8/13/2020

### Requirements

1. A user can remove all expenses from the system using a new command, `clear`.
2. Before deleting all expenses, the program should prompt the user to verify they wish to continue:

```
$ ./expense clear
This will remove all expenses. Are you sure? (y/n)
```

3. If the user presses `n`, then the program should exit without deleting any data:

```
$ ./expense clear
This will remove all expenses. Are you sure? (y/n) # press n
$ ./expense list
1 | 2016-04-05 |        14.56 | Pencils
2 | 2016-04-05 |         3.29 | Coffee
3 | 2016-04-05 |        49.99 | Text Editor
4 | 2016-04-06 |         3.59 | Coffee
```

4. If the user presses `y`, all expenses should be deleted a message should be shown:

```
$ ./expense clear
This will remove all expenses. Are you sure? (y/n) # press y
All expenses have been deleted.
$ ./expense list
$
```

### My Implementation

1. Add a `clear_expenses` method to `ExpenseData` that takes no arguments.
2. Add routing from `CLI` to `ExpenseData#clear_expenses`.
3. `clear_expenses` should display a warning and prompt the user for confirmation.
4. If confirmation does not start with `y` or `Y`, abort.
5. If confirmation starts with `y` or `Y`, delete all expenses and notify user.

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

  def clear_expenses
    puts 'This will remove all expenses. Are you sure? (y/n)'
    confirmation = STDIN.gets

    abort unless confirmation[0].downcase == 'y'
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
    when 'clear'
      @application.clear_expenses
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

#### Adjustments based on provided implementation

* command line (user prompt) should be handled in `CLI`
* clear expenses method name should be clearer

```ruby
  def delete_all_expenses
    @connection.exec 'DELETE FROM expenses;'
    puts 'All expenses have been deleted.'
  end

# ...

  when 'clear'
    puts 'This will remove all expenses. Are you sure? (y/n)'
    confirmation = STDIN.gets
    abort unless confirmation[0].downcase == 'y'
    @application.delete_all_expenses
```

#### Adjustments based on provided hint

* use `IO#getch` instead of `gets`

```ruby
  when 'clear'
    puts 'This will remove all expenses. Are you sure? (y/n)'
    confirmation = STDIN.getch
    abort unless confirmation.downcase == 'y'
    @application.delete_all_expenses
```

#### Adjustments based on provided solution

* `clear` `abort` in `CLI#run` is unnecessary:

```ruby
when 'clear'
  puts 'This will remove all expenses. Are you sure? (y/n)'
  confirmation = STDIN.getch
  @application.delete_all_expenses if confirmation.downcase == 'y'
```
