# book_exercises.rb

# # 1.1
# # In Ruby, objects are created using a class's `new` method:
# class MyClass
# end
#
# MyClass.new

# # 1.2
# # A module is one way to achieve polymorphism in Ruby: they allow the programmer to define additional behaviors (such as methods) that can be applied, or mixed-in, to other classes instead of having to create an entirely new class to accomodate the additional behaviors.
# module Intro
#   def greet
#     puts "Hello, World!"
#   end
# end
#
# class MyClass
#   include Intro
# end



# # 2.1, 2.2, 2.3; 3.1, 3.2
# class MyCar
#
#   attr_reader :year, :model
#   attr_accessor :color
#
#   def self.gas_mileage(gallons, miles)
#     puts "#{miles / gallons} miles per gallon of gas."
#   end
#
#   def to_s
#     "This vehicle is: #{self.color} #{self.year} #{self.model}."
#   end
#
#   def initialize(year, color, model)
#     @year = year
#     @color = color
#     @model = model
#     @speed = 0
#   end
#
#   def accelerate(mph)
#     @speed += mph
#     puts "You accelerate #{mph} miles per hour."
#   end
#
#   def brake(mph)
#     @speed -= mph
#     puts "You decelerate #{mph} miles per hour."
#   end
#
#   def speed
#     puts "You are going #{@speed} miles per hour."
#   end
#
#   def shut_off
#     @speed = 0
#     puts "You turn off this car."
#   end
#
#   def spray_paint(color)
#     self.color = color
#     puts "Your #{@model} has been painted #{self.color}."
#   end
# end
#
# lumina = MyCar.new(1997, 'white', 'chevy lumina')
# lumina.accelerate(20)
# lumina.speed
# lumina.accelerate(20)
# lumina.speed
# lumina.brake(20)
# lumina.speed
# lumina.brake(20)
# lumina.speed
# lumina.shut_off
# lumina.speed
#
# puts lumina.year
#
# puts lumina.color
# puts lumina.color = 'red'
# puts lumina.color
#
# lumina.spray_paint('chartreuse')



# # 3.3
# class Person
#   attr_reader :name
#   def initialize(name)
#     @name = name
#   end
# end
#
# bob = Person.new("Steve")
# bob.name = "Bob"
#
# # We get an undefined method error (for `name=`) because the `Person` class only defined an `attr_reader` for `name`, not a `writer` or `accessor`; as such, only a getter method is available, not a setter. This can be resolved by changing `name`'s `attr_reader` to an `attr_accessor` or `attr_writer` (if getter functionality is no longer needed):
#
# class Person
#   attr_accessor :name
#   # attr_writer :name
#   def initialize(name)
#     @name = name
#   end
# end
#
# bob = Person.new("Steve")
# bob.name = "Bob"



# # 4.1, 4.2, 4.3, 4.5, 4.6
# module Towing
#   def tow
#     puts "Four wheel drive enabled."
#   end
# end
#
# class Vehicle
#   attr_reader :year, :model
#   attr_accessor :color, :speed
#
#   @@total_vehicles = 0
#
#   def self.how_many_vehicles
#     @@total_vehicles
#   end
#
#   def initialize(year, model, color)
#     @year = year
#     @model = model
#     self.color = color
#     self.speed = 0
#     @@total_vehicles += 1
#   end
#
#   def self.gas_mileage(gallons, miles)
#     puts "#{miles / gallons} miles per gallon of gas."
#   end
#
#   def accelerate(mph)
#     @speed += mph
#     puts "You accelerate #{mph} miles per hour."
#   end
#
#   def brake(mph)
#     @speed -= mph
#     puts "You decelerate #{mph} miles per hour."
#   end
#
#   def shut_off
#     @speed = 0
#     puts "You turn off this car."
#   end
#
#   def spray_paint(color)
#     self.color = color
#     puts "Your #{self.model} has been painted #{self.color}."
#   end
#
#   def age
#     puts "This vehicle is #{calculate_age} years old."
#   end
#
#   private
#
#   def calculate_age
#     Time.now.year - self.year
#   end
# end
#
# class MyCar < Vehicle
#   BODY_TYPE = :sedan
# end
#
# class MyTruck < Vehicle
#   include Towing
#
#   BODY_TYPE = :truck
# end
#
# pinto = MyCar.new(1970, 'Ford Pinto', 'puce')
# f150 = MyTruck.new(2006, 'Ford F150', 'grey')



# # 4.4
# puts Vehicle.ancestors
# puts MyCar.ancestors
# puts MyTruck.ancestors



# # 4.7
# class Student
#   def initialize(name, grade)
#     @name = name
#     @grade = grade
#   end
#
#   def better_grade_than?(peer)
#     grade > peer.grade
#   end
#
#   protected
#
#   def grade
#     @grade
#   end
# end
#
# joe = Student.new('Joe', 95)
# bob = Student.new('Bob', 89)
# joe.grade
# joe.grade = (71)
# joe.better_grade_than?(bob)



# 4.8
# The `hi` instance method in the `Person` class is a private method. The `hi` method definition either needs to be moved to the public section of the class definition, or a separate public instance method needs to be created that can call `hi`.
