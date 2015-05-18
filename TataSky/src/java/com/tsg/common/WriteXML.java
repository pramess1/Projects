/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tsg.common;

import com.tsg.log.Logger;
import com.tsg.util.Util;
import java.io.BufferedWriter;
import java.io.FileWriter;

/**
 *
 * @author Rajesh
 */
public class WriteXML {

    String line;

    public void writeTextFile(String xml, String dbCallDetailId) {


        try {
            // Create file 

            String filePath = Util.getDirectoryName(ConfigurationReader.configList.get("FILE_PATH")) + "LZ_CallFlowDetailXML_" + dbCallDetailId + ".txt";

            FileWriter fstream = new FileWriter(filePath);

            BufferedWriter out = new BufferedWriter(fstream);

            out.write(xml);

            //Close the output stream

            out.close();

            fstream.close();

            Logger.info(dbCallDetailId, " Call Flow Detail XML Successfully Written to File : " + dbCallDetailId, false);

        } catch (Exception ex) {//Catch exception if any

            Logger.error(dbCallDetailId, " Exception in writeTextFile  Page : " + ex.getMessage(), false);

        } finally {

            xml = dbCallDetailId = null;

        }

    }
}
