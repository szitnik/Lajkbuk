<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:url value="/admin/addCustomer" var="addCustomer" />

<c:url value="/" var="home" />
<c:url value="/admin/campaigns" var="campaigns" />
<c:url value="/admin/customers" var="customers" />
<c:url value="/admin/other" var="other" />


<html>
<head>
    <title>..:: Admin - Lajkbuk.si Other ::..</title>
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

<h2><font color="red">Customers Editor</font></h2>
<a href="${home}">Home</a> | <a href="${campaigns}">Campaigns Editor</a> | <a href="${customers}">Customers Editor</a> | <a href="${other}">Other</a>
<hr>
<h3>Retrieve additional data for a user</h3>
<a href="<c:url value="/admin/processUsers" />"> Process a user </a><br/>
<br/>
<hr>
</body>
</html>
