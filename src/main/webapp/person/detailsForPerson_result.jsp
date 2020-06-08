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
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import = "java.util.Map" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


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
    String LizNr = "";
    String Ausbildungsgrad = "";
    boolean save = false;
    boolean update = false;


    if (Integer.parseInt(request.getParameter("bool_Ang")) > 0){
        session.setAttribute("ang", true);
        ang = true;
        System.out.println(request.getParameter("bool_Ang"));
        System.out.println(request.getParameter("Bankleitzahl").toString());
        BLZ = Integer.parseInt(request.getParameter("Bankleitzahl"));
        session.setAttribute("BLZ", BLZ);
    }else {
        session.setAttribute("ang", false);
        ang = false;
    }

    if(!(request.getParameter("KapitaenspatentNummer").isEmpty())) {
        KapPatNr = request.getParameter("KapitaenspatentNummer");
    }
    if(!(request.getParameter("Seemeilen").isEmpty())) {
        seemeilen = Integer.parseInt(request.getParameter("Seemeilen"));
    }
    if(!(request.getParameter("Lizenznummer").isEmpty())) {
        LizNr = request.getParameter("Lizenznummer");
    }
    if(!(request.getParameter("Ausbildungsgrad").isEmpty())) {
        Ausbildungsgrad = request.getParameter("Ausbildungsgrad");
    }

    session.setAttribute( "LizNr", LizNr);
    session.setAttribute("KapPatNr", KapPatNr);
    session.setAttribute("seemeilen", seemeilen);
    session.setAttribute( "Ausbild", Ausbildungsgrad);

    session.setAttribute( "Kontonummer", request.getParameter("Kontonummer"));
    session.setAttribute( "AngKapTech", request.getParameter("capTech"));
    session.setAttribute( "currentUser", request.getAttribute("SVNR"));

    if(request.getParameterMap().containsKey("btn-speichern")){
        save = true;
    }
    if(request.getParameterMap().containsKey("btn-update")) {
        update = true;
    }

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
<%--                            <label for="SVNR">SVNR uebernommen:</label>--%>
<%--                            <input type="text" id="SVNR" name="SVNR" disabled="true" maxlength="50" value="<%=userID%>">--%>
                        </th>
                    </tr>
                    <tr>
                        <th>
<%--                           <label><%=userID%></label>--%>
<%--                            <label><%=insertKap%></label>--%>


                                <%if(save){%>
                                    <jsp:include page="save_pers.jsp" />
                                <% }%>
                                <%if(update){%>
                                    <jsp:include page="update_pers.jsp" />
                                <% }%>

<%--                            <c:out value="${salary}" />--%>
<%--                            <label><%=insertTech%></label>--%>
<%--                            <c:if test='${save}'>--%>
<%--                                <c:out value="save" />--%>
<%--                                --%>
<%--                            </c:if>--%>
<%--                            <c:if test='${update}'>--%>
<%--                                <c:out value="update"/>--%>
<%--                                --%>
<%--                            </c:if>--%>

                            <button id="btn-ok" name="btn-ok" href="./index.jsp" value="Ok">Ok</button>
                        </th>
                    </tr>
                </form>


            </table>


            <c:out value='${sessionScope.currentUser}' />



        </div>
    </div>
</div>





<jsp:include page="../footer.jsp"/>
</body>
</html>
