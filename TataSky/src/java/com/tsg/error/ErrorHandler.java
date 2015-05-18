/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 * <CTITRANSACTIONALERT></CTITRANSACTIONALERT>
 */
package com.tsg.error;

import com.tsg.common.ConfigurationReader;

/**
 *
 * @author Rajesh
 */
public class ErrorHandler {

    private int errorCode = 0;
    private String promptName = null;

    public String AccountBalnce(String LZ_errorcode) {

        errorCode = Integer.parseInt(LZ_errorcode);
        switch (errorCode) {
            case 102:
                promptName = ConfigurationReader.configList.get("accountBalancePromptName102");
                break;
            case 200:
                promptName = ConfigurationReader.configList.get("accountBalancePromptName200");
                break;
            case 300:
                promptName = ConfigurationReader.configList.get("accountBalancePromptName300");
                break;
            default:
                promptName = ConfigurationReader.configList.get("PromptName404");
                break;
        }
        LZ_errorcode = null;
        return promptName;
    }

    public String LastRecharge(String LZ_errorcode) {

        errorCode = Integer.parseInt(LZ_errorcode);
        switch (errorCode) {
            case 700:
                promptName = ConfigurationReader.configList.get("lastRechargePromptName700");
                break;
            case 701:
                promptName = ConfigurationReader.configList.get("lastRechargePromptName701");
                break;
            case 702:
                promptName = ConfigurationReader.configList.get("lastRechargePromptName702");
                break;
            default:
                promptName = ConfigurationReader.configList.get("PromptName404");
                break;
        }
        LZ_errorcode = null;
        return promptName;
    }

    public String SoftHeavyRefresh(String LZ_errorcode) {

        errorCode = Integer.parseInt(LZ_errorcode);
        switch (errorCode) {
            case 700:
                promptName = ConfigurationReader.configList.get("softRefreshPromptName700");
                break;
            case 701:
                promptName = ConfigurationReader.configList.get("softRefreshPromptName701");
                break;
            case 702:
                promptName = ConfigurationReader.configList.get("softRefreshPromptName702");
                break;
            default:
                promptName = ConfigurationReader.configList.get("PromptName404");
                break;
        }
        LZ_errorcode = null;
        return promptName;
    }

    public String ServiceRequestCreation(String LZ_errorcode) {

        errorCode = Integer.parseInt(LZ_errorcode);
        switch (errorCode) {
            case 700:
                promptName = ConfigurationReader.configList.get("serviceRequestCreationPromptName700");
                break;
            case 701:
                promptName = ConfigurationReader.configList.get("serviceRequestCreationPromptName701");
                break;
            case 702:
                promptName = ConfigurationReader.configList.get("serviceRequestCreationPromptName702");
                break;
            default:
                promptName = ConfigurationReader.configList.get("PromptName404");
                break;
        }
        LZ_errorcode = null;
        return promptName;
    }

