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
public class CreateRelocationWorkOrderResponse {

    private String ivrId;
    private String subscriberNumber;
    private String activityId;
    private String errorDescription;
    private String errorCode;
    private String responseXml;

    public String getResponseXml() {
        return responseXml;
    }
    
    public String getIvrId() {
        return ivrId;
    }

    public String getSubscriberNumber() {
        return subscriberNumber;
    }

    public String getActivityId() {
        return activityId;
    }

    public String getErrorDescription() {
        return errorDescription;
    }

    public String getErrorCode() {
        return errorCode;
    }

    public CreateRelocationWorkOrderResponse(String xml) throws Exception {
          if (xml.length() > 0) {
            DefineXml generateXML = new DefineXml();
            XmlUtil xmlUtil = generateXML.getStringVersion(xml);
            responseXml = xml;
            ivrId = xmlUtil.getValue("ivrId");
            subscriberNumber = xmlUtil.getValue("subscriberId");
            activityId = xmlUtil.getValue("activityID");
            errorDescription = xmlUtil.getValue("description");
            errorCode = xmlUtil.getValue("errorCode");
        } else {
            ivrId = null;
            subscriberNumber = null;
            activityId = null;
            errorDescription = null;
            errorCode = "404";
        }
    }
}