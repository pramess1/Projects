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
public class EVDRechargeResponse {

    private String errorCode;
    private String responseXml;

    public String getResponseXml() {
        return responseXml;
    }
    
    public String getErrorCode() {
        return errorCode;
    }

    public void setErrorCode(String errorCode) {
        this.errorCode = errorCode;
    }

    public EVDRechargeResponse(String xml) throws Exception {

        if (xml.length() > 0) {
            DefineXml generateXML = new DefineXml();
            XmlUtil xmlUtil = generateXML.getStringVersion(xml);
            responseXml = xml;
            errorCode = xmlUtil.getValue("error-code");
        } else {

            errorCode = "404";
        }
    }
}