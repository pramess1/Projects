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
public class SubscriberValidationResponse {

    private String subscriberId;
    private String accountType;
    private String accountSubType;
    private String accountStatus;
    private String currentBalance;
    private String preferredLanguage;
    private String tataskyTransId;
    private String errorCode;
    private String errorMessage;
    private String param1;
    private String param2;
    private String param3;
    private String param4;
    private String responseXml;

    public String getResponseXml() {
        return responseXml;
    }

    public String getSubscriberId() {
        return subscriberId;
    }

    public String getAccountType() {
        return accountType;
    }

    public String getAccountSubType() {
        return accountSubType;
    }

    public String getAccountStatus() {
        return accountStatus;
    }

    public String getCurrentBalance() {
        return currentBalance;
    }

    public String getPreferredLanguage() {
        return preferredLanguage;
    }

    public String getTataskyTransId() {
        return tataskyTransId;
    }

    public String getErrorCode() {
        return errorCode;
    }

    public String getErrorMessage() {
        return errorMessage;
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

    public String getParam4() {
        return param4;
    }

    public SubscriberValidationResponse(String xml) throws Exception {
        if (xml.length() > 0) {
            DefineXml generateXML = new DefineXml();
            XmlUtil xmlUtil = generateXML.getStringVersion(xml);
            responseXml = xml;
            subscriberId = xmlUtil.getValue("SUBSCRIBER_ID");
            accountType = xmlUtil.getValue("ACCOUNT_TYPE");
            accountSubType = xmlUtil.getValue("ACCOUNT_SUBTYPE");
            accountStatus = xmlUtil.getValue("ACCOUNT_STATUS");
            currentBalance = xmlUtil.getValue("CURRENT_BAL");
            preferredLanguage = xmlUtil.getValue("PREFERRED_LANGUAGE");
            tataskyTransId = xmlUtil.getValue("TSKY_TXN_ID");
            errorCode = xmlUtil.getValue("ERROR_CODE");
            errorMessage = xmlUtil.getValue("ERROR_MSG");
            param1 = xmlUtil.getValue("param1");
            param2 = xmlUtil.getValue("param2");
            param3 = xmlUtil.getValue("param3");
            param4 = xmlUtil.getValue("param4");
        } else {
            errorCode = "404";
        }
    }
}