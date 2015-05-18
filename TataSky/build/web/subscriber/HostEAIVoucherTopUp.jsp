<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>


<%@page import="com.tsg.error.ErrorHandler"%>
<%@page import="com.tsg.util.Util"%>
<%@page import="com.tsg.requesthandler.requestDelegator"%>
<%@page import="com.tsg.eai.VoucherTopUpResponse"%>
<%@page import="com.tsg.eai.VoucherTopUp"%>
<%@page import="com.tsg.xml.GenerateXml"%>
<%@page import="com.tsg.log.Logger"%>

<%!//static Logger log = Logger.getLogger(HostEAIVoucherTopUp_jsp.class);
    private boolean b_SimulatorMode = false; // Simulator Mode by default is set to true.

    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

//Input variables
        String LZ_ivrid = "";

        String BA_SUBSCRIBER_ID = "";

        String LZ_voucherpin = "";

        String LZ_datetime = "";

//Output variables
        String LZ_status = "";

        String LZ_rechargevalue = "";

        String LZ_newbal = "";

        String LZ_errorcode = "404";

        String LZ_PromptName = "";

        String LZ_errorMsg = "";

        String LZ_CallFlowDetailXML = "";

        String LZ_RequestXML = "";

        String LZ_ResponseXML = "";

        String LZ_DBCallDetailID = "";

        String LZ_ServiceID = "VTU";

        String LZ_TransStartTime = Util.getCurrentDateTime();

        String LZ_TransEndTime = "";

        try {
            if (b_SimulatorMode) {
            } else {
                // Realtime scenario
//                LZ_ivrid = state.getString("LZ_ivrid");
//
//                BA_SUBSCRIBER_ID = state.getString("BA_SUBSCRIBER_ID");
//
//                LZ_voucherpin = state.getString("LZ_voucherpin");
//
//                LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
//
//                LZ_DBCallDetailID = state.getString("GZ_DBCallDetailID");
                
                LZ_ivrid = state.optString("LZ_ivrid","");

                BA_SUBSCRIBER_ID = state.optString("BA_SUBSCRIBER_ID","");

                LZ_voucherpin = state.optString("LZ_voucherpin","");

                LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");

                LZ_DBCallDetailID = state.optString("GZ_DBCallDetailID","");                

                // Logged the HostEAIVoucherTopUp Request
//                Logger.info(LZ_DBCallDetailID, "HostEAIVoucherTopUp Request  LZ_ivrid : " + LZ_ivrid 
//                   + " BA_SUBSCRIBER_ID : " + BA_SUBSCRIBER_ID + " LZ_voucherpin : " + LZ_voucherpin 
//                   + " LZ_DBCallDetailID : " + LZ_DBCallDetailID, false);

                // Send the request to Tatasky               
                VoucherTopUpResponse objDataService = new VoucherTopUp().requestVoucherTopUp(LZ_ivrid,
                        BA_SUBSCRIBER_ID, LZ_voucherpin, Util.getCurrentDateAnyFormat("dd/MM/yyyy hh:mm:ss"), LZ_DBCallDetailID);

                // Response from Tatasky 
                LZ_ivrid = objDataService.getIvrId();

                LZ_status = objDataService.getStatus();

                LZ_rechargevalue = objDataService.getRechargeValue();

                if (LZ_rechargevalue != null) {

                    LZ_rechargevalue = (LZ_rechargevalue.contains(".")) ? LZ_rechargevalue : LZ_rechargevalue + ".00";

                }

                LZ_newbal = objDataService.getNewBalance();

                if (LZ_newbal != null) {

                    LZ_newbal = (LZ_newbal.contains(".")) ? LZ_newbal : LZ_newbal + ".00";

                }

                LZ_errorcode = objDataService.getErrorCode();

                LZ_ResponseXML = objDataService.getResponseXml();

                LZ_TransEndTime = Util.getCurrentDateTime();
            }

        } catch (Exception ex) {

            Logger.error(LZ_DBCallDetailID, " Exception in HostEAIVoucherTopUp " + ex.getMessage(), false);

        } finally {

            try {

                LZ_PromptName = new ErrorHandler().VoucherTopUp(LZ_errorcode);

                String msgTokens[] = LZ_PromptName.split(",");

                LZ_PromptName = msgTokens[0].trim();

                LZ_errorMsg = msgTokens[1].trim();

                msgTokens = null;

                // Insert Transcation Details          
                LZ_RequestXML = new VoucherTopUp().voucherTopUp(LZ_ivrid, BA_SUBSCRIBER_ID, LZ_voucherpin, Util.getCurrentDateTime());

                LZ_RequestXML = LZ_RequestXML.replace("<?xml version=\"1.0\" encoding=\"UTF-8\"?>", "");

                LZ_ResponseXML = LZ_ResponseXML.replace("<?xml version=\"1.0\" encoding=\"UTF-8\"?>", "");

                String transDetailXml = new GenerateXml().requestTranscationDetail(LZ_DBCallDetailID, LZ_ServiceID, LZ_TransStartTime,
                        LZ_TransEndTime, LZ_errorcode, LZ_errorMsg, LZ_RequestXML, LZ_ResponseXML);

                //LZ_TransDetailId = new InsertTransactionDetailDAO().insertTransactionDetail(transDetailXml);

                if (!("7220.wav").equalsIgnoreCase(LZ_PromptName)) {

                    LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</CTIROOT>", "<CTITRANSACTIONALERT>" + LZ_errorMsg + "</CTITRANSACTIONALERT></CTIROOT>");

                    LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</ROOT>", "<ERROR_ROOT><ERRORCFID>956</ERRORCFID><ERRORPROMPT>" + LZ_PromptName + "</ERRORPROMPT></ERROR_ROOT></ROOT>");
                }

                LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</TRANSACTIONROOT>", transDetailXml);

            } catch (Exception ex1) {
		LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</CTIROOT>", "<CTITRANSACTIONALERT>" + LZ_errorMsg + "</CTITRANSACTIONALERT></CTIROOT>");

                Logger.error(LZ_DBCallDetailID, " Exception in HostEAIVoucherTopUp Finally Block Page :" + ex1.getMessage(), false);

            }finally{

            BA_SUBSCRIBER_ID = LZ_voucherpin = LZ_datetime = LZ_errorMsg = LZ_RequestXML = LZ_ResponseXML = LZ_DBCallDetailID = LZ_ServiceID = LZ_TransStartTime = LZ_TransEndTime = null;
               } 
        }
        JSONObject result = new JSONObject();

        result.put("LZ_ivrid", LZ_ivrid);

        result.put("LZ_status", LZ_status);

        result.put("LZ_rechargevalue", LZ_rechargevalue);

        result.put("LZ_newbal", LZ_newbal);

        result.put("LZ_errorcode", LZ_errorcode);

        result.put("LZ_PromptName", LZ_PromptName);

        result.put("CallFlowDetailXML", LZ_CallFlowDetailXML);

        // Logged the HostEAIVoucherTopUp Response
//        Logger.info(LZ_DBCallDetailID, "HostEAIVoucherTopUp Response  LZ_ivrid : " + LZ_ivrid 
//           + " LZ_status : " + LZ_status + " LZ_rechargevalue : " + LZ_rechargevalue 
//           + " LZ_newbal : " + LZ_newbal + " LZ_errorcode : " + LZ_errorcode 
//           + " LZ_PromptName : " + LZ_PromptName, false);

        return result;

    }

    ;
%>
<%-- GENERATED: DO NOT REMOVE --%> 
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONException"%>
<%@page import="java.util.Map"%>
<%@include file="../backend.jspf" %>
