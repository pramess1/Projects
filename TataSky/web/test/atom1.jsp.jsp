<%@page import="com.tsg.util.Util"%>
<%@page import="com.tsg.eai.AccountBalance"%>
<%@page import="com.tsg.log.Logger"%>
<%@page import="com.tsg.eai.AccountBalanceResponse"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.tsg.atom.*"%>
<%@page import="com.tsg.portal.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String ivrId = "";
            String tataskyTransId = "";
            String dbCallDetailId = "";
            String amount = "";
            String rrn = "";
            try {
                String atomMerchantId = "1300111";
                String methodType = "getDetails";
                String serviceId = "2000001";
                amount = "100.00";
                String tataSkySubscriberId = "3000341077";
                String customerCallerId = "9926845714";
                String genesysUniqueId = "1234567977";
                String userId = "";
                String srNumber = "";
                String product = "Recharge";


        %>
        <table>
            <tr><h3>Get Details Request</h3></tr>
        <tr><td>Atom MerchantId</td> <td><%=atomMerchantId%></td></tr>
        <tr><td>Method Type :</td> <td><%=methodType%></td></tr>
        <tr><td>Service Id :</td> <td><%=serviceId%></td></tr>
        <tr><td>Amount :</td> <td><%=amount%></td></tr>
        <tr><td>TataSky Subscriber Id :</td> <td><%=tataSkySubscriberId%></td></tr>
        <tr><td>Customer Caller Id :</td> <td><%=customerCallerId%></td></tr>
        <tr><td>Genesys Unique Id :</td> <td><%=genesysUniqueId%></td></tr>
    </table>

    <%

        GetDetailsResponse objDataService = new GetDetails().requestGetDetails(atomMerchantId, methodType,
                serviceId, amount, tataSkySubscriberId, customerCallerId, genesysUniqueId, userId, srNumber, product, dbCallDetailId);
        System.out.println("TxnID : " + objDataService.getTranscationId());
        System.out.println("OrderID : " + objDataService.getOrderId());
        System.out.println("Errorcode : " + objDataService.getErrorCode());
        System.out.println("ErrorMsg : " + objDataService.getErrorMessage());
        ivrId = objDataService.getTranscationId();
    %>
    <table>
        <tr><h3>Get Details Response</h3></tr>
    <tr><td>getTranscationId</td> <td><%=objDataService.getTranscationId()%></td></tr>
    <tr><td>getOrderId :</td> <td><%=objDataService.getOrderId()%></td></tr>
    <tr><td>getErrorCode :</td> <td><%=objDataService.getErrorCode()%></td></tr>
    <tr><td>getErrorMessage :</td> <td><%=objDataService.getErrorMessage()%></td></tr>
</table>

<%} catch (Exception e) {
        System.out.println("Get Details Test Page Exception " + e.getMessage());
    }%>
    </body>
    
</html>
