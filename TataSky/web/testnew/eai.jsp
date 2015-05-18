<%-- 
    Document   : eai
    Created on : Nov 30, 2013, 4:34:27 PM
    Author     : dell
--%>

<%@page import="com.tsg.util.Util"%>
<%@page import="com.tsg.log.Logger"%>
<%@page import="com.tsg.eai.AccountBalanceResponse"%>
<%@page import="com.tsg.eai.AccountBalance"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <script>
            function hideAll()
            {
                
                document.getElementById("eaiacctbal").style.visibility = "hidden";
                document.getElementById("eaicreaterlctn").style.visibility = "hidden";
                document.getElementById("eaievdrecharge").style.visibility = "hidden";
                document.getElementById("eaiheavyref").style.visibility = "hidden";
                document.getElementById("eaisrvcreq").style.visibility = "hidden";
                document.getElementById("eaisoftref").style.visibility = "hidden";
                document.getElementById("eaisubidvldtn").style.visibility = "hidden";
                document.getElementById("eaivuchrtpup").style.visibility = "hidden";
                              
            }
            
            function showeaiacctbal()
            {
                document.getElementById("eaiacctbal").style.visibility = "visible";
                document.getElementById("submenu").style.visibility = "hidden";
                return false;
            }
            
            
            
            function eaiacntbal_resp()
            {
            <%
            try {
                String dbCallDetailId = request.getParameter("db_call_id");
                String ivrId = request.getParameter("ivr_id");
                String subscriberNumber = request.getParameter("sbscr_no");
//        String dateTime = Util.getCurrentDateAnyFormat("dd/MM/yyyy hh:mm:ss");
                String dateTime = request.getParameter("date");

                Logger.info("AccountBalanceResponse ", Util.getCurrentDateAnyFormat("dd/MM/YYYY hh:mm:ss.SSS"), false);
                AccountBalanceResponse AccountBalanceResponse = new AccountBalance().requestAccountBalance(ivrId,
                        subscriberNumber, dateTime, dbCallDetailId);

                Logger.info("AccountBalanceResponse ", Util.getCurrentDateAnyFormat("dd/MM/YYYY hh:mm:ss"), false);
                Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getIvrId(), false);
                Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getBalance(), false);
                Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getDueDateTime(), false);
                Logger.info("AccountBalanceResponse ", AccountBalanceResponse.getErrorCode(), false);
                Logger.info("AccountBalanceResponse ", Util.getCurrentDateAnyFormat("dd/MM/YYYY hh:mm:ss.SSS"), false);

//        Eai ea = new Eai();
//        out.println(ea.accntBalance(db_call_detail_id,ivr_txn,sbscr_id,daatte));
            %>
       
    //       <table>
    //            <tr><h3>Account Balance Response</h3></tr>
    //        <tr><td>Get Ivr Id :</td> <td><%=AccountBalanceResponse.getIvrId()%></td></tr>
    //        <tr><td>Get Balance :</td> <td><%=AccountBalanceResponse.getBalance()%></td></tr>
    //        <tr><td>Get Due Date Time :</td> <td><%=AccountBalanceResponse.getDueDateTime()%></td></tr>
    //        <tr><td>Get Error Code :</td> <td><%=AccountBalanceResponse.getErrorCode()%></td></tr>
    //    </table>
    
            <%
            } catch (Exception e) {
                Logger.info("Account Balance Test Page Exception ", e.getMessage(), false);
            }
            %>
            
            
            }
        
        </script>
    </head>


    <body>

        <h1>Hello World!</h1>

        <div id="submenu">
            <li><a href="" onclick ="return showeaiacctbal()">Account Balance</a> </li>
            <li><a href="" onclick ="return showeaicreaterlctn()">Soft Refresh</a> </li>
            <li><a href="" onclick ="return showeaievdrecharge()">Heavy Refresh</a> </li>
            <li><a href="" onclick ="return showeaiheavyref()">Service Request</a> </li>
            <li><a href="" onclick ="return showeaisrvcreq()">Voucher Top-up</a> </li>
            <li><a href="" onclick ="return showeaisoftref()">Subscriber ID validation</a> </li>
            <li><a href="" onclick ="return showeaisubidvldtn()">Create Relocation WO</a> </li>
            <li><a href="" onclick ="return showeaivuchrtpup()">EVD Recharge</a> </li>
        </div>


        <form id="eaiacctbal" >
            <div id="eaiacctbal" style="position: absolute; width: 250px; height : 200px; top:50%; left: 50%;margin-left: -125px; margin-top: -100px; " size="20">
                <center>
                    <h3> <b> Account Balance </b> <br /> </h3>
                </center>

                <table>
                    <tr><td>DB Call Detail ID </td><td> <input type="text" name="db_call_id" value="" /> <br/></td></tr>
                    <tr><td>IVR ID </td><td> <input type="text" name="ivr_id" value="" /> <br/></td></tr>
                    <tr><td>Subscriber Number </td><td> <input type="text" name="sbscr_no" value="" /> <br/></td></tr>
                    <tr><td>Date</td><td> <input name="date" id="date" /> <br/></td></tr>
                    <script type="text/javascript">
                        document.getElementById('date').value = new Date().getDate() + "/" + (new Date().getMonth()+1) +"/" + new Date().getFullYear() + " " + new Date().getHours() + ":" + new Date().getMinutes() + ":" + new Date().getSeconds();
                    </script>

                    <tr><td><center><input type ="submit" value="OK" onclick ="eaiacntbal_resp();"/></center></td></tr>
                </table>       
            </div>  
        </form>





    </body>
</html>
