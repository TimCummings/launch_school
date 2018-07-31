
[comment]: #(notes_170.md)

5/28/2018

# Internet

* many interconnected networks that allow all sorts of computers and other devices to communicate with each other

## IP (Internet Protocol) Address

* by convention, every device participating on a network is assigned an IP address
* Definition: a unique label provided to a device on a network
* IP Addresses also have **port numbers** which add further detail about how to communicate with that device
  - think of IP Addresses as phone numbers and ports as extensions
* Example: `192.168.0.1`
  - port number is provided as follows: `i.p.addr.ess:portnumber` e.g. `192.168.0.1:8000`

## DNS (Domain Naming System)

* Definitions
  - distributed database which translates computer names to a remote server
  - keeps track of URLs and their corresponding IP addresses on the internet
  - e.g. DNS resolves a name such as `http://www.google.com` to an IP address such as `197.251.230.45`
* very large world-wide network
* hierarchically organized
* no single server contains the whole database
* requests proceed up the hierarchy until matched

## Clients and Servers

* clients: send HTTP requests; process responses
  - web browser is most common client, but there are others
* servers: listen for and handle incoming HTTP requests; generate and send responses

### URL (Uniform Resource Locator)

* a URL is like an address or a phone number which you need to visit or communicate with a particular individual
* URL is the most commonly used aspect of the more general concept of a URI (Uniform Resource Identifier)
  - URI is to uniquely identify a resource
  - URL specifies where to locate a resource

* Resources: generic term for things you interact with via a URL
  - not limited to just web pages; can be images, videos, or even software/applications

* URL components - Ex: `http://www.example.com:88/home?item=book`
  1. Scheme
    + `http`
    + always precedes `://`
    + tells client how to access the resource (which protocol to use) e.g. `http`, `ftp`, `mailto`, `git`
  2. Host
    + `www.example.com`
    + where the resources is hosted/located
  3. Port
    + `:88`
    + provides further detail about how to communicate
    + only necessary if you want to use a port other than the default (80 for http)
  4. Path
    + `/home/`
    + shows what local resource is being requested
    + optional
  5. Query String
    + `?item=book`
    + made up of *query parameters*
    + used to send data to the server
    + optional

### Query Strings/Parameters

* Ex: `http://www.example.com?search=ruby&results=10`
  - `?`: reserved character that marks the start of a query string
  - `search=ruby`: parameter name/value pair
  - `&`: reserved character that delimits multiple parameter name/value pairs
  - `results=10`: also a parameter name/value pair

* query parameters are only used in HTTP GET requests
  - when you type a URL into a browser, you're issuing a GET request
  - most links are also GET requests

* Limitations
  - query strings have a maximum length; large amounts of data will need to be provided a different way
  - parameter name/value pairs are visible in the URL - DO NOT pass sensitive information this way!
  - spaces and other special characters (such as the reserved `?` and `&`) cannot be used normally; they instead must be URL encoded

#### URL Encoding

