# Study Session - Linus, Mat, TJC - 7/8/2018

## HTTP

* Describe what HTTP is and the role of the request and the response.
  - It's a protocol/syntax that helps a client and server communicate with each other.
  - OSI model: Application layer
  - a general convention for how text messages between client and servers *shuold* be formatted.
* What are the components of an HTTP request and an HTTP response?
  - request
    - method (get, post, ...)
    - path
    - parameters - optional
    - headers (host is required in HTTP/1.1) - optional
    - body - optional
  - response
    - status code/text (200 OK)
      - status 204 (no content)
      - 404 (Not Found)
    - headers - optional
    - body - optional

* Identify the components of a URL. Construct a URL that contains a few params and values.
  - protocol - http
  - host - example.com
  - port - :80 ("optional")
  - path - /requested/resource
  - query parameters - ?name=tim&course=170 (optional)
  
  - HTTPS: port 443
  - HTTP: port 80
  
  http://example.com:80/requested/resource?name=tim&course=170
  

* Explain the difference between GET and POST, and know when to choose each.
  - anything other than simple requesting of data, use POST. Otherwise, use GET.

* What is the difference between client-side and server-side code? For each file in a Sinatra project, be able to say which it is.
  - client side: processed on client
  - server side: processed on server

Web

* How does an HTML form element interact with the server-side code that processes it.
  - action = path to server for processing
  - method = GET/POST
  - on submission, browser build up a request based on these attributes to send to the server
  - form fields are submitted as parameters (query parameters in URL if GET request, or parameters in body if PUT request)
  
  ```
  <form action="/todos" method="get">
    <input type="text" name="name">Name</input>
    <input type="submit">Submit</input>
  </form>
  ```
  
* Why is user-entered content a security risk? Be aware of how to mitigate this risk.
  ```
  configure do
    set :erb, :escape_html => true
  end
  
  <%== %>
  
  sanitize inputs
  
  *look for another way*
  
  ```
  
  * if you allow users to get content with URL, they can potentially get private data not meant to be seen by manipulating the URL.
    -  1 way to mitigate: Do not use URL parameters to access files on the server
    - another way to do it: whitelist certain file types so only filetypes you want to be served will be served
    - access documents with the index of the system

Sinatra

* Start a new Sinatra project and write simple routes to handle requests.
```
# Gemfile

source 'https://rubygems.org'

ruby '2.2.3'

gem 'sinatra'
gem 'sinatra-contrib'
gem 'erubis'
```

```
# app.rb

require 'sinatra'
require 'sinatra/reloader'
require 'tilt/erubis'

get '/' do
  erb :home
end

post '/process-this' do
  status 200
  headers['Content-Type'] = 'text/html'
  "the params are: #{params.to_s}"
end
```
```ruby
h = { "c" => 300, "a" => 100, "d" => 400, "c" => 300  }
h.to_s   #=> "{\"c\"=>300, \"a\"=>100, \"d\"=>400}"
```


* What are the benefits of using view templates? Be able to use an ERB template in a Sinatra route.
  - cuts down on repeated "boilerplate code"
  - separation of concerns: handle routing in app file, handle visual content in view template
  - dynamically generate appropriate content in routes, apply it to view template
  - you're able to use ruby code in HTML to dynamically generate content
  
  * <% %>
  * <%= %>
  * <%== %>
  * <% content_for :blah do %>
  <% end %>
    - would go in a route and is another block
  * <%= yield_content :blah %>
  * <%= yield %>

* What is the session? Where it is stored? How it is used?
  - GOOD QUESTOIN FOR TA
    - https://launchschool.com/posts/e3066414
  - Session is something that Sinatra gives us.
    - it allows us to store the state
  - Data is passed via cookies
  - JKASBDJSKABDKSAJBDCDSAS <- session could be stored in here as well as on the server
  - session["success"] = 'asoidnosan'
  <%= session["success"] %>
  
  configure do
    enable :sessions
    set :session_secret, "super secret"
  end

* Write a view helper and use it within a view template.
  - View helpers are methods to be used specifically within views
  - to keep it clear put it in your app
  
```
  helpers do
    def strong(text)
      "<strong>#{text}</strong>"
    end
  end
```
```
  <p>This is <%= strong('important') %></p>
  
  
  <div class='<%= text_class() %>'>
  </div>

  def list_complete?(list)
    todos_count(list) > 0 && todos_remaining_count(list) == 0
  end

  def list_class(list)
    "complete" if list_complete?(list)
  end
```

* Explain how redirection works and why it would be needed in a web application.
  - a server can redirect client back to something that makes a little more sense
  - ex:
    movie tickets, client requests certain ticket time but all sold out 
      - server can redirect instead of 404 error that doesn't display useful info.
      - redirection allows server to send back to something more meaningful (other showings that day etc.)
      - redirection is preferred unless you want to preserve some data (ex. fill out form incorrectly). 
      - being clear with your intent in your code
  - how does it work?
    -  in Sinatra:
      - they define redirect method: redirect '/'
      - 302 or 303, server sends back
      - also sends a locaion header
      - header["Location"]
      - browser will immedialtey look at lcoation header and send a request to that location
      
    - the rest of the code will not process
      - handy with authorization
