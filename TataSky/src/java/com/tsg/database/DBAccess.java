/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tsg.database;

import com.tsg.database.gg.dataaccess.GetAccountDetailDAO;
import com.tsg.database.gg.dataaccess.GetDetailBySubscriberIdDAO;
import com.tsg.database.gg.dataaccess.GetDetailBySubscriberIdDAO_Old;
import com.tsg.database.gg.dataaccess.GetPartnerDetailDAO;
import com.tsg.database.gg.dataaccess.GetProfileBySubscriberIdDAO;
import com.tsg.database.gg.dataaccess.GetStasStateCodeBySubscIdDAO;
import com.tsg.database.gg.dataaccess.GetSubscriberListByCliDAO;
import com.tsg.database.gg.dataaccess.GetSubscriberProfileByRmnDAO;
import com.tsg.database.gg.dataaccess.GetWorkOrderDetailsDAO;
import com.tsg.database.ivr.dataaccess.GetAgentRoutingDetailsDAO;
import com.tsg.database.ivr.dataaccess.GetLangTelecomCircleDAO;
import com.tsg.log.Logger;
import com.tsg.suggestedrecharge.SuggestedRecharge;
import com.tsg.xml.GenerateXml;
import java.util.ArrayList;
import java.util.Iterator;

/**
 *
 * @author Rajesh
 */
public class DBAccess {

    public String getSubscriberProfileByRmn(String callerId, String dbCallDetailId) {

        String getSubscriberProfileByRmnXML = "<XML>null</XML>";

        String callerType = "NonRMN";

        String primaryLanguage = null;

        String secondaryLanguage = null;

        String subIDCount = null;

        String prospectState = null;

        String premiumFlag = null;

        String premiumFlag1 = null;

        String accountStatus = null;

        String subscriberID = null;

        String accountSubStatus = null;

        String cliRepatFlag = null;

        String callCountByCLI = null;

        String firstName = null;

        String lastName = null;

        String activationDate = null;

        String differenceInDays = null;

        String actualCustomerClass = null;

        String isSensitive = null;

        try {

            GetSubscriberProfileByRmnDAO getSubProfileByRmnDAO = new GetSubscriberProfileByRmnDAO();

            ArrayList subProfileRmnList = getSubProfileByRmnDAO.getSubscriberProfileByRmn(callerId, dbCallDetailId);

            Iterator subProfileRmnListItr = subProfileRmnList.iterator();

            while (subProfileRmnListItr.hasNext()) {

                getSubProfileByRmnDAO = (GetSubscriberProfileByRmnDAO) subProfileRmnListItr.next();

                callerType = getSubProfileByRmnDAO.getCallerType();

                primaryLanguage = getSubProfileByRmnDAO.getPrimaryLanguage();

                secondaryLanguage = getSubProfileByRmnDAO.getSecondaryLanguage();

                subIDCount = getSubProfileByRmnDAO.getSubIDCount();

                prospectState = getSubProfileByRmnDAO.getProspectState();

                premiumFlag = getSubProfileByRmnDAO.getPremiumFlag();

                premiumFlag1 = getSubProfileByRmnDAO.getPremiumFlag1();

                accountStatus = getSubProfileByRmnDAO.getAccountStatus();

                subscriberID = getSubProfileByRmnDAO.getSubscriberID();

                accountSubStatus = getSubProfileByRmnDAO.getAccountSubStatus();

                cliRepatFlag = getSubProfileByRmnDAO.getCliRepatFlag();

                callCountByCLI = getSubProfileByRmnDAO.getCallCountByCLI();

                firstName = getSubProfileByRmnDAO.getFirstName();

                lastName = getSubProfileByRmnDAO.getLastName();

                activationDate = getSubProfileByRmnDAO.getActivationDate();

                differenceInDays = getSubProfileByRmnDAO.getDifferenceInDays();

                actualCustomerClass = getSubProfileByRmnDAO.getActualCustomerClass();

                isSensitive = getSubProfileByRmnDAO.getIsSensitive();

            }

            if (callerType.equalsIgnoreCase("Partner")) {

                try {

                    primaryLanguage = getPartnerDetailMobile(callerId, dbCallDetailId);

                    primaryLanguage = primaryLanguage.substring(primaryLanguage.indexOf("<BA_PRIMARY_LANGUAGE>") + 21, primaryLanguage.indexOf("</BA_PRIMARY_LANGUAGE>"));

                } catch (Exception ex) {

                    primaryLanguage = null;

                    Logger.error(dbCallDetailId, " DBAccess Get Partner Detail Mobile Exception : " + callerId + " Message : " + ex.getMessage(), false);

                }
            }

        } catch (Exception ex) {

            Logger.error(dbCallDetailId, " DBAccess Get Subscriber Profile By Rmn Exception : " + callerId + " Message : " + ex.getMessage(), false);

        }

        getSubscriberProfileByRmnXML = new GenerateXml().requestSubProfileByRmn(callerType, subIDCount, subscriberID, accountStatus, accountSubStatus, primaryLanguage, secondaryLanguage,
                premiumFlag, prospectState, cliRepatFlag, premiumFlag1, callCountByCLI, firstName, lastName, activationDate,
                differenceInDays, actualCustomerClass, isSensitive, dbCallDetailId);

        getSubscriberProfileByRmnXML = getSubscriberProfileByRmnXML.replaceAll("null", "");

        Logger.info(dbCallDetailId, " Caller Id : " + callerId + " Get Subscriber Profile By Rmn : " + getSubscriberProfileByRmnXML, false);

        callerId = dbCallDetailId = callerType = subIDCount = subscriberID = accountStatus = accountSubStatus =
                primaryLanguage = secondaryLanguage = premiumFlag = prospectState = cliRepatFlag = firstName =
                lastName = differenceInDays = activationDate = actualCustomerClass = isSensitive = null;

        return getSubscriberProfileByRmnXML;
    }

