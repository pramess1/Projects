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

import oracle.jdbc.OracleCallableStatement;

import oracle.jdbc.OracleTypes;

/**
 *
 * @author Rajesh
 */
public class ValidateDateDAO {

    public String validateDate(String subscriberId, String requestType, int noofDays, String dbCallDetailId) {

        String dataCenter = ConfigurationReader.configList.get("DATACENTER");

        DBConnectionPool dbConPool = new DBConnectionPool();

        dbConPool.setPoolDataSource(dataCenter+"GGPRDB");

        Connection conn = null;

        CallableStatement callableStatement = null;

        ResultSet rs = null;

        String dateFlage = "N";

        String strProc = "{call " + ConfigurationReader.configList.get("PROC_NAME_VALIDATE_DATE") + "(?,?,?,?)}";

        try {

            conn = dbConPool.getConnection(dbCallDetailId);

            callableStatement = conn.prepareCall(strProc);

            callableStatement.setString(1, subscriberId);

            callableStatement.setString(2, requestType);

            callableStatement.setInt(3, noofDays);

            callableStatement.registerOutParameter(4, OracleTypes.CURSOR);

            callableStatement.execute();

            rs = ((OracleCallableStatement) callableStatement).getCursor(4);

            while (rs.next()) {

                dateFlage = rs.getString(1);
            }

        } catch (SQLException sqlEx) {

            Logger.error(dbCallDetailId, " SQLException in Relocation Flag Page Subscriber Id : " + subscriberId + " Message : " + sqlEx.getMessage(), false);

        } catch (Exception ex) {

            Logger.error(dbCallDetailId, " Exception in Relocation Flag Page Subscriber Id : " + subscriberId + " Message : " + ex.getMessage(), false);

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

                Logger.error(dbCallDetailId, " Exception in Relocation Flag finally block Subscriber Id : " + subscriberId + " Message : " + sqlEx.getMessage(), false);
            }

            dbConPool.releaseConnection(dbCallDetailId);
        }
        
        Logger.info(dbCallDetailId, "Relocation Flag Subscriber Id : " + subscriberId + " Request Type : " + requestType 
                + " No of Days : " + noofDays + " Date Flag : " + dateFlage, false);
        
        subscriberId = requestType = dataCenter = null;
        
        noofDays=0;
                      
        return dateFlage;
    }
}
