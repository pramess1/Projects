<%@page language="java" contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.tsg.database.DBAccess"%>
<%@page import="com.tsg.common.*"%>
<%@page import="com.tsg.log.Logger"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean LZ_SimulatorMode = false; // Simulator Mode by default is set to true.
        String LZ_CallFlowDetailXML = ""; // This is used to store the call flow detail XML.
        String LZ_DBCallDetailID = ""; // This is used to store the call detail ID.
        String LZ_RuleID = ""; // This is used to store the rule ID.
        String LZ_CallFlowID = ""; // This is used to store the call flow ID sent by other call flows.

        String LZ_BASubscriberID = ""; // Subscriber ID
        String LZ_BAAccountBalance = ""; // Account balance for a particular subsccriber ID
        String LZ_OverDueAmount = ""; // This is used to store the overdue amount in case of negative account balance.
        String LZ_BASubscriptionType = ""; // Monthly/FDP/LDP etc.
        String LZ_BARechargeDueDate = ""; // Recharge due date
        String LZ_BALastRechargeAmount = ""; // Last recharge amount
        String LZ_BALastRechargeDateTime = ""; // Last recharge date and time
        String LZ_BALastRechargeDate = ""; // Last recharge date
        String LZ_BALastRechargeTime = ""; // Last recharge time
        String LZ_BAAccountStatus = ""; // Account status (Active/De-Active)


        String LZ_DynamicCallFlowXML = ""; // This is used to store the callflow in XML format.

        String LZ_PromptAccountBalance = "2024.wav"; // This is used to store the account balance prompt file name.
        String LZ_PromptOverDueAmount = "2039.wav"; // This is used to store the over due amount prompt file name.
        String LZ_PromptRechargeDueDate = "2040.wav"; // This is used to store the recharge due date prompt file name.
        String LZ_PromptRenewDate = "7262.wav"; // This is used to store the renew date prompt file name.
        String LZ_PromptIs = "is.wav"; // This is used to store the is prompt file name.
        String LZ_PromptRechargeAmount = "2025.wav"; // This is used to store the recharge amount prompt file name.
        String LZ_PromptRechargeDateTime = "3087.wav"; // This is used to store the recharge date and time prompt file name.
        String LZ_PromptActiveAccountStatus = "3405.wav"; // This is used to store the active account status prompt file name.
        String LZ_PromptPendingAccountStatus = "3406.wav"; // This is used to store the pending account status prompt file name.
        String LZ_PromptAt = "at.wav"; // This is used to store the at prompt file name.

        //srini
        String LZ_PromptSubscriberID = "2024.wav"; // This is used to store the account balance prompt file name.
        String LZ_PromptCurrentAccountBalance = "2024_1.wav";

        String LZ_DueDateGTCurrentDate = ""; // This is used as a flag to store whether due date is greater than current date
        String LZ_PromptRenewDateIs = "7260.wav"; // This is used to store the renew date prompt file name not past current date.
        String LZ_PromptRenewDateWas = "7262.wav"; // This is used to store the renew date prompt file name past current date.
        String LZ_PremiumFlag1 = "";
	 String LZ_SelectedLanguage = "";
	 String LZ_PrimaryLanguage = "";
	 String LZ_SecondaryLanguage  = "";
	 String LZ_IVRLanguage  = "";


        String LZ_NUANCE_URL = ""; // This is used to store the NUANCE URL.

        try {
//            LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
//            LZ_DBCallDetailID = state.getString("LZ_DBCallDetailID");
//            LZ_RuleID = state.getString("LZ_RuleID");
//            LZ_CallFlowID = state.getString("LZ_CallFlowID");
            LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");
            LZ_DBCallDetailID = state.optString("LZ_DBCallDetailID","");
            LZ_RuleID = state.optString("LZ_RuleID","");
            LZ_CallFlowID = state.optString("LZ_CallFlowID","");            
            //System.out.println("LZ_CallFlowID=" + LZ_CallFlowID);
            //LZ_CallFlowID = "11033";

            if (LZ_SimulatorMode) {
            } else {

                StringBuilder sbDCF = new StringBuilder("");

                Document docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);

                LZ_BASubscriberID = XMLAO.getNodeValueText(docBA, "BA_SUBSCRIBER_ID");

                LZ_PremiumFlag1 = XMLAO.getNodeValueText(docBA, "BA_PREMIUM_FLAG1");

                String LZ_BA_XML = new DBAccess().getAccountDetail(LZ_BASubscriberID, LZ_DBCallDetailID);

                String LZ_BA_XML_DET = new DBAccess().getDetailBySubscriberId(LZ_BASubscriberID, LZ_PremiumFlag1, LZ_DBCallDetailID);

                LZ_CallFlowDetailXML = XMLAO.getNodeOuterXML(docBA);

                //LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("<BA_ROOT>", "<BA_ROOT>" + LZ_BA_XML + LZ_BA_XML_DET );

                LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("<BA_ROOT>", "<BA_ROOT>" + LZ_BA_XML + LZ_BA_XML_DET);

                docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);

                LZ_BASubscriptionType = XMLAO.getNodeValueText(docBA, "BA_SUBSCRIPTION_TYPE");
                
                LZ_BAAccountStatus = XMLAO.getNodeValueText(docBA, "BA_ACCOUNT_STATUS");

              //  docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);

                LZ_BAAccountBalance = XMLAO.getNodeValueText(docBA, "BA_ACCOUNT_BALANCE");
              
		  LZ_SelectedLanguage = XMLAO.getNodeValueText(docBA, "BA_SELECTED_LANGUAGE");

		  LZ_PrimaryLanguage =  XMLAO.getNodeValueText(docBA, "BA_PRIMARY_LANGUAGE");

		  LZ_SecondaryLanguage =  XMLAO.getNodeValueText(docBA, "BA_SECONDARY_LANGUAGE");


		  if(LZ_SelectedLanguage.isEmpty())
			{	
				if(LZ_PrimaryLanguage.isEmpty())
				{
					if(!LZ_SecondaryLanguage.isEmpty())
					{
						LZ_IVRLanguage = LZ_SecondaryLanguage;
					}
				}
				else
				{
					LZ_IVRLanguage = LZ_PrimaryLanguage;
				}
			
			}
			else
			{
				LZ_IVRLanguage = LZ_SelectedLanguage;
			}

                if (!LZ_BAAccountBalance.trim().isEmpty()) {
                    
                    float LZ_tempBalance = Float.parseFloat(LZ_BAAccountBalance);

                    if (LZ_tempBalance == 0) {
                        
                        LZ_BAAccountBalance = "";
                        
                        LZ_OverDueAmount = "";
                        
                    } else if (LZ_tempBalance < 0) {
                        
                        LZ_tempBalance = LZ_tempBalance * (-1);
                        
                        LZ_OverDueAmount = String.valueOf(LZ_tempBalance);
                        
                        LZ_BAAccountBalance = "";
                        
                    } else {
                        
                        LZ_BAAccountBalance = String.valueOf(LZ_tempBalance);
                    }
                    
                } else {
                    
                    LZ_BAAccountBalance = "";
                    
                    LZ_OverDueAmount = "";
                }

                if (!LZ_BASubscriptionType.isEmpty()) {
                    
                    if (LZ_BASubscriptionType.equals("Monthly")) {
                        
                        LZ_BARechargeDueDate = XMLAO.getNodeValueText(docBA, "BA_RECHARGE_DUE_DATE");
                    }
                    if (LZ_BASubscriptionType.equals("FDP")) {
                        
                        LZ_BARechargeDueDate = XMLAO.getNodeValueText(docBA, "BA_FDP_RENEW_DATE");
                        
                    } else if (LZ_BASubscriptionType.equals("LDP")) {
                        
                        LZ_BARechargeDueDate = XMLAO.getNodeValueText(docBA, "BA_LDP_RENEW_DATE");
                    }

                }

                if (!LZ_BARechargeDueDate.trim().isEmpty()) {
                    
                    DateFormat LZ_DateFormat = new SimpleDateFormat("yyyy-MM-dd");

                    Date LZ_tempDueDate = LZ_DateFormat.parse(LZ_BARechargeDueDate);

                    LZ_BARechargeDueDate = LZ_DateFormat.format(LZ_tempDueDate).toString();

                    Date CurrDate = new Date();

                    if (LZ_tempDueDate.compareTo(CurrDate) >= 0) {
                        
                        LZ_DueDateGTCurrentDate = "Y";
                        
                    } else {
                        
                        LZ_DueDateGTCurrentDate = "N";
                    }
                    
                } else {
                    
                    LZ_BARechargeDueDate = "";
                }

                if (!LZ_BAAccountBalance.isEmpty() || LZ_BAAccountStatus.isEmpty() || !LZ_OverDueAmount.isEmpty() || !LZ_BARechargeDueDate.isEmpty()) {
                    
                    sbDCF.append("<CallFlow CDID=\"" + LZ_DBCallDetailID + "\" RuleID=\"" + LZ_RuleID + "\">");

                   if(!LZ_BAAccountBalance.isEmpty())
				{
				
						
					if(LZ_IVRLanguage.equals("English"))
					{
					sbDCF.append("<Prompt CFID=\"" + LZ_CallFlowID + "\">" + LZ_PromptSubscriberID + "</Prompt>");
					sbDCF.append("<Prompt CFID=\"\">" + LZ_BASubscriberID + "</Prompt>");
					sbDCF.append("<Prompt CFID=\"" + LZ_CallFlowID + "\">" + LZ_PromptCurrentAccountBalance + "</Prompt>");
					sbDCF.append("<Prompt CFID=\"" + LZ_CallFlowID + "\">" + LZ_PromptIs + "</Prompt>");
					sbDCF.append("<Prompt CFID=\"\">" + LZ_BAAccountBalance + "</Prompt>");
					}
					else
					{
					sbDCF.append("<Prompt CFID=\"" + LZ_CallFlowID + "\">" + LZ_PromptSubscriberID + "</Prompt>");
					sbDCF.append("<Prompt CFID=\"\">" + LZ_BASubscriberID + "</Prompt>");
					sbDCF.append("<Prompt CFID=\"" + LZ_CallFlowID + "\">" + LZ_PromptCurrentAccountBalance + "</Prompt>");
					sbDCF.append("<Prompt CFID=\"\">" + LZ_BAAccountBalance + "</Prompt>");
					sbDCF.append("<Prompt CFID=\"" + LZ_CallFlowID + "\">" + LZ_PromptIs + "</Prompt>");
				
					}
									
					
				}

                    if (!LZ_OverDueAmount.isEmpty()) {
                        
                        sbDCF.append("<Prompt CFID=\"" + LZ_CallFlowID + "\">" + LZ_PromptOverDueAmount + "</Prompt>");
                        //sbDCF.append("<Prompt CFID=\"\">" + LZ_BASubscriberID + "</Prompt>");
                        //sbDCF.append("<Prompt CFID=\"" + LZ_CallFlowID + "\">" + LZ_PromptIs + "</Prompt>");
                        sbDCF.append("<Prompt CFID=\"\">" + LZ_OverDueAmount + "</Prompt>");
                    }
                    if (!LZ_BARechargeDueDate.isEmpty() && !LZ_BAAccountStatus.equals("Pending")) {
                        if (LZ_BASubscriptionType.equals("FDP") || LZ_BASubscriptionType.equals("LDP")) {
                            if (LZ_DueDateGTCurrentDate.equals("Y")) {

                                sbDCF.append("<Prompt CFID=\"" + LZ_CallFlowID + "\">" + LZ_PromptRenewDateIs + "</Prompt>");
                            } else {

                                sbDCF.append("<Prompt CFID=\"" + LZ_CallFlowID + "\">" + LZ_PromptRenewDateWas + "</Prompt>");
                            }

                        } else if (LZ_BASubscriptionType.equals("Monthly")) {
                            sbDCF.append("<Prompt CFID=\"" + LZ_CallFlowID + "\">" + LZ_PromptRechargeDueDate + "</Prompt>");
                        } else {
                            sbDCF.append("<Prompt CFID=\"" + LZ_CallFlowID + "\">" + LZ_PromptRechargeDueDate + "</Prompt>");
                        }
                        sbDCF.append("<Prompt CFID=\"\">" + LZ_BARechargeDueDate + "</Prompt>");
                    }
                    LZ_BALastRechargeAmount = XMLAO.getNodeValueText(docBA, "BA_LAST_RECHARGE_AMT");

                    if (!LZ_BALastRechargeAmount.isEmpty() && !LZ_BAAccountStatus.equals("Pending")) {
                        float LZ_tempAmount = Float.parseFloat(LZ_BALastRechargeAmount);

                        if (LZ_tempAmount <= 0) {
                            LZ_BALastRechargeAmount = "";
                        } else {
                            LZ_BALastRechargeAmount = String.valueOf(LZ_tempAmount);

                            sbDCF.append("<Prompt CFID=\"" + LZ_CallFlowID + "\">" + LZ_PromptRechargeAmount + "</Prompt>");
                            sbDCF.append("<Prompt CFID=\"\">" + LZ_BALastRechargeAmount + "</Prompt>");

                            LZ_BALastRechargeDateTime = XMLAO.getNodeValueText(docBA, "BA_LAST_RECHARGE_DATETIME");

                            if (!LZ_BALastRechargeDateTime.isEmpty()) {
                                DateFormat LZ_DateFormat = new SimpleDateFormat("yyyy-MM-dd");
                                DateFormat LZ_TimeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

                                Date LZ_tempDate = LZ_DateFormat.parse(LZ_BALastRechargeDateTime);
                                LZ_BALastRechargeDate = LZ_DateFormat.format(LZ_tempDate).toString();

                                LZ_tempDate = LZ_TimeFormat.parse(LZ_BALastRechargeDateTime);
                                LZ_BALastRechargeTime = LZ_TimeFormat.format(LZ_tempDate).toString();
                                LZ_BALastRechargeTime = LZ_BALastRechargeTime.split(" ")[1];

                                sbDCF.append("<Prompt CFID=\"" + LZ_CallFlowID + "\">" + LZ_PromptRechargeDateTime + "</Prompt>");
                                sbDCF.append("<Prompt CFID=\"\">" + LZ_BALastRechargeDate + "</Prompt>");
                                sbDCF.append("<Prompt CFID=\"" + LZ_CallFlowID + "\">" + LZ_PromptAt + "</Prompt>");
                                sbDCF.append("<Prompt CFID=\"\">" + LZ_BALastRechargeTime + "</Prompt>");
                            } else {
                                LZ_BALastRechargeDate = "";
                                LZ_BALastRechargeTime = "";
                            }

                            LZ_BAAccountStatus = XMLAO.getNodeValueText(docBA, "BA_ACCOUNT_STATUS");

                            if (LZ_BAAccountStatus.equals("Active")) {
                                sbDCF.append("<Prompt CFID=\"" + LZ_CallFlowID + "\">" + LZ_PromptActiveAccountStatus + "</Prompt>");
                            } else {
                                sbDCF.append("<Prompt CFID=\"" + LZ_CallFlowID + "\">" + LZ_PromptPendingAccountStatus + "</Prompt>");
                            }
                        }
                    }

                    sbDCF.append("<Menu CFID=\"11034\">2013.wav</Menu><Menu CFID=\"11035\">2014.wav</Menu><Menu CFID=\"910\">7030.wav</Menu><Menu CFID=\"905\">7013.wav</Menu><Menu CFID=\"904\">7223.wav</Menu><Menu CFID=\"906\">7018.wav</Menu></CallFlow>");
                    
                }

                LZ_DynamicCallFlowXML = sbDCF.toString();
                LZ_NUANCE_URL = ConfigurationReader.configList.get("NUANCE_URL");
            }
        } catch (Exception ex) {
            Logger.error(LZ_DBCallDetailID, " Exception in RetrieveBalanceLastRechargeDetails Page : " + ex.getMessage(), false);
        }finally{
        
            LZ_DBCallDetailID = LZ_RuleID = LZ_CallFlowID = LZ_BASubscriberID =LZ_BAAccountBalance = LZ_OverDueAmount = LZ_BASubscriptionType = LZ_BARechargeDueDate = LZ_BALastRechargeAmount =  LZ_BALastRechargeDateTime = LZ_BALastRechargeDate = LZ_BALastRechargeTime = LZ_BAAccountStatus = LZ_PromptAccountBalance = LZ_PromptOverDueAmount = LZ_PromptRechargeDueDate = LZ_PromptRenewDate = LZ_PromptIs = LZ_PromptRechargeAmount = LZ_PromptRechargeDateTime =LZ_PromptActiveAccountStatus = LZ_PromptPendingAccountStatus = LZ_PromptAt = LZ_PromptSubscriberID = LZ_PromptCurrentAccountBalance = LZ_DueDateGTCurrentDate = LZ_PromptRenewDateIs = LZ_PromptRenewDateWas = LZ_PremiumFlag1 = LZ_SelectedLanguage = LZ_PrimaryLanguage = LZ_SecondaryLanguage  = LZ_IVRLanguage  =null;
        }


        JSONObject result = new JSONObject();
        result.put("DynamicCallFlowXML", LZ_DynamicCallFlowXML);
        result.put("CallFlowDetailXML", LZ_CallFlowDetailXML);
        result.put("NUANCE_URL", LZ_NUANCE_URL);

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

<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<%@include file="../backend.jspf" %>