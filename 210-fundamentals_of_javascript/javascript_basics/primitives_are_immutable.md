
# Primitive Values are Immutable

Most of the data types we've seen so far are *primitive types*: JavaScript represents them directly at the lowest level of the language implementation. JavaScript primitives include:

* number
* string
* boolean
* null
* undefined
* symbols (ES6)
* big integers (ES9)

All JavaScript primitives are immutable. They cannot be changed once created. They may appear to change over the lifetime of a program, but that is an illusion. Instead of changing, variables are assigned entirely new values.

All other JavaScript language constructs are Objects, which are mutable.
