/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tsg.atom;

import com.compoze.util.http.URLEncoder;
import com.tsg.log.Logger;
import java.util.ArrayList;

/**
 *
 * @author Rajesh
 */
public class PostDetails {

    //public static final Logger log = Logger.getLogger(PostDetails.class);
    public PostDetailsResponse requestPostDetails(String atomMerchantId, String methodType,
            String serviceId, String getAmount, String pricePoint, String atomTxnUniqueId, String userId, String srNumber,
            String SubscriberId, String userANI, String ivrId, String status, String callStage, String requiredDigit,
            String enteredDigit, String attempts, String noofBoxes, String packageName, String hardwareAmount,
            String activityFees, String bonusAmount, String packageAmount, String accessoriesAmount, String totalAmount,
            String transactionType, String SRValidResponse, String SRPostResponse, String SUBIDValidResponse,
            String SUBIDPostResponse, String product, String dbCallDetailId) throws Exception {


        return makePostDetailsRequest(atomMerchantId, methodType, serviceId, getAmount, pricePoint, atomTxnUniqueId, userId, srNumber,
                SubscriberId, userANI, ivrId, status, callStage, requiredDigit, enteredDigit, attempts, noofBoxes, packageName, hardwareAmount,
                activityFees, bonusAmount, packageAmount, accessoriesAmount, totalAmount, transactionType, SRValidResponse, SRPostResponse, SUBIDValidResponse,
                SUBIDPostResponse, product, dbCallDetailId);

    }

    public String postDetails(String atomMerchantId, String methodType,
            String serviceId, String getAmount, String pricePoint, String atomTxnUniqueId, String userId, String srNumber,
            String SubscriberId, String userANI, String ivrId, String status, String callStage, String requiredDigit,
            String enteredDigit, String attempts, String noofBoxes, String packageName, String hardwareAmount,
            String activityFees, String bonusAmount, String packageAmount, String accessoriesAmount, String totalAmount,
            String transactionType, String SRValidResponse, String SRPostResponse, String SUBIDValidResponse,
            String SUBIDPostResponse, String product, String dbCallDetailId) {

        StringBuilder builder = new StringBuilder();

        if (product.equalsIgnoreCase("Recharge")) {

            //builder.append("<?xml version=\"1.0\" encoding=\"UTF-8\" ?>");

            builder.append("<Request>");

            builder.append("<atom>").append(atomMerchantId).append("</atom>");

            builder.append("<Method_type>").append(methodType).append("</Method_type>");

            builder.append("<Service_id>").append(serviceId).append("</Service_id>");

            builder.append("<Amount>").append(getAmount).append("</Amount>");

            builder.append("<UDF0>").append(atomTxnUniqueId).append("</UDF0>");

            builder.append("<UDF2>").append(SubscriberId).append("</UDF2>");

            builder.append("<UDF3>").append(userANI).append("</UDF3>");

            builder.append("<UDF4>").append(ivrId).append("</UDF4>");

            builder.append("<UDF5>").append(status).append("</UDF5>");

            builder.append("<UDF6>").append(callStage).append("|").append(requiredDigit).append("|").
                    append(enteredDigit).append("|").append(attempts).append("</UDF6>");

            builder.append("<UDF9>").append("").append("</UDF9>");

            builder.append("<UDF10>").append("").append("</UDF10>");

            builder.append("</Request>");

        } else if (product.equalsIgnoreCase("DirectSales")) {

//             builder.append("<?xml version=\"1.0\" encoding=\"UTF-8\" ?>");

            builder.append("<Request>");

            builder.append("<atom>").append(atomMerchantId).append("</atom>");

            builder.append("<Method_type>").append(methodType).append("</Method_type>");

            builder.append("<Service_id>").append(serviceId).append("</Service_id>");

            builder.append("<Amount>").append(pricePoint).append("</Amount>");

            builder.append("<UDF0>").append(atomTxnUniqueId).append("</UDF0>");

            builder.append("<UDF1>").append(userId).append("</UDF1>");

            builder.append("<UDF2>").append(srNumber).append("</UDF2>");

            builder.append("<UDF3>").append(userANI).append("</UDF3>");

            builder.append("<UDF4>").append(ivrId).append("</UDF4>");

            builder.append("<UDF5>").append(status).append("</UDF5>");

            builder.append("<UDF6>").append(callStage).append("|").append(requiredDigit).append("|").
                    append(enteredDigit).append("|").append(attempts).append("</UDF6>");

            builder.append("<UDF7>").append(noofBoxes).append("|").append(packageName).append("|").
                    append(hardwareAmount).append("|").append(activityFees).append("|").append(bonusAmount).append("|").
                    append(packageAmount).append("|").append(accessoriesAmount).append("|").append(totalAmount).append("</UDF7>");

            builder.append("<UDF8>").append(transactionType).append("</UDF8>");

            builder.append("<UDF9>").append("").append("</UDF9>");

            builder.append("<UDF10>").append("").append("</UDF10>");

            builder.append("</Request>");
        }

        atomMerchantId = methodType = serviceId = getAmount = pricePoint = atomTxnUniqueId = userId = srNumber =
                SubscriberId = userANI = ivrId = status = callStage = requiredDigit = enteredDigit = attempts = noofBoxes = packageName = hardwareAmount =
                activityFees = bonusAmount = packageAmount = accessoriesAmount = totalAmount = transactionType = SRValidResponse = SRPostResponse = SUBIDValidResponse =
                SUBIDPostResponse = product = dbCallDetailId = null;

        return new String(builder);

    }

