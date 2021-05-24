// const { environment } = require('@rails/webpacker')
const erb = require('./loaders/erb')

// const webpack = require("webpack");

// // Add an additional plugin of your choosing : ProvidePlugin
// environment.plugins.append(
//   "Provide",
//   new webpack.ProvidePlugin({
//     $: "jquery",
//     jQuery: "jquery",
//     Popper: ["popper.js", "default"] // for Bootstrap 4
//   })
// );

// environment.loaders.prepend('erb', erb)
module.exports = environment

const { environment } = require('@rails/webpacker')
const erb = require('./loaders/erb')

const webpack = require('webpack')
environment.plugins.append('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Popper: ['popper.js', 'default'],
    Popper: 'popper.js/dist/popper',
    // moment: 'moment/moment'
  })
)

environment.loaders.prepend('erb', erb)
module.exports = environment
