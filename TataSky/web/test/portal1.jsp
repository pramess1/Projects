<%-- 
    Document   : portal
    Created on : Oct 30, 2013, 10:10:33 AM
    Author     : Rajesh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.tsg.portal.*"%>
<%@page import="com.tsg.error.ErrorHandler"%>
<%@page import="com.tsg.util.Util"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String dbCallDetailId = "12";
            String tataskyTransId1 = "";

    // ServiceRequestQuery 
    try {
        String source = "Atom";
        String atomIvrId = "0178E83IA49EDDKE6S3182LAES0002OM";
        String srNumber = "1363776704"; //1362256215//1337000651 // 1337000659 // 1337000667 //1337000643
        srNumber = srNumber.replaceFirst(srNumber.substring(0, 1), srNumber.substring(0, 1) + "-");
        String date = Util.getCurrentDateAnyFormat("dd-MM-yyyy hh:mm:ss");;
        boolean srTypeFlage = false;
        ServiceRequestQueryResponse serviceRequestQueryResponse =
                new ServiceRequestQuery().requestServiceQuery(source, atomIvrId, srNumber, date, dbCallDetailId);
        //srTypeFlage = new Util().srTypeFlage(srType);
%>
<table>
    <tr><h3>Service RequestQuery Response</h3></tr>
<tr><td>getAtomIvrId</td> <td><%=serviceRequestQueryResponse.getAtomIvrId()%></td></tr>
<tr><td>getSrNumber :</td> <td><%=serviceRequestQueryResponse.getSrNumber()%></td></tr>
<tr><td>getTataskyTransId :</td> <td><%=serviceRequestQueryResponse.getTataskyTransId()%></td></tr>
<tr><td>getSrType :</td> <td><%=serviceRequestQueryResponse.getSrType()%></td></tr>
<tr><td>getSrArea :</td> <td><%=serviceRequestQueryResponse.getSrArea()%></td></tr>
<tr><td>getSrSubArea :</td> <td><%=serviceRequestQueryResponse.getSrSubArea()%></td></tr>
<tr><td>getPricePoint :</td> <td><%=serviceRequestQueryResponse.getPricePoint()%></td></tr>
<tr><td>getSubscriberId :</td> <td><%=serviceRequestQueryResponse.getSubscriberId()%></td></tr>
<tr><td>getDate :</td> <td><%=serviceRequestQueryResponse.getDate()%></td></tr>
<tr><td>getPersonalCity :</td> <td><%=serviceRequestQueryResponse.getPersonalCity()%></td></tr>
<tr><td>getErrorCode :</td> <td><%=serviceRequestQueryResponse.getErrorCode()%></td></tr>
</table>

<%
    } catch (Exception e) {
        System.out.println("ServiceRequestQuery Test Page Exception " + e.getMessage());
    }
%>
    
    
</body>
</html>
