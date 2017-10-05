const koutoSwiss        = require('kouto-swiss')
const webpack           = require('webpack');
const path              = require('path');
const ExtractTextPlugin = require('extract-text-webpack-plugin');

module.exports = {
  entry: {
    admin:   path.resolve(__dirname, 'app/assets/javascripts/admin.bundle.js'),
    landing: path.resolve(__dirname, 'app/assets/javascripts/landing.bundle.js'),
  },

  output: {
    path: path.resolve(__dirname + '/public/assets'),
    filename: '[name].bundle.js'
  },

  resolve: {
    modules: [
      path.resolve(__dirname, 'app/assets/javascripts'),
      'node_modules'
    ]
  },

  module: {
    noParse: /libs\//,

    rules: [
      {
        test: /libs\/.+\.js$/,
        exclude: /node_modules/,
        use: "imports-loader?this=>window,define=>false,require=>false,module=>false,exports=>false"
      },
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: 'babel-loader'
      },
      {
        test: /\.styl$/,
        exclude: /node_modules/,
        use: ExtractTextPlugin.extract({
          fallback: { loader: 'style-loader' },
          use: [
            'raw-loader',
            {
              loader: 'stylus-loader',
              options: {
                use: [koutoSwiss()]
              }
            }
          ]
        })
      }
    ]
  },

  plugins: [
    new ExtractTextPlugin('[name].bundle.css')
  ]
};