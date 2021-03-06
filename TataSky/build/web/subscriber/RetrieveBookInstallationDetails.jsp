<%@page language="java" contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.tsg.database.gg.dataaccess.*"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean LZ_SimulatorMode = false; // Simulator Mode by default is set to true.
        String LZ_CallFlowDetailXML = ""; // This is used to store the call flow detail XML.
        String LZ_DBCallDetailID = ""; // This is used to store the call detail ID.
        String LZ_BARepeatCallerFlag = ""; // Flag to denote whether the caller is a repeat caller
        String LZ_BANDNCFlag = ""; // If the CLI is flagged as NDNC
        String LZ_RoutePoint = ""; // This is used to store the result route point.

        try {
//            LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
//            LZ_DBCallDetailID = state.getString("LZ_DBCallDetailID");
              LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");
              LZ_DBCallDetailID = state.optString("LZ_DBCallDetailID",""); 
              Logger.info(LZ_DBCallDetailID, " RetrieveBookInstallationDetails Input = LZ_CallFlowDetailXML : " + LZ_CallFlowDetailXML, false);                         
            if (LZ_SimulatorMode) {
            } else {
                Document docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);
                String LZ_CLI = XMLAO.getNodeValueText(docBA, "FLDCLI");
                LZ_BARepeatCallerFlag = new GetCliRepeatDAO().cliRepeatFlage(LZ_CLI, "BOOK", LZ_DBCallDetailID);
                LZ_RoutePoint = "BIT";
                if (LZ_BARepeatCallerFlag.equals("Y")) {
                    LZ_RoutePoint = "BIR";
                    LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</CTIROOT>", "<CTITRANSACTIONALERT>Book an Installation - Repeat</CTITRANSACTIONALERT></CTIROOT>");
                    LZ_BANDNCFlag = XMLAO.getNodeValueText(docBA, "BA_NDNC_FLAG");
                    if (LZ_BANDNCFlag.equals("Y")) {
                        LZ_RoutePoint = "DBR";
                    }
                } else {
                    LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</CTIROOT>", "<CTISRWO>NONRMN</CTISRWO></CTIROOT>");
                }
                LZ_CLI = null;
            }
        } catch (Exception ex) {
            Logger.error(LZ_DBCallDetailID, " Exception in Retrieve Book Installation Details Page : " + ex.getMessage(), false);
        } finally {
            Logger.info(LZ_DBCallDetailID, " RetrieveBookInstallationDetails Output = LZ_BARepeatCallerFlag : " + LZ_BARepeatCallerFlag + " LZ_RoutePoint : " + LZ_RoutePoint, false);
            LZ_DBCallDetailID = LZ_BANDNCFlag = null;
        }

        JSONObject result = new JSONObject();
        result.put("BARepeatCallerFlag", LZ_BARepeatCallerFlag);
        result.put("RoutePoint", LZ_RoutePoint);
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