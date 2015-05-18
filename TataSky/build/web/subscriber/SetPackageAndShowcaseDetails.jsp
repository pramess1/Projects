<%@page language="java" contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean LZ_SimulatorMode = false; // Simulator Mode by default is set to true.
        String LZ_CallFlowDetailXML = ""; // This is used to store the call flow detail XML.

        String LZ_PromptList = ""; // This is used to store the result prompt list.
        String LZ_MenuOptionSelected = ""; // This is used to store the menu option selected, if any.

        try {
//            LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
//            LZ_PromptList = state.getString("LZ_PromptList");
//            LZ_MenuOptionSelected = state.getString("LZ_MenuOptionSelected");
            LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");
            LZ_PromptList = state.optString("LZ_PromptList","");
            LZ_MenuOptionSelected = state.optString("LZ_MenuOptionSelected","");            

            if (LZ_SimulatorMode) {
            } else {
                if (!LZ_PromptList.isEmpty() && !LZ_MenuOptionSelected.isEmpty()) {
                    String[] LZ_PromptListArray = LZ_PromptList.split(",");
                    int LZ_MenuOption = Integer.parseInt(LZ_MenuOptionSelected);

                    if (LZ_MenuOption > 0 && LZ_MenuOption <= LZ_PromptListArray.length) {
                        int LZ_StartIndex = LZ_CallFlowDetailXML.indexOf("<FLDCALLTYPEID>");
                        int LZ_EndIndex = LZ_CallFlowDetailXML.indexOf("</FLDCALLTYPEID>", LZ_StartIndex) + 16;
                        String LZ_temp = LZ_CallFlowDetailXML.substring(LZ_StartIndex, LZ_EndIndex);
                        String LZ_tempPrompt = LZ_PromptListArray[LZ_MenuOption].replace(".wav", "");

                        LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace(LZ_temp, "<FLDCALLTYPEID>" + "3_" + LZ_tempPrompt + "</FLDCALLTYPEID>");
                        LZ_temp = LZ_tempPrompt = null;
                    }
                    LZ_PromptListArray = null;
                }
            }
        } catch (Exception ex) {
            Logger.error("", " Exception in SetPackageAndShowcaseDetails Page : " + ex.getMessage(), false);
        } finally {
            LZ_PromptList = null;
        }

        JSONObject result = new JSONObject();
        result.put("CallFlowDetailXML", LZ_CallFlowDetailXML);

        return result;

    }

    ;
%>
<%-- GENERATED: DO NOT REMOVE --%> 
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONException"%>
<%@page import="java.util.Map"%>
<%@include file="../backend.jspf" %>