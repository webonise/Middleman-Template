Middleman-Template
==================

Basic [Middleman](http://middlemanapp.com) template project used by [Webonise Lab](http://webonise.com/about).

Installation
=============

Clone this repository as `~/.middleman`. Don't clone it as a _subdirectory_ of `~/.middleman`: clone it as `~/.middleman` itself. So the command looks like this:

```bash
git clone git@github.com:webonise/Middleman-Template.git ~/.middleman
```

Then, install the [`imageoptim` external dependencies](http://github.com/toy/image_optim#binaries-installation), which you will have to install.

Usage
=======

When you create a new Middleman application, use this command:

```bash
middleman init . --template=webonise
```

What You Get
==============

* Our collective corporate wisdom about how to start a Middleman project.
* Pre-configured defaults for Middleman's configuration.
* Automatic minification on build, but nice, readable versions in development.
* The abilty to use Sass/SCSS, Haml, Markdown, and more as markup languages just by appending file suffixes:
    * `foo.css.scss.erb` is first run through ERB, then SCSS, and then (finally!) rendered as a CSS file.
* All of Middleman's [helpers](http://middlemanapp.com/basics/helpers/), [templating](http://middlemanapp.com/basics/templates/), etc.
* No need to specify the image sizes if the image should be rendered at 100% of its size.
* No need to ever use vendor prefixes in your CSS.

Modules
--------

* [middleman-autoprefixer](http://github.com/porada/middleman-autoprefixer), so you don't ever have to write a vendor prefix in CSS again, and unnecessary ones are filtered out.
* [jquery-middleman](http://github.com/jasl/jquery-middleman) -- So you have baked-in [JQuery](http://jquery.com/).
* [font-awesome-middleman](http://github.com/cristianferrarig/font-awesome-middleman), so you have baked-in [Font Awesome](http://fortawesome.github.io/Font-Awesome/).
* [middleman-alias](http://github.com/Octo-Labs/middleman-alias), so that you can have Middleman generate SEO-friendly redirects.
* [middleman-imageoptim](http://github.com/plasticine/middleman-imageoptim), so that you aren't serving unnecessarily large files on the web.

Things Being Considered for Inclusion
======================================

* [middleman-favicon-maker](http://github.com/follmann/middleman-favicon-maker) -- Would generate favicons automatically from a base image, but requires ImageMagick to be installed and generally takes too much configuration/boilerplate.
* [middleman-google-analytics](http://github.com/danielbayerlein/middleman-google-analytics) -- Would include Google Analytics code automatically, but best to hook this up on a per-project basis. If you want it, add it yourself.
