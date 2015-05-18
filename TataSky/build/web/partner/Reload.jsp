<%-- 
    Document   : Reload
    Created on : Mar 25, 2014, 3:58:18 PM
    Author     : Rajesh
--%>

<%@page import="com.tsg.log.Logger"%>
<%@page import="com.tsg.common.rule.RuleService"%>
<%@page import="com.tsg.common.ConfigurationReader"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reload</title>
    </head>
    <body>
        <%
            String reload = request.getParameter("reload");
            String webAppPath = getServletContext().getRealPath("/");
            Logger.info(" "," Reload : " + reload + " Web App Path : " + webAppPath,false);
            try {
                if (reload.equalsIgnoreCase("config")) {
                    ConfigurationReader configReader = new ConfigurationReader();
                    configReader.loadInstanceConfiguration(webAppPath);
                    out.println("<h1>Config Properties loaded Successfully....</h1>");
                } else if (reload.equalsIgnoreCase("rule")) {
                    RuleService.initializeRules(webAppPath + "/WEB-INF/rules.xml");
                    out.println("<h1>Rules loaded Successfully....</h1>");
                    out.println("<h3>Number of Rules grouped by CallFlowIDs : </h3>" + RuleService.getNumberOfRulesGroupedByCallFlowID());
                } else {
                    out.println("<h1>Wrong Parameter Value....</h1>");
                }
            } catch (Exception ex) {
                Logger.error("", " Exception in Reload Page :" + ex.getMessage(), false);
            } finally {
                reload = webAppPath = null;
            }
        %>
    </body>
</html>
