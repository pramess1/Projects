<%@page language="java" contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean LZ_SimulatorMode = false; // Simulator Mode by default is set to true.
        String LZ_CallFlowDetailXML = ""; // This is used to store the call flow detail XML.
        String LZ_DBCallDetailID = ""; // This is used to store the call detail ID.
        String LZ_RuleID = ""; // This is used to store the rule ID.
        String LZ_PromptList = ""; // This is used to store the result prompt list.
        String LZ_CallFlowIDList = ""; // This is used to store the result call flow ID list.

        String LZ_BAAccountBalance = ""; // Account balance for a particular subsccriber ID
        String LZ_OverDueAmount = ""; // This is used to store the overdue amount in case of negative account balance.
        String LZ_BASubscriptionType = ""; // Monthly/FDP/LDP etc.
        String LZ_BARechargeDueDate = ""; // Recharge due date
        String LZ_NumberOfDaysLeft = ""; // This is used to store the number of days left.
        String LZ_BASuggestedRecharge = ""; // Suggested recharge value
        String LZ_BALastRechargeAmount = ""; // Last recharge amount
        String LZ_BALastRechargeDateTime = ""; // Last recharge date and time
        String LZ_BALastRechargeDate = ""; // Last recharge date
        String LZ_BALastRechargeTime = ""; // Last recharge time

        String LZ_DynamicCallFlowXML = ""; // This is used to store the callflow in XML format.

        String LZ_PromptAccountBalance = "3401.wav"; // This is used to store the account balance prompt file name.
        String LZ_PromptOverDueAmount = "3407.wav"; // This is used to store the over due amount prompt file name.
        String LZ_PromptDueDate = "3402.wav"; // This is used to store the due date prompt file name.
        String LZ_PromptPleaseRecharge = "3504.wav"; // This is used to store the please recharge prompt file name.
        String LZ_PromptOnBeforeRecharge = "3504_1.wav"; // This is used to store the on or before prompt file name.
        String LZ_PromptRechargeNext = "3015.wav"; // This is used to store the recharge next prompt file name.
        String LZ_PromptRechargeNextDays = "3015_1.wav"; // This is used to store the recharge next days prompt file name.
        String LZ_PromptBasePackage = "3503.wav"; // This is used to store the base package prompt file name.
        String LZ_PromptDuePackage = "3503_1.wav"; // This is used to store the due package prompt file name.
        String LZ_PromptRecommendedRecharge = "3400.wav"; // This is used to store the recommended recharge prompt file name.
        String LZ_PromptLastRechargeAmount = "3086.wav"; // This is used to store the last recharge amount prompt file name.
        String LZ_PromptLastRechargeDate = "3087.wav"; // This is used to store the last recharge date prompt file name.
        String LZ_PromptActive = "3405.wav"; // This is used to store the active prompt file name.
        String LZ_PromptPending = "3406.wav"; // This is used to store the pending prompt file name.
        String LZ_PromptDays = "days.wav"; // This is used to store the days prompt file name.
        String LZ_PromptAt = "at.wav"; // This is used to store the at prompt file name.

        String LZ_PromptContinue = "7029.wav"; // This is used to store the continue prompt file name.
        String LZ_PromptRepeatMessage = "7030.wav"; // This is used to store the repeat message prompt file name.

        try {
//            LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
//            LZ_DBCallDetailID = state.getString("LZ_DBCallDetailID");
//            LZ_RuleID = state.getString("LZ_RuleID");
//            LZ_PromptList = state.getString("LZ_PromptList");
//            LZ_CallFlowIDList = state.getString("LZ_CallFlowIDList");

            LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");
            LZ_DBCallDetailID = state.optString("LZ_DBCallDetailID","");
            LZ_RuleID = state.optString("LZ_RuleID","");
            LZ_PromptList = state.optString("LZ_PromptList","");
            LZ_CallFlowIDList = state.optString("LZ_CallFlowIDList","");                       
            if (LZ_SimulatorMode) {
                //Testing...
            } else {
                Document docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);
                String[] LZ_PromptListArray = null;
                String[] LZ_CallFlowIDListArray = null;

                if (LZ_PromptList.contains(",")) {
                    LZ_PromptListArray = LZ_PromptList.split(",");
                    LZ_CallFlowIDListArray = LZ_CallFlowIDList.split(",");
                } else {
                    LZ_PromptListArray = new String[1];
                    LZ_PromptListArray[0] = LZ_PromptList;
                    LZ_CallFlowIDListArray = new String[1];
                    LZ_CallFlowIDListArray[0] = LZ_CallFlowIDList;
                }

                StringBuilder sbDCF = new StringBuilder("<CallFlow CDID=\"" + LZ_DBCallDetailID + "\" RuleID=\"" + LZ_RuleID + "\">");

                for (int i = 0; i < LZ_PromptListArray.length; i++) {
                    if (LZ_PromptListArray[i].equals(LZ_PromptAccountBalance)
                            || LZ_PromptListArray[i].equals(LZ_PromptOverDueAmount)) {
                        LZ_BAAccountBalance = XMLAO.getNodeValueText(docBA, "BA_ACCOUNT_BALANCE");

                        if (!LZ_BAAccountBalance.trim().isEmpty()) {
                            float LZ_tempBalance = Float.parseFloat(LZ_BAAccountBalance);

                            if (LZ_tempBalance == 0) {
                                LZ_BAAccountBalance = "";
                            } else if (LZ_tempBalance < 0) {
                                LZ_tempBalance = LZ_tempBalance * (-1);
                                LZ_OverDueAmount = String.valueOf(LZ_tempBalance);

                                sbDCF.append("<Prompt CFID=\"" + LZ_CallFlowIDListArray[i] + "\">" + LZ_PromptOverDueAmount + "</Prompt>");
                                sbDCF.append("<Prompt CFID=\"\">" + LZ_OverDueAmount + "</Prompt>");
                            } else {
                                LZ_BAAccountBalance = String.valueOf(LZ_tempBalance);

                                sbDCF.append("<Prompt CFID=\"" + LZ_CallFlowIDListArray[i] + "\">" + LZ_PromptAccountBalance + "</Prompt>");
                                sbDCF.append("<Prompt CFID=\"\">" + LZ_BAAccountBalance + "</Prompt>");
                            }
                        }
                    } else if (LZ_PromptListArray[i].equals(LZ_PromptDueDate)) {
                        LZ_BASubscriptionType = XMLAO.getNodeValueText(docBA, "BA_SUBSCRIPTION_TYPE").trim();

                        if (!LZ_BASubscriptionType.isEmpty()) {
                            if (LZ_BASubscriptionType.equals("Monthly")) {
                                LZ_BARechargeDueDate = XMLAO.getNodeValueText(docBA, "BA_RECHARGE_DUE_DATE");
                            } else if (LZ_BASubscriptionType.equals("FDP") || LZ_BASubscriptionType.equals("Semi-Annual")) {
                                LZ_BARechargeDueDate = XMLAO.getNodeValueText(docBA, "BA_FDP_RENEW_DATE");
                            } else if (LZ_BASubscriptionType.equals("LDP")) {
                                LZ_BARechargeDueDate = XMLAO.getNodeValueText(docBA, "BA_LDP_RENEW_DATE");
                            }
                        }

                        if (!LZ_BARechargeDueDate.trim().isEmpty()) {
                            DateFormat LZ_DateFormat = new SimpleDateFormat("yyyy-MM-dd");
                            Date LZ_tempDueDate = LZ_DateFormat.parse(LZ_BARechargeDueDate);
                            LZ_BARechargeDueDate = LZ_DateFormat.format(LZ_tempDueDate).toString();

                            sbDCF.append("<Prompt CFID=\"" + LZ_CallFlowIDListArray[i] + "\">" + LZ_PromptListArray[i] + "</Prompt>");
                            sbDCF.append("<Prompt CFID=\"\">" + LZ_BARechargeDueDate + "</Prompt>");
                        }
                    } else if (LZ_PromptListArray[i].equals(LZ_PromptPleaseRecharge)) {
                        LZ_BASubscriptionType = XMLAO.getNodeValueText(docBA, "BA_SUBSCRIPTION_TYPE").trim();

                        if (!LZ_BASubscriptionType.isEmpty()) {
                            if (LZ_BASubscriptionType.equals("Monthly")) {
                                LZ_BARechargeDueDate = XMLAO.getNodeValueText(docBA, "BA_RECHARGE_DUE_DATE");
                            } else if (LZ_BASubscriptionType.equals("FDP") || LZ_BASubscriptionType.equals("Semi-Annual")) {
                                LZ_BARechargeDueDate = XMLAO.getNodeValueText(docBA, "BA_FDP_RENEW_DATE");
                            } else if (LZ_BASubscriptionType.equals("LDP")) {
                                LZ_BARechargeDueDate = XMLAO.getNodeValueText(docBA, "BA_LDP_RENEW_DATE");
                            }
                        }

                        if (!LZ_BARechargeDueDate.trim().isEmpty()) {
                            DateFormat LZ_DateFormat = new SimpleDateFormat("yyyy-MM-dd");
                            Date LZ_tempDueDate = LZ_DateFormat.parse(LZ_BARechargeDueDate);
                            LZ_BARechargeDueDate = LZ_DateFormat.format(LZ_tempDueDate).toString();

                            sbDCF.append("<Prompt CFID=\"" + LZ_CallFlowIDListArray[i] + "\">" + LZ_PromptListArray[i] + "</Prompt>");
                            sbDCF.append("<Prompt CFID=\"\">" + LZ_BARechargeDueDate + "</Prompt>");
                            sbDCF.append("<Prompt CFID=\"" + LZ_CallFlowIDListArray[i] + "\">" + LZ_PromptOnBeforeRecharge + "</Prompt>");
                        }
                    } else if (LZ_PromptListArray[i].equals(LZ_PromptRechargeNext)
                            || LZ_PromptListArray[i].equals(LZ_PromptBasePackage)) {
                        LZ_NumberOfDaysLeft = state.getString("LZ_NumberOfDaysLeft");

                        int LZ_tempNoOfDaysLeft = Integer.parseInt(LZ_NumberOfDaysLeft);

                        if (LZ_tempNoOfDaysLeft > 0) {
                            if (LZ_tempNoOfDaysLeft < 10) {
                                LZ_NumberOfDaysLeft = "cardinals/00" + LZ_NumberOfDaysLeft + ".wav";
                            } else {
                                LZ_NumberOfDaysLeft = "cardinals/0" + LZ_NumberOfDaysLeft + ".wav";
                            }

                            sbDCF.append("<Prompt CFID=\"" + LZ_CallFlowIDListArray[i] + "\">" + LZ_PromptListArray[i] + "</Prompt>");
                            sbDCF.append("<Prompt CFID=\"" + LZ_CallFlowIDListArray[i] + "\">" + LZ_NumberOfDaysLeft + "</Prompt>");
                            sbDCF.append("<Prompt CFID=\"" + LZ_CallFlowIDListArray[i] + "\">" + LZ_PromptDays + "</Prompt>");

                            if (LZ_PromptListArray[i].equals(LZ_PromptBasePackage)) {
                                sbDCF.append("<Prompt CFID=\"" + LZ_CallFlowIDListArray[i] + "\">" + LZ_PromptDuePackage + "</Prompt>");
                            } else if (LZ_PromptListArray[i].equals(LZ_PromptRechargeNext)) {
                                sbDCF.append("<Prompt CFID=\"" + LZ_CallFlowIDListArray[i] + "\">" + LZ_PromptRechargeNextDays + "</Prompt>");
                            }
                        }
                    } else if (LZ_PromptListArray[i].equals(LZ_PromptRecommendedRecharge)) {
                        LZ_BASuggestedRecharge = XMLAO.getNodeValueText(docBA, "BA_SUGGESTED_RECHARGE");
                        float LZ_tempSuggestedRecharge = Float.parseFloat(LZ_BASuggestedRecharge);
                        LZ_BASuggestedRecharge = String.valueOf(LZ_tempSuggestedRecharge);

                        sbDCF.append("<Prompt CFID=\"" + LZ_CallFlowIDListArray[i] + "\">" + LZ_PromptListArray[i] + "</Prompt>");
                        sbDCF.append("<Prompt CFID=\"\">" + LZ_BASuggestedRecharge + "</Prompt>");
                    } else if (LZ_PromptListArray[i].equals(LZ_PromptLastRechargeAmount)) {
                        LZ_BALastRechargeAmount = XMLAO.getNodeValueText(docBA, "BA_LAST_RECHARGE_AMT");
                        float LZ_tempLastRechargeAmount = Float.parseFloat(LZ_BALastRechargeAmount);
                        LZ_BALastRechargeAmount = String.valueOf(LZ_tempLastRechargeAmount);

                        sbDCF.append("<Prompt CFID=\"" + LZ_CallFlowIDListArray[i] + "\">" + LZ_PromptListArray[i] + "</Prompt>");
                        sbDCF.append("<Prompt CFID=\"\">" + LZ_BALastRechargeAmount + "</Prompt>");
                    } else if (LZ_PromptListArray[i].equals(LZ_PromptLastRechargeDate)) {
                        LZ_BALastRechargeDateTime = XMLAO.getNodeValueText(docBA, "BA_LAST_RECHARGE_DATETIME");

                        if (!LZ_BALastRechargeDateTime.trim().isEmpty()) {
                            DateFormat LZ_DateFormat = new SimpleDateFormat("yyyy-MM-dd");
                            DateFormat LZ_TimeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

                            Date LZ_tempDate = LZ_DateFormat.parse(LZ_BALastRechargeDateTime);
                            LZ_BALastRechargeDate = LZ_DateFormat.format(LZ_tempDate).toString();

                            LZ_tempDate = LZ_TimeFormat.parse(LZ_BALastRechargeDateTime);
                            LZ_BALastRechargeTime = LZ_TimeFormat.format(LZ_tempDate).toString();
                            LZ_BALastRechargeTime = LZ_BALastRechargeTime.split(" ")[1];

                            sbDCF.append("<Prompt CFID=\"" + LZ_CallFlowIDListArray[i] + "\">" + LZ_PromptListArray[i] + "</Prompt>");
                            sbDCF.append("<Prompt CFID=\"\">" + LZ_BALastRechargeDate + "</Prompt>");
                            sbDCF.append("<Prompt CFID=\"" + LZ_CallFlowIDListArray[i] + "\">" + LZ_PromptAt + "</Prompt>");
                            sbDCF.append("<Prompt CFID=\"\">" + LZ_BALastRechargeTime + "</Prompt>");
                        }
                    } else if (LZ_PromptListArray[i].equals(LZ_PromptActive)
                            || LZ_PromptListArray[i].equals(LZ_PromptPending)) {
                        sbDCF.append("<Prompt CFID=\"" + LZ_CallFlowIDListArray[i] + "\">" + LZ_PromptListArray[i] + "</Prompt>");
                    } else if (LZ_PromptListArray[i].equals(LZ_PromptContinue)
                            || LZ_PromptListArray[i].equals(LZ_PromptRepeatMessage)) {
                        sbDCF.append("<Menu CFID=\"" + LZ_CallFlowIDListArray[i] + "\">" + LZ_PromptListArray[i] + "</Menu>");
                    }
                }

                sbDCF.append("</CallFlow>");
                LZ_DynamicCallFlowXML = sbDCF.toString();
         
            }
        } catch (Exception ex) {
            Logger.error(LZ_DBCallDetailID, " Exception in RetrieveFlashMessagePrompts Page : " + ex.getMessage(), false);
        } finally {
            LZ_CallFlowDetailXML = LZ_DBCallDetailID = LZ_RuleID = LZ_PromptList = LZ_CallFlowIDList = LZ_BAAccountBalance = LZ_OverDueAmount = LZ_BASubscriptionType = LZ_BARechargeDueDate = LZ_NumberOfDaysLeft = LZ_BASuggestedRecharge = LZ_BALastRechargeAmount = LZ_BALastRechargeDateTime = LZ_BALastRechargeDate = LZ_BALastRechargeTime = LZ_PromptAccountBalance = LZ_PromptOverDueAmount = LZ_PromptDueDate = LZ_PromptPleaseRecharge = LZ_PromptOnBeforeRecharge = LZ_PromptRechargeNext = LZ_PromptRechargeNextDays = LZ_PromptBasePackage = LZ_PromptDuePackage = LZ_PromptRecommendedRecharge = LZ_PromptLastRechargeAmount = LZ_PromptLastRechargeDate = LZ_PromptActive = LZ_PromptPending = LZ_PromptDays = LZ_PromptAt = LZ_PromptContinue = LZ_PromptRepeatMessage = null;
        }

        JSONObject result = new JSONObject();
        result.put("DynamicCallFlowXML", LZ_DynamicCallFlowXML);

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