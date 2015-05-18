/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tsg.common.rule;

import java.io.File;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Unmarshaller;
import org.mvel2.MVEL;
import com.tsg.log.Logger;

/**
 *
 * @author Developer Make sure the initializeRules() & processRuleExpressions()
 * are called ONE TIME before evaluation for the RuleEngine to Work.
 */
public class RuleService {

    //private static TblRules ruleList;   // Holds all the Rules (node) present in the XML
    //public static final Logger log = Logger.getLogger(RuleService.class);
    private static HashMap<Integer, List<TblRules.Rule>> ruleGroupMap;  // Holds the CallFlowID and the associated rules as list. 

    /**
     * One time initialization of the Rule XML
     */
    public static boolean initializeRules(String filePath) {

        TblRules ruleList;   // Holds all the Rules (node) present in the XML

        try {

            File file = new File(filePath);

            JAXBContext jaxbContext = JAXBContext.newInstance(TblRules.class);

            Unmarshaller jaxbUnmarshaller = jaxbContext.createUnmarshaller();

            ruleList = (TblRules) jaxbUnmarshaller.unmarshal(file);

            Logger.info(" initializeRules ", "Initialized Rules XML" + ruleList, false);

            return processRuleExpressions(ruleList);

        } catch (JAXBException e) {

            Logger.error(" initializeRules ", "Error initilizing Rules " + e.getMessage(), false);

            return false;

            //e.printStackTrace();
        }

    }

    // METHOD not used anywhere
    public void getCallFlowExpressions(int cfID) {

        int listSize = ruleGroupMap.size() - 1;

        for (int index = 0; index < listSize; index++) {
//            Logger.debug("getCallFlowExpressions"," Rule=" + ruleGroupMap.get(cfID).get(index).getExpr(),false);
//            Logger.debug("getCallFlowExpressions"," CFID=" + ruleGroupMap.get(cfID).get(index).getCallFlowID(),false);
        }
    }

    /**
     *
     * @param cfID CallFlowID
     * @param baArray Holds business attributes
     * @param baValues Holds business attribute values.
     * @return Returns CODE,ACTION string to be used further.
     *
     * Method called regularly wherever the expression evaluation is required.
     */
    public static String[] evaluateCallFlowExpression(Integer cfID, String[] baArray, String[] baValues, String dbCallDetailId) {

        Logger.debug(dbCallDetailId, " Evaluate Call Flow Expression cfID : " + cfID + " baArray : " + baArray.toString() + " baValues : " + baValues.toString(), false);

        List<TblRules.Rule> objLRule;

        objLRule = ruleGroupMap.get(cfID);

               if (objLRule == null) {

            Logger.debug(dbCallDetailId, " No rules found for given CallFlowID : " + cfID, false);

            return null;
        }

        String[] strActionCode = {"F", "", "", ""};

        if (baArray.length != baValues.length) {

            Logger.debug(dbCallDetailId, " Attributes and values do not match for the given CallFlowID : " + cfID, false);

            return strActionCode;
        }

        Map ruleVars = new HashMap();

        int listSize = baArray.length - 1;

        for (int index = 0; index <= listSize; index++) {

            ruleVars.put(baArray[index].toUpperCase(), (String) baValues[index].toUpperCase());
        }

        listSize = objLRule.size() - 1;

        boolean blnResult = false;

        String strRuleExp = "";

        for (int index = 0; index <= listSize; index++) {

            strRuleExp = objLRule.get(index).getExpr();

            blnResult = MVEL.evalToBoolean(strRuleExp, ruleVars);

            if (blnResult) {

                strActionCode[0] = objLRule.get(index).getCode();

                strActionCode[1] = objLRule.get(index).getAction();

                strActionCode[2] = objLRule.get(index).getRuleID().toString();

                strActionCode[3] = objLRule.get(index).getRuleDesc();

                Logger.debug(dbCallDetailId, " CallFlowID : " + cfID + " Get Code : " + strActionCode[0] + " Get Action : " + strActionCode[1]
                        + " Get Rule Id : " + strActionCode[2] + " Get Rule Description : " + strActionCode[3], false);

                return strActionCode;
            }

        }
        return strActionCode;
    }

