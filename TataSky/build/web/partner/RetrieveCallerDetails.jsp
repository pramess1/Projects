<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean LZ_SimulatorMode = false; // Simulator Mode by default is set to true.
        String LZ_CallFlowDetailXML = ""; // This is used to store the call flow detail XML.
        String LZ_DBCallDetailID = ""; // This is used to store the call detail ID. 
        String LZ_BACallerType = ""; // Caller Type is either Partner, Subscriber RMN, Prospect, Non RMN
        String LZ_BAPartnerAccountStatus = ""; // Partner Account status (Active/Terminated)
        String LZ_BASelected_Language = ""; // Language selected by the caller in IVR (Auto/Manual)
       

        try {
//            LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
            
            LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");            

            if (LZ_SimulatorMode) {
            } else {
            	
            	
                
                Document docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);
                LZ_BACallerType = XMLAO.getNodeValueText(docBA, "BA_CALLER_TYPE");
                LZ_BAPartnerAccountStatus = XMLAO.getNodeValueText(docBA, "BA_PARTNER_ACCOUNT_STATUS");
                LZ_BASelected_Language = XMLAO.getNodeValueText(docBA, "BA_SELECTED_LANGUAGE");
            }
        } catch (Exception ex) {
            Logger.error("", " Exception in RetrieveCallerDetails Page : " + ex.getMessage(), false);
        } finally{
            LZ_CallFlowDetailXML = LZ_DBCallDetailID = null;
        }

        JSONObject result = new JSONObject();
        result.put("BACallerType", LZ_BACallerType);
        result.put("BAPartnerAccountStatus", LZ_BAPartnerAccountStatus);
        result.put("BASelected_Language", LZ_BASelected_Language);
       

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