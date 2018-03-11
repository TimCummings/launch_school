
[comment]: # (fix_the_program-drivable.md)

### Fix the Program - Drivable - 5/23/2017

#### Correct the following program so it will work properly. Assume that the `Car` class has a complete implementation; just make the smallest possible change to ensure that cars have access to the drive method.

``` ruby
module Drivable
  def self.drive
  end
end

class Car
  include Drivable
end

bobs_car = Car.new
bobs_car.drive
```

---

### Solution:

It's not immediately clear to me what this question is asking for. The `Drivable` module defines a class method (module method in this case?) with `self.drive` and the `Car` instance, `bobs_car` is trying to invoke `drive` as an instance method.

Since I am to assume that "the `Car` class has a complete implementation", I would modify the `Drivable::drive` class method to instead be an instance method:

``` ruby
module Drivable
  def drive
  end
end

class Car
  include Drivable
end

bobs_car = Car.new
bobs_car.drive
```
