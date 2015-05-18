/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tsg.database.ivr.dataaccess;

import com.tsg.common.ConfigurationReader;
import com.tsg.database.DBConnectionPool;

import com.tsg.log.Logger;

import java.sql.CallableStatement;

import java.sql.Connection;

import java.sql.SQLException;

/**
 *
 * @author Rajesh
 */
public class InsertCallFlowDetailDAO {

    public String insertCallFlowDetail(String callFlowDetailXml) {

        String dataCenter = ConfigurationReader.configList.get("DATACENTER");
        
        DBConnectionPool dbConPool = new DBConnectionPool();

        dbConPool.setPoolDataSource(dataCenter + "IVRPRDB");

        Connection conn = null;

        CallableStatement callableStatement = null;

        String strProc = "{call " + ConfigurationReader.configList.get("PROC_NAME_INSERT_CALLFLOW_DETAIL") + "(?,?)}";

        String status = "0";

        try {

            conn = dbConPool.getConnection("");

            callableStatement = conn.prepareCall(strProc);

            callableStatement.setString(1, callFlowDetailXml);

            callableStatement.registerOutParameter(2, java.sql.Types.VARCHAR);

            callableStatement.executeUpdate();

            status = callableStatement.getString(2).toString();

            callableStatement.close();

        } catch (SQLException sqlEx) {
            
            Logger.error("", " SQL Exception in Insert Call Flow Detail Page : " + sqlEx.getMessage(), false);
            
        } catch (Exception ex) {

            Logger.error("", " Exception in Insert Call Flow Detail Page : " + ex.getMessage(), false);

        } finally {

            try {

                if (callableStatement != null) {

                    callableStatement.close();

                    callableStatement = null;
                }

                if (conn != null) {

                    conn.close();

                    conn = null;
                }

            } catch (SQLException sqlEx) {

                Logger.error("", " Exception in Insert Call Flow Detail finally block : " + sqlEx.getMessage(), false);
            }

            dbConPool.releaseConnection("");
        }

        callFlowDetailXml = dataCenter = null;

        Logger.info("", " CallFlowDetail Status : " + status, false);

        return status;
    }
}
