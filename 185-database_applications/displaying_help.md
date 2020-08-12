
# Displaying Help - 8/11/2020

The functionality we built in the previous assignment is currently the `expense` command's default, as it is run when no arguments are passed along when the program is executed. We ideally want it to be output when the command is passed an argument `list`, like this:

```
$ ./expense list
  1 | 2016-04-05 |        14.56 | Pencils
  2 | 2016-04-05 |         3.29 | Coffee
  3 | 2016-04-05 |        49.99 | Text Editor
```

When no arguments are passed to `expense`, we want the program to display some help information about its use:

```
$ ./expense
An expense recording system

Commands:

add AMOUNT MEMO [DATE] - record a new expense
clear - delete all expenses
list - list all expenses
delete NUMBER - remove expense with id NUMBER
search QUERY - list expenses with a matching memo field
```

### Requirements

1. Display a list of expenses when passed the `list` argument, and help content otherwise.

### Implementation

1. Move the existing expense listing code into a method.
2. Add a new method that prints out the help content.
3. Check the value of the first argument passed to the program, and call the appropriate method.

> For this assignment, we'll need access to the arguments passed into our CLI program. When writing a script, we can access the list of arguments passed into a command-line program with `ARGV`. In your Ruby script, `ARGV` will be an `Array` of arguments that have been passed to your command-line program.

#### Solution

```ruby
#! /usr/bin/env ruby

require 'pg'
require 'dotenv/load'

def help
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

def list
  db = PG.connect(dbname: 'expenses', password: ENV['DB_PASSWORD'])

  result = db.exec 'SELECT * FROM expenses ORDER BY created_on'

  result.values.each do |row|
    puts [row[0], row[3], row[1].rjust(12), row[2]].join(' | ')
  end
end

case ARGV[0]
when 'list' then list
else help
end
```

---

### Practice Problems

1. Describe what is happening on line 20 of the Solution shown above.

#### Solution

Line 20 is a HEREDOC: a multi-line block of text. Everything between lines 20 and 30 is treated as a string. HEREDOCs make working with larger chunks of text easier than trying to concatenate several lines together.
