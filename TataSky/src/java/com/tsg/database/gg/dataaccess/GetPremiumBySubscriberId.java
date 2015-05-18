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
public class GetPremiumBySubscriberId {

    public String getPremiumBySubscriberId(String subscriberId, String dbCallDetailId) {

        String dataCenter = ConfigurationReader.configList.get("DATACENTER");

        DBConnectionPool dbConPool = new DBConnectionPool();

        dbConPool.setPoolDataSource(dataCenter+"GGPRDB");

        Connection conn = null;

        CallableStatement callableStatement = null;

        String premiumFlage = "N";

        String strProc = "{call " + ConfigurationReader.configList.get("PROC_NAME_GET_PREMIUM_BY_SUBID") + "(?,?)}";

        try {

            conn = dbConPool.getConnection(dbCallDetailId);

            callableStatement = conn.prepareCall(strProc);

            callableStatement.setString(1, subscriberId);

            callableStatement.registerOutParameter(2, java.sql.Types.VARCHAR);

            callableStatement.execute();

            premiumFlage = callableStatement.getString(2).toString();

        } catch (SQLException sqlEx) {

            Logger.error(dbCallDetailId, " SQL Exception in  Get Premium By SubscriberId Flage Page SubscriberId : " + subscriberId + " Message : " + sqlEx.getMessage(), false);

        } catch (Exception ex) {

            Logger.error(dbCallDetailId, " Exception in  Get Premium By SubscriberId Flage Page SubscriberId : " + subscriberId + " Message : " + ex.getMessage(), false);

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

                Logger.error(dbCallDetailId, " Exception in Get Premium By SubscriberId finally block SubscriberId : " + subscriberId + " Message : " + sqlEx.getMessage(), false);
            }

            dbConPool.releaseConnection(dbCallDetailId);
        }

        Logger.info(dbCallDetailId, " SubscriberId :" + subscriberId + " Premium Flage : " + premiumFlage, true);

        subscriberId = dataCenter = null;

        return premiumFlage;
    }
}