    public String VoucherTopUp(String LZ_errorcode) {

        errorCode = Integer.parseInt(LZ_errorcode);
        switch (errorCode) {
            case 102:
                promptName = ConfigurationReader.configList.get("voucherTopUpPromptName102");
                break;
            case 200:
                promptName = ConfigurationReader.configList.get("voucherTopUpPromptName200");
                break;
            case 300:
                promptName = ConfigurationReader.configList.get("voucherTopUpPromptName300");
                break;
            case 301:
                promptName = ConfigurationReader.configList.get("voucherTopUpPromptName301");
                break;
            case 697:
                promptName = ConfigurationReader.configList.get("voucherTopUpPromptName697");
                break;
            case 699:
                promptName = ConfigurationReader.configList.get("voucherTopUpPromptName699");
                break;
            case 701:
                promptName = ConfigurationReader.configList.get("voucherTopUpPromptName701");
                break;
            case 702:
                promptName = ConfigurationReader.configList.get("voucherTopUpPromptName702");
                break;
            case 703:
                promptName = ConfigurationReader.configList.get("voucherTopUpPromptName703");
                break;
            case 706:
                promptName = ConfigurationReader.configList.get("voucherTopUpPromptName706");
                break;
            case 707:
                promptName = ConfigurationReader.configList.get("voucherTopUpPromptName707");
                break;
            case 708:
                promptName = ConfigurationReader.configList.get("voucherTopUpPromptName708");
                break;
            case 711:
                promptName = ConfigurationReader.configList.get("voucherTopUpPromptName711");
                break;
            case 712:
                promptName = ConfigurationReader.configList.get("voucherTopUpPromptName712");
                break;
            case 713:
                promptName = ConfigurationReader.configList.get("voucherTopUpPromptName713");
                break;
            case 714:
                promptName = ConfigurationReader.configList.get("voucherTopUpPromptName714");
                break;
            case 715:
                promptName = ConfigurationReader.configList.get("voucherTopUpPromptName715");
                break;
            case 716:
                promptName = ConfigurationReader.configList.get("voucherTopUpPromptName716");
                break;
            case 718:
                promptName = ConfigurationReader.configList.get("voucherTopUpPromptName718");
                break;
            case 719:
                promptName = ConfigurationReader.configList.get("voucherTopUpPromptName719");
                break;
            case 720:
                promptName = ConfigurationReader.configList.get("voucherTopUpPromptName720");
                break;
            case 721:
                promptName = ConfigurationReader.configList.get("voucherTopUpPromptName721");
                break;
            case 722:
                promptName = ConfigurationReader.configList.get("voucherTopUpPromptName722");
                break;
            case 723:
                promptName = ConfigurationReader.configList.get("voucherTopUpPromptName723");
                break;
            case 727:
                promptName = ConfigurationReader.configList.get("voucherTopUpPromptName727");
                break;
            case 728:
                promptName = ConfigurationReader.configList.get("voucherTopUpPromptName728");
                break;
            case 729:
                promptName = ConfigurationReader.configList.get("voucherTopUpPromptName729");
                break;
            case 741:
                promptName = ConfigurationReader.configList.get("voucherTopUpPromptName741");
                break;
            case 742:
                promptName = ConfigurationReader.configList.get("voucherTopUpPromptName742");
                break;
            case 743:
                promptName = ConfigurationReader.configList.get("voucherTopUpPromptName743");
                break;
            default:
                promptName = ConfigurationReader.configList.get("PromptName404");
                break;
        }
        LZ_errorcode = null;
        return promptName;
    }

    public String SubscriberIDValidation(String LZ_errorcode) {

        errorCode = Integer.parseInt(LZ_errorcode);
        switch (errorCode) {
            case 700:
                promptName = ConfigurationReader.configList.get("SubIdValidationPromptName700");
                break;
            case 701:
                promptName = ConfigurationReader.configList.get("SubIdValidationPromptName701");
                break;
            case 702:
                promptName = ConfigurationReader.configList.get("SubIdValidationPromptName702");
                break;
            default:
                promptName = ConfigurationReader.configList.get("PromptName404");
                break;
        }
        LZ_errorcode = null;
        return promptName;
    }

    public String CreateRelocationWO(String LZ_errorcode) {

        errorCode = Integer.parseInt(LZ_errorcode);
        switch (errorCode) {
            case 700:
                promptName = ConfigurationReader.configList.get("createRelocationWOPromptName700");
                break;
            case 701:
                promptName = ConfigurationReader.configList.get("createRelocationWOPromptName701");
                break;
            case 702:
                promptName = ConfigurationReader.configList.get("createRelocationWOPromptName702");
                break;
            case 703:
                promptName = ConfigurationReader.configList.get("createRelocationWOPromptName703");
                break;
            case 704:
                promptName = ConfigurationReader.configList.get("createRelocationWOPromptName704");
                break;
            case 705:
                promptName = ConfigurationReader.configList.get("createRelocationWOPromptName705");
                break;
            case 706:
                promptName = ConfigurationReader.configList.get("createRelocationWOPromptName706");
                break;
            case 707:
                promptName = ConfigurationReader.configList.get("createRelocationWOPromptName707");
                break;
            default:
                promptName = ConfigurationReader.configList.get("PromptName404");
                break;
        }
        LZ_errorcode = null;
        return promptName;
    }

