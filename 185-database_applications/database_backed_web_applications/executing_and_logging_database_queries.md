
# Executing and Logging Database Queries - 8/16/2020

Implement `DatabasePersistence#find_list`:

```ruby
def find_list(id)
  sql = 'SELECT * FROM lists WHERE id = $1'
  result = @db.exec_params(sql, [id])
  tuple = result.first
  { id: tuple['id'], name: tuple['name'], todos: [] }
end
```

This won't show any todos yet, but we'll fix that later. One step at a time.

---

We'd like for the server output to show the SQL statements being issued to the database. This can be a huge help when debugging:

```ruby
def find_list(id)
  sql = 'SELECT * FROM lists WHERE id = $1'
  puts "#{sql}: #{id}"
  result = @db.exec_params(sql, [id])
  tuple = result.first
  { id: tuple['id'], name: tuple['name'], todos: [] }
end

def all_lists
  sql = 'SELECT * FROM lists;'
  puts sql
  result = @db.exec(sql)

  result.map do |tuple|
    { id: tuple['id'], name: tuple['name'], todos: [] }
  end
end
```

This approach will quickly become annoying because we will have to add logging to over and over in every place we're issuing SQL statements. Let's instead extract this to a method:

```ruby
def query(statement, *params)
  puts "#{statement}: #{params}"
  @db.exec_params(statement, params)
end

def find_list(id)
  sql = 'SELECT * FROM lists WHERE id = $1;'
  result = query(sql, id)
  tuple = result.first
  { id: tuple['id'], name: tuple['name'], todos: [] }
end

def all_lists
  sql = 'SELECT * FROM lists;'
  result = query(sql)

  result.map do |tuple|
    { id: tuple['id'], name: tuple['name'], todos: [] }
  end
end
```

---

Sinatra provides a logging helper that has several advantages:
* more consistent output
* can be enabled or disabled based on configuration settings

Let's use that instead of puts:

```ruby
# todo.rb
before do
  @storage = DatabasePersistence.new(logger)
end

# database_persistence.rb
def initialize(logger)
  @db = PG.connect(dbname: 'todos', password: ENV['DB_PASSWORD'])
  @logger = logger
end

def query(statement, *params)
  @logger.info "#{statement}: #{params}"
  @db.exec_params(statement, params)
end
```
