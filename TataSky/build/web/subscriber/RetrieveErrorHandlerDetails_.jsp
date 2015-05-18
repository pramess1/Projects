<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean LZ_SimulatorMode = false; // Simulator Mode by default is set to true.
        String LZ_CallFlowDetailXML = ""; // This is used to store the call flow detail XML. 
        String LZ_DBCallDetailID = ""; // This is used to store the call detail ID.

        //String LZ_PromptTechnicalError = "7264.wav"; // This is used to store technical error prompt.
        String LZ_PromptTechnicalError = "7220.wav"; // This is used to store technical error prompt.
        String LZ_TechnicalErrorCFID = "999"; // This is used to store error technical CFID.
        String LZ_PromptPause = "7220.wav";

        String LZ_ActionCode = "D"; // This is used to store the action code (C-Continue, D-Disconnect, T-Transfer).
        boolean LZ_IsActionSet = false; // This is used to store whether action has been set.

        String LZ_NonRMNC_CFIDList = "5,22,23,24,38,40"; // This is used to store the CFIDs which should continue for NonRMN caller.
        String LZ_NonRMND_CFIDList = "20,25,26,27,28,29,30,231,400,700,701,702,703,705,706,800,933,1000"; // This is used to store the CFIDs which should disconnect for NonRMN caller.
        String LZ_NonRMNT_CFIDList = "21,202,203,204,205,207,208,214,215,216,217,218,219,220,221,222,223,224,226,227,228,229,230,236,237,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,411,704,805,950,951,952,953,954,955,956,957,958,959,995,997,999"; // This is used to store the CFIDs which should transfer for NonRMN caller.

        String LZ_RMNC_Y_CFIDList = "1,5,22,23,24,38,40"; // This is used to store the CFIDs which should continue for RMN caller with Premium Flag Y.
        String LZ_RMND_Y_CFIDList = "100,104,106,400,401,402,403,231,700,701,702,703,705,706,800,933,1000,1001,1002,1003,1004,1005,400"; // This is used to store the CFIDs which should disconnect for RMN caller with Premium Flag Y.
        String LZ_RMNT_Y_CFIDList = "20,21,25,26,27,28,29,30,33,35,101,102,103,105,107,202,203,204,205,207,208,214,215,216,217,218,219,220,221,222,223,224,226,227,228,229,230,236,237,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,404,405,411,704,805,906,950,951,952,953,954,955,956,957,958,959,995,997,999,9001,9002,9004,9008,9009,9011,9013,9015,9023,9025,9032,9038,9041,9047,9050,9054,9057,9059,9060,9061,9063,9066,9068,9069,9071,9072,9075,9076,9084,9087,9088,9092,9094,9095,9096,9100,9101,9012"; // This is used to store the CFIDs which should transfer for RMN caller with Premium Flag Y.


        String LZ_RMNC_N_CFIDList = "1,5,22,23,24,38,40"; // This is used to store the CFIDs which should continue for RMN caller with Premium Flag N.
        String LZ_RMND_N_CFIDList = "100,25,26,27,28,104,106,231,400,401,402,403,700,701,702,703,704,705,706,800,1000,1001,1002,1003,1004,1005,9015,9023,9025,9032"; // This is used to store the CFIDs which should disconnect for RMN caller with Premium Flag N.
        String LZ_RMNT_N_CFIDList = "20,21,25,26,27,28,29,30,33,35,101,102,103,105,107,202,203,204,205,207,208,214,215,216,217,218,219,220,221,222,223,224,226,227,228,229,230,236,237,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,404,405,411,805,950,951,952,953,954,955,956,957,958,959,995,997,999,9001,9002,9004,9008,9009,9011,9013,9038,9041,9047,9050,9054,9057,9059,9060,9061,9063,9066,9068,9069,9071,9072,9075,9076,9084,9087,9088,9092,9094,9095,9096,9100,9101,9012"; // This is used to store the CFIDs which should transfer for RMN caller with Premium Flag N.

        String LZ_MultipleSubIDT_CFIDList = "20,"; // This is used to store the CFIDs which should transfer for RMN caller with multiple subscriber IDs.
        String LZ_MultipleSubIDC_CFIDList = "23,24,38,40,901"; // This is used to store the CFIDs which should Continue for RMN caller with multiple subscriber IDs.

        String LZ_NoInputCFID = "900"; // This is used to store the no input call flow ID.
        String LZ_NoMatchCFID = "901"; // This is used to store the no match call flow ID.
        String LZ_tempCFID = "";
        String LZ_DynamicCallFlowXML = ""; // This stores the dynamic call flow XML sent by parent call flow.

        try {
//            LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
//            LZ_DBCallDetailID = state.getString("LZ_DBCallDetailID");
            LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML", "");
            LZ_DBCallDetailID = state.optString("LZ_DBCallDetailID", "");
            if (LZ_SimulatorMode) {
                //Testing
            } else {
                Document docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);
                String LZ_CallerType = XMLAO.getNodeValueText(docBA, "BA_CALLER_TYPE");
                Logger.info(LZ_DBCallDetailID, " RetrieveErrorHandlerDetails Input =  LZ_CallerType : " + LZ_CallerType, false);
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
                if (LZ_CallerType.equals("Prospect")) {
                    LZ_ActionCode = "T";
                    LZ_IsActionSet = true;
                } else if (LZ_CallerType.equals("Partner")) {
                    LZ_ActionCode = "D";
                    LZ_IsActionSet = true;
                } else {
                    //System.out.println("LZ_CallFlowDetailXML-->" + LZ_CallFlowDetailXML);
                    int LZ_tempCount = XMLAO.getNodeCount(docBA, "TBLCALLFLOWDETAIL");
                    //System.out.println("LZ_tempCount-->" + String.valueOf(LZ_tempCount));
                    LZ_tempCount--;
                    int LZ_NoOfAttempts = Integer.parseInt(XMLAO.getNodeValueText(docBA, "FLDNOOFATTEMPTS", LZ_tempCount));
                    //System.out.println("LZ_NoOfAttempts-->" + String.valueOf(LZ_NoOfAttempts));
                    String LZ_IsSuccess = XMLAO.getNodeValueText(docBA, "FLDISSUCCESS", LZ_tempCount);
                    if (LZ_NoOfAttempts >= 0) {
                        LZ_tempCFID = XMLAO.getNodeValueText(docBA, "FLDCALLFLOWID", LZ_tempCount);
                        //System.out.println("LZ_tempCFID-->" + LZ_tempCFID);
                        if (LZ_CallerType.equals("NonRMN")) {
                            if (!LZ_NonRMNC_CFIDList.isEmpty()) {
                                String[] LZ_NonRMNC_CFIDListArray = LZ_NonRMNC_CFIDList.split(",");
                                for (int i = 0; i < LZ_NonRMNC_CFIDListArray.length; i++) {
                                    if (LZ_tempCFID.equals(LZ_NonRMNC_CFIDListArray[i])) {
                                        LZ_ActionCode = "C";
                                        LZ_IsActionSet = true;
                                        break;
                                    }
                                }
                            }
                            if (!LZ_NonRMND_CFIDList.isEmpty() && !LZ_IsActionSet) {
                                String[] LZ_NonRMND_CFIDListArray = LZ_NonRMND_CFIDList.split(",");
                                for (int i = 0; i < LZ_NonRMND_CFIDListArray.length; i++) {
                                    if (LZ_tempCFID.equals(LZ_NonRMND_CFIDListArray[i])) {
                                        LZ_ActionCode = "D";
                                        LZ_IsActionSet = true;
                                        //System.out.println("***********Tamil1**********");
                                        break;
                                    }
                                }
                            }
                            if (!LZ_NonRMNT_CFIDList.isEmpty() && !LZ_IsActionSet) {
                                String[] LZ_NonRMNT_CFIDListArray = LZ_NonRMNT_CFIDList.split(",");
                                for (int i = 0; i < LZ_NonRMNT_CFIDListArray.length; i++) {
                                    if (LZ_tempCFID.equals(LZ_NonRMNT_CFIDListArray[i])) {
                                        LZ_ActionCode = "T";
                                        LZ_IsActionSet = true;
                                        break;
                                    }
                                }
                            }
                            if (!LZ_IsActionSet) {
                                LZ_ActionCode = "D";
                                LZ_IsActionSet = true;
                                //System.out.println("***********Tamil2**********");
                            }
                        } else if (LZ_CallerType.equals("RMN")) {
                            int LZ_SubscriberIDCount = Integer.parseInt(XMLAO.getNodeValueText(docBA, "BA_SUBSCRIBER_ID_COUNT"));

                            if (LZ_SubscriberIDCount > 1) {

                                if (!LZ_MultipleSubIDC_CFIDList.isEmpty()) {
                                    String[] LZ_MultipleSubIDC_CFIDListArray = LZ_MultipleSubIDC_CFIDList.split(",");
                                    for (int i = 0; i < LZ_MultipleSubIDC_CFIDListArray.length; i++) {
                                        if (LZ_tempCFID.equals(LZ_MultipleSubIDC_CFIDListArray[i])) {
                                            LZ_ActionCode = "C";
                                            LZ_IsActionSet = true;
                                            break;
                                        }
                                    }
                                }

                                String[] LZ_MultipleSubIDT_CFIDListArray = LZ_MultipleSubIDT_CFIDList.split(",");
                                for (int i = 0; i < LZ_MultipleSubIDT_CFIDListArray.length; i++) {
                                    if (LZ_tempCFID.equals(LZ_MultipleSubIDT_CFIDListArray[i])) {
                                        LZ_ActionCode = "T";
                                        LZ_IsActionSet = true;
                                        break;
                                    }


                                }
                            }
                            if (!LZ_IsActionSet) {
                                String LZ_PremiumFlag = XMLAO.getNodeValueText(docBA, "BA_PREMIUM_FLAG");

                                if (LZ_PremiumFlag.equals("Y")) {
                                    if (!LZ_RMNC_Y_CFIDList.isEmpty()) {
                                        String[] LZ_RMNC_Y_CFIDListArray = LZ_RMNC_Y_CFIDList.split(",");
                                        for (int i = 0; i < LZ_RMNC_Y_CFIDListArray.length; i++) {
                                            if (LZ_tempCFID.equals(LZ_RMNC_Y_CFIDListArray[i])) {
                                                LZ_ActionCode = "C";
                                                LZ_IsActionSet = true;
                                                break;
                                            }
                                        }
                                    }
                                    if (!LZ_RMND_Y_CFIDList.isEmpty() && !LZ_IsActionSet) {
                                        String[] LZ_RMND_Y_CFIDListArray = LZ_RMND_Y_CFIDList.split(",");
                                        for (int i = 0; i < LZ_RMND_Y_CFIDListArray.length; i++) {
                                            if (LZ_tempCFID.equals(LZ_RMND_Y_CFIDListArray[i])) {
                                                LZ_ActionCode = "D";
                                                LZ_IsActionSet = true;
                                                //System.out.println("***********Tamil3**********");
                                                break;
                                            }
                                        }
                                    }
                                    if (!LZ_RMNT_Y_CFIDList.isEmpty() && !LZ_IsActionSet) {
                                        String[] LZ_RMNT_Y_CFIDListArray = LZ_RMNT_Y_CFIDList.split(",");
                                        for (int i = 0; i < LZ_RMNT_Y_CFIDListArray.length; i++) {
                                            if (LZ_tempCFID.equals(LZ_RMNT_Y_CFIDListArray[i])) {
                                                LZ_ActionCode = "T";
                                                LZ_IsActionSet = true;
                                                //System.out.println("***********RMT3**********");
                                                break;
                                            }
                                        }
                                    }
                                    if (!LZ_IsActionSet) {
                                        LZ_ActionCode = "T";
                                        LZ_IsActionSet = true;
                                    }
                                } else {
                                    if (!LZ_RMNC_N_CFIDList.isEmpty()) {
                                        String[] LZ_RMNC_N_CFIDListArray = LZ_RMNC_N_CFIDList.split(",");

                                        for (int i = 0; i < LZ_RMNC_N_CFIDListArray.length; i++) {
                                            if (LZ_tempCFID.equals(LZ_RMNC_N_CFIDListArray[i])) {
                                                LZ_ActionCode = "C";
                                                LZ_IsActionSet = true;
                                                break;
                                            }
                                        }
                                    }
                                    if (!LZ_RMND_N_CFIDList.isEmpty() && !LZ_IsActionSet) {
                                        String[] LZ_RMND_N_CFIDListArray = LZ_RMND_N_CFIDList.split(",");
                                        for (int i = 0; i < LZ_RMND_N_CFIDListArray.length; i++) {
                                            if (LZ_tempCFID.equals(LZ_RMND_N_CFIDListArray[i])) {
                                                LZ_ActionCode = "D";
                                                LZ_IsActionSet = true;
                                                //System.out.println("***********Tamil4**********");
                                                break;
                                            }
                                        }
                                    }
                                    if (!LZ_RMNT_N_CFIDList.isEmpty() && !LZ_IsActionSet) {
                                        String[] LZ_RMNT_N_CFIDListArray = LZ_RMNT_N_CFIDList.split(",");
                                        for (int i = 0; i < LZ_RMNT_N_CFIDListArray.length; i++) {
                                            if (LZ_tempCFID.equals(LZ_RMNT_N_CFIDListArray[i])) {
                                                LZ_ActionCode = "T";
                                                LZ_IsActionSet = true;
                                                //System.out.println("***********RMT4**********");
                                                break;
                                            }
                                        }
                                    }
                                    if (!LZ_IsActionSet) {
                                        LZ_ActionCode = "T";
                                        LZ_IsActionSet = true;
                                    }
                                }
                            }
                        }
                    } else {// Write defaults for all caller types
                        LZ_ActionCode = "D";
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
            LZ_ActionCode = "D";
            LZ_IsActionSet = true;
            Logger.error(LZ_DBCallDetailID, "Exception in RetrieveErrorHandlerDetails Page : " + ex.getMessage(), false);
        } finally {
            Logger.info(LZ_DBCallDetailID, " RetrieveErrorHandlerDetails Output =  LZ_ActionCode : " + LZ_ActionCode, false);
            LZ_CallFlowDetailXML = LZ_DBCallDetailID = LZ_PromptTechnicalError = LZ_TechnicalErrorCFID = LZ_PromptPause = LZ_NonRMNC_CFIDList = LZ_NonRMND_CFIDList = LZ_NonRMNT_CFIDList = LZ_RMNC_Y_CFIDList = LZ_RMND_Y_CFIDList = LZ_RMNT_Y_CFIDList = LZ_RMNC_N_CFIDList = LZ_RMND_N_CFIDList = LZ_RMNT_N_CFIDList = LZ_MultipleSubIDT_CFIDList = LZ_NoInputCFID = LZ_NoMatchCFID = null;

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