    public String PGTxnRecharge(String LZ_errorcode) {

        errorCode = Integer.parseInt(LZ_errorcode);
        switch (errorCode) {
            case 00:
                promptName = ConfigurationReader.configList.get("pgTxnRechargePromptName00");
                break;
            case 01:
                promptName = ConfigurationReader.configList.get("pgTxnRechargePromptName01");
                break;
            case 05:
                promptName = ConfigurationReader.configList.get("pgTxnRechargePromptName05");
                break;
            case 99:
                promptName = ConfigurationReader.configList.get("pgTxnRechargePromptName99");
                break;
            default:
                promptName = ConfigurationReader.configList.get("PromptName404");
                break;
        }
        LZ_errorcode = null;
        return promptName;
    }

    public String PGTxnDirectSales(String LZ_errorcode) {

        errorCode = Integer.parseInt(LZ_errorcode);
        switch (errorCode) {
            case 00:
                promptName = ConfigurationReader.configList.get("pgTxnDirectSalesPromptName00");
                break;
            case 01:
                promptName = ConfigurationReader.configList.get("pgTxnDirectSalesPromptName01");
                break;
            case 05:
                promptName = ConfigurationReader.configList.get("pgTxnDirectSalesPromptName05");
                break;
            case 99:
                promptName = ConfigurationReader.configList.get("pgTxnDirectSalesPromptName99");
                break;
            default:
                promptName = ConfigurationReader.configList.get("PromptName404");
                break;
        }
        LZ_errorcode = null;
        return promptName;
    }

    public String ReportingRecharge(String LZ_errorcode) {

        errorCode = Integer.parseInt(LZ_errorcode);
        switch (errorCode) {
            case 00:
                promptName = ConfigurationReader.configList.get("ReportingRechargePromptName00");
                break;
            case 01:
                promptName = ConfigurationReader.configList.get("ReportingRechargePromptName01");
                break;
            default:
                promptName = ConfigurationReader.configList.get("PromptName404");
                break;
        }
        LZ_errorcode = null;
        return promptName;
    }

    public String ReportingDirectSales(String LZ_errorcode) {

        errorCode = Integer.parseInt(LZ_errorcode);
        switch (errorCode) {
            case 00:
                promptName = ConfigurationReader.configList.get("ReportingDirectSalesPromptName00");
                break;
            case 01:
                promptName = ConfigurationReader.configList.get("ReportingDirectSalesPromptName01");
                break;
            default:
                promptName = ConfigurationReader.configList.get("PromptName404");
                break;
        }
        LZ_errorcode = null;
        return promptName;
    }

    public String GetDetails(String LZ_errorcode) {

        errorCode = Integer.parseInt(LZ_errorcode);
        switch (errorCode) {
            case 00:
                promptName = ConfigurationReader.configList.get("ReportingDirectSalesPromptName00");
                break;
            case 01:
                promptName = ConfigurationReader.configList.get("ReportingDirectSalesPromptName01");
                break;
            default:
                promptName = ConfigurationReader.configList.get("PromptName404");
                break;
        }
        LZ_errorcode = null;
        return promptName;
    }

    public String PaymentReceiver(String LZ_errorcode) {

        errorCode = Integer.parseInt(LZ_errorcode);
        switch (errorCode) {
            case 00:
                promptName = ConfigurationReader.configList.get("ReportingDirectSalesPromptName00");
                break;
            case 01:
                promptName = ConfigurationReader.configList.get("ReportingDirectSalesPromptName01");
                break;
            default:
                promptName = ConfigurationReader.configList.get("PromptName404");
                break;
        }
        LZ_errorcode = null;
        return promptName;
    }