    public String getProfileBySubscriberId(String subscriberId, String dbCallDetailId) {

        String profileBySubscriberIdXml = "<XML>null</XML>";

        String primaryLanguage = null;

        String secondaryLanguage = null;

        String premiumFlag = null;

        String premiumFlag1 = null;

        String accountStatus = null;

        String subscriberID = null;

        String accountSubStatus = null;

        String subscriptionType = null;

        String firstName = null;

        String lastName = null;

        String activationDate = null;

        String differenceInDays = null;

        String actualCustomerClass = null;

        String isSensitive = null;

        try {

            GetProfileBySubscriberIdDAO getProfileBySubscriberIdDAO = new GetProfileBySubscriberIdDAO();

            ArrayList profileBySubList = getProfileBySubscriberIdDAO.getProfileBySubscriberId(subscriberId, dbCallDetailId);

            Iterator profileBySubItr = profileBySubList.iterator();

            while (profileBySubItr.hasNext()) {

                getProfileBySubscriberIdDAO = (GetProfileBySubscriberIdDAO) profileBySubItr.next();

                primaryLanguage = getProfileBySubscriberIdDAO.getPrimaryLanguage();

                secondaryLanguage = getProfileBySubscriberIdDAO.getSecondaryLanguage();

                premiumFlag = getProfileBySubscriberIdDAO.getPremiumFlag();

                premiumFlag1 = getProfileBySubscriberIdDAO.getPremiumFlag1();

                accountStatus = getProfileBySubscriberIdDAO.getAccountStatus();

                subscriberID = getProfileBySubscriberIdDAO.getSubscriberId();

                accountSubStatus = getProfileBySubscriberIdDAO.getSubscriptionSubStatus();

                subscriptionType = getProfileBySubscriberIdDAO.getSubscriptionType();

                firstName = getProfileBySubscriberIdDAO.getFirstName();

                lastName = getProfileBySubscriberIdDAO.getLastName();

                activationDate = getProfileBySubscriberIdDAO.getActivationDate();

                differenceInDays = getProfileBySubscriberIdDAO.getDifferenceInDays();

                actualCustomerClass = getProfileBySubscriberIdDAO.getActualCustomerClass();

                isSensitive = getProfileBySubscriberIdDAO.getIsSensitive();

            }

        } catch (Exception ex) {

            Logger.error(dbCallDetailId, " DBAccess Get Profile By SubscriberId Exception " + ex.getMessage(), false);
        }

        profileBySubscriberIdXml = new GenerateXml().requestProfileBySubscriberId(subscriberID, accountStatus, accountSubStatus,
                primaryLanguage, secondaryLanguage, premiumFlag, premiumFlag1, subscriptionType, firstName, lastName,
                activationDate, differenceInDays, actualCustomerClass, isSensitive, dbCallDetailId);

        profileBySubscriberIdXml = profileBySubscriberIdXml.replaceAll("null", "");

        Logger.info(dbCallDetailId, " Subscriber Id : " + subscriberId + " Get Profile By SubscriberId : " + profileBySubscriberIdXml, false);

        dbCallDetailId = subscriberId = subscriberID = accountStatus = accountSubStatus = primaryLanguage = secondaryLanguage =
                premiumFlag = premiumFlag1 = subscriptionType = firstName = lastName = differenceInDays = activationDate =
                actualCustomerClass = isSensitive = null;

        return profileBySubscriberIdXml;
    }

