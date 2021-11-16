
# Practice Problems: Handlebars Basics - 3/24/2021

To test your work with Handlebars, download a copy of Handlebars from [its homepage](http://handlebarsjs.com/) and include it in the `head` element of a blank HTML file. You could also bring it in directly from a public CDN (Content Delivery Network) with a `script` tag like this:

```javascript
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.5/handlebars.js"></script>
```

We are going to work with a Handlebars template for a blog post and a post object:

```javascript
<script id="post" type="text/x-handlebars">
  <article>
    <h1>{{title}}</h1>
    <p><time>Posted on {{published}}</time></p>
    {{body}}
  </article>
</script>
```

```javascript
let post = {
  title: 'Lorem ipsum dolor sit amet',
  published: 'April 1, 2015',
  body: 'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit.'
};
```

Feel free to check [Handlebars website](http://handlebarsjs.com/) for references.

My HTML file: [handlebars_basics.html](handlebars_basics.html)

1. Locate the template by ID and compile it to a template function. Render the post to the `body` element using the function.

### Solution

```javascript
const template = document.getElementById('post').innerHTML;
let postTemplate = Handlebars.compile(template);

document.body.insertAdjacentHTML('beforeend', postTemplate(post));
```

---

2. Change your `post` object's `body` property to contain HTML elements as part of the string. Modify your Handlebars template to allow HTML to be output unescaped.

### Solution

```javascript
let post = {
  title: 'Lorem ipsum dolor sit amet',
  published: 'April 1, 2015',
  body: '<p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit.</p>'
};

const template = document.getElementById('post').innerHTML;
let postTemplate = Handlebars.compile(template, { noEscape: true });

document.body.insertAdjacentHTML('beforeend', postTemplate(post));
```

#### Adjustments based on provided solution

My solution works, but the provided solution is cleaner:

```javascript
post.body = '<p>' + post.body + '</p>';

// triple curly braces (the so-called "triple-stash") will not escape HTML:
<script id="post" type="text/x-handlebars">
  <article>
    <h1>{{title}}</h1>
    <p><time>Posted on {{published}}</time></p>
    {{{body}}}
  </article>
</script>
```

---

3. Add a property called `tags` on the `post` object that will be an array of strings to represent tags added to the blog post. Use the Handlebars `each` [built-in helper](https://handlebarsjs.com/guide/builtin-helpers.html#each) to output all tags for the post.

### Solution

```javascript
<script id="post" type="text/x-handlebars">
  <article>
    <h1>{{title}}</h1>
    <p><time>Posted on {{published}}</time></p>
    {{{body}}}
  </article>
  <strong>Tags:</strong>
  <ul class="tags">
    {{#each tags}}
      <li>{{this}}</li>
    {{/each}}
  </ul>
</script>

// ...

post.tags = ['Latin', 'cool', 'tech'];
```

---

4. Create a separate template for the HTML element that wraps each tag. Using the handlebars partial method, register the template as a partial using the name "tag" and replace the HTML for tags in the main template with a reference to the partial.

### Solution

```javascript
<script id="post" type="text/x-handlebars">
  <article>
    <h1>{{title}}</h1>
    <p><time>Posted on {{published}}</time></p>
    {{{body}}}
  </article>
  <footer>
    <p>Tags:
      {{#each tags}}
        {{> tagTemplate}}
      {{/each}}
    </p>
  </footer>
</script>

<script id="tag" type="text/x-handlebars">
  <strong>{{this}}</strong>
</script>

<script>
  // ...

  let tagTemplateHTML = document.getElementById('tag').innerHTML;
  let tagTemplate = Handlebars.compile(tagTemplateHTML);
  Handlebars.registerPartial('tagTemplate', tagTemplateHTML);

</script>
```

---

5. Create a `posts` array, adding the existing post to it. Add a second post with no tags property. Modify your template to check for the existence of tags, and if none exist, output a "Not tagged" message. Wrap the template in an each loop to output each post.

### Solution

```javascript
<script id="post" type="text/x-handlebars">
  {{#each posts}}
    <article>
      <h1>{{this.title}}</h1>
      <p><time>Posted on {{published}}</time></p>
      {{{body}}}
    </article>
    <footer>
      <p>Tags:
        {{#each tags}}
          {{> tagTemplate}}
        {{else}}
          Not tagged.
        {{/each}}
      </p>
    </footer>
  {{/each}}
</script>

<script id="tag" type="text/x-handlebars">
  <strong>{{this}}</strong>
</script>

<script>
  let post1 = {
    title: 'Lorem ipsum dolor sit amet',
    published: 'April 1, 2015',
    body: '<p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit.</p>',
    tags: ['Latin', 'cool', 'tech'],
  };

  let post2 = {
    title: 'Maecenas vitae vehicula urna',
    published: 'April 8, 2015',
    body: '<p>Fusce eget aliquet felis. Integer sed eleifend ex, eu efficitur leo. Etiam vel tellus sed nulla tempor vehicula. Nunc sollicitudin velit nunc, quis facilisis justo laoreet non. Morbi faucibus tincidunt justo, a aliquet nibh cursus vitae. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Morbi risus turpis, congue sed tristique et, vulputate quis dui. Nulla facilisi. Nam placerat volutpat mollis. Nullam luctus, est vitae hendrerit venenatis, leo lacus suscipit mi, sed volutpat mi risus nec sem. Mauris ut sem mauris.</p>',
  };

  const posts = [post1, post2];

  let postTemplate = Handlebars.compile(document.querySelector('#post').innerHTML);

  let tagTemplateHTML = document.getElementById('tag').innerHTML;
  let tagTemplate = Handlebars.compile(tagTemplateHTML);
  Handlebars.registerPartial('tagTemplate', tagTemplateHTML);

  document.body.insertAdjacentHTML('beforeend', postTemplate({ posts }));
</script>
```
