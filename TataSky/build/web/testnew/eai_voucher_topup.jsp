<%-- 
    Document   : eai_vooucher_topup
    Created on : Nov 18, 2013, 10:49:04 AM
    Author     : dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Voucher Top-Up</title>
    </head>
    <body>
        <form action="eai_voucher_topup_response.jsp" method ="post">
            <center>
                <h3> <b> Voucher Top-Up </b> <br /> </h3>
            </center>
            
            <table>
                <tr><td>IVR ID </td><td> <input type="text" name="ivr_id" id="ivr_id" size="22"/> <br/></td></tr>
                <script type="text/javascript">
                    document.getElementById('ivr_id').value = "Genesys " + new Date().getDate() + (new Date().getMonth()+1) + new Date().getFullYear() + " " + new Date().getHours() + new Date().getMinutes() + new Date().getSeconds();
                </script>
                <tr><td>Subscriber Number </td><td> <input type="text" name="sbscr_no" value="" size="22"/> <br/></td></tr>
                <tr><td>Voucher Pin </td><td> <input type="text" name="voucher_pin" value="" size="22"/> <br/></td></tr>
                <tr><td>Date</td><td> <input name="date" id="date" size="22"/> <br/></td></tr>
                <script type="text/javascript">
                    document.getElementById('date').value = new Date().getDate() + "/" + (new Date().getMonth()+1) +"/" + new Date().getFullYear() + " " + new Date().getHours() + ":" + new Date().getMinutes() + ":" + new Date().getSeconds();
                </script>
                
                <tr><td><center><input type ="submit" value="OK"/></center></td></tr>
            </table>       
            
        </form>
    </body>
</html>
