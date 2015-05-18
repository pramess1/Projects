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
public class GetIVRWOFlagDAO {

    public void GetIVRWOFlagDAO() {
    }

    public String ivrWOFlage(String subscriberId, int noOfDays, String dbCallDetailId) {

        String dataCenter = ConfigurationReader.configList.get("DATACENTER");

        DBConnectionPool dbConPool = new DBConnectionPool();

        dbConPool.setPoolDataSource(dataCenter + "GGPRDB");

        Connection conn = null;

        CallableStatement callableStatement = null;

        String woFlage = "N";

        String strProc = "{call " + ConfigurationReader.configList.get("PROC_NAME_GET_IVR_WOFLAG") + "(?,?,?)}";

        try {

            conn = dbConPool.getConnection(dbCallDetailId);

            callableStatement = conn.prepareCall(strProc);

            callableStatement.setPoolable(false);

            callableStatement.setString(1, subscriberId);

            callableStatement.setInt(2, noOfDays);

            callableStatement.registerOutParameter(3, java.sql.Types.VARCHAR);

            callableStatement.execute();

            woFlage = callableStatement.getString(3).toString();

        } catch (SQLException sqlEx) {

            Logger.error(dbCallDetailId, " SQL Exception in IVRWO Flage Page : " + sqlEx.getMessage(), false);

        } catch (Exception ex) {

            Logger.error(dbCallDetailId, " Exception in IVRWO Flage Page : " + ex.getMessage(), false);

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

                Logger.error(dbCallDetailId, " Exception in IVRWO Flag finally block : " + subscriberId + " Message : " + sqlEx.getMessage(), false);
            }

            dbConPool.releaseConnection(dbCallDetailId);
        }

        Logger.info(dbCallDetailId, " SubscriberId : " + subscriberId + "  IVR WO Flage : " + woFlage, false);

        subscriberId = dataCenter = null;

        return woFlage;
    }
}
