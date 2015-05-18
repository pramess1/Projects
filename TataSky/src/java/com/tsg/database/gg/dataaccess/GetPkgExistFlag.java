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
 * @author Pramesh
 */
public class GetPkgExistFlag {

    public String getPkgExistFlag(String subscriberId, String packageName, String dbCallDetailId) {

        Logger.info(dbCallDetailId, " Input from JSP : Subscriber Id : " + subscriberId + "PackName : " + packageName, false);

        String dataCenter = ConfigurationReader.configList.get("DATACENTER");

        DBConnectionPool dbConPool = new DBConnectionPool();

        dbConPool.setPoolDataSource(dataCenter + "GGPRDB");

        Connection conn = null;

        CallableStatement callableStatement = null;

        ResultSet rs = null;

        String existFlag = "";

        String dbPackName = "";

        String strProc = "{call " + ConfigurationReader.configList.get("PROC_NAME_GET_PKG_EXIST_FLAG") + "(?,?,?,?)}";

        try {

            conn = dbConPool.getConnection(dbCallDetailId);

            callableStatement = conn.prepareCall(strProc);

            callableStatement.setString(1, subscriberId.trim());

            callableStatement.setString(2, packageName.trim());

            callableStatement.registerOutParameter(3, java.sql.Types.VARCHAR);

            callableStatement.registerOutParameter(4, OracleTypes.CURSOR);

            callableStatement.execute();

            existFlag = callableStatement.getString(3).toString();
            
            Logger.debug(dbCallDetailId, "Exist Flag : " + existFlag, false);

            rs = ((OracleCallableStatement) callableStatement).getCursor(4);

            while (rs.next()) {

                dbPackName = rs.getString(1);
            }
            
            Logger.debug(dbCallDetailId, "Pack Name : " + dbPackName, false);
            
        } catch (Exception ex) {

            Logger.error(dbCallDetailId, " Exception in Package Exist Flag Page subscriberId : " + subscriberId + " Message : " + ex.getMessage(), false);

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

                Logger.error(dbCallDetailId, " Exception in Package Exist Flag finally block : " + subscriberId + " Message : " + sqlEx.getMessage(), false);
            }

            dbConPool.releaseConnection(dbCallDetailId);
        }

        Logger.info(dbCallDetailId, " Package Exist Flag Trimmed Subscriber Id : " + subscriberId + " Flag : " + existFlag.trim() + " Pack Name : " + dbPackName, false);

        subscriberId = dataCenter = null;

        return existFlag.trim() + "||" + dbPackName.trim();
    }
}
