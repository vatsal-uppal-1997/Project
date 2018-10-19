<%@page import="org.json.JSONObject"%>
<%@page import="com.cereal.rentingapplication.UserBean"%>
<%@page import="com.cereal.rentingapplication.UserDao"%>
<%@page contentType="application/json; charset=UTF-8" %>
<jsp:useBean id="createMe" class="com.cereal.rentingapplication.UserBean"/>
<jsp:setProperty name="createMe" property="*"/>

<%

    JSONObject json = new JSONObject();
    UserDao ud = new UserDao(createMe);
    UserBean check = ud.readUser(createMe.getUsername()); // will be null if no such user exists
    if (check.getUsername() != null && (check.getUsername()).equals(createMe.getUsername())) {
        json.put("message", "The user already exists !");
    } else {
        if (ud.readEmail(createMe.getEmail())) { // return a boolean checking whether provided email 
            json.put("message", "The email already exists !");
        } else {
            if (ud.createUser()) {
                json.put("message", "User registered successfully !");
                json.put("redirect", "home.jsp");
                session.setAttribute("logged_in", true);
                session.setAttribute("user", createMe);
            } else {
                json.put("checkUser", check.getUsername());
                json.put("message", "Some error occured !");
            }
        }
    }
    out.println(json);

%>