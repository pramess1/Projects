<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean LZ_SimulatorMode = false; // Simulator Mode by default is set to true.
        String LZ_CallFlowDetailXML = ""; // This is used to store the call flow detail XML.

        String LZ_BASubscriberID = ""; // Subscriber Id
        String LZ_PartnerMobileNumber = ""; // Partner Mobile Number
        String LZ_IVRID = ""; // IVR ID is the UUID
        String LZ_DBCallDetailID = ""; // This is used to store the call detail ID.
        String LZ_AppLanguage = "en-IN"; // This is used to store the language folder.

        try {
//            LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");

            LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");
                                  
            if (LZ_SimulatorMode) {
            } else {
                Document docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);

                LZ_BASubscriberID = XMLAO.getNodeValueText(docBA, "BA_SUBSCRIBER_ID");
                LZ_PartnerMobileNumber = XMLAO.getNodeValueText(docBA, "FLDCLI");
                LZ_IVRID = XMLAO.getNodeValueText(docBA, "FLDUUID");
                LZ_AppLanguage = XMLAO.getNodeValueText(docBA, "BA_APP_LANGUAGE");
            }
        } catch (Exception ex) {
            Logger.error(LZ_DBCallDetailID, " Exception in RetrieveEVDRechargeDetails Page : " + ex.getMessage(), false);
        }finally{
     
                   LZ_CallFlowDetailXML =  LZ_DBCallDetailID = null;

        }

        JSONObject result = new JSONObject();
        result.put("BASubscriberID", LZ_BASubscriberID);
        result.put("PartnerMobileNumber", LZ_PartnerMobileNumber);
        result.put("IVRID", LZ_IVRID);
        result.put("AppLanguage", LZ_AppLanguage);

        return result;

    }

    ;
%>
<%-- GENERATED: DO NOT REMOVE --%> 
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONException"%>
<%@page import="java.util.Map"%>

<%@page import="org.w3c.dom.Document"%>
<%@page import="Common.ActionObjects.*"%>

<%@include file="../backend.jspf" %>