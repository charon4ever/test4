<%--
  Created by IntelliJ IDEA.
  User: yujianhua
  Date: 2018/10/17
  Time: 15:50
  To change this template use File | Settings | File Templates.

业务背景： Added by jhyu on 2019/05/22
1. 存量用户密码都是弱类型，前端仅仅限制了长度8-16位
2. 新用户密码都是强类型，长度8-16位，只能是数字和字母混合
3. Mobile APP 和 WEB APP 共享用户系统，两者用户可以互相联登。

修改点：
Mobile APP：
1. 注册，找回密码，都要设置新密码，规则基于#2
2. 登录输入密码，验证用户输入密码 均需要兼容新老用户，规则基于#1
3. 重置密码，原密码规则基于#1， 新密码规则基于#2

WEB APP：
规则同Mobile APP
--%>

<%--https://www.bootply.com/ZziMEErMxS--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/intl-tel-input-15.0.0/css/intlTelInput.min.css">
<%--<link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/intl-tel-input/css/intlTelInput.css">--%>

<style type="text/css">
    .stepwizard-step p {
        margin-top: 10px;
    }
    .stepwizard-row {
        display: table-row;
    }
    .stepwizard {
        display: table;
        width: 100%;
        position: relative;
        margin: 15px auto 0;
    }
    .stepwizard-step button[disabled] {
        opacity: 1 !important;
        filter: alpha(opacity=100) !important;
    }
    .stepwizard-row:before {
        top: 24px;
        bottom: 0;
        position: absolute;
        content: " ";
        width: 100%;
        height: 1px;
        background-color: #ccc;
        z-order: 0;
    }
    .stepwizard-step {
        display: table-cell;
        text-align: center;
        position: relative;
    }
    .btn-circle {
        width: 48px;
        height: 48px;
        text-align: center;
        /* padding: 26px 0; */
        font-size: 22px;
        line-height: 1.428571429;
        border-radius: 50%;
        vertical-align: middle;
    }
    .segment {
        margin-bottom: 30px;
        border: dotted 1px;
        max-width: 180px;
        max-height: 180px;
    }
    .segment img {
        max-width: 100%;
        max-height: 100%;
    }

    i.fa {
        font-size: 40px;
    }

    .panel-heading title {
        display: block !important;
    }

    div.intl-tel-input {
        display: block;
    }

    #countDown {
        width: 100%;
        margin-left: 20px;
    }

    form {
        padding: 20px 8px;
        /*margin: 20px auto;*/
    }

    #setupRegisterContainer {

    }

    #setupRegisterContainer div.stepwizard {

    }

    .form-group label.control-label {
        margin-top: 3px;
        /* font-size: 18px; */
        font-weight: 500;
        /*text-align: left;*/
    }


    form.setup-content .step-number {
        display: none;
    }


    .checkbox label:after {
        content: '';
        display: table;
        clear: both;
    }

    .checkbox .cr {
        position: relative;
        display: inline-block;
        border: 1px solid #a9a9a9;
        border-radius: .25em;
        width: 1.3em;
        height: 1.3em;
        float: left;
        margin-right: .5em;
    }

    .checkbox .cr .cr-icon {
        position: absolute;
        font-size: .8em;
        line-height: 0;
        top: 50%;
        left: 15%;
    }

    .checkbox label input[type="checkbox"] {
        display: none;
    }

    .checkbox label input[type="checkbox"]+.cr>.cr-icon {
        opacity: 0;
    }

    .checkbox label input[type="checkbox"]:checked+.cr>.cr-icon {
        opacity: 1;
    }

    .checkbox label input[type="checkbox"]:disabled+.cr {
        opacity: .5;
    }

    /*@media screen and (max-width: 767px) {*/
        /*.form-group.checkbox label.control-label {*/
            /*display: none;*/
        /*}*/
    /*}*/

    #agreementAnchor {
        margin-top: -10px;
        margin-bottom: 13px;
    }

    @media screen and (min-width: 768px) {
        #agreementAnchor span.msg-box span.msg-wrap.n-error {
            margin-left: -382px;
        }
    }

    #poupPanelModal {
        font-size: 13px;
    }

    #poupPanelModal .modal-dialog {
        width: 84%!important;
    }

    #poupPanelModal .modal-dialog .modal-body p {
        margin-bottom: 10px;
    }

    #poupPanelModal .modal-dialog .modal-body p strong {
        margin-bottom: 13px;
    }

    #agreementAnchor p {
        font-size: 13px!important;
    }

    #agreementAnchor a {
        text-decoration: underline;
    }

    #phone {
        padding-left: 100px!important;;
    }

