<%-- 
    Document   : DirectSaleAtom
    Created on : Nov 12, 2013, 8:21:23 PM
    Author     : Rajesh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.tsg.atom.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String ivrId = "";
            String tataskyTransId = "";
            try {
                String LZ_AtomMerchantID = "1300101";
                String LZ_Method_type = "getDetails";
                String LZ_Service_id = "2000001";
                String LZ_GetAmount = "0";
                String BA_SUBSCRIBER_ID = "1039442552";
                String LZ_UserID = "101015";
                String genesysUniqueId = "0012345688900EEEE000089087";
                String userId = "101015";
                String LZ_SRNumber = "1337000643";
                String product = "DirectSales";
                String dbCallDetailId = "12";

                GetDetailsResponse objDataService = new GetDetails().requestGetDetails(LZ_AtomMerchantID, LZ_Method_type,
                        LZ_Service_id, LZ_GetAmount, BA_SUBSCRIBER_ID, LZ_UserID, genesysUniqueId, userId, LZ_SRNumber, product, dbCallDetailId);
                System.out.println("TxnID : " + objDataService.getTranscationId());
                System.out.println("OrderID : " + objDataService.getOrderId());
                System.out.println("Errorcode : " + objDataService.getErrorCode());
                System.out.println("ErrorMsg : " + objDataService.getErrorMessage());
                ivrId = objDataService.getTranscationId();
        %>
        <table>
            <tr><h3>Get Details Response</h3></tr>
        <tr><td>getTranscationId</td> <td><%=objDataService.getTranscationId()%></td></tr>
        <tr><td>getOrderId :</td> <td><%=objDataService.getOrderId()%></td></tr>
        <tr><td>getErrorCode :</td> <td><%=objDataService.getErrorCode()%></td></tr>
        <tr><td>getErrorMessage :</td> <td><%=objDataService.getErrorMessage()%></td></tr>
    </table>

    <%} catch (Exception e) {
            System.out.println("Get Details Test Page Exception " + e.getMessage());
        }

        try {
            //Input variables
            String LZ_AtomMerchantID = "1300101";
            String LZ_Method_type = "postDetails";
            String LZ_Service_id = "2000001";
            String LZ_GetAmount = "100.00";
            String LZ_pricePoint = "0";
            String LZ_AtomTxnUniqueID = "311665";
            String LZ_UserID = "101015";
            String LZ_SRNumber = "1337000643";
            String BA_SUBSCRIBER_ID = "1039442552";
            String LZ_UsrANI = "101015";
            String LZ_IVRUUID = "0012345688900EEEE000089087|ADS130711000855047";
            String LZ_Status = "CL";

            String LZ_CallStage = "EnterAmount";
            String LZ_RequiredDigit = "4";
            String LZ_EnteredDigit = "2";
            String LZ_Attempts = "1";
            //PricePoint Grid
            String LZ_NoOfBoxes = "";//1STD
            String LZ_PackName = "";//South Sports Special Pack
            String LZ_HardwareAmount = "";//1800
            String LZ_ActivityFee = "";//0
            String LZ_BonusAmount = "";//0
            String LZ_PackageAmount = "";//201
            String LZ_AccessoriesAmount = "";//0
            String LZ_TotalAmount = "";//2001

            String LZ_TransactionType = "";//Outright
            //String LZ_SRValidResponse = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><tata-sky><sr-query-response><atom-ivr-id>24063284</atom-ivr-id><tatasky-txn-id></tatasky-txn-id><srNumber>1-21253572821</srNumber><srType></srType><srArea></srArea><srSubArea></srSubArea><price-point></price-point><subscriber-id></subscriber-id><date-time>19-06-2013 04:40</date-time><personalCity></personalCity><personalCountry></personalCountry><personalState></personalState><personalStreetAddress></personalStreetAddress><personalStreetAddress2></personalStreetAddress2><personalPostalCode></personalPostalCode><mobileNumber></mobileNumber><personalISPCode></personalISPCode><createdBy></createdBy><error-code>3003</error-code><error-message>SR number invalid</error-message></sr-query-response></tata-sky>";
            //String LZ_SRPostResponse = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><tata-sky><ds-txn-response><atom-ivr-id>24063067</atom-ivr-id><srNumber>1-21252501548</srNumber><activity-id></activity-id><error-code>3004</error-code><error-message>Failure in Activity Creation</error-message></ds-txn-response></tata-sky>";
            String LZ_SRValidResponse = "";//<?xml version=\"1.0\" encoding=\"UTF-8\"?><tata-sky><sr-query-response><atom-ivr-id>"+ivrId+"</atom-ivr-id><tatasky-txn-id></tatasky-txn-id><srNumber>"+LZ_SRNumber+"</srNumber><srType></srType><srArea></srArea><srSubArea></srSubArea><price-point></price-point><subscriber-id></subscriber-id><date-time></date-time><personalCity></personalCity><personalCountry></personalCountry><personalState></personalState><personalStreetAddress></personalStreetAddress><personalStreetAddress2></personalStreetAddress2><personalPostalCode></personalPostalCode><mobileNumber></mobileNumber><personalISPCode></personalISPCode><createdBy></createdBy><error-code>3003</error-code><error-message></error-message></sr-query-response></tata-sky>";
            String LZ_SRPostResponse = "";//<?xml version=\"1.0\" encoding=\"UTF-8\"?><tata-sky><ds-txn-response><atom-ivr-id>"+ivrId+"</atom-ivr-id><srNumber>"+LZ_SRNumber+"</srNumber><activity-id></activity-id><error-code></error-code><error-message></error-message></ds-txn-response></tata-sky>";
            String LZ_SUBIDValidResponse = "";
            String LZ_SUBIDPostResponse = "";
            String LZ_Product = "DirectSales";
            String dbCallDetailId = "12";
            // Send the request to Tatasky
            PostDetailsResponse objDataService = new PostDetails().requestPostDetails(LZ_AtomMerchantID, LZ_Method_type,
                    LZ_Service_id, LZ_GetAmount, LZ_pricePoint, ivrId, LZ_UserID, LZ_SRNumber, BA_SUBSCRIBER_ID, LZ_UsrANI, LZ_IVRUUID,
                    LZ_Status, LZ_CallStage, LZ_RequiredDigit, LZ_EnteredDigit, LZ_Attempts, LZ_NoOfBoxes, LZ_PackName, LZ_HardwareAmount,
                    LZ_ActivityFee, LZ_BonusAmount, LZ_PackageAmount, LZ_AccessoriesAmount, LZ_TotalAmount, LZ_TransactionType,
                    LZ_SRValidResponse, LZ_SRPostResponse, LZ_SUBIDValidResponse, LZ_SUBIDPostResponse, LZ_Product, dbCallDetailId);

            System.out.println("TxnID : " + objDataService.getTranscationId());
            System.out.println("OrderID : " + objDataService.getOrderId());
            System.out.println("Errorcode : " + objDataService.getErrorCode());
            System.out.println("ErrorMsg : " + objDataService.getErrorMessage());
    %>
    <table>
        <tr><h3>Post Details Response</h3></tr>
    <tr><td>getTranscationId</td> <td><%=objDataService.getTranscationId()%></td></tr>
    <tr><td>getOrderId :</td> <td><%=objDataService.getOrderId()%></td></tr>
    <tr><td>getErrorCode :</td> <td><%=objDataService.getErrorCode()%></td></tr>
    <tr><td>getErrorMessage :</td> <td><%=objDataService.getErrorMessage()%></td></tr>
</table>

<%} catch (Exception e) {
        System.out.println("Get Details Test Page Exception " + e.getMessage());
    }
    try {
        //Input variables
        String LZ_AtomMerchantID = "1300101";
        String LZ_Method_type = "postDetails";
        String LZ_Service_id = "9009001";
        String LZ_GetAmount = "100.00";
        String LZ_pricePoint = "1000.00";
        String BA_SUBSCRIBER_ID = "1039442552";
        String LZ_SRNumber = "1337000643";
        String LZ_UsrANI = "101015";
        String LZ_CardType = "";
        String LZ_EMITenure = "31";
        String LZ_MobileNo = ""; // Bank Recharge
        String LZ_BAPin = ""; //  Bank Recharge
        String LZ_RechargeOption = ""; //
        String LZ_RechargeOptionAgent = "";
        String LZ_Product = "DirectSales"; //DirectSales or Recharge
        String LZ_HardwareAmount = "1800.00"; //DirectSales
        String LZ_PackageAmount = "0"; //DirectSales
        String LZ_BonusAmount = "0"; //DirectSales
        String LZ_PackName = "Upgrage";//DirectSales
        //Payment Data
        String LZ_CardNumber = "4012888888881881";
        String LZ_ExpiryDate = "1213";
        String LZ_CVVNumber = "123"; // CREDIT - DEBIT - CITIDB
        String LZ_BatchCode = "123456";
        String LZ_OTP = "123456";
        String LZ_TataskyTxnID = "0012345688900EEEE000089087|ADS130711000855047";

        //Payment Type
        String LZ_PaymentType = "CREDIT";
        String LZ_TSTxnID = "";
        String LZ_AtomTxnUniqueID = ivrId;

        //Output variables
        String LZ_AtomTxnID = "";
        String LZ_BankID = "";
        String LZ_RRN = "";
        String LZ_AuthCode = "";
        String LZ_APGID = "";
        String LZ_Amount = "";
        String LZ_UDF1 = "";
        String LZ_UDF2 = "";
        String LZ_UDF3 = "";
        String LZ_errorcode = "";
        String LZ_errorMsg = "";
        String LZ_PromptName = "";
        String dbCallDetailId = "12";
        // Send the request to Tatasky
        TransactionRechargeResponse objDataService = new TransactionRecharge().requestTransactionRecharge(LZ_AtomMerchantID,
                LZ_Method_type, LZ_Service_id, LZ_GetAmount, BA_SUBSCRIBER_ID, LZ_UsrANI,
                LZ_CardNumber, LZ_ExpiryDate, LZ_CVVNumber, LZ_BatchCode, LZ_OTP, LZ_PaymentType, LZ_TSTxnID,
                LZ_AtomTxnUniqueID, LZ_CardType, LZ_EMITenure, LZ_MobileNo, LZ_BAPin, LZ_RechargeOption,
                LZ_RechargeOptionAgent, LZ_pricePoint, LZ_TataskyTxnID, LZ_Product, LZ_HardwareAmount,
                LZ_PackageAmount, LZ_BonusAmount, LZ_PackName, LZ_SRNumber, dbCallDetailId);

        // Response from Tatasky
        LZ_AtomTxnID = objDataService.getTranscationId();
        LZ_BankID = objDataService.getBankId();
        LZ_RRN = objDataService.getRrn();
        LZ_AuthCode = objDataService.getAuthenticationCode();
        LZ_APGID = objDataService.getAtomPaymentGatewayId();
        LZ_Amount = objDataService.getAmount();
        LZ_UDF1 = objDataService.getCustomerCallerId();
        LZ_UDF2 = objDataService.getPaymentsData();
        LZ_UDF3 = objDataService.getPaymentType();
        LZ_errorcode = objDataService.getErrorCode();
        LZ_errorMsg = objDataService.getErrorMessage();
        System.out.println("TxnID : " + objDataService.getTranscationId());
        System.out.println("getBankId : " + objDataService.getBankId());
        System.out.println("Errorcode : " + objDataService.getErrorCode());
        System.out.println("ErrorMsg : " + objDataService.getErrorMessage());

%>
<table>
    <tr><h3>TransactionRecharge Details Response</h3></tr>
<tr><td>getTranscationId</td> <td><%=objDataService.getTranscationId()%></td></tr>
<tr><td>getBankId :</td> <td><%=objDataService.getBankId()%></td></tr>
<tr><td>getRrn :</td> <td><%=objDataService.getRrn()%></td></tr>
<tr><td>getErrorMessage :</td> <td><%=objDataService.getErrorMessage()%></td></tr>
</table>

<% } catch (Exception e) {
        System.out.println("TransactionRecharge Details Test Page Exception " + e.getMessage());
    }



%>

</body>
</html>