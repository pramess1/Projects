/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tsg.portal;

import com.tsg.log.Logger;
import com.tsg.xml.DefineXml;
import com.tsg.xml.XmlUtil;

/**
 *
 * @author Rajesh
 */
public class ServiceRequestQueryResponse {

    private String atomIvrId;
    private String tataskyTransId;
    private String srNumber;
    private String srType;
    private String srArea;
    private String srSubArea;
    private String pricePoint;
    private String subscriberId;
    private String date;
    private String personalCity;
    private String personalCountry;
    private String personalState;
    private String personalStreetAddress;
    private String personalStreetAddress2;
    private String personalPostalCode;
    private String mobileNumber;
    private String personalISPCode;
    private String errorCode;
    private String errorMessage;
    private String responseXml;
    private String createdBy;

    public String getCreatedBy() {
        return createdBy;
    }

    public String getResponseXml() {
        return responseXml;
    }

    public String getAtomIvrId() {
        return atomIvrId;
    }

    public String getTataskyTransId() {
        return tataskyTransId;
    }

    public String getSrNumber() {
        return srNumber;
    }

    public String getSrType() {
        return srType;
    }

    public String getSrArea() {
        return srArea;
    }

    public String getSrSubArea() {
        return srSubArea;
    }

    public String getPricePoint() {
        return pricePoint;
    }

    public String getSubscriberId() {
        return subscriberId;
    }

    public String getDate() {
        return date;
    }

    public String getPersonalCity() {
        return personalCity;
    }

    public String getPersonalCountry() {
        return personalCountry;
    }

    public String getPersonalState() {
        return personalState;
    }

    public String getPersonalStreetAddress() {
        return personalStreetAddress;
    }

    public String getPersonalStreetAddress2() {
        return personalStreetAddress2;
    }

    public String getPersonalPostalCode() {
        return personalPostalCode;
    }

    public String getMobileNumber() {
        return mobileNumber;
    }

    public String getPersonalISPCode() {
        return personalISPCode;
    }

    public String getErrorCode() {
        return errorCode;
    }

    public String getErrorMessage() {
        return errorMessage;
    }

    public ServiceRequestQueryResponse(String xml) throws Exception {
        if (xml.length() > 0) {
            DefineXml generateXML = new DefineXml();
            XmlUtil xmlUtil = generateXML.getStringVersion(xml);
            responseXml = xml;
            atomIvrId = xmlUtil.getValue("atom-ivr-id");
            tataskyTransId = xmlUtil.getValue("tatasky-txn-id");
            srNumber = xmlUtil.getValue("srNumber");
            srType = xmlUtil.getValue("srType");
            srArea = xmlUtil.getValue("srArea");
            srSubArea = xmlUtil.getValue("srSubArea");
            pricePoint = xmlUtil.getValue("price-point");
            subscriberId = xmlUtil.getValue("subscriber-id");
            date = xmlUtil.getValue("date-time");
            personalCity = xmlUtil.getValue("personalCity");
            personalCountry = xmlUtil.getValue("personalCountry");
            personalState = xmlUtil.getValue("personalState");
            personalStreetAddress = xmlUtil.getValue("personalStreetAddress");
            personalStreetAddress2 = xmlUtil.getValue("personalStreetAddress2");
            personalPostalCode = xmlUtil.getValue("personalPostalCode");
            mobileNumber = xmlUtil.getValue("mobileNumber");
            personalISPCode = xmlUtil.getValue("personalISPCode");
            createdBy = xmlUtil.getValue("createdBy");
            errorCode = xmlUtil.getValue("error-code");
            errorMessage = xmlUtil.getValue("error-message");
        } else {
            errorCode = "404";
        }
    }
}