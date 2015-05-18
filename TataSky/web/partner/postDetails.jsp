<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>

<%@page import="com.tsg.util.Util"%>
<%@page import="com.tsg.error.ErrorHandler"%>
<%@page import="com.tsg.requesthandler.requestDelegator"%>
<%@page import="com.tsg.atom.PostDetails"%>
<%@page import="com.tsg.atom.PostDetailsResponse"%>
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

        String LZ_pricePoint = "";

        String LZ_AtomTxnUniqueID = "";

        String LZ_UserID = "";

        String LZ_SRNumber = "";

        String BA_SUBSCRIBER_ID = "";

        String LZ_UsrANI = "";

        String LZ_IVRUUID = "";

        String LZ_Status = "";

        String LZ_CallStage = "";

        String LZ_RequiredDigit = "";

        String LZ_EnteredDigit = "";

        String LZ_Attempts = "";

//PricePoint Grid
        String LZ_NoOfBoxes = "";

        String LZ_PackName = "";

        String LZ_HardwareAmount = "";

        String LZ_ActivityFee = "";

        String LZ_BonusAmount = "";

        String LZ_PackageAmount = "";

        String LZ_AccessoriesAmount = "";

        String LZ_TotalAmount = "";

        String LZ_TransactionType = "";

        String LZ_SRValidResponse = "";

        String LZ_SRPostResponse = "";

        String LZ_SUBIDValidResponse = "";

        String LZ_SUBIDValidResponse1 = "";

        String LZ_SUBIDPostResponse = "";

        String LZ_Product = "";

//Output variables
        String LZ_AtomTxnID = "";

        String LZ_OrderID = "";

        String LZ_errorcode = "404";

        String LZ_errormsg = "";

        String LZ_PromptName = "";

