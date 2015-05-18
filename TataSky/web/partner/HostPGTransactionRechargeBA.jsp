<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>

<%@page import="com.tsg.util.Util"%>
<%@page import="com.tsg.error.ErrorHandler"%>
<%@page import="com.tsg.requesthandler.requestDelegator"%>
<%@page import="com.tsg.atom.TransactionRecharge1"%>
<%@page import="com.tsg.atom.TransactionRechargeResponse"%>
<%@page import="com.tsg.xml.GenerateXml"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean b_SimulatorMode = false; // Simulator Mode by default is set to true.
//Input variables
        String LZ_AtomMerchantID = "";

        String LZ_Method_type = "";

        String LZ_Service_id = "";

        String LZ_GetAmount = "";

        String BA_SUBSCRIBER_ID = "";

        String LZ_UsrANI = "";

        String LZ_EMITenure = "";

        String LZ_MobileNo = "";

        String LZ_BAPin = "";

//Payment Data
        String LZ_CardNumber = "";

//Payment Type
        String LZ_PaymentType = "";

        String LZ_TSTxnID = "";

        String LZ_IVRTxnID = "";

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

        String LZ_PromptName = "";

//Transcation Details
//String LZ_TransDetailId="";

        String LZ_spUpdateAuthorizeTxn = "";

        String LZ_CallFlowDetailXML = "";

        String LZ_RequestXML = "";

        String LZ_ResponseXML = "";

        String LZ_DBCallDetailID = "";

        String LZ_ServiceID = "PDT";

        String LZ_TransStartTime = Util.getCurrentDateTime();

        String LZ_TransEndTime = "";

        String LZ_IVRUUID = "";

        try {
            if (b_SimulatorMode) {
                //Test method
                LZ_AtomTxnID = "24362624";
                LZ_BankID = "634575502235454";
                LZ_RRN = "31926814321";
                LZ_AuthCode = "001424";
                LZ_APGID = "73162";
                LZ_Amount = "1800.00";
                LZ_UDF1 = "TI1307100007535922";
                LZ_UDF2 = "1070068695";
                LZ_UDF3 = "7000116";
                LZ_errorcode = "00";
                LZ_errorMsg = "SUCCESS";

            } else {

                // Realtime scenario
//                LZ_AtomMerchantID = state.getString("LZ_AtomMerchantID");
//
//                LZ_Method_type = state.getString("LZ_Method_type");
//
//                LZ_Service_id = state.getString("LZ_Service_id");
//
//                LZ_GetAmount = state.getString("LZ_GetAmount");
//
//                BA_SUBSCRIBER_ID = state.getString("BA_SUBSCRIBER_ID");
//
//                LZ_UsrANI = state.getString("LZ_UsrANI");
//
//                LZ_EMITenure = state.getString("LZ_EMITenure");
//
//                LZ_MobileNo = state.getString("LZ_MobileNo");
//
//                LZ_BAPin = state.getString("LZ_BAPin");
//
//                //Payment Data
//                LZ_CardNumber = state.getString("LZ_CardNumber");
//
//                //Payment Type
//                LZ_PaymentType = state.getString("LZ_PaymentType");
//
//                LZ_TSTxnID = state.getString("LZ_TSTxnID");
//
//                LZ_IVRTxnID = state.getString("LZ_IVRTxnID");
//
//                LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
//
//                LZ_DBCallDetailID = state.getString("GZ_DBCallDetailID");
//
//                LZ_spUpdateAuthorizeTxn = state.getString("LZ_spUpdateAuthorizeTxn");

                LZ_AtomMerchantID = state.optString("LZ_AtomMerchantID","");

                LZ_Method_type = state.optString("LZ_Method_type","");

                LZ_Service_id = state.optString("LZ_Service_id","");

                LZ_GetAmount = state.optString("LZ_GetAmount","");

                BA_SUBSCRIBER_ID = state.optString("BA_SUBSCRIBER_ID","");

                LZ_UsrANI = state.optString("LZ_UsrANI","");

                LZ_EMITenure = state.optString("LZ_EMITenure","");

                LZ_MobileNo = state.optString("LZ_MobileNo","");

                LZ_BAPin = state.optString("LZ_BAPin","");

                //Payment Data
                LZ_CardNumber = state.optString("LZ_CardNumber","");

                //Payment Type
                LZ_PaymentType = state.optString("LZ_PaymentType","");

                LZ_TSTxnID = state.optString("LZ_TSTxnID","");

                LZ_IVRTxnID = state.optString("LZ_IVRTxnID","");

                LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");

                LZ_DBCallDetailID = state.optString("GZ_DBCallDetailID","");

                LZ_spUpdateAuthorizeTxn = state.optString("LZ_spUpdateAuthorizeTxn","");                               

                LZ_IVRUUID = LZ_CallFlowDetailXML.substring(LZ_CallFlowDetailXML.lastIndexOf("<FLDIVRUUID>") + 12, LZ_CallFlowDetailXML.lastIndexOf("</FLDIVRUUID>"));

                LZ_TSTxnID = LZ_IVRUUID + "|" + LZ_TSTxnID;


                // Logged the HostPGTransactionRecharge Request
//            Logger.info(LZ_DBCallDetailID, "HostPGTransactionRechargeBA Request  LZ_AtomMerchantID : " + LZ_AtomMerchantID 
//               + " LZ_Method_type : " + LZ_Method_type + " LZ_Service_id : " + LZ_Service_id + " LZ_GetAmount : " + LZ_GetAmount
//               + " BA_SUBSCRIBER_ID : " + BA_SUBSCRIBER_ID + " LZ_UsrANI : " + LZ_UsrANI + " LZ_EMITenure : " + LZ_EMITenure
//               + " LZ_MobileNo : " + LZ_MobileNo + " LZ_BAPin : " + LZ_BAPin + " LZ_CardNumber : " + LZ_CardNumber
//               + " LZ_PaymentType : " + LZ_PaymentType + " LZ_TSTxnID : " + LZ_TSTxnID + " LZ_IVRTxnID : " + LZ_IVRTxnID
//               + " LZ_spUpdateAuthorizeTxn : " + LZ_spUpdateAuthorizeTxn + " LZ_DBCallDetailID : " + LZ_DBCallDetailID, false);

                // Send the request to Tatasky
                TransactionRechargeResponse objDataService = new TransactionRecharge1().requestTransactionRecharge(LZ_AtomMerchantID,
                        LZ_Method_type, LZ_Service_id, LZ_GetAmount, BA_SUBSCRIBER_ID, LZ_UsrANI,
                        LZ_EMITenure, LZ_MobileNo, LZ_BAPin, LZ_CardNumber, LZ_PaymentType, LZ_TSTxnID, LZ_IVRTxnID, LZ_DBCallDetailID);

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
        } catch (Exception ex) {

            Logger.error(LZ_DBCallDetailID, " Exception in HostPGTransactionRechargeBA Page : " + ex.getMessage(), false);

        } finally {

            try {

                LZ_PromptName = new ErrorHandler().PGTxnRecharge(LZ_errorcode);

                String msgTokens[] = LZ_PromptName.split(",");

                LZ_PromptName = msgTokens[0].trim();

                LZ_errorMsg = msgTokens[1].trim();

                msgTokens = null;

                //Insert Transcation Details          
                LZ_RequestXML = new TransactionRecharge1().transactionRecharge(LZ_AtomMerchantID,
                        LZ_Method_type, LZ_Service_id, LZ_GetAmount, BA_SUBSCRIBER_ID, LZ_UsrANI,
                        LZ_EMITenure, LZ_MobileNo, LZ_BAPin, LZ_CardNumber, LZ_PaymentType, LZ_TSTxnID, LZ_IVRTxnID, LZ_DBCallDetailID);

                String transDetailXml = new GenerateXml().requestTranscationDetail(LZ_DBCallDetailID, LZ_ServiceID, LZ_TransStartTime,
                        LZ_TransEndTime, LZ_errorcode, LZ_errorMsg, LZ_RequestXML, LZ_ResponseXML);

                String pgTransDetailXml = new GenerateXml().requestUpdateAuthorizeTranscation("", "", LZ_BankID, LZ_CardNumber, "",
                        LZ_PaymentType, LZ_TransEndTime, LZ_BankID, LZ_AtomTxnID, LZ_RRN, LZ_AuthCode, LZ_APGID, "", LZ_errorcode, LZ_errorMsg, LZ_DBCallDetailID);

                LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</PGTRANSACTIONROOT>", pgTransDetailXml);

//                //LZ_TransDetailId = new InsertTransactionDetailDAO().insertTransactionDetail(transDetailXml);
//                if (!("7220.wav").equalsIgnoreCase(LZ_PromptName)) {
//                    LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</CTIROOT>", "<CTITRANSACTIONALERT>" + LZ_errorMsg + "</CTITRANSACTIONALERT></CTIROOT>");
//                    LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</ROOT>", "<ERROR_ROOT><ERRORCFID>957</ERRORCFID><ERRORPROMPT>" + LZ_PromptName + "</ERRORPROMPT></ERROR_ROOT></ROOT>");
//                }

                LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</TRANSACTIONROOT>", transDetailXml);

                transDetailXml = pgTransDetailXml = null;

            } catch (Exception ex) {

                Logger.error(LZ_DBCallDetailID, " Exception in Host PG TransactionRecharge finally block : " + ex.getMessage(), false);
            }finally{

            LZ_AtomMerchantID = LZ_Method_type = LZ_Service_id = LZ_GetAmount = BA_SUBSCRIBER_ID = LZ_UsrANI = LZ_EMITenure = LZ_MobileNo = LZ_BAPin = LZ_CardNumber = LZ_PaymentType = LZ_TSTxnID = LZ_IVRTxnID = LZ_spUpdateAuthorizeTxn = LZ_RequestXML = LZ_ResponseXML = LZ_DBCallDetailID = LZ_ServiceID = LZ_TransStartTime = LZ_TransEndTime = LZ_IVRUUID = null;
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

        result.put("LZ_PromptName", LZ_PromptName);

        result.put("CallFlowDetailXML", LZ_CallFlowDetailXML);

        // Logged the HostPGTransactionRechargeBA Response
//    Logger.info(LZ_DBCallDetailID, "HostPGTransactionRechargeBA Response  LZ_AtomTxnID : " + LZ_AtomTxnID 
//       + " LZ_BankID : " + LZ_BankID + " LZ_RRN : " + LZ_RRN + " LZ_AuthCode : " + LZ_AuthCode
//       + " LZ_APGID : " + LZ_APGID + " LZ_UDF1 : " + LZ_UDF1 + " LZ_UDF2 : " + LZ_UDF2
//       + " LZ_UDF3 : " + LZ_UDF3 + " LZ_errorcode : " + LZ_errorcode + " LZ_errorMsg : " + LZ_errorMsg
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