# This class represents a todo item and its associated
# data: name and description. There's also a "done"
# flag to show whether this todo item is done.

class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description = '')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end
end



# This class represents a collection of Todo objects.
# You can perform typical collection-oriented actions
# on a TodoList object, including iteration and selection.

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  def <<(todo)
    raise(TypeError, 'Can only add Todo objects') unless todo.class == Todo
    @todos << todo
  end
  alias_method :add, :<<

  def size
    @todos.size
  end

  def first
    @todos.first
  end

  def last
    @todos.last
  end

  def shift
    @todos.shift
  end

  def pop
    @todos.pop
  end

  def item_at(idx)
    @todos.fetch(idx)
  end

  def mark_done_at(idx)
    item_at(idx).done!
  end

  def mark_undone_at(idx)
    item_at(idx).undone!
  end

  def done?
    @todos.all? { |todo| todo.done? }
  end

  def done!
    each { |todo| todo.done! }
  end
  alias_method :mark_all_done, :done!

  def undone!
    each { |todo| todo.undone! }
  end
  alias_method :mark_all_undone, :undone!

  def remove_at(idx)
    @todos.delete(item_at(idx))
  end

  def to_s
    puts "---- #{title} ----"
    each { |todo| puts todo }
  end

  def to_a
    @todos
  end

  def each
    @todos.each { |todo| yield(todo) }
    self
  end

  def select
    result = TodoList.new(title)
    each { |todo| result << todo if yield(todo) }
    result
  end

  # returns first Todo by title, or nil if no match
  def find_by_title(string)
    each { |todo| return todo if todo.title == string }
    nil
  end

  def mark_done(string)
    result = find_by_title(string)
    result.nil? ? nil : result.done!
  end

  def all_done
    select { |todo| todo.done? }
  end

  def all_not_done
    select { |todo| !todo.done? }
  end
end

todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")

list = TodoList.new("Today's Todos")
list.add(todo1)
list.add(todo2)
list.add(todo3)

puts list

todo1.done!

results = list.select { |todo| todo.done? }    # you need to implement this method

puts results.inspect
