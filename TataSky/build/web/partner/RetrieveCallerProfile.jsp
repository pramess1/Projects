<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>
<%@page import="com.tsg.database.DBAccess"%>
<%@page import="com.tsg.common.*"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean LZ_SimulatorMode = false; // Simulator Mode by default is set to true.
        String GZ_CallFlowDetailXML = ""; // This is used to store the call flow detail XML.
        String LZ_DBCallDetailID = ""; // This is used to store the call detail ID.
        String LZ_UsrANI = ""; // This is used to store the ANI of the call.
        String LZ_DefaultLanguage = ""; // This is used to store the default language of the caller.
         String LZ_BA_XML = "";
        try {
//            GZ_CallFlowDetailXML = state.getString("GZ_CallFlowDetailXML");
//            LZ_UsrANI = state.getString("LZ_UsrANI");
//            LZ_DefaultLanguage = state.getString("BA_DEFAULT_LANGUAGE");
//            LZ_DBCallDetailID = state.getString("GZ_DBCallDetailID");
            GZ_CallFlowDetailXML = state.optString("GZ_CallFlowDetailXML","");
            LZ_UsrANI = state.optString("LZ_UsrANI","");
            LZ_DefaultLanguage = state.optString("BA_DEFAULT_LANGUAGE","");
            LZ_DBCallDetailID = state.optString("GZ_DBCallDetailID","");            
            if (LZ_SimulatorMode) {
            } else {
                 
               if(LZ_UsrANI.equals("201005"))
                  {
                        LZ_BA_XML = new DBAccess().getPartnerDetailMobile("9243187879", LZ_DBCallDetailID);
                  }
                else if (LZ_UsrANI.contains("201012")) 
                  {
                    LZ_BA_XML = new DBAccess().getPartnerDetailMobile("9243187879",LZ_DBCallDetailID);
                } 
		 else if (LZ_UsrANI.contains("201013")) 
                  {
                    LZ_BA_XML = new DBAccess().getPartnerDetailMobile("9243187879",LZ_DBCallDetailID);
                } 
	        else if (LZ_UsrANI.contains("201011")) 
                  {
                    LZ_BA_XML = new DBAccess().getPartnerDetailMobile("9243187879",LZ_DBCallDetailID);
                } 

                else
                {
                    LZ_BA_XML = new DBAccess().getPartnerDetailMobile("LZ_UsrANI",LZ_DBCallDetailID);
                }

                Document docTemp = XMLAO.buildXMLDocument("<BA_ROOT>" + LZ_BA_XML + "</BA_ROOT>");
                
                String LZ_PartnerID = XMLAO.getNodeValueText(docTemp, "BA_PARTNER_ID");

                if (LZ_PartnerID.isEmpty()) {
                    GZ_CallFlowDetailXML = GZ_CallFlowDetailXML.replace("</ROOT>", "<BA_ROOT><BA_CALLER_TYPE>NonPartner</BA_CALLER_TYPE>" + LZ_BA_XML + "<BA_DEFAULT_LANGUAGE>" + LZ_DefaultLanguage + "</BA_DEFAULT_LANGUAGE></BA_ROOT></ROOT>");
                } else {
                    GZ_CallFlowDetailXML = GZ_CallFlowDetailXML.replace("</ROOT>", "<BA_ROOT><BA_CALLER_TYPE>Partner</BA_CALLER_TYPE>" + LZ_BA_XML + "<BA_DEFAULT_LANGUAGE>" + LZ_DefaultLanguage + "</BA_DEFAULT_LANGUAGE></BA_ROOT></ROOT>");
                }
            }
        } catch (Exception ex) {
            Logger.error(LZ_DBCallDetailID, " Exception in RetrieveCallerProfile Page : " + ex.getMessage(), false);
        }finally{
              LZ_DBCallDetailID = LZ_UsrANI =  LZ_DefaultLanguage = LZ_BA_XML = null;
        }

        JSONObject result = new JSONObject();
        result.put("CallFlowDetailXML", GZ_CallFlowDetailXML);

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