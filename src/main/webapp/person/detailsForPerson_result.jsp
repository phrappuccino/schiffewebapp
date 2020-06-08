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
    int capTechUpdate = 0;


    if(request.getParameterMap().containsKey("capTech")) {
        session.setAttribute("AngKapTech", request.getParameter("capTech"));


        if (request.getParameterMap().containsKey("Bankleitzahl") && request.getParameterMap().containsKey("Kontonummer")) {
            BLZ = Integer.parseInt(request.getParameter("Bankleitzahl"));
            session.setAttribute("BLZ", BLZ);
            session.setAttribute("Kontonummer", request.getParameter("Kontonummer"));
            ang = true;
        }

        if (Integer.parseInt(request.getParameter("bool_Ang")) > 0) {
            session.setAttribute("ang", true);
            ang = true;
        } else {
            session.setAttribute("ang", false);
            ang = false;
        }


        if (request.getParameterMap().containsKey("KapitaenspatentNummer")) {
            if (!(request.getParameter("KapitaenspatentNummer").isEmpty())) {
                KapPatNr = request.getParameter("KapitaenspatentNummer");
            }
        }
        if (request.getParameterMap().containsKey("Seemeilen")) {
            if (!(request.getParameter("Seemeilen").isEmpty())) {
                seemeilen = Integer.parseInt(request.getParameter("Seemeilen"));
            }
        }
        if (request.getParameterMap().containsKey("Lizenznummer")) {
            if (!(request.getParameter("Lizenznummer").isEmpty())) {
                LizNr = request.getParameter("Lizenznummer");
            }
        }
        if (request.getParameterMap().containsKey("Ausbildungsgrad")) {
            if (!(request.getParameter("Ausbildungsgrad").isEmpty())) {
                Ausbildungsgrad = request.getParameter("Ausbildungsgrad");
            }
        }
        if (request.getParameterMap().containsKey("capTechUpdate")) {
            if (!request.getParameter("capTechUpdate").isEmpty())
                capTechUpdate = Integer.parseInt(request.getParameter("capTechUpdate".toString()));
        }
        session.setAttribute("capTechUpdate", capTechUpdate);
        session.setAttribute("LizNr", LizNr);
        session.setAttribute("KapPatNr", KapPatNr);
        session.setAttribute("seemeilen", seemeilen);
        session.setAttribute("Ausbild", Ausbildungsgrad);


        session.setAttribute("currentUser", request.getParameter("SVNR"));

        if (request.getParameterMap().containsKey("btn-speichern")) {
            save = true;
        }
        if (request.getParameterMap().containsKey("btn-update")) {
            update = true;
        }

        session.setAttribute("insertKap", "");
        session.setAttribute("insertTech", "");

        String insertKap = session.getAttribute("insertKap").toString();
        String insertTech = session.getAttribute("insertTech").toString();
    }
    else{
        session.setAttribute("debugFailure", "Select Angestellter/Techniker/Kapitaen...");
    }

%>

<div class = "container">
    <div class="row">
        <div class="col-9">
            <table class="table">



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

                            <a id="btn-ok" name="btn-ok" href="clear_all_attributes.jsp" value="Ok">Ok</a>
                        </th>
                    </tr>



            </table>

            <c:out value='${sessionScope.debugFailure}' />



        </div>
    </div>
</div>





<jsp:include page="../footer.jsp"/>
</body>
</html>
