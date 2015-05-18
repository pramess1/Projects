package com.tsg.common.rule;

import java.util.ArrayList;
import java.util.List;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;

/**
 * <p>Java class for anonymous complex type.
 *
 * <p>The following schema fragment specifies the expected content contained
 * within this class.
 *
 * <pre>
 * &lt;complexType>
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="Rule" maxOccurs="unbounded">
 *           &lt;complexType>
 *             &lt;complexContent>
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *                 &lt;attribute name="expr" type="{http://www.w3.org/2001/XMLSchema}string" />
 *                 &lt;attribute name="action" type="{http://www.w3.org/2001/XMLSchema}string" />
 *                 &lt;attribute name="code" type="{http://www.w3.org/2001/XMLSchema}string" />
 *                 &lt;attribute name="callFlowID" type="{http://www.w3.org/2001/XMLSchema}int" />
 *                 &lt;attribute name="priority" type="{http://www.w3.org/2001/XMLSchema}int" />
 *               &lt;/restriction>
 *             &lt;/complexContent>
 *           &lt;/complexType>
 *         &lt;/element>
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
    "rule"
})
@XmlRootElement(name = "tblRules")
public class TblRules {

    @XmlElement(name = "Rule", required = true)
    protected List<TblRules.Rule> rule;

    /**
     * Gets the value of the rule property.
     *
     * <p> This accessor method returns a reference to the live list, not a
     * snapshot. Therefore any modification you make to the returned list will
     * be present inside the JAXB object. This is why there is not a
     * <CODE>set</CODE> method for the rule property.
     *
     * <p> For example, to add a new item, do as follows:
     * <pre>
     *    getRule().add(newItem);
     * </pre>
     *
     *
     * <p> Objects of the following type(s) are allowed in the list
     * {@link TblRules.Rule }
     *
     *
     */
    public List<TblRules.Rule> getRule() {
        if (rule == null) {
            rule = new ArrayList<TblRules.Rule>();
        }
        return this.rule;
    }

    /**
     * <p>Java class for anonymous complex type.
     *
     * <p>The following schema fragment specifies the expected content contained
     * within this class.
     *
     * <pre>
     * &lt;complexType>
     *   &lt;complexContent>
     *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
     *       &lt;attribute name="expr" type="{http://www.w3.org/2001/XMLSchema}string" />
     *       &lt;attribute name="action" type="{http://www.w3.org/2001/XMLSchema}string" />
     *       &lt;attribute name="code" type="{http://www.w3.org/2001/XMLSchema}string" />
     *       &lt;attribute name="callFlowID" type="{http://www.w3.org/2001/XMLSchema}int" />
     *       &lt;attribute name="priority" type="{http://www.w3.org/2001/XMLSchema}int" />
     *       &lt;attribute name="
     * " type="{http://www.w3.org/2001/XMLSchema}int" />
     *     &lt;/restriction>
     *   &lt;/complexContent>
     * &lt;/complexType>
     * </pre>
     *
     *
     */
    @XmlAccessorType(XmlAccessType.FIELD)
    @XmlType(name = "")
    public static class Rule implements Comparable<Rule> {

        @XmlAttribute
        protected String expr;
        @XmlAttribute
        protected String action;
        @XmlAttribute
        protected String code;
        @XmlAttribute
        protected Integer callFlowID;
        @XmlAttribute
        public Integer priority;
        @XmlAttribute
        public Integer ruleID;
        @XmlAttribute
        public String ruleDesc;

        /**
         * Gets the value of the expr property.
         *
         * @return possible object is {@link String }
         *
         */
        public String getExpr() {
            return expr;
        }

        /**
         * Sets the value of the expr property.
         *
         * @param value allowed object is {@link String }
         *
         */
        public void setExpr(String value) {
            this.expr = value;
        }

        public String getRuleDesc() {
            return ruleDesc;
        }

        public void setRuleDesc(String value) {
            this.ruleDesc = value;
        }

        /**
         * Gets the value of the action property.
         *
         * @return possible object is {@link Integer }
         *
         */
        public String getAction() {
            return action;
        }

        /**
         * Sets the value of the action property.
         *
         * @param value allowed object is {@link Integer }
         *
         */
        public void setAction(String value) {
            this.action = value;
        }

        /**
         * Gets the value of the code property.
         *
         * @return possible object is {@link String }
         *
         */
        public String getCode() {
            return code;
        }

        /**
         * Sets the value of the code property.
         *
         * @param value allowed object is {@link String }
         *
         */
        public void setCode(String value) {
            this.code = value;
        }

        /**
         * Gets the value of the callFlowID property.
         *
         * @return possible object is {@link Integer }
         *
         */
        public Integer getCallFlowID() {
            return callFlowID;
        }

        /**
         * Sets the value of the callFlowID property.
         *
         * @param value allowed object is {@link Integer }
         *
         */
        public void setCallFlowID(Integer value) {
            this.callFlowID = value;
        }

        /**
         * Gets the value of the priority property.
         *
         * @return possible object is {@link Integer }
         *
         */
        public Integer getPriority() {
            return priority;
        }

        /**
         * Sets the value of the priority property.
         *
         * @param value allowed object is {@link Integer }
         *
         */
        public void setPriority(Integer value) {
            this.priority = value;
        }

        public void setRuleID(Integer ruleID) {
            this.ruleID = ruleID;
        }

        public Integer getRuleID() {
            return ruleID;
        }

        @Override
        public int compareTo(Rule oRule) {
            if (this.priority < oRule.priority) {
                return -1;
            } else if (this.priority > oRule.priority) {
                return 1;
            } else {
                return 0;
            }
        }
    }
}
