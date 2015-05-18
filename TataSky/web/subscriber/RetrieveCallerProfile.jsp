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
        String LZ_BACallerType = ""; // Type of the caller (Subscriber/Partner/Prospect etc.)
        String LZ_RMNFromAgent = "";

        try {
            GZ_CallFlowDetailXML = state.optString("GZ_CallFlowDetailXML","");
            LZ_UsrANI = state.optString("LZ_UsrANI","");
            LZ_DefaultLanguage = state.optString("BA_DEFAULT_LANGUAGE","English");
            LZ_DBCallDetailID = state.optString("GZ_DBCallDetailID","");
            LZ_RMNFromAgent = state.optString("LZ_RMNFromAgent","");
            
            Logger.info(LZ_DBCallDetailID, " RetrieveCallerProfile Input = LZ_UsrANI : " + LZ_UsrANI + " LZ_DefaultLanguage : " + LZ_DefaultLanguage + " LZ_RMNFromAgent : " + LZ_RMNFromAgent, false);
            
            if(!LZ_RMNFromAgent.equals(""))
            {
            	LZ_UsrANI = LZ_RMNFromAgent;
            }
            if (LZ_SimulatorMode) {
            } else {

            	if (LZ_UsrANI.length() > 10) 
            	{
                      LZ_UsrANI = LZ_UsrANI.substring(LZ_UsrANI.length() - 10);
                }
                String LZ_BA_XML = "";

                if(LZ_UsrANI.equals("201012"))
		  {
			LZ_BA_XML = new DBAccess().getSubscriberProfileByRmn("66233567", LZ_DBCallDetailID);
		  }
                else if(LZ_UsrANI.equals("9538283338"))
		  {
			LZ_BA_XML = new DBAccess().getSubscriberProfileByRmn("66233567", LZ_DBCallDetailID);
		  }
	        else if(LZ_UsrANI.equals("201011"))
		  {
			LZ_BA_XML = new DBAccess().getSubscriberProfileByRmn("3003003012", LZ_DBCallDetailID);
		  }
		else if(LZ_UsrANI.equals("201013"))
		  {
			LZ_BA_XML = new DBAccess().getSubscriberProfileByRmn("66233567", LZ_DBCallDetailID);
		  }
               else if(LZ_UsrANI.equals("9886977077"))
		  {
			LZ_BA_XML = new DBAccess().getSubscriberProfileByRmn("66233567", LZ_DBCallDetailID);
		  }
             else if(LZ_UsrANI.equals("8066233530"))
		  {
			LZ_BA_XML = new DBAccess().getSubscriberProfileByRmn("66233567", LZ_DBCallDetailID);
		  }
             else if(LZ_UsrANI.equals("9986219952"))
		  {
			LZ_BA_XML = new DBAccess().getSubscriberProfileByRmn("66233567", LZ_DBCallDetailID);
		  }

      	   else if(LZ_UsrANI.equals("8066233129"))
		  {
			LZ_BA_XML = new DBAccess().getSubscriberProfileByRmn("66233567", LZ_DBCallDetailID);
		  }
              else if(LZ_UsrANI.equals("8066233315"))
		  {
			LZ_BA_XML = new DBAccess().getSubscriberProfileByRmn("9413602070", LZ_DBCallDetailID);
		  }
              
		  else
		  {
			LZ_BA_XML = new DBAccess().getSubscriberProfileByRmn(LZ_UsrANI, LZ_DBCallDetailID);
		  }
		 
              //   GZ_CallFlowDetailXML = GZ_CallFlowDetailXML.replace("</ROOT>", "<BA_ROOT>" + LZ_BA_XML + "</BA_ROOT></ROOT>");
  		  GZ_CallFlowDetailXML = GZ_CallFlowDetailXML.replace("<BA_ROOT>", "<BA_ROOT>" + LZ_BA_XML );

                Document docBA = XMLAO.buildXMLDocument(GZ_CallFlowDetailXML);

                LZ_BACallerType = XMLAO.getNodeValueText(docBA, "BA_CALLER_TYPE");

                if (LZ_BACallerType.equals("Prospect")) {

                    String LZ_ProspectPromoFlag = ConfigurationReader.configList.get("PROSPECT_PROMO_FLAG");
                    String LZ_ProspectPromoDetailFlag = ConfigurationReader.configList.get("PROSPECT_PROMO_DETAIL_FLAG");
                    GZ_CallFlowDetailXML = GZ_CallFlowDetailXML.replace("<BA_ROOT>", "<BA_ROOT><BA_PROSPECT_PROMO_FLAG>" + LZ_ProspectPromoFlag + "</BA_PROSPECT_PROMO_FLAG><BA_PROSPECT_PROMO_DETAIL_FLAG>" + LZ_ProspectPromoDetailFlag + "</BA_PROSPECT_PROMO_DETAIL_FLAG>");

                } else if (LZ_BACallerType.equals("RMN")) {

                    String LZ_IVRBypassFlag = ConfigurationReader.configList.get("IVR_BYPASS_FLAG");
                    GZ_CallFlowDetailXML = GZ_CallFlowDetailXML.replace("<BA_ROOT>", "<BA_ROOT><BA_RMN>" + LZ_UsrANI + "</BA_RMN><BA_RMN_FLAG>Y</BA_RMN_FLAG><BA_IVR_BYPASS_FLAG>" + LZ_IVRBypassFlag + "</BA_IVR_BYPASS_FLAG>");
                    GZ_CallFlowDetailXML = GZ_CallFlowDetailXML.replace("</CTIROOT>", "<CTIISRMNCTIISDND>Y</CTIISRMNCTIISDND></CTIROOT>");


                } else if (LZ_BACallerType.equals("NonRMN")) {

                    GZ_CallFlowDetailXML = GZ_CallFlowDetailXML.replace("</CTIROOT>", "<CTIISRMNCTIISDND>N</CTIISRMNCTIISDND></CTIROOT>");
                }
 		   else if (LZ_BACallerType.equals("Partner")) 
		  {         
                } 
		  else
		  { LZ_BACallerType = "N";
		  }

               
               
                LZ_BA_XML = null;
            }
        } catch (Exception ex) {
            Logger.error(LZ_DBCallDetailID, " Exception in Retrieve Caller Profile Page : " + ex.getMessage(), false);
        } finally {
            Logger.info(LZ_DBCallDetailID, " RetrieveCallerProfile Output = LZ_BACallerType : " + LZ_BACallerType, false);
            LZ_DBCallDetailID = LZ_UsrANI = LZ_DefaultLanguage = null;
        }

        JSONObject result = new JSONObject();
        System.out.println("CallerType = " + LZ_BACallerType);
        result.put("CallFlowDetailXML", GZ_CallFlowDetailXML);
        result.put("CallerType",LZ_BACallerType);
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