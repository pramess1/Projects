<%@page language="java" contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.tsg.database.DBAccess"%>
<%@page import="com.tsg.database.gg.dataaccess.CheckValidSubscriberByCliDAO"%>
<%@page import="com.tsg.common.*"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean LZ_SimulatorMode = false; // Simulator Mode by default is set to true.
        String LZ_CallFlowDetailXML = ""; // This is used to store the call flow detail XML.
        String LZ_IsSuccess = "N"; // This is used to store the success status.

        String LZ_UsrANI = ""; // This is used to store the ANI of the call.
        String LZ_RMN = ""; // This is used to store the RMN of the caller.
        String LZ_CLIRepeatFlag = ""; // This is used to store the CLI repeat flag.
        String LZ_CallCountByCLI = ""; // This is used to store the call count by CLI.
        String LZ_AppLanguage = ""; // This is used to store the language folder.
        String LZ_BASelectedLanguage = ""; // This is used to store the selected Language.
        String LZ_DBCallDetailID = ""; // This is used to store the call detail ID.

        try {
//            LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
//            LZ_RMN = state.getString("LZ_RMN");
            LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML", "");
            LZ_DBCallDetailID = state.optString("LZ_DBCallDetailID", "");
            LZ_RMN = state.optString("LZ_RMN", "");
            Logger.info(LZ_DBCallDetailID, " ValidateRMN Input = LZ_RMN : " + LZ_RMN, false);

            if (LZ_SimulatorMode) {
                LZ_IsSuccess = "Y";
            } else {
                Document docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);

                LZ_UsrANI = XMLAO.getNodeValueText(docBA, "FLDCLI");
                LZ_CLIRepeatFlag = XMLAO.getNodeValueText(docBA, "BA_CLI_REPEAT_CALLER_FLAG");
                LZ_CallCountByCLI = XMLAO.getNodeValueText(docBA, "BA_CALLCOUNTBYCLI");
                LZ_AppLanguage = XMLAO.getNodeValueText(docBA, "BA_APP_LANGUAGE");
                LZ_BASelectedLanguage = XMLAO.getNodeValueText(docBA, "BA_SELECTED_LANGUAGE");

                String LZ_BA_XML = "";

                if (!LZ_RMN.equals(LZ_UsrANI)) {
                    LZ_BA_XML = new DBAccess().getSubscriberProfileByRmn(LZ_RMN, "");
                }

                if (!LZ_BA_XML.isEmpty()) {
                    Document docTemp = XMLAO.buildXMLDocument("<BA_ROOT>" + LZ_BA_XML + "</BA_ROOT>");
                    String LZ_CallerType = XMLAO.getNodeValueText(docTemp, "BA_CALLER_TYPE");

                    if (LZ_CallerType.equals("RMN")) {
                        LZ_IsSuccess = "Y";

                        String LZ_IVRBypassFlag = ConfigurationReader.configList.get("IVR_BYPASS_FLAG");
                        if (LZ_BASelectedLanguage.isEmpty()) {
                            LZ_BA_XML = "<BA_ROOT><BA_RMN>" + LZ_RMN + "</BA_RMN><BA_RMN_FLAG>Y</BA_RMN_FLAG><BA_IVR_BYPASS_FLAG>" + LZ_IVRBypassFlag + "</BA_IVR_BYPASS_FLAG><BA_APP_LANGUAGE>" + LZ_AppLanguage + "</BA_APP_LANGUAGE>" + LZ_BA_XML + "</BA_ROOT>";
                        } else {
                            LZ_BA_XML = "<BA_ROOT><BA_RMN>" + LZ_RMN + "</BA_RMN><BA_RMN_FLAG>Y</BA_RMN_FLAG><BA_IVR_BYPASS_FLAG>" + LZ_IVRBypassFlag + "</BA_IVR_BYPASS_FLAG><BA_SELECTED_LANGUAGE>" + LZ_BASelectedLanguage + "</BA_SELECTED_LANGUAGE><BA_APP_LANGUAGE>" + LZ_AppLanguage + "</BA_APP_LANGUAGE>" + LZ_BA_XML + "</BA_ROOT>";
                        }
                        int LZ_StartIndex = LZ_CallFlowDetailXML.indexOf("<BA_ROOT>");
                        int LZ_EndIndex = LZ_CallFlowDetailXML.indexOf("</BA_ROOT>") + ("</BA_ROOT>").length();
                        String LZ_tempXML = LZ_CallFlowDetailXML.substring(LZ_StartIndex, LZ_EndIndex);

                        LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace(LZ_tempXML, LZ_BA_XML);

                        docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);
                        XMLAO.setNodeValueText(docBA, "FLDNONRMNIDENTIFIER", "RMN");
                        XMLAO.setNodeValueText(docBA, "FLDSUBIDVALIDATED", "N");
                        XMLAO.setNodeValueText(docBA, "BA_CLI_REPEAT_CALLER_FLAG", LZ_CLIRepeatFlag);
                        XMLAO.setNodeValueText(docBA, "BA_CALLCOUNTBYCLI", LZ_CallCountByCLI);
                        LZ_CallFlowDetailXML = XMLAO.getNodeOuterXML(docBA);
                        LZ_IVRBypassFlag = LZ_tempXML = null;
                    }
                    LZ_CallerType = null;
                }
                LZ_BA_XML = null;
            }
        } catch (Exception ex) {
            Logger.error("", " Exception in ValidateRMN Page : " + ex.getMessage(), false);
        } finally {
            Logger.info(LZ_DBCallDetailID, " ValidateRMN Output = LZ_IsSuccess : " + LZ_IsSuccess, false);
            LZ_UsrANI = LZ_CLIRepeatFlag = LZ_CallCountByCLI = LZ_AppLanguage = LZ_RMN = null;
        }

        JSONObject result = new JSONObject();
        result.put("IsSuccess", LZ_IsSuccess);
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