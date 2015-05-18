<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>

<%@page import="com.tsg.util.Util"%>
<%@page import="com.tsg.error.ErrorHandler"%>
<%@page import="com.tsg.requesthandler.requestDelegator"%>
<%@page import="com.tsg.atom.GetDetails"%>
<%@page import="com.tsg.atom.GetDetailsResponse"%>
<%@page import="com.tsg.xml.GenerateXml"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean b_SimulatorMode = true; // false  ture //Simulator Mode by default is set to true.
        //Input variables
        String LZ_AtomMerchantID = "";

        String LZ_Method_type = "";

        String LZ_Service_id = "";

        String LZ_GetAmount = "0";

        String BA_SUBSCRIBER_ID = "";

        String LZ_UsrANI = "";

        String LZ_IVRUUID = "";

        String LZ_UserID = "";

        String LZ_SRNumber = "";

        String LZ_Product = "";

        //Output variables
        String LZ_AtomTxnUniqueID = "";

        String LZ_OrderID = "";

        String LZ_errorcode = "404";

        String LZ_errormsg = "";

        String LZ_PromptName = "";

        String LZ_spCreateIVRTxn = "";

        String LZ_CallFlowDetailXML = "";

        String LZ_TransPgDetailId = "";

        String LZ_RequestXML = "";

        String LZ_ResponseXML = "";

        String LZ_DBCallDetailID = "";

        String LZ_ServiceID = "GDE";

        String LZ_TransStartTime = Util.getCurrentDateTime();

        String LZ_TransEndTime = "";

        try {
            if (b_SimulatorMode) {

                //  Test method
                LZ_AtomTxnUniqueID = "24362624";

                LZ_OrderID = "1039442551";

                LZ_errorcode = "00";

                LZ_errormsg = "SUCCESS";

//                LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
                LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");                


            } else {

                // Below data getting from IVR
//                LZ_AtomMerchantID = state.getString("LZ_AtomMerchantID");
//
//                LZ_Method_type = state.getString("LZ_Method_type");
//
//                LZ_Service_id = state.getString("LZ_Service_id");
//
//                BA_SUBSCRIBER_ID = state.getString("BA_SUBSCRIBER_ID");
//
//                LZ_UsrANI = state.getString("LZ_UsrANI");
//
//                LZ_IVRUUID = state.getString("LZ_IVRUUID");
//
//                LZ_IVRUUID = LZ_IVRUUID + Util.getCurrentTime1();
//
//                LZ_UserID = state.getString("LZ_UserID");
//
//                LZ_SRNumber = state.getString("LZ_SRNumber");
//
//                LZ_Product = state.getString("LZ_Product");
//
//                LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
//
//                LZ_spCreateIVRTxn = state.getString("LZ_spCreateIVRTxn");
//
//                LZ_DBCallDetailID = state.getString("GZ_DBCallDetailID");

                LZ_AtomMerchantID = state.optString("LZ_AtomMerchantID","");

                LZ_Method_type = state.optString("LZ_Method_type","");

                LZ_Service_id = state.optString("LZ_Service_id","");

                BA_SUBSCRIBER_ID = state.optString("BA_SUBSCRIBER_ID","");

                LZ_UsrANI = state.optString("LZ_UsrANI","");

                LZ_IVRUUID = state.optString("LZ_IVRUUID","");

                LZ_IVRUUID = LZ_IVRUUID + Util.getCurrentTime1();

                LZ_UserID = state.optString("LZ_UserID","");

                LZ_SRNumber = state.optString("LZ_SRNumber","");

                LZ_Product = state.optString("LZ_Product","");

                LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");

                LZ_spCreateIVRTxn = state.optString("LZ_spCreateIVRTxn","");

                LZ_DBCallDetailID = state.optString("GZ_DBCallDetailID","");                               

                // Logged the getDetails Request
//            Logger.info(LZ_DBCallDetailID, "getDetails Request  LZ_AtomMerchantID : " + LZ_AtomMerchantID 
//                + " LZ_Method_type : " + LZ_Method_type + " LZ_Service_id : " + LZ_Service_id + " LZ_GetAmount : " + LZ_GetAmount
//                + " LZ_Service_id : " + LZ_Service_id + " LZ_GetAmount : " + LZ_GetAmount + " BA_SUBSCRIBER_ID : " + BA_SUBSCRIBER_ID
//                + " LZ_UsrANI : " + LZ_UsrANI + " LZ_IVRUUID : " + LZ_IVRUUID + " LZ_UserID : " + LZ_UserID
//                + " LZ_SRNumber : " + LZ_SRNumber + " LZ_Product : " + LZ_Product + " LZ_spCreateIVRTxn : " + LZ_spCreateIVRTxn
//                + " LZ_DBCallDetailID : " + LZ_DBCallDetailID, false);

                // Send the request to Tatasky
                GetDetailsResponse objDataService = new GetDetails().requestGetDetails(LZ_AtomMerchantID, LZ_Method_type,
                        LZ_Service_id, LZ_GetAmount, BA_SUBSCRIBER_ID, LZ_UsrANI, LZ_IVRUUID, LZ_UserID, LZ_SRNumber, LZ_Product, LZ_DBCallDetailID);

                // Response from Tatasky 
                LZ_AtomTxnUniqueID = objDataService.getTranscationId();

                LZ_OrderID = objDataService.getOrderId();

                LZ_errorcode = objDataService.getErrorCode();

                LZ_errormsg = objDataService.getErrorMessage();

                LZ_ResponseXML = objDataService.getResponseXml();

                LZ_TransEndTime = Util.getCurrentDateTime();
            }

        } catch (Exception ex) {

            Logger.error(LZ_DBCallDetailID, " Exception in getDetails Page :" + ex.getMessage(), false);

        } finally {

            try {

                LZ_PromptName = new ErrorHandler().portal(LZ_errorcode);

                String msgTokens[] = LZ_PromptName.split(",");

                LZ_PromptName = msgTokens[0].trim();

                LZ_errormsg = msgTokens[1].trim();

                msgTokens = null;

                // Insert Transcation Details          
                LZ_RequestXML = new GetDetails().getDetails(LZ_AtomMerchantID, LZ_Method_type,
                        LZ_Service_id, LZ_GetAmount, BA_SUBSCRIBER_ID, LZ_UsrANI, LZ_IVRUUID, LZ_UserID, LZ_SRNumber, LZ_Product, LZ_DBCallDetailID);


                String transDetailXml = new GenerateXml().requestTranscationDetail(LZ_DBCallDetailID, LZ_ServiceID, LZ_TransStartTime,
                        LZ_TransEndTime, LZ_errorcode, LZ_errormsg, LZ_RequestXML, LZ_ResponseXML);

                String pgTransDetailXml = new GenerateXml().requestCreateIVRTranscation(LZ_DBCallDetailID, LZ_UsrANI,
                        LZ_IVRUUID, BA_SUBSCRIBER_ID, LZ_UserID, LZ_TransStartTime, "get details",
                        LZ_Product, LZ_AtomTxnUniqueID, LZ_errorcode, LZ_errormsg);

                LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</PGTRANSACTIONROOT>", pgTransDetailXml);


                //LZ_TransDetailId = new InsertTransactionDetailDAO().insertTransactionDetail(transDetailXml);

                if (!("7220.wav").equalsIgnoreCase(LZ_PromptName)) {

                    LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</CTIROOT>", "<CTITRANSACTIONALERT>" + LZ_errormsg + "</CTITRANSACTIONALERT></CTIROOT>");

                    LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</ROOT>", "<ERROR_ROOT><ERRORCFID>997</ERRORCFID><ERRORPROMPT>" + LZ_PromptName + "</ERRORPROMPT></ERROR_ROOT></ROOT>");
                }

                LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</TRANSACTIONROOT>", transDetailXml);

                transDetailXml = pgTransDetailXml = null;

            } catch (Exception ex1) {

                Logger.error(LZ_DBCallDetailID, " Exception in getDetails Finally Block Page :" + ex1.getMessage(), false);
            }finally{
            
                LZ_AtomMerchantID = LZ_Method_type =LZ_Service_id = LZ_GetAmount = BA_SUBSCRIBER_ID =  LZ_UsrANI =  LZ_IVRUUID =  LZ_UserID = LZ_SRNumber =  LZ_Product = LZ_spCreateIVRTxn =  LZ_TransPgDetailId =  LZ_RequestXML =  LZ_ResponseXML =  LZ_DBCallDetailID = LZ_ServiceID =  LZ_TransStartTime =  LZ_TransEndTime = null;


            
            }
        }

        JSONObject result = new JSONObject();

        result.put("LZ_AtomTxnUniqueID", LZ_AtomTxnUniqueID);

        result.put("LZ_OrderID", LZ_OrderID);

        result.put("LZ_errorcode", LZ_errorcode);

        result.put("LZ_errormsg", LZ_errormsg.toUpperCase());

        result.put("LZ_PromptName", LZ_PromptName);

        result.put("CallFlowDetailXML", LZ_CallFlowDetailXML);

        // Logged the getDetails Response
//    Logger.info(LZ_DBCallDetailID, "getDetails Response  LZ_AtomTxnUniqueID : " + LZ_AtomTxnUniqueID 
//        + " LZ_OrderID : " + LZ_OrderID + " LZ_errorcode : " + LZ_errorcode + " LZ_errormsg : " + LZ_errormsg
//        + " LZ_PromptName : " + LZ_PromptName, false);

        return result;

    };
%>
<%-- GENERATED: DO NOT REMOVE --%> 
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONException"%>
<%@page import="java.util.Map"%>
<%@include file="../backend.jspf" %>