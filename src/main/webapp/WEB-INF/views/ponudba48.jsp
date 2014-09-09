<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>


<c:url value="/resources/css/style.css" var="css" />


<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>..:: Lajkbuk.si ::..</title>
    <script src="<c:url value="/resources/jquery/jquery-1.9.1.min.js" />"></script>
    <script src="<c:url value="/resources/js/spin.js" />"></script>
    <link rel="stylesheet" href="${css}" type="text/css">
    <link rel="shortcut icon" href="/resources/images/favicon.ico" />
</head>
<body>
<div id="header">
    <div>
        <div class="logo">
            <a href="<c:url value="/" />">&nbsp;</a>
        </div>

        <c:if test="${isAuthenticated}">
        <ul id="navigation" style="margin-left: -80px; position: absolute;">
            </c:if>
            <c:if test="${!isAuthenticated}">
            <ul id="navigation">
                </c:if>
                <li <c:if test="${pageName == 'home'}">class="active"</c:if> style="margin-top: 80px;">
                    <a href="<c:url value="/" />">Domov</a>
                </li>
                <li class="sep" style="margin-top: 80px;"></li>
                <li <c:if test="${pageName == 'about'}">class="active"</c:if> style="margin-top: 80px;">
                    <a href="<c:url value="/about" />">O Lajkbuk.si</a>
                </li>
                <li class="sep" style="margin-top: 80px;"></li>
                <li <c:if test="${pageName == 'yourdata'}">class="active"</c:if> style="margin-top: 80px;">
                    <a href="<c:url value="/yourdata" />">Vaši podatki</a>
                </li>
                <li class="sep" style="margin-top: 80px;"></li>
                <li <c:if test="${pageName == 'howitworks'}">class="active"</c:if> style="margin-top: 80px;">
                    <a href="<c:url value="/howitworks" />">Kako deluje</a>
                </li>
                <c:if test="${isAuthenticated}">
                    <li class="sep" style="margin-top: 80px;"></li>
                    <li <c:if test="${pageName == 'my'}">class="active"</c:if> style="margin-top: 80px;">
                        <a href="<c:url value="/myCampaigns" />">Moje nagradne igre</a>
                    </li>
                </c:if>
                <li class="sep" style="margin-top: 80px;"></li>
                <li <c:if test="${pageName == 'old'}">class="active"</c:if> style="margin-top: 80px;">
                    <a href="<c:url value="/finishedCampaigns" />">Pretekle nagradne igre</a>
                </li>

                <c:if test="${isAuthenticated}">
                    <li class="sep" style="margin-top: 80px;"></li>
                    <li style="margin-top: 80px;">
                        <a href="<c:url value="/signout" />">Odjava</a>
                    </li>
                    <li style="padding-left: 7px;">
                        <img src="<c:url value="/myProfileImage" />" class="img_header">
                    </li>
                </c:if>
                <c:if test="${!isAuthenticated}">
                    <li style="padding-left: 7px; margin-top: 80px;">
                        <form action="<c:url value="/signin/facebook" />" method="POST">
                            <input type="hidden" name="scope" value="email,read_friendlists,user_about_me,user_birthday,user_likes" />
                            <input type="image" src="<c:url value="/resources/images/fblogin.png" />" />
                        </form>
                    </li>
                </c:if>
            </ul>
    </div>
</div>
<div id="subheader"></div>
<div id="contents">
    <a class="mcnButton" title="Prijavi se tukaj" href="http://eepurl.com/NgXrz" target="_blank" style="margin-left: 500px; background-color: #4ade50;   -moz-border-radius: 15px;   -webkit-border-radius: 10px;   /* border: 5px solid #009900; */   padding: 10px;/* padding-bottom: 50px; */font-weight: bold;letter-spacing: -0.5px;line-height: 100%;text-align: center;text-decoration: none;color: #000000;word-wrap: break-word;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;">Prijavi se tukaj</a>
    <center>
        <img src="<c:url value="/resources/files/ponudba48.jpg" />" style="margin-left: 50px; margin-top: 30px;" />
    </center>
</div>
<div id="footer">
    <div>
        <ul class="navigation_footer">
            <li>
                <a href="<c:url value="/resources/files/Lajkbuk.si_PravilaInPogoji.pdf" />" target="_blank">Pravila in pogoji uporabe</a>
            </li>
            <li>
                <a href="<c:url value="/resources/files/Lajkbuk.si_PolitikaZasebnosti.pdf" />" target="_blank">Politika zasebnosti</a>
            </li>
            <li>
                <a href="<c:url value="/about" />">O nas</a>
            </li>
            <li>
                Za splošne informacije pišite na <a href="mailto:info@lajkbuk.si">info@lajkbuk.si</a>
            </li>
            <li>
                V primeru tehnične napake pišite na <a href="mailto:support@lajkbuk.si">support@lajkbuk.si</a>
            </li>
            <li>
                Za povpraševanje pišite na <a href="mailto:povprasevanje@lajkbuk.si">povprasevanje@lajkbuk.si</a>
            </li>
            <li>
                <a>© 2013 Lajkbuk.si. Vse pravice pridržane.</a>
            </li>
        </ul>

    </div>
    <div>
        <div id="connect">
            <a href="https://www.facebook.com/pages/Likebook/412974628764670" target="_blank" class="facebook"></a>
            <div class="fb-like" data-href="https://www.facebook.com/pages/Likebook/412974628764670" data-send="false" data-width="200" data-show-faces="false"></div>
        </div>
    </div>
</div>

</body>
</html>