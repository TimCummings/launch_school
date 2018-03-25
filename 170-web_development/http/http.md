
[comment]: # (http.md)

# Handling HTTP Requests Manually - 3/24/2018

## A Simple Echo Server
This is a simple echo server that listens on port 3003 of localhost and returns the first line of an incoming request. Code provided in video tutorial; comments are my notes.

[echo_server.rb](echo_server.rb)

---
## Parsing Path and Parameters
This is a slight variation on the previous example: in addition to printing the first line of the incoming HTTP request, it will print a random number between 1 and 6, simulating a die roll.

[echo_roll_server.rb](echo_roll_server.rb)

This is a step forward from our initial echo server, but what if we want to make this server more flexible so that a user can specify how many dice are rolled and how many sides those dice have?

If we think about functions, they can take arguments to modify what they do (what output they produce.) You can think of a request to a server similarly: it can take arguments that affect the "output" (response) produced. Since HTTP is stateless, all of the information needed to respond to a request must be contained within that request (there are exceptions but we are ignoring those for now.) If we want to be able to specify number of dice and number of sides, that information will need to be included in the request.

#### Passing Arguments in the URL via Query Parameters
e.g. `http://localhost:3003/?rolls=2&sides=6`

N.B. Some applications can accept an alternate form of query parameters where they are slash delimited, basically included in the path: `http://localhost:3003/rolls/2/sides/6` The style you use should be determined by the type of application you are working on and the type of data being passed in. In this situation, this second path style looks odd and implies some sort of nested relationship between rolls and sides (which is not the case), so we will use the standard style.

Update [echo_roll_server.rb](echo_roll_server.rb) to accept these arguments and adjust its behavior accordingly. (Tip: you can go ahead and make the request you want to the current server to see what the request you want to be able to handle will look like!)
 We want this request: `GET /?rolls=2&sides=6 HTTP/1.1` to result in the following variables:
 * `http_method == "GET"`
 * `path == "/"`
 * `params = { "rolls" => "2", "sides" => "6" }`

Solution: [echo_roll_qp_args_server.rb](echo_roll_qp_args_server.rb)

###### Note provided with exercise:

Many browsers will send additional requests when they load a web page, and that can cause problems for the program we're writing. Two common issues we've run into with this assignment are requests for /favicon.ico and requests that seem to be empty. The result of this is that an exception is raised in the program and it crashes.

If you run into one of these issues, add the following code to your project:

```ruby
loop do
  client = server.accept

  request_line = client.gets
  next if !request_line || request_line =~ /favicon/

  ...
  ```
This will terminate the loop early if the request is one of these problematic ones, allowing us to know that the rest of our code will not need to handle these situations.

We'll look at this a bit more in a future assignment.

---
## Sending a Complete Response
Let's add an html body: [complete_repsonse.rb](complete_response.rb)

Note that we had to change the `Content-Type` response header from `text/plain` to `text/html`, otherwise our HTML tags would get displayed as plain text.

---
## Persisting State in the URL
Let's make a new server that tracks a counter, displaying it on the page, and providing the client two links: one to increment the counter or another to decrement the counter. We can keep most of our previous code and just remove the dice related functionality to replace it with behavior for our counter.

[counter_server.rb](counter_server.rb)

By carefully crafting URLs and parameters, stateful interactions can be built on top of HTTP!
