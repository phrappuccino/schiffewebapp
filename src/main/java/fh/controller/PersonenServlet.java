package fh.controller;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigInteger;


@WebServlet("/personen")
public class PersonenServlet extends HttpServlet{
    public PersonenServlet(){
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
        HttpSession session = request.getSession();

//        List<User> userListe = service.findAllUser();
//        session.setAttribute("userListe", userListe);
//        findLoginUser(request, session, userListe);

        if (request.getParameter("gotel") != null) {
            Long userID = Long.parseLong(request.getParameter("gotel"));
            session.setAttribute("currentUser", userID);
            dispatcher = request.getRequestDispatcher("telenr.jsp");
        }

        if (request.getParameter("upgrade") != null) {
            Long userID = Long.parseLong(request.getParameter("upgrade"));
            session.setAttribute("currentUser", userID);
            dispatcher = request.getRequestDispatcher("detailsForPerson.jsp");
        }

        if (request.getParameter("update") != null) {
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

        if (request.getParameter("speichern") != null) {
            //Get Parameter from Page
            Long userID = Long.parseLong(request.getParameter("SVNR"));
            int BLZ = Integer.parseInt(request.getParameter("BLZ"));
            String AngKapTech = request.getParameter("capTech");
            BigInteger KapPatNr = BigInteger.valueOf(Long.parseLong(request.getParameter("KapitaenspatentNummer")));
            int seemeilen = Integer.parseInt(request.getParameter("Seemeilen"));
            String LizNr = request.getParameter("Lizenznummer");
            String Ausbild = request.getParameter("Ausbildungsgrad");

            session.setAttribute("currentUser", userID);

            //Insert Into

            dispatcher = request.getRequestDispatcher("detailsForPerson.jsp");
        }


        dispatcher.forward(request, response);
    }
}