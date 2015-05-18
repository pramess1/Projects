<%-- 
    Document   : directSales_getDetails_response
    Created on : Dec 24, 2013, 7:45:01 AM
    Author     : dell
--%>

<%@page import="com.tsg.util.Util"%>
<%@page import="com.tsg.log.Logger"%>
<%@page import="com.tsg.atom.GetDetailsResponse"%>
<%@page import="com.tsg.atom.GetDetails"%>
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
        String tataskyTransId = request.getParameter("tata_sky_transaction_id");
        String atomMerchantId = request.getParameter("atom_merchant_id");
        String methodType = request.getParameter("method_type");
        String serviceId = request.getParameter("service_id");
        String amount = request.getParameter("amnt");
        String tataSkySubscriberId = request.getParameter("tata_sbcr_id");
        String customerCallerId = request.getParameter("cust_call_id");
        String genesysUniqueId = request.getParameter("genesys_unique_id");
        String userId = request.getParameter("user_id");
        String srNumber = request.getParameter("sr_number");
        String product = request.getParameter("prdct");
        String dbCallDetailId = request.getParameter("db_call_detail_id");
        Logger.info("AtomPostDetails " , Util.getCurrentDateAnyFormat("dd/MM/YYYY hh:mm:ss.SSS"), false);
        GetDetailsResponse objDataService = new GetDetails().requestGetDetails(atomMerchantId, methodType,
                        serviceId, amount, tataSkySubscriberId, customerCallerId, genesysUniqueId, userId, srNumber, product, dbCallDetailId);
                      
//        DirectSales ds = new DirectSales();
//        out.println(ds.directGetDetails(Ivr_ID,tatasky_txn_id,atm_mrchnt_id,Method_Type,srvc_id,amnt,tata_sbscr_id,cstmr_clr_id,gene_uni_id,User_id,SR_num,Product,DB_call_dtl_id));
        System.out.println("TxnID : " + objDataService.getTranscationId());
                System.out.println("OrderID : " + objDataService.getOrderId());
                System.out.println("Errorcode : " + objDataService.getErrorCode());
                System.out.println("ErrorMsg : " + objDataService.getErrorMessage());
                ivrId = objDataService.getTranscationId();
        %>
        <table>
            <tr><h3>Get Details Response</h3></tr>
        <tr><td>Get Transaction Id :</td> <td><%=objDataService.getTranscationId()%></td></tr>
        <tr><td>Get Order Id :</td> <td><%=objDataService.getOrderId()%></td></tr>
        <tr><td>Get Error Code :</td> <td><%=objDataService.getErrorCode()%></td></tr>
        <tr><td>Get Error Message :</td> <td><%=objDataService.getErrorMessage()%></td></tr>
    </table>

    <%
        Logger.info("AtomPostDetails " , Util.getCurrentDateAnyFormat("dd/MM/YYYY hh:mm:ss.SSS"), false);
        }
        catch (Exception e) 
        {
            System.out.println("Get Details Test Page Exception " + e.getMessage());
        }

        
    %>
    </body>
</html>
