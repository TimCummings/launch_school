# echo_roll_qp_args_server.rb

# require 'socket'
#
# ROLLS_DEFAULT = 1
# SIDES_DEFAULT = 6
#
# server = TCPServer.new('localhost', 3003)
#
# loop do
#   client = server.accept
#
#   request_line = client.gets
#   next if !request_line || request_line =~ /favicon/
#   puts request_line
#
#   http_method, path_and_params = request_line.split(' ')
#   path, params = path_and_params.split('?')
#
#   rolls = ROLLS_DEFAULT
#   sides = SIDES_DEFAULT
#
#   unless params.nil?
#     params = params.split('&').map do |pair|
#       pair.split('=')
#     end.to_h
#
#     rolls = params["rolls"].to_i || ROLLS_DEFAULT
#     sides = params["sides"].to_i || SIDES_DEFAULT
#   end
#
#   client.puts "HTTP/1.1 200 OK\r\n\r\n"
#   client.puts "Content-Type: text/plain\r\n\r\n"
#   client.puts request_line
#   rolls.times { client.puts rand(sides) + 1 }
#   client.close
# end
#
# def roll(sides=6)
#   rand(sides) + 1
# end



# Refactor, extracting request parsing to method
require 'socket'

ROLLS_DEFAULT = 1
SIDES_DEFAULT = 6

def parse_request(request_line)
  http_method, path_and_params, http_version = request_line.split(' ')
  path, params = path_and_params.split('?')

  params = params.split('&').map do |pair|
    pair.split('=')
  end.to_h

  [http_method, path, params]
end

server = TCPServer.new('localhost', 3003)

loop do
  client = server.accept

  request_line = client.gets
  next if !request_line || request_line =~ /favicon/
  puts request_line

  http_method, path, params = parse_request(request_line)

  rolls = ROLLS_DEFAULT
  sides = SIDES_DEFAULT

  unless params.nil?
    rolls = params["rolls"].to_i || ROLLS_DEFAULT
    sides = params["sides"].to_i || SIDES_DEFAULT
  end

  client.puts "HTTP/1.1 200 OK\r\n\r\n"
  client.puts "Content-Type: text/plain\r\n\r\n"
  client.puts request_line
  rolls.times { client.puts rand(sides) + 1 }
  client.close
end
