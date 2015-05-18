/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tsg.xml;

/**
 *
 * @author Rajesh
 */
public class GenerateXml {

    public String requestTranscationDetail(String callDetailId, String serviceId,
            String transactionStartTime, String transactionEndTime, String transactionResponse,
            String transactionFailureReason, String transactionRequestXml,
            String transactionResponseXml) { //, String ivrUUId

        StringBuilder builder = new StringBuilder();
        //builder.append("<ROOT>");
        builder.append("<TBLTRANSACTIONDETAIL>");
        builder.append("<FLDCALLDETAILID>").append(callDetailId).append("</FLDCALLDETAILID>");
        builder.append("<FLDSERVICECODE>").append(serviceId).append("</FLDSERVICECODE>");
        builder.append("<FLDTRANSACTIONSTARTTIME>").append(transactionStartTime).append("</FLDTRANSACTIONSTARTTIME>");
        builder.append("<FLDTRANSACTIONENDTIME>").append(transactionEndTime).append("</FLDTRANSACTIONENDTIME>");
        builder.append("<FLDTRANSACTIONRESPONSE>").append(transactionResponse).append("</FLDTRANSACTIONRESPONSE>");
        builder.append("<FLDTRANSACTIONFAILUREREASON>").append(transactionFailureReason).append("</FLDTRANSACTIONFAILUREREASON>");
        builder.append("<FLDTRANSACTIONREQUESTXML>").append(transactionRequestXml).append("</FLDTRANSACTIONREQUESTXML>");
        builder.append("<FLDTRANSACTIONRESPONSEXML>").append(transactionResponseXml).append("</FLDTRANSACTIONRESPONSEXML>");
//        builder.append("<FLDIVRUUID>").append(callDetailId).append("</FLDIVRUUID>");
//        builder.append("<FLDIVRUUID>").append(callDetailId).append("</FLDIVRUUID>");
        builder.append("</TBLTRANSACTIONDETAIL>");
        builder.append("</TRANSACTIONROOT>");
        return new String(builder);
    }

    public String requestCreateIVRTranscation(String callDetailId,
            String cli, String connectionId, String subscriberId, String agentId,
            String ivrStartTime, String stage, String product, String atomUniqueId,
            String errorCode, String errorMessage) {

        StringBuilder builder = new StringBuilder();
//       / builder.append("<TATASKY>");
        builder.append("<CreateIVRTranscation>"); //<TBLPAYMENTGATEWAYDETAIL>
        builder.append("<FLDCALLDETAILID>").append(callDetailId).append("</FLDCALLDETAILID>");
        //builder.append("<FLDIVRTXNDETAILID>").append(ivrTxnDetailId).append("</FLDIVRTXNDETAILID>");
        builder.append("<FLDCLI>").append(cli).append("</FLDCLI>");
        //builder.append("<FLDDNIS>").append(dnis).append("</FLDDNIS>");
        builder.append("<FLDCONNECTIONID>").append(connectionId).append("</FLDCONNECTIONID>");
        builder.append("<FLDSUBSCRIBERID>").append(subscriberId).append("</FLDSUBSCRIBERID>");
        builder.append("<FLDAGENTID>").append(agentId).append("</FLDAGENTID>");
        builder.append("<FLDIVRSTARTTIME>").append(ivrStartTime).append("</FLDIVRSTARTTIME>");
        builder.append("<FLDSTATUS>").append(errorMessage).append("</FLDSTATUS>");
        builder.append("<FLDSTAGE>").append(stage).append("</FLDSTAGE>");
        builder.append("<FLDPRODUCT>").append(product).append("</FLDPRODUCT>");
        builder.append("<FLDATOMUNIQUEID>").append(atomUniqueId).append("</FLDATOMUNIQUEID>");
        builder.append("<FLDATOMTXNERRORCODE>").append(errorCode).append("</FLDATOMTXNERRORCODE>");
        builder.append("<FLDTXNERRORMESSAGE>").append(errorMessage).append("</FLDTXNERRORMESSAGE>");
        builder.append("<FLDATOMTXNCREATIONTIME>").append(ivrStartTime).append("</FLDATOMTXNCREATIONTIME>");
        builder.append("<FLDIVRUUID>").append(connectionId).append("</FLDIVRUUID>");
        builder.append("</CreateIVRTranscation>");
        builder.append("</PGTRANSACTIONROOT>");
        return new String(builder);
    }

