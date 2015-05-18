<%@page language="java" contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean LZ_SimulatorMode = false; // Simulator Mode by default is set to true.
        String LZ_CallFlowDetailXML = ""; // This is used to store the call flow detail XML.

        String BA_PREMIUM_FLAG = ""; // 
        String BA_SUBSCRIBER_ID = ""; //
        String BA_ACCOUNT_STATUS = ""; // 
        String LZ_DBCallDetailID = ""; // This is used to store the call detail ID.

        try {
//            LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
            LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");            

            if (LZ_SimulatorMode) {
                BA_SUBSCRIBER_ID = "N";
                BA_PREMIUM_FLAG = "1234567890";
            } else {
                Document docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);

                BA_PREMIUM_FLAG = XMLAO.getNodeValueText(docBA, "BA_PREMIUM_FLAG");
                BA_SUBSCRIBER_ID = XMLAO.getNodeValueText(docBA, "BA_SUBSCRIBER_ID");
                BA_ACCOUNT_STATUS = XMLAO.getNodeValueText(docBA, "BA_ACCOUNT_STATUS");
            }
        } catch (Exception ex) {
            Logger.error(LZ_DBCallDetailID, " Exception in RetrieveInstallerVisitScheduleDetails Page : " + ex.getMessage(), false);
        }finally{
        
         LZ_CallFlowDetailXML =LZ_DBCallDetailID = null;
        
        }

        JSONObject result = new JSONObject();
        result.put("PREMIUM_FLAG", BA_PREMIUM_FLAG);
        result.put("SUBSCRIBER_ID", BA_SUBSCRIBER_ID);
        result.put("ACCOUNT_STATUS", BA_ACCOUNT_STATUS);

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