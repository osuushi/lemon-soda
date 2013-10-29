# LemonSoda

A flexible alternative to CSS sprite sheets

***

Sprite sheets are fairly ubiquitous these days. Experienced developers know that packing all of
your sprites into a single image is a relatively sure-fire way to speed up page loading. But the
technique is not without its disadvantages.

For one thing, it locks you into a single format (usually PNG-24). That's not ideal if you have some
images which are better suited to a different format (say, a small photo, or an animated gif). For
another, it limits what you can do with CSS. You can't use `background-repeat` with a sprite sheet,
and performing any kind of transformation on a sprite tends to be cumbersome.

Finally, adding new sprites to a sprite sheet while maintaining efficient packing often requires
changes to your CSS.

LemonSoda is an alternative which aims to solve these problems.

***

- [How it works](#how-it-works)
- [Installing](#installing)
- [Class names](#class-names)
- [Requirements and Browser Compatibility](#requirements-and-browser-compatibility)
	- [Requirements for sixpack](#requirements-for-sixpack)
	- [Browser compatibility for lemon-soda.js](#browser-compatibility-for-lemon-sodajs)

## How it works

LemonSoda comes with a command-line tool called `sixpack`, which transforms an entire directory full
of images into a single JSON file. Once gzipped, this JSON file will only be marginally larger than
the original images. Each image is automatically assigned a class name based on its path.

On the client side, a simple call to `LemonSoda.load(url)` will load and unpack your sprites, and
then generate the CSS rules necessary to use them.

For example, suppose you had the following directory:

    sprites/
        button/
            left.png
            right.png
        icon/
            logo.jpg
            spinner.gif

You pack them with this command:

    sixpack sprites sprites.json

To use one of the icons, you put this in your HTML code:

    <div class="sprite-button-left"></div>

And then before the closing body tag, you insert this:

    <script src = "../js/lemon-soda.js"></script>
    <script>
        LemonSoda.load("sprites.json");
    </script>

And that's it. To add anothes sprite, you simply put it in the `sprites/` directory, use `sixpack`
again, and then it's ready to use. No need to update your CSS or anything else.

## Installing

To install the sixpack tool, open a terminal and enter this command:

    sudo npm install -g git://github.com/osuushi/lemon-soda.git

Then you will need to include
[lemon-soda.js](https://github.com/osuushi/lemon-soda/blob/master/js/lemon-soda.js)
in your HTML code (place it just before the closing `</body>` tag .


## Class names

Class names are generated as follows:

1. The path is taken relative to the input path and the file extension is stripped off

1. Any character that isn't a letter or number is replaced with "-"

1. Repeated hyphens are condensed and trailing hyphens are removed

1. A prefix is added. It defaults to "sprite" but you can change it with the `-p` flag

For example, if you call `sixpack pics pics.json -p img`:

| Input Path                                    | Class Name                                    |
| --------------------------------------------- | --------------------------------------------- |
| pics/foo.png                                  | img-foo                                       |
| pics/upArrow.png                              | img-upArrow                                   |
| pics/logo/300x400.jpg                         | img-logo-300x400                              |
| pics/big button/state/default (active).png    | img-big-button-state-default-active           |

Note: If multiple file paths convert to the same class name, only one of them will be packed, and
it is undefined which one it will be. In practice, this is easy to avoid.

## Requirements and Browser Compatibility

### Requirements for sixpack

* Node.js
* ImageMagick

### Browser compatibility for lemon-soda.js

LemonSoda will work in any modern browser. It will not work in IE8 or below because IE did not
support data URIs in JavaScript until IE9. If you need to target older versions of IE, the easiest
way is to fall back to a CSS file using the individual original images.

## Roadmap

- [x] Tool for packing sprites
- [x] Client side sprite decoding
- [x] Break client side processing into deferred blocks to prevent GUI pauses
- [ ] Tool to generate fallback CSS for older browsers