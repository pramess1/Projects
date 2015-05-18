<%@page language="java" contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.tsg.database.DBAccess"%>
<%@page import="com.tsg.common.*"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean LZ_SimulatorMode = false; // Simulator Mode by default is set to true.
        String LZ_CallFlowDetailXML = ""; // This is used to store the call flow detail XML.
        String LZ_DBCallDetailID = ""; // This is used to store the call detail ID.
        String LZ_RuleID = ""; // This is used to store the rule ID.
        String LZ_CallFlowID = ""; // This is used to store the call flow ID sent by other call flows.
        String LZ_BASubscriberID = ""; // Subscriber ID
        String LZ_BASubscriberIDCount = ""; // Number of subscribers for a particular RMN
        String LZ_BAAccountBalance = ""; // Account balance for a particular subsccriber ID
        String LZ_OverDueAmount = ""; // This is used to store the overdue amount in case of negative account balance.
        String LZ_BASubscriptionType = ""; // Monthly/FDP/LDP etc.
        String LZ_BARechargeDueDate = ""; // Recharge due date
        String LZ_BAPremiumFlag = "";
        String LZ_DynamicCallFlowXML = ""; // This is used to store the callflow in XML format.
        String LZ_PromptAccountBalance = "3401.wav"; // This is used to store the account balance prompt file name.
        String LZ_PromptOverDueAmount = "3407.wav"; // This is used to store the over due amount prompt file name.
        String LZ_PromptRechargeDueDate = "3402.wav"; // This is used to store the recharge due date prompt file name.
        String LZ_PromptRenewDate = "7262.wav"; // This is used to store the renew date prompt file name.
        String LZ_NUANCE_URL = ""; // This is used to store the NUANCE URL.

        try {
//            LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
//            LZ_DBCallDetailID = state.getString("LZ_DBCallDetailID");
//            LZ_RuleID = state.getString("LZ_RuleID");
//            LZ_CallFlowID = state.getString("LZ_CallFlowID");
              LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");
              LZ_DBCallDetailID = state.optString("LZ_DBCallDetailID","");
              LZ_RuleID = state.optString("LZ_RuleID","");
              LZ_CallFlowID = state.optString("LZ_CallFlowID","");            
              Logger.info(LZ_DBCallDetailID, "RetrieveBalanceDueDateDetails Input = LZ_RuleID : " + LZ_RuleID + " LZ_CallFlowID : " + LZ_CallFlowID, false);
            if (LZ_SimulatorMode) {
                //Test
            } else {
                StringBuilder sbDCF = new StringBuilder("");
                Document docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);
                LZ_BASubscriberID = XMLAO.getNodeValueText(docBA, "BA_SUBSCRIBER_ID");
                LZ_BASubscriberIDCount = XMLAO.getNodeValueText(docBA, "BA_SUBSCRIBER_ID_COUNT");
                LZ_BASubscriptionType = XMLAO.getNodeValueText(docBA, "BA_SUBSCRIPTION_TYPE");
                String LZ_BA_XML = new DBAccess().getAccountDetail(LZ_BASubscriberID, LZ_DBCallDetailID);
                XMLAO.deleteNode(docBA, "BA_ACCOUNT_BALANCE");
                XMLAO.deleteNode(docBA, "BA_RECHARGE_DUE_DATE");
                XMLAO.deleteNode(docBA, "BA_FDP_RENEW_DATE");
                XMLAO.deleteNode(docBA, "BA_LAST_RECHARGE_AMT");
                XMLAO.deleteNode(docBA, "BA_LAST_RECHARGE_DATETIME");
                XMLAO.deleteNode(docBA, "BA_SUGGESTED_RECHARGE");
                LZ_CallFlowDetailXML = XMLAO.getNodeOuterXML(docBA);
                LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("<BA_ROOT>", "<BA_ROOT>" + LZ_BA_XML);
                docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);
                LZ_BAAccountBalance = XMLAO.getNodeValueText(docBA, "BA_ACCOUNT_BALANCE");
                LZ_BAPremiumFlag = XMLAO.getNodeValueText(docBA, "BA_PREMIUM_FLAG");
                if (!LZ_BAAccountBalance.trim().isEmpty()) {
                    float LZ_tempBalance = Float.parseFloat(LZ_BAAccountBalance);
                    if (LZ_tempBalance == 0) {
                        LZ_BAAccountBalance = "";
                        LZ_OverDueAmount = "";
                    } else if (LZ_tempBalance < 0) {
                        LZ_tempBalance = LZ_tempBalance * (-1);
                        LZ_OverDueAmount = String.valueOf(LZ_tempBalance);
                        LZ_BAAccountBalance = "";
                    } else {
                        LZ_BAAccountBalance = String.valueOf(LZ_tempBalance);
                    }
                } else {
                    LZ_BAAccountBalance = "";
                    LZ_OverDueAmount = "";
                }
                if (LZ_BASubscriptionType.equals("Monthly")) {
                    LZ_BARechargeDueDate = XMLAO.getNodeValueText(docBA, "BA_RECHARGE_DUE_DATE");
                } else if (LZ_BASubscriptionType.equals("FDP") || LZ_BASubscriptionType.equals("Semi-Annual")) {
                    LZ_BARechargeDueDate = XMLAO.getNodeValueText(docBA, "BA_FDP_RENEW_DATE");
                } else if (LZ_BASubscriptionType.equals("LDP")) {
                    LZ_BARechargeDueDate = XMLAO.getNodeValueText(docBA, "BA_LDP_RENEW_DATE");
                }
                if (!LZ_BARechargeDueDate.trim().isEmpty()) {
                    DateFormat LZ_DateFormat = new SimpleDateFormat("yyyy-MM-dd");
                    Date LZ_tempDueDate = LZ_DateFormat.parse(LZ_BARechargeDueDate);
                    LZ_BARechargeDueDate = LZ_DateFormat.format(LZ_tempDueDate).toString();
                } else {
                    LZ_BARechargeDueDate = "";
                }

                if (!LZ_BAAccountBalance.isEmpty() || !LZ_OverDueAmount.isEmpty() || !LZ_BARechargeDueDate.isEmpty()) {
                    sbDCF.append("<CallFlow CDID=\"" + LZ_DBCallDetailID + "\" RuleID=\"" + LZ_RuleID + "\">");

                    if (!LZ_BAAccountBalance.isEmpty()) {
                        sbDCF.append("<Prompt CFID=\"" + LZ_CallFlowID + "\">" + LZ_PromptAccountBalance + "</Prompt>");
                        sbDCF.append("<Prompt CFID=\"\">" + LZ_BAAccountBalance + "</Prompt>");
                    }

                    if (!LZ_OverDueAmount.isEmpty()) {
                        sbDCF.append("<Prompt CFID=\"" + LZ_CallFlowID + "\">" + LZ_PromptOverDueAmount + "</Prompt>");
                        sbDCF.append("<Prompt CFID=\"\">" + LZ_OverDueAmount + "</Prompt>");
                    }

                    if (!LZ_BARechargeDueDate.isEmpty()) {
                        if (LZ_BASubscriptionType.equals("Monthly")) {
                            sbDCF.append("<Prompt CFID=\"" + LZ_CallFlowID + "\">" + LZ_PromptRechargeDueDate + "</Prompt>");
                        } else if (LZ_BASubscriptionType.equals("FDP") || LZ_BASubscriptionType.equals("LDP") || LZ_BASubscriptionType.equals("Semi-Annual")) {
                            sbDCF.append("<Prompt CFID=\"" + LZ_CallFlowID + "\">" + LZ_PromptRenewDate + "</Prompt>");
                        }

                        sbDCF.append("<Prompt CFID=\"\">" + LZ_BARechargeDueDate + "</Prompt>");
                    }

                    
                    int LZ_tempCount = Integer.parseInt(LZ_BASubscriberIDCount);

                    if (LZ_BAPremiumFlag.equals("Y")) {
                        if (LZ_tempCount > 1) {
                            sbDCF.append("<Prompt CFID=\"272\">7220.wav</Prompt><Menu CFID=\"100\">9011.wav</Menu><Menu CFID=\"9001\">5029.wav</Menu><Menu CFID=\"9002\">5030.wav</Menu><Menu CFID=\"105\">9018.wav</Menu><Menu CFID=\"910\">7030.wav</Menu><Menu CFID=\"905\">7013.wav</Menu><Menu CFID=\"904\">7223.wav</Menu><Menu CFID=\"906\">7018.wav</Menu></CallFlow>");
                        } else {
                            sbDCF.append("<Prompt CFID=\"272\">7220.wav</Prompt><Menu CFID=\"100\">9011.wav</Menu><Menu CFID=\"9001\">5029.wav</Menu><Menu CFID=\"9002\">5030.wav</Menu><Menu CFID=\"910\">7030.wav</Menu><Menu CFID=\"905\">7013.wav</Menu><Menu CFID=\"904\">7223.wav</Menu><Menu CFID=\"906\">7018.wav</Menu></CallFlow>");
                        }
                    } else {
                        if (LZ_tempCount > 1) {
                            sbDCF.append("<Prompt CFID=\"272\">7220.wav</Prompt><Menu CFID=\"100\">9011.wav</Menu><Menu CFID=\"9000\">9046.wav</Menu><Menu CFID=\"105\">9018.wav</Menu><Menu CFID=\"910\">7030.wav</Menu><Menu CFID=\"905\">7013.wav</Menu><Menu CFID=\"904\">7223.wav</Menu><Menu CFID=\"906\">7018.wav</Menu></CallFlow>");
                        } else {
                            sbDCF.append("<Prompt CFID=\"272\">7220.wav</Prompt><Menu CFID=\"100\">9011.wav</Menu><Menu CFID=\"9000\">9046.wav</Menu><Menu CFID=\"910\">7030.wav</Menu><Menu CFID=\"905\">7013.wav</Menu><Menu CFID=\"904\">7223.wav</Menu><Menu CFID=\"906\">7018.wav</Menu></CallFlow>");
                        }
                    }
                }
                LZ_DynamicCallFlowXML = sbDCF.toString();
                LZ_NUANCE_URL = ConfigurationReader.configList.get("NUANCE_URL");
            }
        } catch (Exception ex) {
            Logger.error(LZ_DBCallDetailID, " Exception in  Retrieve Balance DueDate Details Page : " + ex.getMessage(), false);
        } finally{
            Logger.info(LZ_DBCallDetailID, "RetrieveBalanceDueDateDetails Output = LZ_NUANCE_URL : " + LZ_NUANCE_URL, false);
          LZ_DBCallDetailID = LZ_RuleID = LZ_CallFlowID = LZ_BASubscriberID = LZ_BASubscriberIDCount = LZ_BAAccountBalance = LZ_OverDueAmount = LZ_BASubscriptionType = LZ_BARechargeDueDate = LZ_BAPremiumFlag = LZ_PromptAccountBalance = LZ_PromptOverDueAmount = LZ_PromptRechargeDueDate = LZ_PromptRenewDate = null;  
        }

        JSONObject result = new JSONObject();
        result.put("DynamicCallFlowXML", LZ_DynamicCallFlowXML);
        result.put("CallFlowDetailXML", LZ_CallFlowDetailXML);
        result.put("NUANCE_URL", LZ_NUANCE_URL);

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

<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<%@include file="../backend.jspf" %>