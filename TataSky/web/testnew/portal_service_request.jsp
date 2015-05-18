<%-- 
    Document   : portal_service_request
    Created on : Nov 18, 2013, 11:55:18 AM
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
        <form action="portal_service_request_response.jsp" method ="post">
            <center>
                <h3> <b> Service Request </b> <br /> </h3>
            </center>
            
            <table>
                <tr><td>Source</td><td> <input type="text" name="src" value="Atom" /> <br/></td></tr>
                <tr><td>Atom IVR ID </td><td> <input type="text" name="atom_ivr_id" value="" /> <br/></td></tr>
                <tr><td>srNumber</td><td> <input type="text" name="sr_num" value="1337000643" /> <br/></td></tr>
                <tr><td>Date</td><td> <input name="date" id="date" /> <br/></td></tr>
                <script type="text/javascript">
                    document.getElementById('date').value = new Date().getDate() + "/" + (new Date().getMonth()+1) +"/" + new Date().getFullYear() + " " + new Date().getHours() + ":" + new Date().getMinutes() + ":" + new Date().getSeconds();
                </script>
                
                <tr><td><center><input type ="submit" value="OK"/></center></td></tr>
            </table>       
            
        </form>
    </body>
</html>
