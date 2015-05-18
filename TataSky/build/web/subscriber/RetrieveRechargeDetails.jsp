<%@page language="java" contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean LZ_SimulatorMode = false; // Simulator Mode by default is set to true.
        String GZ_CallDetailID = ""; // This is used to store the call detail ID.
        String LZ_CallFlowDetailXML = ""; // This is used to store the call flow detail XML.
        String LZ_CallType = ""; // This is used to store Inbound/Agent.

        String LZ_BACallerType = ""; // Caller Type is either Partner, Subscriber RMN, Prospect, Non RMN
        String LZ_SelectedLanguage = ""; // This is used to store the selected language for this particular call.
        String LZ_BASubscriberID = ""; // Subscriber ID
        String LZ_BASubscriberIDCount = ""; // Number of subscribers for a particular RMN
        String LZ_BAPremiumFlag = ""; // Subscriber category (Mass, Premium etc.)
        String LZ_BAAccountBalance = ""; // Account balance for a particular subsccriber ID
        String LZ_BAAccountStatus = ""; // Account status (Active/De-Active)
        String LZ_BAAccountSubStatus = ""; // Subscription sub status (Partially done etc.)
        String LZ_BARMN = ""; // Registered Mobile Number
        String LZ_BARMNFlag = ""; // Flag to denote the caller calls from RMN or not
        String LZ_BASubscriptionType = ""; // Monthly/LDP etc.
        String LZ_BASuggestedRecharge = ""; // Suggested recharge value
        String LZ_PreviousMenuFlag = "";
        String LZ_MainMenuFlag = "";
        String LZ_AppID = "";



        String LZ_AppLanguage = "en-IN"; // This is used to store the language folder.

        try {
//            LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
            LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML", "");

            if (LZ_SimulatorMode) {
                GZ_CallDetailID = "5555";
                LZ_CallType = "Inbound";
                LZ_BACallerType = "RMN";
                LZ_SelectedLanguage = "English";
                LZ_BASubscriberID = "3000727770";
                LZ_BASubscriberIDCount = "2";
                LZ_BAPremiumFlag = "Y";
                LZ_BAAccountBalance = "1400.50";
                LZ_BAAccountStatus = "Active";
                LZ_BAAccountSubStatus = "Partially Dunned";
                LZ_BARMN = "9036008484";
                LZ_BARMNFlag = "Y";
                LZ_BASubscriptionType = "Monthly";
                LZ_BASuggestedRecharge = "500.30";
                LZ_PreviousMenuFlag = "N";
                LZ_MainMenuFlag = "N";
            } else {
                Document docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);
                LZ_AppLanguage = XMLAO.getNodeValueText(docBA, "BA_APP_LANGUAGE");
                // String LZ_CallTypeID = XMLAO.getNodeValueText(docBA, "FLDCALLTYPEID");
                LZ_AppID = XMLAO.getNodeValueText(docBA, "FLDAPPID");
                LZ_CallType = state.optString("LZ_CallType", "");

                if (LZ_CallType.equals("")) {
                    if (LZ_AppID.equals("1")) {
                        LZ_CallType = "Inbound";
                    } else if (LZ_AppID.equals("2")) {
                        LZ_CallType = "Agent";
                    } else if (LZ_AppID.equals("3")) {
                        LZ_CallType = "Nuance";
                    } else if (LZ_AppID.equals("4")) {
                        LZ_CallType = "DirectSales";
                    }
                }

                GZ_CallDetailID = XMLAO.getNodeValueText(docBA, "FLDCALLDETAILID");
                Logger.info(GZ_CallDetailID, " RetrieveRechargeDetails Input ", false);
                LZ_BACallerType = XMLAO.getNodeValueText(docBA, "BA_CALLER_TYPE");
                LZ_SelectedLanguage = XMLAO.getNodeValueText(docBA, "BA_PRIMARY_LANGUAGE");
                LZ_BASubscriberID = XMLAO.getNodeValueText(docBA, "BA_SUBSCRIBER_ID");
                LZ_BASubscriberIDCount = XMLAO.getNodeValueText(docBA, "BA_SUBSCRIBER_ID_COUNT");
                LZ_BAPremiumFlag = XMLAO.getNodeValueText(docBA, "BA_PREMIUM_FLAG");
                LZ_BAAccountBalance = XMLAO.getNodeValueText(docBA, "BA_ACCOUNT_BALANCE");
                LZ_BAAccountStatus = XMLAO.getNodeValueText(docBA, "BA_ACCOUNT_STATUS");
                LZ_BAAccountSubStatus = XMLAO.getNodeValueText(docBA, "BA_ACCOUNT_SUB_STATUS");
                LZ_BARMN = XMLAO.getNodeValueText(docBA, "BA_RMN");
                LZ_BARMNFlag = XMLAO.getNodeValueText(docBA, "BA_RMN_FLAG");
                LZ_BASubscriptionType = XMLAO.getNodeValueText(docBA, "BA_SUBSCRIPTION_TYPE");
                LZ_BASuggestedRecharge = XMLAO.getNodeValueText(docBA, "BA_SUGGESTED_RECHARGE");
                if (LZ_BASuggestedRecharge.startsWith("0.00")) {
                    LZ_BASuggestedRecharge = "";
                } else if (LZ_BASuggestedRecharge.startsWith("-")) {
                    LZ_BASuggestedRecharge = "";
                } else if (LZ_BASuggestedRecharge.equals("")) {
                    LZ_BASuggestedRecharge = "";
                }
                LZ_PreviousMenuFlag = "N";
                LZ_MainMenuFlag = "N";
            }
        } catch (Exception ex) {
            Logger.error(GZ_CallDetailID, " Exception in RetrieveRechargeDetails Page : " + ex.getMessage(), false);
        } finally {
            Logger.info(GZ_CallDetailID, " RetrieveRechargeDetails Output = LZ_CallType : " + LZ_CallType + " LZ_BACallerType : " + LZ_BACallerType
                    + " LZ_SelectedLanguage : " + LZ_SelectedLanguage + " LZ_BASubscriberID : " + LZ_BASubscriberID + " LZ_BASubscriberIDCount : " + LZ_BASubscriberIDCount + " LZ_BAPremiumFlag : " + LZ_BAPremiumFlag + " LZ_BAAccountBalance : " + LZ_BAAccountBalance
                    + " LZ_BAAccountStatus : " + LZ_BAAccountStatus + " LZ_BAAccountSubStatus : " + LZ_BAAccountSubStatus + " LZ_BARMN : " + LZ_BARMN + " LZ_BARMNFlag : " + LZ_BARMNFlag + " LZ_BASubscriptionType : " + LZ_BASubscriptionType
                    + " LZ_BASuggestedRecharge : " + LZ_BASuggestedRecharge + " LZ_PreviousMenuFlag : " + LZ_PreviousMenuFlag + " LZ_MainMenuFlag : " + LZ_MainMenuFlag + " LZ_AppLanguage : " + LZ_AppLanguage, false);
            LZ_CallFlowDetailXML = null;
        }

        JSONObject result = new JSONObject();
        result.put("CallDetailID", GZ_CallDetailID);
        result.put("CallType", LZ_CallType);
        result.put("BACallerType", LZ_BACallerType);
        result.put("SelectedLanguage", LZ_SelectedLanguage);
        result.put("BASubscriberID", LZ_BASubscriberID);
        result.put("BASubscriberIDCount", LZ_BASubscriberIDCount);
        result.put("BAPremiumFlag", LZ_BAPremiumFlag);
        result.put("BAAccountBalance", LZ_BAAccountBalance);
        result.put("BAAccountStatus", LZ_BAAccountStatus);
        result.put("BAAccountSubStatus", LZ_BAAccountSubStatus);
        result.put("BARMN", LZ_BARMN);
        result.put("BARMNFlag", LZ_BARMNFlag);
        result.put("BASubscriptionType", LZ_BASubscriptionType);
        result.put("BASuggestedRecharge", LZ_BASuggestedRecharge);
        result.put("PreviousMenuFlag", LZ_PreviousMenuFlag);
        result.put("MainMenuFlag", LZ_MainMenuFlag);
        result.put("AppLanguage", LZ_AppLanguage);
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