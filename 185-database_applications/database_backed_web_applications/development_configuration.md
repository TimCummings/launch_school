
# Development Configuration - 8/17/2020

There are current dependencies and methods that we only want to use in specific environments, e.g. `sinatra/reloader` from the previous lesson. We want this to be available and run only in development, and definitely not in production. This can be done one of two ways:

Individually:

```ruby
configure do
  enable :sessions
  set :session_secret, 'secret'
  set :erb, :escape_html => true
  also_reload 'database_persistence.rb' if development?
end
```

Or with a separate `configure` block:

```ruby
configure do
  enable :sessions
  set :session_secret, 'secret'
  set :erb, :escape_html => true
end

configure(:development) do
  require "sinatra/reloader"
  also_reload 'database_persistence.rb'
end
```
