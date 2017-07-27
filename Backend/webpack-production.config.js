'use strict';

var webpack = require('webpack'),
    jsPath  = 'app/assets/javascripts',
    path = require('path'),
    srcPath = path.join(__dirname, 'app/assets/javascripts');

var config = {
    target: 'web',
    entry: {
        
	app: path.join(srcPath, 'app.js'),
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
        path:path.resolve(__dirname, jsPath, 'build'),
        publicPath: '',
        filename: '[name].js',
        pathInfo: true
    },
    watch: true,
    node: {
        fs: "empty"
    },
    module: {
        noParse: [],
        loaders: [
            {
                test: /\.js?$/,
                exclude: /node_modules/,
                loader: 'babel'
            },
            {
                test: /\.scss$/,
                include: /\/app\/assets/,
                loader: 'style!css!sass'
            }
        ]
    },
    plugins: [
        new webpack.optimize.CommonsChunkPlugin('common', 'common.js'),
        new webpack.optimize.UglifyJsPlugin({
            compress: { warnings: false },
            output: { comments: false }
        }),
        new webpack.NoErrorsPlugin()
    ]
};

module.exports = config;
