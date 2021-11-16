
# Project: Photo Gallery - Introduction and Server Setup - 3/30/2021

In this project, we're going to be leveraging everything we've learned in the course so far, including handling events, making Ajax requests, and updating the DOM using a templating library. We'll be creating a photo gallery based on data that we receive from our API server that will allow us to like and favorite a photo. The comments for each photo will be rendered below the slideshow and the form will allow us to send new comments back via AJAX. When the slideshow advances, the details of the photo and the comments are re-rendered to match the visible image.

## Server Set up

To complete this project, you will need to run a local server to obtain the data. We have provided a completed Node server with the starter project that you can download and set up. [Download this archive](https://d3905n0khyu9wc.cloudfront.net/photo_gallery/photo_gallery.zip), then make sure you have Node installed. You can install it by following the instructions on [Node's website](http://nodejs.org/). This also installs NPM, a package manager for Node. This acts as a way to install the external code our server needs to run. To install these packages in the directory where your project is located, unzip the download archive in that directory, then change your current directory to `photo_gallery2`. Once there, you can run `npm install` to install the packages. Note that your code needs to be placed in this `photo_gallery2` directory.

To install these packages, run `npm install` in the root of your project directory.

Please check the included files. The HTML file is in the `public` directory and named `index.html`. When you have the server running and you visit the root URL, you will receive this page. The stylesheets and javascript files are in the `public/stylesheets` and `public/javascripts` directories. You'll notice that you also have a `public/images` directory with the next and previous slide icons in it.

You can run the server with the command `npm start` to see your site. The server will now be running on port `3000`, meaning you will be able to access the server at `http://localhost:3000`. To stop the server, press `Ctrl-c`.

> Recent versions of OS X may put up a message asking you to allow or deny port 3000 connections for this app; you should allow it.

Check the styles for the slideshow portion and see how we've set the `#slideshow` element to `position: relative` and the slides are each set to `position: absolute`. This will set them on top of each other. We've also hidden every slide (`figure`) after the first one with the adjacent sibling selector, `figure + figure`.

In the HTML, we're using dummy data for the slides and the comments to mock up the look and feel of the page. We've also included three Handlebars templates at the end that you'll dynamically populate with server data, and insert into the document.

Alternatively, here is an [HTML file](https://d3905n0khyu9wc.cloudfront.net/photo_gallery/index.html) with the dummy data removed. You may choose to replace the included HTML file in the zipped file with this.

> Note that in the `index.html` file in both the archive zip file and the HTML file linked above, the call to the partial in the `photo_comments` template should be `{{> photo_comment}}` not `{{> comment}}`.
