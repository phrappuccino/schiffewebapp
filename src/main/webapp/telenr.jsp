<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<html>
<head>
    <jsp:include page="header.jsp"/>
    <title>Telefon Nummer</title>
</head>
<body>
    <h3>Telefon Nummer Page for user with SVNR</h3>
    <%Long userID = (Long) session.getAttribute("currentUser");
    String userString = Long.toString(userID);
    %>
    <h3><%=userID%></h3>

    <%--<sql:setDataSource
            driver="com.mysql.cj.jdbc.Driver"
            url = "jdbc:mysql://localhost:3306/BIC4A20_04_Schifffahrt"
            user="root"
            password=""
    />--%>
    <sql:setDataSource
            driver="oracle.jdbc.driver.OracleDriver"
            url="jdbc:oracle:thin:@localhost:1521:xe"
            user="bic4a20_04"
            password="guoXie4"
    />

    <sql:query var="personen">
        select Telefonnummer from telefonnummer_hatperson where SVNR = <%=userString%>
    </sql:query>

        <div class = "container">
            <div class="form-signin">
                <h2>Update Telefonnummer</h2>
                <form action="personen" method="post">
                    <div class="form-group">
                        <label for="inputTelenr">Telefonnummer</label>
                        <input name="telenr" type="text" class="form-control" id="inputTelenr" value="<c:forEach var="person" items="${personen.rows}"><c:out value="${person.Telefonnummer}"/></c:forEach> " required>
                    </div>
                    <br>
                    <button name="updateTeleButton" class="btn btn-lg btn-block btn-primary" value="<%=userID%>" type="submit">Update</button>
                    <a class="btn btn-lg btn-block btn-danger" href="index.jsp"  role="button">Cancel</a>
                </form>
            </div>
        </div>

<jsp:include page="footer.jsp"/>
</body>
</html>