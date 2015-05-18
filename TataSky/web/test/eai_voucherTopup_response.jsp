<%-- 
    Document   : eai_voucherTopup_response
    Created on : Dec 23, 2013, 4:10:22 PM
    Author     : dell
--%>

<%@page import="com.tsg.util.Util"%>
<%@page import="com.tsg.log.Logger"%>
<%@page import="com.tsg.eai.VoucherTopUpResponse"%>
<%@page import="com.tsg.eai.VoucherTopUp"%>
<%@page import="com.tsg.eai.VoucherTopUp"%>
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
        String ivrId = request.getParameter("ivr_id");
        String subscriberNumber = request.getParameter("sbscr_no");
        String voucherPin = request.getParameter("voucher_pin");
//        String date = Util.getCurrentDateAnyFormat("dd/MM/yyyy hh:mm:ss");
        String date = request.getParameter("date");
        String dbCallDetailId = request.getParameter("db_call_detail_id");
        
        Logger.info("voucherTopUpResponse " , Util.getCurrentDateAnyFormat("dd/MM/YYYY hh:mm:ss.SSS"), false);
        VoucherTopUpResponse voucherTopUpResponse = new VoucherTopUp().requestVoucherTopUp(ivrId, 
                subscriberNumber, voucherPin, date, dbCallDetailId);
        
        Logger.info("voucherTopUpResponse " , Util.getCurrentDateAnyFormat("dd/MM/YYYY hh:mm:ss"), false);
        Logger.info("voucherTopUpResponse " , voucherTopUpResponse.getIvrId(), false);
        Logger.info("voucherTopUpResponse " , voucherTopUpResponse.getStatus(), false);
        Logger.info("voucherTopUpResponse " , voucherTopUpResponse.getRechargeValue(), false);
        Logger.info("voucherTopUpResponse " , voucherTopUpResponse.getNewBalance(), false);
        Logger.info("voucherTopUpResponse " , voucherTopUpResponse.getErrorCode(), false);
        Logger.info("voucherTopUpResponse " , Util.getCurrentDateAnyFormat("dd/MM/YYYY hh:mm:ss.SSS"), false);
        
//        Eai ea = new Eai();
//        out.println(ea.voucherTopUp(IVR_ID,Subscbr_num,req_type,daatte));
       %>
       
<table>
    <tr><h3>Voucher Top-Up Response</h3></tr>
<tr><td>Get Ivr Id :</td> <td><%=voucherTopUpResponse.getIvrId()%></td></tr>
<tr><td>Get Status :</td> <td><%=voucherTopUpResponse.getStatus()%></td></tr>
<tr><td>Get Recharge Value :</td> <td><%=voucherTopUpResponse.getRechargeValue()%></td></tr>
<tr><td>Get New Balance :</td> <td><%=voucherTopUpResponse.getNewBalance()%></td></tr>
<tr><td>Get Error Code :</td> <td><%=voucherTopUpResponse.getErrorCode()%></td></tr>
</table>

<% } 
   catch (Exception e) 
   {
        Logger.info("Voucher Top-up Test Page Exception " , e.getMessage(), false);
    }
%>
    </body>
</html>
