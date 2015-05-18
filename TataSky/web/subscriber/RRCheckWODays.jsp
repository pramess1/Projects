<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>

<%@page import="com.tsg.database.gg.dataaccess.ValidateDateDAO"%>
<%@page import="com.tsg.log.Logger"%>
<%!

public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {
    
boolean b_SimulatorMode = false; // Simulator Mode by default is set to true.
// Input varibales
String LZ_CallDetailID="";
String BA_SUBSCRIBER_ID="";
String LZ_RequestType="";
String LZ_RRIPWODays="";
String LZ_CallFlowDetailXML = "";

// output varibales
String LZ_WO_Flag="";


        try {
                if(b_SimulatorMode){
                //  Test method
               
                
                } else {
                    // Realtime scenario
//                    LZ_CallDetailID = state.getString("LZ_CallDetailID");
//                    BA_SUBSCRIBER_ID = state.getString("BA_SUBSCRIBER_ID");
//                    LZ_RequestType=state.getString("LZ_RequestType");
//                    LZ_RRIPWODays = state.getString("LZ_RRIPWODays");
                    LZ_CallDetailID = state.optString("LZ_CallDetailID","");
                    BA_SUBSCRIBER_ID = state.optString("BA_SUBSCRIBER_ID","");
                    LZ_RequestType=state.optString("LZ_RequestType","");
                    LZ_RRIPWODays = state.optString("LZ_RRIPWODays","");  
		      LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");
                                     
                    Logger.info(LZ_CallDetailID," SUBSCRIBER_ID : " + BA_SUBSCRIBER_ID+ " RequestType : " + LZ_RequestType
                            + " RRIPWODays :" +LZ_RRIPWODays ,false);
                    ValidateDateDAO validateDateFalg = new ValidateDateDAO();
                    LZ_WO_Flag = validateDateFalg.validateDate(BA_SUBSCRIBER_ID,LZ_RequestType,Integer.parseInt(LZ_RRIPWODays),LZ_CallDetailID);

                   if (LZ_WO_Flag.equalsIgnoreCase("Y")) {

                        LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("<CTIROOT>", "<CTIROOT><CTITRANSACTIONALERT>Work order already exist</CTITRANSACTIONALERT>");

                    }
                
                }
        }catch(Exception ex){
           Logger.error(LZ_CallDetailID, " Exception in RRCheckWODays Page : " + ex.getMessage(), false);
        } finally {
            LZ_CallDetailID = BA_SUBSCRIBER_ID = LZ_RequestType = LZ_RRIPWODays = null;
        }
    
  
    JSONObject result = new JSONObject();
    result.put("LZ_WO_Flag",LZ_WO_Flag);
    result.put("CallFlowDetailXML", LZ_CallFlowDetailXML);


   
    
    return result; 
    
};
%>
<%-- GENERATED: DO NOT REMOVE --%> 
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONException"%>
<%@page import="java.util.Map"%>
<%@include file="../backend.jspf" %>