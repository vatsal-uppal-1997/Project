/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cereal.rentingapplication;

/**
 *
 * @author cereal
 */
public class Test {
    public static void main(String[] args) {
        UserBean ub = new UserBean();
        ub.setUsername("Vatsal Uppal");
        ub.setCity("Panchkula");
        ub.setEmail("vatsal.uppal@gmail.com");
        ub.setPassword("1234");
        System.out.println(ub.getPassword());
        UserDao ud = new UserDao(ub);
        System.out.println(ud.createUser());
        ub.setCity("chandigarh");
        ud.updateUser(ub, "city");
        ub.setEmail("man@tat.com");
        ud.updateUser(ub, "email");
        UserBean rd = ud.readUser(ub.getUsername());
        System.out.println(rd.getUsername()+" "+rd.getCity()+" "+rd.getEmail()+" "+rd.getPassword());
        UserBean ub2 = new UserBean();
        ub2.setUsername("Vatsal Uppal");
        ub2.setPassword("1234");
        ud.setBean(ub2);
        System.out.println(ud.validate());
    }
}
