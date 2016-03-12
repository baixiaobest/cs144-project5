package edu.ucla.cs.cs144;

import java.io.IOException;
import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter; // print
import edu.ucla.cs.cs144.AuctionSearchClient;

public class ConfirmServlet extends HttpServlet implements Servlet {

    public ConfirmServlet(){}
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
    	HttpSession session = request.getSession(true);
    	if(session.isNew()){
    		request.setAttribute("InvalidSession", "T");
    	}else{
    		session.setAttribute("credit", request.getParameter("credit"));
    		request.setAttribute("InvalidSession", "F");
    	}
        request.getRequestDispatcher("confirm.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        doGet(request, response);
    }

}