<%--
  Created by IntelliJ IDEA.
  User: localFlow
  Date: 20.05.2020
  Time: 16:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import = "java.util.Map" %>
<html>

<head>

    <jsp:include page="../header.jsp"/>
    <title>Details for Person</title>
</head>

<body>
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

<%
    String userID = request.getParameter("upgrade");
%>

<sql:query var="banken">
    select * from bank
</sql:query>
<%--<h3><c:out value="${sessionScope.currentUser}"></c:out></h3>--%>

<sql:query var="angestellt">
    select gehaltskonto.Kontonummer AS Kontonummer, bank.Bankname AS Bankname, bank.BLZ AS BLZ from angestellter_pmg A JOIN gehaltskonto ON A.BLZ = gehaltskonto.BLZ and A.Kontonummer = gehaltskonto.Kontonummer JOIN bank ON A.BLZ = bank.BLZ where A.SVNR = <%=userID%>
</sql:query>

<%--<h3><c:out value="${angestellt.rowCount}"/></h3>--%>
<%--<c:forEach var="ang" items="${angestellt.rows}">--%>
<%--    <h3><c:out value="${ang.Kontonummer}"/></h3>--%>
<%--</c:forEach>--%>


<div class = "container">
    <div class="row">
        <div class="col-9">
            <table class="table">


                <form method="get" action="detailsForPerson_result.jsp">
                    <tr>
                        <th>
                            <label for="SVNR">SVNR uebernommen:</label>
                            <input type="text" id="SVNR" name="SVNR" disabled="true" maxlength="50" value="<%=userID%>">
                        </th>
                    </tr>
                    <tr>
                        <th>
                    <c:choose>
                <%--        Angestellter wurde nicht gefunden--%>
                    <c:when test="${angestellt.rowCount <= 0}">
                            <div id="blzNr">
                            <label for="Bankleitzahl">Bankleitzahl:</label>

                            <select id="Bankleitzahl" name="Bankleitzahl">
                                <c:forEach var="bank" items="${banken.rows}">
                                    <option value="<c:out value="${bank.BLZ}"/>">
                                        <c:out value="${bank.Bankname}"/>
                                    </option>
                                </c:forEach>
                            </select>
                            </div>
                        <div id="KntNr">
                        <label for="Kontonummer">Kontonummer:</label>
                        <input type="text" id="Kontonummer" name="Kontonummer" maxlength="30"/>
                        </div>
                        <br>
                        <input type="number" id="bool_Ang" name="bool_Ang" style="display: none" value=0></input>

                    </c:when>
                <%--        Angestellter gefunden--%>
                        <c:otherwise>
                            <div id="blzNr">
                            <label for="Bankleitzahl">Bankleitzahl:</label>
                            <select id="Bankleitzahl" name="Bankleitzahl">
                                <c:forEach var="bank" items="${banken.rows}">
                                    <c:choose>
                                    <c:when test="${(angestellt.rows[0].BLZ == bank.BLZ)}">
                                        <option value="<c:out value="${bank.BLZ}"/>" selected>
                                            <c:out value="${bank.Bankname}"/>
                                        </option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="<c:out value="${bank.BLZ}"/>">
                                            <c:out value="${bank.Bankname}"/>
                                        </option>
                                    </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </select>
                            </div>
                            <input type="number" id="bool_Ang" name="bool_Ang" style="display: none" value=1></input>



                        <div id="KntNr">
                        <label for="Kontonummer">Kontonummer:</label>
                        <input type="text" id="Kontonummer" name="Kontonummer"
                                <c:forEach var="ang" items="${angestellt.rows}">
                            value="<c:out value="${ang.Kontonummer}"/>" maxlength="30"/>
                                </c:forEach>
                        </div>
                            <br>
                            <%--Techniker Kapitaen oder nur Angestellter--%>
                            <sql:query var="techniker">
                                select * from techniker_istangestellter where SVNR = <%=userID%>
                            </sql:query>

                            <input type="number" id="bool_Tech" name ="bool_Tech" style="display: none" value="<c:out value="${techniker.rowCount}"/>"></input>

                            <sql:query var="kapitaen">
                                select * from kapitän_istangestellter where SVNR = <%=userID%>
                            </sql:query>

                            <input type="number" id="bool_Kap" name="bool_Kap" style="display: none" value="<c:out value="${kapitaen.rowCount}"/>"></input>





                        </c:otherwise>
                </c:choose>
                        </th>
                    </tr>
                    <tr>
                        <th>
                    <c:choose>
                    <c:when test="${((kapitaen.rowCount > 0) or (techniker.rowCount > 0))}">
                        <c:if test="${(kapitaen.rowCount > 0)}">

                                <c:forEach var="kap" items="${kapitaen.rows}">
                                    <label for="KapitaenspatentNummer">Nummer des Kapitaenspatentes:</label>
                                    <input type="Text" id="KapitaenspatentNummer" name="KapitaenspatentNummer" value="<c:out value="${kap.KapitänspatentNummer}"/>"maxlength="255"/>
                                    <label for="Seemeilen">Gefahrene Seemeilen:</label>
                                    <input type="Text" id="Seemeilen" name="Seemeilen" value="<c:out value="${kap.Seemeilen}"/>"/>
                                </c:forEach>

                        </c:if>
                        <c:if test="${(techniker.rowCount > 0)}">
                            <c:forEach var="tec" items="${techniker.rows}">
                                <label for="Lizenznummer">Techniker Lizenznummer:</label>
                                <input type="Text" id="Lizenznummer" name="Lizenznummer" value="<c:out value="${tec.Lizenznummer}"/> "maxlength="255"/>
                                <label for="Ausbildungsgrad">Ausbildungsgrad:</label>
                                <input type="Text" id="Ausbildungsgrad" name="Ausbildungsgrad" value="<c:out value="${tec.Ausbildungsgrad}"/> "maxlength="255"/>
                            </c:forEach>
                        </c:if>

                    </c:when>
                    <c:otherwise>
                        <label for="capTech">Angestellter Techniker oder Kapitaen:</label>
                        <input type="radio" id="rdAngestellter" onclick="javascript:toggler('Angestellter')" name="capTech" value="3"/>
                        <label for="Angestellter">Angestellter</label>
                        <input type="radio" id="rdTechniker" onclick="javascript:toggler('Techniker')"  name="capTech" value="2"/>
                        <label for="Techniker">Techniker</label>
                        <input type="radio" id="rdKapitaen" onclick="javascript:toggler('Kapitaen')"  name="capTech" value="1"/>
                        <label for="Kapitaen">Kapitaen</label>
                        <br>
                        <div id="Techniker" style="display: none">
                            <label for="Lizenznummer">Techniker Lizenznummer:</label>
                            <input type="Text" id="Lizenznummer" name="Lizenznummer" maxlength="255"/>
                            <label for="Ausbildungsgrad">Ausbildungsgrad:</label>
                            <input type="Text" id="Ausbildungsgrad" name="Ausbildungsgrad" maxlength="255"/>
                        </div>
                        <div id="Kapitaen" style="display: none">
                            <label for="KapitaenspatentNummer">Nummer des Kapitaenspatentes:</label>
                            <input type="Text" id="KapitaenspatentNummer" name="KapitaenspatentNummer" maxlength="255"/>
                            <label for="Seemeilen">Gefahrene Seemeilen:</label>
                            <input type="Text" id="Seemeilen" name="Seemeilen"/>
                        </div>
                    </c:otherwise>
                    </c:choose>
                        </th>
                </tr>
                <tr>
                    <th align="center">
                    <br>
                        <button id="btn-speichern" name="btn-speichern" value="btn-speichern" type="submit" hidden="true">Speichern</button>
                        <button id="btn-update" name="btn-update" value="btn-update" type="submit" hidden="true">Update</button>
                    </th>
                </tr>
                </form>
            </table>
        </div>
    </div>
