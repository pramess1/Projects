<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean LZ_SimulatorMode = false; // Simulator Mode by default is set to true.
        String LZ_MobileNumber = ""; // This is used to store the mobile number entered by caller.

        String LZ_InvalidMobileNumberList = "0000000000;1111111111;2222222222;3333333333;4444444444;5555555555;6666666666;7777777777;8888888888;9999999999"; // This stores the invalid mobile number list.
        String LZ_IsSuccess = "Y"; // This is used to store the success status.

        try {
//            LZ_MobileNumber = state.getString("LZ_RMN");
             LZ_MobileNumber = state.optString("LZ_RMN","");            

            if (LZ_SimulatorMode) {
            } else {
                String[] LZ_InvalidMobileNumberArray = LZ_InvalidMobileNumberList.split(";");

                for (int i = 0; i < LZ_InvalidMobileNumberArray.length; i++) {
                    if (LZ_InvalidMobileNumberArray[i].equals(LZ_MobileNumber)) {
                        LZ_IsSuccess = "N";
                        break;
                    }
                }
                LZ_InvalidMobileNumberArray = null;
            }
        } catch (Exception ex) {
            Logger.error("", " Exception in ValidateMobileNumber Page : " + ex.getMessage(), false);
        } finally {
            LZ_MobileNumber = LZ_InvalidMobileNumberList = null;
        }

        JSONObject result = new JSONObject();
        result.put("IsSuccess", LZ_IsSuccess);

        return result;

    };
%>
<%-- GENERATED: DO NOT REMOVE --%> 
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONException"%>
<%@page import="java.util.Map"%>
<%@include file="../backend.jspf" %>