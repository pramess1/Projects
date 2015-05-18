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
public class TransactionRechargeResponse {

    private String transcationId;
    private String bankId;
    private String rrn;
    private String authenticationCode;
    private String atomPaymentGatewayId;
    private String amount;
    private String customerCallerId;
    private String paymentsData;
    private String paymentType;
    private String errorCode;
    private String errorMessage;
    private String responseXml;

    public String getResponseXml() {
        return responseXml;
    }

    public String getTranscationId() {
        return transcationId;
    }

    public String getBankId() {
        return bankId;
    }

    public String getRrn() {
        return rrn;
    }

    public String getAuthenticationCode() {
        return authenticationCode;
    }

    public String getAtomPaymentGatewayId() {
        return atomPaymentGatewayId;
    }

    public String getAmount() {
        return amount;
    }

    public String getCustomerCallerId() {
        return customerCallerId;
    }

    public String getPaymentsData() {
        return paymentsData;
    }

    public String getPaymentType() {
        return paymentType;
    }

    public String getErrorCode() {
        return errorCode;
    }

    public String getErrorMessage() {
        return errorMessage;
    }

    public TransactionRechargeResponse(String xml) throws Exception {

        try {

            if (xml.length() > 10) {

                DefineXml generateXML = new DefineXml();

                XmlUtil xmlUtil = generateXML.getStringVersion(xml);

                responseXml = xml;

                transcationId = xmlUtil.getValue("TxnID");

                bankId = xmlUtil.getValue("BankID");

                rrn = xmlUtil.getValue("RRN");

                authenticationCode = xmlUtil.getValue("AuthCode");

                atomPaymentGatewayId = xmlUtil.getValue("APGID");

                amount = xmlUtil.getValue("Amount");

                customerCallerId = xmlUtil.getValue("UDF1");

                paymentsData = xmlUtil.getValue("UDF2");

                paymentType = xmlUtil.getValue("UDF3");

                errorCode = xmlUtil.getValue("Errorcode");

                errorMessage = xmlUtil.getValue("ErrorMsg");

            } else {
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
