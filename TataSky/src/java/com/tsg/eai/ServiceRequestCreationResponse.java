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
public class ServiceRequestCreationResponse {

    private String ivrId;
    private String statusOfSCMS;
    private String subscriberNumber;
    private String errorCode;
    private String description;
    private String sentDateTime;
    private String responseXml;

    public String getResponseXml() {
        return responseXml;
    }
    
    public String getIvrId() {
        return ivrId;
    }

    public String getStatusOfSCMS() {
        return statusOfSCMS;
    }

    public String getSubscriberNumber() {
        return subscriberNumber;
    }

    public String getErrorCode() {
        return errorCode;
    }

    public String getDescription() {
        return description;
    }

    public String getSentDateTime() {
        return sentDateTime;
    }

    public ServiceRequestCreationResponse(String xml) throws Exception {
          if (xml.length() > 0) {
            DefineXml generateXML = new DefineXml();
            XmlUtil xmlUtil = generateXML.getStringVersion(xml);
            responseXml = xml;
            ivrId = xmlUtil.getValue("ivr-id");
            subscriberNumber = xmlUtil.getValue("sub-no");
            statusOfSCMS = xmlUtil.getValue("status");
            errorCode = xmlUtil.getValue("error-code");
            description = xmlUtil.getValue("description");
            sentDateTime = xmlUtil.getValue("date-time");
        } else {
        }
    }
}
