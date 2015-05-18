
package com.tsg.suggestedrecharge;

import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebResult;
import javax.jws.WebService;
import javax.xml.bind.annotation.XmlSeeAlso;
import javax.xml.ws.RequestWrapper;
import javax.xml.ws.ResponseWrapper;


/**
 * This class was generated by the JAX-WS RI.
 * JAX-WS RI 2.2.6-1b01 
 * Generated source version: 2.2
 * 
 */
@WebService(name = "AccountBalance", targetNamespace = "http://ejbs")
@XmlSeeAlso({
    ObjectFactory.class
})
public interface AccountBalance {


    /**
     * 
     * @param accountBalanceInputDTO
     * @return
     *     returns com.tsg.suggestedrecharge.AccountBalanceOutputDTO
     */
    @WebMethod
    @WebResult(name = "getBalanceReturn", targetNamespace = "")
    @RequestWrapper(localName = "getBalance", targetNamespace = "http://ejbs", className = "com.tsg.suggestedrecharge.GetBalance")
    @ResponseWrapper(localName = "getBalanceResponse", targetNamespace = "http://ejbs", className = "com.tsg.suggestedrecharge.GetBalanceResponse")
    public AccountBalanceOutputDTO getBalance(
        @WebParam(name = "accountBalanceInputDTO", targetNamespace = "")
        AccountBalanceInputDTO accountBalanceInputDTO);

    /**
     * 
     * @param mcndto
     * @return
     *     returns com.tsg.suggestedrecharge.MissCallNrcDTO
     */
    @WebMethod
    @WebResult(name = "invokeKenanNRCReturn", targetNamespace = "")
    @RequestWrapper(localName = "invokeKenanNRC", targetNamespace = "http://ejbs", className = "com.tsg.suggestedrecharge.InvokeKenanNRC")
    @ResponseWrapper(localName = "invokeKenanNRCResponse", targetNamespace = "http://ejbs", className = "com.tsg.suggestedrecharge.InvokeKenanNRCResponse")
    public MissCallNrcDTO invokeKenanNRC(
        @WebParam(name = "mcndto", targetNamespace = "")
        MissCallNrcDTO mcndto);

    /**
     * 
     * @param inputData
     * @return
     *     returns com.tsg.suggestedrecharge.AccountBalanceOutputDTO
     */
    @WebMethod
    @WebResult(name = "getSuspendedDBRReturn", targetNamespace = "")
    @RequestWrapper(localName = "getSuspendedDBR", targetNamespace = "http://ejbs", className = "com.tsg.suggestedrecharge.GetSuspendedDBR")
    @ResponseWrapper(localName = "getSuspendedDBRResponse", targetNamespace = "http://ejbs", className = "com.tsg.suggestedrecharge.GetSuspendedDBRResponse")
    public AccountBalanceOutputDTO getSuspendedDBR(
        @WebParam(name = "inputData", targetNamespace = "")
        AccountBalanceInputDTO inputData);

    /**
     * 
     * @param accountBalanceInputDTO
     * @return
     *     returns com.tsg.suggestedrecharge.AccountBalanceOutputDTO
     */
    @WebMethod
    @WebResult(name = "getDailyBurnRateReturn", targetNamespace = "")
    @RequestWrapper(localName = "getDailyBurnRate", targetNamespace = "http://ejbs", className = "com.tsg.suggestedrecharge.GetDailyBurnRate")
    @ResponseWrapper(localName = "getDailyBurnRateResponse", targetNamespace = "http://ejbs", className = "com.tsg.suggestedrecharge.GetDailyBurnRateResponse")
    public AccountBalanceOutputDTO getDailyBurnRate(
        @WebParam(name = "accountBalanceInputDTO", targetNamespace = "")
        AccountBalanceInputDTO accountBalanceInputDTO);

    /**
     * 
     * @param accountBalanceInputDTO
     * @return
     *     returns com.tsg.suggestedrecharge.AccountBalanceOutputDTO
     */
    @WebMethod
    @WebResult(name = "getBalanceAndDBRReturn", targetNamespace = "")
    @RequestWrapper(localName = "getBalanceAndDBR", targetNamespace = "http://ejbs", className = "com.tsg.suggestedrecharge.GetBalanceAndDBR")
    @ResponseWrapper(localName = "getBalanceAndDBRResponse", targetNamespace = "http://ejbs", className = "com.tsg.suggestedrecharge.GetBalanceAndDBRResponse")
    public AccountBalanceOutputDTO getBalanceAndDBR(
        @WebParam(name = "accountBalanceInputDTO", targetNamespace = "")
        AccountBalanceInputDTO accountBalanceInputDTO);

}
