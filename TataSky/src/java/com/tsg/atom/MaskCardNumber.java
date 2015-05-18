/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tsg.atom;

/**
 *
 * @author Rajesh
 */
public class MaskCardNumber {

    /**
     * Applies the specified mask to the card number.
     *
     * @param cardNumber The card number in plain format
     * @param mask The number mask pattern. Use # to include a digit from the
     * card number at that position, use x to skip the digit at that position
     *
     * @return The masked card number
     */
    
    public  String maskCardNumber(String cardNumber, String mask) {
        // format the number
        int index = 0;
        StringBuilder maskedNumber = new StringBuilder();
        for (int i = 0; i < mask.length(); i++) {
            char c = mask.charAt(i);
            if (c == '#') {
                maskedNumber.append(cardNumber.charAt(index));
                index++;
            } else if (c == 'x') {
                maskedNumber.append(c);
                index++;
            } else {
                maskedNumber.append(c);
            }
        }
        // return the masked number
        return maskedNumber.toString();
    }
}
