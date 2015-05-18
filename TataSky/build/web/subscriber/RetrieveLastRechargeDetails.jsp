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
        String LZ_BALastRechargeAmount = ""; // Last recharge amount
        String LZ_BALastRechargeDateTime = ""; // Last recharge date and time
        String LZ_BALastRechargeDate = ""; // Last recharge date
        String LZ_BALastRechargeTime = ""; // Last recharge time
        String LZ_BAAccountStatus = ""; // Account status (Active/De-Active)
        String LZ_BASubscriberIDCount = ""; // Number of subscribers for a particular RMN

        String LZ_DynamicCallFlowXML = ""; // This is used to store the callflow in XML format.

        String LZ_PromptRechargeAmount = "3086.wav"; // This is used to store the recharge amount prompt file name.
        String LZ_PromptRechargeDateTime = "3087.wav"; // This is used to store the recharge date and time prompt file name.
        String LZ_PromptActiveAccountStatus = "3405.wav"; // This is used to store the active account status prompt file name.
        String LZ_PromptPendingAccountStatus = "3406.wav"; // This is used to store the pending account status prompt file name.
        String LZ_PromptAt = "at.wav"; // This is used to store the at prompt file name.

        String LZ_NUANCE_URL = ""; // This is used to store the NUANCE URL.
        String LZ_BAPremiumFlag = ""; //This is used to store premium flag

        try {
//            LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
//            LZ_DBCallDetailID = state.getString("LZ_DBCallDetailID");
//            LZ_RuleID = state.getString("LZ_RuleID");
//            LZ_CallFlowID = state.getString("LZ_CallFlowID");
            LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML", "");
            LZ_DBCallDetailID = state.optString("LZ_DBCallDetailID", "");
            LZ_RuleID = state.optString("LZ_RuleID", "");
            LZ_CallFlowID = state.optString("LZ_CallFlowID", "");
            Logger.info(LZ_DBCallDetailID, " RetrieveLastRechargeDetails Input = LZ_RuleID : " + LZ_RuleID + " LZ_CallFlowID : " + LZ_CallFlowID, false);
            if (LZ_SimulatorMode) {
            } else {
                StringBuilder sbDCF = new StringBuilder("");
                Document docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);
                LZ_BASubscriberID = XMLAO.getNodeValueText(docBA, "BA_SUBSCRIBER_ID");
                LZ_BASubscriberIDCount = XMLAO.getNodeValueText(docBA, "BA_SUBSCRIBER_ID_COUNT");
                String LZ_BA_XML = new DBAccess().getAccountDetail(LZ_BASubscriberID, LZ_DBCallDetailID);
                //System.out.println("LZ_BA_XML: " + LZ_BA_XML);
                XMLAO.deleteNode(docBA, "BA_ACCOUNT_BALANCE");
                XMLAO.deleteNode(docBA, "BA_RECHARGE_DUE_DATE");
                XMLAO.deleteNode(docBA, "BA_FDP_RENEW_DATE");
                XMLAO.deleteNode(docBA, "BA_LAST_RECHARGE_AMT");
                XMLAO.deleteNode(docBA, "BA_LAST_RECHARGE_DATETIME");
                XMLAO.deleteNode(docBA, "BA_SUGGESTED_RECHARGE");

                LZ_CallFlowDetailXML = XMLAO.getNodeOuterXML(docBA);
                LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("<BA_ROOT>", "<BA_ROOT>" + LZ_BA_XML);
                docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);

                LZ_BALastRechargeAmount = XMLAO.getNodeValueText(docBA, "BA_LAST_RECHARGE_AMT");

                LZ_BAPremiumFlag = XMLAO.getNodeValueText(docBA, "BA_PREMIUM_FLAG");

                int LZ_tempCount = Integer.parseInt(LZ_BASubscriberIDCount);

                if (!LZ_BALastRechargeAmount.isEmpty()) {


                    if (LZ_BALastRechargeAmount.equals("")) {
                        LZ_BALastRechargeAmount = "0";
                    }

                    float LZ_tempAmount = Float.parseFloat(LZ_BALastRechargeAmount);

                    if (LZ_tempAmount <= 0) {
                        LZ_BALastRechargeAmount = "";
                        sbDCF.append("<CallFlow CDID=\"" + LZ_DBCallDetailID + "\" RuleID=\"" + LZ_RuleID + "\">");
                        if (LZ_BAPremiumFlag.equals("Y")) {
                            if (LZ_tempCount > 1) {
                                sbDCF.append("<Menu CFID=\"103\">9011.wav</Menu><Menu CFID=\"9001\">5029.wav</Menu><Menu CFID=\"9002\">5030.wav</Menu><Menu CFID=\"105\">9061.wav</Menu><Menu CFID=\"910\">7030.wav</Menu><Menu CFID=\"905\">7013.wav</Menu><Menu CFID=\"904\">7223.wav</Menu><Menu CFID=\"906\">7018.wav</Menu></CallFlow>");

                            } else {
                                sbDCF.append("<Menu CFID=\"103\">9011.wav</Menu><Menu CFID=\"9001\">5029.wav</Menu><Menu CFID=\"9002\">5030.wav</Menu><Menu CFID=\"910\">7030.wav</Menu><Menu CFID=\"905\">7013.wav</Menu><Menu CFID=\"904\">7223.wav</Menu><Menu CFID=\"906\">7018.wav</Menu></CallFlow>");
                            }


                        } else {

                            if (LZ_tempCount > 1) {
                                sbDCF.append("<Menu CFID=\"103\">9011.wav</Menu><Menu CFID=\"9000\">9046.wav</Menu><Menu CFID=\"105\">9061.wav</Menu><Menu CFID=\"910\">7030.wav</Menu><Menu CFID=\"905\">7013.wav</Menu><Menu CFID=\"904\">7223.wav</Menu><Menu CFID=\"906\">7018.wav</Menu></CallFlow>");
                            } else {
                                sbDCF.append("<Menu CFID=\"103\">9011.wav</Menu><Menu CFID=\"9000\">9046.wav</Menu><Menu CFID=\"910\">7030.wav</Menu><Menu CFID=\"905\">7013.wav</Menu><Menu CFID=\"904\">7223.wav</Menu><Menu CFID=\"906\">7018.wav</Menu></CallFlow>");
                            }
                        }
                        System.out.println("sbDCF" + sbDCF);

                    } else {
                        LZ_BALastRechargeAmount = String.valueOf(LZ_tempAmount);

                        sbDCF.append("<CallFlow CDID=\"" + LZ_DBCallDetailID + "\" RuleID=\"" + LZ_RuleID + "\">");
                        sbDCF.append("<Prompt CFID=\"" + LZ_CallFlowID + "\">" + LZ_PromptRechargeAmount + "</Prompt>");
                        sbDCF.append("<Prompt CFID=\"\">" + LZ_BALastRechargeAmount + "</Prompt>");

                        LZ_BALastRechargeDateTime = XMLAO.getNodeValueText(docBA, "BA_LAST_RECHARGE_DATETIME");

                        if (!LZ_BALastRechargeDateTime.isEmpty()) {
                            DateFormat LZ_DateFormat = new SimpleDateFormat("yyyy-MM-dd");
                            DateFormat LZ_TimeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

                            Date LZ_tempDate = LZ_DateFormat.parse(LZ_BALastRechargeDateTime);
                            LZ_BALastRechargeDate = LZ_DateFormat.format(LZ_tempDate).toString();

                            LZ_tempDate = LZ_TimeFormat.parse(LZ_BALastRechargeDateTime);
                            LZ_BALastRechargeTime = LZ_TimeFormat.format(LZ_tempDate).toString();
                            LZ_BALastRechargeTime = LZ_BALastRechargeTime.split(" ")[1];

                            sbDCF.append("<Prompt CFID=\"" + LZ_CallFlowID + "\">" + LZ_PromptRechargeDateTime + "</Prompt>");
                            sbDCF.append("<Prompt CFID=\"\">" + LZ_BALastRechargeDate + "</Prompt>");
                            sbDCF.append("<Prompt CFID=\"" + LZ_CallFlowID + "\">" + LZ_PromptAt + "</Prompt>");
                            sbDCF.append("<Prompt CFID=\"\">" + LZ_BALastRechargeTime + "</Prompt>");
                        } else {
                            LZ_BALastRechargeDate = "";
                            LZ_BALastRechargeTime = "";
                        }

                        LZ_BAAccountStatus = XMLAO.getNodeValueText(docBA, "BA_ACCOUNT_STATUS");

                        if (LZ_BAAccountStatus.equals("Active")) {
                            sbDCF.append("<Prompt CFID=\"" + LZ_CallFlowID + "\">" + LZ_PromptActiveAccountStatus + "</Prompt>");
                        } else {
                            sbDCF.append("<Prompt CFID=\"" + LZ_CallFlowID + "\">" + LZ_PromptPendingAccountStatus + "</Prompt>");
                        }



                        if (LZ_BAPremiumFlag.equals("Y")) {
                            if (LZ_tempCount > 1) {
                                sbDCF.append("<Menu CFID=\"103\">9011.wav</Menu><Menu CFID=\"9001\">5029.wav</Menu><Menu CFID=\"9002\">5030.wav</Menu><Menu CFID=\"105\">9061.wav</Menu><Menu CFID=\"910\">7030.wav</Menu><Menu CFID=\"905\">7013.wav</Menu><Menu CFID=\"904\">7223.wav</Menu><Menu CFID=\"906\">7018.wav</Menu></CallFlow>");
                                System.out.println("Test Premium inside" + LZ_BAPremiumFlag);
                            } else {
                                sbDCF.append("<Menu CFID=\"103\">9011.wav</Menu><Menu CFID=\"9001\">5029.wav</Menu><Menu CFID=\"9002\">5030.wav</Menu><Menu CFID=\"910\">7030.wav</Menu><Menu CFID=\"905\">7013.wav</Menu><Menu CFID=\"904\">7223.wav</Menu><Menu CFID=\"906\">7018.wav</Menu></CallFlow>");
                            }


                        } else {

                            if (LZ_tempCount > 1) {
                                sbDCF.append("<Menu CFID=\"103\">9011.wav</Menu><Menu CFID=\"9000\">9046.wav</Menu><Menu CFID=\"105\">9061.wav</Menu><Menu CFID=\"910\">7030.wav</Menu><Menu CFID=\"905\">7013.wav</Menu><Menu CFID=\"904\">7223.wav</Menu><Menu CFID=\"906\">7018.wav</Menu></CallFlow>");
                            } else {
                                sbDCF.append("<Menu CFID=\"103\">9011.wav</Menu><Menu CFID=\"9000\">9046.wav</Menu><Menu CFID=\"910\">7030.wav</Menu><Menu CFID=\"905\">7013.wav</Menu><Menu CFID=\"904\">7223.wav</Menu><Menu CFID=\"906\">7018.wav</Menu></CallFlow>");
                            }
                        }
                    }
                }

                LZ_DynamicCallFlowXML = sbDCF.toString();
                LZ_NUANCE_URL = ConfigurationReader.configList.get("NUANCE_URL");
            }
        } catch (Exception ex) {
            Logger.error(LZ_DBCallDetailID, " Exception in RetrieveLastRechargeDetails Page : " + ex.getMessage(), false);
        } finally {
            Logger.info(LZ_DBCallDetailID, " RetrieveLastRechargeDetails Output = LZ_DynamicCallFlowXML : " + LZ_DynamicCallFlowXML, false);
            LZ_DBCallDetailID = LZ_RuleID = LZ_CallFlowID = LZ_BASubscriberID = LZ_BALastRechargeAmount = LZ_BALastRechargeDateTime = LZ_BALastRechargeDate = LZ_BALastRechargeTime = LZ_BAAccountStatus = LZ_BASubscriberIDCount = LZ_PromptRechargeAmount = LZ_PromptRechargeDateTime = LZ_PromptActiveAccountStatus = LZ_PromptPendingAccountStatus = LZ_PromptAt = LZ_BAPremiumFlag = null;
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