    public String requestUpdateDSSRToAtom(String paymentGatewayDetailId, String atomTxnDetailId,
            String status, String stage, String paymentType, String atomUniqueId,
            String atomTxnErrorCode, String txnErrorMessage, String atomTxnCreationTime,
            String lastCallFlowDetailId) {

        StringBuilder builder = new StringBuilder();
        //builder.append("<TATASKY>");
        builder.append("<UpdateDSSRToAtom>"); //<TBLPAYMENTGATEWAYDETAIL>
        //builder.append("<FLDPAYMENTGATEWAYDETAILID>").append(paymentGatewayDetailId).append("</FLDPAYMENTGATEWAYDETAILID>");
        builder.append("<FLDATOMTXNDETAILID>").append(atomTxnDetailId).append("</FLDATOMTXNDETAILID>");
        builder.append("<FLDSTATUS>").append(status).append("</FLDSTATUS>");
        builder.append("<FLDSTAGE>").append(stage).append("</FLDSTAGE>");
        builder.append("<FLDPAYMENTTYPE>").append(paymentType).append("</FLDPAYMENTTYPE>");
        //builder.append("<FLDATOMUNIQUEID>").append(atomUniqueId).append("</FLDATOMUNIQUEID>");
        //builder.append("<FLDATOMTXNERRORCODE>").append(atomTxnErrorCode).append("</FLDATOMTXNERRORCODE>");
        //builder.append("<FLDTXNERRORMESSAGE>").append(txnErrorMessage).append("</FLDTXNERRORMESSAGE>");
        builder.append("<FLDATOMTXNCREATIONTIME>").append(atomTxnCreationTime).append("</FLDATOMTXNCREATIONTIME>");
        builder.append("<FLDLASTCALLFLOWDETAILID>").append(lastCallFlowDetailId).append("</FLDLASTCALLFLOWDETAILID>");
        builder.append("</UpdateDSSRToAtom>");
        builder.append("</PGTRANSACTIONROOT>");
        return new String(builder);
    }

    public String requestUpdateDirectSalesSRDetails(String paymentGatewayDetailId,
            String srTxnDetailId, String srNumber, String srResponseUpdateTime,
            String srType, String srArea, String srSubArea, String srPricePoint,
            String srDateTime, String srPersonalCity, String srPersonalCountry,
            String srPersonalState, String srPersonalStreetAddress, String srPersonalStreetAddress2,
            String srPersonalPostalCode, String srMobileNumber, String srPersonalIspCode, String srAmount,
            String srAgentId, String tataSkyTxnId, String lastCallFlowDetailId) {

        StringBuilder builder = new StringBuilder();
        //builder.append("<TATASKY>");
        builder.append("<UpdateDirectSalesSRDetails>"); //<TBLPAYMENTGATEWAYDETAIL>
        builder.append("<FLDPAYMENTGATEWAYDETAILID>").append(paymentGatewayDetailId).append("</FLDPAYMENTGATEWAYDETAILID>");
        //builder.append("<FLDSRTXNDETAILID>").append(srTxnDetailId).append("</FLDSRTXNDETAILID>");
        builder.append("<FLDSRNUMBER>").append(srNumber).append("</FLDSRNUMBER>");
        builder.append("<FLDSRRESPONSEUPDATETIME>").append(srResponseUpdateTime).append("</FLDSRRESPONSEUPDATETIME>");
        builder.append("<FLDSRTYPE>").append(srType).append("</FLDSRTYPE>");
        builder.append("<FLDSRAREA>").append(srArea).append("</FLDSRAREA>");
        builder.append("<FLDSRSUBAREA>").append(srSubArea).append("</FLDSRSUBAREA>");
        builder.append("<FLDSRPRICEPOINT>").append(srPricePoint).append("</FLDSRPRICEPOINT>");
        builder.append("<FLDSRDATETIME>").append(srDateTime).append("</FLDSRDATETIME>");
        builder.append("<FLDSRPERSONALCITY>").append(srPersonalCity).append("</FLDSRPERSONALCITY>");
        builder.append("<FLDSRPERSONALCOUNTRY>").append(srPersonalCountry).append("</FLDSRPERSONALCOUNTRY>");
        builder.append("<FLDSRPERSONALSTATE>").append(srPersonalState).append("</FLDSRPERSONALSTATE>");
        builder.append("<FLDSRPERSONALSTREETADDRESS>").append(srPersonalStreetAddress).append("</FLDSRPERSONALSTREETADDRESS>");
        builder.append("<FLDSRPERSONALSTREETADDRESS2>").append(srPersonalStreetAddress2).append("</FLDSRPERSONALSTREETADDRESS2>");
        builder.append("<FLDSRPERSONALPOSTALCODE>").append(srPersonalPostalCode).append("</FLDSRPERSONALPOSTALCODE>");
        builder.append("<FLDSRMOBILENUMBER>").append(srMobileNumber).append("</FLDSRMOBILENUMBER>");
        builder.append("<FLDSRPERSONALISPCODE>").append(srPersonalIspCode).append("</FLDSRPERSONALISPCODE>");
        builder.append("<FLDSRAMOUNT>").append(srAmount).append("</FLDSRAMOUNT>");
        builder.append("<FLDSRAGENTID>").append(srAgentId).append("</FLDSRAGENTID>");
        builder.append("<FLDTATASKYTXNID>").append(tataSkyTxnId).append("</FLDTATASKYTXNID>");
        builder.append("<FLDLASTCALLFLOWDETAILID>").append(lastCallFlowDetailId).append("</FLDLASTCALLFLOWDETAILID>");
        builder.append("</UpdateDirectSalesSRDetails>");
        builder.append("</PGTRANSACTIONROOT>");
        return new String(builder);
    }

