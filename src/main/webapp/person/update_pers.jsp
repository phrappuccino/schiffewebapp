<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import = "java.util.Map" %>

<div id="update">
    <h3>Update</h3>
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
    session.setAttribute("debugFailure", "Works...");
    session.setAttribute("debug", "what happpened?");

    ang =Boolean.parseBoolean(session.getAttribute("ang").toString());
    BLZ =Integer.parseInt(session.getAttribute("BLZ").toString());

    seemeilen =Integer.parseInt(session.getAttribute("seemeilen").toString());
    if(session.getAttribute("LizNr") != null) {
        LizNr = session.getAttribute("LizNr").toString();
    }
    if(session.getAttribute("Ausbild")!= null) {
        Ausbild = session.getAttribute("Ausbild").toString();
    }
    if(session.getAttribute("Kontonummer") != null) {
        Kontonummer = session.getAttribute("Kontonummer").toString();
    }

    Integer AngKapTech =Integer.parseInt(session.getAttribute("capTechUpdate").toString());
    session.setAttribute("debug", AngKapTech);
    if(session.getAttribute("currentUser") != null) {
        currentUser = session.getAttribute("currentUser").toString();
    }
    if(session.getAttribute("KapPatNr") != null) {
        KapPatNr = session.getAttribute("KapPatNr").toString();
    }
    String sqlstring = "";

    /* Update*/
    switch (AngKapTech) {
        //Kapitaen = 1
        case 1:
            if (ang) {
                sqlstring = "Update  kapitän_istangestellter " +
                        "set KAPITÄNSPATENTNUMMER = '" + KapPatNr + "', SEEMEILEN ='" + seemeilen + "' where SVNR = " + currentUser + "";
                session.setAttribute("debug",sqlstring);
                try {
//                            Class.forName("com.mysql.cj.jdbc.Driver");
//                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BIC4A20_04_Schifffahrt", "root", "");
//                            Statement stmt = con.createStatement();
//                            int rs = stmt.executeUpdate(sqlstring);
//                            stmt.close();
//                            con.close();


                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bic4a20_04", "guoXie4");
                    Statement stmt = con.createStatement();
                    int rs = stmt.executeUpdate(sqlstring);
                    stmt.close();
                    con.close();



                } catch (Exception e) {
                    session.setAttribute("debugFailure", "Failure: " + e);
                }
            } else {
                session.setAttribute("updateKap", "Fehler Sie sind kein Angestellter");
            }
            break;
        //Techniker = 2
        case 2:
            if (ang) {
                sqlstring = "Update techniker_istangestellter " +
                        "set LIZENZNUMMER='" + LizNr + "', AUSBILDUNGSGRAD='" + Ausbild + "' where SVNR="+currentUser+"";
                session.setAttribute("debug",sqlstring);

                try {
//                        Class.forName("com.mysql.cj.jdbc.Driver");
//                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BIC4A20_04_Schifffahrt", "root", "");
//                        Statement stmt = con.createStatement();
//                        int rs = stmt.executeUpdate(sqlstring);
//                        stmt.close();
//                        con.close();

                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bic4a20_04", "guoXie4");
                    Statement stmt = con.createStatement();
                    int rs = stmt.executeUpdate(sqlstring);
                    stmt.close();
                    con.close();


                } catch (Exception e) {
                    session.setAttribute("debugFailure", "Failure: " + e);
                }

            } else {
                session.setAttribute("updateTech", "Fehler Sie sind kein Angestellter.");
            }
            break;

        //Angestellter = 3
        case 3:
            int old_BLZ = 0;
            String old_Kontonummer = "";
            // zu kompliziert zuerst anlegen neuer Bankverbindung danach update der Person und danach remove der alten Bankverbindung
            // Insert neues Gehaltskonto
            sqlstring = "insert into gehaltskonto " +
                    "values ('" + BLZ + "', '" + Kontonummer + "', " + 150 + ")";
            session.setAttribute("debug",sqlstring);

            try {
//                        Class.forName("com.mysql.cj.jdbc.Driver");
//                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BIC4A20_04_Schifffahrt", "root", "");
//                        Statement stmt = con.createStatement();
//                        int rs = stmt.executeUpdate(sqlstring);
//                        stmt.close();
//                        con.close();

                Class.forName("oracle.jdbc.driver.OracleDriver");
                Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bic4a20_04", "guoXie4");
                Statement stmt = con.createStatement();
                int rs = stmt.executeUpdate(sqlstring);
                stmt.close();
                con.close();


            } catch (Exception e) {
                session.setAttribute("debugFailure", "Failure: " + e);
            }
            //Speichern der alten Kontodaten
            sqlstring = "select BLZ, Kontonummer from Angestellter_PMG Where SVNR="+currentUser+"";
            session.setAttribute("debug",sqlstring);

            try {
//                        Class.forName("com.mysql.cj.jdbc.Driver");
//                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BIC4A20_04_Schifffahrt", "root", "");
//                        Statement stmt = con.createStatement();
//                        int rs = stmt.executeUpdate(sqlstring);
//                        stmt.close();
//                        con.close();

                Class.forName("oracle.jdbc.driver.OracleDriver");
                Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bic4a20_04", "guoXie4");
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery(sqlstring);
                while (rs.next()) {
                    old_Kontonummer = rs.getString("Kontonummer");
                    old_BLZ = Integer.parseInt(rs.getString("BLZ"));
                }
                stmt.close();
                con.close();


            } catch (Exception e) {
                session.setAttribute("debugFailure", "Failure: " + e);
            }



            //Update User
            sqlstring = "Update  ANGESTELLTER_PMG " +
                    "set BLZ = '" + BLZ + "', Kontonummer ='" + Kontonummer + "' where SVNR = " + currentUser + "";
            session.setAttribute("debug",sqlstring);
            try {
//                            Class.forName("com.mysql.cj.jdbc.Driver");
//                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BIC4A20_04_Schifffahrt", "root", "");
//                            Statement stmt = con.createStatement();
//                            int rs = stmt.executeUpdate(sqlstring);
//                            stmt.close();
//                            con.close();


                Class.forName("oracle.jdbc.driver.OracleDriver");
                Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bic4a20_04", "guoXie4");
                Statement stmt = con.createStatement();
                int rs = stmt.executeUpdate(sqlstring);
                stmt.close();
                con.close();



            } catch (Exception e) {
                session.setAttribute("debugFailure", "Failure: " + e);
            }
            //Remove old Gehaltskonto
            sqlstring = "DELETE FROM Gehaltskonto Where BLZ=" + old_BLZ +" and Kontonummer='" + old_Kontonummer + "'";
            session.setAttribute("debug",sqlstring);
            try {
//                            Class.forName("com.mysql.cj.jdbc.Driver");
//                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BIC4A20_04_Schifffahrt", "root", "");
//                            Statement stmt = con.createStatement();
//                            int rs = stmt.executeUpdate(sqlstring);
//                            stmt.close();
//                            con.close();


                Class.forName("oracle.jdbc.driver.OracleDriver");
                Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bic4a20_04", "guoXie4");
                Statement stmt = con.createStatement();
                int rs = stmt.executeUpdate(sqlstring);
                stmt.close();
                con.close();



            } catch (Exception e) {
                session.setAttribute("debugFailure", "Failure: " + e);
            }
    }
%>
    <c:out value='${sessionScope.debugFailure}' />
    <br>
    <c:out value='${sessionScope.debug}' />
</div>