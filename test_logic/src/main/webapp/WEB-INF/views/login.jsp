
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html lang="en">
<head>

    <!-- Google Analytics -->
    <script>
        // (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
        //     (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
        //     m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
        // })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');
        //
        // ga('create', 'UA-105586598-1', 'auto');
        // ga('send', 'pageview');
    </script>
    <!-- End Google Analytics -->

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta http-equiv="refresh">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="author" content="International New business Dev Team">
    <meta name="description" content="UPI Merchant is a multi-function collection webapp developed specifically for UnionPay direct merchants QR code payment. After the merchant has registered and logged in, the merchant code can be applied. At the same time, it also provides merchants with the functions of QR code transaction notification, transaction inquiry, transaction cancellation and refund, and provides the 'one-stop' QR code payment solution for merchants.">
    <link rel="icon" href="${pageContext.request.contextPath}/resources/favicon.ico">

    <%--<c:if test="${not empty title}">--%>
    <title>UPI Merchant</title>
    <%--</c:if>--%>

    <!-- Bootstrap 3.3.6 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/font-awesome-4.7.0/css/font-awesome.min.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/src/main/webapp/resources/css/global.css">

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="${pageContext.request.contextPath}/assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">
    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]>
    <script src="${pageContext.request.contextPath}/assets/js/ie8-responsive-file-warning.js"></script>
    <![endif]-->
    <script src="${pageContext.request.contextPath}/assets/js/ie-emulation-modes-warning.js"></script>

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="${pageContext.request.contextPath}/AdminLTE/js/html5shiv.min.js"></script>
    <script src="${pageContext.request.contextPath}/AdminLTE/js/respond.min.js"></script>
    <![endif]-->

    <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/nice-validator-1.14/jquery.validator.css">

    <style type="text/css">

        body {
            background: url(${pageContext.request.contextPath}/src/main/webapp/resources/img/background.jpg) repeat top center #dfebf5;
            color: #333;
        }

        /* -------------------HEADER -------------- */
        #app-name {
            clear: both;
            padding: 0 0 0 25px;
            background: #333;
            color: #fff;
            font: normal 400 2.8em/2.5em Georgia, "Times New Roman", serif;
        }

        #app-name .title {
            margin-top: 23px;
        }

        #app-name div.logo {
            text-align: center;
            /*margin-left: -20px;*/
            margin-top: -10px;
        }

        @media screen and (max-width: 768px) {
            #app-name .title {
                display: inline-block;
            }

            #app-name .logo {
                /*text-align: left;*/
                /*margin-top: 0;*/
                /*margin-left: 10px;*/
                display: inline-block;
                float: right;
            }
        }

        @media screen and (max-width: 500px) {
            #app-name {
            }

            #app-name .title {
                /*font-size: 20px;*/
                /*margin-top: 10px;*/
            }

            #app-name .logo {
                display: none;
            }
        }

        /* -----------CONTENT ------------ */

        #content {
            position: relative;
            /*clear:both; padding:1px 0; margin:0 25px 2em; background: url(../images/background.jpg) no-repeat scroll;*/
            margin: 50px auto 0;
            /*min-height: 400px;*/
            border-radius: 5px;
            font-size: 14px;
            max-width: 100%;
        }

        @media screen and (min-width: 700px) {
            #content {
                position: absolute;
                top: 50%;
                left: 50%;
                -webkit-transform: translate(-50%, -50%);
                -ms-transform: translate(-50%, -50%);
                transform: translate(-50%, -50%);
                z-index: 888;
                margin: auto;
            }

        }

        /*@media screen and (max-width: 700px) {*/
        /*#footer {*/
        /*position: relative;*/
        /*margin-top: 50px;*/
        /*}*/
        /*}*/

        #content h2 {
            margin: 0 0 1em 0;
            font-size: 1.3em;
            font-weight: 400;
            color: #000;
            /* border-bottom: 1px solid #eee; */
            padding: 3px 0;
        }

        #content h3 {
            font: 1em arial, helvetica, sans-serif;
            font-weight: 600;
            margin-bottom: 20px;
        }

        #content p {
            line-height: 1.5;
            font-size: 1.1em;
            padding: 0 0 18px;
        }

        .panel-heading title {
            display: block;
        }

        /* nice-invalidator */
        form .form-group {
            /*for n-bottom style */
            margin-bottom: 25px!important;
        }

        /*cookie usage */

        .cc_banner-wrapper {
            z-index: 9001;
            position: relative
        }

        .cc_container .cc_btn {
            cursor: pointer;
            text-align: center;
            font-size: 0.6em;
            transition: font-size 200ms;
            line-height: 1em
        }

        .cc_container .cc_message {
            font-size: 0.6em;
            transition: font-size 200ms;
            margin: 0;
            padding: 0;
            line-height: 1.5em
        }

        .cc_container .cc_logo {
            display: none;
            text-indent: -1000px;
            overflow: hidden;
            width: 100px;
            height: 22px;
            background-size: cover;
            background-image: url(//cdnjs.cloudflare.com/ajax/libs/cookieconsent2/1.0.10/logo.png);
            opacity: 0.9;
            transition: opacity 200ms
        }

        .cc_container .cc_logo:hover,.cc_container .cc_logo:active {
            opacity: 1
        }

        @media screen and (min-width: 500px) {
            .cc_container .cc_btn {
                font-size:0.8em
            }

            .cc_container .cc_message {
                font-size: 0.8em
            }
        }

        @media screen and (min-width: 768px) {
            .cc_container .cc_btn {
                font-size:1em
            }

            .cc_container .cc_message {
                font-size: 1em;
                line-height: 1em
            }
        }

        @media screen and (min-width: 992px) {
            .cc_container .cc_message {
                font-size:1em
            }
        }

        @media print {
            .cc_banner-wrapper,.cc_container {
                display: none
            }
        }

        .cc_container {
            position: fixed;
            left: 0;
            right: 0;
            bottom: 0;
            overflow: hidden;
            padding: 10px
        }

        .cc_container .cc_btn {
            padding: 8px 10px;
            background-color: #f1d600;
            cursor: pointer;
            transition: font-size 200ms;
            text-align: center;
            font-size: 0.6em;
            display: block;
            width: 33%;
            margin-left: 10px;
            float: right;
            max-width: 120px
        }

        .cc_container .cc_message {
            transition: font-size 200ms;
            font-size: 0.6em;
            display: block
        }

        @media screen and (min-width: 500px) {
            .cc_container .cc_btn {
                font-size:0.8em
            }

            .cc_container .cc_message {
                margin-top: 0.5em;
                font-size: 0.8em
            }
        }

        @media screen and (min-width: 768px) {
            .cc_container {
                padding:15px 30px 15px
            }

            .cc_container .cc_btn {
                font-size: 1em;
                padding: 8px 15px
            }

            .cc_container .cc_message {
                font-size: 1em
            }
        }

        @media screen and (min-width: 992px) {
            .cc_container .cc_message {
                font-size:1em
            }
        }

        .cc_container {
            background: #222;
            color: #fff;
            font-size: 17px;
            font-family: "Helvetica Neue Light", "HelveticaNeue-Light", "Helvetica Neue", Calibri, Helvetica, Arial;
            box-sizing: border-box
        }

        .cc_container ::-moz-selection {
            background: #ff5e99;
            color: #fff;
            text-shadow: none
        }

        .cc_container .cc_btn,.cc_container .cc_btn:visited {
            color: #000;
            background-color: #f1d600;
            transition: background 200ms ease-in-out,color 200ms ease-in-out,box-shadow 200ms ease-in-out;
            -webkit-transition: background 200ms ease-in-out,color 200ms ease-in-out,box-shadow 200ms ease-in-out;
            border-radius: 5px;
            -webkit-border-radius: 5px
        }

        .cc_container .cc_btn:hover,.cc_container .cc_btn:active {
            background-color: #fff;
            color: #000
        }

        .cc_container a,.cc_container a:visited {
            text-decoration: none;
            color: #31a8f0;
            transition: 200ms color
        }

        .cc_container a:hover,.cc_container a:active {
            color: #b2f7ff
        }

        @-webkit-keyframes slideUp {
            0% {
                -webkit-transform: translateY(66px);
                transform: translateY(66px)
            }

            100% {
                -webkit-transform: translateY(0);
                transform: translateY(0)
            }
        }

        @keyframes slideUp {
            0% {
                -webkit-transform: translateY(66px);
                -ms-transform: translateY(66px);
                transform: translateY(66px)
            }

            100% {
                -webkit-transform: translateY(0);
                -ms-transform: translateY(0);
                transform: translateY(0)
            }
        }

        .cc_container,.cc_message,.cc_btn {
            animation-duration: 0.8s;
            -webkit-animation-duration: 0.8s;
            -moz-animation-duration: 0.8s;
            -o-animation-duration: 0.8s;
            -webkit-animation-name: slideUp;
            animation-name: slideUp
        }
    </style>


</head>


<body>

<noscript>
    You need to enable JavaScript to run this app.
</noscript>

<script type="text/javascript" src="${pageContext.request.contextPath}/src/main/webapp/resources/js/config.js">  </script>

<script type="text/javascript">
    window.jsp_request_contextPath = "${pageContext.request.contextPath}";
    // console.log('window.jsp_request_contextPath = ' + window.jsp_request_contextPath);

    // server driven RSA public key to encrypt password.
    <c:if test="${not empty publicKey}">
    window.jsp_public_key = "${publicKey}";
    </c:if>

    // console.log('window.jsp_public_key = ' + window.jsp_public_key);

</script>

<!-- JQuery -->
<script src="${pageContext.request.contextPath}/plugins/jQuery/jquery-3.1.1.min.js"></script>

<!-- JQuery Plugins-->
<script src="${pageContext.request.contextPath}/plugins/jquery-form/jquery.form.min.js"></script>
<%--<script type="text/javascript" src="${pageContext.request.contextPath}/plugins/jquery.disableAutoFill-1.2.6/jquery.disableAutoFill.min.js"></script>--%>
<script src="${pageContext.request.contextPath}/plugins/nice-validator-1.14/jquery.validator.min.js?local=en"></script>
<script>
    $(function(){
        // Custom theme
        $.validator.setTheme('bootstrap', {
            validClass: 'has-success',
            invalidClass: 'has-error',
            bindClassTo: '.form-group',
            formClass: 'n-default n-bootstrap',
            // msgClass: 'n-right'
            msgClass: 'n-bottom'
        });
    });
</script>

<!-- Bootstrap -->
<script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/src/main/webapp/resources/js/common.js">  </script>

<div id="loader" class="loader v-center-middle" style="display: none">
</div>

<div class="wrapper">

    <div class="fl-screenNavigator-view">
        <div id="app-name" class="flc-screenNavigator-navbar fl-navbar fl-table fl-table-cell">
            <div class="row">
                <h1 class="col-sm-8 col-lg-10 title">
                    UPI Merchant
                </h1>
                <div class="col-sm-4 col-lg-2 logo">
                    <img class="" src="${pageContext.request.contextPath}/src/main/webapp/resources/img/upi-logo.png">
                </div>
            </div>
        </div>

        <%--col-md-8 col-md-offset-2--%>
        <div id="content" class="fl-screenNavigator-scroll-container col-sm-10 col-md-8 col-lg-6">
            <%--<div class="">--%>
            <%--</div>--%>
            <div class="panel panel-info ">
                <div class="panel-heading panel-title">
                    <c:if test="${empty title}">
                        <c:set var="title" value="Login" scope="request"/>
                    </c:if>

                    <title>${title}</title>
                </div>

                <!-- Main content -->
                <section class="content panel-body" style="">
                    <c:if test="${empty viewPage}">
                        <c:set var="viewPage" value="loginModal.jsp" scope="request"/>
                    </c:if>

                    <jsp:include page="${viewPage}"></jsp:include>
                </section>
                <!-- /.content -->
            </div>
        </div>
    </div>

</div>
<!-- ./wrapper -->

<!-- 模态框（Modal） -->
<div class="modal fade" id="popupNotifyModel" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header" style="text-align: left; color: black;">
                <button type="button" class="close"
                        aria-hidden="true">&times;</button>
                <h4 class="modal-title">Alert</h4>
            </div>
            <div class="modal-body" style="text-align: left; color: black;"></div>
            <div class="modal-footer">
                <button type="button" class="btn popup-confirm">OK</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<div id="poupPanelModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <h3 class="modal-title"> </h3>
            <div class="modal-body" style="text-align: left; color: black;">
            </div>

            <div class="modal-footer">
                <button type="button" class="btn popup-confirm btn-success">OK</button>
            </div>
        </div>
    </div>
</div>

<div id="footer" class="">
    <p>
        <strong>
            Copyright &nbsp;<a href="https://www.unionpayintl.com">&copy; UnionPay International Co., Ltd.</a>
        </strong>
        &nbsp;&nbsp;©<span id="thisYearInFooter" class="this-year"></span>&nbsp;&nbsp;All rights reserved.
    </p>
</div>

<div id="cookie">
    <%--tip user to enable cookie--%>
    <div class="cc_banner-wrapper cookie-not-enable" style="display: none">
        <div class="cc_banner cc_container cc_container--open">
            <%--<a href="javascript:void(0)" data-cc-event="click:dismiss" target="_blank" class="cc_btn cc_btn_accept_all">Got it!</a>--%>
            <p class="cc_message">This website uses cookies to ensure work properly, please enable cookies in your web browser
                <a data-cc-if="options.link" target="_self" class="cc_more_info" href="https://knowledgebase.constantcontact.com/articles/KnowledgeBase/5908-enable-cookies-in-your-web-browser?lang=en_US">How to enable?</a>
            </p>
        </div>
    </div>

    <%--https://www.seasongroup.com/cookies-policy/--%>
    <div class="cc_banner-wrapper cookie-law" style="display: none">
        <div class="cc_banner cc_container cc_container--open">
            <a href="javascript:void(0)" data-cc-event="click:dismiss" target="_blank" class="cc_btn cc_btn_accept_all">Got it!</a>
            <p class="cc_message">This website uses cookies to ensure you get the best experience on our website
                <a data-cc-if="options.link" target="_self" class="cc_more_info" href="${pageContext.request.contextPath}/src/main/webapp/resources/html/cookies-policy.html">More info</a>
            </p>
            <%--<a class="cc_logo" target="_blank" href="http://silktide.com/cookieconsent">Cookie Consent plugin for the EU cookie law</a>--%>
        </div>
    </div>
</div>



<script type="text/javascript">
    $(document).ready(function () {
        var common = UP.Common,
            $cookie = $('#cookie')
        ;

        if(common.areCookiesEnabled()) {
            cookieLawHandler();
        }
        else {
            // show cookie enable tips;
            $cookie.find('div.cookie-not-enable').show();
        }

        $('#thisYearInFooter').html(new Date().getFullYear());

        function cookieLawHandler() {
            var $ccBannerWrapper = $cookie.find('div.cookie-law'),
                cookieLSItem = 'cookie_law_accepted';

            $ccBannerWrapper.find('a.cc_btn_accept_all').on('click', function (e) {
                // e.preventDefault();
                // user accepts cookie usage.
                //$ccBannerWrapper.addClass('dismiss'); //.hide();
                $ccBannerWrapper.fadeOut( "slow");
                window.localStorage.setItem(cookieLSItem, '1');
            });

            // user accepts cookie usage.
            // $ccBannerWrapper.on('click:dismiss', function () {
            //     window.localStorage.setItem(cookieLSItem, '1');
            // });

            if(window.localStorage.getItem(cookieLSItem) !== '1') {
                // not accept it, show the notify
                $ccBannerWrapper.show();
            }
        }

        adjustFooterLayoutIfNeeded();

        // footer
        function adjustFooterLayoutIfNeeded() {
            // $wrapper =
            var $footer = $('#footer'),
                $conent = $('div#content'),
                contentBottom = $conent[0].offsetTop + $conent[0].offsetHeight,
                footerTop = $footer[0].offsetTop;

            console.log(contentBottom + " => " + footerTop);

            // if((contentBottom + 20 >= footerTop) && ($('#content').css('position') !== 'absolute')) {
            //     console.log('exceed. adjustFooterLayoutIfNeeded');
            //     $footer.css('position', 'relative');
            //     $footer.css('margin-top', '50px');
            // }

            if(contentBottom + 20 >= footerTop) {
                if($('#content').css('position') === 'absolute') {
                    $footer.css('bottom', '0');
                }
                else {
                    console.log('exceed. adjustFooterLayoutIfNeeded');
                    $footer.css('position', 'relative');
                    $footer.css('margin-top', '50px');
                }
            }

        }

    });
</script>

<script type="text/javascript" src="${pageContext.request.contextPath}/plugins/jsencrypt-3.0.0-rc.1/jsencrypt.min.js"></script>

</body>

</html>