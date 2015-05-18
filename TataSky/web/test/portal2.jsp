<%-- 
    Document   : portal2
    Created on : Jan 28, 2014, 4:17:25 PM
    Author     : Rajesh
--%>

<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.tsg.portal.*"%>
<%@page import="com.tsg.error.ErrorHandler"%>
<%@page import="com.tsg.util.Util"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <%

            String dbCallDetailId = "12";
            String tataskyTransId1 = "";
            try {
                // CreateActivity
                String atomIvrId = "0178E83IA49EDDKE6S3182LAES0002OM";
                String tataskyTransId = "ADS140203000006863";

                SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy hh:mm:ss a");
                Date date = new Date();
                String date1 = dateFormat.format(date);
                date = null;
                dateFormat = null;
                String srNumber = "1363019705";
                srNumber = srNumber.replaceFirst(srNumber.substring(0, 1), srNumber.substring(0, 1) + "-");
                String atomTransId = "314913";
                String TransStatus = "SUCCESS";
                String bankReferenceNo = "31";
                String bankRRRNo = "000093753987";
                String paymentTransId = "777002";
                String transAmount = "22335";
                String productCode = "BoxNo : 3HDP Pack Name : 1YrSpSptskidsPk+1MntMR";
                String bonusAmount = "11997";
                String hardwareAmount = "575";
                String packageAmount = "3795";
                String totalAmount = "22335.00";
                String merchantId = "1300101";
                String userId = "101017";

                CreateActivityResponse createActivityResponse = new CreateActivity().requestCreateActivity(atomIvrId, tataskyTransId, date1, srNumber, atomTransId,
                        TransStatus, bankReferenceNo, bankRRRNo, paymentTransId, transAmount, productCode, bonusAmount,
                        hardwareAmount, packageAmount, totalAmount, merchantId, userId, dbCallDetailId);
        %>
        <table>
            <tr><h3>Create Activity Response</h3></tr>
        <tr><td>getAtomIvrId</td> <td><%=createActivityResponse.getAtomIvrId()%></td></tr>
        <tr><td>getSrNumber :</td> <td><%=createActivityResponse.getSrNumber()%></td></tr>
        <tr><td>getActivityId :</td> <td><%=createActivityResponse.getActivityId()%></td></tr>
        <tr><td>getErrorCode :</td> <td><%=createActivityResponse.getErrorCode()%></td></tr>
    </table>

    <%} catch (Exception e) {
            System.out.println("CreateActivity Test Page Exception " + e.getMessage());
        }






    %>
</body>
</html>