</div>
<jsp:include page="../footer.jsp"/>
<script>
    $(document).ready(function(){
        if(document.getElementById("bool_Kap").value == 1){
            toggler("Kapitaen");
        }else if(document.getElementById("bool_Tech").value == 1) {
            toggler("Techniker");
        }else {
            toggler("Angestellter");
        }

    });



        function toggler(inputValue) {
            switch(inputValue) {
                case "Techniker":
                    document.getElementById("Kapitaen").style.display = "none";
                    document.getElementById("Techniker").style.display = "inline";
                    document.getElementById("blzNr").style.display = "none";
                    document.getElementById("KntNr").style.display = "none";
                    break;
                case "Kapitaen":
                    document.getElementById("Kapitaen").style.display = "inline";
                    document.getElementById("Techniker").style.display = "none";
                    document.getElementById("blzNr").style.display = "none";
                    document.getElementById("KntNr").style.display = "none";
                    break;
                case "Angestellter":
                    document.getElementById("blzNr").style.display = "inline";
                    document.getElementById("KntNr").style.display = "inline";
                default:
                    document.getElementById("Kapitaen").style.display = "none";
                    document.getElementById("Techniker").style.display = "none";

            }
            changeButton(inputValue);
            changeValueInputs(inputValue);
        };

        function changeButton(inputValue) {
            switch (inputValue) {
                case "Angestellter":
                    document.getElementById("rdAngestellter").setAttribute("checked", "checked");
                    changerForButtons("bool_Ang");
                    break;
                case "Techniker":
                    document.getElementById("rdTechniker").setAttribute("checked", "checked");
                    changerForButtons("bool_Tech");
                    break;
                case "Kapitaen":
                    document.getElementById("rdKapitaen").setAttribute("checked", "checked");
                    changerForButtons("bool_Kap");
                    break;
                default:
                    break;
            }

        }
        function changerForButtons(boolValue){
            if(document.getElementById(boolValue).value == 1){
                document.getElementById("btn-speichern").setAttribute("hidden", "true");
                document.getElementById("btn-update").removeAttribute("hidden");
            }else {
                document.getElementById("btn-speichern").removeAttribute("hidden");
                document.getElementById("btn-update").setAttribute("hidden", "true");
            }
        }

    function changeValueInputs(inputValue){
        if (inputValue == "Angestellter")
        {
            document.getElementById("KapitaenspatentNummer").value = "";
            document.getElementById("Seemeilen").value = "";
            document.getElementById("Lizenznummer").value = "";
            document.getElementById("Ausbildungsgrad").value = "";
        }else if(inputValue == "Techniker")
        {
            document.getElementById("KapitaenspatentNummer").value = "";
            document.getElementById("Seemeilen").value = "";
        }else if(inputValue == "Kapitaen")
        {
            document.getElementById("Lizenznummer").value = "";
            document.getElementById("Ausbildungsgrad").value = "";
        }
    };
</script>


</body>
</html>