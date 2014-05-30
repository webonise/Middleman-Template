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
Directory Structure
---------------------

Put your HTML in `./source`, your Sass/SCSS files in `./source/css`, your JavaScript in `./source/js`, and your images in `/.source/img`.

Middleman will build into `./build`.

Development Cycle
-----------------

When you first check out the project, you need to install the appropriate Gems into your repository. If you haven't done this before, it may appear to hang, but
give it a few minutes. Here is the code to run in the root of the project to install the necessary gems:

```bash
bundle install
```

With your gems in place, you can then run this command to start a server:

```bash
bundle exec middleman
```

You make changes in your source code, and Middleman automatically rebuilds in the background.

If you make changes to `Gemfile`, then you will need to run `bundle install` again: that is how it will pick up the new changes. If you ever want to get an
entirely updated versions of gems, blow away `Gemfile.lock` and run that command again. If you want a specific gem to be updated, then remove that particular
line from `Gemfile.lock`.


Deployment Packaging
---------------------

When you are ready to produce a deployment package, execute this command:

```bash
bundle exec middleman build
```

This should be done before you do a `git push`, because building the deployment package may detect problems with your code.

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
* Your JavaScript file can include another file wholsesale using `//= require "jquery"` or `//= require "your_file_name"`.

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

Known Issues
=============

* Ketan Ghumatkar struggled with Ruby 2.0 reporting `uninitialized constant Middleman::Application::MiddlemanApplication1::Redcarpet (NameError)`. Upgrading Ruby resolved the issue.