    public String getStasStateCodeBySubscId(String subscriberId, String dbCallDetailId) {

        String stateCodeBySubcIdXml = "<XML>null</XML>";

        String pinCode = null;

        String state = null;

        try {

            GetStasStateCodeBySubscIdDAO getStasStateCodeBySubscIdDAO = new GetStasStateCodeBySubscIdDAO();

            ArrayList stateCodeList = getStasStateCodeBySubscIdDAO.getStasStateCodeBySubscId(subscriberId, dbCallDetailId);

            Iterator stateCodeItr = stateCodeList.iterator();

            while (stateCodeItr.hasNext()) {

                getStasStateCodeBySubscIdDAO = (GetStasStateCodeBySubscIdDAO) stateCodeItr.next();

                pinCode = getStasStateCodeBySubscIdDAO.getPinCode();

                state = getStasStateCodeBySubscIdDAO.getState();

            }

        } catch (Exception ex) {

            Logger.error(dbCallDetailId, " DBAccess Get Stas State Code By SubscriberId Exception " + ex.getMessage(), false);
        }

        stateCodeBySubcIdXml = new GenerateXml().requestStasStateCodeBySubscId(pinCode, state);

        stateCodeBySubcIdXml = stateCodeBySubcIdXml.replaceAll("null", "");

        Logger.info(dbCallDetailId, " Subscriber Id : " + subscriberId + " Get Stas State Code By SubscriberId " + stateCodeBySubcIdXml, false);

        dbCallDetailId = subscriberId = state = pinCode = null;

        return stateCodeBySubcIdXml;
    }

    public String getWorkOrderDetails(String subscriberId, String dbCallDetailId) {

        String workOrderDetailsXml = "<XML>null</XML>";

        String workOrderNumber = null;

        String workOrderStatus = null;

        String workOrderScheduledDate = null;

        try {

            GetWorkOrderDetailsDAO getWorkOrderDetailsDAO = new GetWorkOrderDetailsDAO();

            ArrayList stateCodeList = getWorkOrderDetailsDAO.getWorkOrderDetails(subscriberId, dbCallDetailId);

            Iterator stateCodeItr = stateCodeList.iterator();

            while (stateCodeItr.hasNext()) {

                getWorkOrderDetailsDAO = (GetWorkOrderDetailsDAO) stateCodeItr.next();

                workOrderNumber = getWorkOrderDetailsDAO.getWorkOrderNumber();

                workOrderStatus = getWorkOrderDetailsDAO.getWorkOrderStatus();

                workOrderScheduledDate = getWorkOrderDetailsDAO.getWorkOrderScheduledDate();
            }

        } catch (Exception ex) {

            Logger.error(dbCallDetailId, " DBAccess Get WorkOrder Details Exception " + ex.getMessage(), false);
        }

        workOrderDetailsXml = new GenerateXml().requestgetWorkOrderDetails(workOrderNumber, workOrderStatus, workOrderScheduledDate);

        workOrderDetailsXml = workOrderDetailsXml.replaceAll("null", "");

        Logger.info(dbCallDetailId, " Subscriber Id : " + subscriberId + " Get WorkOrder Details " + workOrderDetailsXml, false);

        dbCallDetailId = subscriberId = workOrderStatus = workOrderNumber = workOrderScheduledDate = null;

        return workOrderDetailsXml;
    }

    public String getPartnerDetailMobile(String id, String dbCallDetailId) {

        String partnerDetailsMobileXml = "<XML>null</XML>";

        String partnerType = null;

        String partnerId = null;

        String tslPrimaryLanguage = null;

        String status = null;

        String state = null;

        String zipcode = null;

        String partnerRepeat = null;

        String actualPartnerType = null;

        try {

            GetPartnerDetailDAO getPartnerDetailDAO = new GetPartnerDetailDAO();

            ArrayList partnerDetailsMobileList = getPartnerDetailDAO.getPartnerDetailMobile(id, dbCallDetailId);

            Iterator partnerDetailsMobileItr = partnerDetailsMobileList.iterator();

            while (partnerDetailsMobileItr.hasNext()) {

                getPartnerDetailDAO = (GetPartnerDetailDAO) partnerDetailsMobileItr.next();

                partnerType = getPartnerDetailDAO.getPartnerType();

                partnerId = getPartnerDetailDAO.getPartnerId();

                tslPrimaryLanguage = getPartnerDetailDAO.getTslPrimaryLanguage();

                status = getPartnerDetailDAO.getStatus();

                state = getPartnerDetailDAO.getState();

                zipcode = getPartnerDetailDAO.getZipcode();

                partnerRepeat = getPartnerDetailDAO.getPartnerRepeat();

                actualPartnerType = getPartnerDetailDAO.getActualPartnerType();

            }

        } catch (Exception ex) {

            Logger.error(dbCallDetailId, " DBAccess Get Partner Detail Mobile Exception " + ex.getMessage(), false);
        }

        partnerDetailsMobileXml = new GenerateXml().requestgetPartnerDetail(partnerType, partnerId,
                tslPrimaryLanguage, status, state, zipcode, partnerRepeat, actualPartnerType);

        partnerDetailsMobileXml = partnerDetailsMobileXml.replaceAll("null", "");

        Logger.info(dbCallDetailId, " Partner Mobile : " + id + " Get Partner Detail Mobile " + partnerDetailsMobileXml, false);

        dbCallDetailId = id = partnerId = partnerType = tslPrimaryLanguage = status = state = zipcode = partnerRepeat = actualPartnerType = null;

        return partnerDetailsMobileXml;
    }

