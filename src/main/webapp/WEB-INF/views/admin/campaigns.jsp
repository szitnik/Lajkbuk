<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>


<c:url value="/admin/addCampaign" var="addCampaign" />
<c:url value="/" var="home" />
<c:url value="/admin/campaigns" var="campaigns" />
<c:url value="/admin/customers" var="customers" />
<c:url value="/admin/other" var="other" />

<html>
<head>
    <meta http-equiv="content-type" content="application/xhtml+xml; charset=UTF-8" />
    <title>..:: Admin - Lajkbuk.si Campaigns ::..</title>
    <style type="text/css">
        html, body, div, span, applet, object, iframe, h1, h2, h3, h4, h5, h6, p, blockquote, pre, a, abbr, acronym, address, big, cite, code, del, dfn, em, font, img, ins, kbd, q, s, samp, small, strike, strong, sub, sup, tt, var, b, u, i, center, dl, dt, dd, ol, ul, li, fieldset, form, label, legend, table, caption, tbody, tfoot, thead, tr, th, td, input {
            font-size: 100%;
        }
        body {
            font-family: sans-serif;
            font-size:12px;
        }
        .data, .data td {
            border-collapse: collapse;
            width: 550px;
            border: 1px solid #aaa;
            padding: 2px;
        }
        .data th {
            background-color: #7CFC00;
            color: black;
            font-weight: bold;
        }
        h1, h2, h3 {
            font-family: Trebuchet MS,Liberation Sans,DejaVu Sans,sans-serif;
            font-weight: bold;
        }
        h1 {
            font-size: 170%;
        }
        h2 {
            font-size: 140%;
        }
        h3 {
            font-size: 120%;
        }

    </style>
</head>
<body bgcolor="#DCDCDC">

<h2><font color="red">Campaigns Editor</font></h2>
<a href="${home}">Home</a> | <a href="${campaigns}">Campaigns Editor</a> | <a href="${customers}">Customers Editor</a> | <a href="${other}">Other</a>
<hr>
<h3>Add a New Campaign</h3>
<c:if  test="${!empty customerList}">
<form:form method="post" action="${addCampaign}" commandName="campaign" enctype="multipart/form-data">
    <form:errors path="*" cssClass="error"/>
    <table border="1" bordercolor="lime">

        <tr>
            <td><form:label path="id">Id</form:label></td>
            <td><form:input path="id" readonly="true" /></td>
        </tr>
        <tr>
            <td><form:label path="title">Title</form:label></td>
            <td><form:input path="title" /></td>
        </tr>
        <tr>
            <td><form:label path="description">Description</form:label></td>
            <td><form:textarea path="description" /></td>
        </tr>
        <tr>
            <td><form:label path="facebookAppLink">Facebook App Link</form:label></td>
            <td><form:input path="facebookAppLink" /></td>
        </tr>
        <tr>
            <td><form:label path="facebookAppKey">Facebook App Key</form:label></td>
            <td><form:input path="facebookAppKey" /></td>
        </tr>
        <tr>
            <td><form:label path="facebookAppSecret">Facebook App Secret</form:label></td>
            <td><form:input path="facebookAppSecret" /></td>
        </tr>
        <tr>
            <td><form:label path="likeLink">Like link</form:label></td>
            <td><form:input path="likeLink" /></td>
        </tr>
        <tr>
            <td><form:label path="active">Activated</form:label></td>
            <td><form:checkbox path="active" /></td>
        </tr>
        <tr>
            <td><form:label path="targetLikes">Target likes</form:label></td>
            <td><form:input path="targetLikes" /></td>
        </tr>
        <tr>
            <td><form:label path="numOfWinners">Number of winners</form:label></td>
            <td><form:input path="numOfWinners" /></td>
        </tr>
        <tr>
            <td><form:label path="bigImage">Big Image (JPG, PNG, ...), wxh=480x480</form:label></td>
            <td><input type="file" name="bigImage" id="bigImage" /></td>
        </tr>
        <tr>
            <td><form:label path="smallImage">Small Image (JPG, PNG, ...), wxh=290x480</form:label></td>
            <td><input type="file" name="smallImage" id="smallImage" /></td>
        </tr>
        <tr>
            <td><form:label path="terms">Terms (PDF)</form:label></td>
            <td><input type="file" name="terms" id="terms" /></td>
        </tr>
        <tr>
            <td><form:label path="enabledFeatures">Features</form:label></td>
            <td>
                <form:checkbox path="enabledFeatures" value="SHARE" /> SHARE<br />
                <form:checkbox path="enabledFeatures" value="COUPON" /> COUPON<br />
                <form:checkbox path="enabledFeatures" value="COMMENT" /> COMMENT<br />
            </td>
        </tr>
        <tr>
            <td><form:label path="customer">Customer</form:label></td>
            <td>
                <c:if  test="${!empty customerList}">
                    <form:select id="customer" name="customer" path="customer">
                        <c:forEach var="customer" items="${customerList}">
                            <form:option value="${customer.id}"> <c:out value="${customer.id} - ${customer.name}"/></form:option>
                        </c:forEach>
                    </form:select>
                </c:if>
            </td>
        </tr>

        <tr>
            <td colspan="2">
                <input type="submit" value="Submit a Campaign"/>
            </td>
        </tr>
    </table>
