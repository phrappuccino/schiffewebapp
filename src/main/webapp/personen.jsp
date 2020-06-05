<%@page import="java.io.*,java.util.*,java.sql.*"%>
<%@page import="javax.servlet.http.*,javax.servlet.*" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page language="java" contentType="text/html; charset=UTF-8" %>
<%@page import="javax.servlet.http.HttpSession" %>

<html>
<head>
    <jsp:include page="header.jsp"/>
    <title>Home</title>
</head>
<body>

<%--//<sql:setDataSource
//        driver="com.mysql.cj.jdbc.Driver"
//        url = "jdbc:mysql://localhost:3306/BIC4A20_04_Schifffahrt"
//        user="root"
//        password=""
// />--%>
<sql:setDataSource
        driver="oracle.jdbc.driver.OracleDriver"
        url="jdbc:oracle:thin:@localhost:1521:xe"
        user="bic4a20_04"
        password="guoXie4"
/>

<sql:query var="personen">
    select * from person
</sql:query>

<jsp:include page="navBar.jsp"/>
<div class = "container">
    <div class="row">
        <div class="col-9">
            <table class="table">
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
                    <th scope="col"></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="person" items="${personen.rows}">
                    <tr>
                        <th scope="col">
                            <c:out value="${person.SVNR}"/>
                        </th>
                        <th scope="col">
                            <c:out value="${person.Vorname}"/>
                        </th>
                        <th scope="col">
                            <c:out value="${person.Ort}"/>
                        </th>
                        <th scope="col">
                            <c:out value="${person.Straße}"/>
                        </th>
                        <th scope="col">
                            <c:out value="${person.Hausnummer}"/>
                        </th>
                        <th scope="col">
                            <c:out value="${person.PLZ}"/>
                        </th>
                        <th scope="col">
                            <c:out value="${person.Ort}"/>
                        </th>
                        <th>
                            <a class="btn btn-primary" href="telenr.jsp?currentUser=${person.SVNR}">TeleNr</a>
                        </th>
                        <th>
                            <form method="post" action="personen">
                                <button class="btn btn-upgrade" type="submit" name="upgrade" value="<c:out value="${person.SVNR}"/>">
                                    Details-Person
                                </button>
                            </form>
                        </th>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%--<script type="text/javascript">--%>
<%--    function submitform(SVN)--%>
<%--    {--%>
<%--        if(document.gotel.onsubmit())--%>
<%--        {--%>
<%--            session.setAttribute("currentUser", SVN);--%>
<%--            document.gotel.submit();--%>
<%--        }--%>
<%--    }--%>
<%--</script>--%>

<jsp:include page="footer.jsp"/>
</body>
</html>