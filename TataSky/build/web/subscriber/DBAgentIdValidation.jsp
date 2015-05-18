<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>

<%@page import="com.tsg.database.ivr.dataaccess.DatabaseProcessorDAO"%>
<%@page import="com.tsg.database.ivr.dataaccess.GetHostNameDAO"%>
<%@page import="com.tsg.net.StatServerCommunication"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean b_SimulatorMode = false; // Simulator Mode by default is set to true.

// Input varibales
        String LZ_UserID = "";

        String LZ_CallDetailID = ""; // This is used to store the call detail ID.

// output varibales
        String LZ_AgentFlag = "N";

        String LZ_HostName = "N";//SHEBDINI6240MBS

        String LZ_AgentInfo = "N";


        try {

            if (b_SimulatorMode) {
                //  Test method
            } else {
                // Realtime scenario
//                LZ_CallDetailID = state.getString("GZ_DBCallDetailID");
//
//                LZ_UserID = state.getString("LZ_UserID");
                LZ_CallDetailID = state.optString("GZ_DBCallDetailID","");

                LZ_UserID = state.optString("LZ_UserID","");

                Logger.info(LZ_CallDetailID, " User Id : " + LZ_UserID, false);

                GetHostNameDAO getHostName = new GetHostNameDAO();

                LZ_HostName = getHostName.hostName(LZ_UserID, LZ_CallDetailID);

                if (!("N").equalsIgnoreCase(LZ_HostName)) {

                    Logger.info(LZ_CallDetailID, " HostName : " + LZ_HostName, false);

                    LZ_AgentInfo = new StatServerCommunication().AgentInfo(LZ_HostName, LZ_CallDetailID);

                    if (!("N").equalsIgnoreCase(LZ_AgentInfo)) {

                        Logger.info(LZ_CallDetailID, " Agent Info : " + LZ_AgentInfo, false);

                        DatabaseProcessorDAO dbProcessorDAO = new DatabaseProcessorDAO();

                        LZ_AgentFlag = dbProcessorDAO.agentIdValidation(LZ_AgentInfo, LZ_CallDetailID);

                    }
                }
            }

        } catch (Exception ex) {

            Logger.error(LZ_CallDetailID, " Exception in Agent Id Validation Page :  " + ex.getMessage(), false);

        } finally {

            LZ_UserID = LZ_HostName = LZ_AgentInfo = null;

        }
        LZ_AgentFlag="Y";

        JSONObject result = new JSONObject();

        result.put("LZ_AgentFlag", LZ_AgentFlag);

        Logger.info(LZ_CallDetailID, " Agent Flag : " + LZ_AgentFlag, false);

        return result;

    }

    ;
%>
<%-- GENERATED: DO NOT REMOVE --%> 
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONException"%>
<%@page import="java.util.Map"%>
<%@include file="../backend.jspf" %>