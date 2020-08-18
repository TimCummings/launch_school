
# Setting up a Database Connection

### Provided Walkthrough (video)

* add `'pg'` dependency to `Gemfile` and `bundle install`
* move `SessionPersistence` class into its own file
  * `session_persistence.rb`
  * `require_relative "session_persistence"`
  * test app, make sure it still works
* make a copy of `session_persistence.rb` named `database_persistence.rb`
  * `require 'pg'`
  * change class name to `DatabasePersistence`
  * comment out contents of each method (we can reference it as we write the new code)
  * delete `next_element_id` method; database handles this for us
* `database_persistence.rb` changes
  * `initialize`
    * no longer need `session` parameter, remove it
    * use `@db` instead of `@session`; hard code connection in initialize
    * no need to create an empty array
  * `all_lists`
    * simple SQL statement to get list data
    * need to make SQL `result` match what our app expects, which is a hash with keys `id`, `name`, and `todos`
* `todo.rb` changes
  * change `require_relative` to `database_persistence`
  * in before filter, change `SessionPersistence` to `DatabasePersistence`
* test app
  * insert test data directly into database: `INSERT INTO lists (name) VALUES ('Homework'), ('Groceries');`
  * verify they show up on the webpage

### Practice Problems

1. Why can we call the `map` method directly on an instance of `PG::Result`?

#### Solution

`PG::Result` includes the `Enumerable` module which makes the `map` method (and several others) available.
