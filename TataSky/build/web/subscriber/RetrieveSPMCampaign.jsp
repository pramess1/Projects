<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>
<%@page import="com.tsg.database.DBAccess"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.*"%>
<%@page import="com.tsg.util.Util"%>
<%@page import="com.tsg.common.*"%>
<%@page import="com.tsg.xml.GenerateXml"%>
<%@page import="com.tsg.database.gg.dataaccess.GetPkgExistFlag"%>
<%@page import="com.tsg.log.Logger"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="oracle.jdbc.OracleCallableStatement"%>
<%@page import="oracle.jdbc.OracleTypes"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {
        // Input varibales
        String LZ_DBCallDetailID = "";
        String LZ_CallFlowDetailXML = "";
        String LZ_SubscriberId = "";
        String LZ_PremiumFalg1 = "";
        String premiumFlag = "";

        Connection connection = null;
        String userName = null;
        String password = null;
        String connectionUrl = null;
        connectionUrl = "jdbc:oracle:thin:@pun-ent-scan.cct.tatasky.com:1521/PENTPUN";
        userName = "ggdbuser";
        password = "ggdbuser";

        // output varibales
        String spmCampaignFlag = "";
        String spmCampaignId = "";
        String spmPackName = "";
        try {
            // Realtime scenario
            LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML", "");
            Document docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);
            LZ_SubscriberId = XMLAO.getNodeValueText(docBA, "BA_SUBSCRIBER_ID");
            LZ_PremiumFalg1 = XMLAO.getNodeValueText(docBA, "BA_PREMIUM_FLAG1");
            LZ_DBCallDetailID = state.optString("LZ_DBCallDetailID", "");

            premiumFlag = LZ_PremiumFalg1;
            String dbCallDetailId = LZ_DBCallDetailID;
            String subscriberId = LZ_SubscriberId;

            try {
                Class.forName("oracle.jdbc.OracleDriver");
                connection = DriverManager.getConnection(connectionUrl, userName, password);
            } catch (Exception e) {
                Logger.error(dbCallDetailId, " RetrieveSPMCampaign Exception : " + e.getMessage(), false);
            }
            CallableStatement callableStatement = null;
            ResultSet rs = null;
            String strProc = "{call " + ConfigurationReader.configList.get("PROC_NAME_GET_DETAIL_BY_SUB_ID") + "(?,?,?,?,?,?,?,?,?,?)}";

            try {
                callableStatement = connection.prepareCall(strProc);
                callableStatement.setString(1, subscriberId);
                callableStatement.setString(2, premiumFlag);
                callableStatement.registerOutParameter(3, OracleTypes.CURSOR);
                callableStatement.registerOutParameter(4, OracleTypes.CURSOR);
                callableStatement.registerOutParameter(5, OracleTypes.CURSOR);
                callableStatement.registerOutParameter(6, OracleTypes.CURSOR);
                callableStatement.registerOutParameter(7, OracleTypes.CURSOR);
                callableStatement.registerOutParameter(8, OracleTypes.CURSOR);
                callableStatement.registerOutParameter(9, OracleTypes.CURSOR);
                callableStatement.registerOutParameter(10, OracleTypes.CURSOR);
                callableStatement.execute();
                rs = ((OracleCallableStatement) callableStatement).getCursor(4);
                while (rs.next()) {
                    spmCampaignFlag = rs.getString("SPM_CAMPAIGNFLAG");
                    spmCampaignId = rs.getString("CAMPAIGN_ID");
                    spmPackName = rs.getString("PACKNAME");
                }
//                rs = ((OracleCallableStatement) callableStatement).getCursor(3);
//                rs = ((OracleCallableStatement) callableStatement).getCursor(5);
//                rs = ((OracleCallableStatement) callableStatement).getCursor(6);
//                rs = ((OracleCallableStatement) callableStatement).getCursor(7);
//                rs = ((OracleCallableStatement) callableStatement).getCursor(8);
//                rs = ((OracleCallableStatement) callableStatement).getCursor(9);
            } catch (SQLException ex) {
                Logger.error(dbCallDetailId, " SQL Exception in RetrieveSPMCampaign Page : " + ex.getMessage(), false);
            } catch (Exception ex) {
                Logger.error(dbCallDetailId, " RetrieveSPMCampaign Exception in Package Exist Flag Page subscriberId : " + subscriberId + " Message : " + ex.getMessage(), false);
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
                    if (connection != null) {
                        connection.close();
                        connection = null;
                    }
                } catch (SQLException sqlEx) {
                    Logger.error(dbCallDetailId, "RetrieveSPMCampaign Exception in Package Exist Flag finally block : " + subscriberId + " Message : " + sqlEx.getMessage(), false);
                }
            }

        } catch (Exception ex) {
            Logger.error(LZ_DBCallDetailID, " Exception in RetrieveSPMCampaign  :   " + ex.getMessage(), false);
        } finally {
            LZ_DBCallDetailID = null;
        }
        JSONObject result = new JSONObject();

        result.put("LZ_spmCampaignFlag", spmCampaignFlag);
        result.put("LZ_spmCampaignId", spmCampaignId);
        result.put("LZ_spmPackName", spmPackName);
        return result;
    }

    ;
%>
<%-- GENERATED: DO NOT REMOVE --%> 
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONException"%>
<%@page import="java.util.Map"%>
<%@page import="org.w3c.dom.Document"%>
<%@page import="Common.ActionObjects.*"%>
<%@include file="../backend.jspf" %>