<%-- 
    Document   : eai_evd_recharge_response
    Created on : Nov 18, 2013, 11:47:28 AM
    Author     : dell
--%>

<%@page import="com.tsg.util.Util"%>
<%@page import="com.tsg.log.Logger"%>
<%@page import="com.tsg.eai.EVDRecharge"%>
<%@page import="com.tsg.eai.EVDRechargeResponse"%>
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
//        String BA_SUBSCRIBER_ID = request.getParameter("ba_sbscrbr_id");
//        String LZ_EVDPin = request.getParameter("evd_pin");
//        String LZ_EVDMobileNo = request.getParameter("evd_mob_num");
//        String LZ_EVDRechargevalue = request.getParameter("evd_rechrg_val");
////        String senddatetime = Util.getCurrentDateAnyFormat("dd/MM/yyyy hh:mm:ss");
//        String senddatetime = request.getParameter("date");
//        String dbCallDetailId = request.getParameter("db_call_detail_id");
        
        String BA_SUBSCRIBER_ID = "3000578900";
        String LZ_EVDPin = "2222";
        String LZ_EVDMobileNo = "1111111111";
        String LZ_EVDRechargevalue = "600";
        String senddatetime = "23/1/2014 16:37:23";
        String dbCallDetailId = request.getParameter("db_call_detail_id");
               
        Logger.info("EVDRechargeResponse " , Util.getCurrentDateAnyFormat("dd/MM/YYYY hh:mm:ss.SSS"), false);
        EVDRechargeResponse EVDRechargeResponse = new EVDRecharge().requestEVDRecharge(BA_SUBSCRIBER_ID,  
                LZ_EVDMobileNo, LZ_EVDPin, LZ_EVDRechargevalue, senddatetime, dbCallDetailId);
        
       %>
       
<table>
    <tr><h3>EVD Recharge Response</h3></tr>
<tr><td>Http Response :</td> <td><%=EVDRechargeResponse.getErrorCode()%></td></tr>

</table>

<%
    Logger.info("EVDRechargeResponse " , Util.getCurrentDateAnyFormat("dd/MM/YYYY hh:mm:ss.SSS"), false);
    } catch (Exception e) {
        Logger.info("EVD Recharge Test Page Exception " , e.getMessage(), false);
    }
%>
    </body>
</html>
