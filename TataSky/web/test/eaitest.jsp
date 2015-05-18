<%-- 
    Document   : eai
    Created on : Oct 30, 2013, 9:20:41 AM
    Author     : Rajesh
--%>

<%@page import="com.tsg.database.DBAccess"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.tsg.eai.*"%>
<%@page import="com.tsg.error.ErrorHandler"%>
<%@page import="com.tsg.util.Util"%>
<%@page import="com.tsg.log.Logger"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>

        <%//Account Balance Balance
            String dbCallDetailId = "12";
            try {

                String ivrId = "AV87";
                String subscriberNumber = "3000341077";
                String dateTime = Util.getCurrentDateAnyFormat("dd/MM/yyyy hh:mm:ss");


                AccountBalanceResponse AccountBalanceResponse = new AccountBalance().requestAccountBalance(ivrId, subscriberNumber, dateTime, dbCallDetailId);
                Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getIvrId(), false);
                Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getBalance(), false);
                Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getDueDateTime(), false);
                Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getErrorCode(), false);

        %>
        <table>
            <tr><h3>Account Balance Response</h3></tr>
        <tr><td>getIvrId:</td> <td><%=AccountBalanceResponse.getIvrId()%></td></tr>
        <tr><td>getBalance :</td> <td><%=AccountBalanceResponse.getBalance()%></td></tr>
        <tr><td>getDueDateTime :</td> <td><%=AccountBalanceResponse.getDueDateTime()%></td></tr>
        <tr><td>getErrorCode :</td> <td><%=AccountBalanceResponse.getErrorCode()%></td></tr>
    </table>

    <% } catch (Exception e) {
            Logger.info("Account Balance Test Page Exception ", e.getMessage(), false);
        }

        // Voucher Top-up
        try {
            String ivrId = "AV87";
            String subscriberNumber = "3000341077";
            String voucherPin = "2036412372751761";//7170213611770315
            String date = Util.getCurrentDateAnyFormat("dd/MM/yyyy hh:mm:ss");

            VoucherTopUpResponse voucherTopUpResponse = new VoucherTopUp().requestVoucherTopUp(ivrId, subscriberNumber, voucherPin, date, dbCallDetailId);

            Logger.info("voucherTopUpResponse ", voucherTopUpResponse.getIvrId(), false);
            Logger.info("voucherTopUpResponse ", voucherTopUpResponse.getStatus(), false);
            Logger.info("voucherTopUpResponse ", voucherTopUpResponse.getRechargeValue(), false);
            Logger.info("voucherTopUpResponse ", voucherTopUpResponse.getNewBalance(), false);
            Logger.info("voucherTopUpResponse ", voucherTopUpResponse.getErrorCode(), false);
    %>
    <table>
        <tr><h3>Voucher TopUp Response</h3></tr>
    <tr><td>getIvrId:</td> <td><%=voucherTopUpResponse.getIvrId()%></td></tr>
    <tr><td>getStatus :</td> <td><%=voucherTopUpResponse.getStatus()%></td></tr>
    <tr><td>getRechargeValue :</td> <td><%=voucherTopUpResponse.getRechargeValue()%></td></tr>
    <tr><td>getNewBalance :</td> <td><%=voucherTopUpResponse.getNewBalance()%></td></tr>
    <tr><td>getErrorCode :</td> <td><%=voucherTopUpResponse.getErrorCode()%></td></tr>
</table>
<% } catch (Exception e) {
        Logger.info("Voucher Top-up Test Page Exception ", e.getMessage(), false);
    }
    try {

        String getAccountDetail = new DBAccess().getAccountDetail("3000341077");
        System.out.println("xml=" + getAccountDetail);
        
        Logger.info("Get Account Detail ", getAccountDetail, false);

    } catch (Exception e) {
    }

    try {

        String ivrId = "AV87";
        String subscriberNumber = "3000341077";
        String dateTime = Util.getCurrentDateAnyFormat("dd/MM/yyyy hh:mm:ss");
        AccountBalanceResponse AccountBalanceResponse = new AccountBalance().requestAccountBalance(ivrId, subscriberNumber, dateTime, dbCallDetailId);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getIvrId(), false);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getBalance(), false);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getDueDateTime(), false);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getErrorCode(), false);

