Middleman-Template
==================

Basic [Middleman](http://middlemanapp.com) template project used by [Webonise Lab](http://webonise.com/about).

Installation
=============

Clone this repository into `~/.middleman/webonise`.

Usage
=======

When you create a new Middleman application, use the command:

```bash
middleman init . --template=webonise
```

What You Get
==============

* Our collective corporate wisdom about how to start a Middleman project.
* Pre-configured defaults for Middleman's configuration.

Modules
--------

* [middleman-autoprefixer](http://github.com/porada/middleman-autoprefixer), so you don't ever have to write a vendor prefix in CSS again, and unnecessary ones are filtered out.
* [jquery-middleman](http://github.com/jasl/jquery-middleman) -- So you have baked-in [JQuery](http://jquery.com/).
* [font-awesome-middleman](http://github.com/cristianferrarig/font-awesome-middleman), so you have baked-in [Font Awesome](http://fortawesome.github.io/Font-Awesome/).
* [middleman-alias](http://github.com/Octo-Labs/middleman-alias), so that you can have Middleman generate SEO-friendly redirects.
* [middleman-imageoptim](http://github.com/plasticine/middleman-imageoptim), so that you aren't serving unnecessarily large files on the web. This requires [installing some external dependencies](http://github.com/toy/image_optim#binaries-installation), which you will have to install.

Things Being Considered for Inclusion
======================================

* [middleman-favicon-maker](http://github.com/follmann/middleman-favicon-maker) -- Would generate favicons automatically from a base image, but requires ImageMagick to be installed and generally takes too much configuration/boilerplate.
* [middleman-google-analytics](http://github.com/danielbayerlein/middleman-google-analytics) -- Would include Google Analytics code automatically, but best to hook this up on a per-project basis. If you want it, add it yourself.
