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
    <h1>O Lajkbuk.si</h1>
    <br /><br /><br />
    Družbeno omrežje Facebook je v zadnjih letih tudi pri nas postalo močno orodje za povečanje prepoznavnosti blagovne znamke, tega pa se zavedajo le tisti, ki so v koraku s časom. Čedalje več slovenskih podjetij Facebook uporablja v oglaševalne namene, saj lahko v hitrem času dosežemo veliko potencialnih kupcev po nizki ceni.
    <br /><br />
    <b style="color: #4F8A10">Dejstvo #1:</b> Potreba po Facebook nagradnih igrah se iz dneva v dan povečuje, saj je to ena izmed najbolj učinkovitih metod zbiranja oboževalcev na Facebook strani.
    <br /><br />
    <b style="color: #4F8A10">Dejstvo #2:</b> V Sloveniji je približno 71% Facebook strani izdelanih v korporativne namene, takih pa je v Sloveniji okoli 2.200 (Vir: http://analitika.sociallab.si).
    <br /><br />
    <b style="color: #4F8A10">Dejstvo #3:</b> Facebook nagradne igre je na Facebooku zelo težko poiskati.
    <br /><br />
    Lajkbuk.si je spletni portal Facebook nagradnih iger. To pomeni, da so aktualne nagradne igre objavljene na istem spletnem mestu, kjer so uporabnikom za pregledovanje in sodelovanje na voljo kadarkoli.
    <br /><br />
    Smo mlad, razgiban kolektiv z različnimi izkušnjami in imamo željo po ustvarjanju in željo po uspehu. Zato bomo v testni različici Lajkbuk.si BETA, svoje storitve ponudili z zelo ugodnimi pogoji poslovanja.
    <br /><br />
    <b style="color: #4F8A10">
    Vizija: V beta različici portala lajkbuk.si, si želimo vzpostaviti stik s čimvečjim številom naročnikov, ki potrebujejo naše storitve, pri tem pa pridobiti tudi čimveč rednih uporabnikov.
    <br /><br />
    Poslanstvo: Dosegati pričakovanja naših naročnikov ter naših uporabnikov, storitve izvajati profesionalno in učinkovito ter konstantno uvajati novosti.
    </b>
    <br /><br /><br /><br />
    Lep pozdrav, <br />
    Vaša Lajkbuk.si ekipa!
    <br /><br /><br />
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