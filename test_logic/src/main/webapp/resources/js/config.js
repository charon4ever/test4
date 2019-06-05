;
(function (win, UP) {
    'use strict';

    UP.Common = UP.Common || {};
    var common = UP.Common;

    // TODO: must set to false when patch release.
    common.debugMode = false;

    var logger = function() {
        var oldConsoleLog = null;
        var pub = {};

        pub.enableLogger =  function enableLogger() {
            if(oldConsoleLog == null)
                return;

            window['console']['log'] = oldConsoleLog;
        };

        pub.disableLogger = function disableLogger() {
            oldConsoleLog = console.log;
            window['console']['log'] = function() {};
        };

        return pub;
    }();

    if(common.debugMode) {
        logger.enableLogger();
    }
    else {
        logger.disableLogger();
    }

}(window, window.UP || (window.UP = {})));