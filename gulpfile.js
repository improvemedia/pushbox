const gulp        = require('gulp');
const runSequence = require('run-sequence');

require('gulp-task-loader')('./gulp/tasks');

gulp.task('build', () => {
  runSequence(
    'assets:clean',
    'assets:images',
    'assets:webpack',
    'build:clean',
    'build:revision',
    'assets:clean',
    'build:move'
  );
});

gulp.task('default', () => {
  runSequence(
    'assets:clean',
    'assets:images',
    'assets:webpack',
    'watch'
  );
});
