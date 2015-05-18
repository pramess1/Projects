<%@page language="java" contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.tsg.common.*"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean LZ_SimulatorMode = false; // Simulator Mode by default is set to true.
        String LZ_CallFlowDetailXML = ""; // This is used to store the call flow detail XML.
        String LZ_NUANCE_URL = ""; // This is used to store the NUANCE URL.
        String LZ_DBCallDetailID = ""; // This is used to store the call detail ID.
        try {
//            LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
            LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");
            LZ_DBCallDetailID = state.optString("GZ_DBCallDetailID", "");
            Logger.info(LZ_DBCallDetailID, " RetrievePostRechargeDetails Input", false);
            if (LZ_SimulatorMode) {
            } else {
                LZ_NUANCE_URL = ConfigurationReader.configList.get("NUANCE_URL");
            }
        } catch (Exception ex) {
            Logger.error(LZ_DBCallDetailID, " Exception in RetrievePostRechargeDetails Page : " + ex.getMessage(), false);
        } finally {
            Logger.info(LZ_DBCallDetailID, " RetrievePostRechargeDetails Output = LZ_NUANCE_URL : " + LZ_NUANCE_URL, false);
            LZ_CallFlowDetailXML = null;
        }
        JSONObject result = new JSONObject();
        result.put("NUANCE_URL", LZ_NUANCE_URL);

        return result;

    };
%>
<%-- GENERATED: DO NOT REMOVE --%> 
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONException"%>
<%@page import="java.util.Map"%>

<%@page import="org.w3c.dom.Document"%>
<%@page import="Common.ActionObjects.*"%>

<%@include file="../backend.jspf" %>