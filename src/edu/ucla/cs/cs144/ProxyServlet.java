package edu.ucla.cs.cs144;

import java.io.IOException;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.*;
import java.io.PrintWriter; // print

public class ProxyServlet extends HttpServlet implements Servlet {
       
    public ProxyServlet() {}

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        // your codes here
        response.setContentType("text/xml");
        String query = request.getParameter("q");

        String charset = "UTF-8";  
        String url = "http://google.com/complete/search?output=toolbar&q=" + URLEncoder.encode(query,charset);
        URLConnection connection = new URL(url).openConnection();
		connection.setRequestProperty("Accept-Charset", charset);
		InputStream responseFromGoogle = connection.getInputStream();
		

		PrintWriter out = response.getWriter();

		BufferedReader bufferedReader = null;
		StringBuilder stringBuilder = new StringBuilder();

		String line;
	

		bufferedReader = new BufferedReader(new InputStreamReader(responseFromGoogle));
		while ((line = bufferedReader.readLine()) != null) {
			stringBuilder.append(line);
		}
	
		out.println(stringBuilder.toString());
    }
}
