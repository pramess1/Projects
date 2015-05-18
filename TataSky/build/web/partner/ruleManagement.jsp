<%-- 
    Document   : ruleManagement
    Created on : 14 Nov, 2013, 11:25:17 AM
    Author     : Developer
--%>

<%@page import="com.tsg.common.rule.RuleDAO"%>
<%@page import="java.util.Arrays"%>
<%@page import="com.tsg.common.rule.RuleService"%>
<%@page import="com.tsg.common.ConfigurationReader"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String outputMessage = "";
    if (request.getParameter("txtAction") != null && request.getParameter("txtAction").equals("getRules")) {
        int cfID = 0;
        if (request.getParameter("cfIDR") != null && (request.getParameter("cfIDR")).trim().length() > 0) {
            cfID = Integer.parseInt(request.getParameter("cfIDR"));
        } else {
            cfID = 0;
        }
        outputMessage = "Rule details.";
        //outputMessage += "<br>Number of Rules grouped by CallFlowIDs =" + RuleService.getNumberOfRulesGroupedByCallFlowID();
        outputMessage += RuleService.getRulesGroupedByCallFlowID(cfID);

    }
    if (request.getParameter("txtAction") != null && request.getParameter("txtAction").equals("ReloadRules")) {
        String webAppPath = getServletContext().getRealPath("/");
        RuleService.initializeRules(webAppPath + "/WEB-INF/rules.xml");
        outputMessage = "Refreshed Rules XML file.";
        outputMessage += "<br>Number of Rules grouped by CallFlowIDs =" + RuleService.getNumberOfRulesGroupedByCallFlowID();

    }
    if (request.getParameter("txtAction") != null && request.getParameter("txtAction").equals("TestRule")) {
        String strBAValues = "";
        String[] baValuesTest;
        int cfID = Integer.parseInt(request.getParameter("cfID"));
        String[] baArrayTest = request.getParameter("bAttrib").toUpperCase().split(",");
        strBAValues = request.getParameter("baValues").toUpperCase();
        if (strBAValues.contains("#")) {
            baValuesTest = request.getParameter("baValues").toUpperCase().split("#");
        } else {
            baValuesTest = request.getParameter("baValues").toUpperCase().split(",");
        }
        outputMessage = "Process Expression " + Arrays.toString(baArrayTest) + " VALUES=" + Arrays.toString(baValuesTest);
        String[] responseRuleEngine, responseRuleDetail;
        responseRuleEngine = RuleService.evaluateCallFlowExpression(cfID, baArrayTest, baValuesTest);
        RuleDAO objRuleDAO = new RuleDAO();
        responseRuleDetail = objRuleDAO.retrieveRuleAction(responseRuleEngine,"");
        if (responseRuleEngine != null) {
            outputMessage += "<br>Rule engine result=" + responseRuleEngine[0];
            outputMessage += "<br>Action id =" + responseRuleEngine[1];
            outputMessage += "<br>Rule Proc Output Param 1" + responseRuleDetail[0];
            outputMessage += "<br>Rule Proc Output Param 2" + responseRuleDetail[1];
            outputMessage += "<br>Rule ID=" + responseRuleEngine[2].toString();
            //out.println("Executed Rule Proc");
        } else {
            outputMessage += "<br>No rules found for given CallFlowID " + cfID;
            //System.out.println("No rules found for given CallFlowID" + cfID);
        }

    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Rule Management</h1>
        <p>
        <div id="outputMessage" style="background-color: lightgray">
            <p>
                <%=outputMessage%>
        </div>           
        <hr>
        <form name="frmRules1" method="post" action="ruleManagement.jsp">
            Get Rules for the <input type="text" name="cfIDR"> call flow ID. <br>
            Leave blank to get all rules.
            <p>
                <input type="submit" value="Get Rules" name="btnSubmit">
                <input type="hidden" name="txtAction" value="getRules">
        </form>
        <hr>
        <p></p>
        <form name="frmRules2" method="post" action="ruleManagement.jsp">
            <input type="submit" value="Reload Rules" name="btnSubmit">
            <input type="hidden" name="txtAction" value="ReloadRules">
        </form>
        <p></p>
        <hr>
        <form name="frmRules3" method="post" action="ruleManagement.jsp">
            <table>
                <tr> 
                    <td>Call Flow ID</td>
                    <td>
                        <input type="text" name="cfID">
                    </td>
                </tr>
                <tr> 
                    <td>Business attributes</td>
                    <td>
                        <input type="text" name="bAttrib" size="100">
                    </td>
                </tr>
                <tr> 
                    <td>Attribute values</td>
                    <td>
                        <input type="text" name="baValues" size="100"><br>
                        (Rule having contains operator should be separated with # for attributes. The attribute values should be surrounded by {} without quotes <br>
                        EG: Morning# {Natarajan,Rishi,Sreenath}
                        ).
                    </td>
                </tr>
            </table>
            <input type="submit" value="Test Rule" name="btnSubmit">
            <input type="hidden" name="txtAction" value="TestRule">            
            <input type="button" name="clear" value="Clear Output"
                   onclick='javascript:document.getElementById("outputMessage").innerHTML="";' >   
        </form>

    </body>
</html>