</form:form>
</c:if>
<c:if  test="${empty customerList}">
    Please populate some customers first!
</c:if>
<br/>
<hr>
<h3>All Campaigns</h3>

<c:if  test="${!empty campaignList}">
    <table class="data">
        <tr>
            <th>CustomerId</th>
            <th>Id</th>
            <th>Title</th>
            <th>FB App Link</th>
            <th>FB App Key</th>
            <th>FB App Secret</th>
            <th>Description</th>
            <th>Big Image</th>
            <th>Small Image</th>
            <th>Terms</th>
            <th>Active</th>
            <th>Like link</th>
            <th>Current likes</th>
            <th>Target likes</th>
            <th>Number of winners</th>
            <th>Date added</th>
            <th>Date finished</th>
            <th>Features</th>
            <th>Commands</th>
        </tr>
        <c:forEach items="${campaignList}" var="campaign">
            <tr>
                <td>${campaign.customer.id}</td>
                <td>${campaign.id}</td>
                <td>${campaign.title}</td>
                <td>${campaign.facebookAppLink}</td>
                <td>${campaign.facebookAppKey}</td>
                <td>${campaign.facebookAppSecret}</td>
                <td>${campaign.description}</td>
                <td><img src="<c:url value="/bigImage/" />${campaign.id}" width="300px"></td>
                <td><img src="<c:url value="/smallImage/" />${campaign.id}" width="200px"></td>
                <td><a href="<c:url value="/terms/" />${campaign.id}">Terms</a></td>
                <td>${campaign.active}</td>
                <td>${campaign.likeLink}</td>
                <td>${campaign.currentLikes}</td>
                <td>${campaign.targetLikes}</td>
                <td>${campaign.numOfWinners}</td>
                <td>${campaign.dateAdded}</td>
                <td>${campaign.dateFinished}</td>
                <td>${campaign.enabledFeatures}</td>

                <td>
                    <a href="<c:url value="/admin/campaigns/edit/" />${campaign.id}"> Edit </a><br/>

                    <a href="<c:url value="/admin/campaigns/preview/" />${campaign.id}"> Predogled - domača stran </a><br/>
                    <a href="<c:url value="/campaign/" />${campaign.id}"> Predogled - Tab page </a><br/>

                    <a href="<c:url value="/admin/campaigns/activate/" />${campaign.id}"> Aktiviraj </a><br/>
                    <a href="<c:url value="/admin/campaigns/deactivate/" />${campaign.id}"> Deaktiviraj </a><br/>
                    <a href="<c:url value="/admin/campaigns/finish/${campaign.id}/OK" />"> Zaključi OK</a><br/>
                    <a href="<c:url value="/admin/campaigns/finish/${campaign.id}/NECASTNO" />"> Zaključi NECASTNO</a><br/>
                    <a href="<c:url value="/admin/campaigns/finish/${campaign.id}/PREDCASNO" />"> Zaključi PREDCASNO</a><br/>

                    <a href="<c:url value="/admin/removeCampaign/" />${campaign.id}"
                       onclick="return confirm('Are you sure you want to delete this campaign?')"><img
                            src="<c:url value="/resources/images/delete.gif" />" border="0"
                            title="Delete this campaign"/></a><br />
                    Lajkbuk.si link: https://lajkbuk.si/campaign/${campaign.id}/<br />
                </td>
            </tr>
        </c:forEach>
    </table>
</c:if>
<br/>
<hr>
</body>
</html>
