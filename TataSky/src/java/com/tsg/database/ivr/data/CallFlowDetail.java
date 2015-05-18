///*
// * To change this template, choose Tools | Templates
// * and open the template in the editor.
// */
//package com.tsg.database.ivr.data;
//
//import java.io.Serializable;
//import java.math.BigDecimal;
//import java.math.BigInteger;
//import java.util.Date;
//import javax.persistence.Basic;
//import javax.persistence.Column;
//import javax.persistence.Entity;
//import javax.persistence.Id;
//import javax.persistence.NamedQueries;
//import javax.persistence.NamedQuery;
//import javax.persistence.Table;
//import javax.persistence.Temporal;
//import javax.persistence.TemporalType;
//import javax.xml.bind.annotation.XmlRootElement;
//
///**
// *
// * @author Developer
// */
//@Entity
//@Table(name = "TBLCALLFLOWDETAIL")
//@XmlRootElement
//@NamedQueries({
//    @NamedQuery(name = "CallFlowDetail.findAll", query = "SELECT c FROM CallFlowDetail c")})
//public class CallFlowDetail implements Serializable {
//    private static final long serialVersionUID = 1L;
//    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
//    @Id
//    @Basic(optional = false)
//    @Column(name = "FLDCALLFLOWDETAILID")
//    private BigDecimal fldcallflowdetailid;
//    @Column(name = "FLDCALLFLOWDATETIME")
//    @Temporal(TemporalType.TIMESTAMP)
//    private Date fldcallflowdatetime;
//    @Column(name = "FLDCFFIRSTINPUTSTARTDATETIME")
//    @Temporal(TemporalType.TIMESTAMP)
//    private Date fldcffirstinputstartdatetime;
//    @Column(name = "FLDCFFIRSTINPUTENDDATETIME")
//    @Temporal(TemporalType.TIMESTAMP)
//    private Date fldcffirstinputenddatetime;
//    @Column(name = "FLDFIRSTINPUTID")
//    private String fldfirstinputid;
//    @Column(name = "FLDFIRSTINPUTVALUE")
//    private String fldfirstinputvalue;
//    @Column(name = "FLDCFSECONDINPUTSTARTDATETIME")
//    @Temporal(TemporalType.TIMESTAMP)
//    private Date fldcfsecondinputstartdatetime;
//    @Column(name = "FLDCFSECONDINPUTENDDATETIME")
//    @Temporal(TemporalType.TIMESTAMP)
//    private Date fldcfsecondinputenddatetime;
//    @Column(name = "FLDSECONDINPUTID")
//    private String fldsecondinputid;
//    @Column(name = "FLDSECONDINPUTVALUE")
//    private String fldsecondinputvalue;
//    @Column(name = "FLDCFTHIRDINPUTSTARTDATETIME")
//    @Temporal(TemporalType.TIMESTAMP)
//    private Date fldcfthirdinputstartdatetime;
//    @Column(name = "FLDCFTHIRDINPUTENDDATETIME")
//    @Temporal(TemporalType.TIMESTAMP)
//    private Date fldcfthirdinputenddatetime;
//    @Column(name = "FLDTHIRDINPUTID")
//    private String fldthirdinputid;
//    @Column(name = "FLDTHIRDINPUTVALUE")
//    private String fldthirdinputvalue;
//    @Column(name = "FLDNOOFATTEMPTS")
//    private BigInteger fldnoofattempts;
//    @Column(name = "FLDISSUCCESS")
//    private Character fldissuccess;
//    @Column(name = "FLDCREATEDBY")
//    private String fldcreatedby;
//    @Column(name = "FLDCREATEDDATE")
//    @Temporal(TemporalType.TIMESTAMP)
//    private Date fldcreateddate;
//    @Column(name = "FLDUPDATEDBY")
//    private String fldupdatedby;
//    @Column(name = "FLDUPDATEDDATE")
//    @Temporal(TemporalType.TIMESTAMP)
//    private Date fldupdateddate;
//
//    public CallFlowDetail() {
//    }
//
//    public CallFlowDetail(BigDecimal fldcallflowdetailid) {
//        this.fldcallflowdetailid = fldcallflowdetailid;
//    }
//
//    public BigDecimal getFldcallflowdetailid() {
//        return fldcallflowdetailid;
//    }
//
//    public void setFldcallflowdetailid(BigDecimal fldcallflowdetailid) {
//        this.fldcallflowdetailid = fldcallflowdetailid;
//    }
//
//    public Date getFldcallflowdatetime() {
//        return fldcallflowdatetime;
//    }
//
//    public void setFldcallflowdatetime(Date fldcallflowdatetime) {
//        this.fldcallflowdatetime = fldcallflowdatetime;
//    }
//
//    public Date getFldcffirstinputstartdatetime() {
//        return fldcffirstinputstartdatetime;
//    }
//
//    public void setFldcffirstinputstartdatetime(Date fldcffirstinputstartdatetime) {
//        this.fldcffirstinputstartdatetime = fldcffirstinputstartdatetime;
//    }
//
//    public Date getFldcffirstinputenddatetime() {
//        return fldcffirstinputenddatetime;
//    }
//
//    public void setFldcffirstinputenddatetime(Date fldcffirstinputenddatetime) {
//        this.fldcffirstinputenddatetime = fldcffirstinputenddatetime;
//    }
//
//    public String getFldfirstinputid() {
//        return fldfirstinputid;
//    }
//
//    public void setFldfirstinputid(String fldfirstinputid) {
//        this.fldfirstinputid = fldfirstinputid;
//    }
//
//    public String getFldfirstinputvalue() {
//        return fldfirstinputvalue;
//    }
//
//    public void setFldfirstinputvalue(String fldfirstinputvalue) {
//        this.fldfirstinputvalue = fldfirstinputvalue;
//    }
//
//    public Date getFldcfsecondinputstartdatetime() {
//        return fldcfsecondinputstartdatetime;
//    }
//
//    public void setFldcfsecondinputstartdatetime(Date fldcfsecondinputstartdatetime) {
//        this.fldcfsecondinputstartdatetime = fldcfsecondinputstartdatetime;
//    }
//
//    public Date getFldcfsecondinputenddatetime() {
//        return fldcfsecondinputenddatetime;
//    }
//
//    public void setFldcfsecondinputenddatetime(Date fldcfsecondinputenddatetime) {
//        this.fldcfsecondinputenddatetime = fldcfsecondinputenddatetime;
//    }
//
//    public String getFldsecondinputid() {
//        return fldsecondinputid;
//    }
//
//    public void setFldsecondinputid(String fldsecondinputid) {
//        this.fldsecondinputid = fldsecondinputid;
//    }
//
//    public String getFldsecondinputvalue() {
//        return fldsecondinputvalue;
//    }
//
//    public void setFldsecondinputvalue(String fldsecondinputvalue) {
//        this.fldsecondinputvalue = fldsecondinputvalue;
//    }
//
//    public Date getFldcfthirdinputstartdatetime() {
//        return fldcfthirdinputstartdatetime;
//    }
//
//    public void setFldcfthirdinputstartdatetime(Date fldcfthirdinputstartdatetime) {
//        this.fldcfthirdinputstartdatetime = fldcfthirdinputstartdatetime;
//    }
//
//    public Date getFldcfthirdinputenddatetime() {
//        return fldcfthirdinputenddatetime;
//    }
//
//    public void setFldcfthirdinputenddatetime(Date fldcfthirdinputenddatetime) {
//        this.fldcfthirdinputenddatetime = fldcfthirdinputenddatetime;
//    }
//
//    public String getFldthirdinputid() {
//        return fldthirdinputid;
//    }
//
//    public void setFldthirdinputid(String fldthirdinputid) {
//        this.fldthirdinputid = fldthirdinputid;
//    }
//
//    public String getFldthirdinputvalue() {
//        return fldthirdinputvalue;
//    }
//
//    public void setFldthirdinputvalue(String fldthirdinputvalue) {
//        this.fldthirdinputvalue = fldthirdinputvalue;
//    }
//
//    public BigInteger getFldnoofattempts() {
//        return fldnoofattempts;
//    }
//
//    public void setFldnoofattempts(BigInteger fldnoofattempts) {
//        this.fldnoofattempts = fldnoofattempts;
//    }
//
//    public Character getFldissuccess() {
//        return fldissuccess;
//    }
//
//    public void setFldissuccess(Character fldissuccess) {
//        this.fldissuccess = fldissuccess;
//    }
//
//    public String getFldcreatedby() {
//        return fldcreatedby;
//    }
//
//    public void setFldcreatedby(String fldcreatedby) {
//        this.fldcreatedby = fldcreatedby;
//    }
//
//    public Date getFldcreateddate() {
//        return fldcreateddate;
//    }
//
//    public void setFldcreateddate(Date fldcreateddate) {
//        this.fldcreateddate = fldcreateddate;
//    }
//
//    public String getFldupdatedby() {
//        return fldupdatedby;
//    }
//
//    public void setFldupdatedby(String fldupdatedby) {
//        this.fldupdatedby = fldupdatedby;
//    }
//
//    public Date getFldupdateddate() {
//        return fldupdateddate;
//    }
//
//    public void setFldupdateddate(Date fldupdateddate) {
//        this.fldupdateddate = fldupdateddate;
//    }
//
//    @Override
//    public int hashCode() {
//        int hash = 0;
//        hash += (fldcallflowdetailid != null ? fldcallflowdetailid.hashCode() : 0);
//        return hash;
//    }
//
//    @Override
//    public boolean equals(Object object) {
//        // TODO: Warning - this method won't work in the case the id fields are not set
//        if (!(object instanceof CallFlowDetail)) {
//            return false;
//        }
//        CallFlowDetail other = (CallFlowDetail) object;
//        if ((this.fldcallflowdetailid == null && other.fldcallflowdetailid != null) || (this.fldcallflowdetailid != null && !this.fldcallflowdetailid.equals(other.fldcallflowdetailid))) {
//            return false;
//        }
//        return true;
//    }
//
//    @Override
//    public String toString() {
//        return "com.tsg.database.ivr.data.CallFlowDetail[ fldcallflowdetailid=" + fldcallflowdetailid + " ]";
//    }
//    
//}
