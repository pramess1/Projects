/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tsg.eai;

import com.tsg.xml.DefineXml;
import com.tsg.xml.XmlUtil;

/**
 *
 * @author Rajesh
 */
public class SubscriberValidationResponse {

    private static String ivrId;
    private String subscriberNumber;
    private String subStatus;
    private String status;
    private String errorCode;
    private String DateTime;
    private String responseXml;

    public String getResponseXml() {
        return responseXml;
    }
    
    public static String getIvrId() {
        return ivrId;
    }

    public String getSubscriberNumber() {
        return subscriberNumber;
    }

    public String getSubStatus() {
        return subStatus;
    }

    public String getStatus() {
        return status;
    }

    public String getErrorCode() {
        return errorCode;
    }

    public String getDateTime() {
        return DateTime;
    }

    public SubscriberValidationResponse(String xml) throws Exception {
          if (xml.length() > 0) {
            DefineXml generateXML = new DefineXml();
            XmlUtil xmlUtil = generateXML.getStringVersion(xml);
            responseXml = xml;
            ivrId = xmlUtil.getValue("ivr-id");
            subscriberNumber = xmlUtil.getValue("sub-no");
            subStatus = xmlUtil.getValue("sub-status");
            errorCode = xmlUtil.getValue("error-code");
            status = xmlUtil.getValue("status");
            DateTime = xmlUtil.getValue("date-time");
        } else {
            ivrId = null;
            subscriberNumber = null;
            subStatus = null;
            errorCode = "404";
            status = null;
            DateTime = null;
        }
    }
}