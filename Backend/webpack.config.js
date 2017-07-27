'use strict';

var webpack = require('webpack'),
    jsPath  = 'app/assets/javascripts',
    path = require('path'),
    srcPath = path.join(__dirname, 'app/assets/javascripts');

var config = {
    target: 'web',
    entry: {
        
	app: [
	  'webpack-dev-server/client?http://localhost:3000', // WebpackDevServer host and port
	  'webpack/hot/only-dev-server', // "only" prevents reload on syntax errors
	  path.join(srcPath, 'app.js') // Your appʼs entry point
	],
        //, common: ['react-dom', 'react']
        common:['react',
            'react-dom',
            'react-bootstrap',
            'react-router',
            'flux',
            'superagent',
            'classnames',
            'immutable',
            'keymirror',
            'lodash',
            'object-assign',
            'react-widgets',
            'react-input-datalist',
            'react-bootstrap-datetimepicker',
            'react-bootstrap-table']
    },
    resolve: {
        alias: {},
        root: srcPath,
        extensions: ['', '.js'],
        modulesDirectories: ['node_modules', jsPath]
    },
    output: {
        path:path.resolve(__dirname, jsPath, 'devBuild'),
        publicPath: 'http://localhost:3000/',
        filename: '[name].js',
        pathInfo: true
    },
    watch: true,
    devtool: 'eval-source-map', // in-line source maps instead of the default
    node: {
        fs: "empty"
    },
    module: {
        noParse: [],
        loaders: [
            {
                test: /\.js?$/,
                exclude: /node_modules/,
                loaders: ['react-hot','babel']
            },
            {
                test: /\.scss$/,
                include: /\/app\/assets/,
                loader: 'style!css!sass'
            }
        ]
    },
    plugins: [
	new webpack.HotModuleReplacementPlugin()
    ]
};

module.exports = config;
