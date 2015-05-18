/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tsg.portal;

import com.tsg.log.Logger;
import com.tsg.requesthandler.requestDelegator;

/**
 *
 * @author Rajesh
 */
public class SubscriberValidation {

    public SubscriberValidationResponse requestSubscriberValidation(String subscriberId, String dbCallDetailId) throws Exception {

        String xml = subscriberValidation(subscriberId);
        
        subscriberId = null;
        
        return makeSubscriberValidationRequest(xml, dbCallDetailId);

    }

    public String subscriberValidation(String subscriberId) {

        StringBuilder requestMessage = new StringBuilder();
        
        requestMessage.append("Subscriber_Id=" + subscriberId);
        
        subscriberId = null ;
        
        return requestMessage.toString();
        

    }

    private SubscriberValidationResponse makeSubscriberValidationRequest(String strRequestXMLData, String dbCallDetailId) throws Exception {
        
        requestDelegator objReqDelegator = new requestDelegator();
        
        Logger.info(dbCallDetailId, "SubscriberValidation Request XML : " + strRequestXMLData, false);
        
        String strResponseXMLData = objReqDelegator.delegate("SubscriberValidationPortal", strRequestXMLData,dbCallDetailId);
        
        Logger.info(dbCallDetailId, "SubscriberValidation Response XML : " + strResponseXMLData, false);
        
        dbCallDetailId = strRequestXMLData = null;
        
        return new SubscriberValidationResponse(strResponseXMLData);
    }
}