
# Practice Problem: Welcome Stranger - 11/4/2020

Write a function that takes two arguments, an array and an object. The array will contain two or more elements that, when combined with spaces, produce a person's full name. The object will contain two keys, `title` and `occupation`, and suitable values for both items. Your function should log a greeting to the console that uses the person's full name, and mentions the person's title and occupation.

Example:

```javascript
greetings(['John', 'Q', 'Doe'], { title: 'Master', occupation: 'Plumber' });

// console output
Hello, John Q Doe! Nice to have a Master Plumber around.
```

### Solution

```javascript
function greetings(fullName, profession) {
  console.log(`Hello, ${fullName.join(' ')}! Nice to have a ${profession.title} ${profession.occupation} around.`);
}
```
