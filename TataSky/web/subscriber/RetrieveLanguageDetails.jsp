<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean LZ_SimulatorMode = false; // Simulator Mode by default is set to true.
        String LZ_CallFlowDetailXML = ""; // This is used to store the call flow detail XML.

        String LZ_BAPrimary_Language = ""; // Preferred Language Primary is returned from Seibel
        String LZ_BASecondary_Language = ""; // Preferred Language Secondary is returned from Seibel
        String LZ_BADefault_Language = ""; // This is used to store the default language of the caller.
        String LZ_BASelected_Language = ""; // Language selected by the caller in IVR (Auto/Manual)

        String LZ_CurrentLanguage = ""; // This is a placeholder for current language.
        String LZ_LanguageList = "English;Hindi;Marathi;Gujarati;Tamil;Bengali;Kannada;Telugu;Oriya;Punjabi;Malayalam;Assamesse;Manipuri"; // This stores the languages in order of BRD.
        String LZ_AppLanguageList = "en-IN;hi-IN;mr-IN;gu-IN;ta-IN;bn-IN;kn-IN;te-IN;or-IN;pa-IN;ml-IN;as-IN;en-IN"; // This stores the app language folder names in the above order of language list.

        String LZ_FirstCFID = ""; // This is used to store the CFID for first prompt.
        String LZ_BACallerType = ""; // Type of the caller (Subscriber/Partner/Prospect etc.)

        try {
            LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");

            if (LZ_SimulatorMode) {
                //Testing...
            } else {
                Document docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);

                LZ_BAPrimary_Language = XMLAO.getNodeValueText(docBA, "BA_PRIMARY_LANGUAGE");
                LZ_BASecondary_Language = XMLAO.getNodeValueText(docBA, "BA_SECONDARY_LANGUAGE");
                LZ_BADefault_Language = XMLAO.getNodeValueText(docBA, "BA_DEFAULT_LANGUAGE");
                LZ_BASelected_Language = XMLAO.getNodeValueText(docBA, "BA_SELECTED_LANGUAGE");
                
                System.out.println("LZ_BASelected_Language" + LZ_BASelected_Language);
                String[] LZ_LanguageArray = LZ_LanguageList.split(";");
                String[] LZ_AppLanguageArray = LZ_AppLanguageList.split(";");

                if (LZ_BASelected_Language.isEmpty()) 
				{
                    if (LZ_BAPrimary_Language.isEmpty()) 
					{
                        if (!LZ_BASecondary_Language.isEmpty())
						{
                            LZ_CurrentLanguage = LZ_BASecondary_Language;
                        }
                    } else {
                        LZ_CurrentLanguage = LZ_BAPrimary_Language;
                    }


                    boolean LZ_IsCorrectLanguage = false;

                    for (int i = 0; i < LZ_LanguageArray.length; i++) 
					{
                           	if(LZ_LanguageArray[i].equalsIgnoreCase(LZ_CurrentLanguage))
							{
                            LZ_IsCorrectLanguage = true;
                            break;
                            }
                    }

                    if (!LZ_IsCorrectLanguage) 
					{
                        if (!LZ_BAPrimary_Language.isEmpty() || !LZ_BASecondary_Language.isEmpty()) 
                        {
                           	 LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</CTIROOT>", "<CTILANGUAGEALERT>Preferred Language is incorrect in database, please update in Siebel</CTILANGUAGEALERT></CTIROOT>");
                        }
                                         
                        LZ_CurrentLanguage = LZ_BADefault_Language;
                        LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("<BA_ROOT>", "<BA_ROOT><BA_SELECTED_LANGUAGE>" + LZ_CurrentLanguage + "</BA_SELECTED_LANGUAGE>");
                    }
                }
				else 
				{
                    LZ_CurrentLanguage = LZ_BASelected_Language;
                    LZ_BACallerType = XMLAO.getNodeValueText(docBA, "BA_CALLER_TYPE");

                    if (LZ_BACallerType.equals("RMN") && (LZ_BAPrimary_Language.isEmpty() && LZ_BASecondary_Language.isEmpty())) 
					{
                        int LZ_LanguageAlertStartIndex = LZ_CallFlowDetailXML.indexOf("<CTILANGUAGEALERT>");
                        String LZ_tempLanguageAlert = "";

                        if (LZ_LanguageAlertStartIndex > 0)
						{
                            int LZ_LanguageAlertEndIndex = LZ_CallFlowDetailXML.indexOf("</CTILANGUAGEALERT>", LZ_LanguageAlertStartIndex) + 19;
                            LZ_tempLanguageAlert = LZ_CallFlowDetailXML.substring(LZ_LanguageAlertStartIndex, LZ_LanguageAlertEndIndex);
                         
                       	   if(!LZ_BASelected_Language.equalsIgnoreCase(LZ_BAPrimary_Language))
                       	   {
                       		   LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace(LZ_tempLanguageAlert, "<CTILANGUAGEALERT>Preferred Language is not available in database, please update in Siebel</CTILANGUAGEALERT>");
							  
                       	   }
   	   
                        	   
                        } 
						else 
						{
                        	
                            if(!LZ_BASelected_Language.equalsIgnoreCase(LZ_BAPrimary_Language))
                     	   {
                            	LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</CTIROOT>", "<CTILANGUAGEALERT>Preferred Language is not available in database, please update in Siebel</CTILANGUAGEALERT></CTIROOT>");
								
                     	   }
                        }
                        LZ_tempLanguageAlert = null;
                    }
                }
                System.out.println("LZ_CurrentLanguage" + LZ_CurrentLanguage);
                String LZ_AppLanguage = "en-IN";
               
                if (!LZ_CurrentLanguage.isEmpty()) 
				{
                    for (int i = 0; i < LZ_LanguageArray.length; i++)
					{
                        if (LZ_LanguageArray[i].equalsIgnoreCase(LZ_CurrentLanguage)) 
						{
                            LZ_AppLanguage = LZ_AppLanguageArray[i];
                            break;
                        }
                    }
                }

                System.out.println("LZ_AppLanguage2" + LZ_AppLanguage);
                String LZ_tempAppLanguage = XMLAO.getNodeValueText(docBA, "BA_APP_LANGUAGE");

                if (!LZ_AppLanguage.equalsIgnoreCase(LZ_tempAppLanguage)) {
                    String LZ_temp = "<BA_ROOT>";

                    int LZ_StartIndex = LZ_CallFlowDetailXML.indexOf("<BA_APP_LANGUAGE>");

                    if (LZ_StartIndex > 0) {
                        int LZ_EndIndex = LZ_CallFlowDetailXML.indexOf("</BA_APP_LANGUAGE>", LZ_StartIndex) + 18;
                        LZ_temp = LZ_CallFlowDetailXML.substring(LZ_StartIndex, LZ_EndIndex);
                        LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace(LZ_temp, "<BA_APP_LANGUAGE>" + LZ_AppLanguage + "</BA_APP_LANGUAGE>");
                    } else {
                        LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace(LZ_temp, "<BA_ROOT><BA_APP_LANGUAGE>" + LZ_AppLanguage + "</BA_APP_LANGUAGE>");
                    }
                    LZ_temp = null;
                }
                System.out.println("LZ_AppLanguage3" + LZ_AppLanguage);
                

                if (LZ_CurrentLanguage.equalsIgnoreCase("Manipuri")) {
                    LZ_FirstCFID = XMLAO.getNodeValueText(docBA, "FLDCALLFLOWID", 0);
                }

                LZ_CurrentLanguage = LZ_CurrentLanguage.toUpperCase();

                LZ_tempAppLanguage = LZ_AppLanguage = null;
                LZ_LanguageArray = LZ_AppLanguageArray = null;
            }
        } catch (Exception ex) {
            Logger.error("", " Exception in RetrieveLanguageDetails Page : " + ex.getMessage(), false);
        } finally {
            LZ_BAPrimary_Language = LZ_BASecondary_Language = LZ_BADefault_Language = LZ_BASelected_Language = LZ_LanguageList = LZ_AppLanguageList = LZ_BACallerType = null;
        }

        JSONObject result = new JSONObject();
        result.put("CurrentLanguage", LZ_CurrentLanguage);
        result.put("FirstCFID", LZ_FirstCFID);
        result.put("CallFlowDetailXML", LZ_CallFlowDetailXML);

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