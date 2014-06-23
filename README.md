Middleman-Template
==================

Basic [Middleman](http://middlemanapp.com) template project used by [Webonise Lab](http://webonise.com/about).

Installation
=============

Clone this repository as `~/.middleman`. Don't clone it as a _subdirectory_ of `~/.middleman`: clone it as `~/.middleman` itself. So the command looks like this:

```bash
git clone git@github.com:webonise/Middleman-Template.git ~/.middleman
```

Usage
=======

When you create a new Middleman application, use these commands:

```bash
middleman init . --template=webonise
npm install
gulp install
```

Directory Structure
---------------------

Put your HTML in `./source`, your Sass/CSS files in `./source/css`, your CoffeeScript/JavaScript in `./source/js`, and your images in `./source/img`.

Middleman will build into `./build`.

Development Cycle
-----------------

When you first check out the project, you need to install the appropriate Gems, binaries, and node modules onto your system.
If you haven't done this before, it may appear to hang, but give it a few minutes. Here is the code to run in the root of the project to install everything:

```bash
npm install
gulp install
```

With your dependencies in place, you can then run this command to start a server:

```bash
gulp middleman:server
```

This is equivalent to:

```bash
bundle exec middleman server
```

You make changes in your source code, and Middleman automatically rebuilds in the background.

If you make changes to `Gemfile`, then you will need to run `gulp install` again: that is how it will pick up the new changes. If you ever want to get an
entirely updated versions of gems, blow away `Gemfile.lock` and run that command again. If you want a specific gem to be updated, then remove that particular
line from `Gemfile.lock` and run that command again.


Deployment Packaging
---------------------

When you are ready to produce a deployment package, execute this command:

```bash
gulp build
```

This should be done before you do a `git push`, because building the deployment package may detect problems with your code.

What You Get
==============

* Our collective corporate wisdom about how to start a Middleman project leveraging Gulp.
* Pre-configured defaults for Middleman's configuration.
* Automatic minification on build, but nice, readable versions in development.
* The abilty to use Sass/SCSS, Haml, Markdown, and more as markup languages just by appending file suffixes:
    * `foo.css.scss.erb` is first run through ERB, then SCSS, and then (finally!) rendered as a CSS file.
* All of Middleman's [helpers](http://middlemanapp.com/basics/helpers/), [templating](http://middlemanapp.com/basics/templates/), etc.
* No need to specify the image sizes if the image should be rendered at 100% of its size.
* No need to ever use vendor prefixes in your CSS.
* `gulp html:check` to check your HTML for validation and style.
* `gulp middleman:build`, `gulp middleman:build:verbose`, and `gulp:middleman:server` for running Middleman's build, verbose build, and server.
* `gulp nginx:start` and `gulp nginx:stop` to start and stop Nginx hosting the build directory. (See the Gulpfile for details.)
* Your JavaScript file can include another file wholsesale using `//= require "jquery"` or `//= require "your_file_name"`.

Modules
--------

* [middleman-autoprefixer](http://github.com/porada/middleman-autoprefixer), so you don't ever have to write a vendor prefix in CSS again, and unnecessary ones are filtered out.
* [middleman-alias](http://github.com/Octo-Labs/middleman-alias), so that you can have Middleman generate SEO-friendly redirects.
* [middleman-imageoptim](http://github.com/plasticine/middleman-imageoptim), so that you aren't serving unnecessarily large files on the web.
* [middleman-ngmin](https://github.com/bhollis/middleman-ngmin), so that it is safe to run JavaScript minimization on Angular scripts. (This module is installed but disabled by default.)

Things Being Considered for Inclusion
======================================

* [middleman-favicon-maker](http://github.com/follmann/middleman-favicon-maker) -- Would generate favicons automatically from a base image, but requires ImageMagick to be installed and generally takes too much configuration/boilerplate.
* [middleman-google-analytics](http://github.com/danielbayerlein/middleman-google-analytics) -- Would include Google Analytics code automatically, but best to hook this up on a per-project basis. If you want it, add it yourself.

Known Issues
=============

* Ketan Ghumatkar struggled with Ruby 2.0 reporting `uninitialized constant Middleman::Application::MiddlemanApplication1::Redcarpet (NameError)`. Upgrading Ruby resolved the issue.
