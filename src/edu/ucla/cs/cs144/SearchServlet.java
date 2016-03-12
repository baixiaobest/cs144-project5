package edu.ucla.cs.cs144;

import java.io.IOException;
import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter; // print
import edu.ucla.cs.cs144.AuctionSearchClient;
import edu.ucla.cs.cs144.SearchResult;

public class SearchServlet extends HttpServlet implements Servlet {
       
    public SearchServlet() {}

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        // your codes here
		String query = request.getParameter("q");
		int numToSkip = Integer.parseInt(request.getParameter("numResultsToSkip"));
		int numToReturn = Integer.parseInt(request.getParameter("numResultsToReturn"));		
		request.setAttribute("start", numToSkip);

		AuctionSearchClient auctionSearch = new AuctionSearchClient();
		SearchResult[] searchResult = auctionSearch.basicSearch(query, numToSkip, numToReturn);

		String[] ids = new String[searchResult.length];
		String[] names = new String[searchResult.length]; 

		for (int i = 0; i < searchResult.length; i++) {
			ids[i] = searchResult[i].getItemId();
			names[i] = searchResult[i].getName();
		}
		request.setAttribute("numResults", searchResult.length);
		request.setAttribute("idList", ids);
		request.setAttribute("nameList", names);

		request.getRequestDispatcher("/searchResult.jsp").forward(request, response);
	}

}
