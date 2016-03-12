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

public class BuyServlet extends HttpServlet implements Servlet {

    public BuyServlet(){}
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
    	HttpSession session = request.getSession(true);
        if(session.isNew()){
        	session.setAttribute("InvalidSession","T");
        	session.invalidate();
        }else{
        	session.setAttribute("InvalidSession","F");
        }
        request.getRequestDispatcher("buy.jsp").forward(request, response);
    }

}