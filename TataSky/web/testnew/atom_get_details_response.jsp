<%-- 
    Document   : atom_get_details_response
    Created on : Nov 18, 2013, 9:32:47 AM
    Author     : dell
--%>


<%@page import="com.tsg.portal.ServiceRequestQuery"%>
<%@page import="com.tsg.portal.ServiceRequestQueryResponse"%>
<%@page import="com.tsg.atom.TransactionRecharge"%>
<%@page import="com.tsg.atom.TransactionRechargeResponse"%>
<%@page import="com.tsg.portal.SubscriberValidation"%>
<%@page import="com.tsg.portal.SubscriberValidationResponse"%>
<%@page import="com.tsg.atom.GetDetailsResponse"%>
<%@page import="com.tsg.atom.GetDetails"%>
<%@page import="com.tsg.util.Util"%>
<%@page import="com.tsg.log.Logger"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            try {
                String atomTransactionUniqueID = request.getParameter("ivr_id");
                String tataskyTransId = request.getParameter("tata_sky_transaction_id");
                String atomMerchantId = request.getParameter("atom_merchant_id");
                String methodType = request.getParameter("method_type");
                String serviceId = request.getParameter("service_id");
                String amount = request.getParameter("amount");
                String tataSkySubscriberId = request.getParameter("tata_sbcr_id");
                String customerCallerId = request.getParameter("cust_call_id");
                String genesysUniqueId = request.getParameter("genesys_unique_id");
                String userId = request.getParameter("user_id");
                String product = request.getParameter("prdct");
                String dbCallDetailId = request.getParameter("db_call_detail_id");
                //Atom Transaction Recharge Inputs
                String LZ_Method_type = "postDetails";
                String LZ_pricePoint = "";
                String LZ_UsrANI = "9926845714";
                String LZ_CardType = "";
                String LZ_EMITenure = "00";
                String LZ_MobileNo = "";
                String LZ_BAPin = "";
                String LZ_RechargeOption = "";
                String LZ_RechargeOptionAgent = "";

                String LZ_HardwareAmount = "";
                String LZ_PackageAmount = "";
                String LZ_BonusAmount = "";
                String LZ_PackName = "";

                String LZ_CardNumber = "4012888888881881";
                String LZ_ExpiryDate = "1213";
                String LZ_CVVNumber = "123";
                String LZ_BatchCode = "123456";
                String LZ_OTP = "123456";

                String LZ_PaymentType = "CREDIT";

                String source = "Atom";
                String srNumber = "1337000643";
                String tataskyTransactionUniqueID = "";

                Logger.info("AtomGetDetails", Util.getCurrentDateAnyFormat("dd/MM/YYYY hh:mm:ss.SSS"), false);
                GetDetailsResponse objGetDetails = new GetDetails().requestGetDetails(atomMerchantId, methodType,
                        serviceId, amount, tataSkySubscriberId, customerCallerId, genesysUniqueId, userId, srNumber, product, dbCallDetailId);

                System.out.println("TxnID : " + objGetDetails.getTranscationId());
                System.out.println("OrderID : " + objGetDetails.getOrderId());
                System.out.println("Errorcode : " + objGetDetails.getErrorCode());
                System.out.println("ErrorMsg : " + objGetDetails.getErrorMessage());
                atomTransactionUniqueID = objGetDetails.getTranscationId();
                if (objGetDetails.getErrorMessage().equalsIgnoreCase("SUCCESS")) {
                    if (product.equalsIgnoreCase("Recharge")) {
                        SubscriberValidationResponse objSubscriberValidationResponse =
                                new SubscriberValidation().requestSubscriberValidation(tataSkySubscriberId, dbCallDetailId);

                        tataskyTransactionUniqueID = objSubscriberValidationResponse.getTataskyTransId();
                        if (objSubscriberValidationResponse.getErrorMessage().equalsIgnoreCase("SUBMITTED")) {

                            TransactionRechargeResponse objTransactionRecharge = new TransactionRecharge().requestTransactionRecharge(atomMerchantId,
                                    LZ_Method_type, serviceId, amount, tataSkySubscriberId, LZ_UsrANI,
                                    LZ_CardNumber, LZ_ExpiryDate, LZ_CVVNumber, LZ_BatchCode, LZ_OTP, LZ_PaymentType, tataskyTransactionUniqueID,
                                    atomTransactionUniqueID, LZ_CardType, LZ_EMITenure, LZ_MobileNo, LZ_BAPin, LZ_RechargeOption,
                                    LZ_RechargeOptionAgent, LZ_pricePoint, tataskyTransactionUniqueID, product, LZ_HardwareAmount,
                                    LZ_PackageAmount, LZ_BonusAmount, LZ_PackName, dbCallDetailId);
                            if (objTransactionRecharge.getErrorMessage().equalsIgnoreCase("SUCCESS")) {
        %> 
        <table>
            <tr><h3>post Details Response</h3></tr>
        <tr><td>Get Transaction Id :</td> <td><%=objTransactionRecharge.getTranscationId()%></td></tr>
        <tr><td>Get Bank Id :</td> <td><%=objTransactionRecharge.getBankId()%></td></tr>
        <tr><td>Get Rrn :</td> <td><%=objTransactionRecharge.getRrn()%></td></tr>
        <tr><td>Get Error Message :</td> <td><%=objTransactionRecharge.getErrorMessage()%></td></tr>
    </table>
    <%            } else {
    %> 
    <table>
        <tr><h3>post Details Response</h3></tr>
    <tr><td>Get Transaction Id :</td> <td><%=objTransactionRecharge.getTranscationId()%></td></tr>
    <tr><td>Get Bank Id :</td> <td><%=objTransactionRecharge.getBankId()%></td></tr>
    <tr><td>Get Rrn :</td> <td><%=objTransactionRecharge.getRrn()%></td></tr>
    <tr><td>Get Error Message :</td> <td><%=objTransactionRecharge.getErrorMessage()%></td></tr>
</table>   
<%

    }
} else {
%> 
<table>
    <tr><h3>Subscriber Validation Response</h3></tr>
<tr><td>Get Subscriber Id :</td> <td><%=objSubscriberValidationResponse.getSubscriberId()%></td></tr>
<tr><td>Get Account Type :</td> <td><%=objSubscriberValidationResponse.getAccountType()%></td></tr>
<tr><td>Get Account Sub Type :</td> <td><%=objSubscriberValidationResponse.getAccountSubType()%></td></tr>
<tr><td>Get Account Status :</td> <td><%=objSubscriberValidationResponse.getAccountStatus()%></td></tr>
<tr><td>Get Current Balance :</td> <td><%=objSubscriberValidationResponse.getCurrentBalance()%></td></tr>
<tr><td>Get Preferred Language :</td> <td><%=objSubscriberValidationResponse.getPreferredLanguage()%></td></tr>
<tr><td>Get Tatasky Trans Id :</td> <td><%=objSubscriberValidationResponse.getTataskyTransId()%></td></tr>
<tr><td>Get Error Code :</td> <td><%=objSubscriberValidationResponse.getErrorCode()%></td></tr>
<tr><td>Get Error Message :</td> <td><%=objSubscriberValidationResponse.getErrorMessage()%></td></tr>
</table>
<%
    }
} else if (product.equalsIgnoreCase("DirectSales")) {
    String date = Util.getCurrentDateAnyFormat("dd/MM/yyyy hh:mm:ss");
    ServiceRequestQueryResponse objServiceRequestQueryResponse =
            new ServiceRequestQuery().requestServiceQuery(source, atomTransactionUniqueID, srNumber, date, dbCallDetailId);
    tataskyTransactionUniqueID = objServiceRequestQueryResponse.getTataskyTransId();
    if (objServiceRequestQueryResponse.getErrorCode().equalsIgnoreCase("3000")) {
        TransactionRechargeResponse objTransactionRecharge = new TransactionRecharge().requestTransactionRecharge(atomMerchantId,
                LZ_Method_type, serviceId, amount, tataSkySubscriberId, LZ_UsrANI,
                LZ_CardNumber, LZ_ExpiryDate, LZ_CVVNumber, LZ_BatchCode, LZ_OTP, LZ_PaymentType, tataskyTransactionUniqueID,
                atomTransactionUniqueID, LZ_CardType, LZ_EMITenure, LZ_MobileNo, LZ_BAPin, LZ_RechargeOption,
                LZ_RechargeOptionAgent, LZ_pricePoint, tataskyTransactionUniqueID, product, LZ_HardwareAmount,
                LZ_PackageAmount, LZ_BonusAmount, LZ_PackName, dbCallDetailId);
        if (objTransactionRecharge.getErrorMessage().equalsIgnoreCase("SUCCESS")) {
%> 
<table>
    <tr><h3>post Details Response</h3></tr>
<tr><td>Get Transaction Id :</td> <td><%=objTransactionRecharge.getTranscationId()%></td></tr>
<tr><td>Get Bank Id :</td> <td><%=objTransactionRecharge.getBankId()%></td></tr>
<tr><td>Get Rrn :</td> <td><%=objTransactionRecharge.getRrn()%></td></tr>
<tr><td>Get Error Message :</td> <td><%=objTransactionRecharge.getErrorMessage()%></td></tr>
</table>
<%            } else {
%> 
<table>
    <tr><h3>post Details Response</h3></tr>
<tr><td>Get Transaction Id :</td> <td><%=objTransactionRecharge.getTranscationId()%></td></tr>
<tr><td>Get Bank Id :</td> <td><%=objTransactionRecharge.getBankId()%></td></tr>
<tr><td>Get Rrn :</td> <td><%=objTransactionRecharge.getRrn()%></td></tr>
<tr><td>Get Error Message :</td> <td><%=objTransactionRecharge.getErrorMessage()%></td></tr>
</table>   
<%

    }

} else {
%> 
<table>
    <tr><h3>Service Request Query Response</h3></tr>
<tr><td>Get Atom Ivr Id :</td> <td><%=objServiceRequestQueryResponse.getAtomIvrId()%></td></tr>
<tr><td>Get Sr Number :</td> <td><%=objServiceRequestQueryResponse.getSrNumber()%></td></tr>
<tr><td>Get Tatasky Trans Id :</td> <td><%=objServiceRequestQueryResponse.getTataskyTransId()%></td></tr>
<tr><td>Get Sr Type :</td> <td><%=objServiceRequestQueryResponse.getSrType()%></td></tr>
<tr><td>Get Sr Area :</td> <td><%=objServiceRequestQueryResponse.getSrArea()%></td></tr>
<tr><td>Get Sr Sub Area :</td> <td><%=objServiceRequestQueryResponse.getSrSubArea()%></td></tr>
<tr><td>Get Price Point :</td> <td><%=objServiceRequestQueryResponse.getPricePoint()%></td></tr>
<tr><td>Get Subscriber Id :</td> <td><%=objServiceRequestQueryResponse.getSubscriberId()%></td></tr>
<tr><td>Get Date :</td> <td><%=objServiceRequestQueryResponse.getDate()%></td></tr>
<tr><td>Get Personal City :</td> <td><%=objServiceRequestQueryResponse.getPersonalCity()%></td></tr>
<tr><td>Get Error Code :</td> <td><%=objServiceRequestQueryResponse.getErrorCode()%></td></tr>
</table>
<%
        }
    }

} else {
%>
<table>
    <tr><h3>Get Details Response</h3></tr>
<tr><td>Get Transaction Id :</td> <td><%=objGetDetails.getTranscationId()%></td></tr>
<tr><td>Get Order Id :</td> <td><%=objGetDetails.getOrderId()%></td></tr>
<tr><td>Get Error Code :</td> <td><%=objGetDetails.getErrorCode()%></td></tr>
<tr><td>Get Error Message :</td> <td><%=objGetDetails.getErrorMessage()%></td></tr>
</table>

<%
        }
        Logger.info("AtomGetDetails", Util.getCurrentDateAnyFormat("dd/MM/YYYY hh:mm:ss.SSS"), false);
    } catch (Exception e) {
        System.out.println("Get Details Test Page Exception " + e.getMessage());
    }
%>
</body>
</html>
