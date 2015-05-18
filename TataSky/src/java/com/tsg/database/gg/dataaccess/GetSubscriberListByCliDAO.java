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
 * @author Pramesh
 */
public class GetSubscriberListByCliDAO {

    private String subscriberIdList = "";
    private StringBuilder strBuilderSubscriberList = new StringBuilder();

    public String getSubscriberIdList() {
        return subscriberIdList;
    }

    public void setSubscriberIdList(String subscriberIdList) {
        this.subscriberIdList = subscriberIdList;
    }

    public GetSubscriberListByCliDAO() {
    }

    public GetSubscriberListByCliDAO(String subscriberIdList) {

        this.subscriberIdList = subscriberIdList;

    }

    public ArrayList getSubscriberListByCli(String callerId, String dbCallDetailId) {

        String dataCenter = ConfigurationReader.configList.get("DATACENTER");

        DBConnectionPool dbConPool = new DBConnectionPool();

        dbConPool.setPoolDataSource(dataCenter + "GGPRDB");

        Connection conn = null;

        CallableStatement callableStatement = null;

        ResultSet rs = null;

        ArrayList subscriberListByCliList = new ArrayList();

        String strProc = "{call " + ConfigurationReader.configList.get("PROC_NAME_MULTIPLE_SUB_ID") + "(?,?)}";
        
        try {

            conn = dbConPool.getConnection(dbCallDetailId);

            callableStatement = conn.prepareCall(strProc);

            callableStatement.setPoolable(false);

            callableStatement.setString(1, callerId);

            callableStatement.registerOutParameter(2, OracleTypes.CURSOR);

            callableStatement.execute();

            rs = ((OracleCallableStatement) callableStatement).getCursor(2);

            while (rs.next()) {

                subscriberIdList = rs.getString("SUBSCRIBERID");

                strBuilderSubscriberList = strBuilderSubscriberList.append(subscriberIdList).append(",");

                subscriberIdList = null;

            }

            subscriberIdList = strBuilderSubscriberList.toString().replaceAll(",$", "");

        } catch (SQLException sqlEx) {

            Logger.error(dbCallDetailId, " Sql Exception in Subscriber List By Cli Page : " + callerId + " Message : " + sqlEx.getMessage(), false);

        } catch (Exception ex) {

            Logger.error(dbCallDetailId, " Exception in Subscriber List By Cli Page : " + callerId + " Message : " + ex.getMessage(), false);

        } finally {

            dbConPool.releaseConnection(dbCallDetailId);

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

                Logger.error(dbCallDetailId, " Exception in Subscriber List By Cli finally block : " + callerId + " Message : " + sqlEx.getMessage(), false);
            }

        }

        GetSubscriberListByCliDAO subscriberListByCliObj = new GetSubscriberListByCliDAO(subscriberIdList);

        subscriberListByCliList.add(subscriberListByCliObj);

        Logger.info(dbCallDetailId, "Get Subscriber List By CLI : Cli : " + callerId + " Subscriber Id List : " + subscriberIdList, false);

        callerId = dataCenter = dbCallDetailId = subscriberIdList = null;

        return subscriberListByCliList;

    }
}
