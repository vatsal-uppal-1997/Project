/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cereal.rentingapplistings;

import com.cereal.rentingapplication.UserBean;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author cereal
 */
public class ListingDao {

    private ListingBean bean;
    private Connection con;
    
    final private String connection = "jdbc:mysql://localhost";
    final private String createListing = "INSERT INTO ListingDetails VALUES (?,?,?,?,?,?);";
    final private String createListingImage = "INSERT INTO ListingImages VALUES (?,?);";
    final private String readListing ="SELECT ListingDetails.id,listingName,listingLocality,listingDescription,price,username,image FROM ListingDetails JOIN ListingImages ON ListingDetails.id = ListingImages.id WHERE ListingDetails.id = ?;";
    final private String updateListingName = "UPDATE ListingDetails SET ListingName = ? WHERE id = ?;";
    final private String updateListingLocality = "UPDATE ListingDetails SET ListingLocality = ? WHERE id = ?;";
    final private String updateListingDescription = "UPDATE ListingDetails SET ListingDescription = ? WHERE id = ?;";
    final private String updateListingPrice = "UPDATE ListingDetails SET ListingPrice = ? WHERE id = ?;";
    final private String updateListingImage = "UPDATE ListingImages SET image = ? WHERE id = ?;";
    final private String deleteListing = "DELETE FROM ListingDetails WHERE id = ?;";
    
    public ListingBean getBean() {
        return bean;
    }

    public void setBean(ListingBean bean) {
        this.bean = bean;
    }
//      private final String id;
//    private String listingName;
//    private String listingLocality;
//    private String listingDescription;
//    private float listingPrice;
//    private File listingImage;
    
    public ListingDao() {
        this(null);
    }

    public ListingDao(ListingBean bean) {
        this.bean = bean;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(this.connection, "root", "password");
            con.createStatement().execute("use project;");
        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("Error in User Dao Constructor : " + e);
        }
    }
    // C R U D
}
