<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>

<%@page import="com.tsg.error.ErrorHandler"%>
<%@page import="com.tsg.util.Util"%>
<%@page import="com.tsg.requesthandler.requestDelegator"%>
<%@page import="com.tsg.portal.ServiceRequestQueryResponse"%>
<%@page import="com.tsg.portal.ServiceRequestQuery"%>
<%@page import="com.tsg.xml.GenerateXml"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean b_SimulatorMode = false; // Simulator Mode by default is set to true.
        // Input varibales
        String LZ_Source = "";

        String LZ_atom_ivrid = "";

        String LZ_SRNumber = "";

        String LZ_sentdatetime = "";

        // output varibales
        String LZ_TStxnID = "";

        String LZ_srType = "";

        String LZ_srArea = "";

        String LZ_srSubArea = "";

        String LZ_pricePoint = "";

        String LZ_subID = "";

        String LZ_ReceivedDateTime = "";

        String LZ_personalCity = "";

        String LZ_personalCountry = "";

        String LZ_personalState = "";

        String LZ_personalStreetAddress = "";

        String LZ_personalStreetAddress2 = "";

        String LZ_personalPostalCode = "";

        String LZ_mobileNumber = "";

        String LZ_personalISPCode = "";

        String LZ_createdBy = "";

        String LZ_errorcode = "404";

        String LZ_errorMsg = "";

        String LZ_SRValidResponse = "";

        String LZ_SRtypeFlag = "";

        String LZ_PromptName = "";

        String LZ_spUpdateDirectSalesSRDetails = "";

        String LZ_CallFlowDetailXML = "";

        String LZ_RequestXML = "";

        String LZ_ResponseXML = "";

        String LZ_DBCallDetailID = "";

        String LZ_ServiceID = "SRQ";

        String LZ_TransStartTime = Util.getCurrentDateTime();

        String LZ_TransEndTime = "";

        try {
            if (b_SimulatorMode) {
            } else {
                // Realtime scenario
//                LZ_Source = state.getString("LZ_Source");
//
//                LZ_atom_ivrid = state.getString("LZ_atom_ivrid");
//
//                LZ_SRNumber = state.getString("LZ_SRNumber");
                
                LZ_Source = state.optString("LZ_Source","");

                LZ_atom_ivrid = state.optString("LZ_atom_ivrid","");

                LZ_SRNumber = state.optString("LZ_SRNumber","");                

                LZ_SRNumber = LZ_SRNumber.replaceFirst(LZ_SRNumber.substring(0, 1), LZ_SRNumber.substring(0, 1) + "-");

                LZ_sentdatetime = Util.getCurrentDateTime();

//                LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
//
//                LZ_DBCallDetailID = state.getString("GZ_DBCallDetailID");
//
//                LZ_spUpdateDirectSalesSRDetails = state.getString("LZ_spUpdateDirectSalesSRDetails");
                
                LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");
 
                LZ_DBCallDetailID = state.optString("GZ_DBCallDetailID","");

                LZ_spUpdateDirectSalesSRDetails = state.optString("LZ_spUpdateDirectSalesSRDetails","");                

//            // Logged the HostServiceRequestQuery Request
//           Logger.info(LZ_DBCallDetailID, "HostServiceRequestQuery Request  LZ_Source : " + LZ_Source 
//                + " LZ_atom_ivrid : " + LZ_atom_ivrid + " LZ_SRNumber : " + LZ_SRNumber + " LZ_sentdatetime : " + LZ_sentdatetime
//                + " LZ_spUpdateDirectSalesSRDetails : " + LZ_spUpdateDirectSalesSRDetails + " LZ_DBCallDetailID : " + LZ_DBCallDetailID, false);


                // Send the request to Tatasky
                ServiceRequestQueryResponse objDataService = new ServiceRequestQuery().requestServiceQuery(LZ_Source,
                        LZ_atom_ivrid, LZ_SRNumber, Util.getCurrentDateAnyFormat("dd/MM/yyyy hh:mm:ss"), LZ_DBCallDetailID);

                // Response from Tatasky 
                LZ_TStxnID = objDataService.getTataskyTransId();

                LZ_srType = objDataService.getSrType();

                LZ_srArea = objDataService.getSrArea();

                LZ_srSubArea = objDataService.getSrSubArea();

                LZ_pricePoint = objDataService.getPricePoint();

                LZ_subID = objDataService.getSubscriberId();

                LZ_ReceivedDateTime = objDataService.getDate();

                LZ_personalCity = objDataService.getPersonalCity();

                LZ_personalCountry = objDataService.getPersonalCountry();

                LZ_personalState = objDataService.getPersonalState();

                LZ_personalStreetAddress = objDataService.getPersonalStreetAddress();

                LZ_personalStreetAddress2 = objDataService.getPersonalStreetAddress2();

                LZ_personalPostalCode = objDataService.getPersonalPostalCode();

                LZ_mobileNumber = objDataService.getMobileNumber();

                LZ_personalISPCode = objDataService.getPersonalISPCode();

                LZ_createdBy = objDataService.getCreatedBy();

                LZ_errorcode = objDataService.getErrorCode();

                LZ_errorMsg = objDataService.getErrorMessage();

                LZ_SRValidResponse = objDataService.getResponseXml();
			
		  if(LZ_errorcode.equalsIgnoreCase("3000")){	

                  LZ_SRtypeFlag = new Util().srTypeFlage(LZ_srType);
		  
		  }

                LZ_ResponseXML = objDataService.getResponseXml();

                LZ_TransEndTime = Util.getCurrentDateTime();
		
		  //LZ_pricePoint = "10";
            }

        } catch (Exception ex) {

            Logger.error(LZ_DBCallDetailID, " Exception in HostServiceRequestQuery Page :" + ex.getMessage(), false);

        } finally {

            try {

                LZ_PromptName = new ErrorHandler().portal(LZ_errorcode);

                String msgTokens[] = LZ_PromptName.split(",");

                LZ_PromptName = msgTokens[0].trim();

                LZ_errorMsg = msgTokens[1].trim();

                msgTokens = null;

                // Insert Transcation Details          
                LZ_RequestXML = new ServiceRequestQuery().serviceRequestQuery(LZ_Source, LZ_atom_ivrid, LZ_SRNumber, Util.getCurrentDateTime());

                LZ_RequestXML = LZ_RequestXML.replace("<?xml version=\"1.0\" encoding=\"UTF-8\"?>", "");

                LZ_ResponseXML = LZ_ResponseXML.replace("<?xml version=\"1.0\" encoding=\"UTF-8\"?>", "");

                String transDetailXml = new GenerateXml().requestTranscationDetail(LZ_DBCallDetailID, LZ_ServiceID, LZ_TransStartTime,
                        LZ_TransEndTime, LZ_errorcode, LZ_errorMsg, LZ_RequestXML, LZ_ResponseXML);

                String pgTransDetailXml = new GenerateXml().requestUpdateDirectSalesSRDetails("", "", LZ_SRNumber, LZ_TransEndTime,
                        LZ_srType, LZ_srArea, LZ_srSubArea, LZ_pricePoint, Util.getCurrentDateTime(), LZ_personalCity, LZ_personalCountry,
                        LZ_personalState, LZ_personalStreetAddress, LZ_personalStreetAddress2, LZ_personalPostalCode, LZ_mobileNumber,
                        LZ_personalISPCode, "", "", LZ_TStxnID, LZ_DBCallDetailID);

                LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</PGTRANSACTIONROOT>", pgTransDetailXml);

                //LZ_TransDetailId = new InsertTransactionDetailDAO().insertTransactionDetail(transDetailXml);

                if (!("7220.wav").equalsIgnoreCase(LZ_PromptName)) {

                    LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</CTIROOT>", "<CTITRANSACTIONALERT>" + LZ_errorMsg + "</CTITRANSACTIONALERT></CTIROOT>");

                    LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</ROOT>", "<ERROR_ROOT><ERRORCFID>959</ERRORCFID><ERRORPROMPT>" + LZ_PromptName + "</ERRORPROMPT></ERROR_ROOT></ROOT>");
                }

                LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</TRANSACTIONROOT>", transDetailXml);
                
                transDetailXml = pgTransDetailXml = null; 

            } catch (Exception ex1) {
                
                Logger.error(LZ_DBCallDetailID, " Exception in HostServiceRequestQuery Finally Block Page :" + ex1.getMessage(), false);
            }finally{
            
            LZ_Source = LZ_atom_ivrid = LZ_SRNumber = LZ_sentdatetime = LZ_RequestXML = LZ_ResponseXML = LZ_DBCallDetailID = LZ_ServiceID = LZ_TransStartTime = LZ_TransEndTime = null;
               }
            }

        JSONObject result = new JSONObject();

        result.put("LZ_TStxnID", LZ_TStxnID);

        result.put("LZ_srType", LZ_srType);

        result.put("LZ_srArea", LZ_srArea);

        result.put("LZ_srSubArea", LZ_srSubArea);

        result.put("LZ_pricePoint", LZ_pricePoint);

        result.put("LZ_subID", LZ_subID);

        result.put("LZ_ReceivedDateTime", LZ_ReceivedDateTime);

        result.put("LZ_personalCity", LZ_personalCity);

        result.put("LZ_personalCountry", LZ_personalCountry);

        result.put("LZ_personalState", LZ_personalState);

        result.put("LZ_personalStreetAddress", LZ_personalStreetAddress);

        result.put("LZ_personalStreetAddress2", LZ_personalStreetAddress2);

        result.put("LZ_personalPostalCode", LZ_personalPostalCode);

        result.put("LZ_mobileNumber", LZ_mobileNumber);

        result.put("LZ_personalISPCode", LZ_personalISPCode);

        result.put("LZ_createdBy", LZ_createdBy);

        result.put("LZ_errorcode", LZ_errorcode);

        result.put("LZ_errorMsg", LZ_errorMsg);

        result.put("LZ_SRValidResponse", LZ_SRValidResponse);

        result.put("LZ_SRtypeFlag", LZ_SRtypeFlag);

        result.put("LZ_PromptName", LZ_PromptName);

        result.put("CallFlowDetailXML", LZ_CallFlowDetailXML);

        // Logged the HostServiceRequestQuery Response