    public String requestUpdateAuthorizeTranscation(String paymentGatewayDetailId, String pgTxnDetailId,
            String bankId, String cardNumber, String cardType, String cardBrand, String pgResponseUpdateTime,
            String pgBankId, String pgTxnId, String rrn, String authCode, String apgId,
            String directBankAccBankName, String pgTxnErrorCode, String pgTxnErrorMessage,
            String LastCallFlowDetailId) {

        StringBuilder builder = new StringBuilder();
        //builder.append("<TATASKY>");
        builder.append("<UpdateAuthorizeTranscation>"); //<TBLPAYMENTGATEWAYDETAIL>
        builder.append("<FLDPAYMENTGATEWAYDETAILID>").append(paymentGatewayDetailId).append("</FLDPAYMENTGATEWAYDETAILID>");
//        builder.append("<FLDPGTXNDETAILID>").append(pgTxnDetailId).append("</FLDPGTXNDETAILID>");
        builder.append("<FLDBANKID>").append(bankId).append("</FLDBANKID>");
        builder.append("<FLDCARDNUMBER>").append(cardNumber).append("</FLDCARDNUMBER>");
        builder.append("<FLDCARDTYPE>").append(cardType).append("</FLDCARDTYPE>");
        builder.append("<FLDCARDBRAND>").append(cardBrand).append("</FLDCARDBRAND>");
        builder.append("<FLDPGRESPONSEUPDATETIME>").append(pgResponseUpdateTime).append("</FLDPGRESPONSEUPDATETIME>");
        builder.append("<FLDPGBANKID>").append(pgBankId).append("</FLDPGBANKID>");
//        builder.append("<FLDPGTXNID>").append(pgTxnId).append("</FLDPGTXNID>");
        builder.append("<FLDRRN>").append(rrn).append("</FLDRRN>");
        builder.append("<FLDAUTHCODE>").append(authCode).append("</FLDAUTHCODE>");
        builder.append("<FLDAPGID>").append(apgId).append("</FLDAPGID>");
        builder.append("<FLDDIRECTBANKACCBANKNAME>").append(directBankAccBankName).append("</FLDDIRECTBANKACCBANKNAME>");
        builder.append("<FLDPGTXNERRORCODE>").append(pgTxnErrorCode).append("</FLDPGTXNERRORCODE>");
        builder.append("<FLDPGTXNERRORMESSAGE>").append(pgTxnErrorMessage).append("</FLDPGTXNERRORMESSAGE>");
        builder.append("<FLDLASTCALLFLOWDETAILID>").append(LastCallFlowDetailId).append("</FLDLASTCALLFLOWDETAILID>");
        builder.append("</UpdateAuthorizeTranscation>");
        builder.append("</PGTRANSACTIONROOT>");
        return new String(builder);
    }

    public String requestUpdateDirectSalesActivityDetails(String paymentGatewayDetailId, String activityTxnDetailId,
            String activityId, String activityResponseUpdateTime, String errorCode, String errorMessage, String lastCallFlowDetailId) {

        StringBuilder builder = new StringBuilder();
        // builder.append("<TATASKY>");
        builder.append("<UpdateDirectSalesActivityDetails>"); //<TBLPAYMENTGATEWAYDETAIL>
        builder.append("<FLDPAYMENTGATEWAYDETAILID>").append(paymentGatewayDetailId).append("</FLDPAYMENTGATEWAYDETAILID>");
//        builder.append("<FLDACTIVITYTXNDETAILID>").append(activityTxnDetailId).append("</FLDACTIVITYTXNDETAILID>");
        builder.append("<FLDACTIVITYID>").append(activityId).append("</FLDACTIVITYID>");
        builder.append("<FLDACTIVITYRESPONSEUPDATETIME>").append(activityResponseUpdateTime).append("</FLDACTIVITYRESPONSEUPDATETIME>");
        builder.append("<FLDPGTXNERRORCODE>").append(errorCode).append("</FLDPGTXNERRORCODE>");
        builder.append("<FLDPGTXNERRORMESSAGE>").append(errorMessage).append("</FLDPGTXNERRORMESSAGE>");
        builder.append("<FLDLASTCALLFLOWDETAILID>").append(lastCallFlowDetailId).append("</FLDLASTCALLFLOWDETAILID>");
        builder.append("</UpdateDirectSalesActivityDetails>");
        builder.append("</PGTRANSACTIONROOT>");
        return new String(builder);
    }

