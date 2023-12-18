const webpack = require('webpack');
const dotenv = require('dotenv');

module.exports = {
 entry: {
    solicitud: './solicitud.js',
    obtener_img: './obtener_img.js'
  },
  output: {
    filename: '[name].bundle.js',
  },
  plugins: [
    new webpack.DefinePlugin({
      'process.env.API_KEY': JSON.stringify(process.env.API_KEY),
      'process.env.API_IP': JSON.stringify(process.env.API_IP),
    }),
  ],
};