<%-- 
    Document   : eai
    Created on : Oct 30, 2013, 9:20:41 AM
    Author     : Rajesh
--%>

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
                String subscriberNumber = "3000590475";
                String dateTime = Util.getCurrentDateAnyFormat("dd/MM/yyyy hh:mm:ss");
                

                AccountBalanceResponse AccountBalanceResponse = new AccountBalance().requestAccountBalance(ivrId, subscriberNumber, dateTime, dbCallDetailId);
                Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getIvrId(), false);
                Logger.info("AccountBalanceResponse " , AccountBalanceResponse.getBalance(), false);
                Logger.info("AccountBalanceResponse " , AccountBalanceResponse.getDueDateTime(), false);
                Logger.info("AccountBalanceResponse " , AccountBalanceResponse.getErrorCode(), false);
                
        %>
        <table>
            <tr><h3>Account Balance Response</h3></tr>
        <tr><td>getIvrId:</td> <td><%=AccountBalanceResponse.getIvrId()%></td></tr>
        <tr><td>getBalance :</td> <td><%=AccountBalanceResponse.getBalance()%></td></tr>
        <tr><td>getDueDateTime :</td> <td><%=AccountBalanceResponse.getDueDateTime()%></td></tr>
        <tr><td>getErrorCode :</td> <td><%=AccountBalanceResponse.getErrorCode()%></td></tr>
    </table>

    <% } catch (Exception e) {
        e.printStackTrace();
            Logger.info("Account Balance Test Page Exception " , e.getMessage(), false);
        }
        //Soft Refresh
        try {

            String ivrId = "AV87";
            String subscriberNumber = "3000738892";
            String requestType = "SoftRefresh";
            String dateTime = Util.getCurrentDateAnyFormat("dd/MM/yyyy hh:mm:ss");

            SoftHeavyRefreshResponse softRefreshResponse = new SoftHeavyRefresh().requestSoftHeavyRefresh(ivrId, subscriberNumber, requestType, dateTime, dbCallDetailId);
            Logger.info("SoftHeavyRefreshResponse " , softRefreshResponse.getIvrId(), false);
            Logger.info("SoftHeavyRefreshResponse " , softRefreshResponse.getStatusOfSCMS(), false);
            Logger.info("SoftHeavyRefreshResponse " , softRefreshResponse.getSubscriberNumber(), false);
            Logger.info("SoftHeavyRefreshResponse " , softRefreshResponse.getErrorCode(), false);
            Logger.info("ww", "ww", false);
    %>
    <table>
        <tr><h3>Soft Refresh Response</h3></tr>
    <tr><td>getIvrId:</td> <td><%=softRefreshResponse.getIvrId()%></td></tr>
    <tr><td>getStatusOfSCMS :</td> <td><%=softRefreshResponse.getStatusOfSCMS()%></td></tr>
    <tr><td>getSubscriberNumber :</td> <td><%=softRefreshResponse.getSubscriberNumber()%></td></tr>
    <tr><td>getErrorCode :</td> <td><%=softRefreshResponse.getErrorCode()%></td></tr>
</table>
<% } catch (Exception e) {
        Logger.info("Soft Refresh Test Page Exception " , e.getMessage(), false);
    }

    //Heavy Refresh

    try {

        String ivrId = "AV87";
        String subscriberNumber = "3000738892";
        String requestType = "HeavyRefresh";
        String dateTime = Util.getCurrentDateAnyFormat("dd/MM/yyyy hh:mm:ss");

        SoftHeavyRefreshResponse heavyRefreshResponse = new SoftHeavyRefresh().requestSoftHeavyRefresh(ivrId, subscriberNumber, requestType, dateTime, dbCallDetailId);
        Logger.info("heavyRefreshResponse " , heavyRefreshResponse.getIvrId(), false);
        Logger.info("heavyRefreshResponse " , heavyRefreshResponse.getStatusOfSCMS(), false);
        Logger.info("heavyRefreshResponse " , heavyRefreshResponse.getSubscriberNumber(), false);
        Logger.info("heavyRefreshResponse " , heavyRefreshResponse.getErrorCode(), false);
%>
<table>
    <tr><h3>Heavy Refresh Response</h3></tr>
<tr><td>getIvrId:</td> <td><%=heavyRefreshResponse.getIvrId()%></td></tr>
<tr><td>getStatusOfSCMS :</td> <td><%=heavyRefreshResponse.getStatusOfSCMS()%></td></tr>
<tr><td>getSubscriberNumber :</td> <td><%=heavyRefreshResponse.getSubscriberNumber()%></td></tr>
<tr><td>getErrorCode :</td> <td><%=heavyRefreshResponse.getErrorCode()%></td></tr>
</table>
<% } catch (Exception e) {
        Logger.info("Heavy Refresh Test Page Exception " , e.getMessage(), false);
    }

    // Service Request Creation

    try {
        String ivrId = "AV87";
        String subscriberNumber = "3000322697";
        String serviceRequestType = "";
        String serviceRequestArea = "";
        String serviceRequestSubArea = "";
        String description = "";
        String mobileNumber = "1337000643"; 
        String requestType = "SRCreation";
        String dateTime = Util.getCurrentDateAnyFormat("dd/MM/yyyy hh:mm:ss");

        ServiceRequestCreationResponse serviceRequestCreationResponse = new ServiceRequestCreation().
                requestServiceRequestCreation(ivrId, subscriberNumber, serviceRequestType, serviceRequestArea,
                serviceRequestSubArea, description, mobileNumber, requestType, dateTime, dbCallDetailId);
        Logger.info("serviceRequestCreationResponse " , serviceRequestCreationResponse.getIvrId(), false);
        Logger.info("serviceRequestCreationResponse " , serviceRequestCreationResponse.getStatusOfSCMS(), false);
        Logger.info("serviceRequestCreationResponse " , serviceRequestCreationResponse.getSubscriberNumber(), false);
        Logger.info("serviceRequestCreationResponse " , serviceRequestCreationResponse.getErrorCode(), false);
%>
<table>
    <tr><h3>Service Request Creation Response</h3></tr>
<tr><td>getIvrId:</td> <td><%=serviceRequestCreationResponse.getIvrId()%></td></tr>
<tr><td>getStatusOfSCMS :</td> <td><%=serviceRequestCreationResponse.getStatusOfSCMS()%></td></tr>
<tr><td>getSubscriberNumber :</td> <td><%=serviceRequestCreationResponse.getSubscriberNumber()%></td></tr>
<tr><td>getErrorCode :</td> <td><%=serviceRequestCreationResponse.getErrorCode()%></td></tr>
</table>
<% } catch (Exception e) {
        Logger.info("Service Request Creation Test Page Exception " , e.getMessage(), false);
    }
    // Voucher Top-up
    try {
        String ivrId = "AV87";
        String subscriberNumber = "3000341077";
        String voucherPin = "3203341890939196";//7170213611770315
        String date = Util.getCurrentDateAnyFormat("dd/MM/yyyy hh:mm:ss");

        VoucherTopUpResponse voucherTopUpResponse = new VoucherTopUp().requestVoucherTopUp(ivrId, subscriberNumber, voucherPin, date, dbCallDetailId);

        Logger.info("voucherTopUpResponse " , voucherTopUpResponse.getIvrId(), false);
        Logger.info("voucherTopUpResponse " , voucherTopUpResponse.getStatus(), false);
        Logger.info("voucherTopUpResponse " , voucherTopUpResponse.getRechargeValue(), false);
        Logger.info("voucherTopUpResponse " , voucherTopUpResponse.getNewBalance(), false);
        Logger.info("voucherTopUpResponse " , voucherTopUpResponse.getErrorCode(), false);
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
        Logger.info("Voucher Top-up Test Page Exception " , e.getMessage(), false);
    }
        
        try {

                String ivrId = "AV87";
                String subscriberNumber = "3000341077";
                String dateTime = Util.getCurrentDateAnyFormat("dd/MM/yyyy hh:mm:ss");
                

                AccountBalanceResponse AccountBalanceResponse = new AccountBalance().requestAccountBalance(ivrId, subscriberNumber, dateTime, dbCallDetailId);
                Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getIvrId(), false);
                Logger.info("AccountBalanceResponse " , AccountBalanceResponse.getBalance(), false);
                Logger.info("AccountBalanceResponse " , AccountBalanceResponse.getDueDateTime(), false);
                Logger.info("AccountBalanceResponse " , AccountBalanceResponse.getErrorCode(), false);
                
        %>
        <table>
            <tr><h3>Account Balance Response</h3></tr>
        <tr><td>getIvrId:</td> <td><%=AccountBalanceResponse.getIvrId()%></td></tr>
        <tr><td>getBalance :</td> <td><%=AccountBalanceResponse.getBalance()%></td></tr>
        <tr><td>getDueDateTime :</td> <td><%=AccountBalanceResponse.getDueDateTime()%></td></tr>
        <tr><td>getErrorCode :</td> <td><%=AccountBalanceResponse.getErrorCode()%></td></tr>
    </table>

    <% } catch (Exception e) {
            Logger.info("Account Balance Test Page Exception " , e.getMessage(), false);
        }
  

                try {

                String ivrId = "AV87";
                String subscriberNumber = "3000341077";
                String dateTime = Util.getCurrentDateAnyFormat("dd/MM/yyyy hh:mm:ss");
                

                AccountBalanceResponse AccountBalanceResponse = new AccountBalance().requestAccountBalance(ivrId, subscriberNumber, dateTime, dbCallDetailId);
                Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getIvrId(), false);
                Logger.info("AccountBalanceResponse " , AccountBalanceResponse.getBalance(), false);
                Logger.info("AccountBalanceResponse " , AccountBalanceResponse.getDueDateTime(), false);
                Logger.info("AccountBalanceResponse " , AccountBalanceResponse.getErrorCode(), false);
                
        %>
        <table>
            <tr><h3>Account Balance Response</h3></tr>
        <tr><td>getIvrId:</td> <td><%=AccountBalanceResponse.getIvrId()%></td></tr>
        <tr><td>getBalance :</td> <td><%=AccountBalanceResponse.getBalance()%></td></tr>
        <tr><td>getDueDateTime :</td> <td><%=AccountBalanceResponse.getDueDateTime()%></td></tr>
        <tr><td>getErrorCode :</td> <td><%=AccountBalanceResponse.getErrorCode()%></td></tr>
    </table>

    <% } catch (Exception e) {
            Logger.info("Account Balance Test Page Exception " , e.getMessage(), false);
        }




    //Subscriber ID Validation
    try {
        String ivrId = "AV87";
        String subscriberNumber = "3482890";
        String date = Util.getOneDaysAfter();
        String contactNumber = "9436555555";
        String language = "hindi";
        String requestType = "Validation";


        SubscriberValidationResponse SubscriberValidationResponse = new SubscriberValidation()
                .requestSubscriberValidation(ivrId, subscriberNumber, contactNumber, language, requestType, date, dbCallDetailId);

        Logger.info("SubscriberValidationResponse " , SubscriberValidationResponse.getIvrId(), false);
        Logger.info("SubscriberValidationResponse " , SubscriberValidationResponse.getStatus(), false);
        Logger.info("SubscriberValidationResponse " , SubscriberValidationResponse.getSubStatus(), false);
        Logger.info("SubscriberValidationResponse " , SubscriberValidationResponse.getSubscriberNumber(), false);
        Logger.info("SubscriberValidationResponse " , SubscriberValidationResponse.getErrorCode(), false);
%>
<table>
    <tr><h3>Subscriber Validation Response</h3></tr>
<tr><td>getIvrId:</td> <td><%=SubscriberValidationResponse.getIvrId()%></td></tr>
<tr><td>getStatus :</td> <td><%=SubscriberValidationResponse.getStatus()%></td></tr>
<tr><td>getSubStatus :</td> <td><%=SubscriberValidationResponse.getSubStatus()%></td></tr>
<tr><td>getSubscriberNumber :</td> <td><%=SubscriberValidationResponse.getSubscriberNumber()%></td></tr>
<tr><td>getErrorCode :</td> <td><%=SubscriberValidationResponse.getErrorCode()%></td></tr>
</table>
<% } catch (Exception e) {
        Logger.info("Subscriber ID Validation Test Page Exception " , e.getMessage(), false);
    }