%>
<table>
    <tr><h3>Account Balance Response</h3></tr>
<tr><td>getIvrId:</td> <td><%=AccountBalanceResponse.getIvrId()%></td></tr>
<tr><td>getBalance :</td> <td><%=AccountBalanceResponse.getBalance()%></td></tr>
<tr><td>getDueDateTime :</td> <td><%=AccountBalanceResponse.getDueDateTime()%></td></tr>
<tr><td>getErrorCode :</td> <td><%=AccountBalanceResponse.getErrorCode()%></td></tr>
</table>

<% } catch (Exception e) {
        Logger.info("Account Balance Test Page Exception ", e.getMessage(), false);
    }

    try {
        String ivrId = "AV87";
        String subscriberNumber = "3000341077";
        String dateTime = Util.getCurrentDateAnyFormat("dd/MM/yyyy hh:mm:ss");
        AccountBalanceResponse AccountBalanceResponse = new AccountBalance().requestAccountBalance(ivrId, subscriberNumber, dateTime, dbCallDetailId);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getIvrId(), false);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getBalance(), false);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getDueDateTime(), false);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getErrorCode(), false);

%>
<table>
    <tr><h3>Account Balance Response</h3></tr>
<tr><td>getIvrId:</td> <td><%=AccountBalanceResponse.getIvrId()%></td></tr>
<tr><td>getBalance :</td> <td><%=AccountBalanceResponse.getBalance()%></td></tr>
<tr><td>getDueDateTime :</td> <td><%=AccountBalanceResponse.getDueDateTime()%></td></tr>
<tr><td>getErrorCode :</td> <td><%=AccountBalanceResponse.getErrorCode()%></td></tr>
</table>

<% } catch (Exception e) {
        Logger.info("Account Balance Test Page Exception ", e.getMessage(), false);
    }


    try {

        String ivrId = "AV87";
        String subscriberNumber = "3000341077";
        String dateTime = Util.getCurrentDateAnyFormat("dd/MM/yyyy hh:mm:ss");
        AccountBalanceResponse AccountBalanceResponse = new AccountBalance().requestAccountBalance(ivrId, subscriberNumber, dateTime, dbCallDetailId);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getIvrId(), false);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getBalance(), false);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getDueDateTime(), false);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getErrorCode(), false);

%>
<table>
    <tr><h3>Account Balance Response</h3></tr>
<tr><td>getIvrId:</td> <td><%=AccountBalanceResponse.getIvrId()%></td></tr>
<tr><td>getBalance :</td> <td><%=AccountBalanceResponse.getBalance()%></td></tr>
<tr><td>getDueDateTime :</td> <td><%=AccountBalanceResponse.getDueDateTime()%></td></tr>
<tr><td>getErrorCode :</td> <td><%=AccountBalanceResponse.getErrorCode()%></td></tr>
</table>

<% } catch (Exception e) {
        Logger.info("Account Balance Test Page Exception ", e.getMessage(), false);
    }



    try {

        String ivrId = "AV87";
        String subscriberNumber = "3000341077";
        String dateTime = Util.getCurrentDateAnyFormat("dd/MM/yyyy hh:mm:ss");
        AccountBalanceResponse AccountBalanceResponse = new AccountBalance().requestAccountBalance(ivrId, subscriberNumber, dateTime, dbCallDetailId);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getIvrId(), false);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getBalance(), false);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getDueDateTime(), false);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getErrorCode(), false);

%>
<table>
    <tr><h3>Account Balance Response</h3></tr>
<tr><td>getIvrId:</td> <td><%=AccountBalanceResponse.getIvrId()%></td></tr>
<tr><td>getBalance :</td> <td><%=AccountBalanceResponse.getBalance()%></td></tr>
<tr><td>getDueDateTime :</td> <td><%=AccountBalanceResponse.getDueDateTime()%></td></tr>
<tr><td>getErrorCode :</td> <td><%=AccountBalanceResponse.getErrorCode()%></td></tr>
</table>

