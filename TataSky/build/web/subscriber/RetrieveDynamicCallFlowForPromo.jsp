<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean LZ_SimulatorMode = false; // Simulator Mode by default is set to true.
        String LZ_CallFlowDetailXML = ""; // This is used to store the call flow detail XML.
        String LZ_DynamicCallFlowXML = ""; // This stores the dynamic call flow XML sent by parent call flow.
        String LZ_PromptList = ""; // This stores the prompts separated by comma. 
        String LZ_MenuList = ""; // This stores the menus separated by comma. 
        String LZ_MenuOptionList = ""; // This stores the menu options separated by comma. 
        String LZ_MenuOptionPromptList = ""; // This is used to store the menu option prompts.
        String LZ_MenuCallFlowIDList = ""; // This is used to store the menu call flow IDs.

        String LZ_PromptPress0 = "7000.wav"; // This is used to store the press 0 prompt file name.
        String LZ_PromptPress9 = "7009.wav"; // This is used to store the press 9 prompt file name.
        String LZ_PromptPressStar = "7010.wav"; // This is used to store the press * prompt file name.
        String LZ_PromptPressHash = "7011.wav"; // This is used to store the press # prompt file name.
        String LZ_PromptBlank1 = "7220.wav"; // This is used to store the 0.01 sec blank prompt file name.
        String LZ_PromptBlank2 = "7221.wav"; // This is used to store the 0.05 sec blank prompt file name.
        String LZ_PromptBlank3 = "7222.wav"; // This is used to store the 0.25 sec blank prompt file name.
        String LZ_PromptMainMenu = "7223.wav"; // This is used to store the main menu prompt file name.
        String LZ_PromptPreviousMenu = "7013.wav"; // This is used to store the previous menu prompt file name.
        String LZ_PromptAgentTransfer = "7018.wav"; // This is used to store the agent transfer prompt file name.
        String LZ_PromptRepeat = "7012.wav"; // This is used to store the repeat prompt file name.
        String LZ_PromptOtherServices = "7224.wav"; // This is used to store the agent transfer (special) prompt file name.
        String LZ_PromptRepeatMessage = "7030.wav"; // This is used to store the repeat message prompt file name.

        String LZ_MainMenuCFID = "904"; // This is used to store the main menu call flow ID.
        String LZ_PreviousMenuCFID = "905"; // This is used to store the previous menu call flow ID.
        String LZ_AgentTransferCFID = "906"; // This is used to store the agent transfer call flow ID.
        String LZ_RepeatMenuCFID = "907"; // This is used to store the repeat menu call flow ID.
        String LZ_OtherServicesCFID = "908"; // This is used to store the other services call flow ID.
        String LZ_RepeatMessageCFID = "910"; // This is used to store the repeat message call flow ID.

        String LZ_MainMenuOption = "0"; // This is used to store the main menu option.
        String LZ_PreviousMenuOption = "*"; // This is used to store the previous menu option.
        String LZ_AgentTransferOption = "9"; // This is used to store the agent transfer option.
        String LZ_RepeatMenuOption = "#"; // This is used to store the repeat menu option.
        String LZ_OtherServicesOption = "9"; // This is used to store the other services option.
        String LZ_RepeatMessageOption = "#"; // This is used to store the repeat message option.

        String LZ_CallDetailID = ""; // This is used to store the call detail ID.
        String LZ_CallFlowID = ""; // This is used to store the call flow ID.
        String LZ_CallFlowDateTime = ""; // This is used to store the call flow date time.
        String LZ_RuleID = ""; // This is used to store the rule ID.
        String LZ_AppLanguage = ""; // This is used to store the language folder.
        String LZ_RuleDescription = "";

        try {
            if (LZ_SimulatorMode) {
            } else {
//        	LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
                LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML", "");
                //LZ_DynamicCallFlowXML = "<CallFlow CDID=\"10\" RuleID=\"2\"><Menu CFID=\"5\">1023.wav</Menu><Menu CFID=\"6\">1010.wav</Menu><Menu CFID=\"7\">1011.wav</Menu><Menu CFID=\"8\">1012.wav</Menu><Menu CFID=\"904\">7223.wav</Menu><Menu CFID=\"905\">7013.wav</Menu></CallFlow>";
                //LZ_DynamicCallFlowXML = "<CallFlow CDID=\"10\" RuleID=\"2\"><Prompt CFID=\"5\">1023.wav</Prompt><Prompt CFID=\"\">154367</Prompt><Prompt CFID=\"5\">1010.wav</Prompt><Menu CFID=\"904\">7223.wav</Menu><Menu CFID=\"907\">7012.wav</Menu></CallFlow>";
//            LZ_DynamicCallFlowXML = state.getString("LZ_DynamicCallFlowXML");
                LZ_DynamicCallFlowXML = state.optString("LZ_DynamicCallFlowXML", "");
                //LZ_DynamicCallFlowXML = "<CallFlow CDID=\"70\" RuleID=\"\"><Menu CFID=\"700\">7220.wav</Menu><Menu CFID=\"701\">3300.wav</Menu><Menu CFID=\"702\">3301.wav</Menu></CallFlow>";
                Document docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);
                Document doc = XMLAO.buildXMLDocument(LZ_DynamicCallFlowXML);

                LZ_CallDetailID = XMLAO.getNodeAttributeText(doc, "CallFlow", "CDID");

                if (!LZ_CallDetailID.isEmpty()) {
                    DateFormat LZ_DateTimeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
                    Date LZ_CurrentDateTime = new Date();
                    LZ_CallFlowDateTime = LZ_DateTimeFormat.format(LZ_CurrentDateTime).toString();

                    LZ_RuleID = XMLAO.getNodeAttributeText(doc, "CallFlow", "RuleID");

                    LZ_RuleDescription = XMLAO.getNodeAttributeText(doc, "CallFlow", "RuleDesc");

                    Logger.info(LZ_CallDetailID, " RetrieveDynamicCallFlowForPromo Input = LZ_RuleID : " + LZ_RuleID + " LZ_RuleDescription : " + LZ_RuleDescription, false);

                    int LZ_IsPrompt = 0;

                    if (XMLAO.hasNode(doc, "Prompt")) {
                        LZ_IsPrompt = 1;

                        for (int i = 0; i < XMLAO.getNodeCount(doc, "Prompt"); i++) {
                            if (i == 0) {
                                LZ_CallFlowID = XMLAO.getNodeAttributeText(doc, "Prompt", "CFID", i);
                                LZ_PromptList = XMLAO.getNodeValueText(doc, "Prompt", i);
                            } else {
                                if (XMLAO.getNodeAttributeText(doc, "Prompt", "CFID", i).isEmpty()) {
                                    String LZ_tempPromptValue = XMLAO.getNodeValueText(doc, "Prompt", i);

                                    if (ValidationAO.isCardinal(LZ_tempPromptValue)) {
                                        LZ_PromptList = LZ_PromptList + ",CARD=" + LZ_tempPromptValue;
                                    } else if (ValidationAO.isCurrency(LZ_tempPromptValue)) {
                                        LZ_PromptList = LZ_PromptList + ",CURR=INR" + ConversionAO.getCurrency(LZ_tempPromptValue);
                                    } else if (ValidationAO.isDate(LZ_tempPromptValue)) {
                                        LZ_PromptList = LZ_PromptList + ",DATE=" + ConversionAO.getDate(LZ_tempPromptValue);
                                    } else if (ValidationAO.isTime(LZ_tempPromptValue)) {
                                        LZ_PromptList = LZ_PromptList + ",TIME=" + ConversionAO.getTime(LZ_tempPromptValue);
                                    }
                                } else {
                                    LZ_PromptList = LZ_PromptList + "," + XMLAO.getNodeValueText(doc, "Prompt", i);
                                }
                            }
                        }
                    }

                    LZ_AppLanguage = XMLAO.getNodeValueText(docBA, "BA_APP_LANGUAGE");

                    if (LZ_AppLanguage.equals("gu-IN") || LZ_AppLanguage.equals("mr-IN") || LZ_AppLanguage.equals("pn-IN")) {
                        LZ_AppLanguage = "hi-IN";
                    } else {
                        LZ_AppLanguage = "en-IN";
                    }

                    if (XMLAO.hasNode(doc, "Menu")) {
                        if (XMLAO.hasNode(doc, "Prompt")) {
                            LZ_MenuList = LZ_PromptBlank1;
                            LZ_MenuOptionPromptList = LZ_PromptBlank1;
                        }

                        for (int i = 0; i < XMLAO.getNodeCount(doc, "Menu"); i++) {
                            if (i == 0 && !XMLAO.hasNode(doc, "Prompt")) {
                                LZ_CallFlowID = XMLAO.getNodeAttributeText(doc, "Menu", "CFID", i);
                                LZ_MenuList = XMLAO.getNodeValueText(doc, "Menu", i);
                                LZ_MenuOptionPromptList = LZ_PromptBlank1;
                            } else {
                                LZ_MenuCallFlowIDList = LZ_MenuCallFlowIDList + "," + XMLAO.getNodeAttributeText(doc, "Menu", "CFID", i);
                                String LZ_tempMenu = XMLAO.getNodeAttributeText(doc, "Menu", "CFID", i);
                                LZ_MenuList = LZ_MenuList + "," + XMLAO.getNodeValueText(doc, "Menu", i);

                                if (LZ_tempMenu.equals(LZ_MainMenuCFID)
                                        || LZ_tempMenu.equals(LZ_PreviousMenuCFID)
                                        || LZ_tempMenu.equals(LZ_AgentTransferCFID)
                                        || LZ_tempMenu.equals(LZ_RepeatMenuCFID)
                                        || LZ_tempMenu.equals(LZ_OtherServicesCFID)
                                        || LZ_tempMenu.equals(LZ_RepeatMessageCFID)) {
                                    int LZ_tempMenuID = Integer.parseInt(LZ_tempMenu);

                                    switch (LZ_tempMenuID) {
                                        case 904:
                                            LZ_MenuOptionList = LZ_MenuOptionList + "," + LZ_MainMenuOption;
                                            LZ_MenuOptionPromptList = LZ_MenuOptionPromptList + "," + LZ_PromptPress0;
                                            break;
                                        case 905:
                                            LZ_MenuOptionList = LZ_MenuOptionList + "," + LZ_PreviousMenuOption;
                                            LZ_MenuOptionPromptList = LZ_MenuOptionPromptList + "," + LZ_PromptPressStar;
                                            break;
                                        case 906:
                                            LZ_MenuOptionList = LZ_MenuOptionList + "," + LZ_AgentTransferOption;
                                            LZ_MenuOptionPromptList = LZ_MenuOptionPromptList + "," + LZ_PromptPress9;
                                            break;
                                        case 907:
                                            LZ_MenuOptionList = LZ_MenuOptionList + "," + LZ_RepeatMenuOption;
                                            LZ_MenuOptionPromptList = LZ_MenuOptionPromptList + "," + LZ_PromptPressHash;
                                            break;
                                        case 908:
                                            LZ_MenuOptionList = LZ_MenuOptionList + "," + LZ_OtherServicesOption;
                                            LZ_MenuOptionPromptList = LZ_MenuOptionPromptList + "," + LZ_PromptPress9;
                                            break;
                                        case 910:
                                            LZ_MenuOptionList = LZ_MenuOptionList + "," + LZ_RepeatMessageOption;
                                            LZ_MenuOptionPromptList = LZ_MenuOptionPromptList + "," + LZ_PromptPressHash;
                                            break;
                                    }
                                } else {
                                    LZ_MenuOptionList = LZ_MenuOptionList + "," + String.valueOf(i + LZ_IsPrompt);
                                    LZ_MenuOptionPromptList = LZ_MenuOptionPromptList + "," + String.valueOf(7000 + i + LZ_IsPrompt) + ".wav";
                                }
                            }
                        }
                    }
                }
            }
        } catch (Exception ex) {
            Logger.error(LZ_CallDetailID, " Exception in RetrieveDynamicCallFlowForPromo Page : " + ex.getMessage(), false);
        } finally {
            Logger.info(LZ_CallDetailID, " RetrieveDynamicCallFlowForPromo Output = LZ_PromptList : " + LZ_PromptList + " LZ_MenuList : " + LZ_MenuList + " LZ_MenuOptionList : " + LZ_MenuOptionList
                    + " LZ_MenuOptionPromptList : " + LZ_MenuOptionPromptList + " LZ_MenuCallFlowIDList : " + LZ_MenuCallFlowIDList + " LZ_CallFlowID : " + LZ_CallFlowID + " LZ_CallFlowDateTime : " + LZ_CallFlowDateTime + " LZ_RuleID : " + LZ_RuleID + " LZ_AppLanguage : " + LZ_AppLanguage + " LZ_RuleDescription : " + LZ_RuleDescription, false);
            LZ_CallFlowDetailXML = LZ_DynamicCallFlowXML = LZ_PromptPress0 = LZ_PromptPress9 = LZ_PromptPressStar = LZ_PromptPressHash = LZ_PromptBlank1 = LZ_PromptBlank2 = LZ_PromptBlank3 = LZ_PromptMainMenu = LZ_PromptPreviousMenu = LZ_PromptAgentTransfer = LZ_PromptRepeat = LZ_PromptOtherServices = LZ_PromptRepeatMessage = LZ_MainMenuCFID = LZ_PreviousMenuCFID = LZ_AgentTransferCFID = LZ_RepeatMenuCFID = LZ_OtherServicesCFID = LZ_RepeatMessageCFID = LZ_MainMenuOption = LZ_PreviousMenuOption = LZ_AgentTransferOption = LZ_RepeatMenuOption = LZ_OtherServicesOption = LZ_RepeatMessageOption = null;
        }

        JSONObject result = new JSONObject();
        result.put("PromptList", LZ_PromptList);
        result.put("MenuList", LZ_MenuList);
        result.put("MenuOptionList", LZ_MenuOptionList);
        result.put("MenuOptionPromptList", LZ_MenuOptionPromptList);
        result.put("MenuCallFlowIDList", LZ_MenuCallFlowIDList);

        result.put("CallDetailID", LZ_CallDetailID);
        result.put("CallFlowID", LZ_CallFlowID);
        result.put("CallFlowDateTime", LZ_CallFlowDateTime);
        result.put("RuleID", LZ_RuleID);
        result.put("AppLanguage", LZ_AppLanguage);
        result.put("RuleDesc", LZ_RuleDescription);

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