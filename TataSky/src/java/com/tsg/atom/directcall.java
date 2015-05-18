/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tsg.atom;

import com.sun.xml.internal.ws.client.BindingProviderProperties;
import com.tsg.common.ConfigurationReader;
import com.tsg.log.Logger;
import java.util.Map;
import javax.xml.ws.BindingProvider;

/**
 *
 * @author Rajesh
 */
public class directcall {

    public String delegate(String atomMerchantId, String methodType, String serviceId, String amount, StringArray udfData, String dbCallDetailId) {

        String responseXml = null;

        responseXml = directCall(atomMerchantId, methodType, serviceId, amount, udfData, dbCallDetailId);

        atomMerchantId = methodType = serviceId = amount = null;

        return responseXml;
    }

    private String directCall(String atomMerchantId, String methodType, String serviceId, String amount, StringArray udfData, String dbCallDetailId) {

        try {
            
            String timeOut = ConfigurationReader.configList.get("Atom_Time_out");

            PaybuzzCaller service = new PaybuzzCaller();
          
            PaybuzzCallerService port = service.getPaybuzzCallerServicePort();
            
            Map<String, Object> requestContext = ((BindingProvider) port).getRequestContext();
            
            requestContext.put(BindingProviderProperties.CONNECT_TIMEOUT, Integer.parseInt(timeOut));
            
            requestContext.put(BindingProviderProperties.REQUEST_TIMEOUT, Integer.parseInt(timeOut));

            return port.directCall(atomMerchantId, methodType, serviceId, amount, udfData);

        } catch (Exception ex) {

            Logger.error(dbCallDetailId, "Exception While connecting the Atom : " + ex.getMessage(), false);

            return "failed";

        }
    }

    private String demoCaller(String atomMerchantId, String methodType, String serviceId, String amount, StringArray udfData, String dbCallDetailId) {

        try {

            PaybuzzCaller service = new PaybuzzCaller();

            PaybuzzCallerService port = service.getPaybuzzCallerServicePort();

            return port.demoCaller(atomMerchantId, methodType, serviceId, amount, udfData);

        } catch (Exception ex) {

            Logger.error(dbCallDetailId, "Exception While connecting the Atom : " + ex.getMessage(), false);

            return "failed";

        }

    }

    private String caller(String atomMerchantId, String methodType, String serviceId, String amount, StringArray udfData, String dbCallDetailId) {

        try {
            PaybuzzCaller service = new PaybuzzCaller();

            PaybuzzCallerService port = service.getPaybuzzCallerServicePort();

            return port.caller(atomMerchantId, methodType, serviceId, amount, udfData);

        } catch (Exception ex) {

            Logger.error(dbCallDetailId, "Exception While connecting the Atom : " + ex.getMessage(), false);

            return "failed";

        }
    }
}
