<%-- 
    Document   : login
    Created on : Oct 12, 2017, 2:31:39 AM
    Author     : SAMARTH
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String uname = request.getParameter("uname");
            String pass = request.getParameter("psw");
            int flag =1;
            int flag2 =0;
            try {
                Class.forName("com.mysql.jdbc.Driver");
                System.out.println("Driver Found...");
                Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/aoot_assign?zeroDateTimeBehavior=convertToNull","root","tiger");		
                System.out.println("Connection established...");
                Statement stmt = connect.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                ResultSet rs = stmt.executeQuery("select * from login where usrname = '" + uname + "'");
                while (rs.next())
                {
                    flag =0;
                    String check = rs.getString("pswd");
                    Cookie c1= new Cookie("usrname",rs.getString("usrname"));
                    c1.setMaxAge(-1);
                    response.addCookie(c1);
                    if(check.equals(pass))
                    {
                        flag2 = 1;
                        System.out.println("here i am");
                        //request.getRequestDispatcher("msg.jsp").forward(request, response);
                        response.sendRedirect("profile.jsp");
                    }
                }
                if(flag==1||flag2==0) {
                    %>
                    <h2>Invalid Username Password !!!</h2>
                    <%@ include file="index.html" %>
                    <%
                }
            } catch(Exception ex) {	
                ex.printStackTrace();
            }
        %>
    </body>
</html>
