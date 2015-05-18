<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>

<%@page import="com.tsg.util.Util"%>
<%@page import="com.tsg.error.ErrorHandler"%>
<%@page import="com.tsg.requesthandler.requestDelegator"%>
<%@page import="com.tsg.eai.AccountBalanceResponse"%>
<%@page import="com.tsg.eai.AccountBalance"%>
<%@page import="com.tsg.xml.GenerateXml"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean b_SimulatorMode = false; // Simulator Mode by default is set to true. 
// Input varibales
        String LZ_ivrid = "";

        String BA_SUBSCRIBER_ID = "";

        String LZ_sentdatetime = "";

// output varibales
        String LZ_bal = "";

        String LZ_duedate = "";

        String LZ_errorcode = "404";

        String LZ_receiveddatetime = "";

        String LZ_PromptName = "";

        String LZ_errorMsg = "";

//Transcation Details
//String LZ_TransDetailId="";

        String LZ_CallFlowDetailXML = "";

        String LZ_RequestXML = "";

        String LZ_ResponseXML = "";

        String LZ_DBCallDetailID = "";

        String LZ_ServiceID = "ABL";

        String LZ_TransStartTime = Util.getCurrentDateTime();

        String LZ_TransEndTime = "";

        try {
            if (b_SimulatorMode) {
                //  Test method
                LZ_ivrid = "AV87";

                LZ_bal = "1300";

                LZ_duedate = "20/09/2013";

                LZ_errorcode = "300";

                LZ_receiveddatetime = "05/29/2013 05:40:09";

            } else {
                // Realtime scenario
                LZ_ivrid = state.getString("LZ_ivrid");

                BA_SUBSCRIBER_ID = state.getString("BA_SUBSCRIBER_ID");

                LZ_sentdatetime = Util.getCurrentDateAnyFormat("dd/MM/yyyy hh:mm:ss");

                LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");

                LZ_DBCallDetailID = state.getString("GZ_DBCallDetailID");

                // Logged the AccountBalanceQuery Request
//                     Logger.info(LZ_DBCallDetailID, "HostEAIAccountBalanceQuery Request  LZ_ivrid : " + LZ_ivrid 
//                        + " BA_SUBSCRIBER_ID : " + BA_SUBSCRIBER_ID + " LZ_sentdatetime : " + LZ_sentdatetime
//                        + " LZ_DBCallDetailID : " + LZ_DBCallDetailID, false);

                // Account Balance Request to TATASKY          
                AccountBalanceResponse objDataService = new AccountBalance().requestAccountBalance(LZ_ivrid,
                        BA_SUBSCRIBER_ID, LZ_sentdatetime, LZ_DBCallDetailID);

                // Account Balance Response from TATASKY
                LZ_ivrid = objDataService.getIvrId();

                LZ_bal = objDataService.getBalance();

                LZ_duedate = objDataService.getDueDateTime();

                LZ_duedate = Util.convertDateToAnyFormat(LZ_duedate);

                LZ_errorcode = objDataService.getErrorCode();

                LZ_receiveddatetime = objDataService.getReceivedDateTime();

                LZ_ResponseXML = objDataService.getResponseXml();

                LZ_TransEndTime = Util.getCurrentDateTime();

            }

        } catch (Exception ex) {

            Logger.error(LZ_DBCallDetailID, "Exception in HostEAIAccountBalanceQuery Page : " + ex.getMessage(), false);

        } finally {

            try {

                LZ_PromptName = new ErrorHandler().AccountBalnce(LZ_errorcode);

                String msgTokens[] = LZ_PromptName.split(",");

                LZ_PromptName = msgTokens[0].trim();

                LZ_errorMsg = msgTokens[1].trim();

                msgTokens = null;

                // Insert Transcation Details          
                LZ_RequestXML = new AccountBalance().accountBalance(LZ_ivrid, BA_SUBSCRIBER_ID, LZ_sentdatetime);

                LZ_RequestXML = LZ_RequestXML.replace("<?xml version=\"1.0\" encoding=\"UTF-8\"?>", "");

                LZ_ResponseXML = LZ_ResponseXML.replace("<?xml version=\"1.0\" encoding=\"UTF-8\"?>", "");

                String transDetailXml = new GenerateXml().requestTranscationDetail(LZ_DBCallDetailID, LZ_ServiceID, LZ_TransStartTime,
                        LZ_TransEndTime, LZ_errorcode, LZ_errorMsg, LZ_RequestXML, LZ_ResponseXML);

                if (!("7220.wav").equalsIgnoreCase(LZ_PromptName)) {

                    LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</CTIROOT>", "<CTITRANSACTIONALERT>" + LZ_errorMsg + "</CTITRANSACTIONALERT></CTIROOT>");

                    LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</ROOT>", "<ERROR_ROOT><ERRORCFID>950</ERRORCFID><ERRORPROMPT>" + LZ_PromptName + "</ERRORPROMPT></ERROR_ROOT></ROOT>");
                }

                LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</TRANSACTIONROOT>", transDetailXml);

            } catch (Exception ex) {

                Logger.error(LZ_DBCallDetailID, "Exception in Host EAI Account Balance Query Finally Block Page : " + ex.getMessage(), false);
            }finally{
            
             BA_SUBSCRIBER_ID = LZ_sentdatetime =LZ_errorMsg =LZ_RequestXML = LZ_ResponseXML =  LZ_DBCallDetailID =  LZ_ServiceID =LZ_TransStartTime =LZ_TransEndTime = null;
            }
        }

        JSONObject result = new JSONObject();

        result.put("LZ_ivrid", LZ_ivrid);

        result.put("LZ_bal", LZ_bal);

        result.put("LZ_duedate", LZ_duedate);

        result.put("LZ_errorcode", LZ_errorcode);

        result.put("LZ_receiveddatetime", LZ_receiveddatetime);

        result.put("LZ_PromptName", LZ_PromptName);

        result.put("CallFlowDetailXML", LZ_CallFlowDetailXML);

        // Logged the AccountBalanceQuery Response
//    Logger.info(LZ_DBCallDetailID, "HostEAIAccountBalanceQuery Response  LZ_ivrid : " + LZ_ivrid 
//        + " LZ_bal : " + LZ_bal + " LZ_duedate : " + LZ_duedate + " LZ_errorcode : " + LZ_errorcode
//        + " LZ_receiveddatetime : " + LZ_receiveddatetime + " LZ_PromptName : " +LZ_PromptName, false);

        return result;

    }

    ;
%>
<%-- GENERATED: DO NOT REMOVE --%> 
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONException"%>
<%@page import="java.util.Map"%>
<%@include file="../backend.jspf" %>