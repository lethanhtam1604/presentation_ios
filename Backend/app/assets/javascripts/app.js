
var Router = require('react-router').Router;
var Route = require('react-router').Route;
var IndexRoute = require('react-router').IndexRoute;
var hashHistory = require('react-router').hashHistory;

var Route = require('react-router').Route;

var BaseSite = require('./components/BaseSite.react.js');

var React = require('react');
var ReactDOM = require('react-dom');
ReactDOM.render((
	<Router history={hashHistory}>
		<Route path="/" component={BaseSite}>

		</Route>
	</Router>
), document.getElementById('todoapp'));
