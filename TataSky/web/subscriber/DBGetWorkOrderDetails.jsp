<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>

<%@page import="java.util.Iterator"%>
<%@page import="java.util.*"%>
<%@page import="com.tsg.util.Util"%>
<%@page import="com.tsg.xml.GenerateXml"%>
<%@page import="com.tsg.database.gg.dataaccess.GetWorkOrderDetailsDAO"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {
        // Input varibales
        String BA_SUBSCRIBER_ID = "";

        String LZ_CallFlowDetailXML = "";

        String LZ_RequestXML = "";

        String LZ_ResponseXML = "";

        String LZ_DBCallDetailID = "";

        String LZ_ServiceID = "WOD";

        String LZ_TransStartTime = Util.getCurrentDateTime();

        String LZ_TransEndTime = "";

        String LZ_errorcode = "00";

        String LZ_errorMsg = "";

        // output varibales
        String LZ_WO_no = "";

        String LZ_WO_status = "";

        String LZ_WO_scheduleDate = "";


        try {

            // Realtime scenario
//            BA_SUBSCRIBER_ID = state.getString("BA_SUBSCRIBER_ID");
//
//            LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
//
//            LZ_DBCallDetailID = state.getString("LZ_CallDetailID");
            
            BA_SUBSCRIBER_ID = state.optString("BA_SUBSCRIBER_ID","");

            LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");

            LZ_DBCallDetailID = state.optString("LZ_CallDetailID","");

            Logger.info(LZ_DBCallDetailID, " SUBSCRIBER_ID : " + BA_SUBSCRIBER_ID, false);

            GetWorkOrderDetailsDAO getWorkOrderDetailsDAO = new GetWorkOrderDetailsDAO();

            ArrayList stateCodeList = getWorkOrderDetailsDAO.getWorkOrderDetails(BA_SUBSCRIBER_ID, LZ_DBCallDetailID);

            Iterator stateCodeItr = stateCodeList.iterator();

            while (stateCodeItr.hasNext()) {

                getWorkOrderDetailsDAO = (GetWorkOrderDetailsDAO) stateCodeItr.next();

                LZ_WO_no = getWorkOrderDetailsDAO.getWorkOrderNumber();

                LZ_WO_status = getWorkOrderDetailsDAO.getWorkOrderStatus();

                LZ_WO_scheduleDate = getWorkOrderDetailsDAO.getWorkOrderScheduledDate();
            }

            if (LZ_WO_status.equalsIgnoreCase("Scheduled")) {

                String difference = Util.getDateDifference(Util.getCurrentDateTime(), LZ_WO_scheduleDate, "yyyy-MM-dd HH:mm:ss");

                difference = difference.substring(0, 1);

                if (difference.equals("-")) {

                    LZ_WO_status = "Installer Missed Appointment";

                }

            }
        } catch (Exception ex) {

            Logger.error(LZ_DBCallDetailID, " Exception in Get Work Order Details page :   " + ex.getMessage(), false);

        } finally {
            
            try {
                
                LZ_TransEndTime = Util.getCurrentDateTime();

                LZ_errorMsg = "Success";

                if (!LZ_WO_status.equalsIgnoreCase("SCHEDULED")) {

                    if ((LZ_WO_status.equalsIgnoreCase("")) || (LZ_WO_status.equalsIgnoreCase(null))) {

                        LZ_errorMsg = "Failure";

                        LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</CTIROOT>", "<CTITRANSACTIONALERT>WO : No Work Order</CTITRANSACTIONALERT></CTIROOT>");

                    } else {

                        LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</CTIROOT>", "<CTITRANSACTIONALERT>WO : " + LZ_WO_status + "</CTITRANSACTIONALERT></CTIROOT>");

                    }

                }

                LZ_RequestXML = "<tata-sky><subscriber_id>" + BA_SUBSCRIBER_ID + "</subscriber_id></tata-sky>";

                LZ_ResponseXML = "<tata-sky><work_order_no>" + LZ_WO_no + "</work_order_no><work_order_status>" + LZ_WO_status + "</work_order_status><work_order_schedule_date>" + LZ_WO_scheduleDate + "</work_order_schedule_date></tata-sky>";

                LZ_errorMsg = LZ_WO_status;

                if (LZ_WO_status.equalsIgnoreCase("Cancelled")) {
                    
                    LZ_errorcode = "302";
                    
                } else if (LZ_WO_status.equalsIgnoreCase("Verified")) {
                    
                    LZ_errorcode = "303";
                    
                } else if (LZ_WO_status.equalsIgnoreCase("Scheduled")) {
                    
                    LZ_errorcode = "301";
                    
                } else if (LZ_WO_status.equalsIgnoreCase("In Progress")) {
                    
                    LZ_errorcode = "304";
                    
                } else if (LZ_WO_status.equalsIgnoreCase("Installer Missed Appointment")) {
                    
                    LZ_errorcode = "305";
                    
                } else if (LZ_WO_status.equalsIgnoreCase("On Hold")) {
                    
                    LZ_errorcode = "306";
                    
                } else if (LZ_WO_status.equalsIgnoreCase("Cancellations")) {
                    
                    LZ_errorcode = "307";
                    
                } else if (LZ_WO_status.equalsIgnoreCase("UnScheduled")) {
                    
                    LZ_errorcode = "308";
                    
                } else if (LZ_WO_status.equalsIgnoreCase("Completed")) {
                    
                    LZ_errorcode = "300";
                }
                
                String transDetailXml = new GenerateXml().requestTranscationDetail(LZ_DBCallDetailID, LZ_ServiceID, LZ_TransStartTime,
                        LZ_TransEndTime, LZ_errorcode, LZ_errorMsg, LZ_RequestXML, LZ_ResponseXML);

                LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</TRANSACTIONROOT>", transDetailXml);

                if (LZ_WO_status.equalsIgnoreCase("Installer Missed Appointment")) {

                    LZ_WO_status = "Scheduled";
                }
                
                LZ_WO_no = LZ_WO_no.replace("-", "");
                
            } catch (Exception ex1) {
                
                Logger.error(LZ_DBCallDetailID, " Exception in Get Work Order Details Finally Block Page :   " + ex1.getMessage(), false);
            }
            
            BA_SUBSCRIBER_ID = LZ_RequestXML = LZ_ResponseXML = LZ_DBCallDetailID = LZ_ServiceID = LZ_TransStartTime = LZ_TransEndTime = LZ_errorcode = LZ_errorMsg = null;
        }

        JSONObject result = new JSONObject();

        result.put("LZ_WO_no", LZ_WO_no);

        result.put("LZ_WO_status", LZ_WO_status);

        result.put("LZ_WO_scheduleDate", LZ_WO_scheduleDate);

        result.put("CallFlowDetailXML", LZ_CallFlowDetailXML);

        Logger.info(LZ_DBCallDetailID, " Work Order No : " + LZ_WO_no + " Work Order Status : " + LZ_WO_status
                + " Work Order Scheduled Date : " + LZ_WO_scheduleDate, false);

        return result;

    }

    ;
%>
<%-- GENERATED: DO NOT REMOVE --%> 
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONException"%>
<%@page import="java.util.Map"%>
<%@include file="../backend.jspf" %>