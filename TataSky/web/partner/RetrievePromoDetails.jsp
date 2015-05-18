<%@page language="java" contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.tsg.common.*"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean LZ_SimulatorMode = false; // Simulator Mode by default is set to true.
        String LZ_CallFlowDetailXML = ""; // This is used to store the call flow detail XML.
        String LZ_DBCallDetailID = ""; // This is used to store the call detail ID.
        String LZ_BAPartnerType = ""; // Type of the partner (Sales/Field)
        String LZ_BANationalPromoFlag = ""; // National Promo Flag
        String LZ_BAState = ""; // State which the subscription belongs to
        String LZ_BAPincode = ""; // PIN code which the subscription belongs to

        try {
//            LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
            LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");            

            if (LZ_SimulatorMode) {
            } else {
                Document docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);

                LZ_BAPartnerType = XMLAO.getNodeValueText(docBA, "BA_PARTNER_TYPE");

                LZ_BANationalPromoFlag = ConfigurationReader.configList.get("NATIONAL_PROMO_FLAG");

                LZ_BAState = XMLAO.getNodeValueText(docBA, "BA_STATE");
                LZ_BAPincode = XMLAO.getNodeValueText(docBA, "BA_PIN_CODE");
            }
        } catch (Exception ex) {
            Logger.error(LZ_DBCallDetailID, " Exception in RetrievePromoDetails Page : " + ex.getMessage(), false);
        }finally{
        
            LZ_DBCallDetailID = LZ_CallFlowDetailXML = null;
        }

        JSONObject result = new JSONObject();
        result.put("BAPartnerType", LZ_BAPartnerType);
        result.put("BANationalPromoFlag", LZ_BANationalPromoFlag);
        result.put("BAState", LZ_BAState);
        result.put("BAPincode", LZ_BAPincode);

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