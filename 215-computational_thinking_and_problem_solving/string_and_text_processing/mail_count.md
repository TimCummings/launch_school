
# Mail Count - 11/19/2020

The objective of this practice problem is to build a function that parses a string of email data. The function takes an argument that contains the data, parses it, then produces two basic statistics about the email:

* The number of email messages found in the string
* The date range of the email messages

The email messages string has the following characteristics:

* The string contains multiple email messages separated by the delimiter string `##||##`.
* Each email message has five parts. The delimiter string `#/#` separates the parts.
* The five parts are:
  * Sender
  * Subject
  * Date
  * Recipient
  * Body

* All five parts occur in the sequence shown above.

Examples

You can work with this [sample data](https://dbdwvr6p7sskw.cloudfront.net/210/files/email_data_v2.js).

> The sample data file is a JavaScript program snippet that defines a variable named `emailData`. The value of `emailData` is the data you will use for this practice problem. To avoid editor issues (some editors have problems with very long lines), we recommend that you include this file in your HTML, with a `script` element prior to the `script` element that contains your code:
>
> ```html
> <script src="//dbdwvr6p7sskw.cloudfront.net/210/files/email_data_v2.js"></script>
> <script>
>   // your code here
> </script>
> ```
>
> You can download the file and host it locally if you wish.

```javascript
function mailCount(emailData) {
  // ...
}

mailCount(emailData);

// console output

Count of Email: 5
Date Range: Sat Jun 25 2016 - Thu Aug 11 2016
```
