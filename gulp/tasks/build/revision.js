const gulp   = require('gulp');
const RevAll = require('gulp-rev-all');

module.exports = () => {
  return gulp.src('public/assets/**/*')
    .pipe(RevAll.revision({
      dontRenameFile: [/bundle\.chunk/g],
      dontSearchFile: [/templates/g],
      includeFilesInManifest: ['.js', '.css', '.png', '.jpg', '.jpeg', '.gif', '.svg']
    }))
    .pipe(gulp.dest('public/build'))
    .pipe(RevAll.manifestFile())
    .pipe(gulp.dest('config'));
}
