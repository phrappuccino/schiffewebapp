package fh.controller;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;
import java.math.BigInteger;


@WebServlet("/personen")
public class PersonenServlet extends HttpServlet{
    public PersonenServlet(){
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
        HttpSession session = request.getSession();

        if (request.getParameter("gotel") != null) {
            Long userID = Long.parseLong(request.getParameter("gotel"));
            session.setAttribute("currentUser", userID);
            dispatcher = request.getRequestDispatcher("telenr.jsp");
        }

        if (request.getParameter("updateTeleButton") != null){
            String newtelenummer = request.getParameter("telenr");
            String currentUser = Long.toString((Long) session.getAttribute("currentUser"));
            String sqlstring = "insert into telefonnummer_hatperson " +
                    "values ('" + newtelenummer + "', " + currentUser + ") on duplicate key" +
                    " update SVNR = "+currentUser+", Telefonnummer = '" + newtelenummer + "'";
//            String sqlStatement = "UPDATE telefonnummer_hatperson set Telefonnummer = '" + newtelenummer + "' where SVNR = " + currentUser;
            System.out.println(sqlstring);

            try{
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BIC4A20_04_Schifffahrt", "root", "");
                Statement stmt = con.createStatement();
                int rs = stmt.executeUpdate(sqlstring);
//                while(rs.next())
//                    System.out.println(rs.getInt(1)+"  "+rs.getString(2)+"  "+rs.getString(3));
                con.close();

            }catch(Exception e){ System.out.println(e);}
        }

        if (request.getParameter("upgrade") != null) {
            Long userID = Long.parseLong(request.getParameter("upgrade"));
            session.setAttribute("currentUser", userID);
            dispatcher = request.getRequestDispatcher("detailsForPerson.jsp");
        }

        if (request.getParameter("btn-update") != null) {
            //Get Parameter from page
            Long userID = Long.parseLong(request.getParameter("SVNR"));
            int BLZ = Integer.parseInt(request.getParameter("BLZ"));
            String AngKapTech = request.getParameter("capTech");
            BigInteger KapPatNr = BigInteger.valueOf(Long.parseLong(request.getParameter("KapitaenspatentNummer")));
            int seemeilen = Integer.parseInt(request.getParameter("Seemeilen"));
            String LizNr = request.getParameter("Lizenznummer");
            String Ausbild = request.getParameter("Ausbildungsgrad");

            session.setAttribute("currentUser", userID);

            //Update

            dispatcher = request.getRequestDispatcher("detailsForPerson.jsp");
        }

        if (request.getParameter("btn-speichern") != null) {
            //Get Parameter from Page
            int BLZ = 0;
            int seemeilen = 0;
            BigInteger KapPatNr = BigInteger.valueOf(0);

            if(!(request.getParameter("BLZ").isEmpty()))
                BLZ = Integer.parseInt(request.getParameter("BLZ"));
            if(!(request.getParameter("KapitaenspatentNummer").isEmpty()))
                KapPatNr = BigInteger.valueOf(Long.parseLong(request.getParameter("KapitaenspatentNummer")));
            if(!(request.getParameter("Seemeilen").isEmpty()))
                seemeilen = Integer.parseInt(request.getParameter("Seemeilen"));
            String LizNr = request.getParameter("Lizenznummer");
            String Ausbild = request.getParameter("Ausbildungsgrad");
            String Kontonummer = request.getParameter("Kontonummer");
            String AngKapTech = request.getParameter("capTech");
            String currentUser = session.getAttribute("currentUser").toString();
            String sqlstring = "";
            /* Insert Into */
            switch (AngKapTech)
            {

                case "Kapitaen":
                    sqlstring = "insert into kapitän_istangestellter " +
                            "values ('" + KapPatNr + "', " + seemeilen + ", " + currentUser + ")";
                    System.out.println(sqlstring);

                    try{
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BIC4A20_04_Schifffahrt", "root", "");
                        Statement stmt = con.createStatement();
                        int rs = stmt.executeUpdate(sqlstring);
                        con.close();

                    }catch(Exception e){ System.out.println(e);}
                    break;
                case "Techniker":
                    break;
                case "Angestellter":
                    sqlstring = "insert into gehaltskonto " +
                            "values ('" + BLZ + "', '" + Kontonummer + "', " + 150 + ") on duplicate key" +
                            " update BLZ = '" + BLZ + "' ,Kontonummer ='" + Kontonummer +"'";
                    System.out.println(sqlstring);

                    try{
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BIC4A20_04_Schifffahrt", "root", "");
                        Statement stmt = con.createStatement();
                        int rs = stmt.executeUpdate(sqlstring);
                        con.close();

                    }catch(Exception e){ System.out.println(e);}


                    sqlstring = "insert into angestellter_istpersonmitgehaltskonto (SVNR, BLZ, Kontonummer)" +
                            "values ('" + currentUser + "','" + BLZ + "', '" + Kontonummer + "') on duplicate key" +
                            " update BLZ = '" + BLZ + "' ,Kontonummer ='" + Kontonummer +"'";


                    System.out.println(sqlstring);

                    try{
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BIC4A20_04_Schifffahrt", "root", "");
                        Statement stmt = con.createStatement();
                        int rs = stmt.executeUpdate(sqlstring);
                        con.close();

                    }catch(Exception e){ System.out.println(e);}
                    break;
                default:
                    break;
            }

            dispatcher = request.getRequestDispatcher("detailsForPerson.jsp");
        }

        dispatcher.forward(request, response);
    }
}