<%@page language="java" contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.tsg.database.DBAccess"%>
<%@page import="com.tsg.common.*"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean LZ_SimulatorMode = false; // Simulator Mode by default is set to true.
        String LZ_CallFlowDetailXML = ""; // This is used to store the call flow detail XML.
        String LZ_DBCallDetailID = ""; // This is used to store the call detail ID.
        String LZ_BASubscriberID = ""; // Subscriber ID
        String LZ_BAAccountStatus = ""; // Account status (Active/De-Active)
        String LZ_BAAccountBalance = ""; // Account balance for a particular subsccriber ID

        try {
//            LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
//            LZ_DBCallDetailID = state.getString("GZ_DBCallDetailID");

            LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");
            LZ_DBCallDetailID = state.optString("GZ_DBCallDetailID","");
                                  
            if (LZ_SimulatorMode) {
            } else {
                Document docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);
                LZ_BASubscriberID = XMLAO.getNodeValueText(docBA, "BA_SUBSCRIBER_ID");

                String LZ_BA_XML = new DBAccess().getProfileBySubscriberId(LZ_BASubscriberID, LZ_DBCallDetailID);
                String LZ_BA_XML1 = new DBAccess().getAccountDetail(LZ_BASubscriberID, LZ_DBCallDetailID);

                XMLAO.deleteNode(docBA, "BA_PRIMARY_LANGUAGE");
                XMLAO.deleteNode(docBA, "BA_SECONDARY_LANGUAGE");
                XMLAO.deleteNode(docBA, "BA_PREMIUM_FLAG");
                XMLAO.deleteNode(docBA, "BA_ACCOUNT_STATUS");
                XMLAO.deleteNode(docBA, "BA_SUBSCRIBER_ID");
                XMLAO.deleteNode(docBA, "BA_ACCOUNT_SUB_STATUS");

                XMLAO.deleteNode(docBA, "BA_ACCOUNT_BALANCE");
                XMLAO.deleteNode(docBA, "BA_RECHARGE_DUE_DATE");
                XMLAO.deleteNode(docBA, "BA_FDP_RENEW_DATE");
                XMLAO.deleteNode(docBA, "BA_LAST_RECHARGE_AMT");
                XMLAO.deleteNode(docBA, "BA_LAST_RECHARGE_DATETIME");
                XMLAO.deleteNode(docBA, "BA_SUGGESTED_RECHARGE");

                LZ_CallFlowDetailXML = XMLAO.getNodeOuterXML(docBA);
                LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("<BA_ROOT>", "<BA_ROOT>" + LZ_BA_XML + LZ_BA_XML1);
                docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);

                LZ_BAAccountStatus = XMLAO.getNodeValueText(docBA, "BA_ACCOUNT_STATUS");
                LZ_BAAccountBalance = XMLAO.getNodeValueText(docBA, "BA_ACCOUNT_BALANCE");

                LZ_BA_XML = LZ_BA_XML1 = null;
            }
        } catch (Exception ex) {
            Logger.error(LZ_DBCallDetailID, " Exception in  RetrievePostRechargeRefresh Page : " + ex.getMessage(), false);
        } finally {
            LZ_DBCallDetailID = LZ_BASubscriberID = null;
        }

        JSONObject result = new JSONObject();
        //result.put("BAAccountStatus", LZ_BAAccountStatus);
        //result.put("BAAccountBalance", LZ_BAAccountBalance);
        result.put("CallFlowDetailXML", LZ_CallFlowDetailXML);

        return result;

    };
%>
<%-- GENERATED: DO NOT REMOVE --%> 
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONException"%>
<%@page import="java.util.Map"%>

<%@page import="org.w3c.dom.Document"%>
<%@page import="Common.ActionObjects.*"%>

<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<%@include file="../backend.jspf" %>