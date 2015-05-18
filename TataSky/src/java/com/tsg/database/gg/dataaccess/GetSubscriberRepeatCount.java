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
 * @author Pramesh
 */
public class GetSubscriberRepeatCount {

    public String getSubscriberRepeatCount(String subscriberId, String dbCallDetailId) {

        String dataCenter = ConfigurationReader.configList.get("DATACENTER");

        DBConnectionPool dbConPool = new DBConnectionPool();

        dbConPool.setPoolDataSource(dataCenter + "GGPRDB");

        Connection conn = null;

        CallableStatement callableStatement = null;

        String subscriberRepeatFlag = "N";

        String repeatCheck = ConfigurationReader.configList.get("IVR_AGENT_REPEAT");

        int subscriberCount = Integer.parseInt(ConfigurationReader.configList.get("SUB_ID_COUNT"));

        int procIVRRepeatCount = 0;

        int procAgentRepeatCount = 0;

        String strProc = "{call " + ConfigurationReader.configList.get("PROC_NAME_SUBSCRIBER_RPT") + "(?,?,?)}";

        try {

            conn = dbConPool.getConnection(dbCallDetailId);

            callableStatement = conn.prepareCall(strProc);

            callableStatement.setString(1, subscriberId);

            callableStatement.registerOutParameter(2, java.sql.Types.INTEGER);

            callableStatement.registerOutParameter(3, java.sql.Types.INTEGER);

            callableStatement.execute();

            procIVRRepeatCount = callableStatement.getInt(2);

            procAgentRepeatCount = callableStatement.getInt(3);

            Logger.debug(dbCallDetailId, "IVR Repeat Count From Procedure : " + procIVRRepeatCount + " Agent Repat Count from Procedure : " + procAgentRepeatCount, false);

            if (repeatCheck.trim().equalsIgnoreCase("IVR")) {

                Logger.info(dbCallDetailId, "IVR Repeat Count from Procedure " + procIVRRepeatCount, false);

                if (procIVRRepeatCount > subscriberCount) {

                    subscriberRepeatFlag = "Y";

                } else {

                    subscriberRepeatFlag = "N";

                }

            }

            if (repeatCheck.trim().equalsIgnoreCase("AGENT")) {

                Logger.info(dbCallDetailId, "Agent Repeat Count from Procedure " + procAgentRepeatCount, false);

                if (procAgentRepeatCount > subscriberCount) {

                    subscriberRepeatFlag = "Y";

                } else {

                    subscriberRepeatFlag = "N";

                }

            }

        } catch (SQLException sqlEx) {

            subscriberRepeatFlag = "N";

            Logger.error(dbCallDetailId, " SQL Exception in  Get Subscriber Repeat Count Class SubscriberId : " + subscriberId + " Message : " + sqlEx.getMessage(), false);

        } catch (Exception ex) {

            subscriberRepeatFlag = "N";

            Logger.error(dbCallDetailId, " Exception in  Get Subscriber Repeat Count Class SubscriberId : " + subscriberId + " Message : " + ex.getMessage(), false);

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

                Logger.error(dbCallDetailId, " Exception in Get Subscriber Repeat Count Class finally block SubscriberId : " + subscriberId + " Message : " + sqlEx.getMessage(), false);
            }

            dbConPool.releaseConnection(dbCallDetailId);
        }

        Logger.info(dbCallDetailId, " SubscriberId :" + subscriberId + " Subscriber Repeat Flag : " + subscriberRepeatFlag, false);

        subscriberId = dataCenter = null;

        return subscriberRepeatFlag;

    }
}