try {

                String ivrId = "AV87";
                String subscriberNumber = "3000341077";
                String dateTime = Util.getCurrentDateAnyFormat("dd/MM/yyyy hh:mm:ss");
                

                AccountBalanceResponse AccountBalanceResponse = new AccountBalance().requestAccountBalance(ivrId, subscriberNumber, dateTime, dbCallDetailId);
                Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getIvrId(), false);
                Logger.info("AccountBalanceResponse " , AccountBalanceResponse.getBalance(), false);
                Logger.info("AccountBalanceResponse " , AccountBalanceResponse.getDueDateTime(), false);
                Logger.info("AccountBalanceResponse " , AccountBalanceResponse.getErrorCode(), false);
                
        %>
        <table>
            <tr><h3>Account Balance Response</h3></tr>
        <tr><td>getIvrId:</td> <td><%=AccountBalanceResponse.getIvrId()%></td></tr>
        <tr><td>getBalance :</td> <td><%=AccountBalanceResponse.getBalance()%></td></tr>
        <tr><td>getDueDateTime :</td> <td><%=AccountBalanceResponse.getDueDateTime()%></td></tr>
        <tr><td>getErrorCode :</td> <td><%=AccountBalanceResponse.getErrorCode()%></td></tr>
    </table>

    <% } catch (Exception e) {
            Logger.info("Account Balance Test Page Exception " , e.getMessage(), false);
        }


    //Create Relocation WO

    try {

        String ivrId = "AV87";
        String subscriberNumber = "3000322697";
        String date = Util.getOneDaysAfter();
        String type = "Relocation";
        String subType = "Relocate within same house";
        String priority = "3-Medium";

        CreateRelocationWorkOrderResponse CreateRelocationWorkOrderResponse = new CreateRelocationWorkOrder()
                .requestCreateRelocationWorkOrder(ivrId, subscriberNumber, type, subType, date, priority, dbCallDetailId);

        Logger.info("CreateRelocationWorkOrderResponse " , CreateRelocationWorkOrderResponse.getIvrId(), false);
        Logger.info("CreateRelocationWorkOrderResponse " , CreateRelocationWorkOrderResponse.getActivityId(), false);
        Logger.info("CreateRelocationWorkOrderResponse " , CreateRelocationWorkOrderResponse.getSubscriberNumber(), false);
        Logger.info("CreateRelocationWorkOrderResponse " , CreateRelocationWorkOrderResponse.getErrorCode(), false);
%>
<table>
    <tr><h3>Create Relocation Work Order Response</h3></tr>
<tr><td>getIvrId:</td> <td><%=CreateRelocationWorkOrderResponse.getIvrId()%></td></tr>
<tr><td>getActivityId :</td> <td><%=CreateRelocationWorkOrderResponse.getActivityId()%></td></tr>
<tr><td>getSubscriberNumber :</td> <td><%=CreateRelocationWorkOrderResponse.getSubscriberNumber()%></td></tr>
<tr><td>getErrorCode :</td> <td><%=CreateRelocationWorkOrderResponse.getErrorCode()%></td></tr>
</table>
<% } catch (Exception e) {
        Logger.info("Create Relocation WO Test Page Exception " , e.getMessage(), false);
    }
        
        try {

                String ivrId = "AV87";
                String subscriberNumber = "3000341077";
                String dateTime = Util.getCurrentDateAnyFormat("dd/MM/yyyy hh:mm:ss");
                

                AccountBalanceResponse AccountBalanceResponse = new AccountBalance().requestAccountBalance(ivrId, subscriberNumber, dateTime, dbCallDetailId);
                Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getIvrId(), false);
                Logger.info("AccountBalanceResponse " , AccountBalanceResponse.getBalance(), false);
                Logger.info("AccountBalanceResponse " , AccountBalanceResponse.getDueDateTime(), false);
                Logger.info("AccountBalanceResponse " , AccountBalanceResponse.getErrorCode(), false);
                
        %>
        <table>
            <tr><h3>Account Balance Response</h3></tr>
        <tr><td>getIvrId:</td> <td><%=AccountBalanceResponse.getIvrId()%></td></tr>
        <tr><td>getBalance :</td> <td><%=AccountBalanceResponse.getBalance()%></td></tr>
        <tr><td>getDueDateTime :</td> <td><%=AccountBalanceResponse.getDueDateTime()%></td></tr>
        <tr><td>getErrorCode :</td> <td><%=AccountBalanceResponse.getErrorCode()%></td></tr>
    </table>

    <% } catch (Exception e) {
            Logger.info("Account Balance Test Page Exception " , e.getMessage(), false);
        }


    //EVD Recharge

    try {

        String BA_SUBSCRIBER_ID = "3000322697";
        String LZ_EVDPin = "2525";
        String LZ_EVDMobileNo = "9436555555";
        String LZ_EVDRechargevalue = "200";
        String senddatetime = Util.getCurrentDateAnyFormat("dd/MM/yyyy hh:mm:ss");

        EVDRechargeResponse EVDRechargeResponse = new EVDRecharge().requestEVDRecharge(BA_SUBSCRIBER_ID, LZ_EVDPin, LZ_EVDMobileNo,
                LZ_EVDRechargevalue, senddatetime, dbCallDetailId);
        %>

<table>
    <tr><h3>EVD Recharge Response</h3></tr>
<tr><td>Http Response:</td> <td><%=EVDRechargeResponse.getErrorCode()%></td></tr>

</table>

<%} catch (Exception e) {
    
        Logger.info("EVD Recharge Test Page Exception " , e.getMessage(), false);
  }
        
        try {

                String ivrId = "AV87";
                String subscriberNumber = "3000341077";
                String dateTime = Util.getCurrentDateAnyFormat("dd/MM/yyyy hh:mm:ss");
                

                AccountBalanceResponse AccountBalanceResponse = new AccountBalance().requestAccountBalance(ivrId, subscriberNumber, dateTime, dbCallDetailId);
                Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getIvrId(), false);
                Logger.info("AccountBalanceResponse " , AccountBalanceResponse.getBalance(), false);
                Logger.info("AccountBalanceResponse " , AccountBalanceResponse.getDueDateTime(), false);
                Logger.info("AccountBalanceResponse " , AccountBalanceResponse.getErrorCode(), false);
                
        %>
        <table>
            <tr><h3>Account Balance Response</h3></tr>
        <tr><td>getIvrId:</td> <td><%=AccountBalanceResponse.getIvrId()%></td></tr>
        <tr><td>getBalance :</td> <td><%=AccountBalanceResponse.getBalance()%></td></tr>
        <tr><td>getDueDateTime :</td> <td><%=AccountBalanceResponse.getDueDateTime()%></td></tr>
        <tr><td>getErrorCode :</td> <td><%=AccountBalanceResponse.getErrorCode()%></td></tr>
    </table>

    <% } catch (Exception e) {
            Logger.info("Account Balance Test Page Exception " , e.getMessage(), false);
        }

        
        try {

                String ivrId = "AV87";
                String subscriberNumber = "3000341077";
                String dateTime = Util.getCurrentDateAnyFormat("dd/MM/yyyy hh:mm:ss");
                

                AccountBalanceResponse AccountBalanceResponse = new AccountBalance().requestAccountBalance(ivrId, subscriberNumber, dateTime, dbCallDetailId);
                Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getIvrId(), false);
                Logger.info("AccountBalanceResponse " , AccountBalanceResponse.getBalance(), false);
                Logger.info("AccountBalanceResponse " , AccountBalanceResponse.getDueDateTime(), false);
                Logger.info("AccountBalanceResponse " , AccountBalanceResponse.getErrorCode(), false);
                
        %>
        <table>
            <tr><h3>Account Balance Response</h3></tr>
        <tr><td>getIvrId:</td> <td><%=AccountBalanceResponse.getIvrId()%></td></tr>
        <tr><td>getBalance :</td> <td><%=AccountBalanceResponse.getBalance()%></td></tr>
        <tr><td>getDueDateTime :</td> <td><%=AccountBalanceResponse.getDueDateTime()%></td></tr>
        <tr><td>getErrorCode :</td> <td><%=AccountBalanceResponse.getErrorCode()%></td></tr>
    </table>

    <% } catch (Exception e) {
            Logger.info("Account Balance Test Page Exception " , e.getMessage(), false);
        }

%>
</body>
</html>
