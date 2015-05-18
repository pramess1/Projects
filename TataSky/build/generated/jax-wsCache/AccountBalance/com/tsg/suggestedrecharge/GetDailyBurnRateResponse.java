
package com.tsg.suggestedrecharge;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for anonymous complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType>
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="getDailyBurnRateReturn" type="{http://dto.accountbalance.eai.tsky.com}AccountBalanceOutputDTO"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
    "getDailyBurnRateReturn"
})
@XmlRootElement(name = "getDailyBurnRateResponse")
public class GetDailyBurnRateResponse {

    @XmlElement(required = true, nillable = true)
    protected AccountBalanceOutputDTO getDailyBurnRateReturn;

    /**
     * Gets the value of the getDailyBurnRateReturn property.
     * 
     * @return
     *     possible object is
     *     {@link AccountBalanceOutputDTO }
     *     
     */
    public AccountBalanceOutputDTO getGetDailyBurnRateReturn() {
        return getDailyBurnRateReturn;
    }

    /**
     * Sets the value of the getDailyBurnRateReturn property.
     * 
     * @param value
     *     allowed object is
     *     {@link AccountBalanceOutputDTO }
     *     
     */
    public void setGetDailyBurnRateReturn(AccountBalanceOutputDTO value) {
        this.getDailyBurnRateReturn = value;
    }

}
