<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>


<c:url value="/resources/css/style.css" var="css" />


<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="google-site-verification" content="-YJaU1afqD1sZLEStP9upcRozim-ElT3-dOxc3sHH-4" />
    <meta name="keywords" content="nagradna igra,nagradne igre,facebook,všečkanje,všečki,lajki,lajkanje,nagradna igra,nagradne igre,igra,igre,igraj in zadeni,zadeni,igraj,nagrada,nagrade,facebook nagradne igre,facebook nagradna igra,fb nagradna igra,fb nagradne igre,facebook,fb,tab page,zavihek,facebook aplikacija,facebook app,aplikacija,app,aplikacija nagradne igre,poceni nagradna igra,poceni nagradne igre,poceni,ugodne nagradne igre,ugodna nagradna igra,ugodno,ugodne,ugodna,brezplačna nagradna igra,brezplačne nagradne igre,brezplačno,brezplačna,napredna nagradna igra,napredne nagradne igre,facebook napredna nagradna igra,facebook napredne nagradne igre,napredno,napredna,nagradna igra po meri,nagradne igre po meri,facebook nagradna igra po meri,facebook nagradne igre po meri,izdelava aplikacij,izdelava nagradne igre ,izdalava nagradnih iger,izdelava napredne nagradne igre,izdelava naprednih nagradnih iger,izdelava nagradne igre po meri,izdelava nagradnih iger po meri,izdelava facebook aplikacije,izdelava facebook aplikacij,sodeluj in zadeni,sodeluj,nizka cena ,nizkocenovne nagradne igre,nizkocenovna nagradna igra,portal nagradnih iger,portal facebook nagradnih iger,nagradne igre na facebooku,nagradna igra na facebooku,iskalnik nagradnih iger,iskalnik nagradne igre,iskalnih nagradnih iger na facebooku,iskalnik nagradne igre na facebooku" />

    <meta property="og:title" content="Lajkbuk.si" />
    <meta property="og:type" content="website" />
    <meta property="og:image" content="https://lajkbuk.si/resources/images/logo.png" />
    <meta property="og:url" content="https://lajkbuk.si" />
    <meta property="og:description" content="Portal Lajkbuk.si je spletno mesto, kjer je zbranih večje število aktualnih nagradnih iger, ki potekajo na družbenem omrežju Facebook. Portal služi večji in hitrejši preglednosti nad nagradnimi igrami, hkrati pa uporabniku omogoča varno in zanimivo izkušnjo. Nič več spletnih prevar.

Upravljavec Portala Lajkbuk.si podjetjem oziroma našim naročnikom v Beta različici portala ponujamo brezplačno izdelavo nagradne igre standardnega formata ter objavo te na sam portal ter Facebook stran naročnika oziroma organizatorja nagradne igre.

Upravljavec Portala Lajkbuk.si skrbi za tekoče in varno delovanje nagradnih iger ter pošteno naključno izbere nagrajence v nagradni igri.

Upravljavec Portala Lajkbuk.si organizatorju nagradne igre posreduje podatke nagrajencev, ta pa nato nagrade podeli (po dogovoru med nagrajencem in organizatorjem nagradne igre ali glede na Pravila in pogoje posamezne nagradne igre).

Za podelitev nagrad je odgovoren organizator nagradne igre!" />
    <meta property="og:site_name" content="Lajkbuk.si Nagradne igre" />
    <meta property="fb:app_id" content="208956702576053" />

	<title>..:: Lajkbuk.si ::..</title>
    <script src="<c:url value="/resources/jquery/jquery-1.9.1.min.js" />"></script>
    <!-- <script src="c:url value="/resources/js/spin.js" />"></script>-->

	<link rel="stylesheet" href="${css}" type="text/css">
    <link rel="shortcut icon" href="/resources/images/favicon.ico" />
