<%@page language="java" contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.tsg.database.DBAccess"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean LZ_SimulatorMode = false; // Simulator Mode by default is set to true.
        String LZ_CallFlowDetailXML = ""; // This is used to store the call flow detail XML.

        String LZ_BAAccountStatus = ""; // Account status (Active/De-Active)
        String LZ_BASubscriptionType = ""; // Monthly/FDP/LDP etc.
        String LZ_BAPremiumFlag = ""; // Premium flag whether the subscriber is premium or not
        String LZ_BARechargeDueDate = ""; // Recharge due date
        String LZ_BARenewDate = ""; // FDP/LDP renew date
        String LZ_NumberOfDaysLeft = ""; // This is used to store the number of days left.
        String LZ_BAAccountSubStatus = ""; // Subscription sub status (Partially done etc.)
        String LZ_DBCallDetailID = ""; // This is used to store the call detail ID.
        String LZ_BASubscriberID = ""; // Subscriber ID

        try {
//            LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
//            LZ_DBCallDetailID = state.getString("LZ_DBCallDetailID");
            LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");
            LZ_DBCallDetailID = state.optString("LZ_DBCallDetailID","");    
            Logger.info(LZ_DBCallDetailID, " Retrieve Flash Message Details Input = CallFlowDetailXML : " + LZ_CallFlowDetailXML, false);                                                                  
            if (LZ_SimulatorMode) {
            } else {
                Document docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);

                LZ_BAAccountStatus = XMLAO.getNodeValueText(docBA, "BA_ACCOUNT_STATUS");
                LZ_BASubscriptionType = XMLAO.getNodeValueText(docBA, "BA_SUBSCRIPTION_TYPE");
                LZ_BAPremiumFlag = XMLAO.getNodeValueText(docBA, "BA_PREMIUM_FLAG");
                LZ_BAAccountSubStatus = XMLAO.getNodeValueText(docBA, "BA_ACCOUNT_SUB_STATUS");

                LZ_BASubscriberID = XMLAO.getNodeValueText(docBA, "BA_SUBSCRIBER_ID");
                String LZ_BA_XML = new DBAccess().getAccountDetail(LZ_BASubscriberID, LZ_DBCallDetailID);
                //System.out.println("LZ_BA_XML: " + LZ_BA_XML);
                XMLAO.deleteNode(docBA, "BA_ACCOUNT_BALANCE");
                XMLAO.deleteNode(docBA, "BA_RECHARGE_DUE_DATE");
                XMLAO.deleteNode(docBA, "BA_FDP_RENEW_DATE");
                XMLAO.deleteNode(docBA, "BA_LAST_RECHARGE_AMT");
                XMLAO.deleteNode(docBA, "BA_LAST_RECHARGE_DATETIME");
                XMLAO.deleteNode(docBA, "BA_SUGGESTED_RECHARGE");

                LZ_CallFlowDetailXML = XMLAO.getNodeOuterXML(docBA);
                LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("<BA_ROOT>", "<BA_ROOT>" + LZ_BA_XML);
                docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);

                if (!LZ_BASubscriptionType.isEmpty()) {
                    if (LZ_BASubscriptionType.equals("Monthly")) {
                        LZ_BARechargeDueDate = XMLAO.getNodeValueText(docBA, "BA_RECHARGE_DUE_DATE");
                    } else if (LZ_BASubscriptionType.equals("FDP")) {
                        LZ_BARenewDate = XMLAO.getNodeValueText(docBA, "BA_FDP_RENEW_DATE");
                        LZ_BARechargeDueDate = LZ_BARenewDate;
                    } else if (LZ_BASubscriptionType.equals("LDP")) {
                        LZ_BARenewDate = XMLAO.getNodeValueText(docBA, "BA_LDP_RENEW_DATE");
                        LZ_BARechargeDueDate = LZ_BARenewDate;
                    }
                }

                if (!LZ_BARechargeDueDate.isEmpty()) {
                    DateFormat LZ_DateFormat = new SimpleDateFormat("yyyy-MM-dd");
                    Date LZ_tempDueDate = LZ_DateFormat.parse(LZ_BARechargeDueDate);
                    Date LZ_tempCurrentDate = LZ_DateFormat.parse(LZ_DateFormat.format(new Date()));

                    LZ_NumberOfDaysLeft = String.valueOf((LZ_tempDueDate.getTime() - LZ_tempCurrentDate.getTime()) / 86400000);
                }

                LZ_BA_XML = null;
            }
        } catch (Exception ex) {
            Logger.error(LZ_DBCallDetailID, " Exception in RetrieveFlashMessageDetails Page : " + ex.getMessage(), false);
        } finally {
            Logger.info(LZ_DBCallDetailID, " Retrieve Flash Message Details Output = LZ_BAAccountStatus : " + LZ_BAAccountStatus + " LZ_BASubscriptionType : " + LZ_BASubscriptionType +
                    " LZ_BAPremiumFlag : " + LZ_BAPremiumFlag + " LZ_NumberOfDaysLeft : " + LZ_NumberOfDaysLeft + " LZ_BAAccountSubStatus : " + LZ_BAAccountSubStatus, false);                                                                                            
            LZ_BARechargeDueDate = LZ_BARenewDate = LZ_DBCallDetailID = LZ_BASubscriberID = null;
        }

        JSONObject result = new JSONObject();
        result.put("BAAccountStatus", LZ_BAAccountStatus);
        result.put("BASubscriptionType", LZ_BASubscriptionType);
        result.put("BAPremiumFlag", LZ_BAPremiumFlag);
        result.put("NumberOfDaysLeft", LZ_NumberOfDaysLeft);
        result.put("BAAccountSubStatus", LZ_BAAccountSubStatus);
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

<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<%@include file="../backend.jspf" %>