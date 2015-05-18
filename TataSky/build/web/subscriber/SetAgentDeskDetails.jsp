<%@page language="java" contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean LZ_SimulatorMode = false; // Simulator Mode by default is set to true.
        String LZ_CallFlowDetailXML = ""; // This is used to store the call flow detail XML.
        String LZ_RoutePoint = ""; // This is used to store the result route point.
        String LZ_DBCallDetailID = ""; // This is used to store the call detail ID.

        try {
//            LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
//            LZ_RoutePoint = state.getString("LZ_RoutePoint");
            LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");
            LZ_RoutePoint = state.optString("LZ_RoutePoint","");            
            LZ_DBCallDetailID = state.optString("LZ_DBCallDetailID","");
            Logger.info(LZ_DBCallDetailID, " SetAgentDeskDetails Input = LZ_RoutePoint : " + LZ_RoutePoint, false);
            if (LZ_SimulatorMode) {
            } else {
                if (!LZ_RoutePoint.isEmpty()) {
                    int LZ_StartIndex = LZ_CallFlowDetailXML.indexOf("<CTIDESK>");
                    int LZ_EndIndex = LZ_CallFlowDetailXML.indexOf("</CTIDESK>", LZ_StartIndex) + 10;
                    String LZ_temp = LZ_CallFlowDetailXML.substring(LZ_StartIndex, LZ_EndIndex);
                    LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace(LZ_temp, "<CTIDESK>" + LZ_RoutePoint + "</CTIDESK>");
                    LZ_temp = null;
                }
            }

        } catch (Exception ex) {
            Logger.error(LZ_DBCallDetailID, " Exception in SetAgentDeskDetails Page : " + ex.getMessage(), false);
        } finally {
            Logger.info(LZ_DBCallDetailID, " SetAgentDeskDetails Output ", false);
            LZ_RoutePoint = LZ_DBCallDetailID = null;
        }

        JSONObject result = new JSONObject();
        result.put("CallFlowDetailXML", LZ_CallFlowDetailXML);

        return result;

    };
%>
<%-- GENERATED: DO NOT REMOVE --%> 
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONException"%>
<%@page import="java.util.Map"%>
<%@include file="../backend.jspf" %>