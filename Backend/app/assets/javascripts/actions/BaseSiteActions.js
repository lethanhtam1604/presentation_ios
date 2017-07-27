/*
 * Copyright (c) 2014-2015, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 *
 * TodoActions
 */

import AppDispatcher from '../dispatcher/AppDispatcher'
import AppConstants from '../constants/AppConstants'

import { dispatch } from '../dispatcher/AppDispatcher';
var BaseSiteActions = {
    getNew: function () {
        dispatch({
            actionType: AppConstants.GET_NEW
        });
    },
};

export default BaseSiteActions;
