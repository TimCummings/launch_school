# echo_server.rb

# code provided in video tutorial, comments are my notes

# This is a simple echo server that prints the first line of an incoming HTTP request to the server console (terminal) and to the client browser

# built in Ruby library for creating and interacting with servers and performing other networking related tasks
require 'socket'

# creating server on host 'localhost' which will listen on port 3003
server = TCPServer.new('localhost', 3003)

loop do
  # server listens to an incoming connection, which it establishes and returns a client object for us to interact with
  client = server.accept

  request_line = client.gets
  # prints to console/terminal
  puts request_line

  # valid response line to meet "well formed response" criteria; *** note use of carriage return (\r) in conjunction with newline (\n) - probably for compatibility with Windows file system expectations?
  client.puts "HTTP/1.1 200 OK\r\n\r\n"

  # example of optional header (not required for well-formed response)
  client.puts "Content-Type: text/plain\r\n\r\n"

  # prints to client (web browser)
  client.puts request_line
  client.close
end

# This simple echo server lets us work with HTTP requests and response as plain text, which is ultimately what everything is with HTTP

# There have been some browser changes since this tutorial was first created, e.g. Chrome expects a "well formed repsonse" or will return ERR_INVALID_HTTP_RESPONSE and not display the page. To fix this, simply add a valid status line to the beginning of your response (there must be a blank line between the status line, optional headers, and message body.)
