
# JS225 Exercises: Objects - 12/9/2020

## 1. Buggy Code 1

The code below is expected to output the following when run:

```javascript
> const helloVictor = createGreeter('Victor');
> helloVictor.greet('morning');
= Good Morning Victor
```

```javascript
function createGreeter(name) {
  return {
    name,
    morning: 'Good Morning',
    afternoon: 'Good Afternoon',
    evening: 'Good Evening',
    greet(timeOfDay) {
      let msg = '';
      switch (timeOfDay) {
        case 'morning':
          msg += `${morning} ${name}`;
          break;
        case 'afternoon':
          msg += `${afternoon} ${name}`;
          break;
        case 'evening':
          msg += `${evening} ${name}`;
          break;
      }

      console.log(msg);
    },
  };
}
```

However, it instead results in an error. What is the problem with the code? Why isn't it producing the expected results?

### Solution

The problem is that internally, this code is attempting to reference object property values (`name`, `morning`, `afternoon`, `evening`) without `this`. `name` will work, but only because of the `name` argument passed to `createGreeter`. For the time of day properties, there are no local variables or global variables with matching names in scope, which causes the error.

---

## 2. Buggy Code 2

A grocery store uses a JavaScript function to calculate discounts on various items. They are testing out various percentage discounts but are getting unexpected results. Go over the code, and identify the reason why they aren't getting the expected discounted prices from the function. Then, modify the code so that it produces the correct results.

```javascript
const item = {
  name: 'Foo',
  description: 'Fusce consequat dui est, semper.',
  price: 50,
  quantity: 100,
  discount(percent) {
    const discount = this.price * percent / 100;
    this.price -= discount;

    return this.price;
  },
};
```

```javascript
> item.discount(20)   // should return 40
= 40
> item.discount(50)   // should return 25
= 20
> item.discount(25)   // should return 37.5
= 15
```

### Solution

The problem is that each discount is being applied to the `price` property, which persists with the object. Subsequent discounts apply to the already previously discounted price instead of the original price. Within the `discount` method, `this` should not be used with `price` on the second line. A new local `price` variable (or a more clearly named variable like `discountedPrice`) should be set to the original price (`this.price`) minus the discount.

---

## 3. Testing Object Equality

In JavaScript, comparing two objects either with `==` or `===` checks for object identity. In other words, the comparison evaluates to `true` if it's the same object on either side of `==` or `===.` This is a limitation, in a sense, because sometimes we need to check if two objects have the same key/value pairs. JavaScript doesn't give us a way to do that.

Write a function `objectsEqual` that accepts two object arguments and returns `true` or `false` depending on whether the objects have the same key/value pairs.

```javascript
console.log(objectsEqual({a: 'foo'}, {a: 'foo'}));                      // true
console.log(objectsEqual({a: 'foo', b: 'bar'}, {a: 'foo'}));            // false
console.log(objectsEqual({}, {}));                                      // true
console.log(objectsEqual({a: 'foo', b: undefined}, {a: 'foo', c: 1}));  // false
```

### Solution

```javascript
function objectsEqual(object1, object2) {
  let keys1 = Object.keys(object1);
  let keys2 = Object.keys(object2);
  if (keys1.length !== keys2.length) return false;

  for (let key in object1) {
    if (!(key in object2)) return false;
    if (object1[key] !== object2[key]) return false;
  }

  return true;
};
```

---

## 4. Student

Create an object factory for a student object. The student object should have the following methods and it should produce the expected results demonstrated in the sample code:

* `info`: Logs the name and year of the student.
* `addCourse`: Enrolls student in a course. A course is an object literal that has properties for its `name` and `code`.
* `listCourses`: Returns a list of the courses student has enrolled in.
* `addNote`: Adds a `note` property to a course. Takes a `code` and a `note` as an argument. If a note already exists, the `note` is appended to the existing one.
* `updateNote`: Updates a `note` for a course. Updating a note replaces the existing note with the new note.
* `viewNotes`: Logs the notes for all the courses. Courses without notes are not displayed.

```javascript
> foo = createStudent('Foo', '1st');
> foo.info();
= "Foo is a 1st year student"
> foo.listCourses();
= [];
> foo.addCourse({ name: 'Math', code: 101 });
> foo.addCourse({ name: 'Advanced Math', code: 102 });
> foo.listCourses();
= [{ name: 'Math', code: 101 }, { name: 'Advanced Math', code: 102 }]
> foo.addNote(101, 'Fun course');
> foo.addNote(101, 'Remember to study for algebra');
> foo.viewNotes();
= "Math: Fun course; Remember to study for algebra"
> foo.addNote(102, 'Difficult subject');
> foo.viewNotes();
= "Math: Fun course; Remember to study for algebra"
= "Advanced Math: Difficult subject"
> foo.updateNote(101, 'Fun course');
> foo.viewNotes();
= "Math: Fun course"
= "Advanced Math: Difficult subject"
```

### Solution

```javascript
function createStudent(name, year) {
  return {
    name,
    year,
    courses: [],
    info() {
      return `${this.name} is a ${this.year} year student`;
    },
    isValidCourse(course) {
      return (typeof course.name === 'string') &&
        (typeof course.code === 'number');
    },
    addCourse(course) {
      if (this.isValidCourse(course)) {
        this.courses.push(course);
      } else {
        return 'Invalid course! A course must have a name and a code.';
      }
    },
    listCourses() {
      return this.courses;
    },
    addNote(code, note) {
      let course = this.courses.find(currentCourse => {
        return currentCourse.code === code;
      });
      if (!course) return `There is no course with code ${code}.`;

      if (!course.note) {
        course.note = note;
      } else {
        course.note += '; ' + note;
      }
    },
    updateNote(code, note) {
      let course = this.courses.find(currentCourse => {
        return currentCourse.code === code;
      });
      if (!course) return `There is no course with code ${code}.`;

      course.note = note;
    },
    viewNotes() {
      this.courses.forEach(course => {
        if (course.note) console.log(`${course.name}: ${course.note}`);
      });
    },
  };
};
```

