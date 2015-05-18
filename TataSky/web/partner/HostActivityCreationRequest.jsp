<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>

<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.tsg.util.Util"%>
<%@page import="com.tsg.error.ErrorHandler"%>
<%@page import="com.tsg.requesthandler.requestDelegator"%>
<%@page import="com.tsg.portal.CreateActivity"%>
<%@page import="com.tsg.portal.CreateActivityResponse"%>
<%@page import="com.tsg.xml.GenerateXml"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean b_SimulatorMode = false; // Simulator Mode by default is set to true.

//Input Varibales
        String LZ_IVRTxnID = "";

        String LZ_TataskyTxnID = "";

        String LZ_TxnDateTime = "";

        String LZ_SRNumber = "";

        String LZ_AtomTxnUniqueID = "";

        String LZ_TxnSuccess = "";

        String LZ_RefNo = "";

        String LZ_RRN = "";

        String LZ_Amount = "";

        String LZ_PackName = "";

        String LZ_HardwareAmount = "";

        String LZ_BonusAmount = "";

        String LZ_PackageAmount = "";

        String LZ_TotalAmount = "";

        String LZ_AtomMerchantID = "";

        String LZ_UserID = "";

        String LZ_APGID = "";


//Output Variables
        String LZ_ActivityID = "";

        String LZ_BonusAmt = "";

        String LZ_errorcode = "404";

        String LZ_errorMsg = "";

        String LZ_PromptName = "";

