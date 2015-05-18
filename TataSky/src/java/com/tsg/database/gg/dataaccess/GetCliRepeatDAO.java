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
public class GetCliRepeatDAO {

    public String cliRepeatFlage(String cli, String repeatType, String dbCallDetailId) {

        String dataCenter = ConfigurationReader.configList.get("DATACENTER");

        DBConnectionPool dbConPool = new DBConnectionPool();

        dbConPool.setPoolDataSource(dataCenter+"GGPRDB");

        Connection conn = null;

        CallableStatement callableStatement = null;

        String cliRepeatFlage = "N";

        String strProc = "{call " + ConfigurationReader.configList.get("PROC_NAME_GET_CLI_REPEAT") + "(?,?,?)}";

        try {

            conn = dbConPool.getConnection(dbCallDetailId);

            callableStatement = conn.prepareCall(strProc);
            
            callableStatement.setPoolable(false);

            callableStatement.setString(1, cli);

            callableStatement.setString(2, repeatType);

            callableStatement.registerOutParameter(3, java.sql.Types.VARCHAR);

            callableStatement.execute();

            cliRepeatFlage = callableStatement.getString(3).toString();

        } catch (SQLException sqlEx) {

            Logger.error(dbCallDetailId, " SQL Exception in  Cli Repeat Flage Page : " + sqlEx.getMessage(), false);

        } catch (Exception ex) {

            Logger.error(dbCallDetailId, " Exception in  Cli Repeat Flage Page : " + ex.getMessage(), false);

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

                Logger.error(dbCallDetailId, " Exception in Cli Repeat finally block : " + cli + " Message : " + sqlEx.getMessage(), false);
            }

            dbConPool.releaseConnection(dbCallDetailId);
        }

        Logger.info(dbCallDetailId, "Cli : " + cli +  " Repeat Type : " + repeatType + " Repeat Flage : " + cliRepeatFlage, false);
        
        cli = repeatType = dataCenter = null;    
        
        return cliRepeatFlage;
    }
}