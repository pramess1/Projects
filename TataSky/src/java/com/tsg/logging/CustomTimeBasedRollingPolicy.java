/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tsg.logging;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.apache.log4j.rolling.RollingPolicy;
import org.apache.log4j.rolling.RolloverDescription;
import org.apache.log4j.rolling.TimeBasedRollingPolicy;

/**
 * Same as org.apache.log4j.rolling.TimeBasedRollingPolicy but acts only as
 * RollingPolicy and NOT as TriggeringPolicy.
 *
 * This allows us to combine this class with a size-based triggering policy
 * (decision to roll based on size, name of rolled files based on time)
 *
 */
public class CustomTimeBasedRollingPolicy implements RollingPolicy {
    //Logger log  = LogManager.getLogger(CustomTimeBasedRollingPolicy.class.getName());

    TimeBasedRollingPolicy timeBasedRollingPolicy = new TimeBasedRollingPolicy();

    /**
     * Set file name pattern.
     *
     * @param fnp file name pattern.
     */
    public void setFileNamePattern(String fnp) {
//log.debug("Query= selecttttttttttttttttttttttttttttttttt");
        timeBasedRollingPolicy.setFileNamePattern(fnp);
    }
    /*
     public void setActiveFileName(String fnp) {
     timeBasedRollingPolicy.setActiveFileName(fnp);
     }*/

    /**
     * Get file name pattern.
     *
     * @return file name pattern.
     */
    public String getFileNamePattern() {
        return timeBasedRollingPolicy.getFileNamePattern();
    }

    public RolloverDescription initialize(String file, boolean append) throws SecurityException {
        return timeBasedRollingPolicy.initialize(file, append);
    }

    public RolloverDescription rollover(String activeFile) throws SecurityException {
        return timeBasedRollingPolicy.rollover(activeFile);
    }

    public void activateOptions() {
        timeBasedRollingPolicy.activateOptions();
    }
}