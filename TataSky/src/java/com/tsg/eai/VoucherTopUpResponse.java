/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tsg.eai;

import com.tsg.xml.DefineXml;
import com.tsg.xml.XmlUtil;

/**
 *
 * @author Developer
 */
public class VoucherTopUpResponse {

    private String ivrId;
    private String status;
    private String rechargeValue;
    private String newBalance;
    private String errorCode;
    private String responseXml;

    public String getResponseXml() {
        return responseXml;
    }

    public String getIvrId() {
        return ivrId;
    }

    public String getStatus() {
        return status;
    }

    public String getRechargeValue() {
        return rechargeValue;
    }

    public String getNewBalance() {
        return newBalance;
    }

    public String getErrorCode() {
        return errorCode;
    }
    

    public VoucherTopUpResponse(String xml) throws Exception {
        if (xml.length() > 0) {
            DefineXml generateXML = new DefineXml();
            XmlUtil xmlUtil = generateXML.getStringVersion(xml);
            responseXml = xml;
            ivrId = xmlUtil.getValue("ivr-id");
            status = xmlUtil.getValue("status");
            rechargeValue = xmlUtil.getValue("recharge-value");
            newBalance = xmlUtil.getValue("new-bal");
            errorCode = xmlUtil.getValue("error-code");
        } else {
            ivrId = null;
            status = null;
            rechargeValue = null;
            newBalance = null;
            errorCode = "404";
        }
    }
}
