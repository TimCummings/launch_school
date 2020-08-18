
# Solving the Reloading Problem - 8/17/2020

It's aggravating to have to continually restart sinatra when we make changes to a file other than `todo.rb` (which is using `sinatra/reloader`. This aggravation can turn into a real cost over time if we forget what's wrong and attempt to debug unreflected changes. Let's fix this by adding `also_reload` in our `configure` block:

```ruby
# todo.rb
configure do
  enable :sessions
  set :session_secret, 'secret'
  set :erb, :escape_html => true
  also_reload 'database_persistence.rb'
end
```

See the documentation for sinatra reloader for more info: http://sinatrarb.com/contrib/reloader.html.