<% } catch (Exception e) {
        Logger.info("Account Balance Test Page Exception ", e.getMessage(), false);
    }


    try {

        String ivrId = "AV87";
        String subscriberNumber = "3000341077";
        String dateTime = Util.getCurrentDateAnyFormat("dd/MM/yyyy hh:mm:ss");
        AccountBalanceResponse AccountBalanceResponse = new AccountBalance().requestAccountBalance(ivrId, subscriberNumber, dateTime, dbCallDetailId);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getIvrId(), false);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getBalance(), false);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getDueDateTime(), false);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getErrorCode(), false);

%>
<table>
    <tr><h3>Account Balance Response</h3></tr>
<tr><td>getIvrId:</td> <td><%=AccountBalanceResponse.getIvrId()%></td></tr>
<tr><td>getBalance :</td> <td><%=AccountBalanceResponse.getBalance()%></td></tr>
<tr><td>getDueDateTime :</td> <td><%=AccountBalanceResponse.getDueDateTime()%></td></tr>
<tr><td>getErrorCode :</td> <td><%=AccountBalanceResponse.getErrorCode()%></td></tr>
</table>

<% } catch (Exception e) {
        Logger.info("Account Balance Test Page Exception ", e.getMessage(), false);
    }

    try {

        String ivrId = "AV87";
        String subscriberNumber = "3000341077";
        String dateTime = Util.getCurrentDateAnyFormat("dd/MM/yyyy hh:mm:ss");
        AccountBalanceResponse AccountBalanceResponse = new AccountBalance().requestAccountBalance(ivrId, subscriberNumber, dateTime, dbCallDetailId);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getIvrId(), false);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getBalance(), false);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getDueDateTime(), false);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getErrorCode(), false);

%>
<table>
    <tr><h3>Account Balance Response</h3></tr>
<tr><td>getIvrId:</td> <td><%=AccountBalanceResponse.getIvrId()%></td></tr>
<tr><td>getBalance :</td> <td><%=AccountBalanceResponse.getBalance()%></td></tr>
<tr><td>getDueDateTime :</td> <td><%=AccountBalanceResponse.getDueDateTime()%></td></tr>
<tr><td>getErrorCode :</td> <td><%=AccountBalanceResponse.getErrorCode()%></td></tr>
</table>

<% } catch (Exception e) {
        Logger.info("Account Balance Test Page Exception ", e.getMessage(), false);
    }

    try {

        String ivrId = "AV87";
        String subscriberNumber = "3000341077";
        String dateTime = Util.getCurrentDateAnyFormat("dd/MM/yyyy hh:mm:ss");
        AccountBalanceResponse AccountBalanceResponse = new AccountBalance().requestAccountBalance(ivrId, subscriberNumber, dateTime, dbCallDetailId);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getIvrId(), false);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getBalance(), false);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getDueDateTime(), false);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getErrorCode(), false);

%>
<table>
    <tr><h3>Account Balance Response</h3></tr>
<tr><td>getIvrId:</td> <td><%=AccountBalanceResponse.getIvrId()%></td></tr>
<tr><td>getBalance :</td> <td><%=AccountBalanceResponse.getBalance()%></td></tr>
<tr><td>getDueDateTime :</td> <td><%=AccountBalanceResponse.getDueDateTime()%></td></tr>
<tr><td>getErrorCode :</td> <td><%=AccountBalanceResponse.getErrorCode()%></td></tr>
</table>

<% } catch (Exception e) {
        Logger.info("Account Balance Test Page Exception ", e.getMessage(), false);
    }

    try {

        String ivrId = "AV87";
        String subscriberNumber = "3000341077";
        String dateTime = Util.getCurrentDateAnyFormat("dd/MM/yyyy hh:mm:ss");
        AccountBalanceResponse AccountBalanceResponse = new AccountBalance().requestAccountBalance(ivrId, subscriberNumber, dateTime, dbCallDetailId);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getIvrId(), false);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getBalance(), false);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getDueDateTime(), false);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getErrorCode(), false);

%>
<table>
    <tr><h3>Account Balance Response</h3></tr>
<tr><td>getIvrId:</td> <td><%=AccountBalanceResponse.getIvrId()%></td></tr>
<tr><td>getBalance :</td> <td><%=AccountBalanceResponse.getBalance()%></td></tr>
<tr><td>getDueDateTime :</td> <td><%=AccountBalanceResponse.getDueDateTime()%></td></tr>
<tr><td>getErrorCode :</td> <td><%=AccountBalanceResponse.getErrorCode()%></td></tr>
</table>

