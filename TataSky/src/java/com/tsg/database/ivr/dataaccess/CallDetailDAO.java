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
 * @author Developer
 */
public class CallDetailDAO {

    public String insertCallDetails(String strCli, String iDNIS, String strUUID, String strConnID, String strSessionID, String iCallTypeID, String strTimeStamp, String strCallType) {

        String dataCenter = ConfigurationReader.configList.get("DATACENTER");
        
        DBConnectionPool dbConPool = new DBConnectionPool();

        dbConPool.setPoolDataSource(dataCenter + "IVRPRDB");

        Connection conn = null;

        CallableStatement callableStatement = null;

        String strProc = "{call " + ConfigurationReader.configList.get("PROC_NAME_CALL_DETAIL") + "(?,?,?,?,?,?,?,?,?)}";

        String strCallDetailID = "0";

        try {

            conn = dbConPool.getConnection("");

            callableStatement = conn.prepareCall(strProc);

            callableStatement.setString(1, strCli);

            callableStatement.setLong(2, Long.parseLong(iDNIS));

            callableStatement.setString(3, strUUID);

            callableStatement.setString(4, strConnID);

            callableStatement.setString(5, strSessionID);

            callableStatement.setInt(6, Integer.parseInt(iCallTypeID));

            callableStatement.setString(7, strTimeStamp);
            
            callableStatement.setString(8, strCallType);

            callableStatement.registerOutParameter(9, java.sql.Types.INTEGER);

            callableStatement.executeUpdate();

            strCallDetailID = callableStatement.getBigDecimal(9).toString();

        } catch (SQLException sqlEx) {
            
            Logger.error(strCallDetailID, " SQL Exception in Call Detail Page : " + strConnID + " Message : " + sqlEx.getMessage(), false);
            
        } catch (Exception ex) {

            Logger.error(strCallDetailID, " Exception in Call Detail Page : " + strConnID + " Message : " + ex.getMessage(), false);

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

                Logger.error("", " Exception in Call Detail finally block : " + strConnID + " Message : " + sqlEx.getMessage(), false);
            }

            dbConPool.releaseConnection(strCallDetailID);
        }

        Logger.info(strCallDetailID, "Cli : " + strCli + "iDNIS : " + iDNIS 
                + "UUID : " + strUUID + "Connection Id : " + strConnID + "Session Id : " + strSessionID
                + "CallType Id : " + iCallTypeID + " Time Stamp : " +strTimeStamp+ " Call Detail ID : " + strCallDetailID + " Call Type : " + strCallType, false);
        
        strCli = iDNIS = strUUID = strConnID = strSessionID = iCallTypeID = strTimeStamp = strCallType= dataCenter = null;

        return strCallDetailID;
    }
}
