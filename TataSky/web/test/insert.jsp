<%-- 
    Document   : insert
    Created on : Oct 30, 2013, 5:24:57 PM
    Author     : Rajesh
--%>

<%@page import="com.tsg.database.ivr.dataaccess.CallDetailDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
       
       <%     try {

                //INSERT CALL DETAILS
                CallDetailDAO objCallDetail = new CallDetailDAO();
                String s_CallDetailID = objCallDetail.insertCallDetails("703444445", "18004545800",
                        "0RGO02200ff33333338", "0RGO9HD033QL5V5DffU99LH7A9AK000043222", "BA61444433EEg-C3A5-33334F65-8E9F-F2BAA5266F70;gvp.rm.datanodes=1;gvp.rm.tenant-id=1_TataSkyProfile_Demo", "1", "2013-10-25 11:27:09.5831");
                System.out.println("s_CallDetailID=" + s_CallDetailID);
                } catch (Exception ex) {

                System.out.println(" Exception in insert " + ex.getMessage());
                ex.printStackTrace();

            }
        %>
    </body>
</html>
