const path = require('path');

module.exports = {
  entry: './js/phoenix_live_react.js',
  output: {
    filename: 'phoenix_live_react.js',
    path: path.resolve(__dirname, '../priv/static'),
    library: 'phoenix_live_react',
    libraryTarget: 'umd',
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader',
        },
      },
    ],
  },
  plugins: [],
  externals: {
    react: 'react',
    'react-dom/client': 'react-dom/client',
  },
};
