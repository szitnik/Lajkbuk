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
    <title>..:: Admin - Lajkbuk.si Customers ::..</title>
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
<h3>Add a New Customer</h3>
<form:form method="post" action="${addCustomer}" commandName="customer" enctype="multipart/form-data">
    <form:errors path="*" cssClass="error"/>
    <table border="1" bordercolor="lime">
        <tr>
            <td><form:label path="id">Id</form:label></td>
            <td><form:input path="id" readonly="true" /></td>
        </tr>
        <tr>
            <td><form:label path="name">Name</form:label></td>
            <td><form:input path="name" /></td>
        </tr>
        <tr>
            <td><form:label path="address">Address</form:label></td>
            <td><form:textarea path="address" /></td>
        </tr>
        <tr>
            <td><form:label path="phone1">Phone 1</form:label></td>
            <td><form:input path="phone1" /></td>
        </tr>
        <tr>
            <td><form:label path="phone2">Phone 2</form:label></td>
            <td><form:input path="phone2" /></td>
        </tr>
        <tr>
            <td><form:label path="email">Email</form:label></td>
            <td><form:input path="email" /></td>
        </tr>

        <tr>
            <td colspan="2">
                <input type="submit" value="Submit a Customer"/>
            </td>
        </tr>
    </table>
</form:form>
<br/>
<hr>
<h3>All Customers</h3>

<c:if  test="${!empty customerList}">
    <table class="data">
        <tr>
            <th>Id</th>
            <th>Name</th>
            <th>Address</th>
            <th>Phone 1</th>
            <th>Phone 2</th>
            <th>Email</th>
            <th>Commands</th>
        </tr>
        <c:forEach items="${customerList}" var="customer">
            <tr>
                <td>${customer.id}</td>
                <td>${customer.name}</td>
                <td>${customer.address}</td>
                <td>${customer.phone1}</td>
                <td>${customer.phone2}</td>
                <td>${customer.email}</td>
                <td>
                    <a href="<c:url value="/admin/customers/edit/" />${customer.id}"> Edit </a><br/>
                    <a href="<c:url value="/admin/removeCustomer/" />${customer.id}"
                       onclick="return confirm('Are you sure you want to delete this customer?')"><img
                            src="<c:url value="/resources/images/delete.gif" />" border="0"
                            title="Delete this customer"/></a>
                </td>
            </tr>
        </c:forEach>
    </table>
</c:if>
<br/>
<hr>
</body>
</html>
