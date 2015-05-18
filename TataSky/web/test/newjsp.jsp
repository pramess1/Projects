<%-- 
    Document   : atom
    Created on : Oct 30, 2013, 11:28:05 AM
    Author     : Rajesh
--%>

<%@page import="com.tsg.util.Util"%>
<%@page import="com.tsg.eai.AccountBalance"%>
<%@page import="com.tsg.log.Logger"%>
<%@page import="com.tsg.eai.AccountBalanceResponse"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.tsg.atom.*"%>
<%@page import="com.tsg.portal.*"%>
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
            String dbCallDetailId = "";
            String amount = "";
            String rrn = "";
            try {
                String atomMerchantId = "1300111";
                String methodType = "getDetails";
                String serviceId = "2000001";
                amount = "100.00";
                String tataSkySubscriberId = "3000341077";
                String customerCallerId = "9926845714";
                String genesysUniqueId = "1234567977";
                String userId = "";
                String srNumber = "";
                String product = "Recharge";


        %>
        <table>
            <tr><h3>Get Details Request</h3></tr>
        <tr><td>Atom MerchantId</td> <td><%=atomMerchantId%></td></tr>
        <tr><td>Method Type :</td> <td><%=methodType%></td></tr>
        <tr><td>Service Id :</td> <td><%=serviceId%></td></tr>
        <tr><td>Amount :</td> <td><%=amount%></td></tr>
        <tr><td>TataSky Subscriber Id :</td> <td><%=tataSkySubscriberId%></td></tr>
        <tr><td>Customer Caller Id :</td> <td><%=customerCallerId%></td></tr>
        <tr><td>Genesys Unique Id :</td> <td><%=genesysUniqueId%></td></tr>
    </table>

    <%

        GetDetailsResponse objDataService = new GetDetails().requestGetDetails(atomMerchantId, methodType,
                serviceId, amount, tataSkySubscriberId, customerCallerId, genesysUniqueId, userId, srNumber, product, dbCallDetailId);
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



    //Payment        

    try {
        //Input variables
        String LZ_AtomMerchantID = "1300111";
        String LZ_Method_type = "postDetails";
        String LZ_Service_id = "9009001";
        String LZ_GetAmount = "100.00";
        String LZ_pricePoint = "";
        String BA_SUBSCRIBER_ID = "3000341077";
        String LZ_UsrANI = "9926845714";
        String LZ_CardType = ""; //AMEX
        String LZ_EMITenure = "90";
        String LZ_MobileNo = ""; // Bank Recharge
        String LZ_BAPin = ""; //  Bank Recharge
        String LZ_RechargeOption = ""; //
        String LZ_RechargeOptionAgent = "";
        String LZ_Product = "Recharge"; //DirectSales or Recharge
        String LZ_HardwareAmount = ""; //DirectSales
        String LZ_PackageAmount = ""; //DirectSales
        String LZ_BonusAmount = ""; //DirectSales
        String LZ_PackName = "";//DirectSales
        //Payment Data
        String LZ_CardNumber = "4012888888881881"; //4012888888881881 // 301288124446755
        String LZ_ExpiryDate = "1214";  //1214
        String LZ_CVVNumber = "123"; // CREDIT - DEBIT - CITIDB
        String LZ_BatchCode = "1234";
        String LZ_OTP = "123456";
        String LZ_TataskyTxnID = tataskyTransId;

        //Payment Type
        String LZ_PaymentType = "CREDIT"; //CREDIT
        String LZ_TSTxnID = tataskyTransId;
        LZ_TSTxnID = "123456";
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

        String srNumber = "1337000643";

%>
<table>
    <tr><h3>Payment Details Request (PG Trans)</h3></tr>
<tr><td>Atom MerchantId</td> <td><%=LZ_AtomMerchantID%></td></tr>
<tr><td>Method Type :</td> <td><%=LZ_Method_type%></td></tr>
<tr><td>Service Id :</td> <td><%=LZ_Service_id%></td></tr>
<tr><td>Amount :</td> <td><%=LZ_GetAmount%></td></tr>
<tr><td>TataSky Subscriber Id :</td> <td><%=BA_SUBSCRIBER_ID%></td></tr>
<tr><td>Customer Caller Id :</td> <td><%=LZ_UsrANI%></td></tr>
<tr><td>CardNumber :</td> <td><%=LZ_CardNumber%></td></tr>
<tr><td>OTP :</td> <td><%=LZ_ExpiryDate%></td></tr>
<tr><td>ExpiryDate :</td> <td><%=LZ_CVVNumber%></td></tr>
<tr><td>BatchCode :</td> <td><%=LZ_BatchCode%></td></tr>
<tr><td>OTP :</td> <td><%=LZ_OTP%></td></tr>
</table>

<%

    // Send the request to Tatasky
    TransactionRechargeResponse objDataService = new TransactionRecharge().requestTransactionRecharge(LZ_AtomMerchantID,
            LZ_Method_type, LZ_Service_id, LZ_GetAmount, BA_SUBSCRIBER_ID, LZ_UsrANI,
            LZ_CardNumber, LZ_ExpiryDate, LZ_CVVNumber, LZ_BatchCode, LZ_OTP, LZ_PaymentType, LZ_TSTxnID,
            LZ_AtomTxnUniqueID, LZ_CardType, LZ_EMITenure, LZ_MobileNo, LZ_BAPin, LZ_RechargeOption,
            LZ_RechargeOptionAgent, LZ_pricePoint, LZ_TataskyTxnID, LZ_Product, LZ_HardwareAmount,
            LZ_PackageAmount, LZ_BonusAmount, LZ_PackName, srNumber, dbCallDetailId);

    // Response from Tatasky
    LZ_AtomTxnID = objDataService.getTranscationId();
    LZ_BankID = objDataService.getBankId();
    LZ_RRN = objDataService.getRrn();
    rrn = LZ_RRN;
    LZ_AuthCode = objDataService.getAuthenticationCode();
    LZ_APGID = objDataService.getAtomPaymentGatewayId();
    LZ_Amount = objDataService.getAmount();
    amount = LZ_Amount;
    LZ_UDF1 = objDataService.getCustomerCallerId();
    LZ_UDF2 = objDataService.getPaymentsData();
    LZ_UDF3 = objDataService.getPaymentType();
    LZ_errorcode = objDataService.getErrorCode();
    LZ_errorMsg = objDataService.getErrorMessage();%>
<table>
    <tr><h3>Payment Details Response</h3></tr>
<tr><td>getTranscationId</td> <td><%=objDataService.getTranscationId()%></td></tr>
<tr><td>getBankId :</td> <td><%=objDataService.getBankId()%></td></tr>
<tr><td>getRrn :</td> <td><%=objDataService.getRrn()%></td></tr>
<tr><td>getErrorMessage :</td> <td><%=objDataService.getErrorMessage()%></td></tr>
</table>

<% } catch (Exception e) {
        System.out.println("Payment Details Test Page Exception " + e.getMessage());
    }

%>

</body>
</html>
