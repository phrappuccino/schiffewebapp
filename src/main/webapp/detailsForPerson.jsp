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
    <script src= "https://code.jquery.com/jquery-1.12.4.min.js"></script>
</head>

<body>
<sql:setDataSource
        driver="com.mysql.jdbc.Driver"
        url = "jdbc:mysql://localhost:3306/BIC4A20_04_Schifffahrt"
        user="root"
        password=""
/>
<%Long userID = (Long) session.getAttribute("currentUser");%>
<sql:query var="banken">
    select * from bank
</sql:query>


<sql:query var="angestellt">
    select gehaltskonto.Kontonummer AS Kontonummer from angestellter_istpersonmitgehaltskonto A JOIN gehaltskonto ON A.BLZ = gehaltskonto.BLZ and A.Kontonummer = gehaltskonto.Kontonummer where A.SVNR = ?
    <sql:param value="${userID}" />
</sql:query>

<h3><c:out value="${angestellt.rowCount}"/></h3>
<c:forEach var="ang" items="${angestellt.rows}">
    <h3><c:out value="${ang.Kontonummer}"/></h3>
</c:forEach>





<form>

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
    </c:when>
<%--        Angestellter gefunden--%>
        <c:otherwise>
        <label for="Kontonummer">Kontonummer:</label>
        <input type="text" id="Kontonummer" name="Kontonummer"
                <c:forEach var="ang" items="${angestellt.rows}">
            value="<c:out value="${ang.Kontonummer}"/>" maxlength="30"/>
                </c:forEach>
            <%boolean updaterButton = true;%>
            <%--Techniker Kapitaen oder nur Angestellter--%>
            <sql:query var="techniker">
                select * from techniker_istangestellter where SVNR = ?
                <sql:param value="${userID}" />
            </sql:query>
            <h3><c:out value="${techniker.rowCount}"/></h3>
            <sql:query var="kapitaen">
                select * from kapitän_istangestellter where SVNR = ?
                <sql:param value="${userID}" />
            </sql:query>
            <h3><c:out value="${kapitaen.rowCount}"/></h3>

        </c:otherwise>
</c:choose>

    <br>


    <br>
    <label for="capTech">Angestellter Techniker oder Kapitaen:</label>
    <input type="radio" id="Angestellter" name="capTech" value="Angestellter" checked="true">
    <label for="Angestellter">Angestellter</label>
    <input type="radio" id="Techniker" name="capTech" value="Techniker"/>
    <label for="Techniker">Techniker</label>
    <input type="radio" id="Kapitaen" name="capTech" value="Kapitaen"/>
    <label for="Kapitaen">Kapitaen</label>
    <br>
    <div class="Techniker selectt" hidden="true">
        <label for="Lizenznummer">Techniker Lizenznummer:</label>
        <input type="Text" id="Lizenznummer" name="Lizenznummer" maxlength="255"/>
        <label for="Ausbildungsgrad">Ausbildungsgrad des Technikers:</label>
        <input type="Text" id="Ausbildungsgrad" name="Ausbildungsgrad" maxlength="255"/>
    </div>
    <div class="Kapitaen selectt" hidden="true">
        <label for="KapitaenspatentNummer">Nummer des Kapitaenspatentes:</label>
        <input type="Text" id="KapitaenspatentNummer" name="KapitaenspatentNummer" maxlength="255"/>
        <label for="Seemeilen">Gefahrene Seemeilen:</label>
        <input type="Text" id="Seemeilen" name="Seemeilen"/>
    </div>
    <c:choose>

    <c:when test="${updaterButton}">
        <button type="submit" value="Speichern" disabled="true">Speichern</button>
        <button type="submit" value="Update" disabled="false">Update</button>
    </c:when>
        <c:otherwise>
            <button type="submit" value="Speichern" disabled="false">Speichern</button>
            <button type="submit" value="Update" disabled="true">Update</button>
        </c:otherwise>
    </c:choose>

</form>
<script type="text/javascript">
    $(document).ready(function() {
        $('input[type="radio"]').click(function() {
            var inputValue = $(this).attr("value");
            var targetBox = $("." + inputValue);
            $(".selectt").not(targetBox).hide();
            $(targetBox).show();
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
        });
    });
</script>

</body>
</html>