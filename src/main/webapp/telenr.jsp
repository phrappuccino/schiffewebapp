<%@page import="java.io.*,java.util.*,java.sql.*"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib  uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page language="java" contentType="text/html; charset=UTF-8" %>

<html>
<head>
    <jsp:include page="header.jsp"/>
    <title>Telefon Nummer</title>
</head>
<body>
<jsp:include page="navBar.jsp"/>
<h3>Telefon Nummer Page for user with SVNR ${param.currentUser}</h3>

<sql:setDataSource
        driver="oracle.jdbc.driver.OracleDriver"
        url="jdbc:oracle:thin:@localhost:1521:xe"
        user="bic4a20_04"
        password="guoXie4"
/>

<sql:query var="personen">
    select Telefonnummer from telefonnummer_hatperson where SVNR = ?
    <sql:param value="${param.currentUser}" />
</sql:query>
<h3> <c:out value="${personen.rowCount}"/> </h3>

<div class = "container">
    <div class="form-signin">
        <h2>Update Telefonnummer</h2>
        <form action="telenr_update.jsp" method="post">
            <div class="form-group">
                <label for="inputTelenr">Telefonnummer</label>
                <input name="telenr" type="text" class="form-control" id="inputTelenr" value="<c:forEach var="person" items="${personen.rows}"><c:out value="${person.Telefonnummer}"/></c:forEach> " required>
                <input type="hidden" name="currentUser" value="${param.currentUser}" />
            </div>
            <br>
            <button class="btn btn-primary" type="submit">Update</button>
            <a class="btn btn-danger" href="index.jsp"  role="button">Cancel / Back to Index</a>
        </form>
    </div>
</div>

<jsp:include page="footer.jsp"/>
</body>
</html>