---

## 5. School

Create a `school` object. The `school` object uses the `student` object from the previous exercise. It has methods that use and update information about the student. Be sure to check out the previous exercise for the other arguments that might be needed by the `school` object. Implement the following methods for the school object:

* `addStudent`: Adds a student by creating a new student and adding the student to a collection of students. The method adds a constraint that the year can only be any of the following values: `'1st'`, `'2nd'`, `'3rd'`, `'4th'`, or `'5th'`. Returns a student object if year is valid otherwise it logs "Invalid Year".
* `enrollStudent`: Enrolls a student in a course.
* `addGrade`: Adds the grade of a student for a course.
* `getReportCard`: Logs the grades of a student for all courses. If the course has no grade, it uses "In progress" as the grade.
* `courseReport`: Logs the grades of all students for a given course name. Only student with grades are part of the course report.

To test your code, use the three student objects listed below. Using the three student objects, produces the following values from the `getReportCard` and `courseReport` methods respectively.

```javascript
// Examples of created student objects with grades; methods on the objects are not shown here for brevity.
// The following are only showing the properties that aren't methods for the three objects
foo;
{
  name: 'foo',
  year: '3rd',
  courses: [
    { name: 'Math', code: 101, grade: 95, },
    { name: 'Advanced Math', code: 102, grade: 90, },
    { name: 'Physics', code: 202, }
  ],
}

bar;
{
  name: 'bar',
  year: '1st',
  courses: [
    { name: 'Math', code: 101, grade: 91, },
  ],
}

qux;
{
  name: 'qux',
  year: '2nd',
  courses: [
    { name: 'Math', code: 101, grade: 93, },
    { name: 'Advanced Math', code: 102, grade: 90, },
   ],
}
```

```javascript
// getReportCard output

> school.getReportCard(foo);
= Math: 95
= Advanced Math: 90
= Physics: In progress
```

```javascript
//courseReport output

> school.courseReport('Math');
= =Math Grades=
= foo: 95
= bar: 91
= qux: 93
= ---
= Course Average: 93

> school.courseReport('Advanced Math');
= =Advanced Math Grades=
= foo: 90
= qux: 90
= ---
= Course Average: 90

> school.courseReport('Physics');
= undefined
```

### Solution

```javascript
let school = {
  students: [],
  addStudent(name, year) {
    const VALID_YEARS = ['1st', '2nd', '3rd', '4th', '5th'];

    if (VALID_YEARS.includes(year)) {
      let student = createStudent(name, year);
      this.students.push(student);
      return student;
    } else {
      console.log('Invalid Year');
      return;
    }
  },
  getStudent(name) {
    return this.students.find(student => student.name === name);
  },
  enrollStudent(name, course) {
    let student = this.getStudent(name);
    student.addCourse(course);
  },
  addGrade(studentName, courseCode, grade) {
    let student = this.getStudent(studentName);
    let course = student.getCourse(courseCode);
    course.grade = grade;
  },
  getReportCard(student) {
    student.courses.forEach(course => {
      console.log(`${course.name}: ${course.grade || 'In progress'}`);
    });
  },
  courseReport(courseName) {
    let scores = [];

    this.students.forEach(student => {
      let course = student.courses.find(({name}) => name === courseName);
      if (course && course.grade) {
        scores.push({ name: student.name, grade: course.grade });
      }
    });

    if (scores.length > 0) {
      console.log(`=${courseName} Grades=`);
      scores.forEach(({name, grade}) => console.log(`${name}: ${grade}`));

      console.log('---');

      let averageGrade = scores.reduce((sum, score) => sum + score.grade, 0);
      averageGrade = Math.round(averageGrade / scores.length);

      console.log(`Course Average: ${averageGrade}`);
    }

    return;
  },
};

let foo = school.addStudent('foo', '3rd');
school.enrollStudent('foo', { name: 'Math', code: 101, });
school.addGrade('foo', 101, 95);
school.enrollStudent('foo', { name: 'Advanced Math', code: 102, });
school.addGrade('foo', 102, 90);
school.enrollStudent('foo', { name: 'Physics', code: 202, });
console.log(foo);

let invalidStudent = school.addStudent('invalid student', '8th');
console.log(invalidStudent);

let bar = school.addStudent('bar', '1st');
school.enrollStudent('bar', { name: 'Math', code: 101, });
school.addGrade('bar', 101, 91);
console.log(bar);

let qux = school.addStudent('qux', '2nd');
school.enrollStudent('qux', { name: 'Math', code: 101, });
school.addGrade('qux', 101, 93);
school.enrollStudent('qux', { name: 'Advanced Math', code: 102, });
school.addGrade('qux', 102, 90);
console.log(qux);

school.getReportCard(foo);
school.courseReport('Math');
school.courseReport('Advanced Math');
school.courseReport('Physics');
```

#### Adjustments based on provided solution

`enrollStudent` method should take a student, not a student's name; it should also take `courseName` and `courseCode`, not a course object:

```javascript
  enrollStudent(student, courseName, courseCode) {
    student.addCourse({ name: courseName, code: courseCode });
  },
```

`addGrade` method should take a student, not a student's name:

```javascript
  addGrade(student, courseCode, grade) {
    let course = student.getCourse(courseCode);
    course.grade = grade;
  },
```
