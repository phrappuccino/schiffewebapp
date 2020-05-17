package fh.controller;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;


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

        dispatcher.forward(request, response);
    }
}