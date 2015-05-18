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
import java.util.Arrays;
import oracle.jdbc.OracleCallableStatement;
import oracle.jdbc.OracleTypes;

/**
 *
 * @author Rajesh
 */
public class GetDetailBySubscriberIdDAO_Old {

    private String spmCampaignFlag = "";
    private String spmPackName = "";
    private String spmCampaignId = "";
    private String callCountbySubscriberId = "";
    private String openEscalationFlag = "";
    private String openSrFlag = "";
    private String srRepeatFlag = "";
    private String openWoFlag = "";
    private String woRepeatFlag = "";
    private String ndncFlag = "";
    private String productType = "";
    private String subscriptionType = "";
    private String campaign = "";  //campaign1
    private String campaignCode = "";
    private String campaignDescription = "";
    private String campaign2 = "";//campaign2
    private String campaignCode2 = "";
    private String campaignDescription2 = "";
    private String campaign3 = "";////campaign3
    private String campaignCode3 = "";
    private String campaignDescription3 = "";
    private String campaignFlag = "";
    private String repeatPackCount = "";
    private String repeatRechargeCount = "";
    private String subscriberAgentRepeatFlag = "";
    private String subscriberIVRRepeatFlag = "";
    private String differenceInDays = "";
    private String activationDate = "";
    private String isSensitive = "";
    private String[] arrCampaign = new String[3];
    private String[] arrCampaignCode = new String[3];
    private String[] arrCampaignDesc = new String[3];

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

    public String getDifferenceInDays() {
        return differenceInDays;
    }

    public void setDifferenceInDays(String differenceInDays) {
        this.differenceInDays = differenceInDays;
    }

    public String getSubscriberAgentRepeatFlag() {
        return subscriberAgentRepeatFlag;
    }

    public void setSubscriberAgentRepeatFlag(String subscriberAgentRepeatFlag) {
        this.subscriberAgentRepeatFlag = subscriberAgentRepeatFlag;
    }

    public String getSubscriberIVRRepeatFlag() {
        return subscriberIVRRepeatFlag;
    }

    public void setSubscriberIVRRepeatFlag(String subscriberIVRRepeatFlag) {
        this.subscriberIVRRepeatFlag = subscriberIVRRepeatFlag;
    }

    public String getCampaign3() {
        return campaign3;
    }

    public void setCampaign3(String campaign3) {
        this.campaign3 = campaign3;
    }

    public String getCampaignCode3() {
        return campaignCode3;
    }

    public void setCampaignCode3(String campaignCode3) {
        this.campaignCode3 = campaignCode3;
    }

    public String getCampaignDescription3() {
        return campaignDescription3;
    }

    public void setCampaignDescription3(String campaignDescription3) {
        this.campaignDescription3 = campaignDescription3;
    }

    public String getSpmPackName() {
        return spmPackName;
    }

    public void setSpmPackName(String spmPackName) {
        this.spmPackName = spmPackName;
    }

    public String getSpmCampaignId() {
        return spmCampaignId;
    }

    public void setSpmCampaignId(String spmCampaignId) {
        this.spmCampaignId = spmCampaignId;
    }

    public String getCallCountbySubscriberId() {
        return callCountbySubscriberId;
    }

    public void setCallCountbySubscriberId(String callCountbySubscriberId) {
        this.callCountbySubscriberId = callCountbySubscriberId;
    }

    public String getCampaign2() {
        return campaign2;
    }

    public void setCampaign2(String campaign2) {
        this.campaign2 = campaign2;
    }

    public String getCampaignCode2() {
        return campaignCode2;
    }

    public void setCampaignCode2(String campaignCode2) {
        this.campaignCode2 = campaignCode2;
    }

    public String getCampaignDescription2() {
        return campaignDescription2;
    }

    public void setCampaignDescription2(String campaignDescription2) {
        this.campaignDescription2 = campaignDescription2;
    }

    public String getRepeatPackCount() {

        return repeatPackCount;
    }

    public void setRepeatPackCount(String repeatPackCount) {

        this.repeatPackCount = repeatPackCount;
    }

    public String getRepeatRechargeCount() {

        return repeatRechargeCount;
    }

    public void setRepeatRechargeCount(String repeatRechargeCount) {

        this.repeatRechargeCount = repeatRechargeCount;
    }

    public String getSpmCampaignFlag() {

        return spmCampaignFlag;
    }

