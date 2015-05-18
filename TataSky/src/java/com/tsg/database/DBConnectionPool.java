/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tsg.database;

import com.tsg.common.ConfigurationReader;
import com.tsg.log.Logger;
import java.sql.Connection;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import oracle.ucp.jdbc.PoolDataSource;

/**
 *
 * @author Rajesh
 */
public class DBConnectionPool {

    private DataSource dataSource;
    private PoolDataSource poolDataSource;
    //private static int connectionCounter;
    private Connection dbConnection = null;
    private static Context initCtx;
    private int connectTimes = 1;

    public void setPoolDataSource(String strDBReference) {

        //connectTimes = 1;

        try {

            if (initCtx == null) {

                initCtx = new InitialContext();
            }

            this.poolDataSource = (PoolDataSource) initCtx.lookup("java:/comp/env/" + strDBReference);

            this.poolDataSource.setInitialPoolSize(Integer.parseInt(ConfigurationReader.configList.get("SETMINPOOLSIZE")));

            this.poolDataSource.setMinPoolSize(Integer.parseInt(ConfigurationReader.configList.get("SETMINPOOLSIZE")));

            this.poolDataSource.setMaxPoolSize(Integer.parseInt(ConfigurationReader.configList.get("SETMAXPOOLSIZE")));

            //this.poolDataSource.setConnectionWaitTimeout(Integer.parseInt(ConfigurationReader.configList.get("DB_CONNECTION_TIME_OUT")));

            //this.poolDataSource.setInactiveConnectionTimeout(Integer.parseInt(ConfigurationReader.configList.get("DB_CONNECTION_TIME_OUT")));

        } catch (NamingException ex) {

            Logger.error("", "Error in Connection :" + ex.getMessage(), false);

        } catch (Exception exp) {

            Logger.error("", "Error in Connection :" + exp.getMessage(), false);
        }

    }

    public DataSource getPoolDataSource() {

        return this.poolDataSource;
    }

    public DataSource getDataSource() {

        return this.dataSource;
    }

    public synchronized Connection getConnection(String dbCallDetailId) {

        Logger.debug(dbCallDetailId, "Getting DB Connection " + this.poolDataSource.getConnectionPoolName(), false);

        try {

            if (this.dbConnection == null || this.dbConnection.isClosed()) {

                dbConnection = poolDataSource.getConnection();

                dbConnection.isValid(1);

                Logger.debug(dbCallDetailId, "Created Database Connection Count : " + poolDataSource.getAvailableConnectionsCount(), false);

                //connectionCounter++;

            } else {

                Logger.debug(dbCallDetailId, "Did not create connection", false);
            }

            //Logger.debug(dbCallDetailId, "Connection count : " + connectionCounter, false);

        } catch (Exception exp) {

            Logger.error(dbCallDetailId, "Exception in creating " + this.poolDataSource.getConnectionPoolName() + " DB Connection : " + connectTimes + " time(s): " + exp.getMessage(), false);

            try {

                int dbConnectTimes = Integer.parseInt(ConfigurationReader.configList.get("DB_CONNECT_TIMES"));

                if (connectTimes == dbConnectTimes) {

                    connectTimes = 1;

                    return dbConnection;

                } else {

                    connectTimes++;
                    // BLR IVR DB CONFIG 
                    if (this.poolDataSource.getConnectionPoolName().equalsIgnoreCase("BLRIVRPRDB")) {
                        setPoolDataSource("BLRIVRSEDB");
                    } else if (this.poolDataSource.getConnectionPoolName().equalsIgnoreCase("BLRIVRSEDB")) {
                        setPoolDataSource("BLRIVRPRDB");
                        // PUN IVR DB CONFIG      
                    } else if (this.poolDataSource.getConnectionPoolName().equalsIgnoreCase("PUNIVRPRDB")) {
                        setPoolDataSource("PUNIVRSEDB");
                    } else if (this.poolDataSource.getConnectionPoolName().equalsIgnoreCase("PUNIVRSEDB")) {
                        setPoolDataSource("PUNIVRPRDB");
                        // BLR GG DB CONFIG
                    } else if (this.poolDataSource.getConnectionPoolName().equalsIgnoreCase("BLRGGPRDB")) {
                        setPoolDataSource("BLRGGSEDB");
                    } else if (this.poolDataSource.getConnectionPoolName().equalsIgnoreCase("BLRGGSEDB")) {
                        setPoolDataSource("BLRGGPRDB");
                        // PUN GG DB CONFIG    
                    } else if (this.poolDataSource.getConnectionPoolName().equalsIgnoreCase("PUNGGPRDB")) {
                        setPoolDataSource("PUNGGSEDB");
                    } else if (this.poolDataSource.getConnectionPoolName().equalsIgnoreCase("PUNGGSEDB")) {
                        setPoolDataSource("PUNGGPRDB");
                    } 
                    getConnection(dbCallDetailId);
                }

            } catch (Exception ex) {

                System.out.println("Exception : " + ex.getMessage());
            }

        }
        return dbConnection;
    }

