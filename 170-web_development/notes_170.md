
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
* [Paw 3](Paw 3)
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
If we zoom in on our HTTP requests and responses, we can see that HTTP is actually [relying on a TCP/IP connection](http-zoom-tcpip.png) (most of the time.) What is the nature of this relationship?

First, realize that HTTP is basically a convention for formatting strings of text (requests and responses.) Conceptually, the internet's communication stack can be divided into multiple layers. One of the most commonly used models is the [OSI Model](https://en.wikipedia.org/wiki/OSI_model). In the OSI model, HTTP is a top level protocol at the Application layer, while TCP and IP are lower in the stack, closer to the Physical layer. *Essentially, HTTP uses TCP/IP under the hood to do the heavy lifting of ensuring a request/response cycle is completed correctly.*

Developers as they are coding can usually focus strictly on the application server until code is ready to be deployed (and the other components come back into consideration.) When only considering the application server, we can use [this mental model](server-zoom-tcp-ruby.png).
