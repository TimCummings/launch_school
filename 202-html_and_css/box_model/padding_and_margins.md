
# Padding and Margins - 9/5/2020

* padding is inside the border; margin is outside
* padding is generally opaque; margin is generally transparent
* padding is part of the visible, clickable bounds of an element; margin is spacing between elements
* for `inline` elements, neither vertical padding nor vertical margin are used for spacing/placement
* for `block` elements, vertical margins collapse to the larger value (rather than adding, as with padding), e.g. two `p`s with `margin-bottom: 15px;` and `margin-top: 32px;`: the vertical margin between the two will be 32px, not 47px

### Should I Use Padding or Margins?

There's no firm answer to this question, but one useful strategy is to use margins for spacing between elements, and padding to affect the visible or clickable area of one. Within a container, use padding for horizontal separation between its edges and content, and margins for the vertical distance.

This approach works well but sometimes leaves you wondering about the correct choice. Another technique is to use margins everywhere except when you need padding. You probably need to use padding when:

* You want to change the height or width of a border.
* You want to adjust how much background is visible around an element.
* You want to alter the amount of clickable area.
* You want to avoid margin collapse.
* You want some horizontal spacing to the left or right of an `inline` element.
* As before, use padding to separate the left and right sides of a container from its content. Use margins for the vertical gap.

This approach is a simple mechanical process: ask yourself whether any of the above options apply to the element. If any do, use padding to provide those features. Otherwise, use margins. This strategy doesn't guarantee that you will make the correct choice between padding and margins in every situation. However, it should help you choose the right property most of the time.

> As you go through this course, you will see code that doesn't follow the padding vs. margins guidelines above. That's fine; they help you decide which to use, but they are not absolute laws. Not all developers must follow the same rules.

