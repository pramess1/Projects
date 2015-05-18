/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tsg.recharge;

/**
 *
 * @author user
 */
public class LuhnAlgoImplValidateCreditCard {

    public static boolean Check(String LZ_CardNumber) {
        int sum = 0;
        boolean alternate = false;
        for (int i = LZ_CardNumber.length() - 1; i >= 0; i--) {
            int n = Integer.parseInt(LZ_CardNumber.substring(i, i + 1));
            if (alternate) {
                n *= 2;
                if (n > 9) {
                    n = (n % 10) + 1;
                }
            }
            sum += n;
            alternate = !alternate;
        }
        return (sum % 10 == 0);
    }

    public static String getCreditCardType(String LZ_CardNumber) {

        String LZ_CardType = "";

        if (LZ_CardNumber.startsWith("4")) {
            LZ_CardType = "VISA";
        } else if (LZ_CardNumber.startsWith("51") || LZ_CardNumber.startsWith("52") || LZ_CardNumber.startsWith("53") || LZ_CardNumber.startsWith("54") || LZ_CardNumber.startsWith("55")) {
            LZ_CardType = "MASTER";
        } else if (LZ_CardNumber.startsWith("34") || LZ_CardNumber.startsWith("37") || LZ_CardNumber.startsWith("30")) {
            LZ_CardType = "AMEX";
        }
        return LZ_CardType;

    }
    
        public String validateCardExpiryAndCVV(String expiry,String cvv) {

        String response = "";

       
        return response;

    }

    public static void main(String... args) {
        String creditCardNo = "5176521007767041";
        LuhnAlgoImplValidateCreditCard lhn = new LuhnAlgoImplValidateCreditCard();
        boolean status = lhn.Check(creditCardNo);
        System.out.println("status=" + status + "CatrdType=" + lhn.getCreditCardType("5176521007767041"));


    }
}
