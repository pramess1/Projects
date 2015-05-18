<%-- 
    Document   : portal_account_recharge
    Created on : Nov 18, 2013, 11:54:30 AM
    Author     : dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Account Recharge</title>
    </head>
    <body>
        <form action="portal_accnt_recharge_response.jsp" method ="post">
            <center>
                <h3> <b> Account Recharge </b> <br /> </h3>
            </center>
            
            <table>
                <tr><td>Tata Sky Transaction ID </td><td> <input type="text" name="tata_txn_id" value="TI1212170006839585" /> <br/></td></tr>
                <tr><td>Atom Transaction ID </td><td> <input type="text" name="atom_txn_id" value="24063068" /> <br/></td></tr>
                
                <tr><td>Date</td><td> <input name="date" id="date" /> <br/></td></tr>
                <script type="text/javascript">
                    document.getElementById('date').value = new Date().getDate() + "/" + (new Date().getMonth()+1) +"/" + new Date().getFullYear() + " " + new Date().getHours() + ":" + new Date().getMinutes() + ":" + new Date().getSeconds();
                </script>
                <tr><td>Payment Gateway ID</td><td> <input type="text" name="pymnt_gtway_id" value="123457" /> <br/></td></tr>
                <tr><td>RRN </td><td> <input type="text" name="rrn" value="4791132221223525" /> <br/></td></tr>
                <tr><td>Subsriber ID</td><td> <input type="text" name="sbscrbr_id" value="" /> <br/></td></tr>
                <tr><td>Bank Name</td><td> <input type="text" name="bank_nam" value="" /> <br/></td></tr>
                <tr><td>Amount</td><td> <input type="text" name="amnt" value="" /> <br/></td></tr>
                <tr><td></td><td> <input type="hidden" name="err_cd" value="00" /> <br/></td></tr>
                <tr><td></td><td> <input type="hidden" name="err_msg" value="Success" /> <br/></td></tr>
                <tr><td></td><td> <input type="hidden" name="chk_sum" value="" /> <br/></td></tr>
                                
                <tr><td><center><input type ="submit" value="OK"/></center></td></tr>
            </table>       
            
        </form>
    </body>
</html>
