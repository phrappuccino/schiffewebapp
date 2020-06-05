<%@page import="java.io.*,java.util.*,java.sql.*"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib  uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page language="java" contentType="text/html; charset=UTF-8" %>

<html>
<head>
    <jsp:include page="header.jsp"/>
    <title>Passage buchen</title>
</head>
<body>
<jsp:include page="navBar.jsp"/>
<h3>Passage buchen für Passagier mit SVNR ${param.currentUser}</h3>

<sql:setDataSource
        driver="oracle.jdbc.driver.OracleDriver"
        url="jdbc:oracle:thin:@localhost:1521:xe"
        user="bic4a20_04"
        password="guoXie4"
/>

<sql:query var="passagen">
    select PASSAGENNUMMER, ABFAHRTSHAFEN, ZIELHAFEN, ABFAHRTSZEIT, ANKUNFTSZEIT from PASSAGE
    where not exists (select * from PASSAGIER_BUCHTPASSAGE where PASSAGENNUMMER = PASSAGE.PASSAGENNUMMER and SVNR = ?)
    <sql:param value="${param.currentUser}" />
</sql:query>

<div class = "container">
    <form method="post" action="pass_mgmt.jsp">
        <fieldset>
            <c:set var="radioId" value="0" scope="page" />
            <table class="table table-bordered table-light bg-light">
                <thead>
                <tr>
                    <th></th>
                    <th>Abfahrtshafen</th>
                    <th>Zielhafen</th>
                    <th>Abfahrtszeit</th>
                    <th>Ankunftszeit</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="passagen" begin="0" items="${passagen.rows}" varStatus="radioId">
                    <tr>
                        <td>
                            <input type="radio" name="journeyid" id="rdo${radioId.index} value="${passagen.PASSAGENNUMMER}" />
                            <input type="hidden" name="currentUser" value="{param.currentUser}" />
                        </td>
                        <td>${passagen.ABFAHRTSHAFEN}</td>
                        <td>${passagen.ZIELHAFEN}</td>
                        <td>${passagen.ANKUNFTSZEIT}</td>
                        <td>${passagen.ABFAHRTSZEIT}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </fieldset>
        <button class="btn btn-primary" type="submit" name="postJourney" value="1">
            Buchen
        </button>
        <button class="btn btn-danger" type="submit" name="abortPost" value="1">
            Abbrechen
        </button>
    </form>
</div>

<jsp:include page="footer.jsp"/>
</body>
</html>