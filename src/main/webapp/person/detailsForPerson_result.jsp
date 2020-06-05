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
    <jsp:include page="../header.jsp"/>
    <title>Results</title>
</head>
<body>

<%

    int BLZ = 0;
    int seemeilen = 0;
    boolean ang = false;
    String KapPatNr = "";
    boolean save = false;
    boolean update = false;


    if (Integer.parseInt(request.getParameter("bool_Ang")) > 0){
        ang = true;
        System.out.println(request.getParameter("bool_Ang"));
        System.out.println(request.getParameter("Bankleitzahl").toString());
        BLZ = Integer.parseInt(request.getParameter("Bankleitzahl"));
    }else {
        ang = false;
    }

    if(!(request.getParameter("KapitaenspatentNummer").isEmpty()))
        KapPatNr = request.getParameter("KapitaenspatentNummer");
    if(!(request.getParameter("Seemeilen").isEmpty()))
        seemeilen = Integer.parseInt(request.getParameter("Seemeilen"));

    session.setAttribute( "LizNr", request.getParameter("Lizenznummer"));
    session.setAttribute( "Ausbild", request.getParameter("Ausbildungsgrad"));
    session.setAttribute( "Kontonummer", request.getParameter("Kontonummer"));
    session.setAttribute( "AngKapTech", request.getParameter("capTech"));
    session.setAttribute( "currentUser", request.getAttribute("currentUser"));

    if(Integer.parseInt(request.getParameter("btn_speichern").toString())>0) save = true;
    if(Integer.parseInt(request.getParameter("btn_update").toString())>0) update = true;


    session.setAttribute("insertKap", "");
    session.setAttribute("insertTech", "");

    String insertKap = session.getAttribute("insertKap").toString();
    String insertTech = session.getAttribute("insertTech").toString();


%>

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

    <c:if test="${save}">
        <jsp:include page="save_pers.jsp" />
    </c:if>
    <c:if test="${update}">
        <jsp:include page="update_pers.jsp" />
    </c:if>



<jsp:include page="../footer.jsp"/>
</body>
</html>
