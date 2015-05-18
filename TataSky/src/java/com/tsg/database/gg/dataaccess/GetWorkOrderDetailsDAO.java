/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tsg.database.gg.dataaccess;

import com.tsg.common.ConfigurationReader;
import com.tsg.database.DBConnectionPool;

import com.tsg.log.Logger;

import java.sql.CallableStatement;

import java.sql.Connection;

import java.sql.ResultSet;

import java.sql.SQLException;

import java.util.ArrayList;

import oracle.jdbc.OracleCallableStatement;

import oracle.jdbc.OracleTypes;

/**
 *
 * @author Rajesh
 */
public class GetWorkOrderDetailsDAO {

    private String WorkOrderNumber = "";
    private String WorkOrderStatus = "";
    private String WorkOrderScheduledDate = "";

    public String getWorkOrderNumber() {

        return WorkOrderNumber;
    }

    public void setWorkOrderNumber(String WorkOrderNumber) {

        this.WorkOrderNumber = WorkOrderNumber;
    }

    public String getWorkOrderStatus() {

        return WorkOrderStatus;
    }

    public void setWorkOrderStatus(String WorkOrderStatus) {

        this.WorkOrderStatus = WorkOrderStatus;
    }

    public String getWorkOrderScheduledDate() {

        return WorkOrderScheduledDate;
    }

    public void setWorkOrderScheduledDate(String WorkOrderScheduledDate) {

        this.WorkOrderScheduledDate = WorkOrderScheduledDate;
    }

    public GetWorkOrderDetailsDAO() {
    }

    public GetWorkOrderDetailsDAO(String WorkOrderNumber, String WorkOrderStatus, String WorkOrderScheduledDate) {

        this.WorkOrderNumber = WorkOrderNumber;

        this.WorkOrderStatus = WorkOrderStatus;

        this.WorkOrderScheduledDate = WorkOrderScheduledDate;
    }

    public ArrayList getWorkOrderDetails(String subscriberId, String dbCallDetailId) {

        String dataCenter = ConfigurationReader.configList.get("DATACENTER");

        DBConnectionPool dbConPool = new DBConnectionPool();

        dbConPool.setPoolDataSource(dataCenter+"GGPRDB");

        Connection conn = null;

        CallableStatement callableStatement = null;

        ResultSet rs = null;

        ArrayList workOrderDetailsList = new ArrayList();

        String strProc = "{call " + ConfigurationReader.configList.get("PROC_NAME_GET_WO_DETAILS") + "(?,?)}";

        try {

            conn = dbConPool.getConnection(dbCallDetailId);

            callableStatement = conn.prepareCall(strProc);

            callableStatement.setString(1, subscriberId);

            callableStatement.registerOutParameter(2, OracleTypes.CURSOR);

            callableStatement.execute();

            rs = ((OracleCallableStatement) callableStatement).getCursor(2);

            while (rs.next()) {

                WorkOrderNumber = rs.getString("WO_NO");

                WorkOrderStatus = rs.getString("STATUS");

                WorkOrderScheduledDate = rs.getString("SCHEDULED_DATE");
            }

            GetWorkOrderDetailsDAO workOrderDetailsobj = new GetWorkOrderDetailsDAO(WorkOrderNumber, WorkOrderStatus,
                    WorkOrderScheduledDate);

            workOrderDetailsList.add(workOrderDetailsobj);

        } catch (SQLException sqlEx) {

            Logger.error(dbCallDetailId, " SQLException in Work Order Details Page Subscriber Id : " + subscriberId + " Message : " + sqlEx.getMessage(), false);

        } catch (Exception ex) {

            Logger.error(dbCallDetailId, " Exception in Work Order Details Page Subscriber Id : " + subscriberId + " Message : " + ex.getMessage(), false);

        } finally {

            try {

                if (callableStatement != null) {

                    callableStatement.close();

                    callableStatement = null;
                }

                if (rs != null) {

                    rs.close();

                    rs = null;
                }

                if (conn != null) {

                    conn.close();

                    conn = null;
                }

            } catch (SQLException sqlEx) {

                Logger.error(dbCallDetailId, " Exception in Work Order Details finally block Subscriber Id : " + subscriberId + " Message : " + sqlEx.getMessage(), false);
            }

            dbConPool.releaseConnection(dbCallDetailId);
        }

        Logger.info(dbCallDetailId, " Work Order Details for the Subscriber Id : " + subscriberId + " Work Order Number : " + WorkOrderNumber
                + " Work Order Status : " + WorkOrderStatus + " Work Order Scheduled Date : " + WorkOrderScheduledDate, false);

        dbCallDetailId = dataCenter = subscriberId = WorkOrderNumber = WorkOrderStatus = WorkOrderScheduledDate = null;

        return workOrderDetailsList;
    }
}
