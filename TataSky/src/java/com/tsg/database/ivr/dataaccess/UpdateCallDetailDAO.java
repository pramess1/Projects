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
import java.sql.SQLException;

/**
 *
 * @author Rajesh
 */
public class UpdateCallDetailDAO {

    public String updateCallDetail(String Calldetailid, String Callendtime, String Languageselected, String Subscriberid,
            String Subidlist, String Callertype, String Subscribersegment, String Calldisconnectedby, String Calldisconnectreason,
            String Lasttraversedcfdid, String Transferstatus, String Transferfailurereason, String Transferto, String accountStatus,
            String accountSubStatus, String subIdCount, String nonRmnIdEntifier, String subIdValiDated, String cli, String firstPromtPlayTime,
            String ivrExit, String partnerSubType, String productType, String activationDate, String segmentSubType,
            String actualCustomerClass, String isSensitive) {

        String dataCenter = ConfigurationReader.configList.get("DATACENTER");

        DBConnectionPool dbConPool = new DBConnectionPool();

        dbConPool.setPoolDataSource(dataCenter + "IVRPRDB");

        Connection conn = null;

        CallableStatement callableStatement = null;

        String strProc = "{call " + ConfigurationReader.configList.get("PROC_NAME_UPDATE_CALL_DETAIL") + "(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";

        String status = "0";

        Logger.info(Calldetailid, " Update Call Detail Callendtime : " + Callendtime
                + " Languageselected : " + Languageselected + " Subscriberid : " + Subscriberid + " Subidlist : " + Subidlist
                + " Callertype : " + Callertype + " Subscribersegment : " + Subscribersegment + " Calldisconnectedby : " + Calldisconnectedby
                + " Calldisconnectreason : " + Calldisconnectreason + " Lasttraversedcfdid : " + Lasttraversedcfdid + " Transferstatus : " + Transferstatus
                + " Transferfailurereason : " + Transferfailurereason + " Transferto : " + Transferto + " accountStatus : " + accountStatus
                + " accountSubStatus : " + accountSubStatus + " subIdCount : " + subIdCount + " nonRmnIdEntifier : " + nonRmnIdEntifier
                + " subIdValiDated " + subIdValiDated + " cli " + cli + " First Promt Play Time " + firstPromtPlayTime + " IVR Exit " + ivrExit
                + " Partner Sub Type : " + partnerSubType + " Product Type : " + productType + " Activation Date : " + activationDate
                + " Segment Sub Type : " + segmentSubType + " Actual Customer Class : " + actualCustomerClass
                + " Is Sensitive : " + isSensitive, false);

        try {

            conn = dbConPool.getConnection(Calldetailid);

            callableStatement = conn.prepareCall(strProc);

            callableStatement.setLong(1, Long.parseLong(Calldetailid));

            callableStatement.setString(2, Callendtime);

            callableStatement.setString(3, Languageselected);

            callableStatement.setString(4, Subscriberid);

            callableStatement.setString(5, Subidlist);

            callableStatement.setString(6, Callertype);

            callableStatement.setString(7, Subscribersegment);

            callableStatement.setString(8, Calldisconnectedby);

            callableStatement.setString(9, Calldisconnectreason);

            callableStatement.setString(10, Lasttraversedcfdid);

            callableStatement.setString(11, Transferstatus);

            callableStatement.setString(12, Transferfailurereason);

            callableStatement.setString(13, Transferto);

            callableStatement.setString(14, accountStatus);

            callableStatement.setString(15, accountSubStatus);

            if (subIdCount.isEmpty()) {

                callableStatement.setLong(16, 0);

            } else {

                callableStatement.setLong(16, Long.parseLong(subIdCount));
            }

//            callableStatement.setLong(16, Long.parseLong(subIdCount));

            callableStatement.setString(17, nonRmnIdEntifier);

            callableStatement.setString(18, subIdValiDated);

            callableStatement.setString(19, cli);

            callableStatement.setString(20, firstPromtPlayTime);

            callableStatement.setString(21, ivrExit);

            callableStatement.setString(22, partnerSubType);

            callableStatement.setString(23, productType);

            callableStatement.setString(24, activationDate);

            callableStatement.setString(25, segmentSubType);

            callableStatement.setString(26, actualCustomerClass);

            callableStatement.setString(27, isSensitive);

            callableStatement.registerOutParameter(28, java.sql.Types.VARCHAR);

            callableStatement.executeUpdate();

            status = callableStatement.getString(28).toString();

        } catch (SQLException sqlEx) {

            Logger.error(Calldetailid, " Exception in Update Call Detail Page : " + Calldetailid + " Message : " + sqlEx.getMessage(), false);

        } catch (Exception ex) {

            Logger.error(Calldetailid, " Exception in Update Call Detail Page  : " + Calldetailid + " Message : " + ex.getMessage(), false);

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

                Logger.error(Calldetailid, " Exception in Update Call Detail finally block : " + Calldetailid + " Message : " + sqlEx.getMessage(), false);
            }

            dbConPool.releaseConnection(Calldetailid);
        }

        Logger.info(Calldetailid, " Update Call Detail Status " + status, false);

        Calldetailid = Callendtime = Languageselected = Subscriberid = Subidlist = Callertype = Subscribersegment =
                Calldisconnectedby = Calldisconnectreason = Lasttraversedcfdid = Transferstatus = Transferfailurereason =
                Transferto = accountStatus = accountSubStatus = subIdCount = nonRmnIdEntifier = subIdValiDated = cli = firstPromtPlayTime =
                ivrExit = dataCenter = partnerSubType = productType = activationDate = segmentSubType =
                actualCustomerClass = isSensitive = null;

        return status;
    }
}