
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
 *         &lt;element name="getBalanceReturn" type="{http://dto.accountbalance.eai.tsky.com}AccountBalanceOutputDTO"/>
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
    "getBalanceReturn"
})
@XmlRootElement(name = "getBalanceResponse")
public class GetBalanceResponse {

    @XmlElement(required = true, nillable = true)
    protected AccountBalanceOutputDTO getBalanceReturn;

    /**
     * Gets the value of the getBalanceReturn property.
     * 
     * @return
     *     possible object is
     *     {@link AccountBalanceOutputDTO }
     *     
     */
    public AccountBalanceOutputDTO getGetBalanceReturn() {
        return getBalanceReturn;
    }

    /**
     * Sets the value of the getBalanceReturn property.
     * 
     * @param value
     *     allowed object is
     *     {@link AccountBalanceOutputDTO }
     *     
     */
    public void setGetBalanceReturn(AccountBalanceOutputDTO value) {
        this.getBalanceReturn = value;
    }

}
