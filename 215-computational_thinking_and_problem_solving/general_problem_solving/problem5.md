
# Problem 5 - 11/24/2020

Implement encoding and decoding for the rail fence cipher.

The Rail Fence cipher is a form of transposition cipher that gets its name from the way in which it's encoded. It was already used by the ancient Greeks.

In the Rail Fence cipher, the message is written downwards on successive "rails" of an imaginary fence, then moving up when we get to the bottom (like a zig-zag). Finally the message is then read off in rows.

For example, using three "rails" and the message "WE ARE DISCOVERED FLEE AT ONCE", the cipherer writes out:

```
W . . . E . . . C . . . R . . . L . . . T . . . E
. E . R . D . S . O . E . E . F . E . A . O . C .
. . A . . . I . . . V . . . D . . . E . . . N . .
```

Then reads off:

```
WECRLTEERDSOEEFEAOCAIVDEN
```

To decrypt a message you take the zig-zag shape and fill the ciphertext along the rows.

```
? . . . ? . . . ? . . . ? . . . ? . . . ? . . . ?
. ? . ? . ? . ? . ? . ? . ? . ? . ? . ? . ? . ? .
. . ? . . . ? . . . ? . . . ? . . . ? . . . ? . .
```

The first row has seven spots that can be filled with "WECRLTE".

```
W . . . E . . . C . . . R . . . L . . . T . . . E
. ? . ? . ? . ? . ? . ? . ? . ? . ? . ? . ? . ? .
. . ? . . . ? . . . ? . . . ? . . . ? . . . ? . .
```

Now the 2nd row takes "ERDSOEEFEAOC".

```
W . . . E . . . C . . . R . . . L . . . T . . . E
. E . R . D . S . O . E . E . F . E . A . O . C .
. . ? . . . ? . . . ? . . . ? . . . ? . . . ? . .
```

Leaving "AIVDEN" for the last row.

```
W . . . E . . . C . . . R . . . L . . . T . . . E
. E . R . D . S . O . E . E . F . E . A . O . C .
. . A . . . I . . . V . . . D . . . E . . . N . .
```

If you now read along the zig-zag shape you can read the original message.

### Encoding Solution

```javascript
// // ENCODING
// Input:
//   * string message to encode with rail fence cipher
//   * also allow user to specify number of rails/rows?
// Output: string representing a message that has been encoded with rail fence cipher
// Rules/Implicit Knowledge
//   * rails: rows in a grid onto which a message is encoded
//   * whitespace is ignored; only letters are encoded
//   * when encoding:
//     * each column has only one letter
//     * letters are inserted into rows in a zig-zag pattern:
//       * starting with the top row then moving down diagonally
//       * once the last row is reached, insertion moves diagonally up towards the top
//     * once all letters are inserted into rows, read rows normally (left to right, top to bottom) for the final encoded string
// Examples
//   'WE ARE DISCOVERED FLEE AT ONCE' ->
//   W . . . E . . . C . . . R . . . L . . . T . . . E
//   . E . R . D . S . O . E . E . F . E . A . O . C .
//   . . A . . . I . . . V . . . D . . . E . . . N . . ->
//   'WECRLTEERDSOEEFEAOCAIVDEN'
//   console.log(railFenceEncode('WE ARE DISCOVERED FLEE AT ONCE') === 'WECRLTEERDSOEEFEAOCAIVDEN');
//   console.log(railFenceEncode([]) === '');
//   console.log(railFenceEncode('') === '');
// Edge Cases
//   input not a string
//   empty string
//   more rows than characters
// Data Structure: grid - array of arrays (rails and columns)
//   each sub array represents a rail
//   when working with the grid:
//     the first index determines which rail
//     the second index determines which column in the rail
// Algorithm
//   populate the rails
//     initialize goingUp to true (tells us if we're zigging or zagging)
//     initialize prevRail to -1
//     initialize a grid - array of arrays: rails
//     strip whitespace from message and iterate each character
//       set railIndex to output of nextRail function
//       set prevRail to railIndex
//       if goingUp and railIndex is the last rail, set goingUp to false
//       if not goingUp and railIndex is the first rail, set goingUp to true
//       push the current character into the next rail (determined by railIndex)
//       push undefined into all of the other rails
//   nextRail function
//     if goingUp, return railIndex + 1
//     if not goingUp, return railIndex - 1
// Code

let setupFence = function setupFence(numRails) {
  let rails = [];
  for (let counter = 1; counter <= numRails; counter += 1) {
    rails.push([]);
  }

  return {
    rails,
    goingUp: true,
    prevRail: -1,
    firstRail: 0,
    lastRail: numRails - 1,
  };
};

let nextRail = function nextRail(fence) {
  if (fence.goingUp && fence.prevRail < fence.lastRail) {
    return fence.prevRail + 1;
  } else if (!fence.goingUp && fence.prevRail > fence.firstRail) {
    return fence.prevRail - 1;
  } else {
    return fence.prevRail;
  }
};

let insert = function insert(fence, value, index) {
  fence.rails.forEach((rail, railIndex) => {
    if (railIndex === index) {
      rail.push(value);
    } else {
      rail.push(undefined);
    }
  });
};

let zigZag = function zigZag(fence, message) {
  message.replace(/\s/g, '').split('').forEach(character => {
    let railIndex = nextRail(fence);
    fence.prevRail = railIndex;

    if (fence.goingUp && railIndex === fence.lastRail) {
      fence.goingUp = false;
    } else if (!fence.goingUp && railIndex === fence.firstRail) {
      fence.goingUp = true;
    }

    insert(fence, character, railIndex);
  });
};

let readFence = function readFence(fence) {
  let result = '';
  fence.rails.forEach(rail => result += rail.join(''));

  return result;
};

let railFenceEncode = function railFenceEncode(message, numRails = 3) {
  if (typeof message !== 'string' || message === '') return '';

  let fence = setupFence(numRails);
  zigZag(fence, message);

  return readFence(fence);
};

console.log(railFenceEncode('WE ARE DISCOVERED FLEE AT ONCE', 1) === 'WEAREDISCOVEREDFLEEATONCE');
console.log(railFenceEncode('WE ARE DISCOVERED FLEE AT ONCE', 4) === 'WIREEEDSEEEACAECVDLTNROFO');
console.log(railFenceEncode('WE ARE DISCOVERED FLEE AT ONCE') === 'WECRLTEERDSOEEFEAOCAIVDEN');
console.log(railFenceEncode([]) === '');
console.log(railFenceEncode('') === '');
```

