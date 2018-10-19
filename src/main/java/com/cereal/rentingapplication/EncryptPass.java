/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cereal.rentingapplication;

import com.google.common.hash.Hashing;
import java.nio.charset.StandardCharsets;
/**
 *
 * @author cereal
 */
class EncryptPass {
    static String hashPass(String password) {
        return (Hashing.sha256()).hashString(password, StandardCharsets.UTF_8).toString();
    }
}
