/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tsg.eai;

import com.tsg.common.ConfigurationReader;
import com.tsg.log.Logger;
import com.tsg.requesthandler.requestDelegator;

/**
 *
 * @author Rajesh
 */
public class EVDRecharge {

    public EVDRechargeResponse requestEVDRecharge(String subscriberId, String mobileNo,
            String pin, String recharegeAmount, String senddatetime, String dbCallDetailId) throws Exception {

        String xml = EVDRecharge(subscriberId, mobileNo, pin, recharegeAmount, senddatetime);
        
        subscriberId = mobileNo = pin = recharegeAmount = senddatetime = null;
        
        return makeEVDRechargeRequest(xml, dbCallDetailId);

    }

    public String EVDRecharge(String subscriberId, String mobileNo,
            String pin, String recharegeAmount, String senddatetime) {
        
        String username = ConfigurationReader.configList.get("EVD_USERNAME");
        
        String password = ConfigurationReader.configList.get("EVD_PASSWORD");

        StringBuilder builder = new StringBuilder();
        
        builder.append("username=" + username);
        
        builder.append("&password=" + password);
        
        builder.append("&msgid=" + "");
        
        builder.append("&mobileno=" + mobileNo);
        
        builder.append("&sprovider=" + "Genysis");
        
        builder.append("&keyvalue=" + "4." + pin + ".1." + recharegeAmount + "." + subscriberId + ".2");
        
        builder.append("&senddatetime=" + senddatetime);
        
        subscriberId = mobileNo = pin = recharegeAmount = senddatetime = null;
        
        return builder.toString();

    }

    private EVDRechargeResponse makeEVDRechargeRequest(String strRequestXMLData, String dbCallDetailId) throws Exception {

        requestDelegator objReqDelegator = new requestDelegator();

        Logger.info(dbCallDetailId, "EVDRecharge Request XML : " + strRequestXMLData, false);

        String strResponseXMLData = objReqDelegator.delegate("EVDRecharge", strRequestXMLData, dbCallDetailId);

        Logger.info(dbCallDetailId, "EVDRecharge Response XML : " + strResponseXMLData, false);

        dbCallDetailId = strRequestXMLData = null;
        
        return new EVDRechargeResponse(strResponseXMLData);

    }
}
