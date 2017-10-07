
[comment]: # (exercises.md)

# Regex Book - 10/4/2017

---
#### 1. Write a method that returns true if its argument looks like a URL, false if it does not.

Examples:

Ruby
``` ruby
url?('http://launchschool.com')   # -> true
url?('https://example.com')       # -> true
url?('https://example.com hello') # -> false
url?('   https://example.com')    # -> false
```

JavaScript
``` javascript
isUrl('http://launchschool.com');   // -> true
isUrl('https://example.com');       // -> true
isUrl('https://example.com hello'); // -> false
isUrl('   https://example.com');    // -> false
```

### Solution
``` ruby
def url?(string)
  !!(string =~ /\Ahttps?:\/{2}\S+\.(biz|com|io|me|net|org|)\S*\z/)
end
```

---

#### 2. Write a method that returns all of the fields in a haphazardly formatted string. The fields are separated by a variety of spaces, tabs, and commas, with possibly multiple occurrences of these characters.

Examples:

Ruby
``` ruby
fields("Pete,201,Student")
# -> ['Pete', '201', 'Student']

fields("Pete \t 201    ,  TA")
# -> ['Pete', '201', 'TA']

fields("Pete \t 201")
# -> ['Pete', '201']
```

JavaScript
``` javascript
fields("Pete,201,Student");
// -> ['Pete', '201', 'Student']

fields("Pete \t 201    ,  TA");
// -> ['Pete', '201', 'TA']

fields("Pete \t 201");
// -> ['Pete', '201']
```

### Solution
``` ruby
def fields(string)
  string.split /[ \t,]+/
end
```

---

#### 3. Write a method that changes the first arithmetic operator (+, -, [asterisk], /) in a string to a '?'' and returns the resulting string. The original string should not be modified.

Examples:

Ruby
``` ruby
mystery_math('4 + 3 - 5 = 2')
# -> '4 ? 3 - 5 = 2'

mystery_math('(4 * 3 + 2) / 7 - 1 = 1')
# -> '(4 ? 3 + 2) / 7 - 1 = 1'
```

JavaScript
``` javascript
mysteryMath('4 + 3 - 5 = 2');
// -> '4 ? 3 - 5 = 2'

mysteryMath('(4 * 3 + 2) / 7 - 1 = 1');
// -> '(4 ? 3 + 2) / 7 - 1 = 1'
```

### Solution
``` ruby
def mystery_math(text)
  text.sub(/[+\-*\/]/, '?')
end
```

---

#### 4. Write a method that changes every arithmetic operator (+, -, [asterisk], /) to a '?' and returns the resulting string. The original string should not be modified.

Examples:

Ruby
``` ruby
mysterious_math('4 + 3 - 5 = 2')           # -> '4 ? 3 ? 5 = 2'
mysterious_math('(4 * 3 + 2) / 7 - 1 = 1') # -> '(4 ? 3 ? 2) ? 7 ? 1 = 1'
```
JavaScript
``` javascript
mysteriousMath('4 + 3 - 5 = 2');           // -> '4 ? 3 ? 5 = 2'
mysteriousMath('(4 * 3 + 2) / 7 - 1 = 1'); // -> '(4 ? 3 ? 2) ? 7 ? 1 = 1'
```

### Solution
``` ruby
def mysterious_math(text)
  text.gsub(/[+\-*\/]/, '?')
end
```

---
#### 5. Write a method that changes the first occurrence of the word apple, blueberry, or cherry in a string to danish.

Examples:

Ruby
``` ruby
danish('An apple a day keeps the doctor away')
# -> 'An danish a day keeps the doctor away'

danish('My favorite is blueberry pie')
# -> 'My favorite is danish pie'

danish('The cherry of my eye')
# -> 'The danish of my eye'

danish('apple. cherry. blueberry.')
# -> 'danish. cherry. blueberry.'

danish('I love pineapple')
# -> 'I love pineapple'
```
JavaScript
``` javascript
danish('An apple a day keeps the doctor away');
// -> 'An danish a day keeps the doctor away'

danish('My favorite is blueberry pie');
// -> 'My favorite is danish pie'

danish('The cherry of my eye');
// -> 'The danish of my eye'

danish('apple. cherry. blueberry.');
// -> 'danish. cherry. blueberry.'

danish('I love pineapple');
// -> 'I love pineapple'
```

### Solution
``` ruby
def danish(text)
  text.sub(/\b(apple|blueberry|cherry)\b/i, 'danish')
end
```

---
#### 6. Challenge: write a method that changes dates in the format 2016-06-17 to the format 17.06.2016. You must use a regular expression and should only use methods described in this section.

Example:

Ruby
``` ruby
format_date('2016-06-17') # -> '17.06.2016'
format_date('2016/06/17') # -> '2016/06/17' (no change)
```
JavaScript
``` javascript
formatDate('2016-06-17'); // -> '17.06.2016'
formatDate('2016/06/17'); // -> '2016/06/17' (no change)
```

### Solution
``` ruby
def format_date(date)
  date.sub(/(\d{4})-(\d{2})-(\d{2})/, '\3.\2.\1')
end
```

---
#### 7. Challenge: write a method that changes dates in the format 2016-06-17 or 2016/06/17 to the format 17.06.2016. You must use a regular expression and should only use methods described in this section.

Example:

Ruby
``` ruby
format_date('2016-06-17') # -> '17.06.2016'
format_date('2017/05/03') # -> '03.05.2017'
format_date('2015/01-31') # -> '2015/01-31' (no change)
```
JavaScript
``` javascript
format_date('2016-06-17'); // -> '17.06.2016'
format_date('2017/05/03'); // -> '03.05.2017'
format_date('2015/01-31'); // -> '2015/01-31' (no change)
```

### Solution
``` ruby
def format_date(date)
  date.sub(/(\d{4})([\-\/])(\d{2})\2(\d{2})/, '\4.\3.\1')
end
```

Alternate solution using named capturing:
``` ruby
def format_date(date)
  date_regex = /(?<year>\d{4})
                (?<delim>[\-\/])
                (?<month>\d{2})
                \k<delim>
                (?<day>\d{2})/x

  date.sub(date_regex, '\k<day>.\k<month>.\k<year>')
end
```
