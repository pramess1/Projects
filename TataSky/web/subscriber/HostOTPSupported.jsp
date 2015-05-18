<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>
<%@page import="org.apache.log4j.Logger"%>
<%!
static Logger log = Logger.getLogger(RelocationRequest_jsp.class);
private boolean b_SimulatorMode = true; // Simulator Mode by default is set to true.


private String LZ_IsOTPSupported;

public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {
    
        try
        {
                if(b_SimulatorMode)
                {
					//  Test method
					
					LZ_IsOTPSupported = "Success";

                }
                else
                {
                        // Realtime scenario
                }
        }
        catch (Exception ex)
        {
                // Log Exception
        }
    
  
    JSONObject result = new JSONObject();
	result.put("LZ_IsOTPSupported", LZ_IsOTPSupported);
    return result;
    
};
%>
<%-- GENERATED: DO NOT REMOVE --%> 
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONException"%>
<%@page import="java.util.Map"%>
<%@include file="../backend.jspf" %>