<%-- 
    Document   : portal_subscrbr_id_response
    Created on : Nov 18, 2013, 11:57:42 AM
    Author     : dell
--%>

<%@page import="com.tsg.util.Util"%>
<%@page import="com.tsg.log.Logger"%>
<%@page import="com.tsg.portal.SubscriberValidation"%>
<%@page import="com.tsg.portal.SubscriberValidationResponse" %>
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
        String atomIvrId = request.getParameter("atom_ivr_id");
        String dbCallDetailId = request.getParameter("db_call_detail");
        
        Logger.info("PortalAccountRechargeResponse " , Util.getCurrentDateAnyFormat("dd/MM/YYYY hh:mm:ss.SSS"), false);
        SubscriberValidationResponse subscriberValidationResponse =
                    new SubscriberValidation().requestSubscriberValidation(atomIvrId, dbCallDetailId);
        
//        Portal por = new Portal();
//        out.println(por.subscriberID(Atom_Ivr_id));
     %>
       
       <table>
        <tr><h3>Subscriber Validation Response</h3></tr>
    <tr><td>Get Subscriber Id :</td> <td><%=subscriberValidationResponse.getSubscriberId()%></td></tr>
    <tr><td>Get Account Type :</td> <td><%=subscriberValidationResponse.getAccountType()%></td></tr>
    <tr><td>Get Account Sub Type :</td> <td><%=subscriberValidationResponse.getAccountSubType()%></td></tr>
    <tr><td>Get Account Status :</td> <td><%=subscriberValidationResponse.getAccountStatus()%></td></tr>
    <tr><td>Get Current Balance :</td> <td><%=subscriberValidationResponse.getCurrentBalance()%></td></tr>
    <tr><td>Get Preferred Language :</td> <td><%=subscriberValidationResponse.getPreferredLanguage()%></td></tr>
    <tr><td>Get Tatasky Trans Id :</td> <td><%=subscriberValidationResponse.getTataskyTransId()%></td></tr>
    <tr><td>Get Error Code :</td> <td><%=subscriberValidationResponse.getErrorCode()%></td></tr>
    <tr><td>Get Error Message :</td> <td><%=subscriberValidationResponse.getErrorMessage()%></td></tr>
</table>

<%
    Logger.info("PortalAccountRechargeResponse " , Util.getCurrentDateAnyFormat("dd/MM/YYYY hh:mm:ss.SSS"), false);
    }
    catch (Exception e) 
    {
        System.out.println("SubscriberValidation Test Page Exception " + e.getMessage());
    }
%>
    </body>
</html>
