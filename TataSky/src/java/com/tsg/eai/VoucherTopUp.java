/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tsg.eai;

import com.tsg.log.Logger;
import com.tsg.requesthandler.requestDelegator;

/**
 *
 * @author Developer
 */
public class VoucherTopUp {

    public VoucherTopUpResponse requestVoucherTopUp(String ivrId,
            String subscriberNo, String voucherPin, String date, String dbCallDetailId) throws Exception {

        String xml = voucherTopUp(ivrId, subscriberNo, voucherPin, date);
        
        ivrId = subscriberNo = voucherPin = date = null;

        return makeVoucherTopUpRequest(xml, dbCallDetailId);

    }

    public String voucherTopUp(String ivrId, String subscriberNo, String voucherPin, String date) {

        StringBuilder builder = new StringBuilder();
        
        builder.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
        
        builder.append("<tata-sky>");
        
        builder.append("<acct-topup-request>");
        
        builder.append("<ivr-id>").append(ivrId).append("</ivr-id>");
        
        builder.append("<sub-no>").append(subscriberNo).append("</sub-no>");
        
        builder.append("<voucher-pin>").append(voucherPin).append("</voucher-pin>");
        
        builder.append("<date-time>").append(date).append("</date-time>");
        
        builder.append("</acct-topup-request>");
        
        builder.append("</tata-sky>");
        
        ivrId = subscriberNo = voucherPin = date = null;
        
        return new String(builder);

    }

    private VoucherTopUpResponse makeVoucherTopUpRequest(String strRequestXMLData, String dbCallDetailId) throws Exception {

        requestDelegator objReqDelegator = new requestDelegator();

        Logger.info(dbCallDetailId, "VoucherTopUp Request XML : " + strRequestXMLData, false);

        String strResponseXMLData = objReqDelegator.delegate("VoucherTopup", strRequestXMLData, dbCallDetailId);

        Logger.info(dbCallDetailId, "VoucherTopUp Response XML : " + strResponseXMLData, false);

        dbCallDetailId = strRequestXMLData = null;

        return new VoucherTopUpResponse(strResponseXMLData);
    }
}
