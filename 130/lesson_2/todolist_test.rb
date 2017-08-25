require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

require_relative 'todo_list'

require 'pry'

class TodoListTest < Minitest::Test

  def setup
    @todo1 = Todo.new('Buy milk')
    @todo2 = Todo.new('Clean room')
    @todo3 = Todo.new('Go to gym')
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

  def test_shovel
    @list << @todo1
    assert_equal(4, @list.size)
    assert_instance_of(Todo, @list.last)
  end

  def test_add
    @list.add(@todo1)
    assert_equal(4, @list.size)
    assert_instance_of(Todo, @list.last)
  end

  def test_add_with_wrong_type
    assert_raises(TypeError) { @list << 'Not a Todo object' }
    assert_raises(TypeError) { @list << 100 }
    assert_raises(TypeError) { @list << TodoList.new('') }
  end

  def test_size
    assert_equal(3, @list.size)
  end

  def test_first
    assert_equal(@todo1, @list.first)
  end

  def test_last
    assert_equal(@todo3, @list.last)
  end

  def test_shift
    assert_equal(@todo1, @list.shift)

    shifted_list = TodoList.new(@list.title)
    shifted_list << @todo2 << @todo3
    assert_equal(shifted_list, @list)
  end

  def test_pop
    assert_equal(@todo3, @list.pop)

    popped_list = TodoList.new(@list.title)
    popped_list << @todo1 << @todo2
    assert_equal(popped_list, @list)
  end

  def test_item_at
    assert_equal(@todo1, @list.item_at(0))
    assert_raises(IndexError) { @list.item_at(100) }
  end

  def test_mark_done_at
    assert_equal(false, @list.item_at(1).done?)
    @list.mark_done_at(1)
    assert(@list.item_at(1).done?)
    assert_equal(false, @list.first.done?)
    assert_equal(false, @list.last.done?)

    assert_raises(IndexError) { @list.mark_done_at(100) }
  end

  def test_mark_undone_at
    @list.done!
    assert(@list.item_at(1).done?)
    @list.mark_undone_at(1)

    assert(@list.first.done?)
    assert_equal(false, @list.item_at(1).done?)
    assert(@list.last.done?)


    assert_raises(IndexError) { @list.mark_undone_at(100) }
  end

  def test_done?
    assert_equal(false, @list.done?)

    @list.done!
    assert(@list.done?)
  end

  def test_done!
    assert(@todos.none?(&:done?))
    @list.done!
    assert(@todos.all?(&:done?))
  end

  def test_undone!
    @list.done!
    assert(@todos.all?(&:done?))
    @list.undone!
    assert(@todos.none?(&:done?))
  end

  def test_remove_at
    removed_list = TodoList.new(@list.title)
    removed_list << @todo1 << @todo3
    @list.remove_at(1)
    assert_equal(removed_list, @list)

    assert_raises(IndexError) { @list.remove_at(100) }
  end

  def test_to_s
    expected = <<~HEREDOC.chomp
      ---- Today's Todos ----
      [ ] Buy milk
      [ ] Clean room
      [ ] Go to gym
    HEREDOC

    assert_equal(expected, @list.to_s)
  end

  def test_to_s_with_one_done
    expected = <<~HEREDOC.chomp
    ---- Today's Todos ----
    [ ] Buy milk
    [X] Clean room
    [ ] Go to gym
    HEREDOC

    @list.mark_done_at(1)
    assert_equal(expected, @list.to_s)
  end

  def test_to_s_with_all_done
    expected = <<~HEREDOC.chomp
    ---- Today's Todos ----
    [X] Buy milk
    [X] Clean room
    [X] Go to gym
    HEREDOC

    @list.done!
    assert_equal(expected, @list.to_s)
  end

  def test_to_a
    assert_equal(@todos, @list.to_a)
  end

  def test_each
    actual = []
    @list.each { |todo| actual << todo }
    assert_equal(@todos, actual)
  end

  def test_each_return
    assert_equal(@list, @list.each {})
  end

  def test_select
    actual = @list.select { true }
    assert_equal(@list, actual)
    refute_same(@list, actual)
  end

  def test_find_by_title
    assert_same(@todo2, @list.find_by_title('Clean room'))
    assert_nil(@list.find_by_title('not in the list'))
  end

  def test_mark_done
    assert(@todos.none?(&:done?))
    @list.mark_done('Clean room')
    assert(@todo2.done?)
    assert_nil(@list.mark_done('not in the list'))
  end

  def test_all_done
    assert_equal([], @list.all_done.to_a)

    @list.mark_done_at(1)
    assert_equal([@todo2], @list.all_done.to_a)

    @list.done!
    assert_equal(@todos, @list.all_done.to_a)
  end

  def test_all_not_done
    assert_equal(@todos, @list.all_not_done.to_a)

    @list.mark_done_at(1)
    assert_equal([@todo1, @todo3], @list.all_not_done.to_a)

    @list.done!
    assert_equal([], @list.all_not_done.to_a)
  end
end