<% } catch (Exception e) {
        Logger.info("Account Balance Test Page Exception ", e.getMessage(), false);
    }
            
             try {

        String ivrId = "AV87";
        String subscriberNumber = "3000341077";
        String dateTime = Util.getCurrentDateAnyFormat("dd/MM/yyyy hh:mm:ss");
        AccountBalanceResponse AccountBalanceResponse = new AccountBalance().requestAccountBalance(ivrId, subscriberNumber, dateTime, dbCallDetailId);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getIvrId(), false);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getBalance(), false);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getDueDateTime(), false);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getErrorCode(), false);

%>
<table>
    <tr><h3>Account Balance Response</h3></tr>
<tr><td>getIvrId:</td> <td><%=AccountBalanceResponse.getIvrId()%></td></tr>
<tr><td>getBalance :</td> <td><%=AccountBalanceResponse.getBalance()%></td></tr>
<tr><td>getDueDateTime :</td> <td><%=AccountBalanceResponse.getDueDateTime()%></td></tr>
<tr><td>getErrorCode :</td> <td><%=AccountBalanceResponse.getErrorCode()%></td></tr>
</table>

<% } catch (Exception e) {
        Logger.info("Account Balance Test Page Exception ", e.getMessage(), false);
    }
            
             try {

        String ivrId = "AV87";
        String subscriberNumber = "3000341077";
        String dateTime = Util.getCurrentDateAnyFormat("dd/MM/yyyy hh:mm:ss");
        AccountBalanceResponse AccountBalanceResponse = new AccountBalance().requestAccountBalance(ivrId, subscriberNumber, dateTime, dbCallDetailId);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getIvrId(), false);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getBalance(), false);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getDueDateTime(), false);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getErrorCode(), false);

%>
<table>
    <tr><h3>Account Balance Response</h3></tr>
<tr><td>getIvrId:</td> <td><%=AccountBalanceResponse.getIvrId()%></td></tr>
<tr><td>getBalance :</td> <td><%=AccountBalanceResponse.getBalance()%></td></tr>
<tr><td>getDueDateTime :</td> <td><%=AccountBalanceResponse.getDueDateTime()%></td></tr>
<tr><td>getErrorCode :</td> <td><%=AccountBalanceResponse.getErrorCode()%></td></tr>
</table>

<% } catch (Exception e) {
        Logger.info("Account Balance Test Page Exception ", e.getMessage(), false);
    }
            
             try {

        String ivrId = "AV87";
        String subscriberNumber = "3000341077";
        String dateTime = Util.getCurrentDateAnyFormat("dd/MM/yyyy hh:mm:ss");
        AccountBalanceResponse AccountBalanceResponse = new AccountBalance().requestAccountBalance(ivrId, subscriberNumber, dateTime, dbCallDetailId);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getIvrId(), false);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getBalance(), false);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getDueDateTime(), false);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getErrorCode(), false);

%>
<table>
    <tr><h3>Account Balance Response</h3></tr>
<tr><td>getIvrId:</td> <td><%=AccountBalanceResponse.getIvrId()%></td></tr>
<tr><td>getBalance :</td> <td><%=AccountBalanceResponse.getBalance()%></td></tr>
<tr><td>getDueDateTime :</td> <td><%=AccountBalanceResponse.getDueDateTime()%></td></tr>
<tr><td>getErrorCode :</td> <td><%=AccountBalanceResponse.getErrorCode()%></td></tr>
</table>

<% } catch (Exception e) {
        Logger.info("Account Balance Test Page Exception ", e.getMessage(), false);
    }
            
             try {

        String ivrId = "AV87";
        String subscriberNumber = "3000341077";
        String dateTime = Util.getCurrentDateAnyFormat("dd/MM/yyyy hh:mm:ss");
        AccountBalanceResponse AccountBalanceResponse = new AccountBalance().requestAccountBalance(ivrId, subscriberNumber, dateTime, dbCallDetailId);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getIvrId(), false);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getBalance(), false);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getDueDateTime(), false);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getErrorCode(), false);

%>
<table>
    <tr><h3>Account Balance Response</h3></tr>
