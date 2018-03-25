# counter_server.rb

require 'socket'

def parse_request(request_line)
  http_method, path_and_params, http_version = request_line.split(' ')
  path, params = path_and_params.split('?')

  params = (params || '').split('&').map do |pair|
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

  client.puts "HTTP/1.1 200 OK"
  client.puts
  client.puts "<html>"
  client.puts "<body>"
  client.puts "<pre>"
  client.puts request_line
  client.puts http_method
  client.puts path
  client.puts params
  client.puts "</pre>"
  client.puts "<h1>Counter</h1>"

  number = params["number"].to_i
  client.puts "<p>The current number is: #{number}.</p>"

  client.puts "<a href='?number=#{number + 1}'>Increment counter by 1</a>"
  client.puts "<a href='?number=#{number - 1}'>Decrement counter by 1</a>"
  client.puts "</body>"
  client.puts "</html>"
  client.close
end

# By carefully crafting URLs and parameters, stateful interactions can be built on top of HTTP
