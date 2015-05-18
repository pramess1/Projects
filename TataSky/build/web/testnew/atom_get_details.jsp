<%-- 
    Document   : atom_get_details
    Created on : Nov 18, 2013, 9:30:45 AM
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


        <form action="atom_get_details_response.jsp" method ="post">
            <center>
                <h3> <b> Enter all the Details </b> <br /> </h3>
            </center>
            <table>
                <tr><td>Genesys Unique ID </td><td><input type="text" name="genesys_unique_id" id="genesys_unique_id" size="22"/> <br/></td></tr>
                <script type="text/javascript">
                    document.getElementById('genesys_unique_id').value = "Genesys " + new Date().getDate() + (new Date().getMonth()+1) + new Date().getFullYear() + " " + new Date().getHours() + new Date().getMinutes() + new Date().getSeconds();
                </script>
                <!--<tr><td>Atom Merchant ID </td><td> <input type="text" name="atom_merchant_id" value="1300111" /> <br/></td></tr> -->
                

                <tr><td>Method Type </td><td> <input type="text" name="method_type" value="getDetails" size="22"/> <br/></td></tr>       
                <tr><td>Service ID </td><td><input type="text" name="service_id" value="2000001" size="22"/> <br/></td></tr> 
                <tr><td>Tata Sky Subscriber ID </td><td><input type="text" name="tata_sbcr_id" value="1039442552" size="22"/> <br/></td></tr>
                <!--         <tr><td>Product</td><td><input type="text" name="prdct" value="Recharge" /> <br/></td></tr>  -->
                <tr><td>Atom Merchant ID </td><td> <select name="atom_merchant_id"> 
                            <option value="">Select Merchant ID</option>
                            <option value="1300111">Recharge</option>
                            <option value="1300101">Direct Sales</option>
                        </select>
                    </td></tr>
                <tr><td>Product</td><td><select name="prdct" >
                            <option value="">Select Product</option>
                            <option value="Recharge">Recharge</option>
                            <option value="DirectSales">Direct Sales</option>
                        </select></td></tr>
                <tr><td>Amount </td><td><input type="text" name="amount" value="" size="22"/> <br/></td></tr>
                <tr><td>Customer Caller ID </td><td><input type="text" name="cust_call_id" value="" size="22"/> <br/></td></tr>
                
                <tr><td><center><input type ="submit" value="OK"/></center><br/></td></tr>

                <tr><td></td><td><input type="hidden" name="user_id" value="" /> <br/></td></tr>
                <tr><td></td><td><input type="hidden" name="sr_number" value="" /> <br/></td></tr>
                <tr><td></td><td> <input type="hidden" name="ivr_id" value="" /> <br/></td></tr> 
                <tr><td></td><td> <input type="hidden" name="tata_sky_transaction_id" value="" /> <br/></td></tr>



            </table>       
        </form>
    </body>
</html>
