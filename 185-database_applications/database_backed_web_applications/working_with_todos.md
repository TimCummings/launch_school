
# Working with Todos - 8/17/2020

In this assignment, we'll continue the process of implementing methods in the `DatabasePersistence` class to restore the original functionality of the application. We'll focus on the methods that are required to create, complete, and delete todos.

### Practice Problems

1. Write a new implementation of `DatabasePersistence#create_new_todo` that inserts new rows into the database.

#### Solution

```ruby
def create_new_todo(list_id, todo_name)
  sql = 'INSERT INTO todos (name, list_id) VALUES ($1, $2);'
  query sql, todo_name, list_id
end
```

---

2. Write a new implementation of `DatabasePersistence#delete_todo_from_list` that removes the correct row from the `todos` table.

```ruby
def delete_todo_from_list(list_id, todo_id)
  sql = 'DELETE FROM todos WHERE list_id = $1 AND id = $2;'
  query sql, list_id, todo_id
end
```

---

3. Write a new implementation of `DatabasePersistence#update_todo_status` that updates a row in the database.

```ruby
def update_todo_status(list_id, todo_id, new_status)
  sql = 'UPDATE todos SET completed = $1 WHERE list_id = $2 AND id = $3;'
  query sql, new_status, list_id, todo_id
end
```

---

4. Write a new implementation of `DatabasePersistence#mark_all_todos_as_completed` that updates all rows in the database.

```ruby
def mark_all_todos_as_completed(list_id)
  query 'UPDATE todos SET completed = true WHERE list_id = $1;', list_id
end
```
