<%-- 
    Document   : direct_sales_post_details_response
    Created on : Nov 18, 2013, 7:47:00 AM
    Author     : dell
--%>
<%@page import="com.tsg.util.Util"%>
<%@page import="com.tsg.log.Logger"%>
<%@page import="com.tsg.atom.PostDetailsResponse"%>
<%@page import="com.tsg.atom.PostDetails"%>
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
        String LZ_AtomMerchantID = request.getParameter("atom_merchant_id");
        String LZ_Method_type = request.getParameter("method_type");
        String LZ_Service_id = request.getParameter("service_id");
        String LZ_GetAmount = request.getParameter("amount");
        String LZ_pricePoint = request.getParameter("price_point");
        String ivrId = request.getParameter("atom_unique_txn_id");
        String LZ_UserID = request.getParameter("user_id");
        String LZ_SRNumber = request.getParameter("sr_number");
        String BA_SUBSCRIBER_ID = request.getParameter("sbcr_id");
        String LZ_UsrANI = request.getParameter("user_ani");
        String LZ_IVRUUID = request.getParameter("ivr_uid");
        String LZ_Status = request.getParameter("status");
        
        String LZ_CallStage = request.getParameter("call_stage");
        String LZ_RequiredDigit = request.getParameter("req_digits");
        String LZ_EnteredDigit = request.getParameter("entrd_digits");
        String LZ_Attempts = request.getParameter("attempt");
        
        String LZ_NoOfBoxes = request.getParameter("no_of_boxes");
        String LZ_PackName = request.getParameter("pack_name");
        String LZ_HardwareAmount = request.getParameter("hardware_amnt");
        String LZ_ActivityFee = request.getParameter("activity_fee");
        String LZ_BonusAmount = request.getParameter("bonus_amnt");
        String LZ_PackageAmount = request.getParameter("package_amnt");
        String LZ_AccessoriesAmount = request.getParameter("accessories_amnt");
        String LZ_TotalAmount = request.getParameter("total_amnt");
        String LZ_TransactionType = request.getParameter("trnscn_type");
        String LZ_SRValidResponse = request.getParameter("sr_valid_response");
        String LZ_SRPostResponse = request.getParameter("sr_post_response");
        String LZ_SUBIDValidResponse = request.getParameter("sub_valid_response");
        String LZ_SUBIDPostResponse = request.getParameter("sub_post_response");
        String LZ_Product = request.getParameter("product");
        String dbCallDetailId = request.getParameter("db_call_detail_id");
        
        Logger.info("AtomPostDetails " , Util.getCurrentDateAnyFormat("dd/MM/YYYY hh:mm:ss.SSS"), false);
        PostDetailsResponse objDataService = new PostDetails().requestPostDetails(LZ_AtomMerchantID, LZ_Method_type,
                    LZ_Service_id, LZ_GetAmount, LZ_pricePoint, ivrId, LZ_UserID, LZ_SRNumber, BA_SUBSCRIBER_ID, LZ_UsrANI, 
                    LZ_IVRUUID,LZ_Status, LZ_CallStage, LZ_RequiredDigit, LZ_EnteredDigit, LZ_Attempts, LZ_NoOfBoxes, 
                    LZ_PackName, LZ_HardwareAmount,LZ_ActivityFee, LZ_BonusAmount, LZ_PackageAmount, LZ_AccessoriesAmount, 
                    LZ_TotalAmount, LZ_TransactionType,LZ_SRValidResponse, LZ_SRPostResponse, LZ_SUBIDValidResponse, 
                    LZ_SUBIDPostResponse, LZ_Product, dbCallDetailId);
        
//        DirectSales ds = new DirectSales();
//        out.println(ds.directPostDetails(atm_mrchnt_id,Method_Type,srvc_id,amnt,price_pnt,Atom_uni_txn_id,usr_id,sr_num,subcbr_id,user_ANI,ivr_uid,stats,Call_Stage,requrd_dgts,Entrd_dgts,Attempt,numbr_boxes,pck_nam,hrdwr_amnt,actvty_fee,Bonus_amt,packg_amt,accssrs_amt,ttl_amnt,tnsctn_typ,sr_valid_rspns,sr_pst_rspns,sub_valid_rspns,sub_post_rspns,pdct,db_cll_dtl_id));
        System.out.println("TxnID : " + objDataService.getTranscationId());
            System.out.println("OrderID : " + objDataService.getOrderId());
            System.out.println("Errorcode : " + objDataService.getErrorCode());
            System.out.println("ErrorMsg : " + objDataService.getErrorMessage());
    %>
    <table>
        <tr><h3>post Details Response</h3></tr>
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
