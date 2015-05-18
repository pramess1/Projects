<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>


<%@page import="com.tsg.error.ErrorHandler"%>
<%@page import="com.tsg.util.Util"%>
<%@page import="com.tsg.requesthandler.requestDelegator"%>
<%@page import="com.tsg.portal.SubscriberValidationResponse"%>
<%@page import="com.tsg.portal.SubscriberValidation"%>
<%@page import="com.tsg.xml.GenerateXml"%>
<%@page import="com.tsg.log.Logger"%>

<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean b_SimulatorMode = false; // Simulator Mode by default is set to true. 
        //Input variables
        String BA_SUBSCRIBER_ID = "";

        //Output variables
        String BA_ACCOUNT_TYPE = "";

        String BA_ACCOUNT_SUBTYPE = "";

        String BA_ACCOUNT_STATUS = "";

        String BA_CURRENT_BAL = "";

        String BA_PREFERRED_LANGUAGE = "";

        String LZ_TSTxnID = "";

        String LZ_errorcode = "404";

        String LZ_errorMsg = "";

        String LZ_SUBIDValidResponse = "";

        String LZ_PromptName = "";

        String LZ_CallFlowDetailXML = "";

        String LZ_RequestXML = "";

        String LZ_ResponseXML = "";

        String LZ_DBCallDetailID = "";

        String LZ_ServiceID = "SVD";

        String LZ_TransStartTime = Util.getCurrentDateTime();

        String LZ_TransEndTime = "";

        try {

            if (b_SimulatorMode) {

                //  Test method
                BA_SUBSCRIBER_ID = "1234567890";

                BA_ACCOUNT_TYPE = "";

                BA_ACCOUNT_SUBTYPE = "";

                BA_ACCOUNT_STATUS = "Active";

                BA_CURRENT_BAL = "";

                BA_PREFERRED_LANGUAGE = "English";

                LZ_TSTxnID = "TI1307100007535922";

                LZ_errorcode = "00";

                LZ_errorMsg = "SUCCESS";

            } else {

                // Realtime scenario
//                BA_SUBSCRIBER_ID = state.getString("BA_SUBSCRIBER_ID");
//
//                LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
//
//                LZ_DBCallDetailID = state.getString("GZ_DBCallDetailID");
                
                BA_SUBSCRIBER_ID = state.optString("BA_SUBSCRIBER_ID","");

                LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");

                LZ_DBCallDetailID = state.optString("GZ_DBCallDetailID","");                

                // Logged the HostEAIRechargeAccValidator Request
//                Logger.info(LZ_DBCallDetailID," HostEAIRechargeAccValidator Request BA_SUBSCRIBER_ID : " + BA_SUBSCRIBER_ID 
//                    + " LZ_DBCallDetailID : " + LZ_DBCallDetailID, false);

                // Send the request to Tatasky
                SubscriberValidationResponse objDataService = new SubscriberValidation().requestSubscriberValidation(BA_SUBSCRIBER_ID, LZ_DBCallDetailID);

                // Response from Tatasky 
                BA_SUBSCRIBER_ID = objDataService.getSubscriberId();

                BA_ACCOUNT_TYPE = objDataService.getAccountType();

                BA_ACCOUNT_SUBTYPE = objDataService.getAccountSubType();

                BA_ACCOUNT_STATUS = objDataService.getAccountStatus();

                BA_CURRENT_BAL = objDataService.getCurrentBalance();

                BA_PREFERRED_LANGUAGE = objDataService.getPreferredLanguage();

                LZ_TSTxnID = objDataService.getTataskyTransId();

                LZ_errorcode = objDataService.getErrorCode();

                LZ_errorMsg = objDataService.getErrorMessage();

                LZ_SUBIDValidResponse = objDataService.getResponseXml();

                LZ_ResponseXML = objDataService.getResponseXml();

                LZ_TransEndTime = Util.getCurrentDateTime();
            }

        } catch (Exception ex) {

            Logger.error(LZ_DBCallDetailID, " Exception in HostEAIRechargeAccValidator Page : " + ex.getMessage(), false);

        } finally {

            try {

                LZ_PromptName = new ErrorHandler().portal(LZ_errorcode);

                String msgTokens[] = LZ_PromptName.split(",");

                LZ_PromptName = msgTokens[0].trim();

                LZ_errorMsg = msgTokens[1].trim();

                msgTokens = null;

                // Insert Transcation Details          
                LZ_RequestXML = new SubscriberValidation().subscriberValidation(BA_SUBSCRIBER_ID);

                LZ_RequestXML = LZ_RequestXML.replace("<?xml version=\"1.0\" encoding=\"UTF-8\"?>", "");

                LZ_ResponseXML = LZ_ResponseXML.replace("<?xml version=\"1.0\" encoding=\"UTF-8\"?>", "");

                String transDetailXml = new GenerateXml().requestTranscationDetail(LZ_DBCallDetailID, LZ_ServiceID, LZ_TransStartTime,
                        LZ_TransEndTime, LZ_errorcode, LZ_errorMsg, LZ_RequestXML, LZ_ResponseXML);

                LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</PGTRANSACTIONROOT>", "<FLDTATASKYTXNID>" + LZ_TSTxnID + "</FLDTATASKYTXNID><FLDTATASKYTXNSTATUS>" + LZ_errorcode + "</FLDTATASKYTXNSTATUS></PGTRANSACTIONROOT>");

                if (!("7220.wav").equalsIgnoreCase(LZ_PromptName)) {

                    LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</CTIROOT>", "<CTITRANSACTIONALERT>" + LZ_errorMsg + "</CTITRANSACTIONALERT></CTIROOT>");

                    LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</ROOT>", "<ERROR_ROOT><ERRORCFID>953</ERRORCFID><ERRORPROMPT>" + LZ_PromptName + "</ERRORPROMPT></ERROR_ROOT></ROOT>");
                }

                LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</TRANSACTIONROOT>", transDetailXml);

                transDetailXml = null;

            } catch (Exception ex1) {
		
		LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</CTIROOT>", "<CTITRANSACTIONALERT>" + LZ_errorMsg + "</CTITRANSACTIONALERT></CTIROOT>");

                Logger.error(LZ_DBCallDetailID, " Exception in Host EAI Recharge AccValidator Finally Block Page : " + ex1.getMessage(), false);

            }finally {

            LZ_TransEndTime = LZ_TransStartTime = LZ_ServiceID = LZ_DBCallDetailID = LZ_ResponseXML = LZ_RequestXML = null;
       
                   }
              }

        JSONObject result = new JSONObject();

        result.put("BA_SUBSCRIBER_ID", BA_SUBSCRIBER_ID);

        result.put("BA_ACCOUNT_TYPE", BA_ACCOUNT_TYPE);

        result.put("BA_ACCOUNT_SUBTYPE", BA_ACCOUNT_SUBTYPE);

        result.put("BA_ACCOUNT_STATUS", BA_ACCOUNT_STATUS);

        result.put("BA_CURRENT_BAL", BA_CURRENT_BAL);

        result.put("BA_PREFERRED_LANGUAGE", BA_PREFERRED_LANGUAGE);

        result.put("LZ_TSTxnID", LZ_TSTxnID);

        result.put("LZ_errorcode", LZ_errorcode);

        result.put("LZ_errorMsg", LZ_errorMsg);

        result.put("LZ_SUBIDValidResponse", LZ_SUBIDValidResponse);

        result.put("LZ_PromptName", LZ_PromptName);

        result.put("CallFlowDetailXML", LZ_CallFlowDetailXML);

        // Logged the HostEAIRechargeAccValidator Reponse
//        Logger.info(LZ_DBCallDetailID," HostEAIRechargeAccValidator Reponse BA_SUBSCRIBER_ID : " + BA_SUBSCRIBER_ID 
//            + " BA_ACCOUNT_TYPE : "  + BA_ACCOUNT_TYPE + " BA_ACCOUNT_SUBTYPE : " + BA_ACCOUNT_SUBTYPE
//            + " BA_ACCOUNT_STATUS : " + BA_ACCOUNT_STATUS + " BA_CURRENT_BAL : " + BA_CURRENT_BAL 
//            + " BA_CURRENT_BAL : " + BA_CURRENT_BAL + " BA_PREFERRED_LANGUAGE : " + BA_PREFERRED_LANGUAGE
//            + " LZ_TSTxnID : " + LZ_TSTxnID + " LZ_errorcode : " + LZ_errorcode + " LZ_errorMsg : " + LZ_errorMsg
//            + " LZ_SUBIDValidResponse : " + LZ_SUBIDValidResponse + " LZ_PromptName : " + LZ_PromptName, false);

        return result;

    }

    ;
%>
<%-- GENERATED: DO NOT REMOVE --%> 
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONException"%>
<%@page import="java.util.Map"%>
<%@include file="../backend.jspf" %>
