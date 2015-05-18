<%@page language="java" contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.tsg.database.DBAccess"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean LZ_SimulatorMode = false; // Simulator Mode by default is set to true.
        String LZ_CallFlowDetailXML = ""; // This is used to store the call flow detail XML.
        String LZ_DBCallDetailID = ""; // This is used to store the call detail ID.
        String LZ_BASubscriberID = ""; // Subscriber ID
        String LZ_PremiumFlag1 = "";

        try {

//            LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
//
//            LZ_DBCallDetailID = state.getString("LZ_DBCallDetailID");

            LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");

            LZ_DBCallDetailID = state.optString("LZ_DBCallDetailID","");
            
            if (LZ_SimulatorMode) {
                //
            } else {
                Document docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);

                LZ_BASubscriberID = XMLAO.getNodeValueText(docBA, "BA_SUBSCRIBER_ID");

                LZ_PremiumFlag1 = XMLAO.getNodeValueText(docBA, "BA_PREMIUM_FLAG1");

                String LZ_BA_XML = new DBAccess().getAccountDetail(LZ_BASubscriberID, LZ_DBCallDetailID);

                LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("<BA_ROOT>", "<BA_ROOT>" + LZ_BA_XML  );

                LZ_BA_XML = new DBAccess().getDetailBySubscriberId(LZ_BASubscriberID, LZ_PremiumFlag1, LZ_DBCallDetailID);

                LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("<BA_ROOT>","<BA_ROOT>" + LZ_BA_XML  );
            }
        } catch (Exception ex) {

            Logger.error(LZ_DBCallDetailID, " Exception in RetrieveAccountRechargeDetails Page : " + ex.getMessage(), false);
        } finally{
        
         LZ_DBCallDetailID = LZ_BASubscriberID = LZ_PremiumFlag1 = null;
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