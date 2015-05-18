<%-- 
    Document   : eai_soft_refresh
    Created on : Nov 18, 2013, 10:47:29 AM
    Author     : dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Soft Refresh</title>
    </head>
    <body>
        <form id="eai_soft_ref" action="eai_soft_ref_response.jsp" method ="post">
            <center>
                <h3> <b> Soft Refresh </b> <br /> </h3>
            </center>
            
            <table>
                <tr><td>IVR ID </td><td> <input type="text" name="ivr_id" id="ivr_id" size="22"/> <br/></td></tr>
                <script type="text/javascript">
                    document.getElementById('ivr_id').value = "Genesys " + new Date().getDate() + (new Date().getMonth()+1) + new Date().getFullYear() + " " + new Date().getHours() + new Date().getMinutes() + new Date().getSeconds();
                </script>
                <tr><td>Subscriber Number </td><td> <input type="text" name="sbscr_no" value="" size="22"/> <br/></td></tr>
                <tr><td>Request Type </td><td> <input type="text" name="rqust_typ" value="SoftRefresh" size="22"/> <br/></td></tr>
                <tr><td>Date</td><td> <input name="date" id="date" size="22"/> <br/></td></tr>
                <script type="text/javascript">
                    document.getElementById('date').value = new Date().getDate() + "/" + (new Date().getMonth()+1) +"/" + new Date().getFullYear() + " " + new Date().getHours() + ":" + new Date().getMinutes() + ":" + new Date().getSeconds();
                </script>
                
                <tr><td><center><input type ="submit" value="OK"/></center></td></tr>
            </table>       
            
        </form>
    </body>
</html>
