/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tsg.requesthandler;

import com.tsg.common.ConfigurationReader;
import com.tsg.log.Logger;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

/**
 *
 * @author Developer
 */
public class requestDelegator {

    private int connectTimes = 1;

    //private static final long serialVersionUID = 1L;
    public String delegate(String serviceName, String requestXml, String dbCallDetailId) {

        connectTimes = 1;

        String primaryDestinationURL = null;

        String secondayDestinationURL = null;

        HttpURLConnection conn = null;

        String timeOut = "3000";

        String strReturnData = "";

        String enableSecondaryUrl = "N";

        primaryDestinationURL = ConfigurationReader.configList.get(serviceName);

        secondayDestinationURL = ConfigurationReader.configList.get("se_" + serviceName);

        timeOut = ConfigurationReader.configList.get(serviceName + "_Time_out");

        Logger.info(dbCallDetailId, "Service Name=" + serviceName + " DestinationURL " + primaryDestinationURL, false);

        try {

            URL obj = new URL(primaryDestinationURL);

            conn = (HttpURLConnection) obj.openConnection();

            conn.setConnectTimeout(Integer.parseInt(timeOut));

            conn.setDoOutput(true);

            conn.setRequestMethod("POST");

            conn.setReadTimeout(Integer.parseInt(timeOut));

            strReturnData = connectDestinationURL(conn, requestXml, serviceName, dbCallDetailId);

        } catch (IOException ex) {

            Logger.error("", "Exception connecting to destination URL." + ex.getMessage(), false);

        } finally {

            try {
                
                enableSecondaryUrl = ConfigurationReader.configList.get("ENABLE_SECONDARY_URL");

                if (enableSecondaryUrl.equalsIgnoreCase("Y")) {

                    if ((strReturnData.isEmpty()) || (strReturnData == null)) {

                        Logger.error("", "Exception While connecting to Service Name " + serviceName + " Primary destination URL " + primaryDestinationURL + " Count " + connectTimes + " time(s): ", false);

                        connectTimes++;

                        Logger.info(dbCallDetailId, "Service Name=" + serviceName + " Secondary destination URL " + secondayDestinationURL, false);

                        URL obj = new URL(secondayDestinationURL);

                        conn = (HttpURLConnection) obj.openConnection();

                        conn.setConnectTimeout(Integer.parseInt(timeOut));

                        conn.setDoOutput(true);

                        conn.setRequestMethod("POST");

                        conn.setReadTimeout(Integer.parseInt(timeOut));

                        strReturnData = connectDestinationURL(conn, requestXml, serviceName, dbCallDetailId);

                        if ((strReturnData.isEmpty()) || (strReturnData == null)) {

                            Logger.error("", "Exception While connecting to Service Name " + serviceName + " Secondary destination URL " + primaryDestinationURL + " Count " + connectTimes + " time(s): ", false);
                        }
                    }
                }

            } catch (Exception ex) {

                Logger.error("", "Exception connecting to destination URL." + ex.getMessage(), false);

            } finally {

                requestXml = serviceName = dbCallDetailId =  enableSecondaryUrl= null;

                return strReturnData;
            }
        }
    }

    public String connectDestinationURL(HttpURLConnection httpCon, String requestXml, String serviceName, String dbCallDetailId) {

        DataOutputStream dataOutputStream = null;

        try {

            String responseXml = "";

            dataOutputStream = new DataOutputStream(httpCon.getOutputStream());

            dataOutputStream.writeBytes(requestXml);

            dataOutputStream.flush();

            dataOutputStream.close();

            BufferedReader bufferedReader = new BufferedReader(
                    new InputStreamReader(httpCon.getInputStream()));

            String current;

            while ((current = bufferedReader.readLine()) != null) {

                responseXml += current;
            }

            current = null;

            if (serviceName.equalsIgnoreCase("EVDRecharge")) {

                return "<?xml version=\"1.0\" encoding=\"UTF-8\"?><tata-sky><evd-recharge-response><error-code>200</error-code></evd-recharge-response></tata-sky>";

            } else {

                return responseXml;

            }

        } catch (IOException ex) {

            Logger.error(dbCallDetailId, "Exception While " + serviceName + " : " + ex.getMessage(), false);

            return "";

        } finally {

            try {

                dataOutputStream.close();

            } catch (IOException ex) {

                Logger.error(dbCallDetailId, "Exception While " + serviceName + " : " + ex.getMessage(), false);

            } finally {

                dbCallDetailId = requestXml = serviceName = null;

            }

        }
    }
}
//    public String delegate(String serviceName, String requestXml) {
//        URL url = null;
//        URLConnection urlConnection = null;
//        OutputStream outStream = null;
//        InputStream inStream = null;
//        byte[] bytes = null;
//        String responseMsg = null;
//        String strDestinationURL = "";
//        strDestinationURL = ConfigurationReader.configList.get(serviceName);
//        log.info("Service Name=" + serviceName + " Request XML  " + requestXml + " DestinationURL " + strDestinationURL);
//        System.out.println("Service Name=" + serviceName + " Request XML  " + requestXml + " DestinationURL " + strDestinationURL);
//        try {
//            url = new URL(strDestinationURL);
//            urlConnection = url.openConnection();
////            urlConnection.setRequestProperty("Content-type", "application/x-www-form-urlencoded");
//            urlConnection.setConnectTimeout(60000);
//            urlConnection.setDoOutput(true);
//            urlConnection.setDoInput(true);
//            urlConnection.setReadTimeout(60000);
//            outStream = urlConnection.getOutputStream();
//            outStream.write(requestXml.getBytes());
//            outStream.flush();
//            inStream = urlConnection.getInputStream();
//            bytes = new byte[inStream.available()];
//            inStream.read(bytes);
//            responseMsg = new String(bytes);
//        } catch (ConnectException cex) {
//            log.error("Exception connecting to Primary destination URL." + cex.getMessage());
//        } catch (IOException ioex) {
//            log.error("Exception connecting to Primary destination URL." + ioex.getMessage());
//            //ex.printStackTrace();
//        } catch (Exception ex) {
//            log.error("Exception connecting to Primary destination URL." + ex.getMessage());
//        } finally {
//            try {
//                if (bytes != null) {
//                    bytes = null;
//                }
//                if (inStream != null) {
//                    inStream.close();
//                    inStream = null;
//                }
//                if (outStream != null) {
//                    outStream.close();
//                    outStream = null;
//                }
//                if (urlConnection != null) {
//                    urlConnection = null;
//                }
//                if (url != null) {
//                    url = null;
//                }
//            } catch (Exception ex) {
//                //Logger.error(Configuration.APPLICATION_NAME, "Exception in clean up sender resources: " + ex.getMessage(), Configuration.SHOW_CONSOLE);
//            }
//
//            strDestinationURL = requestXml = null;
//        }
//        return responseMsg;
//    }
//}
