<%@page language="java" contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean LZ_SimulatorMode = false; // Simulator Mode by default is set to true.
        String LZ_CallFlowDetailXML = ""; // This is used to store the call flow detail XML.
        String LZ_NADDESK = "";
        String LZ_BA_XML = "";

        try {

            LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML", "");
            LZ_NADDESK = state.optString("LZ_NADBucket", "");
            LZ_BA_XML = "<BA_SEGMENT_SUBTYPE>" + LZ_NADDESK + "</BA_SEGMENT_SUBTYPE>";


            if (LZ_SimulatorMode) {
            } else {
                if (!LZ_NADDESK.isEmpty()) {

                    LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("<BA_ROOT>", "<BA_ROOT>" + LZ_BA_XML);


                }
            }

        } catch (Exception ex) {
            Logger.error("", " Exception in SetAgentDeskDetails Page : " + ex.getMessage(), false);
        } finally {
            LZ_BA_XML = null;
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
<%@include file="../backend.jspf" %>