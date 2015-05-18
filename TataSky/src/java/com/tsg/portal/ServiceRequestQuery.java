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
public class ServiceRequestQuery {

    public ServiceRequestQueryResponse requestServiceQuery(String source, String atomIvrId,
            String srNumber, String date, String dbCallDetailId) throws Exception {

        String xml = serviceRequestQuery(source, atomIvrId, srNumber, date);

        source = atomIvrId = srNumber = date = null;

        return makeServiceRequestQuery(xml, dbCallDetailId);

    }

    public String serviceRequestQuery(String source, String atomIvrId, String srNumber, String date) {

        StringBuilder builder = new StringBuilder();
        
        //builder.append("<?xml version=\"1.0\" encoding=\"UTF-8\" ?>");
        
        builder.append("<tata-sky>");
        
        builder.append("<sr-query-request>");
        
        builder.append("<source>").append(source).append("</source>");
        
        builder.append("<atom-ivr-id>").append(atomIvrId).append("</atom-ivr-id>");
        
        builder.append("<SRNumber>").append(srNumber).append("</SRNumber>");
        
        builder.append("<date-time>").append(date).append("</date-time>");
        
        builder.append("</sr-query-request>");
        
        builder.append("</tata-sky>");
        
        source = atomIvrId = srNumber = date = null;
        
        return new String(builder);

    }

    private ServiceRequestQueryResponse makeServiceRequestQuery(String strRequestXMLData, String dbCallDetailId) throws Exception {

        requestDelegator objReqDelegator = new requestDelegator();

        Logger.info(dbCallDetailId, "ServiceRequestQuery Request XML : " + strRequestXMLData, false);

        String strResponseXMLData = objReqDelegator.delegate("ServiceRequestQueryPortal", strRequestXMLData, dbCallDetailId);

        Logger.info(dbCallDetailId, "ServiceRequestQuery Response XML : " + strResponseXMLData, false);

        dbCallDetailId = strRequestXMLData = null;

        return new ServiceRequestQueryResponse(strResponseXMLData);

    }
}