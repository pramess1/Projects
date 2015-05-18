<%-- 
    Document   : portal_subscriber_validation
    Created on : Nov 18, 2013, 11:54:45 AM
    Author     : dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Subscriber Validation</title>
    </head>
    <body>
        <form action="portal_subscrbr_id_response.jsp" method ="post">
            <center>
                <h3> <b> Subscriber Validation </b> <br /> </h3>
            </center>

            <table>
                <tr><td> Atom IVR ID </td><td> <input type="text" name="atom_ivr_id" value="" /> <br/></td></tr>
                
                <tr><td><center><input type ="submit" value="OK"/></center></td></tr>
            </table>       

        </form>
    </body>
</html>
