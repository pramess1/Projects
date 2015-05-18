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

        String ctiCallDetailID = ""; // CTI field for sending call detail ID
        String ctiIsRMNctiIsDND = ""; // CTI field for sending RMN, DND flags in <Y,N> format
        String ctiIVRLanguage = ""; // CTI field for sending IVR language
        String ctiSubscriberCount = ""; // CTI field for sending subscriber/prospect count
        String ctiRepeatCallCount = ""; // CTI field for sending repeat call count
        String ctiUCID = ""; // CTI field for sending Call UUID
        String ctiLastMenu = ""; // CTI field for sending last menu
        String ctiLanguageAlert = ""; // CTI field for sending language alert
        String ctiTransactionAlert = ""; // CTI field for sending transaction alert
        String ctiCampaignCode1 = ""; // CTI field for sending campaign code 1
        String ctiCampaignCode2 = ""; // CTI field for sending campaign code 2
        String ctiSubscriberID = ""; // CTI field for sending subscriber ID
        String ctiRMN = ""; // CTI field for sending RMN
        String ctiSRWO = ""; // CTI field for sending Seibel Team requested data
        String ctiDesk = ""; // CTI field for sending agent desk
        String ctiDC = ""; // CTI field for sending data center
        String ctiLangCode = ""; // CTI field for sending language code (first 3 letters in upper case)
        String ctiCustCategory = ""; // CTI field for sending customer category (MAS/PRE)
        String ctiPartnerCode = ""; // CTI field for sending partner code
        String test_transactionalert = ""; //test for trans alrt by raja.
        String LZ_tempCFID = "";
        String LZ_TransferNumber = ""; // This stores the transfer number.

        String LZ_DBCallDetailID = ""; // This is used to store the call detail ID.

        String LZ_PrimaryLanguage = "";
        String LZ_SecondaryLanguage = "";
        String LZ_SelectedLanguage = "";
        String ctiLangCodeSec = "";
        String LZ_NonBuisinessHour = "";
        String cti_ExitCode = "";
        String cti_DCVAG = "";
        String cti_DCVQ = "";
        String LZ_SubscriberIDCount = "";
        String LZ_PartnerType = "";
        String LZ_LastTraversedCFDID = "";
        String LZ_CFIDBeforeLastTraversed = "";
        String LZ_CallerType = "";
        String LZ_AccountStatus = "";
        String LZ_AccountSubStatus = "";
        String LZ_NonRMNIdentifier = "";
        String LZ_SubIDValidated = "";
        String LZ_CLI = "";
        String LZ_FirstPromptPlayDateTime = "";
        String LZ_CallTypeID = "";
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

            ctiCallDetailID = LZ_DBCallDetailID;

            Logger.info(LZ_DBCallDetailID, " SetAgentTransferDetails Input ", false);


            if (LZ_SimulatorMode) {
            } else {
                Document docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);
                //       System.out.println("SetAgentTransferDetails.jsp::: docBA : " + LZ_CallFlowDetailXML);

                LZ_PrimaryLanguage = XMLAO.getNodeValueText(docBA, "BA_PRIMARY_LANGUAGE");
                LZ_SecondaryLanguage = XMLAO.getNodeValueText(docBA, "BA_SECONDARY_LANGUAGE");
                LZ_SelectedLanguage = XMLAO.getNodeValueText(docBA, "BA_SELECTED_LANGUAGE");
                cti_DCVAG = XMLAO.getNodeValueText(docBA, "CTIVAG");
                cti_DCVQ = XMLAO.getNodeValueText(docBA, "CTIVQ");
                LZ_CallTypeID = XMLAO.getNodeValueText(docBA, "FLDCALLTYPEID");
                LZ_PartnerSubType = XMLAO.getNodeValueText(docBA, "BA_PARTNER_SUB_TYPE");
                LZ_ProductType = XMLAO.getNodeValueText(docBA, "BA_STB_TYPE");
                LZ_FirstActivationDate = XMLAO.getNodeValueText(docBA, "BA_FIRST_ACTIVATION_DATE");
                LZ_SegmentSubType = XMLAO.getNodeValueText(docBA, "BA_SEGMENT_SUBTYPE");
                LZ_ActualCustomerClass = XMLAO.getNodeValueText(docBA, "BA_ACT_CUST_CLASS");
                LZ_IsSensitive = XMLAO.getNodeValueText(docBA, "BA_ISSENSITIVE");

                Logger.info(LZ_DBCallDetailID, "SetAgentTransferDetails : Partner Sub Type : " + LZ_PartnerSubType + " Product Type : " + LZ_ProductType
                        + " Actual Customer Class : " + LZ_ActualCustomerClass + " Segment SubType :" + LZ_SegmentSubType
                        + "Is Sensitive : " + LZ_IsSensitive, false);




                DateFormat LZ_TimeFormat = new SimpleDateFormat("HH:mm:ss");
                Date LZ_CurrentTime = new Date();
                LZ_CurrentTime = LZ_TimeFormat.parse(LZ_TimeFormat.format(LZ_CurrentTime));

                if (LZ_CurrentTime.after(LZ_TimeFormat.parse("20:00:00")) && LZ_CurrentTime.before(LZ_TimeFormat.parse("08:00:00"))) {
                    LZ_NonBuisinessHour = "N";
                } else {
                    LZ_NonBuisinessHour = "N";
                }

                if (LZ_SelectedLanguage.isEmpty()) {
                    if (LZ_PrimaryLanguage.isEmpty()) {
                        if (!LZ_SecondaryLanguage.isEmpty()) {
                            ctiIVRLanguage = LZ_SecondaryLanguage;
                        }
                    } else {
                        ctiIVRLanguage = LZ_PrimaryLanguage;
                    }

                } else {
                    ctiIVRLanguage = LZ_SelectedLanguage;
                }

                /*if(!(LZ_SelectedLanguage == LZ_PrimaryLanguage || LZ_SelectedLanguage == LZ_SecondaryLanguage))
                 {
                 ctiTransactionAlert == "Language Alert";
                 }*/


                ctiLangCodeSec = LZ_SecondaryLanguage;

                if (!ctiLangCodeSec.equals("") && ctiLangCodeSec.length() > 2) {
                    ctiLangCodeSec = ctiLangCodeSec.substring(0, 3).toUpperCase();
                }


                if (!ctiIVRLanguage.equals("") && ctiIVRLanguage.length() > 2) {
                    ctiLangCode = ctiIVRLanguage.substring(0, 3).toUpperCase();
                }

                /* ctiIVRLanguage = XMLAO.getNodeValueText(docBA, "BA_SELECTED_LANGUAGE");
               
                 if (ctiIVRLanguage.isEmpty()) {
                 String LZ_PrimaryLanguage = XMLAO.getNodeValueText(docBA, "BA_PRIMARY_LANGUAGE");

                 if (LZ_PrimaryLanguage.isEmpty()) {
                 String LZ_SecondaryLanguage = XMLAO.getNodeValueText(docBA, "BA_SECONDARY_LANGUAGE");

                 if (!LZ_SecondaryLanguage.isEmpty()) {
                 ctiIVRLanguage = LZ_SecondaryLanguage;
                 }
                 } else {
                 ctiIVRLanguage = LZ_PrimaryLanguage;
                 }
                 }*/



                ctiSubscriberID = XMLAO.getNodeValueText(docBA, "BA_SUBSCRIBER_ID");

                LZ_SubscriberIDCount = XMLAO.getNodeValueText(docBA, "BA_SUBSCRIBER_ID_COUNT");

                if (LZ_SubscriberIDCount.equals("1")) {
                    ctiSubscriberCount = "N";
                } else if (!LZ_SubscriberIDCount.isEmpty()) {
                    ctiSubscriberCount = "Y," + LZ_SubscriberIDCount;
                } else {
                    ctiSubscriberCount = "N";
                }

                ctiRepeatCallCount = XMLAO.getNodeValueText(docBA, "BA_PARTNER_REPEAT_COUNT");

                LZ_PartnerType = XMLAO.getNodeValueText(docBA, "BA_PARTNER_TYPE");

                if (LZ_PartnerType.equals("Partner FS")) {
                    ctiDesk = "FSD";

                } else {
                    ctiDesk = "PHD";
                }

                ctiUCID = XMLAO.getNodeValueText(docBA, "FLDUUID");

                int LZ_tempCount = XMLAO.getNodeCount(docBA, "TBLCALLFLOWDETAIL");
                LZ_tempCount = LZ_tempCount - 2;

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

                if (LZ_tempCFID.equals("931") || LZ_tempCFID.equals("932") || LZ_tempCFID.equals("933") || LZ_tempCFID.equals("934")) {
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

                ctiLastMenu = new GetCallFlowValueDAO().getCallFlowValue(LZ_LastTraversedCFDID, ctiCallDetailID);
                LZ_CFIDBeforeLastTraversed = XMLAO.getNodeValueText(docBA, "FLDCALLFLOWID", LZ_tempCount - 1);
                int LZ_tempTransactionAlertCount = XMLAO.getNodeCount(docBA, "CTITRANSACTIONALERT") - 1;
                ctiTransactionAlert = XMLAO.getNodeValueText(docBA, "CTITRANSACTIONALERT", LZ_tempTransactionAlertCount);
                ctiLanguageAlert = "";
                //ctiLanguageAlert = XMLAO.getNodeValueText(docBA, "CTILANGUAGEALERT");
                ctiDC = ConfigurationReader.configList.get("DATA_CENTER");
                ctiCustCategory = "PTR";
                LZ_CallerType = XMLAO.getNodeValueText(docBA, "BA_PARTNER_TYPE");
                LZ_AccountStatus = XMLAO.getNodeValueText(docBA, "BA_PARTNER_ACCOUNT_STATUS");
                LZ_AccountSubStatus = "";
                LZ_NonRMNIdentifier = "";
                LZ_SubIDValidated = "";
                ctiPartnerCode = XMLAO.getNodeValueText(docBA, "BA_PARTNER_ID");
                LZ_TransferNumber = ConfigurationReader.configList.get("TRANSFER_ROUTEPOINT");
                LZ_CLI = XMLAO.getNodeValueText(docBA, "FLDCLI");
                LZ_FirstPromptPlayDateTime = XMLAO.getNodeValueText(docBA, "FLDCALLFLOWDATETIME", 0);



                System.out.println("LZ_FirstPromptPlayDateTime=" + LZ_FirstPromptPlayDateTime);
                System.out.println("CurrentDateTime=" + Util.getCurrentDateTime());

                if (LZ_CallerType.equals("")) {
                    LZ_CallerType = XMLAO.getNodeValueText(docBA, "BA_CALLER_TYPE");
                }

                if (ctiSubscriberID == "" || ctiSubscriberID == null) {
                    ctiSRWO = "PARTN";
                } else {
                    ctiSRWO = "PARTNSUB";
                }

                ctiIsRMNctiIsDND = "N,N";
                if (LZ_tempCFID.equals("11060")) {
                    ctiDesk = "ACT";
                }

                if (ctiLangCode.equals("ORI")) {
                    ctiLangCode = "ODI";
                }
                if (ctiLangCodeSec.equals("ORI")) {
                    ctiLangCodeSec = "ODI";
                }


                cti_ExitCode = ctiCustCategory + "_" + ctiDesk;



                if (ctiIVRLanguage.equals("")) {
                    ctiIVRLanguage = "English";
                }

                String updateTCDResult = new UpdateCallDetailDAO().updateCallDetail(LZ_DBCallDetailID,
                        Util.getCurrentDateTime(), ctiIVRLanguage, ctiPartnerCode, "", LZ_CallerType,
                        "", "", "", LZ_LastTraversedCFDID, "Transferred", "", LZ_TransferNumber, LZ_AccountStatus,
                        LZ_AccountSubStatus, LZ_SubscriberIDCount, LZ_NonRMNIdentifier, LZ_SubIDValidated, LZ_CLI,
                        LZ_FirstPromptPlayDateTime, cti_ExitCode, LZ_PartnerSubType, LZ_ProductType, LZ_FirstActivationDate,
                        LZ_SegmentSubType, LZ_ActualCustomerClass, LZ_IsSensitive);


                new WriteXML().writeTextFile(LZ_CallFlowDetailXML, LZ_DBCallDetailID);
            }



            /*System.out.println("********CTI DATA**********");
             System.out.println("LZ_tempCFID: " + LZ_tempCFID);
             System.out.println("ctiIsRMNctiIsDND: " + ctiIsRMNctiIsDND);
             System.out.println("ctiSubscriberCount: " + ctiSubscriberCount);
             System.out.println("ctiIVRLanguage: " + ctiIVRLanguage);
             System.out.println("ctiRepeatCallCount: " + ctiRepeatCallCount);
             System.out.println("ctiUCID: " + ctiUCID);
             System.out.println("ctiLastMenu: " + ctiLastMenu);
             System.out.println("ctiLanguageAlert: " + ctiLanguageAlert);
             System.out.println("ctiCampaignCode1: " + ctiCampaignCode1);
             System.out.println("ctiCampaignCode2: " + ctiCampaignCode2);
             System.out.println("ctiSubscriberID: " + ctiSubscriberID);
             System.out.println("ctiRMN: " + ctiRMN);
             System.out.println("ctiSRWO: " + ctiSRWO);
             System.out.println("ctiExit: " + ctiDesk);
             System.out.println("ctiDC: " + ctiDC);
             System.out.println("ctiLangCode: " + ctiLangCode);
             System.out.println("ctiCustCategory: " + ctiCustCategory);
             System.out.println("ctiTransactionAlert : " + ctiTransactionAlert);
             System.out.println("ctiPartnerCode : " + ctiPartnerCode);
             System.out.println("ctiLangCodeSec : " + ctiLangCodeSec);
             System.out.println("cti_ExitCode : " + cti_ExitCode);
             System.out.println("cti_DCVAG : "+cti_DCVAG );
             System.out.println("cti_DCVQ: "+cti_DCVQ );

             System.out.println("***************************");*/



            System.out.println("***************************");

            Logger.info(LZ_DBCallDetailID, "********CTI DATA**********", false);
            Logger.info(LZ_DBCallDetailID, "LZ_tempCFID: " + LZ_tempCFID, false);
            Logger.info(LZ_DBCallDetailID, "ctiIsRMNctiIsDND: " + ctiIsRMNctiIsDND, false);
            Logger.info(LZ_DBCallDetailID, "ctiSubscriberCount: " + ctiSubscriberCount, false);
            Logger.info(LZ_DBCallDetailID, "ctiIVRLanguage: " + ctiIVRLanguage, false);
            Logger.info(LZ_DBCallDetailID, "ctiRepeatCallCount: " + ctiRepeatCallCount, false);
            Logger.info(LZ_DBCallDetailID, "ctiUCID: " + ctiUCID, false);
            Logger.info(LZ_DBCallDetailID, "ctiLastMenu: " + ctiLastMenu, false);
            Logger.info(LZ_DBCallDetailID, "ctiLanguageAlert: " + ctiLanguageAlert, false);
            Logger.info(LZ_DBCallDetailID, "ctiCampaignCode1: " + ctiCampaignCode1, false);
            Logger.info(LZ_DBCallDetailID, "ctiCampaignCode2: " + ctiCampaignCode2, false);
            Logger.info(LZ_DBCallDetailID, "ctiSubscriberID: " + ctiSubscriberID, false);
            Logger.info(LZ_DBCallDetailID, "ctiRMN: " + ctiRMN, false);
            Logger.info(LZ_DBCallDetailID, "ctiSRWO: " + ctiSRWO, false);
            Logger.info(LZ_DBCallDetailID, "ctiExit: : " + ctiDesk, false);
            Logger.info(LZ_DBCallDetailID, "ctiExitCode: " + cti_ExitCode, false);
            Logger.info(LZ_DBCallDetailID, "ctiDC: " + ctiDC, false);
            Logger.info(LZ_DBCallDetailID, "ctiLangCodePrimary: " + ctiLangCode, false);
            Logger.info(LZ_DBCallDetailID, "PartnerCode : " + ctiPartnerCode, false);
            Logger.info(LZ_DBCallDetailID, "TransferNumber : " + LZ_TransferNumber, false);
            Logger.info(LZ_DBCallDetailID, "ctiLangCodeSecondary: " + ctiLangCodeSec, false);
            Logger.info(LZ_DBCallDetailID, "ctiCustCategory: " + ctiCustCategory, false);
            Logger.info(LZ_DBCallDetailID, "ctiTransactionAlert : " + ctiTransactionAlert, false);
            Logger.info(LZ_DBCallDetailID, "NonBusinessHoursFlag : " + LZ_NonBuisinessHour, false);
            Logger.info(LZ_DBCallDetailID, "cti_DCVAG : " + cti_DCVAG, false);
            Logger.info(LZ_DBCallDetailID, "cti_DCVQ: " + cti_DCVQ, false);

            Logger.info(LZ_DBCallDetailID, "***************************", false);
        } catch (Exception ex) {
            Logger.error(ctiCallDetailID, " Exception in SetAgentTransferDetails Page : " + ex.getMessage(), false);
        } finally {
            LZ_CallFlowDetailXML = LZ_tempCFID = test_transactionalert = LZ_DBCallDetailID = LZ_PrimaryLanguage =
                    LZ_SecondaryLanguage = LZ_SelectedLanguage = cti_ExitCode = LZ_FirstActivationDate = LZ_SegmentSubType =
                    LZ_ActualCustomerClass = LZ_IsSensitive = null;
        }


        JSONObject result = new JSONObject();
        result.put("CallDetailID", ctiCallDetailID);
        result.put("IsRMNIsDND", ctiIsRMNctiIsDND);
        result.put("IVRLanguage", ctiIVRLanguage);
        result.put("SubscriberCount", ctiSubscriberCount);
        result.put("RepeatCallCount", ctiRepeatCallCount);
        result.put("UCID", ctiUCID);
        result.put("LastMenu", ctiLastMenu);
        result.put("LanguageAlert", ctiLanguageAlert);
        result.put("TransactionAlert", ctiTransactionAlert);
        result.put("CampaignCode1", ctiCampaignCode1);
        result.put("CampaignCode2", ctiCampaignCode2);
        result.put("SubscriberID", ctiSubscriberID);
        result.put("RMN", ctiRMN);
        result.put("SRWO", ctiSRWO);
        result.put("Desk", ctiDesk);
        result.put("DC", ctiDC);
        result.put("LangCode", ctiLangCode);
        result.put("CustCategory", ctiCustCategory);
        result.put("PartnerCode", ctiPartnerCode);
        result.put("TransferNumber", LZ_TransferNumber);
        result.put("SecondaryLanguage", ctiLangCodeSec);
        result.put("NonBusinessHoursFlag", LZ_NonBuisinessHour);
        result.put("DCVAG", cti_DCVAG);
        result.put("DCVQ", cti_DCVQ);
        result.put("CallTypeID", LZ_CallTypeID);
        return result;

    }

    ;
%>
<%-- GENERATED: DO NOT REMOVE --%> 
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONException"%>
<%@page import="java.util.Map"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<%@page import="org.w3c.dom.Document"%>
<%@page import="Common.ActionObjects.*"%>

<%@include file="../backend.jspf" %>