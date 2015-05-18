/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tsg.common;

import com.tsg.common.rule.RuleService;

import com.tsg.database.DBConnectionPool;

import com.tsg.log.LogRotator;

import com.tsg.log.Logger;

import java.io.FileInputStream;

import java.io.IOException;

import java.sql.Connection;

import java.util.Hashtable;

import java.util.Properties;

import javax.servlet.ServletContext;

import javax.servlet.ServletContextEvent;

import javax.servlet.ServletContextListener;

import Common.ActionObjects.*;
import java.util.Enumeration;


//import org.apache.log4j.LogManager;
//import org.apache.log4j.Logger;

import org.apache.log4j.xml.DOMConfigurator;

/**
 *
 * @author Developer
 */
public class ConfigurationReader implements ServletContextListener {

    public static Hashtable<String, String> configList = new Hashtable();
    public static int IVRCallCounter;

    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) { // servletContextEvent

        //System.out.println("TSG Context initialized");

        IVRCallCounter = 1;

        ServletContext servletContext = servletContextEvent.getServletContext();

        String webAppPath = servletContext.getRealPath("/");

        // String log4jProp = webAppPath + "WEB-INF/log4j.properties";
        // PropertyConfigurator.configure(log4jProp);

        //String log4jXml = webAppPath + servletContext.getInitParameter("log4jFileName");

        //DOMConfigurator.configure(log4jXml);

        loadInstanceConfiguration(webAppPath);

        // loadAppConfiguration(servletContext);

        //System.out.println(webAppPath + "/WEB-INF/rules.xml");

        if (!RuleService.initializeRules(webAppPath + "/WEB-INF/rules.xml")) {

            Logger.error("Context Initialized ", "************RULES INITIALIZATION FAILED*********", false);
        }

        String dataCenter = ConfigurationReader.configList.get("DATACENTER");

        DBConnectionPool dbConPool = new DBConnectionPool();

        dbConPool.setPoolDataSource(dataCenter + "IVRPRDB");

        Connection conn = null;

        try {

            conn = dbConPool.getConnection("open");

        } catch (Exception ex) {

            Logger.error("", " Exception DB Connection : " + ex.getMessage(), false);

        } finally {

            try {

                if (conn != null) {

                    conn.close();

                    conn = null;
                }

            } catch (Exception ex) {

                Logger.error("", " Exception DB Close Connection : " + ex.getMessage(), false);

            }
            
            dataCenter = null;
            
            dbConPool.releaseConnection("open");
        }

        Logger.debug("", " Configuration Reader started " + webAppPath, false);

        LogRotator.start();

    }

    @Override
    public void contextDestroyed(ServletContextEvent event) {

        Logger.debug("", " ServletContextListener Stopped", false);

        System.out.println("TSG Context stopped");
        // NOOP.
    }

    public static void loadAppConfiguration(ServletContext applicationContext) { // applicationContext

        try {

            Logger.info("", " Load App Configuration ", false);

            // EAI Parameters        
            configList.put("AccountBalance", applicationContext.getInitParameter("AccountBalance"));

            configList.put("LastRechargeDetails", applicationContext.getInitParameter("LastRechargeDetails"));

            configList.put("SoftRefresh", applicationContext.getInitParameter("SoftRefresh"));

            configList.put("HeavyRefresh", applicationContext.getInitParameter("HeavyRefresh"));

            configList.put("ServiceRequestCreation", applicationContext.getInitParameter("ServiceRequestCreation"));

            configList.put("VoucherTopup", applicationContext.getInitParameter("VoucherTopup"));

            configList.put("PayPerView", applicationContext.getInitParameter("PayPerView"));

            configList.put("ChangePackage", applicationContext.getInitParameter("ChangePackage"));

            configList.put("SubscriberIDValidation", applicationContext.getInitParameter("SubscriberIDValidation"));

            configList.put("CreateRelocationWorkOrder", applicationContext.getInitParameter("CreateRelocationWorkOrder"));

            configList.put("CreateCallLog", applicationContext.getInitParameter("CreateCallLog"));

            configList.put("EVDBalance", applicationContext.getInitParameter("EVDBalance"));

            configList.put("CallHistory", applicationContext.getInitParameter("CallHistory"));

            configList.put("EVDRecharge", applicationContext.getInitParameter("EVDRecharge"));

            // PORTAL Parameters

            configList.put("AccountRechargeTopUpPortal", applicationContext.getInitParameter("AccountRechargeTopUpPortal"));

            configList.put("ServiceRequestQueryPortal", applicationContext.getInitParameter("ServiceRequestQueryPortal"));

            configList.put("CreateActivityPortal", applicationContext.getInitParameter("CreateActivityPortal"));

            configList.put("SubscriberValidationPortal", applicationContext.getInitParameter("SubscriberValidationPortal"));

            configList.put("PaymentReceiver", applicationContext.getInitParameter("PaymentReceiver"));

            // ATOM Parameters

            configList.put("PostDetails", applicationContext.getInitParameter("PostDetails"));

            configList.put("GetDetails", applicationContext.getInitParameter("GetDetails"));

            configList.put("TransactionRecharge", applicationContext.getInitParameter("TransactionRecharge"));

        } catch (Exception ex) {

            Logger.error("", " Error reading application configuration>>>>>>>>" + ex.getMessage(), false);

        }

    }

    public static boolean loadInstanceConfiguration(String webApplicationPath) { //webApplicationPath

        Properties configProp = new Properties();

        try {


            String configPath = webApplicationPath + "Resources/config.properties";

            configProp.load(new FileInputStream(configPath));

            Enumeration<?> e = configProp.propertyNames();

            while (e.hasMoreElements()) {

                String key = e.nextElement().toString();

                configList.put(key, configProp.getProperty(key));

            }

            /*//DB CONNECTION POOL

             configList.put("SETMINPOOLSIZE", configProp.getProperty("SETMINPOOLSIZE"));

             configList.put("SETMAXPOOLSIZE", configProp.getProperty("SETMAXPOOLSIZE"));

             //SR TYPE FLAGE

             configList.put("SR_TYPE_FLAGE", configProp.getProperty("SR_TYPE_FLAGE"));

             //Nuance path

             configList.put("NUANCE_URL", configProp.getProperty("NUANCE_URL"));

             //IVR

             configList.put("DEFAULT_LANGUAGE", configProp.getProperty("DEFAULT_LANGUAGE"));

             configList.put("IVR_BYPASS_FLAG", configProp.getProperty("IVR_BYPASS_FLAG"));

             configList.put("PROSPECT_PROMO_FLAG", configProp.getProperty("PROSPECT_PROMO_FLAG"));

             configList.put("PROSPECT_PROMO_DETAIL_FLAG", configProp.getProperty("PROSPECT_PROMO_DETAIL_FLAG"));

             configList.put("NATIONAL_PROMO_FLAG", configProp.getProperty("NATIONAL_PROMO_FLAG"));

             configList.put("BRAND_GREET_FLAG", configProp.getProperty("BRAND_GREET_FLAG"));

             configList.put("SEASONAL_GREET_FLAG", configProp.getProperty("SEASONAL_GREET_FLAG"));

             configList.put("CUSTOM_GREET_FLAG", configProp.getProperty("CUSTOM_GREET_FLAG"));

             configList.put("TRANSFER_ROUTEPOINT", configProp.getProperty("TRANSFER_ROUTEPOINT"));

             configList.put("DATA_CENTER", configProp.getProperty("DATA_CENTER"));

             configList.put("DIRECT_SALES_DNIS", configProp.getProperty("DIRECT_SALES_DNIS"));

             configList.put("AGENT_DNIS", configProp.getProperty("AGENT_DNIS"));
            
             configList.put("DNIS_PRIMARY", configProp.getProperty("DNIS_PRIMARY"));
            
             configList.put("DCVAG_PRIMARY", configProp.getProperty("DCVAG_PRIMARY"));
            
             configList.put("DCVQ_PRIMARY", configProp.getProperty("DCVQ_PRIMARY"));
            
             configList.put("DNIS_SECONDARY", configProp.getProperty("DNIS_SECONDARY"));
            
             configList.put("DCVAG_SECONDARY", configProp.getProperty("DCVAG_SECONDARY"));
            
             configList.put("DCVQ_SECONDARY", configProp.getProperty("DCVQ_SECONDARY"));
            
             // STAT SERVER INFORMATION
            
             configList.put("PR_STAT_SERVER_NAME", configProp.getProperty("PR_STAT_SERVER_NAME"));
            
             configList.put("PR_STAT_SERVER_HOST_NAME", configProp.getProperty("PR_STAT_SERVER_HOST_NAME"));
            
             configList.put("PR_STAT_SERVER_PORT_NUMBER", configProp.getProperty("PR_STAT_SERVER_PORT_NUMBER"));
            
             configList.put("SE_STAT_SERVER_NAME", configProp.getProperty("SE_STAT_SERVER_NAME"));
            
             configList.put("SE_STAT_SERVER_HOST_NAME", configProp.getProperty("SE_STAT_SERVER_HOST_NAME"));
            
             configList.put("SE_STAT_SERVER_PORT_NUMBER", configProp.getProperty("SE_STAT_SERVER_PORT_NUMBER"));
            
             // SERVICE TIME OUT 
            
             configList.put("AccountBalance_Time_out", configProp.getProperty("AccountBalance_Time_out"));
            
             configList.put("CreateRelocationWorkOrder_Time_out", configProp.getProperty("CreateRelocationWorkOrder_Time_out"));
            
             configList.put("EVDRecharge_Time_out", configProp.getProperty("EVDRecharge_Time_out"));
            
             configList.put("ServiceRequestCreation_Time_out", configProp.getProperty("ServiceRequestCreation_Time_out"));
            
             configList.put("SoftRefresh_Time_out", configProp.getProperty("SoftRefresh_Time_out"));
            
             configList.put("SubscriberIDValidation_Time_out", configProp.getProperty("SubscriberIDValidation_Time_out"));
            
             configList.put("VoucherTopup_Time_out", configProp.getProperty("VoucherTopup_Time_out"));
            
             configList.put("CreateActivityPortal_Time_out", configProp.getProperty("CreateActivityPortal_Time_out"));
            
             configList.put("PaymentReceiver_Time_out", configProp.getProperty("PaymentReceiver_Time_out"));
            
             configList.put("ServiceRequestQueryPortal_Time_out", configProp.getProperty("ServiceRequestQueryPortal_Time_out"));
            
             configList.put("SubscriberValidationPortal_Time_out", configProp.getProperty("SubscriberValidationPortal_Time_out"));
                                  
             //File Path

             configList.put("FILE_PATH", configProp.getProperty("FILE_PATH"));

             configList.put("LOG_FILE_PATH", configProp.getProperty("LOG_FILE_PATH"));

             configList.put("LOG_FILE_NAME", configProp.getProperty("LOG_FILE_NAME"));

             //CHECKSUM KEY VALUE

             configList.put("checksumKey", configProp.getProperty("checksumKey"));

             // COMMON

             configList.put("PromptName404", configProp.getProperty("PromptName404"));

             // EAI

             configList.put("accountBalancePromptName102", configProp.getProperty("accountBalancePromptName102"));

             configList.put("accountBalancePromptName200", configProp.getProperty("accountBalancePromptName200"));

             configList.put("accountBalancePromptName300", configProp.getProperty("accountBalancePromptName300"));

             configList.put("lastRechargePromptName700", configProp.getProperty("lastRechargePromptName700"));

             configList.put("lastRechargePromptName701", configProp.getProperty("lastRechargePromptName701"));

             configList.put("lastRechargePromptName702", configProp.getProperty("lastRechargePromptName702"));

             configList.put("softRefreshPromptName700", configProp.getProperty("softRefreshPromptName700"));

             configList.put("softRefreshPromptName701", configProp.getProperty("softRefreshPromptName701"));

             configList.put("softRefreshPromptName702", configProp.getProperty("softRefreshPromptName702"));

             configList.put("serviceRequestCreationPromptName700", configProp.getProperty("serviceRequestCreationPromptName700"));

             configList.put("serviceRequestCreationPromptName701", configProp.getProperty("serviceRequestCreationPromptName701"));

             configList.put("serviceRequestCreationPromptName702", configProp.getProperty("serviceRequestCreationPromptName702"));

             configList.put("voucherTopUpPromptName102", configProp.getProperty("voucherTopUpPromptName102"));

             configList.put("voucherTopUpPromptName200", configProp.getProperty("voucherTopUpPromptName200"));

             configList.put("voucherTopUpPromptName300", configProp.getProperty("voucherTopUpPromptName300"));

             configList.put("voucherTopUpPromptName301", configProp.getProperty("voucherTopUpPromptName301"));

             configList.put("voucherTopUpPromptName697", configProp.getProperty("voucherTopUpPromptName697"));

             configList.put("voucherTopUpPromptName699", configProp.getProperty("voucherTopUpPromptName699"));

             configList.put("voucherTopUpPromptName701", configProp.getProperty("voucherTopUpPromptName701"));

             configList.put("voucherTopUpPromptName702", configProp.getProperty("voucherTopUpPromptName702"));

             configList.put("voucherTopUpPromptName703", configProp.getProperty("voucherTopUpPromptName703"));

             configList.put("voucherTopUpPromptName706", configProp.getProperty("voucherTopUpPromptName706"));

             configList.put("voucherTopUpPromptName707", configProp.getProperty("voucherTopUpPromptName707"));

             configList.put("voucherTopUpPromptName708", configProp.getProperty("voucherTopUpPromptName708"));

             configList.put("voucherTopUpPromptName711", configProp.getProperty("voucherTopUpPromptName711"));

             configList.put("voucherTopUpPromptName712", configProp.getProperty("voucherTopUpPromptName712"));

             configList.put("voucherTopUpPromptName713", configProp.getProperty("voucherTopUpPromptName713"));

             configList.put("voucherTopUpPromptName714", configProp.getProperty("voucherTopUpPromptName714"));

             configList.put("voucherTopUpPromptName715", configProp.getProperty("voucherTopUpPromptName715"));

             configList.put("voucherTopUpPromptName716", configProp.getProperty("voucherTopUpPromptName716"));

             configList.put("voucherTopUpPromptName718", configProp.getProperty("voucherTopUpPromptName718"));

             configList.put("voucherTopUpPromptName719", configProp.getProperty("voucherTopUpPromptName719"));

             configList.put("voucherTopUpPromptName720", configProp.getProperty("voucherTopUpPromptName720"));

             configList.put("voucherTopUpPromptName721", configProp.getProperty("voucherTopUpPromptName721"));

             configList.put("voucherTopUpPromptName722", configProp.getProperty("voucherTopUpPromptName722"));

             configList.put("voucherTopUpPromptName723", configProp.getProperty("voucherTopUpPromptName723"));

             configList.put("voucherTopUpPromptName727", configProp.getProperty("voucherTopUpPromptName727"));

             configList.put("voucherTopUpPromptName728", configProp.getProperty("voucherTopUpPromptName728"));

             configList.put("voucherTopUpPromptName729", configProp.getProperty("voucherTopUpPromptName729"));

             configList.put("voucherTopUpPromptName741", configProp.getProperty("voucherTopUpPromptName741"));

             configList.put("voucherTopUpPromptName742", configProp.getProperty("voucherTopUpPromptName742"));

             configList.put("voucherTopUpPromptName743", configProp.getProperty("voucherTopUpPromptName743"));

             configList.put("SubIdValidationPromptName700", configProp.getProperty("SubIdValidationPromptName700"));

             configList.put("SubIdValidationPromptName701", configProp.getProperty("SubIdValidationPromptName701"));

             configList.put("SubIdValidationPromptName702", configProp.getProperty("SubIdValidationPromptName702"));

             configList.put("createRelocationWOPromptName700", configProp.getProperty("createRelocationWOPromptName700"));

             configList.put("createRelocationWOPromptName701", configProp.getProperty("createRelocationWOPromptName701"));

             configList.put("createRelocationWOPromptName702", configProp.getProperty("createRelocationWOPromptName702"));

             configList.put("createRelocationWOPromptName703", configProp.getProperty("createRelocationWOPromptName703"));

             configList.put("createRelocationWOPromptName704", configProp.getProperty("createRelocationWOPromptName704"));

             configList.put("createRelocationWOPromptName705", configProp.getProperty("createRelocationWOPromptName705"));

             configList.put("createRelocationWOPromptName706", configProp.getProperty("createRelocationWOPromptName706"));

             configList.put("createRelocationWOPromptName707", configProp.getProperty("createRelocationWOPromptName707"));

             //PORTAL

             configList.put("PortalPromptName00", configProp.getProperty("PortalPromptName00"));

             configList.put("PortalPromptName01", configProp.getProperty("PortalPromptName01"));

             configList.put("PortalPromptName05", configProp.getProperty("PortalPromptName05"));

             configList.put("PortalPromptName06", configProp.getProperty("PortalPromptName06"));

             configList.put("PortalPromptName07", configProp.getProperty("PortalPromptName07"));

             configList.put("PortalPromptName99", configProp.getProperty("PortalPromptName99"));

             configList.put("PortalPromptName300", configProp.getProperty("PortalPromptName300"));

             configList.put("PortalPromptName400", configProp.getProperty("PortalPromptName400"));

             configList.put("PortalPromptName405", configProp.getProperty("PortalPromptName405"));

             configList.put("PortalPromptName406", configProp.getProperty("PortalPromptName406"));

             configList.put("PortalPromptName407", configProp.getProperty("PortalPromptName407"));

             configList.put("PortalPromptName408", configProp.getProperty("PortalPromptName408"));

             configList.put("PortalPromptName409", configProp.getProperty("PortalPromptName409"));

             configList.put("PortalPromptName410", configProp.getProperty("PortalPromptName410"));

             configList.put("PortalPromptName412", configProp.getProperty("PortalPromptName412"));

             configList.put("PortalPromptName413", configProp.getProperty("PortalPromptName413"));

             configList.put("PortalPromptName414", configProp.getProperty("PortalPromptName414"));

             configList.put("PortalPromptName415", configProp.getProperty("PortalPromptName415"));

             configList.put("PortalPromptName3000", configProp.getProperty("PortalPromptName3000"));

             configList.put("PortalPromptName3001", configProp.getProperty("PortalPromptName3001"));

             configList.put("PortalPromptName3002", configProp.getProperty("PortalPromptName3002"));

             configList.put("PortalPromptName3003", configProp.getProperty("PortalPromptName3003"));

             configList.put("PortalPromptName3004", configProp.getProperty("PortalPromptName3004"));

             configList.put("PortalPromptName3005", configProp.getProperty("PortalPromptName3005"));*/

            Logger.info("", " Reading the config properties successfully  ", false);

        } catch (IOException ex) {

            System.out.println(" Error Reading application properties........." + ex.getMessage());

            return false;
        }

        return true;
    }
}
