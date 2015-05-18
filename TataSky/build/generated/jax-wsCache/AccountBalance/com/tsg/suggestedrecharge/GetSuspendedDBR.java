
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
 *         &lt;element name="inputData" type="{http://dto.accountbalance.eai.tsky.com}AccountBalanceInputDTO"/>
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
    "inputData"
})
@XmlRootElement(name = "getSuspendedDBR")
public class GetSuspendedDBR {

    @XmlElement(required = true, nillable = true)
    protected AccountBalanceInputDTO inputData;

    /**
     * Gets the value of the inputData property.
     * 
     * @return
     *     possible object is
     *     {@link AccountBalanceInputDTO }
     *     
     */
    public AccountBalanceInputDTO getInputData() {
        return inputData;
    }

    /**
     * Sets the value of the inputData property.
     * 
     * @param value
     *     allowed object is
     *     {@link AccountBalanceInputDTO }
     *     
     */
    public void setInputData(AccountBalanceInputDTO value) {
        this.inputData = value;
    }

}
