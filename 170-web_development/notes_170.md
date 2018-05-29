
[comment]: #(notes_170.md)

5/28/2018

# HTTP - Hypertext Transfer Protocol
* Definition
  - a protocol (system of rules) that serves as a link between applications and the transfer of hypertext documents
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
# Statelessness
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
# Tools
## GUI Tools
* [Paw 3](Paw 3)
* [Insomnia](https://insomnia.rest/)
* [Postman](https://www.getpostman.com/)

**NB:** GUI tools with default settings probably WILL act like a browser and WILL do a number of things automatically (of which the user may be unaware), e.g. following redirects automatically.


## Command Line Tools
* [curl](http://curl.haxx.se/)

**NB:** CLI tools with default settings probably WON'T act like a browser and WON'T do a number of things automatically (of which the user may be unaware), e.g. following redirects automatically.


---
# HTTP Request Method
Think of an HTTP request method as a verb that tells the server what action to perform on the requested resource. The two most common are `GET` and `POST`. With few exceptions (such as timeouts), *every request gets a response, even if that response is an error.*


## GET
* used to retrieve a resource
* most links are GET requests
* if the response references other resources, browsers will automatically request the referenced resources (while pure HTTP tools will not)
* information can be sent to a server in the URL via query parameters, but is visible in the URL (and will probably get logged - multiple places!)

## POST
* used to initiate an action on a server or send data to a server
* typically used for submitting forms
* allows a client to send much larger amounts of data to a server, and that data is not visible in the URL (BUT STILL MAY NOT BE SECURE - USE HTTPS!!)


If POST data is not sent in the URL, then how is it submitted? The HTTP **body**. The HTTP body contains the data being submitted in a POST request and is optional (it can be empty).
* it can contain HTML, images, audio, etc.
* think of the body as the letter enclosed in an envelope