    private PostDetailsResponse makePostDetailsRequest(String atomMerchantId, String methodType,
            String serviceId, String getAmount, String pricePoint, String atomTxnUniqueId, String userId, String srNumber,
            String SubscriberId, String userANI, String ivrId, String status, String callStage, String requiredDigit,
            String enteredDigit, String attempts, String noofBoxes, String packageName, String hardwareAmount,
            String activityFees, String bonusAmount, String packageAmount, String accessoriesAmount, String totalAmount,
            String transactionType, String SRValidResponse, String SRPostResponse, String SUBIDValidResponse,
            String SUBIDPostResponse, String product, String dbCallDetailId) throws Exception {

        directcall directCall = new directcall();
        
        String strResponseXMLData = "";
        
        StringArray udfData = new StringArray();

        udfData.value = new ArrayList<String>();
        
        if (product.equalsIgnoreCase("Recharge")) {

            udfData.value.add(atomTxnUniqueId);

            udfData.value.add("");

            udfData.value.add(SubscriberId);

            udfData.value.add(userANI);

            udfData.value.add(ivrId);

            udfData.value.add(status);

            udfData.value.add(callStage + "|" + requiredDigit + "|" + enteredDigit + "|" + attempts);

            udfData.value.add("");

            udfData.value.add("");

            udfData.value.add(URLEncoder.encode(SUBIDValidResponse, "UTF-8"));

            udfData.value.add(URLEncoder.encode(SUBIDPostResponse, "UTF-8"));

            //Logged the PostDetails Request XML
            Logger.info(dbCallDetailId, "PostDetails Request String 1 :" + atomMerchantId + " String 2 : " + methodType + " String 3 : "
                    + serviceId + " String 4 : " + getAmount + " UDF : " + udfData.getValue(), false);

            // Call ATOM    
            strResponseXMLData = directCall.delegate(atomMerchantId, methodType, serviceId, getAmount, udfData, dbCallDetailId);

        } else if (product.equalsIgnoreCase("DirectSales")) {

            udfData.value.add(atomTxnUniqueId);

            udfData.value.add(userId);

            udfData.value.add(srNumber);

            udfData.value.add(userANI);

            udfData.value.add(ivrId);

            udfData.value.add(status);

            udfData.value.add(callStage + "|" + requiredDigit + "|" + enteredDigit + "|" + attempts);

            udfData.value.add(noofBoxes + "|" + packageName + "|" + hardwareAmount + "|" + activityFees + "|" + bonusAmount + "|" + packageAmount + "|" + accessoriesAmount + "|" + totalAmount);

            udfData.value.add(transactionType);

            udfData.value.add(URLEncoder.encode(SRValidResponse, "UTF-8"));

            udfData.value.add(URLEncoder.encode(SRPostResponse, "UTF-8"));

            //Logged the PostDetails Request XML
            Logger.info(dbCallDetailId, " String 1 :" + atomMerchantId + " String 2 : " + methodType + " String 3 : "
                    + serviceId + " String 4 : " + pricePoint + " UDF : " + udfData.getValue(), false);

            // Call ATOM    
            strResponseXMLData = directCall.delegate(atomMerchantId, methodType, serviceId, pricePoint, udfData, dbCallDetailId);
        }

        Logger.info(dbCallDetailId, "PostDetails Response XML : " + strResponseXMLData, false);
        
        atomMerchantId = methodType = serviceId = getAmount = pricePoint = atomTxnUniqueId = userId = srNumber =
                SubscriberId = userANI = ivrId = status = callStage = requiredDigit = enteredDigit = attempts = noofBoxes = packageName = hardwareAmount =
                activityFees = bonusAmount = packageAmount = accessoriesAmount = totalAmount = transactionType = SRValidResponse = SRPostResponse = SUBIDValidResponse =
                SUBIDPostResponse = product = dbCallDetailId = null;
        
        udfData = null;

        return new PostDetailsResponse(strResponseXMLData);
    }
}
