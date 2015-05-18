<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>

<%@page import="com.tsg.util.Util"%>
<%@page import="com.tsg.error.ErrorHandler"%>
<%@page import="com.tsg.requesthandler.requestDelegator"%>
<%@page import="com.tsg.atom.TransactionRecharge"%>
<%@page import="com.tsg.atom.TransactionRechargeResponse"%>
<%@page import="com.tsg.xml.GenerateXml"%>
<%@page import="com.tsg.log.Logger"%>

<%!    
   
public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {
    
boolean b_SimulatorMode = true; // true false Simulator Mode by default is set to true.
//Input variables
String LZ_AtomMerchantID = "";

String LZ_Method_type = "";

String LZ_Service_id = "";

String LZ_GetAmount = "";

String LZ_pricePoint="";

String BA_SUBSCRIBER_ID = "";

String LZ_UsrANI = "";

String LZ_CardType = "";

String LZ_EMITenure = "";

String LZ_MobileNo = ""; // Bank Recharge

String LZ_BAPin = ""; //  Bank Recharge

String LZ_RechargeOption = ""; //

String LZ_RechargeOptionAgent = "";

String LZ_Product = ""; //DirectSales or Recharge

String LZ_HardwareAmount=""; //DirectSales

String LZ_PackageAmount=""; //DirectSales

String LZ_BonusAmount=""; //DirectSales

String LZ_PackName="";//DirectSales

String LZ_TataskyTxnID="";//DirectSales

String LZ_SRNumber="";

//Payment Data
String LZ_CardNumber = "";

String LZ_ExpiryDate = "";

String LZ_CVVNumber = ""; // CREDIT - DEBIT - CITIDB

String LZ_BatchCode = "";

String LZ_OTP = "";

//Payment Type
String LZ_PaymentType = "";

String LZ_TSTxnID = "";

String LZ_AtomTxnUniqueID = "";

String LZ_IVRUUID="";

//Output variables
String LZ_AtomTxnID = "";

String LZ_BankID = "";

String LZ_RRN = "";

String LZ_AuthCode = "";

String LZ_APGID = "";

String LZ_Amount = "";

String LZ_UDF1 = "";

String LZ_UDF2 = "";

String LZ_UDF3 = "";

String LZ_errorcode = "404";

String LZ_errorMsg = "";

String LZ_PromptName="";

//Transcation Details
//String LZ_TransDetailId="";
String LZ_spUpdateAuthorizeTxn="";

String LZ_CallFlowDetailXML="";

String LZ_RequestXML="";

String LZ_ResponseXML="";

String LZ_DBCallDetailID="";

String LZ_ServiceID="PDT";

String LZ_TransStartTime = Util.getCurrentDateTime();

String LZ_TransEndTime = "";

        try {

            if (b_SimulatorMode) {
                //  Test method
                LZ_AtomTxnID = "24362624";
                LZ_BankID = "6346378502231920";
                LZ_RRN = "319268387808";
                LZ_AuthCode = "001245";
                LZ_APGID = "73162";
                LZ_Amount = "1800.00";
                LZ_UDF1 = "ADS130711000855047";
                LZ_UDF2 = "121668202896";
                LZ_UDF3 = "7000145";
                LZ_errorcode = "00";
                LZ_errorMsg = "SUCCESS";
//                LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
                LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");                

           } else {
                // Realtime scenario
//                //Recharge & Direct Sales
//                LZ_AtomMerchantID = state.getString("LZ_AtomMerchantID");
//                
//                LZ_Method_type = state.getString("LZ_Method_type");
//                
//                LZ_Service_id = state.getString("LZ_Service_id");
//                                				
//                //Recharge
//                LZ_GetAmount = state.getString("LZ_GetAmount");
//                				
//                //Direct Sales
//                LZ_pricePoint = state.getString("LZ_pricePoint");
//                				
//                //Recharge & Direct Sales
//                BA_SUBSCRIBER_ID = state.getString("BA_SUBSCRIBER_ID");
//                
//                LZ_UsrANI = state.getString("LZ_UsrANI");
//                
//                LZ_CardType = state.getString("LZ_CardType");
//               
//                LZ_EMITenure = state.getString("LZ_EMITenure");
//                			
//                LZ_MobileNo = state.getString("LZ_MobileNo");
//                
//                LZ_BAPin = state.getString("LZ_BAPin");
//               
//                LZ_RechargeOption = state.getString("LZ_RechargeOption");
//                
//                LZ_RechargeOptionAgent = state.getString("LZ_RechargeOptionAgent");
//                                
//                LZ_Product = state.getString("LZ_Product");
//              								
//                //Payment Data
//                LZ_CardNumber = state.getString("LZ_CardNumber");
//                
//                LZ_ExpiryDate = state.getString("LZ_ExpiryDate");
//                
//                LZ_CVVNumber = state.getString("LZ_CVVNumber");// CREDIT - DEBIT - CITIDB
//                
//                LZ_BatchCode = state.getString("LZ_BatchCode");// AMEX
//                
//                LZ_OTP = state.getString("LZ_OTP");
//               
//                //Payment Type
//                LZ_PaymentType = state.getString("LZ_PaymentType");
//                               
//                //Recharge
//                LZ_TSTxnID = state.getString("LZ_TSTxnID");
//               
//                //Direct Sales
//                LZ_TataskyTxnID = state.getString("LZ_TataskyTxnID");
//               				
//                LZ_AtomTxnUniqueID = state.getString("LZ_AtomTxnUniqueID");
//                                
//                LZ_PackName = state.getString("LZ_PackName");
//                
//                LZ_HardwareAmount = state.getString("LZ_HardwareAmount");
//                
//                LZ_PackageAmount = state.getString("LZ_PackageAmount");
//                
//                LZ_BonusAmount = state.getString("LZ_BonusAmount");
//                
//                LZ_SRNumber = state.getString("LZ_SRNumber");
//                
//                LZ_spUpdateAuthorizeTxn = state.getString("LZ_spUpdateAuthorizeTxn");
//                
//                LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
//                
//                LZ_DBCallDetailID = state.getString("GZ_DBCallDetailID");

                //Recharge & Direct Sales
                LZ_AtomMerchantID = state.optString("LZ_AtomMerchantID","");
                
                LZ_Method_type = state.optString("LZ_Method_type","");
                
                LZ_Service_id = state.optString("LZ_Service_id","");
                                				
                //Recharge
                LZ_GetAmount = state.optString("LZ_GetAmount","");
                				
                //Direct Sales
                LZ_pricePoint = state.optString("LZ_pricePoint","");
                				
                //Recharge & Direct Sales
                BA_SUBSCRIBER_ID = state.optString("BA_SUBSCRIBER_ID","");
                
                LZ_UsrANI = state.optString("LZ_UsrANI","");
                
                LZ_CardType = state.optString("LZ_CardType","");
               
                LZ_EMITenure = state.optString("LZ_EMITenure","");
                			
                LZ_MobileNo = state.optString("LZ_MobileNo","");
                
                LZ_BAPin = state.optString("LZ_BAPin","");
               
                LZ_RechargeOption = state.optString("LZ_RechargeOption","");
                
                LZ_RechargeOptionAgent = state.optString("LZ_RechargeOptionAgent","");
                                
                LZ_Product = state.optString("LZ_Product","");
              								
                //Payment Data
                LZ_CardNumber = state.optString("LZ_CardNumber","");
                
                LZ_ExpiryDate = state.optString("LZ_ExpiryDate","");
                
                LZ_CVVNumber = state.optString("LZ_CVVNumber","");// CREDIT - DEBIT - CITIDB
                
                LZ_BatchCode = state.optString("LZ_BatchCode","");// AMEX
                
                LZ_OTP = state.optString("LZ_OTP","");
               
                //Payment Type
                LZ_PaymentType = state.optString("LZ_PaymentType","");
                               
                //Recharge
                LZ_TSTxnID = state.optString("LZ_TSTxnID","");
               
                //Direct Sales
                LZ_TataskyTxnID = state.optString("LZ_TataskyTxnID","");
               				
                LZ_AtomTxnUniqueID = state.optString("LZ_AtomTxnUniqueID","");
                                
                LZ_PackName = state.optString("LZ_PackName","");
                
                LZ_HardwareAmount = state.optString("LZ_HardwareAmount","");
                
                LZ_PackageAmount = state.optString("LZ_PackageAmount","");
                
                LZ_BonusAmount = state.optString("LZ_BonusAmount","");
                
                LZ_SRNumber = state.optString("LZ_SRNumber","");
                
                LZ_spUpdateAuthorizeTxn = state.optString("LZ_spUpdateAuthorizeTxn","");
                
                LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");
                
                LZ_DBCallDetailID = state.optString("GZ_DBCallDetailID","");                               
                
                LZ_IVRUUID = LZ_CallFlowDetailXML.substring(LZ_CallFlowDetailXML.lastIndexOf("<FLDIVRUUID>")+12,LZ_CallFlowDetailXML.lastIndexOf("</FLDIVRUUID>"));
                
                LZ_TSTxnID = LZ_IVRUUID + "|"+ LZ_TSTxnID;
               
                //Direct Sales
                LZ_TataskyTxnID = LZ_IVRUUID + "|"+ LZ_TataskyTxnID;
                
                // Logged the HostPGTransactionRecharge Request
                /*Logger.info(LZ_DBCallDetailID, "HostPGTransactionRecharge Request  LZ_AtomMerchantID : " + LZ_AtomMerchantID 
                   + " LZ_Method_type : " + LZ_Method_type + " LZ_Service_id : " + LZ_Service_id + " LZ_GetAmount : " + LZ_GetAmount
                   + " BA_SUBSCRIBER_ID : " + BA_SUBSCRIBER_ID + " LZ_CardNumber : " + LZ_CardNumber + " LZ_ExpiryDate : " + LZ_ExpiryDate
                   + " LZ_CVVNumber : " + LZ_CVVNumber + " LZ_BatchCode : " + LZ_BatchCode + " LZ_OTP : " + LZ_OTP
                   + " LZ_PaymentType : " + LZ_PaymentType + " LZ_TSTxnID : " + LZ_TSTxnID + " LZ_AtomTxnUniqueID : " + LZ_AtomTxnUniqueID
                   + " LZ_CardType : " + LZ_CardType + " LZ_EMITenure : " + LZ_EMITenure + " LZ_MobileNo : " + LZ_MobileNo
                   + " LZ_BAPin : " + LZ_BAPin + " LZ_RechargeOption : " + LZ_RechargeOption + " LZ_RechargeOptionAgent : " + LZ_RechargeOptionAgent
                   + " LZ_pricePoint : " + LZ_pricePoint + " LZ_TataskyTxnID : " + LZ_TataskyTxnID + " LZ_Product : " + LZ_Product
                   + " LZ_HardwareAmount : " + LZ_HardwareAmount + " LZ_PackageAmount : " + LZ_PackageAmount + " LZ_BonusAmount : " + LZ_BonusAmount
                   + " LZ_PackName : " + LZ_PackName + " LZ_spUpdateAuthorizeTxn : " + LZ_spUpdateAuthorizeTxn 
                   + " LZ_DBCallDetailID : " + LZ_DBCallDetailID, true);*/
				
                
                // Send the request to Tatasky
                TransactionRechargeResponse objDataService = new TransactionRecharge().requestTransactionRecharge(LZ_AtomMerchantID,
                        LZ_Method_type, LZ_Service_id, LZ_GetAmount, BA_SUBSCRIBER_ID, LZ_UsrANI,
                        LZ_CardNumber, LZ_ExpiryDate, LZ_CVVNumber, LZ_BatchCode, LZ_OTP, LZ_PaymentType, LZ_TSTxnID, 
                        LZ_AtomTxnUniqueID, LZ_CardType, LZ_EMITenure,LZ_MobileNo,LZ_BAPin,LZ_RechargeOption,
                        LZ_RechargeOptionAgent,LZ_pricePoint,LZ_TataskyTxnID,LZ_Product, LZ_HardwareAmount,
                        LZ_PackageAmount,LZ_BonusAmount,LZ_PackName,LZ_SRNumber,LZ_DBCallDetailID);

                // Response from Tatasky
                LZ_AtomTxnID = objDataService.getTranscationId();
                
                LZ_BankID = objDataService.getBankId();
                
                LZ_RRN = objDataService.getRrn();
                
                LZ_AuthCode = objDataService.getAuthenticationCode();
                
                LZ_APGID = objDataService.getAtomPaymentGatewayId();
                
                LZ_Amount = objDataService.getAmount();
                
                LZ_UDF1 = objDataService.getCustomerCallerId();
                
                LZ_UDF2 = objDataService.getPaymentsData();
                
                LZ_UDF3 = objDataService.getPaymentType();
                
                LZ_errorcode = objDataService.getErrorCode();
                
                LZ_errorMsg = objDataService.getErrorMessage();
                
                LZ_ResponseXML = objDataService.getResponseXml();
                
                LZ_TransEndTime = Util.getCurrentDateTime();
            }
       }catch (Exception ex){
      
            Logger.error(LZ_DBCallDetailID, " Exception in HostPGTransactionRecharge Page : " + ex.getMessage(), false);
           
       } finally {
            
            try {
                   if((LZ_errorMsg.equalsIgnoreCase("Invalid OTP")) || (LZ_errorMsg.equalsIgnoreCase("Invalid OTP Or Billing Pincode"))) {
                       
                    if(LZ_CardType.equalsIgnoreCase("AMEX")){
                        
                        LZ_PromptName="3149.wav";

                           LZ_errorcode="07";

                        LZ_errorMsg ="Invalid Billing Pincode";
                        
                    } else {
                           LZ_errorcode="06";
                        
                        LZ_PromptName="3147.wav";

                        LZ_errorMsg ="Invalid OTP";
                        
                    }
                       
                   }      
                 // Insert Transcation Details          
                 LZ_RequestXML = new TransactionRecharge().transactionRecharge(LZ_AtomMerchantID,
                        LZ_Method_type, LZ_Service_id, LZ_GetAmount, BA_SUBSCRIBER_ID, LZ_UsrANI,
                        LZ_CardNumber, LZ_ExpiryDate, LZ_CVVNumber, LZ_BatchCode, LZ_OTP, LZ_PaymentType, LZ_TSTxnID, 
                        LZ_AtomTxnUniqueID, LZ_CardType, LZ_EMITenure,LZ_MobileNo,LZ_BAPin,LZ_RechargeOption,
                        LZ_RechargeOptionAgent,LZ_pricePoint,LZ_TataskyTxnID,LZ_Product, LZ_HardwareAmount,
                        LZ_PackageAmount,LZ_BonusAmount,LZ_PackName,LZ_SRNumber,LZ_DBCallDetailID);

                  String transDetailXml = new GenerateXml().requestTranscationDetail(LZ_DBCallDetailID, LZ_ServiceID, LZ_TransStartTime,
                            LZ_TransEndTime, LZ_errorcode, LZ_errorMsg, LZ_RequestXML, LZ_ResponseXML);

                  
                  String pgTransDetailXml = new GenerateXml().requestUpdateAuthorizeTranscation("","",LZ_BankID,LZ_CardNumber,LZ_CardType,
                        LZ_PaymentType,LZ_TransEndTime,LZ_BankID,LZ_AtomTxnID,LZ_RRN,LZ_AuthCode,LZ_APGID,"",LZ_errorcode,LZ_errorMsg,LZ_DBCallDetailID);

                  LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</PGTRANSACTIONROOT>", pgTransDetailXml);


                //if (!("7220.wav").equalsIgnoreCase(LZ_PromptName)) {

                   // LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</CTIROOT>","<CTITRANSACTIONALERT>"+LZ_errorMsg+"</CTITRANSACTIONALERT></CTIROOT>");

                    //LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</ROOT>", "<ERROR_ROOT><ERRORCFID>997</ERRORCFID><ERRORPROMPT>" + LZ_PromptName + "</ERRORPROMPT></ERROR_ROOT></ROOT>");
                //}

                LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</TRANSACTIONROOT>", transDetailXml);
                
                transDetailXml = pgTransDetailXml = null;

              }catch (Exception ex){

                  Logger.error(LZ_DBCallDetailID, " Exception in Host PG TransactionRecharge finally block : " + ex.getMessage(), false);
              }finally{
            
            LZ_AtomMerchantID = LZ_Method_type = LZ_Service_id = LZ_GetAmount = LZ_pricePoint=BA_SUBSCRIBER_ID = LZ_UsrANI = LZ_CardType = LZ_EMITenure = LZ_MobileNo =  LZ_BAPin = LZ_RechargeOption = LZ_RechargeOptionAgent = LZ_Product = LZ_HardwareAmount = LZ_PackageAmount = LZ_BonusAmount= LZ_PackName = LZ_TataskyTxnID = LZ_SRNumber = LZ_CardNumber = LZ_ExpiryDate = LZ_CVVNumber =  LZ_BatchCode = LZ_OTP = LZ_PaymentType = LZ_TSTxnID = LZ_AtomTxnUniqueID = LZ_IVRUUID = LZ_spUpdateAuthorizeTxn = LZ_RequestXML = LZ_ResponseXML = LZ_DBCallDetailID = LZ_ServiceID = LZ_TransStartTime = LZ_TransEndTime = null;
            }
       }
           
        JSONObject result = new JSONObject();
        
        result.put("LZ_AtomTxnID", LZ_AtomTxnID);
        
        result.put("LZ_BankID", LZ_BankID);
        
        result.put("LZ_RRN", LZ_RRN);
        
        result.put("LZ_AuthCode", LZ_AuthCode);
        
        result.put("LZ_APGID", LZ_APGID);
        
        result.put("LZ_Amount", LZ_Amount);
        
        result.put("LZ_UDF1", LZ_UDF1);
        
        result.put("LZ_UDF2", LZ_UDF2);
        
        result.put("LZ_UDF3", LZ_UDF3);
        
        result.put("LZ_errorcode", LZ_errorcode);
        
        result.put("LZ_errorMsg", LZ_errorMsg.toUpperCase());
        
        result.put("LZ_PromptName",LZ_PromptName);
        
        result.put("CallFlowDetailXML",LZ_CallFlowDetailXML);
        
         // Logged the HostPGTransactionRecharge Response
//        Logger.info(LZ_DBCallDetailID, "HostPGTransactionRecharge Response  LZ_AtomTxnID : " + LZ_AtomTxnID 
//           + " LZ_BankID : " + LZ_BankID + " LZ_RRN : " + LZ_RRN + " LZ_AuthCode : " + LZ_AuthCode
//           + " LZ_APGID : " + LZ_APGID + " LZ_UDF1 : " + LZ_UDF1 + " LZ_UDF2 : " + LZ_UDF2
//           + " LZ_UDF3 : " + LZ_UDF3 + " LZ_errorcode : " + LZ_errorcode + " LZ_errorMsg : " + LZ_errorMsg
//           + " LZ_PromptName : " + LZ_PromptName, false);
        
        return result;

  };
%>
<%-- GENERATED: DO NOT REMOVE --%> 
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONException"%>
<%@page import="java.util.Map"%>
<%@include file="../backend.jspf" %>