</style>

<div id="setupRegisterContainer" data-role="${userRole}">
    <div class="stepwizard ">
        <div class="stepwizard-row setup-panel">
            <div class="stepwizard-step">
                <a href="#step-1" type="button" class="btn btn-primary btn-circle">1</a>
                <p>Step 1</p>
            </div>
            <div class="stepwizard-step">
                <a href="#step-2" type="button" class="btn btn-default btn-circle" disabled="disabled">2</a>
                <p>Step 2</p>
            </div>
            <div class="stepwizard-step">
                <a href="#step-3" type="button" class="btn btn-default btn-circle" disabled="disabled">3</a>
                <p>Step 3</p>
            </div>
        </div>
    </div>

    <form id="step-1" class="form-horizontal setup-content" role="form"
          action="${pageContext.request.contextPath}/${userRole}/doRegister"
          method="post" enctype="application/x-www-form-urlencoded"
          autocomplete="off"
          data-validator-option="{theme:'bootstrap', timely:2, stopOnError:true}"
          style="display: block"
    >
        <div class="col-md-12 step-1">
            <h3 class="step-number"> Step 1</h3>

            <div class="form-group">
                <label class="control-label col-sm-3">User Name</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control" name="userName" placeholder="letters or numbers" minlength="1" maxlength="100"
                           data-rule="required; userName;"
                           data-rule-userName="[/^[0-9a-zA-Z]{1,100}$/, 'Please enter letters or numbers']"
                    <%--data-tip="Please fill in 15 numbers"--%>
                    >
                </div>
            </div>

