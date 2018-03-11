
[comment]: # (pet_shelter.md)

### Pet Shelter - 5/24/2017

#### Consider the following code:

``` ruby
butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
```

#### Write the classes and methods that will be necessary to make this code run, and print the following output:

```
P Hanson has adopted the following pets:
a cat named Butterscotch
a cat named Pudding
a bearded dragon named Darwin

B Holmes has adopted the following pets:
a dog named Molly
a parakeet named Sweetie Pie
a dog named Kennedy
a fish named Chester

P Hanson has 3 adopted pets.
B Holmes has 4 adopted pets.
```

#### The order of the output does not matter, so long as all of the information is presented.

---

### Initial Solution:

``` ruby
class Pet
  attr_reader :type, :name

  def initialize(type, name)
    @type = type
    @name = name
  end
end

class Owner
  attr_reader :name
  attr_accessor :number_of_pets

  def initialize(name)
    @name = name
    @number_of_pets = 0
  end
end

class Shelter
  attr_reader :owners

  def initialize
    @owners = {}
  end

  def adopt(owner, pet)
    if owners[owner].nil?
      owners[owner] = [pet]
    else
      owners[owner] << pet
    end

    owner.number_of_pets += 1
  end

  def print_adoptions
    owners.each do |owner, pets|
      puts "#{owner.name} has adopted the following pets:"

      pets.each do |pet|
        puts "a #{pet.type} named #{pet.name}"
      end
      puts
    end
  end
end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
```

---

### Second Take:

#### In my initial solution, the `Shelter` class was doing all the legwork; I made this decision due `shelter.print_adoptions` in the provided code. I think it makes more sense to localize some of the work to the `Owner` and `Pet` classes.

``` ruby
class Pet
  def initialize(type, name)
    @type = type
    @name = name
  end

  def to_s
    "a #{@type} named #{@name}"
  end
end

class Owner
  attr_reader :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end

  def adopt(pet)
    pets << pet
  end

  def print_pets
    pets.each do |pet|
      puts pet
    end
  end

  def number_of_pets
    pets.size
  end

  def to_s
    "#{name}"
  end
end

class Shelter

  attr_reader :owners

  def initialize
    @owners = []
  end

  def adopt(owner, pet)
    owner.adopt(pet)
    owners << owner unless owners.include?(owner)
  end

  def print_adoptions
    owners.each do |owner|
      puts "#{owner} has adopted the following pets:"
      owner.print_pets
      puts
    end
  end
end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
```

---

### Further Exploration

#### Add your own name and pets to this project.

``` ruby
me = Owner.new('T Cummings')
josie = Pet.new('collie', 'Josie')
dc = Pet.new('cat', 'DC')
shelter.adopt(me, josie)
shelter.adopt(me, dc)
```

#### Suppose the shelter has a number of not-yet-adopted pets, and wants to manage them through this same system. Thus, you should be able to add the following output to the example output shown above:

```
The Animal Shelter has the following unadopted pets:
a dog named Asta
a dog named Laddie
a cat named Fluffy
a cat named Kat
a cat named Ben
a parakeet named Chatterbox
a parakeet named Bluebell
   ...

P Hanson has 3 adopted pets.
B Holmes has 4 adopted pets.
The Animal shelter has 7 unadopted pets.
```

#### Can you make these updates to your solution?

``` ruby
class Pet
  def initialize(type, name)
    @type = type
    @name = name
  end

  def to_s
    "a #{@type} named #{@name}"
  end
end

class Owner
  attr_reader :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end

  def adopt(pet)
    pets << pet
  end

  def print_pets
    pets.each do |pet|
      puts pet
    end
  end

  def number_of_pets
    pets.size
  end

  def to_s
    "#{name}"
  end
end

class Shelter

  attr_reader :owners, :unadopted_pets

  def initialize
    @owners = []
    @unadopted_pets = []
  end

  def adopt(owner, pet)
    owner.adopt(pet)
    owners << owner unless owners.include?(owner)
    unadopted_pets.delete(pet)
  end

  def print_adoptions
    owners.each do |owner|
      puts "#{owner} has adopted the following pets:"
      owner.print_pets
      puts
    end

    print_pets
  end

  def print_pets
    puts "#{self} has the following unadopted pets:"
    unadopted_pets.each do |pet|
      puts pet
    end
  end

  def intake(*pets)
    unadopted_pets.concat pets
  end

  def number_of_pets
    unadopted_pets.size
  end

  def to_s
    'The Animal Shelter'
  end
end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')
josie        = Pet.new('collie', 'Josie')
dc           = Pet.new('cat', 'DC')
asta         = Pet.new('dog', 'Asta')
laddie       = Pet.new('dog', 'Laddie')
fluffy       = Pet.new('cat', 'Fluffy')
kat          = Pet.new('cat', 'Kat')
ben          = Pet.new('cat', 'Ben')
chatterbox   = Pet.new('parakeet', 'Chatterbox')
bluebell     = Pet.new('parakeet', 'Bluebell')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')
me = Owner.new('T Cummings')

shelter = Shelter.new
shelter.intake(butterscotch, pudding, darwin, kennedy, sweetie, molly, chester, josie, dc, asta, laddie, fluffy, kat, ben, chatterbox, bluebell)
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
puts "#{shelter} has #{shelter.number_of_pets} unadopted pets."
```

#### Did you need to change your class system at all? Were you able to make all of your changes without modifying the existing interface?

I was able to keep the class system intact and just add the missing interface elements to the `Shelter` class. These elements were almost identical to the interface in the `Owner` class - I'm tempted to explore an `Ownership` or `Ownable` module.
