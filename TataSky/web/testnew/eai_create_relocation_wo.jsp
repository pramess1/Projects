<%-- 
    Document   : eai_create_relocation_wo
    Created on : Nov 18, 2013, 10:50:28 AM
    Author     : dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Relocation</title>
    </head>
    <body>
        <form action="eai_create_relocation_response.jsp" method ="post">
            <center>
                <h3> <b> Create Relocation </b> <br /> </h3>
            </center>

            <table>
                <!--<tr><td>IVR ID </td><td> <input type="text" name="ivr_id" value="" /> <br/></td></tr> -->
                <tr><td>IVR ID </td><td> <input type="text" name="ivr_id" id="ivr_id" size="22"/> <br/></td></tr>
                <script type="text/javascript">
                    document.getElementById('ivr_id').value = "Genesys " + new Date().getDate() + (new Date().getMonth()+1) + new Date().getFullYear() + " " + new Date().getHours() + new Date().getMinutes() + new Date().getSeconds();
                </script>
                <tr><td>Subscriber Number </td><td> <input type="text" name="sbscr_no" value="" size="22"/> <br/></td></tr>
                <tr><td>Date</td><td> <input name="date" id="date" size="22"/> <br/></td></tr>
                <script type="text/javascript">
                    document.getElementById('date').value = (new Date().getMonth()+1) + "/" + new Date().getDate() +"/" + new Date().getFullYear() + " " + new Date().getHours() + ":" + new Date().getMinutes() + ":" + new Date().getSeconds();
                </script>
                <tr><td>Type</td><td> <input type="text" name="typ" value="Relocation" size="22"/> <br/></td></tr>
                <tr><td>Subtype </td><td> <input type="text" name="sub_typ" value="Relocate within same house" size="22"/> <br/></td></tr>
                <tr><td>Priority</td><td> <input type="text" name="prty" value="3-Medium" size="22"/> <br/></td></tr>

                <tr><td><center><input type ="submit" value="OK"/></center></td></tr>
            </table>       

        </form>
    </body>
</html>
