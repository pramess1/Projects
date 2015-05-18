/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tsg.log;

import com.tsg.common.ConfigurationReader;
import com.tsg.util.Util;
import java.io.FileOutputStream;
import java.io.PrintStream;
import java.nio.channels.FileChannel;

/**
 * @author rajesh<br> Description: This class is used to store log information
 * and print console your data
 */
public class Logger {

    private static String logFilePath = null;
    private static String logFileErrorPath = null;
    private static Boolean createNewFile = true;
    private static Boolean createNewErrorFile = true;
    public static long limit = 1024, logFileSize = 10240, temp = 0;
    public static FileChannel fileChannel;

    /**
     * <b>Description:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * Write your information into a log file and also may print in console
     * <br><br><b>Parameters:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * sessionID - User ID or Project name like
     * that<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * content - Write the log file
     * content<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * console - If the content print in console
     */
    public static void info(String callDetailID, String logMessage, boolean showConsole) {
        if (showConsole) {
            System.out.println("[" + Util.getCurrentTime() + "] " + logMessage);
        }
        writeLog(callDetailID, "INFO", logMessage);
        callDetailID = logMessage = null;
    }

    /**
     * <b>Description:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * Write your waring information into a log file and also may print in
     * console
     * <br><br><b>Parameters:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * sessionID - User ID or Project name like
     * that<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * content - Write the log file
     * content<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * console - If the content print in console
     */
    public static void warn(String callDetailId, String logMessage, boolean showConsole) {

        String warnLogFlag = ConfigurationReader.configList.get("WARN_LOG_FLAG");
        if (warnLogFlag.equalsIgnoreCase("Y")) {
            if (showConsole) {
                System.out.println("[" + Util.getCurrentTime() + "] " + logMessage);
            }
            writeLog(callDetailId, "WARN", logMessage);
        }
        callDetailId = logMessage = warnLogFlag = null;
    }

    public static void debug(String callDetailId, String logMessage, boolean showConsole) {

        String debugLogFlag = ConfigurationReader.configList.get("DEBUG_LOG_FLAG");

        if (debugLogFlag.equalsIgnoreCase("Y")) {
            if (showConsole) {
                System.out.println("[" + Util.getCurrentTime() + "] " + logMessage);
            }
            writeLog(callDetailId, "DEBUG", logMessage);
        }
        callDetailId = logMessage = debugLogFlag = null;
    }

    /**
     * <b>Description:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * Write your Error or Exception into a log file and also may print in
     * console
     * <br><br><b>Parameters:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * sessionID - User ID or Project name like
     * that<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * content - Write the log file
     * content<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * console - If the content print in console
     */
    public static void error(String callDetailId, String logMessage, boolean showConsole) {
        if (showConsole) {
            System.out.println("[" + Util.getCurrentTime() + "] " + logMessage);
        }
        writeLog(callDetailId, "ERROR", logMessage);
        writeErrorLog(callDetailId, "ERROR", logMessage);
        callDetailId = logMessage = null;
    }

    /**
     * <b>Description:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * Write your content into a log file
     * <br><br><b>Parameters:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * sessionID - User ID or Project name like
     * that<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; type
     * - What type of content
     * this<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * content - Write the log file content
     */
    private static synchronized void writeLog(String callDetailId, String messageType, String logMessage) {
        try {
            logFileSize = Long.parseLong(ConfigurationReader.configList.get("LOG_FILE_SIZE"));
            FileOutputStream fos = new FileOutputStream(getLogFilePath(), true);
            PrintStream ps = new PrintStream(fos);
            fileChannel = fos.getChannel();
            ps.println("[" + Util.getCurrentDateTime() + "] [callDetailId: " + callDetailId + "] " + messageType + ": " + logMessage);
            ps.println();
            temp = fileChannel.size() / limit;
            createNewFile = false;
            if (temp > logFileSize) {
                createNewFile = true;
            }
            ps.close();
            fos.close();
            ps = null;
            fos = null;
        } catch (Exception ex) {
            System.out.println("Exception in writing log file: " + ex.getMessage() + " and Log message: " + logMessage);
        }
        callDetailId = messageType = logMessage = null;
    }
    
