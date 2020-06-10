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
    session.setAttribute("debugFailure", "");

    ang =Boolean.parseBoolean(session.getAttribute("ang").toString());
    if(session.getAttribute("BLZ")!=null) {
        BLZ = Integer.parseInt(session.getAttribute("BLZ").toString());


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
                            "values ('" + KapPatNr + "', " + seemeilen + ", " + currentUser + ")";
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
                    session.setAttribute("insertKap", "Fehler Sie sind kein Angestellter");
                }
                break;
            //Techniker = 2
            case 2:
                if (ang) {
                    sqlstring = "insert into techniker_istangestellter " +
                            "values ('" + LizNr + "', " + currentUser + ", " + Ausbild + ")";
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


                        session.setAttribute("insertTech", "Sie sind nun Techniker.");
                    } catch (Exception e) {
                        session.setAttribute("debugFailure", "Failure: " + e);
                    }

                } else {
                    session.setAttribute("insertTech", "Fehler Sie sind kein Angestellter.");
                }
                break;

            //Angestellter = 3
            case 3:
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


                sqlstring = "insert into angestellter_pmg (ANGESTELLTENNUMMER, SVNR, BLZ, Kontonummer)" +
                        "values (seqAng.nextval, '" + currentUser + "','" + BLZ + "', '" + Kontonummer + "')";


                session.setAttribute("debug",sqlstring);

                try {
    //                        Class.forName("com.mysql.cj.jdbc.Driver");
    //                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BIC4A20_04_Schifffahrt", "root", "");
    //                        Statement stmt = con.createStatement();
    //                        int rs = stmt.executeUpdate(sqlstring);
                    //        stmt.close();
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
                break;
            default:
                break;
        }
    }
    else{
        session.setAttribute("debugFailure", "Failure: " + "Du bist kein Angestellter mit Kontonummer.");
    }
%>
    <c:out value='${sessionScope.debugFailure}' />
    <br>
    <c:out value='${sessionScope.debug}' />
</div>
