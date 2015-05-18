<%@page language="java" contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean LZ_SimulatorMode = false; // Simulator Mode by default is set to true.
        String LZ_CallFlowDetailXML = ""; // This is used to store the call flow detail XML.

        String BA_PREMIUM_FLAG = ""; // 
        String BA_STB_TYPE = ""; // STB Type
        String BA_SUBSCRIPTION_TYPE = ""; // Subscription Type
        String BA_ACCOUNT_STATUS = ""; // Account Status

        try {
//            LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
            LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");            

            if (LZ_SimulatorMode) {
                BA_PREMIUM_FLAG = "N";
                BA_STB_TYPE = "HD";
            } else {
                Document docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);

                BA_PREMIUM_FLAG = XMLAO.getNodeValueText(docBA, "BA_PREMIUM_FLAG");
                BA_STB_TYPE = XMLAO.getNodeValueText(docBA, "BA_STB_TYPE");
                BA_SUBSCRIPTION_TYPE = XMLAO.getNodeValueText(docBA, "BA_SUBSCRIPTION_TYPE");
                BA_ACCOUNT_STATUS = XMLAO.getNodeValueText(docBA, "BA_ACCOUNT_STATUS");

            }
        } catch (Exception ex) {
            Logger.error("", " Exception in RetrieveMTVDynamicMenuDetails Page : " + ex.getMessage(), false);
        } finally {
            LZ_CallFlowDetailXML = null;
        }

        JSONObject result = new JSONObject();
        result.put("PREMIUM_FLAG", BA_PREMIUM_FLAG);
        result.put("STB_TYPE", BA_STB_TYPE);
        result.put("SUBSCRIPTION_TYPE", BA_SUBSCRIPTION_TYPE);
        result.put("ACCOUNT_STATUS", BA_ACCOUNT_STATUS);

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