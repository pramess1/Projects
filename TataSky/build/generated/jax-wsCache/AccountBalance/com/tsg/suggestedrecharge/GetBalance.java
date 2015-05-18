
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
 *         &lt;element name="accountBalanceInputDTO" type="{http://dto.accountbalance.eai.tsky.com}AccountBalanceInputDTO"/>
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
    "accountBalanceInputDTO"
})
@XmlRootElement(name = "getBalance")
public class GetBalance {

    @XmlElement(required = true, nillable = true)
    protected AccountBalanceInputDTO accountBalanceInputDTO;

    /**
     * Gets the value of the accountBalanceInputDTO property.
     * 
     * @return
     *     possible object is
     *     {@link AccountBalanceInputDTO }
     *     
     */
    public AccountBalanceInputDTO getAccountBalanceInputDTO() {
        return accountBalanceInputDTO;
    }

    /**
     * Sets the value of the accountBalanceInputDTO property.
     * 
     * @param value
     *     allowed object is
     *     {@link AccountBalanceInputDTO }
     *     
     */
    public void setAccountBalanceInputDTO(AccountBalanceInputDTO value) {
        this.accountBalanceInputDTO = value;
    }

}
