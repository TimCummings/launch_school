# book_exercises.rb

# # 1.1
# class Thing
# end
#
# this_thing = Thing.new



# # 1.2
# # A module is a way to define functionality that can be shared or "mixed in" with multiple classes that don't necessarily share a superclass. However, a module cannot be instantiated as an object. Once a module is defined (similarly to a class but with the keyword "module" instead of "class"), it can be mixed in with a class using the keyword "include".
#
# module Inanimate
#   def speak
#     puts "I can't talk - I'm not alive!"
#   end
# end
#
# class Thing
#   include Inanimate
# end
#
# this_thing = Thing.new
# this_thing.speak



# 2.1, 2.2, 2.3; 3.1, 3.2; 4.1, 4.2, 4.3, 4.5, 4.6
module Towable
  def tow(load)
    puts "I'm towing #{load}!"
  end
end

class Vehicle
  @@number_of_vehicles = 0

  def self.total_vehicles
    @@number_of_vehicles
  end

  def self.gas_mileage(miles, gallons)
    puts "This Vehicle gets #{miles / gallons} miles per gallon."
  end

  attr_accessor :color, :speed
  attr_reader :year, :model

  def initialize(year, color, model)
    @@number_of_vehicles += 1
    @year = year
    @color = color
    @model = model
    @speed = 0
  end

  def accelerate(mph)
    puts "You accelerate to #{self.speed += mph} mph."
  end

  def brake(mph)
    puts "You decelerate to #{self.speed -= mph} mph."
  end

  def shut_off
    self.speed = 0
    puts "You stop and turn off your #{self.model}."
  end

  def spray_paint(color)
    self.color = color
    puts "Your car has been painted #{self.color}!"
  end

  def to_s
    "#{self.year} #{self.color} #{self.model} travelling at #{self.speed} mph"
  end

  def age
    puts "This #{self.year} #{self.model} is #{calculate_age} years old."
  end

  private

  def calculate_age
    Time.now.year - self.year
  end
end

class MyCar < Vehicle
  BODY_TYPE = :car
end

class Truck < Vehicle
  include Towable

  BODY_TYPE = :truck
end

lumina = MyCar.new(1997, 'white', 'Chevy Lumina')
pickup = Truck.new(2015, 'gray', 'F150')
puts lumina
lumina.accelerate(35)
lumina.brake(5)
lumina.accelerate(50)
lumina.shut_off

puts "My car is painted: #{lumina.color}."
lumina.color = 'blue'
puts "My car is now painted: #{lumina.color}."

puts "My car was made in: #{lumina.year}."

lumina.spray_paint('green')
puts lumina.color

# 3.1
MyCar.gas_mileage(300, 16)

# 3.2
puts lumina



# 3.3
# This error is due to the name instance variable being defined with `attr_reader`, which only creates a getter method, not a setter method. This is best fixed by changing `attr_reader` to `attr_accessor`, which will create the getter and setter methods for the name instance variable.



# 4.4
puts Vehicle.ancestors
puts MyCar.ancestors
puts Truck.ancestors



# 4.7
class Student
  attr_accessor :name

  def initialize(name, grade)
    self.name = name
    self.grade = grade
  end

  def better_grade_than?(peer)
    self.grade > peer.grade
  end

  protected

  attr_accessor :grade
end

joe = Student.new('Joe', 95)
bob = Student.new('Bob', 86)
puts "Well done!" if joe.better_grade_than?(bob)



# 4.8
`bob.hi` is trying to call a method (`hi`) that is defined in the `Person` class as a `private` method. In order for `bob.hi` to work as shown, the `hi` method in the `Person` class needs to be moved to the `public` section of the class.




class Box
  def initialize(w,h) # Initialize the width and height
    @width,@height = w, h
  end

  def +(other)         # Define + to do vector addition
    Box.new(@width + other.width, @height + other.height)
  end

  def -@               # Define unary minus to negate width and height
    Box.new(-@width, -@height)
  end

  def *(scalar)        # To perform scalar multiplication
    Box.new(@width*scalar, @height*scalar)
  end
end
