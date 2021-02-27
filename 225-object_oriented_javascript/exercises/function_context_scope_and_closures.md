
# JS225 Exercises: Function Context, Scope, and Closures - 1/25/2021

## 1. What is This

Read the following code carefully. What do you think is logged on line 7. Try to answer the question before you run the code.

```javascript
const person = {
  firstName: 'Rick ',
  lastName: 'Sanchez',
  fullName: this.firstName + this.lastName,
};

console.log(person.fullName);
```

### Solution

This is method invocation and it should log `Rick Sanchez`.

#### Adjustments after attempting to run it

`fullName` is not a function or a method, it's just a property that is provided an expression as its value. Because the value of `this` is established by non-arrow function definitions, the value of `this` on line 4 is the global object. The global object does not have `firstName` or `lastName` properties, so the value of `fullName` on line 4 evaluates to `undefined + undefined`, then to `NaN + Nan`, then to just `NaN`. Line 7 logs `NaN`.

---

## 2. The Franchise

The method `franchise.allMovies` is supposed to return the following array:

```javascript
[
  'How to Train Your Dragon 1',
  'How to Train Your Dragon 2',
  'How to Train Your Dragon 3'
]
```

Explain why this method will not return the desired object? Try fixing this problem by taking advantage of JavaScript lexical scoping rules.

```javascript
const franchise = {
  name: 'How to Train Your Dragon',
  allMovies() {
    return [1, 2, 3].map(function(number) {
      return `${this.name} ${number}`;
    });
  },
};
```

### Solution

Since `map`'s callback function is not provided a `thisArg`, the value of `this` inside the callback function on line 5 is the global object, which doesn't have a `name` property. This causes `franchise.allMovies()` to return `[ 'undefined 1', 'undefined 2', 'undefined 3' ]`. The easiest solution is to provide a `thisArg` value to `map`:

```javascript
const franchise = {
  name: 'How to Train Your Dragon',
  allMovies() {
    return [1, 2, 3].map(function(number) {
      return `${this.name} ${number}`;
    }, this);
  },
};
```

I'm not sure if this qualifies as a solution that 'takes advantage of JavaScript lexical scoping rules'. Alternatively, inside `allMovies` before `map`'s callback, where the value of `this` is the object assigned to `franchise`, we could assign `this` to a local variable and reference that local variable from inside `map`'s callback:

```javascript
const franchise = {
  name: 'How to Train Your Dragon',
  allMovies() {
    let self = this;
    return [1, 2, 3].map(function(number) {
      return `${self.name} ${number}`;
    });
  },
};
```

---

3. The Franchise - Solution 2

In the previous exercise, we had a situation where an anonymous method passed to `map` had an undesirable execution context. We solved the problem by taking advantage of lexical scoping and introducing a new variable `self`. Solve the same problem again by passing a hard-bound anonymous function to `map`.

```javascript
const franchise = {
  name: 'How to Train Your Dragon',
  allMovies() {
    let generateName = function(number) {
      return `${this.name} ${number}`;
    }.bind(this);

    return [1, 2, 3].map(generateName);
  },
};
```

---

4. Our very own bind()

[Function.prototype.bind](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_objects/Function/bind) is a method on all function objects that allows us to hard-bind a function to a particular object. The way this works is that you pass a context object to the `bind` method and it returns a new function that is essentially the same function but hard-bound to the context object supplied.

Create a function `myBind`, that accepts two arguments: 1) The function to bind, 2) The context object, and returns a new function that's hard-bound to the passed in context object.

### Solution

This isn't quite right - it returns the evaluated result of a function, not a new function.

```javascript
function myBind(func, context) {
  return func.apply(context);
}
```

#### Adjustments based on provided solution

Return a function that calls the function argument with `apply`:

```javascript
function myBind(func, context) {
  return function(...args) {
    return func.apply(context, args);
  };
}
```

---

5. myBind() Improved

Our earlier implementation of the `Function.prototype.bind` was simplistic. `Function.prototype.bind` has another trick up its sleeve besides hard-binding functions to context objects. It's called partial function application. Read [this assignment](https://launchschool.com/lessons/0b371359/assignments/f2c6f687) and the [MDN documentation](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_objects/Function/bind#Partially_applied_functions) to learn more about partial function application.

Alter the `myBind` function written in the previous exercise to support partial function application.

### Solution

```javascript
function myBind(func, context, ...partialArgs) {
  return function(...args) {
    args = partialArgs.concat(args);
    return func.apply(context, args);
  };
}
```

---

6. myFilter()

In this exercise we'll update the implementation of [myFilter](https://launchschool.com/lessons/bfc761bc/assignments/c6f3935e) by adding the functionality of accepting an optional `thisArg` just like the original [Array.prototype.filter](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/filter#Parameters).

Here's our original implementation. We also show an example of how we want to call our modified function: the 3rd argument, `filter`, supplies the desired context (`thisArg`).

```javascript
function myFilter(array, func) {
  const result = [];

  array.forEach(value => {
    if (func(value)) {
      result.push(value);
    }
  });

  return result;
}

const filter = {
  allowedValues: [5, 6, 9],
};

myFilter([2, 1, 3, 4, 5, 6, 12], function(val) {
  return this.allowedValues.includes(val);
}, filter); // returns [5, 6]
```

Modify the original implementation such that the expected result is returned. Don't use the `thisArg` argument of `Array.prototype.forEach`.

### Solution

```javascript
function myFilter(array, func, thisArg) {
  const result = [];

  array.forEach(value => {
    if (func.call(thisArg, value)) {
      result.push(value);
    }
  });

  return result;
}
```

---

7. Garbage Collection

Read the following code carefully. Will the JavaScript garbage collection mechanism garbage collect the value assigned to the variable `count` after the function `counter` is run on line 10?

