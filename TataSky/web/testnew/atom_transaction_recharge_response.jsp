<%-- 
    Document   : atom_transaction_recharge_response
    Created on : Nov 18, 2013, 5:40:15 PM
    Author     : dell
--%>

<%@page import="com.tsg.util.Util"%>
<%@page import="com.tsg.log.Logger"%>
<%@page import="com.tsg.atom.TransactionRechargeResponse"%>
<%@page import="com.tsg.atom.TransactionRecharge"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
        try
        {
        String LZ_AtomMerchantID = request.getParameter("atom_merchant_id");
        String LZ_Method_type = request.getParameter("method_type");
        String LZ_Service_id = request.getParameter("service_id");
        String LZ_GetAmount = request.getParameter("amount");
        String LZ_pricePoint = request.getParameter("price_point");
        String BA_SUBSCRIBER_ID = request.getParameter("sbscrbr_id");
        String LZ_UsrANI = request.getParameter("user_ani");
        String LZ_CardType = request.getParameter("card_type");
        String LZ_EMITenure = request.getParameter("emi_tenure");
        
        String LZ_MobileNo = request.getParameter("mob_num");
        String LZ_BAPin = request.getParameter("ba_pin");
        String LZ_RechargeOption = request.getParameter("recharge_option");
        String LZ_RechargeOptionAgent = request.getParameter("recharge_option_agent");
        String LZ_Product = request.getParameter("prdct");
                
        String LZ_HardwareAmount = request.getParameter("hardware_amnt");
        String LZ_PackageAmount = request.getParameter("package_amnt");
        String LZ_BonusAmount = request.getParameter("bonus_amnt");
        String LZ_PackName = request.getParameter("pack_name");
        
        String LZ_CardNumber = request.getParameter("card_num");
        String LZ_ExpiryDate = request.getParameter("expiry_date");
        String LZ_CVVNumber = request.getParameter("cvv_num");
        String LZ_BatchCode = request.getParameter("batch_code");
        String LZ_OTP = request.getParameter("otp");
        String LZ_TataskyTxnID = request.getParameter("tatasky_trans_id");
      
        String LZ_PaymentType = request.getParameter("pymnt_type");
        String LZ_AtomTxnUniqueID = request.getParameter("atom_txn_id");
        String dbCallDetailId = request.getParameter("db_call_detail_id");
        
        Logger.info("AtomPostDetails " , Util.getCurrentDateAnyFormat("dd/MM/YYYY hh:mm:ss.SSS"), false);
        TransactionRechargeResponse objDataService = new TransactionRecharge().requestTransactionRecharge(LZ_AtomMerchantID,
                LZ_Method_type, LZ_Service_id, LZ_GetAmount, BA_SUBSCRIBER_ID, LZ_UsrANI,
                LZ_CardNumber, LZ_ExpiryDate, LZ_CVVNumber, LZ_BatchCode, LZ_OTP, LZ_PaymentType, LZ_TataskyTxnID,
                LZ_AtomTxnUniqueID, LZ_CardType, LZ_EMITenure, LZ_MobileNo, LZ_BAPin, LZ_RechargeOption,
                LZ_RechargeOptionAgent, LZ_pricePoint, LZ_TataskyTxnID, LZ_Product, LZ_HardwareAmount,
                LZ_PackageAmount, LZ_BonusAmount, LZ_PackName, dbCallDetailId);
        
        
        System.out.println("LZ_AtomTxnID : " + objDataService.getTranscationId());
        System.out.println("LZ_BankID : " + objDataService.getBankId());
        System.out.println("LZ_RRN : " + objDataService.getRrn());
        System.out.println("LZ_AuthCode : " + objDataService.getAuthenticationCode());
        System.out.println("LZ_APGID : " + objDataService.getAtomPaymentGatewayId());
        System.out.println("LZ_Amount : " + objDataService.getAmount());
        System.out.println("LZ_UDF1 : " + objDataService.getCustomerCallerId());
        System.out.println("LZ_UDF2 : " + objDataService.getPaymentsData());
        System.out.println("LZ_UDF3 : " + objDataService.getPaymentType());
        System.out.println("LZ_errorcode : " + objDataService.getErrorCode());
        System.out.println("LZ_errorMsg : " + objDataService.getErrorMessage());
        
        %>
        
<!--         LZ_AtomTxnID = objDataService.getTranscationId();
        LZ_BankID = objDataService.getBankId();
        LZ_RRN = objDataService.getRrn();
        LZ_AuthCode = objDataService.getAuthenticationCode();
        LZ_APGID = objDataService.getAtomPaymentGatewayId();
        LZ_Amount = objDataService.getAmount();
        LZ_UDF1 = objDataService.getCustomerCallerId();
        LZ_UDF2 = objDataService.getPaymentsData();
        LZ_UDF3 = objDataService.getPaymentType();
        LZ_errorcode = objDataService.getErrorCode();
        LZ_errorMsg = objDataService.getErrorMessage();%>-->
<table>
    <tr><h3>post Details Response</h3></tr>
<tr><td>Get Transaction Id :</td> <td><%=objDataService.getTranscationId()%></td></tr>
<tr><td>Get Bank Id :</td> <td><%=objDataService.getBankId()%></td></tr>
<tr><td>Get Rrn :</td> <td><%=objDataService.getRrn()%></td></tr>
<tr><td>Get Error Message :</td> <td><%=objDataService.getErrorMessage()%></td></tr>
</table>

<% 
    Logger.info("AtomPostDetails " , Util.getCurrentDateAnyFormat("dd/MM/YYYY hh:mm:ss.SSS"), false);
        } catch (Exception e) {
        System.out.println("Get Details Test Page Exception " + e.getMessage());
    }

%>
    </body>
</html>
