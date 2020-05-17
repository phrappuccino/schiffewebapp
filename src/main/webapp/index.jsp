<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%--<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>--%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
<head>

</head>
<body>
<h2>Hello World!</h2>

<sql:setDataSource
        driver="com.mysql.cj.jdbc.Driver"
        url = "jdbc:mysql://localhost:3306"
        user="root"
        password=""
/>

<sql:query var="Bank"
           sql="select BLZ from Bank" >
    <sql:param value="${param.isbn}" />
</sql:query>


<ul>
    <c:forEach var="autor" begin="0" items="${autoren.rows}">
        <li>${autor.autor} wa</li>
    </c:forEach>
</ul>

</body>
</html>