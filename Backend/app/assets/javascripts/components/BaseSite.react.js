var React = require('react');
var Link = require('react-router').Link;
import BaseSiteActions from '../actions/BaseSiteActions';
import BaseSiteStore from '../stores/BaseSiteStore';

var LoadingPageElement = require('../elements/LoadingPageElement');

var BaseSite = React.createClass({
    getInitialState: function () {
        return {
            images: [],
            isLoading: false,
            totalSeconds: 0,
            element: [],
        };
    },
    componentDidMount: function () {
        setInterval(function () {
            this.setTime()
        }.bind(this), 1000);
        setInterval(function () {
            BaseSiteActions.getNew();
        }, 6000)
        var element = this.state.element;
        for (var i = 0; i < 51; i++) {
            element.push(<li><span>Image 01</span>
                <div><img src=""></img></div>
            </li>);
        }
        this.setState({element: element});
        BaseSiteStore.addChangeListener(this._onChange);
        BaseSiteStore.addResponseListener(this._onResponse);
    },
    setTime: function () {
        var sec = this.state.totalSeconds;
        console.log("second: " + sec);
        if (sec % 6 == 0) {
            var num = Math.floor(sec / 6);

            console.log("index: " + num);
            var image = this.state.images;
            var element = this.state.element;
            if (image.length > 0) {
                var first = image[0].Code;
                for (var i = 0; i < 51; i++) {
                    if (i == num) {
                        element[i] = <li><span>Image 01</span>
                            <div><img src={"data:" + first}></img></div>
                        </li>;
                    }else{
                        element[i] = <li><span>Image 01</span>
                            <div><img src=""></img></div>
                        </li>;
                    }
                }
                image.splice(0, 1);
                this.setState({images: image, element: element});
            } else {
                this.setState({images: image});
            }
        }
        sec = sec + 1;
        if (sec == 312) sec = 0;
        this.setState({totalSeconds: sec});
    },
    componentWillUnmount: function () {
        BaseSiteStore.removeChangeListener(this._onChange);
        BaseSiteStore.removeResponseListener(this._onResponse);
    },
    _onChange: function () {
        var data = BaseSiteStore.getImages();
        var image = this.state.images;
        var s = _.concat(image, data);
        this.setState({images: s});
    },
    _onResponse: function () {
        if (this.state.isLoading == true) {
            setInterval(function () {
                this.setTime()
            }.bind(this), 1000);
        }

        this.setState({isLoading: false});

    },
    render: function () {
        if ((this.state.isLoading === true)) {
            return (<LoadingPageElement></LoadingPageElement>);
        }
        var x = [];
        for (var a in this.state.images) {
            x.push(<p>{this.state.images[a].Code}</p>)
        }
        return (
            <div id="page">
                <ul className="cb-slideshow">
                    {this.state.element}
                </ul>
                <div className="container">

                    <div className="codrops-top">

                        <div className="clr"></div>
                    </div>
                    <header>
                        <h1 style={{fontStyle:"italic",fontFamily: "Snell Roundhand",color:"#ff00ff",opacity:"0.7",textShadow: "3px 3px 9px #ffffff"}}>Tuấn Tài & Thanh Ngọc</h1>

                    </header>
                </div>
            </div>

        );
    },
});

module.exports = BaseSite;
