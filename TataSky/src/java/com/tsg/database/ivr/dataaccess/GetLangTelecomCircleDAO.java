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
import java.util.ArrayList;
import oracle.jdbc.OracleCallableStatement;
import oracle.jdbc.OracleTypes;

/**
 *
 * @author Pramesh
 */
public class GetLangTelecomCircleDAO {

    private String telecomCircle = null;
    private String langCode = null;

    public GetLangTelecomCircleDAO() {
    }

    public GetLangTelecomCircleDAO(String telecomCircle, String langCode) {

        this.telecomCircle = telecomCircle;

        this.langCode = langCode;

    }

    public String gettelecomCircle() {

        return telecomCircle;
    }

    public void settelecomCircle(String telecomCircle) {

        this.telecomCircle = telecomCircle;
    }

    public String getlangCode() {

        return langCode;
    }

    public void setlangCode(String langCode) {

        this.langCode = langCode;
    }

    public ArrayList getLangCodeAndTelecomCircle(String dbCallDetailId, String callerType, String DNIS, String state) {

        Logger.info(dbCallDetailId, "Input Values dbCallDetailId : " + dbCallDetailId + " callerType : " + callerType + " DNIS : " + DNIS + " state : " + state, false);

        String dataCenter = ConfigurationReader.configList.get("DATACENTER");

        Logger.info(dbCallDetailId, "DataCenter : " + dataCenter, false);

        DBConnectionPool dbConPool = new DBConnectionPool();

        dbConPool.setPoolDataSource(dataCenter + "IVRPRDB");

        //Logger.info(dbCallDetailId, "set " + dataCenter + "IVRPRDB as PoolDataSource", false);

        Connection conn = null;

        ResultSet rs = null;

        CallableStatement callableStatement = null;

        ArrayList telecomList = new ArrayList();

        String strProc = "{call  " + ConfigurationReader.configList.get("PROC_NAME_GET_LANG_TELECOM_CIRCLE") + "(?,?,?,?,?)}";

        String isProspect = null;

        int tempDNIS = 0;

        if (callerType.equalsIgnoreCase("Prospect")) {

            isProspect = "S";

        } else {

            isProspect = "D";

            tempDNIS = Integer.parseInt(DNIS);

            state = null;

        }

        Logger.info(dbCallDetailId, "Input for Stored Procedure Prospect : " + isProspect + " State : " + state + " DNIS  : " + tempDNIS, false);

        try {

            conn = dbConPool.getConnection(dbCallDetailId);

            callableStatement = conn.prepareCall(strProc);

            callableStatement.setString(1, isProspect);

            callableStatement.setInt(2, tempDNIS);

            callableStatement.setString(3, state);

            callableStatement.registerOutParameter(4, java.sql.Types.VARCHAR);

            callableStatement.registerOutParameter(5, java.sql.Types.VARCHAR);

            callableStatement.executeUpdate();

            langCode = callableStatement.getString(4);

            telecomCircle = callableStatement.getString(5);

            Logger.info(dbCallDetailId, "OutPut telecomCircle : " + telecomCircle + " langCode : " + langCode, false);

            GetLangTelecomCircleDAO getTelecomCircleObj = new GetLangTelecomCircleDAO(telecomCircle, langCode);

            telecomList.add(getTelecomCircleObj);

        } catch (SQLException sqlEx) {

            Logger.error(dbCallDetailId, " SQL Exception in Get LangCode And TelecomCircle XML Page TelecomCircle : " + telecomCircle + " LangCode is : " + langCode + " Message : " + sqlEx.getMessage(), false);

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

                Logger.error(dbCallDetailId, " SQL Exception in Get LangCode And TelecomCircle XML Page TelecomCircle: " + telecomCircle + " LangCode is : " + langCode + " Message : " + sqlEx.getMessage(), false);
            }

            dbConPool.releaseConnection(dbCallDetailId);
        }

        return telecomList;

    }
}
