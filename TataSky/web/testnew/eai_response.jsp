<%-- 
    Document   : eai_response
    Created on : Nov 30, 2013, 5:36:14 PM
    Author     : dell
--%>

<%@page import="com.tsg.util.Util"%>
<%@page import="com.tsg.log.Logger"%>
<%@page import="com.tsg.eai.AccountBalanceResponse"%>
<%@page import="com.tsg.eai.AccountBalance"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <script>
            function eaiacntbal_resp()
            {
           <%
     try
        {
        String dbCallDetailId = request.getParameter("db_call_id");
        String ivrId = request.getParameter("ivr_id");
        String subscriberNumber = request.getParameter("sbscr_no");
//        String dateTime = Util.getCurrentDateAnyFormat("dd/MM/yyyy hh:mm:ss");
        String dateTime = request.getParameter("date");
        
        Logger.info("AccountBalanceResponse " , Util.getCurrentDateAnyFormat("dd/MM/YYYY hh:mm:ss.SSS"), false);
        AccountBalanceResponse AccountBalanceResponse = new AccountBalance().requestAccountBalance(ivrId, 
                subscriberNumber, dateTime, dbCallDetailId);
        
        Logger.info("AccountBalanceResponse " , Util.getCurrentDateAnyFormat("dd/MM/YYYY hh:mm:ss"), false);
        Logger.info("AccountBalanceResponse " , AccountBalanceResponse.getIvrId(), false);
        Logger.info("AccountBalanceResponse " , AccountBalanceResponse.getBalance(), false);
        Logger.info("AccountBalanceResponse " , AccountBalanceResponse.getDueDateTime(), false);
        Logger.info("AccountBalanceResponse " , AccountBalanceResponse.getErrorCode(), false);
        Logger.info("AccountBalanceResponse " , Util.getCurrentDateAnyFormat("dd/MM/YYYY hh:mm:ss.SSS"), false);
        
//        Eai ea = new Eai();
//        out.println(ea.accntBalance(db_call_detail_id,ivr_txn,sbscr_id,daatte));
       %>
       
//       <table>
//            <tr><h3>Account Balance Response</h3></tr>
//        <tr><td>Get Ivr Id :</td> <td><%=AccountBalanceResponse.getIvrId()%></td></tr>
//        <tr><td>Get Balance :</td> <td><%=AccountBalanceResponse.getBalance()%></td></tr>
//        <tr><td>Get Due Date Time :</td> <td><%=AccountBalanceResponse.getDueDateTime()%></td></tr>
//        <tr><td>Get Error Code :</td> <td><%=AccountBalanceResponse.getErrorCode()%></td></tr>
//    </table>
    
    <% 
  }
  catch (Exception e) 
    {
            Logger.info("Account Balance Test Page Exception " , e.getMessage(), false);
    }
    %>
            }
        </script>
    </body>
</html>




            
            
            
            
            
            
            
            
            
        