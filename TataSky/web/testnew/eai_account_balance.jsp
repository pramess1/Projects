<%-- 
    Document   : eai_account_balance
    Created on : Nov 18, 2013, 10:46:17 AM
    Author     : dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Account Balance</title>
    </head>
    <body>
        <form id="eai_acct_bal" action="eai_accnt_bal_response.jsp" method ="post">
            <center>
                <h3> <b> Account Balance </b> <br /> </h3>
            </center>

            <table>
                <tr><td>IVR ID </td><td> <input type="text" name="ivr_id" id="ivr_id" size="22"/> <br/></td></tr>
                <script type="text/javascript">
                    document.getElementById('ivr_id').value = "Genesys " + new Date().getDate() + (new Date().getMonth()+1) + new Date().getFullYear() + " " + new Date().getHours() + new Date().getMinutes() + new Date().getSeconds();
                </script>
                <tr><td>Subscriber Number </td><td> <input type="text" name="sbscr_no" value="" size="22"/> <br/></td></tr>
                <tr><td>Date</td><td> <input name="date" id="date" size="22"/> <br/></td></tr>
                <script type="text/javascript">
                    document.getElementById('date').value = new Date().getDate() + "/" + (new Date().getMonth()+1) +"/" + new Date().getFullYear() + " " + new Date().getHours() + ":" + new Date().getMinutes() + ":" + new Date().getSeconds();
                </script>

                <tr><td><center><input type ="submit" value="OK"/></center></td></tr>
            </table>       

        </form>



    </body>
</html>
