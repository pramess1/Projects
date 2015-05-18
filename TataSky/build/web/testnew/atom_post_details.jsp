<%-- 
    Document   : atom_post_details
    Created on : Nov 18, 2013, 10:40:04 AM
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


        <form action="atom_post_details_response.jsp">
            <center>
                <h3> <b> Enter all the Details </b> <br /> </h3>
            </center>



            <table>
                <!--        <tr><td>Atom Merchant ID </td><td> <input type="text" name="atom_merchant_id" value="" /> <br/></td></tr> 
                        <tr><td>Method Type </td><td> <input type="text" name="method_type" value="" /> <br/></td></tr>       -->

                <tr><td>Atom Merchant ID </td><td> <input type="text" name="atom_merchant_id" value="1300111" /> </td> 
                    <td>Method Type </td><td> <input type="text" name="method_type" value="postDetails" /> <br/></td></tr> 
                <tr><td>Service ID </td><td><input type="text" name="service_id" value="2000001" /> </td> 
                    <td>Atom Unique Transaction ID </td><td><input type="text" name="atom_unique_txn_id" value="311665" /> </td><br/></td></tr>
                <tr><td>Status</td><td><input type="text" name="status" value="CL" /> </td>
                    <td>Call Stage </td><td><input type="text" name="call_stage" value="EnterAmount" /><br/> </td></tr>
                <tr><td>Required Digits</td><td><input type="text" name="req_digits" value="4" /> </td>
                    <td>Entered Digits </td><td><input type="text" name="entrd_digits" value="2" /><br/></td></tr>
                <tr><td>Attempt</td><td><input type="text" name="attempt" value="1" /> </td>
                    <td>SUB ID Valid Response</td><td><input type="text" name="sub_valid_response" value="XML" /> <br/></td></tr>
                <tr><td>SUB ID Post Response</td><td><input type="text" name="sub_post_response" value="XML" /> </td>
                    <td>Product</td><td><input type="text" name="product" value="Recharge" /> <br/></td></tr>
                <tr><td>User ANI </td><td><input type="text" name="user_ani" value="" /> </td>
                    <td>IVR UID</td><td><input type="text" name="ivr_uid" value="" /><br/></td></tr>
                <tr><td>Amount </td><td><input type="text" name="amount" value="" /> </td>
                    <td>Subscriber ID </td><td><input type="text" name="sbcr_id" value="" /><br/></td></tr>

                <tr><td><center><input type ="submit" value="OK"/> </center><br/></td></tr>

                <tr><td></td><td><input type="hidden" name="price_point" value="" /> </td>
                <tr><td></td><td><input type="hidden" name="user_id" value="" /> </td>
                    <td></td><td><input type="hidden" name="sr_number" value="" /> <br/></td></tr>
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



            </table>
        </form>
    </body>
</html>
