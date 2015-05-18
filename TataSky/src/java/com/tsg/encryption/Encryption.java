/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tsg.encryption;

import com.tsg.common.ConfigurationReader;
import com.tsg.log.Logger;
import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.SecretKeySpec;

/**
 *
 * @author Pramesh
 */
public class Encryption {

    public String encrypt(String plainText) throws
            NoSuchAlgorithmException, NoSuchPaddingException, InvalidKeyException, UnsupportedEncodingException,
            IllegalBlockSizeException, BadPaddingException {

        String key = ConfigurationReader.configList.get("KEY");

        Cipher cipher = Cipher.getInstance("AES");
        
        Logger.info("", "Encrypting the Card", false);

        try {

            SecretKeySpec keySpec = new SecretKeySpec(key.getBytes("UTF-8"), "AES");

            cipher.init(Cipher.ENCRYPT_MODE, keySpec);

            return toHexString(cipher.doFinal(plainText.getBytes()));

        } catch (UnsupportedEncodingException | InvalidKeyException | IllegalBlockSizeException | BadPaddingException e) {

            Logger.info("", "Exception While Ecryption the card number : " + e.getMessage(), false);
        }

        return toHexString(cipher.doFinal(plainText.getBytes()));

    }

    public static String toHexString(byte bytes[]) {

        StringBuffer retString = new StringBuffer();

        for (int i = 0; i < bytes.length; i++) {

            retString.append(Integer.toHexString(256 + (bytes[i] & 0xff)).substring(1));
        }

        return retString.toString();
    }
}
