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
public class GetStasStateCodeBySubscIdDAO {

    private String state;
    
    private String pinCode;

    public String getState() {

        return state;
    }

    public void setState(String state) {

        this.state = state;
    }

    public String getPinCode() {

        return pinCode;
    }

    public void setPinCode(String pinCode) {

        this.pinCode = pinCode;
    }

    public GetStasStateCodeBySubscIdDAO() {
    }

    public GetStasStateCodeBySubscIdDAO(String state, String pinCode) {

        this.state = state;

        this.pinCode = pinCode;
    }

    public ArrayList getStasStateCodeBySubscId(String subscriberId, String dbCallDetailId) {

        String dataCenter = ConfigurationReader.configList.get("DATACENTER");

        DBConnectionPool dbConPool = new DBConnectionPool();

        dbConPool.setPoolDataSource(dataCenter+"GGPRDB");

        Connection conn = null;

        CallableStatement callableStatement = null;

        ResultSet rs = null;

        ArrayList stateCodeList = new ArrayList();

        String strProc = "{call " + ConfigurationReader.configList.get("PROC_NAME_GET_STAS_STATECODE_BY_SUBID") + "(?,?)}";

        try {

            conn = dbConPool.getConnection(dbCallDetailId);

            callableStatement = conn.prepareCall(strProc);

            callableStatement.setString(1, subscriberId);

            callableStatement.registerOutParameter(2, OracleTypes.CURSOR);

            callableStatement.execute();

            rs = ((OracleCallableStatement) callableStatement).getCursor(2);

            while (rs.next()) {

                state = rs.getString("STATE");

                pinCode = rs.getString("PINCODE");

                GetStasStateCodeBySubscIdDAO stateCodeBySubscIdobj = new GetStasStateCodeBySubscIdDAO(state, pinCode);

                stateCodeList.add(stateCodeBySubscIdobj);
            }

        } catch (SQLException sqlEx) {

            Logger.error(dbCallDetailId, " SQLException in Stas State Code By Subscriber Id  Page Subscriber Id : " + subscriberId + " Message : " + sqlEx.getMessage(), false);

        } catch (Exception ex) {

            Logger.error(dbCallDetailId, " Exception in Stas State Code By Subscriber Id  Page Subscriber Id : " + subscriberId + " Message : " + ex.getMessage(), false);

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

                Logger.error(dbCallDetailId, " Exception in Stas State Code By Subscriber Id finally block Subscriber Id : " + subscriberId + " Message : " + sqlEx.getMessage(), false);
            }

            dbConPool.releaseConnection(dbCallDetailId);

        }

        Logger.info(dbCallDetailId, " Stas State Code By Subscriber Id : " + subscriberId + " State : " + state + " PinCode : " + pinCode, false);

        subscriberId = dataCenter = dbCallDetailId = state = pinCode = null;

        return stateCodeList;
    }
}