<%--            <c:if test="${userRole eq 'terminal'}">--%>
<%--                <div class="form-group">--%>
<%--                    <label class="control-label col-sm-3">Terminal ID</label>--%>
<%--                    <div class="col-sm-9">--%>
<%--                        <input type="text" class="form-control" name="terminalId" placeholder="8 numbers" minlength="8" maxlength="8" pattern="\d*"--%>
<%--                               data-rule="required; terminalId;"--%>
<%--                               data-rule-terminalId="[/^[\d]{8,8}$/, 'Please enter 8 numbers']"--%>
<%--                        >--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </c:if>--%>

            <div class="form-group">
                <label class="control-label col-sm-3">Registered By</label>
                <div class="col-sm-9">
                    <select name="authType" class="indent-2 form-control">
                        <option value="email" lang="en_US">Email</option>
                        <option value="mobile" lang="en_US">Mobile Phone</option>
                    </select>
                </div>
            </div>

            <div id="byEmail" class="form-group">
                <label class="control-label col-sm-3">Email</label>
                <div class="col-sm-9">
                    <input id="email" name="email" value="" maxlength="128" type="email" class="form-control"
                           placeholder="Email"
                           data-rule="required;email"
                    >
                </div>
            </div>

            <div id="byPhone" class="form-group" style="display: none">
                <label class="control-label col-sm-3">Mobile Phone</label>
                <div class="col-sm-9">
                    <input id="phone" name="mobile" type="tel" value="" maxlength="32" class="form-control" placeholder="Phone Number" pattern="\d*"
                           data-rule="required; mobile;"
                           novalidate="true"
                    >
                </div>
            </div>

            <c:if test="${isRegisterPage}">
                <!-- Checked checkbox for T&C -->
                <div id="agreementAnchor" class="checkbox form-group" style="">
                    <%--<label class="control-label col-sm-2"></label>--%>
                    <div class="col-sm-offset-2 col-sm-10">
                        <label style="padding-left: 0">
                            <input type="checkbox" value="" data-rule="checked" checked>
                            <span class="cr">
                                <i class="cr-icon glyphicon glyphicon-ok"></i>
                            </span>
                            Have read and agree to
                            <a target="_blank" href="${pageContext.request.contextPath}/resources/html/terms-condition.html" lang="en_US">Terms of Use and Privacy Policy</a>
                        </label>
                    </div>
                </div>
            </c:if>
            <div class="form-group">
                <button id="redirect2LoginPage" class="btn btn-default prevBtn pull-left" type="button">Previous</button>
                <button class="btn btn-primary nextBtn pull-right" type="submit">Next</button>
            </div>
        </div>
    </form>

    <form id="step-2" class="setup-content form-horizontal" role="form"
          action="${pageContext.request.contextPath}/${userRole}/validateOtp"
          method="post" enctype="application/x-www-form-urlencoded" style="display: none"
          data-validator-option="{theme:'bootstrap', timely:2, stopOnError:true}"
          autocomplete="off"
          data-validator-option="{theme:'bootstrap', timely:2, stopOnError:true}"
    >

        <div class="col-md-12 step-2">
            <h3 class="step-number"> Step 2</h3>

            <div class="form-group email">
                <label class="control-label col-sm-3">Email</label>

                <div class="col-sm-9">
                    <input name="email" value="${email}" maxlength="256" type="email" required="required"
                           class="form-control" disabled="disabled">
                </div>
            </div>

            <div class="form-group mobile">
                <label class="control-label col-sm-3">Mobile Phone</label>
                <div class="col-sm-9">
                    <input name="mobile" value="${mobile}" maxlength="256" type="text" required="required"
                           class="form-control" disabled="disabled">
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-sm-3">OTP Code</label>
                <div class="col-sm-9">
                    <div class="row">
                        <div class="col-xs-6">
                            <input class="form-control" name="otp" type="tel" class="" placeholder="OTP code" minlength="6" maxlength="6" pattern="\d*"
                                   data-rule="required;otp"
                                   data-rule-otp="[/^[\d]{6,6}$/, 'Please enter 6 numbers']"
                            >
                        </div>
                        <div class="col-xs-5">
                            <input type="button" id="countDown" class="btn btn-primary btn-md" value="300">
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <button class="btn btn-default prevBtn pull-left" type="button">Previous</button>
                <button class="btn btn-primary nextBtn pull-right" type="submit">Next</button>
            </div>
        </div>
    </form>

    <form id="step-3" class="setup-content form-horizontal" role="form"
          action="${pageContext.request.contextPath}/${userRole}/${isRegisterPage ? 'doRegister' : 'resetPassword'}"
          method="post" enctype="application/x-www-form-urlencoded" style="display: none"
          autocomplete="off"
          data-validator-option="{theme:'bootstrap', timely:2, stopOnError:true}"
    >

        <div class="col-md-12 step-3">
            <h3 class="step-number"> Step 3</h3>

            <div class="form-group">
                <label class="control-label col-sm-3">Password</label>
                <div class="col-sm-9">
                    <input name="${isRegisterPage ? 'password' : 'newPassword'}" type="password" value=""
                           minlength="8" maxlength="16" required="required" class="form-control"
                           placeholder="8-16 letters and numbers"
                           data-rule="required;password;newPassword"
                           data-rule-password="[/(?!^[0-9]+$)(?!^[A-Za-z]+$)(^([A-Za-z0-9]){8,16}$)/, 'Password should be longer than 8 and composed of numbers and letters']"
                           data-rule-newPassword="[/(?!^[0-9]+$)(?!^[A-Za-z]+$)(^([A-Za-z0-9]){8,16}$)/, 'Password should be longer than 8 and composed of numbers and letters']"
                    >
                </div>
            </div>
            <div class="form-group">
                <button class="btn btn-default prevBtn pull-left" type="button">Previous</button>
                <button class="btn btn-primary pull-right"
                        type="submit">${isRegisterPage ? 'Sign up' : 'Reset Password'}</button>
            </div>

        </div>
    </form>