    public void setSpmCampaignFlag(String spmCampaignFlag) {

        this.spmCampaignFlag = spmCampaignFlag;
    }

    public String getOpenEscalationFlag() {

        return openEscalationFlag;
    }

    public void setOpenEscalationFlag(String openEscalationFlag) {

        this.openEscalationFlag = openEscalationFlag;
    }

    public String getOpenSrFlag() {

        return openSrFlag;
    }

    public void setOpenSrFlag(String openSrFlag) {

        this.openSrFlag = openSrFlag;
    }

    public String getSrRepeatFlag() {

        return srRepeatFlag;
    }

    public void setSrRepeatFlag(String srRepeatFlag) {

        this.srRepeatFlag = srRepeatFlag;
    }

    public String getOpenWoFlag() {

        return openWoFlag;
    }

    public void setOpenWoFlag(String openWoFlag) {

        this.openWoFlag = openWoFlag;
    }

    public String getWoRepeatFlag() {

        return woRepeatFlag;
    }

    public void setWoRepeatFlag(String woRepeatFlag) {

        this.woRepeatFlag = woRepeatFlag;
    }

    public String getNdncFlag() {
        return ndncFlag;
    }

    public void setNdncFlag(String ndncFlag) {

        this.ndncFlag = ndncFlag;
    }

    public String getProductType() {

        return productType;
    }

    public void setProductType(String productType) {

        this.productType = productType;
    }

    public String getSubscriptionType() {

        return subscriptionType;
    }

    public void setSubscriptionType(String subscriptionType) {

        this.subscriptionType = subscriptionType;
    }

    public String getCampaign() {

        return campaign;
    }

    public void setCampaign(String campaign) {

        this.campaign = campaign;
    }

    public String getCampaignCode() {

        return campaignCode;
    }

    public void setCampaignCode(String campaignCode) {

        this.campaignCode = campaignCode;
    }

    public String getCampaignDescription() {

        return campaignDescription;
    }

    public void setCampaignDescription(String campaignDescription) {

        this.campaignDescription = campaignDescription;
    }

    public String getCampaignFlag() {

        return campaignFlag;
    }

    public void setCampaignFlag(String campaignFlag) {

        this.campaignFlag = campaignFlag;
    }

    public GetDetailBySubscriberIdDAO_Old() {
    }

    public GetDetailBySubscriberIdDAO_Old(String spmCampaignFlag, String openEscalationFlag, String openSrFlag,
            String srRepeatFlag, String openWoFlag, String woRepeatFlag, String ndncFlag, String productType,
            String subscriptionType, String campaign, String campaignCode, String campaignDescription,
            String campaign2, String campaignCode2, String campaignDescription2, String campaign3, String campaignCode3,
            String campaignDescription3, String campaignFlag, String repeatPackCount,
            String repeatRechargeCount, String spmPackName, String spmCampaignId, String callCountbySubscriberId,
            String subscriberAgentRepeatFlag, String subscriberIVRRepeatFlag, String activationDate,
            String differenceInDays, String isSensitive) {

        this.spmCampaignFlag = spmCampaignFlag;

        this.openEscalationFlag = openEscalationFlag;

        this.openSrFlag = openSrFlag;

        this.srRepeatFlag = srRepeatFlag;

        this.openWoFlag = openWoFlag;

        this.woRepeatFlag = woRepeatFlag;

        this.ndncFlag = ndncFlag;

        this.productType = productType;

        this.subscriptionType = subscriptionType;

        this.campaign = campaign;

        this.campaignCode = campaignCode;

        this.campaignDescription = campaignDescription;

        this.campaign2 = campaign2;

        this.campaignCode2 = campaignCode2;

        this.campaignDescription2 = campaignDescription2;

        this.campaign3 = campaign3;

        this.campaignCode3 = campaignCode3;

        this.campaignDescription3 = campaignDescription3;

        this.campaignFlag = campaignFlag;

        this.repeatPackCount = repeatPackCount;

        this.repeatRechargeCount = repeatRechargeCount;

        this.spmPackName = spmPackName;

        this.spmCampaignId = spmCampaignId;

        this.callCountbySubscriberId = callCountbySubscriberId;

        this.subscriberAgentRepeatFlag = subscriberAgentRepeatFlag;

        this.subscriberIVRRepeatFlag = subscriberIVRRepeatFlag;

        this.differenceInDays = differenceInDays;

        this.activationDate = activationDate;

        this.isSensitive = isSensitive;

    }

