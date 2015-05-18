<%@page language="java" contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.tsg.database.DBAccess"%>
<%@page import="com.tsg.common.*"%>
<%@page import="com.tsg.log.Logger"%>
<%@page import="com.tsg.util.Util"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean LZ_SimulatorMode = false; // Simulator Mode by default is set to true.
        String LZ_CallFlowDetailXML = ""; // This is used to store the call flow detail XML.
        String LZ_DBCallDetailID = ""; // This is used to store the call detail ID.
        String LZ_BACallerType = ""; // Type of the caller (Subscriber/Partner/Prospect etc.)
        String LZ_BAPremiumFlag = ""; // Premium flag whether the subscriber is premium or not
        String LZ_BASTBType = ""; // Type of the STB (HD, SD etc.)
        String LZ_BAAccountStatus = ""; // Account status (Active/De-Active)
        String LZ_BANationalPromoFlag = ""; // National Promo Flag
        String LZ_BAState = ""; // State which the subscription belongs to
        String LZ_BAPincode = ""; // PIN code which the subscription belongs to
        String LZ_BASPMCampaignFlag = ""; // Personal campaign associated to subscriber flag
        String LZ_BASubscriptionType = ""; // Monthly/LDP etc.
        String LZ_BAAccountSubStatus = ""; // Subscription sub status (Partially done etc.)
        String LZ_BACampaignFlag = ""; // Flag to denote whether campaign is enabled or not
        String LZ_BACampaignCode1 = "";
        String LZ_BACampaignCode2 = "";
        String LZ_BACampaignCode3 = "";
        String LZ_CampaignCode = "";
        String LZ_BARMN = "";
        String LZ_BASubscriberID = ""; // Subscriber ID
        String LZ_CurrentDate="";
        try {
//            LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
//            LZ_DBCallDetailID = state.getString("LZ_DBCallDetailID");
            LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML", "");
            LZ_DBCallDetailID = state.optString("LZ_DBCallDetailID", "");
            Logger.info(LZ_DBCallDetailID, " Retrieve Promo Details Input = CallFlowDetailXML : " + LZ_CallFlowDetailXML, false);

            if (LZ_SimulatorMode) {
            } else {
                Document docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);
                LZ_BARMN = XMLAO.getNodeValueText(docBA, "BA_RMN");
                LZ_BACallerType = XMLAO.getNodeValueText(docBA, "BA_CALLER_TYPE");
                LZ_BAPremiumFlag = XMLAO.getNodeValueText(docBA, "BA_PREMIUM_FLAG");
                LZ_BASTBType = XMLAO.getNodeValueText(docBA, "BA_STB_TYPE");
                LZ_BAAccountStatus = XMLAO.getNodeValueText(docBA, "BA_ACCOUNT_STATUS");

                LZ_BANationalPromoFlag = ConfigurationReader.configList.get("NATIONAL_PROMO_FLAG");

                LZ_BASubscriberID = XMLAO.getNodeValueText(docBA, "BA_SUBSCRIBER_ID");
                String LZ_BA_XML = new DBAccess().getStasStateCodeBySubscId(LZ_BASubscriberID, LZ_DBCallDetailID);
                XMLAO.deleteNode(docBA, "BA_STATE");
                XMLAO.deleteNode(docBA, "BA_PIN_CODE");
                LZ_CallFlowDetailXML = XMLAO.getNodeOuterXML(docBA);
                LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("<BA_ROOT>", "<BA_ROOT>" + LZ_BA_XML);
                docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);

                LZ_BAState = XMLAO.getNodeValueText(docBA, "BA_STATE");
                LZ_BAPincode = XMLAO.getNodeValueText(docBA, "BA_PIN_CODE");
                LZ_BASPMCampaignFlag = XMLAO.getNodeValueText(docBA, "BA_SPM_CAMPAIGN_FLAG");
                LZ_BASubscriptionType = XMLAO.getNodeValueText(docBA, "BA_SUBSCRIPTION_TYPE");
                LZ_BAAccountSubStatus = XMLAO.getNodeValueText(docBA, "BA_ACCOUNT_SUB_STATUS");
                LZ_BACampaignFlag = XMLAO.getNodeValueText(docBA, "BA_CAMPAIGN_FLAG");
                if (LZ_BACampaignFlag.equals("Y")) {
                    LZ_BACampaignCode1 = XMLAO.getNodeValueText(docBA, "BA_CAMPAIGN1");
                    LZ_BACampaignCode2 = XMLAO.getNodeValueText(docBA, "BA_CAMPAIGN2");
                    LZ_BACampaignCode3 = XMLAO.getNodeValueText(docBA, "BA_CAMPAIGN3");

                    if (LZ_BACampaignCode1.isEmpty()) {
                        if (LZ_BACampaignCode2.isEmpty()) {
                            if (!LZ_BACampaignCode3.isEmpty()) {
                                LZ_CampaignCode = LZ_BACampaignCode3;
                            }
                        } else {
                            LZ_CampaignCode = LZ_BACampaignCode2;
                        }
                    } else {
                        LZ_CampaignCode = LZ_BACampaignCode1;
                    }
                }

                LZ_BA_XML = null;
                LZ_CurrentDate = Util.getCurrentDate();
            }
        } catch (Exception ex) {
            Logger.error(LZ_DBCallDetailID, " Exception in RetrievePromoDetails Page : " + ex.getMessage(), false);
        } finally {
            Logger.info(LZ_DBCallDetailID, " Retrieve Promo Details Output = LZ_BARMN : " + LZ_BARMN + " LZ_CurrentDate : " + LZ_CurrentDate + " LZ_BACallerType : " + LZ_BACallerType
                    + " LZ_BAPremiumFlag : " + LZ_BAPremiumFlag + " LZ_BASTBType : " + LZ_BASTBType + " LZ_BAAccountStatus : " + LZ_BAAccountStatus
                    + " LZ_BANationalPromoFlag : " + LZ_BANationalPromoFlag + " LZ_BAState : " + LZ_BAState + " LZ_BAPincode : " + LZ_BAPincode
                    + " LZ_BASPMCampaignFlag : " + LZ_BASPMCampaignFlag + " LZ_BASubscriptionType : " + LZ_BASubscriptionType + " LZ_BAAccountSubStatus : " + LZ_BAAccountSubStatus
                    + " LZ_BACampaignFlag : " + LZ_BACampaignFlag + " LZ_CampaignCode : " + LZ_CampaignCode, false);

            LZ_DBCallDetailID =  null;
        }

        JSONObject result = new JSONObject();
        result.put("BARMN", LZ_BARMN);
        result.put("BACurrentDate", LZ_CurrentDate);
        result.put("BACallerType", LZ_BACallerType);
        result.put("BAPremiumFlag", LZ_BAPremiumFlag);
        result.put("BASTBType", LZ_BASTBType);
        result.put("BAAccountStatus", LZ_BAAccountStatus);
        result.put("BANationalPromoFlag", LZ_BANationalPromoFlag);
        result.put("BAState", LZ_BAState);
        result.put("BAPincode", LZ_BAPincode);
        result.put("BASPMCampaignFlag", LZ_BASPMCampaignFlag);
        result.put("BASubscriptionType", LZ_BASubscriptionType);
        result.put("BAAccountSubStatus", LZ_BAAccountSubStatus);
        result.put("CallFlowDetailXML", LZ_CallFlowDetailXML);
        result.put("CampaignFlag", LZ_BACampaignFlag);
        result.put("CampaignCode", LZ_CampaignCode);

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