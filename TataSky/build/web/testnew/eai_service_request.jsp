<%-- 
    Document   : eai_service_request
    Created on : Nov 18, 2013, 10:48:25 AM
    Author     : dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Service Request</title>
    </head>
    <body>
        <form action="eai_servc_rqust_response.jsp" method ="post">
            <center>
                <h3> <b> Service Request </b> <br /> </h3>
            </center>

            <table>
                <tr><td>IVR ID </td><td> <input type="text" name="ivr_id" id="ivr_id" size="22"/> <br/></td></tr>
                <script type="text/javascript">
                    document.getElementById('ivr_id').value = "Genesys " + new Date().getDate() + (new Date().getMonth()+1) + new Date().getFullYear() + " " + new Date().getHours() + new Date().getMinutes() + new Date().getSeconds();
                </script>
                <tr><td>Subscriber Number </td><td> <input type="text" name="sbscr_no" value="" size="22"/> <br/></td></tr>
                <tr><td>Mobile Number </td><td> <input type="text" name="mob_num" value="" size="22"/> <br/></td></tr>
                <tr><td>Request Type </td><td> <input type="text" name="rqust_typ" value="SRCreation" size="22"/> <br/></td></tr>
                <tr><td>Date</td><td> <input name="date" id="date" size="22"/> <br/></td></tr>
                <script type="text/javascript">
                    document.getElementById('date').value = new Date().getDate() + "/" + (new Date().getMonth()+1) +"/" + new Date().getFullYear() + " " + new Date().getHours() + ":" + new Date().getMinutes() + ":" + new Date().getSeconds();
                </script>

                <tr><td><center><input type ="submit" value="OK"/></center></td></tr>

                <tr><td></td><td> <input type="hidden" name="srvc_rqust_typ" value="" /> <br/></td></tr>
                <tr><td></td><td> <input type="hidden" name="srvc_rqust_area" value="" /> <br/></td></tr>
                <tr><td></td><td> <input type="hidden" name="srvc_rqust_sub_area" value="" /> <br/></td></tr>
                <tr><td></td><td> <input type="hidden" name="dscrptn" value="" /> <br/></td></tr>
            </table>       

        </form>
    </body>
</html>
