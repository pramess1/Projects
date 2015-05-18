
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
 *         &lt;element name="getSuspendedDBRReturn" type="{http://dto.accountbalance.eai.tsky.com}AccountBalanceOutputDTO"/>
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
    "getSuspendedDBRReturn"
})
@XmlRootElement(name = "getSuspendedDBRResponse")
public class GetSuspendedDBRResponse {

    @XmlElement(required = true, nillable = true)
    protected AccountBalanceOutputDTO getSuspendedDBRReturn;

    /**
     * Gets the value of the getSuspendedDBRReturn property.
     * 
     * @return
     *     possible object is
     *     {@link AccountBalanceOutputDTO }
     *     
     */
    public AccountBalanceOutputDTO getGetSuspendedDBRReturn() {
        return getSuspendedDBRReturn;
    }

    /**
     * Sets the value of the getSuspendedDBRReturn property.
     * 
     * @param value
     *     allowed object is
     *     {@link AccountBalanceOutputDTO }
     *     
     */
    public void setGetSuspendedDBRReturn(AccountBalanceOutputDTO value) {
        this.getSuspendedDBRReturn = value;
    }

}
