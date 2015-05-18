<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>

<%@page import="com.tsg.database.DBAccess"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.*"%>
<%@page import="com.tsg.util.Util"%>
<%@page import="com.tsg.common.*"%>
<%@page import="com.tsg.xml.GenerateXml"%>
<%@page import="com.tsg.database.gg.dataaccess.GetPkgExistFlag"%>
<%@page import="com.tsg.log.Logger"%>
<%
        // Input varibales
        String LZ_PackName = "";
        String LZ_DBCallDetailID = "";
        String LZ_CallFlowDetailXML = "";
        String LZ_SubscriberId = "";
        String[] arrResult = new String[2];
        String[] arrPackName = new String[5];
	 String result1 = "";
        

        // output varibales
        String LZ_PromoExistingFlag = "";

        try {

            // Realtime scenario
            
//            LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML", "");
//            Document docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);
//            LZ_PackName = state.optString("LZ_PromptList", "");
//            LZ_SubscriberId = XMLAO.getNodeValueText(docBA, "BA_SUBSCRIBER_ID");
//            LZ_DBCallDetailID = state.optString("LZ_DBCallDetailID", "");
            
            LZ_SubscriberId = request.getParameter("sub");
            LZ_PackName = request.getParameter("packName");
            LZ_DBCallDetailID = "12345678";

            Logger.info(LZ_DBCallDetailID, " RetrievePackageKnowmorePromoExist Page Input : Subscriber ID : " + LZ_SubscriberId + " Pack Name : " + LZ_PackName + " Subscriber Id Length : " + LZ_SubscriberId.length(), false);

            if (LZ_PackName.contains("p1_")) {

                LZ_PackName = LZ_PackName.replaceAll("p1_", "");
                
                LZ_PackName = LZ_PackName.replaceAll(".wav","");
                
                LZ_PackName = LZ_PackName.substring(0,LZ_PackName.length()-15);
                
                GetPkgExistFlag objGetPkgExistFlag = new GetPkgExistFlag();

                Logger.info(LZ_DBCallDetailID, " RetrievePackageKnowmorePromoExist Page : Packname : " + LZ_PackName + " Pack Name Length : " + LZ_PackName.length(), false);

                result1 = objGetPkgExistFlag.getPkgExistFlag(LZ_SubscriberId.trim(), LZ_PackName.trim(), LZ_DBCallDetailID);

                arrResult = result1.split("\\|\\|");

                LZ_PromoExistingFlag = arrResult[0];

                String tempPackName = arrResult[1];
                
                out.println("Promo Flag : " + LZ_PromoExistingFlag + " Pack Name : " + tempPackName);
                
//                if((tempPackName != null) || (!tempPackName.isEmpty()) || (tempPackName != "")) {
//                	
//                	tempPackName = "p1_" + tempPackName + ".wav";
//                	
//                }
//                Logger.info(LZ_DBCallDetailID, "RetrievePackageKnowmorePromoExist = LZ_PromoExistingFlag : " + LZ_PromoExistingFlag + "tempPackName : " + tempPackName, false);
//                LZ_PackName = tempPackName + ",9006.wav,7029.wav,7030.wav";
                
                
            } else {

            	LZ_PromoExistingFlag = "NOTPACK";

            }

        } catch (Exception ex) {

            Logger.error(LZ_DBCallDetailID, " Exception in RetrievePackageKnowmorePromoExist  :   " + ex.getMessage(), false);

        } finally {

            LZ_DBCallDetailID = null;

        }
        
%>
<%-- GENERATED: DO NOT REMOVE --%> 
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONException"%>
<%@page import="java.util.Map"%>
<%@page import="org.w3c.dom.Document"%>
<%@page import="Common.ActionObjects.*"%>
<%@include file="../backend.jspf" %>