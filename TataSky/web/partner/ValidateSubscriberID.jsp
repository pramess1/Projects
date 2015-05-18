<%@page language="java" contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.tsg.database.DBAccess"%>
<%@page import="com.tsg.database.gg.dataaccess.CheckValidSubscriberByCliDAO"%>
<%@page import="com.tsg.common.*"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean LZ_SimulatorMode = false; // Simulator Mode by default is set to true.
        String LZ_CallFlowDetailXML = ""; // This is used to store the call flow detail XML.
        String LZ_IsSuccess = "N"; // This is used to store the success status.
        String LZ_DBCallDetailID = ""; // This is used to store the call detail ID.
        String LZ_SubscriberID = ""; // This is used to store the subscriber ID entered.
        String LZ_SubStrSubIDFromLZxml = "";

        try {
//            LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
//            LZ_SubscriberID = state.getString("LZ_SubscriberID");
//            LZ_DBCallDetailID = state.getString("LZ_DBCallDetailID");
              LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");
              LZ_SubscriberID = state.optString("LZ_SubscriberID","");
              LZ_DBCallDetailID = state.optString("LZ_DBCallDetailID","");            
            if (LZ_SimulatorMode) {
                LZ_IsSuccess = "Y";
            } else {
                Document docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);

                String LZ_tempSubscriberID = XMLAO.getNodeValueText(docBA, "BA_SUBSCRIBER_ID");
                String LZ_BA_XML = "";

                if (LZ_tempSubscriberID.isEmpty()) {
                    LZ_BA_XML = new DBAccess().getProfileBySubscriberId(LZ_SubscriberID,LZ_DBCallDetailID);
                } else {
                    if (LZ_tempSubscriberID.equals(LZ_SubscriberID)) {
                        LZ_IsSuccess = "Y";
                    } else {
                        LZ_BA_XML = new DBAccess().getProfileBySubscriberId(LZ_SubscriberID,LZ_DBCallDetailID);
                    }
                }

                System.out.println("LZ_BA_XML second: " + LZ_BA_XML);

                LZ_SubStrSubIDFromLZxml = LZ_BA_XML.substring(LZ_BA_XML.indexOf("<BA_SUBSCRIBER_ID>") + 18, LZ_BA_XML.indexOf("</BA_SUBSCRIBER_ID>"));


                if (!LZ_SubStrSubIDFromLZxml.isEmpty()) {
                    if (!LZ_BA_XML.isEmpty()) {
                        LZ_IsSuccess = "Y";
                        Document docTemp = XMLAO.buildXMLDocument("<BA_ROOT>" + LZ_BA_XML + "</BA_ROOT>");
                        StringBuilder sbBA = new StringBuilder("<BA_ROOT><BA_SUBSCRIBER_ID>" + LZ_SubscriberID + "</BA_SUBSCRIBER_ID>");

                        sbBA.append("<BA_PREMIUM_FLAG>" + XMLAO.getNodeValueText(docTemp, "BA_PREMIUM_FLAG") + "</BA_PREMIUM_FLAG>");
                        sbBA.append("<BA_ACCOUNT_STATUS>" + XMLAO.getNodeValueText(docTemp, "BA_ACCOUNT_STATUS") + "</BA_ACCOUNT_STATUS>");
                        sbBA.append("<BA_ACCOUNT_SUB_STATUS>" + XMLAO.getNodeValueText(docTemp, "BA_ACCOUNT_SUB_STATUS") + "</BA_ACCOUNT_SUB_STATUS>");

                        LZ_BA_XML = new DBAccess().getAccountDetail(LZ_SubscriberID,LZ_DBCallDetailID);


                        sbBA.append(LZ_BA_XML);

                        if (!LZ_tempSubscriberID.isEmpty()) {
                            int LZ_StartIndex = LZ_CallFlowDetailXML.indexOf("<BA_SUBSCRIBER_ID>");
                            int LZ_EndIndex = LZ_CallFlowDetailXML.indexOf("</BA_SUGGESTED_RECHARGE>", LZ_StartIndex);

                            if (LZ_EndIndex < LZ_StartIndex) {
                                LZ_EndIndex = LZ_CallFlowDetailXML.indexOf("<BA_SUGGESTED_RECHARGE/>", LZ_StartIndex) + 24;
                            } else {
                                LZ_EndIndex = LZ_EndIndex + 24;
                            }

                            String LZ_temp = LZ_CallFlowDetailXML.substring(LZ_StartIndex, LZ_EndIndex);
                            LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace(LZ_temp, "");
                        }


                       // sbBA.append("</BA_ROOT>");


                        LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("<BA_ROOT>", sbBA.toString());
                    }
                } else {
                    LZ_IsSuccess = "N";
                }
            }
        } catch (Exception ex) {
            Logger.error(LZ_DBCallDetailID, " Exception in  Page : " + ex.getMessage(), false);
        }finally {
            LZ_DBCallDetailID = LZ_SubscriberID = LZ_SubStrSubIDFromLZxml = null;
        }

        JSONObject result = new JSONObject();
        result.put("IsSuccess", LZ_IsSuccess);
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