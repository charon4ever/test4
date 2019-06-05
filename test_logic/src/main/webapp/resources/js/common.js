
/* Extra small devices (phones, less than 768px) */
/* No media query since this is the default in Bootstrap */

/* Small devices (tablets, 768px and up) */
// @media (min-width: @screen-sm-min) { ... }

/* Medium devices (desktops, 992px and up) */
// @media (min-width: @screen-md-min) { ... }

/* Large devices (large desktops, 1200px and up) */
// @media (min-width: @screen-lg-min) { ... }

;
(function (win, UP) {
    'use strict';

    var $loading,
        $popupModel,
        $poupPanelModel,
        common,
        $sidebarMenu,
        currencyMapJson;

    UP.Common = UP.Common || {};
    common = UP.Common;


    //操作成功/失败
    // common.showToast = function (type, text) {
    //     $.toast().reset('all');
    //
    //     var msg = text ? text : (type == 'error' ? 'Operation failed' : 'Operation success');
    //
    //     $.toast({
    //         heading: 'Hint',
    //         text: msg,
    //         icon: type || 'success', //error/info/warning
    //         loader: false,
    //         position: 'top-center' // bottom-left or bottom-right or bottom-center or top-left or top-right or top-center or mid-center or an object representing the left, right, top, bottom values to position the toast on page
    //     });
    // };

    /**
     * Use for success/fail message popup
     * @param params configrable
     */
    common.showPopup = function (params) {
        var title, message, closeFunc, success;

        if(typeof params === 'string') {
            // previous interface design
            message = params;
        }
        else {
            title = params.title;
            message = params.message;
            closeFunc = params.closeFunc;
            success = params.success;
        }

        if(!$popupModel) {
            $popupModel = $('#popupNotifyModel');
            $popupModel.find('button.close').on('click', closePopup);
            $popupModel.find('button.popup-confirm').on('click', closePopup);
        }

        function closePopup() {
            $popupModel.modal("hide");
            $.isFunction(closeFunc) && closeFunc();
        }

        $popupModel.find('.modal-body').html(message);

        if(!!success) {
            // success
            $popupModel.find('.modal-title').html(title || 'Congratulations! ');
            $popupModel.find('.modal-footer button').removeClass('btn-warning').addClass('btn-success');
        }
        else {
            // fail
            $popupModel.find('.modal-title').html(title || 'Error');
            $popupModel.find('.modal-footer button').removeClass('btn-success').addClass('btn-warning');
        }

        $popupModel.modal("show");
    };

    /**
     * For lots of info popup show, use panel style.
     *
     * @param title
     * @param body
     * @param closeFunc
     */
    common.showMessagePanelPopup = function(title, body, closeFunc) {
        if(!$poupPanelModel) {
            $poupPanelModel = $('#poupPanelModal');

            $poupPanelModel.find('button.popup-confirm').click(function () {
                $poupPanelModel.modal("hide");
                $.isFunction(closeFunc) && closeFunc();
            });
        }


        if(title) {
            $poupPanelModel.find('.modal-title').html(title).show();
        }
        else {
            $poupPanelModel.find('.modal-title').hide();
        }

        if(body) {
            $poupPanelModel.find('.modal-body').html(body).show();
        }
        else {
            $poupPanelModel.find('.modal-body').hide();
        }

        $poupPanelModel.modal('show');
    };

    common.showLoading = function () {
        $loading = $loading || $('#loader');
        $loading.fadeIn("fast", function() {
            // Animation complete
        });
    };

    common.dismissLoading = function () {
        $loading = $loading || $('#loader');
        $loading.fadeOut("slow", function() {
            // Animation complete
        });
    };

    //格式化时间yyyy-mm-dd
    common.formatDate = function (date) {
        return date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate();
    };

    common.isEmailValid = function (email) {
        /**
         *  https://stackoverflow.com/questions/46155/how-to-validate-email-address-in-javascript
         *
         *  https://en.wikipedia.org/wiki/Email_address
         *
         *  Domain
         The domain name part of an email address has to conform to strict guidelines: it must match the requirements for a hostname, a list of dot-separated DNS labels, each label being limited to a length of 63 characters and consisting of:[6]:§2

         uppercase and lowercase Latin letters A to Z and a to z;
         digits 0 to 9, provided that top-level domain names are not all-numeric;
         hyphen -, provided that it is not the first or last character.
         This rule is known as the LDH rule (letters, digits, hyphen). In addition, the domain may be an IP address literal, surrounded by square brackets [], such as jsmith@[192.168.2.1] or jsmith@[IPv6:2001:db8::1], although this is rarely seen except in email spam. Internationalized domain names (which are encoded to comply with the requirements for a hostname) allow for presentation of non-ASCII domains. In mail systems compliant with RFC 6531 and RFC 6532 an email address may be encoded as UTF-8, both a local-part as well as a domain name.

         Comments are allowed in the domain as well as in the local-part; for example, john.smith@(comment)example.com and john.smith@example.com(comment) are equivalent to john.smith@example.com.
         *
         *  TODO: case: user@[2001:DB8::1]
         */
        var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        return re.test(email);
    };

    common.ajaxRequest = function (params) {
        var url = params.action;

        if (params.enableLoading) {
            common.showLoading();
        }

        if(url.indexOf(window.jsp_request_contextPath) === 0) {
            // has jsp prefix path already
        }
        else {
            url = window.jsp_request_contextPath + url;
        }

        var data = params.data || {};
        data.timestamp = new Date().getTime();

        console.log('>>> ajaxRequest, action = ' + params.action);
        // console.log('>>> data = ' + JSON.stringify(data));

        // try{
        //
        // }
        // catch (e) {
        //
        // }

        $.ajax({
            type: 'POST',
            url: url,
            data: data,
            dataType: 'json',
            success: function (response, status, xhr) {
                // got areas success
                var message = response.message || response.Message;

                common.dismissLoading();

                if (response.responseCode === '00') {
                    // success
                    var successCB = params.successCB;
                    if ($.isFunction(successCB)) {
                        successCB(response.data);
                    }
                    else {

                        setTimeout(function () {
                            common.showPopup({
                                message: message || 'Success',
                                success: true
                            });
                        }, 100);
                    }
                }
                else {
                    var logicErrorCB = params.logicErrorCB;

                    if ($.isFunction(logicErrorCB)) {
                        logicErrorCB(response);
                    }
                    else {
                        // logic error
                        setTimeout(function () {
                            common.showPopup({
                                message: message || 'Request error'
                            });

                        }, 100);
                    }
                }
            },
            error: function (xhr, status, e) {
                var errorCB = params.errorCB;
                console.log('other error');
                common.dismissLoading();
                if ($.isFunction(errorCB)) {
                    errorCB(xhr, status, e);
                }
                else {
                    // alert('Network error or server is busy!');
                    common.showPopup({
                        message: 'Network error or server is busy!'
                    });
                }
            }
        });
    };

    /**
     *
     * @param $targetForm
     * @param cbParams
     *  logicError & error callback:
     *  logicError: server response back with responseCode not equal 00, which means logic error.
     *  error: caused by network issue or server is busy.
     *
     */
    common.formSubmitByAjax = function ($targetForm, cbParams, data) {
        $targetForm.on('valid.form', function () {
            var beforeSerializeCB, beforeSendCB, successCB, logicErrorCB, errorCB, completeCB;
            var dataForReq;

            var $submitBtn = $targetForm.find('button[type="submit"]');
            if($submitBtn.length === 0) {
                $submitBtn = $targetForm.find('input[type="submit"]');
            }

            if (cbParams) {
                if ($.isFunction(cbParams.beforeSerialize)) {
                    beforeSerializeCB = cbParams.beforeSerialize;
                }

                if ($.isFunction(cbParams.beforeSend)) {
                    beforeSendCB = cbParams.beforeSend;
                }

                if ($.isFunction(cbParams.success)) {
                    successCB = cbParams.success;
                }

                if ($.isFunction(cbParams.logicError)) {
                    logicErrorCB = cbParams.logicError;
                }

                if ($.isFunction(cbParams.error)) {
                    errorCB = cbParams.error;
                }

                if ($.isFunction(cbParams.complete)) {
                    completeCB = cbParams.complete;
                }
            }

            if($.isFunction(data)) {
                // function delay call
                dataForReq = data();
            }
            else {
                // deep copy
                dataForReq = jQuery.extend(true, {}, data);
            }

            if(dataForReq && $.isFunction(dataForReq.passwordFunc)) {
                dataForReq[dataForReq.passwordKeyName] = dataForReq.passwordFunc();
            }

            dataForReq = dataForReq || {};
            dataForReq.timestamp = new Date().getTime();

            console.log('--- ajaxSubmit, action = ' + $targetForm.attr('action'));
            // console.log('>>> data = ' + JSON.stringify(data));

            try {
                $(this).ajaxSubmit({
                    data: (function () {
                        // Deep copy
                        if(dataForReq) {
                            // remove unused data params;
                            delete dataForReq.passwordFunc;
                            delete dataForReq.passwordKeyName;
                            return dataForReq;
                        }

                        return {};
                    }()),
                    beforeSerialize: function ($form, options) {
                        console.log('beforeSerialize');

                        if ($submitBtn.length) {
                            // disable click action .
                            $submitBtn.addClass('disabled').attr("disabled", "disabled");
                        }

                        if (beforeSerializeCB) {
                            if(beforeSerializeCB($form, options) === false) {
                                regularRecovery();
                                return false;
                            }
                        }

                        // return false to cancel submit
                        // !! make sure to enable submit button if cancel submit here by "return false;"
                    },
                    beforeSend: function (arr, $form, options) {
                        if (beforeSendCB) {
                            if(beforeSendCB(arr, $form, options) === false) {
                                regularRecovery();
                                return false;
                            }
                        }

                        console.log('beforeSend');
                        common.showLoading();
                        // return false to cancel submit
                    },
                    success: function (response) {
                        console.log('success');
                        var message;

                        if (typeof response === 'string') {
                            try {
                                response = JSON.parse(response);
                            }
                            catch (e) {
                                // error occurs, jump to login page
                                common.jump2LoginPage();
                            }
                        }

                        message = response.message || response.Message;

                        if (response.responseCode === '00') {
                            // logic success
                            if (successCB) {
                                successCB(response.data);
                            }
                            else {
                                common.dismissLoading();
                                setTimeout(function () {
                                    common.showPopup({
                                        message: message || 'Success',
                                        success: true
                                    });
                                }, 100);
                            }
                        }
                        else {
                            common.dismissLoading();
                            if (logicErrorCB) {
                                logicErrorCB(response);
                            }
                            else {
                                // logic error
                                setTimeout(function () {
                                    common.showPopup(message || 'Request Error');
                                }, 100);
                            }
                        }
                    },
                    error: function (xhr, status, e) {
                        console.log('other error');
                        common.dismissLoading();
                        if (errorCB) {
                            errorCB(xhr, status, e);
                        }
                        else {
                            // alert('Network error or server is busy!');
                            common.showPopup('Network error or server is busy!');
                        }
                    },
                    complete: function (xhr, status) {
                        console.log('complete');
                        if (completeCB) {
                            completeCB(xhr, status);
                        }
                        regularRecovery();
                    }
                });
            }
            catch (e) {
                regularRecovery()();
            }

            function regularRecovery() {
                common.dismissLoading();
                // enale click action again.
                $submitBtn.removeClass("disabled").removeAttr("disabled");
            }

            return false;
        });

    };

    /**
     * For form has password field which need to be encrypted before request.
     *
     * @param $targetForm
     * @param cbParams
     * @param passwordKeyName default is password
     */
    common.formSubmitByAjaxWithPwd = function($targetForm, cbParams, data) {
        var $pwd = $targetForm.find('input[type="password"]');

        // if($pwd.length === 0) {
        //     $pwd = $targetForm.find('input.password')
        // }
        // else if($pwd.length === 0) {
        //     $pwd = $targetForm.find('input#password')
        // }

        if($pwd.length) {
            // form has password field
            // raw password will be encrypted.
            cbParams = cbParams || {};
            var beforeSerializeCB = cbParams.beforeSerialize;

            cbParams.beforeSerialize = function ($form, options) {
                $pwd.removeAttr('name');
                if($.isFunction(beforeSerializeCB)) {
                    beforeSerializeCB($form, options);
                }
            };

            var completeCB = cbParams.complete;
            cbParams.complete = function () {
                $pwd.attr('name', 'password');
                if($.isFunction(completeCB)) {
                    completeCB();
                }
            };

            data = data || {};
            data.passwordFunc = function () {
                // Encrypt with the public key...
                return common.encrypt($pwd);
            };
            data.passwordKeyName = ($pwd.attr('name') || 'password');
        }

        common.formSubmitByAjax($targetForm, cbParams, data);
    };

    common.encrypt = function ($password, value) {
        if(!window.jsp_public_key) {
            throw new Error('No public key found!!!');
        }

        var encrypt = new JSEncrypt(),
            value = ($password ? $password.val().trim() : value);

        if(value) {
            encrypt.setPublicKey(window.jsp_public_key);
            console.log('encrypted value = ' + value);
            return encrypt.encrypt(value);
        }

        return null;
    };

    common.jump2LoginPage = function () {
        window.location.replace(window.jsp_request_contextPath + '/login');
    };

    common.formatNumbers = function (id) {
        if (typeof id === 'string') {
            // 消除空格和非数字，增加空格
            return id.replace(/\s/g, '').replace(/(\S{4})(?=\S)/g, '$1 ');
        } else {
            return '';
        }
    };

    // Not to written in closure, dues to screen change during debugging consideration.
    common.windowSize = function () {
        return {
            width: Math.max(document.documentElement.clientWidth, window.innerWidth || 0),
            height: Math.max(document.documentElement.clientHeight, window.innerHeight || 0)
        };
    };

    common.drawEmvQR = function (params) {
        var data;
        if(params.staticQR) {
            data = {
                qrCodeType: '11',
                amount: null
            }
        }
        else {
            data = {
                qrCodeType: '12',
                amount: common.encrypt(null, params.amount)
            }
        }

        // request qr code
        common.ajaxRequest({
            enableLoading: true,
            action: "/qr/upiQRCode",
            data: data,
            successCB: function (data) {
                // success
                var qrCode = data && data.qrCode;
                setTimeout(function () {
                    drawQR(qrCode);

                    if($.isFunction(params.success)) {
                        params.success(data);
                    }
                }, 0);

                $(window).resize(function() {
                    drawQR(qrCode);
                });
            }
        });

        // function drawQR(qrString) {
        //     var canvas = document.getElementById("qr"),
        //         segs = qrcodegen.QrSegment.makeSegments(qrString),
        //         scrWidth = common.windowSize().width,
        //         eccLevel;
        //
        //     if(scrWidth >= 600) {
        //         eccLevel = qrcodegen.QrCode.Ecc.QUARTILE;
        //     }
        //     else if(scrWidth >= 540) {
        //         eccLevel = qrcodegen.QrCode.Ecc.MEDIUM;
        //     }
        //     else {
        //         eccLevel = qrcodegen.QrCode.Ecc.LOW;
        //     }
        //
        //     // generate qr
        //     var qr = qrcodegen.QrCode.encodeSegments(segs, eccLevel, 1, 40, -1, true);
        //     // draw qr on canvas
        //     qr && qr.drawCanvas(8, 4, canvas);
        //     return canvas;
        // }

        // function drawQR(qrString) {
        //     var canvas = document.getElementById("qr"),
        //         segs = qrcodegen.QrSegment.makeSegments(qrString),
        //         // scrWidth = common.windowSize().width,
        //         scrWidth = $('div.content-wrapper').css('width'),
        //         eccLevel,
        //         scale,
        //         border;
        //
        //
        //     /* Extra small devices (phones, less than 768px) */
        //     /* No media query since this is the default in Bootstrap */
        //
        //     /* Small devices (tablets, 768px and up) */
        //     // @media (min-width: @screen-sm-min) { ... }
        //
        //     /* Medium devices (desktops, 992px and up) */
        //     // @media (min-width: @screen-md-min) { ... }
        //
        //     /* Large devices (large desktops, 1200px and up) */
        //     // @media (min-width: @screen-lg-min) { ... }
        //
        //     if(scrWidth >= 1200) {
        //         eccLevel = qrcodegen.QrCode.Ecc.HIGH;
        //         scale = 8;
        //         border = 4;
        //     }
        //     else if(scrWidth >= 992) {
        //         eccLevel = qrcodegen.QrCode.Ecc.QUARTILE;
        //         scale = 8;
        //         border = 4;
        //     }
        //     else if(scrWidth >= 768) {
        //         eccLevel = qrcodegen.QrCode.Ecc.QUARTILE;
        //         scale = 7;
        //         border = 4;
        //     }
        //     else if(scrWidth >= 500) {
        //         eccLevel = qrcodegen.QrCode.Ecc.QUARTILE;
        //         scale = 6;
        //         border = 2;
        //     }
        //     else if(scrWidth >= 400) {
        //         eccLevel = qrcodegen.QrCode.Ecc.MEDIUM;
        //         scale = 5;
        //         border = 1;
        //     }
        //     else if(scrWidth >= 350) {
        //         eccLevel = qrcodegen.QrCode.Ecc.MEDIUM;
        //         scale = 5;
        //         border = 0;
        //     }
        //     else {
        //         eccLevel = qrcodegen.QrCode.Ecc.LOW;
        //         scale = 4;
        //         border = 0;
        //     }
        //
        //     console.log('eccLevel = ' + eccLevel.ordinal);
        //     console.log('scale = ' + scale);
        //     console.log('border = ' + border);
        //
        //     // generate qr
        //     var qr = qrcodegen.QrCode.encodeSegments(segs, eccLevel, 1, 40, -1, true);
        //     // draw qr on canvas
        //     qr && qr.drawCanvas(scale, border, canvas);
        //     return canvas;
        // }

        // function drawQR(qrString) {
        //     var canvas = document.getElementById("qr"),
        //         segs = qrcodegen.QrSegment.makeSegments(qrString),
        //         // scrWidth = common.windowSize().width,
        //         scrWidth = parseInt($('div.content-wrapper').css('width')),
        //         eccLevel,
        //         scale,
        //         border;
        //
        //     console.log('>>> scrWidth = ' + scrWidth);
        //
        //     // https://getbootstrap.com/docs/3.3/css/
        //
        //     /* Extra small devices (phones, less than 768px) */
        //     /* No media query since this is the default in Bootstrap */
        //
        //     /* Small devices (tablets, 768px and up) */
        //     // @media (min-width: @screen-sm-min) { ... }
        //
        //     /* Medium devices (desktops, 992px and up) */
        //     // @media (min-width: @screen-md-min) { ... }
        //
        //     /* Large devices (large desktops, 1200px and up) */
        //     // @media (min-width: @screen-lg-min) { ... }
        //
        //     if(scrWidth >= 1200) {
        //         // lg
        //         eccLevel = qrcodegen.QrCode.Ecc.HIGH;
        //         scale = 8;
        //         border = 4;
        //     }
        //     else if(scrWidth >= 992) {
        //         // md
        //         eccLevel = qrcodegen.QrCode.Ecc.QUARTILE;
        //         scale = 8;
        //         border = 4;
        //     }
        //     else if(scrWidth >= 768) {
        //         // sm
        //         eccLevel = qrcodegen.QrCode.Ecc.QUARTILE;
        //         scale = 6;
        //         border = 4;
        //     }
        //     else if(scrWidth >= 568) {
        //         // small device
        //         eccLevel = qrcodegen.QrCode.Ecc.QUARTILE;
        //         scale = 6;
        //         border = 2;
        //     }
        //     else if(scrWidth >= 400) {
        //         eccLevel = qrcodegen.QrCode.Ecc.MEDIUM;
        //         scale = 5;
        //         border = 1;
        //     }
        //     else if(scrWidth >= 350) {
        //         eccLevel = qrcodegen.QrCode.Ecc.MEDIUM;
        //         scale = 5;
        //         border = 0;
        //     }
        //     else {
        //         eccLevel = qrcodegen.QrCode.Ecc.LOW;
        //         scale = 4;
        //         border = 0;
        //     }
        //
        //     console.log('eccLevel = ' + eccLevel.ordinal);
        //     console.log('scale = ' + scale);
        //     console.log('border = ' + border);
        //
        //     // generate qr
        //     var qrSegments = qrcodegen.QrCode.encodeSegments(segs, eccLevel, 1, 40, -1, true);
        //     // draw qr on canvas
        //     if(qrSegments) {
        //         var image = $('img#logo')[0],
        //             canvasCxt;
        //
        //         qrSegments.drawCanvas(scale, border, canvas);
        //         canvasCxt = canvas.getContext("2d");
        //
        //         canvasCxt.drawImage(image,
        //             canvas.width / 2 - image.width / 2,
        //             canvas.height / 2 - image.height / 2
        //         );
        //     }
        // }

        function drawQR(qrString) {
            var canvas = document.getElementById("qr"),
                segs = qrcodegen.QrSegment.makeSegments(qrString),
                // scrWidth = common.windowSize().width,
                scrWidth = parseInt($('div.content-wrapper').css('width')),
                eccLevel,
                scale,
                border;

            console.log('>>> scrWidth = ' + scrWidth);

            // https://getbootstrap.com/docs/3.3/css/

            /* Extra small devices (phones, less than 768px) */
            /* No media query since this is the default in Bootstrap */

            /* Small devices (tablets, 768px and up) */
            // @media (min-width: @screen-sm-min) { ... }

            /* Medium devices (desktops, 992px and up) */
            // @media (min-width: @screen-md-min) { ... }

            /* Large devices (large desktops, 1200px and up) */
            // @media (min-width: @screen-lg-min) { ... }

            if(scrWidth >= 992) {
                // md
                eccLevel = qrcodegen.QrCode.Ecc.QUARTILE;
                scale = 7;
                border = 4;
            }
            else if(scrWidth >= 768) {
                // sm
                eccLevel = qrcodegen.QrCode.Ecc.QUARTILE;
                scale = 6;
                border = 4;
            }
            else if(scrWidth >= 568) {
                // small device
                eccLevel = qrcodegen.QrCode.Ecc.QUARTILE;
                scale = 6;
                border = 2;
            }
            else if(scrWidth >= 400) {
                eccLevel = qrcodegen.QrCode.Ecc.MEDIUM;
                scale = 5;
                border = 1;
            }
            else if(scrWidth >= 350) {
                eccLevel = qrcodegen.QrCode.Ecc.MEDIUM;
                scale = 5;
                border = 0;
            }
            else {
                eccLevel = qrcodegen.QrCode.Ecc.LOW;
                scale = 4;
                border = 0;
            }

            console.log('eccLevel = ' + eccLevel.ordinal);
            console.log('scale = ' + scale);
            console.log('border = ' + border);

            // generate qr
            var qrSegments = qrcodegen.QrCode.encodeSegments(segs, eccLevel, 1, 40, -1, true);
            // draw qr on canvas
            if(qrSegments) {
                var image = $('img#logo')[0],
                    canvasCxt;

                qrSegments.drawCanvas(scale, border, canvas);
                canvasCxt = canvas.getContext("2d");

                if(scrWidth >= 568) {
                    // large screeh
                    canvasCxt.drawImage(image,
                        canvas.width / 2 - image.width / 2,
                        canvas.height / 2 - image.height / 2
                    );
                }
                else {
                    var dstW = image.width * 2 / 3,
                        dstH = image.height * 2 / 3;

                    // small
                    canvasCxt.drawImage(image,
                        canvas.width / 2 - dstW / 2,
                        canvas.height / 2 - dstH / 2,
                        dstW,
                        dstH
                    );
                }
            }
        }
    };

    common.menuItemActive = function (feature) {
        if(feature) {
            $sidebarMenu = $sidebarMenu || $('ul.sidebar-menu');
            $sidebarMenu.find('li').removeClass('active');
            $sidebarMenu.find('li.' + feature).addClass('active');
        }
    };

    common.getCurrencyInfo = function (currencyCode, success) {
        if(currencyMapJson) {
            $.isFunction(success) && success(currencyMapJson[currencyCode]);
        }
        else {
            $.getJSON(window.jsp_request_contextPath + '/assets/json/common-currency.json', function(json){
                currencyMapJson = json;
                $.isFunction(success) && success(currencyMapJson[currencyCode]);
            });
        }
    };

    common.areCookiesEnabled = function () {
        var cookieEnabled = navigator.cookieEnabled;

        // When cookieEnabled flag is present and false then cookies are disabled.
        if (cookieEnabled === false) {
            return false;
        }

        // try to set a test cookie if we can't see any cookies and we're using
        // either a browser that doesn't support navigator.cookieEnabled
        // or IE (which always returns true for navigator.cookieEnabled)
        if (!document.cookie && (cookieEnabled === null || /*@cc_on!@*/false))
        {
            document.cookie = "testcookie=1";

            if (!document.cookie) {
                return false;
            } else {
                document.cookie = "testcookie=; expires=" + new Date(0).toUTCString();
            }
        }

        return true;
    }


}(window, window.UP || (window.UP = {})));