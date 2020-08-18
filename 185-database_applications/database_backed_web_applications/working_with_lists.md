
# Working with Lists - 8/17/2020

In this assignment, we'll continue the process of implementing methods in the `DatabasePersistence` class to restore the original functionality of the application. We'll focus on the methods that are required to create, edit, and delete lists.

### Practice Problems

1. Write a new implementation of `DatabasePersistence#create_new_list` that inserts new rows into the database.

#### Solution

```ruby
def create_new_list(name)
  sql = 'INSERT INTO lists (name) VALUES ($1);'
  query(sql, name);
end
```

---

2. Write a new implementation of `DatabasePersistence#delete_list` that removes the correct row from the `lists` table.

#### Solution

```ruby
def delete_list(id)
  sql = 'DELETE FROM lists WHERE id = $1;'
  query(sql, id)
end
```

#### Adjustments based on provided solution

We first have to delete any todos belonging to the list before deleting the list! Also, our queries our short and can be done on one line (same for previous problem.)

```ruby
def delete_list(id)
  query 'DELETE FROM todos WHERE list_id = $1;', id
  query 'DELETE FROM lists WHERE id = $1;', id
end
```

---

3. Write a new implementation of `DatabasePersistence#update_list_name` that updates a row in the database.

#### Solution

```ruby
def update_list_name(id, name)
  query 'UPDATE lists SET name = $1 WHERE id = $2;', name, id
end
```

---
