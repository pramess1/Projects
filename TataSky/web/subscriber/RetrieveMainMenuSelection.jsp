<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean LZ_SimulatorMode = false; // Simulator Mode by default is set to true.
        String LZ_CallFlowDetailXML = ""; // This is used to store the call flow detail XML.
        String LZ_MainMenuSelectedID = ""; // This is used to store the Main Menu selected ID.
        String LZ_DBCallDetailID = "";
        try {
//            LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
           LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");
           LZ_DBCallDetailID = state.optString("LZ_DBCallDetailID","");   
           Logger.info(LZ_DBCallDetailID, " RetrieveMainMenuSelection Input = CallFlowDetailXML : " + LZ_CallFlowDetailXML, false);                                                    
            if (LZ_SimulatorMode) {
                //Testing...
            } else {
                Document docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);
                LZ_MainMenuSelectedID = XMLAO.getNodeValueText(docBA, "CTILASTMENU");
            }
        } catch (Exception ex) {
            Logger.error(LZ_DBCallDetailID, " Exception in RetrieveMainMenuSelection Page : " + ex.getMessage(), false);
        } finally {
            Logger.info(LZ_DBCallDetailID, " RetrieveMainMenuSelection Output = LZ_MainMenuSelectedID : " + LZ_MainMenuSelectedID, false);                                                    
            LZ_CallFlowDetailXML = LZ_DBCallDetailID = null;
        }

        JSONObject result = new JSONObject();
        result.put("MainMenuSelectedID", LZ_MainMenuSelectedID);

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

<%@include file="../backend.jspf" %>