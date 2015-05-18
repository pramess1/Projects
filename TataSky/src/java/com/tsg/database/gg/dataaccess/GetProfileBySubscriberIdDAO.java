/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tsg.database.gg.dataaccess;

import com.tsg.common.ConfigurationReader;
import com.tsg.database.DBConnectionPool;

import com.tsg.log.Logger;
import com.tsg.util.Util;

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
public class GetProfileBySubscriberIdDAO {

    private String primaryLanguage;
    private String secondaryLanguage;
    private String premiumFlag;
    private String accountStatus;
    private String subscriberId;
    private String subscriptionSubStatus;
    private String premiumFlag1;
    private String subscriptionType = "";
    private String firstName = "";
    private String lastName = "";
    private String activationDate = "";
    private String actualCustomerClass = "";
    private String differenceInDays = "";
    private String isSensitive = "";

    public String getIsSensitive() {
        return isSensitive;
    }

    public void setIsSensitive(String isSensitive) {
        this.isSensitive = isSensitive;
    }
    
    public String getDifferenceInDays() {
        return differenceInDays;
    }

    public void setDifferenceInDays(String differenceInDays) {
        this.differenceInDays = differenceInDays;
    }

    public String getActivationDate() {
        return activationDate;
    }

    public void setActivationDate(String activationDate) {
        this.activationDate = activationDate;
    }

    public String getActualCustomerClass() {
        return actualCustomerClass;
    }