    public String requestUpdateRechargeDetails(String paymentGatewayDetailId, String rechargeTxnDetailId,
            String rechargeCurrentBalance, String rechargeBonusAmount, String rechargeAmount,
            String rechargeTskyReceipt, String rechargeChecksum, String rechargeResponseUpdateTime,
            String errorCode, String errorMessage, String lastCallFlowDetailId) {

        StringBuilder builder = new StringBuilder();
        //builder.append("<TATASKY>");
        builder.append("<UpdateRechargeDetails>"); //<TBLPAYMENTGATEWAYDETAIL>
        builder.append("<FLDPAYMENTGATEWAYDETAILID>").append(paymentGatewayDetailId).append("</FLDPAYMENTGATEWAYDETAILID>");
//        builder.append("<FLDRECHARGETXNDETAILID>").append(rechargeTxnDetailId).append("</FLDRECHARGETXNDETAILID>");
        builder.append("<FLDRECHARGECURRENTBALANCE>").append(rechargeCurrentBalance).append("</FLDRECHARGECURRENTBALANCE>");
        builder.append("<FLDRECHARGEBONUSAMOUNT>").append(rechargeBonusAmount).append("</FLDRECHARGEBONUSAMOUNT>");
        builder.append("<FLDRECHARGEAMOUNT>").append(rechargeAmount).append("</FLDRECHARGEAMOUNT>");
        builder.append("<FLDRECHARGETSKYRECEIPT>").append(rechargeTskyReceipt).append("</FLDRECHARGETSKYRECEIPT>");
        builder.append("<FLDRECHARGECHECKSUM>").append(rechargeChecksum).append("</FLDRECHARGECHECKSUM>");
        builder.append("<FLDRECHARGERESPONSEUPDATETIME>").append(rechargeResponseUpdateTime).append("</FLDRECHARGERESPONSEUPDATETIME>");
        builder.append("<FLDPRODUCTCODE>").append("").append("</FLDPRODUCTCODE>");
        builder.append("<FLDPGTXNERRORCODE>").append(errorCode).append("</FLDPGTXNERRORCODE>");
        builder.append("<FLDPGTXNERRORMESSAGE>").append(errorMessage).append("</FLDPGTXNERRORMESSAGE>");
        builder.append("<FLDLASTCALLFLOWDETAILID>").append(lastCallFlowDetailId).append("</FLDLASTCALLFLOWDETAILID>");
        builder.append("</UpdateRechargeDetails>");
        builder.append("</PGTRANSACTIONROOT>");
        return new String(builder);
    }

    public String requestUpdateFinalStatus(String paymentGatewayDetailId, String TxnDetailId,
            String status, String stage, String lastCallFlowDetailId) {

        StringBuilder builder = new StringBuilder();
        //builder.append("<TATASKY>");
        builder.append("<UpdateFinalStatus>"); //<TBLPAYMENTGATEWAYDETAIL>
        builder.append("<FLDPAYMENTGATEWAYDETAILID>").append(paymentGatewayDetailId).append("</FLDPAYMENTGATEWAYDETAILID>");
//        builder.append("<FLDRECONCILETXNDETAILID>").append(TxnDetailId).append("</FLDRECONCILETXNDETAILID>");
        builder.append("<FLDSTATUS>").append(status).append("</FLDSTATUS>");
        builder.append("<FLDSTAGE>").append(stage).append("</FLDSTAGE>");
        builder.append("<FLDLASTCALLFLOWDETAILID>").append(lastCallFlowDetailId).append("</FLDLASTCALLFLOWDETAILID>");
        builder.append("</UpdateFinalStatus>");
        builder.append("</PGTRANSACTIONROOT>");
        return new String(builder);
    }

    public String requestUpdateMobileStatus(String paymentGatewayDetailId, String accRegnTxnDetailId,
            String directBankAccRegnFlag) {

        StringBuilder builder = new StringBuilder();
        //builder.append("<TATASKY>");
        builder.append("<UpdateMobileStatus>"); //<TBLPAYMENTGATEWAYDETAIL>
        builder.append("<FLDPAYMENTGATEWAYDETAILID>").append(paymentGatewayDetailId).append("</FLDPAYMENTGATEWAYDETAILID>");
        builder.append("<FLDACCREGNTXNDETAILID>").append(accRegnTxnDetailId).append("</FLDACCREGNTXNDETAILID>");
        builder.append("<FLDDIRECTBANKACCREGNFLAG>").append(directBankAccRegnFlag).append("</FLDDIRECTBANKACCREGNFLAG>");
        builder.append("</UpdateMobileStatus>");
        builder.append("</PGTRANSACTIONROOT>");
        return new String(builder);
    }

    public String requestUpdatePasswordStatus(String paymentGatewayDetailId, String ivrPwdTxnDetailId,
            String isPswdGeneratedFlag) {
        StringBuilder builder = new StringBuilder();
        //builder.append("<TATASKY>");
        builder.append("<UpdatePasswordStatus>"); //<TBLPAYMENTGATEWAYDETAIL>
        builder.append("<FLDPAYMENTGATEWAYDETAILID>").append(paymentGatewayDetailId).append("</FLDPAYMENTGATEWAYDETAILID>");
        builder.append("<FLDIVRPWDTXNDETAILID>").append(ivrPwdTxnDetailId).append("</FLDIVRPWDTXNDETAILID>");
        builder.append("<FLDISPSWDGENERATEDFLAG>").append(isPswdGeneratedFlag).append("</FLDISPSWDGENERATEDFLAG>");
        builder.append("</UpdatePasswordStatus>");
        builder.append("</PGTRANSACTIONROOT>");
        return new String(builder);
    }