    public ArrayList getDetailBySubscriberId(String subscriberId, String premiumFlag, String dbCallDetailId) {

        String dataCenter = ConfigurationReader.configList.get("DATACENTER");

        DBConnectionPool dbConPool = new DBConnectionPool();

        dbConPool.setPoolDataSource(dataCenter + "GGPRDB");
        
        Connection conn = null;

        CallableStatement callableStatement = null;

        ResultSet rs = null;

        ArrayList detailBySubscriberIdList = new ArrayList();

        String strProc = "{call " + ConfigurationReader.configList.get("PROC_NAME_GET_DETAIL_BY_SUB_ID") + "(?,?,?,?,?,?,?,?,?,?)}";

        try {

            conn = dbConPool.getConnection(dbCallDetailId);

            callableStatement = conn.prepareCall(strProc);

            callableStatement.setPoolable(false);

            callableStatement.setString(1, subscriberId);

            callableStatement.setString(2, premiumFlag);

            callableStatement.registerOutParameter(3, OracleTypes.CURSOR);

            callableStatement.registerOutParameter(4, OracleTypes.CURSOR);

            callableStatement.registerOutParameter(5, OracleTypes.CURSOR);

            callableStatement.registerOutParameter(6, OracleTypes.CURSOR);

            callableStatement.registerOutParameter(7, OracleTypes.CURSOR);

            callableStatement.registerOutParameter(8, OracleTypes.CURSOR);

            callableStatement.registerOutParameter(9, OracleTypes.CURSOR);

            callableStatement.registerOutParameter(10, OracleTypes.CURSOR);

            callableStatement.execute();

            rs = ((OracleCallableStatement) callableStatement).getCursor(3);

            if (rs.next()) {

                productType = rs.getString("PRODUCTTYPE");

                subscriptionType = rs.getString("SUBSCRIPTIONTYPE");

                activationDate = rs.getString("ACTIVATIONDATE");

                isSensitive = rs.getString("ISSENSITIVE");

            }

            String currentDate = Util.getCurrentDate();

            String noOfDays = Util.getDateDifference(activationDate, currentDate, "yyyy-MM-dd");

            Logger.info(dbCallDetailId, "Activation Date : " + activationDate + "Current Date : " + currentDate + "Difference in Days : " + noOfDays.substring(0, noOfDays.length() - 7), false);

            if ((Integer.parseInt(noOfDays.substring(0, noOfDays.length() - 7)) == 0) || Integer.parseInt(noOfDays.substring(0, noOfDays.length() - 7)) < 0) {

                differenceInDays = "9999";

            } else {

                differenceInDays = noOfDays;

            }

            differenceInDays = differenceInDays.substring(0, differenceInDays.length() - 7);

            rs = ((OracleCallableStatement) callableStatement).getCursor(4);

            while (rs.next()) {

                spmCampaignFlag = rs.getString("SPM_CAMPAIGNFLAG");

                spmCampaignId = rs.getString("CAMPAIGN_ID");

                spmPackName = rs.getString("PACKNAME");

            }

            rs = ((OracleCallableStatement) callableStatement).getCursor(5);

            while (rs.next()) {

                openEscalationFlag = rs.getString("ISOPENESC");

                openSrFlag = rs.getString("ISOPENSR");

                srRepeatFlag = rs.getString("ISREPEATSR");

            }

            rs = ((OracleCallableStatement) callableStatement).getCursor(6);

            while (rs.next()) {

                openWoFlag = rs.getString("ISOPENWO");

                woRepeatFlag = rs.getString("ISREPEATWO");

            }

            rs = ((OracleCallableStatement) callableStatement).getCursor(7);

            while (rs.next()) {

                ndncFlag = rs.getString("ISNDNC");

            }

            rs = ((OracleCallableStatement) callableStatement).getCursor(8);

            while (rs.next()) {

                repeatPackCount = rs.getString("RPTPACKCOUNT");

                repeatRechargeCount = rs.getString("RPTRECHARGECOUNT");

                callCountbySubscriberId = rs.getString("DAYREPEATCOUNT");

                subscriberAgentRepeatFlag = rs.getString("ISSUBCAGENTREPEATFLAG");

                subscriberIVRRepeatFlag = rs.getString("ISSUBCIVRREPEATFLAG");
            }

            rs = ((OracleCallableStatement) callableStatement).getCursor(9);

            int i = 0;

            while (rs.next()) {

                arrCampaign[i] = rs.getString("CAMPAIGNNAME");
                arrCampaignCode[i] = rs.getString("CAMPAIGNCODE");
                arrCampaignDesc[i] = rs.getString("CAMPAIGNDESC");

                Logger.debug(dbCallDetailId, "Inside While :: Campaign Name" + i + " : " + arrCampaign[i] + " Campaign Code" + i + " : " + arrCampaignCode[i] + " Campaign Description" + i + " : " + arrCampaignDesc[i], false);

                campaignFlag = rs.getString("CAMPAIGNFLAG");

                i++;
            }

            if(arrCampaign[0] == null) {
                
                arrCampaign[0] = "";
                
            }
            
            if(arrCampaign[1] == null) {
                
                arrCampaign[1] = "";
                
            }
            
            if(arrCampaign[2] == null) {
                
                arrCampaign[2] = "";
                
            }
            
            if(arrCampaign[0].equalsIgnoreCase("Camp1")) {
                
                campaign = arrCampaign[0];
                campaignCode = arrCampaignCode[0];
                campaignDescription = arrCampaignDesc[0];
                
            } 
            
            if(arrCampaign[1].equalsIgnoreCase("Camp2")) {
                
                campaign2 = arrCampaign[1];
                campaignCode2 = arrCampaignCode[1];
                campaignDescription2 = arrCampaignDesc[1];
                
            } 
            
            if(arrCampaign[2].equalsIgnoreCase("Camp3")) {
                
                campaign3 = arrCampaign[2];
                campaignCode3 = arrCampaignCode[2];
                campaignDescription3 = arrCampaignDesc[2];
                
            } 
            
            if(arrCampaign[0].equalsIgnoreCase("Camp2")) {
                
                campaign2 = arrCampaign[0];
                campaignCode2 = arrCampaignCode[0];
                campaignDescription2 = arrCampaignDesc[0];
                
            } 
            
            if(arrCampaign[1].equalsIgnoreCase("Camp1")) {
                
                campaign = arrCampaign[1];
                campaignCode = arrCampaignCode[1];
                campaignDescription = arrCampaignDesc[1];
                
            } 
            
            if(arrCampaign[2].equalsIgnoreCase("Camp3")) {
                
                campaign3 = arrCampaign[2];
                campaignCode3 = arrCampaignCode[2];
                campaignDescription3 = arrCampaignDesc[2];
                
            } 
            
            if(arrCampaign[0].equalsIgnoreCase("Camp3")) {
                
                campaign3 = arrCampaign[0];
                campaignCode3 = arrCampaignCode[0];
                campaignDescription3 = arrCampaignDesc[0];
                
            } 
            
            if(arrCampaign[1].equalsIgnoreCase("Camp1")) {
                
                campaign = arrCampaign[1];
                campaignCode = arrCampaignCode[1];
                campaignDescription = arrCampaignDesc[1];
                
            } 
            
            if(arrCampaign[2].equalsIgnoreCase("Camp2")) {
                
                campaign2 = arrCampaign[2];
                campaignCode2 = arrCampaignCode[2];
                campaignDescription2 = arrCampaignDesc[2];
                
            } 
            
            if(arrCampaign[0].equalsIgnoreCase("Camp3")) {
                
                campaign3 = arrCampaign[0];
                campaignCode3 = arrCampaignCode[0];
                campaignDescription3 = arrCampaignDesc[0];
                
            } 
            
            if(arrCampaign[1].equalsIgnoreCase("Camp2")) {
                
                campaign2 = arrCampaign[1];
                campaignCode2 = arrCampaignCode[1];
                campaignDescription2 = arrCampaignDesc[1];
                
            } 
            
            if(arrCampaign[2].equalsIgnoreCase("Camp1")) {
                
                campaign = arrCampaign[2];
                campaignCode = arrCampaignCode[2];
                campaignDescription = arrCampaignDesc[2];
                
            } 
            
            if(arrCampaign[0].equalsIgnoreCase("Camp1")) {
                
                campaign = arrCampaign[0];
                campaignCode = arrCampaignCode[0];
                campaignDescription = arrCampaignDesc[0];
                
            } 
            
            if(arrCampaign[1].equalsIgnoreCase("Camp3")) {
                
                campaign3 = arrCampaign[1];
                campaignCode3 = arrCampaignCode[1];
                campaignDescription3 = arrCampaignDesc[1];
                
            } 
            
            if(arrCampaign[2].equalsIgnoreCase("Camp2")) {
                
                campaign2 = arrCampaign[2];
                campaignCode2 = arrCampaignCode[2];
                campaignDescription2 = arrCampaignDesc[2];
                
            } 
            
            if(arrCampaign[0].equalsIgnoreCase("Camp2")) {
                
                campaign2 = arrCampaign[0];
                campaignCode2 = arrCampaignCode[0];
                campaignDescription2 = arrCampaignDesc[0];
                
            } 
            
            if(arrCampaign[1].equalsIgnoreCase("Camp3")) {
                
                campaign3 = arrCampaign[1];
                campaignCode3 = arrCampaignCode[1];
                campaignDescription3 = arrCampaignDesc[1];
                
            } 
            
            if(arrCampaign[2].equalsIgnoreCase("Camp1")) {
                
                campaign = arrCampaign[2];
                campaignCode = arrCampaignCode[2];
                campaignDescription = arrCampaignDesc[2];
                
            }

            GetDetailBySubscriberIdDAO_Old getDetailBySubscriberIdobj = new GetDetailBySubscriberIdDAO_Old(spmCampaignFlag, openEscalationFlag, openSrFlag,
                    srRepeatFlag, openWoFlag, woRepeatFlag, ndncFlag, productType, subscriptionType, campaign, campaignCode, campaignDescription,
                    campaign2, campaignCode2, campaignDescription2, campaign3, campaignCode3, campaignDescription3, campaignFlag,
                    repeatPackCount, repeatRechargeCount, spmPackName, spmCampaignId, callCountbySubscriberId,
                    subscriberAgentRepeatFlag, subscriberIVRRepeatFlag, activationDate, differenceInDays, isSensitive);

            detailBySubscriberIdList.add(getDetailBySubscriberIdobj);

        } catch (SQLException ex) {

            Logger.error(dbCallDetailId, " SQL Exception in Detail By Subscriber Id Page : " + ex.getMessage(), false);

        } catch (Exception ex) {

            Logger.error(dbCallDetailId, " Exception in Detail By Subscriber Id Page : " + ex.getMessage(), false);

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

                Logger.error(dbCallDetailId, " Exception in Detail By Subscriber Id finally block : " + subscriberId + " Message : " + sqlEx.getMessage(), false);
            }

            dbConPool.releaseConnection(dbCallDetailId);
        }

