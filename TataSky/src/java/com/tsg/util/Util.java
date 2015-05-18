/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tsg.util;

import com.tsg.common.ConfigurationReader;
import java.io.File;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.TimeUnit;
import java.util.zip.CRC32;

/**
 *
 * @author Rajesh
 */
public class Util {

    /**
     * <b>Description:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * Get the current date with the standard format of yyyy-MM-dd
     * <br><br><b>Example:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * return 2012-04-30
     * <br><br><b>Returns:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * Current date for string format
     */
    public static String getCurrentDate() {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();
        String value = dateFormat.format(date);
        date = null;
        dateFormat = null;
        Set s = new TreeSet();
        return value;
    }

    /**
     * <b>Description:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * Get the current time with the standard format of hh:mm:ss
     * <br><br><b>Example:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * return 10:25:35
     * <br><br><b>Returns:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * Current date for string format
     */
    public static String getCurrentTime() {
        SimpleDateFormat dateFormat = new SimpleDateFormat("hh:mm:ss");
        Date date = new Date();
        String value = dateFormat.format(date);
        date = null;
        dateFormat = null;
        return value;
    }

    public static String getCurrentTime1() {
        SimpleDateFormat dateFormat = new SimpleDateFormat("HHmmss");
        Date date = new Date();
        String value = dateFormat.format(date);
        date = null;
        dateFormat = null;
        return value;
    }

    /**
     * <b>Description:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * Get the current date and time with the standard format of yyyy-MM-dd
     * hh:mm:ss
     * <br><br><b>Example:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * return 2012-04-30 10:30:00
     * <br><br><b>Returns:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * Current date and time for string format
     */
    public static String getCurrentDateTime() {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
        Date date = new Date();
        String value = dateFormat.format(date) + 1;
        date = null;
        dateFormat = null;
        return value;
    }

    /**
     * <b>Description:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * Get the current date, time and AM with the standard format of yyyy-MM-dd
     * hh:mm:ss a
     * <br><br><b>Example:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * return 2012-04-30 10:30:00 AM
     * <br><br><b>Returns:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * Current date, time and AM for string format
     */
    public static String getCurrentDateTimeAM() {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss a");
        Date date = new Date();
        String value = dateFormat.format(date);
        date = null;
        dateFormat = null;
        return value;
    }

    /**
     * <b>Description:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * Get the current date, time and timezone with the standard format of
     * yyyy-MM-dd hh:mm:ss z
     * <br><br><b>Example:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * return 2012-04-30 10:30:00 IST
     * <br><br><b>Returns:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * Current date, time and timezone for string format
     */
    public static String getCurrentDateTimeTimezone() {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss z");
        Date date = new Date();
        String value = dateFormat.format(date);
        date = null;
        dateFormat = null;
        return value;
    }

    /**
     * <b>Description:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * Get the current date, time, AM and timezone with the standard format of
     * yyyy-MM-dd hh:mm:ss a z
     * <br><br><b>Example:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * return 2012-04-30 10:30:00 AM IST
     * <br><br><b>Returns:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * Current date, time, AM and timezone for string format
     */
    public static String getCurrentDateTimeAMTimezone() {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss a z");
        Date date = new Date();
        String value = dateFormat.format(date);
        date = null;
        dateFormat = null;
        return value;
    }

    /**
     * <b>Description:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * Get the current date for your required any format
     * <br><br><b>Example:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * getCurrentDateAnyFormat(MMM dd, yyyy
     * hh:mm:ss)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * return Apr 30, 2012 10:30:00
     * <br><br><b>Parameters:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * format - Your required format
     * <br><br><b>Returns:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * Current date for string format
     */
    public static String getCurrentDateAnyFormat(String format) {
        SimpleDateFormat dateFormat = new SimpleDateFormat(format);
        Date date = new Date();
        format = dateFormat.format(date);
        date = null;
        dateFormat = null;
        return format;
    }

