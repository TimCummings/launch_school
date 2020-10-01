
# Practice Problems: Floats 2 - 9/28/2020

For this problem set, use the Inspector to add CSS properties to the working page and see immediate results. If you need a review of the Inspector, see [the documentation](https://developers.google.com/web/tools/chrome-devtools/inspect-styles/). You must know how to inspect and edit pages and styles for this assignment; you don't need any other developer tools.

1. Open [this page](https://d3jtzah944tvom.cloudfront.net/lesson_4/exercises_floating_positioning/float1.html) then open the Inspector and find the div with the "floated" ID. Select it, then make the `div` float left by updating the styles tab.

### Solution

```css
#floated {
  float: left;
}
```

---

2. Can you determine why the blue paragraph hangs out beneath the right edge of the orange `div`? Add a CSS property to force the blue box beneath the orange; don't worry about the widths - the blue box will be wider than the orange.

### Solution

To force the blue box beneath the orange, blue must clear the float (orange):

```css
main > p {
  clear: both;
}
```

---

3. Why is the orange container now narrower than the blue? How can you keep the orange box floated but take on the same width as the blue?

### Solution

Neither the orange element nor the blue have styles that specify their size. Because orange is floated left, its width is automatically calculated from its content. Blue, as a non-floated block element, extends to occupy all available width within its parent. This results in the width disparity between orange and blue.

To make the orange element the same width as the blue while keeping it floated, we can specify a width of 100%:

```css
#floated {
  width: 100%;
}
```

---

4. Change the floated element's width to 20%, then remove the `clear` from the `p` below it. Try setting a left margin on the blue paragraph equal to the width of the floated element.

### Solution

```css
#floated {
  width: 20%;
}

main > p {
  /* DELETE clear: both; */
  margin-left: 20%;
}
```

---

5. Remove the left margin on the blue paragraph, and have it float right instead. What do you think will happen? Will the orange and blue elements sit side-by-side?

### Solution

I think the blue paragraph will move to its own row since its content exceeds the space remaining on the row with orange.

```css
main > p {
  /* DELETE margin-left: 20%; */
  float: right;
}
```

---

6. Ideally, you want both boxes side-by-side. In an attempt to do that, you add a width of 80% to the blue paragraph. What happens? How can you fix this problem without changing the width setting?

### Solution

Blue has padding which is being added to make it larger than 80%. Add `box-sizing: border-box;` to blue:

```css
main > p {
  box-sizing: border-box;
  width: 80%;
}
```