---

### Decoding Solution

```javascript
// DECODING
// Input:
//   * string representing a message that has been encoded wit hrail fence cipher
//   * also allow user to specify number of rails/rows?
// Output: decoded string message
// Examples
//   console.log(railFenceDecode('WECRLTEERDSOEEFEAOCAIVDEN') === 'WEAREDISCOVEREDFLEEATONCE');
//   console.log(railFenceDecode([]) === '');
//   console.log(railFenceDecode('') === '');
// Edge Cases
//   not a string
//   empty string
// Data Structure
// Algorithm
//   setup a fence as if we were encoding a message
//   create a string of placeholder characters the same length as the encoded message string
//     use '#' because it looks like a fence
//   iterate the characters of the encoded message
//     starting with the first rail, find the index of the next placeholder and replace it with the current character
//     when there are no more placeholders, move to the next rail
//   reset fence properties (goingUp, prevRail)
//   follow the insertion path but read letters instead of inserting
// Code

let rowFill = function rowFill(fence, message) {
  let currentRail = fence.firstRail;
  message.split('').forEach(character => {
    let nextPlaceholder = fence.rails[currentRail].indexOf('#');
    if (nextPlaceholder === -1) {
      currentRail += 1;
      nextPlaceholder = fence.rails[currentRail].indexOf('#');
    }
    fence.rails[currentRail][nextPlaceholder] = character;
  });
};

let railFenceDecode = function railFenceDecode(message, numRails = 3) {
  if (typeof message !== 'string' || message === '') return '';

  let fence = setupFence(numRails);
  let placeholders = '#'.repeat(message.length);

  zigZag(fence, placeholders);
  rowFill(fence, message);

  fence.goingUp = true;
  fence.prevRail = -1;

  let decodedMessage = '';
  for (let column = 0; column < message.length; column += 1) {
    let railIndex = nextRail(fence);
    fence.prevRail = railIndex;

    if (fence.goingUp && railIndex === fence.lastRail) {
      fence.goingUp = false;
    } else if (!fence.goingUp && railIndex === fence.firstRail) {
      fence.goingUp = true;
    }

    decodedMessage += fence.rails[railIndex][column];
  }

  return decodedMessage;
};

console.log(railFenceDecode('WECRLTEERDSOEEFEAOCAIVDEN') === 'WEAREDISCOVEREDFLEEATONCE');
console.log(railFenceDecode('WEAREDISCOVEREDFLEEATONCE', 1) === 'WEAREDISCOVEREDFLEEATONCE');
console.log(railFenceDecode('WIREEEDSEEEACAECVDLTNROFO', 4) === 'WEAREDISCOVEREDFLEEATONCE');
console.log(railFenceDecode([]) === '');
console.log(railFenceDecode('') === '');
```
