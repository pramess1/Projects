<%@page language="java" contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean LZ_SimulatorMode = false; // Simulator Mode by default is set to true.
        String LZ_IsValidExpiryDate = "Failure"; // This checks if the entered expiry date is valid.
        String LZ_ExpDate = ""; // This stores the expiry date.
        String LZ_CallDetailID = "";

        try {
            if (LZ_SimulatorMode) {
            } else {
//                LZ_CallDetailID = state.getString("GZ_DBCallDetailID");
                LZ_CallDetailID = state.optString("GZ_DBCallDetailID","");                
                DateFormat LZ_DateTimeFormat = new SimpleDateFormat("yyyy-MM-dd");
                Date LZ_CurrentDateTime = new Date();
                String LZ_CallFlowDateTime = LZ_DateTimeFormat.format(LZ_CurrentDateTime).toString();
                Calendar LZ_Calendar = Calendar.getInstance();
                LZ_Calendar.setTime(LZ_DateTimeFormat.parse(LZ_CallFlowDateTime));
//                LZ_ExpDate = state.getString("LZ_ExpDate");
                LZ_ExpDate = state.optString("LZ_ExpDate","");                
                String LZ_Month = LZ_ExpDate.substring(0, 2);
                String LZ_Year = "20" + LZ_ExpDate.substring(2, 4);
                int LZ_tempMonth = Integer.parseInt(LZ_Month);
                int LZ_tempYear = Integer.parseInt(LZ_Year);
                if (LZ_tempMonth > 0 && LZ_tempMonth <= 12) {
                    if (LZ_tempYear > LZ_Calendar.get(Calendar.YEAR)
                            || (LZ_tempYear == LZ_Calendar.get(Calendar.YEAR) && LZ_tempMonth >= (LZ_Calendar.get(Calendar.MONTH) + 1))) {
                        LZ_IsValidExpiryDate = "SUCCESS";
                    }
                }
            }
        } catch (Exception ex) {
            Logger.error(LZ_CallDetailID, " Exception in Validate Expiry Date Page : " + ex.getMessage(), false);
        } finally {
            LZ_CallDetailID = null;
        }

        JSONObject result = new JSONObject();
        result.put("IsValidExpiryDate", LZ_IsValidExpiryDate);
        result.put("ExpiryDate", LZ_ExpDate);

        return result;

    }

    ;
%>
<%-- GENERATED: DO NOT REMOVE --%> 
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONException"%>
<%@page import="java.util.Map"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@include file="../backend.jspf" %>