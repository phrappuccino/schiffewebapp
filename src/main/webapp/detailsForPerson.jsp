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
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<html>

<head>

    <jsp:include page="header.jsp"/>

</head>

<body>
<sql:setDataSource
        driver="com.mysql.jdbc.Driver"
        url = "jdbc:mysql://localhost:3306/BIC4A20_04_Schifffahrt"
        user="root"
        password=""
/>
<%String userID = session.getAttribute("currentUser").toString();%>

<sql:query var="banken">
    select * from bank
</sql:query>
<%--<h3><c:out value="${sessionScope.currentUser}"></c:out></h3>--%>

<sql:query var="angestellt">
    select gehaltskonto.Kontonummer AS Kontonummer, bank.Bankname AS Bankname from angestellter_istpersonmitgehaltskonto A JOIN gehaltskonto ON A.BLZ = gehaltskonto.BLZ and A.Kontonummer = gehaltskonto.Kontonummer JOIN bank ON A.BLZ = bank.BLZ where A.SVNR = <%=userID%>
</sql:query>

<%--<h3><c:out value="${angestellt.rowCount}"/></h3>--%>
<%--<c:forEach var="ang" items="${angestellt.rows}">--%>
<%--    <h3><c:out value="${ang.Kontonummer}"/></h3>--%>
<%--</c:forEach>--%>





<form method="post" action="personen">

    <label for="SVNR">SVNR uebernommen:</label>
    <input type="text" id="SVNR" name="SVNR" disabled="true" maxlength="50" value="<%=userID%>">
    <br>
    <c:choose>
<%--        Angestellter wurde nicht gefunden--%>
    <c:when test="${angestellt.rowCount <= 0}">

            <label for="BLZ">Bankleitzahl:</label>

            <select id="BLZ">
                <c:forEach var="bank" items="${banken.rows}">
                    <option value="<c:out value="${bank.BLZ}"/>">
                        <c:out value="${bank.Bankname}"/>
                    </option>
                </c:forEach>
            </select>
        <label for="Kontonummer">Kontonummer:</label>
        <input type="text" id="Kontonummer" name="Kontonummer" maxlength="30"/>
        <br>
    </c:when>
<%--        Angestellter gefunden--%>
        <c:otherwise>
            <label for="bank">Bank:</label>
            <input type="text" id="bank" name="Bank"
            <c:forEach var="ang" items="${angestellt.rows}">
                value="<c:out value="${ang.Bankname}"/>" disabled="true" maxlength="30"/>
            </c:forEach>
        <label for="Kontonummer">Kontonummer:</label>
        <input type="text" id="Kontonummer" name="Kontonummer"
                <c:forEach var="ang" items="${angestellt.rows}">
            value="<c:out value="${ang.Kontonummer}"/>" disabled="true" maxlength="30"/>
                </c:forEach>
            <br>
            <%--Techniker Kapitaen oder nur Angestellter--%>
            <sql:query var="techniker">
                select * from techniker_istangestellter where SVNR = <%=userID%>
            </sql:query>

<%--            <h3>Techniker: <c:out value="${techniker.rowCount}"/></h3>--%>

            <sql:query var="kapitaen">
                select * from kapitän_istangestellter where SVNR = <%=userID%>
            </sql:query>

<%--            <h3>Kapitaen: <c:out value="${kapitaen.rowCount}"/></h3>--%>




        </c:otherwise>
</c:choose>
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
                <label for="Ausbildungsgrad">Ausbildungsgrad des Technikers:</label>
                <input type="Text" id="Ausbildungsgrad" name="Ausbildungsgrad" value="<c:out value="${tec.Ausbildungsgrad}"/> "maxlength="255"/>
            </c:forEach>
        </c:if>
        <c:set var="updaterButton" value="1"/>

    </c:when>
    <c:otherwise>
        <label for="capTech">Angestellter Techniker oder Kapitaen:</label>
        <input type="radio" id="rdAngestellter" onclick="javascript:toggler('Angestellter')" name="capTech" value="Angestellter"/>
        <label for="Angestellter">Angestellter</label>
        <input type="radio" id="rdTechniker" onclick="javascript:toggler('Techniker')"  name="capTech" value="Techniker"/>
        <label for="Techniker">Techniker</label>
        <input type="radio" id="rdKapitaen" onclick="javascript:toggler('Kapitaen')"  name="capTech" value="Kapitaen"/>
        <label for="Kapitaen">Kapitaen</label>
        <br>
        <div id="Techniker" style="display: none">
            <label for="Lizenznummer">Techniker Lizenznummer:</label>
            <input type="Text" id="Lizenznummer" name="Lizenznummer" maxlength="255"/>
            <label for="Ausbildungsgrad">Ausbildungsgrad des Technikers:</label>
            <input type="Text" id="Ausbildungsgrad" name="Ausbildungsgrad" maxlength="255"/>
        </div>
        <div id="Kapitaen" style="display: none">
            <label for="KapitaenspatentNummer">Nummer des Kapitaenspatentes:</label>
            <input type="Text" id="KapitaenspatentNummer" name="KapitaenspatentNummer" maxlength="255"/>
            <label for="Seemeilen">Gefahrene Seemeilen:</label>
            <input type="Text" id="Seemeilen" name="Seemeilen"/>
        </div>
        <c:set var="updaterButton" value="0"/>
    </c:otherwise>
    </c:choose>


<br>
    <c:choose>
    <c:when test="${(updaterButton == 0)}">
        <button type="submit" value="Speichern" >Speichern</button>
        <button type="submit" value="Update" disabled>Update</button>
    </c:when>
        <c:otherwise>
            <button type="submit" value="Speichern" disabled>Speichern</button>
            <button type="submit" value="Update">Update</button>
        </c:otherwise>
    </c:choose>

</form>

<jsp:include page="footer.jsp"/>
<script>

        function toggler(inputValue) {
            switch(inputValue) {
                case "Techniker":
                    document.getElementById("Kapitaen").style.display = "none";
                    document.getElementById("Techniker").style.display = "inline";
                    document.getElementById("bank").setAttribute("disabled");
                    document.getElementById("Kontonummer").setAttribute("disabled");
                    break;
                case "Kapitaen":
                    document.getElementById("Kapitaen").style.display = "inline";
                    document.getElementById("Techniker").style.display = "none";
                    document.getElementById("bank").setAttribute("disabled");
                    document.getElementById("Kontonummer").setAttribute("disabled");
                    break;
                case "Angestellter":
                    document.getElementById("bank").removeAttribute("disabled");
                    document.getElementById("Kontonummer").removeAttribute("disabled");
                default:
                    document.getElementById("Kapitaen").style.display = "none";
                    document.getElementById("Techniker").style.display = "none";

            }
            changeValueInputs(inputValue);
        };


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