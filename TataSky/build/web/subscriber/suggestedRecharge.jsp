<%-- 
    Document   : suggestedRecharge
    Created on : Feb 11, 2015, 5:04:15 PM
    Author     : Pramesh
--%>

<%@page import="com.tsg.log.Logger"%>
<%@page import="com.tsg.suggestedrecharge.SuggestedRecharge"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%

            String suggestedRechargeAmount = "0";
            String subscriberId = "";
            try {

                SuggestedRecharge suggestedRecharge = new SuggestedRecharge();

                suggestedRechargeAmount = suggestedRecharge.SuggestedRechargeAmount(subscriberId, "");
                
                out.println("Suggested Recharge Amount : " + suggestedRechargeAmount);

                if (suggestedRechargeAmount.equals("0.0")) {

                    suggestedRechargeAmount = "0";
                }

            } catch (Exception ex) {

                Logger.error("", " Exception in Get Account Detail Page :" + subscriberId + " Message : " + ex.getMessage(), false);
            }

        %>
    </body>
</html>
