/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tsg.atom;

import com.tsg.log.Logger;
import com.tsg.xml.DefineXml;
import com.tsg.xml.XmlUtil;

/**
 *
 * @author Rajesh
 */
public class PostDetailsResponse {

    private String transcationId;
    private String orderId;
    private String errorCode;
    private String errorMessage;
    private String responseXml;

    public String getResponseXml() {
        return responseXml;
    }

    public String getTranscationId() {
        return transcationId;
    }

    public String getOrderId() {
        return orderId;
    }

    public String getErrorCode() {
        return errorCode;
    }

    public String getErrorMessage() {
        return errorMessage;
    }

    public PostDetailsResponse(String xml) throws Exception {

        try {

            if (xml.length() > 10) {

                DefineXml generateXML = new DefineXml();

                XmlUtil xmlUtil = generateXML.getStringVersion(xml);

                responseXml = xml;

                transcationId = xmlUtil.getValue("TxnID");

                orderId = xmlUtil.getValue("OrderID");

                errorCode = xmlUtil.getValue("Errorcode");

                errorMessage = xmlUtil.getValue("ErrorMsg");

            } else {

                transcationId = null;

                orderId = null;

                errorCode = "404";

                errorMessage = "Time out Error";
            }

         } catch (Exception ex) {
            
            errorCode = "404";
            
            errorMessage = "XML Error";
            
            Logger.error("", " Exception While in Page : " + ex.getMessage(), false);
            
        } finally {
            
            xml = null;
        }
    }
}