    public String getPartnerDetailId(String id, String dbCallDetailId) {

        String partnerDetailsIdXml = "<XML>null</XML>";

        String partnerType = null;

        String partnerId = null;

        String tslPrimaryLanguage = null;

        String status = null;

        String state = null;

        String zipcode = null;

        String partnerRepeat = null;

        String actualPartnerType = null;

        try {

            GetPartnerDetailDAO getPartnerDetailDAO = new GetPartnerDetailDAO();

            ArrayList partnerDetailsMobileList = getPartnerDetailDAO.getPartnerDetailId(id, dbCallDetailId);

            Iterator partnerDetailsMobileItr = partnerDetailsMobileList.iterator();

            while (partnerDetailsMobileItr.hasNext()) {

                getPartnerDetailDAO = (GetPartnerDetailDAO) partnerDetailsMobileItr.next();

                partnerType = getPartnerDetailDAO.getPartnerType();

                partnerId = getPartnerDetailDAO.getPartnerId();

                tslPrimaryLanguage = getPartnerDetailDAO.getTslPrimaryLanguage();

                status = getPartnerDetailDAO.getStatus();

                state = getPartnerDetailDAO.getState();

                zipcode = getPartnerDetailDAO.getZipcode();

                partnerRepeat = getPartnerDetailDAO.getPartnerRepeat();

                actualPartnerType = getPartnerDetailDAO.getActualPartnerType();
            }

        } catch (Exception ex) {

            Logger.error(dbCallDetailId, " DBAccess Get Partner Detail Id Exception " + ex.getMessage(), false);
        }

        partnerDetailsIdXml = new GenerateXml().requestgetPartnerDetail(partnerType, partnerId,
                tslPrimaryLanguage, status, state, zipcode, partnerRepeat, actualPartnerType);

        partnerDetailsIdXml = partnerDetailsIdXml.replaceAll("null", "");

        Logger.info(dbCallDetailId, " Subscriber Id : " + id + " Get Partner Detail Id " + partnerDetailsIdXml, false);

        dbCallDetailId = id = partnerId = partnerType = tslPrimaryLanguage = status = state = zipcode = partnerRepeat = actualPartnerType = null;

        return partnerDetailsIdXml;
    }

