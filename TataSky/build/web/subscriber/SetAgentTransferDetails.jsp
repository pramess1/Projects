<%@page language="java" contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.tsg.database.ivr.dataaccess.UpdateCallDetailDAO"%>
<%@page import="com.tsg.database.ivr.dataaccess.InsertCallFlowDetailDAO"%>
<%@page import="com.tsg.util.*"%>
<%@page import="com.tsg.common.*"%>
<%@page import="com.tsg.database.ivr.dataaccess.GetCallFlowValueDAO"%>
<%@page import="com.tsg.database.gg.dataaccess.GetPremiumBySubscriberId"%>
<%@page import="com.tsg.database.gg.dataaccess.GetSubscriberRepeatCount"%>
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
        String ctiCampaignCode3 = ""; // CTI field for sending campaign code 3
        String ctiSubscriberID = ""; // CTI field for sending subscriber ID
        String ctiRMN = ""; // CTI field for sending RMN
        String ctiSRWO = ""; // CTI field for sending Seibel Team requested data
        String ctiDesk = ""; // CTI field for sending agent desk
        String ctiDC = ""; // CTI field for sending data center
        String ctiLangCode = ""; // CTI field for sending language code (first 3 letters in upper case)
        String ctiLangCodeSec = ""; // CTI field for sending language code (first 3 letters in upper case)
        String LZ_LastTraversedCFDID = "";
        String ctiCustCategory = ""; // CTI field for sending customer category (MAS/PRE)
        String test_transactionalert = ""; //test for trans alrt by raja.
        String LZ_TransferNumber = ""; // This stores the transfer number.
        String LZ_CLI_RepeatFlag = "";

        String LZ_DBCallDetailID = ""; // This is used to store the call detail ID.
        int LZ_tempCount = 0;
        String LZ_tempCFID = "";

        String LZ_PrimaryLanguage = "";
        String LZ_SecondaryLanguage = "";
        String LZ_SelectedLanguage = "";
        String cti_DCVAG = "";
        String cti_DCVQ = "";
        String cti_ExitCode = "";
        String LZ_DNDFlag = "";
        String LZ_CallTypeID = "";
        String cti_FirstName = "";
        String cti_LastName = "";
        String LZ_CallerType = "";
        String LZ_PartnerSubType = "";
        String LZ_ProductType = "";
        String LZ_ActualCustomerClass = "";
        String LZ_FirstActivationDate = "";
        String LZ_SegmentSubType = "";
        int LZ_ActivationDateDifference = 0;
        String LZ_IsSensitive = "";

        try {
//          LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
//          LZ_DBCallDetailID = state.getString("LZ_DBCallDetailID");
            LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML", "");
            LZ_DBCallDetailID = state.optString("LZ_DBCallDetailID", "");
            ctiCallDetailID = LZ_DBCallDetailID;


            if (LZ_SimulatorMode) {
            } else {
                Document docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);
                ctiRepeatCallCount = XMLAO.getNodeValueText(docBA, "BA_CALLCOUNTBYSUBID");//Rishi added on 27/12 

                LZ_PrimaryLanguage = XMLAO.getNodeValueText(docBA, "BA_PRIMARY_LANGUAGE");
                LZ_SecondaryLanguage = XMLAO.getNodeValueText(docBA, "BA_SECONDARY_LANGUAGE");
                LZ_SelectedLanguage = XMLAO.getNodeValueText(docBA, "BA_SELECTED_LANGUAGE");
                //  LZ_CLI_RepeatFlag = XMLAO.getNodeValueText(docBA, "BA_SUB_AGENT_REPEAT_FLAG");
                // LZ_CLI_RepeatFlag = XMLAO.getNodeValueText(docBA, "BA_CLI_REPEAT_CALLER_FLAG");
                ctiSubscriberID = XMLAO.getNodeValueText(docBA, "BA_SUBSCRIBER_ID");
//                LZ_CLI_RepeatFlag = XMLAO.getNodeValueText(docBA, "BA_SUB_IVR_REPEAT_FLAG");
                GetSubscriberRepeatCount objGetSubscriberCount = new GetSubscriberRepeatCount();
                LZ_CLI_RepeatFlag = objGetSubscriberCount.getSubscriberRepeatCount(ctiSubscriberID, LZ_DBCallDetailID);
                LZ_PartnerSubType = XMLAO.getNodeValueText(docBA, "BA_PARTNER_SUB_TYPE");
                LZ_ProductType = XMLAO.getNodeValueText(docBA, "BA_STB_TYPE");
                LZ_FirstActivationDate = XMLAO.getNodeValueText(docBA, "BA_FIRST_ACTIVATION_DATE");
                LZ_SegmentSubType = XMLAO.getNodeValueText(docBA, "BA_SEGMENT_SUBTYPE");

//                LZ_ActivationDateDifference = Integer.parseInt(XMLAO.getNodeValueText(docBA, "BA_ACTV_DATE_DIFFERENCE"));

                try {
                    LZ_ActivationDateDifference = Integer.parseInt(XMLAO.getNodeValueText(docBA, "BA_ACTV_DATE_DIFFERENCE"));
                } catch (Exception ex) {

                    Logger.info(LZ_DBCallDetailID, "LZ_ActivationDateDifference : " + ex.getMessage(), false);
                }

                LZ_ActualCustomerClass = XMLAO.getNodeValueText(docBA, "BA_ACT_CUST_CLASS");
                LZ_IsSensitive = XMLAO.getNodeValueText(docBA, "BA_ISSENSITIVE");

                Logger.info(LZ_DBCallDetailID, "SetAgentTransferDetails : Partner Sub Type : " + LZ_PartnerSubType + " Product Type : " + LZ_ProductType
                        + " First Activation Date : " + LZ_FirstActivationDate + " Actual Customer Class : " + LZ_ActualCustomerClass + " Segment SubType :" + LZ_SegmentSubType
                        + " Is Sensitive : " + LZ_IsSensitive, false);


                Logger.info(LZ_DBCallDetailID, "CLI Repeat Flag : " + LZ_CLI_RepeatFlag, false);


                LZ_TransferNumber = ConfigurationReader.configList.get("TRANSFER_ROUTEPOINT");



                cti_DCVAG = XMLAO.getNodeValueText(docBA, "CTIVAG");
                cti_DCVQ = XMLAO.getNodeValueText(docBA, "CTIVQ");
                LZ_CallTypeID = XMLAO.getNodeValueText(docBA, "FLDCALLTYPEID");
                cti_FirstName = XMLAO.getNodeValueText(docBA, "BA_FIRSTNAME");
                cti_LastName = XMLAO.getNodeValueText(docBA, "BA_LASTNAME");


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


                ctiLangCodeSec = XMLAO.getNodeValueText(docBA, "BA_SECONDARY_LANGUAGE");

                if (!ctiLangCodeSec.equals("") && ctiLangCodeSec.length() > 2) {
                    ctiLangCodeSec = ctiLangCodeSec.substring(0, 3).toUpperCase();
                }
                if (!ctiIVRLanguage.equals("") && ctiIVRLanguage.length() > 2) {
                    ctiLangCode = ctiIVRLanguage.substring(0, 3).toUpperCase();
                }


                String LZ_SubscriberIDCount = XMLAO.getNodeValueText(docBA, "BA_SUBSCRIBER_ID_COUNT");
                ctiSubscriberCount = LZ_SubscriberIDCount;
                ctiCustCategory = XMLAO.getNodeValueText(docBA, "BA_PREMIUM_FLAG");

                if (ctiCustCategory.equals("Y")) {
                    ctiCustCategory = "PRM";
                } else {
                    ctiCustCategory = "MAS";
                }


                //ctiRepeatCallCount = XMLAO.getNodeValueText(docBA, "BA_CLI_REPEAT_COUNT"); Rishi
                ctiUCID = XMLAO.getNodeValueText(docBA, "FLDUUID");

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

                ctiLastMenu = new GetCallFlowValueDAO().getCallFlowValue(LZ_LastTraversedCFDID, ctiCallDetailID);

                int LZ_tempTransactionAlertCount = 0;

                LZ_tempTransactionAlertCount = XMLAO.getNodeCount(docBA, "CTITRANSACTIONALERT") - 1;



                ctiTransactionAlert = XMLAO.getNodeValueText(docBA, "CTITRANSACTIONALERT", LZ_tempTransactionAlertCount);




                ctiLanguageAlert = XMLAO.getNodeValueText(docBA, "CTILANGUAGEALERT");
                ctiDC = ConfigurationReader.configList.get("DATA_CENTER");


                LZ_CallerType = XMLAO.getNodeValueText(docBA, "BA_CALLER_TYPE");

                String LZ_AccountStatus = "";

                String LZ_AccountSubStatus = "";
                String LZ_NonRMNIdentifier = "";
                String LZ_SubIDValidated = "";

                if (LZ_CallerType.contains("Prospect")) {

                    //****************************Prospect Configuration starts **************************
                    ctiIsRMNctiIsDND = "Y,N";
                    ctiCampaignCode1 = "";
                    ctiCampaignCode2 = "";
                    ctiSubscriberID = "";
                    ctiRMN = XMLAO.getNodeValueText(docBA, "FLDCLI");
                    //ctiRMN = "9008788000"; // prospect - multi
                    //ctiRMN = "9880512345"; // prospect
                    if (!ctiSubscriberCount.equals("")) {
                        ctiSRWO = ctiSubscriberCount.substring(0, 1);
                    }

                    if (ctiSRWO.equals("Y")) {
                        ctiSRWO = "PRSPTMUL";
                    } else {
                        ctiSRWO = "PRSPT";
                    }

                    ctiDesk = "PRO";//Rishi
                    ctiCustCategory = "PRO";//Rishi

                    Logger.info(LZ_DBCallDetailID, "********Prospect DATA********** ctiIsRMNctiIsDND " + ctiIsRMNctiIsDND + " ctiDesk : " + ctiDesk + " ctiCustCategory :" + ctiCustCategory + " ctiSRWO :" + ctiSRWO, false);
                    //9886123456 - MULTIPRSPT
                    //****************************Prospect Configuration Ends **************************

                } else if (LZ_CallerType.equals("RMN")) {
                    //****************************RMN Configuration starts **************************
                    ctiIsRMNctiIsDND = XMLAO.getNodeValueText(docBA, "CTIISRMNCTIISDND");
                    LZ_DNDFlag = XMLAO.getNodeValueText(docBA, "BA_NDNC_FLAG");

                    if (LZ_DNDFlag.equals("")) {
                        LZ_DNDFlag = "N";
                    }
                    if (ctiIsRMNctiIsDND.equals("Y")) {

                        ctiIsRMNctiIsDND = "Y," + LZ_DNDFlag;
                        //ctiDesk = "DND";


                    } else {

                        //ctiIsRMNctiIsDND = "Y," + XMLAO.getNodeValueText(docBA, "BA_NDNC_FLAG");
                        //*********************** Start***********************
                        ctiSubscriberID = XMLAO.getNodeValueText(docBA, "BA_SUBSCRIBER_ID");
                        ctiRMN = XMLAO.getNodeValueText(docBA, "BA_RMN");
                        ctiSRWO = XMLAO.getNodeValueText(docBA, "CTISRWO");
                        ctiSRWO = XMLAO.getNodeValueText(docBA, "BA_SR_OPEN_FLAG") + XMLAO.getNodeValueText(docBA, "BA_WO_OPEN_FLAG");
                        //ctiSRWO = "NY";
                        //if(ctiSRWO==""){ctiSRWO = "YY";}
                        ctiDesk = XMLAO.getNodeValueText(docBA, "CTIDESK");
                        ctiCustCategory = XMLAO.getNodeValueText(docBA, "BA_PREMIUM_FLAG");
                        //ctiRepeatCallCount = XMLAO.getNodeValueText(docBA, "BA_CLI_REPEAT_COUNT"); //Rishi
                        ctiRepeatCallCount = XMLAO.getNodeValueText(docBA, "BA_CALLCOUNTBYSUBID");//Rishi added on 27/12 
                        if (ctiCustCategory.equals("Y")) {
                            ctiCustCategory = "PRM";

                            if (ctiDesk.isEmpty()) {
                                ctiDesk = "PRM";
                            }



                        } else {
                            ctiCustCategory = "MAS";
                        }
                        ctiIsRMNctiIsDND = "N,N";
                        //********************END *******************
                    }
                    //**********Camapign Code settings and priority starts *******************

                    //**********Camapign Code settings and priority Ends *******************

                    ctiSubscriberID = XMLAO.getNodeValueText(docBA, "BA_SUBSCRIBER_ID");
                    ctiRMN = XMLAO.getNodeValueText(docBA, "BA_RMN");
                    ctiSRWO = XMLAO.getNodeValueText(docBA, "BA_SR_OPEN_FLAG") + XMLAO.getNodeValueText(docBA, "BA_WO_OPEN_FLAG");

                    if (ctiDesk.isEmpty()) {
                        ctiDesk = XMLAO.getNodeValueText(docBA, "CTIDESK");

                        if (ctiCustCategory.equals("PRM") && ctiDesk.equals("MAS")) {
                            if (ctiDesk.isEmpty()) {
                                ctiDesk = "PRM";
                            }

                            //  System.out.println("inside ctidesk empty 1");
                        }

                        if (ctiCustCategory.equals("PRM")) {
                            if (ctiDesk.isEmpty()) {
                                ctiDesk = "PRM";
                            }
                            // System.out.println("inside ctidesk empty 2");
                        }

                    }

                    LZ_AccountStatus = XMLAO.getNodeValueText(docBA, "BA_ACCOUNT_STATUS");
                    LZ_AccountSubStatus = XMLAO.getNodeValueText(docBA, "BA_ACCOUNT_SUB_STATUS");
                    LZ_NonRMNIdentifier = XMLAO.getNodeValueText(docBA, "FLDNONRMNIDENTIFIER");
                    LZ_SubIDValidated = XMLAO.getNodeValueText(docBA, "FLDSUBIDVALIDATED");

                    if ((ctiSRWO.equals("NN") || ctiSRWO.equals("YY") || ctiSRWO.equals("YN") || ctiSRWO.equals("NY")) && ctiSubscriberID.equals("")) {
                        //ctiSRWO = "NN";
                        ctiSRWO = "NONRMN";
                    }


                    // if (LZ_AccountStatus.equals("Blacklisted") || LZ_AccountStatus.equals("Cancelled") || LZ_AccountStatus.equals("WrittenOff") || ////LZ_AccountStatus.equals("Cancel-Pending") || LZ_AccountStatus.equals("Temp Suspension")) 
                    if (LZ_AccountStatus.equals("Blacklisted")) {
                        ctiLastMenu = "Validate Subscriber ID";
                        ctiTransactionAlert = "Blacklisted Account";
                    }
                    if (LZ_AccountStatus.equals("Cancelled")) {
                        ctiLastMenu = "Validate Subscriber ID";
                        ctiTransactionAlert = "Cancelled Account";
                    }
                    if (LZ_AccountStatus.equals("WrittenOff")) {
                        ctiLastMenu = "Validate Subscriber ID";
                        ctiTransactionAlert = "WrittenOff Account";
                    }
                    if (LZ_AccountStatus.equals("Cancel-Pending")) {
                        ctiLastMenu = "Validate Subscriber ID";
                        ctiTransactionAlert = "Cancel-Pending Account";
                    }
                    if (LZ_AccountStatus.equals("Temp Suspension")) {
                        ctiLastMenu = "Validate Subscriber ID";
                        ctiTransactionAlert = "Temp Suspension Account";
                    }

                    //****************************RMN Configuration Ends **************************
                } else if (LZ_CallerType.equals("NonRMN")) {
                    ctiIsRMNctiIsDND = "N,N";
                    ctiSubscriberCount = "";
                    ctiLanguageAlert = "";
                    ctiCampaignCode1 = "";
                    ctiCampaignCode2 = "";
                    ctiSubscriberID = XMLAO.getNodeValueText(docBA, "BA_SUBSCRIBER_ID");
                    ctiRMN = XMLAO.getNodeValueText(docBA, "BA_RMN");
                    ctiSRWO = XMLAO.getNodeValueText(docBA, "CTISRWO");
                    ctiSRWO = XMLAO.getNodeValueText(docBA, "BA_SR_OPEN_FLAG") + XMLAO.getNodeValueText(docBA, "BA_WO_OPEN_FLAG");
                    ctiSRWO = "NONRMN";


                    //ctiRepeatCallCount = 
                    ctiDesk = XMLAO.getNodeValueText(docBA, "CTIDESK");
                    ctiCustCategory = "MAS";

                }
                new WriteXML().writeTextFile(LZ_CallFlowDetailXML, LZ_DBCallDetailID);
                if (ctiRepeatCallCount.equals("")) {
                    ctiRepeatCallCount = XMLAO.getNodeValueText(docBA, "BA_CALLCOUNTBYCLI");//Rishi added on 27/12 
                }
                LZ_tempCFID = LZ_LastTraversedCFDID;

                if (ctiCustCategory.equals("PRM") && ctiDesk.equals("MAS")) {

                    ctiDesk = "PRM";

                }
                if (ctiCustCategory.equals("PRM") && LZ_tempCFID.equals("9001")) {

                    ctiDesk = "PRM";
                }

                if (LZ_tempCFID.equals("400") || LZ_tempCFID.equals("401") || LZ_tempCFID.equals("402") || LZ_tempCFID.equals("403") || LZ_tempCFID.equals("404") || LZ_tempCFID.equals("405") || LZ_tempCFID.equals("406") || LZ_tempCFID.equals("407") || LZ_tempCFID.equals("408") || LZ_tempCFID.equals("409") || LZ_tempCFID.equals("410") || LZ_tempCFID.equals("400") || LZ_tempCFID.equals("411")) {
                    ctiDesk = "TEC";
                }



                if (LZ_tempCFID.equals("1004") || LZ_tempCFID.equals("1001")) {
                    ctiDesk = "OF1";
                }

                if (LZ_tempCFID.equals("1005") || LZ_tempCFID.equals("1002")) {
                    ctiDesk = "OF2";
                }

                if (LZ_tempCFID.equals("25") && ctiCustCategory.equals("PRM")) {
                    ctiLastMenu = "Main Menu - Agent Transfer";
                    if (ctiDesk.equals("CAT")) {
                        ctiDesk = "PRM";
                    } else if (ctiDesk.equals("PAT")) {
                        ctiDesk = "PRM";
                    }

                }
                if (ctiTransactionAlert.equals("Validation failed")) {
                    ctiTransactionAlert = "";
                }

                if (ctiRepeatCallCount.equals("0")) {
                    ctiRepeatCallCount = "";
                }
                if (ctiDesk.equals("PAT")) {
                    ctiDesk = "CAT";
                }



                if (LZ_tempCFID.equals("700") || LZ_tempCFID.equals("701") || LZ_tempCFID.equals("702") || LZ_tempCFID.equals("703") || LZ_tempCFID.equals("704") || LZ_tempCFID.equals("705") || LZ_tempCFID.equals("706") || LZ_tempCFID.equals("707") || LZ_tempCFID.equals("708")) {
                    ctiDesk = "SPD";
                }

                String LZ_PremiumFlag1 = XMLAO.getNodeValueText(docBA, "BA_PREMIUM_FLAG1");
                String LZ_CLI = XMLAO.getNodeValueText(docBA, "FLDCLI");
                String LZ_FirstPromptPlayDateTime = XMLAO.getNodeValueText(docBA, "FLDCALLFLOWDATETIME", 0);


                //--this is the default values for SUBSCRIBER SPECIFIC CAMPAIGN FOR  all the Subscribers

                if (ctiTransactionAlert.equals("CAMPAIGN")) {
                    ctiTransactionAlert = "";
                    ctiCampaignCode1 = XMLAO.getNodeValueText(docBA, "BA_CAMPAIGN_DESC1");
                    ctiCampaignCode2 = XMLAO.getNodeValueText(docBA, "BA_CAMPAIGN_DESC2");
                    ctiCampaignCode3 = XMLAO.getNodeValueText(docBA, "BA_CAMPAIGN_DESC3");

                    if (ctiCampaignCode1.isEmpty()) {
                        if (ctiCampaignCode2.isEmpty()) {
                            if (!ctiCampaignCode3.isEmpty()) {
                                ctiDesk = "CM3";
                            }
                        } else {
                            ctiDesk = "CM2";
                        }
                    } else {
                        ctiDesk = "CM1";
                        System.out.println("ctiDesk for campaign 1 is assigned here:" + ctiDesk);
                    }
                }

                //-----------Tezpur campaign // ----------------------------------------------------------- 
                ctiCampaignCode1 = XMLAO.getNodeValueText(docBA, "BA_CAMPAIGN_DESC1");
                System.out.println("ctiCampaignCode1 " + ctiCampaignCode1 + "===============" + ctiSubscriberID);
                if (ctiCampaignCode1.equals("Tezpur Army Campaign")) {
                    ctiDesk = "CM1";
                }
                //-------------------//-----------------------------------------------------------                
                //------NAD desk configuration desk given the preference	 
                if (LZ_tempCFID.equals("300") || LZ_tempCFID.equals("301")) {
                    ctiCustCategory = "MAS";
                    ctiDesk = "NAD";
                }
                if (LZ_tempCFID.equals("4")) {
                    if (LZ_ActivationDateDifference <= 120) {
                        ctiCustCategory = "MAS";
                        ctiDesk = "MAS";
                    }
                }
                //-----------------------------------------------------------	 	 
                //------RPT desk given the preference
                if (LZ_CLI_RepeatFlag.equals("Y")) {
                    ctiCustCategory = "MAS";
                    ctiDesk = "RPT";
                }
                //------
                //-----------------------------------------------------------	 
                //-----this is default value for IVR language if the value is empty while transferring

                if (ctiLangCode.equals("ORI")) {
                    ctiLangCode = "ODI";
                }
                if (ctiLangCodeSec.equals("ORI")) {
                    ctiLangCodeSec = "ODI";
                }
                if (ctiIVRLanguage == "") {
                    ctiIVRLanguage = "English";
                }
                //------------------

                cti_ExitCode = ctiCustCategory + "_" + ctiDesk;

                String updateTCDResult = new UpdateCallDetailDAO().updateCallDetail(LZ_DBCallDetailID,
                        Util.getCurrentDateTime(), ctiIVRLanguage, ctiSubscriberID, "", LZ_CallerType,
                        LZ_PremiumFlag1, "", "", LZ_LastTraversedCFDID, "Transferred", "", LZ_TransferNumber, LZ_AccountStatus,
                        LZ_AccountSubStatus, LZ_SubscriberIDCount, LZ_NonRMNIdentifier, LZ_SubIDValidated, LZ_CLI, LZ_FirstPromptPlayDateTime,
                        cti_ExitCode, LZ_PartnerSubType, LZ_ProductType, LZ_FirstActivationDate, LZ_SegmentSubType,
                        LZ_ActualCustomerClass, LZ_IsSensitive);



                LZ_SubscriberIDCount = LZ_CallerType = LZ_AccountStatus = LZ_AccountSubStatus = LZ_NonRMNIdentifier =
                        LZ_SubIDValidated = LZ_PremiumFlag1 = LZ_CLI = LZ_FirstPromptPlayDateTime = null;


                //-----this is configured for language alert--

                //System.out.println("Primary Language:" + LZ_PrimaryLanguage);
                //System.out.println("Secondary Language:" + LZ_SecondaryLanguage);
                //System.out.println("Selected Language:" + LZ_SelectedLanguage);

                //------NAD desk config

                if (LZ_SegmentSubType.equals("Bucket1") || LZ_SegmentSubType.equals("Bucket2")) {

                    ctiCustCategory = "MAS";
                    ctiDesk = "NAD";
                    Logger.info(LZ_DBCallDetailID, "SetAgentTransferDetails :- NAD Exit", false);
                    Logger.info(LZ_DBCallDetailID, "SetAgentTransferDetails :- ctiDesk: " + ctiDesk, false);

                }
                //---------------------------------



                if (LZ_tempCFID.equals("31")) {
                    ctiLanguageAlert = "";
                    System.out.println("**CFID 31 so No Lang alert");
                } else if (LZ_tempCFID.equals("32")) {
                    ctiLanguageAlert = "";
                    System.out.println("**CFID 32 so No Lang alert");
                } else if (ctiSRWO.equals("PRSPT")) {
                    ctiLanguageAlert = "";
                    System.out.println("**Prospect so No Lang alert");
                } else if (ctiSRWO.equals("MULPRSPT")) {
                    ctiLanguageAlert = "";
                    System.out.println("**Prospect 32 so No Lang alert");
                } else if (ctiIVRLanguage.equals("manipuri")) {
                    ctiLanguageAlert = "";
                    System.out.println("**Language Manipuri No Lang alert");
                } else if (!LZ_PrimaryLanguage.equalsIgnoreCase("") && LZ_SelectedLanguage.equalsIgnoreCase("")) {
                    ctiLanguageAlert = "";
                    System.out.println("**Primary language has value and Selected is null");
                } else if (LZ_PrimaryLanguage.equalsIgnoreCase("") && !LZ_SelectedLanguage.equalsIgnoreCase("")) {
                    ctiLanguageAlert = "Preferred Language is not set in database, please update in Siebel";
                    System.out.println("**Selected language has value and Primary language is null");
                } else if (LZ_PrimaryLanguage.equalsIgnoreCase(LZ_SelectedLanguage)) {
                    ctiLanguageAlert = "";
                    //System.out.println("**********Primary Language and Selected language is same********");
                } else {
                    ctiLanguageAlert = "Preferred Language is incorrect in database, please update in Siebel";
                    //System.out.println("**********Primary Language and Selected language is Different********");
                }

                //----


                //This is Invalid message handled in Recharge - Credit card module --need to be handled in APP
                if (ctiTransactionAlert.equalsIgnoreCase("SUBMITTED")) {
                    ctiTransactionAlert = "";
                }
                //----


            }


        } catch (Exception ex) {
            System.out.println("SetAgentException-->" + ex.getMessage());

        } finally {

            System.out.println("SUB ID:" + ctiSubscriberID + "--------------" + "EXITDESK" + cti_ExitCode);
            Logger.info(LZ_DBCallDetailID, "********CTI DATA**********", false);
            Logger.info(LZ_DBCallDetailID, "LZ_tempCFID: " + LZ_tempCFID, false);
            Logger.info(LZ_DBCallDetailID, "ctiCallDetailID: " + ctiCallDetailID, false);
            Logger.info(LZ_DBCallDetailID, "ctiIsRMNctiIsDND: " + ctiIsRMNctiIsDND, false);
            Logger.info(LZ_DBCallDetailID, "ctiSubscriberCount: " + ctiSubscriberCount, false);
            Logger.info(LZ_DBCallDetailID, "ctiIVRLanguage: " + ctiIVRLanguage, false);
            Logger.info(LZ_DBCallDetailID, "ctiRepeatCallCount: " + ctiRepeatCallCount, false);
            Logger.info(LZ_DBCallDetailID, "ctiUCID: " + ctiUCID, false);
            Logger.info(LZ_DBCallDetailID, "ctiLastMenu: " + ctiLastMenu, false);
            Logger.info(LZ_DBCallDetailID, "ctiLanguageAlert: " + ctiLanguageAlert, false);
            Logger.info(LZ_DBCallDetailID, "ctiCampaignCode1: " + ctiCampaignCode1, false);
            Logger.info(LZ_DBCallDetailID, "ctiCampaignCode2: " + ctiCampaignCode2, false);
            Logger.info(LZ_DBCallDetailID, "ctiCampaignCode3: " + ctiCampaignCode3, false);
            Logger.info(LZ_DBCallDetailID, "ctiSubscriberID: " + ctiSubscriberID, false);
            Logger.info(LZ_DBCallDetailID, "ctiRMN: " + ctiRMN, false);
            Logger.info(LZ_DBCallDetailID, "ctiSRWO: " + ctiSRWO, false);
            Logger.info(LZ_DBCallDetailID, "ctiExitCode: " + cti_ExitCode, false);
            Logger.info(LZ_DBCallDetailID, "ctiDC: " + ctiDC, false);
            Logger.info(LZ_DBCallDetailID, "ctiLangCodePrimary: " + ctiLangCode, false);
            Logger.info(LZ_DBCallDetailID, "ctiLangCodeSecondary: " + ctiLangCodeSec, false);
            Logger.info(LZ_DBCallDetailID, "ctiCustCategory: " + ctiCustCategory, false);
            Logger.info(LZ_DBCallDetailID, "ctiTransactionAlert : " + ctiTransactionAlert, false);
            Logger.info(LZ_DBCallDetailID, "cti_DCVAG : " + cti_DCVAG, false);
            Logger.info(LZ_DBCallDetailID, "cti_DCVQ: " + cti_DCVQ, false);
            Logger.info(LZ_DBCallDetailID, "CallTypeID: " + LZ_CallTypeID, false);
            Logger.info(LZ_DBCallDetailID, "cti_CallerType: " + LZ_CallerType, false);
            Logger.info(LZ_DBCallDetailID, "cti_FirstName: " + cti_FirstName, false);
            Logger.info(LZ_DBCallDetailID, "cti_FirstName: " + cti_FirstName, false);
            Logger.info(LZ_DBCallDetailID, "cti_ProductType: " + LZ_ProductType, false);



            Logger.info(LZ_DBCallDetailID, "***************************", false);

            LZ_CallFlowDetailXML = LZ_LastTraversedCFDID = test_transactionalert = LZ_DBCallDetailID = LZ_tempCFID =
                    LZ_PrimaryLanguage = LZ_SecondaryLanguage = LZ_SelectedLanguage = cti_ExitCode = LZ_ActualCustomerClass =
                    LZ_IsSensitive = null;

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
        result.put("CampaignCode3", ctiCampaignCode3);
        result.put("SubscriberID", ctiSubscriberID);
        result.put("RMN", ctiRMN);
        result.put("SRWO", ctiSRWO);
        result.put("Desk", ctiDesk);
        result.put("DC", ctiDC);
        result.put("LangCode", ctiLangCode);
        result.put("SecLangCode", ctiLangCodeSec);
        result.put("CustCategory", ctiCustCategory);
        result.put("TransferNumber", LZ_TransferNumber);
        result.put("DCVAG", cti_DCVAG);
        result.put("DCVQ", cti_DCVQ);
        result.put("CallTypeID", LZ_CallTypeID);
        result.put("CallerType", LZ_CallerType);
        result.put("FirstName", cti_FirstName);
        result.put("LastName", cti_LastName);
        result.put("ProductType", LZ_ProductType);

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