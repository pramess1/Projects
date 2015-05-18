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
public class GetSubscriberProfileByRmnDAO {

    private String callerType = "";
    private String primaryLanguage = "";
    private String secondaryLanguage = "";
    private String subIDCount = "";
    private String prospectState = "";
    private String premiumFlag = "";
    private String accountStatus = "0";
    private String subscriberID = "";
    private String accountSubStatus = "";
    private String cliRepatFlag = "";
    private String premiumFlag1 = "";
    private String callCountByCLI = "";
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

    public String getDifferenceInDays() {
        return differenceInDays;
    }

    public void setDifferenceInDays(String differenceInDays) {
        this.differenceInDays = differenceInDays;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getPremiumFlag1() {
        return premiumFlag1;
    }

    public void setPremiumFlag1(String premiumFlag1) {
        this.premiumFlag1 = premiumFlag1;
    }

    public String getCallCountByCLI() {
        return callCountByCLI;
    }

    public void setCallCountByCLI(String callCountByCLI) {
        this.callCountByCLI = callCountByCLI;
    }

    public String getCliRepatFlag() {

        return cliRepatFlag;
    }

    public void setCliRepatFlag(String cliRepatFlag) {

        this.cliRepatFlag = cliRepatFlag;
    }

    public String getCallerType() {

        return callerType;
    }

    public void setCallerType(String callerType) {

        this.callerType = callerType;
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

    public String getSubIDCount() {

        return subIDCount;
    }

    public void setSubIDCount(String subIDCount) {

        this.subIDCount = subIDCount;
    }

    public String getProspectState() {

        return prospectState;
    }

    public void setProspectState(String prospectState) {

        this.prospectState = prospectState;
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

    public String getSubscriberID() {

        return subscriberID;
    }

    public void setSubscriberID(String subscriberID) {

        this.subscriberID = subscriberID;
    }

    public String getAccountSubStatus() {

        return accountSubStatus;
    }

    public void setAccountSubStatus(String accountSubStatus) {

        this.accountSubStatus = accountSubStatus;
    }

    public GetSubscriberProfileByRmnDAO() {
    }

    public GetSubscriberProfileByRmnDAO(String callerType, String subIDCount, String subscriberID,
            String accountStatus, String accountSubStatus, String primaryLanguage, String secondaryLanguage,
            String premiumFlag, String prospectState, String cliRepatFlag, String premiumFlag1, String callCountByCLI,
            String firstName, String lastName, String activationDate, String differenceInDays, String actualCustomerClass,
            String isSensitive) {


        this.callerType = callerType;

        this.subIDCount = subIDCount;

        this.subscriberID = subscriberID;

        this.accountStatus = accountStatus;

        this.accountSubStatus = accountSubStatus;

        this.primaryLanguage = primaryLanguage;

        this.secondaryLanguage = secondaryLanguage;

        this.premiumFlag = premiumFlag;

        this.prospectState = prospectState;

        this.cliRepatFlag = cliRepatFlag;

        this.premiumFlag1 = premiumFlag1;

        this.callCountByCLI = callCountByCLI;

        this.firstName = firstName;

        this.lastName = lastName;

        this.differenceInDays = differenceInDays;

        this.activationDate = activationDate;

        this.actualCustomerClass = actualCustomerClass;

        this.isSensitive = isSensitive;

    }

    public ArrayList getSubscriberProfileByRmn(String callerId, String dbCallDetailId) {

        subIDCount = null;

        String dataCenter = ConfigurationReader.configList.get("DATACENTER");

        String isSensitiveFlag = ConfigurationReader.configList.get("ISSENSITIVE");

        DBConnectionPool dbConPool = new DBConnectionPool();

        dbConPool.setPoolDataSource(dataCenter + "GGPRDB");

        Connection conn = null;

        CallableStatement callableStatement = null;

        ResultSet rs = null;

        ArrayList profileByRmnList = new ArrayList();

        String strProc = "{call " + ConfigurationReader.configList.get("PROC_NAME_GET_SUB_PROF_BY_RMN") + "(?,?,?,?,?)}";

        try {

            conn = dbConPool.getConnection(dbCallDetailId);

            callableStatement = conn.prepareCall(strProc);

            callableStatement.setPoolable(false);

            callableStatement.setString(1, callerId);

            callableStatement.registerOutParameter(2, java.sql.Types.VARCHAR);

            callableStatement.registerOutParameter(3, java.sql.Types.INTEGER);

            callableStatement.registerOutParameter(4, OracleTypes.CURSOR);

            callableStatement.registerOutParameter(5, OracleTypes.CURSOR);

            callableStatement.execute();

            callerType = callableStatement.getString(2).toString();

            if (callerType.equalsIgnoreCase("RMN")) { // RMN

                subIDCount = callableStatement.getString(3).toString();

                rs = ((OracleCallableStatement) callableStatement).getCursor(4);

                if (rs.next()) {

                    subscriberID = rs.getString("SUBSCRIBERID");

                    accountStatus = rs.getString("ACCOUNTSTATUS");

                    accountSubStatus = rs.getString("ACCOUNTSUBSTATUS");

                    primaryLanguage = rs.getString("PRIMARYLANGUAGE");

                    secondaryLanguage = rs.getString("SECONDARYLANGUAGE");

                    firstName = rs.getString("FIRST_NAME");

                    if (!firstName.isEmpty() || firstName != null) {

                        if (firstName.contains("&")) {

                            firstName = firstName.replaceAll("&", "and");

                        }

                    }

                    lastName = rs.getString("LAST_NAME");

                    if (!lastName.isEmpty() || lastName != null) {

                        if (lastName.contains("&")) {

                            lastName = lastName.replaceAll("&", "and");

                        }

                    }

                    premiumFlag = rs.getString("CUSTOMERCLASS");

                    premiumFlag1 = premiumFlag;

                    if (premiumFlag.equalsIgnoreCase("C")) {

                        Logger.info(dbCallDetailId, " Corporate identification Flag " + premiumFlag, false);

                        premiumFlag = "Y";
                    }

                    activationDate = rs.getString("ACTIVATIONDATE");

                    String currentDate = Util.getCurrentDate();

                    String noOfDays = Util.getDateDifference(activationDate, currentDate, "yyyy-MM-dd");

                    Logger.info(dbCallDetailId, "Get Subscriber Profile By RMN : Activation Date : " + activationDate + "Current Date : " + currentDate + "Difference in Days : " + noOfDays.substring(0, noOfDays.length() - 7), false);

                    if ((Integer.parseInt(noOfDays.substring(0, noOfDays.length() - 7)) == 0) || Integer.parseInt(noOfDays.substring(0, noOfDays.length() - 7)) < 0) {

                        differenceInDays = "9999";

                    } else {

                        differenceInDays = noOfDays;

                    }

                    differenceInDays = differenceInDays.substring(0, differenceInDays.length() - 7);

                    actualCustomerClass = rs.getString("ACTUAL_CUSTOMERCLASS");

                    isSensitive = rs.getString("ISSENSITIVE");
                    
                    Logger.info(dbCallDetailId, "Is Sensitive : " + isSensitive, false);

                    if (isSensitiveFlag.equalsIgnoreCase("Y")) {

                        if (isSensitive.equalsIgnoreCase("Y")) {

                            premiumFlag = "Y";

                        }

                    }
                    
                    Logger.info(dbCallDetailId, "Premium Flag After Change : " + premiumFlag, false);

                }

                rs = ((OracleCallableStatement) callableStatement).getCursor(5);

                while (rs.next()) {

                    cliRepatFlag = rs.getString("CLIREPEAT_FLAG");

                    callCountByCLI = rs.getString("CLICALLCOUNT");
                }

            } else if (callerType.equalsIgnoreCase("Partner")) { //Partner
            } else if (callerType.equalsIgnoreCase("Prospect")) { //Prospect

                subIDCount = callableStatement.getString(3).toString();

//                rs = ((OracleCallableStatement) callableStatement).getCursor(4);
//
//                while (rs.next()) {
//
//                    prospectState = rs.getString("STATE");
//
//                }

            } else if (callerType.equalsIgnoreCase("NonRMN")) { //NonRMN

                rs = ((OracleCallableStatement) callableStatement).getCursor(5);

                while (rs.next()) {

                    cliRepatFlag = rs.getString("CLIREPEAT_FLAG");

                    callCountByCLI = rs.getString("CLICALLCOUNT");
                }
            }

        } catch (SQLException sqlEx) {

            Logger.error(dbCallDetailId, " Sql Exception in Subscriber Profile By Rmn Page : " + callerId + " Message : " + sqlEx.getMessage(), false);

        } catch (Exception ex) {

            Logger.error(dbCallDetailId, " Exception in Subscriber Profile By Rmn Page : " + callerId + " Message : " + ex.getMessage(), false);

        } finally {

            dbConPool.releaseConnection(dbCallDetailId);

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

                Logger.error(dbCallDetailId, " Exception in Subscriber Profile By Rmn finally block : " + callerId + " Message : " + sqlEx.getMessage(), false);
            }



        }

        GetSubscriberProfileByRmnDAO subscriberProfileByRmnobj = new GetSubscriberProfileByRmnDAO(callerType, subIDCount,
                subscriberID, accountStatus, accountSubStatus, primaryLanguage, secondaryLanguage, premiumFlag,
                prospectState, cliRepatFlag, premiumFlag1, callCountByCLI, firstName, lastName, activationDate,
                differenceInDays, actualCustomerClass, isSensitive);

        profileByRmnList.add(subscriberProfileByRmnobj);

        Logger.info(dbCallDetailId, " Get Subscriber Profile By RMN : " + callerId + " Caller Type : " + callerType
                + " Sub Id Count : " + subIDCount + " Subscriber Id : " + subscriberID + " Account Status : " + accountStatus
                + " Account Sub Status : " + accountSubStatus + " Primary Language : " + primaryLanguage
                + " Secondary Language : " + secondaryLanguage + " Premium Flag : " + premiumFlag + " Prospect State : " + prospectState
                + " Cli Repat Flag : " + cliRepatFlag + " premiumFlag1 : " + premiumFlag1 + " callCountByCLI " + callCountByCLI
                + " First Name " + firstName + " Last Name " + lastName + " Activation Date : " + activationDate
                + " Difference In Days : " + differenceInDays + " Actual Customer Class : " + actualCustomerClass
                + " Is Sensitive : " + isSensitive, false);

        callerId = dataCenter = dbCallDetailId = callerType = subIDCount = subscriberID = accountStatus = accountSubStatus =
                primaryLanguage = secondaryLanguage = premiumFlag = prospectState = cliRepatFlag = premiumFlag1 =
                callCountByCLI = firstName = lastName = activationDate = differenceInDays = actualCustomerClass = 
                isSensitive = null;

        return profileByRmnList;
    }
}
