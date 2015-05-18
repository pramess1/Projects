<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>

<%@page import="java.util.Iterator"%>
<%@page import="java.util.*"%>
<%@page import="com.tsg.database.ivr.dataaccess.BankIdDAO"%>
<%@page import="com.tsg.log.Logger"%>

<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        boolean b_SimulatorMode = false; // Simulator Mode by default is set to true.

// Input varibales
        String LZ_BankID = "";

        String LZ_CallDetailID = ""; // This is used to store the call detail ID.

        String LZ_CallFlowDetailXML = "";

// output varibales
        String LZ_BankFlag = "";

        String LZ_EMITenure = "";


        try {
            if (b_SimulatorMode) {
                //  Test method
            } else {
                // Realtime scenario
//                LZ_CallDetailID = state.getString("GZ_DBCallDetailID");
//
//                LZ_BankID = state.getString("LZ_BankID");
//
//                LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
                
                LZ_CallDetailID = state.optString("GZ_DBCallDetailID","");

                LZ_BankID = state.optString("LZ_BankID","");

                LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");                

                Logger.info(LZ_CallDetailID, " BankId Id : " + LZ_BankID, false);

                BankIdDAO dbBankIdDAO = new BankIdDAO();

                ArrayList bankIdlist = dbBankIdDAO.bankIdValidation(LZ_BankID, LZ_CallDetailID);

                Iterator bankIdlistItr = bankIdlist.iterator();

                while (bankIdlistItr.hasNext()) {

                    dbBankIdDAO = (BankIdDAO) bankIdlistItr.next();

                    LZ_BankFlag = dbBankIdDAO.getBankFlage();

                    LZ_EMITenure = dbBankIdDAO.getBankEmiDetails();

                }

            }

        } catch (Exception ex) {

            Logger.error(LZ_CallDetailID, " Exception in Bank Id Validation Page :   " + ex.getMessage(), false);

        } finally {

            try {

                if (LZ_BankFlag.equalsIgnoreCase("N")) {

                    if (LZ_EMITenure.equalsIgnoreCase("Invalid Bank Id")) {

                        LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</CTIROOT>", "<CTITRANSACTIONALERT>Invalid Bank Id</CTITRANSACTIONALERT></CTIROOT>");

                    } else {

                        LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</CTIROOT>", "<CTITRANSACTIONALERT>Database Connection Failed</CTITRANSACTIONALERT></CTIROOT>");

                    }
                }

            } catch (Exception ex1) {

                Logger.error(LZ_CallDetailID, " Exception in Bank Id Validation Finally Block :   " + ex1.getMessage(), false);
            }finally{
              
            LZ_BankID = null;
                  }

        }

        JSONObject result = new JSONObject();

        result.put("LZ_BankFlag", LZ_BankFlag);

        result.put("LZ_EMITenure", LZ_EMITenure);

        result.put("CallFlowDetailXML", LZ_CallFlowDetailXML);

        Logger.info(LZ_CallDetailID, " Bank Flag : " + LZ_BankFlag + " EMI Tenure : " + LZ_EMITenure, false);

        return result;

    }

    ;
%>
<%-- GENERATED: DO NOT REMOVE --%> 
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONException"%>
<%@page import="java.util.Map"%>
<%@include file="../backend.jspf" %>