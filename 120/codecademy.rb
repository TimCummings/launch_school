# codecademy.rb

# class Account
#   def initialize(name, balance = 100)
#       @name = name
#       @balance = balance
#   end
#
#   def to_s
#     puts "Account: #{@name}"
#     puts "Balance: $#{@balance}"
#   end
#
#   def display_balance(pin_number)
#       if pin_number == pin
#           puts "Balance: $#{@balance}."
#       else
#           puts pin_error
#       end
#   end
#
#   def deposit(amount)
#       @balance += amount
#       puts "Deposited $#{amount}. New balance: $#{@balance}."
#   end
#
#   def withdraw(pin_number, amount)
#       if pin_number != pin
#          puts pin_error
#       elsif overdraft?(amount)
#           puts "Insufficient funds."
#       else
#          @balance -= amount
#          puts "Withdrew $#{amount}. New balance: $#{@balance}."
#       end
#   end
#
#   private
#   attr_reader :name, :balance
#
#   def pin
#       @pin = 1234
#   end
#
#   def pin_error
#       "Access denied: incorrect PIN."
#   end
#
#   def overdraft?(amount)
#       @balance < amount
#   end
# end



class Computer

  @@users = Hash.new

  def self.get_users
    @@users
  end

  attr_reader :username, :location_services

  def initialize(username, password, location_services = false)
    @@users[username] = password
    @username = username
    @password = password
    @location_services = location_services
    @files = Hash.new
  end

  def create_file(filename, contents)
    time = Time.now
    @files[filename] = [@username, time, contents]
    puts "User #{@username} created filed #{filename} at time #{time}."
  end

  def delete_file(filename)
    if @files.delete(filename)
      puts "File #{filename} deleted!"
    else
      puts "File #{filename} does not exist!"
    end
  end

  def update_file(filename, contents)
    if @files.has_key?(filename)
      @files[filename][2] = contents
      puts "File #{filename} has been updated!"
    else
      puts "File #{filename} does not exist!"
    end
  end

  def read_file(filename)
    if @files.has_key?(filename)
      puts "Reading file: #{filename}"
      puts "Created by: #{@files[filename][0]}"
      puts "At time: #{@files[filename][1]}"
      puts "-------------------------------------------------------"
      puts @files[filename][2]
    else
      puts "File #{filename} does not exist!"
    end
  end

  private

  attr_writer :username, :location_services
  attr_accessor :password

end

my_pc = Computer.new('MarcoPolo', 'HelloWorld!')
