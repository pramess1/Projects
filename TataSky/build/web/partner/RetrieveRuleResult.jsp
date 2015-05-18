<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>
<%@page import="com.tsg.common.rule.RuleDAO"%>
<%@page import="com.tsg.common.rule.RuleService"%>
<%@page import="java.util.Arrays"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean LZ_SimulatorMode = false; // Simulator Mode by default is set to true.
        String LZ_HostResponse = "Failure"; // This is used to store the rule engine transaction status.

        String LZ_CallFlowID = ""; // This is used to store the call flow ID.
        String LZ_BAString = ""; // This is used to store the BA attributes in comma separated format.
        String LZ_BAValueString = ""; // This is used to store the BA attribute values in comma separated format.
        String LZ_DBCallDetailID = ""; // This is used to store the call detail ID.
        String LZ_PromptList = ""; // This is used to store the result prompt list.
        String LZ_RoutePoint = ""; // This is used to store the result route point.

        String LZ_CallFlowIDList = ""; // This is used to store the result call flow ID list.

        String LZ_RuleID = ""; // This is used to store the rule ID.
        String LZ_RuleDesc = ""; // This is used to store the rule description.

        try {
//            LZ_CallFlowID = state.getString("LZ_CallFlowID");
//            LZ_BAString = state.getString("LZ_BAString");
//            LZ_BAValueString = state.getString("LZ_BAValueString");
              LZ_CallFlowID = state.optString("LZ_CallFlowID","");
              LZ_BAString = state.optString("LZ_BAString","");
              LZ_BAValueString = state.optString("LZ_BAValueString","");            

            if (LZ_SimulatorMode) {
                LZ_HostResponse = "Success";
            } else {
                System.out.println("LZ_CallFlowID: " + LZ_CallFlowID);
                System.out.println("LZ_BAString: " + LZ_BAString);
                System.out.println("LZ_BAValueString: " + LZ_BAValueString);
                if (String.valueOf(LZ_BAValueString.charAt(LZ_BAValueString.length() - 1)).equals(",")) {
                    LZ_BAValueString = LZ_BAValueString + "NOVALUE";
                }

                int LZ_CFID = Integer.parseInt(LZ_CallFlowID);
                String[] LZ_BAStringArray = LZ_BAString.split(",");
                String[] LZ_BAValueStringArray = LZ_BAValueString.split(",");

                String[] LZ_ResponseRuleEngine = RuleService.evaluateCallFlowExpression(LZ_CFID, LZ_BAStringArray, LZ_BAValueStringArray, LZ_DBCallDetailID);
                if (!LZ_ResponseRuleEngine[0].equals("F")) {
                    RuleDAO objRuleDAO = new RuleDAO();
                    String[] LZ_ResponseRuleDetail = objRuleDAO.retrieveRuleAction(LZ_ResponseRuleEngine, LZ_DBCallDetailID);

                    String[] LZ_ResponseRuleDetailArray = LZ_ResponseRuleDetail[0].split(",");

                    if (LZ_ResponseRuleDetailArray.length > 0) {
                        if (!LZ_ResponseRuleDetailArray[0].equals("F")) {
                            if (LZ_ResponseRuleDetailArray[0].equals("R")) {
                                LZ_RoutePoint = LZ_ResponseRuleDetailArray[1];
                            } else if (LZ_ResponseRuleDetailArray[0].equals("M") || LZ_ResponseRuleDetailArray[0].equals("MS")) {
                                LZ_PromptList = LZ_ResponseRuleDetail[0].replace("M,", "").replace("MS,", "");
                            }

                            LZ_CallFlowIDList = LZ_ResponseRuleDetail[1].replace(LZ_ResponseRuleDetailArray[0] + ",", "");
                            LZ_RuleID = LZ_ResponseRuleEngine[2].toString();
                            LZ_RuleDesc = LZ_ResponseRuleEngine[3].toString();
                            LZ_HostResponse = "Success";                        
                         
                        }
                    }
                } else {
                    System.out.println("LZ_RuleID: No rules found");
                }
            }
         } catch (Exception ex) {
            Logger.error(LZ_DBCallDetailID, " Exception in RetrieveRuleResult Page : " + ex.getMessage(), false);
         } finally {
            LZ_CallFlowID = LZ_BAString = LZ_BAValueString = LZ_DBCallDetailID = null;
        }


        JSONObject result = new JSONObject();
        result.put("HostResponse", LZ_HostResponse);

        result.put("PromptList", LZ_PromptList);
        result.put("RoutePoint", LZ_RoutePoint);
        result.put("CallFlowIDList", LZ_CallFlowIDList);
        result.put("RuleID", LZ_RuleID);
        result.put("RuleDesc", LZ_RuleDesc);

        return result;

    }

    ;

%>
<%-- GENERATED: DO NOT REMOVE --%> 
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONException"%>
<%@page import="java.util.Map"%>

<%@page import="Common.ActionObjects.*"%>

<%@include file="../backend.jspf" %>