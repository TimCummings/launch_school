
# Preparations

See the [style guide](javascript_style_guide.md).

* runtime environments
  1. browser
  2. node.js

* documentation
  * constructor is listed in Pascal case, e.g. `String`
  * instance methods
    * use the format `Constructor.prototype.methodName()`, e.g. `String.prototype.toUpperCase()`
    * are called on a value of that type, e.g. `'xyzzy'.toUpperCase()`
  * static methods
    * use the format `Constructor.methodName()`, e.g. `String.fromCharCode()`
    * are called on the constructor, e.g. `String.fromCharCode(97)`
  * properties
    * some data types also have properties
    * if methods/operations are like verbs, properties are like nouns
    * e.g. `"hello".length" # returns 5`

## Exercises

1. Create a directory named `my_folder` and navigate to that directory. Create two files named `one.js` and `two.js` in `my_folder`. Add the following JavaScript code to `one.js`:

```javascript
console.log('this is file one');
```

Add some code to `two.js` that logs `'this is file two'`.

When you're finished, run both programs with `node`.

### Solution

```
mkdir my_folder
cd my_folder
touch one.js
touch two.js

node one.js
=> this is file one

node two.js
=> this is file two
```

---

2. When you finish Exercise 1, navigate to the directory above the `my_folder` directory and delete all the content you generated in exercise 1 with one command.

WARNING: The rm method is DANGEROUS. Once you run this command, there is no undoing it. It is permanent. Make sure you are in the correct directory and that you use the correct name of the directory you want to delete.

### Solution

```
cd ..
rm -rf my_folder
```

---

3. Create a file named `foo.js` in a directory named `preparations_exercises`. Add the following code to the file.

```javascript
let foo = 'bar';
console.log(foo);
foo;
```

### Solution

```
mkdir preparations_exercises
cd preparations_exercises
touch foo.js
# edit foo.js in editor
```

---

4. 
1. Use `node` to run the `foo.js` file using `node`. What does it output?
2. Copy and paste the code from `foo.js` into the `node` REPL. What does it output?
3. Copy and paste the code from `foo.js` into the Chrome console REPL. What does it output?

### Solution

1.

```
node foo.js
=> bar
```

2.

```
node
// paste copied code
// line 2 outputs `bar`
// line 3 returns `'bar'`
```

3.

line 2 outputs `bar`
line 3 returns `"bar"`

---

5. Identify the Constructors for each of the following methods and classify each method as either a "Static" or a "Prototype" method:

* `substring`
* `create`
* `fromCharCode`
* `slice`

Multiple constructors may provide some methods; be sure to list them all in your answer. You can limit your search for methods to the `String`, `Object`, `Array`, and `Number` constructors.

### Solution

* `substring`
  * `String.prototype.substring()` is a prototype method of the `String` constructor
* `create`
  * `Object.create()` is a static method of the `Object` constructor
* `fromCharCode`
  * `String.fromCharCode()` is a static method of the `String` constructor
* `slice`
  * `String.prototype.slice()` is a prototype method of the `String` constructor
  * `Array.prototype.slice()` is a prototype method of the `Array` constructor

---

6. Which of the following names satisfy the style guidelines for variable names? For the purposes of this question, constants are not variables.

| Name         |
|--------------|
| index        |
| CatName      |
| snake_case   |
| lazyDog      |
| quick_Fox    |
| 1stCharacter |
| operand2     |
| BIG_NUMBER   |

### Solution

valid variable names:
* index
* lazyDog
* operand2

invalid variable names:
* CatName (should be catName)
* snake_case (should be snakeCase)
* quick_Fox (should be quickFox)
* 1stCharacter (must start with a lowercase letter)
* BIG_NUMBER (is a constant; variable should be bigNumber)

---

7. Which of the following names satisfy the style guidelines for function names?

| Name         |
|--------------|
| index        |
| CatName      |
| snake_case   |
| lazyDog      |
| quick_Fox    |
| 1stCharacter |
| operand2     |
| BIG_NUMBER   |

### Solution

valid function names:
* index
* CatName (as a Constructor, if they count)
* lazyDog
* operand2

invalid variable names:
* CatName (if Constructors don't count; should be catName)
* snake_case (should be snakeCase)
* quick_Fox (should be quickFox)
* 1stCharacter (must start with a lowercase letter)
* BIG_NUMBER (is a constant; function should be bigNumber)

---

8. Which of the following names satisfy the style guidelines for constants?

| Name         |
|--------------|
| index        |
| CatName      |
| snake_case   |
| lazyDog      |
| quick_Fox    |
| 1stCharacter |
| operand2     |
| BIG_NUMBER   |

### Solution

Only BIG_NUMBER. Constants should be uppercase and may use underscores to separate words.

---

9. Which of the following names don't satisfy the style guidelines for naming variables, functions, or constants?

| Name         |
|--------------|
| index        |
| CatName      |
| snake_case   |
| lazyDog      |
| quick_Fox    |
| 1stCharacter |
| operand2     |
| BIG_NUMBER   |

### Solution

invalid names:
* snake_case
* quick_Fox
* 1stCharacter
