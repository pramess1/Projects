/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tsg.suggestedrecharge;

import com.sun.xml.internal.ws.client.BindingProviderProperties;
import com.tsg.common.ConfigurationReader;
import com.tsg.log.Logger;
import java.text.DecimalFormat;
import java.util.Map;
import javax.xml.ws.BindingProvider;

/**
 *
 * @author Rajesh
 */
public class SuggestedRecharge {

    public SuggestedRecharge() {
    }

    public String SuggestedRechargeAmount(String subscriberId, String dbCallDetailId) {

        try {

            String timeOut = ConfigurationReader.configList.get("Suggested_Recharge_Time_out");

            AccountBalanceService service = new AccountBalanceService();

            AccountBalance port = service.getAccountBalance();

            Map<String, Object> requestContext = ((BindingProvider) port).getRequestContext();

            requestContext.put(BindingProviderProperties.CONNECT_TIMEOUT, Integer.parseInt(timeOut));

            requestContext.put(BindingProviderProperties.REQUEST_TIMEOUT, Integer.parseInt(timeOut));

            AccountBalanceInputDTO inputData = new AccountBalanceInputDTO();

            inputData.setSubscriberNo(subscriberId);

            AccountBalanceOutputDTO result = port.getSuspendedDBR(inputData);

            double primaryBurnRate = result.getPrimaryBurnRate();

            primaryBurnRate = ((primaryBurnRate * 365) / 12);

            DecimalFormat df = new DecimalFormat("#.##");

            Logger.info(dbCallDetailId, " Suggested Recharge Amount for " + subscriberId + " and amount : " + primaryBurnRate, false);

            return Double.valueOf(df.format(primaryBurnRate)).toString();

        } catch (Exception ex) {

            Logger.warn(dbCallDetailId, " Exception in Suggested Recharge Amount Page :" + subscriberId + " Message : " + ex.getMessage(), false);

            return "0";

        } finally {

            subscriberId = dbCallDetailId = null;
        }
    }
}
