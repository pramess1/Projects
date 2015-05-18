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

import oracle.jdbc.OracleCallableStatement;

import oracle.jdbc.OracleTypes;

/**
 *
 * @author Rajesh
 */
public class GetEVDBalanceDAO {

    public String getEVDBalance(String partnerId, String rmn, String dbCallDetailId) {

        String dataCenter = ConfigurationReader.configList.get("DATACENTER");

        DBConnectionPool dbConPool = new DBConnectionPool();

        dbConPool.setPoolDataSource(dataCenter+"GGPRDB");

        Connection conn = null;

        CallableStatement callableStatement = null;

        ResultSet rs = null;

        String balance = "N";

        String flag;

        String strProc = "{call " + ConfigurationReader.configList.get("PROC_NAME_GET_EVDBALANCE") + "(?,?,?,?)}";


        try {

            conn = dbConPool.getConnection(dbCallDetailId);

            callableStatement = conn.prepareCall(strProc);

            callableStatement.setString(1, partnerId);

            callableStatement.setString(2, rmn);

            callableStatement.registerOutParameter(3, java.sql.Types.VARCHAR);

            callableStatement.registerOutParameter(4, OracleTypes.CURSOR);

            callableStatement.execute();

            flag = callableStatement.getString(3).toString();

            if (flag.equalsIgnoreCase("Y")) {

                rs = ((OracleCallableStatement) callableStatement).getCursor(4);

                while (rs.next()) {

                    balance = rs.getString(1);

                }

            }

        } catch (Exception ex) {

            Logger.error(dbCallDetailId, " Exception in EVD Balance Page : " + ex.getMessage(), false);

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

                Logger.error(dbCallDetailId, " Exception in EVD Balance finally block : " + partnerId + " Message : " + sqlEx.getMessage(), false);
            }

            dbConPool.releaseConnection(dbCallDetailId);

        }

        Logger.info(dbCallDetailId, " EVD Balance PartnerId: " + partnerId + " Cli : " + rmn + " Balance  : " + balance, false);

        partnerId = dataCenter = null;

        return balance;
    }
}