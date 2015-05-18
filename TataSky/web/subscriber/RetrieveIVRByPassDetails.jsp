<%@page language="java" contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.tsg.database.DBAccess"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean LZ_SimulatorMode = false; // Simulator Mode by default is set to true.
        String LZ_CallFlowDetailXML = ""; // This is used to store the call flow detail XML.

        String LZ_BAIVRByPassFlag = ""; // IVR Bypass Flag
        String LZ_BACallerType = ""; // Type of the caller (Subscriber/Partner/Prospect etc.)
        String LZ_BASubscriberIDCount = ""; // Number of subscribers for a particular RMN
        String LZ_BAPremiumFlag = ""; // Premium flag whether the subscriber is premium or not
        String LZ_BASPMCampaignFlag = ""; // Personal campaign associated to subscriber flag
        String LZ_BACLIRepeatCallerFlag = ""; // Flag to denote whether the caller is a repeat caller by CLI
        String LZ_BAOpenEscalationFlag = ""; // If the SR is flagged as Open Escalation
        String LZ_BASROpenFlag = ""; // Flag to denote whether an SR is open or not
        String LZ_BASRRepeatFlag = ""; // Flag to denote whether it is an SR repeat
        String LZ_BAWOOpenFlag = ""; // Flag to denote whether an WO is open or not
        String LZ_BAWORepeatFlag = ""; // Flag to denote whether it is an WO repeat
        String LZ_BANDNCFlag = ""; // If the CLI is flagged as NDNC
        String LZ_BASTBType = ""; // Type of the STB (HD, SD etc.)
        String LZ_BASubscriptionType = ""; // Monthly/LDP etc.
        String LZ_BAAccountStatus = ""; // Account status (Active/De-Active)
        String LZ_BACampaignFlag = ""; // Flag to denote whether campaign is enabled or not
        String LZ_DBCallDetailID = ""; // This is used to store the call detail ID.
        String LZ_BASubscriberID = ""; // Subscriber ID

        String LZ_PremiumFlag1 = "";

        try {
//            LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
//            LZ_DBCallDetailID = state.getString("LZ_DBCallDetailID");
            LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML", "");
            LZ_DBCallDetailID = state.optString("LZ_DBCallDetailID", "");
            Logger.info(LZ_DBCallDetailID, " RetrieveIVRByPassDetails Input =:> CallFlowDetailXML : " + LZ_CallFlowDetailXML, false);
            if (LZ_SimulatorMode) {
                //Testing....
            } else {
                Document docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);

                LZ_BASubscriberID = XMLAO.getNodeValueText(docBA, "BA_SUBSCRIBER_ID");

                LZ_PremiumFlag1 = XMLAO.getNodeValueText(docBA, "BA_PREMIUM_FLAG1");

                Logger.info(LZ_DBCallDetailID, " RetrieveIVRByPassDetails Input = LZ_BASubscriberID : " + LZ_BASubscriberID + " LZ_PremiumFlag : " + LZ_PremiumFlag1, false);

                //System.out.println("By Pass Inputs = " + LZ_DBCallDetailID + "," + LZ_BASubscriberID + "," + LZ_PremiumFlag1);
                //String LZ_BA_XML = new DBAccess().getDetailBySubscriberId(LZ_BASubscriberID);
                String LZ_BA_XML = new DBAccess().getDetailBySubscriberId(LZ_BASubscriberID, LZ_PremiumFlag1, LZ_DBCallDetailID);

                // System.out.println("By Pass LZ_BA_XML: " + LZ_BA_XML);

                XMLAO.deleteNode(docBA, "BA_SPM_CAMPAIGN_FLAG");
                XMLAO.deleteNode(docBA, "BA_OPEN_ESCALATION_FLAG");
                XMLAO.deleteNode(docBA, "BA_SR_OPEN_FLAG");
                XMLAO.deleteNode(docBA, "BA_SR_REPEAT_FLAG");
                XMLAO.deleteNode(docBA, "BA_WO_OPEN_FLAG");
                XMLAO.deleteNode(docBA, "BA_WO_REPEAT_FLAG");
                XMLAO.deleteNode(docBA, "BA_NDNC_FLAG");
                XMLAO.deleteNode(docBA, "BA_STB_TYPE");
                XMLAO.deleteNode(docBA, "BA_SUBSCRIPTION_TYPE");
                XMLAO.deleteNode(docBA, "BA_CAMPAIGN1");
                XMLAO.deleteNode(docBA, "BA_CAMPAIGN_CODE1");
                XMLAO.deleteNode(docBA, "BA_CAMPAIGN_DESC1");
                XMLAO.deleteNode(docBA, "BA_CAMPAIGN2");
                XMLAO.deleteNode(docBA, "BA_CAMPAIGN_CODE2");
                XMLAO.deleteNode(docBA, "BA_CAMPAIGN_DESC2");
                XMLAO.deleteNode(docBA, "BA_CAMPAIGN3");
                XMLAO.deleteNode(docBA, "BA_CAMPAIGN_CODE3");
                XMLAO.deleteNode(docBA, "BA_CAMPAIGN_DESC3");
                XMLAO.deleteNode(docBA, "BA_CAMPAIGN_FLAG");
                XMLAO.deleteNode(docBA, "BA_SUB_AGENT_REPEAT_FLAG"); //BA_SUB_REPEAT_CALLER_FLAG
                XMLAO.deleteNode(docBA, "BA_SUB_IVR_REPEAT_FLAG");
                XMLAO.deleteNode(docBA, "BA_REPEAT_PACK_COUNT");
                XMLAO.deleteNode(docBA, "BA_REPEAT_RECHARGE_COUNT");
                XMLAO.deleteNode(docBA, "BA_SPMPACKNAME");
                XMLAO.deleteNode(docBA, "BA_SPMCAMPAIGNID");
                XMLAO.deleteNode(docBA, "BA_CALLCOUNTBYSUBID");

                LZ_CallFlowDetailXML = XMLAO.getNodeOuterXML(docBA);
                LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("<BA_ROOT>", "<BA_ROOT>" + LZ_BA_XML);
                docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);

                LZ_BAIVRByPassFlag = XMLAO.getNodeValueText(docBA, "BA_IVR_BYPASS_FLAG");
                LZ_BACallerType = XMLAO.getNodeValueText(docBA, "BA_CALLER_TYPE");
                LZ_BASubscriberIDCount = XMLAO.getNodeValueText(docBA, "BA_SUBSCRIBER_ID_COUNT");
                LZ_BAPremiumFlag = XMLAO.getNodeValueText(docBA, "BA_PREMIUM_FLAG");
                LZ_BASPMCampaignFlag = XMLAO.getNodeValueText(docBA, "BA_SPM_CAMPAIGN_FLAG");
                LZ_BACLIRepeatCallerFlag = XMLAO.getNodeValueText(docBA, "BA_CLI_REPEAT_CALLER_FLAG");
                LZ_BAOpenEscalationFlag = XMLAO.getNodeValueText(docBA, "BA_OPEN_ESCALATION_FLAG");
                LZ_BASROpenFlag = XMLAO.getNodeValueText(docBA, "BA_SR_OPEN_FLAG");
                LZ_BASRRepeatFlag = XMLAO.getNodeValueText(docBA, "BA_SR_REPEAT_FLAG");
                LZ_BAWOOpenFlag = XMLAO.getNodeValueText(docBA, "BA_WO_OPEN_FLAG");
                LZ_BAWORepeatFlag = XMLAO.getNodeValueText(docBA, "BA_WO_REPEAT_FLAG");
                LZ_BANDNCFlag = XMLAO.getNodeValueText(docBA, "BA_NDNC_FLAG");
                LZ_BASTBType = XMLAO.getNodeValueText(docBA, "BA_STB_TYPE");
                LZ_BASubscriptionType = XMLAO.getNodeValueText(docBA, "BA_SUBSCRIPTION_TYPE");
                LZ_BAAccountStatus = XMLAO.getNodeValueText(docBA, "BA_ACCOUNT_STATUS");
                LZ_BACampaignFlag = XMLAO.getNodeValueText(docBA, "BA_CAMPAIGN_FLAG");

                //System.out.println("LZ_BAIVRByPassFlag : "+LZ_BAIVRByPassFlag + " LZ_BACallerType : " + LZ_BACallerType + " LZ_BASubscriberIDCount : " + LZ_BASubscriberIDCount);		


                LZ_BA_XML = null;
            }
        } catch (Exception ex) {
            //ex.printStackTrace();
            Logger.error(LZ_DBCallDetailID, " Exception in RetrieveIVRByPassDetails Page : " + ex.getMessage(), false);
        } finally {

            Logger.info(LZ_DBCallDetailID, " RetrieveIVRByPassDetails Output = LZ_BAIVRByPassFlag : " + LZ_BAIVRByPassFlag + " LZ_BACallerType : " + LZ_BACallerType + " LZ_BASubscriberIDCount : " + LZ_BASubscriberIDCount, false);

            LZ_DBCallDetailID = LZ_BASubscriberID = LZ_PremiumFlag1 = null;

        }


        JSONObject result = new JSONObject();
        result.put("BAIVRByPassFlag", LZ_BAIVRByPassFlag);
        result.put("BACallerType", LZ_BACallerType);
        result.put("BASubscriberIDCount", LZ_BASubscriberIDCount);
        result.put("BAPremiumFlag", LZ_BAPremiumFlag);
        result.put("BASPMCampaignFlag", LZ_BASPMCampaignFlag);
        result.put("BACLIRepeatCallerFlag", LZ_BACLIRepeatCallerFlag);
        result.put("BAOpenEscalationFlag", LZ_BAOpenEscalationFlag);
        result.put("BASROpenFlag", LZ_BASROpenFlag);
        result.put("BASRRepeatFlag", LZ_BASRRepeatFlag);
        result.put("BAWOOpenFlag", LZ_BAWOOpenFlag);
        result.put("BAWORepeatFlag", LZ_BAWORepeatFlag);
        result.put("BANDNCFlag", LZ_BANDNCFlag);
        result.put("BASTBType", LZ_BASTBType);
        result.put("BASubscriptionType", LZ_BASubscriptionType);
        result.put("BAAccountStatus", LZ_BAAccountStatus);
        result.put("BACampaignFlag", LZ_BACampaignFlag);
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