    public String getAccountDetail(String subscriberId, String dbCallDetailId) {

        String getAccountDetailXml = "<BA_ACCOUNT_BALANCE>null</BA_ACCOUNT_BALANCE><BA_RECHARGE_DUE_DATE>null</BA_RECHARGE_DUE_DATE><BA_FDP_RENEW_DATE>null</BA_FDP_RENEW_DATE><BA_LAST_RECHARGE_DATETIME>null</BA_LAST_RECHARGE_DATETIME><BA_LAST_RECHARGE_AMT>null</BA_LAST_RECHARGE_AMT><BA_SUGGESTED_RECHARGE>null</BA_SUGGESTED_RECHARGE>";

        String accountBal = null;

        String dueDate = null;

        String renewDate = null;

        String lastRechargeDateTime = null;

        String lastRechargeAmount = null;

        String suggestedRechargeAmount = "0";

        try {

            GetAccountDetailDAO getAccountDetailDAO = new GetAccountDetailDAO();

            ArrayList getAccountDetailList = getAccountDetailDAO.getAccountDetail(subscriberId, dbCallDetailId);

            Iterator getAccountDetailItr = getAccountDetailList.iterator();

            while (getAccountDetailItr.hasNext()) {

                getAccountDetailDAO = (GetAccountDetailDAO) getAccountDetailItr.next();

                accountBal = getAccountDetailDAO.getAccountBal();

                dueDate = getAccountDetailDAO.getDueDate();

                renewDate = getAccountDetailDAO.getRenewDate();

                lastRechargeDateTime = getAccountDetailDAO.getLastRechargeDateTime();

                lastRechargeAmount = getAccountDetailDAO.getLastRechargeAmount();

                suggestedRechargeAmount = getAccountDetailDAO.getSuggestedRechargeAmount();

            }

            if ((suggestedRechargeAmount.equals("0")) || (suggestedRechargeAmount.isEmpty())) {

                try {

                    SuggestedRecharge suggestedRecharge = new SuggestedRecharge();

                    suggestedRechargeAmount = suggestedRecharge.SuggestedRechargeAmount(subscriberId, dbCallDetailId);

                    if (suggestedRechargeAmount.equals("0.0")) {

                        suggestedRechargeAmount = "0";
                    }

                } catch (Exception ex) {

                    Logger.error(dbCallDetailId, " Exception in Get Account Detail Page :" + subscriberId + " Message : " + ex.getMessage(), false);
                }

            }

        } catch (Exception ex) {

            Logger.error(dbCallDetailId, " DBAccess Get Account Detail Exception " + ex.getMessage(), false);
        }

        getAccountDetailXml = new GenerateXml().requestgetAccountDetail(accountBal, dueDate,
                renewDate, lastRechargeDateTime, lastRechargeAmount, suggestedRechargeAmount);

        getAccountDetailXml = getAccountDetailXml.replaceAll("null", "");

        Logger.info(dbCallDetailId, " Subscriber Id : " + subscriberId + " Get Account Detail " + getAccountDetailXml, false);

        dbCallDetailId = subscriberId = accountBal = dueDate = renewDate = lastRechargeDateTime = lastRechargeAmount = suggestedRechargeAmount = null;

        return getAccountDetailXml;
    }

