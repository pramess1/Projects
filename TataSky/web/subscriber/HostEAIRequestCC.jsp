<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>
<%@page import="com.tsg.log.Logger"%>
<%!
private boolean b_SimulatorMode = true; // Simulator Mode by default is set to true.
private String GZ_CallFlowID;
private String GZ_CallDetailID;

private String LZ_SubscriberID;
private String LZ_TSTxnID;
private String LZ_AtomTxnID;
private String LZ_BankName;
private String LZ_CurrBal;
private String LZ_Amount;
private String LZ_BonusAmt;

private String LZ_APGID;
private String LZ_RRN;
private String LZ_TSReceipt;
private String LZ_errorcode;
private String LZ_errorMsg;
private String LZ_CheckSum;

public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {
    
        try
        {
                if(b_SimulatorMode)
                {
					//  Test method
					
					LZ_SubscriberID = "1234567892";
					LZ_TSTxnID = "2345167890";
					LZ_AtomTxnID = "123456";
					LZ_BankName = "ICICIAC";
					LZ_CurrBal = "100";
					LZ_Amount = "200";
					LZ_BonusAmt = "50";
					LZ_APGID = "73162";
					LZ_RRN = "31926814321";
					LZ_TSReceipt = "121217156853614";
					LZ_errorcode = "00";
					LZ_errorMsg = "SUCCESS";
					LZ_CheckSum = "1506615709";
                }
                else
                {
                        // Realtime scenario
                }
        }
        catch (Exception ex)
        {
                // Log Exception
        }
    
  
    JSONObject result = new JSONObject();
	result.put("LZ_SubscriberID", LZ_SubscriberID);
	result.put("LZ_TSTxnID", LZ_TSTxnID);
	result.put("LZ_AtomTxnID", LZ_AtomTxnID);
	result.put("LZ_BankName", LZ_BankName);
        result.put("LZ_CurrBal", LZ_CurrBal);
        result.put("LZ_Amount", LZ_Amount);
  	result.put("LZ_BonusAmt", LZ_BonusAmt);
	result.put("LZ_APGID", LZ_APGID);
	result.put("LZ_RRN", LZ_RRN);
	result.put("LZ_TSReceipt", LZ_TSReceipt);
	result.put("LZ_errorcode", LZ_errorcode);
	result.put("LZ_errorMsg", LZ_errorMsg);
	result.put("LZ_CheckSum", LZ_CheckSum);
    return result;
    
};
%>
<%-- GENERATED: DO NOT REMOVE --%> 
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONException"%>
<%@page import="java.util.Map"%>
<%@include file="../backend.jspf" %>