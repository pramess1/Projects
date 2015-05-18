<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean LZ_SimulatorMode = false; // Simulator Mode by default is set to true.
        String LZ_DynamicCallFlowXML = ""; // This stores the dynamic call flow XML sent by parent call flow.
        String LZ_PromptList = ""; // This stores the prompts separated by comma. 
        String LZ_MenuOptionList = "#"; // This stores the menu options separated by comma.

        String LZ_CallDetailID = ""; // This is used to store the call detail ID.
        String LZ_CallFlowID = ""; // This is used to store the call flow ID.
        String LZ_CallFlowDateTime = ""; // This is used to store the call flow date time.
        String LZ_RuleID = ""; // This is used to store the rule ID.

        try {
            if (LZ_SimulatorMode) {
                //Testing
            } else {
//                LZ_DynamicCallFlowXML = state.getString("LZ_DynamicCallFlowXML");

                LZ_DynamicCallFlowXML = state.optString("LZ_DynamicCallFlowXML", "");

                LZ_CallDetailID = XMLAO.getNodeAttributeText(LZ_DynamicCallFlowXML, "CallFlow", "CDID");

                if (!LZ_CallDetailID.isEmpty()) {
                    DateFormat LZ_DateTimeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
                    Date LZ_CurrentDateTime = new Date();
                    LZ_CallFlowDateTime = LZ_DateTimeFormat.format(LZ_CurrentDateTime).toString();

                    LZ_RuleID = XMLAO.getNodeAttributeText(LZ_DynamicCallFlowXML, "CallFlow", "RuleID");
                    Logger.info(LZ_CallDetailID, " RetrieveDynamicPromptWithRepeat Input = LZ_RuleID : " + LZ_RuleID, false);
                    int LZ_NodeCount = XMLAO.getNodeCount(LZ_DynamicCallFlowXML, "Prompt");

                    LZ_CallFlowID = XMLAO.getNodeAttributeText(LZ_DynamicCallFlowXML, "Prompt", "CFID", 0);
                    LZ_PromptList = XMLAO.getNodeValueText(LZ_DynamicCallFlowXML, "Prompt", 0);

                    for (int i = 1; i < LZ_NodeCount; i++) {
                        if (XMLAO.getNodeAttributeText(LZ_DynamicCallFlowXML, "Prompt", "CFID", i).isEmpty()) {
                            String LZ_tempPromptValue = XMLAO.getNodeValueText(LZ_DynamicCallFlowXML, "Prompt", i);

                            if (ValidationAO.isCardinal(LZ_tempPromptValue)) {
                                LZ_PromptList = LZ_PromptList + ",CARD=" + LZ_tempPromptValue;
                            } else if (ValidationAO.isCurrency(LZ_tempPromptValue)) {
                                LZ_PromptList = LZ_PromptList + ",CURR=INR" + ConversionAO.getCurrency(LZ_tempPromptValue);
                            } else if (ValidationAO.isDate(LZ_tempPromptValue)) {
                                LZ_PromptList = LZ_PromptList + ",DATE=" + ConversionAO.getDate(LZ_tempPromptValue);
                            } else if (ValidationAO.isTime(LZ_tempPromptValue)) {
                                LZ_PromptList = LZ_PromptList + ",TIME=" + ConversionAO.getTime(LZ_tempPromptValue);
                            }
                        } else {
                            LZ_PromptList = LZ_PromptList + "," + XMLAO.getNodeValueText(LZ_DynamicCallFlowXML, "Prompt", i);
                        }
                    }
                }
            }
        } catch (Exception ex) {
            Logger.error(LZ_CallDetailID, " Exception in RetrieveDynamicPromptWithRepeat Page : " + ex.getMessage(), false);
        } finally {
            Logger.info(LZ_CallDetailID, " RetrieveDynamicPromptWithRepeat Output = LZ_PromptList : " + LZ_PromptList + " LZ_MenuOptionList : " + LZ_MenuOptionList
                    + " LZ_CallFlowID : " + LZ_CallFlowID + " LZ_CallFlowDateTime : " + LZ_CallFlowDateTime + " LZ_RuleID : " + LZ_RuleID, false);
            LZ_DynamicCallFlowXML = null;
        }

        JSONObject result = new JSONObject();
        result.put("PromptList", LZ_PromptList);
        result.put("MenuOptionList", LZ_MenuOptionList);

        result.put("CallDetailID", LZ_CallDetailID);
        result.put("CallFlowID", LZ_CallFlowID);
        result.put("CallFlowDateTime", LZ_CallFlowDateTime);
        result.put("RuleID", LZ_RuleID);

        return result;

    }

    ;

%>
<%-- GENERATED: DO NOT REMOVE --%> 
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONException"%>
<%@page import="java.util.Map"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<%@page import="org.w3c.dom.Document"%>
<%@page import="Common.ActionObjects.*"%>

<%@include file="../backend.jspf" %>