<%@page language="java" contentType="text/xml" pageEncoding="UTF-8"%>
<%@page import="com.tsg.common.rule.RuleDAO"%>
<%@page import="com.tsg.common.rule.RuleService"%>
<%@page import="java.util.Arrays"%>

<%@page import="org.apache.log4j.Logger"%>
<%!    static Logger log = Logger.getLogger(TestRuleEngine_jsp.class);
%>
<%


    int cfID = 1; //Integer.parseInt(request.getParameter("cfID"));
    String[] responseRuleEngine, responseRuleDetail;
    String[] baArrayTest = {"TIME_GREET_FLAG", "LANGUAGE"};
    String[] baValuesTest = {"Morning", "HI"};
    responseRuleEngine = RuleService.evaluateCallFlowExpression(cfID, baArrayTest, baValuesTest);
    RuleDAO objRuleDAO = new RuleDAO();
    responseRuleDetail = objRuleDAO.retrieveRuleAction(responseRuleEngine);
    if (responseRuleEngine != null) {
        System.out.println("Executed Rule Proc responseRuleDetail[0]" + responseRuleDetail[0]);
        System.out.println("Executed Rule Proc responseRuleDetail[1]" + responseRuleDetail[1]);
        System.out.println("Executed ruleID=" + responseRuleEngine[2].toString());
        System.out.println("Executed Rule Proc");
    } else {
        log.info("No rules found for given CallFlowID" + cfID);
    }
        



%>
<%-- GENERATED: DO NOT REMOVE --%> 



