
# Flex and Grid - 9/29/2020

So far, we've used floats and positioning to control CSS layouts. These have been around for a while and work well, but they make some things more complicated than they should be (like we saw with centering an element inside a positioned container) and you have to deal with new things, such as the effects of removing items from the normal document flow.

## Flex

`display: flex;` is a new property as of 2018 that seems poised for widespread growth. It solves many front-end headaches and support is strong in contemporary browsers. We recommend using it in your projects, including Launch School.

Flex is a one-dimensional layout tool: one row or column in a single flexbox. You *can* create a two-dimensional layout with multiple flexboxes, but Grid is better for that.

## Grid

`display: grid;` also seems poised for growth, but it's not quite as supported as Flex yet (~85% of users currently use browsers that understand Grid.) We also recommend using Grid.

Grid is a two-dimensional layout tool. You place elements in a grid format (rows and columns) at the same time. You *can* do a single row or column, but Flex is betterfor such cases.

## Further Study

Spend some time with these external resources. We don't expect you memorize everything, but you should know enough to use MDN and Google to produce some simple Flex and Grid layouts.

* Flex
  * **Video:** [15 minute student talk on Flex](https://launchschool.com/posts/b401d522)
  * **Video:** [Flexbox Tutorial (CSS): Real Layout Examples](https://www.youtube.com/watch?v=k32voqQhODc)
  * [A Complete Guide to Flexbox](https://css-tricks.com/snippets/css/a-guide-to-flexbox/)
  * [Using CSS Flexible Boxes](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Flexible_Box_Layout/Using_CSS_flexible_boxes)
*  Grid
  * **Video**: [CSS Grid Changes Everything](https://www.youtube.com/watch?v=7kVeCqQCxlk)
  * [A Complete Guide to Grid](https://css-tricks.com/snippets/css/complete-guide-grid/)
  * [CSS Grid Layout](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Grid_Layout)
  * [Grid by Example](https://gridbyexample.com/)
* Flex and Grid
  * [codepip: Learn to Code With Games](https://codepip.com/)
  * [Flexbox and Grids, your layout’s best friends](https://aerolab.co/blog/flexbox-grids)
