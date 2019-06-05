<%--
  Created by IntelliJ IDEA.
  User: yujianhua
  Date: 2018/11/2
  Time: 12:01
  To change this template use File | Settings | File Templates.
--%>


<style type="text/css">
    .form-signin {
        /* max-width: 330px; */
        padding: 30px 10px 0 20px;
        /*margin: 20px auto;*/
    }

    .form-signin .form-signin-heading,
    .form-signin .checkbox {
        margin-bottom: 10px;
    }

    .form-signin .checkbox {
        font-weight: normal;
    }

    .form-signin .form-control {
        position: relative;
        height: auto;
        -webkit-box-sizing: border-box;
        -moz-box-sizing: border-box;
        box-sizing: border-box;
        /* padding: 10px; */
        font-size: 16px;
    }

    .form-signin .form-control:focus {
        z-index: 2;
    }

    .form-signin input[type="number"] {
        margin-bottom: -1px;
        border-bottom-right-radius: 0;
        border-bottom-left-radius: 0;
    }

    .form-signin input[type="password"] {
        /* margin-bottom: 10px; */
        border-top-left-radius: 0;
        border-top-right-radius: 0;
    }

    .form-signin a.register {
        /* text-decoration: none; */
        /* background-color: transparent; */
        /* color: white; */
    }

    .form-signin a.register {
        margin: 20px;
        font-size: 16px;
    }

    .form-signin a.find-pwd {
        margin: 20px;
        font-size: 16px;
    }

    #userRole a {
        /*margin: 10px 15px 0;*/
        font-size: 16px;
        text-decoration: underline;
    }

    #captcha img, #captchaForMerchant img {
        max-height: 40px;
        margin: auto;
        display: block;
    }

    @media (max-width: 768px) {
        div.captcha {
            width: 50%;
            display: inline-block;
            /*margin-left: 15px;*/
        }

        div.captcha-img {
            width: 40%;
            display: inline-block;
            margin-bottom: -12px;
        }

        div.register div {
            margin-left: 0;
        }

        div.register div input {
            /*min-width: 180px;*/
            width: 40%;
        }

        div.register div input + input {
            margin-left: 10%;
        }

    }
</style>

<div id="setupLoginContainer">

    <form class="form-signin form-horizontal" role="form"
          action="${pageContext.request.contextPath}/terminal/doLogin"
          method="post" enctype="application/x-www-form-urlencoded"
          data-validator-option="{theme:'bootstrap', timely:2, stopOnError:true}"
          autocomplete="off">
        <%--<h2 class="form-signin-heading">Please Sign In (Terminal Role)</h2>--%>

        <div class="form-group">
            <label class="control-label col-sm-3">User name</label>
            <div class="col-sm-9">
                <input type="text" class="form-control" name="userName" placeholder="user name" minlength="1"
                       onkeyup="value=value.replace(/[^\d]/g,'')"
                       maxlength="100"
                       data-rule="required; userName;"
                       data-rule-userName="[/[0-9a-zA-Z]{1,100}/, 'Please enter 1-100 letters or digits']"
                <%--data-tip="Please fill in 15 digits"--%>
                >
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-3">Password</label>s
            <div class="col-sm-9">
                <input type="password" class="form-control" name="password" placeholder="8-16 letters or digits"
                       minlength="8" maxlength="16"
                       data-rule="required; password;"
                       data-rule-password="[/[\d\w]{8,16}/, 'Please fill in 8-16 letters or digits']"
                <%--data-tip="Please fill in 8-16 digits or digits"--%>
                <%--autocomplete="off" readonly onfocus="this.removeAttribute('readonly');"--%>
                >
            </div>
        </div>


        <div id="captcha" class="form-group">
            <label class="control-label col-sm-3">Captcha</label>
            <div class="row col-sm-9">
                <div class="col-sm-7 captcha">
                    <input type="text" class="form-control" name="captcha" placeholder="Captcha" maxlength="4"
                           minlength="4"
                           data-rule="required; captcha;"
                           data-rule-captcha="[/[\d\w]{4,4}/, 'Please fill captcha']"
                    <%--data-tip="Please fill in captcha"--%>
                    >
                </div>
                <div class="col-sm-5 captcha-img">
                    <img alt="Refresh Captcha" src="" style="display: none">
                </div>
            </div>
        </div>

        <%--<div class="checkbox">--%>
        <%--<label>--%>
        <%--<input type="checkbox" value="remember-me"> Remember me--%>
        <%--</label>--%>
        <%--</div>--%>

        <%--<div class="register form-group">--%>
        <%--<div class="col-md-offset-3 col-md-9 col-sm-offset-0 col-sm-12">--%>
        <%--<input class="btn btn-primary col-md-4 col-sm-5" name="submit" type="submit" value="Sign in">--%>
        <%--<input class="btn btn-default col-md-offset-1 col-md-4 col-sm-offset-2 col-sm-5" name="reset" type="reset" value="Clear">--%>
        <%--</div>--%>
        <%--</div>--%>

        <div class="register form-group">
            <div class="col-sm-offset-3 col-sm-9">
                <input class="btn btn-primary col-sm-4" name="submit" type="submit" value="Sign in">
                <input class="btn btn-default col-sm-offset-1 col-sm-4" name="reset" type="reset" value="Clear">
            </div>
        </div>


        <%--<button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>--%>

        <%--<a href="${pageContext.request.contextPath}/register?role=terminal"--%>
        <%--class="register btn btn-lg btn-default btn-block">Sign up</a>--%>

        <div class="clearfix">
            <a href="${pageContext.request.contextPath}/register" class="register pull-right">Sign up</a>
            <a href="${pageContext.request.contextPath}/findPwd" class="find-pwd pull-right"> Find password </a>
        </div>

    </form>
</div>

<script type="text/javascript">
    (function () {
        'use strict';

        $(document).ready(function () {
            var $topContainer = $('#setupLoginContainer'),
                $signupForm = $topContainer.find('form'),
                common = UP.Common;

            var $captcha = $('#captcha'),
                $captchaImg = $captcha.find('img');

            common.dismissLoading();
            initPageData();

            function initPageData() {
                $(document).ready(function () {
                    pageCtrlShowHideDriven();
                    initPageEvent();
                });
            }

            function initPageEvent() {
                $captchaImg.on('click', function () {
                    getCaptcha($(this));
                });

                var formSubmitHandlerParams = {
                    success: function (data) {
                        // success
                        window.location.replace(window.jsp_request_contextPath + '/main');
                    },
                    logicError: function (response) {
                        setTimeout(function () {
                            common.showPopup({
                                message: response.message || response.Message,
                                closeFunc: function () {
                                    // refresh captcha
                                    getCaptcha($captchaImg);
                                }
                            });
                        }, 100);
                    }
                };

                // merchant form submit
                common.formSubmitByAjaxWithPwd($signupForm, formSubmitHandlerParams);
            }

            function getCaptcha($captchaImg) {
                console.log('>>> getCaptcha');
                common.ajaxRequest({
                    enableLoading: false,
                    action: "${pageContext.request.contextPath}/getCaptcha",
                    data: {
                        r: Math.random()
                    },
                    successCB: function (data) {
                        // success
                        $captchaImg.attr('src', 'data:image/png;base64,' + data).show();
                        // $captchaForTerminal
                        $captchaImg.closest('div.row').find('input[name="captcha"]').val('');
                    }
                });
            }

            function pageCtrlShowHideDriven() {
                $signupForm.show();
                getCaptcha($captchaImg);
            }
        });
    }());
</script>
