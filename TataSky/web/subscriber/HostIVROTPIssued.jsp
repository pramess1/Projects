<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>

<%!
private boolean b_SimulatorMode = true; // Simulator Mode by default is set to true.


private String LZ_IsIVRPasswordIssued;

public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {
    
        try
        {
                if(b_SimulatorMode)
                {
					//  Test method
					
					LZ_IsIVRPasswordIssued = "Success";

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
	result.put("LZ_IsIVRPasswordIssued", LZ_IsIVRPasswordIssued);
    return result;
    
};
%>
<%-- GENERATED: DO NOT REMOVE --%> 
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONException"%>
<%@page import="java.util.Map"%>
<%@include file="../backend.jspf" %>