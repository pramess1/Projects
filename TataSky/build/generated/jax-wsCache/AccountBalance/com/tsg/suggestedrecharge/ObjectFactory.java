
package com.tsg.suggestedrecharge;

import javax.xml.bind.annotation.XmlRegistry;


/**
 * This object contains factory methods for each 
 * Java content interface and Java element interface 
 * generated in the com.tsg.suggestedrecharge package. 
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


    /**
     * Create a new ObjectFactory that can be used to create new instances of schema derived classes for package: com.tsg.suggestedrecharge
     * 
     */
    public ObjectFactory() {
    }

    /**
     * Create an instance of {@link AccountBalanceInputDTO }
     * 
     */
    public AccountBalanceInputDTO createAccountBalanceInputDTO() {
        return new AccountBalanceInputDTO();
    }

    /**
     * Create an instance of {@link AccountBalanceOutputDTO }
     * 
     */
    public AccountBalanceOutputDTO createAccountBalanceOutputDTO() {
        return new AccountBalanceOutputDTO();
    }

    /**
     * Create an instance of {@link MissCallNrcDTO }
     * 
     */
    public MissCallNrcDTO createMissCallNrcDTO() {
        return new MissCallNrcDTO();
    }

    /**
     * Create an instance of {@link GetBalance }
     * 
     */
    public GetBalance createGetBalance() {
        return new GetBalance();
    }

    /**
     * Create an instance of {@link GetSuspendedDBR }
     * 
     */
    public GetSuspendedDBR createGetSuspendedDBR() {
        return new GetSuspendedDBR();
    }

    /**
     * Create an instance of {@link GetDailyBurnRate }
     * 
     */
    public GetDailyBurnRate createGetDailyBurnRate() {
        return new GetDailyBurnRate();
    }

    /**
     * Create an instance of {@link InvokeKenanNRC }
     * 
     */
    public InvokeKenanNRC createInvokeKenanNRC() {
        return new InvokeKenanNRC();
    }

    /**
     * Create an instance of {@link GetBalanceAndDBR }
     * 
     */
    public GetBalanceAndDBR createGetBalanceAndDBR() {
        return new GetBalanceAndDBR();
    }

    /**
     * Create an instance of {@link InvokeKenanNRCResponse }
     * 
     */
    public InvokeKenanNRCResponse createInvokeKenanNRCResponse() {
        return new InvokeKenanNRCResponse();
    }

    /**
     * Create an instance of {@link GetBalanceResponse }
     * 
     */
    public GetBalanceResponse createGetBalanceResponse() {
        return new GetBalanceResponse();
    }

    /**
     * Create an instance of {@link GetDailyBurnRateResponse }
     * 
     */
    public GetDailyBurnRateResponse createGetDailyBurnRateResponse() {
        return new GetDailyBurnRateResponse();
    }

    /**
     * Create an instance of {@link GetBalanceAndDBRResponse }
     * 
     */
    public GetBalanceAndDBRResponse createGetBalanceAndDBRResponse() {
        return new GetBalanceAndDBRResponse();
    }

    /**
     * Create an instance of {@link GetSuspendedDBRResponse }
     * 
     */
    public GetSuspendedDBRResponse createGetSuspendedDBRResponse() {
        return new GetSuspendedDBRResponse();
    }

}
