
[comment]: # (fix_the_program-flight_data.md)

### Fix the Program - Flight Data - 5/22/2017

#### Consider the following class definition:

``` ruby
class Flight
  attr_accessor :database_handle

  def initialize(flight_number)
    @database_handle = Database.init
    @flight_number = flight_number
  end
end
```

#### There is nothing technically incorrect about this class, but the definition may lead to problems in the future. How can this class be fixed to be resistant to future problems?

---

### Solution:

``` ruby
class Flight
  attr_accessor :database_handle

  def initialize(flight_number)
    self.database_handle = Database.init
    @flight_number = flight_number
  end
end
```

Instead of accessing the `@database_handle` instance variable directly, since a setter method is defined with `attr_accessor`, `initialize` should use this setter method. If the way `@database_handle` is set needs to be changed in the future, in only needs to be changed one place, in the setter method.

---

### Correct Answer:

Remove `attr_accessor :database_handle`. This is an implementation detail that needs to be encapsulated and not made accessible as part of the `Flight` class. Users of the `Flight` class should be able to access the underlying database (for security and reliability). Also, this ties the `Flight` class too strongly to this specific database implementation - `Flight` will be harder to maintain and extend in the future.
