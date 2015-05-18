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
public class SoftHeavyRefresh {

    public SoftHeavyRefreshResponse requestSoftHeavyRefresh(String ivrId,
            String subscriberNumber, String requestType, String dateTime, String dbCallDetailId) throws Exception {

        String xml = softHeavyRefresh(ivrId, subscriberNumber, requestType, dateTime);

        ivrId = subscriberNumber = requestType = dateTime = null;

        return makeSoftHeavyRefreshRequest(xml, dbCallDetailId);

    }

    public String softHeavyRefresh(String ivrId, String subscriberNumber, String requestType, String dateTime) {

        StringBuilder builder = new StringBuilder();

        builder.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");

        builder.append("<tata-sky>");

        builder.append("<SoftRefresh-request>");

        builder.append("<ivr-id>").append(ivrId).append("</ivr-id>");

        builder.append("<sub-no>").append(subscriberNumber).append("</sub-no>");

        builder.append("<request-type>").append(requestType).append("</request-type>");

        builder.append("<date-time>").append(dateTime).append("</date-time>");

        builder.append("</SoftRefresh-request>");

        builder.append("</tata-sky>");

        ivrId = subscriberNumber = requestType = dateTime = null;

        return new String(builder);

    }

    private SoftHeavyRefreshResponse makeSoftHeavyRefreshRequest(String strRequestXMLData, String dbCallDetailId) throws Exception {

        requestDelegator objReqDelegator = new requestDelegator();

        Logger.info(dbCallDetailId, "Soft or Heavy Refresh Request XML : " + strRequestXMLData, false);

        String strResponseXMLData = objReqDelegator.delegate("SoftRefresh", strRequestXMLData, dbCallDetailId);

        Logger.info(dbCallDetailId, "Soft or Heavy Refresh Response XML : " + strResponseXMLData, false);

        dbCallDetailId = strRequestXMLData = null;

        return new SoftHeavyRefreshResponse(strResponseXMLData);
    }
}