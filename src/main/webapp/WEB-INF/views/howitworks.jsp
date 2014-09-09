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
    <h1>Kako deluje</h1>
    <br /><br /><br />
    Portal Lajkbuk.si je spletno mesto, kjer je zbranih večje število aktualnih nagradnih iger, ki potekajo na družbenem omrežju Facebook. Portal služi večji in hitrejši preglednosti nad nagradnimi igrami, hkrati pa uporabniku omogoča varno in zanimivo izkušnjo. Nič več spletnih prevar.
    <br /><br />
    Upravljavec Portala Lajkbuk.si podjetjem oziroma našim naročnikom v Beta različici portala ponujamo izdelavo nagradne igre standardnega formata ter objavo te na sam portal ter Facebook stran naročnika oziroma organizatorja nagradne igre.
    <br /><br />
    Upravljavec Portala Lajkbuk.si skrbi za tekoče in varno delovanje nagradnih iger ter pošteno naključno izbere nagrajence v nagradni igri.
    <br /><br />
    Upravljavec Portala Lajkbuk.si organizatorju nagradne igre posreduje podatke nagrajencev, ta pa nato nagrade podeli (po dogovoru med nagrajencem in organizatorjem nagradne igre ali glede na Pravila in pogoje posamezne nagradne igre).
    <br /><br />
    Za podelitev nagrad je odgovoren organizator nagradne igre!
    <br /><br />
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