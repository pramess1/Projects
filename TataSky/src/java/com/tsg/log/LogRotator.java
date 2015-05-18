/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tsg.log;

import com.tsg.config.Configuration;
import com.tsg.util.Util;
import java.util.Timer;
import java.util.TimerTask;

/**
 *
 * @author Rajesh
 */
public class LogRotator {
    
private static Timer timer = null;
    private static boolean startRotator = false;

    public static void start() {

        stop();
        Logger.info("", "Log Rotate timer start...", true);

        timer = new Timer();
        timer.scheduleAtFixedRate(new TimerTask() {

            public void run() {

                String hour = Util.getCurrentDateAnyFormat("HHa");

                if (hour.equals(Configuration.LOG_ROTATOR_TIME)) {

                    if (startRotator) {
                        Logger.setLogFilePath();
                        Logger.setLogFileErrorPath();
                        Logger.info("", "Log Rotator is successfully change the log file...", true);
                    } else {
                        stop();
                        startRotator = true;
                        Configuration.LOG_ROTATOR_INTERVAL = (1000 * 60 * 60 * 24);
                        start();
                        Logger.info("", "Log Rotate timer to start the service now.", true);
                    }

                } else {

                    Logger.info("", "Log Rotate timer is waiting to start the service at 12 AM", true);

                }

                hour = null;

            }
        }, (1000 * 60 * 1 * 1), Configuration.LOG_ROTATOR_INTERVAL); // three minutes delay

    }

    public static void stop() {
        if (timer != null) {
            Logger.info("", "Log Rotate timer stop...", true);
            startRotator = false;
            timer.cancel();
            timer.purge();
            timer = null;
        } else {
//            Logger.info("COMMON API", "Log Rotate timer already stop...", true);
        }
    }
}