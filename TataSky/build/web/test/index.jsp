<%-- 
    Document   : index
    Created on : Dec 16, 2013, 3:40:51 PM
    Author     : dell
--%>



<%@page import="com.tsg.eai.AccountBalance"%>
<%@page import="com.tsg.eai.AccountBalanceResponse"%>
<%@page import="com.tsg.util.Util"%>
<%@page import="com.tsg.log.Logger"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
        <script>
            function hideAll() {
                document.getElementById("eaisubmenu").style.visibility = "hidden";
                document.getElementById("eaiacctbal").style.visibility = "hidden";
                document.getElementById("eaiheavyref").style.visibility = "hidden";
                document.getElementById("eaisoftref").style.visibility = "hidden";
                document.getElementById("eaivouchertopup").style.visibility = "hidden";
                document.getElementById("eaisubscrbrid").style.visibility = "hidden";
                document.getElementById("eaisrvcrequest").style.visibility = "hidden";
                document.getElementById("eaicreaterelocation").style.visibility = "hidden";
                document.getElementById("eaievdrecharge").style.visibility = "hidden";
                               
                return false;
            }
            
            function showmenu() {
                document.getElementById("menu").style.visibility = "visible";
                document.getElementById("eaisubmenu").style.visibility = "hidden";
                
                return false;
            }
            
            function showeaisubmenu() {
                document.getElementById("eaisubmenu").style.visibility = "visible";
                document.getElementById("menu").style.visibility = "hidden";
                document.getElementById("eaiacctbal").style.visibility = "hidden";
                document.getElementById("eaiheavyref").style.visibility = "hidden";
                document.getElementById("eaisoftref").style.visibility = "hidden";
                document.getElementById("eaivouchertopup").style.visibility = "hidden";
                document.getElementById("eaisubscrbrid").style.visibility = "hidden";
                document.getElementById("eaisrvcrequest").style.visibility = "hidden";
                document.getElementById("eaicreaterelocation").style.visibility = "hidden";
                document.getElementById("eaievdrecharge").style.visibility = "hidden";
                
                return false;
            }
            
            function showeaiacctbal() {
                document.getElementById("eaiacctbal").style.visibility = "visible";
                document.getElementById("eaisubmenu").style.visibility = "hidden";
                
                return false;
            }
            
            function showeaiheavyref() {
                document.getElementById("eaiheavyref").style.visibility = "visible";
                document.getElementById("eaisubmenu").style.visibility = "hidden";
                
                return false;
            }
            
            function showeaisoftref() {
                document.getElementById("eaisoftref").style.visibility = "visible";
                document.getElementById("eaisubmenu").style.visibility = "hidden";
                 
                return false;
            }
            
            function showeaivouchertopup() {
                document.getElementById("eaivouchertopup").style.visibility = "visible";
                document.getElementById("eaisubmenu").style.visibility = "hidden";
                return false;
            }
            
            function showeaisubscrbrid() {
                document.getElementById("eaisubscrbrid").style.visibility = "visible";
                document.getElementById("eaisubmenu").style.visibility = "hidden";
                return false;
            }
            
            function showeaisrvcrqust() {
                document.getElementById("eaisrvcrequest").style.visibility = "visible";
                document.getElementById("eaisubmenu").style.visibility = "hidden";
                return false;
            }
            
            function showeaiCreateRelocationWO() {
                document.getElementById("eaicreaterelocation").style.visibility = "visible";
                document.getElementById("eaisubmenu").style.visibility = "hidden";
                return false;
            }
            
            function showeaiEVDRecharge() {
                document.getElementById("eaievdrecharge").style.visibility = "visible";
                document.getElementById("eaisubmenu").style.visibility = "hidden";
                return false;
            }
        </script>
    </head>
    <body onload="hideAll()">

        <div id="menu" style="position:absolute">
            <li><a href="" onclick ="return showeaisubmenu()">EAI</a> </li>
            <li><a href="portal.jsp" onclick ="">PORTAL</a> </li>
            <li><a href="atom.jsp" onclick ="">ATOM - RECHARGE</a> </li>
            <li><a href="directsales.jsp" onclick ="">ATOM - DIRECT SALES</a> </li>
        </div>

        <div id="eaisubmenu" style="position:absolute;width: 250px; height : 300px; top:37%; left: 12%;margin-left: -125px; margin-top: -150px; " size="20">
            <li>Click here to Go to <a href="" onclick ="return showmenu()"> MAIN MENU</a> </li><br/><br/>
            <li><a href="" onclick ="return showeaiacctbal()">Account Balance</a> </li>
            <li><a href="" onclick ="return showeaisoftref()">Soft Refresh</a> </li>
            <li><a href="" onclick ="return showeaiheavyref()">Heavy Refresh</a> </li>
            <li><a href="" onclick ="return showeaivouchertopup()">Voucher Top-up</a> </li>
            <li><a href="" onclick ="return showeaisubscrbrid()">Subscriber ID Validation</a> </li>
            <li><a href="" onclick ="return showeaisrvcrqust()">Service Request</a> </li>
            <li><a href="" onclick ="return showeaiCreateRelocationWO()">Create Relocation WO</a> </li>
            <li><a href="" onclick ="return showeaiEVDRecharge()">EVD Recharge</a> </li>
        </div>

        <form id="eaiacctbal" action="eai_accntBal_response.jsp" method="post">
            <div id="eaiacctbal" style="position: absolute; width: 250px; height : 300px; top:30%; left: 50%;margin-left: -125px; margin-top: -150px; " size="20">
                <center>
                    <h3> <b> Account Balance </b> <br /> </h3>
                </center>

                <table>
                    <tr><td>IVR ID </td><td> <input type="text" name="ivr_id" value="" /> <br/></td></tr>
                    <tr><td>Subscriber Number </td><td> <input type="text" name="sbscr_no" value="" /> <br/></td></tr>
                    <tr><td>Date</td><td> <input name="date" id="date" /> <br/></td></tr>
                    <script type="text/javascript">
                        document.getElementById('date').value = new Date().getDate() + "/" + (new Date().getMonth()+1) +"/" + new Date().getFullYear() + " " + new Date().getHours() + ":" + new Date().getMinutes() + ":" + new Date().getSeconds();
                    </script>

                    <tr><td><input type ="submit" value="OK"/></td><td><input type ="submit" value="BACK" onclick ="this.form.reset();return showeaisubmenu();"/></td></tr>
                </table>       
            </div>  
        </form>

        <form id="eaiheavyref" action ="eai_heavyRef_response.jsp"method="post">
            <div id="eaiheavyref" style="position: absolute; width: 250px; height : 200px; top:30%; left: 50%;margin-left: -125px; margin-top: -100px; " size="20">
                <center>
                    <h3> <b> Heavy Refresh </b> <br /> </h3>
                </center>

                <table>
                    <tr><td>IVR ID </td><td> <input type="text" name="ivr_id" value="" /> <br/></td></tr>
                    <tr><td>Subscriber Number </td><td> <input type="text" name="sbscr_no" value="" /> <br/></td></tr>
                    <tr><td>Request Type </td><td> <input type="text" name="rqust_typ" value="" /> <br/></td></tr>
                    <tr><td>Date</td><td> <input name="date1" id="date1" /> <br/></td></tr>
                    <script type="text/javascript">
                        document.getElementById('date1').value = new Date().getDate() + "/" + (new Date().getMonth()+1) +"/" + new Date().getFullYear() + " " + new Date().getHours() + ":" + new Date().getMinutes() + ":" + new Date().getSeconds();
                    </script>

                    <tr><td><input type ="submit" value="OK"/></td><td><input type ="submit" value="BACK" onclick ="this.form.reset();return showeaisubmenu();"/></td></tr>
                </table>       
            </div> 
        </form>

        <form id="eaisoftref" action="eai_softRef_response.jsp"method="post" >
            <div id="eaisoftref" style="position: absolute; width: 250px; height : 200px; top:30%; left: 50%;margin-left: -125px; margin-top: -100px; " size="20">
                <center>
                    <h3> <b> Soft Refresh </b> <br /> </h3>
                </center>

                <table>
                    <tr><td>IVR ID </td><td> <input type="text" name="ivr_id" value="" /> <br/></td></tr>
                    <tr><td>Subscriber Number </td><td> <input type="text" name="sbscr_no" value="" /> <br/></td></tr>
                    <tr><td>Request Type </td><td> <input type="text" name="rqust_typ" value="" /> <br/></td></tr>
                    <tr><td>Date</td><td> <input name="date2" id="date2" /> <br/></td></tr>
                    <script type="text/javascript">
                        document.getElementById('date2').value = new Date().getDate() + "/" + (new Date().getMonth()+1) +"/" + new Date().getFullYear() + " " + new Date().getHours() + ":" + new Date().getMinutes() + ":" + new Date().getSeconds();
                    </script>

                    <tr><td><input type ="submit" value="OK"/></td><td><input type ="submit" value="BACK" onclick ="this.form.reset();return showeaisubmenu();"/></td></tr>
                </table>       
            </div>
        </form>

        <form id="eaivouchertopup" action="eai_voucherTopup_response.jsp" method ="post">
            <div id="eaivouchertopup" style="position: absolute; width: 250px; height : 200px; top:30%; left: 50%;margin-left: -125px; margin-top: -100px; " size="20">
                <center>
                    <h3> <b> Voucher Top-Up </b> <br /> </h3>
                </center>

                <table>
                    <tr><td>IVR ID </td><td> <input type="text" name="ivr_id" value="" /> <br/></td></tr>
                    <tr><td>Subscriber Number </td><td> <input type="text" name="sbscr_no" value="" /> <br/></td></tr>
                    <tr><td>Voucher Pin </td><td> <input type="text" name="voucher_pin" value="" /> <br/></td></tr>
                    <tr><td>Date</td><td> <input name="date3" id="date3" /> <br/></td></tr>
                    <script type="text/javascript">
                        document.getElementById('date3').value = new Date().getDate() + "/" + (new Date().getMonth()+1) +"/" + new Date().getFullYear() + " " + new Date().getHours() + ":" + new Date().getMinutes() + ":" + new Date().getSeconds();
                    </script>

                    <tr><td><input type ="submit" value="OK"/></td><td><input type ="submit" value="BACK" onclick ="this.form.reset();return showeaisubmenu();"/></td></tr>
                </table>       
            </div>
        </form>

        <form id="eaisubscrbrid" action="eai_subscrbrID_response.jsp" method ="post">
            <div id="eaisubscrbrid" style="position: absolute; width: 250px; height : 200px; top:30%; left: 50%;margin-left: -125px; margin-top: -100px; " size="20">
                <center>
                    <h3> <b> Subscriber ID Validation </b> <br /> </h3>
                </center>

                <table>
                    <tr><td>IVR ID </td><td> <input type="text" name="ivr_id" value="" /> <br/></td></tr>
                    <tr><td>Subscriber Number </td><td> <input type="text" name="sbscr_no" value="" /> <br/></td></tr>
                    <tr><td>Date</td><td> <input name="date4" id="date4" /> <br/></td></tr>
                    <script type="text/javascript">
                        document.getElementById('date4').value = new Date().getDate() + "/" + (new Date().getMonth()+1) +"/" + new Date().getFullYear() + " " + new Date().getHours() + ":" + new Date().getMinutes() + ":" + new Date().getSeconds();
                    </script>
                    <tr><td>Contact Number</td><td> <input type="text" name="cont_num" value="" /> <br/></td></tr>
                    <tr><td>Language </td><td> <input type="text" name="lang" value="" /> <br/></td></tr>
                    <tr><td>Request Type </td><td> <input type="text" name="rqust_typ" value="" /> <br/></td></tr>

                    <tr><td><input type ="submit" value="OK"/></td><td><input type ="submit" value="BACK" onclick ="this.form.reset();return showeaisubmenu();"/></td></tr>
                </table> 
            </div>
        </form>

        <form id="eaisrvcrequest" action="eai_servcRqust_response.jsp" method ="post">
            <div id="eaisrvcrequest" style="position: absolute; width: 250px; height : 200px; top:30%; left: 50%;margin-left: -125px; margin-top: -100px; " size="20">
                <center>
                    <h3> <b> Service Request </b> <br /> </h3>
                </center>

                <table>
                    <tr><td>IVR ID </td><td> <input type="text" name="ivr_id" value="" /> <br/></td></tr>
                    <tr><td>Subscriber Number </td><td> <input type="text" name="sbscr_no" value="" /> <br/></td></tr>
                    <tr><td>Service Request Type </td><td> <input type="text" name="srvc_rqust_typ" value="" /> <br/></td></tr>
                    <tr><td>Service Request Area </td><td> <input type="text" name="srvc_rqust_area" value="" /> <br/></td></tr>
                    <tr><td>Service Request Sub Area</td><td> <input type="text" name="srvc_rqust_sub_area" value="" /> <br/></td></tr>
                    <tr><td>Description </td><td> <input type="text" name="dscrptn" value="" /> <br/></td></tr>
                    <tr><td>Mobile Number </td><td> <input type="text" name="mob_num" value="" /> <br/></td></tr>
                    <tr><td>Request Type </td><td> <input type="text" name="rqust_typ" value="" /> <br/></td></tr>
                    <tr><td>Date</td><td> <input name="date5" id="date5" /> <br/></td></tr>
                    <script type="text/javascript">
                        document.getElementById('date5').value = new Date().getDate() + "/" + (new Date().getMonth()+1) +"/" + new Date().getFullYear() + " " + new Date().getHours() + ":" + new Date().getMinutes() + ":" + new Date().getSeconds();
                    </script>

                    <tr><td><input type ="submit" value="OK"/></td><td><input type ="submit" value="BACK" onclick ="this.form.reset();return showeaisubmenu();"/></td></tr>
                </table>       
            </div>
        </form>

        <form id="eaicreaterelocation" action="eai_createRelocation_response.jsp" method ="post">
            <div id="eaicreaterelocation" style="position: absolute; width: 250px; height : 200px; top:30%; left: 50%;margin-left: -125px; margin-top: -100px; " size="20">
                <center>
                    <h3> <b> Create Relocation </b> <br /> </h3>
                </center>

                <table>
                    <tr><td>IVR ID </td><td> <input type="text" name="ivr_id" value="" /> <br/></td></tr>
                    <tr><td>Subscriber Number </td><td> <input type="text" name="sbscr_no" value="" /> <br/></td></tr>
                    <tr><td>Date</td><td> <input name="date6" id="date6" /> <br/></td></tr>
                    <script type="text/javascript">
                        document.getElementById('date6').value = (new Date().getMonth()+1) + "/" + new Date().getDate +"/" + new Date().getFullYear() + " " + new Date().getHours() + ":" + new Date().getMinutes() + ":" + new Date().getSeconds();
                    </script>
                    <tr><td>Type</td><td> <input type="text" name="typ" value="" /> <br/></td></tr>
                    <tr><td>Subtype </td><td> <input type="text" name="sub_typ" value="" /> <br/></td></tr>
                    <tr><td>Priority</td><td> <input type="text" name="prty" value="" /> <br/></td></tr>

                    <tr><td><input type ="submit" value="OK"/></td><td><input type ="submit" value="BACK" onclick ="this.form.reset();return showeaisubmenu();"/></td></tr>
                </table>       
            </div>
        </form>

        <form id="eaievdrecharge" action="eai_evdRecharge_response.jsp" method ="post">
            <div id="eaievdrecharge" style="position: absolute; width: 250px; height : 200px; top:30%; left: 50%;margin-left: -125px; margin-top: -100px; " size="20">
                <center>
                    <h3> <b> EVD Recharge </b> <br /> </h3>
                </center>

                <table>
                    <tr><td>BA Subscriber ID </td><td> <input type="text" name="ba_sbscrbr_id" value="" /> <br/></td></tr>
                    <tr><td>EVD Pin</td><td> <input type="text" name="evd_pin" value="" /> <br/></td></tr>
                    <tr><td>EVD Mobile Number</td><td> <input type="text" name="evd_mob_num" value="" /> <br/></td></tr>
                    <tr><td>EVD Recharge Value </td><td> <input type="text" name="evd_rechrg_val" value="" /> <br/></td></tr>
                    <tr><td>Date</td><td> <input name="date7" id="date7" /> <br/></td></tr>
                    <script type="text/javascript">
                        document.getElementById('date7').value = new Date().getDate() + "/" + (new Date().getMonth()+1) +"/" + new Date().getFullYear() + " " + new Date().getHours() + ":" + new Date().getMinutes() + ":" + new Date().getSeconds();
                    </script>

                    <tr><td><input type ="submit" value="OK"/></td><td><input type ="submit" value="BACK" onclick ="this.form.reset();return showeaisubmenu();"/></td></tr>
                </table>       
            </div>
        </form>
    </body>
</html>