URLs by default only accept certain characters in the [ASCII character set](https://en.wikipedia.org/wiki/ASCII); characters not included in this set (or other unsafe or reserved characters) must be encoded to conform to this format. To encode such a character, the character is replaced with a `%` followed by two hexadecimal digits representing that character's [ASCII code](http://www.asciitable.com/).

* Ex: `tommy hilfiger` => `tommy%20hilfiger`
  - The Space character is not allowed; its ASCII code is 20, so its URL encoding is `%20`

* Allowed characters:
  - alphanumeric
  - reserved characters when used for reserved purposes
  - special characters: `$`, `-`, `_`, `.`, `+`, `!`, `'`, `"`, `(`, `)`, `,`

---

# HTTP - Hypertext Transfer Protocol

* Definition
  - a text-based protocol (system of rules) that serves as a link between applications and the transfer of hypertext documents
  - an agreement or message format of how machines communicate with each other
* simple model in which a client sends a *request* to a server and then waits for a *response* (-> referred to as a request response protocol)
* History
  - invented by Tim Berners-Lee in 1980s
  - 1991: HTTP/0.9 - only support HTML pages
  - 1992: HTTP/1.0 - support different file types e.g. HTML, CSS, videos, scripts, images
  - 1995: HTTP/1.1 - able to reuse established connections for subsequent requests, plus many other features
  - 1999: more improvements to HTTP/1.1
  - today (2018): HTTP/2.0 in early stages of development

---

## Statelessness

A protocol is said to be *stateless* when it's designed so that each request/response pair is completely independent of the previous one. It is **essential** to realize that **HTTP is a stateless protocol**.

* Implications:
  - server does not need to hang onto information (state) between requests
  - if a request "breaks" en route, the is no cleanup required
  - services built on top of HTTP can be distributed since there is no state to maintain

* Impact:
  - HTTP is a *resilient* protocol
    + no single point of failure or source to attack
  - HTTP is a difficult protocol for building *stateful* applications
    + since HTTP is inherently stateless, web developers have a difficult task in simulating stateful behavior
  - difficult to secure

---

## Tools

### GUI Tools

* [Paw 3](https://paw.cloud)
* [Insomnia](https://insomnia.rest/)
* [Postman](https://www.getpostman.com/)

**NB:** GUI tools with default settings probably WILL act like a browser and WILL do a number of things automatically (of which the user may be unaware), e.g. following redirects automatically.

### Command Line Tools

* [curl](http://curl.haxx.se/)

**NB:** CLI tools with default settings probably WON'T act like a browser and WON'T do a number of things automatically (of which the user may be unaware), e.g. following redirects automatically.

---

## HTTP Request

Components (**bold** indicates mandatory):

1. **Method**
2. **Path**
3. **Request Headers** (optional in 1.0; 1.1 requires the host in a `Host` request header)
4. Parameters
5. Body

e.g. `http://todos.com/tasks?due=today`

* method = GET
* path = `/tasks`
* parameters = `due=today`

### Method

Think of an HTTP request method as a verb that tells the server what action to perform on the requested resource. The two most common are `GET` and `POST`. With few exceptions (such as timeouts), *every request gets a response, even if that response is an error.*

#### GET

* used to retrieve a resource
* most links are GET requests
* if the response references other resources, browsers will automatically request the referenced resources (while pure HTTP tools will not)
* information can be sent to a server in the URL via query parameters, but is visible in the URL (and will probably get logged - multiple places!)
* think of GET as "read-only"

#### POST

* used to initiate an action on a server or send data to a server
* typically used for submitting forms
* allows a client to send much larger amounts of data to a server, and that data is not visible in the URL (BUT STILL MAY NOT BE SECURE - USE HTTPS!!)

If POST data is not sent in the URL, then how is it submitted? The HTTP **body**. The HTTP body contains the data being submitted in a POST request and is optional (it can be empty).

* it can contain HTML, images, audio, etc.
* think of the body as the letter enclosed in an envelope

---

## HTTP Headers

HTTP headers allow the client and server to send additional information during the request/response cycle. Headers are colon-separated name-value pairs that are sent in plain text.

### Request Headers

Request headers give more information about the client and the resource to be fetched, e.g. Host, Accept-Language, User-Agent, Connection, etc.

### Response Headers

Response headers give more information about the resource being sent back, e.g. Content-Encoding, Server, Location, Content-Type, etc.

---

## HTTP Response

* Definition: the raw data returned by a server in reply to an HTTP request
* Components (**bold** indicates mandatory):
  1. **Status Code**: three digit number signifying status of the request
  2. Response Headers: offer more information about the resource being sent back
  3. Response Body

---

## Statelessness Revisited

It's obvious by spending any time on a modern web page that the *stateless* HTTP protocol is somehow being augmented to simulate a sense of statefulness. One way this is accomplished (with help from the browser) is by having the server send a form of unique token (**session identifier**) to the client, which the client will include in subsequent requests.

Consequences of this faux statefulness:

* every request must be inspected for a session ID
* if a session ID is present, the server must ensure that session is still valid
* the server must have rules in place for:
  - session expiration
  - storage of session data
* if a session ID is present and the session is valid, the server must retrieve session data based on the session ID
* the server must re-create the application state based on session data and generate an appropriate response

Subsequent responses within a single session may contain much of the same information, but due to HTTP's statelessness, each request must still get an individual response. This can get very expensive, e.g. Facebook: the server must retrieve posts, images, comments, likes; if you "like" a new post, even though the only change is an incremented number, this new request still needs an individual response. (There are many techniques for optimizing sessions, such as AJAX.)

### Cookies (one common way to store session info)

* **cookies**: small files stored in the browser which contain session information
* most browsers have cookies enabled by default
* when you visit a website for the first time, the server sends session information which is stored in your browser cookie, locally on your machines
  - this is just an identifier; the actual session data is stored on the server

* you can see this in action in Chrome browser inspector
  - visiting a site for the first time will show a `set-cookie` *response* header (maybe more than one) under the `Network` tab
  - if you visit the site again, you can now see a `cookie` *request* header
    + this cookie will get sent in every subsequent request to this site and uniquely identifies your client
    + cookies can be viewed in browser inspector under `Application`

* think of session IDs stored with the client as keys to session data stored with the server
* **N.B.**
  - session IDs are unique
  - session IDs usually expire relatively quickly
  - logging out or manually removing a session ID (cookie) disassociates your client with the previous session data

---

## AJAX - Asynchronous JavaScript and XML

* allows browsers to issue requests and process responses *without a full page refresh*
  - remember our previous Facebook example: we can increment a "like" without expensively refreshing the entire page because of AJAX
* you can see AJAX in action by going to Google and opening the inspector's `Network` tab
  - type a single letter of your search and watch the requests
* responses to AJAX requests are handled by some **callback**: a piece of logic you pass on to some function to be executed after a certain event has happened
    + in our search example, the "event" is when a response is returned
    + the callback function in this example is updating the HTML with new search results
* **NB**: AJAX requests are just like normal requests - they are sent from client to server with standard HTTP components; the server handles them just like any other HTTP request
  - the difference is that responses are handled by callback functions (usually some piece of client-side JavaScript code) instead of by the browser refreshing the page and processing the response

---

## Security

* Implications of statelessness and sessions
  - If someone steals my session ID, can they log in as me?
  - Can sites "peak" at session data/cookies from other sites?

### Secure HTTP (HTTPS)

* every request/response is encrypted before being transported on the network (prevents packet sniffing from gaining any useful information - would only sniff encrypted packets)
* encryption is performed through the TLS protocol (Transport Layer Security): certificates are used to communicate with remote servers and exchange security keys before data is encrypted and transported
  - TLS is the successor of SSL (Secure Sockets Layer)

### Same Origin Policy

* permits resources originating from the same site to access each other with no restrictions; prevents access otherwise
  - "same origin" is defined as the same:
    + protocol
    + hostname
    + port number
  - e.g.:
    + `http://www.test.com/aboutus.html` can embed the contents of `http://www.test.com/fancy.js`
    + documents at `http://www.test.com` cannot embed documents hosted on `http://www.example.com`

* CORS (Cross Origin Resource Sharing)
  - allows resources from one domain to be requested from another domain
  - adds new HTTP headers allowing servers to serve resources to permitted origin domains

### Common Threats

#### Session Hijacking

If an attacker gets possession of a session ID, both attacker and user share the same session and can access the site/application. The user won't know (and the user's username and password have not necessarily ever been compromised either.)

* countermeasures:
  - resetting sessions (rendering previous sessions invalid) on login or attempted access to sensitive areas (require re-authentication)
  - expire sessions after a set amount of time, which minimizes the window within which an attacker can do damage
  - use HTTPS across an entire site/app to minimize the chances of an attacker successfully intercepting a session ID

#### XSS (Cross-Site Scripting)

XSS can occur when a site attempts to display raw user input; if a malicious user inputs HTML, JavaScript, etc., that code can end up getting executed by the server

* countermeasures:
  - never allow raw user input unless absolutely necessary
  - ALWAYS sanitize user input
    + if possible, disallow potentially disruptive types of input like HTML and JavaScript in favor of a safer format, like Markdown
  - if you're going to render user input, *escape* it before doing so, so the browser doesn't interpret it as code
    + escape: replace HTML characters with certain combinations of ASCII characters, called [HTML Entities](http://entitycode.com/#math-content)

---

# Zooming In

## Server

In our [client-server descriptions of HTTP](images/client-sever.png), the "server" has been simplified. In reality, a "server" is composed of multiple components, each of which could be distributed over many physical machines. There could also be intermediary components such as load balancers for larger server infrastructures. You don't have to know all of these specifics, but be aware that the term "server" is usually highly overloaded, and be able to identify and zoom-in on the applicable component when you're coding or troubleshooting.

For our current purposes, we will consider [three primary server components](images/server-zoom-web-app-data.png):

1. **Web Server**: a server that responds to requests for static assets (files, images, CSS, scripts, etc.); no data processing is required so these can be handled by a simple web server
2. **Application Server**: this is where your application/business logic resides which handles more complicated requests (when your server-side code is deployed, this is where it lives)
3. **Data Store**: some form of persistent storage; usually a relational database, but could also be a file, key/value store, etc.

## HTTP over TCP/IP

If we zoom in on our HTTP requests and responses, we can see that HTTP is actually [relying on a TCP/IP connection](images/http-zoom-tcpip.png) (most of the time.) What is the nature of this relationship?

First, realize that HTTP is basically a convention for formatting strings of text (requests and responses.) Conceptually, the internet's communication stack can be divided into multiple layers. One of the most commonly used models is the [OSI Model](https://en.wikipedia.org/wiki/OSI_model). In the OSI model, HTTP is a top level protocol at the Application layer, while TCP and IP are lower in the stack, closer to the Physical layer. *Essentially, HTTP uses TCP/IP under the hood to do the heavy lifting of ensuring a request/response cycle is completed correctly.*

Developers as they are coding can usually focus strictly on the application server until code is ready to be deployed (and the other components come back into consideration.) When only considering the application server, we can use [this mental model](images/server-zoom-tcp-ruby.png).

## Rack

See "Growing Your Own Web Framework with Rack"

* [Part 1](https://launchschool.com/blog/growing-your-own-web-framework-with-rack-part-1)
* [Part 2](https://launchschool.com/blog/growing-your-own-web-framework-with-rack-part-2)
* [Part 3](https://launchschool.com/blog/growing-your-own-web-framework-with-rack-part-3)
* [Part 4](https://launchschool.com/blog/growing-your-own-web-framework-with-rack-part-4)

After some exercises to get a feel for handling HTTP requests and responses manually, we want to detour and talk about Rack: a library/generic interface to connect applications and web servers. While our TCP server works for simple exercises, it's not appropriate for a production quality application, and there are plenty of common, robust web servers already available. We will start with WEBrick since it comes built-in with Ruby.

Connecting to and working with WEBrick can be cumbersome, so we will rely on Rack to help; we can now use the following [mental model](images/server-zoom-rack.png).

### Requirements

Since Rack sets a standardized methodology for communicating HTTP requests and responses between a client a server, it has some very specific conventions to be aware of. In order to make your Ruby code Rack compatible, you need to:

1. Create a "rackup" file with the `.ru` extension (`config.ru` is expected by default); this is a configuration file that specifies what to run and how
2. The rack application specified in the rackup file must be a Ruby object that responds to the `call(env)` method, where `env` is the only argument and is a list of environment variables for the application.

The `call` method always returns an array containing these three elements:

1. Status Code: represented by a string or another data type that responds to `to_i`
2. Headers: in the form of key-value pairs inside a hash.
3. Response Body: this can be anything as long as it responds to the `each` method and *yields* a String value, e.g. `Enumerable`, `StringIO`, or a custom class that meets these criteria.

[Rack Documentation](https://www.rubydoc.info/github/rack/rack/master/file/SPEC)

## View Templates and ERB

While it's possible to generate a full HTML response inside the `call` method, this approach very quickly becomes repetitive (*DRY!*) and unwieldy for all but the most simple uses. What we need next is a location in our application to store and maintain code related to what we want to display - this type of code is called a *view template*. View templates are separate files that allow our server to do some pre-processing in our programming language of choice and then output a string (usually HTML) to return to the client.

There are many view templating options, but we're going to start with ERB (Embedded Ruby) which allows us to mix Ruby into HTML and produce a final 100% HTML string.

ERB provides the following two syntax forms to embed Ruby in HTML:

* `<%= ruby_code_here %>`: embedded Ruby code is evaluated and its return value is *included* in the HTML output (good for method invocations)
* `<% ruby_code_here %>`: embedded Ruby code is evaluated but its return value is **not** included in the HTML output (good for method definitions and conditionals)

### Layouts

Along with `view templates`, Sinatra provides the option to also create `layouts`, which can be thought of as view templates that wrap around other view templates. A `layout` will be a templating language file just like a `view template`, but it will `yield` where it wants the `view template` content to be. Sinatra will automatically wrap views with a `layout` file named `layout` if it exists (e.g. `layout.erb`), although a different layout can be specified (see Sinatra documentation.)

### ERB Files

ERB can also be used to process entire files (ERB files need to use the `.erb` extension.) If we have the following `example.erb` file:

```html
<% names = ['bob', 'joe', 'kim', 'jill'] %>

<html>
  <body>
    <h4>Hello, my name is <%= names.sample %></h4>
  </body>
</html>
```

We could process this ERB file from a separate Ruby file with:

```ruby
require 'erb'

template_file = File.read('example.erb')
erb = ERB.new(template_file)
erb.result
```

`erb.result` returns a 100% HTML string such as: `<html><body><h4>Hello, my name is jill</h4></body></html>`.

## Sinatra

[Sinatra](http://sinatrarb.com/intro.html) is a Rack-based web development framework: it comes with several out-of-the-box features to make web development easier, but which hide a lot of power. But at its core, it's Ruby code connecting to a TCP server, handling requests, and sending back responses in an HTTP-compliant string format. We can update our mental model [accordingly](images/server-zoom-sinatra.png).

### Routes

Sinatra makes it simple to write Ruby code that runs when visiting a particular URL by providing a DSL for defining *routes*. Routes are how a developer maps a URL pattern to a chunk of Ruby code:

```ruby
require 'sinatra'

# declare a route matching the URL '/'; when a user visits '/', Sinatra will execute the body of this block and send its return value to the client
get '/' do
  File.read 'public/template.html'
end
```

### Route Parameters

Sinatra lets you add *parameters* to your URL patterns by prefixing with a colon. Values passed through the URL in this manner will be made available in the `params` hash. E.g.:
```ruby
get '/chapters/:number' do
  params[:number]
end
```
The example route above will match any route that starts with `/chapters/` and is followed by an additional segment; the additional segment will be accessible inside the block as shown. E.g. `/chapters/8` will match and inside the block, `params[:number]` will be `'8'`.

#### Other Parameters

There are two other ways that data can get into the `params` hash:
1. query parameters via the URL
2. form submission via a POST request

### Files

Sinatra, by default, will serve any requested file in a `public` directory that's in the same directory as the application. N.B. this does not mean only that Sinatra provides access, but that it will serve requested files from the `public` directory (without needing to manually create a route.)

Useful classes/methods for working with files:
* [Dir.glob](http://ruby-doc.org/core-2.3.0/Dir.html#method-c-glob) to list folders and/or files
* [File class](http://ruby-doc.org/core-2.3.0/File.html) for all sorts of things
  - manipulating paths and file names (e.g. get only the file name from a path with `File.basename`)
  - reading from files
  - writing to files

### Before Filters

Similar to Minitest's `setup` method, Sinatra provides a `before` block for logic that needs to be evaluated for every request/route. Common uses are authenticating users, loading user information, and any other common code that is repeated in every route. However, be aware that a `before` filter is evaluated before a route; watch out for code that looks like it's repeated but is actually context sensitive, e.g. a `@title` variable may be present in every route, but its value may be context sensitive to every route as well; while this first appears as a good candidate for moving into a `before` filter, doing so would actually disrupt our dynamic, context-sensitive title.

### View Helpers

Sinatra allows you to define a *helpers* (or *view helpers*) block; methods defined inside the *helpers* block are made available within view templates for the purpose of filtering and processing data or performing other necessary functions. **NB:** While Sinatra doesn't restrict the *helpers* block to **ONLY** view helpers (you are also able to include route helper methods), this convention is not followed by Rails. To maintain consistency, only include **view** helper methods in the helpers block; define **route** helper methods in the main level of your Sinatra application.

E.g. in your application:
```ruby
helpers do
  def slugify(text)
    text.downcase.gsub(/\s+/, '-').gsub(/[^\w-]/, '')
  end
end
```
This allows you to do the following in a view template:
```html
<a href="/articles/<%= slugify(@title) %>"><%= @title %></a>
```
If `@title == 'Today is the Day'`, this will render:
```html
<a href="/articles/today-is-the-day">Today is the Day</a>
```

### 404 Page Not Found

If a user requests a path that doesn't match any of your routes, Sinatra by default will display its own 404 page, but it also provides the `not_found` route in which you can customize your own 404 page.

### Redirecting

Redirecting users to other pages is a common practice, e.g. redirecting to an order confirmation page once a payment form is successfully submitted; redirecting unauthorized users from protected content; handling edge cases such as valid but semantically correct paths (e.g. `/chapters/22` which is the correct structure, but you only have 12 chapters.) To accomplish this, the server will set a `Location` header in the HTTP response with a status code in the `3XX` range (usually `301` or `302`); the browser will evaluate the response and then look to the `Location` header and automatically send a followup request to the specified location.

Sinatra provides a `redirect` method for easy redirection.

---

### Deploying to Heroku

* Prerequisites:
  - Install the [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli) (make sure you can `heroku login`)
  - your project must be in a Git repository
  - **NB:** `pry` doesn't work with Heroku out of the box; remove any `binding.pry` calls in your code before deploying to Heroku.

#### Configuring an App for Deployment
1. Sinatra provides `development?` and `production?` methods whose return values are determined by the current value of the `RACK_ENV` environment variable. Heroku automatically sets this to `"production"`. Use this feature to enable/disable appropriate tasks, e.g. you don't want your production application's files reloading every page refresh, so disable `sinatra/reloader` in production with: `require 'sinatra/reloader' if development?`
2. Specify a Ruby version in your `Gemfile` so Heroku knows exactly which version to use, otherwise Heroku will throw an error.
3. Use a production web server (i.e. _not_ WEBrick). WEBrick is fine for local development but [it's not suitable as a production web server](https://devcenter.heroku.com/articles/ruby-default-web-server). Add a gem for a production web server to your `Gemfile` in a production group:
```ruby
group :production do
  gem 'puma'
end
```
4. Create a rackup file (usually `config.ru`) in your project's root directory; this will tell the web server how to start your application:
```ruby
require './book_viewer'
run Sinatra::Application
```
5. Create a `Procfile` in your project's root directory; this determines which processes to start when your application boots up. [More info here](https://devcenter.heroku.com/articles/procfile). For large applications, it's recommended to use a separate config file, but for small apps, this inline approach is ok: `web: bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-development}`
6. Test your project (and Procfile) locally with: `heroku local`; you should see something like:
```
$ heroku local
forego | starting web.1 on port 5000
web.1  | Puma starting in single mode...
web.1  | * Listening on tcp://0.0.0.0:5000
web.1  | Use Ctrl-C to stop
```

#### Creating a Heroku Application
1. Create a Heroku application with `heroku apps:create $NAME`, where `$NAME` is the application name you wish to use. If you don't provide a value, Heroku will randomly generate one. (You will sometimes see the alias `heroku create $NAME`.)
2. Push your project to the new Heroku application with `git push heroku master`. **NB:** Heroku only looks at the `master` branch of a repository when processing a `git push`. Accordingly, you _must_ the code you want to run on Heroku to the remote `master` branch, regardless of which branch it is in locally. You can either specify the name of a local branch with `git push heroku local-branch-name:master`, or merge your changes into your local `master` branch and then `git push heroku master`.
3. Visit your application and make sure it's working.
4. After deploying, you can see certain details (like the `RACK_ENV` environment variable) with `heroku config` in your project's directory. (**NB:** Environment variables are often used to provide API keys and other secret values to applications without including them in source code and version control, so this can be a useful troubleshooting step.)

---

### Flashing Messages

1. save message to session in generating route
2. check for message in terminating view, deleting message from session to display it

### Validation

Notice that we follow a certain pattern when organizing our routes. When a valid action takes place we redirect and when there is some sort of error we will render a page.
```ruby
post "/lists" do
  list_name = params[:list_name].strip
  if list_name.size >= 1 && list_name.size <= 100
    session[:lists] << {name: list_name, todos: []}
    session[:success] = "The list has been created."
    redirect "/lists"
  else
    session[:error] = "List name must be between 1 and 100 characters."
    erb :new_list, layout: :layout
  end
end
```
The reason for this pattern is due to HTTP's stateless nature. If there is an error, we want to be able to go back and fix it. It may be useful to have access to our parameters and any instance variables set in the current route in that case. If we redirect to the new list page, then we'll lose access to data related to the current request.

### Capturing Template Content for Display Elsewhere

With [`Sinatra::ContentFor`](http://sinatrarb.com/contrib/content_for), an extension that is part of `Sinatra::Contrib`, it is possible to define additional content in a view and display it in your layout in a specific location, separate from the layout's `<%= yield %>`. To use `Sinatra::ContentFor`...
1. `require 'sinatra/content_for'` in your main Sinatra app file
2. In a view, define additional content in a `content_for` block and provide a symbol name, e.g.
```ruby
<% content_for :header_links do %>
  <a href="/link/1">Link 1</a>
  <a href="/link/2">Link 2</a>
<% end %>
```
3. In the appropriate layout, `yield_content` to the symbol name, e.g.
```ruby
  <%= yield_content :header_links %>
```
4. Note the use of `<% %>` in the view and of `<%= %>` in the layout!

---

### Securing Applications

One of Sinatra's main benefits is how lightweight it is: there is less to learn than e.g. Rails and you can get a simple project running quickly. A downside to this is that developers have to sometimes manually handle features that larger frameworks take care of automatically. One such security feature is *escaping* HTML: replacing certain characters in the text with HTML entities that the browser won't interpret as code.

As useful as it is to generate HTML dynamically, doing so provides lots of opportunities to influence the code that is written into a page. Nefarious parties can use such opportunities to modify your page and ultimately steal data or credentials.

As an example in the Sinatra Todos application, add the following todo (exactly): `<script>alert("This code was injected!");</script>Pizza`. Note that:
1. The JavaScript code in the script tag [is being evaluated](images/during_injection.png).
2. [After clicking OK, the page appears normally](../images/after_injection.png): if the code hadn't announced itself, we'd have no idea it was injected.

Rack provides a method for escaping HTML with `Rack::Utils.escape_html`:
```ruby
Rack::Utils.escape_html "test"
# => "test"
Rack::Utils.escape_html "<p>This won't be evaluted.</p>"
# => "&lt;p&gt;This won&#x27;t be evaluated&lt;&#x2F;p&gt;"
```

Sinatra provides another, more thorough approach which escapes *all* output:
```ruby
configure do
  set :erb, :escape_html => true
end
```
**NB**: this may escape code that you want to be evaluated. In that case, make sure to use `<%== ... %>` to disable auto-escaping. E.g. in `layout.erb`, `<%= yield %>` will probably not work as intended; instead, use `<%== yield %>`.

#### HTTP Methods and Security

Form submissions via `GET` uses query parameters in the URL, e.g. `localhost:4567/submit?email=my.email%40something.com`. As a result, `GET` is (correctly) regarded as in-secure over HTTP.

Form submissions via `POST` use the request body instead of query parameters, leading some to assume `POST` is more secure. However, the request body is still plainly visible over HTTP (unencrypted) to anyone with even a vague understanding of HTTP. Consequently, `POST` is no more or less secure than `GET`.

If your form modifies data on the server, use `POST`; if it doesn't, use `GET`. **For security, make sure you're using HTTPS (encrypted)!!**
