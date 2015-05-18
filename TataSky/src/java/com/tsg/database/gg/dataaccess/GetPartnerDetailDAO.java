/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tsg.database.gg.dataaccess;

import com.tsg.common.ConfigurationReader;
import com.tsg.database.DBConnectionPool;

import com.tsg.log.Logger;

import java.sql.CallableStatement;

import java.sql.Connection;

import java.sql.ResultSet;

import java.sql.SQLException;

import java.util.ArrayList;

import oracle.jdbc.OracleCallableStatement;

import oracle.jdbc.OracleTypes;

/**
 *
 * @author Rajesh
 */
public class GetPartnerDetailDAO {

    private String partnerType;
    
    private String partnerId;
    
    private String tslPrimaryLanguage;
    
    private String status;
    
    private String state;
    
    private String zipcode;
    
    private String partnerRepeat;
    
    private String actualPartnerType;

    public String getActualPartnerType() {
        return actualPartnerType;
    }

    public void setActualPartnerType(String actualPartnerType) {
        this.actualPartnerType = actualPartnerType;
    }

    public String getPartnerRepeat() {
        return partnerRepeat;
    }

    public void setPartnerRepeat(String partnerRepeat) {
        this.partnerRepeat = partnerRepeat;
    }

    public String getPartnerType() {

        return partnerType;
    }

    public void setPartnerType(String partnerType) {

        this.partnerType = partnerType;
    }

    public String getPartnerId() {

        return partnerId;
    }

    public void setPartnerId(String partnerId) {

        this.partnerId = partnerId;
    }

    public String getTslPrimaryLanguage() {

        return tslPrimaryLanguage;
    }

    public void setTslPrimaryLanguage(String tslPrimaryLanguage) {

        this.tslPrimaryLanguage = tslPrimaryLanguage;
    }

    public String getStatus() {

        return status;
    }

    public void setStatus(String status) {

        this.status = status;
    }

    public String getState() {

        return state;
    }

    public void setState(String state) {

        this.state = state;
    }

    public String getZipcode() {

        return zipcode;
    }

    public void setZipcode(String zipcode) {

        this.zipcode = zipcode;
    }

    public GetPartnerDetailDAO() {
    }

    public GetPartnerDetailDAO(String partnerType, String partnerId, String tslPrimaryLanguage,
            String status, String state, String zipcode, String partnerRepeat, String actualPartnerType) {

        this.partnerType = partnerType;

        this.partnerId = partnerId;

        this.tslPrimaryLanguage = tslPrimaryLanguage;

        this.status = status;

        this.state = state;

        this.zipcode = zipcode;
        
        this.partnerRepeat = partnerRepeat;
        
        this.actualPartnerType = actualPartnerType;
    }

    public ArrayList getPartnerDetailMobile(String id, String dbCallDetailId) {

        String dataCenter = ConfigurationReader.configList.get("DATACENTER");

        DBConnectionPool dbConPool = new DBConnectionPool();

        dbConPool.setPoolDataSource(dataCenter+"GGPRDB");

        Connection conn = null;

        CallableStatement callableStatement = null;

        ResultSet rs = null;

        ArrayList partnerDetailList = new ArrayList();

        String strProc = "{call " + ConfigurationReader.configList.get("PROC_NAME_GET_PARTNER_DETAIL") + "(?,?,?)}";

        try {

            conn = dbConPool.getConnection(dbCallDetailId);

            callableStatement = conn.prepareCall(strProc);

            callableStatement.setString(1, "M");

            callableStatement.setString(2, id);

            callableStatement.registerOutParameter(3, OracleTypes.CURSOR);

            callableStatement.execute();

            rs = ((OracleCallableStatement) callableStatement).getCursor(3);
            
             while (rs.next()) {

                partnerType = rs.getString("PARTNER_TYPE");

                partnerId = rs.getString("PARTNER_ID");

                tslPrimaryLanguage = rs.getString("TSL_PRIMARY_LANGUAGE");

                status = rs.getString("STATUS");

                state = rs.getString("STATE");

                zipcode = rs.getString("ZIPCODE");//
                
                partnerRepeat = rs.getString("PARTNERREPEAT");
                
                actualPartnerType = rs.getString("ACTUAL_PARTNER_TYPE");
         
                GetPartnerDetailDAO getPartnerDetailObj = new GetPartnerDetailDAO(partnerType, partnerId,
                        tslPrimaryLanguage, status, state, zipcode, partnerRepeat, actualPartnerType);
                
                partnerDetailList.add(getPartnerDetailObj);

            }

        } catch (SQLException sqlEx) {

            Logger.error(dbCallDetailId, " SQL Exception in Partner Detail Mobile Page Id : " + id + " Message : " + sqlEx.getMessage(), false);

        } catch (Exception ex) {

            Logger.error(dbCallDetailId, " Exception in Partner Detail Mobile Page Id : " + id + " Message : " + ex.getMessage(), false);

        } finally {
            
            try {

                if (callableStatement != null) {

                    callableStatement.close();

                    callableStatement = null;
                }

                if (rs != null) {

                    rs.close();

                    rs = null;
                }

                if (conn != null) {

                    conn.close();

                    conn = null;
                }

            } catch (SQLException sqlEx) {

                Logger.error(dbCallDetailId, " Exception in Partner Detail Mobile finally block Id : " + id + " Message : " + sqlEx.getMessage(), false);
            }

            dbConPool.releaseConnection(dbCallDetailId);
        }

        Logger.info(dbCallDetailId, " Partner Detail Mobile  Id : " + id + " partnerType : " + partnerType + " partnerId : " + partnerId + " tslPrimaryLanguage : " + tslPrimaryLanguage
                + " status : " + status + " state : " + state + " zipcode : " + zipcode + " Actual Partner Type : " + actualPartnerType, false);

        id = dbCallDetailId = dataCenter = partnerType = partnerId = tslPrimaryLanguage = status = state = zipcode = actualPartnerType = null;

        return partnerDetailList;
    }

