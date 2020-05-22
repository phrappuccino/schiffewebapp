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
            dispatcher = request.getRequestDispatcher("upgradePerson.jsp");
        }

        dispatcher.forward(request, response);
    }
}