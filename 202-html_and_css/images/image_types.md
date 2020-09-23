
# Image Types - 9/11/2020

The three most common types of images you'll encounter on the internet are: **jpg**, **png**, and **gif**.

## JPG

* The most common image format in web documents.
* They provide a good balance of image quality and compression.
* JPG compression is **lossy**! Every edit further reduces quality.
* Some JPGs (or any after severe quality loss) will have **JPEG artifacts**. They become more noticeable the further image quality degrades.
* Rule of thumb: aim for as much file size reduction as possible without noticeable loss of detail or artifacts.
* JPGs generally don't work well as CSS background images.

## PNG

* PNGs use non-lossy compression, but file sizes are usually larger, sometimes considerably.
* Support transparency; useful for logos, icons, and line drawings.
* Support alpha channel for 16.7+ million colors.
* PNGs are often the best choice for backgrounds and non-photographic images.

## GIF

* GIFs are suitable for small interface icon images.
* Limited to 256 colors, but this also means file sizes are small.

Don't memorize this table:

| Feature              | JPG           | PNG                 | GIF                    |
|----------------------|---------------|---------------------|------------------------|
| Compression          | Lossy         |Non-lossy            | None/Lossy/Non-lossy   |
| Photographs?         | Yes           |Yes, but too big     | No                     |
| Line Drawings?       | No            |Yes                  | Depends on drawing     |
| Gradients?           | No            |Yes                  | No                     |
| Typical File Size    | Small         |Medium-Large         | Tiny                   |
| Quality              | Poor to Good  |Best                 | Good but limited color |
| Color Palette        | 16.7 million  |256 TC (note 1)      | 256                    |
| Color Depth          | 24 bits       |8-48 bits            | 8 bits                 |
| 1-Color Transparency | No            |Yes                  | Yes                    |
| alpha Transparency   | No            |Yes                  | No                     |
| Resolution Maximum   | 65536 x 65536 |2 GP x 2 GP (note 2) | 65536 x 65536          |
| Total Pixels Max     | 4 GP          |256 EP (note 3)      | 4 GP                   |

1. 256 teracolors, an astonishing 280 million million colors.
2. GP refers to gigapixels
3. 256 exapixels, an incredibly large number: 3 followed by 23 zeros.
