var gulp = require('gulp');
var process_spawn = require('child_process').spawn;
var gutil = require('gulp-util');
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

gulp.task("middleman:build", spawn('bundle', 'exec', 'middleman', 'build'));

gulp.task("middleman:server", spawn('bundle', 'exec', 'middleman'));

gulp.task("install", ["install:" + process.platform, "install:npm", "install:bundle"], nop);

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
