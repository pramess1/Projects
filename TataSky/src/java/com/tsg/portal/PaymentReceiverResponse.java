/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tsg.portal;

import com.tsg.xml.DefineXml;
import com.tsg.xml.XmlUtil;

/**
 *
 * @author Rajesh
 */
public class PaymentReceiverResponse {

    private String subscriberId;
    private String tataskyTransId;
    private String atomTransId;
    private String bankName;
    private String currentBalance;
    private String amount;
    private String bonus;
    private String dateTime;
    private String pgId;
    private String rrn;
    private String tataskyReceipt;
    private String errorCode;
    private String errorMessage;
    private String checksum;
    private String param1;
    private String param2;
    private String param3;
    private String responseXml;

    public String getResponseXml() {
        return responseXml;
    }

    public String getSubscriberId() {
        return subscriberId;
    }

    public String getTataskyTransId() {
        return tataskyTransId;
    }

    public String getAtomTransId() {
        return atomTransId;
    }

    public String getBankName() {
        return bankName;
    }

    public String getCurrentBalance() {
        return currentBalance;
    }

    public String getAmount() {
        return amount;
    }

    public String getBonus() {
        return bonus;
    }

    public String getDateTime() {
        return dateTime;
    }

    public String getPgId() {
        return pgId;
    }

    public String getRrn() {
        return rrn;
    }

    public String getTataskyReceipt() {
        return tataskyReceipt;
    }

    public String getErrorCode() {
        return errorCode;
    }

    public String getErrorMessage() {
        return errorMessage;
    }

    public String getChecksum() {
        return checksum;
    }

    public String getParam1() {
        return param1;
    }

    public String getParam2() {
        return param2;
    }

    public String getParam3() {
        return param3;
    }

    public PaymentReceiverResponse(String xml) throws Exception {
       if (xml.length() > 0) {
            DefineXml generateXML = new DefineXml();
            XmlUtil xmlUtil = generateXML.getStringVersion(xml);
            responseXml = xml;
            subscriberId = xmlUtil.getValue("SUBSCRIBER_ID");
            tataskyTransId = xmlUtil.getValue("TSKY_TXN_ID");
            atomTransId = xmlUtil.getValue("ATOM_TXN_ID");
            bankName = xmlUtil.getValue("BANK_NAME");
            currentBalance = xmlUtil.getValue("CURRENT_BAL");
            amount = xmlUtil.getValue("AMOUNT");
            bonus = xmlUtil.getValue("BONUS");
            dateTime = xmlUtil.getValue("DATE_TIME");
            pgId = xmlUtil.getValue("PG_ID");
            rrn = xmlUtil.getValue("RRN");
            tataskyReceipt = xmlUtil.getValue("TSKY_RECEIPT");
            errorCode = xmlUtil.getValue("ERROR_CODE");
            errorMessage = xmlUtil.getValue("ERROR_MSG");
            checksum = xmlUtil.getValue("CHECKSUM");
            param1 = xmlUtil.getValue("param1");
            param2 = xmlUtil.getValue("param2");
            param3 = xmlUtil.getValue("param3");
        } else {
            subscriberId = null;
            tataskyTransId = null;
            atomTransId = null;
            bankName = null;
            currentBalance = null;
            amount = null;
            bonus = null;
            dateTime = null;
            pgId = null;
            rrn = null;
            tataskyReceipt = null;
            errorCode = "404";
            errorMessage = null;
            checksum = null;
            param1 = null;
            param2 = null;
            param3 = null;
        }

    }
}
