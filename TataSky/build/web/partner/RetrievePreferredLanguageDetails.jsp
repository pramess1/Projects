<%@page language="java" contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean LZ_SimulatorMode = true; // Simulator Mode by default is set to true.
        String LZ_DBCallDetailID = ""; // This is used to store the call detail ID.
        String LZ_CurrentLanguage = ""; // This is a placeholder for current language.

        String LZ_LanguageList = "English;Hindi;Marathi;Gujarati;Tamil;Bengali;Kannada;Telugu;Odiya;Punjabi;Malayalam;Assamese;Manipuri"; // This stores the languages in order of BRD.
        String LZ_LanguagePromptList = "1038.wav;1024.wav;1025.wav;1026.wav;1027.wav;1028.wav;1029.wav;1030.wav;1031.wav;1032.wav;1033.wav;1034.wav;1035.wav"; // This stores the call flow IDs in order of BRD.

        String LZ_DynamicCallFlowXML = ""; // This is used to store the callflow in XML format.

        try {
//            LZ_DBCallDetailID = state.getString("LZ_DBCallDetailID");
//            LZ_CurrentLanguage = state.getString("LZ_CurrentLanguage");
            LZ_DBCallDetailID = state.optString("LZ_DBCallDetailID","");
            LZ_CurrentLanguage = state.optString("LZ_CurrentLanguage","");            

            String[] LZ_LanguageListArray = LZ_LanguageList.split(";");
            String[] LZ_LanguagePromptListArray = LZ_LanguagePromptList.split(";");

            for (int i = 0; i < LZ_LanguageListArray.length; i++) {
                if (LZ_CurrentLanguage.equals(LZ_LanguageListArray[i])) {
                    LZ_DynamicCallFlowXML = "<CallFlow CDID=\"" + LZ_DBCallDetailID + "\" RuleID=\"\"><Prompt CFID=\"38\">1036.wav</Prompt><Prompt CFID=\"38\">" + LZ_LanguagePromptListArray[i] + "</Prompt><Prompt CFID=\"38\">1037.wav</Prompt><Menu CFID=\"911\">7225.wav</Menu><Menu CFID=\"909\">7029.wav</Menu><Menu CFID=\"907\">7012.wav</Menu></CallFlow>";
                    break;
                }
            }
        } catch (Exception ex) {
            Logger.error(LZ_DBCallDetailID, " Exception in RetrievePreferredLanguageDetails Page : " + ex.getMessage(), false);
        } finally{
         
            LZ_DBCallDetailID = LZ_CurrentLanguage = LZ_LanguageList = LZ_LanguagePromptList = null;
            
        }

        JSONObject result = new JSONObject();
        result.put("DynamicCallFlowXML", LZ_DynamicCallFlowXML);

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