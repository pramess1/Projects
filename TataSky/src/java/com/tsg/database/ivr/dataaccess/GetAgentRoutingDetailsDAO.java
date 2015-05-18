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
 * @author Rajesh
 */
public class GetAgentRoutingDetailsDAO {

    private String vag = "";
    private String ivrExit = "";
    private String primaryLanguage = ""; 
    private String secondaryLanguage = "";

    public String getVag() {
        return vag;
    }

    public void setVag(String vag) {
        this.vag = vag;
    }

    public String getIvrExit() {
        return ivrExit;
    }

    public void setIvrExit(String ivrExit) {
        this.ivrExit = ivrExit;
    }

    public String getPrimaryLanguage() {
        return primaryLanguage;
    }

    public void setPrimaryLanguage(String primaryLanguage) {
        this.primaryLanguage = primaryLanguage;
    }

    public String getSecondaryLanguage() {
        return secondaryLanguage;
    }

    public void setSecondaryLanguage(String secondaryLanguage) {
        this.secondaryLanguage = secondaryLanguage;
    }

    public GetAgentRoutingDetailsDAO() {
    }

    public GetAgentRoutingDetailsDAO(String vag, String ivrExit, String primaryLanguage, String secondaryLanguage) {

        this.vag = vag;
        this.ivrExit = ivrExit;
        this.primaryLanguage = primaryLanguage;
        this.secondaryLanguage = secondaryLanguage;

    }

    public ArrayList agentRoutingDetails(String cli, String dbCallDetailId) {

        String dataCenter = ConfigurationReader.configList.get("DATACENTER");

        DBConnectionPool dbConPool = new DBConnectionPool();

        dbConPool.setPoolDataSource(dataCenter + "IVRPRDB");

        Connection conn = null;

        ResultSet rs = null;

        ArrayList agentRoutingDetailsList = new ArrayList();

        CallableStatement callableStatement = null;

        String strProc = "{call " + ConfigurationReader.configList.get("PROC_NAME_GET_AGENT_ROUTING_DETAILS") + "(?,?,?,?,?)}";

        try {

            conn = dbConPool.getConnection(dbCallDetailId);

            callableStatement = conn.prepareCall(strProc);

            callableStatement.setString(1, cli);

            callableStatement.registerOutParameter(2, java.sql.Types.VARCHAR);

            callableStatement.registerOutParameter(3, java.sql.Types.VARCHAR);

            callableStatement.registerOutParameter(4, java.sql.Types.VARCHAR);

            callableStatement.registerOutParameter(5, java.sql.Types.VARCHAR);

            callableStatement.executeUpdate();

            vag = callableStatement.getString(2).toString();

            ivrExit = callableStatement.getString(3).toString();

            primaryLanguage = callableStatement.getString(4).toString();

            secondaryLanguage = callableStatement.getString(5).toString();

            GetAgentRoutingDetailsDAO getAgentRoutingDetailsDAOobj = new GetAgentRoutingDetailsDAO(vag, ivrExit, primaryLanguage, secondaryLanguage);

            agentRoutingDetailsList.add(getAgentRoutingDetailsDAOobj);

        } catch (SQLException sqlEx) {

            Logger.error(dbCallDetailId, " SQL Exception in Get Agent Routing Details: " + cli + " Message : " + sqlEx.getMessage(), false);

        } catch (Exception ex) {

            Logger.error(dbCallDetailId, " Exception in Get Agent Routing Details: " + cli + " Message : " + ex.getMessage(), false);

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

                Logger.error(dbCallDetailId, " Exception in Get Agent Routing Details finally block : " + cli + " Message : " + sqlEx.getMessage(), false);
            }

            dbConPool.releaseConnection(dbCallDetailId);

        }

        Logger.info(dbCallDetailId, " Cli " + cli + " VAG " + vag + " IVR Exit " + ivrExit
                + " Primary Language " + primaryLanguage + " Secondary Language " + secondaryLanguage, true);

        cli = vag = ivrExit = primaryLanguage = secondaryLanguage = null;

        return agentRoutingDetailsList;
    }
}