    private static synchronized void writeErrorLog(String callDetailId, String messageType, String logMessage) {
        try {
            logFileSize = Long.parseLong(ConfigurationReader.configList.get("LOG_FILE_SIZE"));
            FileOutputStream fos = new FileOutputStream(getLogFileErrorPath(), true);
            PrintStream ps = new PrintStream(fos);
            fileChannel = fos.getChannel();
            ps.println("[" + Util.getCurrentDateTime() + "] [callDetailId: " + callDetailId + "] " + messageType + ": " + logMessage);
            ps.println();
            temp = fileChannel.size() / limit; 
            createNewFile = false;
            if (temp > logFileSize) {
                createNewFile = true;
            }
            ps.close();
            fos.close();
            ps = null;
            fos = null;
        } catch (Exception ex) {
            System.out.println("Exception in writing log file: " + ex.getMessage() + " and Log message: " + logMessage);
        }
        callDetailId = messageType = logMessage = null;
    }

    /**
     * <b>Description:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * Print your content in console
     * <br><br><b>Parameters:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * content - Print the console content
     */
    public static void console(String printMessage) {
        System.out.println("[" + Util.getCurrentTime() + "] " + printMessage);
        printMessage = null;
    }

    /**
     * <b>Description:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * Get the log file path
     */
    public static String getLogFilePath() {
        try {

            if (createNewFile == true) {

                logFilePath = Util.getFileNameWithDateAndTime(Util.getTodayDirectoryName(ConfigurationReader.configList.get("LOG_FILE_PATH")) + ConfigurationReader.configList.get("LOG_FILE_NAME")) + ".log";

                createNewFile = false;
            }

            if (logFilePath == null) {

                logFilePath = Util.getFileNameWithDateAndTime(Util.getTodayDirectoryName(ConfigurationReader.configList.get("LOG_FILE_PATH")) + ConfigurationReader.configList.get("LOG_FILE_NAME")) + ".log";
            }

        } catch (Exception ex) {

            System.out.println(" Exception in getLogFilePath : " + ex.getMessage());
        }
        return logFilePath;
    }

    public static void setLogFilePath() {
        logFilePath = Util.getFileNameWithDateAndTime(Util.getTodayDirectoryName(ConfigurationReader.configList.get("LOG_FILE_PATH")) + ConfigurationReader.configList.get("LOG_FILE_NAME")) + ".log";

    }
    
    public static String getLogFileErrorPath() {
        try {

            if (createNewErrorFile == true) {

                logFileErrorPath = Util.getFileNameWithDateAndTime(Util.getTodayDirectoryName(ConfigurationReader.configList.get("ERROR_LOG_FILE_PATH")) + ConfigurationReader.configList.get("ERROR_LOG_FILE_NAME")) + ".log";

                createNewErrorFile = false;
            }

            if (logFileErrorPath == null) {

                logFileErrorPath = Util.getFileNameWithDateAndTime(Util.getTodayDirectoryName(ConfigurationReader.configList.get("ERROR_LOG_FILE_PATH")) + ConfigurationReader.configList.get("ERROR_LOG_FILE_NAME")) + ".log";
            }

        } catch (Exception ex) {

            System.out.println(" Exception in getLogFilePath : " + ex.getMessage());
        }
        return logFileErrorPath;
    }

    public static void setLogFileErrorPath() {
        
        logFileErrorPath = Util.getFileNameWithDateAndTime(Util.getTodayDirectoryName(ConfigurationReader.configList.get("ERROR_LOG_FILE_PATH")) + ConfigurationReader.configList.get("ERROR_LOG_FILE_NAME")) + ".log";
        
    }
}