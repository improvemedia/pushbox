const gulp = require('gulp');
const del  = require('del');

module.exports = () => {
  return gulp.src('public/build/**/*')
    .pipe(gulp.dest('public/assets'))
}