
# Creating the Schema Automatically - 8/14/2020

In PostgreSQL, information about the database server is contained in and presented as tables that can be interacted with in the same way as other user-created tables. We're going to take advantage of this to automatically determine if the `expenses` table has been created. If it hasn't, the program should automatically create it before doing anything else.

### Requirements

1. When a user runs the `expense` program for the first time, it should automatically create any tables it needs within the `expenses` database (notice there are no errors):

```
$ createdb expenses
$ ./expense list
There are no expenses.
```

### Implementation

The following query will return a value of one if a table with the name `expenses` exists:

```sql
expenses=# SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'public' AND table_name = 'expenses';
 count
-------
     1
(1 row)
```

If that table does not exist, the `COUNT` will return zero:

```sql
expenses=# SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'public' AND table_name = 'doesnotexist';
 count
-------
     0
(1 row)
```

1. Add a new method, `setup_schema` to `ExpenseData`. Call this method inside `ExpenseData#initialize`.
2. Inside `setup_schema`, use the query described above to see if the `expenses` table already exists. If it doesn't, create it.

#### Solution

```ruby
#! /usr/bin/env ruby

require 'pg'
require 'dotenv/load'
require 'io/console'

class ExpenseData
  def initialize
    @connection = PG.connect(dbname: 'expenses', password: ENV['DB_PASSWORD'])
    setup_schema
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

  def setup_schema
    table_check = <<~SQL
      SELECT COUNT(*) FROM information_schema.tables
       WHERE table_schema = 'public'
         AND table_name = 'expenses';
    SQL
    result = @connection.exec(table_check)

    if result.values.first == ['0']
      table_creation = <<~SQL
        CREATE TABLE expenses (
          id serial PRIMARY KEY,
          amount decimal(8, 2) CHECK (amount > 0.0),
          memo text,
          created_on date
        );
      SQL
      @connection.exec(table_creation)
    end
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

Adjustments based on provided solution

* HEREDOC can be passed directly to `exec`

```ruby
def setup_schema
  result = @connection.exec <<~SQL
    SELECT COUNT(*) FROM information_schema.tables
     WHERE table_schema = 'public'
       AND table_name = 'expenses';
  SQL

# ...

@connection.exec <<~SQL
  CREATE TABLE expenses (
    id serial PRIMARY KEY,
    amount decimal(8, 2) CHECK (amount >= 0.01),
    memo text,
    created_on date
  );
SQL
```

* Because of our two digit limit, `amount` `CHECK` should be `>= 0.01`, not just `> 0`.
* `COUNT` check can be more specific: `if result.first['count'] == '0'`.
