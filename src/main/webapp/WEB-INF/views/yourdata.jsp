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
    <h1>Vaši podatki</h1>
    <br /><br /><br />
    Podatki, ki jih pridobimo z vašega Facebook profila ob prvi prijavi v našo aplikacijo Lajkbuk.si se hranijo v dobro zaščiteni oblačni storitvi. Do podatkov lahko dostopajo le pooblaščene osebe, ki imajo za to ustrezno geslo. To so osebe povezane s Portalom Lajkbuk.si, ki so podpisale izjavo o varovanju osebnih podatkov.
    <br /><br />
    Z vsemi podatki ravnamo v okviru Zakona o varovanju osebnih podatkov (ZVOP-1).
    <br /><br />
    Podatke z vašim privoljenjem lahko posredujemo naročniku, oziroma organizatorju nagradne igre, to potrdite s klikom na gumb “Strinjam se” ko sodelujete v katerikoli izmed nagradnih iger.
    <br /><br />
    Podatke naročnikom posredujemo preko medija, ki je enkriptiran (zaščiten z geslom).
    <br /><br />
    Vsak naročnik podpiše izjavo o varovanju osebnih podatkov.
    <br /><br />
    Sodelujoči v nagradni igri lahko od upravljavca Portala Lajkbuk.si kadarkoli zahteva vpogled, prepis, dopolnitev, popravek, blokiranje ali izbris svojih osebnih podatkov, skladno z veljavnim zakonom, in sicer po elektronski pošti <a href="mailto:podatki@lajkbuk.si">podatki@lajkbuk.si</a>.
    <br /><br />
    Sodelujoči lahko prav tako kadarkoli zahteva, da upravljavec v 15 dneh, trajno ali začasno, preneha uporabljati njegove osebne podatke za namen neposrednega trženja, in sicer po elektronski pošti <a href="mailto:preklic@lajkbuk.si">preklic@lajkbuk.si</a>.
    <br /><br />
    Sodelujoči v nagradnih igrah se strinja in izrecno dovoljuje, da je v primeru, če bo nagrajen, njegovo ime in priimek lahko objavljeno na Facebook strani organizatorja posamezne nagradne igre in Facebook strani upravljavca ter na samem portalu <a href="https://lajkbuk.si">lajkbuk.si</a>. Podatki bodo objavljeni do preklica, ki ga sodelujoči lahko zahteva po elektronski pošti <a href="mailto:preklic@lajkbuk.si">preklic@lajkbuk.si</a>.
    <br /><br />
    Portal Lajkbuk.si je namenjen varnosti izvedb nagradnih iger, zato so vaši podatki pri nas varni!
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