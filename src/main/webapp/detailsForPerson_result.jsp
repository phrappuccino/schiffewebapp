<%--
  Created by IntelliJ IDEA.
  User: localFlow
  Date: 24.05.2020
  Time: 15:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<html>
<head>
    <jsp:include page="header.jsp"/>
    <title>Results</title>
</head>
<body>

<c:forEach var="par" items="${paramValues}">
    <c:if test="${fn:startsWith(par.key, 'token')}">
        ${par.key} = ${par.value[0]};
    </c:if>
</c:forEach>


<div class = "container">
    <div class="row">
        <div class="col-9">
            <table class="table">


                <form method="post" action="personen">
                    <tr>
                        <th>
                            <label for="SVNR">SVNR uebernommen:</label>
                            <input type="text" id="SVNR" name="SVNR" disabled="true" maxlength="50" value="<%=userID%>">
                        </th>
                    </tr>
                    <tr>
                        <th>
                            <label><%=userID%></label>
                            <label><%=insertKap%></label>
                            <label><%=insertTech%></label>
                            <button id="btn-ok" name="btn-ok" type="submit" value="Ok">Ok</button>
                        </th>
                    </tr>
                </form>


            </table>
        </div>
    </div>
</div>



<jsp:include page="footer.jsp"/>
</body>
</html>
