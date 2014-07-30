var gulp = require('gulp');
var process_spawn = require('child_process').spawn;
var gutil = require('gulp-util');
var w3cjs = require('gulp-w3cjs');
var chalk = gutil.colors;
var htmlhint = require("gulp-htmlhint");
var _ = require('underscore');

// Utilities
var nop = function(cb) { cb() };
var process_env = process.env;

// Pass in the command and the command args as arguments, returns a gulp task
// definition function that executes that command with the given arguments in a
// separate process.
var spawn = function(cmd, cmd_args) {
  var args = _.toArray(arguments);
  cmd = args.shift();
  cmd_args = args;
  return function(cb) {
    cb = _.once(cb);
    gutil.log("Executing '" + cmd + "' command with arguments: " + cmd_args);
    var process = process_spawn(cmd, cmd_args, {
      stdio: 'inherit',
      env: process_env,
      detached: false
    });
    process.on('error', cb);
    process.on('exit', function() { cb() });
    return process;
  };
};

//gulp.watch(["source/**/*", "config.rb"], ['middleman:build']);

gulp.task("jenkins", ["build"], nop);

gulp.task("build", ["middleman:build"], nop);

gulp.task("middleman", ["middleman:server"], nop);

gulp.task("middleman:build", spawn('bundle', 'exec', 'middleman', 'build'));

gulp.task("middleman:build:verbose", spawn('bundle', 'exec', 'middleman', 'build', '--verbose'));

// Always run the server in verbose mode: it's not actually that verbose
gulp.task("middleman:server", spawn('bundle', 'exec', 'middleman', '--verbose'));

gulp.task("install", ["install:" + process.platform, "install:npm", "install:bundle"], function() {
  gutil.log("Be sure you have also installed", chalk.bold.cyan('pngout'), ":", chalk.bold.red('http://github.com/toy/image_optim#pngout-installation-optional'));
});

gulp.task("install:npm", spawn("npm", "install"));

gulp.task("install:bundle", spawn("bundle", "install"));

gulp.task("install:darwin", spawn("brew", "install",
  "advancecomp", "gifsicle", "jhead", "jpegoptim", "jpeg", "optipng", "pngcrush"
));

gulp.task("install:linux", spawn("apt-get", "install", "-y",
  "advancecomp", "gifsicle", "jhead", "jpegoptim", "libjpeg-progs", "optipng", "pngcrush"
));

gulp.task("install:win32", function() {
  gutil.log("You are responsible for figuring out how to install the necessary binaries to build on Win32");
  gutil.log("For help, see http://github.com/toy/image_optim#binaries-installation");
});

gulp.task("html:check", ["html:validate", "html:hint"], nop);

gulp.task("html:validate", ["middleman:build", "html:debug-help"], function() {
  return gulp.src(['build/*.html', 'build/**/*.html']).pipe(w3cjs());
});

gulp.task("html:debug-help", [], function() {
  gutil.log("If you have errors in your HTML,", chalk.bold("*temporarily*"), "disable",
    chalk.bold.cyan(':html_minify'), "on", chalk.bold.cyan('config.rb'), "to help you debug them.");
  gutil.log("(But if you do disable the", chalk.bold.cyan(':html_minify'), "then", chalk.bold("*please*"),
    "re-enable it before you check in again");
});

gulp.task("html:hint", ["middleman:build", "html:debug-help"], function() {
  return gulp.src(['build/*.html', 'build/**/*.html'])
    .pipe(htmlhint({"htmlhintrc":".htmlhintrc"}))
    .pipe(htmlhint.reporter());
});

/**
* nginx tasks. These should only be used for sanity checking the build. Most of the time, you want to use "gulp middleman:server".
* Using "middleman:server" provides equivalent behavior, but without performing the minimization, which makes things both faster and more developer-friendly.
*
* The configuration file presumes that you have "middleman.local" set up as an alias for "localhost" in your /etc/hosts file.
* (See https://webonise.atlassian.net/wiki/display/AS/Nginx+Web+Server#NginxWebServer-SettingUpaNewHost for help on that.)
*/
gulp.task("nginx:start", ["middleman:build:verbose"], spawn("nginx", "-p", process.cwd(), "-c", "nginx.conf"));
gulp.task("nginx:stop", [], spawn("nginx", "-p", process.cwd(), "-c", "nginx.conf", "-s", "stop"));


