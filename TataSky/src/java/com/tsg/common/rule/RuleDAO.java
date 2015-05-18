/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tsg.common.rule;

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
public class RuleDAO {

    public String[] retrieveRuleAction(String[] strActionCode, String dbCallDetailId) {

        String dataCenter = ConfigurationReader.configList.get("DATACENTER");
        
        DBConnectionPool dbConPool = new DBConnectionPool();

        dbConPool.setPoolDataSource(dataCenter + "IVRPRDB");

        Connection conn = null;

        CallableStatement callableStatement = null;

        String[] strRuleActionResult = {"", ""};

        String strProc = "{call " + ConfigurationReader.configList.get("PROC_NAME_RULE") + "(?,?,?,?)}";

        try {

            conn = dbConPool.getConnection(dbCallDetailId);

            callableStatement = conn.prepareCall(strProc);

            callableStatement.setString(1, strActionCode[0]);

            callableStatement.setString(2, strActionCode[1]);

            callableStatement.registerOutParameter(3, java.sql.Types.VARCHAR);

            callableStatement.registerOutParameter(4, java.sql.Types.VARCHAR);

            callableStatement.execute();

            strRuleActionResult[0] = callableStatement.getString(3).toString();

            strRuleActionResult[1] = callableStatement.getString(4).toString();

        } catch (SQLException sqeEx) {

            Logger.error(dbCallDetailId, " Exception in Rule DAO DB Connection Page :" + sqeEx.getMessage(), false);

        } catch (Exception ex) {

            Logger.error(dbCallDetailId, " Exception in  Rule DAO DB Connection Page :" + ex.getMessage(), false);

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

                Logger.error(dbCallDetailId, " Exception in Retrieve Rule finally block : " + sqlEx.getMessage(), false);
            
            } finally {

                dbConPool.releaseConnection(dbCallDetailId);

            }
        }

        Logger.info(dbCallDetailId, " strRuleActionResult[0] : " + strRuleActionResult[0] + " strRuleActionResult[1] : " + strRuleActionResult[1], true);

        dataCenter = dbCallDetailId = null;
        
        return strRuleActionResult;
    }
}
