<%-- 
    Document   : eai_evdRecharge_response
    Created on : Dec 23, 2013, 4:52:48 PM
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
        String BA_SUBSCRIBER_ID = request.getParameter("ba_sbscrbr_id");
        String LZ_EVDPin = request.getParameter("evd_pin");
        String LZ_EVDMobileNo = request.getParameter("evd_mob_num");
        String LZ_EVDRechargevalue = request.getParameter("evd_rechrg_val");
//        String senddatetime = Util.getCurrentDateAnyFormat("dd/MM/yyyy hh:mm:ss");
        String senddatetime = request.getParameter("date");
        String dbCallDetailId = request.getParameter("db_call_detail_id");
               
        Logger.info("EVDRechargeResponse " , Util.getCurrentDateAnyFormat("dd/MM/YYYY hh:mm:ss.SSS"), false);
        EVDRechargeResponse EVDRechargeResponse = new EVDRecharge().requestEVDRecharge(BA_SUBSCRIBER_ID, LZ_EVDPin, 
                LZ_EVDMobileNo,LZ_EVDRechargevalue, senddatetime, dbCallDetailId);
        
//        Eai ea = new Eai();
//        out.println(ea.evdRecharge(BA_Sbscrbr_ID,EVD_Pin,EVD_Mob_num,EVD_Recrg_val,Date_Time));
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
