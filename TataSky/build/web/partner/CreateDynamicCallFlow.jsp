<%@page language="java" contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.tsg.log.Logger"%>
<%!

public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {
    
        boolean LZ_SimulatorMode = false; // Simulator Mode by default is set to true.
        String LZ_DynamicCallFlowXML = ""; // This stores the dynamic call flow XML sent by parent call flow.
        String LZ_CallFlowType = ""; // This stores the dynamic call flow type.
        String LZ_PromptList = ""; // This is used to store the result prompt list.
        String LZ_CallFlowIDList = ""; // This is used to store the result call flow ID list.
        String LZ_RuleID = ""; // This is used to store the rule ID.
        String LZ_CallDetailID = ""; // This is used to store the call detail ID.

        String LZ_MainMenuCFID = "904"; // This is used to store the main menu call flow ID.
        String LZ_PreviousMenuCFID = "905"; // This is used to store the previous menu call flow ID.
        String LZ_AgentTransferCFID = "906"; // This is used to store the agent transfer call flow ID.
        String LZ_RepeatMenuCFID = "907"; // This is used to store the repeat menu call flow ID.
        String LZ_OtherServicesCFID = "908"; // This is used to store the other services call flow ID.
        String LZ_RepeatMessageCFID = "910"; // This is used to store the repeat message call flow ID.
	
        try
        {
//            LZ_CallFlowType = state.getString("LZ_CallFlowType");
//            LZ_PromptList = state.getString("LZ_PromptList");
//            LZ_CallFlowIDList = state.getString("LZ_CallFlowIDList");
//            LZ_RuleID = state.getString("LZ_RuleID");
//            LZ_CallDetailID = state.getString("LZ_DBCallDetailID");
            LZ_CallFlowType = state.optString("LZ_CallFlowType","");
            LZ_PromptList = state.optString("LZ_PromptList","");
            LZ_CallFlowIDList = state.optString("LZ_CallFlowIDList","");
            LZ_RuleID = state.optString("LZ_RuleID","");
            LZ_CallDetailID = state.optString("LZ_DBCallDetailID","");            
          
            if(LZ_SimulatorMode)
            {

            }
            else
            {
                StringBuilder sbDCF = new StringBuilder("<CallFlow CDID=\"" + LZ_CallDetailID + "\" RuleID=\"" + LZ_RuleID + "\">");
                String[] LZ_PromptListArray = null;
                String[] LZ_CallFlowIDListArray = null;
                
                if(LZ_PromptList.contains(","))
                {
                    LZ_PromptListArray = LZ_PromptList.split(",");
                    LZ_CallFlowIDListArray = LZ_CallFlowIDList.split(",");
                }
                else
                {
                    LZ_PromptListArray = new String[1];
                    LZ_PromptListArray[0] = LZ_PromptList;
                    LZ_CallFlowIDListArray = new String[1];
                    LZ_CallFlowIDListArray[0] = LZ_CallFlowIDList;
                }
                
                if(LZ_CallFlowType.equals("Prompt")
                    || LZ_CallFlowType.equals("ValuePrompt"))
                {
                    for(int i=0; i < LZ_PromptListArray.length; i++)
                    {
                        if(LZ_PromptListArray.length > LZ_CallFlowIDListArray.length && i == LZ_PromptListArray.length - 1)
                        {
                                sbDCF.append("<Prompt CFID=\"\">" + LZ_PromptListArray[i] + "</Prompt>");
                        }
                        else
                        {
                                sbDCF.append("<Prompt CFID=\"" + LZ_CallFlowIDListArray[i] + "\">" + LZ_PromptListArray[i] + "</Prompt>");
                        }
                    }
                }
                else if(LZ_CallFlowType.equals("RepeatPrompt")
                        || LZ_CallFlowType.equals("ValueRepeatPrompt"))
                {
                    for(int i=0; i < LZ_PromptListArray.length; i++)
                    {
                        if(LZ_CallFlowIDListArray[i].equals(LZ_MainMenuCFID) 
                            || LZ_CallFlowIDListArray[i].equals(LZ_PreviousMenuCFID)
                            || LZ_CallFlowIDListArray[i].equals(LZ_AgentTransferCFID)
                            || LZ_CallFlowIDListArray[i].equals(LZ_RepeatMenuCFID)
                            || LZ_CallFlowIDListArray[i].equals(LZ_OtherServicesCFID)
                            || LZ_CallFlowIDListArray[i].equals(LZ_RepeatMessageCFID))
                        {
                                sbDCF.append("<Menu CFID=\"" + LZ_CallFlowIDListArray[i] + "\">" + LZ_PromptListArray[i] + "</Menu>");
                        }
                        else
                        {
                                sbDCF.append("<Prompt CFID=\"" + LZ_CallFlowIDListArray[i] + "\">" + LZ_PromptListArray[i] + "</Prompt>");
                        }
                    }
                }
                else if(LZ_CallFlowType.equals("Menu"))
                {
                    for(int i=0; i < LZ_PromptListArray.length; i++)
                    {
                        sbDCF.append("<Menu CFID=\"" + LZ_CallFlowIDListArray[i] + "\">" + LZ_PromptListArray[i] + "</Menu>");
                    }
                }
                
                sbDCF.append("</CallFlow>");
               
                LZ_DynamicCallFlowXML = sbDCF.toString();
               
            }
        }
        catch(Exception ex)
        {
           Logger.error(LZ_CallDetailID, " Exception in Create Dynamic Call Flow Page : " + ex.getMessage(), false);
        }finally{
        
            LZ_CallFlowType = LZ_PromptList = LZ_CallFlowIDList = LZ_RuleID = LZ_CallDetailID = LZ_MainMenuCFID = LZ_PreviousMenuCFID = LZ_AgentTransferCFID = LZ_RepeatMenuCFID = LZ_OtherServicesCFID = LZ_RepeatMessageCFID =null;
        }
    
    JSONObject result = new JSONObject();
    result.put("DynamicCallFlowXML", LZ_DynamicCallFlowXML);

    
    return result;
    
};
%>
<%-- GENERATED: DO NOT REMOVE --%> 
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONException"%>
<%@page import="java.util.Map"%>

<%@page import="org.w3c.dom.Document"%>
<%@page import="Common.ActionObjects.*"%>

<%@include file="../backend.jspf" %>