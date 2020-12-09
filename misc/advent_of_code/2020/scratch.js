'use strict';

// Input: string representing boot code (list of instructions
// Output: a number representing the value of accumulator immediately before looping
// Rules/Implicit Knowledge
//   accumulator global value initialized to 0
//   possible instructions:
//     1) acc: add the argument to the global accumulator
//     2) jmp: move to a new instruction based on argument (that many lines forward or backwards)
//     3) nop: do noting; continue to the next immediate instruction
//   instructions repeat at some point
//     when encountering the first repeated instruction, return accumulator's prior value
// Examples: see below
// Edge Cases
// Data Structure
// Algorithm
//   virtual machine
//     create initializer function
//     parse instructions
//       split bootCode on newlines to array of instructions
//       split instruction on space to operation and argument
//     acc
//     jmp
//     nop
// Code



let bootCode =
'nop +0\n' +
'acc +1\n' +
'jmp +4\n' +
'acc +3\n' +
'jmp -3\n' +
'acc -99\n' +
'acc +1\n' +
'jmp -4\n' +
'acc +6';
