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
public class GetDetailBySubscriberIdDAO {

    private String spmCampaignFlag = "";
    private String spmPackName = "";
    private String spmCampaignId = "";
    private String callCountbySubscriberId = "";
    private String openEscalationFlag = "";
    private String openSrFlag = "";
    private String srRepeatFlag = "";
    private String openWoFlag = "";
    private String woRepeatFlag = "";
    private String productType = "";
    private String subscriptionType = "";
    private String campaign1 = "";  //campaign1
    private String campaignCode1 = "";
    private String campaignDescription1 = "";
    private String campaign2 = "";//campaign2
    private String campaignCode2 = "";
    private String campaignDescription2 = "";
    private String campaign3 = "";//campaign3
    private String campaignCode3 = "";
    private String campaignDescription3 = "";
    private String campaign4 = "";//campaign4
    private String campaignCode4 = "";
    private String campaignDescription4 = "";
    private String campaign5 = "";//campaign5
    private String campaignCode5 = "";
    private String campaignDescription5 = "";
    private String campaign6 = "";//campaign6
    private String campaignCode6 = "";
    private String campaignDescription6 = "";
    private String campaign7 = "";//campaign7
    private String campaignCode7 = "";
    private String campaignDescription7 = "";
    private String campaign8 = "";//campaign8
    private String campaignCode8 = "";
    private String campaignDescription8 = "";
    private String campaign9 = "";//campaign9
    private String campaignCode9 = "";
    private String campaignDescription9 = "";
    private String campaignFlag = "";
    private String repeatPackCount = "";
    private String repeatRechargeCount = "";
    private String subscriberAgentRepeatFlag = "";
    private String subscriberIVRRepeatFlag = "";
    private String differenceInDays = "";
    private String activationDate = "";
    private String isSensitive = "";
    private String ivrSRType = "";
    private String isIvrOpenSR = "";
    private String ivrWOType = "";
    private String isIvrOpenWO = "";
    private String srCreatedDate = "";
    private String ivrSRNumber = "";
    private String woSheduledDateTime = "";
    private String ivrWONumber = "";
    private String ivrWOStatus = "";
    private String woCreatedDate = "";
    private String ivrSRStatus = "";
    private String[] arrCampaign = new String[9];
    private String[] arrCampaignCode = new String[9];
    private String[] arrCampaignDesc = new String[9];

    public String getWoCreatedDate() {
        return woCreatedDate;
    }

    public void setWoCreatedDate(String woCreatedDate) {
        this.woCreatedDate = woCreatedDate;
    }

    public String getIvrWOStatus() {
        return ivrWOStatus;
    }

    public void setIvrWOStatus(String ivrWOStatus) {
        this.ivrWOStatus = ivrWOStatus;
    }

    public String getIvrSRStatus() {
        return ivrSRStatus;
    }

    public void setIvrSRStatus(String ivrSRStatus) {
        this.ivrSRStatus = ivrSRStatus;
    }

    public String getSrCreatedDate() {
        return srCreatedDate;
    }

    public void setSrCreatedDate(String srCreatedDate) {
        this.srCreatedDate = srCreatedDate;
    }

    public String getIvrSRNumber() {
        return ivrSRNumber;
    }

    public void setIvrSRNumber(String ivrSRNumber) {
        this.ivrSRNumber = ivrSRNumber;
    }

    public String getWoSheduledDateTime() {
        return woSheduledDateTime;
    }

    public void setWoSheduledDateTime(String woSheduledDateTime) {
        this.woSheduledDateTime = woSheduledDateTime;
    }

    public String getIvrWONumber() {
        return ivrWONumber;
    }

    public void setIvrWONumber(String ivrWONumber) {
        this.ivrWONumber = ivrWONumber;
    }

    public String getIvrWOType() {
        return ivrWOType;
    }

    public void setIvrWOType(String ivrWOType) {
        this.ivrWOType = ivrWOType;
    }

    public String getIsIvrOpenWO() {
        return isIvrOpenWO;
    }

    public void setIsIvrOpenWO(String isIvrOpenWO) {
        this.isIvrOpenWO = isIvrOpenWO;
    }

    public String getIsIvrOpenSR() {
        return isIvrOpenSR;
    }

