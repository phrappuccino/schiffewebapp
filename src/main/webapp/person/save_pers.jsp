<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import = "java.util.Map" %>

<div id="insert">
    <h3>Save</h3>
<%
    //Get Parameter from Page
    int BLZ = 0;
    int seemeilen = 0;
    boolean ang = false;
    String KapPatNr = "";
    String LizNr = "";
    String Ausbild = "";
    String Kontonummer = "";
    String currentUser = "";

    ang =Boolean.parseBoolean(session.getAttribute("ang").toString());
    BLZ =Integer.parseInt(session.getAttribute("BLZ").toString());

    seemeilen =Integer.parseInt(session.getAttribute("seemeilen").toString());
    if(session.getAttribute("Lizenznummer") != null) {
        LizNr = session.getAttribute("Lizenznummer").toString();
    }
    if(session.getAttribute("Ausbild")!= null) {
        Ausbild = session.getAttribute("Ausbild").toString();
    }
    if(session.getAttribute("Kontonummer") != null) {
        Kontonummer = session.getAttribute("Kontonummer").toString();
    }

    Integer AngKapTech =Integer.parseInt(session.getAttribute("AngKapTech").toString());

    if(session.getAttribute("currentUser") != null) {
        currentUser = session.getAttribute("currentUser").toString();
    }
    if(session.getAttribute("KapPatNr") != null) {
        KapPatNr = session.getAttribute("KapPatNr").toString();
    }
    String sqlstring = "";


    /* Insert Into */
    switch (AngKapTech) {
        //Kapitaen = 1
        case 1:
            if (ang) {
                sqlstring = "insert into kapitän_istangestellter " +
                        "values ('" + KapPatNr + "', " + seemeilen + ", " + currentUser + ") on duplicate key" +
                        " update Seemeilen ='" + seemeilen + "'";
                session.setAttribute("debug",sqlstring);
                try {
//                            Class.forName("com.mysql.cj.jdbc.Driver");
//                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BIC4A20_04_Schifffahrt", "root", "");
//                            Statement stmt = con.createStatement();
//                            int rs = stmt.executeUpdate(sqlstring);
//                            con.close();


                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bic4a20_04", "guoXie4");
                    Statement stmt = con.createStatement();
                    int rs = stmt.executeUpdate(sqlstring);
                    con.close();


                    session.setAttribute("insertKap", "Sie sind nun Kapitaen.");
                } catch (Exception e) {
                    System.out.println(e);
                }
            } else {
                session.setAttribute("insertKap", "Fehler Sie sind kein Angestellter");
            }
            break;
        //Techniker = 2
        case 2:
            if (ang) {
                sqlstring = "insert into techniker_istangestellter " +
                        "values ('" + LizNr + "', " + currentUser + ", " + Ausbild + ") on duplicate key" +
                        " update Ausbildungsgrad ='" + Ausbild + "'";
                session.setAttribute("debug",sqlstring);

                try {
//                        Class.forName("com.mysql.cj.jdbc.Driver");
//                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BIC4A20_04_Schifffahrt", "root", "");
//                        Statement stmt = con.createStatement();
//                        int rs = stmt.executeUpdate(sqlstring);
//                        con.close();

                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bic4a20_04", "guoXie4");
                    Statement stmt = con.createStatement();
                    int rs = stmt.executeUpdate(sqlstring);
                    con.close();


                    session.setAttribute("insertTech", "Sie sind nun Techniker.");
                } catch (Exception e) {
                    System.out.println(e);
                }

            } else {
                session.setAttribute("insertTech", "Fehler Sie sind kein Angestellter.");
            }
            break;

        //Angestellter = 3
        case 3:
            sqlstring = "insert into gehaltskonto " +
                    "values ('" + BLZ + "', '" + Kontonummer + "', " + 150 + ") on duplicate key" +
                    " update BLZ = '" + BLZ + "' ,Kontonummer ='" + Kontonummer + "'";
            session.setAttribute("debug",sqlstring);

            try {
//                        Class.forName("com.mysql.cj.jdbc.Driver");
//                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BIC4A20_04_Schifffahrt", "root", "");
//                        Statement stmt = con.createStatement();
//                        int rs = stmt.executeUpdate(sqlstring);
//                        con.close();

                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bic4a20_04", "guoXie4");
                Statement stmt = con.createStatement();
                int rs = stmt.executeUpdate(sqlstring);
                con.close();


            } catch (Exception e) {
                System.out.println(e);
            }


            sqlstring = "insert into angestellter_pmg (SVNR, BLZ, Kontonummer)" +
                    "values ('" + currentUser + "','" + BLZ + "', '" + Kontonummer + "') on duplicate key" +
                    " update BLZ = '" + BLZ + "' ,Kontonummer ='" + Kontonummer + "'";


            session.setAttribute("debug",sqlstring);

            try {
//                        Class.forName("com.mysql.cj.jdbc.Driver");
//                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BIC4A20_04_Schifffahrt", "root", "");
//                        Statement stmt = con.createStatement();
//                        int rs = stmt.executeUpdate(sqlstring);
//                        con.close();

                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bic4a20_04", "guoXie4");
                Statement stmt = con.createStatement();
                int rs = stmt.executeUpdate(sqlstring);
                con.close();

            } catch (Exception e) {
                System.out.println(e);
            }
            break;
        default:
            break;
    }
%>
    <c:out value='${sessionScope.currentUser}' />
    <c:out value='${sessionScope.debug}' />
</div>