    public String requestSubProfileByRmn(String callerType, String subIDCount, String subscriberID,
            String accountStatus, String accountSubStatus, String primaryLanguage, String secondaryLanguage,
            String premiumFlag, String prospectState, String cliRepatFlag, String premiumFlag1, String callCountByCLI,
            String firstName, String lastName, String activationDate, String differenceInDays, String actualCustomerClass,
            String isSensitive, String dbCallDetailId) {

        StringBuilder builder = new StringBuilder();

        builder.append("<BA_CALLER_TYPE>").append(callerType).append("</BA_CALLER_TYPE>");
        builder.append("<BA_SUBSCRIBER_ID_COUNT>").append(subIDCount).append("</BA_SUBSCRIBER_ID_COUNT>");
        builder.append("<BA_SUBSCRIBER_ID>").append(subscriberID).append("</BA_SUBSCRIBER_ID>");
        builder.append("<BA_ACCOUNT_STATUS>").append(accountStatus).append("</BA_ACCOUNT_STATUS>");
        builder.append("<BA_ACCOUNT_SUB_STATUS>").append(accountSubStatus).append("</BA_ACCOUNT_SUB_STATUS>");
        builder.append("<BA_PRIMARY_LANGUAGE>").append(primaryLanguage).append("</BA_PRIMARY_LANGUAGE>");
        builder.append("<BA_SECONDARY_LANGUAGE>").append(secondaryLanguage).append("</BA_SECONDARY_LANGUAGE>");
        builder.append("<BA_PREMIUM_FLAG>").append(premiumFlag).append("</BA_PREMIUM_FLAG>");
        builder.append("<BA_STATE>").append(prospectState).append("</BA_STATE>");
        builder.append("<BA_CLI_REPEAT_CALLER_FLAG>").append(cliRepatFlag).append("</BA_CLI_REPEAT_CALLER_FLAG>");
        builder.append("<BA_PREMIUM_FLAG1>").append(premiumFlag1).append("</BA_PREMIUM_FLAG1>");
        builder.append("<BA_CALLCOUNTBYCLI>").append(callCountByCLI).append("</BA_CALLCOUNTBYCLI>");
        builder.append("<BA_FIRSTNAME>").append(firstName).append("</BA_FIRSTNAME>");
        builder.append("<BA_LASTNAME>").append(lastName).append("</BA_LASTNAME>");
        builder.append("<BA_FIRST_ACTIVATION_DATE>").append(activationDate).append("</BA_FIRST_ACTIVATION_DATE>");
        builder.append("<BA_ACTV_DATE_DIFFERENCE>").append(differenceInDays).append("</BA_ACTV_DATE_DIFFERENCE>");
        builder.append("<BA_ACT_CUST_CLASS>").append(actualCustomerClass).append("</BA_ACT_CUST_CLASS>");
        builder.append("<BA_ISSENSITIVE>").append(isSensitive).append("</BA_ISSENSITIVE>");
        builder.append("<BA_DBCALLDETAILID>").append(dbCallDetailId).append("</BA_DBCALLDETAILID>");
        return new String(builder);
    }

    public String requestProfileBySubscriberId(String subscriberID, String accountStatus, String accountSubStatus,
            String primaryLanguage, String secondaryLanguage, String premiumFlag, String premiumFlag1,
            String subscriptionType, String firstName, String lastName, String activationDate, String differenceInDays,
            String actualCustomerClass, String isSensitive, String dbCallDetailId) {

        StringBuilder builder = new StringBuilder();
        builder.append("<BA_SUBSCRIBER_ID>").append(subscriberID).append("</BA_SUBSCRIBER_ID>");
        builder.append("<BA_ACCOUNT_STATUS>").append(accountStatus).append("</BA_ACCOUNT_STATUS>");
        builder.append("<BA_ACCOUNT_SUB_STATUS>").append(accountSubStatus).append("</BA_ACCOUNT_SUB_STATUS>");
        builder.append("<BA_SUBSCRIPTION_TYPE>").append(subscriptionType).append("</BA_SUBSCRIPTION_TYPE>");
        builder.append("<BA_PRIMARY_LANGUAGE>").append(primaryLanguage).append("</BA_PRIMARY_LANGUAGE>");
        builder.append("<BA_SECONDARY_LANGUAGE>").append(secondaryLanguage).append("</BA_SECONDARY_LANGUAGE>");
        builder.append("<BA_PREMIUM_FLAG>").append(premiumFlag).append("</BA_PREMIUM_FLAG>");
        builder.append("<BA_PREMIUM_FLAG1>").append(premiumFlag1).append("</BA_PREMIUM_FLAG1>");
        builder.append("<BA_FIRSTNAME>").append(firstName).append("</BA_FIRSTNAME>");
        builder.append("<BA_LASTNAME>").append(lastName).append("</BA_LASTNAME>");
        builder.append("<BA_FIRST_ACTIVATION_DATE>").append(activationDate).append("</BA_FIRST_ACTIVATION_DATE>");
        builder.append("<BA_ACTV_DATE_DIFFERENCE>").append(differenceInDays).append("</BA_ACTV_DATE_DIFFERENCE>");
        builder.append("<BA_ACT_CUST_CLASS>").append(actualCustomerClass).append("</BA_ACT_CUST_CLASS>");
        builder.append("<BA_ISSENSITIVE>").append(isSensitive).append("</BA_ISSENSITIVE>");
        builder.append("<BA_DBCALLDETAILID>").append(dbCallDetailId).append("</BA_DBCALLDETAILID>");
        return new String(builder);
    }

