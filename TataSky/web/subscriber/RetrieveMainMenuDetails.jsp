<%@page language="java" contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.tsg.common.*"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean LZ_SimulatorMode = false; // Simulator Mode by default is set to true.
        String LZ_CallFlowDetailXML = ""; // This is used to store the call flow detail XML.

        String LZ_BACallerType = ""; // Type of the caller (Subscriber/Partner/Prospect etc.)
        String LZ_BAPremiumFlag = ""; // Premium Flag
        String LZ_BASTBType = ""; // Type of the STB (HD, SD etc.)
        String LZ_BASubscriptionType = ""; // Monthly/LDP etc.
        String LZ_BAAccountStatus = ""; // Account status (Active/De-Active)
        String LZ_BAAccountSubStatus = ""; // Subscription sub status (Partially done etc.)
        String LZ_BARepeatMainMenuFlag = "N"; // Repeat Main Menu flag for Package and Recharge (Y-P,R;N-R,P)
        String LZ_BARepeatPackCount = ""; // Repeat Pack count for main menu
        String LZ_BARepeatRechargeCount = ""; // Repeat Recharge count for main menu
        String LZ_NUANCE_URL = ""; // This is used to store the NUANCE URL.
        String LZ_DBCallDetailID = "";
        String LZ_TempCFID = "";


        try {
//            LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
            LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML", "");
            LZ_DBCallDetailID = state.optString("LZ_DBCallDetailID", "");
            Logger.info(LZ_DBCallDetailID, " RetrieveMainMenuDetails Input = CallFlowDetailXML : " + LZ_CallFlowDetailXML, false);
            if (LZ_SimulatorMode) {
                //Testing...
            } else {
                Document docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);

                LZ_BACallerType = XMLAO.getNodeValueText(docBA, "BA_CALLER_TYPE");
                LZ_BAPremiumFlag = XMLAO.getNodeValueText(docBA, "BA_PREMIUM_FLAG");
                LZ_BASTBType = XMLAO.getNodeValueText(docBA, "BA_STB_TYPE");
                LZ_BASubscriptionType = XMLAO.getNodeValueText(docBA, "BA_SUBSCRIPTION_TYPE");
                LZ_BAAccountStatus = XMLAO.getNodeValueText(docBA, "BA_ACCOUNT_STATUS");
                LZ_BAAccountSubStatus = XMLAO.getNodeValueText(docBA, "BA_ACCOUNT_SUB_STATUS");
                LZ_BARepeatPackCount = XMLAO.getNodeValueText(docBA, "BA_REPEAT_PACK_COUNT");
                LZ_BARepeatRechargeCount = XMLAO.getNodeValueText(docBA, "BA_REPEAT_RECHARGE_COUNT");



                // System.out.println("LZ_BACallerType " + LZ_BACallerType);

                if (!LZ_BARepeatPackCount.isEmpty()) {
                    int LZ_tempPackCount = Integer.parseInt(LZ_BARepeatPackCount);
                    int LZ_tempRechargeCount = Integer.parseInt(LZ_BARepeatRechargeCount);

                    if (LZ_tempRechargeCount >= 3) {
                        LZ_BARepeatMainMenuFlag = "R";
                    } else if (LZ_tempPackCount >= 3) {
                        LZ_BARepeatMainMenuFlag = "P";
                    } else {
                        LZ_BARepeatMainMenuFlag = "N";
                    }

                }
                LZ_NUANCE_URL = ConfigurationReader.configList.get("NUANCE_URL");
            }
        } catch (Exception ex) {
            Logger.error(LZ_DBCallDetailID, " Exception in RetrieveMainMenuDetails Page : " + ex.getMessage(), false);
        } finally {
            Logger.info(LZ_DBCallDetailID, " RetrieveMainMenuDetails Output = LZ_BACallerType : " + LZ_BACallerType + " LZ_BAPremiumFlag : " + LZ_BAPremiumFlag
                    + " LZ_BASTBType : " + LZ_BASTBType + " LZ_BASubscriptionType : " + LZ_BASubscriptionType + " LZ_BAAccountStatus : " + LZ_BAAccountStatus
                    + " LZ_BAAccountSubStatus : " + LZ_BAAccountSubStatus + " LZ_BARepeatMainMenuFlag : " + LZ_BARepeatMainMenuFlag + " LZ_NUANCE_URL : " + LZ_NUANCE_URL, false);
            LZ_DBCallDetailID = LZ_BARepeatPackCount = LZ_BARepeatRechargeCount = LZ_CallFlowDetailXML = null;
        }

        JSONObject result = new JSONObject();
        result.put("BACallerType", LZ_BACallerType);
        result.put("BAPremiumFlag", LZ_BAPremiumFlag);
        result.put("BASTBType", LZ_BASTBType);
        result.put("BASubscriptionType", LZ_BASubscriptionType);
        result.put("BAAccountStatus", LZ_BAAccountStatus);
        result.put("BAAccountSubStatus", LZ_BAAccountSubStatus);
        result.put("BARepeatMainMenuFlag", LZ_BARepeatMainMenuFlag);
        result.put("NUANCE_URL", LZ_NUANCE_URL);

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