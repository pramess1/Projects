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

import java.sql.ResultSet;

import java.sql.SQLException;

import oracle.jdbc.OracleCallableStatement;

import oracle.jdbc.OracleTypes;

/**
 *
 * @author Rajesh
 */
public class DatabaseProcessorDAO {

    public String agentIdValidation(String agentId, String dbCallDetailId) {

        String dataCenter = ConfigurationReader.configList.get("DATACENTER");
        
        DBConnectionPool dbConPool = new DBConnectionPool();

        dbConPool.setPoolDataSource(dataCenter + "IVRPRDB");

        Connection conn = null;

        CallableStatement callableStatement = null;

        String agentFlage = "N";

        ResultSet rs = null;

        String strProc = "{call " + ConfigurationReader.configList.get("PROC_NAME_DATABASE_PROCESSOR") + "(?,?)}";

        try {

            conn = dbConPool.getConnection(dbCallDetailId);

            callableStatement = conn.prepareCall(strProc);

            callableStatement.setString(1, agentId);

            callableStatement.registerOutParameter(2, OracleTypes.CURSOR);

            callableStatement.execute();

            rs = ((OracleCallableStatement) callableStatement).getCursor(2);

            while (rs.next()) {

                agentFlage = rs.getString(1);

            }

        } catch (SQLException sqlEx) {

            Logger.error(dbCallDetailId, " SQL Exception in Agent Flage Details Page Agent Id : " + agentId + " Message : " + sqlEx.getMessage(), false);

        } catch (Exception ex) {

            Logger.error(dbCallDetailId, " Exception in Agent Flage Details Page Agent Id : " + agentId + " Message : " + ex.getMessage(), false);

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

                Logger.error(dbCallDetailId, " Exception in Agent Flage Details finally block : " + agentId + " Message : " + sqlEx.getMessage(), false);
            }

            dbConPool.releaseConnection(dbCallDetailId);
        }

        Logger.info(dbCallDetailId, " Agent Flag Details Id : " + agentId + " Flag :" + agentFlage, false);

        agentId = dbCallDetailId = dataCenter = null;

        return agentFlage;
    }
}