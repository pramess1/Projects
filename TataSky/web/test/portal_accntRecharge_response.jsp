<%-- 
    Document   : portal_accntRecharge_response
    Created on : Dec 24, 2013, 7:29:33 AM
    Author     : dell
--%>

<%@page import="com.tsg.portal.PaymentReceiverResponse"%>
<%@page import="com.tsg.portal.PaymentReceiver"%>
<%@page import="com.tsg.log.Logger"%>
<%@page import="com.tsg.util.Util"%>
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
        String subscriberId = request.getParameter("sbscrbr_id");
        String tataskyTransId = request.getParameter("tata_txn_id");
        String atomTransId = request.getParameter("atom_txn_id");
        String bankName = request.getParameter("bank_nam");
        String amount = request.getParameter("amnt");
        String date = request.getParameter("date");
        String paymentGatewayId = request.getParameter("pymnt_gtway_id");
        String rrn = request.getParameter("rrn");
        String errorCode = request.getParameter("err_cd");
        String errorMessage = request.getParameter("err_msg");
        String checkSum = request.getParameter("chk_sum");
        String dbCallDetailId = request.getParameter("db_call_detail");
        
        Logger.info("PortalAccountRechargeResponse " , Util.getCurrentDateAnyFormat("dd/MM/YYYY hh:mm:ss.SSS"), false);
        PaymentReceiverResponse paymentReceiverResponse = new PaymentReceiver().requestPaymentReceiver(subscriberId,
         tataskyTransId,atomTransId, bankName, amount, date, paymentGatewayId, rrn, errorCode, errorMessage, 
         checkSum, dbCallDetailId);
        
//        Portal por = new Portal();
//        out.println(por.accountRecharge(Sbscrbr_id,Tata_Txn_id,Atom_txn_id,Bank_name,Amnt,Daate,Pymnt_gtwy_id,Rrn,Err_code,Err_msg,Chk_sum));
       %>
       
       <table>
            <tr><h3>Payment Receiver Response</h3></tr>
        <tr><td>Get Subscriber Id :</td> <td><%=paymentReceiverResponse.getSubscriberId()%></td></tr>
        <tr><td>Get Amount :</td> <td><%=paymentReceiverResponse.getAmount()%></td></tr>
        <tr><td>Get AtomTrans Id :</td> <td><%=paymentReceiverResponse.getAtomTransId()%></td></tr>
        <tr><td>Get Bank Name :</td> <td><%=paymentReceiverResponse.getBankName()%></td></tr>
        <tr><td>Get Bonus :</td> <td><%=paymentReceiverResponse.getBonus()%></td></tr>
        <tr><td>Get Checksum :</td> <td><%=paymentReceiverResponse.getChecksum()%></td></tr>
        <tr><td>Get Tatasky TransId :</td> <td><%=paymentReceiverResponse.getTataskyTransId()%></td></tr>
        <tr><td>Get Error Code :</td> <td><%=paymentReceiverResponse.getErrorCode()%></td></tr>
        <tr><td>Get Error Message :</td> <td><%=paymentReceiverResponse.getErrorMessage()%></td></tr>
    </table>
    <%  
     
     Logger.info("PortalAccountRechargeResponse " , Util.getCurrentDateAnyFormat("dd/MM/YYYY hh:mm:ss.SSS"), false);
     } 
     
     catch (Exception e) 
     {
            System.out.println("AccountRecharge Test Page Exception " + e.getMessage());
      }
     %>
    </body>
</html>
