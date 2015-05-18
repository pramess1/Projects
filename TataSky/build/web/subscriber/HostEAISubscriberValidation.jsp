<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>

<%@page import="com.tsg.error.ErrorHandler"%>
<%@page import="com.tsg.util.Util"%>
<%@page import="com.tsg.requesthandler.requestDelegator"%>
<%@page import="com.tsg.eai.SubscriberValidation"%>
<%@page import="com.tsg.eai.SubscriberValidationResponse"%>
<%@page import="com.tsg.xml.GenerateXml"%>
<%@page import="com.tsg.log.Logger"%>
<%!

public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {
    
boolean b_SimulatorMode = false; // Simulator Mode by default is set to true.  
// Input varibales
String LZ_ivrid="";

String BA_SUBSCRIBER_ID="";

String LZ_Phone_No="";

String BA_SELECTED_LANGUAGE="";

String LZ_DateTime="";

String LZ_RequestType="";

// output varibales
String LZ_Sub_Status="";

String LZ_Status="";

String LZ_errorcode="404";

String LZ_PromptName="";

String LZ_errorMsg="";

//Transcation Details
//String LZ_TransDetailId="";

String LZ_CallFlowDetailXML="";

String LZ_RequestXML="";

String LZ_ResponseXML="";

String LZ_DBCallDetailID="";

String LZ_ServiceID="SPU";

String LZ_TransStartTime = Util.getCurrentDateTime();

String LZ_TransEndTime = "";

        try {
                if(b_SimulatorMode){
                //  Test method
                             
                } else {
                    // Realtime scenario
//                    LZ_ivrid = state.getString("LZ_ivrid");
//
//                    BA_SUBSCRIBER_ID = state.getString("BA_SUBSCRIBER_ID");
//
//                    LZ_Phone_No = state.getString("LZ_Phone_No");
//			
//                    BA_SELECTED_LANGUAGE = state.getString("BA_SELECTED_LANGUAGE");
//
//                    LZ_RequestType = state.getString("LZ_RequestType");
//
//                    LZ_DateTime=Util.getCurrentDateAnyFormat("dd/MM/yyyy hh:mm:ss");
//
//                    LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
//
//                    LZ_DBCallDetailID = state.getString("LZ_DBCallDetailID");
                    
                    LZ_ivrid = state.optString("LZ_ivrid","");

                    BA_SUBSCRIBER_ID = state.optString("BA_SUBSCRIBER_ID","");

                    LZ_Phone_No = state.optString("LZ_Phone_No","");

		      BA_SELECTED_LANGUAGE = state.optString("BA_SELECTED_LANGUAGE","");

                    LZ_RequestType = state.optString("LZ_RequestType","");

                    LZ_DateTime=Util.getCurrentDateAnyFormat("dd/MM/yyyy hh:mm:ss");

                    LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");

                    LZ_DBCallDetailID = state.optString("LZ_DBCallDetailID","");                    

                    // Logged the HostEAISubscriberValidation Request
                    /*Logger.info(LZ_DBCallDetailID, "HostEAISubscriberValidation Request  LZ_ivrid : " + LZ_ivrid 
                       + " BA_SUBSCRIBER_ID : " + BA_SUBSCRIBER_ID + " LZ_Phone_No : " + LZ_Phone_No + " BA_SELECTED_LANGUAGE : " + BA_SELECTED_LANGUAGE
                       + " LZ_RequestType : " + LZ_RequestType + " LZ_DateTime : " + LZ_DateTime
                       + " LZ_DBCallDetailID : " + LZ_DBCallDetailID, false);*/

                    // Subscriber Validation Request to TATASKY          
                    SubscriberValidationResponse objDataService = new SubscriberValidation().requestSubscriberValidation(LZ_ivrid,
                            BA_SUBSCRIBER_ID, LZ_Phone_No, BA_SELECTED_LANGUAGE, LZ_RequestType, LZ_DateTime, LZ_DBCallDetailID);

                    // Subscriber Validation Response from TATASKY
                    LZ_ivrid=objDataService.getIvrId();

                    BA_SUBSCRIBER_ID=objDataService.getSubscriberNumber();

                    LZ_Sub_Status=objDataService.getSubStatus();

                    LZ_Status=objDataService.getStatus();

                    LZ_errorcode=objDataService.getErrorCode();

                    LZ_DateTime=objDataService.getDateTime();

                    LZ_ResponseXML = objDataService.getResponseXml();

                    LZ_TransEndTime = Util.getCurrentDateTime();
                
                }
                
        }catch (Exception ex){
            
               Logger.error(LZ_DBCallDetailID, " Exception in HostEAISubscriberValidation Page : " + ex.getMessage(), false);
               
        } finally {
            
            try {
                
                LZ_PromptName =  new ErrorHandler().SubscriberIDValidation(LZ_errorcode);
                
                String msgTokens[] = LZ_PromptName.split(",");
                
                LZ_PromptName=msgTokens[0].trim();
                
                LZ_errorMsg =msgTokens[1].trim();
                
                msgTokens=null; 
                
                // Insert Transcation Details          
                LZ_RequestXML = new SubscriberValidation().subscriberValidation(LZ_ivrid,
                               BA_SUBSCRIBER_ID, LZ_Phone_No, BA_SELECTED_LANGUAGE, LZ_RequestType, LZ_DateTime);
                
                LZ_RequestXML = LZ_RequestXML.replace("<?xml version=\"1.0\" encoding=\"UTF-8\"?>","");
               
                LZ_ResponseXML = LZ_ResponseXML.replace("<?xml version=\"1.0\" encoding=\"UTF-8\"?>","");
                
                String transDetailXml = new GenerateXml().requestTranscationDetail(LZ_DBCallDetailID, LZ_ServiceID, LZ_TransStartTime,
                   LZ_TransEndTime, LZ_errorcode, LZ_errorMsg, LZ_RequestXML, LZ_ResponseXML);
               
                if (!("7220.wav").equalsIgnoreCase(LZ_PromptName)) {
                    
                    LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</CTIROOT>","<CTITRANSACTIONALERT>"+LZ_errorMsg+"</CTITRANSACTIONALERT></CTIROOT>");
                    
                    LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</ROOT>", "<ERROR_ROOT><ERRORCFID>955</ERRORCFID><ERRORPROMPT>" + LZ_PromptName + "</ERRORPROMPT></ERROR_ROOT></ROOT>");
                
                }
                
                LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</TRANSACTIONROOT>", transDetailXml);
                
            }catch (Exception ex){
                
                Logger.error(LZ_DBCallDetailID, " Exception in HostEAISubscriberValidation Page : " + ex.getMessage(), false);
            } finally{
            
            LZ_ivrid = BA_SUBSCRIBER_ID = LZ_Phone_No = BA_SELECTED_LANGUAGE = LZ_DateTime = LZ_RequestType = LZ_Sub_Status = LZ_errorMsg = LZ_RequestXML = LZ_ResponseXML = LZ_DBCallDetailID = LZ_ServiceID = LZ_TransStartTime = LZ_TransEndTime = null;
              } 
           } 
                
    JSONObject result = new JSONObject();
    
    result.put("LZ_Status",LZ_Status);
    
    result.put("LZ_errorcode",LZ_errorcode);
    
    result.put("LZ_PromptName",LZ_PromptName);
    
    result.put("CallFlowDetailXML",LZ_CallFlowDetailXML);
    
    // Logged the HostEAISubscriberValidation Response
    /*Logger.info(LZ_DBCallDetailID, "HostEAISubscriberValidation Response  LZ_Status : " + LZ_Status 
       + " LZ_errorcode : " + LZ_errorcode + " LZ_PromptName : " + LZ_PromptName, false);*/
    
    return result;
    
};
%>
<%-- GENERATED: DO NOT REMOVE --%> 
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONException"%>
<%@page import="java.util.Map"%>
<%@include file="../backend.jspf" %>