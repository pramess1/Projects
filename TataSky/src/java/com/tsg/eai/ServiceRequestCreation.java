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
public class ServiceRequestCreation {

        public ServiceRequestCreationResponse requestServiceRequestCreation(String ivrId,
            String subscriberNumber, String serviceRequestType, String serviceRequestArea,
            String serviceRequestSubArea, String description, String mobileNumber,
            String requestType, String dateTime, String dbCallDetailId) throws Exception {

        String xml = serviceRequestCreation(ivrId, subscriberNumber, serviceRequestType,
                serviceRequestArea, serviceRequestSubArea, description, mobileNumber,
                requestType, dateTime);
        
        ivrId = subscriberNumber = serviceRequestType = serviceRequestArea = serviceRequestSubArea = description = mobileNumber = requestType = dateTime = null;

        return makeServiceRequestCreationRequest(xml, dbCallDetailId);

    }

    public String serviceRequestCreation(String ivrId,
            String subscriberNumber, String serviceRequestType, String serviceRequestArea,
            String serviceRequestSubArea, String description, String mobileNumber,
            String requestType, String dateTime) {

        StringBuilder builder = new StringBuilder();
        
        builder.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
        
        builder.append("<tata-sky>");
        
        builder.append("<sr-creation-request>");
        
        builder.append("<ivr-id>").append(ivrId).append("</ivr-id>");
        
        builder.append("<sub-no>").append(subscriberNumber).append("</sub-no>");
        
        builder.append("<sr-type>").append(serviceRequestType).append("</sr-type>");
        
        builder.append("<sr-area>").append(serviceRequestArea).append("</sr-area>");
        
        builder.append("<sr-sub-area>").append(serviceRequestSubArea).append("</sr-sub-area>");
        
        builder.append("<description>").append(description).append("</description>");
        
        builder.append("<phone-no>").append(mobileNumber).append("</phone-no>");
        
        builder.append("<request-type>").append(requestType).append("</request-type>");
        
        builder.append("<date-time>").append(dateTime).append("</date-time>");
        
        builder.append("</sr-creation-request>");
        
        builder.append("</tata-sky>");
        
        ivrId = subscriberNumber = serviceRequestType = serviceRequestArea = serviceRequestSubArea = description = mobileNumber = requestType = dateTime = null;
        
        return new String(builder);

    }

    private ServiceRequestCreationResponse makeServiceRequestCreationRequest(String strRequestXMLData, String dbCallDetailId) throws Exception {
        
        requestDelegator objReqDelegator = new requestDelegator();
        
        Logger.info(dbCallDetailId,"Service Request Creation Request XML : " + strRequestXMLData,false);
        
        String strResponseXMLData = objReqDelegator.delegate("ServiceRequestCreation", strRequestXMLData, dbCallDetailId);
        
        Logger.info(dbCallDetailId,"Service Request Creation Response XML : " + strResponseXMLData,false);
        
        dbCallDetailId = strRequestXMLData = null;
        
        return new ServiceRequestCreationResponse(strResponseXMLData);
    }
}
