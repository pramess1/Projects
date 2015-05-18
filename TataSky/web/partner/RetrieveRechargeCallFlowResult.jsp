<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean LZ_SimulatorMode = false; // Simulator Mode by default is set to true.
        String LZ_CallFlowDetailXML = ""; // This is used to store the call flow detail XML.
        String LZ_MenuOptionList = ""; // This stores the menu options separated by comma. 
        String LZ_MenuCallFlowIDList = ""; // This is used to store the menu call flow IDs.

        String LZ_NoInputCFID = "900"; // This is used to store the no input call flow ID.
        String LZ_NoMatchCFID = "901"; // This is used to store the no match call flow ID.

        String LZ_CallDetailID = ""; // This is used to store the call detail ID.
        String LZ_CallFlowID = ""; // This is used to store the call flow ID.
        String LZ_CallFlowDateTime = ""; // This is used to store the call flow date time.
        String LZ_CallFlowInputStartDateTime = ""; // This is used to store the input start time (comma delimited list).
        String LZ_CallFlowInputEndDateTime = ""; // This is used to store the input end time (comma delimited list).
        String LZ_InputValue = ""; // This is used to store the input value (comma delimited list).
        String LZ_NoOfAttempts = ""; // This is used to store the number of attempts.
        String LZ_RuleID = ""; // This is used to store the rule ID.
        String LZ_IsSuccess = ""; // This is used to store the success status.

        String LZ_CallFlowFirstInputStartDateTime = ""; // This is used to store the first input start time.
        String LZ_CallFlowFirstInputEndDateTime = ""; // This is used to store the first input end time.
        String LZ_FirstInputID = ""; // This is used to store the first input ID.
        String LZ_FirstInputValue = ""; // This is used to store the first input value.
        String LZ_CallFlowSecondInputStartDateTime = ""; // This is used to store the second input start time.
        String LZ_CallFlowSecondInputEndDateTime = ""; // This is used to store the second input end time.
        String LZ_SecondInputID = ""; // This is used to store the second input ID.
        String LZ_SecondInputValue = ""; // This is used to store the second input value.
        String LZ_CallFlowThirdInputStartDateTime = ""; // This is used to store the third input start time.
        String LZ_CallFlowThirdInputEndDateTime = ""; // This is used to store thethird  input end time.
        String LZ_ThirdInputID = ""; // This is used to store the third input ID.
        String LZ_ThirdInputValue = ""; // This is used to store the third input value.

        try {
//            LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
//            LZ_CallDetailID = state.getString("GZ_DBCallDetailID");
//            LZ_CallFlowID = state.getString("LZ_CallFlowID");
//            LZ_NoOfAttempts = state.getString("LZ_RetryCount");
            LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");
            LZ_CallDetailID = state.optString("GZ_DBCallDetailID","");
            LZ_CallFlowID = state.optString("LZ_CallFlowID","");
            LZ_NoOfAttempts = state.optString("LZ_RetryCount","");            
            int LZ_tempAttempts = Integer.parseInt(LZ_NoOfAttempts);
            if (LZ_tempAttempts > 3) {
                LZ_NoOfAttempts = "3";
            }

            //LZ_RuleID = state.getString("LZ_RuleID");
//            LZ_IsSuccess = state.getString("LZ_IsSuccess");
//
//            LZ_MenuCallFlowIDList = state.getString("LZ_InputID");
            LZ_IsSuccess = state.optString("LZ_IsSuccess","");
            LZ_MenuCallFlowIDList = state.optString("LZ_InputID","");            
            //LZ_MenuOptionList = state.getString("LZ_MenuOptionList");

//            LZ_CallFlowInputStartDateTime = state.getString("LZ_CallFlowInputStartDateTime");
//            LZ_CallFlowInputEndDateTime = state.getString("LZ_CallFlowInputEndDateTime");
//            LZ_InputValue = state.getString("LZ_InputValue");
            LZ_CallFlowInputStartDateTime = state.optString("LZ_CallFlowInputStartDateTime","");
            LZ_CallFlowInputEndDateTime = state.optString("LZ_CallFlowInputEndDateTime","");
            LZ_InputValue = state.optString("LZ_InputValue","");            

            if (LZ_SimulatorMode) {
            } else {
                String[] LZ_tempStartDateTime = LZ_CallFlowInputStartDateTime.split(",");
                String[] LZ_tempEndDateTime = LZ_CallFlowInputEndDateTime.split(",");
                String[] LZ_tempInputID = LZ_MenuCallFlowIDList.split(",");
                String[] LZ_tempInputValue = LZ_InputValue.split(",");

                for (int i = 1; i < LZ_tempStartDateTime.length; i++) {
                    switch (i) {
                        case 1:
                            LZ_CallFlowFirstInputStartDateTime = LZ_tempStartDateTime[i];
                            LZ_CallFlowFirstInputEndDateTime = LZ_tempEndDateTime[i];
                            LZ_CallFlowDateTime = LZ_CallFlowFirstInputStartDateTime;
                            if (LZ_tempInputValue.length > 1) {
                                if (LZ_tempInputValue[i].isEmpty()) {
                                    LZ_FirstInputID = LZ_NoInputCFID;
                                } else if (!LZ_MenuOptionList.contains(LZ_tempInputValue[i])) {
                                    LZ_FirstInputID = LZ_NoMatchCFID;
                                } else {
                                    String[] LZ_tempOptionList = LZ_MenuOptionList.split(",");

                                    for (int j = 1; j < LZ_tempOptionList.length; j++) {
                                        if (LZ_tempInputValue[i].equals(LZ_tempOptionList[j])) {
                                            LZ_FirstInputID = LZ_tempInputID[j];
                                        }
                                    }
                                }

                                LZ_FirstInputValue = LZ_tempInputValue[i];
                            } else {
                                LZ_FirstInputID = LZ_NoInputCFID;
                            }
                            break;
                        case 2:
                            LZ_CallFlowSecondInputStartDateTime = LZ_tempStartDateTime[i];
                            LZ_CallFlowSecondInputEndDateTime = LZ_tempEndDateTime[i];

                            if (LZ_tempInputValue.length > 2) {
                                if (LZ_tempInputValue[i].isEmpty()) {
                                    LZ_SecondInputID = LZ_NoInputCFID;
                                } else if (!LZ_MenuOptionList.contains(LZ_tempInputValue[i])) {
                                    LZ_SecondInputID = LZ_NoMatchCFID;
                                } else {
                                    String[] LZ_tempOptionList = LZ_MenuOptionList.split(",");

                                    for (int j = 1; j < LZ_tempOptionList.length; j++) {
                                        if (LZ_tempInputValue[i].equals(LZ_tempOptionList[j])) {
                                            LZ_SecondInputID = LZ_tempInputID[j];
                                        }
                                    }
                                }

                                LZ_SecondInputValue = LZ_tempInputValue[i];
                            } else {
                                LZ_SecondInputID = LZ_NoInputCFID;
                            }
                            break;
                        case 3:
                            LZ_CallFlowThirdInputStartDateTime = LZ_tempStartDateTime[i];
                            LZ_CallFlowThirdInputEndDateTime = LZ_tempEndDateTime[i];

                            if (LZ_tempInputValue.length > 3) {
                                if (LZ_tempInputValue[i].isEmpty()) {
                                    LZ_ThirdInputID = LZ_NoInputCFID;
                                } else if (!LZ_MenuOptionList.contains(LZ_tempInputValue[i])) {
                                    LZ_ThirdInputID = LZ_NoMatchCFID;
                                } else {
                                    String[] LZ_tempOptionList = LZ_MenuOptionList.split(",");

                                    for (int j = 1; j < LZ_tempOptionList.length; j++) {
                                        if (LZ_tempInputValue[i].equals(LZ_tempOptionList[j])) {
                                            LZ_ThirdInputID = LZ_tempInputID[j];
                                        }
                                    }
                                }

                                LZ_ThirdInputValue = LZ_tempInputValue[i];
                            } else {
                                LZ_ThirdInputID = LZ_NoInputCFID;
                            }
                            break;
                    }
                }

                int LZ_StartIndex = LZ_CallFlowDetailXML.indexOf("<CTILASTMENU>");
                int LZ_EndIndex = LZ_CallFlowDetailXML.indexOf("</CTILASTMENU>", LZ_StartIndex) + 14;
                String LZ_temp = LZ_CallFlowDetailXML.substring(LZ_StartIndex, LZ_EndIndex);

                if (LZ_ThirdInputID.isEmpty()) {
                    if (LZ_SecondInputID.isEmpty()) {
                        if (LZ_FirstInputID.isEmpty()) {
                            LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace(LZ_temp, "<CTILASTMENU>" + LZ_CallFlowID + "</CTILASTMENU>");
                        } else {
                            LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace(LZ_temp, "<CTILASTMENU>" + LZ_FirstInputID + "</CTILASTMENU>");
                        }
                    } else {
                        LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace(LZ_temp, "<CTILASTMENU>" + LZ_SecondInputID + "</CTILASTMENU>");
                    }
                } else {
                    LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace(LZ_temp, "<CTILASTMENU>" + LZ_ThirdInputID + "</CTILASTMENU>");
                }

                StringBuilder sbCFD = new StringBuilder("<TBLCALLFLOWDETAIL>");
                sbCFD.append("<FLDCALLDETAILID>" + LZ_CallDetailID + "</FLDCALLDETAILID>");
                sbCFD.append("<FLDCALLFLOWID>" + LZ_CallFlowID + "</FLDCALLFLOWID>");
                sbCFD.append("<FLDCALLFLOWDATETIME>" + LZ_CallFlowDateTime + "</FLDCALLFLOWDATETIME>");
                sbCFD.append("<FLDCALLFLOWFIRSTINPUTSTARTDATETIME>" + LZ_CallFlowFirstInputStartDateTime + "</FLDCALLFLOWFIRSTINPUTSTARTDATETIME>");
                sbCFD.append("<FLDCALLFLOWFIRSTINPUTENDDATETIME>" + LZ_CallFlowFirstInputEndDateTime + "</FLDCALLFLOWFIRSTINPUTENDDATETIME>");
                sbCFD.append("<FLDFIRSTINPUTID>" + LZ_FirstInputID + "</FLDFIRSTINPUTID>");
                sbCFD.append("<FLDFIRSTINPUTVALUE>" + LZ_FirstInputValue + "</FLDFIRSTINPUTVALUE>");
                sbCFD.append("<FLDCALLFLOWSECONDINPUTSTARTDATETIME>" + LZ_CallFlowSecondInputStartDateTime + "</FLDCALLFLOWSECONDINPUTSTARTDATETIME>");
                sbCFD.append("<FLDCALLFLOWSECONDINPUTENDDATETIME>" + LZ_CallFlowSecondInputEndDateTime + "</FLDCALLFLOWSECONDINPUTENDDATETIME>");
                sbCFD.append("<FLDSECONDINPUTID>" + LZ_SecondInputID + "</FLDSECONDINPUTID>");
                sbCFD.append("<FLDSECONDINPUTVALUE>" + LZ_SecondInputValue + "</FLDSECONDINPUTVALUE>");
                sbCFD.append("<FLDCALLFLOWTHIRDINPUTSTARTDATETIME>" + LZ_CallFlowThirdInputStartDateTime + "</FLDCALLFLOWTHIRDINPUTSTARTDATETIME>");
                sbCFD.append("<FLDCALLFLOWTHIRDINPUTENDDATETIME>" + LZ_CallFlowThirdInputEndDateTime + "</FLDCALLFLOWTHIRDINPUTENDDATETIME>");
                sbCFD.append("<FLDTHIRDINPUTID>" + LZ_ThirdInputID + "</FLDTHIRDINPUTID>");
                sbCFD.append("<FLDTHIRDINPUTVALUE>" + LZ_ThirdInputValue + "</FLDTHIRDINPUTVALUE>");
                sbCFD.append("<FLDNOOFATTEMPTS>" + LZ_NoOfAttempts + "</FLDNOOFATTEMPTS>");
                sbCFD.append("<FLDRULEID>" + LZ_RuleID + "</FLDRULEID>");
                sbCFD.append("<FLDISSUCCESS>" + LZ_IsSuccess + "</FLDISSUCCESS>");
                sbCFD.append("</TBLCALLFLOWDETAIL></ROOT>");

                LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</ROOT>", sbCFD);
            }
        } catch (Exception ex) {
            Logger.error(LZ_CallDetailID, " Exception in RetrieveRechargeCallFlowResult Page : " + ex.getMessage(), false);
        }finally {
         
              LZ_MenuOptionList = LZ_MenuCallFlowIDList = LZ_NoInputCFID = LZ_NoMatchCFID = LZ_CallDetailID = LZ_CallFlowID = LZ_CallFlowDateTime = LZ_CallFlowInputStartDateTime = LZ_CallFlowInputEndDateTime = LZ_InputValue = LZ_NoOfAttempts =LZ_RuleID = LZ_IsSuccess = LZ_CallFlowFirstInputStartDateTime = LZ_CallFlowFirstInputEndDateTime = LZ_FirstInputID =LZ_FirstInputValue = LZ_CallFlowSecondInputStartDateTime = LZ_CallFlowSecondInputEndDateTime = LZ_SecondInputID =LZ_SecondInputValue = LZ_CallFlowThirdInputStartDateTime = LZ_CallFlowThirdInputEndDateTime = LZ_ThirdInputID = LZ_ThirdInputValue = null;
        }

        JSONObject result = new JSONObject();
        result.put("CallFlowDetailXML", LZ_CallFlowDetailXML);

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

<%@page import="org.w3c.dom.Document"%>
<%@page import="Common.ActionObjects.*"%>

<%@include file="../backend.jspf" %>