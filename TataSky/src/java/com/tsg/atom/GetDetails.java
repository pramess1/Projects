/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tsg.atom;

import com.tsg.log.Logger;
import java.util.ArrayList;

/**
 *
 * @author Rajesh
 */
public class GetDetails {

    public GetDetailsResponse requestGetDetails(String atomMerchantId,
            String methodType, String serviceId, String amount, String tataSkySubscriberId, String customerCallerId,
            String genesysUniqueId, String userId, String srNumber, String product, String dbCallDetailId) throws Exception {

        return makeGetDetailsRequest(atomMerchantId, methodType, serviceId, amount, tataSkySubscriberId,
                customerCallerId, genesysUniqueId, userId, srNumber, product, dbCallDetailId);
    }

    public String getDetails(String atomMerchantId,
            String methodType, String serviceId, String amount, String tataSkySubscriberId, String customerCallerId,
            String genesysUniqueId, String userId, String srNumber, String product, String dbCallDetailId) {

        StringBuilder builder = new StringBuilder();

        //builder.append("<?xml version=\"1.0\" encoding=\"UTF-8\" ?>");

        builder.append("<Request>");

        builder.append("<atom>").append(atomMerchantId).append("</atom>");

        builder.append("<Method_type>").append(methodType).append("</Method_type>");

        builder.append("<Service_id>").append(serviceId).append("</Service_id>");

        builder.append("<Amount>").append(amount).append("</Amount>");

        if (product.equalsIgnoreCase("DirectSales")) {

            builder.append("<UDF1>").append(userId).append("</UDF1>");

            builder.append("<UDF2>").append(srNumber).append("</UDF2>");

        } else {

            builder.append("<UDF2>").append(tataSkySubscriberId).append("</UDF2>");

        }

        builder.append("<UDF3>").append(customerCallerId).append("</UDF3>");

        builder.append("<UDF4>").append(genesysUniqueId).append("</UDF4>");

        builder.append("</Request>");

        atomMerchantId = methodType = serviceId = amount = tataSkySubscriberId = customerCallerId = genesysUniqueId = userId = srNumber = product = dbCallDetailId = null;

        return new String(builder);

    }

    public GetDetailsResponse makeGetDetailsRequest(String atomMerchantId,
            String methodType, String serviceId, String amount, String tataSkySubscriberId, String customerCallerId,
            String genesysUniqueId, String userId, String srNumber, String product, String dbCallDetailId) throws Exception {

        directcall directCall = new directcall();

        StringArray udfData = new StringArray();

        udfData.value = new ArrayList<String>();

        if (product.equalsIgnoreCase("Recharge")) {

            udfData.value.add("");
        }

        if (product.equalsIgnoreCase("DirectSales")) {

            udfData.value.add(userId);

            udfData.value.add(srNumber);

        } else {

            udfData.value.add(tataSkySubscriberId);
        }

        udfData.value.add(customerCallerId);

        udfData.value.add(genesysUniqueId);

        Logger.info(dbCallDetailId, "GetDetails Request String 1 :" + atomMerchantId + " String 2 : " + methodType + " String 3 : "
                + serviceId + " String 4 : " + amount + " UDF : " + udfData.getValue(), false);

        // Call ATOM         
        String strResponseXMLData = directCall.delegate(atomMerchantId, methodType, serviceId, amount, udfData, dbCallDetailId); 

        Logger.info(dbCallDetailId, "GetDetails Response XML : " + strResponseXMLData, false);

        atomMerchantId = methodType = serviceId = amount = tataSkySubscriberId = customerCallerId = genesysUniqueId = userId = srNumber = product = dbCallDetailId = null;
        
        udfData = null;
        
        return new GetDetailsResponse(strResponseXMLData);
    }
}