    public void releaseConnection(String dbCallDetailId) {

        try {

            if (dbConnection != null && !dbConnection.isClosed()) {

                dbConnection.close();

//                connectionCounter--;

                Logger.debug(dbCallDetailId, "Closed DB Connection", false);

            } else {

                Logger.debug(dbCallDetailId, "Already Closed DB Connection", false);

                //               connectionCounter--;
            }

        } catch (SQLException sqlEx) {

            Logger.error(dbCallDetailId, "Exception closing DB Connection: " + sqlEx.getMessage(), false);
        }

    }
}
//package com.tsg.database;
//
//import com.tsg.common.ConfigurationReader;
//
//import com.tsg.log.Logger;
//
//import java.sql.Connection;
//
//import java.sql.SQLException;
//
//import javax.naming.Context;
//
//import javax.naming.InitialContext;
//
//import javax.naming.NamingException;
//
//import javax.sql.DataSource;
//
//import oracle.ucp.jdbc.PoolDataSource;
//
//public class DBConnectionPool {
//
//    public DataSource dataSource;
//    
//    public PoolDataSource poolDataSource;
//    
//    private static int connectionCounter;
//    
//    public Connection dbConnection = null;
//    
//    public static Context initCtx;
//
//    public void setPoolDataSource(String strDBReference) {
//
//        try {
//
//            if (initCtx == null) {
//
//                initCtx = new InitialContext();
//
//            }
//
//            this.poolDataSource = (PoolDataSource) initCtx.lookup("java:/comp/env/" + strDBReference);
//
//            this.poolDataSource.setInitialPoolSize(Integer.parseInt(ConfigurationReader.configList.get("SETMINPOOLSIZE")));
//
//            this.poolDataSource.setMinPoolSize(Integer.parseInt(ConfigurationReader.configList.get("SETMINPOOLSIZE")));
//
//            this.poolDataSource.setMaxPoolSize(Integer.parseInt(ConfigurationReader.configList.get("SETMAXPOOLSIZE")));
//
//        } catch (NamingException ex) {
//
//            Logger.error("Set PoolData Source", "Error in Connection :" + ex.getMessage(), false);
//
//        } catch (Exception exp) {
//
//            Logger.error("Set PoolData Source", "Error in Connection :" + exp.getMessage(), false);
//        }
//
//    }
//
//    public DataSource getPoolDataSource() {
//
//        return this.poolDataSource;
//
//    }
//
//    public DataSource getDataSource() {
//
//        return this.dataSource;
//
//    }
//
//    public synchronized Connection getConnection() {
//
//        try {
//
//            if (this.dbConnection == null || this.dbConnection.isClosed()) {
//
//                dbConnection = poolDataSource.getConnection();
//
//                dbConnection.isValid(1);
//
//                Logger.debug("Get DB Connection", "Getting DB Connection count : " + poolDataSource.getAvailableConnectionsCount(), false);
//
//                connectionCounter++;
//
//            } else {
//
//                Logger.debug("Get Connection", "Did not create connection", false);
//
//            }
//
//        } catch (Exception exp) {
//
//            Logger.error("Get Connection", "Exception in creating DB Connection: " + exp.getMessage(), false);
//
//            getConnection();
//        }
//
//        return dbConnection;
//    }
//
//    public void releaseConnection() {
//
//        try {
//
//            if (dbConnection != null && !dbConnection.isClosed()) {
//
//                dbConnection.close();
//
//                connectionCounter--;
//
//                Logger.debug("Get DB Connection", " Release the DB Connection ", false);
//
//            }
//
//        } catch (SQLException e) {
//
//            Logger.error("Release Connection ", "Exception closing DB Connection: " + e.getMessage(), false);
//
//        }
//    }
//}
