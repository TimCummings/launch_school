
# Input Attributes - 9/23/2020

There are a variety of supported attributes for the `input` tag. Memorize the ones listed here.

## Value

Most input controls can use the `value` attribute, but the meaning can change with the type of input.

* text (`text`, `email`, `number`): `value` assigns a default; use one if it exists (either loaded from the database or already provided by the user in the session)
* `checkbox`/`radio`: `value` defines the value that is submitted with the form to the server for that element
* buttons (`submit`, `reset`, `button`): `value` is the label text that appears on the button

## Other Text Field Attributes

These apply to most text type fields.

* `size`: specifies the width (in characters)
* `maxlength`: limits the maximum length of input values (this can be more or less than `size`)
* `placeholder`: displays some text when a field is empty (most browsers show `placeholder` text as faint or grayed out); sometimes `placeholder` will be used instead of `label`, but you should ALWAYS include labels, even if you have to hide them via CSS (for accessibility)

> `size` is an *approximation*; it is also overriden by CSS `width`

HTML5 also specifies a `minlength` attribute, but support for it is poor currently.

## Disabled

`disabled` `input` elements are rendered but the user cannot interact with them. Helpful CSS pseudoclasses: `:disabled` and `:enabled`.

## Required

Browsers won't let a user submit a form until all required inputs have been completed. CSS pseudoclass: `:required`.

## Autocomplete

Can be turned on (`autocmplete="on"`) or off (`autocmplete="off"`) to allow compatible browsers (especially on mobile devices) to store `input` data for future reuse. Autocomplete can be annoying for certain input fields. It does NOT work with `password` input types.

## Autocorrect

This is not currently part of the HTML5 standard, but it's supported by some mobile browsers like Safari. Possible values are `"on"` or `"off"`. It can be annoying when active for names and addresses.

## Autocapitalize

This is not currently a part of the HTML5 standard, but it's supported by some mobile browsers like Safari and Chrome. Possible values are `"none"`, `"sentences"`, `"words"`, `"characters"`.
