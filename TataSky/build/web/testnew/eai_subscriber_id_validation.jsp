<%-- 
    Document   : eai_subscriber_id_validation
    Created on : Nov 18, 2013, 10:49:42 AM
    Author     : dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Subscriber ID Validation</title>
    </head>
    <body>
        <form action="eai_subscrbr_id_response.jsp" method ="post">
            <center>
                <h3> <b> Subscriber ID Validation </b> <br /> </h3>
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
                <tr><td>Contact Number</td><td> <input type="text" name="cont_num" value="" size="22"/> <br/></td></tr>

                <!--       <tr><td>Language </td><td> <input type="text" name="lang" value="" /> <br/></td></tr>   -->
                <tr><td>Request Type </td><td> <input type="text" name="rqust_typ" value="Validation" size="22"/> <br/></td></tr>
                <tr><td>Language </td><td><select name="lang" >
                            <option value="">Select Language</option>
                            <option value="ASM">Assamese</option>
                            <option value="BEN">Bengali</option>
                            <option value="DEF">Default</option>
                            <option value="ENG">English</option>
                            <option value="GUJ">Gujarati</option>
                            <option value="HIN">Hindi</option>
                            <option value="KAN">Kannada</option>
                            <option value="MAL">Malayalam</option>
                            <option value="MAN">Manipuri</option>
                            <option value="MAR">Marathi</option>
                            <option value="ODI">Odiya</option>
                            <option value="PUN">Punjabi</option>
                            <option value="TAM">Tamil</option>
                            <option value="TEL">Telugu</option>
                        </select>
                    </td></tr>                                   


                <tr><td><center><input type ="submit" value="OK"/></center></td></tr>
            </table>       

        </form>
    </body>
</html>

