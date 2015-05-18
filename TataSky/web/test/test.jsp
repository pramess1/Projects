<%-- 
    Document   : test
    Created on : Sep 25, 2013, 11:57:17 AM
    Author     : Rajesh
--%>

<%@page language="java" contentType="application/json" pageEncoding="UTF-8"%>

<%@page import="com.tsg.atom.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="org.apache.log4j.Logger"%>

<%!
    String atomMerchantId = "1300111";
    String methodType = "getDetails";
    String serviceId = "2000001";
    String amount = "1000.00";
    String tataSkySubscriberId = "1039442552";
    String customerCallerId = "9926845714";
    String genesysUniqueId = "1234567977";
    String userId = "";
    String srNumber = "";
    String product = "";%>

<%

    try {
        GetDetailsResponse objDataService = new GetDetails().requestGetDetails(atomMerchantId, methodType,
                serviceId, amount, tataSkySubscriberId, customerCallerId, genesysUniqueId, userId, srNumber, product,"");
        System.out.println("TxnID : " + objDataService.getOrderId());
        System.out.println("OrderID : " + objDataService.getOrderId());
        System.out.println("Errorcode : " + objDataService.getErrorCode());
        System.out.println("ErrorMsg : " + objDataService.getErrorMessage());
    } catch (Exception e) {
        System.out.println("AccountRecharge Test Page Exception " + e.getMessage());
    }
new GetDetails().getDetails(atomMerchantId, methodType,
                serviceId, amount, tataSkySubscriberId, customerCallerId, genesysUniqueId, userId, srNumber, product,"");

%>


