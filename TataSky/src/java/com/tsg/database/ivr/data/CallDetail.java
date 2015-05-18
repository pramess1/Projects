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
//@Table(name = "TBLCALLDETAIL")
//@XmlRootElement
//public class CallDetail implements Serializable {
//    private static final long serialVersionUID = 1L;
//    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
//    @Id
//    @Basic(optional = false)
//    @Column(name = "FLDCALLDETAILID")
//    private BigDecimal fldcalldetailid;
//    @Basic(optional = false)
//    @Column(name = "FLDUUID")
//    private String flduuid;
//    @Column(name = "FLDCONNECTIONID")
//    private String fldconnectionid;
//    @Column(name = "FLDSESSIONID")
//    private String fldsessionid;
//    @Column(name = "FLDCLI")
//    private String fldcli;
//    @Basic(optional = false)
//    @Column(name = "FLDDNIS")
//    private BigInteger flddnis;
//    @Column(name = "FLDCALLTYPEID")
//    private BigInteger fldcalltypeid;
//    @Column(name = "FLDCALLSTARTTIME")
//    @Temporal(TemporalType.TIMESTAMP)
//    private Date fldcallstarttime;
//    @Column(name = "FLDCALLENDTIME")
//    @Temporal(TemporalType.TIMESTAMP)
//    private Date fldcallendtime;
//    @Column(name = "FLDLANGUAGESELECTED")
//    private String fldlanguageselected;
//    @Column(name = "FLDSUBSCRIBERID")
//    private String fldsubscriberid;
//    @Column(name = "FLDSUBIDLIST")
//    private String fldsubidlist;
//    @Column(name = "FLDCALLERTYPE")
//    private String fldcallertype;
//    @Column(name = "FLDSUBSCRIBERSEGMENT")
//    private String fldsubscribersegment;
//    @Column(name = "FLDCALLDISCONNECTEDBY")
//    private String fldcalldisconnectedby;
//    @Column(name = "FLDCALLDISCONNECTREASON")
//    private String fldcalldisconnectreason;
//    @Column(name = "FLDLASTTRAVERSEDCFDID")
//    private BigInteger fldlasttraversedcfdid;
//    @Column(name = "FLDTRANSFERSTATUS")
//    private String fldtransferstatus;
//    @Column(name = "FLDTRANSFERFAILUREREASON")
//    private String fldtransferfailurereason;
//    @Column(name = "FLDTRANSFERTO")
//    private String fldtransferto;
//    @Column(name = "FLDAGENTID")
//    private String fldagentid;
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
//    public CallDetail() {
//    }
//
//    public CallDetail(BigDecimal fldcalldetailid) {
//        this.fldcalldetailid = fldcalldetailid;
//    }
//
//    public CallDetail(BigDecimal fldcalldetailid, String flduuid, BigInteger flddnis) {
//        this.fldcalldetailid = fldcalldetailid;
//        this.flduuid = flduuid;
//        this.flddnis = flddnis;
//    }
//
//    public BigDecimal getFldcalldetailid() {
//        return fldcalldetailid;
//    }
//
//    public void setFldcalldetailid(BigDecimal fldcalldetailid) {
//        this.fldcalldetailid = fldcalldetailid;
//    }
//
//    public String getFlduuid() {
//        return flduuid;
//    }
//
//    public void setFlduuid(String flduuid) {
//        this.flduuid = flduuid;
//    }
//
//    public String getFldconnectionid() {
//        return fldconnectionid;
//    }
//
//    public void setFldconnectionid(String fldconnectionid) {
//        this.fldconnectionid = fldconnectionid;
//    }
//
//    public String getFldsessionid() {
//        return fldsessionid;
//    }
//
//    public void setFldsessionid(String fldsessionid) {
//        this.fldsessionid = fldsessionid;
//    }
//
//    public String getFldcli() {
//        return fldcli;
//    }
//
//    public void setFldcli(String fldcli) {
//        this.fldcli = fldcli;
//    }
//
//    public BigInteger getFlddnis() {
//        return flddnis;
//    }
//
//    public void setFlddnis(BigInteger flddnis) {
//        this.flddnis = flddnis;
//    }
//
//    public BigInteger getFldcalltypeid() {
//        return fldcalltypeid;
//    }
//
//    public void setFldcalltypeid(BigInteger fldcalltypeid) {
//        this.fldcalltypeid = fldcalltypeid;
//    }
//
//    public Date getFldcallstarttime() {
//        return fldcallstarttime;
//    }
//
//    public void setFldcallstarttime(Date fldcallstarttime) {
//        this.fldcallstarttime = fldcallstarttime;
//    }
//
//    public Date getFldcallendtime() {
//        return fldcallendtime;
//    }
//
//    public void setFldcallendtime(Date fldcallendtime) {
//        this.fldcallendtime = fldcallendtime;
//    }
//
//    public String getFldlanguageselected() {
//        return fldlanguageselected;
//    }
//
//    public void setFldlanguageselected(String fldlanguageselected) {
//        this.fldlanguageselected = fldlanguageselected;
//    }
//
//    public String getFldsubscriberid() {
//        return fldsubscriberid;
//    }
//
//    public void setFldsubscriberid(String fldsubscriberid) {
//        this.fldsubscriberid = fldsubscriberid;
//    }
//
//    public String getFldsubidlist() {
//        return fldsubidlist;
//    }
//
//    public void setFldsubidlist(String fldsubidlist) {
//        this.fldsubidlist = fldsubidlist;
//    }
//
//    public String getFldcallertype() {
//        return fldcallertype;
//    }
//
//    public void setFldcallertype(String fldcallertype) {
//        this.fldcallertype = fldcallertype;
//    }
//
//    public String getFldsubscribersegment() {
//        return fldsubscribersegment;
//    }
//
//    public void setFldsubscribersegment(String fldsubscribersegment) {
//        this.fldsubscribersegment = fldsubscribersegment;
//    }
//
//    public String getFldcalldisconnectedby() {
//        return fldcalldisconnectedby;
//    }
//
//    public void setFldcalldisconnectedby(String fldcalldisconnectedby) {
//        this.fldcalldisconnectedby = fldcalldisconnectedby;
//    }
//
//    public String getFldcalldisconnectreason() {
//        return fldcalldisconnectreason;
//    }
//
//    public void setFldcalldisconnectreason(String fldcalldisconnectreason) {
//        this.fldcalldisconnectreason = fldcalldisconnectreason;
//    }
//
//    public BigInteger getFldlasttraversedcfdid() {
//        return fldlasttraversedcfdid;
//    }
//
//    public void setFldlasttraversedcfdid(BigInteger fldlasttraversedcfdid) {
//        this.fldlasttraversedcfdid = fldlasttraversedcfdid;
//    }
//
//    public String getFldtransferstatus() {
//        return fldtransferstatus;
//    }
//
//    public void setFldtransferstatus(String fldtransferstatus) {
//        this.fldtransferstatus = fldtransferstatus;
//    }
//
//    public String getFldtransferfailurereason() {
//        return fldtransferfailurereason;
//    }
//
//    public void setFldtransferfailurereason(String fldtransferfailurereason) {
//        this.fldtransferfailurereason = fldtransferfailurereason;
//    }
//
//    public String getFldtransferto() {
//        return fldtransferto;
//    }
//
//    public void setFldtransferto(String fldtransferto) {
//        this.fldtransferto = fldtransferto;
//    }
//
//    public String getFldagentid() {
//        return fldagentid;
//    }
//
//    public void setFldagentid(String fldagentid) {
//        this.fldagentid = fldagentid;
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
//        hash += (fldcalldetailid != null ? fldcalldetailid.hashCode() : 0);
//        return hash;
//    }
//
//    @Override
//    public boolean equals(Object object) {
//        // TODO: Warning - this method won't work in the case the id fields are not set
//        if (!(object instanceof CallDetail)) {
//            return false;
//        }
//        CallDetail other = (CallDetail) object;
//        if ((this.fldcalldetailid == null && other.fldcalldetailid != null) || (this.fldcalldetailid != null && !this.fldcalldetailid.equals(other.fldcalldetailid))) {
//            return false;
//        }
//        return true;
//    }
//
//    @Override
//    public String toString() {
//        return "com.tsg.database.ivr.data.CallDetail[ fldcalldetailid=" + fldcalldetailid + " ]";
//    }
//    
//}
