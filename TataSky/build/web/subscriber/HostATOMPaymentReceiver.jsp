<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>

<%@page import="com.tsg.util.Util"%>
<%@page import="com.tsg.error.ErrorHandler"%>
<%@page import="com.tsg.requesthandler.requestDelegator"%>
<%@page import="com.tsg.portal.PaymentReceiver"%>
<%@page import="com.tsg.portal.PaymentReceiverResponse"%>
<%@page import="org.apache.log4j.Logger"%>
<%!
static Logger log = Logger.getLogger(HostATOMPaymentReceiver_jsp.class);
private boolean b_SimulatorMode = true; // Simulator Mode by default is set to true.

public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {
    
        //Input Varibales
        String BA_SUBSCRIBER_ID="";
        String LZ_TSTxnID="";
        String LZ_AtomTxnID="";
        String LZ_BankName="";
        String LZ_GetAmount="";
        String LZ_TxnDateTime="";
        String LZ_RRN="";
        String LZ_APGID="";
        String LZ_errorcode="";
        String LZ_errorMsg="";
        String LZ_CheckSum="";
	
        //Output Variables
        String LZ_CurrBal="";
        String LZ_Amount="";
        String LZ_BonusAmt="";
        String LZ_TSReceipt="";
        String LZ_PromptName="";
        try{
            
            if(b_SimulatorMode){
                
                //  Test method
                LZ_errorcode = "00";
                LZ_errorMsg = "SUCCESS";
                				
            } else {
                
                // Below data getting from IVR
//                BA_SUBSCRIBER_ID = state.getString("BA_SUBSCRIBER_ID");
//                LZ_TSTxnID = state.getString("LZ_TSTxnID");
//                LZ_AtomTxnID = state.getString("LZ_AtomTxnID");
//                LZ_BankName = state.getString("LZ_BankName");
//                LZ_GetAmount = state.getString("LZ_GetAmount");	
//                LZ_TxnDateTime = Util.getCurrentDateTime();
//                LZ_RRN = state.getString("LZ_RRN");	
//                LZ_APGID = state.getString("LZ_APGID");
//                LZ_errorcode = state.getString("LZ_errorcode_pg");
//                LZ_errorMsg = state.getString("LZ_errorMsg_pg");
//                LZ_CheckSum = state.getString("LZ_CheckSum");
                
                BA_SUBSCRIBER_ID = state.optString("BA_SUBSCRIBER_ID","");
                LZ_TSTxnID = state.optString("LZ_TSTxnID","");
                LZ_AtomTxnID = state.optString("LZ_AtomTxnID","");
                LZ_BankName = state.optString("LZ_BankName","");
                LZ_GetAmount = state.optString("LZ_GetAmount","");	
                LZ_TxnDateTime = Util.getCurrentDateTime();
                LZ_RRN = state.optString("LZ_RRN","");	
                LZ_APGID = state.optString("LZ_APGID","");
                LZ_errorcode = state.optString("LZ_errorcode_pg","");
                LZ_errorMsg = state.optString("LZ_errorMsg_pg","");
                LZ_CheckSum = state.optString("LZ_CheckSum","");
                
                // Send the request to Tatasky
                PaymentReceiverResponse objDataService = new PaymentReceiver().requestPaymentReceiver(BA_SUBSCRIBER_ID, LZ_TSTxnID, LZ_AtomTxnID, LZ_BankName,
                LZ_GetAmount, LZ_TxnDateTime, LZ_RRN, LZ_APGID, LZ_errorcode, LZ_errorMsg, LZ_CheckSum,"");
                
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
                LZ_PromptName =  new ErrorHandler().PaymentReceiver(LZ_errorcode);
                
                System.out.println("HostATOMPaymentReceiver_jsp output Subscriber Id " +  BA_SUBSCRIBER_ID 
                + " Tatasky Trans Id " + LZ_TSTxnID + " atom Trans Id " + LZ_AtomTxnID
                + " Bank Name " + LZ_BankName + " Current Balance " + LZ_CurrBal
                + " Amount " + LZ_Amount + " Bonus Amount " + LZ_BonusAmt
                + " Trans Date and Time " + LZ_TxnDateTime + " Atom payment Gateway Id " + LZ_APGID
                + " RRN " + LZ_RRN + " Tatasky Receipt " + LZ_TSReceipt
                + " Error Code " + LZ_errorcode + " Error Message " + LZ_errorMsg);
                
                log.info("HostATOMPaymentReceiver_jsp output Subscriber Id " +  BA_SUBSCRIBER_ID 
                + " Tatasky Trans Id " + LZ_TSTxnID + " atom Trans Id " + LZ_AtomTxnID
                + " Bank Name " + LZ_BankName + " Current Balance " + LZ_CurrBal
                + " Amount " + LZ_Amount + " Bonus Amount " + LZ_BonusAmt
                + " Trans Date and Time " + LZ_TxnDateTime + " Atom payment Gateway Id " + LZ_APGID
                + " RRN " + LZ_RRN + " Tatasky Receipt " + LZ_TSReceipt
                + " Error Code " + LZ_errorcode + " Error Message " + LZ_errorMsg);
                
                
            }
            
        }catch (Exception ex){
                System.out.println(" Exception in HostATOMPaymentReceiver_jsp" + ex.getMessage());
                log.info(" Exception in HostATOMPaymentReceiver_jsp" + ex.getMessage());
        }finally{
        
               LZ_GetAmount=LZ_CheckSum=null;
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
    result.put("LZ_PromptName",LZ_PromptName);
    return result;
    
};
%>
<%-- GENERATED: DO NOT REMOVE --%> 
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONException"%>
<%@page import="java.util.Map"%>
<%@include file="../backend.jspf" %>