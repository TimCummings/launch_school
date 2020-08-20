
# Pushing Down Operations to the Database - 8/19/2020

While our N+1 optimization from the previous lesson was good, we have broken our other page for viewing an individual list and its todos: `undefined method '>' for nil:NilClass`!

The issue appears to be that our refactored `all_lists` method returns a hash with different keys than our `find_list` method. One approach when working through an issue like this is to add the missing keys with placeholder values and see if that fixes your error or not. If so, then you can go back and fill in the placeholder values. In this case, we'll simply add `todos_count: 0` and `todos_remaining_count: 0` to the hash returned by the `find_list` method.

This does indeed fix our error, so now let's work on getting real values instead of placeholders:

```ruby
def find_list(id)
  sql = <<~SQL
    SELECT lists.*,
     COUNT(todos.id) AS todos_count,
     COUNT(NULLIF(todos.completed, true)) AS todos_remaining_count
      FROM lists
      LEFT JOIN todos ON todos.list_id = lists.id
     WHERE lists.id = $1
     GROUP BY lists.id
     ORDER BY lists.name;
  SQL
  result = query(sql, id)

  tuple = result.first

  list_id = tuple['id'].to_i
  todos = find_todos_for_list(list_id)
  {
    id: tuple['id'].to_i,
    name: tuple['name'],
    todos: todos,
    todos_count: tuple['todos_count'].to_i,
    todos_remaining_count: tuple['todos_remaining_count'].to_i
  }
end
```

We can remove several of our helpers now, since we've essentially delegated counting `todos` and completed `todos` to the database. Whether or not this is a good idea depends on your app; in this case,it is a good idea.

Next, we can remove the `todos` key/value from our `find_list` result if we refactor `list.erb`. Instead of expecting `todos` in the `list` (currently `@list[:todos]`), let's just do `@todos`. We need to adjust our route accordingly: `@todos = @storage.find_todos_for_list(@list_id)`. `find_todos_for_list` is private, but it doesn't need to be; let's make it public.

Lastly, we can extract our result hash into a method since it's being used in `find_list` and `all_lists`:

```ruby
def tuple_to_list_hash(tuple)
  {
    id: tuple['id'].to_i,
    name: tuple['name'],
    todos_count: tuple['todos_count'].to_i,
    todos_remaining_count: tuple['todos_remaining_count'].to_i
  }
end
```