    public void setActualCustomerClass(String actualCustomerClass) {
        this.actualCustomerClass = actualCustomerClass;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getLastName() {
        return lastName;
    }

    public String getSubscriptionType() {
        return subscriptionType;
    }

    public void setSubscriptionType(String subscriptionType) {
        this.subscriptionType = subscriptionType;
    }

    public String getPremiumFlag1() {
        return premiumFlag1;
    }

    public void setPremiumFlag1(String premiumFlag1) {
        this.premiumFlag1 = premiumFlag1;
    }

    public String getPrimaryLanguage() {

        return primaryLanguage;
    }

    public void setPrimaryLanguage(String primaryLanguage) {

        this.primaryLanguage = primaryLanguage;
    }

    public String getSecondaryLanguage() {

        return secondaryLanguage;
    }

    public void setSecondaryLanguage(String secondaryLanguage) {

        this.secondaryLanguage = secondaryLanguage;
    }

    public String getPremiumFlag() {

        return premiumFlag;
    }

    public void setPremiumFlag(String premiumFlag) {

        this.premiumFlag = premiumFlag;
    }

    public String getAccountStatus() {

        return accountStatus;
    }

    public void setAccountStatus(String accountStatus) {

        this.accountStatus = accountStatus;
    }

    public String getSubscriberId() {

        return subscriberId;
    }

    public void setSubscriberId(String subscriberId) {

        this.subscriberId = subscriberId;
    }

    public String getSubscriptionSubStatus() {

        return subscriptionSubStatus;
    }

    public void setSubscriptionSubStatus(String subscriptionSubStatus) {

        this.subscriptionSubStatus = subscriptionSubStatus;
    }

    public GetProfileBySubscriberIdDAO() {
    }

    public GetProfileBySubscriberIdDAO(String primaryLanguage, String secondaryLanguage, String premiumFlag,
            String accountStatus, String subscriberId, String subscriptionSubStatus, String premiumFlag1,
            String subscriptionType, String firstName, String lastName, String activationDate, String differenceInDays,
            String actualCustomerClass, String isSensitive) {

        this.primaryLanguage = primaryLanguage;

        this.secondaryLanguage = secondaryLanguage;

        this.premiumFlag = premiumFlag;

        this.accountStatus = accountStatus;

        this.subscriberId = subscriberId;

        this.subscriptionSubStatus = subscriptionSubStatus;

        this.premiumFlag1 = premiumFlag1;

        this.subscriptionType = subscriptionType;

        this.firstName = firstName;

        this.lastName = lastName;

        this.differenceInDays = differenceInDays;

        this.activationDate = activationDate;

        this.actualCustomerClass = actualCustomerClass;
        
        this.isSensitive = isSensitive;
        
    }

    public ArrayList getProfileBySubscriberId(String subscriberId, String dbCallDetailId) {

        String dataCenter = ConfigurationReader.configList.get("DATACENTER");
        
        String isSensitiveFlag = ConfigurationReader.configList.get("ISSENSITIVE");

        DBConnectionPool dbConPool = new DBConnectionPool();

        dbConPool.setPoolDataSource(dataCenter + "GGPRDB");

        Connection conn = null;

        CallableStatement callableStatement = null;

        ResultSet rs = null;

        ArrayList profileBySubscriberIdList = new ArrayList();

        String strProc = "{call " + ConfigurationReader.configList.get("PROC_NAME_GET_PROFILE_BY_SUBID") + "(?,?)}";

        try {

            conn = dbConPool.getConnection(dbCallDetailId);

            callableStatement = conn.prepareCall(strProc);

            callableStatement.setPoolable(false);

            callableStatement.setString(1, subscriberId);

            callableStatement.registerOutParameter(2, OracleTypes.CURSOR);

            callableStatement.execute();

            rs = ((OracleCallableStatement) callableStatement).getCursor(2);

            if (rs.next()) {

                primaryLanguage = rs.getString("PRIMARYLANGUAGE");

                secondaryLanguage = rs.getString("SECONDARYLANGUAGE");

                premiumFlag = rs.getString("CUSTOMERCLASS");

                premiumFlag1 = premiumFlag;

                if (premiumFlag.equalsIgnoreCase("C")) {

                    premiumFlag = "Y";
                }

                accountStatus = rs.getString("ACCOUNTSTATUS").trim();

                subscriberId = rs.getString("SUBSCRIBERID");

                subscriptionSubStatus = rs.getString("ACCOUNTSUBSTATUS");

                subscriptionType = rs.getString("SUBSCRIPTIONTYPE");

                firstName = rs.getString("FIRST_NAME");

                lastName = rs.getString("LAST_NAME");

                if (!firstName.isEmpty() || firstName != null) {

                    if (firstName.contains("&")) {

                        firstName = firstName.replaceAll("&", "and");

                    }

                }

                if (!lastName.isEmpty() || lastName != null) {

                    if (lastName.contains("&")) {

                        lastName = lastName.replaceAll("&", "and");

                    }

                }

                activationDate = rs.getString("ACTIVATIONDATE");

                String currentDate = Util.getCurrentDate();

                String noOfDays = Util.getDateDifference(activationDate, currentDate, "yyyy-MM-dd");

                Logger.info(dbCallDetailId, "Get Profile By Subscriber Id : Activation Date : " + activationDate + "Current Date : " + currentDate + "Difference in Days : " + noOfDays.substring(0, noOfDays.length() - 7), false);

                if ((Integer.parseInt(noOfDays.substring(0, noOfDays.length() - 7)) == 0) || Integer.parseInt(noOfDays.substring(0, noOfDays.length() - 7)) < 0) {

                    differenceInDays = "9999";

                } else {

                    differenceInDays = noOfDays;

                }

                actualCustomerClass = rs.getString("ACTUAL_CUSTOMERCLASS");
                
                differenceInDays = differenceInDays.substring(0, differenceInDays.length() - 7);
                
                isSensitive = rs.getString("ISSENSITIVE");
                
                Logger.info(dbCallDetailId, "Is Sensitive : " + isSensitive, false);
                
                if (isSensitiveFlag.equalsIgnoreCase("Y")) {

                    if (isSensitive.equalsIgnoreCase("Y")) {

                        premiumFlag = "Y";

                    }

                }
                
                Logger.info(dbCallDetailId, "Premium Flag After Change : " + premiumFlag, false);

                GetProfileBySubscriberIdDAO profileBySubscriberIdobj = new GetProfileBySubscriberIdDAO(primaryLanguage,
                        secondaryLanguage, premiumFlag, accountStatus, subscriberId, subscriptionSubStatus, premiumFlag1,
                        subscriptionType, firstName, lastName, activationDate, differenceInDays, actualCustomerClass,
                        isSensitive);

                profileBySubscriberIdList.add(profileBySubscriberIdobj);
            }

        } catch (SQLException sqlEx) {

            Logger.error(dbCallDetailId, " SQLException in Profile By Subscriber Id Page : " + sqlEx.getMessage(), false);

        } catch (Exception ex) {

            Logger.error(dbCallDetailId, " Exception in Profile By Subscriber Id Page : " + ex.getMessage(), false);

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

                Logger.error(dbCallDetailId, " Exception in Profile By SubscriberId finally block : " + subscriberId + " Message : " + sqlEx.getMessage(), false);
            }

            dbConPool.releaseConnection(dbCallDetailId);
        }

        Logger.info(dbCallDetailId, " Profile By SubscriberId : " + subscriberId + " primaryLanguage : " + primaryLanguage
                + " secondaryLanguage : " + secondaryLanguage + " premiumFlag : " + premiumFlag + " Corporate identification Flag : " + premiumFlag1
                + " accountStatus : " + accountStatus + " subscriberId : " + subscriberId + " subscriptionSubStatus : " + subscriptionSubStatus
                + " Subscription Type " + subscriptionType + " First Name " + firstName + " Last Name " + lastName
                + " Activation Date : " + activationDate + " Difference In Days : " + differenceInDays
                + " Actual Customer Class : " + actualCustomerClass + " Is Sensitive : " + isSensitive, false);

        dbCallDetailId = dataCenter = primaryLanguage = secondaryLanguage = premiumFlag = premiumFlag1 = accountStatus =
                subscriberId = subscriptionSubStatus = subscriptionType = firstName = lastName = differenceInDays =
                activationDate = actualCustomerClass = isSensitive = null;

        return profileBySubscriberIdList;
    }
}