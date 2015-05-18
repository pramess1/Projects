/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tsg.eai;

import com.tsg.log.Logger;
import com.tsg.requesthandler.requestDelegator;

/**
 *
 * @author Rajesh
 */
public class SubscriberValidation {

    public SubscriberValidationResponse requestSubscriberValidation(String ivrId, String subscriberNumber,
            String contactNumber, String language, String requestType, String dateTime, String dbCallDetailId) throws Exception {

        String xml = subscriberValidation(ivrId, subscriberNumber,
                contactNumber, language, requestType, dateTime);
        
        ivrId = subscriberNumber = contactNumber = language = requestType = dateTime = null;

        return makeSubscriberValidationRequest(xml, dbCallDetailId);

    }

    public String subscriberValidation(String ivrId, String subscriberNumber,
            String contactNumber, String language, String requestType, String dateTime) {

        StringBuilder builder = new StringBuilder();
        
        builder.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
        
        builder.append("<tata-sky>");
        
        builder.append("<sub-Validation-request>");
        
        builder.append("<ivr-id>").append(ivrId).append("</ivr-id>");
        
        builder.append("<sub-no>").append(subscriberNumber).append("</sub-no>");
        
        builder.append("<contact-no>").append(contactNumber).append("</contact-no>");
        
        builder.append("<language>").append(language).append("</language>");
        
        builder.append("<request-type>").append(requestType).append("</request-type>");
        
        builder.append("<date-time>").append(dateTime).append("</date-time>");
        
        builder.append("</sub-Validation-request>");
        
        builder.append("</tata-sky>");
        
        ivrId = subscriberNumber = contactNumber = language = requestType = dateTime = null;
        
        return new String(builder);

    }

    private SubscriberValidationResponse makeSubscriberValidationRequest(String strRequestXMLData, String dbCallDetailId) throws Exception {
        
        requestDelegator objReqDelegator = new requestDelegator();
        
        Logger.info(dbCallDetailId, "Subscriber Validation Request XML : " + strRequestXMLData, false);

        String strResponseXMLData = objReqDelegator.delegate("SubscriberIDValidation", strRequestXMLData,dbCallDetailId);
        
        Logger.info(dbCallDetailId, "Subscriber Validation Response XML : " + strResponseXMLData, false);
        
        dbCallDetailId = strRequestXMLData = null;

        return new SubscriberValidationResponse(strResponseXMLData);

    }
}