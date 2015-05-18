<%-- 
    Document   : test
    Created on : 29 Jul, 2013, 10:44:59 AM
    Author     : Developer
--%>
<%@page import="com.tsg.common.rule.RuleDAO"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Arrays"%>
<%@page import="com.tsg.common.ConfigurationReader"%>
<%@page import="com.tsg.common.rule.RuleService"%>
<%@page import="java.sql.Clob"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="com.tsg.database.ivr.dataaccess.CallDetailDAO"%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.tsg.database.DBConnectionPool"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tata Sky - Genesys Web Application</title>
    </head>
    <body>
        <h1>Welcome to Test Rule Page!</h1> <p><br>
            <%

                int cfID = Integer.parseInt(request.getParameter("cfID"));
                String[] baArrayTest = request.getParameter("bAttrib").split(",");
                String[] baValuesTest = request.getParameter("baValues").split(",");

                System.out.println("Process Expression " + Arrays.toString(baArrayTest) + " VALUES=" + Arrays.toString(baValuesTest));

                String[] responseRuleEngine, responseRuleDetail;
//    String[] baArrayTest = {"TIME_GREET_FLAG", "LANGUAGE"};
//    String[] baValuesTest = {"Morning", "HI"};
                responseRuleEngine = RuleService.evaluateCallFlowExpression(cfID, baArrayTest, baValuesTest);
                RuleDAO objRuleDAO = new RuleDAO();
                responseRuleDetail = objRuleDAO.retrieveRuleAction(responseRuleEngine);
                if (responseRuleEngine != null) {
                    out.println("<br>Executed Rule Proc Output Param 1" + responseRuleDetail[0]);
                    out.println("<br>Executed Rule Proc Output Param 2" + responseRuleDetail[1]);
                    out.println("<br>Executed ruleID=" + responseRuleEngine[2].toString());
                    //out.println("Executed Rule Proc");
                } else {
                    out.println("No rules found for given CallFlowID" + cfID);
                    System.out.println("No rules found for given CallFlowID" + cfID);
                }
            %>
    </body>
</html>
