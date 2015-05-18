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
public class AccountBalance {

    //public static final Logger log = Logger.getLogger(AccountBalance.class);
    public AccountBalanceResponse requestAccountBalance(String ivrId,
            String subscriberNumber, String dateTime, String dbCallDetailId) throws Exception {

        String xml = accountBalance(ivrId, subscriberNumber, dateTime);

        ivrId = subscriberNumber = dateTime = null;

        return makeAccountBalanceRequest(xml, dbCallDetailId);

    }

    public String accountBalance(String ivrId, String subscriberNumber, String dateTime) {

        StringBuilder builder = new StringBuilder();
        
        builder.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
        
        builder.append("<tata-sky>");
        
        builder.append("<acct-bal-request>");
        
        builder.append("<ivr-id>").append(ivrId).append("</ivr-id>");
        
        builder.append("<sub-no>").append(subscriberNumber).append("</sub-no>");
        
        builder.append("<date-time>").append(dateTime).append("</date-time>");
        
        builder.append("</acct-bal-request>");
        
        builder.append("</tata-sky>");
        
        ivrId = subscriberNumber = dateTime = null;
        
        return new String(builder);

    }

    private AccountBalanceResponse makeAccountBalanceRequest(String strRequestXMLData, String dbCallDetailId) throws Exception {

        requestDelegator objReqDelegator = new requestDelegator();

        Logger.info(dbCallDetailId, "AccountBalance Request XML : " + strRequestXMLData, false);

        String strResponseXMLData = objReqDelegator.delegate("AccountBalance", strRequestXMLData, dbCallDetailId);

        Logger.info(dbCallDetailId, "AccountBalance Response XML : " + strResponseXMLData, false);

        dbCallDetailId = strRequestXMLData = null;

        return new AccountBalanceResponse(strResponseXMLData);
    }
}
