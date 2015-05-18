
package com.tsg.suggestedrecharge;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for AccountBalanceOutputDTO complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="AccountBalanceOutputDTO">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="currentConsumption" type="{http://www.w3.org/2001/XMLSchema}double"/>
 *         &lt;element name="rechargeEstVas" type="{http://www.w3.org/2001/XMLSchema}double"/>
 *         &lt;element name="rechargeEstWOVas" type="{http://www.w3.org/2001/XMLSchema}double"/>
 *         &lt;element name="suggestedLDPPack" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="errorCode" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="errorMsg" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="currentBalance" type="{http://www.w3.org/2001/XMLSchema}double"/>
 *         &lt;element name="endDate" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="primaryBurnRate" type="{http://www.w3.org/2001/XMLSchema}double"/>
 *         &lt;element name="totalBurnRate" type="{http://www.w3.org/2001/XMLSchema}double"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "AccountBalanceOutputDTO", namespace = "http://dto.accountbalance.eai.tsky.com", propOrder = {
    "currentConsumption",
    "rechargeEstVas",
    "rechargeEstWOVas",
    "suggestedLDPPack",
    "errorCode",
    "errorMsg",
    "currentBalance",
    "endDate",
    "primaryBurnRate",
    "totalBurnRate"
})
public class AccountBalanceOutputDTO {

    protected double currentConsumption;
    protected double rechargeEstVas;
    protected double rechargeEstWOVas;
    @XmlElement(required = true, nillable = true)
    protected String suggestedLDPPack;
    @XmlElement(required = true, nillable = true)
    protected String errorCode;
    @XmlElement(required = true, nillable = true)
    protected String errorMsg;
    protected double currentBalance;
    @XmlElement(required = true, nillable = true)
    protected String endDate;
    protected double primaryBurnRate;
    protected double totalBurnRate;

    /**
     * Gets the value of the currentConsumption property.
     * 
     */
    public double getCurrentConsumption() {
        return currentConsumption;
    }

    /**
     * Sets the value of the currentConsumption property.
     * 
     */
    public void setCurrentConsumption(double value) {
        this.currentConsumption = value;
    }

    /**
     * Gets the value of the rechargeEstVas property.
     * 
     */
    public double getRechargeEstVas() {
        return rechargeEstVas;
    }

    /**
     * Sets the value of the rechargeEstVas property.
     * 
     */
    public void setRechargeEstVas(double value) {
        this.rechargeEstVas = value;
    }

    /**
     * Gets the value of the rechargeEstWOVas property.
     * 
     */
    public double getRechargeEstWOVas() {
        return rechargeEstWOVas;
    }

    /**
     * Sets the value of the rechargeEstWOVas property.
     * 
     */
    public void setRechargeEstWOVas(double value) {
        this.rechargeEstWOVas = value;
    }

    /**
     * Gets the value of the suggestedLDPPack property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSuggestedLDPPack() {
        return suggestedLDPPack;
    }

    /**
     * Sets the value of the suggestedLDPPack property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSuggestedLDPPack(String value) {
        this.suggestedLDPPack = value;
    }

    /**
     * Gets the value of the errorCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getErrorCode() {
        return errorCode;
    }

    /**
     * Sets the value of the errorCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setErrorCode(String value) {
        this.errorCode = value;
    }

    /**
     * Gets the value of the errorMsg property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getErrorMsg() {
        return errorMsg;
    }

    /**
     * Sets the value of the errorMsg property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setErrorMsg(String value) {
        this.errorMsg = value;
    }

    /**
     * Gets the value of the currentBalance property.
     * 
     */
    public double getCurrentBalance() {
        return currentBalance;
    }

    /**
     * Sets the value of the currentBalance property.
     * 
     */
    public void setCurrentBalance(double value) {
        this.currentBalance = value;
    }

    /**
     * Gets the value of the endDate property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getEndDate() {
        return endDate;
    }

    /**
     * Sets the value of the endDate property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setEndDate(String value) {
        this.endDate = value;
    }

    /**
     * Gets the value of the primaryBurnRate property.
     * 
     */
    public double getPrimaryBurnRate() {
        return primaryBurnRate;
    }

    /**
     * Sets the value of the primaryBurnRate property.
     * 
     */
    public void setPrimaryBurnRate(double value) {
        this.primaryBurnRate = value;
    }

    /**
     * Gets the value of the totalBurnRate property.
     * 
     */
    public double getTotalBurnRate() {
        return totalBurnRate;
    }

    /**
     * Sets the value of the totalBurnRate property.
     * 
     */
    public void setTotalBurnRate(double value) {
        this.totalBurnRate = value;
    }

}