    public ArrayList getPartnerDetailId(String id, String dbCallDetailId) {

        String dataCenter = ConfigurationReader.configList.get("DATACENTER");

        DBConnectionPool dbConPool = new DBConnectionPool();

        dbConPool.setPoolDataSource(dataCenter+"GGPRDB");

        Connection conn = null;

        CallableStatement callableStatement = null;

        ResultSet rs = null;

        ArrayList partnerDetailList = new ArrayList();

        String strProc = "{call USPGETPARTNERDETAIL(?,?,?)}";

        try {

            conn = dbConPool.getConnection(dbCallDetailId);

            callableStatement = conn.prepareCall(strProc);

            callableStatement.setString(1, "I");

            callableStatement.setString(2, id);

            callableStatement.registerOutParameter(3, OracleTypes.CURSOR);

            callableStatement.execute();

            rs = ((OracleCallableStatement) callableStatement).getCursor(3);

            while (rs.next()) {

                partnerType = rs.getString("PARTNER_TYPE");

                partnerId = rs.getString("PARTNER_ID");

                tslPrimaryLanguage = rs.getString("TSL_PRIMARY_LANGUAGE");

                status = rs.getString("STATUS");

                state = rs.getString("STATE");

                zipcode = rs.getString("ZIPCODE");
                
                partnerRepeat = rs.getString("PARTNERREPEAT");
                
                actualPartnerType = rs.getString("ACTUAL_PARTNER_TYPE");

                GetPartnerDetailDAO getPartnerDetailObj = new GetPartnerDetailDAO(partnerType, partnerId,
                        tslPrimaryLanguage, status, state, zipcode, partnerRepeat, actualPartnerType);

                partnerDetailList.add(getPartnerDetailObj);
            }

        } catch (SQLException sqlEx) {

            Logger.error(dbCallDetailId, " SQL Exception in Partner Detail Id Page Id: " + id + " Message : " + sqlEx.getMessage(), false);

        } catch (Exception ex) {

            Logger.error(dbCallDetailId, " Exception in Partner Detail Id Page Id : " + id + " Message : " + ex.getMessage(), false);

        } finally {
            
            try {

                if (callableStatement != null) {

                    callableStatement.close();

                    callableStatement = null;
                }

                if (rs != null) {

                    rs.close();

                    rs = null;
                }

                if (conn != null) {

                    conn.close();

                    conn = null;
                }

            } catch (SQLException sqlEx) {

                Logger.error(dbCallDetailId, " Exception in Partner Detail finally block Id : " + id + " Message : " + sqlEx.getMessage(), false);
            }

            dbConPool.releaseConnection(dbCallDetailId);
        }

        Logger.info(dbCallDetailId, " Partner Detail Id : " + id + " partnerType : " + partnerType + " partnerId : " + partnerId + " tslPrimaryLanguage : " + tslPrimaryLanguage
                + " status : " + status + " state : " + state + " zipcode : " + zipcode + " Actual Partner Type : " + actualPartnerType, false);

        id = dbCallDetailId = dataCenter = partnerType = partnerId = tslPrimaryLanguage = status = state = zipcode = actualPartnerType = null;

        return partnerDetailList;
    }
}


