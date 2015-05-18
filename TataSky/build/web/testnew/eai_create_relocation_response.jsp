<%-- 
    Document   : eai_create_relocation_response
    Created on : Nov 18, 2013, 11:35:46 AM
    Author     : dell
--%>

<%@page import="com.tsg.util.Util"%>
<%@page import="com.tsg.log.Logger"%>
<%@page import="com.tsg.eai.CreateRelocationWorkOrderResponse"%>
<%@page import="com.tsg.eai.CreateRelocationWorkOrder"%>
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
        String date = request.getParameter("date");
        String type = request.getParameter("typ");
        String subType = request.getParameter("sub_typ");
        String priority = request.getParameter("prty");
        String dbCallDetailId = request.getParameter("db_call_detail_id");
        
        Logger.info("CreateRelocationWorkOrderResponse " , Util.getCurrentDateAnyFormat("dd/MM/YYYY hh:mm:ss.SSS"), false);
        CreateRelocationWorkOrderResponse CreateRelocationWorkOrderResponse = new CreateRelocationWorkOrder()
                .requestCreateRelocationWorkOrder(ivrId, subscriberNumber, type, subType, date, priority, dbCallDetailId);
        
        Logger.info("CreateRelocationWorkOrderResponse " , CreateRelocationWorkOrderResponse.getIvrId(), false);
        Logger.info("CreateRelocationWorkOrderResponse " , CreateRelocationWorkOrderResponse.getActivityId(), false);
        Logger.info("CreateRelocationWorkOrderResponse " , CreateRelocationWorkOrderResponse.getSubscriberNumber(), false);
        Logger.info("CreateRelocationWorkOrderResponse " , CreateRelocationWorkOrderResponse.getErrorCode(), false);
        Logger.info("CreateRelocationWorkOrderResponse " , Util.getCurrentDateAnyFormat("dd/MM/YYYY hh:mm:ss.SSS"), false);
        %>
       
<table>
    <tr><h3>Create Relocation Work Order Response</h3></tr>
<tr><td>Get Ivr Id :</td> <td><%=CreateRelocationWorkOrderResponse.getIvrId()%></td></tr>
<tr><td>Get Activity Id :</td> <td><%=CreateRelocationWorkOrderResponse.getActivityId()%></td></tr>
<tr><td>Get Subscriber Number :</td> <td><%=CreateRelocationWorkOrderResponse.getSubscriberNumber()%></td></tr>
<tr><td>Get Error Code :</td> <td><%=CreateRelocationWorkOrderResponse.getErrorCode()%></td></tr>
</table>

<% } 
    catch (Exception e) 
    {
        Logger.info("Create Relocation WO Test Page Exception " , e.getMessage(), false);
    }
%>
    </body>
</html>
