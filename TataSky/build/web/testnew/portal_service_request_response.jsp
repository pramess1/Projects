<%-- 
    Document   : portal_service_request_response
    Created on : Nov 18, 2013, 12:59:29 PM
    Author     : dell
--%>

<%@page import="com.tsg.util.Util"%>
<%@page import="com.tsg.log.Logger"%>
<%@page import="com.tsg.portal.ServiceRequestQuery"%>
<%@page import="com.tsg.portal.ServiceRequestQueryResponse"%>
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
        String source = request.getParameter("src");
        String atomIvrId = request.getParameter("atom_ivr_id");
        String srNumber = request.getParameter("sr_num");
//        String date = Util.getCurrentDateAnyFormat("dd-MM-yyyy hh:mm");
        String date = request.getParameter("date");
        String dbCallDetailId = request.getParameter("db_call_detail");
        
        Logger.info("PortalAccountRechargeResponse " , Util.getCurrentDateAnyFormat("dd/MM/YYYY hh:mm:ss.SSS"), false);
        ServiceRequestQueryResponse serviceRequestQueryResponse =
                new ServiceRequestQuery().requestServiceQuery(source, atomIvrId, srNumber, date, dbCallDetailId);
        
//        Portal por = new Portal();
//        out.println(por.serviceRequest(Source,Atom_Ivr_id,Sr_Num,daatte));
       %>
       
       <table>
    <tr><h3>Service Request Query Response</h3></tr>
<tr><td>Get Atom Ivr Id :</td> <td><%=serviceRequestQueryResponse.getAtomIvrId()%></td></tr>
<tr><td>Get Sr Number :</td> <td><%=serviceRequestQueryResponse.getSrNumber()%></td></tr>
<tr><td>Get Tatasky Trans Id :</td> <td><%=serviceRequestQueryResponse.getTataskyTransId()%></td></tr>
<tr><td>Get Sr Type :</td> <td><%=serviceRequestQueryResponse.getSrType()%></td></tr>
<tr><td>Get Sr Area :</td> <td><%=serviceRequestQueryResponse.getSrArea()%></td></tr>
<tr><td>Get Sr Sub Area :</td> <td><%=serviceRequestQueryResponse.getSrSubArea()%></td></tr>
<tr><td>Get Price Point :</td> <td><%=serviceRequestQueryResponse.getPricePoint()%></td></tr>
<tr><td>Get Subscriber Id :</td> <td><%=serviceRequestQueryResponse.getSubscriberId()%></td></tr>
<tr><td>Get Date :</td> <td><%=serviceRequestQueryResponse.getDate()%></td></tr>
<tr><td>Get Personal City :</td> <td><%=serviceRequestQueryResponse.getPersonalCity()%></td></tr>
<tr><td>Get Error Code :</td> <td><%=serviceRequestQueryResponse.getErrorCode()%></td></tr>
</table>

<%
    Logger.info("PortalAccountRechargeResponse " , Util.getCurrentDateAnyFormat("dd/MM/YYYY hh:mm:ss.SSS"), false);
    } 
    catch (Exception e) 
    {
        System.out.println("ServiceRequestQuery Test Page Exception " + e.getMessage());
    }
%>
    </body>
</html>
