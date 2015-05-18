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
public class CreateActivity {

    public CreateActivityResponse requestCreateActivity(String atomIvrId,
            String tataskyTransId, String date, String srNumber, String atomTransId, String TransStatus,
            String bankReferenceNo, String bankRRRNo, String paymentTransId, String transAmount,
            String productCode, String bonusAmount, String hardwareAmount, String packageAmount,
            String totalAmount, String merchantId, String userId, String activationFee, String accessoryAmount, String dbCallDetailId) throws Exception {

        String xml = createActivity(atomIvrId, tataskyTransId, date, srNumber, atomTransId,
                TransStatus, bankReferenceNo, bankRRRNo, paymentTransId, transAmount, productCode, bonusAmount,
                hardwareAmount, packageAmount, totalAmount, merchantId, userId, activationFee, accessoryAmount);
        
        atomIvrId = tataskyTransId = date = srNumber = atomTransId = TransStatus = activationFee = accessoryAmount = bankReferenceNo = bankRRRNo = paymentTransId = transAmount = productCode = bonusAmount = hardwareAmount = packageAmount = totalAmount = merchantId = userId = null;

        return makeCreateActivityRequest(xml, dbCallDetailId);

    }

    public String createActivity(String atomIvrId, String tataskyTransId, String date, String srNumber,
            String atomTransId, String TransStatus, String bankReferenceNo, String bankRRRNo, String paymentTransId,
            String transAmount, String productCode, String bonusAmount, String hardwareAmount,
            String packageAmount, String totalAmount, String merchantId, String userId, String activationFee, String accessoryAmount) {

        StringBuilder builder = new StringBuilder();
        
        //builder.append("<?xml version=\"1.0\" encoding=\"UTF-8\" ?>");
        
        builder.append("<tata-sky>");
        
        builder.append("<ds-txn-request>");
        
        builder.append("<atom-ivr-id>").append(atomIvrId).append("</atom-ivr-id>");
        
        builder.append("<tatasky-txn-id>").append(tataskyTransId).append("</tatasky-txn-id>");
        
        builder.append("<date-time>").append(date).append("</date-time>");
        
        builder.append("<srNumber>").append(srNumber).append("</srNumber>");
        
        builder.append("<atomTxnId>").append(atomTransId).append("</atomTxnId>");
        
        builder.append("<txnStatus>").append(TransStatus).append("</txnStatus>");
        
        builder.append("<bankRefNo>").append(bankReferenceNo).append("</bankRefNo>");
        
        builder.append("<bankRRNNo>").append(bankRRRNo).append("</bankRRNNo>");
        
        builder.append("<pgTxnId>").append(paymentTransId).append("</pgTxnId>");
        
        builder.append("<txnAmount>").append(transAmount).append("</txnAmount>");
        
        builder.append("<productCode>").append(productCode).append("</productCode>");
        
        builder.append("<bonusAmount>").append(bonusAmount).append("</bonusAmount>");
        
        builder.append("<hardwareAmount>").append(hardwareAmount).append("</hardwareAmount>");
        
        builder.append("<packageAmount>").append(packageAmount).append("</packageAmount>");
        
        builder.append("<totalAmount>").append(totalAmount).append("</totalAmount>");
        
        builder.append("<merchantid>").append(merchantId).append("</merchantid>");
        
        builder.append("<userid>").append(userId).append("</userid>");
        
        builder.append("<activationFee>").append(activationFee).append("</activationFee>");
        
        builder.append("<accessoryAmount>").append(accessoryAmount).append("</accessoryAmount>");
        
        builder.append("</ds-txn-request>");
        
        builder.append("</tata-sky>");
        
        atomIvrId = tataskyTransId = date = srNumber = activationFee = accessoryAmount = atomTransId = TransStatus = bankReferenceNo = bankRRRNo = paymentTransId = transAmount = productCode = bonusAmount = hardwareAmount = packageAmount = totalAmount = merchantId = userId = null;
        
        return new String(builder);

    }

    private CreateActivityResponse makeCreateActivityRequest(String strRequestXMLData, String dbCallDetailId) throws Exception {
        
        requestDelegator objReqDelegator = new requestDelegator();
        
        Logger.info(dbCallDetailId, "CreateActivity Request XML : " + strRequestXMLData, false);
       
        String strResponseXMLData = objReqDelegator.delegate("CreateActivityPortal", strRequestXMLData, dbCallDetailId);
       
        Logger.info(dbCallDetailId, "CreateActivity Response XML : " + strResponseXMLData, false);
        
        dbCallDetailId = strRequestXMLData = null;
       
        return new CreateActivityResponse(strResponseXMLData);

    }
}