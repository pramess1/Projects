<%@page language="java" contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean LZ_SimulatorMode = false; // Simulator Mode by default is set to true.
        String LZ_CallFlowDetailXML = ""; // This is used to store the call flow detail XML.

        String LZ_BASelectedLanguage = ""; // This is used to store the selected language for this particular call.
        String LZ_BASubscriberID = ""; // Subscriber ID

        try {
//            LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
            LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");            

            if (LZ_SimulatorMode) {
                LZ_BASelectedLanguage = "English";
                LZ_BASubscriberID = "1234567890";
            } else {
                Document docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);

                LZ_BASelectedLanguage = XMLAO.getNodeValueText(docBA, "BA_SELECTED_LANGUAGE");

                if (LZ_BASelectedLanguage.isEmpty()) {
                    String LZ_BAPrimary_Language = XMLAO.getNodeValueText(docBA, "BA_PRIMARY_LANGUAGE");

                    if (LZ_BAPrimary_Language.isEmpty()) {
                        String LZ_BASecondary_Language = XMLAO.getNodeValueText(docBA, "BA_SECONDARY_LANGUAGE");

                        if (!LZ_BASecondary_Language.isEmpty()) {
                            LZ_BASelectedLanguage = LZ_BASecondary_Language;
                        }
                    } else {
                        LZ_BASelectedLanguage = LZ_BAPrimary_Language;
                    }
                    LZ_BAPrimary_Language = null;
                }

                LZ_BASubscriberID = XMLAO.getNodeValueText(docBA, "BA_SUBSCRIBER_ID");

            }
        } catch (Exception ex) {
            Logger.error("", " Exception in RetrieveInsidePremisesDetails Page : " + ex.getMessage(), false);
        } finally {
            LZ_CallFlowDetailXML = null;
        }

        JSONObject result = new JSONObject();
        result.put("BASelectedLanguage", LZ_BASelectedLanguage);
        result.put("BASubscriberID", LZ_BASubscriberID);


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