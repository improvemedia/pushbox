const gulp = require('gulp');

module.exports = (callback) => {
  return gulp.src('./app/assets/images/**/*')
    .pipe(gulp.dest('./public/assets'))
}