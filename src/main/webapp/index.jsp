<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <jsp:include page="header.jsp"/>
    <title>SELECT Operation</title>
</head>
<body>

<sql:setDataSource
        driver="com.mysql.cj.jdbc.Driver"
        url = "jdbc:mysql://localhost:3306/BIC4A20_04_Schifffahrt"
        user="root"
        password=""
/>

<sql:query var="personen">
    select * from person
</sql:query>


<%--<ul>--%>
<%--    <c:forEach var="person" items="${personen.rows}">--%>
<%--        --%>
<%--&lt;%&ndash;        <li><c:out value="${person.Vorname}"/></li>&ndash;%&gt;--%>
<%--    </c:forEach>--%>
<%--</ul>--%>

<div class = "container">
    <div class="row">
        <div class="col-9">
            <thead class="thead-dark">
            <tr>
                <th scope="col">SVNR</th>
                <th scope="col">Vorname</th>
                <th scope="col">Nachname</th>
                <th scope="col">Strasse</th>
                <th scope="col">Hausnummer</th>
                <th scope="col">PLZ</th>
                <th scope="col">Ort</th>
                <th scope="col"></th>
            </tr>
            </thead>
            <tbody>
                <c:forEach var="person" items="${personen.rows}">
                    <tr>
                        <th scope="col">
                            <c:out value="${person.SVNR}"/>
                            <c:out value="${person.Vorname}"/>
                            <c:out value="${person.Nachname}"/>
                            <c:out value="${person.Straße}"/>
                            <c:out value="${person.Hausnummer}"/>
                            <c:out value="${person.PLZ}"/>
                            <c:out value="${person.Ort}"/>
                        </th>
                    </tr>
                </c:forEach>
            </tbody>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp"/>

</body>
</html>