    public void setIsIvrOpenSR(String isIvrOpenSR) {
        this.isIvrOpenSR = isIvrOpenSR;
    }

    public String getIvrSRType() {
        return ivrSRType;
    }

    public void setIvrSRType(String ivrSRType) {
        this.ivrSRType = ivrSRType;
    }

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

    public String getCampaign4() {
        return campaign4;
    }

    public void setCampaign4(String campaign4) {
        this.campaign4 = campaign4;
    }

    public String getCampaignCode4() {
        return campaignCode4;
    }

    public void setCampaignCode4(String campaignCode4) {
        this.campaignCode4 = campaignCode4;
    }

    public String getCampaignDescription4() {
        return campaignDescription4;
    }

    public void setCampaignDescription4(String campaignDescription4) {
        this.campaignDescription4 = campaignDescription4;
    }

    public String getCampaign5() {
        return campaign5;
    }

    public void setCampaign5(String campaign5) {
        this.campaign5 = campaign5;
    }

    public String getCampaignCode5() {
        return campaignCode5;
    }

    public void setCampaignCode5(String campaignCode5) {
        this.campaignCode5 = campaignCode5;
    }

    public String getCampaignDescription5() {
        return campaignDescription5;
    }

    public void setCampaignDescription5(String campaignDescription5) {
        this.campaignDescription5 = campaignDescription5;
    }

    public String getCampaign6() {
        return campaign6;
    }

    public void setCampaign6(String campaign6) {
        this.campaign6 = campaign6;
    }

    public String getCampaignCode6() {
        return campaignCode6;
    }

    public void setCampaignCode6(String campaignCode6) {
        this.campaignCode6 = campaignCode6;
    }

    public String getCampaignDescription6() {
        return campaignDescription6;
    }

    public void setCampaignDescription6(String campaignDescription6) {
        this.campaignDescription6 = campaignDescription6;
    }

    public String getCampaign7() {
        return campaign7;
    }

    public void setCampaign7(String campaign7) {
        this.campaign7 = campaign7;
    }

    public String getCampaignCode7() {
        return campaignCode7;
    }

    public void setCampaignCode7(String campaignCode7) {
        this.campaignCode7 = campaignCode7;
    }

    public String getCampaignDescription7() {
        return campaignDescription7;
    }

    public void setCampaignDescription7(String campaignDescription7) {
        this.campaignDescription7 = campaignDescription7;
    }

    public String getCampaign8() {
        return campaign8;
    }

    public void setCampaign8(String campaign8) {
        this.campaign8 = campaign8;
    }

    public String getCampaignCode8() {
        return campaignCode8;
    }

    public void setCampaignCode8(String campaignCode8) {
        this.campaignCode8 = campaignCode8;
    }

    public String getCampaignDescription8() {
        return campaignDescription8;
    }

    public void setCampaignDescription8(String campaignDescription8) {
        this.campaignDescription8 = campaignDescription8;
    }

    public String getCampaign9() {
        return campaign9;
    }

    public void setCampaign9(String campaign9) {
        this.campaign9 = campaign9;
    }

    public String getCampaignCode9() {
        return campaignCode9;
    }

    public void setCampaignCode9(String campaignCode9) {
        this.campaignCode9 = campaignCode9;
    }

    public String getCampaignDescription9() {
        return campaignDescription9;
    }

