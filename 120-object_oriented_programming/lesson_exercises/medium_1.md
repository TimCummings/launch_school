
[comment]: # (medium_1.md)

# Medium 1 - 5/2/2017

---

#### 1. Ben asked Alyssa to code review the following code:
``` ruby
class BankAccount
  attr_reader :balance

  def initialize(starting_balance)
    @balance = starting_balance
  end

  def positive_balance?
    balance >= 0
  end
end
```
#### Alyssa glanced over the code quickly and said - "It looks fine, except that you forgot to put the `@` before `balance` when you refer to the `balance` instance variable in the body of the `positive_balance?` method."

#### "Not so fast", Ben replied. "What I'm doing here is valid - I'm not missing an `@`!"

#### Who is right, Ben or Alyssa, and why?
The code will work as Alyssa describes, but Ben is correct. The line `attr_reader :balance` defines a getter method for the instance variable `balance`, so while accessing that instance variable with `@balance` will work, it is more appropriate to use the getter method that has been defined, as Ben is already doing in the existing code with just `balance`.

---

#### 2. Alyssa created the following code to keep track of items for a shopping cart application she's writing:
``` ruby
class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    quantity = updated_count if updated_count >= 0
  end
end
```
#### Alan looked at the code and spotted a mistake. "This will fail when `update_quantity` is called", he says.

#### Can you spot the mistake and how to address it?
Alyssa is creating a local `quantity` variable in the `update_quantity` method instead of setting the instance variable `quantity`. This can be fixed a couple of ways:
1. Define either a setter method or attribute writer for `@quantity` (or change the attribute reader to an attribute accessor), and use `self.quantity` in the `update_quantity` method:
> * Setter Method:
> ``` ruby
> def quantity=(number_purchased)
>   @quantity = number_purchased
> end
> ```
> * or Attribute Writer:
> `attr_writer :quantity`
> * or Attribute Reader
> `attr_reader :quantity`
> * And inside `update_quantity`:
> ``` ruby
> def update_quantity(updated_count)
>   # prevent negative quantities from being set
>   self.quantity = updated_count if updated_count >= 0
> end
> ```

2. Access `@quantity` directly in the `update_quantity` method:
> ``` ruby
> def update_quantity(updated_count)
>  # prevent negative quantities from being set
>  @quantity = updated_count if updated_count >= 0
> end
>```

---

#### 3. Alan noticed that this will fail when update_quantity is called. Since `quantity` is an instance variable, it must be accessed with the `@quantity` notation when setting it. One way to fix this is to change `attr_reader` to `attr_accessor` and change `quantity` to `self.quantity`.

#### Is there anything wrong with fixing it this way?
The only potential issue with this solution is that it creates a setter method for the other instance variable, `@product_name`, which will not be used. It would be best to leave `attr_reader :product_name` and also add `attr_accessor :quantity`. Otherwise, this is the correct way of fixing this issue.

**Correction:** Adding `attr_accessor :quantity` directly exposes `@quantity` to users, bypassing the protection of the `update_quantity` method.

---

#### 4. Let's practice creating an object hierarchy.

#### Create a class called Greeting with a single method called greet that takes a string argument and prints that argument to the terminal.
``` ruby
class Greeting
  def greet(message)
    puts message
  end
end
```

#### Now create two other classes that are derived from Greeting: one called Hello and one called Goodbye. The Hello class should have a hi method that takes no arguments and prints "Hello". The Goodbye class should have a bye method to say "Goodbye". Make use of the Greeting class greet method when implementing the Hello and Goodbye classes - do not use any puts in the Hello or Goodbye classes.
``` ruby
class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end
```

---

#### 5. You are given the following class that has been implemented:
``` ruby
class KrispyKreme
  def initialize(filling_type, glazing)
    @filling_type = filling_type
    @glazing = glazing
  end
end
```
#### And the following specification of expected behavior:
``` ruby
donut1 = KrispyKreme.new(nil, nil)
donut2 = KrispyKreme.new("Vanilla", nil)
donut3 = KrispyKreme.new(nil, "sugar")
donut4 = KrispyKreme.new(nil, "chocolate sprinkles")
donut5 = KrispyKreme.new("Custard", "icing")

puts donut1
  => "Plain"

puts donut2
  => "Vanilla"

puts donut3
  => "Plain with sugar"

puts donut4
  => "Plain with chocolate sprinkles"

puts donut5
  => "Custard with icing"
```
#### Write additional code for `KrispyKreme` such that the `puts` statements will work as specified above.

``` ruby
class KrispyKreme
  def initialize(filling_type, glazing)
    @filling_type = filling_type
    @glazing = glazing
  end

  def to_s
    if @filling_type.nil?
      filling = 'Plain'
    else
      filling = @filling_type
    end
    if @glazing.nil?
      "#{filling}"
    else
      "#{filling} with #{@glazing}"
    end
  end
end
```

---

#### 6. If we have these two methods:
``` ruby
class Computer
  attr_accessor :template

  def create_template
    @template = "template 14231"
  end

  def show_template
    template
  end
end
```
#### and
``` ruby
class Computer
  attr_accessor :template

  def create_template
    self.template = "template 14231"
  end

  def show_template
    self.template
  end
end
```
#### What is the difference in the way the code works?
These two pieces of code will output the same thing. The two `create_template` methods work differently: the first directly accesses the instance variable with `@template`, while the second uses the setter method defined with `attr_accessor :template` by `self.template`. The two `show_template` methods look slightly different but function the same way: they are using the instance variable's getter method.

---

#### 7. How could you change the method name below so that the method name is more clear and less repetitive.
``` ruby
class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.light_information
    "I want to turn on the light with a brightness level of super high and a colour of green"
  end
end
```
It is redundant to include the class's name again in the method: `Light#light_information`. It should just be `Light#information` instead.
