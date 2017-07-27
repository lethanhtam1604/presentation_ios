/**
 * Created by tybq on 8/10/16.
 */

var React = require('react');
var Modal = require('react-bootstrap').Modal;
var moment = require('moment');
var _ = require('lodash');

var LoadingPageElement = React.createClass({
    render: function () {
        return(<div>
                <div className="loader"></div>
            </div>
        );
    },
});

module.exports = LoadingPageElement;
