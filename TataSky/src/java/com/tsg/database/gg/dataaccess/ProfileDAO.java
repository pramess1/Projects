///*
// * To change this template, choose Tools | Templates
// * and open the template in the editor.
// */
//package com.tsg.database.gg.dataaccess;
//
//import com.tsg.database.DBConnectionPool;
//import com.tsg.database.gg.data.Profile;
//import com.tsg.log.Logger;
//import java.sql.CallableStatement;
//import java.sql.Connection;
//import java.sql.Timestamp;
//import java.util.Date;
//
//
///**
// *
// * @author Developer not using
// */
//public class ProfileDAO {
//
//   
//    public Profile getProfile(String strCli) {
//        //CallDetail objCallDetail = new CallDetail();
//        Profile profileData = new Profile();
//        DBConnectionPool dbConPool = new DBConnectionPool();
//        dbConPool.setPoolDataSource("GGDB");
//        Connection conn = null;
//        CallableStatement callableStatement = null;
//
//        String strProc = "{call USP_GETPROFILETEST(?,?,?,?)}";
//        //ResultSet objRS = new ResultSet();
//        Timestamp ts = new Timestamp(new Date().getTime());
//
//        // Get a connection object
//
//        try {
//            conn = dbConPool.getConnection("");
//            callableStatement = conn.prepareCall(strProc);
//            callableStatement.setString(1, strCli);
//            callableStatement.registerOutParameter(2, java.sql.Types.VARCHAR);
//            callableStatement.registerOutParameter(3, java.sql.Types.VARCHAR);
//            callableStatement.registerOutParameter(4, java.sql.Types.VARCHAR);
//            callableStatement.executeUpdate();
//            //objCallDetail.setFldcalldetailid(callableStatement.getBigDecimal(iCallDetailID)) ;
//            profileData.setStrCallerType(callableStatement.getString(2));
//            profileData.setStrPreferredLangPrimary(callableStatement.getString(3));
//            profileData.setStrPreferredLangSecondary(callableStatement.getString(4));
//            //log.info("Profile CallerType=" + profileData.getStrCallerType());
//            dbConPool.releaseConnection("");
//
//            return profileData;
//
//        } catch (Exception ex) {
//
//            Logger.error("Profile ", " Exception in Profile Page : " + ex.getMessage(), false);
//            return null;
//        }
//
//    }
//}
