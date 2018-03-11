# lesson_2.rb

# 1
class Person
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end



# 2
class Person
  attr_reader :first_name
  attr_accessor :last_name

  def initialize(name)
    @first_name, @last_name = name.split
    @first_name = '' if @first_name.nil?
    @last_name = '' if @last_name.nil?
  end

  def name
    "#{first_name} #{last_name}".strip
  end
end



# 3
class Person
  attr_accessor :first_name, :last_name

  def initialize(name)
    name_separator(name)
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def name=(name)
    name_separator(name)
  end

  private

  def name_separator(full_name)
    @first_name, @last_name = full_name.split
    @first_name = '' if @first_name.nil?
    @last_name = '' if @last_name.nil?
  end
end



# 4

# As far as our class is currently concerned, the only state that is maintained is `first_name` and `last_name`. Even though in the real world, two different people can share first and last names, and not be the same person, our class currently has no way to track this. So currently, we could compare for equality by checking that both objects are instances of this `Person` class, and both objects have the same `first_name` and `last_name`.

class Person
  attr_accessor :first_name, :last_name

  def initialize(name)
    name_separator(name)
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def name=(name)
    name_separator(name)
  end

  def ==(other)
    (self.first_name == other.first_name) &&
    (self.last_name == other.last_name) &&
    (self.class == other.class)
  end

  private

  def name_separator(full_name)
    @first_name, @last_name = full_name.split
    @first_name = '' if @first_name.nil?
    @last_name = '' if @last_name.nil?
  end
end



# 5
# Since we have not defined a `to_s` method, it will print using `Object`'s `to_s` method, which prints a "string representing `obj`" which is the name of the class and an encoding of the instance's object ID.

class Person
  attr_accessor :first_name, :last_name

  def initialize(name)
    name_separator(name)
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def name=(name)
    name_separator(name)
  end

  def ==(other)
    (self.first_name == other.first_name) &&
    (self.last_name == other.last_name) &&
    (self.class == other.class)
  end

  def to_s
    name
  end

  private

  def name_separator(full_name)
    @first_name, @last_name = full_name.split
    @first_name = '' if @first_name.nil?
    @last_name = '' if @last_name.nil?
  end
end

# With the `to_s` method now overriden, it will print the object's `first_name` and `last_name`, just like the `name` method (which `to_s` is now calling).
