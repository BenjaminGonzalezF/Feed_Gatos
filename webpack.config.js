const webpack = require('webpack');
const dotenv = require('dotenv');

module.exports = {
  entry: './solicitud.js',
  output: {
    filename: 'bundle.js',
  },
  plugins: [
    new webpack.DefinePlugin({
      'process.env.API_KEY': JSON.stringify(process.env.API_KEY),
    }),
  ],
};