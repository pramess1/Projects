<%@page language="java" contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.tsg.common.*"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean LZ_SimulatorMode = false; // Simulator Mode by default is set to true.
        String LZ_CallFlowDetailXML = ""; // This is used to store the call flow detail XML.
        String LZ_DBCallDetailID = ""; // This is used to store the call detail ID.
        String LZ_DNIS = ""; // Account balance for a particular subsccriber ID
        String LZ_DirectSalesDNIS = ""; // This is used to store the Direct Sales DNIS.
        String LZ_AgentDNIS = ""; // This is used to store the Agent DNIS.
        String LZ_DNISCode = ""; // This is used to store the DNIS code.
        String LZ_PrimaryDNIS = ""; // This is used to store the Primary DNIS from Config file
        String LZ_SecondaryDNIS = ""; // This is used to store the Secondary DNIS from Config file
        String LZ_DCVAG = ""; // This is used to store DCVAG.
        String LZ_DCVQ = ""; // This is used to store DCVQ.
        String LZ_CallTypeID = "";
        String LZ_NUANCE_URL = "";

        try {
//            LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
//            LZ_DBCallDetailID = state.getString("LZ_DBCallDetailID");
            LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");
            LZ_DBCallDetailID = state.optString("LZ_DBCallDetailID","");            
            if (LZ_SimulatorMode) {
            } else {
                Document docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);

                LZ_CallTypeID = XMLAO.getNodeValueText(docBA, "FLDCALLTYPEID");

                if (LZ_CallTypeID.equals("4")) {
                    LZ_DNISCode = "DSD";
                } else if (LZ_CallTypeID.equals("2")) {
                    LZ_DNISCode = "AGD";
                }else if (LZ_CallTypeID.equals("3")) {
                    LZ_DNISCode = "PCKSHW";
                    LZ_NUANCE_URL = ConfigurationReader.configList.get("NUANCE_URL");
                }

                
                /* LZ_DNIS = XMLAO.getNodeValueText(docBA, "FLDDNIS");
                 LZ_DirectSalesDNIS = ConfigurationReader.configList.get("DIRECT_SALES_DNIS");
                 String[] LZ_DirectSalesDNISList = LZ_DirectSalesDNIS.split(",");
                 for(int i=0; i < LZ_DirectSalesDNISList.length; i++){
                 if(LZ_DNIS.equals(LZ_DirectSalesDNISList[i])){
                 LZ_DNISCode = "DSD";
                 LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</ROOT>", "<BA_ROOT><BA_DEFAULT_LANGUAGE>English</BA_DEFAULT_LANGUAGE></BA_ROOT></ROOT>");
                 int LZ_StartIndex = LZ_CallFlowDetailXML.indexOf("<FLDCALLTYPEID>");
                 int LZ_EndIndex = LZ_CallFlowDetailXML.indexOf("</FLDCALLTYPEID>", LZ_StartIndex) + 16;
                 String LZ_temp = LZ_CallFlowDetailXML.substring(LZ_StartIndex, LZ_EndIndex);
                 LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace(LZ_temp, "<FLDCALLTYPEID>4</FLDCALLTYPEID>");
                 break;
                 }
                 }
                 if(LZ_DNISCode.isEmpty()){
                 LZ_AgentDNIS = ConfigurationReader.configList.get("AGENT_DNIS");
                 String[] LZ_AgentDNISList = LZ_AgentDNIS.split(",");
                 for(int i=0; i < LZ_AgentDNISList.length; i++){
                 if(LZ_DNIS.equals(LZ_AgentDNISList[i])){
                 LZ_DNISCode = "AGD";
                 LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</ROOT>", "<BA_ROOT><BA_DEFAULT_LANGUAGE>English</BA_DEFAULT_LANGUAGE></BA_ROOT></ROOT>");
                 int LZ_StartIndex = LZ_CallFlowDetailXML.indexOf("<FLDCALLTYPEID>");
                 int LZ_EndIndex = LZ_CallFlowDetailXML.indexOf("</FLDCALLTYPEID>", LZ_StartIndex) + 16;
                 String LZ_temp = LZ_CallFlowDetailXML.substring(LZ_StartIndex, LZ_EndIndex);
                 LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace(LZ_temp, "<FLDCALLTYPEID>2</FLDCALLTYPEID>");
                 break;
                 }
                 }
                 }*/

            }
        } catch (Exception ex) {
            Logger.error(LZ_DBCallDetailID, " Exception in Retrieve DNIS Details Page : " + ex.getMessage(), false);
        }finally{
            LZ_DBCallDetailID = LZ_DNIS = LZ_DirectSalesDNIS = LZ_AgentDNIS = LZ_PrimaryDNIS = LZ_SecondaryDNIS = LZ_DCVAG = LZ_DCVQ = LZ_CallTypeID = null;
        }

        JSONObject result = new JSONObject();
        result.put("DNISCode", LZ_DNISCode);
        result.put("CallFlowDetailXML", LZ_CallFlowDetailXML);
        result.put("NuanceURL" , LZ_NUANCE_URL);

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