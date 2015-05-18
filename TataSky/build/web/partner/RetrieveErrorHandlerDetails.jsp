<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean LZ_SimulatorMode = false; // Simulator Mode by default is set to true.
        String LZ_CallFlowDetailXML = ""; // This is used to store the call flow detail XML.
        String LZ_DBCallDetailID = ""; // This is used to store the call detail ID.

        //String LZ_PromptTechnicalError = "7264.wav"; // This is used to store technical error prompt.
        String LZ_PromptTechnicalError = ""; // This is used to store technical error prompt.
        String LZ_TechnicalErrorCFID = "999"; // This is used to store error technical CFID.
        String LZ_PromptPause = "7220.wav";

        String LZ_ActionCode = "T"; // This is used to store the action code (C-Continue, D-Disconnect, T-Transfer).
        boolean LZ_IsActionSet = false; // This is used to store whether action has been set.

        String LZ_NonPartnerC_CFIDList = ""; // This is used to store the CFIDs which should continue for Non Partner caller.
        String LZ_NonPartnerD_CFIDList = ""; // This is used to store the CFIDs which should disconnect for Non Partner caller.
        String LZ_NonPartnerT_CFIDList = ""; // This is used to store the CFIDs which should transfer for Non Partner caller.
        String LZ_NonPartnerM_CFIDList = ""; // This is used to store the CFIDs which should goto main menu for Non Partner caller.

        String LZ_PartnerC_CFIDList = "5,22,11004,11018"; // This is used to store the CFIDs which should continue for Partner caller.
        String LZ_PartnerD_CFIDList = "1004,1005,11020,11033,11055,11056,11042,15001"; // This is used to store the CFIDs which should disconnect for Partner caller.
        String LZ_PartnerT_CFIDList = "98,9001,9002,9004,9008,9009,9011,9013,9038,9041,9047,9050,9054,9057,9059,9060,9061,9063,9066,9068,9069,9071,9072,9075,9076,9084,9087,9088,9092,9094,9095,9096,9100,9101,9012,10015,10016,11021,11036,11073,11074"; // This is used to store the CFIDs which should transfer for Partner caller.
        String LZ_PartnerM_CFIDList = "20,26,29,23,202,400,805,999,9015,9023,9025,9032,11022,11026,11032,11038,11042,11043,11044,11045,11046,11047,11049,11048,11056,11057,11058,11091"; // This is used to store the CFIDs which should goto main menu for Partner caller.


        //11049-sales partner mainmenu
        //15001-unable to view menu
        //400-reauthorise menu




        String LZ_MultipleSubIDT_CFIDList = "20"; // This is used to store the CFIDs which should transfer for RMN caller with multiple subscriber IDs.

        String LZ_NoInputCFID = "900"; // This is used to store the no input call flow ID.
        String LZ_NoMatchCFID = "901"; // This is used to store the no match call flow ID.

        String LZ_DynamicCallFlowXML = ""; // This stores the dynamic call flow XML sent by parent call flow.
        int LZ_NoOfAttempts = 0;
        String LZ_tempCFID = "";
        String LZ_IsSuccess = "";

        try {
//            LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
//            LZ_DBCallDetailID = state.getString("LZ_DBCallDetailID");
              LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");
              LZ_DBCallDetailID = state.optString("LZ_DBCallDetailID","");            

            if (LZ_SimulatorMode) {
            } else {
                Document docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);
                String LZ_CallerType = XMLAO.getNodeValueText(docBA, "BA_CALLER_TYPE");
                int LZ_CallFlowCount = XMLAO.getNodeCount(docBA, "TBLCALLFLOWDETAIL");

                String LZ_LastCallFlowID = "";

                String LZ_CurrentCallFlowID = XMLAO.getNodeValueText(docBA, "FLDCALLFLOWID", LZ_CallFlowCount - 1);
                String LZ_FirstInputID = XMLAO.getNodeValueText(docBA, "FLDFIRSTINPUTID", LZ_CallFlowCount - 1);
                String LZ_SecondInputID = XMLAO.getNodeValueText(docBA, "FLDSECONDINPUTID", LZ_CallFlowCount - 1);
                String LZ_ThirdInputID = XMLAO.getNodeValueText(docBA, "FLDTHIRDINPUTID", LZ_CallFlowCount - 1);

                StringBuilder sbDCF = new StringBuilder("");


                if (!LZ_ThirdInputID.equals("")) {
                    LZ_LastCallFlowID = LZ_ThirdInputID;
                } else if (!LZ_SecondInputID.equals("")) {
                    LZ_LastCallFlowID = LZ_SecondInputID;
                } else if (!LZ_FirstInputID.equals("")) {
                    LZ_LastCallFlowID = LZ_FirstInputID;
                }

                //StringBuilder sbDCF = new StringBuilder("<CallFlow CDID=\"" + LZ_DBCallDetailID + "\" RuleID=\"\"><Prompt CFID=\" + LZ_LastCallFlowID + "\">" + LZ_PromptPause + "</Prompt>");

                if (LZ_LastCallFlowID.equals("")) {
                    sbDCF.append("<CallFlow CDID=\"" + LZ_DBCallDetailID + "\" RuleID=\"\"><Prompt CFID=\"");
                } else {
                    sbDCF.append("<CallFlow CDID=\"" + LZ_DBCallDetailID + "\" RuleID=\"\"><Prompt CFID=\"" + LZ_LastCallFlowID + "\">" + LZ_PromptPause + "</Prompt><Prompt CFID=\"");
                }

                String LZ_tempErrorPrompt = XMLAO.getNodeValueText(docBA, "ERRORPROMPT");
                String LZ_tempErrorCFID = XMLAO.getNodeValueText(docBA, "ERRORCFID");

                if (LZ_tempErrorPrompt.isEmpty()) {
                    sbDCF.append(LZ_TechnicalErrorCFID + "\">" + LZ_PromptTechnicalError + "</Prompt></CallFlow>");
                } else {
                    if (LZ_tempErrorPrompt.equals(LZ_PromptTechnicalError)) {
                        sbDCF.append(LZ_TechnicalErrorCFID + "\">" + LZ_PromptTechnicalError + "</Prompt></CallFlow>");
                    } else {
                        sbDCF.append(LZ_tempErrorCFID + "\">" + LZ_tempErrorPrompt + "</Prompt>");
                        sbDCF.append("<Prompt CFID=\"" + LZ_TechnicalErrorCFID + "\">" + LZ_PromptTechnicalError + "</Prompt></CallFlow>");
                    }
                }

                System.out.println("sbDCF=" + sbDCF.toString());
                System.out.println("LZ_CallFlowDetailXML-->" + LZ_CallFlowDetailXML);
                int LZ_tempCount = XMLAO.getNodeCount(docBA, "TBLCALLFLOWDETAIL");
                System.out.println("LZ_tempCount-->" + String.valueOf(LZ_tempCount));
                LZ_tempCount--;


                if (LZ_tempCount > 0) {
                    LZ_NoOfAttempts = Integer.parseInt(XMLAO.getNodeValueText(docBA, "FLDNOOFATTEMPTS", LZ_tempCount));
                    System.out.println("LZ_NoOfAttempts-->" + String.valueOf(LZ_NoOfAttempts));
                    LZ_IsSuccess = XMLAO.getNodeValueText(docBA, "FLDISSUCCESS", LZ_tempCount);
                    LZ_tempCFID = XMLAO.getNodeValueText(docBA, "FLDCALLFLOWID", LZ_tempCount);
                    System.out.println("LZ_tempCFID-->" + LZ_tempCFID);
                }




                if (LZ_CallerType.equals("Partner")) {

                    if (LZ_NoOfAttempts > 0) {
                        if (!LZ_PartnerC_CFIDList.isEmpty()) {
                            String[] LZ_PartnerC_CFIDListArray = LZ_PartnerC_CFIDList.split(",");

                            for (int i = 0; i < LZ_PartnerC_CFIDListArray.length; i++) {
                                if (LZ_tempCFID.equals(LZ_PartnerC_CFIDListArray[i])) {
                                    LZ_ActionCode = "C";
                                    LZ_IsActionSet = true;
                                    break;
                                }
                            }
                        }

                        if (!LZ_PartnerD_CFIDList.isEmpty()) {
                            String[] LZ_PartnerD_CFIDListArray = LZ_PartnerD_CFIDList.split(",");

                            for (int i = 0; i < LZ_PartnerD_CFIDListArray.length; i++) {
                                if (LZ_tempCFID.equals(LZ_PartnerD_CFIDListArray[i])) {
                                    LZ_ActionCode = "D";
                                    LZ_IsActionSet = true;
                                    break;
                                }
                            }
                        }

                        if (!LZ_PartnerT_CFIDList.isEmpty()) {
                            String[] LZ_PartnerT_CFIDListArray = LZ_PartnerT_CFIDList.split(",");

                            for (int i = 0; i < LZ_PartnerT_CFIDListArray.length; i++) {
                                if (LZ_tempCFID.equals(LZ_PartnerT_CFIDListArray[i])) {
                                    LZ_ActionCode = "T";
                                    LZ_IsActionSet = true;
                                    break;
                                }
                            }
                        }

                        if (!LZ_PartnerM_CFIDList.isEmpty()) {
                            String[] LZ_PartnerM_CFIDListArray = LZ_PartnerM_CFIDList.split(",");

                            for (int i = 0; i < LZ_PartnerM_CFIDListArray.length; i++) {
                                if (LZ_tempCFID.equals(LZ_PartnerM_CFIDListArray[i])) {
                                    LZ_ActionCode = "M";
                                    LZ_IsActionSet = true;
                                    break;
                                }
                            }
                        }

                        if (!LZ_IsActionSet) // This is for Partner default.
                        {
                            LZ_ActionCode = "T";
                            LZ_IsActionSet = true;
                        }
                    } else if (LZ_tempCFID.equals("11055") || LZ_tempCFID.equals("11056") || LZ_tempCFID.equals("11029") || LZ_tempCFID.equals("11048")) {
                        LZ_ActionCode = "M";
                        LZ_IsActionSet = true;

                    } else // Write defaults for all attempts
                    {
                        System.out.println("Else Part");
                        LZ_ActionCode = "D";
                        LZ_IsActionSet = true;
                    }
                } else {
                    if (LZ_NoOfAttempts == 3) {
                        if (!LZ_NonPartnerC_CFIDList.isEmpty()) {
                            String[] LZ_NonPartnerC_CFIDListArray = LZ_NonPartnerC_CFIDList.split(",");

                            for (int i = 0; i < LZ_NonPartnerC_CFIDListArray.length; i++) {
                                if (LZ_tempCFID.equals(LZ_NonPartnerC_CFIDListArray[i])) {
                                    LZ_ActionCode = "C";
                                    LZ_IsActionSet = true;
                                    break;
                                }
                            }
                        }

                        if (!LZ_NonPartnerD_CFIDList.isEmpty()) {
                            String[] LZ_NonPartnerD_CFIDListArray = LZ_NonPartnerD_CFIDList.split(",");

                            for (int i = 0; i < LZ_NonPartnerD_CFIDListArray.length; i++) {
                                if (LZ_tempCFID.equals(LZ_NonPartnerD_CFIDListArray[i])) {
                                    LZ_ActionCode = "D";
                                    LZ_IsActionSet = true;
                                    break;
                                }
                            }
                        }

                        if (!LZ_NonPartnerT_CFIDList.isEmpty()) {
                            String[] LZ_NonPartnerT_CFIDListArray = LZ_NonPartnerT_CFIDList.split(",");

                            for (int i = 0; i < LZ_NonPartnerT_CFIDListArray.length; i++) {
                                if (LZ_tempCFID.equals(LZ_NonPartnerT_CFIDListArray[i])) {
                                    LZ_ActionCode = "T";
                                    LZ_IsActionSet = true;
                                    break;
                                }
                            }
                        }

                        if (!LZ_NonPartnerM_CFIDList.isEmpty()) {
                            String[] LZ_NonPartnerM_CFIDListArray = LZ_NonPartnerM_CFIDList.split(",");

                            for (int i = 0; i < LZ_NonPartnerM_CFIDListArray.length; i++) {
                                if (LZ_tempCFID.equals(LZ_NonPartnerM_CFIDListArray[i])) {
                                    LZ_ActionCode = "M";
                                    LZ_IsActionSet = true;
                                    break;
                                }
                            }
                        }

                        if (!LZ_IsActionSet) // This is for Partner default.
                        {
                            LZ_ActionCode = "D";
                            LZ_IsActionSet = true;
                        }
                    } else // Write defaults for all attempts
                    {
                        LZ_ActionCode = "T";
                        LZ_IsActionSet = true;
                    }
                }

                if (LZ_ActionCode.equals("C")) {
                    LZ_DynamicCallFlowXML = "";
                } else {
                    LZ_DynamicCallFlowXML = sbDCF.toString();
                }
            }
        } catch (Exception ex) {
            LZ_ActionCode = "T";
            LZ_IsActionSet = true;
            Logger.error(LZ_DBCallDetailID, " Exception in RetrieveErrorHandlerDetails Page : " + ex.getMessage(), false);
        }finally{
        
         LZ_CallFlowDetailXML = LZ_DBCallDetailID = LZ_PromptTechnicalError = LZ_TechnicalErrorCFID = LZ_PromptPause = LZ_NonPartnerC_CFIDList =LZ_NonPartnerD_CFIDList =LZ_NonPartnerT_CFIDList = LZ_NonPartnerM_CFIDList = LZ_PartnerC_CFIDList = LZ_PartnerD_CFIDList = LZ_PartnerT_CFIDList =LZ_PartnerM_CFIDList =null;
        }

        JSONObject result = new JSONObject();
        result.put("ActionCode", LZ_ActionCode);
        result.put("DynamicCallFlowXML", LZ_DynamicCallFlowXML);

        return result;

    }

    ;
%>
<%-- GENERATED: DO NOT REMOVE --%> 
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONException"%>
<%@page import="java.util.Map"%>

<%@page import="org.w3c.dom.Document"%>
<%@page import="Common.ActionObjects.*"%>

<%@include file="../backend.jspf" %>