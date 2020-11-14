// Code Review: Rot13 Cipher

// > After completing this practice problem, post your solution as a Code Review in this lesson's forums.

// Rot13 ("rotate by 13 places") is a letter-substitution cipher that translates a String into a new String:

// For each character in the original String:

//     If the character is a letter in the [modern English alphabet](https://en.wikipedia.org/wiki/English_alphabet#Modern_English), change it to the character 13 positions later in the alphabet. Thus, a becomes n. If you reach the end of the alphabet, return to the beginning. Thus, o becomes b.
//     Letter transformations preserve case. A becomes N while a becomes n.
//     Don't modify characters that are not letters.

// Write a Function, rot13, that takes a String and returns that String transformed by the rot13 cipher.

console.log(rot13('Teachers open the door, but you must enter by yourself.'));

// // logs:
// Grnpuref bcra gur qbbe, ohg lbh zhfg ragre ol lbhefrys.

// It's worth noting that rot13 applied twice results in the original string:

console.log(rot13(rot13('Teachers open the door, but you must enter by yourself.')));

// // logs:
// Teachers open the door, but you must enter by yourself.

// This happens since there are 26 characters in the modern English alphabet: 2 sets of 13.

function rot13(string) {
  function isLowerCase(character) {
    return character >= 'a' && character <= 'z';
  }

  function isUpperCase(character) {
    return character >= 'A' && character <= 'Z';
  }

  function rotate(character, midPoint) {
    let charCode = character.charCodeAt(0);

    if (character < midPoint) {
      charCode += OFFSET;
    } else {
      charCode -= OFFSET;
    }

    return String.fromCharCode(charCode);
  }

  const OFFSET = 13;
  const LOWER_MIDPOINT = 'n';
  const UPPER_MIDPOINT = 'N';
  let result = '';

  for (let index = 0; index < string.length; index += 1) {
    let character = string[index];

    if (isLowerCase(character)) {
      character = rotate(character, LOWER_MIDPOINT);
    } else if (isUpperCase(character)) {
      character = rotate(character, UPPER_MIDPOINT);
    }

    result += character;
  }

  return result;
}
