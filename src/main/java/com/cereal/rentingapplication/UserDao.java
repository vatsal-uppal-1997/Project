/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cereal.rentingapplication;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author cereal
 */
public class UserDao {
    
    private UserBean bean;
    private Connection con;
    final private String connection = "jdbc:mysql://localhost";
    final private String createUser = "INSERT INTO UserDetails VALUES (?,?,?);";
    final private String createLogin = "INSERT INTO UserLogin VALUES (?,?)";
    final private String readUser = "SELECT UserDetails.username, city, email, password FROM UserDetails INNER JOIN UserLogin ON UserDetails.username = UserLogin.username where UserDetails.username = ?;";
    final private String readEmail = "SELECT username FROM UserDetails WHERE email = ?;";
    final private String updateCity = "UPDATE UserDetails SET city = ? WHERE username = ?";
    final private String updateEmail = "UPDATE UserDetails SET email = ? WHERE username = ?";
    final private String updatePassword = "UPDATE UserLogin SET password = ? WHERE username = ?";
    final private String deleteUser = "DELETE FROM UserDetails WHERE username = ?";
    
    // table UserDetails
    // username varchar(30) primary key
    //  email varchar(30)
    // city varchar(30)
    public UserDao() {
       this(null);
    }
    public UserDao(UserBean bean) {
        this.bean = bean;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(this.connection,"root","password");
            con.createStatement().execute("use project;");
        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("Error in User Dao Constructor : "+e);
        }
    }

    public UserBean getBean() {
        return bean;
    }

    public void setBean(UserBean bean) {
        this.bean = bean;
    }
    
    // C R U D
    
    public boolean createUser() {
        if (bean == null)
            return false;
        try {
            
            PreparedStatement psUser = con.prepareStatement(this.createUser);
            PreparedStatement psLogin = con.prepareStatement(this.createLogin);
            psUser.setString(1, this.bean.getUsername());
            psUser.setString(2,  this.bean.getCity());
            psUser.setString(3, this.bean.getEmail());
            psLogin.setString(1, this.bean.getUsername());
            psLogin.setString(2, this.bean.getPassword());
            
            psUser.execute();
            psLogin.execute();
            
        } catch (SQLException e) {
            System.err.println("An error occured in create user func :"+e);
            return false;
        }
        return true;
    }
    
    public UserBean readUser(String username) {
        UserBean newBean;
        try {
            PreparedStatement ps;
            ps = con.prepareStatement(this.readUser);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            newBean = new UserBean();
            while (rs.next()) {
                newBean.setUsername(rs.getString(1));
                newBean.setCity(rs.getString(2));
                newBean.setEmail(rs.getString(3));
                newBean.setPassword(rs.getString(4), true);
            }
        } catch (SQLException e) {
            System.err.println("An error occured in readUser func : "+e);
            return null;
        }
        return newBean;
    }
    
    public boolean readEmail(String email) {
        try {
            PreparedStatement ps = con.prepareStatement(this.readEmail);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            System.out.println("An error occured in readEmail function : "+e);
            return false;
        }
    }
    public boolean updateUser(UserBean bean, String toUpdate) {
        toUpdate = toUpdate.toLowerCase();
        try {
            switch (toUpdate) {
                case "city":
                    {
                        PreparedStatement ps = con.prepareStatement(this.updateCity);
                        ps.setString(1,bean.getCity());
                        ps.setString(2, bean.getUsername());
                        ps.execute();
                        break;
                    }
                case "email":
                    {
                        PreparedStatement ps = con.prepareStatement(this.updateEmail);
                        ps.setString(1, bean.getEmail());
                        ps.setString(2, bean.getUsername());
                        ps.execute();
                        break;
                    }
                case "password":
                {
                        PreparedStatement ps = con.prepareStatement(this.updatePassword);
                        ps.setString(1, bean.getPassword());
                        ps.setString(2, bean.getUsername());
                        ps.execute();
                        break;
                }
                default:
                    return false;
            }
        } catch (SQLException e) {
            System.err.println("An error occured in updateUser: "+e);
        }
        return true;
    }
    
    public boolean deleteUser(UserBean bean) {
        try {
            PreparedStatement ps = con.prepareStatement(this.deleteUser);
            ps.setString(1, bean.getUsername());
            ps.execute();
        } catch (SQLException e) {
            System.err.println("An error occured in deleteUser func : "+e);
            return false;
        }
        return true;
    }
    
    public boolean validate() {
        if (this.bean.getUsername() == null || this.bean.getPassword() == null)
            return false;
        UserBean verify = this.readUser(this.bean.getUsername());
        if (verify.getUsername() == null || verify.getPassword() == null)
            return false;
        return (verify.getPassword()).equals(this.bean.getPassword()) &&
                (verify.getUsername()).equals(this.bean.getUsername());
    }
}
