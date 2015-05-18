<%@page language="java" contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.tsg.database.DBAccess"%>
<%@page import="com.tsg.common.*"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean LZ_SimulatorMode = false; // Simulator Mode by default is set to true.
        String LZ_CallFlowDetailXML = ""; // This is used to store the call flow detail XML.

        String LZ_BACallerType = ""; // Type of the caller (Subscriber/Partner/Prospect etc.)
        String LZ_BAPremiumFlag = ""; // Premium flag whether the subscriber is premium or not
        String LZ_BASTBType = ""; // Type of the STB (HD, SD etc.)
        String LZ_BAAccountStatus = ""; // Account status (Active/De-Active)
        String LZ_BANationalPromoFlag = ""; // National Promo Flag
        String LZ_BAState = ""; // State which the subscription belongs to
        String LZ_BAPincode = ""; // PIN code which the subscription belongs to
        String LZ_BASPMCampaignFlag = ""; // Personal campaign associated to subscriber flag
        String LZ_BASPMPackName = ""; // Personal campaign name associated to subscriber
        String LZ_BASubscriptionType = ""; // Monthly/LDP etc.
        String LZ_BAAccountSubStatus = ""; // Subscription sub status (Partially done etc.)
        String LZ_NUANCE_URL = ""; // This is used to store the NUANCE URL.
        try {
//            LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
            LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");            
            if (LZ_SimulatorMode) {
            } else {
                Document docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);
                LZ_BACallerType = XMLAO.getNodeValueText(docBA, "BA_CALLER_TYPE");
                LZ_BAPremiumFlag = XMLAO.getNodeValueText(docBA, "BA_PREMIUM_FLAG");
                LZ_BASTBType = XMLAO.getNodeValueText(docBA, "BA_STB_TYPE");
                LZ_BAAccountStatus = XMLAO.getNodeValueText(docBA, "BA_ACCOUNT_STATUS");
                LZ_BANationalPromoFlag = ConfigurationReader.configList.get("NATIONAL_PROMO_FLAG");
                LZ_BAState = XMLAO.getNodeValueText(docBA, "BA_STATE");
                LZ_BAPincode = XMLAO.getNodeValueText(docBA, "BA_PIN_CODE");
                LZ_BASPMCampaignFlag = XMLAO.getNodeValueText(docBA, "BA_SPM_CAMPAIGN_FLAG");
                LZ_BASPMPackName = XMLAO.getNodeValueText(docBA, "BA_SPMPACKNAME");
                LZ_BASubscriptionType = XMLAO.getNodeValueText(docBA, "BA_SUBSCRIPTION_TYPE");
                LZ_BAAccountSubStatus = XMLAO.getNodeValueText(docBA, "BA_ACCOUNT_SUB_STATUS");

                LZ_NUANCE_URL = ConfigurationReader.configList.get("NUANCE_URL");
            }
        } catch (Exception ex) {
            Logger.error("", " Exception in  RetrieveProvisionalPromoDetails Page : " + ex.getMessage(), false);
        } 

        JSONObject result = new JSONObject();
        result.put("BACallerType", LZ_BACallerType);
        result.put("BAPremiumFlag", LZ_BAPremiumFlag);
        result.put("BASTBType", LZ_BASTBType);
        result.put("BAAccountStatus", LZ_BAAccountStatus);
        result.put("BANationalPromoFlag", LZ_BANationalPromoFlag);
        result.put("BAState", LZ_BAState);
        result.put("BAPincode", LZ_BAPincode);
        result.put("BASPMCampaignFlag", LZ_BASPMCampaignFlag);
        result.put("BASPMPackName", LZ_BASPMPackName);
        result.put("BASubscriptionType", LZ_BASubscriptionType);
        result.put("BAAccountSubStatus", LZ_BAAccountSubStatus);
        result.put("NUANCE_URL", LZ_NUANCE_URL);
        result.put("CallFlowDetailXML", LZ_CallFlowDetailXML);

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