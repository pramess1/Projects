<%@page language="java" contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean LZ_SimulatorMode = false; // Simulator Mode by default is set to true.
        String LZ_InstallationScheduleEndTime = ""; // This is offset to +1 of schedule time.
        String LZ_DBCallDetailID = ""; // This is used to store the call detail ID.
        try {
//            String BA_WO_SCHEDULE_DATE = state.getString("LZ_WO_SCHEDULE_DATE");
             String BA_WO_SCHEDULE_DATE = state.optString("LZ_WO_SCHEDULE_DATE","");            

            if (LZ_SimulatorMode) {
                DateFormat LZ_DateTimeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                Date LZ_CurrentDateTime = new Date();
                LZ_InstallationScheduleEndTime = LZ_DateTimeFormat.format(LZ_CurrentDateTime).toString();
            } else {
                DateFormat LZ_DateTimeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                Date LZ_tempEndDateTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(BA_WO_SCHEDULE_DATE);
                Date LZ_CurrentDateTime = new Date();

                if (LZ_tempEndDateTime.after(LZ_CurrentDateTime)) {
                    Calendar calendar = Calendar.getInstance();
                    calendar.setTime(LZ_tempEndDateTime);
                    calendar.add(Calendar.HOUR_OF_DAY, 1);
                    LZ_tempEndDateTime = calendar.getTime();
                    LZ_InstallationScheduleEndTime = LZ_DateTimeFormat.format(LZ_tempEndDateTime).toString();
                }
            }
        } catch (Exception ex) {
            Logger.error(LZ_DBCallDetailID, " Exception in RetrieveInstallationScheduleEndTime Page : " + ex.getMessage(), false);
        }finally{
                 LZ_DBCallDetailID =null;
        }

        JSONObject result = new JSONObject();
        result.put("InstallationScheduleEndTime", LZ_InstallationScheduleEndTime);

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
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@include file="../backend.jspf" %>