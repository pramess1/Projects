<%@page language="java" contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean LZ_SimulatorMode = false; // Simulator Mode by default is set to true.
        String LZ_CallFlowDetailXML = ""; // This is used to store the call flow detail XML.
        String LZ_RuleDesc = ""; // This is used to store the rule description.
        String LZ_DBCallDetailID = ""; // This is used to store the call detail ID.
        try {
//            LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
//            LZ_RuleDesc = state.getString("LZ_RuleDesc");
            
            LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");
            LZ_RuleDesc = state.optString("LZ_RuleDesc","");            
            LZ_DBCallDetailID = state.optString("LZ_DBCallDetailID",""); 
            Logger.info(LZ_DBCallDetailID, " SetRuleDescriptionDetails Input = LZ_RuleDesc : " + LZ_RuleDesc, false);
            if (LZ_SimulatorMode) {
            } else {
                if (!LZ_RuleDesc.isEmpty()) {
                    int LZ_StartIndex = LZ_CallFlowDetailXML.indexOf("<CTITRANSACTIONALERT>");
                    int LZ_EndIndex = 0;
                    String LZ_temp = "</CTIROOT>";

                    if (LZ_StartIndex > -1) {
                        LZ_EndIndex = LZ_CallFlowDetailXML.indexOf("</CTITRANSACTIONALERT>", LZ_StartIndex) + 22;
                        LZ_temp = LZ_CallFlowDetailXML.substring(LZ_StartIndex, LZ_EndIndex);

                        LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace(LZ_temp, "<CTITRANSACTIONALERT>" + LZ_RuleDesc + "</CTITRANSACTIONALERT>");
                    } else {
                        LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace(LZ_temp, "<CTITRANSACTIONALERT>" + LZ_RuleDesc + "</CTITRANSACTIONALERT></CTIROOT>");
                    }
                                   
                }
                
            }
        } catch (Exception ex) {
            Logger.error(LZ_DBCallDetailID, " Exception in SetRuleDescriptionDetails Page : " + ex.getMessage(), false);
        } finally {
            Logger.info(LZ_DBCallDetailID, " SetRuleDescriptionDetails Output ", false);
            LZ_RuleDesc = LZ_DBCallDetailID = null;
        }

        JSONObject result = new JSONObject();
        result.put("CallFlowDetailXML", LZ_CallFlowDetailXML);

        return result;

    };
%>
<%-- GENERATED: DO NOT REMOVE --%> 
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONException"%>
<%@page import="java.util.Map"%>
<%@include file="../backend.jspf" %>