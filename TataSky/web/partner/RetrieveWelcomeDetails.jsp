<%@page language="java" contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.tsg.common.*"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean LZ_SimulatorMode = false; // Simulator Mode by default is set to true.
        String LZ_CallFlowDetailXML = ""; // This is used to store the call flow detail XML.
        String LZ_DBCallDetailID = ""; // This is used to store the call detail ID.
        String LZ_TimePhase = ""; // TimePhase is either Morning, Noon, Evening
        String LZ_BACallerType = ""; // Caller Type is either Partner, Subscriber RMN, Prospect, Non RMN
        String LZ_BABrandGreetFlag = ""; // Branding greeting enable/disable
        String LZ_BASeasonalGreetFlag = ""; // Seasonal greeting enable/disable

        try {
//            LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
            LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");            

            if (LZ_SimulatorMode) {
            } else {
                DateFormat LZ_TimeFormat = new SimpleDateFormat("HH:mm:ss");
                Date LZ_CurrentTime = new Date();
                LZ_CurrentTime = LZ_TimeFormat.parse(LZ_TimeFormat.format(LZ_CurrentTime));

                if (LZ_CurrentTime.after(LZ_TimeFormat.parse("00:00:00")) && LZ_CurrentTime.before(LZ_TimeFormat.parse("12:00:00"))) {
                    LZ_TimePhase = "Morning";
                } else if (LZ_CurrentTime.after(LZ_TimeFormat.parse("12:00:00")) && LZ_CurrentTime.before(LZ_TimeFormat.parse("16:00:00"))) {
                    LZ_TimePhase = "Noon";
                } else {
                    LZ_TimePhase = "Evening";
                }

                Document docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);

                LZ_BACallerType = XMLAO.getNodeValueText(docBA, "BA_CALLER_TYPE");

                LZ_BABrandGreetFlag = ConfigurationReader.configList.get("BRAND_GREET_FLAG");
                LZ_BASeasonalGreetFlag = ConfigurationReader.configList.get("SEASONAL_GREET_FLAG");
            }
        } catch (Exception ex) {
            Logger.error(LZ_DBCallDetailID, " Exception in RetrieveWelcomeDetails Page : " + ex.getMessage(), false);
        } finally {
            LZ_CallFlowDetailXML = LZ_DBCallDetailID = null;
        }


        JSONObject result = new JSONObject();
        result.put("TimePhase", LZ_TimePhase);
        result.put("BACallerType", LZ_BACallerType);
        result.put("BABrandGreetFlag", LZ_BABrandGreetFlag);
        result.put("BASeasonalGreetFlag", LZ_BASeasonalGreetFlag);

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