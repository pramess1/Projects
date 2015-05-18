<%-- 
    Document   : eai_soft_ref_response
    Created on : Nov 18, 2013, 10:55:59 AM
    Author     : dell
--%>

<%@page import="com.tsg.util.Util"%>
<%@page import="com.tsg.log.Logger"%>
<%@page import="com.tsg.eai.SoftHeavyRefreshResponse"%>
<%@page import="com.tsg.eai.SoftHeavyRefresh"%>
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
        String requestType = request.getParameter("rqust_typ");
        String dateTime = request.getParameter("date");
        String dbCallDetailId = request.getParameter("db_call_detail_id");
        
        Logger.info("SoftHeavyRefreshResponse " , Util.getCurrentDateAnyFormat("dd/MM/YYYY hh:mm:ss.SSS"), false);
        SoftHeavyRefreshResponse softRefreshResponse = new SoftHeavyRefresh().requestSoftHeavyRefresh(ivrId, 
                subscriberNumber, requestType, dateTime, dbCallDetailId);
        Logger.info("SoftHeavyRefreshResponse " , softRefreshResponse.getIvrId(), false);
        Logger.info("SoftHeavyRefreshResponse " , softRefreshResponse.getStatusOfSCMS(), false);
        Logger.info("SoftHeavyRefreshResponse " , softRefreshResponse.getSubscriberNumber(), false);
        Logger.info("SoftHeavyRefreshResponse " , softRefreshResponse.getErrorCode(), false);
        Logger.info("ww", "ww", false);
        Logger.info("SoftHeavyRefreshResponse " , Util.getCurrentDateAnyFormat("dd/MM/YYYY hh:mm:ss.SSS"), false);
        
      %>
       
    <table>
        <tr><h3>Soft Refresh Response</h3></tr>
    <tr><td>Get Ivr Id :</td> <td><%=softRefreshResponse.getIvrId()%></td></tr>
    <tr><td>Get Status Of SCMS :</td> <td><%=softRefreshResponse.getStatusOfSCMS()%></td></tr>
    <tr><td>Get Subscriber Number :</td> <td><%=softRefreshResponse.getSubscriberNumber()%></td></tr>
    <tr><td>Get Error Code :</td> <td><%=softRefreshResponse.getErrorCode()%></td></tr>
    </table>
    
    <% 
     }
       catch (Exception e) 
       {
        Logger.info("Soft Refresh Test Page Exception " , e.getMessage(), false);
        }
     %>
    </body>
</html>
