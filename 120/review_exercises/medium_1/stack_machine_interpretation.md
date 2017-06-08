
[comment]: # (stack_machine_interpretation.md)

### Stack Machine Interpretation - 5/28/2017

#### You may remember our Minilang language from back in the 101 Medium exercises. We return to that language now, but this time we'll be using OOP. If you need a refresher, refer back to that exercise.

#### Write a class that implements a miniature stack-and-register-based programming language that has the following commands:

* #### `n` Place a value n in the "register". Do not modify the stack.
* #### `PUSH` Push the register value on to the stack. Leave the value in the register.
* #### `ADD` Pops a value from the stack and adds it to the register value, storing the result in the register.
* #### `SUB` Pops a value from the stack and subtracts it from the register value, storing the result in the register.
* #### `MULT` Pops a value from the stack and multiplies it by the register value, storing the result in the register.
* #### `DIV` Pops a value from the stack and divides it into the register value, storing the integer result in the register.
* #### `MOD` Pops a value from the stack and divides it into the register value, storing the integer remainder of the division in the register.
* #### `POP` Remove the topmost item from the stack and place in register
* #### `PRINT` Print the register value
* #### `All` operations are integer operations (which is only important with DIV and MOD).

#### Programs will be supplied to your language method via a string passed in as an argument. Your program should produce an error if an unexpected item is present in the string, or if a required stack value is not on the stack when it should be (the stack is empty). In all error cases, no further processing should be performed on the program.

#### You should initialize the register to 0.

#### Examples:

``` ruby
Minilang.new('PRINT').eval
# 0

Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)
```

---

### Solution:

``` ruby
class Minilang

  COMMANDS = %w[PUSH ADD SUB MULT DIV MOD POP PRINT].freeze

  def initialize(args)
    @register = 0
    @args = args.split
    @stack = []
  end

  def eval
    @args.each do |arg|
      if COMMANDS.include?(arg)
        send(arg.downcase)
      elsif number?(arg)
        @register = arg.to_i
      else
        token_error(arg)
      end
    end
  end

  private

  def push
    @stack.push(@register)
  end

  def pop
    stack_error unless @register = @stack.pop
  end

  def add
    stack_error unless @register += @stack.pop
  end

  def sub
    stack_error unless @register -= @stack.pop
  end

  def mult
    stack_error unless @register *= @stack.pop
  end

  def div
    stack_error unless @register /= @stack.pop
  end

  def mod
    stack_error unless @register %= @stack.pop
  end

  def print
    puts @register unless @register.nil?
  end

  def number?(string)
    string.to_i.to_s == string
  end

  def token_error(arg)
    puts "Invalid token: #{arg}"
  end

  def stack_error
    puts 'Empty stack!'
  end
end
```

---

### Refactoring:

* use `Set` instead of `Array`
* use actual `Exception`s instead of methods that pretend to act like them
* move majority of work into private helper method and let `eval` rescue exceptions
* use `Minilang#pop` instead of `Array#pop` allowing stack exceptions to be raised from a single method

``` ruby
require 'set'

class MinilangError < RuntimeError; end
class BadTokenError < MinilangError; end
class EmptyStackError < MinilangError; end

class Minilang
  COMMANDS = Set.new %w[PUSH ADD SUB MULT DIV MOD POP PRINT]

  def initialize(args)
    @register = 0
    @args = args.split
    @stack = []
  end

  def eval
    @args.each { |arg| eval_argument(arg) }
  rescue MinilangError => exception
    puts exception.message
  end

  private

  def eval_argument(arg)
    if COMMANDS.include?(arg)
      send(arg.downcase)
    elsif number?(arg)
      @register = arg.to_i
    else
      raise BadTokenError, "Invalid token: #{arg}"
    end
  end

  def push
    @stack.push(@register)
  end

  def pop
    raise EmptyStackError, 'Empty stack!' if @stack.empty?
    @register = @stack.pop
  end

  def add
    @register += pop
  end

  def sub
    @register -= pop
  end

  def mult
    @register *= pop
  end

  def div
    @register /= pop
  end

  def mod
    @register %= pop
  end

  def print
    puts @register unless @register.nil?
  end

  def number?(string)
    string.to_i.to_s == string
  end
end
```

---

### Further Exploration

#### You can write minilang programs that take input values by simply interpolating values into the program string with 1. For instance,

``` ruby
CENTIGRADE_TO_FAHRENHEIT =
  '5 PUSH %<degrees_c>d PUSH 9 MULT DIV PUSH 32 ADD PRINT'
Minilang.new(format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: 100)).eval
# 212
Minilang.new(format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: 0)).eval
# 32
Minilang.new(format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: -40)).eval
# -40
```

#### This process could be simplified by passing some optional parameters to eval, and using those parameters to modify the program string.

``` ruby
CENTIGRADE_TO_FAHRENHEIT =
  '5 PUSH %<degrees_c>d PUSH 9 MULT DIV PUSH 32 ADD PRINT'
minilang = Minilang.new(CENTIGRADE_TO_FAHRENHEIT)
minilang.eval(degrees_c: 100)
# 212
minilang.eval(degrees_c: 0)
# 32
minilang.eval(degrees_c: -40)
# -40
```

