<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>

<%@page import="com.tsg.util.Util"%>
<%@page import="com.tsg.database.ivr.dataaccess.CallDetailDAO"%>
<%@page import="com.tsg.log.Logger"%>

<%!    

public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {
    
    // Input variables
        boolean b_SimulatorMode = false; // Simulator Mode by default is set to true.
        String LZ_UsrANI = ""; // This is used to store the ANI of the call.
        String LZ_UsrDNIS = ""; // This is used to store the DNIS of the call.
        String LZ_UsrCallSessionID = ""; // This is used to store the session of a particular call.
        String LZ_UsrCallUUID = ""; // This is used to store the CallUUID.
        String LZ_CallTypeID = ""; // This is used to store the call type, inbound/outbound.
        String GZ_CallFlowDetailXML = ""; // This is used to store the call flow detail XML.
        String LZ_Date = ""; // This is used to store the date and time of call start.
 
        // Output variables
        String GZ_CallDetailID = ""; // The CallDetailID needs to be returned after insertion.
 
        try
        {
            if (b_SimulatorMode)
            {
            } 
            else
            {
                // Realtime scenario
				
//                        LZ_UsrANI = state.getString("LZ_UsrANI");
                        LZ_UsrANI = state.optString("LZ_UsrANI","");                
                        
                           if(LZ_UsrANI.length() > 10)
                           {
                           LZ_UsrANI = LZ_UsrANI.substring(LZ_UsrANI.length() - 10, 10);
                           }
                              
//                        LZ_UsrDNIS = state.getString("LZ_UsrDNIS");
//       
//                        LZ_UsrCallSessionID = state.getString("LZ_UsrCallSessionID");
//       
//                        LZ_UsrCallUUID = state.getString("LZ_UsrCallUUID");
//       
//                        LZ_CallTypeID = state.getString("LZ_CallTypeID");
//       
//                        LZ_CallTypeID = state.getString("LZ_CallTypeID");
//                        
//                        GZ_CallFlowDetailXML = state.getString("GZ_CallFlowDetailXML");
                        
                        LZ_UsrDNIS = state.optString("LZ_UsrDNIS","");
       
                        LZ_UsrCallSessionID = state.optString("LZ_UsrCallSessionID","");
       
                        LZ_UsrCallUUID = state.optString("LZ_UsrCallUUID","");
       
                        LZ_CallTypeID = state.optString("LZ_CallTypeID","");
       
                        LZ_CallTypeID = state.optString("LZ_CallTypeID","");
                        
                        GZ_CallFlowDetailXML = state.optString("GZ_CallFlowDetailXML","");                        
                        
                        LZ_Date = Util.getCurrentDateTime();
                        
                        Logger.info("","UsrANI : " + LZ_UsrANI + " UsrDNIS : " +LZ_UsrDNIS+ " UsrCallSessionID :" + LZ_UsrCallSessionID
                                + " UsrCallUUID : " + LZ_UsrCallUUID + " CallTypeID : " + LZ_CallTypeID +" Date : " + LZ_Date, false);

                        // Call Insert Call Detail Function
                        CallDetailDAO objCallDetail = new CallDetailDAO();
                        GZ_CallDetailID = objCallDetail.insertCallDetails(LZ_UsrANI, LZ_UsrDNIS, LZ_UsrCallUUID, LZ_UsrCallUUID, LZ_UsrCallSessionID, LZ_CallTypeID, LZ_Date, LZ_CallTypeID);
				
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
                        sbCTI.append("<CTIDESK>DEF</CTIDESK>");
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
           Logger.error(GZ_CallDetailID, " Exception in InsertIntoCallDetail Page : " + ex.getMessage(), false);
        }finally{
        LZ_UsrANI =  LZ_UsrDNIS = LZ_UsrCallSessionID = LZ_UsrCallUUID = LZ_CallTypeID =  LZ_Date = null;
        
        }

        JSONObject result = new JSONObject();
        result.put("CallDetailID",GZ_CallDetailID);
     
        result.put("CallFlowDetailXML",GZ_CallFlowDetailXML);
     
        return result;

    };
%>
<%-- GENERATED: DO NOT REMOVE --%> 
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONException"%>
<%@page import="java.util.Map"%>
<%@include file="../backend.jspf" %>