    /**
     * <b>Description:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * Get the exist date with the standard format of yyyy-MM-dd
     * <br><br><b>Example:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * getExistDate(3)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * return 2012-04-27
     * <br><br><b>Parameters:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * days - Your required previous date of number like yesterday as 1
     * <br><br><b>Returns:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * Exist date for string format
     */
    public static String getExistDate(int days) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DATE, -days);
        String value = dateFormat.format(cal.getTime());
        cal = null;
        dateFormat = null;
        return value;
    }

    /**
     * <b>Description:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * Get the exist date and time with the standard format of yyyy-MM-dd
     * hh:mm:ss
     * <br><br><b>Example:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * getExistDateTime(3)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * return 2012-04-27 10:30:00
     * <br><br><b>Parameters:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * days - Your required previous date of number like yesterday as 1
     * <br><br><b>Returns:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * Exist date and time for string format
     */
    public static String getExistDateTime(int days) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DATE, -days);
        String value = dateFormat.format(cal.getTime());
        cal = null;
        dateFormat = null;
        return value;
    }

    /**
     * <b>Description:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * Get the exist date, time and AM with the standard format of yyyy-MM-dd
     * hh:mm:ss a
     * <br><br><b>Example:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * getExistDateTimeAM(3)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * return 2012-04-27 10:30:00 AM
     * <br><br><b>Parameters:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * days - Your required previous date of number like yesterday as 1
     * <br><br><b>Returns:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * Exist date, time and AM for string format
     */
    public static String getExistDateTimeAM(int days) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss a");
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DATE, -days);
        String value = dateFormat.format(cal.getTime());
        cal = null;
        dateFormat = null;
        return value;
    }

    /**
     * <b>Description:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * Get the exist date, time and timezone with the standard format of
     * yyyy-MM-dd hh:mm:ss z
     * <br><br><b>Example:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * getExistDateTimeTimezone(3)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * return 2012-04-27 10:30:00 IST
     * <br><br><b>Parameters:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * days - Your required previous date of number like yesterday as 1
     * <br><br><b>Returns:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * Exist date, time and timezone for string format
     */
    public static String getExistDateTimeTimezone(int days) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss z");
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DATE, -days);
        String value = dateFormat.format(cal.getTime());
        cal = null;
        dateFormat = null;
        return value;
    }

    /**
     * <b>Description:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * Get the exist date, time, AM and timezone with the standard format of
     * yyyy-MM-dd hh:mm:ss a z
     * <br><br><b>Example:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * getExistDateTimeAMTimezone(3)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * return 2012-04-27 10:30:00 AM IST
     * <br><br><b>Parameters:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * days - Your required previous date of number like yesterday as 1
     * <br><br><b>Returns:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * Exist date, time, AM and timezone for string format
     */
    public static String getExistDateTimeAMTimezone(int days) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss a z");
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DATE, -days);
        String value = dateFormat.format(cal.getTime());
        cal = null;
        dateFormat = null;
        return value;
    }

    /**
     * <b>Description:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * Get the exist date for your required any format
     * <br><br><b>Example:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * getExistDateAnyFormat(MMM dd, yyyy hh:mm:ss,
     * 3)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return
     * Apr 27, 2012 10:30:00
     * <br><br><b>Parameters:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * format - Your required
     * format<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * days - Your required previous date of number like yesterday as 1
     * <br><br><b>Returns:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * Exist date for string format
     */
    public static String getExistDateAnyFormat(String format, int days) {
        SimpleDateFormat dateFormat = new SimpleDateFormat(format);
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DATE, -days);
        format = dateFormat.format(cal.getTime());
        cal = null;
        dateFormat = null;
        return format;
    }

    public static String getFutureDateTime(int days) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DATE, days);
        String date = dateFormat.format(cal.getTime());
        cal = null;
        dateFormat = null;
        return date;
    }

    /**
     * <b>Description:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * The input date convert to any date format
     * <br><br><b>Example:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * convertTimezone(31/03/2012, dd/MM/yyyy, yyyy-MM-dd hh:mm:ss
     * z)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return
     * 2012-03-31 12:00:00 IST
     * <br><br><b>Parameters:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * inputDate - Input
     * Date<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * inputFormat - Input Date
     * Format<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * outputFormat - Output Date Format
     * <br><br><b>Returns:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * Converted date for String format
     */
    public static String convertDateToAnyFormat(String inputDate, String inputFormat, String outputFormat) {
        String convertDate = null;
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat(inputFormat);
            Date date = dateFormat.parse(inputDate);
            dateFormat = new SimpleDateFormat(outputFormat);
            convertDate = dateFormat.format(date);
            date = null;
            dateFormat = null;
        } catch (Exception ex) {
        }
        inputDate = inputFormat = outputFormat = null;
        return convertDate;
    }

    public static String convertDateToAnyFormat(String inputDate) {
        String convertDate = null;
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy hh:mm:ss");
            Date date = dateFormat.parse(inputDate);
            dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            convertDate = dateFormat.format(date);
            date = null;
            dateFormat = null;
        } catch (Exception ex) {
        }
        inputDate = null;
        return convertDate;
    }

    /**
     * <b>Description:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * The input timezone convert to server timezone with format of yyyy-MM-dd
     * hh:mm:ss z
     * <br><br><b>Example:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * convertTimezone(2012-03-30 10:30:00
     * PST)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * return 2012-03-31 12:00:00 IST
     * <br><br><b>Parameters:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * date - Date
     * <br><br><b>Returns:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * Converted date for String format
     */
    public static String convertTimezone(String date) {
        String convertDate = null;
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss z");
            Date dat = dateFormat.parse(date);
            convertDate = dateFormat.format(dat);
            dat = null;
            dateFormat = null;
        } catch (Exception ex) {
        }
        date = null;
        return convertDate;
    }

    /**
     * <b>Description:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * The input timezone convert to your required timezone with format of
     * yyyy-MM-dd hh:mm:ss z
     * <br><br><b>Example:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * convertTimezone(2012-03-30 10:30:00 PST,
     * IST)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * return 2012-03-31 12:00:00 IST
     * <br><br><b>Parameters:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * date -
     * Date<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * timezone - Convert Timezone format
     * <br><br><b>Returns:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * Converted date for String format
     */
    public static String convertTimezone(String date, String timezone) {
        String convertDate = null;
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss z");
            Date dat = dateFormat.parse(date);
            dateFormat.setTimeZone(TimeZone.getTimeZone(timezone));
            convertDate = dateFormat.format(dat);
            dat = null;
            dateFormat = null;
        } catch (Exception ex) {
        }
        date = timezone = null;
        return convertDate;
    }

    /**
     * <b>Description:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * The input timezone convert to your required timezone with any format
     * <br><br><b>Example:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * convertTimezone(Mar 30, 2012 10:30:00 PST, MMM dd, yyyy hh:mm:ss z,
     * IST)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * return Mar 31, 2012 12:00:00 IST
     * <br><br><b>Parameters:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * date -
     * Date<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * format - Date
     * format<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * timezone - Convert Timezone format
     * <br><br><b>Returns:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * Converted date for String format
     */
    public static String convertTimezone(String date, String format, String timezone) {
        String convertDate = null;
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat(format);
            Date dat = dateFormat.parse(date);
            dateFormat.setTimeZone(TimeZone.getTimeZone(timezone));
            convertDate = dateFormat.format(dat);
            dateFormat = null;
            dat = null;
        } catch (Exception ex) {
        }
        date = format = timezone = null;
        return convertDate;
    }

    /**
     * <b>Description:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * Get the time difference from input start date to server current date with
     * input format of yyyy-MM-dd hh:mm:ss z
     * <br><br><b>Example:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * getDateDifference(2012-04-30 10:30:00
     * IST)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * return 1 hour(s)
     * <br><br><b>Parameters:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * startDate - Start date
     * <br><br><b>Returns:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * Time difference for String format
     */
    public static String getDateDifference(String startDate) {
        String difference = null;
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss z");
            Date sDate = dateFormat.parse(startDate);
            Date eDate = new Date();
            difference = getDateDifference(eDate.getTime() - sDate.getTime());
            dateFormat = null;
            sDate = eDate = null;
        } catch (Exception ex) {
        }
        startDate = null;
        return difference;
    }

    /**
     * <b>Description:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * Get the time difference from input start date to input end date with
     * input format of yyyy-MM-dd hh:mm:ss z
     * <br><br><b>Example:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * getDateDifference(2012-04-29 10:30:00 IST, 2012-04-30 11:30:00
     * IST)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * return 1 day(s)
     * <br><br><b>Parameters:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * startDate - Start
     * date<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * endDate - End date
     * <br><br><b>Returns:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * Time difference for String format
     */
    public static String getDateDifference(String startDate, String endDate) {
        String difference = null;
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss z");
            Date sDate = dateFormat.parse(startDate);
            Date eDate = dateFormat.parse(endDate);
            difference = getDateDifference(eDate.getTime() - sDate.getTime());
            dateFormat = null;
            sDate = eDate = null;
        } catch (Exception ex) {
        }
        startDate = endDate = null;
        return difference;
    }

    /**
     * <b>Description:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * Get the time difference from input start date to input end date with any
     * input format
     * <br><br><b>Example:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * getDateDifference(Apr 30, 2012 08:30:00 IST, Apr 30, 2012 11:30:00 IST,
     * MMM dd, yyyy hh:mm:ss
     * z)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return
     * 3 hour(s)
     * <br><br><b>Parameters:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * startDate - Start
     * date<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * endDate - End
     * date<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; date
     * -Format Input date format
     * <br><br><b>Returns:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * Time difference for String format
     */
    public static String getDateDifference(String startDate, String endDate, String dateFormat) {
        String difference = null;
        try {
            SimpleDateFormat dFormat = new SimpleDateFormat(dateFormat);
            Date sDate = dFormat.parse(startDate);
            Date eDate = dFormat.parse(endDate);
            difference = getDateDifference(eDate.getTime() - sDate.getTime());
            dFormat = null;
            sDate = eDate = null;
        } catch (Exception ex) {
        }
        startDate = endDate = dateFormat = null;

        return difference;
    }

    /**
     * <b>Description:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * Get the time difference for input time in milliSeconds
     * <br><br><b>Example:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * getDateDifference(10800000)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * return 3 hour(s)
     * <br><br><b>Parameters:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * milliSeconds - Time in milliSeconds
     * <br><br><b>Returns:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * Time difference for String format
     */
    public static String getDateDifference(long milliSeconds) {
        long days = TimeUnit.MILLISECONDS.toDays(milliSeconds);
        long hours = TimeUnit.MILLISECONDS.toHours(milliSeconds);
        long minutes = TimeUnit.MILLISECONDS.toMinutes(milliSeconds);
        String difference = "";
        if (days != 0) {
            difference = days + " day(s)";
        } else if (hours != 0) {
            difference = hours + " hour(s)";
        } else if (minutes != 0) {
            difference = minutes + " minute(s)";
        } else {
            difference = "1 minute";
        }
        return difference;
    }

    /**
     * <b>Description:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * Get the file name with datetime included
     * <br><br><b>Example:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * getFileNameWithDateAndTime(thai_billing)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * return thai_billing_2012-04-30-11-58-09
     * <br><br><b>Parameters:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * fileName - Log file name
     * <br><br><b>Returns:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     * Log file name for string format
     */
    public static String getFileNameWithDateAndTime(String fileName) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss");
        Date date = new Date();
        fileName += "_" + dateFormat.format(date);
        date = null;
        dateFormat = null;
        return fileName;
    }

    public static String validateChecksum(String checkSumValue, String checkSumKey) {
        String checkSum = null;
        CRC32 crc32 = new CRC32();
        try {
            System.out.println(" checkSumValue " + checkSumValue + " checkSumKey " + checkSumKey);
            checkSumValue = checkSumValue + "~" + checkSumKey;
            crc32.update(checkSumValue.getBytes());
            checkSum = String.valueOf(crc32.getValue());
            System.out.println(" checkSum " + checkSum);
        } catch (Exception exception) {
            System.out.println("The requested algorithm was not found" + exception.getMessage());
        } finally {
            return checkSum;
        }
    }

    public static String getOneDaysAfter() {
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DATE, 1);
        DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy hh:mm:ss");
        return dateFormat.format(cal.getTime());
    }

    public String srTypeFlage(String srType) {
        boolean srTypeFlage = false;
        String srTypeFlage1 = "N";
        String msgTokens[] = ConfigurationReader.configList.get("SR_TYPE_FLAGE").split(",");
        for (int i = 0; i < msgTokens.length; i++) {
            srTypeFlage = srType.toUpperCase().equalsIgnoreCase(msgTokens[i].toUpperCase().trim());
            if (srTypeFlage) {
                srTypeFlage1 = "Y";
                break;
            }
        }
        srType = null;
        return srTypeFlage1.trim();
    }