    public void setCampaignDescription9(String campaignDescription9) {
        this.campaignDescription9 = campaignDescription9;
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

    public String getCampaign1() {

        return campaign1;
    }

    public void setCampaign1(String campaign) {

        this.campaign1 = campaign;
    }

    public String getCampaignCode1() {

        return campaignCode1;
    }

    public void setCampaignCode1(String campaignCode) {

        this.campaignCode1 = campaignCode;
    }

    public String getCampaignDescription1() {

        return campaignDescription1;
    }

    public void setCampaignDescription1(String campaignDescription) {

        this.campaignDescription1 = campaignDescription;
    }

    public String getCampaignFlag() {

        return campaignFlag;
    }

    public void setCampaignFlag(String campaignFlag) {

        this.campaignFlag = campaignFlag;
    }

    public GetDetailBySubscriberIdDAO() {
    }

    public GetDetailBySubscriberIdDAO(String spmCampaignFlag, String openEscalationFlag, String openSrFlag, String srRepeatFlag,
            String openWoFlag, String woRepeatFlag, String productType, String subscriptionType, String campaign1,
            String campaignCode1, String campaignDescription1, String campaign2, String campaignCode2, String campaignDescription2,
            String campaign3, String campaignCode3, String campaignDescription3, String campaignFlag, String repeatPackCount,
            String repeatRechargeCount, String spmPackName, String spmCampaignId, String callCountbySubscriberId,
            String subscriberAgentRepeatFlag, String subscriberIVRRepeatFlag, String activationDate, String differenceInDays,
            String isSensitive, String ivrSRType, String isIvrOpenSR, String ivrWOType, String isIvrOpenWO, String srCreatedDate,
            String ivrSRNumber, String woSheduledDateTime, String ivrWONumber, String ivrWOStatus, String ivrSRStatus,
            String woCreatedDate, String campaign4, String campaignCode4, String campaignDescription4, String campaign5,
            String campaignCode5, String campaignDescription5, String campaign6, String campaignCode6, String campaignDescription6,
            String campaign7, String campaignCode7, String campaignDescription7, String campaign8, String campaignCode8,
            String campaignDescription8, String campaign9, String campaignCode9, String campaignDescription9) {



        this.spmCampaignFlag = spmCampaignFlag;

        this.openEscalationFlag = openEscalationFlag;

        this.openSrFlag = openSrFlag;

        this.srRepeatFlag = srRepeatFlag;

        this.openWoFlag = openWoFlag;

        this.woRepeatFlag = woRepeatFlag;

        this.productType = productType;

        this.subscriptionType = subscriptionType;

        this.campaign1 = campaign1;

        this.campaignCode1 = campaignCode1;

        this.campaignDescription1 = campaignDescription1;

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

        this.ivrSRType = ivrSRType;

        this.isIvrOpenSR = isIvrOpenSR;

        this.ivrWOType = ivrWOType;

        this.isIvrOpenWO = isIvrOpenWO;

        this.srCreatedDate = srCreatedDate;

        this.ivrSRNumber = ivrSRNumber;

        this.woSheduledDateTime = woSheduledDateTime;

        this.ivrWONumber = ivrWONumber;

        this.ivrSRStatus = ivrSRStatus;

        this.ivrWOStatus = ivrWOStatus;

        this.woCreatedDate = woCreatedDate;

        this.campaign4 = campaign4;

        this.campaignCode4 = campaignCode4;

        this.campaignDescription4 = campaignDescription4;

        this.campaign5 = campaign5;

        this.campaignCode5 = campaignCode5;

        this.campaignDescription5 = campaignDescription5;

        this.campaign6 = campaign6;

        this.campaignCode6 = campaignCode6;

        this.campaignDescription6 = campaignDescription6;

        this.campaign7 = campaign7;

        this.campaignCode7 = campaignCode7;

        this.campaignDescription7 = campaignDescription7;

        this.campaign8 = campaign8;

        this.campaignCode8 = campaignCode8;

        this.campaignDescription8 = campaignDescription8;

        this.campaign9 = campaign9;

        this.campaignCode9 = campaignCode9;

        this.campaignDescription9 = campaignDescription9;

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

                ivrSRType = rs.getString("IVRSRTYPE");

                isIvrOpenSR = rs.getString("ISIVROPENSR");

                srCreatedDate = rs.getString("SRCREATEDDATETIME");

                ivrSRNumber = rs.getString("IVRSR_NUMBER");

                ivrSRStatus = rs.getString("STATUS");

            }

            rs = ((OracleCallableStatement) callableStatement).getCursor(7);

            while (rs.next()) {

                openWoFlag = rs.getString("ISOPENWO");

                woRepeatFlag = rs.getString("ISREPEATWO");

            }

            rs = ((OracleCallableStatement) callableStatement).getCursor(8);

            while (rs.next()) {

                ivrWOType = rs.getString("IVRWOTYPE");

                isIvrOpenWO = rs.getString("ISIVROPENWO");

                woSheduledDateTime = rs.getString("WOSCHEDULEDDATETIME");

                ivrWONumber = rs.getString("IVRWO_NUMBER");

                ivrWOStatus = rs.getString("WOSTATUS");

                woCreatedDate = rs.getString("WOCREATEDDATE");

            }

            rs = ((OracleCallableStatement) callableStatement).getCursor(9);

            while (rs.next()) {

                repeatPackCount = rs.getString("RPTPACKCOUNT");

                repeatRechargeCount = rs.getString("RPTRECHARGECOUNT");

                callCountbySubscriberId = rs.getString("DAYREPEATCOUNT");

                subscriberAgentRepeatFlag = rs.getString("ISSUBCAGENTREPEATFLAG");

                subscriberIVRRepeatFlag = rs.getString("ISSUBCIVRREPEATFLAG");
            }

            rs = ((OracleCallableStatement) callableStatement).getCursor(10);

            int i = 0;

            try {

                while (rs.next()) {

                    arrCampaign[i] = rs.getString("CAMPAIGNNAME");

                    arrCampaignCode[i] = rs.getString("CAMPAIGNCODE");

                    arrCampaignDesc[i] = rs.getString("CAMPAIGNDESC");

                    campaignFlag = rs.getString("CAMPAIGNFLAG");

                    i++;

                }
            } catch (Exception e) {

                Logger.error(dbCallDetailId, "Exception in 11th Cursor : " + e.getMessage(), false);

            }

            for (int k = 0; k < arrCampaign.length; k++) {

                if (arrCampaign[k] == null) {
                    arrCampaign[k] = "";
                    arrCampaignCode[k] = "";
                    arrCampaignDesc[k] = "";
                }
            }

            for (int j = 0; j < arrCampaign.length; j++) {

                if (arrCampaign[j].equalsIgnoreCase("CAM1")) {

                    campaign1 = arrCampaign[j];
                    campaignCode1 = arrCampaignCode[j];
                    campaignDescription1 = arrCampaignDesc[j];

                } else if (arrCampaign[j].equalsIgnoreCase("CAM2")) {

                    campaign2 = arrCampaign[j];
                    campaignCode2 = arrCampaignCode[j];
                    campaignDescription2 = arrCampaignDesc[j];

                } else if (arrCampaign[j].equalsIgnoreCase("CAM3")) {

                    campaign3 = arrCampaign[j];
                    campaignCode3 = arrCampaignCode[j];
                    campaignDescription3 = arrCampaignDesc[j];

                } else if (arrCampaign[j].equalsIgnoreCase("CAM4")) {

                    campaign4 = arrCampaign[j];
                    campaignCode4 = arrCampaignCode[j];
                    campaignDescription4 = arrCampaignDesc[j];

                } else if (arrCampaign[j].equalsIgnoreCase("CAM5")) {

                    campaign5 = arrCampaign[j];
                    campaignCode5 = arrCampaignCode[j];
                    campaignDescription5 = arrCampaignDesc[j];

                } else if (arrCampaign[j].equalsIgnoreCase("CAM6")) {

                    campaign6 = arrCampaign[j];
                    campaignCode6 = arrCampaignCode[j];
                    campaignDescription6 = arrCampaignDesc[j];

                } else if (arrCampaign[j].equalsIgnoreCase("CAM7")) {

                    campaign7 = arrCampaign[j];
                    campaignCode7 = arrCampaignCode[j];
                    campaignDescription7 = arrCampaignDesc[j];

                } else if (arrCampaign[j].equalsIgnoreCase("CAM8")) {

                    campaign8 = arrCampaign[j];
                    campaignCode8 = arrCampaignCode[j];
                    campaignDescription8 = arrCampaignDesc[j];

                } else if (arrCampaign[j].equalsIgnoreCase("CAM9")) {

                    campaign9 = arrCampaign[j];
                    campaignCode9 = arrCampaignCode[j];
                    campaignDescription9 = arrCampaignDesc[j];

                }

            }
            GetDetailBySubscriberIdDAO getDetailBySubscriberIdobj = new GetDetailBySubscriberIdDAO(spmCampaignFlag, openEscalationFlag, openSrFlag,
                    srRepeatFlag, openWoFlag, woRepeatFlag, productType, subscriptionType, campaign1, campaignCode1, campaignDescription1,
                    campaign2, campaignCode2, campaignDescription2, campaign3, campaignCode3, campaignDescription3, campaignFlag,
                    repeatPackCount, repeatRechargeCount, spmPackName, spmCampaignId, callCountbySubscriberId,
                    subscriberAgentRepeatFlag, subscriberIVRRepeatFlag, activationDate, differenceInDays, isSensitive, ivrSRType, isIvrOpenSR,
                    ivrWOType, isIvrOpenWO, srCreatedDate, ivrSRNumber, woSheduledDateTime, ivrWONumber, ivrWOStatus, ivrSRStatus, woCreatedDate,
                    campaign4, campaignCode4, campaignDescription4, campaign5, campaignCode5, campaignDescription5, campaign6, campaignCode6,
                    campaignDescription6, campaign7, campaignCode7, campaignDescription7, campaign8, campaignCode8, campaignDescription8,
                    campaign9, campaignCode9, campaignDescription9);

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

        Logger.info(dbCallDetailId, " spmCampaignFlag : " + spmCampaignFlag + " openEscalationFlag : " + openEscalationFlag 
                + " openSrFlag : " + openSrFlag + " srRepeatFlag : " + srRepeatFlag + " openWoFlag : " + openWoFlag  
                + " woRepeatFlag : " + woRepeatFlag + " productType : " + productType + " subscriptionType : " + subscriptionType  
                + " campaign1 : " + campaign1 + " campaignCode1 : " + campaignCode1 + " campaignDescription1 : " + campaignDescription1  
                + " Campaign2 : " + campaign2 + " CampaignCode2 : " + campaignCode2 + " CampaignDescription2 : " + campaignDescription2
                + " Campaign3 : " + campaign3 + " CampaignCode3 : " + campaignCode3 + " CampaignDescription3 : " + campaignDescription3
                + " campaignFlag :" + campaignFlag + " subscriberIVRRepeatFlag :" + subscriberIVRRepeatFlag 
                + " subscriberAgentRepeatFlag" + subscriberAgentRepeatFlag + " repeatPackCount :" + repeatPackCount 
                + " repeatRechargeCount :" + repeatRechargeCount + " Call Count by SubscriberId : " + callCountbySubscriberId 
                + " Spm Campaign Id : " + spmCampaignId + " Spm Pack Name : " + spmPackName + " Activatioin Date : " + activationDate 
                + " Difference In Days : " + differenceInDays + "Is Sensitive : " + isSensitive + " IvrSRType :" + ivrSRType 
                + " IsIvrOpenSR :" + isIvrOpenSR + " IvrWOType :" + ivrWOType + " IsIvrOpenWO : " + isIvrOpenWO 
                + "  SR_CreatedDate :  " + srCreatedDate + "  IVRSRNumber : " + ivrSRNumber + "  WO_ShecduledTime : " + woSheduledDateTime
                + " IVR WO Number : " + ivrWONumber + " IVR WO Status : " + ivrWOStatus + " IVR SR Status : " + ivrSRStatus 
                + "WO Created Date : " + woCreatedDate, false);;

        dataCenter = spmCampaignFlag = openEscalationFlag = openSrFlag = srRepeatFlag = openWoFlag = woRepeatFlag =
                productType = subscriptionType = callCountbySubscriberId = spmCampaignId = subscriberIVRRepeatFlag =
                subscriberAgentRepeatFlag = spmPackName = differenceInDays = activationDate = isSensitive = ivrSRType = 
                isIvrOpenSR = ivrWOType = isIvrOpenWO = srCreatedDate = ivrSRNumber = woSheduledDateTime = ivrWONumber = 
                ivrWOStatus = ivrSRStatus = woCreatedDate = campaign1 = campaign2 = campaign3 = campaign4 = campaign5 =
                campaign6 = campaign7 = campaign8 = campaign9 = campaignCode1 = campaignCode2 = campaignCode3 = campaignCode4 = 
                campaignCode5 = campaignCode6 = campaignCode7 = campaignCode8 = campaignCode9 = campaignDescription1 = 
                campaignDescription2 = campaignDescription3 = campaignDescription4 = campaignDescription5 = campaignDescription6 =
                campaignDescription7 = campaignDescription8 = campaignDescription9 = campaignFlag = null;

        return detailBySubscriberIdList;
    }
}
