<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>
<%@page import="com.tsg.database.DBAccess"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.*"%>
<%@page import="com.tsg.util.Util"%>
<%@page import="com.tsg.common.*"%>
<%@page import="com.tsg.xml.GenerateXml"%>
<%@page import="com.tsg.database.gg.dataaccess.GetPkgExistFlag"%>
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
        // Input varibales
        String LZ_PackName = "";
        String LZ_DBCallDetailID = "";
        String LZ_CallFlowDetailXML = "";
        String LZ_SubscriberId = "";
        String[] arrResult = new String[2];
        String[] arrPackName = new String[5];
	 String result1 = "";
        
        Connection connection = null;
	 String userName = null;
        String password = null;
        String connectionUrl = null;
	 connectionUrl = "jdbc:oracle:thin:@pun-ent-scan.cct.tatasky.com:1521/PENTPUN";
        userName = "ggdbuser";
        password = "ggdbuser";


        // output varibales
        String LZ_PromoExistingFlag = "";

        try {

            // Realtime scenario
            
            LZ_CallFlowDetailXML = state.optString("LZ_CallFlowDetailXML", "");
            Document docBA = XMLAO.buildXMLDocument(LZ_CallFlowDetailXML);
            LZ_PackName = state.optString("LZ_PromptList", "");
            LZ_SubscriberId = XMLAO.getNodeValueText(docBA, "BA_SUBSCRIBER_ID");
            LZ_DBCallDetailID = state.optString("LZ_DBCallDetailID", "");

            

            if (LZ_PackName.contains("p1_")) {

 
                LZ_PackName = LZ_PackName.replaceAll("p1_", "");
                
                LZ_PackName = LZ_PackName.replaceAll(".wav","");
                
                LZ_PackName = LZ_PackName.substring(0,LZ_PackName.length()-15);

		Logger.info(LZ_DBCallDetailID, " RetrievePackageKnowmorePromoExist Page Input : Subscriber ID : " + LZ_SubscriberId + " Pack Name : " + LZ_PackName + " Subscriber Id Length : " + LZ_SubscriberId.length(), false);
                
		String dbCallDetailId = LZ_DBCallDetailID;
	     	String subscriberId = LZ_SubscriberId;
		String packageName = LZ_PackName;
               try {
	            Class.forName("oracle.jdbc.OracleDriver");
       	     connection = DriverManager.getConnection(connectionUrl, userName, password);
            	} catch(Exception e) {
              	  Logger.error(dbCallDetailId, " RetrievePackageKnowmorePromoExist Exception : " + e.getMessage(), false);
            	}
        CallableStatement callableStatement = null;
        ResultSet rs = null;
	 int count = 5;
        String existFlag = "";
        String dbPackName = "";
        String strProc = "{call " + ConfigurationReader.configList.get("PROC_NAME_GET_PKG_EXIST_FLAG") + "(?,?,?,?)}";
                
	try {
            callableStatement = connection.prepareCall(strProc);
            callableStatement.setString(1, subscriberId.trim());
            callableStatement.setString(2, packageName.trim());
            callableStatement.registerOutParameter(3, java.sql.Types.VARCHAR);
            callableStatement.registerOutParameter(4, OracleTypes.CURSOR);
            callableStatement.execute();
            existFlag = callableStatement.getString(3).toString();
            Logger.error(dbCallDetailId, "RetrievePackageKnowmorePromoExist Exist Flag : " + existFlag + " Subscriber ID : " + LZ_SubscriberId, false);
            rs = ((OracleCallableStatement) callableStatement).getCursor(4);
            while (rs.next()) {
                dbPackName = rs.getString(1);
            }
            Logger.error(dbCallDetailId, "RetrievePackageKnowmorePromoExist  Pack Name : " + dbPackName, false);
        } catch (Exception ex) {
            Logger.error(dbCallDetailId, " RetrievePackageKnowmorePromoExist Exception in Package Exist Flag Page subscriberId : " + subscriberId + " Message : " + ex.getMessage(), false);
        }
	finally {
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
                Logger.error(dbCallDetailId, "RetrievePackageKnowmorePromoExist Exception in Package Exist Flag finally block : " + subscriberId + " Message : " + sqlEx.getMessage(), false);
            }
        }
   
                LZ_PromoExistingFlag = existFlag;
                String tempPackName = dbPackName;
                if((tempPackName != null) || (!tempPackName.isEmpty()) || (tempPackName != "")) {
                	
                	tempPackName = "p1_" + tempPackName + ".wav";
                	
                }
                Logger.info(LZ_DBCallDetailID, "RetrievePackageKnowmorePromoExist = LZ_PromoExistingFlag : " + LZ_PromoExistingFlag + "tempPackName : " + tempPackName, false);
                LZ_PackName = tempPackName + ",9006.wav,7029.wav,7030.wav";
                
                
            } else {

            	LZ_PromoExistingFlag = "NOTPACK";

            }

        } catch (Exception ex) {

            Logger.error(LZ_DBCallDetailID, " Exception in RetrievePackageKnowmorePromoExist  :   " + ex.getMessage(), false);

        } finally {

            LZ_DBCallDetailID = null;

        }
        JSONObject result = new JSONObject();

        result.put("LZ_PromoExistingFlag", LZ_PromoExistingFlag);
        result.put("LZ_PromptList", LZ_PackName);
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