    public String requestStasStateCodeBySubscId(String pinCode, String state) {
        StringBuilder builder = new StringBuilder();
        builder.append("<BA_STATE>").append(state).append("</BA_STATE>");
        builder.append("<BA_PIN_CODE>").append(pinCode).append("</BA_PIN_CODE>");
        return new String(builder);
    }

    public String requestgetWorkOrderDetails(String workOrderNumber, String workOrderStatus, String workOrderScheduledDate) {
        StringBuilder builder = new StringBuilder();
        builder.append("<BA_WO_NO>").append(workOrderNumber).append("</BA_WO_NO>");
        builder.append("<BA_WO_STATUS>").append(workOrderStatus).append("</BA_WO_STATUS>");
        builder.append("<BA_WO_SCHEDULE_DATE>").append(workOrderScheduledDate).append("</BA_WO_SCHEDULE_DATE>");
        return new String(builder);
    }

    public String requestgetAccountDetail(String accountBal, String dueDate,
            String renewDate, String lastRechargeDateTime, String lastRechargeAmount, String suggestedRechargeAmount) {
        StringBuilder builder = new StringBuilder();
        builder.append("<BA_ACCOUNT_BALANCE>").append(accountBal).append("</BA_ACCOUNT_BALANCE>");
        builder.append("<BA_RECHARGE_DUE_DATE>").append(dueDate).append("</BA_RECHARGE_DUE_DATE>");
        builder.append("<BA_FDP_RENEW_DATE>").append(renewDate).append("</BA_FDP_RENEW_DATE>");
        builder.append("<BA_LAST_RECHARGE_DATETIME>").append(lastRechargeDateTime).append("</BA_LAST_RECHARGE_DATETIME>");
        builder.append("<BA_LAST_RECHARGE_AMT>").append(lastRechargeAmount).append("</BA_LAST_RECHARGE_AMT>");
        builder.append("<BA_SUGGESTED_RECHARGE>").append(suggestedRechargeAmount).append("</BA_SUGGESTED_RECHARGE>");
        return new String(builder);
    }

    public String requestgetPartnerDetail(String partnerType, String partnerId, String tslPrimaryLanguage,
            String status, String state, String zipcode, String partnerRepeatCount, String actualPartnerType) {
        StringBuilder builder = new StringBuilder();
        builder.append("<BA_PARTNER_TYPE>").append(partnerType).append("</BA_PARTNER_TYPE>");
        builder.append("<BA_PARTNER_ID>").append(partnerId).append("</BA_PARTNER_ID>");
        builder.append("<BA_PRIMARY_LANGUAGE>").append(tslPrimaryLanguage).append("</BA_PRIMARY_LANGUAGE>");
        builder.append("<BA_PARTNER_ACCOUNT_STATUS>").append(status).append("</BA_PARTNER_ACCOUNT_STATUS>");
        builder.append("<BA_STATE>").append(state).append("</BA_STATE>");
        builder.append("<BA_PIN_CODE>").append(zipcode).append("</BA_PIN_CODE>");
        builder.append("<BA_PARTNER_REPEAT_COUNT>").append(partnerRepeatCount).append("</BA_PARTNER_REPEAT_COUNT>");
        builder.append("<BA_PARTNER_SUB_TYPE>").append(actualPartnerType).append("</BA_PARTNER_SUB_TYPE>");
        return new String(builder);
    }

