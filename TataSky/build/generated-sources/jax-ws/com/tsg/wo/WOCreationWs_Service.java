
package com.tsg.wo;

import java.net.MalformedURLException;
import java.net.URL;
import javax.xml.namespace.QName;
import javax.xml.ws.Service;
import javax.xml.ws.WebEndpoint;
import javax.xml.ws.WebServiceClient;
import javax.xml.ws.WebServiceException;
import javax.xml.ws.WebServiceFeature;


/**
 * This class was generated by the JAX-WS RI.
 * JAX-WS RI 2.2.6-1b01 
 * Generated source version: 2.2
 * 
 */
@WebServiceClient(name = "WOCreationWs", targetNamespace = "http://ws.tsg.com/", wsdlLocation = "http://10.30.0.75:8080/WOCreation/WOCreationWs?wsdl")
public class WOCreationWs_Service
    extends Service
{

    private final static URL WOCREATIONWS_WSDL_LOCATION;
    private final static WebServiceException WOCREATIONWS_EXCEPTION;
    private final static QName WOCREATIONWS_QNAME = new QName("http://ws.tsg.com/", "WOCreationWs");

    static {
        URL url = null;
        WebServiceException e = null;
        try {
            url = new URL("http://10.30.0.75:8080/WOCreation/WOCreationWs?wsdl");
        } catch (MalformedURLException ex) {
            e = new WebServiceException(ex);
        }
        WOCREATIONWS_WSDL_LOCATION = url;
        WOCREATIONWS_EXCEPTION = e;
    }

    public WOCreationWs_Service() {
        super(__getWsdlLocation(), WOCREATIONWS_QNAME);
    }

    public WOCreationWs_Service(WebServiceFeature... features) {
        super(__getWsdlLocation(), WOCREATIONWS_QNAME, features);
    }

    public WOCreationWs_Service(URL wsdlLocation) {
        super(wsdlLocation, WOCREATIONWS_QNAME);
    }

    public WOCreationWs_Service(URL wsdlLocation, WebServiceFeature... features) {
        super(wsdlLocation, WOCREATIONWS_QNAME, features);
    }

    public WOCreationWs_Service(URL wsdlLocation, QName serviceName) {
        super(wsdlLocation, serviceName);
    }

    public WOCreationWs_Service(URL wsdlLocation, QName serviceName, WebServiceFeature... features) {
        super(wsdlLocation, serviceName, features);
    }

    /**
     * 
     * @return
     *     returns WOCreationWs
     */
    @WebEndpoint(name = "WOCreationWsPort")
    public WOCreationWs getWOCreationWsPort() {
        return super.getPort(new QName("http://ws.tsg.com/", "WOCreationWsPort"), WOCreationWs.class);
    }

    /**
     * 
     * @param features
     *     A list of {@link javax.xml.ws.WebServiceFeature} to configure on the proxy.  Supported features not in the <code>features</code> parameter will have their default values.
     * @return
     *     returns WOCreationWs
     */
    @WebEndpoint(name = "WOCreationWsPort")
    public WOCreationWs getWOCreationWsPort(WebServiceFeature... features) {
        return super.getPort(new QName("http://ws.tsg.com/", "WOCreationWsPort"), WOCreationWs.class, features);
    }

    private static URL __getWsdlLocation() {
        if (WOCREATIONWS_EXCEPTION!= null) {
            throw WOCREATIONWS_EXCEPTION;
        }
        return WOCREATIONWS_WSDL_LOCATION;
    }

}
