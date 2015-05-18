<%@page language="java" contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.tsg.log.Logger"%>
<%!    private boolean LZ_SimulatorMode = false; // Simulator Mode by default is set to true.
    private String LZ_CallFlowDetailXML = ""; // This is used to store the call flow detail XML.
    private String BA_ACCOUNT_STATUS = ""; // 
    private String BA_STB_TYPE = ""; // 

    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        try {
//            LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
            LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");            

            if (LZ_SimulatorMode) {
                BA_ACCOUNT_STATUS = "Active";
                BA_STB_TYPE = "HD";
            } else {
                Document docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);

                BA_ACCOUNT_STATUS = XMLAO.getNodeValueText(docBA, "BA_ACCOUNT_STATUS");
                BA_STB_TYPE = XMLAO.getNodeValueText(docBA, "BA_STB_TYPE");
            }
        } catch (Exception ex) {
            Logger.error("", " Exception in RetrieveWhatsNewInTataSkyWhatDetails Page : " + ex.getMessage(), false);
        } finally {
            LZ_CallFlowDetailXML = null;
        }

        JSONObject result = new JSONObject();
        result.put("ACCOUNT_STATUS", BA_ACCOUNT_STATUS);
        result.put("STB_TYPE", BA_STB_TYPE);


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