<%-- 
    Document   : portal
    Created on : Dec 23, 2013, 5:02:51 PM
    Author     : dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        
        <script>
            function hideAll()
            {
                document.getElementById("poracctrchrg").style.visibility = "hidden";
                document.getElementById("porcrteactvt").style.visibility = "hidden";
                document.getElementById("porsrvcrqst").style.visibility = "hidden";
                document.getElementById("porsbscrvldtn").style.visibility = "hidden";
                                               
                return false;
            }
            
            function showporsubmenu()
            {
                document.getElementById("porsubmenu").style.visibility = "visible";
                document.getElementById("poracctrchrg").style.visibility = "hidden";
                document.getElementById("porcrteactvt").style.visibility = "hidden";
                document.getElementById("porsrvcrqst").style.visibility = "hidden";
                document.getElementById("porsbscrvldtn").style.visibility = "hidden";
                return false;
            }
            
            function showporacctrchrg()
            {
                document.getElementById("poracctrchrg").style.visibility = "visible";
                document.getElementById("porsubmenu").style.visibility = "hidden";
                return false;
            }
            
            function showporsbscrvldtn()
            {
                document.getElementById("porsbscrvldtn").style.visibility = "visible";
                document.getElementById("porsubmenu").style.visibility = "hidden";
                return false;
            }
            
            function showporcrtactvty()
            {
                document.getElementById("porcrteactvt").style.visibility = "visible";
                document.getElementById("porsubmenu").style.visibility = "hidden";
                return false;
            }
            
            function showporsrvcreq()
            {
                document.getElementById("porsrvcrqst").style.visibility = "visible";
                document.getElementById("porsubmenu").style.visibility = "hidden";
                return false;
            }
            
        </script>
    </head>
    <body onload="hideAll()">
                
        <div id="porsubmenu" style="position:absolute;width: 250px; height : 300px; top:37%; left: 12%;margin-left: -125px; margin-top: -150px; " size="20">
            <li>Click here to Go to <a href="index.jsp" onclick =""> MAIN MENU</a> </li><br/><br/>
            <li><a href="" onclick ="return showporacctrchrg()">Account Recharge</a> </li>
            <li><a href="" onclick ="return showporsbscrvldtn()">Subscriber Validation</a> </li>
            <li><a href="" onclick ="return showporcrtactvty()">Create Activity</a> </li>
            <li><a href="" onclick ="return showporsrvcreq()">Service Request</a> </li>
        </div>
        
        <form id="poracctrchrg" action="portal_accntRecharge_response.jsp" method="post">
            <div id="poracctrchrg" style="position: absolute; width: 250px; height : 200px; top:30%; left: 50%;margin-left: -125px; margin-top: -100px; " size="20">
                <center>
                    <h3> <b> Account Recharge </b> <br /> </h3>
                </center>

                <table>
                    <tr><td>Subsriber ID</td><td> <input type="text" name="sbscrbr_id" value="" /> <br/></td></tr>
                    <tr><td>Tata Sky Transaction ID </td><td> <input type="text" name="tata_txn_id" value="" /> <br/></td></tr>
                    <tr><td>Atom Transaction ID </td><td> <input type="text" name="atom_txn_id" value="" /> <br/></td></tr>
                    <tr><td>Bank Name</td><td> <input type="text" name="bank_nam" value="" /> <br/></td></tr>
                    <tr><td>Amount</td><td> <input type="text" name="amnt" value="" /> <br/></td></tr>
                    <tr><td>Date</td><td> <input name="date" id="date" /> <br/></td></tr>
                    <script type="text/javascript">
                        document.getElementById('date').value = new Date().getDate() + "/" + (new Date().getMonth()+1) +"/" + new Date().getFullYear() + " " + new Date().getHours() + ":" + new Date().getMinutes() + ":" + new Date().getSeconds();
                    </script>
                    <tr><td>Payment Gateway ID</td><td> <input type="text" name="pymnt_gtway_id" value="" /> <br/></td></tr>
                    <tr><td>RRN </td><td> <input type="text" name="rrn" value="" /> <br/></td></tr>
                    <tr><td>Error Code </td><td> <input type="text" name="err_cd" value="" /> <br/></td></tr>
                    <tr><td>Error Message </td><td> <input type="text" name="err_msg" value="" /> <br/></td></tr>
                    <tr><td>Check Sum</td><td> <input type="text" name="chk_sum" value="" /> <br/></td></tr>
                    
                    <tr><td><input type ="submit" value="OK"/></td><td><input type ="submit" value="BACK" onclick ="this.form.reset();return showporsubmenu();"/></td></tr>
                </table>       
            </div>
        </form>

        <form id="porcrteactvt" action="portal_createActivity_response.jsp" method="post">
            <div id="porcrteactvt" style="position: absolute; width: 250px; height : 200px; top:30%; left: 50%;margin-left: -125px; margin-top: -100px; " size="20">
                <center>
                    <h3> <b> Create Activity </b> <br /> </h3>
                </center>

                <table>
                    <tr><td>Atom IVR ID</td><td> <input type="text" name="atom_ivr_id" value="" /> <br/></td></tr>
                    <tr><td>Tata Sky Transaction ID </td><td> <input type="text" name="tata_txn_id" value="" /> <br/></td></tr>
                    <tr><td>Date</td><td> <input name="date1" id="date1" /> <br/></td></tr>
                    <script type="text/javascript">
                        document.getElementById('date1').value = new Date().getDate() + "/" + (new Date().getMonth()+1) +"/" + new Date().getFullYear() + " " + new Date().getHours() + ":" + new Date().getMinutes() + ":" + new Date().getSeconds();
                    </script>
                    <tr><td>Sr Num</td><td> <input type="text" name="sr_num" value="" /> <br/></td></tr>
                    <tr><td>Atom Transaction ID</td><td> <input type="text" name="atom_trans_id" value="" /> <br/></td></tr>
                    <tr><td>Transaction Status </td><td> <input type="text" name="trans_status" value="" /> <br/></td></tr>
                    <tr><td>Bank Reference Number</td><td> <input type="text" name="bank_ref_no" value="" /> <br/></td></tr>
                    <tr><td>Bank RRN Num </td><td> <input type="text" name="bank_rrn_no" value="" /> <br/></td></tr>
                    <tr><td>Payment Transaction ID</td><td> <input type="text" name="pymnt_trans_id" value="" /> <br/></td></tr>
                    <tr><td>Transaction Amount</td><td> <input type="text" name="trans_amnt" value="" /> <br/></td></tr>
                    <tr><td>Product Code</td><td> <input type="text" name="prdct_cod" value="" /> <br/></td></tr>
                    <tr><td>Bonus Amount</td><td> <input type="text" name="bonus_amt" value="" /> <br/></td></tr>
                    <tr><td>Hardware Amount</td><td> <input type="text" name="hrdwr_amt" value="" /> <br/></td></tr>
                    <tr><td>Package Amount</td><td> <input type="text" name="pckg_amt" value="" /> <br/></td></tr>
                    <tr><td>Total Amount</td><td> <input type="text" name="tot_amt" value="" /> <br/></td></tr>
                    <tr><td>Merchant ID</td><td> <input type="text" name="mrchnt_id" value="" /> <br/></td></tr>
                    <tr><td>User ID</td><td> <input type="text" name="usr_id" value="" /> <br/></td></tr>
                    
                    <tr><td><input type ="submit" value="OK"/></td><td><input type ="submit" value="BACK" onclick ="this.form.reset();return showporsubmenu();"/></td></tr>
                </table>       
            </div>
        </form>

        <form id="porsrvcrqst" action="portal_serviceRequest_response.jsp" method="post">
            <div id="porsrvcrqst" style="position: absolute; width: 250px; height : 200px; top:30%; left: 50%;margin-left: -125px; margin-top: -100px; " size="20">
                <center>
                    <h3> <b> Service Request </b> <br /> </h3>
                </center>

                <table>
                    <tr><td>Source</td><td> <input type="text" name="src" value="" /> <br/></td></tr>
                    <tr><td>Atom IVR ID </td><td> <input type="text" name="atom_ivr_id" value="" /> <br/></td></tr>
                    <tr><td>srNumber</td><td> <input type="text" name="sr_num" value="" /> <br/></td></tr>
                    <tr><td>Date</td><td> <input name="date2" id="date2" /> <br/></td></tr>
                    <script type="text/javascript">
                        document.getElementById('date2').value = new Date().getDate() + "/" + (new Date().getMonth()+1) +"/" + new Date().getFullYear() + " " + new Date().getHours() + ":" + new Date().getMinutes() + ":" + new Date().getSeconds();
                    </script>
                    
                    <tr><td><input type ="submit" value="OK"/></td><td><input type ="submit" value="BACK" onclick ="this.form.reset();return showporsubmenu();"/></td></tr>
                </table>       
            </div>
        </form>

        <form id="porsbscrvldtn" action="portal_subscriberId_response.jsp" method="post">
            <div id="porsbscrvldtn" style="position: absolute; width: 250px; height : 200px; top:30%; left: 50%;margin-left: -125px; margin-top: -100px; " size="20">
                <center>
                    <h3> <b> Subscriber Validation </b> <br /> </h3>
                </center>

                <table>
                    <tr><td> Atom IVR ID </td><td> <input type="text" name="atom_ivr_id" value="" /> <br/></td></tr>
                    
                    <tr><td><input type ="submit" value="OK"/></td><td><input type ="submit" value="BACK" onclick ="this.form.reset();return showporsubmenu();"/></td></tr>
                </table>       
            </div>
        </form>
    </body>
</html>
