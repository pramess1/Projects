/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tsg.common;

import com.tsg.log.Logger;

/**
 *
 * @author Rajesh
 */
public class Common {

    public String ValidateMobileNumber(String mobileNumber) {
        String isSuccess = "Y"; // This is used to store the success status.
        try {
            switch (mobileNumber) {
                case "0000000000":
                    isSuccess = "N";
                    break;
                case "1111111111":
                    isSuccess = "N";
                    break;
                case "2222222222":
                    isSuccess = "N";
                    break;
                case "3333333333":
                    isSuccess = "N";
                    break;
                case "4444444444":
                    isSuccess = "N";
                    break;
                case "5555555555":
                    isSuccess = "N";
                    break;
                case "6666666666":
                    isSuccess = "N";
                    break;
                case "7777777777":
                    isSuccess = "N";
                    break;
                case "8888888888":
                    isSuccess = "N";
                    break;
                case "9999999999":
                    isSuccess = "N";
                    break;
                default:
                    isSuccess = "Y";
                    break;
            }
            return isSuccess;
        } catch (Exception ex) {
            Logger.error("", " Exception in Validate Mobile Number : " + ex.getMessage(), false);
            return "N";
        } finally {
            mobileNumber = null;
        }
    }

    public String preferredLanguage(String dbCallDetailID, String currentLanguage) {
        String dynamicCallFlowXML = ""; // This is used to store the callflow in XML format.
        try {
            switch (currentLanguage) {
                case "English":
                    dynamicCallFlowXML = "<CallFlow CDID=\"" + dbCallDetailID + "\" RuleID=\"\"><Prompt CFID=\"38\">1036.wav</Prompt><Prompt CFID=\"38\">1038.wav</Prompt><Prompt CFID=\"38\">1037.wav</Prompt><Menu CFID=\"911\">7225.wav</Menu><Menu CFID=\"909\">7029.wav</Menu><Menu CFID=\"907\">7012.wav</Menu></CallFlow>";
                    break;
                case "Hindi":
                    dynamicCallFlowXML = "<CallFlow CDID=\"" + dbCallDetailID + "\" RuleID=\"\"><Prompt CFID=\"38\">1036.wav</Prompt><Prompt CFID=\"38\">1024.wav</Prompt><Prompt CFID=\"38\">1037.wav</Prompt><Menu CFID=\"911\">7225.wav</Menu><Menu CFID=\"909\">7029.wav</Menu><Menu CFID=\"907\">7012.wav</Menu></CallFlow>";
                    break;
                case "Marathi":
                    dynamicCallFlowXML = "<CallFlow CDID=\"" + dbCallDetailID + "\" RuleID=\"\"><Prompt CFID=\"38\">1036.wav</Prompt><Prompt CFID=\"38\">1025.wav</Prompt><Prompt CFID=\"38\">1037.wav</Prompt><Menu CFID=\"911\">7225.wav</Menu><Menu CFID=\"909\">7029.wav</Menu><Menu CFID=\"907\">7012.wav</Menu></CallFlow>";
                    break;
                case "Gujarati":
                    dynamicCallFlowXML = "<CallFlow CDID=\"" + dbCallDetailID + "\" RuleID=\"\"><Prompt CFID=\"38\">1036.wav</Prompt><Prompt CFID=\"38\">1026.wav</Prompt><Prompt CFID=\"38\">1037.wav</Prompt><Menu CFID=\"911\">7225.wav</Menu><Menu CFID=\"909\">7029.wav</Menu><Menu CFID=\"907\">7012.wav</Menu></CallFlow>";
                    break;
                case "Tamil":
                    dynamicCallFlowXML = "<CallFlow CDID=\"" + dbCallDetailID + "\" RuleID=\"\"><Prompt CFID=\"38\">1036.wav</Prompt><Prompt CFID=\"38\">1027.wav</Prompt><Prompt CFID=\"38\">1037.wav</Prompt><Menu CFID=\"911\">7225.wav</Menu><Menu CFID=\"909\">7029.wav</Menu><Menu CFID=\"907\">7012.wav</Menu></CallFlow>";
                    break;
                case "Bengali":
                    dynamicCallFlowXML = "<CallFlow CDID=\"" + dbCallDetailID + "\" RuleID=\"\"><Prompt CFID=\"38\">1036.wav</Prompt><Prompt CFID=\"38\">1028.wav</Prompt><Prompt CFID=\"38\">1037.wav</Prompt><Menu CFID=\"911\">7225.wav</Menu><Menu CFID=\"909\">7029.wav</Menu><Menu CFID=\"907\">7012.wav</Menu></CallFlow>";
                    break;
                case "Kannada":
                    dynamicCallFlowXML = "<CallFlow CDID=\"" + dbCallDetailID + "\" RuleID=\"\"><Prompt CFID=\"38\">1036.wav</Prompt><Prompt CFID=\"38\">1029.wav</Prompt><Prompt CFID=\"38\">1037.wav</Prompt><Menu CFID=\"911\">7225.wav</Menu><Menu CFID=\"909\">7029.wav</Menu><Menu CFID=\"907\">7012.wav</Menu></CallFlow>";
                    break;
                case "Telugu":
                    dynamicCallFlowXML = "<CallFlow CDID=\"" + dbCallDetailID + "\" RuleID=\"\"><Prompt CFID=\"38\">1036.wav</Prompt><Prompt CFID=\"38\">1030.wav</Prompt><Prompt CFID=\"38\">1037.wav</Prompt><Menu CFID=\"911\">7225.wav</Menu><Menu CFID=\"909\">7029.wav</Menu><Menu CFID=\"907\">7012.wav</Menu></CallFlow>";
                    break;
                case "Odiya":
                    dynamicCallFlowXML = "<CallFlow CDID=\"" + dbCallDetailID + "\" RuleID=\"\"><Prompt CFID=\"38\">1036.wav</Prompt><Prompt CFID=\"38\">1031.wav</Prompt><Prompt CFID=\"38\">1037.wav</Prompt><Menu CFID=\"911\">7225.wav</Menu><Menu CFID=\"909\">7029.wav</Menu><Menu CFID=\"907\">7012.wav</Menu></CallFlow>";
                    break;
                case "Punjabi":
                    dynamicCallFlowXML = "<CallFlow CDID=\"" + dbCallDetailID + "\" RuleID=\"\"><Prompt CFID=\"38\">1036.wav</Prompt><Prompt CFID=\"38\">1032.wav</Prompt><Prompt CFID=\"38\">1037.wav</Prompt><Menu CFID=\"911\">7225.wav</Menu><Menu CFID=\"909\">7029.wav</Menu><Menu CFID=\"907\">7012.wav</Menu></CallFlow>";
                    break;
                case "Malayalam":
                    dynamicCallFlowXML = "<CallFlow CDID=\"" + dbCallDetailID + "\" RuleID=\"\"><Prompt CFID=\"38\">1036.wav</Prompt><Prompt CFID=\"38\">1033.wav</Prompt><Prompt CFID=\"38\">1037.wav</Prompt><Menu CFID=\"911\">7225.wav</Menu><Menu CFID=\"909\">7029.wav</Menu><Menu CFID=\"907\">7012.wav</Menu></CallFlow>";
                    break;
                case "Assamese":
                    dynamicCallFlowXML = "<CallFlow CDID=\"" + dbCallDetailID + "\" RuleID=\"\"><Prompt CFID=\"38\">1036.wav</Prompt><Prompt CFID=\"38\">1034.wav</Prompt><Prompt CFID=\"38\">1037.wav</Prompt><Menu CFID=\"911\">7225.wav</Menu><Menu CFID=\"909\">7029.wav</Menu><Menu CFID=\"907\">7012.wav</Menu></CallFlow>";
                    break;
                case "Manipuri":
                    dynamicCallFlowXML = "<CallFlow CDID=\"" + dbCallDetailID + "\" RuleID=\"\"><Prompt CFID=\"38\">1036.wav</Prompt><Prompt CFID=\"38\">1035.wav</Prompt><Prompt CFID=\"38\">1037.wav</Prompt><Menu CFID=\"911\">7225.wav</Menu><Menu CFID=\"909\">7029.wav</Menu><Menu CFID=\"907\">7012.wav</Menu></CallFlow>";
                    break;
                default:
                    dynamicCallFlowXML = "";
                    break;
            }
            return dynamicCallFlowXML;
        } catch (Exception ex) {
            Logger.error("", " Exception in Preferred Language : " + ex.getMessage(), false);
            return dynamicCallFlowXML;
        } finally {
            dbCallDetailID = currentLanguage = null;
        }
    }

