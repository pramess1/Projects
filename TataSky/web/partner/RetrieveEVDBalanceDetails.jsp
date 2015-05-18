<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean LZ_SimulatorMode = false; // Simulator Mode by default is set to true.
        String LZ_CallFlowDetailXML = ""; // This is used to store the call flow detail XML.
        String LZ_DBCallDetailID = ""; // This is used to store the call detail ID.
        String LZ_BAPartnerID = ""; // This is used to store the ANI of the call.

        try {
            LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");

            if (LZ_SimulatorMode) {
            } else {
                Document docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);

                LZ_BAPartnerID = XMLAO.getNodeValueText(docBA, "BA_PARTNER_ID");
            }
        } catch (Exception ex) {
            Logger.error(LZ_DBCallDetailID, " Exception in RetrieveEVDBalanceDetails Page : " + ex.getMessage(), false);
        }finally{
        
            LZ_CallFlowDetailXML = LZ_DBCallDetailID = null;
        }

        JSONObject result = new JSONObject();
        result.put("BAPartnerID", LZ_BAPartnerID);

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