//Transcation Details
//String LZ_TransDetailId="";

        String LZ_spUpdateFinalStatus = "";

        String LZ_CallFlowDetailXML = "";

        String LZ_RequestXML = "";

        String LZ_ResponseXML = "";

        String LZ_DBCallDetailID = "";

        String LZ_ServiceID = "PDR";

        String LZ_TransStartTime = Util.getCurrentDateTime();

        String LZ_TSTxnID = "";

        String LZ_TransEndTime = "";

        try {

            if (b_SimulatorMode) {

                //  Test method
                LZ_AtomTxnID = "24362624";

                LZ_OrderID = "1039442551";

                LZ_errorcode = "00";

                LZ_errormsg = "SUCCESS";

//                LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
                LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");                


            } else {
                // Below data getting from IVR
                LZ_Product = state.getString("LZ_Product");

                // Recharge & Direct Sales
//                LZ_AtomMerchantID = state.getString("LZ_AtomMerchantID");
//
//                LZ_Method_type = state.getString("LZ_Method_type");
//
//                LZ_Service_id = state.getString("LZ_Service_id");
//
//                LZ_AtomTxnUniqueID = state.getString("LZ_AtomTxnUniqueID");
//
//                LZ_UsrANI = state.getString("LZ_UsrANI");
//
//                LZ_IVRUUID = state.getString("LZ_IVRUUID");
//
//                LZ_Status = state.getString("LZ_Status");
//
//                LZ_CallStage = state.getString("LZ_CallStage");
//
//                LZ_RequiredDigit = state.getString("LZ_RequiredDigit");
//
//                LZ_EnteredDigit = state.getString("LZ_EnteredDigit");
//
//                LZ_Attempts = state.getString("LZ_Attempts");
//
//                LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
//
//                LZ_IVRUUID = LZ_CallFlowDetailXML.substring(LZ_CallFlowDetailXML.lastIndexOf("<FLDIVRUUID>") + 12, LZ_CallFlowDetailXML.lastIndexOf("</FLDIVRUUID>"));
//
//                LZ_DBCallDetailID = state.getString("GZ_DBCallDetailID");

                LZ_AtomMerchantID = state.optString("LZ_AtomMerchantID","");

                LZ_Method_type = state.optString("LZ_Method_type","");

                LZ_Service_id = state.optString("LZ_Service_id","");

                LZ_AtomTxnUniqueID = state.optString("LZ_AtomTxnUniqueID","");

                LZ_UsrANI = state.optString("LZ_UsrANI","");

                LZ_IVRUUID = state.optString("LZ_IVRUUID","");

                LZ_Status = state.optString("LZ_Status","");

                LZ_CallStage = state.optString("LZ_CallStage","");

                LZ_RequiredDigit = state.optString("LZ_RequiredDigit","");

                LZ_EnteredDigit = state.optString("LZ_EnteredDigit","");

                LZ_Attempts = state.optString("LZ_Attempts","");

                LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");

                LZ_IVRUUID = LZ_CallFlowDetailXML.substring(LZ_CallFlowDetailXML.lastIndexOf("<FLDIVRUUID>") + 12, LZ_CallFlowDetailXML.lastIndexOf("</FLDIVRUUID>"));

                LZ_DBCallDetailID = state.optString("GZ_DBCallDetailID","");                               

                if (LZ_Product.equalsIgnoreCase("Recharge")) {
                    //Recharge
//                    LZ_GetAmount = state.getString("LZ_GetAmount");
                    
                    LZ_GetAmount = state.optString("LZ_GetAmount","");                    

                    if (LZ_GetAmount.isEmpty()) {

                        LZ_GetAmount = "0";

                    }

                    LZ_TSTxnID = LZ_CallFlowDetailXML.substring(LZ_CallFlowDetailXML.lastIndexOf("<FLDTATASKYTXNID>") + 17, LZ_CallFlowDetailXML.lastIndexOf("</FLDTATASKYTXNID>"));

//                    BA_SUBSCRIBER_ID = state.getString("BA_SUBSCRIBER_ID");
                    BA_SUBSCRIBER_ID = state.optString("BA_SUBSCRIBER_ID","");                    

                    //LZ_SUBIDValidResponse = LZ_CallFlowDetailXML.substring(LZ_CallFlowDetailXML.lastIndexOf("<FLDTATASKYTXNSTATUS>")+21,LZ_CallFlowDetailXML.lastIndexOf("</FLDTATASKYTXNSTATUS>"));

//                    LZ_SUBIDValidResponse = state.getString("LZ_SUBIDValidResponse");
//
//                    LZ_SUBIDPostResponse = state.getString("LZ_SUBIDPostResponse");

                    LZ_SUBIDValidResponse = state.optString("LZ_SUBIDValidResponse","");

                    LZ_SUBIDPostResponse = state.optString("LZ_SUBIDPostResponse","");
                    
                    if (LZ_Status.equalsIgnoreCase("MR")) {

                        LZ_SUBIDValidResponse = LZ_SUBIDValidResponse.replace("300", "MR");

                        LZ_SUBIDValidResponse = LZ_SUBIDValidResponse.replace("SUBMITTED", "Retry Exceeded");

                    } else if (LZ_Status.equalsIgnoreCase("EA")) {

                        LZ_SUBIDValidResponse = LZ_SUBIDValidResponse.replace("300", "EA");

                        LZ_SUBIDValidResponse = LZ_SUBIDValidResponse.replace("SUBMITTED", "Ended Abruptly");
                    }


                    if (LZ_SUBIDPostResponse.isEmpty()) {
                        
                    } else {

                        LZ_SUBIDValidResponse1 = LZ_SUBIDValidResponse;

                        LZ_SUBIDValidResponse = LZ_SUBIDPostResponse;

                        LZ_SUBIDPostResponse = LZ_SUBIDValidResponse1;
                    }

                } else if (LZ_Product.equalsIgnoreCase("DirectSales")) {

                    //Direct Sales
//                    LZ_pricePoint = state.getString("LZ_pricePoint");
//
//                    LZ_TSTxnID = LZ_CallFlowDetailXML.substring(LZ_CallFlowDetailXML.lastIndexOf("<FLDTATASKYTXNID>") + 17, LZ_CallFlowDetailXML.lastIndexOf("</FLDTATASKYTXNID>"));//FLDTATASKYTXNID
//
//                    LZ_UserID = state.getString("LZ_UserID"); // Agent ID
//
//                    LZ_SRNumber = state.getString("LZ_SRNumber");
//
//                    LZ_NoOfBoxes = state.getString("LZ_NoOfBoxes");
//
//                    LZ_PackName = state.getString("LZ_PackName");
//
//                    LZ_HardwareAmount = state.getString("LZ_HardwareAmount");
//
//                    LZ_ActivityFee = state.getString("LZ_ActivityFee");
//
//                    LZ_BonusAmount = state.getString("LZ_BonusAmount");
//
//                    LZ_PackageAmount = state.getString("LZ_PackageAmount");
//
//                    LZ_AccessoriesAmount = state.getString("LZ_AccessoriesAmount");
//
//                    LZ_TotalAmount = state.getString("LZ_TotalAmount");
//
//                    LZ_TransactionType = state.getString("LZ_TransactionType");
//
//                    LZ_SRValidResponse = state.getString("LZ_SRValidResponse");
//
//                    LZ_SRPostResponse = state.getString("LZ_SRPostResponse");
//
//                    LZ_spUpdateFinalStatus = state.getString("LZ_spUpdateFinalStatus");
                    
                    LZ_pricePoint = state.optString("LZ_pricePoint","");

                    LZ_TSTxnID = LZ_CallFlowDetailXML.substring(LZ_CallFlowDetailXML.lastIndexOf("<FLDTATASKYTXNID>") + 17, LZ_CallFlowDetailXML.lastIndexOf("</FLDTATASKYTXNID>"));//FLDTATASKYTXNID

                    LZ_UserID = state.optString("LZ_UserID",""); // Agent ID

                    LZ_SRNumber = state.optString("LZ_SRNumber","");

                    LZ_NoOfBoxes = state.optString("LZ_NoOfBoxes","");

                    LZ_PackName = state.optString("LZ_PackName","");

                    LZ_HardwareAmount = state.optString("LZ_HardwareAmount","");

                    LZ_ActivityFee = state.optString("LZ_ActivityFee","");

                    LZ_BonusAmount = state.optString("LZ_BonusAmount","");

                    LZ_PackageAmount = state.optString("LZ_PackageAmount","");

                    LZ_AccessoriesAmount = state.optString("LZ_AccessoriesAmount","");

                    LZ_TotalAmount = state.optString("LZ_TotalAmount","");

                    LZ_TransactionType = state.optString("LZ_TransactionType","");

                    LZ_SRValidResponse = state.optString("LZ_SRValidResponse","");

                    LZ_SRPostResponse = state.optString("LZ_SRPostResponse","");

                    LZ_spUpdateFinalStatus = state.optString("LZ_spUpdateFinalStatus","");                    
                }

                LZ_IVRUUID = LZ_IVRUUID + "|" + LZ_TSTxnID;


                // Logged the postDetails Request
//                Logger.info(LZ_DBCallDetailID, "postDetails Request  LZ_AtomMerchantID : " + LZ_AtomMerchantID 
//                    + " LZ_Method_type : " + LZ_Method_type + " LZ_Service_id : " + LZ_Service_id + " LZ_GetAmount : " + LZ_GetAmount
//                    + " LZ_pricePoint : " + LZ_pricePoint + " LZ_AtomTxnUniqueID : " + LZ_AtomTxnUniqueID + " LZ_UserID : " + LZ_UserID
//                    + " LZ_SRNumber : " + LZ_SRNumber + " BA_SUBSCRIBER_ID : " + BA_SUBSCRIBER_ID + " LZ_UsrANI : " + LZ_UsrANI
//                    + " LZ_IVRUUID : " + LZ_IVRUUID + " LZ_Status : " + LZ_Status + " LZ_CallStage : " + LZ_CallStage
//                    + " LZ_RequiredDigit : " + LZ_RequiredDigit + " LZ_EnteredDigit : " + LZ_EnteredDigit + " LZ_Attempts : " + LZ_Attempts
//                    + " LZ_NoOfBoxes : " + LZ_NoOfBoxes + " LZ_PackName : " + LZ_PackName + " LZ_HardwareAmount : " + LZ_HardwareAmount
//                    + " LZ_ActivityFee : " + LZ_ActivityFee + " LZ_BonusAmount : " + LZ_BonusAmount + " LZ_PackageAmount : " + LZ_PackageAmount
//                    + " LZ_AccessoriesAmount : " + LZ_AccessoriesAmount + " LZ_TotalAmount : " + LZ_TotalAmount + " LZ_TransactionType : " + LZ_TransactionType
//                    + " LZ_Product : " + LZ_Product + " LZ_spUpdateFinalStatus : " + LZ_spUpdateFinalStatus + " LZ_DBCallDetailID : " + LZ_DBCallDetailID, false);

                // Send the request to Tatasky
                PostDetailsResponse objDataService = new PostDetails().requestPostDetails(LZ_AtomMerchantID, LZ_Method_type,
                        LZ_Service_id, LZ_GetAmount, LZ_pricePoint, LZ_AtomTxnUniqueID, LZ_UserID, LZ_SRNumber, BA_SUBSCRIBER_ID, LZ_UsrANI, LZ_IVRUUID,
                        LZ_Status, LZ_CallStage, LZ_RequiredDigit, LZ_EnteredDigit, LZ_Attempts, LZ_NoOfBoxes, LZ_PackName, LZ_HardwareAmount,
                        LZ_ActivityFee, LZ_BonusAmount, LZ_PackageAmount, LZ_AccessoriesAmount, LZ_TotalAmount, LZ_TransactionType,
                        LZ_SRValidResponse, LZ_SRPostResponse, LZ_SUBIDValidResponse, LZ_SUBIDPostResponse, LZ_Product, LZ_DBCallDetailID);

                // Response from Tatasky 
                LZ_AtomTxnID = objDataService.getTranscationId();

                LZ_OrderID = objDataService.getOrderId();

                LZ_errorcode = objDataService.getErrorCode();

                LZ_errormsg = objDataService.getErrorMessage();

                LZ_ResponseXML = objDataService.getResponseXml();

                LZ_TransEndTime = Util.getCurrentDateTime();
            }

        } catch (Exception ex) {

            Logger.error(LZ_DBCallDetailID, " Exception in postDetails Page :" + ex.getMessage(), false);

        } finally {

            try {

//           if (LZ_Product.equalsIgnoreCase("Recharge")) {
//
//               LZ_PromptName =  new ErrorHandler().ReportingRecharge(LZ_errorcode);
//
//           } else if (LZ_Product.equalsIgnoreCase("DirectSales")) {
//
//              LZ_PromptName =  new ErrorHandler().ReportingDirectSales(LZ_errorcode); 
//
//           } else {
//
//              LZ_PromptName =  new ErrorHandler().ReportingDirectSales(LZ_errorcode); 
//           }

//            String msgTokens[] = LZ_PromptName.split(",");
//            
//            LZ_PromptName=msgTokens[0].trim();
//            
//            LZ_errormsg =msgTokens[1].trim();
//            
//            msgTokens=null; 

                // Insert Transcation Details          
                LZ_RequestXML = new PostDetails().postDetails(LZ_AtomMerchantID, LZ_Method_type,
                        LZ_Service_id, LZ_GetAmount, LZ_pricePoint, LZ_AtomTxnUniqueID, LZ_UserID, LZ_SRNumber, BA_SUBSCRIBER_ID, LZ_UsrANI, LZ_IVRUUID,
                        LZ_Status, LZ_CallStage, LZ_RequiredDigit, LZ_EnteredDigit, LZ_Attempts, LZ_NoOfBoxes, LZ_PackName, LZ_HardwareAmount,
                        LZ_ActivityFee, LZ_BonusAmount, LZ_PackageAmount, LZ_AccessoriesAmount, LZ_TotalAmount, LZ_TransactionType,
                        LZ_SRValidResponse, LZ_SRPostResponse, LZ_SUBIDValidResponse, LZ_SUBIDPostResponse, LZ_Product, LZ_DBCallDetailID);

                String transDetailXml = new GenerateXml().requestTranscationDetail(LZ_DBCallDetailID, LZ_ServiceID, LZ_TransStartTime,
                        LZ_TransEndTime, LZ_errorcode, LZ_errormsg, LZ_RequestXML, LZ_ResponseXML);

                String pgTransDetailXml = new GenerateXml().requestUpdateFinalStatus("", "", LZ_Status,
                        LZ_CallStage, LZ_DBCallDetailID);

                LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</PGTRANSACTIONROOT>", pgTransDetailXml);

                //LZ_TransDetailId = new InsertTransactionDetailDAO().insertTransactionDetail(transDetailXml);
//            if (!("7220.wav").equalsIgnoreCase(LZ_PromptName)) {
//                
//                LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</CTIROOT>","<CTITRANSACTIONALERT>"+LZ_errormsg+"</CTITRANSACTIONALERT></CTIROOT>");
//               
//                LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</ROOT>", "<ERROR_ROOT><ERRORCFID>997</ERRORCFID><ERRORPROMPT>" + LZ_PromptName + "</ERRORPROMPT></ERROR_ROOT></ROOT>");
//            }

                LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</TRANSACTIONROOT>", transDetailXml);
                  
                transDetailXml = pgTransDetailXml = null;

            } catch (Exception ex1) {
                
                Logger.error(LZ_DBCallDetailID, " Exception in Finally Block PostDetails Page :" + ex1.getMessage(), false);
            } finally{
            
                  LZ_AtomMerchantID = LZ_Method_type = LZ_Service_id = LZ_GetAmount = LZ_pricePoint = LZ_AtomTxnUniqueID = LZ_UserID = LZ_SRNumber = BA_SUBSCRIBER_ID = LZ_UsrANI = LZ_IVRUUID = LZ_Status = LZ_CallStage = LZ_RequiredDigit = LZ_EnteredDigit = LZ_Attempts = LZ_NoOfBoxes = LZ_PackName = LZ_HardwareAmount = LZ_ActivityFee = LZ_BonusAmount = LZ_PackageAmount = LZ_AccessoriesAmount = LZ_TotalAmount = LZ_TransactionType = LZ_SRValidResponse = LZ_SRPostResponse = LZ_SUBIDValidResponse = LZ_SUBIDValidResponse1 = LZ_SUBIDPostResponse = LZ_Product = LZ_spUpdateFinalStatus = LZ_RequestXML = LZ_ResponseXML =LZ_DBCallDetailID = LZ_ServiceID = LZ_TransStartTime = LZ_TSTxnID = LZ_TransEndTime = null; 
              }
             }

        JSONObject result = new JSONObject();

        result.put("LZ_AtomTxnID", LZ_AtomTxnID);

        result.put("LZ_OrderID", LZ_OrderID);

        result.put("LZ_errorcode", LZ_errorcode);

        result.put("LZ_errormsg", LZ_errormsg.toUpperCase());

        result.put("LZ_PromptName", LZ_PromptName);

        result.put("CallFlowDetailXML", LZ_CallFlowDetailXML);

        // Logged the postDetails Response
//    Logger.info(LZ_DBCallDetailID, "postDetails Response  LZ_AtomTxnUniqueID : " + LZ_AtomTxnUniqueID 
//        + " LZ_OrderID : " + LZ_OrderID + " LZ_errorcode : " + LZ_errorcode + " LZ_errormsg : " + LZ_errormsg
//        + " LZ_PromptName : " + LZ_PromptName, false);

        return result;
    }

    ;
%>
<%-- GENERATED: DO NOT REMOVE --%> 
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONException"%>
<%@page import="java.util.Map"%>
<%@include file="../backend.jspf" %>