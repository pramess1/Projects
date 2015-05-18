<%-- 
    Document   : eai_heavy_ref_response
    Created on : Nov 18, 2013, 10:59:57 AM
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
//        String dateTime = Util.getCurrentDateAnyFormat("dd/MM/yyyy hh:mm:ss");
        String dateTime = request.getParameter("date");
        String dbCallDetailId = request.getParameter("db_call_detail_id");
        
        Logger.info("heavyRefreshResponse " , Util.getCurrentDateAnyFormat("dd/MM/YYYY hh:mm:ss.SSS"), false);
        SoftHeavyRefreshResponse heavyRefreshResponse = new SoftHeavyRefresh().requestSoftHeavyRefresh(ivrId, 
                subscriberNumber, requestType, dateTime, dbCallDetailId);
        
        Logger.info("heavyRefreshResponse " , Util.getCurrentDateAnyFormat("dd/MM/YYYY hh:mm:ss"), false);
        Logger.info("heavyRefreshResponse " , heavyRefreshResponse.getIvrId(), false);
        Logger.info("heavyRefreshResponse " , heavyRefreshResponse.getStatusOfSCMS(), false);
        Logger.info("heavyRefreshResponse " , heavyRefreshResponse.getSubscriberNumber(), false);
        Logger.info("heavyRefreshResponse " , heavyRefreshResponse.getErrorCode(), false);
        Logger.info("heavyRefreshResponse " , Util.getCurrentDateAnyFormat("dd/MM/YYYY hh:mm:ss.SSS"), false);
//        Eai ea = new Eai();
//        out.println(ea.heavyRefresh(Ivr_id,Sbscrbr_num,Rqust_typ,daatte));
       %>
       
<table>
    <tr><h3>Heavy Refresh Response</h3></tr>
<tr><td>Get Ivr Id :</td> <td><%=heavyRefreshResponse.getIvrId()%></td></tr>
<tr><td>Get Status Of SCMS :</td> <td><%=heavyRefreshResponse.getStatusOfSCMS()%></td></tr>
<tr><td>Get Subscriber Number :</td> <td><%=heavyRefreshResponse.getSubscriberNumber()%></td></tr>
<tr><td>Get Error Code :</td> <td><%=heavyRefreshResponse.getErrorCode()%></td></tr>
</table>

<% } 
      catch (Exception e) 
      {
        Logger.info("Heavy Refresh Test Page Exception " , e.getMessage(), false);
        }
%>
    </body>
</html>