//Transcation Details
//String LZ_TransDetailId="";

        String LZ_spUpdateDirectSalesActivityDetails = "";

        String LZ_CallFlowDetailXML = "";

        String LZ_RequestXML = "";

        String LZ_ResponseXML = "";

        String LZ_DBCallDetailID = "";

        String LZ_ServiceID = "CAT";

        String LZ_TransStartTime = Util.getCurrentDateTime();

        String LZ_TransEndTime = "";

        try {

            if (b_SimulatorMode) {
                //  Test method
                LZ_errorcode = "00";

                LZ_errorMsg = "SUCCESS";

            } else {
                // Below data getting from IVR
//                LZ_IVRTxnID = state.getString("LZ_IVRTxnID");
//
//                LZ_TataskyTxnID = state.getString("LZ_TataskyTxnID");

                LZ_IVRTxnID = state.optString("LZ_IVRTxnID","");

                LZ_TataskyTxnID = state.optString("LZ_TataskyTxnID","");                               

                SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy hh:mm:ss a");

                Date date = new Date();

                LZ_TxnDateTime = dateFormat.format(date);

                date = null;

                dateFormat = null;

//                LZ_SRNumber = state.getString("LZ_SRNumber");
//
//                LZ_SRNumber = LZ_SRNumber.replaceFirst(LZ_SRNumber.substring(0, 1), LZ_SRNumber.substring(0, 1) + "-");
//
//                LZ_AtomTxnUniqueID = state.getString("LZ_AtomTxnUniqueID");
//
//                LZ_TxnSuccess = state.getString("LZ_TxnSuccess");
//
//                LZ_RefNo = state.getString("LZ_EMITenure");
//
//                LZ_RRN = state.getString("LZ_RRN");
//
//                LZ_APGID = state.getString("LZ_APGID");
//
//                LZ_Amount = state.getString("LZ_Amount");
//
//                LZ_PackName = state.getString("LZ_PackName");
//
//                LZ_HardwareAmount = state.getString("LZ_HardwareAmount");
//
//                LZ_BonusAmount = state.getString("LZ_BonusAmount");
//
//                LZ_PackageAmount = state.getString("LZ_PackageAmount");
//
//                LZ_TotalAmount = state.getString("LZ_TotalAmount");
//
//                LZ_AtomMerchantID = state.getString("LZ_AtomMerchantID");
//
//                LZ_UserID = state.getString("LZ_UserID");
//
//                LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
//
//                LZ_DBCallDetailID = state.getString("GZ_DBCallDetailID");
//
//                LZ_spUpdateDirectSalesActivityDetails = state.getString("LZ_spUpdateDirectSalesActivityDetails");

                LZ_SRNumber = state.optString("LZ_SRNumber","");

                LZ_SRNumber = LZ_SRNumber.replaceFirst(LZ_SRNumber.substring(0, 1), LZ_SRNumber.substring(0, 1) + "-");

                LZ_AtomTxnUniqueID = state.optString("LZ_AtomTxnUniqueID","");

                LZ_TxnSuccess = state.optString("LZ_TxnSuccess","");

                LZ_RefNo = state.optString("LZ_EMITenure","");

                LZ_RRN = state.optString("LZ_RRN","");

                LZ_APGID = state.optString("LZ_APGID","");

                LZ_Amount = state.optString("LZ_Amount","");

                LZ_PackName = state.optString("LZ_PackName","");

                LZ_HardwareAmount = state.optString("LZ_HardwareAmount","");

                LZ_BonusAmount = state.optString("LZ_BonusAmount","");

                LZ_PackageAmount = state.optString("LZ_PackageAmount","");

                LZ_TotalAmount = state.optString("LZ_TotalAmount","");

                LZ_AtomMerchantID = state.optString("LZ_AtomMerchantID","");

                LZ_UserID = state.optString("LZ_UserID","");

                LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");

                LZ_DBCallDetailID = state.optString("GZ_DBCallDetailID","");

                LZ_spUpdateDirectSalesActivityDetails = state.optString("LZ_spUpdateDirectSalesActivityDetails","");
                
                // Logged the ActivityCreationRequest Request
//                Logger.info(LZ_DBCallDetailID, "HostActivityCreationRequest Request  LZ_IVRTxnID : " + LZ_IVRTxnID 
//                    + " LZ_TataskyTxnID : " + LZ_TataskyTxnID + " LZ_TxnDateTime : " + LZ_TxnDateTime + " LZ_SRNumber : " + LZ_SRNumber
//                    + " LZ_AtomTxnUniqueID : " + LZ_AtomTxnUniqueID + " LZ_TxnSuccess : " +LZ_TxnSuccess + " LZ_RefNo : " + LZ_RefNo
//                    + " LZ_RRN : " + LZ_RRN + " LZ_APGID : " + LZ_APGID + " LZ_Amount : " + LZ_Amount + " LZ_PackName : " + LZ_PackName
//                    + " LZ_HardwareAmount : " + LZ_HardwareAmount + " LZ_BonusAmount : " + LZ_BonusAmount + " LZ_PackageAmount : " + LZ_PackageAmount
//                    + " LZ_TotalAmount : " + LZ_TotalAmount + " LZ_AtomMerchantID : " + LZ_AtomMerchantID
//                    + " LZ_DBCallDetailID : " + LZ_DBCallDetailID + " LZ_spUpdateDirectSalesActivityDetails : " + LZ_spUpdateDirectSalesActivityDetails, false);

                // Send the request to Tatasky
                CreateActivityResponse objDataService = new CreateActivity().requestCreateActivity(LZ_IVRTxnID,
                        LZ_TataskyTxnID, LZ_TxnDateTime, LZ_SRNumber, LZ_AtomTxnUniqueID,
                        LZ_TxnSuccess, LZ_RefNo, LZ_RRN, LZ_APGID, LZ_Amount, LZ_PackName, LZ_HardwareAmount,
                        LZ_BonusAmount, LZ_PackageAmount, LZ_TotalAmount, LZ_AtomMerchantID, LZ_UserID, LZ_DBCallDetailID);

                // Response from Tatasky 
                LZ_IVRTxnID = objDataService.getAtomIvrId();

                LZ_SRNumber = objDataService.getSrNumber();

                LZ_ActivityID = objDataService.getActivityId();

                LZ_errorcode = objDataService.getErrorCode();

                LZ_errorMsg = objDataService.getErrorMessage();

                LZ_ResponseXML = objDataService.getResponseXml();

                LZ_TransEndTime = Util.getCurrentDateTime();

            }

        } catch (Exception ex) {

            Logger.error(LZ_DBCallDetailID, "Exception in Host Activity CreationRequest Page : " + ex.getMessage(), false);

        } finally {

            try {

                LZ_PromptName = new ErrorHandler().portal(LZ_errorcode);

                String msgTokens[] = LZ_PromptName.split(",");

                LZ_PromptName = msgTokens[0].trim();

                LZ_errorMsg = msgTokens[1].trim();

                msgTokens = null;

                // Insert Transcation Details          
                LZ_RequestXML = new CreateActivity().createActivity(LZ_IVRTxnID, LZ_TataskyTxnID, LZ_TxnDateTime, LZ_SRNumber, LZ_AtomTxnUniqueID,
                        LZ_TxnSuccess, LZ_RefNo, LZ_RRN, LZ_APGID, LZ_Amount, LZ_PackName, LZ_HardwareAmount, LZ_BonusAmount, LZ_PackageAmount,
                        LZ_TotalAmount, LZ_AtomMerchantID, LZ_UserID);

                LZ_RequestXML = LZ_RequestXML.replace("<?xml version=\"1.0\" encoding=\"UTF-8\"?>", "");

                LZ_ResponseXML = LZ_ResponseXML.replace("<?xml version=\"1.0\" encoding=\"UTF-8\"?>", "");

                String transDetailXml = new GenerateXml().requestTranscationDetail(LZ_DBCallDetailID, LZ_ServiceID, LZ_TransStartTime,
                        LZ_TransEndTime, LZ_errorcode, LZ_errorMsg, LZ_RequestXML, LZ_ResponseXML);

                String pgTransDetailXml = new GenerateXml().requestUpdateDirectSalesActivityDetails("", "", LZ_ActivityID, LZ_TransEndTime, LZ_DBCallDetailID);

                LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</PGTRANSACTIONROOT>", pgTransDetailXml);

                if (!("7220.wav").equalsIgnoreCase(LZ_PromptName)) {

                    LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</CTIROOT>", "<CTITRANSACTIONALERT>" + LZ_errorMsg + "</CTITRANSACTIONALERT></CTIROOT>");

                    LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</ROOT>", "<ERROR_ROOT><ERRORCFID>997</ERRORCFID><ERRORPROMPT>" + LZ_PromptName + "</ERRORPROMPT></ERROR_ROOT></ROOT>");

                }

                LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</TRANSACTIONROOT>", transDetailXml);

            } catch (Exception ex) {

                Logger.error(LZ_DBCallDetailID, " Exception in Host Activity Creation Request Finally Block Page : " + ex.getMessage(), false);
            }finally{
            
              LZ_TataskyTxnID = LZ_TxnDateTime = LZ_AtomTxnUniqueID = LZ_TxnSuccess = LZ_RefNo = LZ_RRN = LZ_Amount = LZ_PackName = LZ_HardwareAmount = LZ_BonusAmount = LZ_PackageAmount = LZ_TotalAmount = LZ_AtomMerchantID = LZ_UserID = LZ_APGID = LZ_BonusAmt = LZ_spUpdateDirectSalesActivityDetails = LZ_RequestXML = LZ_DBCallDetailID = LZ_ServiceID = LZ_TransStartTime = LZ_TransEndTime = null;
             
            }
        }

        JSONObject result = new JSONObject();

        result.put("LZ_IVRTxnID", LZ_IVRTxnID);

        result.put("LZ_SRNumber", LZ_SRNumber);

        result.put("LZ_ActivityID", LZ_ActivityID);

        result.put("LZ_errorcode", LZ_errorcode);

        result.put("LZ_ResponseXML", LZ_ResponseXML);

        result.put("LZ_errorMsg", LZ_errorMsg);

        result.put("LZ_PromptName", LZ_PromptName);

        result.put("CallFlowDetailXML", LZ_CallFlowDetailXML);

        // Logged the ActivityCreationRequest Response
//    Logger.info(LZ_DBCallDetailID, "HostActivityCreationRequest Response  LZ_SRNumber : " + LZ_SRNumber 
//        + " LZ_ActivityID : " + LZ_ActivityID + " LZ_errorcode : " + LZ_errorcode + " LZ_errorMsg : " + LZ_errorMsg
//        + " LZ_PromptName : " + LZ_PromptName, false);

        return result;

    };
%>
<%-- GENERATED: DO NOT REMOVE --%> 
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONException"%>
<%@page import="java.util.Map"%>
<%@include file="../backend.jspf" %>