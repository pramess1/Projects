/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tsg.database.gg.dataaccess;

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
public class GetAccountDetailDAO {

    private String accountBal;
    private String dueDate;
    private String renewDate;
    private String lastRechargeDateTime;
    private String lastRechargeAmount;
    private String suggestedRechargeAmount = "0";

    public GetAccountDetailDAO() {
    }

    public GetAccountDetailDAO(String accountBal, String dueDate, String renewDate, String lastRechargeDateTime, String lastRechargeAmount, String suggestedRechargeAmount) {

        this.accountBal = accountBal;

        this.dueDate = dueDate;

        this.renewDate = renewDate;

        this.lastRechargeDateTime = lastRechargeDateTime;

        this.lastRechargeAmount = lastRechargeAmount;

        this.suggestedRechargeAmount = suggestedRechargeAmount;

    }

    public String getAccountBal() {

        return accountBal;
    }

    public void setAccountBal(String accountBal) {

        this.accountBal = accountBal;
    }

    public String getDueDate() {

        return dueDate;
    }

    public void setDueDate(String dueDate) {

        this.dueDate = dueDate;
    }

    public String getRenewDate() {

        return renewDate;
    }

    public void setRenewDate(String renewDate) {

        this.renewDate = renewDate;
    }

    public String getLastRechargeDateTime() {

        return lastRechargeDateTime;
    }

    public void setLastRechargeDateTime(String lastRechargeDateTime) {

        this.lastRechargeDateTime = lastRechargeDateTime;
    }

    public String getLastRechargeAmount() {

        return lastRechargeAmount;
    }

    public void setLastRechargeAmount(String lastRechargeAmount) {

        this.lastRechargeAmount = lastRechargeAmount;
    }

    public String getSuggestedRechargeAmount() {

        return suggestedRechargeAmount;
    }

    public void setSuggestedRechargeAmount(String SuggestedRechargeAmount) {

        this.suggestedRechargeAmount = SuggestedRechargeAmount;
    }

    public ArrayList getAccountDetail(String subscriberId, String dbCallDetailId) {

        String dataCenter = ConfigurationReader.configList.get("DATACENTER");

        DBConnectionPool dbConPool = new DBConnectionPool();

        dbConPool.setPoolDataSource(dataCenter+"GGPRDB");

        Connection conn = null;

        CallableStatement callableStatement = null;

        ResultSet rs = null;

        ArrayList accountDetailList = new ArrayList();

        String strProc = "{call " + ConfigurationReader.configList.get("PROC_NAME_GET_ACCOUNT_DETAIL") + "(?,?,?,?,?,?)}";

        try {

            conn = dbConPool.getConnection(dbCallDetailId);

            callableStatement = conn.prepareCall(strProc);
            
            callableStatement.setPoolable(false);

            callableStatement.setString(1, subscriberId);

            callableStatement.registerOutParameter(2, OracleTypes.CURSOR);

            callableStatement.registerOutParameter(3, OracleTypes.CURSOR);

            callableStatement.registerOutParameter(4, OracleTypes.CURSOR);

            callableStatement.registerOutParameter(5, OracleTypes.CURSOR);

            callableStatement.registerOutParameter(6, OracleTypes.CURSOR);

            callableStatement.execute();

            rs = ((OracleCallableStatement) callableStatement).getCursor(2);

            while (rs.next()) {

                lastRechargeAmount = rs.getString(1);

                lastRechargeDateTime = rs.getString(2);
            }

            rs = ((OracleCallableStatement) callableStatement).getCursor(3);

            while (rs.next()) {

                accountBal = rs.getString(1);

                dueDate = rs.getString(2);
            }

            rs = ((OracleCallableStatement) callableStatement).getCursor(4);

            while (rs.next()) {

                suggestedRechargeAmount = rs.getString(1);
            }

            rs = ((OracleCallableStatement) callableStatement).getCursor(5);

            while (rs.next()) {

                renewDate = rs.getString(2);
            }

            GetAccountDetailDAO getAccountDetailObj = new GetAccountDetailDAO(accountBal, dueDate, renewDate, lastRechargeDateTime, lastRechargeAmount, suggestedRechargeAmount);

            accountDetailList.add(getAccountDetailObj);

        } catch (SQLException sqlEx) {

            Logger.error(dbCallDetailId, " SQL Exception in Account Detail Page : " + sqlEx.getMessage(), false);

        } catch (Exception ex) {

            Logger.error(dbCallDetailId, " Exception in Account Detail Page : " + ex.getMessage(), false);

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

                Logger.error(dbCallDetailId, " Exception in Account Detail finally block : " + subscriberId + " Message : " + sqlEx.getMessage(), false);
            }

            dbConPool.releaseConnection(dbCallDetailId);
        }

        Logger.info(dbCallDetailId, " Account Detail for the subscriberId : " + subscriberId + " Account Bal : " + accountBal + " Due Date : " + dueDate + " Renew Date : " + renewDate + " Last Recharge Date Time : " + lastRechargeDateTime
                + " Last Recharge Amount : " + lastRechargeAmount + " Suggested Recharge Amount : " + suggestedRechargeAmount, true);

        subscriberId = dbCallDetailId = accountBal = dueDate = renewDate = lastRechargeDateTime = lastRechargeAmount = suggestedRechargeAmount = dataCenter = null;

        return accountDetailList;
    }
}