//    public static boolean createDirectory() {
//
//        File file = new File(ConfigurationReader.configList.get("LOG_FILE_PATH") + getCurrentDate());
//        if (file.mkdir()) {
//            file = null;
//            return true;
//        }
//        file = null;
//
//
//        return false;
//    }
//    public static boolean createDirectories() {
//
//        File file = new File(ConfigurationReader.configList.get("LOG_FILE_PATH") + getCurrentDate());
//        if (file.mkdirs()) {
//            file = null;
//            return true;
//        }
//        file = null;
//
//        return false;
//    }
//
//    public static boolean isDirectoryAvailable(String userLocation) {
//
//        File file = new File(Configuration.HOME_LOCATION + userLocation);
//        if (file.exists()) {
//            file = null;
//            userLocation = null;
//            return true;
//        }
//        file = null;
//        userLocation = null;
//
//        return false;
//    }
    /* create directory if not present and return its name */
    public static String getTodayDirectoryName(String path) {

        String filePath = path + Util.getCurrentDateAnyFormat("YYYY-MM-dd") + "/";

        File file = new File(filePath);

        if (!file.exists()) {

            file.mkdirs();
        }

        path = null;

        return filePath;
    }

    /* create directory if not present and return its name */
    public static String getDirectoryName(String path) {

        String filePath = path;

        File file = new File(filePath);

        if (!file.exists()) {

            file.mkdirs();
        }

        path = null;

        return filePath;
    }

    public static String getDateDifferenceInHours(String startDate, String endDate, String dateFormat) {

        String difference = null;

        try {

            SimpleDateFormat dFormat = new SimpleDateFormat(dateFormat);

            Date sDate = dFormat.parse(startDate);

            Date eDate = dFormat.parse(endDate);

            difference = getDifferenceinHours(eDate.getTime() - sDate.getTime());

            dFormat = null;

            sDate = eDate = null;

        } catch (Exception ex) {
        }

        startDate = endDate = dateFormat = null;

        return difference;
    }

    public static String getDifferenceinHours(long milliSeconds) {

        long hours = TimeUnit.MILLISECONDS.toHours(milliSeconds);

        String difference = "";

        if (hours != 0) {

            difference = hours + "";

        } else {

            difference = "0";

        }

        return difference;

    }
}
