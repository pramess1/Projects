<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>

<%@page import="com.tsg.util.Util"%>
<%@page import="com.tsg.database.ivr.dataaccess.CallDetailDAO"%>
<%@page import="com.tsg.common.ConfigurationReader"%>
<%@page import="com.tsg.log.Logger"%>

<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        //Local Variables
        String LZ_PrimaryDNIS = ""; // This is used to store the Primary DNIS from Config file
        String LZ_SecondaryDNIS = ""; // This is used to store the Secondary DNIS from Config file
        String LZ_DCVAG = ""; // This is used to store DCVAG.
        String LZ_DCVQ = ""; // This is used to store DCVQ.
        String LZ_DirectSalesDNIS = ""; // This is used to store the Direct Sales DNIS.
        String LZ_AgentDNIS = ""; // This is used to store the Agent DNIS.
        String LZ_DNISCode = ""; // This is used to store the DNIS code.


        // Input variables
        boolean b_SimulatorMode = false; // Simulator Mode by default is set to true.
        String LZ_UsrANI = ""; // This is used to store the ANI of the call.
        String LZ_UsrDNIS = ""; // This is used to store the DNIS of the call.
        String LZ_UsrCallSessionID = ""; // This is used to store the session of a particular call.
        String LZ_UsrCallUUID = ""; // This is used to store the CallUUID.
        String LZ_CallTypeID = ""; // This is used to store the call type, inbound/outbound.
        String GZ_CallFlowDetailXML = ""; // This is used to store the call flow detail XML.
        String LZ_Date = ""; // This is used to store the date and time of call start.
        String LZ_SubscriberId = "";
        String LZ_AppID = "";
        String LZ_RMN = "";
        String LZ_AppLanguage = "";
        String LZ_DefaultLanguage = "";
        String LZ_CallTypeIDFromAgent = "";
           


        // Output variables
        String GZ_CallDetailID = ""; // The CallDetailID needs to be returned after insertion.

        try {
            if (b_SimulatorMode) {
            } else {
                // Realtime scenario
                LZ_UsrANI = state.optString("LZ_UsrANI","");
                System.out.println("LZ_UsrANI(Actual) =" + LZ_UsrANI);
              
                              	
                if (LZ_UsrANI.length() > 10) {
                    LZ_UsrANI = LZ_UsrANI.substring(LZ_UsrANI.length() - 10);
                }
                
                
                LZ_SubscriberId = state.optString("LZ_SubIDFromAgent","");
                LZ_AppID = state.optString("LZ_AppIDFromAgent","");
                LZ_RMN = state.optString("LZ_RMNFromAgent","");
                LZ_AppLanguage = state.optString("LZ_LanguageFromAgent","");
                LZ_CallTypeIDFromAgent = state.optString("LZ_CallTypeFromAgent","");

		  System.out.println("LZ_SubIDFromAgent=" + LZ_SubscriberId);
                System.out.println("LZ_AppIDFromAgent=" + LZ_AppID);
                System.out.println("LZ_RMNFromAgent=" + LZ_RMN);
                System.out.println("LZ_LanguageFromAgent=" + LZ_AppLanguage);
                System.out.println("LZ_CallTypeFromAgent=" + LZ_CallTypeIDFromAgent);

                
                System.out.println("LZ_UsrANI(Trimmed) =" + LZ_UsrANI);
                //System.out.println("InsertIntoCallDetail_jsp output LZ_UsrANI=" + LZ_UsrANI);
                LZ_UsrDNIS = state.optString("LZ_UsrDNIS","");
                
                if(LZ_UsrDNIS.equals("MSML"))
                {
                	LZ_UsrDNIS = "1212";
                	//LZ_AppID = "4";
                }
                
                //System.out.println("InsertIntoCallDetail_jsp output LZ_UsrDNIS="+LZ_UsrDNIS);
                LZ_UsrCallSessionID = state.optString("LZ_UsrCallSessionID","");
                //System.out.println("InsertIntoCallDetail_jsp output LZ_UsrCallSessionID="+LZ_UsrCallSessionID);
                LZ_UsrCallUUID = state.optString("LZ_UsrCallUUID","");
                //System.out.println("InsertIntoCallDetail_jsp output LZ_UsrCallUUID="+LZ_UsrCallUUID);
                if(LZ_CallTypeIDFromAgent.equals(""))
                {
                	LZ_CallTypeID = state.optString("LZ_CallTypeID","");
                }
                else
                {
                	LZ_CallTypeID = LZ_CallTypeIDFromAgent;
                }
                
                
                //System.out.println("InsertIntoCallDetail_jsp output LZ_CallTypeID="+LZ_CallTypeID);
                GZ_CallFlowDetailXML = state.optString("GZ_CallFlowDetailXML","");
                //System.out.println("InsertIntoCallDetail_jsp output GZ_CallFlowDetailXML="+GZ_CallFlowDetailXML);
                
                LZ_DefaultLanguage = state.optString("BA_DEFAULT_LANGUAGE","English");
                                
               
                
                LZ_Date = Util.getCurrentDateTime();

                
               if(!LZ_AppID.equals(""))
               {
                if (LZ_AppID.equals("4")) {
                	if(LZ_AppLanguage.equals(""))
                	{
                    	GZ_CallFlowDetailXML = GZ_CallFlowDetailXML.replace("</ROOT>", "<BA_ROOT><BA_DEFAULT_LANGUAGE>" + LZ_DefaultLanguage + "</BA_DEFAULT_LANGUAGE></BA_ROOT></ROOT>");
                	}
                	else
                	{
                		GZ_CallFlowDetailXML = GZ_CallFlowDetailXML.replace("</ROOT>", "<BA_ROOT><BA_DEFAULT_LANGUAGE>" + LZ_DefaultLanguage + "</BA_DEFAULT_LANGUAGE><BA_SELECTED_LANGUAGE>" + LZ_AppLanguage + "</BA_SELECTED_LANGUAGE></BA_ROOT></ROOT>");
                   	}
                    //LZ_CallTypeID = "4";
                } else if (LZ_AppID.equals("2")) {
                	if(LZ_AppLanguage.equals(""))
                	{
                    	GZ_CallFlowDetailXML = GZ_CallFlowDetailXML.replace("</ROOT>", "<BA_ROOT><BA_DEFAULT_LANGUAGE>" + LZ_DefaultLanguage + "</BA_DEFAULT_LANGUAGE></BA_ROOT></ROOT>");
                	}
                	else
                	{
                		GZ_CallFlowDetailXML = GZ_CallFlowDetailXML.replace("</ROOT>", "<BA_ROOT><BA_DEFAULT_LANGUAGE>" + LZ_DefaultLanguage + "</BA_DEFAULT_LANGUAGE><BA_SELECTED_LANGUAGE>" + LZ_AppLanguage + "</BA_SELECTED_LANGUAGE></BA_ROOT></ROOT>");
                   	}
                    //LZ_CallTypeID = "2";
                }else if (LZ_AppID.equals("3")) {
                	if(LZ_AppLanguage.equals(""))
                	{
                    	GZ_CallFlowDetailXML = GZ_CallFlowDetailXML.replace("</ROOT>", "<BA_ROOT><BA_DEFAULT_LANGUAGE>" + LZ_DefaultLanguage + "</BA_DEFAULT_LANGUAGE></BA_ROOT></ROOT>");
                	}
                	else
                	{
                		GZ_CallFlowDetailXML = GZ_CallFlowDetailXML.replace("</ROOT>", "<BA_ROOT><BA_DEFAULT_LANGUAGE>" + LZ_DefaultLanguage + "</BA_DEFAULT_LANGUAGE><BA_SELECTED_LANGUAGE>" + LZ_AppLanguage + "</BA_SELECTED_LANGUAGE></BA_ROOT></ROOT>");
                   	}
                	//LZ_CallTypeID = "3";
                } 
                else {
                	if(LZ_AppLanguage.equals(""))
                	{
                    	GZ_CallFlowDetailXML = GZ_CallFlowDetailXML.replace("</ROOT>", "<BA_ROOT><BA_DEFAULT_LANGUAGE>" + LZ_DefaultLanguage + "</BA_DEFAULT_LANGUAGE></BA_ROOT></ROOT>");
                	}
                	else
                	{
                		GZ_CallFlowDetailXML = GZ_CallFlowDetailXML.replace("</ROOT>", "<BA_ROOT><BA_DEFAULT_LANGUAGE>" + LZ_DefaultLanguage + "</BA_DEFAULT_LANGUAGE><BA_SELECTED_LANGUAGE>" + LZ_AppLanguage + "</BA_SELECTED_LANGUAGE></BA_ROOT></ROOT>");
                   	}
                	//LZ_CallTypeID = "1";
                }
                    
               }    
               else
               {
             	 LZ_DirectSalesDNIS = ConfigurationReader.configList.get("DIRECT_SALES_DNIS");
                 LZ_AgentDNIS = ConfigurationReader.configList.get("AGENT_DNIS");
           

                //System.out.println("index of Primary DNIS" + LZ_DirectSalesDNIS.indexOf(LZ_UsrDNIS));
                //System.out.println("index of Secondary DNIS" + LZ_AgentDNIS.indexOf(LZ_UsrDNIS));

                if (LZ_DirectSalesDNIS.indexOf(LZ_UsrDNIS) != -1) {
                    GZ_CallFlowDetailXML = GZ_CallFlowDetailXML.replace("</ROOT>", "<BA_ROOT></BA_ROOT></ROOT>");
                    //LZ_CallTypeID = "4";
                    LZ_AppID = "4";
                } else if (LZ_AgentDNIS.indexOf(LZ_UsrDNIS) != -1) {
                    GZ_CallFlowDetailXML = GZ_CallFlowDetailXML.replace("</ROOT>", "<BA_ROOT></BA_ROOT></ROOT>");
                   // LZ_CallTypeID = "2";
                    LZ_AppID = "2";
                } else {
                    GZ_CallFlowDetailXML = GZ_CallFlowDetailXML.replace("</ROOT>", "<BA_ROOT></BA_ROOT></ROOT>");
                   // LZ_CallTypeID = "1";
                    LZ_AppID = "1";
                }

               }
               	LZ_PrimaryDNIS = ConfigurationReader.configList.get("DNIS_PRIMARY");
               	LZ_SecondaryDNIS = ConfigurationReader.configList.get("DNIS_SECONDARY");
               
                if (LZ_PrimaryDNIS.indexOf(LZ_UsrDNIS) != -1) {
                    LZ_DCVAG = ConfigurationReader.configList.get("DCVAG_PRIMARY");
                    LZ_DCVQ = ConfigurationReader.configList.get("DCVQ_PRIMARY");
                } else if (LZ_SecondaryDNIS.indexOf(LZ_UsrDNIS) != -1) {
                    LZ_DCVAG = ConfigurationReader.configList.get("DCVAG_SECONDARY");
                    LZ_DCVQ = ConfigurationReader.configList.get("DCVQ_SECONDARY");
                } else {
                    LZ_DCVAG = ConfigurationReader.configList.get("DCVAG_PRIMARY");
                    LZ_DCVQ = ConfigurationReader.configList.get("DCVQ_PRIMARY");
                }


                Logger.info("", "UsrANI : " + LZ_UsrANI + " UsrDNIS : " + LZ_UsrDNIS + "CallSessionID : " + LZ_UsrCallSessionID
                        + " Usr Call UUID : " + LZ_UsrCallUUID + " Call Type ID : " + LZ_CallTypeID + " LZ_Date : " + LZ_Date, false);
                // Call Insert Call Detail Function
                CallDetailDAO objCallDetail = new CallDetailDAO();
                GZ_CallDetailID = objCallDetail.insertCallDetails(LZ_UsrANI, LZ_UsrDNIS, LZ_UsrCallUUID, LZ_UsrCallUUID, LZ_UsrCallSessionID, LZ_CallTypeID, LZ_Date, LZ_CallTypeID);
                // Append the Call Flow Detail XML
                StringBuilder sbTCD = new StringBuilder("<TBLCALLDETAIL>");
                sbTCD.append("<FLDCALLDETAILID>" + GZ_CallDetailID + "</FLDCALLDETAILID>");
                sbTCD.append("<FLDUUID>" + LZ_UsrCallUUID + "</FLDUUID>");
                sbTCD.append("<FLDCONNECTIONID>" + LZ_UsrCallUUID + "</FLDCONNECTIONID>");
                sbTCD.append("<FLDSESSIONID>" + LZ_UsrCallSessionID + "</FLDSESSIONID>");
                sbTCD.append("<FLDCLI>" + LZ_UsrANI + "</FLDCLI>");
                sbTCD.append("<FLDDNIS>" + LZ_UsrDNIS + "</FLDDNIS>");
                sbTCD.append("<FLDCALLTYPEID>" + LZ_CallTypeID + "</FLDCALLTYPEID>");
                sbTCD.append("<FLDCALLSTARTTIME>" + LZ_Date + "</FLDCALLSTARTTIME>");
                sbTCD.append("<FLDCALLENDTIME>" + LZ_Date + "</FLDCALLENDTIME>");
                sbTCD.append("<FLDLANGUAGESELECTED>" + "" + "</FLDLANGUAGESELECTED>");
                sbTCD.append("<FLDSUBSCRIBERID>" + "" + "</FLDSUBSCRIBERID>");
                sbTCD.append("<FLDSUBIDLIST>" + "" + "</FLDSUBIDLIST>");
                sbTCD.append("<FLDCALLERTYPE>" + "" + "</FLDCALLERTYPE>");
                sbTCD.append("<FLDSUBSCRIBERSEGMENT>" + "" + "</FLDSUBSCRIBERSEGMENT>");
                sbTCD.append("<FLDCALLDISCONNECTEDBY>" + "" + "</FLDCALLDISCONNECTEDBY>");
                sbTCD.append("<FLDCALLDISCONNECTREASON>" + "" + "</FLDCALLDISCONNECTREASON>");
                sbTCD.append("<FLDLASTTRAVERSEDCALLFLOWDETAILID>" + "" + "</FLDLASTTRAVERSEDCALLFLOWDETAILID>");
                sbTCD.append("<FLDTRANSFERSTATUS>" + "" + "</FLDTRANSFERSTATUS>");
                sbTCD.append("<FLDTRANSFERFAILUREREASON>" + "" + "</FLDTRANSFERFAILUREREASON>");
                sbTCD.append("<FLDTRANSFERTO>" + "" + "</FLDTRANSFERTO>");
                sbTCD.append("<FLDACCOUNTSTATUS>" + "" + "</FLDACCOUNTSTATUS>");
                sbTCD.append("<FLDACCOUNTSUBSTATUS>" + "" + "</FLDACCOUNTSUBSTATUS>");
                sbTCD.append("<FLDSUBIDCOUNT>" + "" + "</FLDSUBIDCOUNT>");
                sbTCD.append("<FLDNONRMNIDENTIFIER>" + "" + "</FLDNONRMNIDENTIFIER>");
                sbTCD.append("<FLDSUBIDVALIDATED>" + "" + "</FLDSUBIDVALIDATED>");
                sbTCD.append("<FLDAPPID>" + LZ_AppID + "</FLDAPPID>");
                sbTCD.append("</TBLCALLDETAIL></ROOT>");

                GZ_CallFlowDetailXML = GZ_CallFlowDetailXML.replace("</ROOT>", sbTCD);

                StringBuilder sbCTI = new StringBuilder("<CTIROOT>");
                //sbCTI.append("<CTIIVRLANGUAGE>" + "" + "</CTIIVRLANGUAGE>");
                //sbCTI.append("<CTISUBSCRIBERCOUNT>" + "" + "</CTISUBSCRIBERCOUNT>");
                //sbCTI.append("<CTIISRMNCTIISDND>" + "" + "</CTIISRMNCTIISDND>");
                //sbCTI.append("<CTIREPEATCALLCOUNT>" + "" + "</CTIREPEATCALLCOUNT>");
                //sbCTI.append("<CTIUCID>" + LZ_UsrCallUUID + "</CTIUCID>");
                sbCTI.append("<CTILASTMENU>0</CTILASTMENU>");
                //sbCTI.append("<CTILANGUAGEALERT>" + "" + "</CTILANGUAGEALERT>");
                //sbCTI.append("<CTITRANSACTIONALERT>" + "" + "</CTITRANSACTIONALERT>");
                //sbCTI.append("<CTICAMPAIGNCODE1>" + "" + "</CTICAMPAIGNCODE1>");
                //sbCTI.append("<CTICAMPAIGNCODE2>" + "" + "</CTICAMPAIGNCODE2>");
                //sbCTI.append("<CTISUBSCRIBERID>" + "" + "</CTISUBSCRIBERID>");
                //sbCTI.append("<CTIRMN>" + "" + "</CTIRMN>");
                //sbCTI.append("<CTISRWO>" + "" + "</CTISRWO>");
                sbCTI.append("<CTIDESK>MAS</CTIDESK>");
                sbCTI.append("<CTIVAG>" + LZ_DCVAG + "</CTIVAG>");
                sbCTI.append("<CTIVQ>" + LZ_DCVQ + "</CTIVQ>");
                sbCTI.append("</CTIROOT></ROOT>");

                GZ_CallFlowDetailXML = GZ_CallFlowDetailXML.replace("</ROOT>", sbCTI);

                StringBuilder sbTR = new StringBuilder("<TRANSACTIONROOT>");
                sbTR.append("0</TRANSACTIONROOT></ROOT>");

                GZ_CallFlowDetailXML = GZ_CallFlowDetailXML.replace("</ROOT>", sbTR);

                StringBuilder sbPG = new StringBuilder("<PGTRANSACTIONROOT>");
                sbPG.append("0</PGTRANSACTIONROOT></ROOT>");

                GZ_CallFlowDetailXML = GZ_CallFlowDetailXML.replace("</ROOT>", sbPG);
            }
        } catch (Exception ex) {
            Logger.error(GZ_CallDetailID, " Exception in  Insert Into CallDetail Page : " + ex.getMessage(), false);
        }finally{
           LZ_PrimaryDNIS = LZ_SecondaryDNIS = LZ_DCVAG = LZ_DCVQ = LZ_DirectSalesDNIS = LZ_AgentDNIS = LZ_DNISCode = LZ_UsrANI = LZ_UsrDNIS = LZ_UsrCallSessionID = LZ_UsrCallUUID = LZ_CallTypeID =  LZ_Date = null; 
        }
        JSONObject result = new JSONObject();
        result.put("CallDetailID", GZ_CallDetailID);
        //System.out.println("InsertIntoCallDetail_jsp output CallDetailID="+GZ_CallDetailID);
        result.put("CallFlowDetailXML", GZ_CallFlowDetailXML);
        //System.out.println("InsertIntoCallDetail_jsp output GZ_CallFlowDetailXML="+GZ_CallFlowDetailXML);
        return result;

    }

    ;
%>
<%-- GENERATED: DO NOT REMOVE --%> 
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONException"%>
<%@page import="java.util.Map"%>
<%@include file="../backend.jspf" %>
