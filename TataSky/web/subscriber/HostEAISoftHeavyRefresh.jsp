<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>

<%@page import="com.tsg.error.ErrorHandler"%>
<%@page import="com.tsg.util.Util"%>
<%@page import="com.tsg.requesthandler.requestDelegator"%>
<%@page import="com.tsg.eai.SoftHeavyRefresh"%>
<%@page import="com.tsg.eai.SoftHeavyRefreshResponse"%>
<%@page import="com.tsg.xml.GenerateXml"%>
<%@page import="com.tsg.log.Logger"%>

<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean b_SimulatorMode = false; // Simulator Mode by default is set to true.
        //Input variables
        String LZ_IvrId = "";

        String BA_SUBSCRIBER_ID = "";

        String LZ_requestType = "";

        String LZ_DateTime = "";

        //Output variables
        String LZ_Status = "";

        String LZ_errorcode = "404";

        String LZ_errorMsg = "";

        String LZ_PromptName = "";

        String LZ_CallFlowDetailXML = "";

        String LZ_RequestXML = "";

        String LZ_ResponseXML = "";

        String LZ_DBCallDetailID = "";

        String LZ_ServiceID = "SOHER";

        String LZ_TransStartTime = Util.getCurrentDateTime();

        String LZ_TransEndTime = "";

        try {
            if (b_SimulatorMode) {
                //  Test method
            } else {
                // Realtime scenario
//                LZ_IvrId = state.getString("LZ_IvrId");
//
//                BA_SUBSCRIBER_ID = state.getString("BA_SUBSCRIBER_ID");
//
//                LZ_requestType = state.getString("LZ_requestType");
                
                LZ_IvrId = state.optString("LZ_IvrId","");

                BA_SUBSCRIBER_ID = state.optString("BA_SUBSCRIBER_ID","");

                LZ_requestType = state.optString("LZ_requestType","");                

                if (LZ_requestType.equalsIgnoreCase("SoftRefresh")) {

                    LZ_ServiceID = "SRH";

                } else {

                    LZ_ServiceID = "HRH";

                }

                LZ_DateTime = Util.getCurrentDateAnyFormat("dd/MM/yyyy hh:mm:ss");

//                LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
//
//                LZ_DBCallDetailID = state.getString("LZ_DBCallDetailID");
                
                LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");

                LZ_DBCallDetailID = state.optString("LZ_DBCallDetailID","");
                               
                // Logged the HostEAISoftHeavyRefresh Request
//                Logger.info(LZ_DBCallDetailID, "HostEAISoftHeavyRefresh Request  LZ_IvrId : " + LZ_IvrId 
//                   + " BA_SUBSCRIBER_ID : " + BA_SUBSCRIBER_ID + " LZ_requestType : " + LZ_requestType + " LZ_DateTime : " + LZ_DateTime
//                   + " LZ_DBCallDetailID : " + LZ_DBCallDetailID, false);

                // Send the request to Tatasky
                SoftHeavyRefreshResponse objDataService = new SoftHeavyRefresh().requestSoftHeavyRefresh(LZ_IvrId,
                        BA_SUBSCRIBER_ID, LZ_requestType, LZ_DateTime, LZ_DBCallDetailID);
                // Response from Tatasky 
                LZ_IvrId = objDataService.getIvrId();

                BA_SUBSCRIBER_ID = objDataService.getSubscriberNumber();

                LZ_Status = objDataService.getStatusOfSCMS();

                LZ_errorcode = objDataService.getErrorCode();

                LZ_errorMsg = objDataService.getDescription();

                LZ_DateTime = objDataService.getSentDateTime();

                LZ_ResponseXML = objDataService.getResponseXml();

                LZ_TransEndTime = Util.getCurrentDateTime();
            }
        } catch (Exception ex) {

            Logger.error(LZ_DBCallDetailID, " Exception in Host EAI Soft Heavy Refresh Page : " + ex.getMessage(), false);

        } finally {

            try {
                LZ_PromptName = new ErrorHandler().SoftHeavyRefresh(LZ_errorcode);

                String msgTokens[] = LZ_PromptName.split(",");

                LZ_PromptName = msgTokens[0].trim();

                LZ_errorMsg = msgTokens[1].trim();

                msgTokens = null;

                // Insert Transcation Details          
                LZ_RequestXML = new SoftHeavyRefresh().softHeavyRefresh(LZ_IvrId,
                        BA_SUBSCRIBER_ID, LZ_requestType, LZ_DateTime);

                LZ_RequestXML = LZ_RequestXML.replace("<?xml version=\"1.0\" encoding=\"UTF-8\"?>", "");

                LZ_ResponseXML = LZ_ResponseXML.replace("<?xml version=\"1.0\" encoding=\"UTF-8\"?>", "");

                String transDetailXml = new GenerateXml().requestTranscationDetail(LZ_DBCallDetailID, LZ_ServiceID, LZ_TransStartTime,
                        LZ_TransEndTime, LZ_errorcode, LZ_errorMsg, LZ_RequestXML, LZ_ResponseXML);

                //LZ_TransDetailId = new InsertTransactionDetailDAO().insertTransactionDetail(transDetailXml);
                if (!("7220.wav").equalsIgnoreCase(LZ_PromptName)) {

                    LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</CTIROOT>", "<CTITRANSACTIONALERT>" + LZ_errorMsg + "</CTITRANSACTIONALERT></CTIROOT>");

                    LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</ROOT>", "<ERROR_ROOT><ERRORCFID>954</ERRORCFID><ERRORPROMPT>" + LZ_PromptName + "</ERRORPROMPT></ERROR_ROOT></ROOT>");
                }

                LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</TRANSACTIONROOT>", transDetailXml);
                
                transDetailXml = null; 

            } catch (Exception ex1) {

                Logger.error(LZ_DBCallDetailID, " Exception in Host EAI Soft Heavy Refresh Finally Block Page : " + ex1.getMessage(), false);

            } finally{

            LZ_IvrId = BA_SUBSCRIBER_ID = LZ_requestType = LZ_DateTime = LZ_errorcode = LZ_errorMsg = LZ_RequestXML = LZ_ResponseXML = LZ_DBCallDetailID = LZ_ServiceID = LZ_TransStartTime = LZ_TransEndTime = null;

              }      
        }

        JSONObject result = new JSONObject();

        result.put("EAIStatus", LZ_Status);

        result.put("LZ_PromptName", LZ_PromptName);

        result.put("CallFlowDetailXML", LZ_CallFlowDetailXML);

        // Logged the HostEAISoftHeavyRefresh Response
//    Logger.info(LZ_DBCallDetailID, "HostEAISoftHeavyRefresh Response  LZ_Status : " + LZ_Status 
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