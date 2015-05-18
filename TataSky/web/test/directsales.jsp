<%-- 
    Document   : directsales
    Created on : Dec 23, 2013, 5:04:19 PM
    Author     : dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <script>
            function hideAll()
            {
                document.getElementById("dirsalesgtdtls").style.visibility = "hidden";
                document.getElementById("dirsalespstdtls").style.visibility = "hidden";
                return false;
            }
            
            function showdirsalessubmenu()
            {
                document.getElementById("dirsalessubmenu").style.visibility = "visible";
                document.getElementById("dirsalesgtdtls").style.visibility = "hidden";
                document.getElementById("dirsalespstdtls").style.visibility = "hidden";
                return false;
            }
            
            function showdirsalesgetdtls()
            {
                document.getElementById("dirsalesgtdtls").style.visibility = "visible";
                document.getElementById("dirsalessubmenu").style.visibility = "hidden";
                return false;
            }
            function showdirsalespstdtls()
            {
                document.getElementById("dirsalespstdtls").style.visibility = "visible";
                document.getElementById("dirsalessubmenu").style.visibility = "hidden";
                return false;
            }
        </script>
    </head>
    <body onload="hideAll()">

        <div id="dirsalessubmenu" style="position:absolute;width: 250px; height : 300px; top:37%; left: 12%;margin-left: -125px; margin-top: -150px; " size="20">
            <li>Click here to Go to <a href="index.jsp" onclick =""> MAIN MENU</a> </li><br/><br/>
            <li><a href="" onclick ="return showdirsalesgetdtls()">Get Details</a> </li>
            <li><a href="" onclick ="return showdirsalespstdtls()">Post Details</a> </li>
        </div>

        <form id="dirsalesgtdtls" action="directSales_getDetails_response.jsp" method="post">
            <div id="dirsalesgtdtls" style="position: absolute; width: 250px; height : 200px; top:30%; left: 50%;margin-left: -125px; margin-top: -100px; " size="20">
                <center>
                    <h3> <b> Enter all the Details </b> <br /> </h3>
                </center>
                <table>
                    <tr><td>IVR ID </td><td> <input type="text" name="ivr_id" value="" /> <br/></td></tr> 
                    <tr><td>Tata Sky Transaction ID </td><td> <input type="text" name="tata_sky_transaction_id" value="" /> <br/></td></tr> 
                    <tr><td>Atom Merchant ID </td><td> <input type="text" name="atom_merchant_id" value="" /> <br/></td></tr> 
                    <tr><td>Method Type </td><td> <input type="text" name="method_type" value="" /> <br/></td></tr>       
                    <tr><td>Service ID </td><td><input type="text" name="service_id" value="" /> <br/></td></tr> 
                    <tr><td>Amount </td><td><input type="text" name="amnt" value="" /> <br/></td></tr>
                    <tr><td>Tata Sky Subscriber ID </td><td><input type="text" name="tata_sbcr_id" value="" /> <br/></td></tr>
                    <tr><td>Customer Caller ID </td><td><input type="text" name="cust_call_id" value="" /> <br/></td></tr>
                    <tr><td>Genesys Unique ID </td><td><input type="text" name="genesys_unique_id" value="" /> <br/></td></tr>
                    <tr><td>User ID </td><td><input type="text" name="user_id" value="" /> <br/></td></tr>
                    <tr><td>SR Number</td><td><input type="text" name="sr_number" value="" /> <br/></td></tr>
                    <tr><td>Product</td><td><input type="text" name="prdct" value="" /> <br/></td></tr>
                    
                    <tr><td><input type ="submit" value="OK"/></td><td><input type ="submit" value="BACK" onclick ="this.form.reset();return showdirsalessubmenu();"/></td></tr>
                </table>   
            </div>
        </form>

        <form id="dirsalespstdtls" action="directSales_postDetails_response.jsp" method="post">
            <div id="dirsalespstdtls">
                <center>
                    <h3> <b> Enter all the Details </b> <br /> </h3>
                </center>
                <table cellpadding ="5" cellspacing="5">
                    <tr><td>Atom Merchant ID </td><td> <input type="text" name="atom_merchant_id" value="" /></td>
                        <td>Method Type </td><td> <input type="text" name="method_type" value="" /> <br/></td></tr>       
                    <tr><td>Service ID </td><td><input type="text" name="service_id" value="" /> </td>
                        <td>Amount </td><td><input type="text" name="amount" value="" /> <br/></td></tr>
                    <tr><td>Price Point </td><td><input type="text" name="price_point" value="" /> </td>
                        <td>Atom Unique Transaction ID </td><td><input type="text" name="atom_unique_txn_id" value="" /> <br/></td></tr>
                    <tr><td>User ID </td><td><input type="text" name="user_id" value="" /> </td>
                        <td>SR Number</td><td><input type="text" name="sr_number" value="" /> <br/></td></tr>
                    <tr><td>Subscriber ID </td><td><input type="text" name="sbcr_id" value="" /> </td>
                        <td>User ANI </td><td><input type="text" name="user_ani" value="" /> <br/></td></tr>
                    <tr><td>IVR UID</td><td><input type="text" name="ivr_uid" value="" /> </td>
                        <td>Status</td><td><input type="text" name="status" value="" /> <br/></td></tr>

                    <tr><td>Call Stage </td><td><input type="text" name="call_stage" value="" /> </td>
                        <td>Required Digits</td><td><input type="text" name="req_digits" value="" /> <br/></td></tr>
                    <tr><td>Entered Digits </td><td><input type="text" name="entrd_digits" value="" /> </td>
                        <td>Attempt</td><td><input type="text" name="attempt" value="" /> <br/></td></tr>

                    <tr><td>No of Boxes</td><td><input type="text" name="no_of_boxes" value="" /> </td>
                        <td>Pack Name</td><td><input type="text" name="pack_name" value="" /> <br/></td></tr>
                    <tr><td>Hardware Amount</td><td><input type="text" name="hardware_amnt" value="" /> </td>
                        <td>Activity Fee</td><td><input type="text" name="activity_fee" value="" /> <br/></td></tr>
                    <tr><td>Bonus Amount</td><td><input type="text" name="bonus_amnt" value="" /> </td>
                        <td>Package Amount</td><td><input type="text" name="package_amnt" value="" /> <br/></td></tr>
                    <tr><td>Accessories Amount</td><td><input type="text" name="accessories_amnt" value="" /> </td>
                        <td>Total Amount</td><td><input type="text" name="total_amnt" value="" /> <br/></td></tr>

                    <tr><td>Transaction Type</td><td><input type="text" name="trnscn_type" value="" /> </td>
                        <td>SR Valid Response</td><td><input type="text" name="sr_valid_response" value="" /> <br/></td></tr>
                    <tr><td>SR Post Response</td><td><input type="text" name="sr_post_response" value="" /> </td>
                        <td>SUB ID Valid Response</td><td><input type="text" name="sub_valid_response" value="" /> <br/></td></tr>
                    <tr><td>SUB ID Post Response</td><td><input type="text" name="sub_post_response" value="" /> </td>
                        <td>Product</td><td><input type="text" name="product" value="" /> <br/></td></tr>
                                        
                    <tr><td><input type ="submit" value="OK"/></td><td><input type ="submit" value="BACK" onclick ="this.form.reset();return showdirsalessubmenu();"/></td></tr>
                </table> 
            </div>
        </form>
    </body>
</html>

