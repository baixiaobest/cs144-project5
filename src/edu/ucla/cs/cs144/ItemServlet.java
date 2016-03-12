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

import java.io.*;
import java.text.*;
import java.util.*;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.FactoryConfigurationError;
import javax.xml.parsers.ParserConfigurationException;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.Element;
import org.w3c.dom.Text;
import org.xml.sax.SAXException;
import org.xml.sax.SAXParseException;
import org.xml.sax.ErrorHandler;
import org.xml.sax.InputSource;

public class ItemServlet extends HttpServlet implements Servlet {
       
    public ItemServlet() {}

    static Element getElementByTagNameNR(Element e, String tagName) {
        Node child = e.getFirstChild();
        while (child != null) {
            if (child instanceof Element && child.getNodeName().equals(tagName))
                return (Element) child;
            child = child.getNextSibling();
        }
        return null;
    }

    static String getElementText(Element e) {
        if (e.getChildNodes().getLength() == 1) {
            Text elementText = (Text) e.getFirstChild();
            return elementText.getNodeValue();
        }
        else
            return "";
    }

    static String getElementTextByTagNameNR(Element e, String tagName) {
        Element elem = getElementByTagNameNR(e, tagName);
        if (elem != null)
            return getElementText(elem);
        else
            return "";
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        // your codes here
        AuctionSearchClient auctionSearch = new AuctionSearchClient();
        String xmlFormattedResult = auctionSearch.getXMLDataForItemId(request.getParameter("itemId")); 
		    
        HttpSession session = request.getSession(true);
        
        try {
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            factory.setValidating(false);
            factory.setIgnoringElementContentWhitespace(true);      
            DocumentBuilder builder = factory.newDocumentBuilder();
            StringReader string = new StringReader(xmlFormattedResult);
            InputSource xmlFile = new InputSource(string);
            Document doc = builder.parse(xmlFile);
            Element ele = doc.getDocumentElement();
            Node n = doc;
            while(n.getNodeName()!="Item"){
                org.w3c.dom.NodeList nlist = n.getChildNodes();
                n = nlist.item(0);
            }
            //put values into session
            if(getElementTextByTagNameNR(ele, "Buy_Price")!=""){
                session.setAttribute("Price",getElementTextByTagNameNR(ele, "Buy_Price"));
                session.setAttribute("Name", getElementTextByTagNameNR(ele, "Name"));
                org.w3c.dom.NamedNodeMap nattrib = n.getAttributes();
                String itemID = nattrib.item(0).getNodeValue();
                session.setAttribute("ItemId",itemID);
            }
        }
        catch (FactoryConfigurationError e) {
            System.out.println("unable to get a document builder factory");
            System.exit(2);
        } 
        catch (ParserConfigurationException e) {
            System.out.println("parser was unable to be configured");
            System.exit(2);
        }
        catch (IOException e) {
            e.printStackTrace();
            System.exit(3);
        }
        catch (SAXException e) {
            System.out.println("Parsing error on file ");
            System.out.println("  (not supposed to happen with supplied XML files)");
            e.printStackTrace();
            System.exit(3);
        }

        request.setAttribute("dump", xmlFormattedResult);
        request.getRequestDispatcher("itemDetail.jsp").forward(request, response);
    }
}
