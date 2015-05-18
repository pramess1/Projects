
package com.tsg.wo;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlElementDecl;
import javax.xml.bind.annotation.XmlRegistry;
import javax.xml.namespace.QName;


/**
 * This object contains factory methods for each 
 * Java content interface and Java element interface 
 * generated in the com.tsg.wo package. 
 * <p>An ObjectFactory allows you to programatically 
 * construct new instances of the Java representation 
 * for XML content. The Java representation of XML 
 * content can consist of schema derived interfaces 
 * and classes representing the binding of schema 
 * type definitions, element declarations and model 
 * groups.  Factory methods for each of these are 
 * provided in this class.
 * 
 */
@XmlRegistry
public class ObjectFactory {

    private final static QName _WoWebServiceResponse_QNAME = new QName("http://ws.tsg.com/", "woWebServiceResponse");
    private final static QName _HelloResponse_QNAME = new QName("http://ws.tsg.com/", "helloResponse");
    private final static QName _WoWebService_QNAME = new QName("http://ws.tsg.com/", "woWebService");
    private final static QName _Hello_QNAME = new QName("http://ws.tsg.com/", "hello");

    /**
     * Create a new ObjectFactory that can be used to create new instances of schema derived classes for package: com.tsg.wo
     * 
     */
    public ObjectFactory() {
    }

    /**
     * Create an instance of {@link Hello }
     * 
     */
    public Hello createHello() {
        return new Hello();
    }

    /**
     * Create an instance of {@link HelloResponse }
     * 
     */
    public HelloResponse createHelloResponse() {
        return new HelloResponse();
    }

    /**
     * Create an instance of {@link WoWebService }
     * 
     */
    public WoWebService createWoWebService() {
        return new WoWebService();
    }

    /**
     * Create an instance of {@link WoWebServiceResponse }
     * 
     */
    public WoWebServiceResponse createWoWebServiceResponse() {
        return new WoWebServiceResponse();
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link WoWebServiceResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://ws.tsg.com/", name = "woWebServiceResponse")
    public JAXBElement<WoWebServiceResponse> createWoWebServiceResponse(WoWebServiceResponse value) {
        return new JAXBElement<WoWebServiceResponse>(_WoWebServiceResponse_QNAME, WoWebServiceResponse.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link HelloResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://ws.tsg.com/", name = "helloResponse")
    public JAXBElement<HelloResponse> createHelloResponse(HelloResponse value) {
        return new JAXBElement<HelloResponse>(_HelloResponse_QNAME, HelloResponse.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link WoWebService }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://ws.tsg.com/", name = "woWebService")
    public JAXBElement<WoWebService> createWoWebService(WoWebService value) {
        return new JAXBElement<WoWebService>(_WoWebService_QNAME, WoWebService.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link Hello }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://ws.tsg.com/", name = "hello")
    public JAXBElement<Hello> createHello(Hello value) {
        return new JAXBElement<Hello>(_Hello_QNAME, Hello.class, null, value);
    }

}
