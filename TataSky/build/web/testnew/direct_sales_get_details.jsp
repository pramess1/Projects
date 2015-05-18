<%-- 
    Document   : direct_sales_get_details
    Created on : Nov 18, 2013, 6:55:55 AM
    Author     : dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Get Details</title>
    </head>
    <body>


        <form action="direct_sales_get_details_response.jsp" method ="post">
            <center>
                <h3> <b> Enter all the Details </b> <br /> </h3>
            </center>
            <table>

                <tr><td>Atom Merchant ID </td><td> <input type="text" name="atom_merchant_id" value="1300101" /> <br/></td></tr> 
                <tr><td>Method Type </td><td> <input type="text" name="method_type" value="getDetails" /> <br/></td></tr>       
                <tr><td>Service ID </td><td><input type="text" name="service_id" value="2000001" /> <br/></td></tr> 
                <tr><td>Amount </td><td><input type="text" name="amnt" value="0" /> <br/></td></tr>
                <tr><td>Tata Sky Subscriber ID </td><td><input type="text" name="tata_sbcr_id" value="1039442552" /> <br/></td></tr>
                <tr><td>Customer Caller ID </td><td><input type="text" name="cust_call_id" value="101015" /> <br/></td></tr>
                <tr><td>User ID </td><td><input type="text" name="user_id" value="101015" /> <br/></td></tr>
                <tr><td>SR Number</td><td><input type="text" name="sr_number" value="1337000643" /> <br/></td></tr>
                <tr><td>Product</td><td><input type="text" name="prdct" value="DirectSales" /> <br/></td></tr>
                <tr><td>Genesys Unique ID </td><td><input type="text" name="genesys_unique_id" value="" /> <br/></td></tr>

                <tr><td><center><input type ="submit" value="OK"/></center> <br/></td></tr>

                <tr><td></td><td> <input type="hidden" name="ivr_id" value="" /> <br/></td></tr> 
                <tr><td></td><td> <input type="hidden" name="tata_sky_transaction_id" value="" /> <br/></td></tr> 
            </table>       
        </form>
    </body>
</html>
