/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tsg.database.ivr.dataaccess;

import com.tsg.common.ConfigurationReader;
import com.tsg.common.rule.RuleDAO;
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
public class PricePointDAO {

    private int hardWareAmount;
    private int activationAmount;
    private int bonusAmount;
    private int installationAmount;
    private int accessoriesAmount;
    private String productCode;
    private String boxNo;
    private int totalAmount;

    public int getHardWareAmount() {
        return hardWareAmount;
    }

    public void setHardWareAmount(int hardWareAmount) {
        this.hardWareAmount = hardWareAmount;
    }

    public int getActivationAmount() {
        return activationAmount;
    }

    public void setActivationAmount(int activationAmount) {
        this.activationAmount = activationAmount;
    }

    public int getBonusAmount() {
        return bonusAmount;
    }

    public void setBonusAmount(int bonusAmount) {
        this.bonusAmount = bonusAmount;
    }

    public int getInstallationAmount() {
        return installationAmount;
    }

    public void setInstallationAmount(int installationAmount) {
        this.installationAmount = installationAmount;
    }

    public int getAccessoriesAmount() {
        return accessoriesAmount;
    }

    public void setAccessoriesAmount(int accessoriesAmount) {
        this.accessoriesAmount = accessoriesAmount;
    }

    public String getProductCode() {
        return productCode;
    }

    public void setProductCode(String productCode) {
        this.productCode = productCode;
    }

    public String getBoxNo() {
        return boxNo;
    }

    public void setBoxNo(String boxNo) {
        this.boxNo = boxNo;
    }

    public int getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(int totalAmount) {
        this.totalAmount = totalAmount;
    }

    public PricePointDAO() {
    }

    public PricePointDAO(int hardWareAmount, int activationAmount, int bonusAmount, int installationAmount,
            int accessoriesAmount, String productCode, String boxNo, int totalAmount) {

        this.hardWareAmount = hardWareAmount;
        this.activationAmount = activationAmount;
        this.bonusAmount = bonusAmount;
        this.installationAmount = installationAmount;
        this.accessoriesAmount = accessoriesAmount;
        this.productCode = productCode;
        this.boxNo = boxNo;
        this.totalAmount = totalAmount;
    }

    public ArrayList pricePoint(String amount, String dbCallDetailId) {

        String dataCenter = ConfigurationReader.configList.get("DATACENTER");
        
        DBConnectionPool dbConPool = new DBConnectionPool();

        dbConPool.setPoolDataSource(dataCenter + "IVRPRDB");

        Connection conn = null;

        ResultSet rs = null;

        ArrayList pricePointList = new ArrayList();

        CallableStatement callableStatement = null;

        String strProc = "{call " + ConfigurationReader.configList.get("PROC_NAME_PRICE_POINT") + "(?,?)}";

        try {

            conn = dbConPool.getConnection(dbCallDetailId);

            callableStatement = conn.prepareCall(strProc);

            callableStatement.setInt(1, Integer.parseInt(amount));

            callableStatement.registerOutParameter(2, OracleTypes.CURSOR); //REF CURSOR

            callableStatement.executeQuery();

            rs = ((OracleCallableStatement) callableStatement).getCursor(2);

            while (rs.next()) {

                hardWareAmount = rs.getInt("HardWareAmount");

                activationAmount = rs.getInt("ActivationAmount");

                bonusAmount = rs.getInt("BonusAmount");

                installationAmount = rs.getInt("InstallationAmount");

                accessoriesAmount = rs.getInt("AccessoriesAmount");

                productCode = rs.getString("ProductCode");

                boxNo = rs.getString("BOXNO");

                totalAmount = rs.getInt("TOTALAMOUNT");

            }

            PricePointDAO pricePointDAOobj = new PricePointDAO(hardWareAmount, activationAmount,
                    bonusAmount, installationAmount, accessoriesAmount, productCode,
                    boxNo, totalAmount);

            pricePointList.add(pricePointDAOobj);

        } catch (SQLException sqlEx) {

            Logger.error(dbCallDetailId, " SQL Exception in Price Point Page Amount: " + amount + " Message : " + sqlEx.getMessage(), false);

        } catch (Exception ex) {

            Logger.error(dbCallDetailId, " Exception in Price Point Page Amount: " + amount + " Message : " + ex.getMessage(), false);

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

                Logger.error(dbCallDetailId, " Exception in Price Point finally block : " + amount + " Message : " + sqlEx.getMessage(), false);
            }

            dbConPool.releaseConnection(dbCallDetailId);

        }

        Logger.info(dbCallDetailId, " Price Point " + amount + " hardWareAmount " + hardWareAmount + " activationAmount " + activationAmount
                + " bonusAmount " + bonusAmount + " installationAmount " + installationAmount + " accessoriesAmount " + accessoriesAmount
                + " productCode " + productCode + " boxNo " + boxNo + " totalAmount " + totalAmount, true);

        amount = dataCenter = productCode = boxNo = null;

        hardWareAmount = activationAmount = bonusAmount = installationAmount = accessoriesAmount = totalAmount = 0;

        return pricePointList;
    }
}