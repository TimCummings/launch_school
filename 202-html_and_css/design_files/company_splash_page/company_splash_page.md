
# On Your Own: A Company Splash Page - 10/1/2020

> You may notice different versions of the project in the videos on this page, as well as in the image that shows the structure of the `main` and `footer` areas. Don't worry about the pictured discrepancies; the downloaded design files show the design we want you to use.

In this project, you will take a simple design file and some image assets, and write the HTML and CSS you need to duplicate the design as well as you can. We provide you with both PSD and PNG design files, together with the image assets you will need. ([Download the zip file](https://d3jtzah944tvom.cloudfront.net/202/projects/lesson_7/company_splash_page.zip).)

If you have Photoshop or a workable alternative, we recommend that you try to create the final page using the PSD file. Otherwise, use the PNG file.

Watch our overview video to become more familiar with the project. Your job is to create the HTML and CSS to match the design.

Make sure you choose the most appropriate semantic HTML elements when creating the markup. The logo is the primary heading of the site, even though it is an image element; it should be the site header. The white box contains your main content, with subheadings and paragraphs of text, while the gray area includes a list of social media icons used as a footer; each image is a link to the appropriate social media site. You can use `#` as the URL.

While coding, be sure to check your work using the W3C HTML and CSS validators.

Your completed page should look like [ours](https://d3jtzah944tvom.cloudfront.net/202/projects/lesson_7/company_splash_page_final/site.html). Compare your markup and styles and see how close you came.

## Guidelines

When you start a project that already has a design, the first thing you should do is determine the HTML you need to recreate the design. Identify the major components of the page: headers, footers, main content areas, sections, asides, navigation, headings, paragraphs, etc. Build an initial copy of the HTML without worrying about the styles; this will give you something to look at as you work on the design. Your concern at this point is using semantic HTML to ensure the document structure makes sense.

Once you've built the HTML, you can start working on the CSS. Most developers will start with the overall look: the page background, the default font, the colors used, and the general placement of components. If you use Flex or Grid, you want to determine what columns, rows, and grid you need, and what elements go where. Your goal is to build something that approximates the final look.

Once you have a page that looks similar, you can start worrying about the details like padding, margins, borders, positioning, etc.

On this page, the starry background is a background image. The downloaded file contains this image along with the logo and the social media icons. Since the background image will cover the entire page, you can add it to your `body` element selector.

We show the background image below. Notice that it is a small portion of the entire background. You need to set the image to repeat in both directions to ensure it fills the page.

A white block encloses the rest of the page content - our `main` element - followed by the light gray block that contains our footer.

Use the character entity `&bull;` to produce the bullets before and after the heading text.

This project uses the Avenir font family as the default font:

* The two main headings use Avenir Heavy.
* The blue heading uses Avenir Black.
* The text content uses Avenir Medium.

You can use these fonts if you have them on your system, or you can download and install a free look-alike font named Nunito (Google it). If you can't use the Avenir variants or Nunito, try Helvetica, Arial, and the browser's default sans-serif font instead; note, though, that using any font other than Avenir or Nunito will make your job more difficult when you try to match the exact appearance.

You can see our [completed example here](https://d3jtzah944tvom.cloudfront.net/202/projects/lesson_7/company_splash_page_final/site.html). We also have an [example that uses Flex](https://d3jtzah944tvom.cloudfront.net/202/projects/lesson_7/company_splash_page_final/site2.html) for the footer.

## Challenge

If you want an additional challenge, try changing the page layout to a variable width by using a combination of min-width and max-width CSS properties. As you resize the browser window, the content should adjust in width to match the minimum and maximum widths.

#### Adjustments based on provided solution

* footer images should be in a list and should also be links
* supply background-color to header image