//    Logger.info(LZ_DBCallDetailID, "HostServiceRequestQuery Response  LZ_TStxnID : " + LZ_TStxnID 
//       + " LZ_srType : " + LZ_srType + " LZ_srArea : " + LZ_srArea + " LZ_srSubArea : " + LZ_srSubArea
//       + " LZ_pricePoint : " + LZ_pricePoint + " LZ_subID : " + LZ_subID + " LZ_ReceivedDateTime : " + LZ_ReceivedDateTime
//       + " LZ_personalCity : " + LZ_personalCity + " LZ_personalCountry : " + LZ_personalCountry + " LZ_personalState : " + LZ_personalState
//       + " LZ_personalStreetAddress : " + LZ_personalStreetAddress + " LZ_personalStreetAddress2 : " + LZ_personalStreetAddress2 + " LZ_personalPostalCode : " + LZ_personalPostalCode
//       + " LZ_mobileNumber : " + LZ_mobileNumber + " LZ_personalISPCode : " + LZ_personalISPCode + " LZ_createdBy : " + LZ_createdBy
//       + " LZ_errorcode : " + LZ_errorcode + " LZ_errorMsg : " + LZ_errorMsg + " LZ_SRValidResponse : " + LZ_SRValidResponse
//       + " LZ_SRtypeFlag : " + LZ_SRtypeFlag + " LZ_PromptName : " + LZ_PromptName, false);

        return result;

    }

    ;
%>
<%-- GENERATED: DO NOT REMOVE --%> 
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONException"%>
<%@page import="java.util.Map"%>
<%@include file="../backend.jspf" %>