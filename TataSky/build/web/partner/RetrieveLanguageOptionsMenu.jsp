<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean LZ_SimulatorMode = false; // Simulator Mode by default is set to true.
      //  String LZ_LanguageOptionsList = "1,2,8;1,2,7,8,5,11,6,9,12;1,2,3,4;1,2,3,4;1,2,10;1,2,10;1,2,12,6;1,2,12,6;1,2,7,8,5,11,6,9,12;1,2,9;1,2,6;1,2,12,6;1,2,7,8,5,11,6,9,12;1,2,7,8,5,11,6,9,12;1,2,12,6;1,2,12,6;1,2,12,6;1,2,12,6;1,2,12,6;1,2,7,8,5,11,6,9,12;1,2,12,6;1,2,7;1,2,11;1,2,5;1,2,7,8,5,11,6,9,12;1,2,7,8,5,11,6,9,12;1,2,3,4;1,2,3,4;1,2,3,4;1,2,3,4;1,2,3,4;1,2,8,6,5,9;1,2,7,11,12,10,4,3;1,2,8,6,5,9;1,2,7,11,12,10,4,3;"; // This is used to store the language options for all DNIS.
        //String LZ_DNISList = "4027683000;4066006633;2027020200;2066006633;1722236139;1726600663;4027683006;4066006631;4027683007;4027683005;4027683004;4027683010;4027683011;4027683008;4027683009;4027683012;4027683013;4027683014;4027683015;4027683016;4027683017;4027683001;4027683003;4027683002;4027683018;4027683019;2027020400;2027020500;2027020600;2027020700;2027020300;66697501;3333;1111;66697503"; // This is used to store the DNIS List.
      
        String LZ_LanguageOptionsList = "4,2,1;7,1,2;11,1,2;3,2,1;3,2,1;5,1,2"; // This is used to store the language options for all DNIS.
        String LZ_DNISList = "49432202;49432203;49432204;49432205;49432206;49432207"; // This is used to store the DNIS List.
      
        String LZ_CurrentDNIS = ""; // This is used to store the current DNIS.
        String LZ_DBCallDetailID = ""; // This is used to store the call detail ID.
        String LZ_StateToLanguageOptionsList = "1,2,5;1,2,7"; // This is used to store the state to language options. 
        String LZ_StateList = "Tamilnadu;Karnataka"; // This is used to store the states.

        String LZ_MenuList = "1023.wav"; // This stores the menus separated by comma. 
        String LZ_MenuOptionList = ""; // This stores the menu options separated by comma. 
        String LZ_MenuOptionPromptList = "7220.wav"; // This is used to store the menu option prompts.
        String LZ_MenuCallFlowIDList = ""; // This is used to store the menu call flow IDs.

        String LZ_PromptPressHash = "7011.wav"; // This is used to store the press # prompt file name.
        String LZ_PromptBlank1 = "7220.wav"; // This is used to store the 0.01 sec blank prompt file name.
        String LZ_PromptBlank2 = "7221.wav"; // This is used to store the 0.05 sec blank prompt file name.
        String LZ_PromptBlank3 = "7222.wav"; // This is used to store the 0.25 sec blank prompt file name.
        String LZ_PromptRepeat = "7012.wav"; // This is used to store the repeat prompt file name.

        String LZ_RepeatMenuCFID = "907"; // This is used to store the repeat menu call flow ID.

        String LZ_RepeatMenuOption = "#"; // This is used to store the repeat menu option.

        String LZ_CallFlowID = "5"; // This is used to store the call flow ID.
        String LZ_CallFlowDateTime = ""; // This is used to store the call flow date time.

        String LZ_BACallerType = ""; // Type of the caller (Subscriber/Partner/Prospect etc.)
        String LZ_State = ""; // State which the subscription belongs to

        String LZ_CallFlowDetailXML = ""; // This is used to store the call flow detail XML.

        try {
            LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
            Document docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);

            LZ_BACallerType = XMLAO.getNodeValueText(docBA, "BA_CALLER_TYPE");
            LZ_State = XMLAO.getNodeValueText(docBA, "BA_STATE");


            LZ_CurrentDNIS = XMLAO.getNodeValueText(docBA, "FLDDNIS");
            
            DateFormat LZ_DateTimeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
            Date LZ_CurrentDateTime = new Date();
            LZ_CallFlowDateTime = LZ_DateTimeFormat.format(LZ_CurrentDateTime).toString();

            if (LZ_SimulatorMode) {
                LZ_MenuList = "1023.wav,Default_Language.wav," + LZ_PromptRepeat;
                LZ_MenuOptionList = ",1,2," + LZ_RepeatMenuOption;
                LZ_MenuCallFlowIDList = ",6,7," + LZ_RepeatMenuCFID;
                LZ_MenuOptionPromptList = "7220.wav,7220.wav," + LZ_PromptPressHash;
            } else {
                if (LZ_BACallerType.equals("NonRMN") || LZ_BACallerType.equals("Partner")) {
                    String[] LZ_DNISListArray = LZ_DNISList.split(";");
                    String[] LZ_LanguageOptionsListArray = LZ_LanguageOptionsList.split(";");

                    for (int i = 0; i < LZ_DNISListArray.length; i++) {
                        LZ_MenuList = "1023.wav";
                        LZ_MenuOptionList = "";
                        LZ_MenuOptionPromptList = "7220.wav";
                        LZ_MenuCallFlowIDList = "";

                        if (LZ_DNISListArray[i].equals(LZ_CurrentDNIS)) {
                            LZ_MenuList = LZ_MenuList + "," + LZ_CurrentDNIS + ".wav";

                            String[] LZ_LanguageOptionsArray = LZ_LanguageOptionsListArray[i].split(",");

                            for (int j = 0; j < LZ_LanguageOptionsArray.length; j++) {
                                LZ_MenuOptionList = LZ_MenuOptionList + "," + String.valueOf(j + 1);
                                LZ_MenuCallFlowIDList = LZ_MenuCallFlowIDList + "," + String.valueOf(Integer.parseInt(LZ_LanguageOptionsArray[j]) + 5);
                            }

                            LZ_MenuList = LZ_MenuList + "," + LZ_PromptRepeat;
                            LZ_MenuOptionList = LZ_MenuOptionList + "," + LZ_RepeatMenuOption;
                            LZ_MenuCallFlowIDList = LZ_MenuCallFlowIDList + "," + LZ_RepeatMenuCFID;
                            LZ_MenuOptionPromptList = LZ_MenuOptionPromptList + ",7220.wav," + LZ_PromptPressHash;
                            break;
                        } else {
                            LZ_MenuList = "1023.wav,Default_Language.wav," + LZ_PromptRepeat;
                            LZ_MenuOptionList = ",1,2," + LZ_RepeatMenuOption;
                            LZ_MenuCallFlowIDList = ",6,7," + LZ_RepeatMenuCFID;
                            LZ_MenuOptionPromptList = "7220.wav,7220.wav," + LZ_PromptPressHash;
                        }
                    }
                } else {
                    LZ_MenuList = "1023.wav,Default_Language.wav," + LZ_PromptRepeat;
                    LZ_MenuOptionList = ",1,2," + LZ_RepeatMenuOption;
                    LZ_MenuCallFlowIDList = ",6,7," + LZ_RepeatMenuCFID;
                    LZ_MenuOptionPromptList = "7220.wav,7220.wav," + LZ_PromptPressHash;
                }
            }
        } catch (Exception ex) {

            Logger.error(LZ_DBCallDetailID, " Exception in RetrieveLanguageOptionsMenu Page : " + ex.getMessage(), false);
        }

        JSONObject result = new JSONObject();
        result.put("MenuList", LZ_MenuList);
        result.put("MenuOptionList", LZ_MenuOptionList);
        result.put("MenuOptionPromptList", LZ_MenuOptionPromptList);
        result.put("MenuCallFlowIDList", LZ_MenuCallFlowIDList);

        result.put("CallFlowID", LZ_CallFlowID);
        result.put("CallFlowDateTime", LZ_CallFlowDateTime);

        result.put("BACallerType", LZ_BACallerType);

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