        public String requestGetDetailBySubscriberId(String spmCampaignFlag, String openEscalationFlag, String openSrFlag,
            String srRepeatFlag, String openWoFlag, String woRepeatFlag, String productType,
            String subscriptionType, String campaign1, String campaignCode1, String campaignDescription1,
            String campaign2, String campaignCode2, String campaignDescription2, String campaign3, String campaignCode3, 
            String campaignDescription3, String campaignFlag, String repeatPackCount, String repeatRechargeCount, 
            String spmPackName, String spmCampaignId, String callCountbySubscriberId, String subscriberAgentRepeatFlag, 
            String subscriberIVRRepeatFlag, String activationDate, String differenceInDays, String isSensitive, 
            String dbCallDetailId , String ivrSRType, String isIvrOpenSR, String ivrWOType, String isIvrOpenWO ,
            String srCreatedDate, String ivrSRNumber, String woSheduledDateTime, String ivrWONumber, String ivrWOStatus, 
            String ivrSRStatus, String woCreatedDate, String campaign4, String campaignCode4, String campaignDescription4,
            String campaign5, String campaignCode5, String campaignDescription5, String campaign6, String campaignCode6, 
            String campaignDescription6, String campaign7, String campaignCode7, String campaignDescription7,
            String campaign8, String campaignCode8, String campaignDescription8, String campaign9, String campaignCode9,
            String campaignDescription9) {

        StringBuilder builder = new StringBuilder();
        builder.append("<BA_SPM_CAMPAIGN_FLAG>").append(spmCampaignFlag).append("</BA_SPM_CAMPAIGN_FLAG>");
        builder.append("<BA_OPEN_ESCALATION_FLAG>").append(openEscalationFlag).append("</BA_OPEN_ESCALATION_FLAG>");
        builder.append("<BA_SR_OPEN_FLAG>").append(openSrFlag).append("</BA_SR_OPEN_FLAG>");
        builder.append("<BA_SR_REPEAT_FLAG>").append(srRepeatFlag).append("</BA_SR_REPEAT_FLAG>");
        builder.append("<BA_WO_OPEN_FLAG>").append(openWoFlag).append("</BA_WO_OPEN_FLAG>");
        builder.append("<BA_WO_REPEAT_FLAG>").append(woRepeatFlag).append("</BA_WO_REPEAT_FLAG>");
        builder.append("<BA_STB_TYPE>").append(productType).append("</BA_STB_TYPE>");
        builder.append("<BA_SUBSCRIPTION_TYPE>").append(subscriptionType).append("</BA_SUBSCRIPTION_TYPE>");
        builder.append("<BA_CAMPAIGN1>").append(campaign1).append("</BA_CAMPAIGN1>");
        builder.append("<BA_CAMPAIGN_CODE1>").append(campaignCode1).append("</BA_CAMPAIGN_CODE1>");
        builder.append("<BA_CAMPAIGN_DESC1>").append(campaignDescription1).append("</BA_CAMPAIGN_DESC1>");
        builder.append("<BA_CAMPAIGN2>").append(campaign2).append("</BA_CAMPAIGN2>");
        builder.append("<BA_CAMPAIGN_CODE2>").append(campaignCode2).append("</BA_CAMPAIGN_CODE2>");
        builder.append("<BA_CAMPAIGN_DESC2>").append(campaignDescription2).append("</BA_CAMPAIGN_DESC2>");
        builder.append("<BA_CAMPAIGN3>").append(campaign3).append("</BA_CAMPAIGN3>");
        builder.append("<BA_CAMPAIGN_CODE3>").append(campaignCode3).append("</BA_CAMPAIGN_CODE3>");
        builder.append("<BA_CAMPAIGN_DESC3>").append(campaignDescription3).append("</BA_CAMPAIGN_DESC3>");
        builder.append("<BA_CAMPAIGN4>").append(campaign4).append("</BA_CAMPAIGN4>");
        builder.append("<BA_CAMPAIGN_CODE4>").append(campaignCode4).append("</BA_CAMPAIGN_CODE4>");
        builder.append("<BA_CAMPAIGN_DESC4>").append(campaignDescription4).append("</BA_CAMPAIGN_DESC4>");
        builder.append("<BA_CAMPAIGN5>").append(campaign5).append("</BA_CAMPAIGN5>");
        builder.append("<BA_CAMPAIGN_CODE5>").append(campaignCode5).append("</BA_CAMPAIGN_CODE5>");
        builder.append("<BA_CAMPAIGN_DESC5>").append(campaignDescription5).append("</BA_CAMPAIGN_DESC5>");
        builder.append("<BA_CAMPAIGN6>").append(campaign6).append("</BA_CAMPAIGN6>");
        builder.append("<BA_CAMPAIGN_CODE6>").append(campaignCode6).append("</BA_CAMPAIGN_CODE6>");
        builder.append("<BA_CAMPAIGN_DESC6>").append(campaignDescription6).append("</BA_CAMPAIGN_DESC6>");
        builder.append("<BA_CAMPAIGN7>").append(campaign7).append("</BA_CAMPAIGN7>");
        builder.append("<BA_CAMPAIGN_CODE7>").append(campaignCode7).append("</BA_CAMPAIGN_CODE7>");
        builder.append("<BA_CAMPAIGN_DESC7>").append(campaignDescription7).append("</BA_CAMPAIGN_DESC7>");
        builder.append("<BA_CAMPAIGN8>").append(campaign8).append("</BA_CAMPAIGN8>");
        builder.append("<BA_CAMPAIGN_CODE8>").append(campaignCode8).append("</BA_CAMPAIGN_CODE8>");
        builder.append("<BA_CAMPAIGN_DESC8>").append(campaignDescription8).append("</BA_CAMPAIGN_DESC8>");
        builder.append("<BA_CAMPAIGN9>").append(campaign9).append("</BA_CAMPAIGN9>");
        builder.append("<BA_CAMPAIGN_CODE9>").append(campaignCode9).append("</BA_CAMPAIGN_CODE9>");
        builder.append("<BA_CAMPAIGN_DESC9>").append(campaignDescription9).append("</BA_CAMPAIGN_DESC9>");
        builder.append("<BA_CAMPAIGN_FLAG>").append(campaignFlag).append("</BA_CAMPAIGN_FLAG>");
        builder.append("<BA_REPEAT_PACK_COUNT>").append(repeatPackCount).append("</BA_REPEAT_PACK_COUNT>");
        builder.append("<BA_REPEAT_RECHARGE_COUNT>").append(repeatRechargeCount).append("</BA_REPEAT_RECHARGE_COUNT>");
        builder.append("<BA_SPMPACKNAME>").append(spmPackName).append("</BA_SPMPACKNAME>");
        builder.append("<BA_SPMCAMPAIGNID>").append(spmCampaignId).append("</BA_SPMCAMPAIGNID>");
        builder.append("<BA_CALLCOUNTBYSUBID>").append(callCountbySubscriberId).append("</BA_CALLCOUNTBYSUBID>");
        builder.append("<BA_SUB_AGENT_REPEAT_FLAG>").append(subscriberAgentRepeatFlag).append("</BA_SUB_AGENT_REPEAT_FLAG>");
        builder.append("<BA_SUB_IVR_REPEAT_FLAG>").append(subscriberIVRRepeatFlag).append("</BA_SUB_IVR_REPEAT_FLAG>");
        builder.append("<BA_ISSENSITIVE>").append(isSensitive).append("</BA_ISSENSITIVE>");
        builder.append("<BA_DBCALLDETAILID>").append(dbCallDetailId).append("</BA_DBCALLDETAILID>");
        builder.append("<BA_IVRSRTYPE>").append(ivrSRType).append("</BA_IVRSRTYPE>");
        builder.append("<BA_IVRSR_OPEN>").append(isIvrOpenSR).append("</BA_IVRSR_OPEN>");
        builder.append("<BA_IVRWOTYPE>").append(ivrWOType).append("</BA_IVRWOTYPE>");        
        builder.append("<BA_IVRWO_OPEN>").append(isIvrOpenWO).append("</BA_IVRWO_OPEN>");
        builder.append("<BA_SRCREATEDDATETIME>").append(srCreatedDate).append("</BA_SRCREATEDDATETIME>");
        builder.append("<BA_IVRSR_NUMBER>").append(ivrSRNumber).append("</BA_IVRSR_NUMBER>");
        builder.append("<BA_WOSCHEDULEDDATETIME>").append(woSheduledDateTime).append("</BA_WOSCHEDULEDDATETIME>");
        builder.append("<BA_IVRWO_NUMBER>").append(ivrWONumber).append("</BA_IVRWO_NUMBER>");   
        builder.append("<BA_IVRWO_STATUS>").append(ivrWOStatus).append("</BA_IVRWO_STATUS>");
        builder.append("<BA_WO_CREATED_DATE>").append(woCreatedDate).append("</BA_WO_CREATED_DATE>");
        builder.append("<BA_IVRSR_STATUS>").append(ivrSRStatus).append("</BA_IVRSR_STATUS>");
        return new String(builder);
    }

