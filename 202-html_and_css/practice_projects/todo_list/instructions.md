
# Practice Project 2: Todo List - 10/11/2020

> The former assessment gave you 48 hours to complete this project, though most students would complete it in less than 24. You may take more time than that, but if you want to test yourself, try to limit yourself to 48 hours.

Your goal for this project is to build a Todo List manager using HTML and CSS. Do not use any JavaScript, and do not use any enhanced forms of HTML or CSS. The project will not be fully functional -- you won't be able to select different todo lists, won't be able to add or delete todos, and won't be able to mark todos as complete. However, you should be able to view the popup modal used for adding new todos, and the responsive hamburger should work to show and hide the navigation bar when your browser's width is less than 768 pixels wide.

You can download the design files from [here](https://d3jtzah944tvom.cloudfront.net/202/projects/assessment-20190922.zip).

There are three views of the Todo list that your project should provide:

* **The Todo List Page** page contains a list of Todo items and a `nav` pane for viewing groups of Todo items.
* **A mobile device version** of the Todo List page that hides the `nav` pane by default, but lets the user reveal it by clicking on a **responsive hamburger**.
* **The Modal** is a dialog that lets a user add a Todo item.

If we don't provide explicit details about something, use your judgment to determine what you should do.

## Todo List

![todos_list.png](todos_list.png)


* There are two main components:
  * The white `main` area contains the Todo list.
  * The purple `nav` area that contains groupings of Todo items (by month/year)
* The main Todo list should adjust its width as you adjust the width of the window. The navigation area should remain fixed in width.
* The color of a Todo item in the Todo list changes when you hover the cursor over it. Notice the cursor hovering over `Item 2` in the design file.
* Leave proper spacing between the Todo list in the `main` area and the right side of the browser window.
* Greyed-out Todo items with strikethroughs (see `Item 3`) represent completed Todo items.
* The selected `nav` group on the left is "highlighted" with a dark background (see 2/16 under "All Todos").
* The circle surrounding the count of Todo items should adjust its size accordingly (see the circle enclosing the number 18)
* When the window width is 768px wide or less:
  * Hide the `nav` area.
  * Show a **responsive hamburger** (three horizontal lines) above the Todo List in the `main` area.
  * Show the `nav` area when the user clicks the hamburger, then hide it again when the user clicks a second time. When you show the `nav` area, shift the `main` area to the right so you can still read it.
* Some items use images. Be sure to use them in your project:
  * `all-todos.png` - All Todos icon from the navigation area
  * `done.png` - Completed todos icon from the navigation area
  * `hamburger.png` - The "responsive hamburger" icon for mobile sizes
  * `plus.png` - The `+` sign for adding todos
  * `select.png` - The up and down arrows for the modal date controls
  * `ticked-box.png` - Checkbox for completed todo items in the main todo list
  * `trash.png` - Trash can for deleting todo items
  * `unticked-box.png` - Checkbox for incomplete todo items in the main todo list

### Mobile Device Screen

![todo-narrow.png](todo-narrow.png)

> Hint: Check [this article](http://www.outofscope.com/css-only-menu-toggle-no-javascript-required/) for inspiration.

### Modal Specifications

![todos-edit.png](todos-edit.png)

todo-edit

* The modal asks for three inputs: `Title`, `Due Date`, and `Description`.
* The `Due Date` has three selects: the `Day`, `Month`, and `Year` fields.
* The content of the modal input elements isn't critical. However, the spacing and alignment relative to each other within the modal are.
* Show the modal when the user clicks `Item 1`. Refer to the responsive hamburger implementation to learn how to respond to clicks.
* You don't have to provide a way to close the modal (a page refresh should do the trick).
* When the modal is visible, a translucent overlay should dim the white part of the screen behind it.
* Center the modal proportionally horizontally over the main todo list content.
* The modal should not change size when you adjust the width of the window.
* The modal should remain centered over the todo list content as you change the window width until it can no longer fit. When the modal won't fit, use your best judgment for its placement, but ensure the modal remains fully visible as long as possible.
* If you use the PSD file for this project, you can find the modal design in hidden layers. Otherwise, use the PNG show above.

## General Requirements

* Use standard HTML and CSS exclusively. Do not use Javascript or any HTML or CSS extensions, add-ons, or preprocessors.
* You may use Flex, Grid, floats, or positioning as needed and desired in the project.
* Your project doesn't have to connect to a server or database, but it should include the HTML that it would otherwise need: provide anchors, form controls, and actions where necessary. You can use a URL of `#` in tags that require URLs.
* Your HTML markup should pass the [W3C HTML validator](https://validator.w3.org/#validate_by_input). You may ignore warnings about browser-specific attributes like `autocapitalize` and `autocorrect`.
* Your CSS should pass the [W3C CSS validator](https://jigsaw.w3.org/css-validator/#validate_by_input).
* Check the appearance of your work on multiple browsers.
* Note that some browsers use `border-radius: 5px` to give rounded corners to the 3 drop-down boxes, but others do not. Your submission should show square corners regardless of which browser the grader uses.
* Use the design files to determine width, height, margins, and padding for elements (see below for colors and fonts). The design files show the project at a fixed screen width, but your project should stretch or shrink horizontally as the width changes. The navigation column should be fixed width, but the main todo list is the part that varies in width.
* If you do not have access to Photoshop or a viable alternative, you may use the provided PNG files instead. You can measure some aspects of the PNG files using most PNG viewers (like Mac's Preview program). Try to estimate the sizes of fonts, margins, padding, and other items as best you can. We'll be looking for visual differences. A blink comparison should help you get a close match for the design.
* The state of the page you build should match those of the above screenshots. For example, there should be 9 Todo items in the `main` area with 3 of those marked as complete.
* Please zip all your files (including the `README.md` if present) and include it as an attachment.

## Fonts, Icons, and Colors

If you can measure colors font sizes yourself, please feel free to try doing that. If you can't do that yourself, here are some values you can use for the various components of the app.

* Primary font (used in Todo list): 16px Helvetica, Arial, sans-serif
* The design files include the four icons you need.
* Navigation area colors:
  * Background: #464f77
  * Selected item background color: #38405e
  * Blue circles background color: #148fd5
  * Gray circles background color: #6b7292
  * White characters color: #ffffff
  * Dim characters color: #b2b5c3
* Todo Area and Modal Colors
  * Background: #ffffff
  * Black text: #060606
  * Dim text: #b3b3b3
  * Blue text and circles: #148fd5
  * Blue buttons background: #148fd5
  * Lines between todo items: #e7e7e7
* Opacity of Modal Overlay: 0.2

## Completed Project

Here are some things to look for in your completed project:

#### Operation

* Do a blink comparison between your completed project and the PNG files with your browser's window width set to 1200 pixels, or as close to that as you can get. This works best with the full page view and the modal view design files.
* Several numbers on the display have a circular background: make sure they are all circular except for the number 18 next to "All Todos"; that one should appear more lozenge-shaped (a flattened circle).
* Hover the cursor above one of the todos. The todo should change colors.
* Make sure the navigation bar hides itself when you reduce the window width to 768 pixels or less.
* While at 768 pixels, do a blink comparison with the appropriate design file.
* Click the responsive hamburger. The navigation bar should show itself.
* While at 768 pixels, do a blink comparison with the appropriate design file.
* Click the responsive hamburger. The navigation bar should hide itself.
* Slowly expand the window to more than 768 pixels and check that the navigation bar reveals itself automatically.
* Click item 1: the modal should open
* When the modal is open, the visible white area of the main screen should be grayed out.
* Make sure the drop-down widgets for the date fields look like the design file
* Reload the page to close the modal
* Check the app out in other browsers, your phone, and your tablet (if you have them)

#### HTML

* Validate your HTML
* Where is the code for your modal? Is your modal inside the list of todos? The modal is not part of the todo list, so it's semantically wrong to put it inside the todo list.
* Avoid `<div>` and `<span>` tags. Try to limit yourself to semantic HTML.
* Don't use tags for their appearance; use them semantically, then style them with CSS. In other words, don't use tags like `<b>` and `<strong>` to boldface the uncompleted todos and the currently selected date in the left column.

#### CSS

* Validate your HTML
* Try to avoid complex selectors. As much as possible, use simple selectors that are based on class names

> We can not provide code reviews for this project. Use the checklist above to perform a self review of your project and code.
