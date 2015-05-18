/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tsg.xml;

import java.util.Vector;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

/**
 *
 * @author Rajesh
 */
public class XmlUtil {

    NodeList children;
    Element root_Here;
    Document document_Here;

    public XmlUtil(Document document) {
        document_Here = document;
        getNodeList();
    }

    public void getNodeList() {
        root_Here = getRoot();
        if (root_Here == null) {
            return;
        }
        children = root_Here.getChildNodes();
    }

    public Element getRoot() {
        if (document_Here.getDocumentElement() == null) {
            return null;
        }
        return document_Here.getDocumentElement();
    }

    public int getNumberOfNodes() {
        return children.getLength();
    }

    public Node getNode(int nodeValue) {
        return children.item(nodeValue);
    }

    public Vector getElementNodeList() {
        Vector numberOfNodes = new Vector();
        for (int ia = 0; ia < getNumberOfNodes(); ia++) {
            Node node_Here = children.item(ia);
            if (node_Here.getNodeType() == node_Here.ELEMENT_NODE) {
                numberOfNodes.addElement(node_Here);
            }
        }
        return numberOfNodes;
    }

    public String getValue(String name) {
        Element cmdElement = (Element) document_Here.getElementsByTagName(name).item(0);
        if (cmdElement == null) {
            return null;
        }
        Node childNode = cmdElement.getFirstChild();
        if (childNode == null) {
            return null;
        }
        String value = childNode.getNodeValue();
        return value;
    }

    //for Single Node present in the XML document
    public String getSingleNodeValue(String name, int nodeValue) {
        Element cmdElement = (Element) document_Here.getElementsByTagName(name).item(nodeValue);
        if (cmdElement == null) {
            return null;
        }
        Node childNode = cmdElement.getFirstChild();
        if (childNode == null) {
            return null;
        }
        String value = childNode.getNodeValue();
        return value;
    }

    public String getNodeAttributes(Node childNode) {
        String AttrValue = "";
        if (childNode.hasAttributes()) {
            //System.out.println("Has Attributes");
            if (childNode.getNodeType() == childNode.ELEMENT_NODE) {
                NamedNodeMap startAttr = childNode.getAttributes();
                for (int ib = 0; ib < startAttr.getLength(); ib++) {
                    Node attr = startAttr.item(ib);
                    //System.out.println("OM"+"Attribute     "+attr.getNodeName()+"="+attr.getNodeValue());
                    AttrValue = attr.getNodeValue();
                }
            }
        } else {
            //System.out.println("No Attributes in this Node");
        }
        return AttrValue;
    }

    public void getNodeValue(Node start) {
        String nodeName = "";
        //System.out.println(start.getNodeName()+" "+start.getNodeValue());
        if (start.getNodeType() == start.ELEMENT_NODE) {
            nodeName = start.getNodeName();
            NamedNodeMap startAttr = start.getAttributes();
            for (int i = 0; i < startAttr.getLength(); i++) {
                Node attr = startAttr.item(i);
                //System.out.println("  Attribute:  "+ attr.getNodeName()
                //+" = "+attr.getNodeValue());
            }
            System.out.println(start.getNodeName() + " = " + start.getNodeValue());
        }

        if (start.getNodeType() == start.TEXT_NODE) {
            String textValue = start.getNodeValue().trim();
            System.out.println(start.getNodeName() + " = " + start.getNodeValue());
            if (!textValue.equals("")) {
                nodeName = "";
            }
        }
        for (Node child = start.getFirstChild(); child != null; child = child.getNextSibling()) {
            getNodeValue(child);
        }
    }
}