    public String requestAgentRoutingDetails(String vag, String ivrExit, String primaryLanguage,
            String secondaryLanguage) {

        StringBuilder builder = new StringBuilder();
        builder.append("<BA_VAG>").append(vag).append("</BA_VAG>");
        builder.append("<BA_IVREXIT>").append(ivrExit).append("</BA_IVREXIT>");
        builder.append("<BA_PRIMARY_LANGUAGE>").append(primaryLanguage).append("</BA_PRIMARY_LANGUAGE>");
        builder.append("<BA_SECONDARY_LANGUAGE>").append(secondaryLanguage).append("</BA_SECONDARY_LANGUAGE>");
        return new String(builder);
    }

    public String requestGetTelecomCircle(String telecomCircle, String langCode) {

        StringBuilder builder = new StringBuilder();
        builder.append("<BA_TELECOM_CIRCLE>").append(telecomCircle).append("</BA_TELECOM_CIRCLE>");
        builder.append("<BA_LANG_CODE>").append(langCode).append("</BA_LANG_CODE>");
        return new String(builder);
    }
    
     public String requestSubListByCli(String subscriberIdList) {

        StringBuilder builder = new StringBuilder();

        builder.append("<BA_SUBSCRIBERID_LIST>").append(subscriberIdList).append("</BA_SUBSCRIBERID_LIST>");
        return new String(builder);
    }
}
