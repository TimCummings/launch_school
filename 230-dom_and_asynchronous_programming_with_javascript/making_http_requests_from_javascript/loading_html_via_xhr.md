
# Example: Loading HTML via XHR - 3/9/2021

## Problems

Each product in our final example has an edit form that you access by clicking first on the item link, and then on "Edit this product." The code, though, incorrectly handles the form when you submit it.

1. What prevents the form submission from working? Investigate the problem with the web developer tools in your browser.

We'll see how to resolve this issue in upcoming assignments.

### Solution

Based on console output, the response has a status code of `404` which is not found. This is the same error the store initially had which we circumvented by listening for clicks on anchor elements, stopping their default behavior, and initiating our own AJAX request instead. I assume we'd need to do something similar here: listen for form submissions, stop their default behavior, and manually submit them with AJAX requests.
