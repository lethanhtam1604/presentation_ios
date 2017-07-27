import AppDispatcher from '../dispatcher/AppDispatcher';
import { register } from '../dispatcher/AppDispatcher';
import EventEmitter from 'events';
import AppConstants from '../constants/AppConstants';
import { dispatch } from '../dispatcher/AppDispatcher.js';
import assign from 'object-assign';
import _  from 'lodash';

var CHANGE_EVENT = 'BaseSite-Change';
var CHANGE_RESPONSE = 'BaseSite-RESPONSE';
var _images=[];


class BaseSiteStore extends EventEmitter {
    constructor() {
        super();
    }

    getImages() {
        return _images;
    }

    loadImages() {
        var self=this;
        var r = jsRoutes.controllers.BaseApi.getNew();
        $.ajax({
            url: r.url,
            dataType: 'json',
            type: "post",
            cache: false,
            success: function (rs) {
                dispatch({
                    actionType:AppConstants.GET_NEW_SUCCESS,
                    data:{
                        rs:rs
                    }
                });

            },
            error: function (xhr, status, err) {
                dispatch({
                    actionType:AppConstants.GET_NEW_FAILED,
                    data:{
                        xhr:xhr,
                        status:status,
                        err:err
                    }
                });
            }
        });
    }
    loadImages_Success(data)
    {
        _images = data.rs;
        this.emitResponse();
        this.emitChange();
    }
    loadImages_Failed(data)
    {
        _images = [];
        console.log(data.err.toString())
    }

    emitChange() {
        this.emit(CHANGE_EVENT);
    }

    emitResponse() {
        this.emit(CHANGE_RESPONSE);
    }

    addChangeListener(callback) {
        this.on(CHANGE_EVENT, callback);
    }

    addResponseListener(callback) {
        this.on(CHANGE_RESPONSE, callback);
    }


    removeChangeListener(callback) {
        this.removeListener(CHANGE_EVENT, callback);
    }

    removeResponseListener(callback) {
        this.removeListener(CHANGE_RESPONSE, callback);
    }

};

let instance = new BaseSiteStore();

instance.dispatchToken = register(action => {
    switch(action.actionType) {
        case AppConstants.GET_NEW:
            instance.loadImages();
            break;
        case AppConstants.GET_NEW_SUCCESS:
            instance.loadImages_Success(action.data);
            break;
        case AppConstants.GET_NEW_FAILED:
            instance.loadImages_Failed(action.data);
            break;
        default:
            return;
    }
});

export default instance;