</div>

<script type="text/javascript" src="${pageContext.request.contextPath}/plugins/intl-tel-input-15.0.0/js/intlTelInput-jquery.min.js" async></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/plugins/intl-tel-input-15.0.0/js/utils.js" async></script>
<script type="text/javascript">
    (function () {
        'use strict';
        initPageData();
        function initPageData() {
            $(document).ready(function () {
                var $registerContainer = $('#setupRegisterContainer'),
                    userRole = $registerContainer.data('role'),
                    terminalRole = (userRole === 'terminal'),
                    isRegisterPage = ${isRegisterPage},
                    businessScenario = (isRegisterPage ? 'REGISTER' : 'RESET_PASSWORD');

                console.log('isRegisterPage = ' + isRegisterPage);

                var $step1Form = $('#step-1'),
                    $step2Form = $('#step-2'),
                    $step3Form = $('#step-3'),
                    $mobile = $('#phone'),
                    $email = $('#email'),
                    $authType = $('select[name="authType"]'),
                    common = UP.Common;

                var $countDown = $('#countDown'),
                    timer,
                    phoneCountryCode;

                setupInputForIntlTel();
                pageStepsHandler();
                setupAuthSelector();
                initPageEvent();
                mockTestAccount();

                $("#redirect2LoginPage").click(function () {
                    UP.Common.jump2LoginPage();
                });
                // mock
                // $step1Form.hide();
                // $step2Form.show();
                // startCountDown(10);
                // end mock
                function pageStepsHandler() {
                    var navListItems = $('div.setup-panel div a'),
                        allWells = $('.setup-content'),
                        allNextBtn = $('.nextBtn'),
                        allPrevBtn = $('.prevBtn');

                    allWells.hide();

                    navListItems.click(function (e) {
                        e.preventDefault();
                        var $target = $($(this).attr('href')),
                            $item = $(this);

                        if ($item.attr('disabled') !== 'disabled') {
                            navListItems.removeClass('btn-primary').addClass('btn-default');
                            $item.addClass('btn-primary');
                            allWells.hide();
                            $target.show();
                            $target.find('input:eq(0)').focus();
                        }
                    });

                    allPrevBtn.click(function () {
                        var curStep = $(this).closest(".setup-content"),
                            curStepBtn = curStep.attr("id"),
                            prevStepWizard = $('div.setup-panel div a[href="#' + curStepBtn + '"]').parent().prev().children("a");

                        prevStepWizard.removeAttr('disabled').trigger('click');
                    });

                    $('div.setup-panel div a.btn-primary').trigger('click');
                }

                // sub steps next handler
                function nextStepHandler($form) {
                    var curStep = $form.closest(".setup-content"),
                        curStepBtn = curStep.attr("id"),
                        nextStepWizard = $('div.setup-panel div a[href="#' + curStepBtn + '"]').parent().next().children("a"),
                        //curInputs = curStep.find("input[type='text'],input[type='url']"),
                        curInputs = curStep.find("input:not(:disabled)"),
                        isValid = true,
                        i;

                    $(".form-group").removeClass("has-error");

                    for (i = 0; i < curInputs.length; i++) {
                        if (!curInputs[i].validity.valid) {
                            isValid = false;
                            $(curInputs[i]).closest(".form-group").addClass("has-error");
                        }
                    }

                    if (isValid) {
                        nextStepWizard.removeAttr('disabled').trigger('click');
                    }
                }

                // setup page listen event.
                function initPageEvent() {
                    // step-1 request
                    var $agreementAnchor = $('#agreementAnchor'),
                        otpVerifyPass;

                    // for step-1
                    // $agreementAnchor.find('a').on('click', function (e) {
                    //     // show agreement content
                    //     var $contentDiv = $('#agreementContent');
                    //     common.showMessagePanelPopup('Payment Success Result', $contentDiv.html());
                    // });

                    common.formSubmitByAjax($step1Form, {
                        beforeSerialize: function ($form, options) {
                            // if(!!isRegisterPage) {
                            //     // agree T&C is mandatory
                            //     if($agreementAnchor.find('input[type="checkbox"]').prop('checked') === false) {
                            //         common.showPopup('Terms of Use and Privacy Policy should be agreed to continue.');
                            //         return false;
                            //     }
                            // }

                            if (isAuthByEmail()) {
                                // user choose email to auth
                                $mobile.removeAttr('name');
                                $email.val($email.val().trim());
                            }
                            else {
                                // user choose mobile to auth
                                $email.removeAttr('name');
                                var mobileValue = $mobile.val().trim();
                                $mobile.val();
                            }
                        },
                        success: function (data) {
                            // success
                            // jump to step 2.
                            nextStepHandler($step1Form);

                            var $emailDiv = $step2Form.find('div.form-group.email'),
                                $mobileDiv = $step2Form.find('div.form-group.mobile');

                            if (isAuthByEmail()) {
                                // email
                                $emailDiv.find('input[name="email"]').val($email.val());
                                $emailDiv.show();
                                $mobileDiv.hide();
                            }
                            else {
                                // mobile
                                $mobileDiv.find('input[name="mobile"]').val('+' + phoneCountryCode + '-' + $mobile.val());
                                $mobileDiv.show();
                                $emailDiv.hide();
                            }

                            otpVerifyPass = false;

                            $step2Form.find('input[name="otp"]').val('');

                            startCountDown(data.resendInterval || 300);
                        },
                        complete: function () {
                            if (isAuthByEmail()) {
                                // user choose email to auth
                                $mobile.attr('name', 'mobile');
                            }
                            else {
                                // user choose mobile to auth
                                $email.attr('name', 'email');
                            }
                        }
                    }, function () {
                        var params = {
                            businessScenario: businessScenario
                        };

                        if (isAuthByEmail()) {
                            // auth by mobile
                            // do nothing
                        }
                        else {
                            phoneCountryCode = $step1Form.find('div.selected-dial-code').html().replace(/\D/g,'');
                            // remove '+' in phoneCountryCode
                            params.phoneCountryCode = phoneCountryCode;
                        }

                        return params;
                    });

                    // for step-2
                    // step-2 submit
                    common.formSubmitByAjax($step2Form, {
                        beforeSerialize: function ($form, options) {
                            if(otpVerifyPass) {
                                // case: user go back from step3 to step2, no need to verify OTP again.
                                // jump to step 3.
                                nextStepHandler($step2Form);
                                return false;
                            }
                        },
                        success: function (data) {
                            // success
                            // jump to step 3.
                            nextStepHandler($step2Form);
                            otpVerifyPass = true;
                        }
                    }, {
                        businessScenario: businessScenario
                    });

                    // re-send OTP click action during step-2
                    $('#countDown').on('click', function () {
                        var data = {
                                businessScenario: businessScenario
                            },
                            action;

                        if(isAuthByEmail()) {
                            action = '/resendEmailOtp';
                        }
                        else {
                            action = '/resendSmsOtp';
                            data.phoneCountryCode = phoneCountryCode;
                        }

                        common.ajaxRequest({
                            enableLoading: true,
                            action: '/' + userRole + action,
                            data: data,
                            successCB: function (data) {
                                startCountDown(data.resendInterval || 300);
                            }
                        });
                    });

                    // for step-3
                    // step-3 submit
                    common.formSubmitByAjaxWithPwd($step3Form, {
                        success: function (data) {
                            // success
                            // redirect to home page.
                            window.location.replace(window.jsp_request_contextPath + '/main');
                        }
                    }, {
                        businessScenario: businessScenario
                    });
                }

                function isAuthByEmail() {
                    return $authType.val() === 'email';
                }

                function mockTestAccount() {
                    if (common.debugMode) {
                        if (isRegisterPage) {
                            // TODO mock input element
                            $('input[name="merchantId"]').val('500000000000000');
                            $('input[name="terminalId"]').val('12345678');
                            $('input[name="email"]').val('jhyu@sysnew.com');
                            $('input[name="mobile"]').val('88889999');
                        }
                        else {
                            $('input[name="merchantId"]').val('299999999999999');
                            $('input[name="terminalId"]').val('00000000');
                            $('input[name="email"]').val('yltang@sysnew.com');
                            $('input[name="mobile"]').val('88888888');
                        }
                    }
                }

                // config intl tel input
                function setupInputForIntlTel() {
                    //var $dialCode = $('div.selected-dial-code');

                    /*
                        针对敏感地区的称呼参考了网易邮箱注册 http://reg.email.163.com/unireg/call.do?cmd=register.entrance&from=126mail
                        和 云闪付 地区搜索提示
                     */
                    $mobile.intlTelInput({
                        // allowDropdown: false,
                        // autoHideDialCode: false,
                        autoPlaceholder: "off",
                        // dropdownContainer: "body",
                        // excludeCountries: ["us"],
                        // formatOnDisplay: false,
                        // geoIpLookup: function(callback) {
                        //     //  https://ipinfo.io
                        //     $.get("//ipinfo.io", function() {}, "jsonp").always(function(resp) {
                        //         // set HK as default  HK=852
                        //         var countryCode = (resp && resp.country) ? resp.country : "hk";
                        //         console.log('countryCode = ' + countryCode);
                        //         callback(countryCode);
                        //     });
                        // },
                        // hiddenInput: "full_number",
                        initialCountry: "hk",
                        // nationalMode: false,
                        // onlyCountries: ['us', 'gb', 'ch', 'ca', 'do'],
                        placeholderNumberType: "polite",
                        preferredCountries: ['hk', 'sg', 'th'],
                        separateDialCode: true
                    });

                    $mobile.on("countrychange", function (e, countryData) {
                        // do something with countryData
                        // clear original input.
                        $mobile.val('');
                    });
                }

                function setupAuthSelector() {
                    // listen auth type change
                    var $fromRowForEmail = $('#byEmail'),
                        $fromRowForPhone = $('#byPhone');

                    $authType.on('change', function () {
                        var value = $(this).val();
                        console.log('>>> authType = ' + value);
                        if (value.toUpperCase() === 'EMAIL') {
                            // Email
                            $fromRowForEmail.show();
                            $fromRowForPhone.hide();

                            $email.removeAttr('novalidate');
                            $mobile.attr('novalidate', 'true');
                        }
                        else {
                            // mobile phone
                            $fromRowForPhone.show();
                            $fromRowForEmail.hide();

                            $mobile.removeAttr('novalidate');
                            $email.attr('novalidate', 'true');
                        }
                    });
                }

                // sms count down timer.
                function startCountDown(counter) {
                    // TODO: mock
                    // counter = 5;

                    $countDown.text(counter + '');
                    $countDown.addClass('disabled').attr("disabled", "disabled");

                    timer && clearInterval(timer);

                    timer = setInterval(function () {
                        countDownHandler(counter);
                        counter--;
                    }, 1000);
                }

                // count down
                function countDownHandler(counter) {
                    // console.log('>>>> ' + countNum);

                    if (counter > 0) {
                        $countDown.val('  ' + counter + '  ');
                    }
                    else {
                        $countDown.val("Resend OTP again");
                        //停止倒计时
                        clearCountDownTimer();
                    }
                }

                //停止倒计时
                function clearCountDownTimer() {
                    if (timer) {
                        clearInterval(timer);
                        timer = null;
                        $countDown.removeClass('disabled').removeAttr("disabled");
                    }
                }
            });
        }
    }());

</script>
