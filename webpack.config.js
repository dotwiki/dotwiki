const path = require('path')
const glob = require('glob')
const WebpackAssetsManifest = require('webpack-assets-manifest')
const MiniCssExtractPlugin = require('mini-css-extract-plugin')
const PurgecssPlugin = require('purgecss-webpack-plugin')
const { VueLoaderPlugin } = require('vue-loader')

const { NODE_ENV } = process.env
const isProd = NODE_ENV === 'production'

function collectWhitelist() {
  return ['show']
}

function collectWhitelistPatternsChildren() {
  return [/CodeMirror/, /editor/, /cm/, /toast/, /avatar/, /diff/]
}

module.exports = {
  mode: isProd ? 'production' : 'development',
  entry: {
    application: path.resolve(__dirname, 'app/frontend/application.js'),
    simplemde: path.resolve(__dirname, 'app/frontend/javascripts/simplemde.js'),
    marked: path.resolve(__dirname, 'app/frontend/javascripts/marked.js'),
    wiki_nav: path.resolve(__dirname, 'app/frontend/javascripts/wiki_nav.js'),
    watch_wiki: path.resolve(__dirname, 'app/frontend/javascripts/watch_wiki.js')
  },
  output: {
    path: path.resolve(__dirname, 'public/packs'),
    publicPath: isProd ? '/packs/' : '//localhost:8081/packs/',
    filename: isProd ? '[name]-[hash].js' : '[name].js'
  },
  resolve: {
    extensions: ['.js']
  },
  devServer: {
    contentBase: path.resolve(__dirname, 'public'),
    publicPath: '/packs/',
    host: 'localhost',
    port: 8081,
    headers: {
      'Access-Control-Allow-Origin': '*'
    }
  },
  module: {
    rules: [
      {
        test: /\.vue$/,
        use: ['vue-loader']
      },
      {
        test: /\.(css|sass|scss)$/,
        use: [
          MiniCssExtractPlugin.loader,
          'css-loader',
          {
            loader: 'postcss-loader',
            options: {
              sourceMap: true,
              plugins: [
                require('autoprefixer')({
                  grid: true
                }),
                require('cssnano')({
                  preset: [
                    'default',
                    {
                      discardComments: {
                        removeAll: true
                      }
                    }
                  ]
                })
              ]
            }
          },
          'sass-loader'
        ]
      },
      {
        test: /\.(sass|scss)$/,
        enforce: 'pre',
        loader: 'import-glob-loader'
      }
    ]
  },
  plugins: [
    new WebpackAssetsManifest({ publicPath: true, writeToDisk: true }),
    new MiniCssExtractPlugin({
      filename: isProd ? '[name]-[hash].css' : '[name].css'
    }),
    new PurgecssPlugin({
      paths: glob.sync(`${path.join(__dirname, 'app/views')}/**/*`, { nodir: true }),
      only: ['application'],
      whitelist: collectWhitelist,
      whitelistPatternsChildren: collectWhitelistPatternsChildren
    }),
    new VueLoaderPlugin()
  ]
}