    public String getDetailBySubscriberId(String subscriberId, String premiumFlag, String dbCallDetailId) {

        String getDetailBySubscriberIdXml = "<XML>null</XML>";

        String spmCampaignFlag = null;

        String openEscalationFlag = null;

        String openSrFlag = null;

        String srRepeatFlag = null;

        String openWoFlag = null;

        String woRepeatFlag = null;

        String productType = null;

        String subscriptionType = null;

        String campaign1 = null;

        String campaignCode1 = null;

        String campaignDescription1 = null;

        String campaign2 = null;

        String campaignCode2 = null;

        String campaignDescription2 = null;

        String campaign3 = null;

        String campaignCode3 = null;

        String campaignDescription3 = null;
        
        String campaign4 = null;

        String campaignCode4 = null;

        String campaignDescription4 = null;
        
        String campaign5 = null;

        String campaignCode5 = null;

        String campaignDescription5 = null;
        
        String campaign6 = null;

        String campaignCode6 = null;

        String campaignDescription6 = null;
        
        String campaign7 = null;

        String campaignCode7 = null;

        String campaignDescription7 = null;
        
        String campaign8 = null;

        String campaignCode8 = null;

        String campaignDescription8 = null;
        
        String campaign9 = null;

        String campaignCode9 = null;

        String campaignDescription9 = null;

        String campaignFlag = null;

        String repeatPackCount = null;

        String repeatRechargeCount = null;

        String spmPackName = null;

        String spmCampaignId = null;

        String callCountbySubscriberId = null;

        String subscriberAgentRepeatFlag = null;

        String subscriberIVRRepeatFlag = null;

        String activationDate = null;

        String differenceInDays = null;

        String isSensitive = null;

        String ivrSRType = null;

        String isIvrOpenSR = null;

        String ivrWOType = null;

        String isIvrOpenWO = null;

        String srCreatedDate = null;
        
        String ivrSRNumber = null;
        
        String woSheduledDateTime = null;
        
        String ivrWONumber = null;
        
        String ivrWOStatus = null;
        
        String ivrSRStatus = null;
        
        String woCreatedDate = null;

        try {

            GetDetailBySubscriberIdDAO getDetailBySubscriberIdDAO = new GetDetailBySubscriberIdDAO();

            ArrayList getDetailBySubscriberIdList = getDetailBySubscriberIdDAO.getDetailBySubscriberId(subscriberId, premiumFlag, dbCallDetailId);

            Iterator getDetailBySubscriberIdListItr = getDetailBySubscriberIdList.iterator();

            while (getDetailBySubscriberIdListItr.hasNext()) {

                getDetailBySubscriberIdDAO = (GetDetailBySubscriberIdDAO) getDetailBySubscriberIdListItr.next();

                spmCampaignFlag = getDetailBySubscriberIdDAO.getSpmCampaignFlag();

                spmCampaignFlag = (!spmCampaignFlag.equals("")) ? spmCampaignFlag : "N";

                openEscalationFlag = getDetailBySubscriberIdDAO.getOpenEscalationFlag();

                openEscalationFlag = (!openEscalationFlag.equals("")) ? openEscalationFlag : "N";

                openSrFlag = getDetailBySubscriberIdDAO.getOpenSrFlag();

                openSrFlag = (!openSrFlag.equals("")) ? openSrFlag : "N";

                srRepeatFlag = getDetailBySubscriberIdDAO.getSrRepeatFlag();

                srRepeatFlag = (!srRepeatFlag.equals("")) ? srRepeatFlag : "N";

                openWoFlag = getDetailBySubscriberIdDAO.getOpenWoFlag();

                openWoFlag = (!openWoFlag.equals("")) ? openWoFlag : "N";

                woRepeatFlag = getDetailBySubscriberIdDAO.getOpenWoFlag();

                woRepeatFlag = (!woRepeatFlag.equals("")) ? woRepeatFlag : "N";

                productType = getDetailBySubscriberIdDAO.getProductType();

                subscriptionType = getDetailBySubscriberIdDAO.getSubscriptionType();

                campaign1 = getDetailBySubscriberIdDAO.getCampaign1();

                campaignCode1 = getDetailBySubscriberIdDAO.getCampaignCode1();

                campaignDescription1 = getDetailBySubscriberIdDAO.getCampaignDescription1();

                campaign2 = getDetailBySubscriberIdDAO.getCampaign2();

                campaignCode2 = getDetailBySubscriberIdDAO.getCampaignCode2();

                campaignDescription2 = getDetailBySubscriberIdDAO.getCampaignDescription2();

                campaign3 = getDetailBySubscriberIdDAO.getCampaign3();

                campaignCode3 = getDetailBySubscriberIdDAO.getCampaignCode3();

                campaignDescription3 = getDetailBySubscriberIdDAO.getCampaignDescription3();
                
                campaign4 = getDetailBySubscriberIdDAO.getCampaign4();

                campaignCode4 = getDetailBySubscriberIdDAO.getCampaignCode4();

                campaignDescription4 = getDetailBySubscriberIdDAO.getCampaignDescription4();
                
                campaign5 = getDetailBySubscriberIdDAO.getCampaign5();

                campaignCode5 = getDetailBySubscriberIdDAO.getCampaignCode5();

                campaignDescription5 = getDetailBySubscriberIdDAO.getCampaignDescription5();
                
                campaign6 = getDetailBySubscriberIdDAO.getCampaign6();

                campaignCode6 = getDetailBySubscriberIdDAO.getCampaignCode6();

                campaignDescription6 = getDetailBySubscriberIdDAO.getCampaignDescription6();
                
                campaign7 = getDetailBySubscriberIdDAO.getCampaign7();

                campaignCode7 = getDetailBySubscriberIdDAO.getCampaignCode7();

                campaignDescription7 = getDetailBySubscriberIdDAO.getCampaignDescription7();
                
                campaign8 = getDetailBySubscriberIdDAO.getCampaign8();

                campaignCode8 = getDetailBySubscriberIdDAO.getCampaignCode8();

                campaignDescription8 = getDetailBySubscriberIdDAO.getCampaignDescription8();
                
                campaign9 = getDetailBySubscriberIdDAO.getCampaign9();

                campaignCode9 = getDetailBySubscriberIdDAO.getCampaignCode9();

                campaignDescription9 = getDetailBySubscriberIdDAO.getCampaignDescription9();

                campaignFlag = getDetailBySubscriberIdDAO.getCampaignFlag();

                campaignFlag = (!campaignFlag.equals("")) ? campaignFlag : "N";

                repeatPackCount = getDetailBySubscriberIdDAO.getRepeatPackCount();

                repeatRechargeCount = getDetailBySubscriberIdDAO.getRepeatRechargeCount();

                spmCampaignId = getDetailBySubscriberIdDAO.getSpmCampaignId();

                spmPackName = getDetailBySubscriberIdDAO.getSpmPackName();

                callCountbySubscriberId = getDetailBySubscriberIdDAO.getCallCountbySubscriberId();

                subscriberAgentRepeatFlag = getDetailBySubscriberIdDAO.getSubscriberAgentRepeatFlag();

                subscriberAgentRepeatFlag = (!subscriberAgentRepeatFlag.equals("")) ? subscriberAgentRepeatFlag : "N";

                subscriberIVRRepeatFlag = getDetailBySubscriberIdDAO.getSubscriberIVRRepeatFlag();

                subscriberIVRRepeatFlag = (!subscriberIVRRepeatFlag.trim().equals("")) ? subscriberIVRRepeatFlag : "N";

                activationDate = getDetailBySubscriberIdDAO.getActivationDate();

                differenceInDays = getDetailBySubscriberIdDAO.getDifferenceInDays();

                isSensitive = getDetailBySubscriberIdDAO.getIsSensitive();

                ivrSRType = getDetailBySubscriberIdDAO.getIvrSRType();

                isIvrOpenSR = getDetailBySubscriberIdDAO.getIsIvrOpenSR();

                ivrWOType = getDetailBySubscriberIdDAO.getIvrWOType();

                isIvrOpenWO = getDetailBySubscriberIdDAO.getIsIvrOpenWO();
                
                srCreatedDate = getDetailBySubscriberIdDAO.getSrCreatedDate();
                
                ivrSRNumber = getDetailBySubscriberIdDAO.getIvrSRNumber();
                
                woSheduledDateTime = getDetailBySubscriberIdDAO.getWoSheduledDateTime();
                
                ivrWONumber = getDetailBySubscriberIdDAO.getIvrWONumber();
                
                ivrWOStatus = getDetailBySubscriberIdDAO.getIvrWOStatus();
                
                ivrSRStatus = getDetailBySubscriberIdDAO.getIvrSRStatus();
                
                woCreatedDate = getDetailBySubscriberIdDAO.getWoCreatedDate();
            }

        } catch (Exception ex) {

            Logger.error(dbCallDetailId, " DBAccess Get Detail By SubscriberId Exception " + ex.getMessage(), false);
        }

        getDetailBySubscriberIdXml = new GenerateXml().requestGetDetailBySubscriberId(spmCampaignFlag, openEscalationFlag, openSrFlag,
                srRepeatFlag, openWoFlag, woRepeatFlag, productType, subscriptionType, campaign1, campaignCode1, campaignDescription1,
                campaign2, campaignCode2, campaignDescription2, campaign3, campaignCode3, campaignDescription3, campaignFlag, 
                repeatPackCount, repeatRechargeCount, spmPackName, spmCampaignId, callCountbySubscriberId, subscriberAgentRepeatFlag,
                subscriberIVRRepeatFlag, activationDate, differenceInDays, isSensitive, dbCallDetailId, ivrSRType, isIvrOpenSR,
                ivrWOType, isIvrOpenWO, srCreatedDate, ivrSRNumber, woSheduledDateTime, ivrWONumber, ivrWOStatus, ivrSRStatus, 
                woCreatedDate, campaign4, campaignCode4, campaignDescription4, campaign5, campaignCode5, campaignDescription5, 
                campaign6, campaignCode6, campaignDescription6, campaign7, campaignCode7, campaignDescription7, campaign8, 
                campaignCode8, campaignDescription8, campaign9, campaignCode9, campaignDescription9);

        getDetailBySubscriberIdXml = getDetailBySubscriberIdXml.replaceAll("null", "");

        Logger.info(dbCallDetailId, " Subscriber Id : " + subscriberId + " Get Detail By SubscriberId " + getDetailBySubscriberIdXml, false);

        dbCallDetailId = subscriberId = spmCampaignFlag = openEscalationFlag = openSrFlag = srRepeatFlag = openWoFlag =
                woRepeatFlag = productType = subscriptionType = campaignFlag = spmPackName = spmCampaignId = 
                callCountbySubscriberId = differenceInDays = activationDate = isSensitive = ivrSRType = isIvrOpenSR = ivrWOType =
                isIvrOpenWO = srCreatedDate = ivrSRNumber = woSheduledDateTime =  ivrWONumber = ivrWOStatus = ivrSRStatus = 
                woCreatedDate = campaign1 = campaign2 = campaign3 = campaign4 = campaign5 = campaign6 = campaign7 = campaign8 =
                campaign9 = campaignCode1 = campaignCode2 = campaignCode3 = campaignCode4 = campaignCode5 = campaignCode6 = 
                campaignCode7 = campaignCode8 = campaignCode9 = campaignDescription1 = campaignDescription2 = 
                campaignDescription3 = campaignDescription4 = campaignDescription5 = campaignDescription6 =
                campaignDescription7 = campaignDescription8 = campaignDescription9 = null;

        return getDetailBySubscriberIdXml;
    }

