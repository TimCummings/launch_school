
# Optimizing N+1 Queries - 8/19/2020

Let's start by looking at our template to see what data it needs:
* `list_id`
* `todos_remaining_count` method
  * requires list of `todos`
* `todos_count` method
  * requires list of `todos`

It looks like we'll need to make a number of adjustments if we change the way `todo` data is retrieved.

It's important to stress that optimizations like this should only be done when they become necessary. Don't start such optimizations before your app is even working.
