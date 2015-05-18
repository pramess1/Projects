<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean LZ_SimulatorMode = false; // Simulator Mode by default is set to true.
        String LZ_CallFlowDetailXML = ""; // This is used to store the call flow detail XML.
        String LZ_DBCallDetailID = ""; // This is used to store the call detail ID.
        String LZ_BACallerType = ""; // Caller Type is either Partner, Subscriber RMN, Prospect, Non RMN
        String LZ_BASelected_Language = ""; // Language selected by the caller in IVR (Auto/Manual)
        String LZ_BASubscriberIDCount = ""; // Number of subscribers for a particular RMN
        String LZ_BAPrimary_Language = ""; // Primary Language of subscriber
        String LZ_BASecondary_Language = ""; // Primary Language of subscriber
        

        try {
//            LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
//            LZ_DBCallDetailID = state.getString("LZ_DBCallDetailID");
            LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");
            LZ_DBCallDetailID = state.optString("LZ_DBCallDetailID","");    
            Logger.info(LZ_DBCallDetailID, " RetrieveCallerDetails Page Input = CallFlowDetailXML : " + LZ_CallFlowDetailXML, false);                   
            if (LZ_SimulatorMode) {
                // Test
            } else {
                Document docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);
                LZ_BACallerType = XMLAO.getNodeValueText(docBA, "BA_CALLER_TYPE");
                LZ_BASelected_Language = XMLAO.getNodeValueText(docBA, "BA_SELECTED_LANGUAGE");
                LZ_BAPrimary_Language = XMLAO.getNodeValueText(docBA, "BA_PRIMARY_LANGUAGE");
                LZ_BASecondary_Language = XMLAO.getNodeValueText(docBA, "BA_SECONDARY_LANGUAGE");
                //System.out.println("LZ_BASelected_Language From Agent" + LZ_BASelected_Language);
                LZ_BASubscriberIDCount = XMLAO.getNodeValueText(docBA, "BA_SUBSCRIBER_ID_COUNT");
            }
        } catch (Exception ex) {
            Logger.error(LZ_DBCallDetailID, " Exception in Retrieve Caller Details Page : " + ex.getMessage(), false);
        } finally {
            
            Logger.info(LZ_DBCallDetailID, " RetrieveCallerDetails Page Output = LZ_BACallerType : " + LZ_BACallerType + " LZ_BASelected_Language : " + LZ_BASelected_Language + " LZ_BASubscriberIDCount :" 
                + LZ_BASubscriberIDCount + " LZ_BAPrimary_Language : " + LZ_BAPrimary_Language + " LZ_BASecondary_Language : " + LZ_BASecondary_Language, false);
        
            LZ_CallFlowDetailXML = LZ_DBCallDetailID = null;
        }
        
        JSONObject result = new JSONObject();
        result.put("BACallerType", LZ_BACallerType);
        result.put("BASelected_Language", LZ_BASelected_Language);
        result.put("BASubscriberIDCount", LZ_BASubscriberIDCount);
        result.put("BAPrimary_Language", LZ_BAPrimary_Language);
        result.put("BASecondary_Language", LZ_BASecondary_Language);

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