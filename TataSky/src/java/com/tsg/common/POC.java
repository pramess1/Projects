///*
// * To change this template, choose Tools | Templates
// * and open the template in the editor.
// */
//package com.tsg.common;
//
//import com.tsg.common.rule.RuleService;
//import java.sql.Connection;
//import java.sql.DriverManager;
//import java.sql.PreparedStatement;
//import java.sql.SQLException;
//import java.util.ArrayList;
//import java.util.Iterator;
//import java.util.List;
//import java.util.logging.Level;
//import java.util.logging.Logger;
//
///**
// *
// * @author Developer
// */
//public class POC {
//
//    public static void main(String args[]) {
//        System.out.println("Bismillah");
//
////        strReplacements = String.format(String.format("%%0%dd", 3), 0).replaceAll("0", "?,");
////        System.out.println(strReplacements);
////        RuleService.initializeRules("C:/Users/Developer/Desktop/rules.xml");
////
////        String[] baArray = {"TIME_GREET_FLAG", "LANGUAGE", "Test", "PDate"};
////        String[] baValues = {"Noon", "EN", "1", "2016-08-14"};
////
////        System.out.println("Response from Rule Engine:" + RuleService.evaluateCallFlowExpression(1, baArray, baValues));
////        String[] baArray1 = {"BRAND_GREET_FLAG"};
////        String[] baValues1 = {"Y"};
////        System.out.println("Response from Rule Engine:" + RuleService.evaluateCallFlowExpression(2, baArray1, baValues1));
//        POC poc = new POC();
//        //poc.prepareQuery("");
//        ArrayList stagingTableColumnList = new ArrayList();
//        stagingTableColumnList.add("col1");
//        stagingTableColumnList.add("col2");
//        poc.buildInsertQuery(stagingTableColumnList);
//        poc.prepareQuery(poc.buildInsertQuery(stagingTableColumnList));
//    }
//
//    public void prepareQuery(String strQuery) {
//        try {
//            Class.forName("com.mysql.jdbc.Driver");
//            String sql = "insert into sheet1 (drive, subject_code, roll_no, token_no) values (?, ?, ?, ?)";
//            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost/miasdb?" + "user=root&password=vpek");
//            PreparedStatement ps = connection.prepareStatement(strQuery);
//            //String[] strValue = {"A", "B", "C", "D"};
//            String[] strData = {"data2", "data3"};
//            //String[] rowIndex = {"4", "3"};
//            ArrayList rowIndex = new ArrayList();
//            rowIndex.add(4);
//            rowIndex.add(2);
//
//            System.out.println(rowIndex.get(0));
//            final int batchSize = 4;
//            int count = 0;
//
//            for (int index = 0; index < 15; index++) { // Bulk Insert X number of records at a time.
//                int matchedColumnsIndex = 0, matchedColumnsLength;
//                matchedColumnsLength = rowIndex.size();
//                System.out.println("Length" + matchedColumnsLength);
//                for (int dataColumnindex = 1; dataColumnindex <= 4; dataColumnindex++) { // Variable number of columns
//                    if (matchedColumnsIndex < matchedColumnsLength) {
//                        if (rowIndex.contains(dataColumnindex)) {
//                            ps.setString(dataColumnindex, strData[rowIndex.indexOf(dataColumnindex)]);
//                            System.out.println("MSExcel Data=" + strData[rowIndex.indexOf(dataColumnindex)]);
//                            matchedColumnsIndex++;
//                            continue;
//                        }
//                    }
//                    ps.setString(dataColumnindex, null);
//                    System.out.println("Blank Data added @ " + dataColumnindex);
//
//                }
//                ps.addBatch();
//                if (++count % batchSize == 0) {
//                    //ps.executeBatch();
//                    System.out.println("Executed batch");
//                }
//            }
//           // ps.executeBatch(); // inserting remaining records
//            ps.close();
//
//        } catch (Exception ex) {
//            Logger.getLogger(POC.class.getName()).log(Level.SEVERE, null, ex);
//        }
//    }
//
//    private String buildInsertQuery(List<String> strColumnNames) {
//        int fieldCounter = 0;
//        StringBuilder sbColumn = new StringBuilder();
//        sbColumn.append("INSERT INTO tablename (");
//        Iterator itr = strColumnNames.iterator();
//        while (itr.hasNext()) {
//            sbColumn.append(itr.next() + " ,");
//            fieldCounter++;
//        }
//        sbColumn.deleteCharAt(sbColumn.length() - 1);
//        sbColumn.append(" ) VALUES (");
//        for (int i = 0; i < fieldCounter; i++) {
//            sbColumn.append(" ?,");
//        }
//        sbColumn.deleteCharAt(sbColumn.length() - 1);
//        sbColumn.append(")");
//        System.out.println("sbColumn=" + sbColumn.toString());
//        return sbColumn.toString();
//    }
//}
