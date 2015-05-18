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
public class CreateActivityResponse {

    private String atomIvrId;
    private String srNumber;
    private String activityId;
    private String errorCode;
    private String errorMessage;
    private String responseXml;

    public String getAtomIvrId() {
        return atomIvrId;
    }

    public String getSrNumber() {
        return srNumber;
    }

    public String getActivityId() {
        return activityId;
    }

    public String getErrorCode() {
        return errorCode;
    }

    public String getErrorMessage() {
        return errorMessage;
    }

    public String getResponseXml() {
        return responseXml;
    }

    public CreateActivityResponse(String xml) throws Exception {
        if (xml.length() > 0) {
            DefineXml generateXML = new DefineXml();
            XmlUtil xmlUtil = generateXML.getStringVersion(xml);
            responseXml = xml;
            atomIvrId = xmlUtil.getValue("atom-ivr-id");
            srNumber = xmlUtil.getValue("srNumber");
            activityId = xmlUtil.getValue("activity-id");
            errorCode = xmlUtil.getValue("error-code");
            errorMessage = xmlUtil.getValue("error-message");
        } else {
            errorCode = "404";
        }

    }
}