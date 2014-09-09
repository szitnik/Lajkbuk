<%@ page session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<form action="<c:url value="/signin/facebook" />" method="POST" style="text-align: center;">
    <input type="hidden" name="scope" value="email,read_friendlists,user_about_me,user_birthday,user_likes" />
    <input type="image" src="<c:url value="/resources/images/fblogin.png" />" />
</form>
<br />
<div style="text-align: center;">
    <img src="/resources/images/prijavitukaj.png">
</div>

