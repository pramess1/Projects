/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tsg.net;

import com.genesyslab.platform.commons.protocol.Endpoint;
import com.genesyslab.platform.commons.protocol.Message;
import com.genesyslab.platform.reporting.protocol.StatServerProtocol;
import com.genesyslab.platform.reporting.protocol.statserver.ActionsMask;
import com.genesyslab.platform.reporting.protocol.statserver.DnActionMask;
import com.genesyslab.platform.reporting.protocol.statserver.DnActions;
import com.genesyslab.platform.reporting.protocol.statserver.Notification;
import com.genesyslab.platform.reporting.protocol.statserver.NotificationMode;
import com.genesyslab.platform.reporting.protocol.statserver.StatisticCategory;
import com.genesyslab.platform.reporting.protocol.statserver.StatisticMetricEx;
import com.genesyslab.platform.reporting.protocol.statserver.StatisticObject;
import com.genesyslab.platform.reporting.protocol.statserver.StatisticObjectType;
import com.genesyslab.platform.reporting.protocol.statserver.StatisticSubject;
import com.genesyslab.platform.reporting.protocol.statserver.requests.RequestOpenStatisticEx;
import com.tsg.common.ConfigurationReader;
import com.tsg.log.Logger;

/**
 *
 * @author Rajesh
 */
public class StatServerCommunication {

    public String AgentInfo(String hostName, String dbCallDetailId) {
        Message response = null;
        String response1 = null;
        try {
            StatServerProtocol statServerProtocol = new StatServerProtocol(new Endpoint(ConfigurationReader.configList.get("PR_STAT_SERVER_NAME"),
                    ConfigurationReader.configList.get("PR_STAT_SERVER_HOST_NAME"), Integer.parseInt(ConfigurationReader.configList.get("PR_STAT_SERVER_PORT_NUMBER"))));
            statServerProtocol.setClientName(ConfigurationReader.configList.get("PR_STAT_SERVER_NAME"));
            statServerProtocol.setClientId(2);
            try {
                statServerProtocol.open();
            } catch (Exception ex) {
                Logger.error(dbCallDetailId, "While Connecting the Primary Stat Server Protocol Exception : " + ex.getMessage(), false);
                statServerProtocol = new StatServerProtocol(new Endpoint(ConfigurationReader.configList.get("SE_STAT_SERVER_NAME"),
                        ConfigurationReader.configList.get("SE_STAT_SERVER_HOST_NAME"), Integer.parseInt(ConfigurationReader.configList.get("SE_STAT_SERVER_PORT_NUMBER"))));
                statServerProtocol.setClientName(ConfigurationReader.configList.get("SE_STAT_SERVER_NAME"));
                statServerProtocol.setClientId(2);
                try {
                    statServerProtocol.open();
                } catch (Exception ex1) {
                    statServerProtocol.beginClose();
                    Logger.error(dbCallDetailId, " Exception While Opening the Secondary Stat Server Connection " + ex1.getMessage(), true);
                    return "N";
                }
            }
            RequestOpenStatisticEx req = RequestOpenStatisticEx.create();
            StatisticObject object = StatisticObject.create();
            object.setObjectType(StatisticObjectType.AgentPlace);
            object.setObjectId(hostName); // 
            object.setTenantName("Resources");
            object.setTenantPassword("");
            Notification notification = Notification.create();
            notification.setMode(NotificationMode.Periodical);
            notification.setFrequency(5);
            req.setReferenceId(3);
            DnActionMask mainMask = ActionsMask.createDNActionsMask();
            mainMask.setBit(DnActions.WaitForNextCall);
            mainMask.setBit(DnActions.CallDialing);
            mainMask.setBit(DnActions.CallRinging);
            mainMask.setBit(DnActions.NotReadyForNextCall);
            mainMask.setBit(DnActions.CallOnHold);
            mainMask.setBit(DnActions.CallUnknown);
            mainMask.setBit(DnActions.CallConsult);
            mainMask.setBit(DnActions.CallInternal);
            mainMask.setBit(DnActions.CallOutbound);
            mainMask.setBit(DnActions.CallInbound);
            mainMask.setBit(DnActions.LoggedOut);
            DnActionMask relMask = ActionsMask.createDNActionsMask();
            StatisticMetricEx metric = StatisticMetricEx.create();
            metric.setCategory(StatisticCategory.CurrentState);
            metric.setIntervalLength(0);
            metric.setMainMask(mainMask);
            metric.setRelativeMask(relMask);
            metric.setSubject(StatisticSubject.DNStatus);
            metric.setSubject(StatisticSubject.PlaceStatus);
            req.setStatisticMetricEx(metric);
            req.setStatisticObject(object);
            req.setNotification(notification);
            try {
                Logger.info(dbCallDetailId, "Stat Server request :" + req, false);
                statServerProtocol.request(req);
                response = statServerProtocol.receive();
                statServerProtocol.beginClose();
                Logger.info(dbCallDetailId, "Stat Server Response :" + response, false);
                if (response == null) {
                    return "N";
                } else {
                    String[] reponseArray = null;
                    String agentId = null, agentValue = null;
                    response1 = response.toString();
                    reponseArray = response1.split("=");
                    for (int j = 0; j < reponseArray.length; j++) {
                        if (reponseArray[j].contains("AgentId")) {
                            agentId = reponseArray[j];
                            agentValue = reponseArray[j + 1];
                            agentId = agentId.substring(agentId.length() - 8, agentId.length()).trim();
                            agentValue = agentValue.replaceFirst("LoginId", "").trim();
                        }
                    }
                    if ((agentValue == null) || (agentId == null)) {
                        Logger.info(dbCallDetailId, "AgentId is not Received", false);
                        return "N";
                    } else {
                        Logger.info(dbCallDetailId, "AgentId is :" + agentValue, false);
                        return agentValue;
                    }
                }
            } catch (Exception ex) {
                Logger.error(dbCallDetailId, "Exception in Stat Server response : " + ex.getMessage(), false);
                return "N";
            }
        } catch (Exception ex) {
            Logger.error(dbCallDetailId, "Exception in Stat Server Communication page : " + ex.getMessage(), false);
            return "N";
        }
    }
}