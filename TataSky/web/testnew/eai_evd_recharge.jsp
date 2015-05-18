<%-- 
    Document   : eai_evd_recharge
    Created on : Nov 18, 2013, 10:50:46 AM
    Author     : dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>EVD Recharge</title>
    </head>
    <body>
        <form action="eai_evd_recharge_response.jsp" method ="post">
            <center>
                <h3> <b> EVD Recharge </b> <br /> </h3>
            </center>
            
            <table>
                <tr><td>BA Subscriber ID </td><td> <input type="text" name="ba_sbscrbr_id" value="" /> <br/></td></tr>
                <tr><td>EVD Pin</td><td> <input type="text" name="evd_pin" value="" /> <br/></td></tr>
                <tr><td>EVD Mobile Number</td><td> <input type="text" name="evd_mob_num" value="" /> <br/></td></tr>
                <tr><td>EVD Recharge Value </td><td> <input type="text" name="evd_rechrg_val" value="" /> <br/></td></tr>
                <tr><td>Date</td><td> <input name="date" id="date" /> <br/></td></tr>
                <script type="text/javascript">
                    document.getElementById('date').value = new Date().getDate() + "/" + (new Date().getMonth()+1) +"/" + new Date().getFullYear() + " " + new Date().getHours() + ":" + new Date().getMinutes() + ":" + new Date().getSeconds();
                </script>
                
                <tr><td><center><input type ="submit" value="OK"/></center></td></tr>
            </table>       
            
        </form>
    </body>
</html>
