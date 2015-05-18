/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tsg.eai;

import com.tsg.log.Logger;
import com.tsg.xml.DefineXml;
import com.tsg.xml.XmlUtil;

/**
 *
 * @author Rajesh
 */
public class AccountBalanceResponse {

    private String ivrId;
    private String balance;
    private String dueDateTime;
    private String errorCode;
    private String receivedDateTime;
    private String responseXml;

    public String getResponseXml() {
        return responseXml;
    }

    public String getIvrId() {
        return ivrId;
    }

    public String getBalance() {
        return balance;
    }

    public String getDueDateTime() {
        return dueDateTime;
    }

    public String getErrorCode() {
        return errorCode;
    }

    public String getReceivedDateTime() {
        return receivedDateTime;
    }

    public AccountBalanceResponse(String xml) throws Exception {
        if (xml.length() > 0) {
            DefineXml generateXML = new DefineXml();
            XmlUtil xmlUtil = generateXML.getStringVersion(xml);
            responseXml = xml;
            ivrId = xmlUtil.getValue("ivr-id");
            balance = xmlUtil.getValue("bal");
            dueDateTime = xmlUtil.getValue("due-date");
            errorCode = xmlUtil.getValue("error-code");
            receivedDateTime = xmlUtil.getValue("date-time");
        } else {
            ivrId = null;
            balance = null;
            dueDateTime = null;
            errorCode = "404";
            receivedDateTime = null;
        }
    }
}
