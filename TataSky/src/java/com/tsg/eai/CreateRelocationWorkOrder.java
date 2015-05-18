/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tsg.eai;

import com.tsg.requesthandler.requestDelegator;
import com.tsg.log.Logger;

/**
 *
 * @author Rajesh
 */
public class CreateRelocationWorkOrder {

    public CreateRelocationWorkOrderResponse requestCreateRelocationWorkOrder(String ivrId,
            String subscriberNumber, String type, String subType,
            String dateTime, String priority, String dbCallDetailId) throws Exception {

        String xml = createRelocationWorkOrder(ivrId, subscriberNumber, type, subType, dateTime, priority);

        ivrId = subscriberNumber = type = subType = dateTime = priority = null;

        return makeCreateRelocationWorkOrderRequest(xml, dbCallDetailId);

    }

    public String createRelocationWorkOrder(String ivrId, String subscriberNumber,
            String type, String subType, String dateTime, String priority) {

        StringBuilder builder = new StringBuilder();

        builder.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");

        builder.append("<tata-sky>");

        builder.append("<reallocation-WorkOrder-request>");

        builder.append("<ivrId>").append(ivrId).append("</ivrId>");

        builder.append("<subscriberId>").append(subscriberNumber).append("</subscriberId>");

        builder.append("<type>").append(type).append("</type>");

        builder.append("<subType>").append(subType).append("</subType>");

        builder.append("<preferredDate>").append(dateTime).append("</preferredDate>");

        builder.append("<priority>").append(priority).append("</priority>");

        builder.append("</reallocation-WorkOrder-request>");

        builder.append("</tata-sky>");

        ivrId = subscriberNumber = type = subType = dateTime = priority = null;

        return new String(builder);

    }

    private CreateRelocationWorkOrderResponse makeCreateRelocationWorkOrderRequest(String strRequestXMLData, String dbCallDetailId) throws Exception {

        requestDelegator objReqDelegator = new requestDelegator();

        Logger.info(dbCallDetailId, "Create Relocation Work Order Request XML : " + strRequestXMLData, false);

        String strResponseXMLData = objReqDelegator.delegate("CreateRelocationWorkOrder", strRequestXMLData, dbCallDetailId);

        Logger.info(dbCallDetailId, "Create Relocation Work Order Response XML : " + strResponseXMLData, false);

        dbCallDetailId = strRequestXMLData = null;

        return new CreateRelocationWorkOrderResponse(strResponseXMLData);
    }
}
