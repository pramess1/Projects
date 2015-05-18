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

import java.sql.SQLException;

/**
 *
 * @author Rajesh
 */
public class CheckValidSubscriberByCliDAO {

    
    public String checkValidSubscriberByCli(String callerId, String subscriberId, String dbCallDetailId) {
        
        String dataCenter = ConfigurationReader.configList.get("DATACENTER");

        DBConnectionPool dbConPool = new DBConnectionPool();

        dbConPool.setPoolDataSource(dataCenter+"GGPRDB");

        Connection conn = null;

        CallableStatement callableStatement = null;

        String isValidSubByCliFlag = "N";

        String strProc = "{call " + ConfigurationReader.configList.get("PROC_NAME_CHECK_VALID_SUB_BY_CLI") + "(?,?,?)}";

        try {

            conn = dbConPool.getConnection(dbCallDetailId);

            callableStatement = conn.prepareCall(strProc);
            
            callableStatement.setPoolable(false);

            callableStatement.setString(1, callerId);

            callableStatement.setString(2, subscriberId);

            callableStatement.registerOutParameter(3, java.sql.Types.VARCHAR);

            callableStatement.execute();

            isValidSubByCliFlag = callableStatement.getString(3).toString();

        } catch (SQLException sqlEx) {

            Logger.error(dbCallDetailId, " SQL Exception in Check Valid Subscriber By Cli Page : " + sqlEx.getMessage(), false);

        } catch (Exception ex) {

            Logger.error(dbCallDetailId, " Exception in Check Valid Subscriber By Cli Page : " + ex.getMessage(), false);

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

                Logger.error(dbCallDetailId, " Exception in Subscriber By Cli finally block : " + callerId + " Message : " + sqlEx.getMessage(), false);
            }

            dbConPool.releaseConnection(dbCallDetailId);
        }

        Logger.info(dbCallDetailId, " Check Valid Subscriber By Cli Caller Id : " + callerId + " Subscriber Id : " + subscriberId + " Flag : " + isValidSubByCliFlag, false);

        callerId = subscriberId = dbCallDetailId = dataCenter = null;

        return isValidSubByCliFlag;
    }
}

