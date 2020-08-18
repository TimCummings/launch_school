
# Loading Records from the Database - 8/16/2020

Update `DatabasePersistence.all_lists`: if there are any todos, return an array of hashes with each hash representing a todo, instead of always returning an empty array as it's currently doing.

#### Solution

Let's insert some test data (todos):

```sql
INSERT INTO todos (name, list_id) VALUES
 ('English', 1),
 ('Algebra', 1),
 ('History', 1),
 ('Bread', 2),
 ('Milk', 2),
 ('Eggs', 2);
```

And the updates to `DatabasePersistence#find_list` and `DatabasePersistence#all_lists` (with private helper methods):

```ruby
def find_list(id)
  sql = <<~SQL
    SELECT l.id AS list_id, l.name AS list_name,
           t.id AS todo_id, t.name AS todo_name, t.completed
      FROM lists AS l
      LEFT OUTER JOIN todos AS t ON l.id = t.list_id
     WHERE l.id = $1;
  SQL
  result = query(sql, id)
  parse_result(result).first
end

def all_lists
  sql = <<~SQL
    SELECT l.id AS list_id, l.name AS list_name,
           t.id AS todo_id, t.name AS todo_name, t.completed
      FROM lists AS l
      LEFT OUTER JOIN todos AS t ON l.id = t.list_id
     ORDER BY l.id;
  SQL

  result = query(sql)
  parse_result(result)
end

private

def parse_result(result)
  lists = {}

  result.each do |tuple|
    todo = parse_todo(tuple)
    id = tuple['list_id']
    lists[id] = parse_list(tuple) if lists[id].nil?
    lists[id][:todos] << todo
  end

  lists.values
end

def parse_todo(tuple)
  {
    id: tuple['todo_id'],
    name: tuple['todo_name'],
    completed: to_bool(tuple['completed'])
  }
end

def parse_list(tuple)
  {
    id: tuple['list_id'],
    name: tuple['list_name'],
    todos: []
  }
end

def to_bool(str)
  case str.downcase
  when 'f' then false
  when 'false' then false
  when 't' then true
  when 'true' then true
  else nil
  end
end
```

#### Initial Adjustments

The provided solution is not yet concerned with limiting the number of database queries and instead performs an additional query for each list. I immediately paused the solution video to re-implement my solution with that approach:

```ruby
def find_list(id)
  sql = 'SELECT * FROM lists WHERE id = $1;'
  result = query(sql, id)
  tuple = result.first
  { id: tuple['id'], name: tuple['name'], todos: find_todos(tuple['id']) }
end

def all_lists
  sql = 'SELECT * FROM lists;'
  result = query(sql)

  result.map do |tuple|
    { id: tuple['id'], name: tuple['name'], todos: find_todos(tuple['id']) }
  end
end

def find_todos(list_id)
  sql = 'SELECT * FROM todos WHERE list_id = $1;'
  result = query(sql, list_id)
  result.map do |tuple|
    { id: tuple['id'], name: tuple['name'], completed: to_bool(tuple['completed']) }
  end
end

private

def to_bool(str)
  case str.downcase
  when 'f' then false
  when 'false' then false
  when 't' then true
  when 'true' then true
  else nil
  end
end
```

#### Adjustments based on provided solution

* `find_todos` can be named more clearly: `find_todos_for_list`
* `find_todos_for_list` should be private
