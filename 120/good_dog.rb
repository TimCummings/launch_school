# # good_dog.rb
#
# module Swimmable
#   def swim
#     "I'm swimming!"
#   end
# end
#
# class Animal
#   attr_accessor :name
#
#   def initialize(name)
#     @name = name
#   end
#
#   def speak
#     "Hello!"
#   end
#
#   def a_public_method
#     "Will this work? " + self.a_protected_method
#   end
#
#   protected
#
#   def a_protected_method
#     "Yes, I'm protected!"
#   end
# end
#
# class Fish < Animal
#   include Swimmable
# end
#
# class GoodDog < Animal
#   include Swimmable
#
#   DOG_YEARS = 7
#
#   attr_accessor :name, :age
#
#   @@number_of_dogs = 0
#
#   def self.total_number_of_dogs
#     @@number_of_dogs
#   end
#
#   def self.what_am_i
#     "I'm a GoodDog class!"
#   end
#
#   def initialize(age, name)
#     super(name)
#     @@number_of_dogs += 1
#     self.age = age
#   end
#
#   # def to_s
#   #   "This dog's name is #{self.name} and it is #{self.age} in dog years."
#   # end
#
#   def speak
#     super + " from GoodDog class!"
#   end
#
#   def public_disclosure
#     "#{self.name} in human years is #{human_years}."
#   end
#
#   private
#
#   def human_years
#     age * DOG_YEARS
#   end
# end
#
# class BadDog < Animal
#   include Swimmable
#
#   def initialize(name, age)
#     super(name)
#     @age = age
#   end
# end
#
# class Cat < Animal
# end
#
# # sparky = GoodDog.new(8, 'Sparky')
# # puts sparky
# # p sparky
# # puts sparky.speak
# # puts sparky.swim
# # puts sparky.public_disclosure
# #
# # bear = BadDog.new('Bear', 2)
# # p bear
# # puts bear.swim
# #
# # paws = Cat.new("Paws")
# # puts paws.speak
#
# fido = Animal.new('Fido')
# puts fido.a_public_method
# puts Animal.a_protected_method



class Parent
  def say_hi
    p "Hi from Parent."
  end
end

class Child < Parent
  def say_hi
    p "Hi from Child."
  end

  def send
    p "send from Child... "
  end

  def instance_of?
    p "I am a fake instance."
end
