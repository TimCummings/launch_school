# complete_response.rb

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

  client.puts "HTTP/1.1 200 OK"
  client.puts "Content-Type: text/html\r\n\r\n"
  client.puts "<html>"
  client.puts "<body>"
  # <pre>: content will be displayed to user without modification; whitespace will be preserved
  client.puts "<pre>"
  client.puts request_line
  client.puts http_method
  client.puts path
  client.puts params
  client.puts "</pre>"
  client.puts "<h1>Rolls!</h1>"

  rolls.times { client.puts "<p>", rand(sides) + 1, "</p>" }

  client.puts "</body>"
  client.puts "</html>"
  client.close
end
