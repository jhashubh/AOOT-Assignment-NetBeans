<%-- 
    Document   : signup
    Created on : Oct 13, 2017, 8:10:31 AM
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
            int flag =0;
            String uname = request.getParameter("uname");
            String pass = request.getParameter("psw");
            String fname = request.getParameter("fname");
            String lname = request.getParameter("lname");
            String cnf = request.getParameter("cnfpsw");
            String bday = request.getParameter("bday");
            if(!cnf.equals(pass)) {
                %>
                <h1>Passwords does not match each other</h1>
                <%@ include file="signup.jsp" %>
                <%
            } else {
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    System.out.println("Driver Found...");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/aoot_assign?zeroDateTimeBehavior=convertToNull","root","tiger");
                    System.out.println("Connection established...");
                    String sql = "insert into login(fname, lname, usrname, pswd, dob) values ('" + fname + "','" + lname + "','"+ uname + "','" + pass + "','" + bday + "')";
                    Statement stmt = (Statement) con.createStatement();
                    String sql1 = "Select * from login where usrname = '"+uname+"'";
                    ResultSet rs = stmt.executeQuery(sql1);
                    System.out.println("hi");
                    if(!rs.next()) {
                        Statement stmt2 = (Statement) con.createStatement();
                        stmt2.execute(sql);
                        flag = 1;
                        System.out.println("hello");
                        out.println("<h1 align = centre> Successfuly signed up </h1> ");
                        %>
                        <%@ include file="index.html" %>
                        <%
                    }
                } catch(Exception e) {
                    e.printStackTrace();
                }
                if(flag == 0) {
                    %>
                    <h1>user-name already in use</h1>
                    <%@ include file="signupForm.html" %>
                    <%
                        flag =0;
                }
            }
        %>
    </body>
</html>
