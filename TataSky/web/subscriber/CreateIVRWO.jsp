<%@page import="com.tsg.common.ConfigurationReader"%>
<%@page import="com.tsg.database.gg.dataaccess.GetIVRWOFlagDAO"%>
<%@page import="com.tsg.wo.*"%>
<%@page import="java.text.DateFormat"%>
<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>

<%@page import="Common.ActionObjects.XMLAO"%>
<%@page import="org.w3c.dom.Document"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.*"%>
<%@page import="com.tsg.util.Util"%>
<%@page import="com.tsg.xml.GenerateXml"%>
<%@page import="com.tsg.database.gg.dataaccess.GetWorkOrderDetailsDAO"%>
<%@page import="com.tsg.log.Logger"%>

<%@page import="java.sql.CallableStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="oracle.jdbc.OracleCallableStatement"%>
<%@page import="oracle.jdbc.OracleTypes"%>
<%!
    public JSONObject performLogic(JSONObject state, Map<String, String> additionalParams) throws Exception {

        String LZ_DynamicCallFlowXML = "";
        String LZ_DBCallDetailID = "";
        String LZ_CallFlowDetailXML = "";
        String LZ_SubscriberID = "";
        String LZ_CLI = "";
        String LZ_NO_IVR_WO_FLAG = "";
        String BA_NO_IVR_WO_FLAG = "N";
        String LZ_MenuSelectedCFID = "";
        String LZ_WOTrasactionXML = "";
        int LZ_NoOfDays = 30;

        Connection connection = null;
        String userName = null;
        String password = null;
        String connectionUrl = null;
        connectionUrl = "jdbc:oracle:thin:@ban-ent-scan.cct.tatasky.com:1521:pentban1";
        userName = "ggdbuser";
        password = "ggdbuser";


        try {
            LZ_DBCallDetailID = state.optString("LZ_DBCallDetailID", "");
            LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML", "");
            LZ_MenuSelectedCFID = state.optString("LZ_MenuSelectedID", "");

            Logger.info(LZ_DBCallDetailID, "  CreateIVRWO.jsp Input LZ_CallFlowDetailXML : " + LZ_CallFlowDetailXML, false);

            Document docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);
            LZ_SubscriberID = XMLAO.getNodeValueText(docBA, "BA_SUBSCRIBER_ID");
            LZ_CLI = XMLAO.getNodeValueText(docBA, "BA_RMN");

            try {
                Class.forName("oracle.jdbc.OracleDriver");
                connection = DriverManager.getConnection(connectionUrl, userName, password);
            } catch (Exception e) {
                Logger.error(LZ_DBCallDetailID, " CreateIVRWO.jsp Exception : " + e.getMessage(), false);
            }
            CallableStatement callableStatement = null;
            ResultSet rs = null;

            String strProc = "{call " + ConfigurationReader.configList.get("PROC_NAME_GET_IVR_WOFLAG") + "(?,?,?)}";

            try {                

                callableStatement = connection.prepareCall(strProc);

                callableStatement.setPoolable(false);

                callableStatement.setString(1, LZ_SubscriberID);

                callableStatement.setInt(2, LZ_NoOfDays);

                callableStatement.registerOutParameter(3, java.sql.Types.VARCHAR);

                callableStatement.execute();

                BA_NO_IVR_WO_FLAG = callableStatement.getString(3).toString();

            } catch (SQLException sqlEx) {

                Logger.error(LZ_DBCallDetailID, " SQL Exception in IVRWO Flage Page : " + sqlEx.getMessage(), false);

            } catch (Exception ex) {

                Logger.error(LZ_DBCallDetailID, " Exception in IVRWO Flage Page : " + ex.getMessage(), false);

            }finally {
            try {
                if (callableStatement != null) {
                    callableStatement.close();
                    callableStatement = null;
                }
                if (rs != null) {
                    rs.close();
                    rs = null;
                }
                if (connection != null) {
                    connection.close();
                    connection = null;
                }
            } catch (SQLException sqlEx) {
                Logger.error(LZ_DBCallDetailID, "CreateIVRWO.jsp Exception in finally block : " + LZ_SubscriberID + " Message : " + sqlEx.getMessage(), false);
            }
        }

            //GetIVRWOFlagDAO ivrWOFlagObj = new GetIVRWOFlagDAO();

            //  BA_NO_IVR_WO_FLAG = ivrWOFlagObj.ivrWOFlage(LZ_SubscriberID, LZ_NoOfDays, LZ_DBCallDetailID);

            Logger.info(LZ_DBCallDetailID, "BA_NO_IVR_WO_FLAG from DB in CreateIVRWO page : " + BA_NO_IVR_WO_FLAG, false);

            if (BA_NO_IVR_WO_FLAG.equalsIgnoreCase("N")) {

                LZ_DynamicCallFlowXML = "<CallFlow CDID=\"" + LZ_DBCallDetailID + "\" RuleID=\"\" ><Menu CFID=\"818\">9100.wav</Menu><Menu CFID=\"818\">7220.wav</Menu><Menu CFID=\"904\">2313.wav</Menu><Menu CFID=\"910\">7030.wav</Menu></CallFlow>";
                LZ_NO_IVR_WO_FLAG = "N";

            }
            if (LZ_MenuSelectedCFID.equalsIgnoreCase("818") || LZ_MenuSelectedCFID.equalsIgnoreCase("50")) {


                try {
                    com.tsg.wo.WOCreationWs_Service service = new com.tsg.wo.WOCreationWs_Service();
                    com.tsg.wo.WOCreationWs port = service.getWOCreationWsPort();
                    LZ_WOTrasactionXML = port.woWebService(LZ_DBCallDetailID, LZ_SubscriberID, "IVR");

                    Logger.info(LZ_DBCallDetailID, "WO Transaction XML : " + LZ_WOTrasactionXML, false);

                    Logger.info(LZ_DBCallDetailID, "  before CallFlowDetailXML  : " + LZ_CallFlowDetailXML, false);


                    if (LZ_CallFlowDetailXML.contains("<TBLTRANSACTIONDETAIL>")) {


                        LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</TBLTRANSACTIONDETAIL>", "</TBLTRANSACTIONDETAIL>" + LZ_WOTrasactionXML);

                        Logger.info(LZ_DBCallDetailID, " inside if : ", false);


                    } else {

                        LZ_CallFlowDetailXML = LZ_CallFlowDetailXML.replace("</TRANSACTIONROOT>", LZ_WOTrasactionXML + "</TRANSACTIONROOT>");

                        Logger.info(LZ_DBCallDetailID, " inside else : ", false);

                    }

                    Logger.info(LZ_DBCallDetailID, "  afetr CallFlowDetailXML  : " + LZ_CallFlowDetailXML, false);

                    Document docBA1 = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);

                } catch (Exception ex) {
                    Logger.error(LZ_DBCallDetailID, "Exception in calling web service: " + ex.getMessage(), false);
                }



            }

        } catch (Exception ex) {

            Logger.error(LZ_DBCallDetailID, " Exception in CreateIVRWO page :   " + ex.getMessage(), false);

        } finally {


            Logger.info(LZ_DBCallDetailID, " LZ_NO_IVR_WO_FLAG From CreateIVRWO.jsp : " + LZ_NO_IVR_WO_FLAG, false);

            LZ_DBCallDetailID = null;

        }

        JSONObject result = new JSONObject();

        result.put("LZ_NO_IVR_WO_FLAG", LZ_NO_IVR_WO_FLAG);
        result.put("LZ_DynamicCallFlowXML", LZ_DynamicCallFlowXML);
        result.put("LZ_CallFlowDetailXML", LZ_CallFlowDetailXML);

        return result;
    }

    ;

%>
<%-- GENERATED: DO NOT REMOVE --%> 
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONException"%>
<%@page import="java.util.Map"%>
<%@include file="../backend.jspf" %>    