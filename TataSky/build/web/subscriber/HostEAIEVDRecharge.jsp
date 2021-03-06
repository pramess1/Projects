<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>

<%@page import="com.tsg.util.Util"%>
<%@page import="com.tsg.error.ErrorHandler"%>
<%@page import="com.tsg.eai.EVDRecharge"%>
<%@page import="com.tsg.eai.EVDRechargeResponse"%>
<%@page import="com.tsg.xml.GenerateXml"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean b_SimulatorMode = true; // Simulator Mode by default is set to true.  
        //Input Varibales
        String BA_SUBSCRIBER_ID = "";

        String LZ_EVDPin = "";
        //String LZ_EVDPin = "2222";

        String LZ_EVDRechargevalue = "";

        String LZ_EVDSendDateTime = "";

        String LZ_EVDMobileNo = "";
        //String LZ_EVDMobileNo = "1111111111";

        //Output Variables
        String LZ_errorcode = "404";

        String LZ_PromptName = "";

        String LZ_errorMsg = "";

        String LZ_CallFlowDetailXML = "";

        String LZ_RequestXML = "";

        String LZ_ResponseXML = "";

        String LZ_DBCallDetailID = "";

        String LZ_ServiceID = "ERC";

        String LZ_TransStartTime = Util.getCurrentDateTime();

        String LZ_TransEndTime = "";

        try {

            if (b_SimulatorMode) {

                //  Test method
                LZ_errorcode = "00";

                LZ_errorMsg = "SUCCESS";

            } else {

                // Below data getting from IVR
//                BA_SUBSCRIBER_ID = state.getString("BA_SUBSCRIBER_ID");
//
//                LZ_EVDPin = state.getString("LZ_EVDPin");
//
//                LZ_EVDMobileNo = state.getString("LZ_EVDMobileNo");
//
//                LZ_EVDRechargevalue = state.getString("LZ_EVDRechargevalue");
//
//                LZ_EVDSendDateTime = Util.getCurrentDateTime();
//
//                LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
//
//                LZ_DBCallDetailID = state.getString("LZ_DBCallDetailID");
                
                BA_SUBSCRIBER_ID = state.optString("BA_SUBSCRIBER_ID","");

                LZ_EVDPin = state.optString("LZ_EVDPin","");

                LZ_EVDMobileNo = state.optString("LZ_EVDMobileNo","");

                LZ_EVDRechargevalue = state.optString("LZ_EVDRechargevalue","");

                LZ_EVDSendDateTime = Util.getCurrentDateTime();

                LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");

                LZ_DBCallDetailID = state.optString("LZ_DBCallDetailID","");                

                // Logged the HostEAIEVDRecharge Request
//                Logger.info(LZ_DBCallDetailID, "HostEAIEVDRecharge Request  BA_SUBSCRIBER_ID : " + BA_SUBSCRIBER_ID 
//                   + " LZ_EVDPin : " + LZ_EVDPin + " LZ_EVDMobileNo : " + LZ_EVDMobileNo + " LZ_EVDRechargevalue : " + LZ_EVDRechargevalue
//                   + " LZ_EVDSendDateTime : " + LZ_EVDSendDateTime + " LZ_DBCallDetailID : " + LZ_DBCallDetailID, false);

                // Send the request to Tatasky
                EVDRechargeResponse objDataService = new EVDRecharge().requestEVDRecharge(BA_SUBSCRIBER_ID, LZ_EVDMobileNo,
                        LZ_EVDPin, LZ_EVDRechargevalue, LZ_EVDSendDateTime, LZ_DBCallDetailID);

                // Response from Tatasky 
                LZ_errorcode = objDataService.getErrorCode();

                LZ_ResponseXML = objDataService.getResponseXml();

                LZ_TransEndTime = Util.getCurrentDateTime();
            }
        } catch (Exception ex) {

            Logger.error(LZ_DBCallDetailID, " Exception in HostEAIEVDRecharge Page : " + ex.getMessage(), false);

        } finally {

            try {

                LZ_PromptName = new ErrorHandler().PaymentReceiver(LZ_errorcode);

                String msgTokens[] = LZ_PromptName.split(",");

                LZ_PromptName = msgTokens[0].trim();

                LZ_errorMsg = msgTokens[1].trim();

                msgTokens = null;

                // Insert Transcation Details          
                LZ_RequestXML = new EVDRecharge().EVDRecharge(BA_SUBSCRIBER_ID, LZ_EVDMobileNo,
                        LZ_EVDPin, LZ_EVDRechargevalue, LZ_EVDSendDateTime);

                LZ_RequestXML = LZ_RequestXML.replace("<?xml version=\"1.0\" encoding=\"UTF-8\"?>", "");

                LZ_ResponseXML = LZ_ResponseXML.replace("<?xml version=\"1.0\" encoding=\"UTF-8\"?>", "");

                String transDetailXml = new GenerateXml().requestTranscationDetail(LZ_DBCallDetailID, LZ_ServiceID, LZ_TransStartTime,
                        LZ_TransEndTime, LZ_errorcode, LZ_errorMsg, LZ_RequestXML, LZ_ResponseXML);

                if (!("7220.wav").equalsIgnoreCase(LZ_PromptName)) {

                    LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</CTIROOT>", "<CTITRANSACTIONALERT>" + LZ_errorMsg + "</CTITRANSACTIONALERT></CTIROOT>");

                    LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</ROOT>", "<ERROR_ROOT><ERRORCFID>952</ERRORCFID><ERRORPROMPT>" + LZ_PromptName + "</ERRORPROMPT></ERROR_ROOT></ROOT>");
                }

                LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</TRANSACTIONROOT>", transDetailXml);
                
                transDetailXml = null; 

            } catch (Exception ex) {

                Logger.error(LZ_DBCallDetailID, " Exception in Host EAI EVD Recharge Finally Block Page : " + ex.getMessage(), false);
            }
            finally{
                
            BA_SUBSCRIBER_ID = LZ_EVDPin = LZ_EVDRechargevalue = LZ_EVDSendDateTime = LZ_EVDMobileNo = LZ_errorMsg = LZ_RequestXML = LZ_ResponseXML = LZ_DBCallDetailID = LZ_ServiceID = LZ_TransStartTime = LZ_TransEndTime = null;
                      }
        }

        JSONObject result = new JSONObject();

        result.put("LZ_errorcode", LZ_errorcode);

        result.put("LZ_PromptName", LZ_PromptName);

        result.put("CallFlowDetailXML", LZ_CallFlowDetailXML);

        // Logged the HostEAIEVDRecharge Response
//    Logger.info(LZ_DBCallDetailID, "HostEAIEVDRecharge Response  LZ_errorcode : " + LZ_errorcode 
//       + " LZ_PromptName : " + LZ_PromptName, false);

        return result;

    }

    ;
%>
<%-- GENERATED: DO NOT REMOVE --%> 
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONException"%>
<%@page import="java.util.Map"%>
<%@include file="../backend.jspf" %>