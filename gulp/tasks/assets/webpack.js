const gulp    = require('gulp');
const path    = require('path');
const gutil   = require('gulp-util');
const webpack = require('webpack');

const webpackConfig = require(path.join(process.cwd(),
  process.env.NODE_ENV === 'production' ? 'webpack.prod.js' : 'webpack.dev.js'
))

module.exports = (callback) => {
  return new Promise((resolve) => {
    webpack(webpackConfig, (err, stats) => {
      if (err) {
        throw new gutil.PluginError('webpack', err);
      }

      if (process.env.NODE_ENV === 'production' && stats.hasErrors()) {
        throw new gutil.PluginError('webpack', stats.toString());
      }

      gutil.log(stats.toString({ chunks: false, colors: true }));

      resolve();
    });
  });
}