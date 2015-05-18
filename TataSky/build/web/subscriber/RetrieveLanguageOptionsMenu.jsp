<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean LZ_SimulatorMode = false; // Simulator Mode by default is set to true.
      //  String LZ_LanguageOptionsList = "1,2,8;1,2,7,8,5,11,6,9,12;1,2,3,4;1,2,3,4;1,2,10;1,2,10;1,2,12,6;1,2,12,6;1,2,7,8,5,11,6,9,12;1,2,9;1,2,6;1,2,12,6;1,2,7,8,5,11,6,9,12;1,2,7,8,5,11,6,9,12;1,2,12,6;1,2,12,6;1,2,12,6;1,2,12,6;1,2,12,6;1,2,7,8,5,11,6,9,12;1,2,12,6;1,2,7;1,2,11;1,2,5;1,2,7,8,5,11,6,9,12;1,2,7,8,5,11,6,9,12;1,2,3,4;1,2,3,4;1,2,3,4;1,2,3,4;1,2,3,4;1,2,7,11,6,10,4,3;1,2"; // This is used to store the language options for all DNIS.
       // String LZ_DNISList = "4027683000;4066006633;2027020200;2066006633;1722236139;1726600663;4027683006;4066006631;4027683007;4027683005;4027683004;4027683010;4027683011;4027683008;4027683009;4027683012;4027683013;4027683014;4027683015;4027683016;4027683017;4027683001;4027683003;4027683002;4027683018;4027683019;2027020400;2027020500;2027020600;2027020700;2027020300;7777;49432108"; // This is used to store the DNIS List.
        
        String LZ_LanguageOptionsList = "4,2,1;7,1,2;11,1,2;3,2,1;3,2,1;5,1,2;3,2,1;3,2,1;8,1,2;5,1,2;7,1,2;4;"; // This is used to store the language options for all DNIS.
        String LZ_DNISList = "49432102;49432103;49432104;49432105;49432106;49432107;67028601;67028602;67028603;67028604;67028605;"; // This is used to store the DNIS List.
        String LZ_CurrentDNIS = ""; // This is used to store the current DNIS.

        String LZ_StateToLanguageOptionsList = "2,1;8,2,1;2,1;12,2,1;2,1;2,1;2,1;3,2,1;4,2,1;2,1;7,2,1;11,2,1;2,1;2,1;3,2,1;13,2,1;2,1;2,1;2,1;9,2,1;5,2,1;10,2,1;2,1;5,2,1;2,1;6,2,1"; // This is used to store the state to language options. 
        String LZ_StateList = "ANDAMANNICOBOR;ANDHRA PRADESH;ARUNACHAL;ASSAM;CHATTISGARH;DADRA;DAMAN AND DIU;GOA;GUJARAT;JHARKHAND;KARNATAKA;KERALA;LAKSHDEEP;MADHYA PRADESH;MAHARASTRA;MANIPUR;MEGHALAYA;MIZORAM;NAGALAND;ORISSA;PONDICHERRY;PUNJAB;SIKKIM;TAMILNADU;TRIPURA;WEST BENGAL"; // This is used to store the states.


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
//            LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
            LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");            
            Document docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);

            LZ_BACallerType = XMLAO.getNodeValueText(docBA, "BA_CALLER_TYPE");
            LZ_State = XMLAO.getNodeValueText(docBA, "BA_STATE");
            LZ_CurrentDNIS = XMLAO.getNodeValueText(docBA, "FLDDNIS");

            //LZ_CurrentDNIS = "4027683018";// 9 languages		

            DateFormat LZ_DateTimeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
            Date LZ_CurrentDateTime = new Date();
            LZ_CallFlowDateTime = LZ_DateTimeFormat.format(LZ_CurrentDateTime).toString();

            if (LZ_SimulatorMode) {
                //Testing...
            } else {
                if (LZ_BACallerType.equals("NonRMN") || LZ_BACallerType.equals("RMN")) {
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
				//LZ_MenuOptionList = ",1,2,7,11,6,10,4,3," + LZ_RepeatMenuOption;
                   	//	LZ_MenuCallFlowIDList = ",6,7,12,16,11,15,9,8," + LZ_RepeatMenuCFID;

                            LZ_MenuOptionPromptList = "7220.wav,7220.wav," + LZ_PromptPressHash;
                        }
                    }
                } else if (LZ_BACallerType.equals("Prospect")) {
                    String[] LZ_StateListArray = LZ_StateList.split(";");
                    String[] LZ_StateToLanguageOptionsListArray = LZ_StateToLanguageOptionsList.split(";");

                    for (int i = 0; i < LZ_StateListArray.length; i++) {
                        LZ_MenuList = "1023.wav";
                        LZ_MenuOptionList = "";
                        LZ_MenuOptionPromptList = "7220.wav";
                        LZ_MenuCallFlowIDList = "";

                        if (LZ_StateListArray[i].equals(LZ_State)) {
                            LZ_MenuList = LZ_MenuList + "," + LZ_State + ".wav";

                            String[] LZ_LanguageOptionsArray = LZ_StateToLanguageOptionsListArray[i].split(",");

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
				//LZ_MenuOptionList = ",1,2,7,11,6,10,4,3," + LZ_RepeatMenuOption;
                   	//	LZ_MenuCallFlowIDList = ",6,7,12,16,11,15,9,8," + LZ_RepeatMenuCFID;


                            LZ_MenuOptionPromptList = "7220.wav,7220.wav," + LZ_PromptPressHash;
                        }
                    }
                } else {
                    LZ_MenuList = "1023.wav,Default_Language.wav," + LZ_PromptRepeat;
                    LZ_MenuOptionList = ",1,2," + LZ_RepeatMenuOption;
                    LZ_MenuCallFlowIDList = ",6,7," + LZ_RepeatMenuCFID;
 		     // LZ_MenuOptionList = ",1,2,7,11,6,10,4,3," + LZ_RepeatMenuOption;
                //    LZ_MenuCallFlowIDList = ",6,7,12,16,11,15,9,8," + LZ_RepeatMenuCFID;
                    LZ_MenuOptionPromptList = "7220.wav,7220.wav," + LZ_PromptPressHash;
                }
            }
        } catch (Exception ex) {
            Logger.error("", " Exception in RetrieveLanguageOptionsMenu Page : " + ex.getMessage(), false);
        } finally {
            LZ_LanguageOptionsList = LZ_DNISList = LZ_CurrentDNIS = LZ_StateToLanguageOptionsList = LZ_StateList = LZ_PromptPressHash = LZ_PromptBlank1 = LZ_PromptBlank2 = LZ_PromptBlank3 = LZ_PromptRepeat = LZ_RepeatMenuCFID = LZ_RepeatMenuOption = LZ_State = LZ_CallFlowDetailXML = null;
        }

   	 System.out.println("MenuList" + LZ_MenuList);
        System.out.println("MenuOptionList" + LZ_MenuOptionList);
        System.out.println("MenuOptionPromptList" + LZ_MenuCallFlowIDList);
        System.out.println("MenuCallFlowIDList" + LZ_MenuCallFlowIDList);


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