    public String languageDetails(String currentLanguage) {
        String appLanguage = "en-IN"; // This is used to store the callflow in XML format.
        try {
            switch (currentLanguage) {
                case "English":
                    appLanguage = "en-IN";
                    break;
                case "Hindi":
                    appLanguage = "hi-IN";
                    break;
                case "Marathi":
                    appLanguage = "mr-IN";
                    break;
                case "Gujarati":
                    appLanguage = "gu-IN";
                    break;
                case "Tamil":
                    appLanguage = "ta-IN";
                    break;
                case "Bengali":
                    appLanguage = "bn-IN";
                    break;
                case "Kannada":
                    appLanguage = "kn-IN";
                    break;
                case "Telugu":
                    appLanguage = "te-IN";
                    break;
                case "Odiya":
                    appLanguage = "or-IN";
                    break;
                case "Punjabi":
                    appLanguage = "pa-IN";
                    break;
                case "Malayalam":
                    appLanguage = "ml-IN";
                    break;
                case "Assamese":
                    appLanguage = "as-IN";
                    break;
                case "Manipuri":
                    appLanguage = "en-IN";
                    break;
                default:
                    appLanguage = "en-IN";
                    break;
            }
            return appLanguage;
        } catch (Exception ex) {
            Logger.error("", " Exception in Language Details : " + ex.getMessage(), false);
            return appLanguage;
        } finally {
            currentLanguage = null;
        }
    }
}
