const gulp = require('gulp');
const del  = require('del');

module.exports = () => {
  return del('public/build/**/*');
}