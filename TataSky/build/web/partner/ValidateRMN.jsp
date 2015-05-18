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
        String LZ_SubscriberID = "";
        String LZ_tempSubscriberID = "";
        String LZ_UsrANI = ""; // This is used to store the ANI of the call.
        String LZ_RMN = ""; // This is used to store the RMN of the caller.
        String LZ_CheckRMNInvalid = ""; // this is used to check whether RMN returned after calling getSubscriberProfileByRmn
        String LZ_DBCallDetailID = ""; // This is used to store the call detail ID.
        try {
//            LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
//            LZ_DBCallDetailID = state.getString("LZ_DBCallDetailID");
//            LZ_RMN = state.getString("LZ_RMN");
              LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");
              LZ_DBCallDetailID = state.optString("LZ_DBCallDetailID","");
              LZ_RMN = state.optString("LZ_RMN","");            

            if (LZ_SimulatorMode) {
                LZ_IsSuccess = "Y";
            } else {
                Document docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);

                String LZ_BA_XML = new DBAccess().getSubscriberProfileByRmn(LZ_RMN, LZ_DBCallDetailID);

                LZ_CheckRMNInvalid = LZ_BA_XML.substring(LZ_BA_XML.indexOf("<BA_SUBSCRIBER_ID>"), LZ_BA_XML.indexOf("</BA_SUBSCRIBER_ID>"));

                if (!LZ_CheckRMNInvalid.isEmpty()) {
                    if (!LZ_BA_XML.isEmpty()) {
                        Document docTemp1 = XMLAO.buildXMLDocument("<BA_ROOT>" + LZ_BA_XML + "</BA_ROOT>");
                        String LZ_CallerType = XMLAO.getNodeValueText(docTemp1, "BA_CALLER_TYPE");
                        LZ_SubscriberID = XMLAO.getNodeValueText(docTemp1, "BA_SUBSCRIBER_ID");
                        if (LZ_CallerType.equals("RMN")) {

                            LZ_IsSuccess = "Y";

                            System.out.println("LZ_BA_XML-Rishi-1:" + LZ_CallerType);
                            if (LZ_SubscriberID.isEmpty()) {
                                System.out.println("LZ_SubscriberID IS NULL" + LZ_SubscriberID);
                                LZ_SubscriberID = "3000724660";
                            }
                            
                            Document docTemp = XMLAO.buildXMLDocument("<BA_ROOT>" + LZ_BA_XML + "</BA_ROOT>");
                            StringBuilder sbBA = new StringBuilder("<BA_ROOT><BA_SUBSCRIBER_ID>" + LZ_SubscriberID + "</BA_SUBSCRIBER_ID>");

                            sbBA.append("<BA_PREMIUM_FLAG>" + XMLAO.getNodeValueText(docTemp, "BA_PREMIUM_FLAG") + "</BA_PREMIUM_FLAG>");
                            sbBA.append("<BA_ACCOUNT_STATUS>" + XMLAO.getNodeValueText(docTemp, "BA_ACCOUNT_STATUS") + "</BA_ACCOUNT_STATUS>");
                            sbBA.append("<BA_ACCOUNT_SUB_STATUS>" + XMLAO.getNodeValueText(docTemp, "BA_ACCOUNT_SUB_STATUS") + "</BA_ACCOUNT_SUB_STATUS>");
                            sbBA.append("<BA_SUBSCRIBER_ID_COUNT>" + XMLAO.getNodeValueText(docTemp, "BA_SUBSCRIBER_ID_COUNT") + "</BA_SUBSCRIBER_ID_COUNT>");

                            LZ_BA_XML = new DBAccess().getAccountDetail(LZ_SubscriberID, "");

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


                            
                            LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("<BA_ROOT>", sbBA.toString());

                        }
                    }
                } else {
                    LZ_IsSuccess = "N";
                }
            }
        } catch (Exception ex) {
            Logger.error(LZ_DBCallDetailID, " Exception in ValidateRMN Page : " + ex.getMessage(), false);
        }finally {
            LZ_SubscriberID = LZ_tempSubscriberID = LZ_UsrANI = LZ_RMN = LZ_CheckRMNInvalid = LZ_DBCallDetailID = null;
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