        Logger.info(dbCallDetailId, "Subscriber IVR Repeat Flag : " + subscriberIVRRepeatFlag, false);

        Logger.info(dbCallDetailId, " spmCampaignFlag : " + spmCampaignFlag + " openEscalationFlag : " + openEscalationFlag + " openSrFlag : " + openSrFlag + " srRepeatFlag : " + srRepeatFlag
                + " openWoFlag : " + openWoFlag + " woRepeatFlag : " + woRepeatFlag + " ndncFlag : " + ndncFlag + " productType : " + productType + " subscriptionType : " + subscriptionType + " campaign" + campaign
                + " campaignCode " + campaignCode + " campaignDescription " + campaignDescription + " Campaign2 " + campaign2 + " CampaignCode2 " + campaignCode2 + " CampaignDescription2 " + campaignDescription2
                + " Campaign3 " + campaign3 + " CampaignCode3 " + campaignCode3 + " CampaignDescription3 " + campaignDescription3
                + " campaignFlag :" + campaignFlag + " subscriberIVRRepeatFlag :" + subscriberIVRRepeatFlag
                + " subscriberAgentRepeatFlag" + subscriberAgentRepeatFlag + " repeatPackCount :" + repeatPackCount + " repeatRechargeCount :" + repeatRechargeCount
                + " Call Count by SubscriberId : " + callCountbySubscriberId + " Spm Campaign Id : " + spmCampaignId + " Spm Pack Name : " + spmPackName
                + " Activatioin Date : " + activationDate + " Difference In Days : " + differenceInDays + "Is Sensitive : " + isSensitive, false);

        dataCenter = spmCampaignFlag = openEscalationFlag = openSrFlag = srRepeatFlag = openWoFlag = woRepeatFlag = ndncFlag = productType =
                subscriptionType = callCountbySubscriberId = spmCampaignId = subscriberIVRRepeatFlag =
                subscriberAgentRepeatFlag = spmPackName = differenceInDays = activationDate = isSensitive = null;

        return detailBySubscriberIdList;
    }
}
