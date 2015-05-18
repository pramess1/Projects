<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>
<%@page import="com.tsg.log.Logger"%>
<%@page import="com.tsg.atom.MaskCardNumber"%>
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
        String LZ_RuleDescription = "";


        try {
            LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML", "");

            LZ_CallDetailID = state.optString("GZ_DBCallDetailID", "");
            if (LZ_CallDetailID.equals("")) {
                LZ_CallDetailID = state.optString("LZ_DBCallDetailID", "");
            }
            if (LZ_CallDetailID.equals("")) {
                LZ_CallDetailID = state.optString("LZ_CallDetailID", "");
            }

            LZ_CallFlowID = state.optString("LZ_CallFlowID", "");

            LZ_CallFlowDateTime = state.optString("LZ_CallFlowDateTime", "");

            LZ_NoOfAttempts = state.optString("LZ_NoOfAttempts", "");

            int LZ_tempAttempts = Integer.parseInt(LZ_NoOfAttempts);

            if (LZ_tempAttempts > 3) {
                LZ_NoOfAttempts = "3";
            }

            LZ_RuleID = state.optString("LZ_RuleID", "");

            LZ_RuleDescription = state.optString("LZ_RuleDesc", "");

            LZ_IsSuccess = state.optString("LZ_IsSuccess", "");

            LZ_MenuCallFlowIDList = state.optString("LZ_MenuCallFlowIDList", "");


            LZ_MenuOptionList = state.optString("LZ_MenuOptionList", "");

            LZ_CallFlowInputStartDateTime = state.optString("LZ_CallFlowInputStartDateTime", "");


            LZ_CallFlowInputEndDateTime = state.optString("LZ_CallFlowInputEndDateTime", "");
            LZ_InputValue = state.optString("LZ_InputValue", "");

            Logger.info(LZ_CallDetailID, " RetrieveRechargeCallFlowResult Input = LZ_CallFlowID : " + LZ_CallFlowID + " LZ_NoOfAttempts : " + LZ_NoOfAttempts + " LZ_tempAttempts : " + LZ_tempAttempts
                    + " LZ_RuleID : " + LZ_RuleID + " LZ_RuleDescription : " + LZ_RuleDescription + " LZ_InputValue : " + LZ_InputValue, false);


            /*    System.out.println("LZ_CallDetailID=" + LZ_CallDetailID);
             System.out.println("LZ_CallFlowID=" + LZ_CallFlowID);
             System.out.println("LZ_CallFlowDateTime=" + LZ_CallFlowDateTime);
             System.out.println("LZ_NoOfAttempts=" + LZ_NoOfAttempts);
             System.out.println("LZ_RuleID=" + LZ_RuleID);
             System.out.println("LZ_RuleDesc=" + LZ_RuleDescription);
             System.out.println("LZ_IsSuccess=" + LZ_IsSuccess);
             System.out.println("LZ_MenuCallFlowIDList=" + LZ_MenuCallFlowIDList );
             System.out.println("LZ_MenuOptionList=" + LZ_MenuOptionList );
             System.out.println("LZ_CallFlowInputStartDateTime=" + LZ_CallFlowInputStartDateTime );
             System.out.println("LZ_CallFlowInputEndDateTime=" + LZ_CallFlowInputEndDateTime );
             System.out.println("LZ_InputValue=" + LZ_InputValue );
             System.out.println("LZ_CallFlowDetailXML=" + LZ_CallFlowDetailXML );*/

            if (!LZ_CallFlowInputStartDateTime.equals("")) {
                if (!LZ_CallFlowInputStartDateTime.substring(0, 1).equals(",")) {
                    LZ_CallFlowInputStartDateTime = "," + LZ_CallFlowInputStartDateTime;
                }
            }


            if (!LZ_CallFlowInputEndDateTime.equals("")) {
                if (!LZ_CallFlowInputEndDateTime.substring(0, 1).equals(",")) {
                    LZ_CallFlowInputEndDateTime = "," + LZ_CallFlowInputEndDateTime;
                }
            }




            // System.out.println( LZ_CallDetailID + "," +  LZ_CallFlowID  + "," + LZ_CallFlowDateTime + "," + LZ_NoOfAttempts  + "," + LZ_RuleID + "," + LZ_IsSuccess + "," + LZ_CallFlowInputStartDateTime + "," + LZ_CallFlowInputEndDateTime);

            if (LZ_SimulatorMode) {
            } else {

                String[] LZ_tempStartDateTime = null;
                String[] LZ_tempEndDateTime = null;
                String[] LZ_tempInputID = null;
                String[] LZ_tempInputValue = null;


                if (!LZ_CallFlowInputStartDateTime.isEmpty()) {
                    LZ_tempStartDateTime = LZ_CallFlowInputStartDateTime.split(",");
                }
                if (!LZ_CallFlowInputEndDateTime.isEmpty()) {
                    LZ_tempEndDateTime = LZ_CallFlowInputEndDateTime.split(",");
                }
                if (!LZ_MenuCallFlowIDList.isEmpty()) {
                    LZ_tempInputID = LZ_MenuCallFlowIDList.split(",");
                }
                try {
                    if (!LZ_InputValue.isEmpty()) {
                        LZ_tempInputValue = LZ_InputValue.split(",");
                    }
                } catch (Exception ex1) {
                    LZ_InputValue = "";
                    Logger.warn(LZ_CallDetailID, "RetrieveRechargeCallFlowResult Split Error " + ex1.getMessage(), false);
                }
                try {
                    for (int i = 1; i <= 3; i++) {
                        switch (i) {
                            case 1:
                                if (!LZ_CallFlowInputStartDateTime.isEmpty()) {
                                    LZ_CallFlowFirstInputStartDateTime = LZ_tempStartDateTime[i];
                                    LZ_CallFlowFirstInputStartDateTime = LZ_CallFlowFirstInputStartDateTime.replace(",", "");
                                }

                                if (!LZ_CallFlowInputEndDateTime.isEmpty()) {
                                    LZ_CallFlowFirstInputEndDateTime = LZ_tempEndDateTime[i];
                                    LZ_CallFlowFirstInputEndDateTime = LZ_CallFlowFirstInputEndDateTime.replace(",", "");
                                }

                                if (!LZ_InputValue.isEmpty()) {
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
                                        LZ_tempOptionList = null;
                                    }

                                    LZ_FirstInputValue = LZ_tempInputValue[i];


                                } else {
                                    LZ_FirstInputID = LZ_NoInputCFID;
                                    LZ_FirstInputValue = "NoInput";

                                }
                                LZ_FirstInputID = LZ_FirstInputID.replace(",", "");
                                LZ_FirstInputValue = LZ_FirstInputValue.replace(",", "");
                                //      System.out.println("LZ_CallFlowFirstInputStartDateTime" + i + " " + LZ_CallFlowFirstInputStartDateTime );
                                //     System.out.println("LZ_CallFlowFirstInputEndDateTime" + i + " " + LZ_CallFlowFirstInputEndDateTime );
                                //      System.out.println("LZ_FirstInputID" + i + " " + LZ_FirstInputID );
                                //      System.out.println("LZ_FirstInputValue" + i + " " + LZ_FirstInputValue );
                                break;
                            case 2:
                                if (!LZ_CallFlowInputStartDateTime.isEmpty()) {
                                    LZ_CallFlowSecondInputStartDateTime = LZ_tempStartDateTime[i];
                                    LZ_CallFlowSecondInputStartDateTime = LZ_CallFlowSecondInputStartDateTime.replace(",", "");



                                }
                                if (!LZ_CallFlowInputEndDateTime.isEmpty()) {
                                    LZ_CallFlowSecondInputEndDateTime = LZ_tempEndDateTime[i];
                                    LZ_CallFlowSecondInputEndDateTime = LZ_CallFlowSecondInputEndDateTime.replace(",", "");

                                }
                                if (!LZ_InputValue.isEmpty()) {
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
                                        LZ_tempOptionList = null;
                                    }

                                    LZ_SecondInputValue = LZ_tempInputValue[i];

                                } else {
                                    LZ_SecondInputID = LZ_NoInputCFID;
                                    LZ_SecondInputValue = "NoInput";
                                }
                                LZ_SecondInputID = LZ_SecondInputID.replace(",", "");
                                LZ_SecondInputValue = LZ_SecondInputValue.replace(",", "");

                                //   System.out.println("LZ_CallFlowSecondInputStartDateTime" + i + " " + LZ_CallFlowSecondInputStartDateTime );
                                //    System.out.println("LZ_CallFlowSecondInputEndDateTime" + i + " " + LZ_CallFlowSecondInputEndDateTime );
                                //   System.out.println("LZ_SecondInputID" + i + " " + LZ_SecondInputID );
                                //    System.out.println("LZ_SecondInputValue" + i + " " + LZ_SecondInputValue );
                                break;
                            case 3:

                                if (!LZ_CallFlowInputStartDateTime.isEmpty()) {
                                    LZ_CallFlowThirdInputStartDateTime = LZ_tempStartDateTime[i];
                                    LZ_CallFlowThirdInputStartDateTime = LZ_CallFlowThirdInputStartDateTime.replace(",", "");


                                }
                                if (!LZ_CallFlowInputEndDateTime.isEmpty()) {
                                    LZ_CallFlowThirdInputEndDateTime = LZ_tempEndDateTime[i];

                                    LZ_CallFlowThirdInputEndDateTime = LZ_CallFlowThirdInputEndDateTime.replace(",", "");

                                }
                                if (!LZ_InputValue.isEmpty()) {
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
                                        LZ_tempOptionList = null;
                                    }

                                    LZ_ThirdInputValue = LZ_tempInputValue[i];

                                } else {
                                    LZ_ThirdInputID = LZ_NoInputCFID;
                                    LZ_ThirdInputValue = "NoInput";
                                }
                                LZ_ThirdInputID = LZ_ThirdInputID.replace(",", "");
                                LZ_ThirdInputValue = LZ_ThirdInputValue.replace(",", "");
                                //System.out.println("LZ_CallFlowThirdInputEndDateTime" + i + " " + LZ_CallFlowThirdInputEndDateTime );
                                // System.out.println("LZ_CallFlowThirdInputStartDateTime" + i + " " + LZ_CallFlowThirdInputStartDateTime );
                                //   System.out.println("LZ_ThirdInputID" + i + " " + LZ_ThirdInputID );
                                //     System.out.println("LZ_ThirdInputValue" + i + " " + LZ_ThirdInputValue );
                                break;
                        }
                    }
                } catch (Exception ex2) {
                    Logger.warn(LZ_CallDetailID, "RetrieveRechargeCallFlowResult For Loop Error.................... " + ex2.getMessage(), false);
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

                MaskCardNumber maskCardNumber = new MaskCardNumber();
                //Card number
                if ((LZ_CallFlowID.equals("216")) || (LZ_CallFlowID.equals("217")) || (LZ_CallFlowID.equals("281")) || (LZ_CallFlowID.equals("282")) || (LZ_CallFlowID.equals("283")) || (LZ_CallFlowID.equals("284"))) {

                    if (LZ_FirstInputValue.length() == 16) {
                        LZ_FirstInputValue = maskCardNumber.maskCardNumber(LZ_FirstInputValue, "######xxxxxx####");
                    } else if (LZ_FirstInputValue.length() == 15) {
                        LZ_FirstInputValue = maskCardNumber.maskCardNumber(LZ_FirstInputValue, "#####xxxxxx####");
                    } else if (LZ_SecondInputValue.length() == 16) {
                        LZ_SecondInputValue = maskCardNumber.maskCardNumber(LZ_SecondInputValue, "######xxxxxx####");
                    } else if (LZ_SecondInputValue.length() == 15) {
                        LZ_SecondInputValue = maskCardNumber.maskCardNumber(LZ_SecondInputValue, "#####xxxxxx####");
                    } else if (LZ_ThirdInputValue.length() == 16) {
                        LZ_ThirdInputValue = maskCardNumber.maskCardNumber(LZ_ThirdInputValue, "######xxxxxx####");
                    } else if (LZ_ThirdInputValue.length() == 15) {
                        LZ_ThirdInputValue = maskCardNumber.maskCardNumber(LZ_ThirdInputValue, "#####xxxxxx####");
                    }
                } else if (LZ_CallFlowID.equals("244")) {
                    if (LZ_FirstInputValue.length() == 4) {
                        LZ_FirstInputValue = maskCardNumber.maskCardNumber(LZ_FirstInputValue, "xxxx");
                    } else if (LZ_FirstInputValue.length() == 3) {
                        LZ_FirstInputValue = maskCardNumber.maskCardNumber(LZ_FirstInputValue, "xxx");
                    } else if (LZ_SecondInputValue.length() == 4) {
                        LZ_SecondInputValue = maskCardNumber.maskCardNumber(LZ_SecondInputValue, "xxxx");
                    } else if (LZ_SecondInputValue.length() == 3) {
                        LZ_SecondInputValue = maskCardNumber.maskCardNumber(LZ_SecondInputValue, "xxx");
                    } else if (LZ_ThirdInputValue.length() == 4) {
                        LZ_ThirdInputValue = maskCardNumber.maskCardNumber(LZ_ThirdInputValue, "xxxx");
                    } else if (LZ_ThirdInputValue.length() == 3) {
                        LZ_ThirdInputValue = maskCardNumber.maskCardNumber(LZ_ThirdInputValue, "xxx");
                    }

                } else if (LZ_CallFlowID.equals("246")) {
                    if (LZ_FirstInputValue.length() == 3) {
                        LZ_FirstInputValue = maskCardNumber.maskCardNumber(LZ_FirstInputValue, "xxx");
                    } else if (LZ_FirstInputValue.length() == 2) {
                        LZ_FirstInputValue = maskCardNumber.maskCardNumber(LZ_FirstInputValue, "xx");
                    } else if (LZ_SecondInputValue.length() == 3) {
                        LZ_SecondInputValue = maskCardNumber.maskCardNumber(LZ_SecondInputValue, "xxx");
                    } else if (LZ_SecondInputValue.length() == 2) {
                        LZ_SecondInputValue = maskCardNumber.maskCardNumber(LZ_SecondInputValue, "xx");
                    } else if (LZ_ThirdInputValue.length() == 3) {
                        LZ_ThirdInputValue = maskCardNumber.maskCardNumber(LZ_ThirdInputValue, "xxx");
                    } else if (LZ_ThirdInputValue.length() == 2) {
                        LZ_ThirdInputValue = maskCardNumber.maskCardNumber(LZ_ThirdInputValue, "xx");
                    }
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
                sbCFD.append("<FLDRULEDESC>" + LZ_RuleDescription + "</FLDRULEDESC>");
                sbCFD.append("</TBLCALLFLOWDETAIL></ROOT>");


                LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</ROOT>", sbCFD);
                LZ_temp = null;
                LZ_tempStartDateTime = LZ_tempEndDateTime = LZ_tempInputID = LZ_tempInputValue = null;
            }
        } catch (Exception ex) {
            Logger.error(LZ_CallDetailID, " Exception in RetrieveRechargeCallFlowResult Page : " + ex.getMessage(), false);
        } finally {
            Logger.info(LZ_CallDetailID, " RetrieveRechargeCallFlowResult Output ", false);
            LZ_MenuOptionList = LZ_MenuCallFlowIDList = LZ_NoInputCFID = LZ_NoMatchCFID = LZ_CallDetailID = LZ_CallFlowID =
                    LZ_CallFlowDateTime = LZ_CallFlowInputStartDateTime = LZ_CallFlowInputEndDateTime = LZ_InputValue =
                    LZ_NoOfAttempts = LZ_RuleID = LZ_IsSuccess = LZ_CallFlowFirstInputStartDateTime = LZ_CallFlowFirstInputEndDateTime =
                    LZ_FirstInputID = LZ_FirstInputValue = LZ_CallFlowSecondInputStartDateTime = LZ_CallFlowSecondInputEndDateTime =
                    LZ_SecondInputID = LZ_SecondInputValue = LZ_CallFlowThirdInputStartDateTime = LZ_CallFlowThirdInputEndDateTime =
                    LZ_ThirdInputID = LZ_ThirdInputValue = null;
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