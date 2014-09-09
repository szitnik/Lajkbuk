<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<c:url value="/resources/css/style.css" var="css" />
<spring:eval expression="T(si.zitnik.likebook.util.SignInUtils).getCurrentUserFbId()" var="fbUserId" />


<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>..:: Lajkbuk.si ::..</title>
    <script src="<c:url value="/resources/jquery/jquery-1.9.1.min.js" />"></script>
    <link rel="stylesheet" href="${css}" type="text/css">
    <link rel="shortcut icon" href="/resources/images/favicon.ico" />
</head>
<body>
<div id="fb-root"></div>
<script>
    window.fbAsyncInit = function() {
        FB.init({
            appId      : '208956702576053',
            status     : true,
            xfbml      : true
        });
    };

    (function(d, s, id){
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) {return;}
        js = d.createElement(s); js.id = id;
        js.src = "//connect.facebook.net/en_US/all.js";
        fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));
</script>
<script>
    function shareNagradnaIgra() {
    FB.ui(
            {
                method: 'feed',
                name: '${campaign.title}',
                caption: 'Nagradna igra',
                description: ('Na portalu lajkbuk.si objavljamo najnovejše nagradne igre. Sodelujte tudi vi!'),
                link: '${campaign.likeLink}',
                picture: '<c:url value="https://lajkbuk.si/bigImage/${campaign.id}" />'
            },
            function(response) {
                if (response && response.post_id) {
                    $.post('https://lajkbuk.si/campaign/share/${campaign.id}/${fbUserId}');
                    alert('Uspešno ste delili nagradno igro.');
                } else {
                    alert('Nagradne igre niste delili dalje.');
                }
            }
    );
    }
</script>



<div id="header" style="width: 810px;">
    <div>
        <div class="logo">
            <a href="<c:url value="/" />" target="_top">&nbsp;</a>
        </div>
        <c:if test="${isAuthenticated}">
            <c:if test="${!hasLiked}">
                <div class="lajkajtu"></div>
            </c:if>
        </c:if>
    </div>
</div>
<div id="subheader" style="width: 810px;"></div>

<div id="contents" style="width: 810px; min-height: 200px; margin: 0;">
    <c:if test="${isAuthenticated}">
        <c:if test="${hasLiked}">
            <div class="lajkajNext"></div>
        </c:if>
    </c:if>

<c:if test="${!isAuthenticated}">
    <form style="text-align: center; vertical-align: middle; margin-top: 100px; margin-bottom: 20px;">
        <input type="image" src="<c:url value="/resources/images/fblogin.png" />"
               onclick="showModalDialog('https://lajkbuk.si/signinfbTab', self); location.reload();" />
    </form>
    <div style="text-align: center; margin-left: -180px;">
        <img src="/resources/images/prijavitukaj.png" alt="Prijavi se tukaj">
    </div>
</c:if>
<c:if test="${isAuthenticated}">
    <div class="kampanja">

        <c:if test="${campaign.finished}">
            <a href="<c:url value="/finishDocument/" />${campaign.id}">
                <div style="top: 20px; left: 250px; width: 411px; height: 392px; z-index: 3; background-image: url(<c:url value="/resources/images/end${campaign.finishType}.png" />); position: absolute;"></div>
            </a>
        </c:if>

        <div class="kampanja_left"  <c:if test="${campaign.finished}">style="opacity: 0.5;width: 310px;"</c:if>
             <c:if test="${!campaign.finished}">style="width: 310px;"</c:if>>
            <img src="<c:url value="/smallImage/${campaign.id}" />" class="img_campaign" style="width: 290px;">
        </div>

        <div class="kampanja_right"<c:if test="${campaign.finished}">style="opacity: 0.5;margin-left: 317px;"</c:if>
             <c:if test="${!campaign.finished}">style="margin-left: 317px;"</c:if>>
            <h1>${campaign.title}</h1>
            <div class="kampanja_right_hr"></div>
            <div class="kampanja_text">${campaign.description}</div>
            <div class="kampanja_right_hr"></div>
            <div class="organizer_info">
                Nagradno igro organizira <b>${campaign.customer.name}</b>, ${campaign.customer.address}, e-naslov: ${campaign.customer.email}.
            </div>
            <div class="bar">
                <div class="bar_header"></div>
                <div class="bar_empty"></div>
                <div class="bar_full" style="width: ${campaign.currentLikes*400/campaign.targetLikes}px;"></div>
            </div>
            <div class="kampanja_status">
                <div class="kampanja_status_first"><b>${campaign.currentLikes}</b> trenutno</div>
                <div class="kampanja_status_2nd"><b><fmt:formatNumber value="${campaign.currentLikes*100.0/campaign.targetLikes}" maxFractionDigits="1"/></b>%</div>
                <div class="kampanja_status_3rd"><b>${campaign.targetLikes}</b> cilj</div>
            </div>

            <c:if test="${isAuthenticated}">
                <c:if test="${hasLiked}">
                    <div style="text-align: center;">
                        <img src="/resources/images/uspesno.png" />
                    </div>
                    <c:if test="${fn:contains(campaign.enabledFeatures, 'COUPON')}">
                        <div class="kampanja_coupon">
                            Vaša koda je <div style="display: inline; font-weight: bold;" id="couponDiv${campaign.id}"></div>.
                        </div>
                        <script type="text/javascript">
                            jQuery(function($){
                                $('#couponDiv${campaign.id}').load('<c:url value="/campaign/coupon/${campaign.id}" />');
                            });
                        </script>
                    </c:if>
                </c:if>
                <c:if test="${!campaign.finished}">
                <c:if test="${!hasLiked}">
                    <div class="kampanja_right_hr"></div>
                    <div class="kampanja_terms">
                        S klikom na zgornji gumb Like se strinjam s <a href="<c:url value="/terms/" />${campaign.id}" target="_blank">pogoji in pravili</a> nagradne igre.
                        Vsi podatki, ki ste jih delili z aplikacijo, so lahko posredovani podjetju ${campaign.customer.name}.
                    </div>
                </c:if>

                <c:if test="${fn:contains(campaign.enabledFeatures, 'SHARE')}">
                    <div style="text-align: right; margin-left: 350px; width: 50px; height: 18px; background: url('/resources/images/fb_share.jpg'); cursor: pointer;" onclick="shareNagradnaIgra();"></div>
                </c:if>

                <c:if test="${fn:contains(campaign.enabledFeatures, 'COMMENT')}">
                    <div style="text-align: center; margin-left: 10px; margin-top: 10px;" class="fb-comments" data-href="https://lajkbuk.si/campaign/${campaign.id}" data-width="470" data-numposts="5" data-colorscheme="light"></div>
                </c:if>
                </c:if>
            </c:if>
        </div>
    </div>
    <div class="kampanja_hr" style="width: 810px;"></div>
</c:if>

</div>


<div id="footer" style="width: 810px;">
    <div>
        <ul class="navigation_footer">
            <li>
                <a href="<c:url value="/resources/files/Lajkbuk.si_PravilaInPogoji.pdf" />" target="_blank">Pravila in pogoji uporabe</a>
            </li>
            <li>
                <a href="<c:url value="/resources/files/Lajkbuk.si_PolitikaZasebnosti.pdf" />" target="_blank">Politika zasebnosti</a>
            </li>
            <li>
                <a href="<c:url value="/about" />" target="_top">O nas</a>
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
</div>

</body>
</html>