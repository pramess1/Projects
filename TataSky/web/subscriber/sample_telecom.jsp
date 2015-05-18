<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>

<%@page import="java.sql.SQLException"%>
<%@page import="oracle.jdbc.OracleCallableStatement"%>
<%@page import="oracle.jdbc.OracleTypes"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.tsg.database.DBConnectionPool"%>
<%@page import="com.tsg.common.ConfigurationReader"%>
<%@page import="com.tsg.log.Logger"%>
<%@page import="com.tsg.database.ivr.dataaccess.GetLangTelecomCircleDAO"%>
<%


//public void getLangCodeAndTelecomCircle() {
    
        String telecomCircle = null, 
                langCode = null,
                dbCallDetailId = "21",
                callerType = "Prospect",
                state = "TamilNadu";
        
        int DNIS = 7777;

        
        String dataCenter = ConfigurationReader.configList.get("DATACENTER");     
	
	 System.out.println("DataCenter : " + dataCenter);

        DBConnectionPool dbConPool = new DBConnectionPool();

        dbConPool.setPoolDataSource(dataCenter + "IVRPRDB");

	 System.out.println("set " + dataCenter + "IVRPRDB as PoolDataSource");

        Connection conn = null;
        
        ResultSet rs = null;

        CallableStatement callableStatement = null;

        ArrayList telecomList = new ArrayList();

        String strProc = "{call USP_GET_LANG_TELCOMCIRCLE_1(?,?,?,?)}";

        String isProspect = null;       
          
        String temp = null;

        if (callerType.equalsIgnoreCase("Prospect")) {

            isProspect = "S";
            
            temp = state ;             

             }else {
        
            isProspect = "D";
           
            temp =  String.valueOf(DNIS);
         }
        
        Logger.info(dbCallDetailId, " Input for Stored Procedure isProspect : "+isProspect+" State / DNIS : "+temp, false);

        try {

            conn = dbConPool.getConnection(dbCallDetailId);

            callableStatement = conn.prepareCall(strProc);
            
            Logger.info(dbCallDetailId, " callableStatement : "+callableStatement.toString(), true);

            callableStatement.setString(1, isProspect.trim());

            callableStatement.setString(2, temp.trim());       

//             callableStatement.registerOutParameter(1, OracleTypes.CURSOR); //REF CURSOR

            callableStatement.registerOutParameter(3, java.sql.Types.VARCHAR);

             callableStatement.registerOutParameter(4, java.sql.Types.VARCHAR);
            
            Logger.info( "","----------1--------", false);

            callableStatement.executeUpdate();

            Logger.info( "","----------2--------", false);

	     telecomCircle = callableStatement.getString(1);

      	     langCode = callableStatement.getString(2);
            
//             rs = ((OracleCallableStatement) callableStatement).getCursor(3);
             
//              while (rs.next()) {
              
//                telecomCircle = rs.getString("TELECOMCIRCLE");

//                langCode = rs.getString("LANGCODE");
                            
//              }
           
            Logger.info(dbCallDetailId, "OutPut telecomCircle : "+telecomCircle+" langCode : "+langCode, true);  
              
            GetLangTelecomCircleDAO getTelecomCircleObj = new GetLangTelecomCircleDAO(telecomCircle, langCode);

            telecomList.add(getTelecomCircleObj);
            
            Logger.info(dbCallDetailId, "OutPut telecomCircle : "+telecomCircle+" langCode : "+langCode, true);

        } catch (SQLException sqlEx) {

            Logger.error(dbCallDetailId, " SQL Exception in Get LangCode And TelecomCircle XML Page TelecomCircle : " + telecomCircle + " LangCode is : " + langCode + " Message : " + sqlEx.getMessage(), false);

        } finally {

            try {

                if (callableStatement != null) {

                    callableStatement.close();

                    callableStatement = null;
                }

                if (conn != null) {

                    conn.close();

                    conn = null;
                }

            } catch (SQLException sqlEx) {

                Logger.error(dbCallDetailId, " SQL Exception in Get LangCode And TelecomCircle XML Page TelecomCircle: " + telecomCircle + " LangCode is : " + langCode + " Message : " + sqlEx.getMessage(), false);
            }

            dbConPool.releaseConnection(dbCallDetailId);
        }

        //return telecomList;

//           }
%>