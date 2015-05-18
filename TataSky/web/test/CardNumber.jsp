<%-- 
    Document   : CardNumber
    Created on : Nov 22, 2013, 1:23:27 PM
    Author     : Rajesh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.tsg.log.Logger"%>
<%@page import="com.tsg.recharge.LuhnAlgoImplValidateCreditCard"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>

        <%

            String s_LZ_CardNumber = "301288124446755"; //301288124446755 //4012888888881881

            String LZ_HostResponse = "";

            String LZ_CardType = "";

            boolean s_LZ_HostResponse;

            try {


                // Test method
                //s_LZ_CardNumber = state.getString("LZ_CardNumber");

                Logger.info("Card Number Validate ", " Card Number : " + s_LZ_CardNumber, false);

                s_LZ_HostResponse = LuhnAlgoImplValidateCreditCard.Check(s_LZ_CardNumber);

                LZ_CardType = LuhnAlgoImplValidateCreditCard.getCreditCardType(s_LZ_CardNumber);
                
                System.out.println("s_LZ_HostResponse : " + s_LZ_HostResponse);
                
                System.out.println("LZ_CardType : " + LZ_CardType);

                if (s_LZ_HostResponse) {

                    LZ_HostResponse = "Success";

                } else {

                    LZ_HostResponse = "Failure";
                }
 System.out.println("LZ_HostResponse : " + LZ_HostResponse);


            } catch (Exception ex) {
                //Logger.error(" ", " Exception in Card Number Validate Page :  " + ex.getMessage(), false);
            } finally {

                s_LZ_CardNumber = null;

            }




        %>
    </body>
</html>
