<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>
<%@page import="com.tsg.common.rule.*"%>
<%@page import="java.util.Arrays"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean b_SimulatorMode = true; // Simulator Mode by default is set to true.
        String LZ_PromoID = "";
        String LZ_CallFlowID = "";
        String LZ_RuleID = "";
        //Log Variables
        String Log_RuleOutput1 = "";
        String Log_RuleOutput2 = "";
        String Log_RuleOutput3 = "";

        try {
            if (b_SimulatorMode) {
                // Realtime scenario
                LZ_PromoID = "";
                LZ_RuleID = "";
            } else {
                // Test method
                int s_LZ_CallFlowID = Integer.parseInt(state.getString("LZ_CallFlowID"));
                String[] s_LZ_BAString = state.optString("LZ_BAString","").split(",");
                String[] s_LZ_BAValueString = state.optString("LZ_BAValueString","").split(",");
                String[] responseRuleEngine, responseRuleDetail;
                responseRuleEngine = RuleService.evaluateCallFlowExpression(s_LZ_CallFlowID, s_LZ_BAString, s_LZ_BAValueString);
                RuleDAO objRuleDAO = new RuleDAO();
                responseRuleDetail = objRuleDAO.retrieveRuleAction(responseRuleEngine, "");
                Log_RuleOutput1 = responseRuleDetail[0];
                Log_RuleOutput2 = responseRuleDetail[1];
                Log_RuleOutput3 = responseRuleEngine[2].toString();
                String[] LZ_PromoIDArray = responseRuleDetail[0].split(",");
                String[] LZ_CallFlowIDArray = responseRuleDetail[1].split(",");
                LZ_PromoID = LZ_PromoIDArray[1];
                LZ_CallFlowID = LZ_CallFlowIDArray[1];
                LZ_RuleID = responseRuleEngine[2].toString();
            }
        } catch (Exception ex) {
            Logger.error("", " Exception in Relocation Request Page : " + ex.getMessage(), false);
        } 

        JSONObject result = new JSONObject();
        result.put("LZ_HostResponse", "SUCCESS");
        result.put("LZ_PromoID", LZ_PromoID);
        result.put("LZ_CallFlowID", LZ_CallFlowID);
        result.put("LZ_RuleID", LZ_RuleID);

        //Return Log Values
        result.put("RuleOutput1", Log_RuleOutput1);
        result.put("RuleOutput2", Log_RuleOutput2);
        result.put("RuleOutput3", Log_RuleOutput3);

        return result;

    }

    ;
%>
<%-- GENERATED: DO NOT REMOVE --%> 
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONException"%>
<%@page import="java.util.Map"%>
<%@include file="../backend.jspf" %>