    public String getAgentRoutingDetails(String cli, String dbCallDetailId) {

        String agentRoutingDetailsXml = "<XML>null</XML>";

        String vag = null;

        String ivrExit = null;

        String primaryLanguage = null;

        String secondaryLanguage = null;

        try {

            GetAgentRoutingDetailsDAO getAgentRoutingDetailsDAO = new GetAgentRoutingDetailsDAO();

            ArrayList agentRoutingDetailsList = getAgentRoutingDetailsDAO.agentRoutingDetails(cli, dbCallDetailId);

            Iterator agentRoutingDetailsItr = agentRoutingDetailsList.iterator();

            while (agentRoutingDetailsItr.hasNext()) {

                getAgentRoutingDetailsDAO = (GetAgentRoutingDetailsDAO) agentRoutingDetailsItr.next();

                vag = getAgentRoutingDetailsDAO.getVag();

                ivrExit = getAgentRoutingDetailsDAO.getIvrExit();

                primaryLanguage = getAgentRoutingDetailsDAO.getPrimaryLanguage();

                secondaryLanguage = getAgentRoutingDetailsDAO.getSecondaryLanguage();

            }

        } catch (Exception ex) {

            Logger.error(dbCallDetailId, " DBAccess Get Agent Routing Details Exception " + ex.getMessage(), false);
        }

        agentRoutingDetailsXml = new GenerateXml().requestAgentRoutingDetails(vag, ivrExit, primaryLanguage, secondaryLanguage);

        agentRoutingDetailsXml = agentRoutingDetailsXml.replaceAll("null", "");

        Logger.info(dbCallDetailId, " CLI : " + cli + " Get Agent Routing Details " + agentRoutingDetailsXml, false);

        dbCallDetailId = vag = ivrExit = primaryLanguage = secondaryLanguage = null;

        return agentRoutingDetailsXml;
    }

