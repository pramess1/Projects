<%@page language="java" contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean LZ_SimulatorMode = true; // Simulator Mode by default is set to true.
        String LZ_MenuOptionList = ""; // This stores the menu options separated by comma. 
        String LZ_MenuCallFlowIDList = ""; // This is used to store the menu call flow IDs.

        String LZ_MenuOptionSelected = ""; // This is used to store the menu option selected, if any.
        String LZ_CurrentLanguage = ""; // This is a placeholder for current language.

        String LZ_LanguageList = "English;Hindi;Marathi;Gujarati;Tamil;Bengali;Kannada;Telugu;Oriya;Punjabi;Malayalam;Assamese;Manipuri"; // This stores the languages in order of BRD.
        String LZ_LanguageCallIDList = "6;7;8;9;10;11;12;13;14;15;16;17;18"; // This stores the call flow IDs in order of BRD.

        String LZ_CallFlowDetailXML = ""; // This is used to store the call flow detail XML.

        try {
//            LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
//            LZ_MenuCallFlowIDList = state.getString("LZ_MenuCallFlowIDList");
//            LZ_MenuOptionList = state.getString("LZ_MenuOptionList");
//            LZ_MenuOptionSelected = state.getString("LZ_MenuOptionSelected");
            LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");
            LZ_MenuCallFlowIDList = state.optString("LZ_MenuCallFlowIDList","");
            LZ_MenuOptionList = state.optString("LZ_MenuOptionList","");
            LZ_MenuOptionSelected = state.optString("LZ_MenuOptionSelected","");            

            String[] LZ_LanguageListArray = LZ_LanguageList.split(";");
            String[] LZ_LanguageCallIDListArray = LZ_LanguageCallIDList.split(";");
            String[] LZ_MenuCallFlowIDListArray = LZ_MenuCallFlowIDList.split(",");

            if (LZ_MenuOptionList.contains(LZ_MenuOptionSelected) && !LZ_MenuOptionSelected.isEmpty()) {
                if (!LZ_MenuOptionSelected.equals("#")) {
                    int LZ_tempOption = Integer.parseInt(LZ_MenuOptionSelected);
                    String LZ_tempID = LZ_MenuCallFlowIDListArray[LZ_tempOption];

                    for (int i = 0; i < LZ_LanguageCallIDListArray.length; i++) {
                       // if (LZ_tempID.equals(LZ_LanguageCallIDListArray[i])) {
                    	   if (LZ_tempID.equalsIgnoreCase(LZ_LanguageCallIDListArray[i])) {
                            LZ_CurrentLanguage = LZ_LanguageListArray[i];
                            //System.out.println("Before Language Change LZ_CallFlowDetailXML: " + LZ_CallFlowDetailXML);
                            
                            LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("<BA_ROOT>", "<BA_ROOT><BA_SELECTED_LANGUAGE>" + LZ_CurrentLanguage + "</BA_SELECTED_LANGUAGE>");
                     
                            
                            /*int LZ_StartIndex = LZ_CallFlowDetailXML.indexOf("<BA_SELECTED_LANGUAGE>");
                            int LZ_EndIndex = 0;
                            String LZ_temp = "";

                            if (LZ_StartIndex > 0) {
                                LZ_EndIndex = LZ_CallFlowDetailXML.indexOf("</BA_SELECTED_LANGUAGE>", LZ_StartIndex) + 23;
                                LZ_temp = LZ_CallFlowDetailXML.substring(LZ_StartIndex, LZ_EndIndex);
                                LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace(LZ_temp, "<BA_SELECTED_LANGUAGE>" + LZ_CurrentLanguage + "</BA_SELECTED_LANGUAGE>");
                            } else {
                                LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("<BA_ROOT>", "<BA_ROOT><BA_SELECTED_LANGUAGE>" + LZ_CurrentLanguage + "</BA_SELECTED_LANGUAGE>");
                            }*/
                            break;
                        }
                    }
                }
            }
        } catch (Exception ex) {
            Logger.error("", " Exception in RetrieveLanguageSelected Page : " + ex.getMessage(), false);
        } finally {

            LZ_MenuOptionList = LZ_MenuCallFlowIDList = LZ_MenuOptionSelected = LZ_LanguageList = LZ_LanguageCallIDList = null;
        }

        JSONObject result = new JSONObject();
        result.put("CurrentLanguage", LZ_CurrentLanguage);
        result.put("CallFlowDetailXML", LZ_CallFlowDetailXML);

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