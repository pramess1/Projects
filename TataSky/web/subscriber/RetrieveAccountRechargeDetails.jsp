<%@page import="com.tsg.util.Util"%>
<%@page import="com.tsg.xml.GenerateXml"%>
<%@page language="java" contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.tsg.database.DBAccess"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean LZ_SimulatorMode = false; // Simulator Mode by default is set to true.
        String LZ_CallFlowDetailXML = ""; // This is used to store the call flow detail XML.
        String LZ_BASubscriberID = ""; // Subscriber ID
        String LZ_DBCallDetailID = "";
        String LZ_ServiceID = "";
        String LZ_TransStartTime = "";
        String LZ_TransEndTime = "";
        String LZ_errorcode = "";
        String LZ_errorMsg = "";
        String LZ_RequestXML = "";
        String LZ_ResponseXML = "";
        String transDetailXml = "";
        try {
//            LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
            LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML", "");
            LZ_DBCallDetailID = state.optString("LZ_DBCallDetailID", "");
            if (LZ_SimulatorMode) {
                //Test
            } else {
                LZ_errorcode = "200";
                LZ_errorMsg = "Success";
                LZ_ServiceID = "GGACCB";
                Document docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);
                LZ_BASubscriberID = XMLAO.getNodeValueText(docBA, "BA_SUBSCRIBER_ID");
                LZ_TransStartTime = Util.getCurrentDateTime();
                String LZ_BA_XML = new DBAccess().getAccountDetail(LZ_BASubscriberID, "");
                LZ_TransEndTime = Util.getCurrentDateTime();
                LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("<BA_ROOT>", "<BA_ROOT>" + LZ_BA_XML);
                LZ_RequestXML = LZ_BASubscriberID;
                LZ_ResponseXML = LZ_BA_XML;
                transDetailXml = new GenerateXml().requestTranscationDetail(LZ_DBCallDetailID, LZ_ServiceID, LZ_TransStartTime,
                        LZ_TransEndTime, LZ_errorcode, LZ_errorMsg, LZ_RequestXML, LZ_ResponseXML);
                
                LZ_BA_XML = new DBAccess().getDetailBySubscriberId(LZ_BASubscriberID, "", "");
                LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</TRANSACTIONROOT>", transDetailXml);
                LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("<BA_ROOT>", "<BA_ROOT>" + LZ_BA_XML);
                
                LZ_BA_XML = null;
            }
        } catch (Exception ex) {
            Logger.error("", " Exception in  RetrieveAccountRechargeDetails Page : " + ex.getMessage(), false);
        } finally {



            LZ_BASubscriberID = null;
        }

        JSONObject result = new JSONObject();
        result.put("CallFlowDetailXML", LZ_CallFlowDetailXML);
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