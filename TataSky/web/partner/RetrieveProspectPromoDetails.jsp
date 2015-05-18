<%@page language="java" contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.tsg.log.Logger"%>
<%!    private boolean LZ_SimulatorMode = false; // Simulator Mode by default is set to true.
    private String LZ_CallFlowDetailXML = ""; // This is used to store the call flow detail XML.
    private String LZ_BACallerType = ""; // Type of the caller (Subscriber/Partner/Prospect etc.)
    private String LZ_BAProspectPromoFlag = ""; // Prospect promo flag
    private String LZ_BAProspectPromoDetailFlag = ""; // Prospect promo detail flag

    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        try {
//            LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
            LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");            

            if (LZ_SimulatorMode) {
            } else {
                Document docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);

                LZ_BACallerType = XMLAO.getNodeValueText(docBA, "BA_CALLER_TYPE");
                LZ_BAProspectPromoFlag = XMLAO.getNodeValueText(docBA, "BA_PROSPECT_PROMO_FLAG");
                LZ_BAProspectPromoDetailFlag = XMLAO.getNodeValueText(docBA, "BA_PROSPECT_PROMO_DETAIL_FLAG");
            }
        } catch (Exception ex) {
            Logger.error("", " Exception in RetrieveProspectPromoDetails Page : " + ex.getMessage(), false);
        } finally {
            LZ_CallFlowDetailXML = null;
        }

        JSONObject result = new JSONObject();
        result.put("BACallerType", LZ_BACallerType);
        result.put("BAProspectPromoFlag", LZ_BAProspectPromoFlag);
        result.put("BAProspectPromoDetailFlag", LZ_BAProspectPromoDetailFlag);

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