```javascript
function makeCounter() {
  let count = 1;

  return () => {
    console.log(count++)
  };
}

const counter = makeCounter();
counter();
// more code
```

### Solution

Yes and no: the initial value of `1` will be garbage collected since `count` is reassigned the value of two and JavaScript primitives are immutable. But the new value of `2` will not be garbage collected after line 10 because it's still referenced by the anonymous function pointed to by the `counter` variable.

---

8. Make a Stack

A stack is a compound data type like an array. The difference between an array and a stack is that in an array you can insert and remove elements in any order you want, but a stack has a rule whereby you can only add new elements at the end and remove the last inserted element.

Create a function `newStack`, that when called returns a stack object with three methods: `push`, `pop`, and `printStack`. `push` takes a value and inserts it at the end of the stack. `pop` removes the last element from the stack. `printStack` logs each remaining element of the stack on its own line.

Internally, use an array to implement the stack. Make sure that the array is not accessible from outside the methods.

### Solution

```javascript
function newStack() {
  let array = [];

  return {
    push(value) {
      array.push(value);
    },

    pop() {
      return array.pop();
    },

    printStack() {
      array.forEach(element => console.log(element));
    },
  };
}
```

---

9. Don't Pollute My Window

Consider the following code:

```javascript
const name = 'Naveed';
const greeting = 'Hello';

const greeter = {
  message: `${greeting} ${name}!`,
  sayGreetings() {
    console.log(this.message);
  }
};
```

Note that the `message` property uses the result of interpolation as its value. As a result, we have two global variables: `name`, and `greeting` that pollute the global scope. As we already know, we should limit the use of global variables as much as we can. Here we can avoid using the global variables by simply setting the `message` property to the value `"Hello Naveed!"`. But let's pretend that we must use variables and interpolation to accomplish this. Can you think of a way to refactor this code so we don't have any other variables in the global scope besides `greeter`?

### Solution

One solution is to move the variables to properties then reference them from within the `sayGreetings` method:

```javascript
const greeter = {
  name: 'Naveed',
  greeting: 'Hello',
  sayGreetings() {
    console.log(`${this.greeting} ${this.name}!`);
  }
};

greeter.sayGreetings();
```

Another solution is to move the variables into the `sayGreetings` method:

```javascript
const greeter = {
  name: 'Naveed',
  greeting: 'Hello',
  sayGreetings() {
    const name = 'Naveed';
    const greeting = 'Hello';
    console.log(`${greeting} ${name}!`);
  }
};

greeter.sayGreetings();
```

---

10. School Improved

In an [earlier exercise](https://launchschool.com/exercises/4f445afb), we created a `school` object. It works, however, it can still be improved. The following are improvements for you to implement in the solution provided:

* Make the list `students` private. Right now, anyone can gain access to it and manipulate it.
* Make the constraint for allowed values for years a private variable. As a private variable it avoids an unnecessary statement in the `addStudent` method and at the same time makes the code more declarative.
* Make the `getCourse` function accessible in the `addGrade` method also. As it is, only the `courseReport` method has access.

### Solution

```javascript
function createStudent(name, year) {
  return {
    name,
    year,
    courses: [],
    info() {
      console.log(`${this.name} is a ${this.year} student`);
    },

    listCourses() {
      return this.courses;
    },

    addCourse(course) {
      this.courses.push(course);
    },

    addNote(courseCode, note) {
      const course = this.courses.filter(({code}) => code === courseCode)[0];

      if (course) {
        if (course.note) {
          course.note += `; ${note}`;
        } else {
          course.note = note;
        }
      }

    },

    viewNotes() {
      this.courses.forEach(course => {
        if (course.note) {
          console.log(`${course.name}: ${course.note}`);
        }
      });
    },

    updateNote(courseCode, note) {
      const course = this.courses.filter(({code}) => code === courseCode)[0];

      if (course) {
        course.note = note;
      }
    },
  };
}

function makeSchool() {
  const students = [];
  const VALID_YEARS = ['1st', '2nd', '3rd', '4th', '5th'];

  return {
    addStudent(name, year) {
      if (VALID_YEARS.includes(year)) {
        const student = createStudent(name, year);
        this.students.push(student);
        return student;
      } else {
        console.log('Invalid Year');
      }
    },

    enrollStudent(student, courseName, courseCode) {
      student.addCourse({name: courseName, code: courseCode})
    },

    addGrade(student, courseName, grade) {
      const course = student.listCourses().filter(({name}) => name === courseName)[0];

      if (course) {
        course.grade = grade;
      }
    },

    getReportCard(student) {
      student.listCourses().forEach(({grade, name}) => {
        if (grade) {
          console.log(`${name}: ${String(grade)}`);
        } else {
          console.log(`${name}: In progress`);
        }
      });
    },

    getCourse(student, courseName) {
      return student.listCourses().filter(({name}) => name === courseName)[0];
    },

    courseReport(courseName) {
      const courseStudents = this.students.map(student => {
        const course = getCourse(student, courseName) || { grade: undefined };
        return { name: student.name, grade: course.grade };
      }).filter(({grade}) => grade);

      if (courseStudents.length > 0) {
        console.log(`=${courseName} Grades=`);

        const average = courseStudents.reduce((total, {name, grade}) => {
          console.log(`${name}: ${String(grade)}`);
          return total + grade;
        }, 0) / courseStudents.length;

        console.log('---');
        console.log(`Course Average: ${String(average)}`);
      }
    },
  };
}
```

#### Adjustments based on provided solution

An immediately invoked function expression (IIFE) is a better fit here than a constructor; an IIFE allows the `school` variable name to stay the same and have outwardly identical behavior.
