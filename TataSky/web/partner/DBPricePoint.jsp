<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>

<%@page import="java.util.Iterator"%>
<%@page import="java.util.*"%>
<%@page import="com.tsg.database.ivr.dataaccess.PricePointDAO"%>
<%@page import="com.tsg.log.Logger"%>
<%!//static Logger log = Logger.getLogger(DBPricePoint_jsp.class);
    private boolean b_SimulatorMode = false; // Simulator Mode by default is set to true.

    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {
        // Input varibales
        String LZ_pricePoint = "";

        String LZ_CallDetailID = ""; // This is used to store the call detail ID.

        String LZ_CallFlowDetailXML = "";

        // output varibales
        String LZ_NoOfBoxes = "";

        String LZ_PackName = "";

        int LZ_HardwareAmount = 0;

        int LZ_ActivityFee = 0;

        int LZ_BonusAmount = 0;

        int LZ_PackageAmount = 0;

        int LZ_AccessoriesAmount = 0;

        String LZ_TotalAmount = "";


        try {
            if (b_SimulatorMode) {
                //  Test method
            } else {

                // Realtime scenario
//                LZ_CallDetailID = state.getString("GZ_DBCallDetailID");
//
//                LZ_pricePoint = state.getString("LZ_pricePoint");
                
                LZ_CallDetailID = state.optString("GZ_DBCallDetailID","");

                LZ_pricePoint = state.optString("LZ_pricePoint","");                

                Logger.info(LZ_CallDetailID, " Price Point : " + LZ_pricePoint, false);

                //LZ_pricePoint = LZ_pricePoint.substring(0, LZ_pricePoint.indexOf(".")) ;

//                LZ_CallFlowDetailXML = state.getString("LZ_CallFlowDetailXML");
                
                LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML","");                

                PricePointDAO pricePointDAO = new PricePointDAO();

                ArrayList pricePointlist = pricePointDAO.pricePoint(LZ_pricePoint, LZ_CallDetailID);

                Iterator pricePointlistItr = pricePointlist.iterator();

                while (pricePointlistItr.hasNext()) {

                    pricePointDAO = (PricePointDAO) pricePointlistItr.next();

                    LZ_NoOfBoxes = pricePointDAO.getBoxNo();

                    LZ_PackName = pricePointDAO.getProductCode();

                    LZ_PackName = "TSK";

                    LZ_HardwareAmount = pricePointDAO.getHardWareAmount();

                    LZ_ActivityFee = pricePointDAO.getActivationAmount();

                    LZ_BonusAmount = pricePointDAO.getBonusAmount();

                    LZ_PackageAmount = pricePointDAO.getInstallationAmount();

                    LZ_AccessoriesAmount = pricePointDAO.getAccessoriesAmount();

                    LZ_TotalAmount = String.valueOf(pricePointDAO.getTotalAmount());

                    LZ_TotalAmount = String.valueOf(Float.parseFloat(LZ_TotalAmount));
                }

            }
        } catch (Exception ex) {

            Logger.error(LZ_CallDetailID, " Exception in Price Point Page :  " + ex.getMessage(), false);

        } finally {

            LZ_pricePoint = LZ_CallDetailID = null;

        }


        JSONObject result = new JSONObject();

        result.put("LZ_NoOfBoxes", LZ_NoOfBoxes);

        result.put("LZ_PackName", LZ_PackName);

        result.put("LZ_HardwareAmount", LZ_HardwareAmount);

        result.put("LZ_ActivityFee", LZ_ActivityFee);

        result.put("LZ_BonusAmount", LZ_BonusAmount);

        result.put("LZ_PackageAmount", LZ_PackageAmount);

        result.put("LZ_AccessoriesAmount", LZ_AccessoriesAmount);

        result.put("LZ_TotalAmount", LZ_TotalAmount);

        result.put("CallFlowDetailXML", LZ_CallFlowDetailXML);

        Logger.info(LZ_CallDetailID, " No Of Boxes : " + LZ_NoOfBoxes + " Package Name : " + LZ_PackName
                + " Hardware Amount : " + LZ_HardwareAmount + " Activity Fee: " + LZ_ActivityFee
                + " Bonus Amount : " + LZ_BonusAmount + " Package Amount :" + LZ_PackageAmount
                + " Accessories Amount :" + LZ_AccessoriesAmount + " Total Amount : " + LZ_TotalAmount, false);

        return result;

    }

    ;
%>
<%-- GENERATED: DO NOT REMOVE --%> 
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONException"%>
<%@page import="java.util.Map"%>
<%@include file="../backend.jspf" %>