    /**
     * One time processes the rules. Replaces AND with &&. Groups Rules based on
     * CallFlowID.
     */
    public static boolean processRuleExpressions(TblRules ruleList) {

        Logger.info(" Process Rule Expressions ", " Process Rule Expressions   Started ruleList : " + ruleList, false);

        try {

            ruleGroupMap = new HashMap();

            int listSize = ruleList.rule.size() - 1;

            for (int index = 0; index <= listSize; index++) {

                Integer cfID = ruleList.rule.get(index).getCallFlowID();

                List<TblRules.Rule> tmpList = ruleGroupMap.get(cfID);

                if (tmpList == null) {

                    tmpList = new ArrayList<TblRules.Rule>();

                    ruleList.rule.get(index).setExpr(ruleList.rule.get(index).getExpr().replaceAll(" AND ", " && "));
                    
                    ruleList.rule.get(index).setExpr(ruleList.rule.get(index).getExpr().replaceAll(" OR ", " || "));

                    ruleList.rule.get(index).setExpr(ruleList.rule.get(index).getExpr().replaceAll(" LT ", " < "));

                    ruleList.rule.get(index).setExpr(ruleList.rule.get(index).getExpr().replaceAll(" GT ", " > "));

                    ruleList.rule.get(index).setExpr(ruleList.rule.get(index).getExpr().toUpperCase());

                    tmpList.add(ruleList.rule.get(index));

                    ruleGroupMap.put(cfID, tmpList);
                    //log.debug("NEW" + cfID);
                } else {

                    ruleList.rule.get(index).setExpr(ruleList.rule.get(index).getExpr().replaceAll(" AND ", " && "));
                    
                    ruleList.rule.get(index).setExpr(ruleList.rule.get(index).getExpr().replaceAll(" OR ", " || "));

                    ruleList.rule.get(index).setExpr(ruleList.rule.get(index).getExpr().replaceAll(" LT ", " < "));

                    ruleList.rule.get(index).setExpr(ruleList.rule.get(index).getExpr().replaceAll(" GT ", " > "));

                    ruleList.rule.get(index).setExpr(ruleList.rule.get(index).getExpr().toUpperCase());

                    tmpList.add(ruleList.rule.get(index));

                    ruleGroupMap.put(cfID, tmpList);

                }
            }

            listSize = ruleGroupMap.size() - 1;

            Integer callFlowID = 0;

            for (Map.Entry<Integer, List<TblRules.Rule>> entry : ruleGroupMap.entrySet()) {

                //log.debug("Key : " + entry.getKey() + " Value : " + entry.getValue());

                callFlowID = entry.getKey();

                List<TblRules.Rule> tmpList = ruleGroupMap.get(callFlowID); //index is nothing but CFID

                Collections.sort(tmpList);
            }

            Logger.debug(" Process Rule Expressions ", " Process Rule Expressions Stoped  ", false);

            return true;

        } catch (Exception ex) {

            Logger.error("  ", " Error processing Rule expressions " + ex.getMessage(), false);

            return false;
        }
    }

    public static int getNumberOfRulesGroupedByCallFlowID() {

        return (ruleGroupMap != null ? ruleGroupMap.size() : 0);
    }

