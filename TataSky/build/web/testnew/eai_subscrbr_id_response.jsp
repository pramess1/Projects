<%-- 
    Document   : eai_subscrbr_id_response
    Created on : Nov 18, 2013, 11:24:48 AM
    Author     : dell
--%>

<%@page import="com.tsg.util.Util"%>
<%@page import="com.tsg.log.Logger"%>
<%@page import="com.tsg.eai.SubscriberValidationResponse"%>
<%@page import="com.tsg.eai.SubscriberValidation"%>
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
        String date = Util.getOneDaysAfter();
        String contactNumber = request.getParameter("cont_num");
        String language = request.getParameter("lang");
        String requestType = request.getParameter("rqust_typ");
        String dbCallDetailId = request.getParameter("db_call_detail_id");
        
        Logger.info("SubscriberValidationResponse " , Util.getCurrentDateAnyFormat("dd/MM/YYYY hh:mm:ss.SSS"), false);
        SubscriberValidationResponse SubscriberValidationResponse = new SubscriberValidation()
                .requestSubscriberValidation(ivrId, subscriberNumber, contactNumber, language, requestType, date, dbCallDetailId);
        
        Logger.info("SubscriberValidationResponse " , SubscriberValidationResponse.getIvrId(), false);
        Logger.info("SubscriberValidationResponse " , SubscriberValidationResponse.getStatus(), false);
        Logger.info("SubscriberValidationResponse " , SubscriberValidationResponse.getSubStatus(), false);
        Logger.info("SubscriberValidationResponse " , SubscriberValidationResponse.getSubscriberNumber(), false);
        Logger.info("SubscriberValidationResponse " , SubscriberValidationResponse.getErrorCode(), false);
        Logger.info("SubscriberValidationResponse " , Util.getCurrentDateAnyFormat("dd/MM/YYYY hh:mm:ss.SSS"), false);
       %>
       
<table>
    <tr><h3>Subscriber Validation Response</h3></tr>
<tr><td>Get Ivr Id :</td> <td><%=SubscriberValidationResponse.getIvrId()%></td></tr>
<tr><td>Get Status :</td> <td><%=SubscriberValidationResponse.getStatus()%></td></tr>
<tr><td>Get Sub Status :</td> <td><%=SubscriberValidationResponse.getSubStatus()%></td></tr>
<tr><td>Get Subscriber Number :</td> <td><%=SubscriberValidationResponse.getSubscriberNumber()%></td></tr>
<tr><td>Get Error Code :</td> <td><%=SubscriberValidationResponse.getErrorCode()%></td></tr>
</table>

<% } 
    catch (Exception e) 
    {
        Logger.info("Subscriber ID Validation Test Page Exception " , e.getMessage(), false);
    }
%>
    </body>
</html>
