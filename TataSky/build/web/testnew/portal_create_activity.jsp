<%-- 
    Document   : portal_create_activity
    Created on : Nov 18, 2013, 11:55:00 AM
    Author     : dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Activity</title>
    </head>
    <body>
        <form action="portal_create_activity_response.jsp">
            <center>
                <h3> <b> Create Activity </b> <br /> </h3>
            </center>
            
            <table>
                <tr><td>Atom IVR ID</td><td> <input type="text" name="atom_ivr_id" value="" /> <br/></td></tr>
                <tr><td>Tata Sky Transaction ID </td><td> <input type="text" name="tata_txn_id" value="ADS130619000823268" /> <br/></td></tr>
                <tr><td>Date</td><td> <input name="date" id="date" /> <br/></td></tr>
                <script type="text/javascript">
                    document.getElementById('date').value = new Date().getDate() + "/" + (new Date().getMonth()+1) +"/" + new Date().getFullYear() + " " + new Date().getHours() + ":" + new Date().getMinutes() + ":" + new Date().getSeconds();
                </script>
                <tr><td>Sr Num</td><td> <input type="text" name="sr_num" value="1-21252501548" /> <br/></td></tr>
                <tr><td>Atom Transaction ID</td><td> <input type="text" name="atom_trans_id" value="752697" /> <br/></td></tr>
                <tr><td>Transaction Status </td><td> <input type="text" name="trans_status" value="SUCCESS" /> <br/></td></tr>
                <tr><td>Bank Reference Number</td><td> <input type="text" name="bank_ref_no" value="066294" /> <br/></td></tr>
                <tr><td>Bank RRN Num </td><td> <input type="text" name="bank_rrn_no" value="317019656325" /> <br/></td></tr>
                <tr><td>Payment Transaction ID</td><td> <input type="text" name="pymnt_trans_id" value="5180320251631701" /> <br/></td></tr>
                <tr><td>Transaction Amount</td><td> <input type="text" name="trans_amnt" value="3570" /> <br/></td></tr>
                <tr><td>Product Code</td><td> <input type="text" name="prdct_cod" value="BoxNo:1STD Pack Name:Multiroom 1Yr MultiTvPack" /> <br/></td></tr>
                <tr><td>Bonus Amount</td><td> <input type="text" name="bonus_amt" value="0" /> <br/></td></tr>
                <tr><td>Hardware Amount</td><td> <input type="text" name="hrdwr_amt" value="999" /> <br/></td></tr>
                <tr><td>Package Amount</td><td> <input type="text" name="pckg_amt" value="2571" /> <br/></td></tr>
                <tr><td>Total Amount</td><td> <input type="text" name="tot_amt" value="3570" /> <br/></td></tr>
                <tr><td>Merchant ID</td><td> <input type="text" name="mrchnt_id" value="17823" /> <br/></td></tr>
                <tr><td>User ID</td><td> <input type="text" name="usr_id" value="541868" /> <br/></td></tr>
                                
                <tr><td><center><input type ="submit" value="OK"/></center></td></tr>
            </table>       
            
        </form>
    </body>
</html>
