<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>

<%@page import="com.tsg.util.Util"%>
<%@page import="com.tsg.error.ErrorHandler"%>
<%@page import="com.tsg.requesthandler.requestDelegator"%>
<%@page import="com.tsg.portal.PaymentReceiver"%>
<%@page import="com.tsg.portal.PaymentReceiverResponse"%>
<%@page import="com.tsg.xml.GenerateXml"%>
<%@page import="com.tsg.log.Logger"%>
<%@page import="com.tsg.common.ConfigurationReader"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean b_SimulatorMode = false; // Simulator Mode by default is set to true.

//Input Varibales
        String BA_SUBSCRIBER_ID = "";

        String LZ_TSTxnID = "";

        String LZ_AtomTxnID = "";

        String LZ_BankName = "";

        String LZ_GetAmount = "";

        String LZ_TxnDateTime = "";

        String LZ_RRN = "";

        String LZ_APGID = "";

        String LZ_errorcode = "404";

        String LZ_errorMsg = "";

        String LZ_CheckSum = "";

//Output Variables
        String LZ_CurrBal = "";

        String LZ_Amount = "";

        String LZ_BonusAmt = "";

        String LZ_TSReceipt = "";

        String LZ_SUBIDPostResponse = "";

        String LZ_PromptName = "";

        String LZ_CallFlowDetailXML = "";

        String LZ_RequestXML = "";

        String LZ_ResponseXML = "";

        String LZ_DBCallDetailID = "";

        String LZ_ServiceID = "ART";

        String LZ_TransStartTime = Util.getCurrentDateTime();

        String LZ_TransEndTime = "";

        try {

            if (b_SimulatorMode) {
                //  Test method
                LZ_errorcode = "00";
                LZ_errorMsg = "SUCCESS";
            } else {
//                // Below data getting from IVR
//                BA_SUBSCRIBER_ID = state.getString("BA_SUBSCRIBER_ID");
//
//                LZ_TSTxnID = state.getString("LZ_TSTxnID");
//
//                LZ_AtomTxnID = state.getString("LZ_AtomTxnID");
//
//                LZ_BankName = state.getString("LZ_BankName");
//
//                LZ_GetAmount = state.getString("LZ_GetAmount");
//
//                LZ_TxnDateTime = state.getString("LZ_TxnDateTime");
//
//                LZ_RRN = state.getString("LZ_RRN");
//
//                LZ_APGID = state.getString("LZ_APGID");
//
//                LZ_errorcode = state.getString("LZ_errorcode_pg");
//
//                LZ_errorMsg = state.getString("LZ_errorMsg_pg");

                // Below data getting from IVR
                BA_SUBSCRIBER_ID = state.optString("BA_SUBSCRIBER_ID","");

                LZ_TSTxnID = state.optString("LZ_TSTxnID","");

                LZ_AtomTxnID = state.optString("LZ_AtomTxnID","");

                LZ_BankName = state.optString("LZ_BankName","");

                LZ_GetAmount = state.optString("LZ_GetAmount","");

                LZ_TxnDateTime = state.optString("LZ_TxnDateTime","");

                LZ_RRN = state.optString("LZ_RRN","");

                LZ_APGID = state.optString("LZ_APGID","");

                LZ_errorcode = state.optString("LZ_errorcode_pg","");

                LZ_errorMsg = state.optString("LZ_errorMsg_pg","");                               

                if (LZ_errorMsg.equalsIgnoreCase("SUCCESS")) {

                    LZ_errorcode = "OK";
                }

//                LZ_CheckSum = state.getString("LZ_CheckSum");
//
//                LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
//
//                LZ_DBCallDetailID = state.getString("GZ_DBCallDetailID");

                LZ_CheckSum = state.optString("LZ_CheckSum","");

                LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");

                LZ_DBCallDetailID = state.optString("GZ_DBCallDetailID","");
                
                // Logged the HostPortalPaymentReceiver Request
//            Logger.info(LZ_DBCallDetailID, "HostPortalPaymentReceiver Request  BA_SUBSCRIBER_ID : " + BA_SUBSCRIBER_ID 
//               + " LZ_TSTxnID : " + LZ_TSTxnID + " LZ_AtomTxnID : " + LZ_AtomTxnID + " LZ_BankName : " + LZ_BankName
//               + " LZ_GetAmount : " + LZ_GetAmount + " LZ_TxnDateTime : " + LZ_TxnDateTime + " LZ_RRN : " + LZ_RRN
//               + " LZ_APGID : " + LZ_APGID + " LZ_errorcode : " + LZ_errorcode + " LZ_errorMsg : " + LZ_errorMsg
//               + " LZ_CheckSum : " + LZ_CheckSum + " LZ_DBCallDetailID : " + LZ_DBCallDetailID, false);

                // Send the request to Tatasky
                PaymentReceiverResponse objDataService = new PaymentReceiver().requestPaymentReceiver(BA_SUBSCRIBER_ID, LZ_TSTxnID, LZ_AtomTxnID, LZ_BankName,
                        LZ_GetAmount, LZ_TxnDateTime, LZ_APGID, LZ_RRN, LZ_errorcode, LZ_errorMsg, LZ_CheckSum, LZ_DBCallDetailID);

                // Response from Tatasky 
                BA_SUBSCRIBER_ID = objDataService.getSubscriberId();

                LZ_TSTxnID = objDataService.getTataskyTransId();

                LZ_AtomTxnID = objDataService.getAtomTransId();

                LZ_BankName = objDataService.getBankName();

                LZ_CurrBal = objDataService.getCurrentBalance();

                LZ_Amount = objDataService.getAmount();

                LZ_BonusAmt = objDataService.getBonus();

                LZ_TxnDateTime = objDataService.getDateTime();

                LZ_APGID = objDataService.getPgId();

                LZ_RRN = objDataService.getRrn();

                LZ_TSReceipt = objDataService.getTataskyReceipt();

                LZ_errorcode = objDataService.getErrorCode();

                LZ_errorMsg = objDataService.getErrorMessage();

                LZ_SUBIDPostResponse = objDataService.getResponseXml();

                LZ_ResponseXML = objDataService.getResponseXml();

                LZ_TransEndTime = Util.getCurrentDateTime();
            }

        } catch (Exception ex) {

            Logger.error(LZ_DBCallDetailID, " Exception in HostATOMPaymentReceiver Page : " + ex.getMessage(), false);

        } finally {

            try {

                LZ_PromptName = new ErrorHandler().portal(LZ_errorcode);

                String msgTokens[] = LZ_PromptName.split(",");

                LZ_PromptName = msgTokens[0].trim();

                LZ_errorMsg = msgTokens[1].trim();

                msgTokens = null;

                String checkSumValue = BA_SUBSCRIBER_ID + "~" + LZ_TSTxnID + "~" + LZ_AtomTxnID + "~" + LZ_BankName + "~" + LZ_GetAmount + "~" + LZ_TxnDateTime + "~" + LZ_APGID + "~" + LZ_RRN + "~" + LZ_errorcode + "~" + LZ_errorMsg + "~~~";

                String checkSumKey = ConfigurationReader.configList.get("checksumKey");

                LZ_CheckSum = Util.validateChecksum(checkSumValue, checkSumKey);

                // Insert Transcation Details          
                LZ_RequestXML = new PaymentReceiver().paymentReceiver(BA_SUBSCRIBER_ID, LZ_TSTxnID, LZ_AtomTxnID, LZ_BankName,
                        LZ_GetAmount, LZ_TxnDateTime, LZ_RRN, LZ_APGID, LZ_errorcode, LZ_errorMsg, LZ_CheckSum);

                LZ_RequestXML = LZ_RequestXML.replace("<?xml version=\"1.0\" encoding=\"UTF-8\"?>", "");

                LZ_ResponseXML = LZ_ResponseXML.replace("<?xml version=\"1.0\" encoding=\"UTF-8\"?>", "");

                LZ_RequestXML = LZ_RequestXML.replace("<XML>", "");

                LZ_RequestXML = LZ_RequestXML.replace("</XML>", "");

                LZ_ResponseXML = LZ_ResponseXML.replace("<XML>", "");

                LZ_ResponseXML = LZ_ResponseXML.replace("</XML>", "");

                String transDetailXml = new GenerateXml().requestTranscationDetail(LZ_DBCallDetailID, LZ_ServiceID, LZ_TransStartTime,
                        LZ_TransEndTime, LZ_errorcode, LZ_errorMsg, LZ_RequestXML, LZ_ResponseXML);

                //LZ_TransDetailId = new InsertTransactionDetailDAO().insertTransactionDetail(transDetailXml);
                if (!("7220.wav").equalsIgnoreCase(LZ_PromptName)) {

                    LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</CTIROOT>", "<CTITRANSACTIONALERT>" + LZ_errorMsg + "</CTITRANSACTIONALERT></CTIROOT>");

                    LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</ROOT>", "<ERROR_ROOT><ERRORCFID>958</ERRORCFID><ERRORPROMPT>" + LZ_PromptName + "</ERRORPROMPT></ERROR_ROOT></ROOT>");
                }

                LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</TRANSACTIONROOT>", transDetailXml);

                String pgTransDetailXml = new GenerateXml().requestUpdateRechargeDetails("", "", LZ_CurrBal, LZ_BonusAmt, LZ_Amount,
                        LZ_TSReceipt, LZ_CheckSum, LZ_TransEndTime, LZ_DBCallDetailID);

                LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</PGTRANSACTIONROOT>", pgTransDetailXml);
                
                pgTransDetailXml = transDetailXml = null; 

            } catch (Exception ex1) {

                Logger.error(LZ_DBCallDetailID, " Exception in Host ATOM Payment Receiver Finally Block Page : " + ex1.getMessage(), false);

            }finally{
            
            LZ_CheckSum = LZ_RequestXML = LZ_ResponseXML = LZ_DBCallDetailID = LZ_ServiceID = LZ_TransStartTime = LZ_TransEndTime = null;
          }
                       }

        JSONObject result = new JSONObject();

        result.put("BA_SUBSCRIBER_ID", BA_SUBSCRIBER_ID);

        result.put("LZ_TSTxnID", LZ_TSTxnID);

        result.put("LZ_AtomTxnID", LZ_AtomTxnID);

        result.put("LZ_BankName", LZ_BankName);

        result.put("LZ_CurrBal", LZ_CurrBal);

        result.put("LZ_Amount", LZ_Amount);

        result.put("LZ_BonusAmt", LZ_BonusAmt);

        result.put("LZ_TxnDateTime", LZ_TxnDateTime);

        result.put("LZ_RRN", LZ_RRN);

        result.put("LZ_APGID", LZ_APGID);

        result.put("LZ_TSReceipt", LZ_TSReceipt);

        result.put("LZ_errorcode", LZ_errorcode);

        result.put("LZ_errorMsg", LZ_errorMsg);

        result.put("LZ_SUBIDPostResponse", LZ_SUBIDPostResponse);

        result.put("LZ_PromptName", LZ_PromptName);

        result.put("CallFlowDetailXML", LZ_CallFlowDetailXML);

        // Logged the HostPortalPaymentReceiver Response
    /*Logger.info(LZ_DBCallDetailID, "HostPortalPaymentReceiver Response  BA_SUBSCRIBER_ID : " + BA_SUBSCRIBER_ID 
         + " LZ_TSTxnID : " + LZ_TSTxnID + " LZ_AtomTxnID : " + LZ_AtomTxnID + " LZ_BankName : " + LZ_BankName
         + " LZ_CurrBal : " + LZ_CurrBal + " LZ_Amount : " + LZ_Amount + " LZ_BonusAmt : " + LZ_BonusAmt
         + " LZ_TxnDateTime : " + LZ_TxnDateTime + " LZ_RRN : " + LZ_RRN + " LZ_APGID : " + LZ_APGID
         + " LZ_TSReceipt : " + LZ_TSReceipt + " LZ_errorcode : " + LZ_errorcode + " LZ_errorMsg : " + LZ_errorMsg
         + " LZ_SUBIDPostResponse : " + LZ_SUBIDPostResponse + " LZ_PromptName : " + LZ_PromptName, false);*/

        return result;

    };
%>
<%-- GENERATED: DO NOT REMOVE --%> 
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONException"%>
<%@page import="java.util.Map"%>
<%@include file="../backend.jspf" %>