<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>

<%@page import="com.tsg.util.Util"%>
<%@page import="com.tsg.error.ErrorHandler"%>
<%@page import="com.tsg.requesthandler.requestDelegator"%>
<%@page import="com.tsg.eai.CreateRelocationWorkOrderResponse"%>
<%@page import="com.tsg.eai.CreateRelocationWorkOrder"%>
<%@page import="com.tsg.xml.GenerateXml"%>
<%@page import="com.tsg.log.Logger"%>

<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean b_SimulatorMode = false; // Simulator Mode by default is set to true.   
        //Input variables
        String LZ_ivrid = "";

        String BA_SUBSCRIBER_ID = "";

        String LZ_Type = "";

        String LZ_SubType = "";

        String LZ_Priority = "";

        String LZ_sentdatetime = "";

        //Output variables
        String LZ_errorcode = "404";

        String LZ_activity_Id = "";

        String LZ_errorMsg = "";

        String LZ_PromptName = "";

        String LZ_CallFlowDetailXML = "";

        String LZ_RequestXML = "";

        String LZ_ResponseXML = "";

        String LZ_DBCallDetailID = "";

        String LZ_ServiceID = "CRW";

        String LZ_TransStartTime = Util.getCurrentDateTime();

        String LZ_TransEndTime = "";

        try {
            if (b_SimulatorMode) {
                //  Test method
            } else {
                // Realtime scenario
//                LZ_ivrid = state.getString("LZ_ivrid");
//
//                BA_SUBSCRIBER_ID = state.getString("BA_SUBSCRIBER_ID");
//
//                LZ_Type = state.getString("LZ_Type");
//
//                LZ_Type = "Relocation";
//
//                LZ_SubType = state.getString("LZ_SubType");
//
//                LZ_SubType = "Relocate within same house";
//
//                LZ_Priority = state.getString("LZ_Priority");
//
//                LZ_sentdatetime = Util.getOneDaysAfter();
//
//                LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
//
//                LZ_DBCallDetailID = state.getString("LZ_DBCallDetailID");

                LZ_ivrid = state.optString("LZ_ivrid","");

                BA_SUBSCRIBER_ID = state.optString("BA_SUBSCRIBER_ID","");

                LZ_Type = state.optString("LZ_Type","");

                LZ_Type = "Relocation";

                LZ_SubType = state.optString("LZ_SubType","");

                LZ_SubType = "Relocate within same house";

                LZ_Priority = state.optString("LZ_Priority","");

                LZ_sentdatetime = Util.getOneDaysAfter();

                LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");

                LZ_DBCallDetailID = state.optString("LZ_DBCallDetailID","");                               

                // Logged the HostEAICreateRelocationWO Request
//                Logger.info(LZ_DBCallDetailID, "HostEAICreateRelocationWO Request  LZ_ivrid : " + LZ_ivrid 
//                   + " BA_SUBSCRIBER_ID : " + BA_SUBSCRIBER_ID + " LZ_Type : " + LZ_Type + " LZ_SubType : " + LZ_SubType
//                   + " LZ_Priority : " + LZ_Priority + " LZ_sentdatetime : " +LZ_sentdatetime
//                   + " LZ_DBCallDetailID : " + LZ_DBCallDetailID, false);

                //Send the request to Tatasky
                CreateRelocationWorkOrderResponse objDataService = new CreateRelocationWorkOrder().requestCreateRelocationWorkOrder(LZ_ivrid,
                        BA_SUBSCRIBER_ID, LZ_Type, LZ_SubType, LZ_sentdatetime, LZ_Priority, LZ_DBCallDetailID);

                //Response from Tatasky 
                LZ_ivrid = objDataService.getIvrId();

                BA_SUBSCRIBER_ID = objDataService.getSubscriberNumber();

                LZ_activity_Id = objDataService.getActivityId();
                // LZ_activity_Id = "5YU5G2";
                LZ_errorcode = objDataService.getErrorCode();

                LZ_errorMsg = objDataService.getErrorDescription();

                LZ_ResponseXML = objDataService.getResponseXml();

                LZ_TransEndTime = Util.getCurrentDateTime();

            }

        } catch (Exception ex) {

            Logger.error(LZ_DBCallDetailID, " Exception in HostEAICreateRelocationWO Page : " + ex.getMessage(), false);

        } finally {

            try {

                LZ_PromptName = new ErrorHandler().CreateRelocationWO(LZ_errorcode);

                String msgTokens[] = LZ_PromptName.split(",");

                LZ_PromptName = msgTokens[0].trim();

                LZ_errorMsg = msgTokens[1].trim();

                msgTokens = null;

                // Insert Transcation Details          
                LZ_RequestXML = new CreateRelocationWorkOrder().createRelocationWorkOrder(LZ_ivrid,
                        BA_SUBSCRIBER_ID, LZ_Type, LZ_SubType, LZ_sentdatetime, LZ_Priority);

                LZ_RequestXML = LZ_RequestXML.replace("<?xml version=\"1.0\" encoding=\"UTF-8\"?>", "");

                LZ_ResponseXML = LZ_ResponseXML.replace("<?xml version=\"1.0\" encoding=\"UTF-8\"?>", "");

                String transDetailXml = new GenerateXml().requestTranscationDetail(LZ_DBCallDetailID, LZ_ServiceID, LZ_TransStartTime,
                        LZ_TransEndTime, LZ_errorcode, LZ_errorMsg, LZ_RequestXML, LZ_ResponseXML);

                if (!("7220.wav").equalsIgnoreCase(LZ_PromptName)) {

                    LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</CTIROOT>", "<CTITRANSACTIONALERT>" + LZ_errorMsg + "</CTITRANSACTIONALERT></CTIROOT>");

                    LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</ROOT>", "<ERROR_ROOT><ERRORCFID>951</ERRORCFID><ERRORPROMPT>" + LZ_PromptName + "</ERRORPROMPT></ERROR_ROOT></ROOT>");
                }

                LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</TRANSACTIONROOT>", transDetailXml);

                transDetailXml = null;

            } catch (Exception ex) {

                Logger.error(LZ_DBCallDetailID, " Exception in HostEAICreateRelocationWO " + ex.getMessage(), false);
            } finally{
            
            LZ_Type = LZ_SubType = LZ_Priority = LZ_sentdatetime = LZ_RequestXML = LZ_ResponseXML = LZ_DBCallDetailID = LZ_ServiceID = LZ_TransStartTime = LZ_TransEndTime = null;
                      }
           }

        JSONObject result = new JSONObject();

        result.put("LZ_ivrid", LZ_ivrid);

        result.put("BA_SUBSCRIBER_ID", BA_SUBSCRIBER_ID);

        result.put("LZ_activity_Id", LZ_activity_Id);

        result.put("LZ_errorcode", LZ_errorcode);

        result.put("LZ_errorMsg", LZ_errorMsg);

        result.put("LZ_PromptName", LZ_PromptName);

        result.put("CallFlowDetailXML", LZ_CallFlowDetailXML);

        // Logged the HostEAICreateRelocationWO Response
//    Logger.info(LZ_DBCallDetailID, "HostEAICreateRelocationWO Response  LZ_ivrid : " + LZ_ivrid 
//       + " BA_SUBSCRIBER_ID : " + BA_SUBSCRIBER_ID + " LZ_activity_Id : " + LZ_activity_Id + " LZ_errorcode : " + LZ_errorcode
//       + " LZ_errorMsg : " + LZ_errorMsg + " LZ_PromptName : " + LZ_PromptName, false);

        return result;
    }

    ;
%>
<%-- GENERATED: DO NOT REMOVE --%> 
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONException"%>
<%@page import="java.util.Map"%>
<%@include file="../backend.jspf" %>
