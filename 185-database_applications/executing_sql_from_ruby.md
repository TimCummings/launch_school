
# Executing SQL Statements from Ruby

* Import [this file](https://raw.githubusercontent.com/launchschool/sql_course_data/master/sql-and-relational-databases/relational-data-and-joins/converting-a-1m-relationship-to-a-mm-relationship/films7.sql) into a database before continuing.

### Solution

```
curl -O https://raw.githubusercontent.com/launchschool/sql_course_data/master/sql-and-relational-databases/relational-data-and-joins/converting-a-1m-relationship-to-a-mm-relationship/films7.sql
createdb ls_185
psql -d ls_185 < films7.sql
```

---

### Notes

* use `pg` gem to connect to a postgresql database with Ruby
* establish a connection with `db = PG.connect(dbname: 'ls_185')`
  * `password:` argument can be provided to connect if required.
* SQL statements can be issued with `db.exec "SELECT 1"`
  * `exec` will return a `result` object
  * You'll usually want to store this in a variable to work with it: `result = db.exec "SELECT 1"`
    * several `result` methods reference tuples - these are Ruby hashes
    * several `result` methods reference rows - these are Ruby arrays
  * result's values (inside tuples/hashes and rows/arrays) are all strings; you'll need to convert them into more meaningful Ruby objects to work with them more meaningfully
* pry
  * You can treat pry's scope like a directory!!
    * `ls` shows available methods
    * you can `cd` to an object to change to its scope, e.g. `cd result`
  * You can get more information about a method with `show-method` and `show-doc` (currently bugged in pry.)

* some useful result methods:
  * `result.values` returns an array of arrays (rows), but without column names
    * `result.values.size` or `result.ntuples` returns the number of rows in the result
  * `result.fields` returns an array of column names
  * to iterate rows:
    * `result.each do |tuple|`: `tuple` is a hash; values can be accessed by column name `tuple['title']`
    * `result.each_row do |row|`: `row` is an array; values can be accessed by column index `row[2]`
  * to access a specific row:
    * `result[2]` returns a hash with column names as keys and values as values
  * to see all values of a specific column:
    * `result.field_values('title')` lookup by column name, returns an array
    * `result.column_values(4)` lookup by column index, returns an array
