<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>
<%@page import="com.tsg.common.rule.RuleDAO"%>
<%@page import="com.tsg.common.rule.RuleService"%>
<%@page import="java.util.Arrays"%>
<%@page import="com.tsg.log.Logger"%>
<%!   
public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {
        
    boolean b_SimulatorMode = false; // Simulator Mode by default is set to true.
    String LZ_PromptID = "";
    String LZ_CallFlowID = "";
    String LZ_RuleID = "";
        
        try {
            if (b_SimulatorMode) {
                // Realtime scenario
            } else {
                // Test method
                int s_LZ_CallFlowID = Integer.parseInt(state.getString("LZ_CallFlowID"));
//                String[] s_LZ_BAString = state.getString("LZ_BAString").split(",");
//                String[] s_LZ_BAValueString = state.getString("LZ_BAValueString").split(",");
                String[] s_LZ_BAString = state.optString("LZ_BAString","").split(",");
                String[] s_LZ_BAValueString = state.optString("LZ_BAValueString","").split(",");                
                String[] responseRuleEngine, responseRuleDetail;
                Logger.info("Process Expression " , Arrays.toString(s_LZ_BAString) + " VALUES=" + Arrays.toString(s_LZ_BAValueString), false);
                responseRuleEngine = RuleService.evaluateCallFlowExpression(s_LZ_CallFlowID, s_LZ_BAString, s_LZ_BAValueString);
                
                RuleDAO objRuleDAO = new RuleDAO();
                responseRuleDetail = objRuleDAO.retrieveRuleAction(responseRuleEngine);
                Logger.info("Executed Rule Proc responseRuleDetail[0]" , responseRuleDetail[0], false);
                Logger.info("Executed Rule Proc responseRuleDetail[1]" , responseRuleDetail[1], false);
                Logger.info("Executed ruleID=" , responseRuleEngine[2].toString(), false);
                LZ_PromptID = responseRuleDetail[0];
                LZ_CallFlowID = responseRuleDetail[1];
                LZ_RuleID = responseRuleEngine[2].toString();
                
                s_LZ_BAString = s_LZ_BAValueString = responseRuleEngine = responseRuleDetail = null;
            }
        } catch (Exception ex) {
              Logger.error("Exception in PostRechargeMenu_jsp page" , ex.getMessage(),false);
        } 

        JSONObject result = new JSONObject();
        result.put("LZ_HostResponse", "Success");
        result.put("LZ_RoutePoint", LZ_PromptID);
        result.put("LZ_CallFlowID", LZ_CallFlowID);
        result.put("LZ_RuleID", LZ_RuleID);
        return result;
 };

%>
<%-- GENERATED: DO NOT REMOVE --%> 
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONException"%>
<%@page import="java.util.Map"%>
<%@include file="../backend.jspf" %>