    public String getLangCodeAndTelecomCircle(String dbCallDetailId, String callerType, String DNIS, String state) {

        String getTelecomCircleXml = "<BA_TELECOM_CIRCLE>NULL</BA_TELECOM_CIRCLE><BA_LANG_CODE>NULL</BA_LANG_CODE>";

        String telecomCircle = null;

        String langCode = null;

        try {

            GetLangTelecomCircleDAO getLangTelecomCircleDAO = new GetLangTelecomCircleDAO();

            ArrayList getTelecomList = getLangTelecomCircleDAO.getLangCodeAndTelecomCircle(dbCallDetailId, callerType, DNIS, state);

            Iterator getTelecomItr = getTelecomList.iterator();

            while (getTelecomItr.hasNext()) {

                getLangTelecomCircleDAO = (GetLangTelecomCircleDAO) getTelecomItr.next();

                telecomCircle = getLangTelecomCircleDAO.gettelecomCircle();

                langCode = getLangTelecomCircleDAO.getlangCode();

            }


        } catch (Exception ex) {

            Logger.error(dbCallDetailId, " DBAccess Get LangCode And TelecomCircle XML Exception " + ex.getMessage(), false);
        }

        getTelecomCircleXml = new GenerateXml().requestGetTelecomCircle(telecomCircle, langCode);

        getTelecomCircleXml = getTelecomCircleXml.replaceAll("null", "");

        Logger.info(dbCallDetailId, " Get Telecom Circle Xml : " + getTelecomCircleXml, false);

        telecomCircle = langCode = null;

        return getTelecomCircleXml;
    }

    public String getSubscriberListByCli(String callerId, String dbCallDetailId) {

        String getSubscriberListByCliXML = "<XML>null</XML>";

        String subscriberIdList = null;

        try {

            GetSubscriberListByCliDAO getSubscriberListByCliDao = new GetSubscriberListByCliDAO();

            ArrayList subListByCli = getSubscriberListByCliDao.getSubscriberListByCli(callerId, dbCallDetailId);

            Iterator subListByCliItr = subListByCli.iterator();

            while (subListByCliItr.hasNext()) {

                getSubscriberListByCliDao = (GetSubscriberListByCliDAO) subListByCliItr.next();

                subscriberIdList = getSubscriberListByCliDao.getSubscriberIdList();

            }

        } catch (Exception ex) {

            Logger.error(dbCallDetailId, " DBAccess Get Subscriber List By CLI Exception : " + callerId + " Message : " + ex.getMessage(), false);

        }

        getSubscriberListByCliXML = new GenerateXml().requestSubListByCli(subscriberIdList);

        getSubscriberListByCliXML = getSubscriberListByCliXML.replaceAll("null", "");

        Logger.info(dbCallDetailId, " Caller Id : " + callerId + " Get Subscriber List By Cli : " + getSubscriberListByCliXML, false);

        callerId = dbCallDetailId = subscriberIdList = null;

        return getSubscriberListByCliXML;

    }
}