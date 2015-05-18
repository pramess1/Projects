<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>
<%@page import="com.tsg.recharge.LuhnAlgoImplValidateCreditCard"%>
<%@page import="com.tsg.log.Logger"%>
<%@page import="java.util.Arrays"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean b_SimulatorMode = false; // Simulator Mode by default is set to true.
        String LZ_CallDetailID = "";
        String LZ_HostResponse = "";
        String LZ_CardType = "";
        String s_LZ_CardNumber = "";
        boolean s_LZ_HostResponse;
        try {
            if (b_SimulatorMode) {
                // Realtime scenario
            } else {
                // Test method
//                LZ_CallDetailID = state.getString("GZ_DBCallDetailID");
//                s_LZ_CardNumber = state.getString("LZ_CardNumber");
                
                LZ_CallDetailID = state.optString("GZ_DBCallDetailID","");
          
                s_LZ_CardNumber = state.optString("LZ_CardNumber","");

                s_LZ_HostResponse = LuhnAlgoImplValidateCreditCard.Check(s_LZ_CardNumber);

                LZ_CardType = LuhnAlgoImplValidateCreditCard.getCreditCardType(s_LZ_CardNumber);

               if (s_LZ_HostResponse) {
                   
                    LZ_HostResponse = "Success";
                    
                } else {
                    
                    LZ_HostResponse = "Failure";
                    
                }
                Logger.info(LZ_CallDetailID, "Card Type : " + LZ_CardType + " HostResponse : " + LZ_HostResponse, false);
            }
        } catch (Exception ex) {
            
            Logger.error(LZ_CallDetailID, " Exception in Card Number Validate Page : " + ex.getMessage(), false);
        
        } finally {
        
               LZ_CallDetailID = s_LZ_CardNumber = null;
        }
        JSONObject result = new JSONObject();
        result.put("LZ_HostResponse", LZ_HostResponse);
        result.put("LZ_CardType", LZ_CardType);
        return result;

    }

    ;
%>
<%-- GENERATED: DO NOT REMOVE --%> 
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONException"%>
<%@page import="java.util.Map"%>
<%@include file="../backend.jspf" %>