<tr><td>getIvrId:</td> <td><%=AccountBalanceResponse.getIvrId()%></td></tr>
<tr><td>getBalance :</td> <td><%=AccountBalanceResponse.getBalance()%></td></tr>
<tr><td>getDueDateTime :</td> <td><%=AccountBalanceResponse.getDueDateTime()%></td></tr>
<tr><td>getErrorCode :</td> <td><%=AccountBalanceResponse.getErrorCode()%></td></tr>
</table>

<% } catch (Exception e) {
        Logger.info("Account Balance Test Page Exception ", e.getMessage(), false);
    }
            
             try {

        String ivrId = "AV87";
        String subscriberNumber = "3000341077";
        String dateTime = Util.getCurrentDateAnyFormat("dd/MM/yyyy hh:mm:ss");
        AccountBalanceResponse AccountBalanceResponse = new AccountBalance().requestAccountBalance(ivrId, subscriberNumber, dateTime, dbCallDetailId);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getIvrId(), false);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getBalance(), false);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getDueDateTime(), false);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getErrorCode(), false);

%>
<table>
    <tr><h3>Account Balance Response</h3></tr>
<tr><td>getIvrId:</td> <td><%=AccountBalanceResponse.getIvrId()%></td></tr>
<tr><td>getBalance :</td> <td><%=AccountBalanceResponse.getBalance()%></td></tr>
<tr><td>getDueDateTime :</td> <td><%=AccountBalanceResponse.getDueDateTime()%></td></tr>
<tr><td>getErrorCode :</td> <td><%=AccountBalanceResponse.getErrorCode()%></td></tr>
</table>

<% } catch (Exception e) {
        Logger.info("Account Balance Test Page Exception ", e.getMessage(), false);
    }

            
             try {

        String ivrId = "AV87";
        String subscriberNumber = "3000341077";
        String dateTime = Util.getCurrentDateAnyFormat("dd/MM/yyyy hh:mm:ss");
        AccountBalanceResponse AccountBalanceResponse = new AccountBalance().requestAccountBalance(ivrId, subscriberNumber, dateTime, dbCallDetailId);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getIvrId(), false);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getBalance(), false);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getDueDateTime(), false);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getErrorCode(), false);

%>
<table>
    <tr><h3>Account Balance Response</h3></tr>
<tr><td>getIvrId:</td> <td><%=AccountBalanceResponse.getIvrId()%></td></tr>
<tr><td>getBalance :</td> <td><%=AccountBalanceResponse.getBalance()%></td></tr>
<tr><td>getDueDateTime :</td> <td><%=AccountBalanceResponse.getDueDateTime()%></td></tr>
<tr><td>getErrorCode :</td> <td><%=AccountBalanceResponse.getErrorCode()%></td></tr>
</table>

<% } catch (Exception e) {
        Logger.info("Account Balance Test Page Exception ", e.getMessage(), false);
    }

            
             try {

        String ivrId = "AV87";
        String subscriberNumber = "3000341077";
        String dateTime = Util.getCurrentDateAnyFormat("dd/MM/yyyy hh:mm:ss");
        AccountBalanceResponse AccountBalanceResponse = new AccountBalance().requestAccountBalance(ivrId, subscriberNumber, dateTime, dbCallDetailId);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getIvrId(), false);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getBalance(), false);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getDueDateTime(), false);
        Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getErrorCode(), false);

%>
<table>
    <tr><h3>Account Balance Response</h3></tr>
<tr><td>getIvrId:</td> <td><%=AccountBalanceResponse.getIvrId()%></td></tr>
<tr><td>getBalance :</td> <td><%=AccountBalanceResponse.getBalance()%></td></tr>
<tr><td>getDueDateTime :</td> <td><%=AccountBalanceResponse.getDueDateTime()%></td></tr>
<tr><td>getErrorCode :</td> <td><%=AccountBalanceResponse.getErrorCode()%></td></tr>
</table>

<% } catch (Exception e) {
        Logger.info("Account Balance Test Page Exception ", e.getMessage(), false);
    }

try {

        String getAccountDetail = new DBAccess().getAccountDetail("3000341077");
        System.out.println("xml=" + getAccountDetail);
        
        Logger.info("Get Account Detail ", getAccountDetail, false);

    } catch (Exception e) {
    }

%>
</body>
</html>
