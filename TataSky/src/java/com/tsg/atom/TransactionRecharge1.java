/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tsg.atom;

import com.tsg.log.Logger;
import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;

/**
 *
 * @author Rajesh
 */
public class TransactionRecharge1 {

    MaskCardNumber maskCardNumber = new MaskCardNumber();
//    Encryption objEncrypt = new Encryption();

    public TransactionRechargeResponse requestTransactionRecharge(String atomMerchantId,
            String methodType, String serviceId, String getAmount, String subscriberId, String customerCallerId,
            String EMITenure, String mobileNo, String BAPin, String cardNumber, String paymentType, String tataSkyTransId,
            String ivrTransId, String dbCallDetailId) throws Exception {

        return makeTransactionRechargeRequest(atomMerchantId, methodType, serviceId, getAmount, subscriberId, customerCallerId,
                EMITenure, mobileNo, BAPin, cardNumber, paymentType, tataSkyTransId, ivrTransId, dbCallDetailId);
    }

    public String transactionRecharge(String atomMerchantId,
            String methodType, String serviceId, String getAmount, String subscriberId, String customerCallerId,
            String EMITenure, String mobileNo, String BAPin, String cardNumber, String paymentType, String tataSkyTransId,
            String ivrTransId, String dbCallDetailId) 
    throws 
            NoSuchAlgorithmException, NoSuchPaddingException, InvalidKeyException, UnsupportedEncodingException,
            IllegalBlockSizeException, BadPaddingException{

        StringBuilder builder = new StringBuilder();

        //builder.append("<?xml version=\"1.0\" encoding=\"UTF-8\" ?>");

        builder.append("<Request>");

        builder.append("<atom>").append(atomMerchantId).append("</atom>");

        builder.append("<Method_type>").append(methodType).append("</Method_type>");

        builder.append("<Service_id>").append(serviceId).append("</Service_id>");

        builder.append("<Amount>").append(getAmount).append("</Amount>");

        builder.append("<UDF0>").append(subscriberId).append("</UDF0>");

        builder.append("<UDF1>").append(customerCallerId).append("</UDF1>");

        if (paymentType.equalsIgnoreCase("AXISDB")) {

//            builder.append("<UDF2>").append(EMITenure).append("|").append(objEncrypt.encrypt(cardNumber)).append("|")
//                    .append(BAPin).append("</UDF2>");
            
            builder.append("<UDF2>").append(EMITenure).append("|").append(maskCardNumber.maskCardNumber(cardNumber, BAPin)).append("|")
                    .append(BAPin).append("</UDF2>");
        } else {

            builder.append("<UDF2>").append(EMITenure).append("|").append(mobileNo).append("|")
                    .append(BAPin).append("</UDF2>");
        }

        builder.append("<UDF3>").append(paymentType).append("</UDF3>");

        builder.append("<UDF4>").append(tataSkyTransId).append("</UDF4>");

        builder.append("<UDF5>").append(ivrTransId).append("</UDF5>");

        builder.append("</Request>");

        atomMerchantId = methodType = serviceId = getAmount = subscriberId = customerCallerId =
                EMITenure = mobileNo = BAPin = cardNumber = paymentType = tataSkyTransId = ivrTransId = dbCallDetailId = null;

        return new String(builder);

    }

    private TransactionRechargeResponse makeTransactionRechargeRequest(String atomMerchantId,
            String methodType, String serviceId, String getAmount, String subscriberId, String customerCallerId,
            String EMITenure, String mobileNo, String BAPin, String cardNumber, String paymentType, String tataSkyTransId,
            String ivrTransId, String dbCallDetailId) throws Exception {

        directcall directCall = new directcall();

        StringArray udfData = new StringArray();

        udfData.value = new ArrayList<String>();

        udfData.value.add(subscriberId);

        udfData.value.add(customerCallerId);

        if (paymentType.equalsIgnoreCase("AXISDB")) {

            udfData.value.add(EMITenure + "|" + cardNumber + "|" + BAPin);

        } else {

            udfData.value.add(EMITenure + "|" + mobileNo + "|" + BAPin);
        }

        udfData.value.add(paymentType);

        udfData.value.add(tataSkyTransId);

        udfData.value.add(ivrTransId);

        Logger.info(dbCallDetailId, " TransactionRechargeBA Request String 1 :" + atomMerchantId + " String 2 : " + methodType + " String 3 : "
                + serviceId + " String 4 : " + getAmount + " UDF : " + udfData, false);

        //Call Atom
        String strResponseXMLData = directCall.delegate(atomMerchantId, methodType, serviceId, getAmount, udfData, dbCallDetailId);

        Logger.info(dbCallDetailId, "TransactionRechargeBA Response XML=" + strResponseXMLData, false);

        atomMerchantId = methodType = serviceId = getAmount = subscriberId = customerCallerId =
                EMITenure = mobileNo = BAPin = cardNumber = paymentType = tataSkyTransId = ivrTransId = dbCallDetailId = null;
        
        udfData = null;

        return new TransactionRechargeResponse(strResponseXMLData);
    }
}
