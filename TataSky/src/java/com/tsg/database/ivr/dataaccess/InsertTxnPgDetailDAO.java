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
public class InsertTxnPgDetailDAO {

    public String insertTransactionPgDetail(String transPgDetailXml, String Transaction) {

        String dataCenter = ConfigurationReader.configList.get("DATACENTER");
        
        DBConnectionPool dbConPool = new DBConnectionPool();

        dbConPool.setPoolDataSource(dataCenter + "IVRPRDB");

        Connection conn = null;

        CallableStatement callableStatement = null;

        String transPgDetailId = null;

        ResultSet rs = null;

        String strProc = "{call " + ConfigurationReader.configList.get("PROC_NAME_INSERT_TXN_PG_DETAIL") + "(?,?,?)}";

        try {

            conn = dbConPool.getConnection("");

            callableStatement = conn.prepareCall(strProc);

            callableStatement.setString(1, transPgDetailXml);

            callableStatement.setString(2, Transaction);

            callableStatement.registerOutParameter(3, OracleTypes.CURSOR);

            callableStatement.execute();

            rs = ((OracleCallableStatement) callableStatement).getCursor(3);

            while (rs.next()) {

                transPgDetailId = rs.getString(1);
            }

        } catch (SQLException sqlEx) {

            Logger.error("", " SQL Exception in Insert PG Transaction Detail Page : " + sqlEx.getMessage(), false);

        } catch (Exception ex) {

            Logger.error("", " Exception in Insert PG Transaction Detail Page : " + ex.getMessage(), false);

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

                Logger.error("", " Exception in Insert Transcation PG Detail finally block : " + sqlEx.getMessage(), false);
            }

            dbConPool.releaseConnection("");
        }

        transPgDetailXml = Transaction = dataCenter = null;

        Logger.info("", " Insert PG Transaction Detail : " + transPgDetailId, false);

        return transPgDetailId;
    }
}