</head>
<body>
<script>

    /*
    function showHide(id, visibility) {
        if (visibility) {
            $("#"+id).css('height', '25px');
            $("#"+id).css('display', 'inline');
        } else {
            $("#"+id).css('height', '0px');
            $("#"+id).css('display', 'none');
        }
    }*/

    if (document.images) {
        var pic1 = new Image();
        pic1.src = '<c:url value="/resources/images/sodeluj-pressed.png" />';
        var pic2 = new Image();
        pic2.src = '<c:url value="/resources/images/sodeluj-over.png" />';
    }


    function changeButton(id_lnk, id_chkbx) {
        if (document.getElementById(id_chkbx).checked) {
            document.getElementById(id_lnk).className = "strinjam"
        } else {
            document.getElementById(id_lnk).className = "sodeluj"
        }
    }

    function process(id_chkbx, newlink) {
        if (document.getElementById(id_chkbx).checked) {
            document.location = newlink;
        } else {
            alert("Prosimo, da pred sodelovanjem potrdite pogoje nagradne igre.");
        }
    }

    if (window.opener != null) {
        window.close();
    }
</script>


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
                    <img src="<c:url value="/myProfileImage" />" class="img_header" alt="Profilna slika" />
                </li>
                </c:if>
                <c:if test="${!isAuthenticated}">
                <li style="padding-left: 7px; margin-top: 80px;">
                        <form action="<c:url value="/signin/facebook" />" method="POST">
                            <input type="hidden" name="scope" value="email,read_friendlists,user_about_me,user_birthday,user_likes" />
                            <input type="image" src="<c:url value="/resources/images/fblogin.png" />" alt="Prijava" />
                        </form>
                </li>
                </c:if>
			</ul>
		</div>
	</div>
    <div id="subheader"></div>
	<div id="contents">
        <c:if  test="${!empty campaignList}">
                <c:forEach items="${campaignList}" var="campaign">
                    <div class="kampanja">

                        <c:if test="${pageName == 'old'}">
                            <a href="<c:url value="/finishDocument/" />${campaign.id}">
                                <div style="top: 20px; left: 250px; width: 411px; height: 392px; z-index: 3; background-image: url(<c:url value="/resources/images/end${campaign.finishType}.png" />); position: absolute;"></div>
                            </a>
                        </c:if>



                    <div class="kampanja_left" <c:if test="${pageName == 'old'}">style="opacity: 0.5;"</c:if>>
                        <img src="<c:url value="/bigImage/${campaign.id}" />" class="img_campaign" alt="Slika nagradne igre" />
                    </div>

                    <div class="kampanja_right" <c:if test="${pageName == 'old'}">style="opacity: 0.5;"</c:if>>

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
                            <div class="kampanja_right_hr"></div>
                            <div class="kampanja_terms">
                                <c:if test="${pageName == 'home'}">
                                    <input type="checkbox" id="sodeluj_${campaign.id}_checkbox" onclick="changeButton('sodeluj_${campaign.id}_btn', 'sodeluj_${campaign.id}_checkbox')" /> <!--onclick="showHide('sodeluj_{campaign.id}', checked);"-->
                                </c:if>
                                Strinjam se s <a href="<c:url value="/terms/" />${campaign.id}">pogoji in pravili</a> nagradne igre.
                                Vsi podatki, ki ste jih delili z aplikacijo, so lahko posredovani podjetju ${campaign.customer.name}.
                            </div>

                            <c:if test="${pageName == 'my'}">
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

                            <c:if test="${pageName == 'home'}">
                                <div class="fbgumbek" id="sodeluj_${campaign.id}" onclick="process('sodeluj_${campaign.id}_checkbox', '${campaign.facebookAppLink}');">
                                    <a id="sodeluj_${campaign.id}_btn" class="sodeluj"></a>
                                </div>
                            </c:if>
                        </c:if>
                        <c:if test="${!isAuthenticated}">
                            <div class="kampanja_right_hr"></div>


                            <c:if test="${pageName == 'home'}">
                                <div style="display: block;" class="fbgumbek"  onclick="alert('Za sodelovanje v nagradni igri morate biti prijavljeni! Prijavite se desno zgoraj.');">
                                    <a class="sodeluj"></a>
                                </div>
                            </c:if>
                        </c:if>
                    </div>
                    </div>
                    <div class="kampanja_hr"></div>
                </c:forEach>
        </c:if>
        <c:if  test="${empty campaignList}">
            <div class="kampanja">
                <h1>Nagradne igre</h1>
                <div>
                    <p>
                        Trenutno ni na voljo nobene nagradne igre.
                    </p>
                </div>
            </div>
        </c:if>
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