    public String CreateActivity(String LZ_errorcode) {

        errorCode = Integer.parseInt(LZ_errorcode);
        switch (errorCode) {
            case 00:
                promptName = ConfigurationReader.configList.get("ReportingDirectSalesPromptName00");
                break;
            case 01:
                promptName = ConfigurationReader.configList.get("ReportingDirectSalesPromptName01");
                break;
            default:
                promptName = ConfigurationReader.configList.get("PromptName404");
                break;
        }
        LZ_errorcode = null;
        return promptName;
    }

    public String SubscriberValidation(String LZ_errorcode) {

        errorCode = Integer.parseInt(LZ_errorcode);
        switch (errorCode) {
            case 00:
                promptName = ConfigurationReader.configList.get("ReportingDirectSalesPromptName00");
                break;
            case 01:
                promptName = ConfigurationReader.configList.get("ReportingDirectSalesPromptName01");
                break;
            default:
                promptName = ConfigurationReader.configList.get("PromptName404");
                break;
        }
        LZ_errorcode = null;
        return promptName;
    }

    public String ServiceRequestQuery(String LZ_errorcode) {

        errorCode = Integer.parseInt(LZ_errorcode);
        switch (errorCode) {
            case 00:
                promptName = ConfigurationReader.configList.get("ReportingDirectSalesPromptName00");
                break;
            case 01:
                promptName = ConfigurationReader.configList.get("ReportingDirectSalesPromptName01");
                break;
            default:
                promptName = ConfigurationReader.configList.get("PromptName404");
                break;
        }
        LZ_errorcode = null;
        return promptName;
    }

    public String portal(String LZ_errorcode) {

        errorCode = Integer.parseInt(LZ_errorcode);
        switch (errorCode) {
            case 00:
                promptName = ConfigurationReader.configList.get("PortalPromptName00");
                break;
            case 01:
                promptName = ConfigurationReader.configList.get("PortalPromptName01");
                break;
            case 05:
                promptName = ConfigurationReader.configList.get("PortalPromptName05");
                break;
            case 06:
                promptName = ConfigurationReader.configList.get("PortalPromptName06");
                break;
            case 07:
                promptName = ConfigurationReader.configList.get("PortalPromptName07");
                break;
            case 99:
                promptName = ConfigurationReader.configList.get("PortalPromptName99");
                break;
            case 300:
                promptName = ConfigurationReader.configList.get("PortalPromptName300");
                break;
            case 400:
                promptName = ConfigurationReader.configList.get("PortalPromptName400");
                break;
            case 405:
                promptName = ConfigurationReader.configList.get("PortalPromptName405");
                break;
            case 406:
                promptName = ConfigurationReader.configList.get("PortalPromptName406");
                break;
            case 407:
                promptName = ConfigurationReader.configList.get("PortalPromptName407");
                break;
            case 408:
                promptName = ConfigurationReader.configList.get("PortalPromptName408");
                break;
            case 409:
                promptName = ConfigurationReader.configList.get("PortalPromptName409");
                break;
            case 410:
                promptName = ConfigurationReader.configList.get("PortalPromptName410");
                break;
            case 412:
                promptName = ConfigurationReader.configList.get("PortalPromptName412");
                break;
            case 413:
                promptName = ConfigurationReader.configList.get("PortalPromptName413");
                break;
            case 414:
                promptName = ConfigurationReader.configList.get("PortalPromptName414");
                break;
            case 415:
                promptName = ConfigurationReader.configList.get("PortalPromptName415");
                break;
            case 3000:
                promptName = ConfigurationReader.configList.get("PortalPromptName3000");
                break;
            case 3001:
                promptName = ConfigurationReader.configList.get("PortalPromptName3001");
                break;
            case 3002:
                promptName = ConfigurationReader.configList.get("PortalPromptName3002");
                break;
            case 3003:
                promptName = ConfigurationReader.configList.get("PortalPromptName3003");
                break;
            case 3004:
                promptName = ConfigurationReader.configList.get("PortalPromptName3004");
                break;
            case 3005:
                promptName = ConfigurationReader.configList.get("PortalPromptName3005");
                break;
            default:
                promptName = ConfigurationReader.configList.get("PromptName404");
                break;
        }
        LZ_errorcode = null;
        return promptName;
    }
}
