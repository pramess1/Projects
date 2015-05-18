<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>
<%@page import="com.tsg.common.rule.RuleDAO"%>
<%@page import="com.tsg.common.rule.RuleService"%>
<%@page import="java.util.Arrays"%>
<%@page import="org.apache.log4j.Logger"%>
<%!    static Logger log = Logger.getLogger(RelocationRequest_jsp.class);
    boolean b_SimulatorMode = false; // Simulator Mode by default is set to true.
    String GZ_CallFlowID;
    String GZ_CallDetailID;
    String LZ_ExpiryDate;
    String LZ_HostResponse;
    String LZ_RoutePoint = "";
    String LZ_CallFlowID = "";
    String LZ_RuleID = "";

    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {
        System.out.println("Called RelocationRequest page");
        try {
            if (b_SimulatorMode) {
                // Realtime scenario
            } else {
                // Test method




                int s_LZ_CallFlowID = Integer.parseInt(state.getString("LZ_CallFlowID"));
                String[] s_LZ_BAString = state.getString("LZ_BAString").split(",");
                String[] s_LZ_BAValueString = state.getString("LZ_BAValueString").split(",");
                String[] responseRuleEngine, responseRuleDetail;
                log.info("Process Expression " + Arrays.toString(s_LZ_BAString) + " VALUES=" + Arrays.toString(s_LZ_BAValueString));

                responseRuleEngine = RuleService.evaluateCallFlowExpression(s_LZ_CallFlowID, s_LZ_BAString, s_LZ_BAValueString);
                //  log.info("Response from Rule Engine:Message::" + responseRuleEngine[0] + "CODE::" + responseRuleEngine[1]+"responseRuleEngine[0]"+responseRuleEngine[2]);

                RuleDAO objRuleDAO = new RuleDAO();
                responseRuleDetail = objRuleDAO.retrieveRuleAction(responseRuleEngine);
                log.info("Executed Rule Proc responseRuleDetail[0]" + responseRuleDetail[0]);
                log.info("Executed Rule Proc responseRuleDetail[1]" + responseRuleDetail[1]);
                log.info("Executed ruleID=" + responseRuleEngine[2].toString());
                System.out.println("Executed Rule Proc");

                LZ_RoutePoint = responseRuleDetail[0];
                LZ_CallFlowID = responseRuleDetail[1];
                LZ_RuleID = responseRuleEngine[2].toString();
            }
        } catch (Exception ex) {
            // Log Exception
            log.error("Exception in RelocationRequest page" + ex.getMessage());
        }


        JSONObject result = new JSONObject();
        result.put("LZ_HostResponse", "Success");
        result.put("LZ_RoutePoint", LZ_RoutePoint);
        result.put("LZ_CallFlowID", LZ_CallFlowID);
        result.put("LZ_RuleID", LZ_RuleID);


        return result;

    }

%>
<%-- GENERATED: DO NOT REMOVE --%> 
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONException"%>
<%@page import="java.util.Map"%>
<%@include file="backend.jspf" %>


