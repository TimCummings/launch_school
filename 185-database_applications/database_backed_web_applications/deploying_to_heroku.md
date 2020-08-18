# Deploying PG Applications to Heroku - 8/17/2020

After verifying that our app works, it's time to deploy to Heroku!

* Make sure the [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli) is installed and working.
*  Specify a version of Ruby in the `Gemfile`.
* Add `puma` to the `Gemfile`.
* Run `bundle install`.
* Add a `Procfile`.
* Verify that everything is working using `heroku local`.
* Make sure that any development-specific code, such as `sinatra/reloader`, won't run in production.

* Update your code to open the database like this:

```ruby
@db = if Sinatra::Base.production?
        PG.connect(ENV['DATABASE_URL'])
      else
        PG.connect(dbname: "todos")
      end
```

* Create an application on Heroku by running `heroku apps:create` within the project's directory:

```
▶ heroku apps:create tjc-ls-185-todos
Creating ⬢ tjc-ls-185-todos... done
https://tjc-ls-185-todos.herokuapp.com/ | https://git.heroku.com/tjc-ls-185-todos.git
```

* Enable PostgreSQL for your application on Heroku:

```
▶ heroku addons:create heroku-postgresql:hobby-dev -a tjc-ls-185-todos
Creating heroku-postgresql:hobby-dev on ⬢ tjc-ls-185-todos... free
Database has been created and is available
 ! This database is empty. If upgrading, you can transfer
 ! data from another database with pg:copy
Created postgresql-triangular-59929 as DATABASE_URL
Use heroku addons:docs heroku-postgresql to view documentation
```

* If you have some code to create your database schema in `schema.sql`, you can try running the following command to do so:

```ruby
$ heroku pg:psql < schema.sql
--> Connecting to postgresql-triangular-59929
CREATE TABLE
CREATE TABLE
```

* We're using Heroku's free hobby-dev PostgreSQL database plan, which only allows for a maximum of 20 open database connections at once. If we exceed this limit, then our application will throw an error. Add the following code into your application to ensure that you don't exceed that 20 connection limit.

```ruby
# todo.rb
after do
  @storage.disconnect
end
```

```ruby
# database_persistence.rb
def disconnect
  @db.close
end
```

* Commit any changes you made above.

* Deploy the application to Heroku using `git push heroku master` (if you're working on a branch other than master, you'll need to use its name in this command instead).

Now if you visit your app's URL, your app should appear as a brand new app that is ready for to track your todos permanently.
