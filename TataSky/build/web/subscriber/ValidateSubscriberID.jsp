<%@page language="java" contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.tsg.database.DBAccess"%>
<%@page import="com.tsg.database.gg.dataaccess.CheckValidSubscriberByCliDAO"%>
<%@page import="com.tsg.common.*"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean LZ_SimulatorMode = false; // Simulator Mode by default is set to true.
        String LZ_CallFlowDetailXML = ""; // This is used to store the call flow detail XML.
        String LZ_IsSuccess = "N"; // This is used to store the success status.
        String LZ_DBCallDetailID = ""; // This is used to store the call detail ID.
        String LZ_SubscriberID = ""; // This is used to store the subscriber ID entered.
        String LZ_BACallerType = ""; // Caller Type is either Partner, Subscriber RMN, Prospect, Non RMN
        String LZ_BASubscriberIDCount = ""; // Number of subscribers for a particular RMN
        String LZ_UsrANI = ""; // This is used to store the ANI of the call.
        String LZ_RMN = ""; // This is used to store the RMN of the caller.
        String LZ_CallTypeID = ""; // This is used to store the call type ID.
        String LZ_CLIRepeatFlag = ""; // This is used to store the CLI repeat flag.
        String LZ_CallCountByCLI = ""; // This is used to store the call count by CLI.
        String LZ_AppLanguage = ""; // This is used to store the language folder.
        String LZ_AppID = "";

        try {
//		LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
//		LZ_DBCallDetailID = state.getString("LZ_DBCallDetailID");
//		LZ_SubscriberID = state.optString("LZ_SubscriberID","");
            LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML", "");
            LZ_DBCallDetailID = state.optString("LZ_DBCallDetailID", "");
            LZ_SubscriberID = state.optString("LZ_SubscriberID", "");
            Logger.info(LZ_DBCallDetailID, " ValidateSubscriberID Input = LZ_SubscriberID : " + LZ_SubscriberID, false);
            if (LZ_SimulatorMode) {
                LZ_IsSuccess = "Y";
            } else {
                Document docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);

                //LZ_CallTypeID = XMLAO.getNodeValueText(docBA, "FLDCALLTYPEID");
                LZ_AppID = XMLAO.getNodeValueText(docBA, "FLDAPPID");
                LZ_CLIRepeatFlag = XMLAO.getNodeValueText(docBA, "BA_CLI_REPEAT_CALLER_FLAG");
                LZ_CallCountByCLI = XMLAO.getNodeValueText(docBA, "BA_CALLCOUNTBYCLI");
                LZ_AppLanguage = XMLAO.getNodeValueText(docBA, "BA_APP_LANGUAGE");
                String LZ_PremiumFlag1 = "";
                Logger.info(LZ_DBCallDetailID, " LZ_AppID  : " + LZ_AppID, false);
                //if(LZ_CallTypeID.equals("1"))
                if (LZ_AppID.equals("1")) {
                    LZ_BACallerType = XMLAO.getNodeValueText(docBA, "BA_CALLER_TYPE");
                    LZ_BASubscriberIDCount = XMLAO.getNodeValueText(docBA, "BA_SUBSCRIBER_ID_COUNT");
                    LZ_UsrANI = XMLAO.getNodeValueText(docBA, "FLDCLI");
                    LZ_RMN = XMLAO.getNodeValueText(docBA, "BA_RMN");
                    Logger.info(LZ_DBCallDetailID, " LZ_BACallerType  : " + LZ_BACallerType +  " LZ_BASubscriberIDCount " + LZ_BASubscriberIDCount + " LZ_UsrANI " + LZ_UsrANI + " LZ_RMN " + LZ_RMN, false);
                    if (LZ_BACallerType.equals("NonRMN")
                            || (LZ_BACallerType.equals("RMN") && LZ_BASubscriberIDCount.equals("1"))) {

                        System.out.println("RMNSUBCOUNT1");
                        //String LZ_BA_XML_temp =  new DBAccess().getDetailBySubscriberId(LZ_SubscriberID);



                        String LZ_BA_XML = new DBAccess().getProfileBySubscriberId(LZ_SubscriberID, LZ_DBCallDetailID);
                        LZ_PremiumFlag1 = LZ_BA_XML.substring(LZ_BA_XML.lastIndexOf("<BA_PREMIUM_FLAG1>") + 18, LZ_BA_XML.lastIndexOf("</BA_PREMIUM_FLAG1>"));
                        String LZ_BA_XML_temp = new DBAccess().getDetailBySubscriberId(LZ_SubscriberID, LZ_PremiumFlag1, LZ_DBCallDetailID);



                        LZ_BA_XML = LZ_BA_XML + LZ_BA_XML_temp;

                        System.out.println("Non RMN LZ_BA_XML" + LZ_BA_XML);

                        if (!LZ_BA_XML.isEmpty()) {
                            String LZ_BASelectedLanguage = XMLAO.getNodeValueText(docBA, "BA_SELECTED_LANGUAGE");

                            Document docTemp = XMLAO.buildXMLDocument("<BA_ROOT>" + LZ_BA_XML + "</BA_ROOT>");
                            String LZ_AccountStatus = XMLAO.getNodeValueText(docTemp, "BA_ACCOUNT_STATUS");

                            if (!LZ_AccountStatus.isEmpty()) {
                                LZ_IsSuccess = "Y";

                                String LZ_IVRBypassFlag = ConfigurationReader.configList.get("IVR_BYPASS_FLAG");

                                if (LZ_BASelectedLanguage.isEmpty()) {
                                    LZ_BA_XML = "<BA_ROOT><BA_CALLER_TYPE>RMN</BA_CALLER_TYPE><BA_SUBSCRIBER_ID_COUNT>1</BA_SUBSCRIBER_ID_COUNT><BA_RMN>" + LZ_UsrANI + "</BA_RMN><BA_RMN_FLAG>Y</BA_RMN_FLAG><BA_IVR_BYPASS_FLAG>" + LZ_IVRBypassFlag + "</BA_IVR_BYPASS_FLAG><BA_CLI_REPEAT_CALLER_FLAG>" + LZ_CLIRepeatFlag + "</BA_CLI_REPEAT_CALLER_FLAG><BA_CALLCOUNTBYCLI>" + LZ_CallCountByCLI + "</BA_CALLCOUNTBYCLI><BA_APP_LANGUAGE>" + LZ_AppLanguage + "</BA_APP_LANGUAGE>" + LZ_BA_XML + "</BA_ROOT>";
                                } else {
                                    LZ_BA_XML = "<BA_ROOT><BA_CALLER_TYPE>RMN</BA_CALLER_TYPE><BA_SUBSCRIBER_ID_COUNT>1</BA_SUBSCRIBER_ID_COUNT><BA_RMN>" + LZ_UsrANI + "</BA_RMN><BA_RMN_FLAG>Y</BA_RMN_FLAG><BA_IVR_BYPASS_FLAG>" + LZ_IVRBypassFlag + "</BA_IVR_BYPASS_FLAG><BA_CLI_REPEAT_CALLER_FLAG>" + LZ_CLIRepeatFlag + "</BA_CLI_REPEAT_CALLER_FLAG><BA_CALLCOUNTBYCLI>" + LZ_CallCountByCLI + "</BA_CALLCOUNTBYCLI><BA_SELECTED_LANGUAGE>" + LZ_BASelectedLanguage + "</BA_SELECTED_LANGUAGE><BA_APP_LANGUAGE>" + LZ_AppLanguage + "</BA_APP_LANGUAGE>" + LZ_BA_XML + "</BA_ROOT>";
                                }

                                int LZ_StartIndex = LZ_CallFlowDetailXML.indexOf("<BA_ROOT>");
                                int LZ_EndIndex = LZ_CallFlowDetailXML.indexOf("</BA_ROOT>") + ("</BA_ROOT>").length();
                                String LZ_tempXML = LZ_CallFlowDetailXML.substring(LZ_StartIndex, LZ_EndIndex);

                                LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace(LZ_tempXML, LZ_BA_XML);

                                docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);
                                XMLAO.setNodeValueText(docBA, "FLDNONRMNIDENTIFIER", "SubID");
                                XMLAO.setNodeValueText(docBA, "FLDSUBIDVALIDATED", "Y");
                                LZ_CallFlowDetailXML = XMLAO.getNodeOuterXML(docBA);
                            }
                        }
                    } else if (LZ_BACallerType.equals("RMN") && Integer.parseInt(LZ_BASubscriberIDCount) > 1) {
                        System.out.println("RMNSUBCOUNT2");

                        if (LZ_RMN.equals(LZ_UsrANI)
                                || !LZ_RMN.isEmpty()) {
                            LZ_IsSuccess = new CheckValidSubscriberByCliDAO().checkValidSubscriberByCli(LZ_RMN, LZ_SubscriberID, LZ_DBCallDetailID);
                            //LZ_IsSuccess = new CheckValidSubscriberByCliDAO().checkValidSubscriberByCli("9886977077", LZ_SubscriberID,LZ_DBCallDetailID);
                        } else {
                            LZ_IsSuccess = new CheckValidSubscriberByCliDAO().checkValidSubscriberByCli(LZ_RMN, LZ_SubscriberID, LZ_DBCallDetailID);
                            //LZ_IsSuccess = new CheckValidSubscriberByCliDAO().checkValidSubscriberByCli("9886977077", LZ_SubscriberID,LZ_DBCallDetailID);
                        }

                        if (LZ_IsSuccess.equals("1")) {
                            LZ_IsSuccess = "Y";
                        } else {
                            LZ_IsSuccess = "N";
                        }

                        //if(LZ_IsSuccess.equals("Y"))
                        //{



                        String LZ_BA_XML = new DBAccess().getProfileBySubscriberId(LZ_SubscriberID, LZ_DBCallDetailID);
                        LZ_PremiumFlag1 = LZ_BA_XML.substring(LZ_BA_XML.lastIndexOf("<BA_PREMIUM_FLAG1>") + 18, LZ_BA_XML.lastIndexOf("</BA_PREMIUM_FLAG1>"));
                        String LZ_BA_XML_temp = new DBAccess().getDetailBySubscriberId(LZ_SubscriberID, LZ_PremiumFlag1, LZ_DBCallDetailID);

                        LZ_BA_XML = LZ_BA_XML + LZ_BA_XML_temp;




                        String LZ_IVRBypassFlag = ConfigurationReader.configList.get("IVR_BYPASS_FLAG");



                        if (LZ_RMN.equals(LZ_UsrANI)
                                || !LZ_RMN.isEmpty()) {
                            LZ_BA_XML = "<BA_ROOT><BA_CALLER_TYPE>RMN</BA_CALLER_TYPE><BA_SUBSCRIBER_ID_COUNT>" + LZ_BASubscriberIDCount + "</BA_SUBSCRIBER_ID_COUNT><BA_RMN>" + LZ_RMN + "</BA_RMN><BA_RMN_FLAG>Y</BA_RMN_FLAG><BA_IVR_BYPASS_FLAG>" + LZ_IVRBypassFlag + "</BA_IVR_BYPASS_FLAG><BA_CLI_REPEAT_CALLER_FLAG>" + LZ_CLIRepeatFlag + "</BA_CLI_REPEAT_CALLER_FLAG><BA_CALLCOUNTBYCLI>" + LZ_CallCountByCLI + "</BA_CALLCOUNTBYCLI><BA_APP_LANGUAGE>" + LZ_AppLanguage + "</BA_APP_LANGUAGE>" + LZ_BA_XML + "</BA_ROOT>";
                        } else {
                            LZ_BA_XML = "<BA_ROOT><BA_CALLER_TYPE>RMN</BA_CALLER_TYPE><BA_SUBSCRIBER_ID_COUNT>" + LZ_BASubscriberIDCount + "</BA_SUBSCRIBER_ID_COUNT><BA_RMN>" + LZ_UsrANI + "</BA_RMN><BA_RMN_FLAG>Y</BA_RMN_FLAG><BA_IVR_BYPASS_FLAG>" + LZ_IVRBypassFlag + "</BA_IVR_BYPASS_FLAG><BA_CLI_REPEAT_CALLER_FLAG>" + LZ_CLIRepeatFlag + "</BA_CLI_REPEAT_CALLER_FLAG><BA_CALLCOUNTBYCLI>" + LZ_CallCountByCLI + "</BA_CALLCOUNTBYCLI><BA_APP_LANGUAGE>" + LZ_AppLanguage + "</BA_APP_LANGUAGE>" + LZ_BA_XML + "</BA_ROOT>";
                        }

                        int LZ_StartIndex = LZ_CallFlowDetailXML.indexOf("<BA_ROOT>");
                        int LZ_EndIndex = LZ_CallFlowDetailXML.indexOf("</BA_ROOT>") + ("</BA_ROOT>").length();
                        String LZ_tempXML = LZ_CallFlowDetailXML.substring(LZ_StartIndex, LZ_EndIndex);

                        LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace(LZ_tempXML, LZ_BA_XML);

                        docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);
                        XMLAO.setNodeValueText(docBA, "FLDNONRMNIDENTIFIER", "SubID");
                        XMLAO.setNodeValueText(docBA, "FLDSUBIDVALIDATED", "Y");
                        LZ_CallFlowDetailXML = XMLAO.getNodeOuterXML(docBA);
                        //}
                    }
                } else {
                    String LZ_BA_XML = new DBAccess().getProfileBySubscriberId(LZ_SubscriberID, LZ_DBCallDetailID);
                    LZ_PremiumFlag1 = LZ_BA_XML.substring(LZ_BA_XML.lastIndexOf("<BA_PREMIUM_FLAG1>") + 18, LZ_BA_XML.lastIndexOf("</BA_PREMIUM_FLAG1>"));
                    String LZ_BA_XML_temp = new DBAccess().getDetailBySubscriberId(LZ_SubscriberID, LZ_PremiumFlag1, LZ_DBCallDetailID);

                    LZ_BA_XML = LZ_BA_XML + LZ_BA_XML_temp;



                    if (!LZ_BA_XML.isEmpty()) {
                        LZ_IsSuccess = "Y";

                        LZ_BA_XML = "<BA_ROOT>" + LZ_BA_XML + "<BA_APP_LANGUAGE>" + LZ_AppLanguage + "</BA_APP_LANGUAGE></BA_ROOT>";

                        int LZ_StartIndex = LZ_CallFlowDetailXML.indexOf("<BA_ROOT>");
                        int LZ_EndIndex = LZ_CallFlowDetailXML.indexOf("</BA_ROOT>") + ("</BA_ROOT>").length();
                        String LZ_tempXML = LZ_CallFlowDetailXML.substring(LZ_StartIndex, LZ_EndIndex);

                        LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace(LZ_tempXML, LZ_BA_XML);

                        docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);
                        XMLAO.setNodeValueText(docBA, "FLDNONRMNIDENTIFIER", "SubID");
                        XMLAO.setNodeValueText(docBA, "FLDSUBIDVALIDATED", "Y");
                        LZ_CallFlowDetailXML = XMLAO.getNodeOuterXML(docBA);
                    }
                }
            }
        } catch (Exception ex) {
            Logger.error(LZ_DBCallDetailID, " Exception in ValidateSubscriberID Page : " + ex.getMessage(), false);
        } finally {
            Logger.info(LZ_DBCallDetailID, " ValidateSubscriberID Output = LZ_IsSuccess : " + LZ_IsSuccess, false);
            LZ_DBCallDetailID = LZ_SubscriberID = LZ_BACallerType = LZ_BASubscriberIDCount = LZ_UsrANI = LZ_RMN = LZ_CallTypeID = LZ_CLIRepeatFlag = LZ_CallCountByCLI = LZ_AppLanguage = null;


        }

        JSONObject result = new JSONObject();
        result.put("IsSuccess", LZ_IsSuccess);
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

<%@include file="../backend.jspf" %>