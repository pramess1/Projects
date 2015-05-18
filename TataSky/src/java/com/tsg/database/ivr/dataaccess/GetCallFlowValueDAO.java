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
public class GetCallFlowValueDAO {

    public String getCallFlowValue(String callFlowId, String dbCallDetailId) {

        String dataCenter = ConfigurationReader.configList.get("DATACENTER");
        
        DBConnectionPool dbConPool = new DBConnectionPool();

        dbConPool.setPoolDataSource(dataCenter + "IVRPRDB");

        Connection conn = null;

        CallableStatement callableStatement = null;

        String strProc = "{call " + ConfigurationReader.configList.get("PROC_NAME_GET_CALLFLOW_VALUE") + "(?,?)}";

        String callFlowName = "0";

        try {

            conn = dbConPool.getConnection(dbCallDetailId);

            callableStatement = conn.prepareCall(strProc);

            callableStatement.setInt(1, Integer.parseInt(callFlowId));

            callableStatement.registerOutParameter(2, java.sql.Types.VARCHAR);

            callableStatement.executeUpdate();

            callFlowName = callableStatement.getString(2).toString();

        } catch (SQLException sqlEx) {

            Logger.error(dbCallDetailId, " SQL Exception in Get Call Flow Value Call Flow Id : " + callFlowId + " Message :" + sqlEx.getMessage(), false);

        } catch (Exception ex) {

            Logger.error(dbCallDetailId, " Exception in Get Call Flow Value Call Flow Id : " + callFlowId + " Message :" + ex.getMessage(), false);

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

                Logger.error(dbCallDetailId, " Exception in Get Call Flow Value finally block Call Flow Id : " + callFlowId + " Message : " + sqlEx.getMessage(), false);
            }

            dbConPool.releaseConnection(dbCallDetailId);
        }

        Logger.info(dbCallDetailId, "Call Flow Id : " + callFlowId + " Call Flow Name : " + callFlowName, false);

        callFlowId = dataCenter = dbCallDetailId = null;

        return callFlowName;
    }
}
