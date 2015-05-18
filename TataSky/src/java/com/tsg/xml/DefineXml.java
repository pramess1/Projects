/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tsg.xml;

import javax.xml.parsers.*;
import org.w3c.dom.*;
import java.io.*;

/**
 *
 * @author Rajesh
 */
public class DefineXml {

    String stringVersionXML = "";
    File filePath_Here;
    DocumentBuilderFactory factory;
    DocumentBuilder documentBuilder;
    Document document;
    XmlUtil xmlUtil;

    public DefineXml() {
    }

    public XmlUtil getStringVersion(String xml) {
        try {
            getFactory();
            if (getDocument(xml)) {
                xmlUtil = new XmlUtil(document);
            } else {
                return null;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return xmlUtil;
    }

    public XmlUtil getFileVersion(File file_From) {
        try {
            getFactory();
            if (getDocument(file_From)) {
                xmlUtil = new XmlUtil(document);
            } else {
                return null;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            //otherUtil_Here.getException(ex);
        }
        return xmlUtil;
    }

    public void getFactory() {
        try {
            factory = DocumentBuilderFactory.newInstance();
            factory.setValidating(false);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public boolean getDocument(File from) {
        try {
            documentBuilder = factory.newDocumentBuilder();
            document = documentBuilder.parse(from);
            if (document == null) {
                return false;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return true;
    }

    public boolean getDocument(String xml_From) {

        try {

            documentBuilder = factory.newDocumentBuilder();

            document = documentBuilder.parse(new ByteArrayInputStream(xml_From.getBytes()));

            if (document == null) {
                return false;
            }

        } catch (Exception ex) {

            ex.printStackTrace();

        }

        return true;
    }
}
