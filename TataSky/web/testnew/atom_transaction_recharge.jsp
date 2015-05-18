<%-- 
    Document   : atom_transaction_recharge
    Created on : Nov 18, 2013, 5:29:52 PM
    Author     : dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="atom_transaction_recharge_response.jsp">
            <center>
                <h3> <b> Enter all the Details </b> <br /> </h3>
            </center>



            <table cellpadding="5" cellspacing="5">
                <tr><td>Atom Merchant ID </td><td> <input type="text" name="atom_merchant_id" value="1300111" /> </td>
                    <td>Method Type </td><td> <input type="text" name="method_type" value="postDetails" /> <br/></td></tr>       
                <tr><td>Service ID </td><td><input type="text" name="service_id" value="9009001" /> </td>
                    <td>Atom Transaction Unique ID</td><td><input type="text" name="atom_txn_id" value="TI1307100007535922" /> <br/></td></tr>
                <tr><td>EMI Tenure</td><td><input type="text" name="emi_tenure" value="00" /> </td>
                    <td>Product</td><td><input type="text" name="prdct" value="Recharge" /> <br/></td></tr>
                <tr><td>Card Number </td><td><input type="text" name="card_num" value="4012888888881881" /> </td>
                    <td>Expiry Date</td><td><input type="date" name="expiry_date" value="1213" /> <br/></td></tr>
                <tr><td>CVV Number</td><td><input type="text" name="cvv_num" value="123" /> </td>
                    <td>Batch Code</td><td><input type="text" name="batch_code" value="123456" /> <br/></td></tr>
                <tr><td>OTP</td><td><input type="text" name="otp" value="123456" /> </td>
                    <td>Tata Sky Transaction ID</td><td><input type="text" name="tatasky_trans_id" value="TI1307100007535922" /> <br/></td></tr>
                <tr><td>Payment Type</td><td><input type="text" name="pymnt_type" value="CREDIT" /> </td>
                    <td>Amount </td><td><input type="text" name="amount" value="" /> <br/></td></tr>
                <tr><td>Subscriber ID </td><td><input type="text" name="sbscrbr_id" value="" /> </td>
                    <td>User ANI </td><td><input type="text" name="user_ani" value="" /><br/> </td></tr>

                <tr><td><center><input type ="submit" value="OK"/> </center><br/></td></tr>

                <tr><td></td><td><input type="hidden" name="price_point" value="" /> </td>
                <tr><td></td><td><input type="hidden" name="hardware_amnt" value="" /> </td>
                    <td></td><td><input type="hidden" name="package_amnt" value="" /> <br/></td></tr>
                <tr><td></td><td><input type="hidden" name="bonus_amnt" value="" /> </td>
                    <td></td><td><input type="hidden" name="pack_name" value="" /> <br/></td></tr>
                <td></td><td><input type="hidden" name="mob_num" value="" /> <br/></td></tr>
                <tr><td></td><td><input type="hidden" name="ba_pin" value="" /> </td>
                    <td></td><td><input type="hidden" name="recharge_option" value="" /> <br/></td></tr>
                <tr><td></td><td><input type="hidden" name="recharge_option_agent" value="" /> </td>
                    <td></td><td><input type="hidden" name="card_type" value="" /> <br/></td></tr>
            </table>
        </form>
    </body>
</html>
