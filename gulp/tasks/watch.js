const gulp       = require('gulp');
const livereload = require('gulp-livereload');

module.exports = () => {
  gulp.watch('./app/assets/images/**/*', ['assets:images']);

  gulp.watch([
    'public/assets/**/*.css',
  ], (event) => {
    livereload.changed(event.path);
  });

  livereload.listen();
}