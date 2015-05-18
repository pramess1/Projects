<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.*"%>
<%@page import="com.tsg.database.gg.dataaccess.GetEVDBalanceDAO"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {
    
        // Input varibales
        boolean b_SimulatorMode = false; // Simulator Mode by default is set to true.
        
        String BA_PARTNER_ID = "";
        
        String LZ_DBCallDetailID = ""; // This is used to store the call detail ID.
        
        String LZ_ANI = "";

        // output varibales
        String LZ_Balance = "";

        try {
            
            if (b_SimulatorMode) {
                //  Test method
            } else {
                // Realtime scenario
//                LZ_DBCallDetailID = state.getString("LZ_DBCallDetailID");
//                
//                BA_PARTNER_ID = state.getString("BA_PARTNER_ID");
//                
//                LZ_ANI = state.getString("LZ_ANI");
                
                LZ_DBCallDetailID = state.optString("LZ_DBCallDetailID","");
                
                BA_PARTNER_ID = state.optString("BA_PARTNER_ID","");
                
                LZ_ANI = state.optString("LZ_ANI","");
                
                Logger.info(LZ_DBCallDetailID, " PARTNER ID : " + BA_PARTNER_ID + " ANI :" + LZ_ANI, false);
                              
                LZ_Balance = new GetEVDBalanceDAO().getEVDBalance(BA_PARTNER_ID, LZ_ANI,LZ_DBCallDetailID);
            }
        } catch (Exception ex) {
           
            Logger.error(LZ_DBCallDetailID, " Exception in DBEVDBalance Page : " + ex.getMessage(), false);
            
        } finally {
            
            BA_PARTNER_ID = LZ_DBCallDetailID = LZ_ANI = null; 
            
        }

        JSONObject result = new JSONObject();
        
        result.put("LZ_Balance", LZ_Balance);
               
        return result;

    };
%>
<%-- GENERATED: DO NOT REMOVE --%> 
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONException"%>
<%@page import="java.util.Map"%>
<%@include file="../backend.jspf" %>