/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tsg.database.ivr.dataaccess;

import com.tsg.common.ConfigurationReader;
import com.tsg.database.DBConnectionPool;

import com.tsg.log.Logger;

import java.sql.CallableStatement;

import java.sql.Connection;

import java.sql.ResultSet;

import java.sql.SQLException;

import java.util.ArrayList;

import oracle.jdbc.OracleCallableStatement;

import oracle.jdbc.OracleTypes;

/**
 *
 * @author Rajesh
 */
public class BankIdDAO {

    private String bankEmiDetails;
    private String bankFlage;

    public String getBankEmiDetails() {
        
        return bankEmiDetails;
    }

    public void setBankEmiDetails(String bankEmiDetails) {
        
        this.bankEmiDetails = bankEmiDetails;
    }

    public String getBankFlage() {
        
        return bankFlage;
    }

    public void setBankFlage(String bankFlage) {
        
        this.bankFlage = bankFlage;
    }

    public BankIdDAO() {
        
    }

    public BankIdDAO(String bankFlage, String bankEmiDetails) {

        this.bankFlage = bankFlage;
        
        this.bankEmiDetails = bankEmiDetails;

    }

    public ArrayList bankIdValidation(String bankId, String dbCallDetailId) {

        String dataCenter = ConfigurationReader.configList.get("DATACENTER");
        
        DBConnectionPool dbConPool = new DBConnectionPool();

        dbConPool.setPoolDataSource(dataCenter + "IVRPRDB");

        Connection conn = null;

        CallableStatement callableStatement = null;

        String bankFlage1 = "N";

        ArrayList bankIdValidationList = new ArrayList();

        ResultSet rs = null;

        String strProc = "{call " + ConfigurationReader.configList.get("PROC_NAME_BANK_ID") + "(?,?,?)}";

        try {

            conn = dbConPool.getConnection(dbCallDetailId);

            callableStatement = conn.prepareCall(strProc);

            callableStatement.setString(1, bankId);

            callableStatement.registerOutParameter(2, java.sql.Types.VARCHAR);

            callableStatement.registerOutParameter(3, OracleTypes.CURSOR);

            callableStatement.execute();

            bankFlage1 = callableStatement.getString(2).toString();

            if (bankFlage1.equalsIgnoreCase("Y")) {

                rs = ((OracleCallableStatement) callableStatement).getCursor(3);

                while (rs.next()) {

                    bankEmiDetails = rs.getString(1);
                }

                rs.close();

            } else {

                bankEmiDetails = "Invalid Bank Id";
            }

            callableStatement.close();

            BankIdDAO bankIdDAOobj = new BankIdDAO(bankFlage1, bankEmiDetails);

            bankIdValidationList.add(bankIdDAOobj);

        } catch (Exception ex) {

            Logger.error(dbCallDetailId, " Exception in Bank Id Validation Page Bank Id : " + bankId + " Message : " + ex.getMessage(), false);

        } finally {
            
            try {
                
                if (callableStatement != null) {
                    
                    callableStatement.close();
                    
                    callableStatement = null;
                }
                
                if (rs != null) {
                    
                    rs.close();
                    
                    rs = null;
                }
                
                if (conn != null) {
                    
                    conn.close();
                    
                    conn = null;
                }
                
            } catch (SQLException sqlEx) {
                
                Logger.error(dbCallDetailId, " Exception in Detail By Subscriber Id finally block Bank Id: " + bankId + " Message : " + sqlEx.getMessage(), false);
            }

            dbConPool.releaseConnection(dbCallDetailId);
        }

        Logger.info(dbCallDetailId, "Bank Id : " + bankId + " Flage : " + bankFlage1 + " Emi Details : " + bankEmiDetails, false);

        bankId = dataCenter = bankFlage1 = bankEmiDetails = null;

        return bankIdValidationList;
    }
}