    public static String getRulesGroupedByCallFlowID(int icallFlowID) {

        Integer callFlowID = 0;

        String strRules = "";

        if (icallFlowID == 0) {

            for (Map.Entry<Integer, List<TblRules.Rule>> entry : ruleGroupMap.entrySet()) {

                callFlowID = entry.getKey();

                List<TblRules.Rule> tmpList = ruleGroupMap.get(callFlowID);

                int listSize = tmpList.size() - 1;

                strRules += "<br>====================";

                for (int index = 0; index <= listSize; index++) {

                    strRules += "<br><br>Expression=" + tmpList.get(index).getExpr();

                    strRules += "&nbsp;Code=" + tmpList.get(index).getCode();

                    strRules += "&nbsp;Action=" + tmpList.get(index).getAction();

                    strRules += "&nbsp;RuleID=" + tmpList.get(index).getRuleID().toString();
                }

            }

        } else {

            List<TblRules.Rule> tmpList = ruleGroupMap.get(icallFlowID);

            strRules += "<br>====================";

            if (tmpList == null) {

                strRules += "No rule found for the call flow ID";

            } else {

                int listSize = tmpList.size() - 1;

                for (int index = 0; index <= listSize; index++) {

                    strRules += "<br><br>Expression=" + tmpList.get(index).getExpr();

                    strRules += "&nbsp;Code=" + tmpList.get(index).getCode();

                    strRules += "&nbsp;Action=" + tmpList.get(index).getAction();

                    strRules += "&nbsp;RuleID=" + tmpList.get(index).getRuleID().toString();
                }

            }

        }

        return strRules;
    }
}
///*
// * To change this template, choose Tools | Templates
// * and open the template in the editor.
// */
//package com.tsg.common.rule;
//
//import java.io.File;
//import java.util.ArrayList;
//import java.util.Collections;
//import java.util.HashMap;
//import java.util.Iterator;
//import java.util.List;
//import java.util.Map;
//import javax.xml.bind.JAXBContext;
//import javax.xml.bind.JAXBException;
//import javax.xml.bind.Unmarshaller;
//import org.apache.log4j.Logger;
//import org.mvel2.MVEL;
//
///**
// *
// * @author Developer Make sure the initializeRules() & processRuleExpressions()
// * are called ONE TIME before evaluation for the RuleEngine to Work.
// */
//public class RuleService {
//
//    //private static TblRules ruleList;   // Holds all the Rules (node) present in the XML
//    public static final Logger log = Logger.getLogger(RuleService.class);
//    private static HashMap<Integer, List<TblRules.Rule>> ruleGroupMap;  // Holds the CallFlowID and the associated rules as list. 
//
//    /**
//     * One time initialization of the Rule XML
//     */
//    public static void initializeRules(String filePath) {
//        TblRules ruleList;   // Holds all the Rules (node) present in the XML
//        try {
//            File file = new File(filePath);
//            JAXBContext jaxbContext = JAXBContext.newInstance(TblRules.class);
//            Unmarshaller jaxbUnmarshaller = jaxbContext.createUnmarshaller();
//            ruleList = (TblRules) jaxbUnmarshaller.unmarshal(file);
//            log.info("Initialized Rules XML" + ruleList);
//            processRuleExpressions(ruleList);
//        } catch (JAXBException e) {
//            e.printStackTrace();
//        }
//    }
//
//    public void getCallFlowExpressions(int cfID) {
//        int listSize = ruleGroupMap.size() - 1;
//        for (int index = 0; index < listSize; index++) {
//            System.out.print("Rule=" + ruleGroupMap.get(cfID).get(index).getExpr());
//            System.out.println("CFID=" + ruleGroupMap.get(cfID).get(index).getCallFlowID());
//
//        }
//    }
//
//    /**
//     *
//     * @param cfID CallFlowID
//     * @param baArray Holds business attributes
//     * @param baValues Holds business attribute values.
//     * @return Returns CODE,ACTION string to be used further.
//     *
//     * Method called regularly wherever the expression evaluation is required.
//     */
//    public static String[] evaluateCallFlowExpression(Integer cfID, String[] baArray, String[] baValues) {
//        String[] strActionCode = {"F", "", ""};
//        List<TblRules.Rule> objLRule;
//        objLRule = ruleGroupMap.get(cfID);
//        //System.out.println("Length of BA variables =" + baArray.length);
//        //Collections.sort(objLRule);
//        if (objLRule == null) {
//            System.out.println("No rules found for given CallFlowID" + cfID);
//            return null;
//        }
//        Map ruleVars = new HashMap();
//        int listSize = baArray.length - 1;
//        for (int index = 0; index <= listSize; index++) {
//            ruleVars.put(baArray[index], (String) baValues[index]);
//            System.out.println("Added BA=" + baArray[index]);
//        }
//
//        listSize = objLRule.size() - 1;
//        boolean blnResult = false;
//        for (int index = 0; index <= listSize; index++) {
//            String strRuleExp = objLRule.get(index).getExpr();
//            log.info("Exp to evaluate=" + strRuleExp);
//
//            blnResult = MVEL.evalToBoolean(strRuleExp, ruleVars);
//            log.info("Dynamic expression result from MVEL of the RULE=" + blnResult + " for Rule index" + index);
//
//            if (blnResult) {
//                strActionCode[0] = objLRule.get(index).getCode();
//                strActionCode[1] = objLRule.get(index).getAction();
//                strActionCode[2] = objLRule.get(index).getRuleID().toString();
//                log.debug("Expression output=" + strActionCode.toString());
//                log.debug("Expression output=" + strActionCode[2].toString());
//                return strActionCode;
//            }
//
//        }
//        return strActionCode;
//    }
//
//    /**
//     * One time processes the rules. Replaces AND with &&. Groups Rules based on
//     * CallFlowID.
//     */
//    public static void processRuleExpressions(TblRules ruleList) {
//        ruleGroupMap = new HashMap();
//        int listSize = ruleList.rule.size() - 1;
//        log.info("Total rules =" + listSize);
//        for (int index = 0; index <= listSize; index++) {
//            Integer cfID = ruleList.rule.get(index).getCallFlowID();
//            List<TblRules.Rule> tmpList = ruleGroupMap.get(cfID);
//            if (tmpList == null) {
//                tmpList = new ArrayList<TblRules.Rule>();
//                ruleList.rule.get(index).setExpr(ruleList.rule.get(index).getExpr().replaceAll(" AND ", " && "));
//                ruleList.rule.get(index).setExpr(ruleList.rule.get(index).getExpr().replaceAll(" LT ", " < "));
//                ruleList.rule.get(index).setExpr(ruleList.rule.get(index).getExpr().replaceAll(" GT ", " > "));
//                tmpList.add(ruleList.rule.get(index));
//                ruleGroupMap.put(cfID, tmpList);
//                log.debug("NEW" + cfID);
//            } else {
//                ruleList.rule.get(index).setExpr(ruleList.rule.get(index).getExpr().replaceAll(" AND ", " && "));
//                ruleList.rule.get(index).setExpr(ruleList.rule.get(index).getExpr().replaceAll(" LT ", " < "));
//                ruleList.rule.get(index).setExpr(ruleList.rule.get(index).getExpr().replaceAll(" GT ", " > "));
//                tmpList.add(ruleList.rule.get(index));
//                ruleGroupMap.put(cfID, tmpList);
//                log.debug("INSERTED" + cfID);
//            }
//        }
//        log.debug("Size of final MAP with unique callflow ids=" + ruleGroupMap.size());
//
//        listSize = ruleGroupMap.size() - 1;
////        for (int index = 1; index <= listSize; index++) {
////            List<TblRules.Rule> tmpList = ruleGroupMap.get(index); //index is nothing but CFID
////            Collections.sort(tmpList);
////        }
//       
//        Integer callFlowID=0;
//        for (Map.Entry<Integer, List<TblRules.Rule>> entry : ruleGroupMap.entrySet()) {
//            //System.out.println("Key : " + entry.getKey() + " Value : " + entry.getValue());
//            callFlowID = entry.getKey();
//            List<TblRules.Rule> tmpList = ruleGroupMap.get(callFlowID); //index is nothing but CFID
//            Collections.sort(tmpList);
//        }
//
//        log.info("Grouped Rules XML with priority sorting.");
//    }
//}
///*
// * To change this template, choose Tools | Templates
// * and open the template in the editor.
// */
//package com.tsg.common.rule;
//
//import java.io.File;
//import java.util.ArrayList;
//import java.util.Collections;
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//import javax.xml.bind.JAXBContext;
//import javax.xml.bind.JAXBException;
//import javax.xml.bind.Unmarshaller;
//import org.mvel2.MVEL;
//import com.tsg.log.Logger;
//
///**
// *
// * @author Developer Make sure the initializeRules() & processRuleExpressions()
// * are called ONE TIME before evaluation for the RuleEngine to Work.
// */
//public class RuleService {
//
//    private static HashMap<Integer, List<TblRules.Rule>> ruleGroupMap;  // Holds the CallFlowID and the associated rules as list. 
//
//    /**
//     * One time initialization of the Rule XML
//     */
//    public static boolean initializeRules(String filePath) {
//
//        TblRules ruleList;   // Holds all the Rules (node) present in the XML
//
//        try {
//
//            File file = new File(filePath);
//
//            JAXBContext jaxbContext = JAXBContext.newInstance(TblRules.class);
//
//            Unmarshaller jaxbUnmarshaller = jaxbContext.createUnmarshaller();
//
//            ruleList = (TblRules) jaxbUnmarshaller.unmarshal(file);
//
//            Logger.info(" ", "Initialized Rules XML" + ruleList, false);
//
//            return processRuleExpressions(ruleList);
//
//        } catch (JAXBException e) {
//
//            Logger.error(" ", "Error initilizing Rules " + e.getMessage(), false);
//
//            return false;
//
//        } finally {
//            
//            filePath = null;
//        }
//
//    }
//
//    // METHOD not used anywhere
//    public void getCallFlowExpressions(int cfID) {
//
//        int listSize = ruleGroupMap.size() - 1;
//
//        for (int index = 0; index < listSize; index++) {
////            Logger.debug("getCallFlowExpressions"," Rule=" + ruleGroupMap.get(cfID).get(index).getExpr(),false);
////            Logger.debug("getCallFlowExpressions"," CFID=" + ruleGroupMap.get(cfID).get(index).getCallFlowID(),false);
//        }
//    }
//
//    /**
//     *
//     * @param cfID CallFlowID
//     * @param baArray Holds business attributes
//     * @param baValues Holds business attribute values.
//     * @return Returns CODE,ACTION string to be used further.
//     *
//     * Method called regularly wherever the expression evaluation is required.
//     */
//    public static String[] evaluateCallFlowExpression(Integer cfID, String[] baArray, String[] baValues) {
//
//        List<TblRules.Rule> objLRule;
//
//        objLRule = ruleGroupMap.get(cfID);
//
//        if (objLRule == null) {
//
//            Logger.debug("", " No rules found for given CallFlowID : " + cfID, false);
//
//            return null;
//        }
//
//        String[] strActionCode = {"F", "", "", ""};
//
//        if (baArray.length != baValues.length) {
//
//            Logger.debug(" ", " Attributes and values do not match for the given CallFlowID : " + cfID, false);
//
//            return strActionCode;
//        }
//
//        Map ruleVars = new HashMap();
//
//        int listSize = baArray.length - 1;
//
//        for (int index = 0; index <= listSize; index++) {
//
//            ruleVars.put(baArray[index].toUpperCase(), (String) baValues[index].toUpperCase());
////            Logger.debug("","Added BA=" + baArray[index],false);
////            Logger.debug("","Added BA Values=" + baValues[index],false);
//        }
//
//        //Logger.debug(" Evaluate Call Flow Expression ", " For Loop1 Stoped for the given CallFlowID : " + cfID, false);
//
//        listSize = objLRule.size() - 1;
//
//        boolean blnResult = false;
//
//        String strRuleExp = "";
//
//        //Logger.debug(" Evaluate Call Flow Expression ", " For Loop2 Started for the given CallFlowID : " + cfID, false);
//
//        for (int index = 0; index <= listSize; index++) {
//
//            strRuleExp = objLRule.get(index).getExpr();
//
////            Logger.debug("","Exp to evaluate=" + strRuleExp,false);
//
//            blnResult = MVEL.evalToBoolean(strRuleExp, ruleVars);
//
//            //log.info("Dynamic expression result from MVEL of the RULE=" + blnResult + " for Rule index" + index);
//
//            if (blnResult) {
//
//                strActionCode[0] = objLRule.get(index).getCode();
//
//                strActionCode[1] = objLRule.get(index).getAction();
//
//                strActionCode[2] = objLRule.get(index).getRuleID().toString();
//
//                strActionCode[3] = objLRule.get(index).getRuleDesc();
//
//                Logger.debug(" ", " CallFlowID : " + cfID + " Get Code : " + strActionCode[0] + " Get Action : " + strActionCode[1]
//                        + " Get Rule Id : " + strActionCode[2] + " Get Rule Description : " + strActionCode[3], false);
//
//                return strActionCode;
//            }
//
//        }
//
//        //Logger.debug(" Evaluate Call Flow Expression ", " For Loop2 Stoped for the given CallFlowID : " + cfID, false);
//
//        return strActionCode;
//    }
//
//    /**
//     * One time processes the rules. Replaces AND with &&. Groups Rules based on
//     * CallFlowID.
//     */
//    public static boolean processRuleExpressions(TblRules ruleList) {
//
//        Logger.info(" ", " Process Rule Expressions   Started ruleList : " + ruleList, false);
//
//        try {
//
//            ruleGroupMap = new HashMap();
//
//            int listSize = ruleList.rule.size() - 1;
//
//            for (int index = 0; index <= listSize; index++) {
//
//                Integer cfID = ruleList.rule.get(index).getCallFlowID();
//
//                List<TblRules.Rule> tmpList = ruleGroupMap.get(cfID);
//
//                if (tmpList == null) {
//
//                    tmpList = new ArrayList<TblRules.Rule>();
//
//                    ruleList.rule.get(index).setExpr(ruleList.rule.get(index).getExpr().replaceAll(" AND ", " && "));
//
//                    ruleList.rule.get(index).setExpr(ruleList.rule.get(index).getExpr().replaceAll(" LT ", " < "));
//
//                    ruleList.rule.get(index).setExpr(ruleList.rule.get(index).getExpr().replaceAll(" GT ", " > "));
//
//                    ruleList.rule.get(index).setExpr(ruleList.rule.get(index).getExpr().toUpperCase());
//
//                    tmpList.add(ruleList.rule.get(index));
//
//                    ruleGroupMap.put(cfID, tmpList);
//                    
//                } else {
//
//                    ruleList.rule.get(index).setExpr(ruleList.rule.get(index).getExpr().replaceAll(" AND ", " && "));
//
//                    ruleList.rule.get(index).setExpr(ruleList.rule.get(index).getExpr().replaceAll(" LT ", " < "));
//
//                    ruleList.rule.get(index).setExpr(ruleList.rule.get(index).getExpr().replaceAll(" GT ", " > "));
//
//                    ruleList.rule.get(index).setExpr(ruleList.rule.get(index).getExpr().toUpperCase());
//
//                    tmpList.add(ruleList.rule.get(index));
//
//                    ruleGroupMap.put(cfID, tmpList);
//
//                }
//            }
//
//            listSize = ruleGroupMap.size() - 1;
//
//            Integer callFlowID = 0;
//
//            for (Map.Entry<Integer, List<TblRules.Rule>> entry : ruleGroupMap.entrySet()) {
//
//                //log.debug("Key : " + entry.getKey() + " Value : " + entry.getValue());
//
//                callFlowID = entry.getKey();
//
//                List<TblRules.Rule> tmpList = ruleGroupMap.get(callFlowID); //index is nothing but CFID
//
//                Collections.sort(tmpList);
//            }
//
//            Logger.debug(" ", " Process Rule Expressions Stoped  ", false);
//
//            return true;
//
//        } catch (Exception ex) {
//
//            Logger.error(" ", " Error processing Rule expressions " + ex.getMessage(), false);
//
//            return false;
//        }
//    }
//
//    public static int getNumberOfRulesGroupedByCallFlowID() {
//
//        return (ruleGroupMap != null ? ruleGroupMap.size() : 0);
//    }
//
//    public static String getRulesGroupedByCallFlowID(int icallFlowID) {
//
//        Integer callFlowID = 0;
//
//        String strRules = "";
//
//        if (icallFlowID == 0) {
//
//            for (Map.Entry<Integer, List<TblRules.Rule>> entry : ruleGroupMap.entrySet()) {
//
//                callFlowID = entry.getKey();
//
//                List<TblRules.Rule> tmpList = ruleGroupMap.get(callFlowID);
//
//                int listSize = tmpList.size() - 1;
//
//                strRules += "<br>====================";
//
//                for (int index = 0; index <= listSize; index++) {
//
//                    strRules += "<br><br>Expression=" + tmpList.get(index).getExpr();
//
//                    strRules += "&nbsp;Code=" + tmpList.get(index).getCode();
//
//                    strRules += "&nbsp;Action=" + tmpList.get(index).getAction();
//
//                    strRules += "&nbsp;RuleID=" + tmpList.get(index).getRuleID().toString();
//                }
//
//            }
//
//        } else {
//
//            List<TblRules.Rule> tmpList = ruleGroupMap.get(icallFlowID);
//
//            strRules += "<br>====================";
//
//            if (tmpList == null) {
//
//                strRules += "No rule found for the call flow ID";
//
//            } else {
//
//                int listSize = tmpList.size() - 1;
//
//                for (int index = 0; index <= listSize; index++) {
//
//                    strRules += "<br><br>Expression=" + tmpList.get(index).getExpr();
//
//                    strRules += "&nbsp;Code=" + tmpList.get(index).getCode();
//
//                    strRules += "&nbsp;Action=" + tmpList.get(index).getAction();
//
//                    strRules += "&nbsp;RuleID=" + tmpList.get(index).getRuleID().toString();
//                }
//
//            }
//
//        }
//
//        return strRules;
//    }
//}