#### Try to implement this modification. Also, try writing other minilang programs, such as one that converts fahrenheit to centigrade, another that converts miles per hour to kilometers per hour (3 mph is approximately equal to 5 kph). Try writing a program that needs two inputs: for example, compute the area of a rectangle.

---

### Format Interpolation Minilang with Centigrade to Fahrenheit

``` ruby
require 'set'

class MinilangError < RuntimeError; end
class BadTokenError < MinilangError; end
class EmptyStackError < MinilangError; end

class Minilang
  COMMANDS = Set.new %w[PUSH ADD SUB MULT DIV MOD POP PRINT]

  def initialize(token_string)
    @register = 0
    @token_string = token_string
    @stack = []
  end

  def eval(arg_hash = nil)
    tokens = if arg_hash.nil?
        @token_string
      else
        format(@token_string, arg_hash)
      end

    tokens.split.each { |token| eval_token(token) }
  rescue MinilangError => exception
    puts exception.message
  end

  private

  def eval_token(token)
    if COMMANDS.include?(token)
      send(token.downcase)
    elsif number?(token)
      @register = token.to_i
    else
      raise BadTokenError, "Invalid token: #{token}"
    end
  end

  def push
    @stack.push(@register)
  end

  def pop
    raise EmptyStackError, 'Empty stack!' if @stack.empty?
    @register = @stack.pop
  end

  def add
    @register += pop
  end

  def sub
    @register -= pop
  end

  def mult
    @register *= pop
  end

  def div
    @register /= pop
  end

  def mod
    @register %= pop
  end

  def print
    puts @register unless @register.nil?
  end

  def number?(string)
    string.to_i.to_s == string
  end
end

CENTIGRADE_TO_FAHRENHEIT =
  '5 PUSH %<degrees_c>d PUSH 9 MULT DIV PUSH 32 ADD PRINT'
Minilang.new(format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: 100)).eval
# 212
Minilang.new(format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: 0)).eval
# 32
Minilang.new(format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: -40)).eval
# -40

NEW_CENTIGRADE_TO_FAHRENHEIT =
  '5 PUSH %<degrees_c>d PUSH 9 MULT DIV PUSH 32 ADD PRINT'
minilang = Minilang.new(NEW_CENTIGRADE_TO_FAHRENHEIT)
minilang.eval(degrees_c: 100)
# 212
minilang.eval(degrees_c: 0)
# 32
minilang.eval(degrees_c: -40)
# -40
```

---

### Fahrenheit to Centigrade Minilang

``` ruby
FAHRENHEIT_TO_CENTIGRADE =
  '9 PUSH 5 PUSH 32 PUSH %<degrees_f>d SUB MULT DIV PRINT'
Minilang.new(format(FAHRENHEIT_TO_CENTIGRADE, degrees_f: 212)).eval
# 100
Minilang.new(format(FAHRENHEIT_TO_CENTIGRADE, degrees_f: 32)).eval
# 0
Minilang.new(format(FAHRENHEIT_TO_CENTIGRADE, degrees_f: -40)).eval
# -40

NEW_FAHRENHEIT_TO_CENTIGRADE =
  '9 PUSH 5 PUSH 32 PUSH %<degrees_f>d SUB MULT DIV PRINT'
minilang = Minilang.new(NEW_FAHRENHEIT_TO_CENTIGRADE)
minilang.eval(degrees_f: 212)
# 100
minilang.eval(degrees_f: 32)
# 0
minilang.eval(degrees_f: -40)
# -40
```

---

### Miles per Hour to Kilometers per Hour Minilang

``` ruby
MPH_TO_KPH =
  '3 PUSH 5 PUSH %<mph>d MULT DIV PRINT'
Minilang.new(format(MPH_TO_KPH, mph: 3)).eval
# 5
Minilang.new(format(MPH_TO_KPH, mph: 60)).eval
# 100
Minilang.new(format(MPH_TO_KPH, mph: 200)).eval
# 333

NEW_MPH_TO_KPH =
  '3 PUSH 5 PUSH %<mph>d MULT DIV PRINT'
minilang = Minilang.new(NEW_MPH_TO_KPH)
minilang.eval(mph: 3)
# 5
minilang.eval(mph: 60)
# 100
minilang.eval(mph: 200)
# 333
```

---

### Area of Rectangle Minilang

``` ruby
RECTANGLE_AREA =
  '%<width>d PUSH %<length>d MULT PRINT'
Minilang.new(format(RECTANGLE_AREA, width: 3, length: 5)).eval
# 15
Minilang.new(format(RECTANGLE_AREA, width: 60, length: 15)).eval
# 900
Minilang.new(format(RECTANGLE_AREA, width: 22, length: 18)).eval
# 396

NEW_RECTANGLE_AREA =
  '%<width>d PUSH %<length>d MULT PRINT'
minilang = Minilang.new(NEW_RECTANGLE_AREA)
minilang.eval(width: 3, length: 5)
# 15
minilang.eval(width: 60, length: 15)
# 900
minilang.eval(width: 22, length: 18)
# 396
```
