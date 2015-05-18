/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tsg.portal;

import com.tsg.common.ConfigurationReader;
import com.tsg.log.Logger;
import com.tsg.requesthandler.requestDelegator;
import com.tsg.util.Util;

/**
 *
 * @author Rajesh
 */
public class PaymentReceiver {

    public PaymentReceiverResponse requestPaymentReceiver(String subscriberId, String tataskyTransId,
            String atomTransId, String bankName, String amount, String dateTime, String pgId,
            String rrn, String errorCode, String errorMessage, String checksum, String dbCallDetailId) throws Exception {

        String checkSumValue = subscriberId + "~" + tataskyTransId + "~" + atomTransId + "~" + bankName + "~" + amount + "~" + dateTime + "~" + pgId + "~" + rrn + "~" + errorCode + "~" + errorMessage + "~~~";
        
        String checkSumKey = ConfigurationReader.configList.get("checksumKey");
        
        checksum = Util.validateChecksum(checkSumValue, checkSumKey);
        
        String xml = paymentReceiver(subscriberId, tataskyTransId, atomTransId, bankName, amount,
                dateTime, pgId, rrn, errorCode, errorMessage, checksum);
        
        subscriberId = tataskyTransId = atomTransId = bankName = amount = dateTime = pgId = rrn = errorCode = errorMessage = checksum = null;
        
        return makePaymentReceiverRequest(xml, dbCallDetailId);

    }

    public String paymentReceiver(String subscriberId, String tataskyTransId,
            String atomTransId, String bankName, String amount, String dateTime, String pgId,
            String rrn, String errorCode, String errorMessage, String checksum) {

        StringBuilder builder = new StringBuilder();
        
        builder.append("<XML>");
        
        builder.append("<SUBSCRIBER_ID>").append(subscriberId).append("</SUBSCRIBER_ID>");
        
        builder.append("<TSKY_TXN_ID>").append(tataskyTransId).append("</TSKY_TXN_ID>");
        
        builder.append("<ATOM_TXN_ID>").append(atomTransId).append("</ATOM_TXN_ID>");
        
        builder.append("<BANK_NAME>").append(bankName).append("</BANK_NAME>");
        
        builder.append("<AMOUNT>").append(amount).append("</AMOUNT>");
        
        builder.append("<DATE_TIME>").append(dateTime).append("</DATE_TIME>");
        
        builder.append("<PG_ID>").append(pgId).append("</PG_ID>");
        
        builder.append("<RRN>").append(rrn).append("</RRN>");
        
        builder.append("<ERROR_CODE>").append(errorCode).append("</ERROR_CODE>");
        
        builder.append("<ERROR_MSG>").append(errorMessage).append("</ERROR_MSG>");
        
        builder.append("<CHECKSUM>").append(checksum).append("</CHECKSUM>");
        
        builder.append("<param1>").append("").append("</param1>");
        
        builder.append("<param2>").append("").append("</param2>");
        
        builder.append("<param3>").append("").append("</param3>");
        
        builder.append("</XML>");
        
        subscriberId = tataskyTransId = atomTransId = bankName = amount = dateTime = pgId = rrn = errorCode = errorMessage = checksum = null;
        
        return new String(builder);

    }

    private PaymentReceiverResponse makePaymentReceiverRequest(String strRequestXMLData, String dbCallDetailId) throws Exception {
        
        requestDelegator objReqDelegator = new requestDelegator();
        
        Logger.info(dbCallDetailId, "PaymentReceiver Request XML : " + strRequestXMLData, false);
        
        String strResponseXMLData = objReqDelegator.delegate("PaymentReceiver", strRequestXMLData, dbCallDetailId);
        
        Logger.info(dbCallDetailId, "PaymentReceiver Response XML : " + strResponseXMLData, false);
        
        dbCallDetailId = strRequestXMLData = null;
        
        return new PaymentReceiverResponse(strResponseXMLData);

    }
}
