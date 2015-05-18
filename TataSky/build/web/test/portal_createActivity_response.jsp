<%-- 
    Document   : portal_createActivity_response
    Created on : Dec 24, 2013, 7:31:49 AM
    Author     : dell
--%>

<%@page import="com.tsg.portal.CreateActivityResponse"%>
<%@page import="com.tsg.portal.CreateActivity"%>
<%@page import="com.tsg.log.Logger"%>
<%@page import="com.tsg.util.Util"%>
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
        String atomIvrId = request.getParameter("atom_ivr_id");
        String tataskyTransId = request.getParameter("tata_txn_id");
        String date = request.getParameter("date");
        String srNumber = request.getParameter("sr_num");
        String atomTransId = request.getParameter("atom_trans_id");
        String TransStatus = request.getParameter("trans_status");
        String bankReferenceNo = request.getParameter("bank_ref_no");
        String bankRRRNo = request.getParameter("bank_rrn_no");
        String paymentTransId = request.getParameter("pymnt_trans_id");
        String transAmount = request.getParameter("trans_amnt");
        String productCode = request.getParameter("prdct_cod");
        String bonusAmount = request.getParameter("bonus_amt");
        String hardwareAmount = request.getParameter("hrdwr_amt");
        String packageAmount = request.getParameter("pckg_amt");
        String totalAmount = request.getParameter("tot_amt");
        String merchantId = request.getParameter("mrchnt_id");
        String userId = request.getParameter("usr_id");
        String dbCallDetailId = request.getParameter("db_call_detail");
               
        Logger.info("PortalAccountRechargeResponse " , Util.getCurrentDateAnyFormat("dd/MM/YYYY hh:mm:ss.SSS"), false);
        CreateActivityResponse createActivityResponse = new CreateActivity().requestCreateActivity(atomIvrId, tataskyTransId, date, srNumber, atomTransId,
                TransStatus, bankReferenceNo, bankRRRNo, paymentTransId, transAmount, productCode, bonusAmount,
                hardwareAmount, packageAmount, totalAmount, merchantId, userId, dbCallDetailId);
        
//        Portal por = new Portal();
//        out.println(por.createActivity(Atom_ivr_id,Tata_Txn_id,Daate,SR_Num,Atom_trans_id,Trans_status,Bank_ref_no,Bank_rrn_no,Paymnt_trans_id,Trans_amt,Prdct_cd,Bonus_amt,Hardwr_amt,Packg_amt,Tot_amt,Mrchnt_id,Usr_id));
       %>
       
<table>
<tr><h3>Create Activity Response</h3></tr>
<tr><td>Get Atom Ivr Id :</td> <td><%=createActivityResponse.getAtomIvrId()%></td></tr>
<tr><td>Get Sr Number :</td> <td><%=createActivityResponse.getSrNumber()%></td></tr>
<tr><td>Get Activity Id :</td> <td><%=createActivityResponse.getActivityId()%></td></tr>
<tr><td>Get Error Code :</td> <td><%=createActivityResponse.getErrorCode()%></td></tr>
</table>

<%
     Logger.info("PortalAccountRechargeResponse " , Util.getCurrentDateAnyFormat("dd/MM/YYYY hh:mm:ss.SSS"), false);
     }
     catch (Exception e) 
     {
        System.out.println("CreateActivity Test Page Exception " + e.getMessage());
     }
     %>
    </body>
</html>

