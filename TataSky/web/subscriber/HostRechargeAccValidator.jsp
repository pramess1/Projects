<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>

<%@page import="java.util.Date"%>
<%@page import="com.tsg.error.ErrorHandler"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.tsg.requesthandler.requestDelegator"%>
<%@page import="com.tatasky.portal.SubscriberValidationResponse"%>
<%@page import="com.tatasky.portal.SubscriberValidation"%>
<%@page import="org.apache.log4j.Logger"%>

<%!   
    static Logger log = Logger.getLogger(HostRechargeAccValidator_jsp.class);
    private boolean b_SimulatorMode = false; // Simulator Mode by default is set to true.


    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {
    
        //Input variables
        String BA_SUBSCRIBER_ID="";
        //Output variables
        String BA_ACCOUNT_TYPE="";
        String BA_ACCOUNT_SUBTYPE="";
        String BA_ACCOUNT_STATUS="";
        String BA_CURRENT_BAL="";
        String BA_PREFERRED_LANGUAGE="";
        String LZ_TSTxnID="";
        String LZ_errorcode="";
        String LZ_errorMsg="";
        String LZ_PromptName="";
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
                BA_SUBSCRIBER_ID = state.optString("BA_SUBSCRIBER_ID","");                
                log.info("HostRechargeAccValidator_jsp SUBSCRIBER_ID="+BA_SUBSCRIBER_ID);
                
                // Send the request to Tatasky
                SubscriberValidationResponse objDataService = new SubscriberValidation().requestSubscriberValidation
                        (BA_SUBSCRIBER_ID);
                
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
                LZ_PromptName =  new ErrorHandler().SubscriberValidation(LZ_errorcode);
                System.out.println("HostRechargeAccValidator_jsp output Subscriber Id " +  BA_SUBSCRIBER_ID 
                + " Account Type " + BA_ACCOUNT_TYPE + " Account Subtype " + BA_ACCOUNT_SUBTYPE
                + " Account Status " + ACCOUNT_STATUS + " Current Balance " + BA_CURRENT_BAL
                + " Preferred Language " + BA_PREFERRED_LANGUAGE + " Transcation Id " + LZ_TSTxnID
                + " Error Code " + Error Message + " LZ_errorMsg " + LZ_errorMsg);
        
                log.info("HostRechargeAccValidator_jsp output Subscriber Id " +  BA_SUBSCRIBER_ID 
                + " Account Type " + BA_ACCOUNT_TYPE + " Account Subtype " + BA_ACCOUNT_SUBTYPE
                + " Account Status " + ACCOUNT_STATUS + " Current Balance " + BA_CURRENT_BAL
                + " Preferred Language " + BA_PREFERRED_LANGUAGE + " Transcation Id " + LZ_TSTxnID
                + " Error Code " + Error Message + " LZ_errorMsg " + LZ_errorMsg);
                
            }
            
        } catch (Exception ex) {
            System.out.println(" Exception in HostRechargeAccValidator_jsp" + ex.getMessage());
            log.info(" Exception in HostRechargeAccValidator_jsp" + ex.getMessage());
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
        result.put("LZ_PromptName",LZ_PromptName);
        return result;

    };
%>
<%-- GENERATED: DO NOT REMOVE --%> 
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONException"%>
<%@page import="java.util.Map"%>
<%@include file="../backend.jspf" %>
