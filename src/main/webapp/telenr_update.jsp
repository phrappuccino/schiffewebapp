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

<sql:update var="updateTele">
    merge into TELEFONNUMMER_HATPERSON dest
    using (select ? TELEFONNUMMER, ? SVNR from dual) src
    on (dest.SVNR = src.SVNR)
    when matched then
    update set TELEFONNUMMER = src.TELEFONNUMMER
    when not matched then
    insert (TELEFONNUMMER, SVNR)
    values (src.TELEFONNUMMER, src.SVNR)

    <sql:param value="${param.telenr}" />
    <sql:param value="${param.currentUser}" />
</sql:update>

<div class = "container">
    <div class="card">
        <div class="card-header">
            Title
        </div>
        <div class="card-body">
            update successful
            <br>
            <a class="btn btn-primary" href="index.jsp">Back to Index</a>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp"/>
</body>
</html>