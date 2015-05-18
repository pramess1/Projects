<%@page language="java" contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.tsg.database.ivr.dataaccess.UpdateCallDetailDAO"%>
<%@page import="com.tsg.database.ivr.dataaccess.InsertCallFlowDetailDAO"%>
<%@page import="com.tsg.util.*"%>
<%@page import="com.tsg.common.*"%>
<%@page import="com.tsg.database.ivr.dataaccess.GetCallFlowValueDAO"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean LZ_SimulatorMode = false; // Simulator Mode by default is set to true.
        String LZ_CallFlowDetailXML = ""; // This is used to store the call flow detail XML.
        String LZ_IVRLanguage = ""; // Caller selected IVR language
        String LZ_SubscriberID = ""; // Subscriber ID

        String LZ_DynamicCallFlowXML = ""; // This stores the dynamic call flow XML sent by parent call flow.
        String LZ_DBCallDetailID = ""; // This is used to store the call detail ID.
        String LZ_LastTraversedCFDID = "";
        String LZ_DisconnectedBy = "";

        int LZ_tempCount = 0;
        String LZ_tempCFID = "";
        String LZ_PartnerSubType = "";
        String LZ_ProductType = "";
        String LZ_ActualCustomerClass = "";
        String LZ_FirstActivationDate = "";
        String LZ_SegmentSubType = "";
        String LZ_IsSensitive = "";

        try {
//            LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
//            LZ_DBCallDetailID = state.getString("LZ_DBCallDetailID");
            LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML", "");

            LZ_DBCallDetailID = state.optString("LZ_DBCallDetailID", "");

            LZ_DisconnectedBy = state.optString("LZ_DisconnectedBy", "");

            if (LZ_SimulatorMode) {
            } else {
                Document docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);

                LZ_IVRLanguage = XMLAO.getNodeValueText(docBA, "BA_SELECTED_LANGUAGE");

                if (LZ_IVRLanguage.isEmpty()) {
                    String LZ_PrimaryLanguage = XMLAO.getNodeValueText(docBA, "BA_PRIMARY_LANGUAGE");

                    if (LZ_PrimaryLanguage.isEmpty()) {
                        String LZ_SecondaryLanguage = XMLAO.getNodeValueText(docBA, "BA_SECONDARY_LANGUAGE");

                        if (!LZ_SecondaryLanguage.isEmpty()) {
                            LZ_IVRLanguage = LZ_SecondaryLanguage;
                        }
                        LZ_SecondaryLanguage = null;
                    } else {
                        LZ_IVRLanguage = LZ_PrimaryLanguage;
                    }
                    LZ_PrimaryLanguage = null;
                }

                LZ_SubscriberID = XMLAO.getNodeValueText(docBA, "BA_SUBSCRIBER_ID");
                LZ_FirstActivationDate = XMLAO.getNodeValueText(docBA, "BA_FIRST_ACTIVATION_DATE");
                LZ_PartnerSubType = XMLAO.getNodeValueText(docBA, "BA_PARTNER_SUB_TYPE");
                LZ_ProductType = XMLAO.getNodeValueText(docBA, "BA_STB_TYPE");
                LZ_ActualCustomerClass = XMLAO.getNodeValueText(docBA, "BA_ACT_CUST_CLASS");
                LZ_SegmentSubType = XMLAO.getNodeValueText(docBA, "BA_SEGMENT_SUBTYPE");
                LZ_IsSensitive = XMLAO.getNodeValueText(docBA, "BA_ISSENSITIVE");

                Logger.info(LZ_DBCallDetailID, "Set Disconnect Details : Partner Sub Type : " + LZ_PartnerSubType + " Product Type : " + LZ_ProductType
                        + "First Activation Date : " + LZ_FirstActivationDate + " Actual Customer Class : " + LZ_ActualCustomerClass
                        + " Segment Sub Type :" + LZ_SegmentSubType + " Is Sensitive : " + LZ_IsSensitive, false);

                String LZ_CallerType = XMLAO.getNodeValueText(docBA, "BA_CALLER_TYPE");
                String LZ_SubscriberIDCount = XMLAO.getNodeValueText(docBA, "BA_SUBSCRIBER_ID_COUNT");
                String LZ_AccountStatus = "";
                String LZ_AccountSubStatus = "";
                String LZ_NonRMNIdentifier = "";
                String LZ_SubIDValidated = "";

                if (LZ_CallerType.equals("RMN")) {
                    LZ_AccountStatus = XMLAO.getNodeValueText(docBA, "BA_ACCOUNT_STATUS");
                    LZ_AccountSubStatus = XMLAO.getNodeValueText(docBA, "BA_ACCOUNT_SUB_STATUS");
                    LZ_NonRMNIdentifier = XMLAO.getNodeValueText(docBA, "FLDNONRMNIDENTIFIER");
                    LZ_SubIDValidated = XMLAO.getNodeValueText(docBA, "FLDSUBIDVALIDATED");
                }

                LZ_tempCount = XMLAO.getNodeCount(docBA, "TBLCALLFLOWDETAIL");
                LZ_tempCount--;
                LZ_tempCFID = XMLAO.getNodeValueText(docBA, "FLDCALLFLOWID", LZ_tempCount);

                if (LZ_tempCFID.equals("99")) {
                    LZ_tempCount--;
                }

                LZ_tempCFID = XMLAO.getNodeValueText(docBA, "FLDCALLFLOWID", LZ_tempCount);

                if (LZ_tempCFID.equals("98")) {
                    LZ_tempCount--;
                }

                LZ_tempCFID = XMLAO.getNodeValueText(docBA, "FLDCALLFLOWID", LZ_tempCount);

                if (LZ_tempCFID.equals("900") || LZ_tempCFID.equals("901") || LZ_tempCFID.equals("902") || LZ_tempCFID.equals("903") || LZ_tempCFID.equals("904") || LZ_tempCFID.equals("905") || LZ_tempCFID.equals("906") || LZ_tempCFID.equals("907") || LZ_tempCFID.equals("908") || LZ_tempCFID.equals("909") || LZ_tempCFID.equals("910")) {
                    LZ_tempCount--;
                }


                if (LZ_tempCFID.equals("911") || LZ_tempCFID.equals("912") || LZ_tempCFID.equals("913") || LZ_tempCFID.equals("914") || LZ_tempCFID.equals("915") || LZ_tempCFID.equals("916") || LZ_tempCFID.equals("917") || LZ_tempCFID.equals("918") || LZ_tempCFID.equals("919") || LZ_tempCFID.equals("920")) {
                    LZ_tempCount--;
                }

                if (LZ_tempCFID.equals("921") || LZ_tempCFID.equals("922") || LZ_tempCFID.equals("923") || LZ_tempCFID.equals("924") || LZ_tempCFID.equals("925") || LZ_tempCFID.equals("926") || LZ_tempCFID.equals("927") || LZ_tempCFID.equals("928") || LZ_tempCFID.equals("929") || LZ_tempCFID.equals("930")) {
                    LZ_tempCount--;
                }

                if (LZ_tempCFID.equals("931") || LZ_tempCFID.equals("932") || LZ_tempCFID.equals("933") || LZ_tempCFID.equals("934") || LZ_tempCFID.equals("231")) {
                    LZ_tempCount--;
                }

                if (LZ_tempCFID.equals("950") || LZ_tempCFID.equals("951") || LZ_tempCFID.equals("952") || LZ_tempCFID.equals("953") || LZ_tempCFID.equals("954") || LZ_tempCFID.equals("955") || LZ_tempCFID.equals("956") || LZ_tempCFID.equals("957") || LZ_tempCFID.equals("958") || LZ_tempCFID.equals("959")) {
                    LZ_tempCount--;
                }

                if (LZ_tempCFID.equals("999") || LZ_tempCFID.equals("998") || LZ_tempCFID.equals("997") || LZ_tempCFID.equals("996") || LZ_tempCFID.equals("995")) {
                    LZ_tempCount--;
                }

                // for nuance
                if (LZ_tempCFID.equals("10000") || LZ_tempCFID.equals("10001") || LZ_tempCFID.equals("10002") || LZ_tempCFID.equals("10003") || LZ_tempCFID.equals("10004")) {
                    LZ_tempCount--;
                }

                LZ_LastTraversedCFDID = XMLAO.getNodeValueText(docBA, "FLDCALLFLOWID", LZ_tempCount);

                String LZ_PremiumFlag1 = XMLAO.getNodeValueText(docBA, "BA_PREMIUM_FLAG1");
                String LZ_CLI = XMLAO.getNodeValueText(docBA, "FLDCLI");
                String LZ_FirstPromptPlayDateTime = XMLAO.getNodeValueText(docBA, "FLDCALLFLOWDATETIME", 0);



                String updateTCDResult = new UpdateCallDetailDAO().updateCallDetail(LZ_DBCallDetailID,
                        Util.getCurrentDateTime(), LZ_IVRLanguage, LZ_SubscriberID, "", LZ_CallerType,
                        LZ_PremiumFlag1, LZ_DisconnectedBy, "", LZ_LastTraversedCFDID, "", "", "", LZ_AccountStatus, LZ_AccountSubStatus,
                        LZ_SubscriberIDCount, LZ_NonRMNIdentifier, LZ_SubIDValidated, LZ_CLI, LZ_FirstPromptPlayDateTime, "",
                        LZ_PartnerSubType, LZ_ProductType, LZ_FirstActivationDate, LZ_SegmentSubType, LZ_ActualCustomerClass,
                        LZ_IsSensitive);

                new WriteXML().writeTextFile(LZ_CallFlowDetailXML, LZ_DBCallDetailID);

                Logger.info(LZ_DBCallDetailID, " SetDisconnectDetails CallFlowDetailXML Output : " + LZ_CallFlowDetailXML, false);

                LZ_CallerType = LZ_SubscriberIDCount = LZ_AccountStatus = LZ_AccountSubStatus = LZ_NonRMNIdentifier =
                        LZ_SubIDValidated = LZ_PremiumFlag1 = LZ_CLI = LZ_FirstPromptPlayDateTime = null;
            }
        } catch (Exception ex) {
            Logger.error(LZ_DBCallDetailID, " Exception in SetDisconnectDetails Page : " + ex.getMessage(), false);
        } finally {
            LZ_CallFlowDetailXML = LZ_IVRLanguage = LZ_SubscriberID = LZ_DBCallDetailID = LZ_LastTraversedCFDID = LZ_tempCFID =
                    LZ_PartnerSubType = LZ_ProductType = LZ_FirstActivationDate = LZ_ActualCustomerClass = LZ_SegmentSubType =
                    LZ_IsSensitive = null;
        }

        JSONObject result = new JSONObject();
        result.put("DynamicCallFlowXML", LZ_DynamicCallFlowXML);

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