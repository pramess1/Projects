<%-- 
    Document   : eai_servc_rqust_response
    Created on : Nov 18, 2013, 11:05:04 AM
    Author     : dell
--%>

<%@page import="com.tsg.util.Util"%>
<%@page import="com.tsg.log.Logger"%>
<%@page import="com.tsg.eai.ServiceRequestCreationResponse"%>
<%@page import="com.tsg.eai.ServiceRequestCreation"%>
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
        String serviceRequestType = request.getParameter("srvc_rqust_typ");
        String serviceRequestArea = request.getParameter("srvc_rqust_area");
        String serviceRequestSubArea = request.getParameter("srvc_rqust_sub_area");
        String description = request.getParameter("dscrptn");
        String mobileNumber = request.getParameter("mob_num");
        String requestType = request.getParameter("rqust_typ");
        String dateTime = request.getParameter("date");
        String dbCallDetailId = request.getParameter("db_call_detail_id");
        
        Logger.info("serviceRequestCreationResponse " , Util.getCurrentDateAnyFormat("dd/MM/YYYY hh:mm:ss.SSS"), false);
        ServiceRequestCreationResponse serviceRequestCreationResponse = new ServiceRequestCreation().
                requestServiceRequestCreation(ivrId, subscriberNumber, serviceRequestType, serviceRequestArea,
                serviceRequestSubArea, description, mobileNumber, requestType, dateTime, dbCallDetailId);
        
        Logger.info("serviceRequestCreationResponse " , serviceRequestCreationResponse.getIvrId(), false);
        Logger.info("serviceRequestCreationResponse " , serviceRequestCreationResponse.getStatusOfSCMS(), false);
        Logger.info("serviceRequestCreationResponse " , serviceRequestCreationResponse.getSubscriberNumber(), false);
        Logger.info("serviceRequestCreationResponse " , serviceRequestCreationResponse.getErrorCode(), false);
        Logger.info("serviceRequestCreationResponse " , Util.getCurrentDateAnyFormat("dd/MM/YYYY hh:mm:ss.SSS"), false);
        
       %>
       
<table>
    <tr><h3>Service Request Creation Response</h3></tr>
<tr><td>Get Ivr Id :</td> <td><%=serviceRequestCreationResponse.getIvrId()%></td></tr>
<tr><td>Get Status Of SCMS :</td> <td><%=serviceRequestCreationResponse.getStatusOfSCMS()%></td></tr>
<tr><td>Get Subscriber Number :</td> <td><%=serviceRequestCreationResponse.getSubscriberNumber()%></td></tr>
<tr><td>Get Error Code :</td> <td><%=serviceRequestCreationResponse.getErrorCode()%></td></tr>
</table>

<% 
   } 
    catch (Exception e) 
    {
        Logger.info("Service Request Creation Test Page Exception " , e.getMessage(), false);
    }
%>
    </body>
</html>
