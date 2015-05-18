<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>
<%@ page import="java.util.HashMap" %>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean LZ_SimulatorMode = false; // Simulator Mode by default is set to true.
        String LZ_CallFlowDetailXML = ""; // This is used to store the call flow detail XML.

        String LZ_CLI = ""; // This stores the CLI of the call.
        String LZ_DNIS = ""; // This stores the DNIS of the call.
        String LZ_Language = ""; // This stores the language of the call.
        String LZ_SubscriberCategory = ""; // This stores the subscriber category (Premium/NonPremium) of the caller.
        String LZ_AccountStatus = ""; // This stores the account status of the caller.
        String LZ_ProductType = ""; // This stores the product type of the caller.
        String LZ_Subscription = ""; // This stores the subscription of the caller.
        String LZ_State = ""; // This stores the state of the caller.
        String LZ_Pincode = ""; // This stores the pincode of the caller.
        String LZ_CallerType = ""; // This stores the caller type (RMN/Prospect/Partner/NonRMN).
        String LZ_CallID = ""; // This stores the call ID of the call.
        String LZ_MultipleSubscriberID = ""; // This stores whether the caller has multiple subscriber IDs or not (Y/N).
        String LZ_SubscriberID = ""; // Subscriber Id
        String LZ_CallerIntent = ""; // This is either MAIN/SHOWCASE/PROMO.
        String LZ_PSCode = ""; // This is package or showcase code.
        String LZ_DBCallDetailID = ""; // This is used to store the call detail ID.

        Map<String, String> languageMap = new HashMap<String, String>();
        languageMap.put("english", "en-IN");
        languageMap.put("hindi", "hi-IN");

        try {
//            LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
            LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML", "");
            LZ_DBCallDetailID = state.optString("LZ_DBCallDetailID", "");
            Logger.info(LZ_DBCallDetailID, " RetrievePSDetails Input ", false);
            if (LZ_SimulatorMode) {
            } else {
                Document docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);
                LZ_CLI = XMLAO.getNodeValueText(docBA, "FLDCLI");
                LZ_DNIS = XMLAO.getNodeValueText(docBA, "FLDDNIS");
                LZ_Language = XMLAO.getNodeValueText(docBA, "BA_SELECTED_LANGUAGE");
                if (LZ_Language.isEmpty()) {
                    String LZ_PrimaryLanguage = XMLAO.getNodeValueText(docBA, "BA_PRIMARY_LANGUAGE");
                    if (LZ_PrimaryLanguage.isEmpty()) {
                        String LZ_SecondaryLanguage = XMLAO.getNodeValueText(docBA, "BA_SECONDARY_LANGUAGE");
                        if (!LZ_SecondaryLanguage.isEmpty()) {
                            LZ_Language = LZ_SecondaryLanguage;
                        }
                        LZ_SecondaryLanguage = null;
                    } else {
                        LZ_Language = LZ_PrimaryLanguage;
                    }
                    LZ_PrimaryLanguage = null;
                }
                LZ_Language = languageMap.get(LZ_Language.toLowerCase());
                LZ_SubscriberCategory = XMLAO.getNodeValueText(docBA, "LZ_SubscriberCategory");
                if (LZ_SubscriberCategory.equals("Y")) {
                    LZ_SubscriberCategory = "platinum";
                } else {
                    LZ_SubscriberCategory = "mass";
                }
                LZ_AccountStatus = XMLAO.getNodeValueText(docBA, "BA_ACCOUNT_STATUS");
                LZ_ProductType = XMLAO.getNodeValueText(docBA, "BA_STB_TYPE");
                LZ_Subscription = XMLAO.getNodeValueText(docBA, "BA_SUBSCRIPTION_TYPE");
                LZ_State = XMLAO.getNodeValueText(docBA, "BA_STATE");
                LZ_Pincode = XMLAO.getNodeValueText(docBA, "BA_PIN_CODE");
                LZ_CallerType = XMLAO.getNodeValueText(docBA, "BA_CALLER_TYPE");
                if (LZ_CallerType.equals("RMN")) {
                    LZ_CallerType = "subscriber";
                } else if (LZ_CallerType.equals("Partner")) {
                    LZ_CallerType = "partner";
                }
                LZ_CallID = XMLAO.getNodeValueText(docBA, "FLDCALLDETAILID");
                LZ_MultipleSubscriberID = XMLAO.getNodeValueText(docBA, "BA_SUBSCRIBER_ID_COUNT");
                LZ_SubscriberID = XMLAO.getNodeValueText(docBA, "BA_SUBSCRIBER_ID");
                if (LZ_MultipleSubscriberID.equals("1")) {
                    LZ_MultipleSubscriberID = "N";
                } else if (!LZ_MultipleSubscriberID.isEmpty()) {
                    LZ_MultipleSubscriberID = "Y";
                }
                int LZ_tempCount = XMLAO.getNodeCount(docBA, "TBLCALLFLOWDETAIL");
                LZ_tempCount--;
                int LZ_CFID = Integer.parseInt(XMLAO.getNodeValueText(docBA, "FLDCALLFLOWID", LZ_tempCount));
                if (LZ_CFID == 24) {
                    LZ_CallerIntent = "PROMO";
                    String LZ_tempCallTypeID = XMLAO.getNodeValueText(docBA, "FLDCALLTYPEID");
                    LZ_tempCallTypeID = LZ_tempCallTypeID.replaceFirst("3_", "");
                    LZ_tempCallTypeID = LZ_tempCallTypeID.replace("_", " ");
                    LZ_PSCode = LZ_tempCallTypeID;
                } else {
                    int LZ_LastMenu = Integer.parseInt(XMLAO.getNodeValueText(docBA, "CTILASTMENU"));
                    if (LZ_LastMenu == 11024) {
                        LZ_CallerIntent = "SHOWCASE";
                    } else {
                        LZ_CallerIntent = "MAIN";
                    }
                }
                int LZ_StartIndex = LZ_CallFlowDetailXML.indexOf("<FLDCALLTYPEID>");
                int LZ_EndIndex = LZ_CallFlowDetailXML.indexOf("</FLDCALLTYPEID>", LZ_StartIndex) + 16;
                String LZ_temp = LZ_CallFlowDetailXML.substring(LZ_StartIndex, LZ_EndIndex);
                LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace(LZ_temp, "<FLDCALLTYPEID>3</FLDCALLTYPEID>");
            }
        } catch (Exception ex) {
            Logger.error(LZ_DBCallDetailID, " Exception in RetrievePSDetails Page : " + ex.getMessage(), false);
        } finally {
            Logger.info(LZ_DBCallDetailID, " RetrievePSDetails Output =  LZ_CLI : " + LZ_CLI + " LZ_DNIS : " + LZ_DNIS
                    + " LZ_Language : " + LZ_Language + " LZ_SubscriberCategory : " + LZ_SubscriberCategory + " LZ_AccountStatus : " + LZ_AccountStatus
                    + " LZ_ProductType : " + LZ_ProductType + " LZ_Subscription : " + LZ_Subscription + " LZ_PSCode : " + LZ_PSCode, false);
            LZ_CallFlowDetailXML = LZ_DBCallDetailID = null;
        }

        JSONObject result = new JSONObject();
        result.put("CLI", LZ_CLI);
        result.put("DNIS", LZ_DNIS);
        result.put("Language", LZ_Language);
        result.put("SubscriberType", LZ_SubscriberCategory);
        result.put("AccountStatus", LZ_AccountStatus);
        result.put("ProductType", LZ_ProductType);
        result.put("Subscription", LZ_Subscription);
        result.put("State", LZ_State);
        result.put("Pincode", LZ_Pincode);
        result.put("CallerType", LZ_CallerType);
        result.put("CallID", LZ_CallID);
        result.put("MultipleSubscriberID", LZ_MultipleSubscriberID);
        result.put("SubscriberId", LZ_SubscriberID);
        result.put("CallerIntent", LZ_CallerIntent);
        result.put("PSCode", LZ_PSCode);

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