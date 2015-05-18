<%@page language="java" contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.tsg.database.DBAccess"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean LZ_SimulatorMode = false; // Simulator Mode by default is set to true.
        String LZ_CallFlowDetailXML = ""; // This is used to store the call flow detail XML.




        String LZ_BAPremiumFlag = ""; // Premium flag whether the subscriber is premium or not
        String LZ_BAActivationDateDifference = "";
        String LZ_DBCallDetailID = ""; // This is used to store the call detail ID.
        String LZ_BASubscriberID = ""; // Subscriber ID
        String LZ_BAAccountStatus = ""; // Account status (Active/De-Active)


        try {

            LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML", "");
            LZ_DBCallDetailID = state.optString("LZ_DBCallDetailID", "");
            Logger.info(LZ_DBCallDetailID, " RetrieveIVRByPassDetails Input =:> CallFlowDetailXML : " + LZ_CallFlowDetailXML, false);
            if (LZ_SimulatorMode) {
                //Testing....
            } else {

                LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML", "");
                LZ_DBCallDetailID = state.optString("LZ_DBCallDetailID", "");

                Logger.info(LZ_DBCallDetailID, " RetrieveNADDetails Input =:> CallFlowDetailXML : " + LZ_CallFlowDetailXML, false);

                Document docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);

                LZ_BASubscriberID = XMLAO.getNodeValueText(docBA, "BA_SUBSCRIBER_ID");
                LZ_BAPremiumFlag = XMLAO.getNodeValueText(docBA, "BA_PREMIUM_FLAG");
                LZ_BAActivationDateDifference = XMLAO.getNodeValueText(docBA, "BA_ACTV_DATE_DIFFERENCE");
                LZ_BAAccountStatus = XMLAO.getNodeValueText(docBA, "BA_ACCOUNT_STATUS");

                Logger.info(LZ_DBCallDetailID, " RetrieveNADDetails Input = LZ_BASubscriberID : " + LZ_BASubscriberID
                        + " LZ_BAActivationDateDifference : " + LZ_BAActivationDateDifference, false);

            }
        } catch (Exception ex) {
            //ex.printStackTrace();
            Logger.error(LZ_DBCallDetailID, " Exception in RetrieveIVRByPassDetails Page : " + ex.getMessage(), false);
        } finally {

            Logger.info(LZ_DBCallDetailID, " RetrieveNADDetails Output = LZ_PremiumFlag : " + LZ_BAPremiumFlag
                    + " LZ_BAActivationDateDifference : " + LZ_BAActivationDateDifference, false);

            LZ_DBCallDetailID = LZ_BASubscriberID = null;

        }

        //LZ_BAActivationDateDifference = "80";	
        JSONObject result = new JSONObject();
        result.put("BASubscriberID", LZ_BASubscriberID);
        result.put("DBCallDetailID", LZ_DBCallDetailID);
        result.put("BAActivationDateDifference", LZ_BAActivationDateDifference);
        result.put("BAPremiumFlag", LZ_BAPremiumFlag);
        result.put("BAAccountStatus", LZ_BAAccountStatus);

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