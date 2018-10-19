<%-- 
    Document   : login
    Created on : 18 Oct, 2018, 3:41:44 PM
    Author     : cereal
--%>
<%@page import="com.cereal.rentingapplication.UserDao"%>
<%@page contentType="application/json; charset=UTF-8"%>
<%@page import="org.json.JSONObject" %>
<jsp:useBean class="com.cereal.rentingapplication.UserBean" id="validate"/>
<jsp:setProperty name="validate" property="*"/>
<% 
    UserDao res = new UserDao(validate);
    boolean checkPass = res.validate();
    JSONObject json = new JSONObject();
    if (checkPass == false) {
        json.put("message", "password invalid !");
    } else {
        json.put("message", "valid password !");
        json.put("redirect", "home.jsp");
        session.setAttribute("logged_in", true);
        session.setAttribute("user", validate);
    }
    out.println(json);
    
%>

