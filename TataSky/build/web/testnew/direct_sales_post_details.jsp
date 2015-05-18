<%-- 
    Document   : direct_sales_post_details
    Created on : Nov 18, 2013, 7:06:27 AM
    Author     : dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Post Details</title>
    </head>
    <body>


        <form action="direct_sales_post_details_response.jsp" method ="post">
            <center>
                <h3> <b> Enter all the Details </b> <br /> </h3>
            </center>
            <table>
                <tr><td>Atom Merchant ID </td><td> <input type="text" name="atom_merchant_id" value="1300101" /></td>
                    <td>Method Type </td><td> <input type="text" name="method_type" value="postDetails" /> <br/></td></tr>       
                <tr><td>Service ID </td><td><input type="text" name="service_id" value="2000001" /> </td>
                    <td>Atom Unique Transaction ID </td><td><input type="text" name="atom_unique_txn_id" value="311665" /> <br/></td></tr>
                <tr><td>Price Point </td><td><input type="text" name="price_point" value="0" /> </td>
                    <td>Call Stage </td><td><input type="text" name="call_stage" value="EnterAmount" /> <br/></td></tr>
                <tr><td>User ID </td><td><input type="text" name="user_id" value="123456789123456" /> </td>
                    <td>SR Number</td><td><input type="text" name="sr_number" value="1337000643" /> <br/></td></tr>
                <tr><td>Product</td><td><input type="text" name="product" value="DirectSales" /></td>
                    <td>Status</td><td><input type="text" name="status" value="CL" /> <br/></td></tr>
                <tr><td>Attempt</td><td><input type="text" name="attempt" value="1" /> </td>
                    <td>Required Digits</td><td><input type="text" name="req_digits" value="4" /> <br/></td></tr>
                <tr><td>Entered Digits </td><td><input type="text" name="entrd_digits" value="2" /> </td>
                    <td>Amount </td><td><input type="text" name="amount" value="" /> <br/></td></tr>
                <tr><td>Subscriber ID </td><td><input type="text" name="sbcr_id" value="" /> </td>
                    <td>User ANI </td><td><input type="text" name="user_ani" value="" /> <br/></td></tr>
                <td>IVR UID</td><td><input type="text" name="ivr_uid" value="" /> </td>


                <tr><td><center><input type ="submit" value="OK"/></center> <br/></td></tr>

                <tr><td></td><td><input type="hidden" name="no_of_boxes" value="" /> </td>
                    <td></td><td><input type="hidden" name="pack_name" value="" /> <br/></td></tr>
                <tr><td></td><td><input type="hidden" name="hardware_amnt" value="" /> </td>
                    <td></td><td><input type="hidden" name="activity_fee" value="" /> <br/></td></tr>
                <tr><td></td><td><input type="hidden" name="bonus_amnt" value="" /> </td>
                    <td></td><td><input type="hidden" name="package_amnt" value="" /> <br/></td></tr>
                <tr><td></td><td><input type="hidden" name="accessories_amnt" value="" /> </td>
                    <td></td><td><input type="hidden" name="total_amnt" value="" /> <br/></td></tr>

                <tr><td></td><td><input type="hidden" name="trnscn_type" value="" /> </td>
                    <td></td><td><input type="hidden" name="sr_valid_response" value="" /> <br/></td></tr>
                <tr><td></td><td><input type="hidden" name="sr_post_response" value="" /> </td>
                    <td></td><td><input type="hidden" name="sub_valid_response" value="" /> <br/></td></tr>
                <tr><td></td><td><input type="hidden" name="sub_post_response" value="" /> </td>

            </table>       
        </form>
    </body>
</html>
