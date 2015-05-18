<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>

<%@page import="com.tsg.util.Util"%>
<%@page import="com.tsg.error.ErrorHandler"%>
<%@page import="com.tsg.requesthandler.requestDelegator"%>
<%@page import="com.tsg.atom.GetDetails"%>
<%@page import="com.tsg.atom.GetDetailsResponse"%>
<%@page import="com.tsg.xml.GenerateXml"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean b_SimulatorMode = false; // Simulator Mode by default is set to true.

//Input variables
        String LZ_UsrDNIS = "";

        String LZ_CallFlowDetailXML = "";

        String BA_APP_LANGUAGE = "";

        try {
            if (b_SimulatorMode) {
            } else {

//                LZ_UsrDNIS = state.getString("LZ_UsrDNIS");
//
//                LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
                
                LZ_UsrDNIS = state.optString("LZ_UsrDNIS","");

                LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");

                Document docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);

                BA_APP_LANGUAGE = XMLAO.getNodeValueText(docBA, "BA_APP_LANGUAGE");

                if (LZ_UsrDNIS.equalsIgnoreCase("6661") || LZ_UsrDNIS.equalsIgnoreCase("5551")) {
                    LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace(BA_APP_LANGUAGE, "ml-IN");
                } else if (LZ_UsrDNIS.equalsIgnoreCase("6662") || LZ_UsrDNIS.equalsIgnoreCase("5552")) {
                    LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace(BA_APP_LANGUAGE, "hi-IN");
                } else if (LZ_UsrDNIS.equalsIgnoreCase("6663") || LZ_UsrDNIS.equalsIgnoreCase("5553")) {
                    LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace(BA_APP_LANGUAGE, "kn-IN");
                } else if (LZ_UsrDNIS.equalsIgnoreCase("6664") || LZ_UsrDNIS.equalsIgnoreCase("5554")) {
                    LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace(BA_APP_LANGUAGE, "te-IN");
                } else if (LZ_UsrDNIS.equalsIgnoreCase("6665") || LZ_UsrDNIS.equalsIgnoreCase("5556")) {
                    LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace(BA_APP_LANGUAGE, "ta-IN");
                } else if (LZ_UsrDNIS.equalsIgnoreCase("6666") || LZ_UsrDNIS.equalsIgnoreCase("5555") || LZ_UsrDNIS.equalsIgnoreCase("49432102")) {
                    LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace(BA_APP_LANGUAGE, "en-IN");
                } else if (LZ_UsrDNIS.equalsIgnoreCase("6667") || LZ_UsrDNIS.equalsIgnoreCase("5557")) {
                    LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace(BA_APP_LANGUAGE, "mr-IN");
                } else if (LZ_UsrDNIS.equalsIgnoreCase("6668") || LZ_UsrDNIS.equalsIgnoreCase("5558")) {
                    LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace(BA_APP_LANGUAGE, "gu-IN");
                } else if (LZ_UsrDNIS.equalsIgnoreCase("6669") || LZ_UsrDNIS.equalsIgnoreCase("5559")) {
                    LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace(BA_APP_LANGUAGE, "bn-IN");
                } else if (LZ_UsrDNIS.equalsIgnoreCase("6670") || LZ_UsrDNIS.equalsIgnoreCase("5560")) {
                    LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace(BA_APP_LANGUAGE, "or-IN");
                } else if (LZ_UsrDNIS.equalsIgnoreCase("6671") || LZ_UsrDNIS.equalsIgnoreCase("5561")) {
                    LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace(BA_APP_LANGUAGE, "pa-IN");
                } else if (LZ_UsrDNIS.equalsIgnoreCase("6672") || LZ_UsrDNIS.equalsIgnoreCase("5562")) {
                    LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace(BA_APP_LANGUAGE, "as-IN");
                }

            }

        } catch (Exception ex) {
//            LZ_UsrDNIS = state.getString("LZ_UsrDNIS");
//            LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
            
            LZ_UsrDNIS = state.optString("LZ_UsrDNIS","");
             
            LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");

            Logger.error("", " Exception in Direct Sales Set Language Page :" + ex.getMessage(), false);

        } finally {

            LZ_UsrDNIS = BA_APP_LANGUAGE = null;

        }
        JSONObject result = new JSONObject();
        result.put("CallFlowDetailXML", LZ_CallFlowDetailXML);
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