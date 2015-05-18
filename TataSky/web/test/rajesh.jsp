<%-- 
    Document   : rajesh
    Created on : Oct 1, 2013, 2:11:58 PM
    Author     : Rajesh
--%>
<%@page import="com.tsg.atom.MaskCardNumber"%>
<%@page import="org.apache.el.lang.ELArithmetic"%>
<%@page import="com.tsg.net.StatServerCommunication"%>
<%@page import="com.tsg.database.ivr.dataaccess.*"%>
<%@page import="com.tsg.database.gg.dataaccess.*"%>
<%@page import="com.tsg.portal.*"%>
<%@page import="com.tsg.common.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.Iterator"%>
<%@page import="java.util.*"%>
<%@page import="com.tsg.error.ErrorHandler"%>
<%@page import="com.tsg.xml.GenerateXml"%>
<%@page import="com.tsg.database.*"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="com.tsg.util.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%!            // Input varibales
            String LZ_BankID = "23";
            String s_CallDetailID = ""; // The CallDetailID needs to be returned after insertion.
// output varibales
            String LZ_BankFlag = "";
            String LZ_EMITenure = "";
            String LZ_PromptName = "";
            String xml = "";
            // output varibales
            String LZ_WO_no = "";
            String LZ_WO_status = "";
            String LZ_WO_scheduleDate = "";
            String LZ_NoOfBoxes = "";
            String LZ_PackName = "";
            int LZ_HardwareAmount = 0;
            int LZ_ActivityFee = 0;
            int LZ_BonusAmount = 0;
            int LZ_PackageAmount = 0;
            int LZ_AccessoriesAmount = 0;
            int LZ_TotalAmount = 0;
            String Flage = "";
            String callFlowName = "";
            String LZ_SubscriberIDCount = "2";

            //static Logger log = Logger.getLogger(rajesh_jsp.class);
%>
        <%

            try {
//                ********************* INSERT CALL DETAILS *********************
//                CallDetailDAO objCallDetail = new CallDetailDAO();
//                s_CallDetailID = objCallDetail.insertCallDetails("7002", "2223", "0RGO9HD0QL5V5DDCU99LH7A9AK00003V", "0RGO9HD0QL5V5DDCU99LH7A9AK000043", "BA6133EE-C3A5-4F65-8E9F-F2BAA5266F70;gvp.rm.datanodes=1;gvp.rm.tenant-id=1_TataSkyProfile_Demo", "4", "2013-10-25 11:27:09.5831");
//                
//                System.out.println("s_CallDetailID=" + s_CallDetailID);



//                ********************* USPEVDBalance *********************
//                 String balance = new GetEVDBalanceDAO().getEVDBalance("120068","98800957782");
//                 
//                 System.out.println("balance=" + balance);


//                ********************* USPISVALIDSUBSCRIBERBYCLI *********************
//                String xml = new CheckValidSubscriberByCliDAO().checkValidSubscriberByCli("9036774334","2000000023");
//                System.out.println("xml=" + xml);

                //                ********************* USPISVALIDSUBSCRIBERBYCLI *********************
//                String xml = new StatServerCommunication().AgentInfo("Tamilmani-PC");//Tamilmani-PC //SHEBDINI6240MBS
//                System.out.println("xml=" + xml);



//                ********************* USP_INSERTCALLFLOWDETAILTBL *********************
//                String insertCallFlowDetail = new InsertCallFlowDetailDAO().insertCallFlowDetail("<ROOT><TBLCALLFLOWDETAIL><FLDCALLDETAILID>15</FLDCALLDETAILID><FLDCALLFLOWID>9</FLDCALLFLOWID><FLDCALLFLOWDATETIME></FLDCALLFLOWDATETIME><FLDCFFIRSTINPUTSTARTDATETIME></FLDCFFIRSTINPUTSTARTDATETIME><FLDCFFIRSTINPUTENDDATETIME></FLDCFFIRSTINPUTENDDATETIME><FLDFIRSTINPUTID></FLDFIRSTINPUTID><FLDFIRSTINPUTVALUE></FLDFIRSTINPUTVALUE><FLDCFSECONDINPUTSTARTDATETIME></FLDCFSECONDINPUTSTARTDATETIME><FLDCFSECONDINPUTENDDATETIME></FLDCFSECONDINPUTENDDATETIME><FLDSECONDINPUTID></FLDSECONDINPUTID><FLDSECONDINPUTVALUE></FLDSECONDINPUTVALUE><FLDCFTHIRDINPUTSTARTDATETIME></FLDCFTHIRDINPUTSTARTDATETIME><FLDCFTHIRDINPUTENDDATETIME></FLDCFTHIRDINPUTENDDATETIME><FLDTHIRDINPUTID></FLDTHIRDINPUTID><FLDTHIRDINPUTVALUE></FLDTHIRDINPUTVALUE><FLDNOOFATTEMPTS></FLDNOOFATTEMPTS><FLDRULEID>1</FLDRULEID><FLDISSUCCESS>Y</FLDISSUCCESS></TBLCALLFLOWDETAIL><TBLCALLFLOWDETAIL><FLDCALLDETAILID>12</FLDCALLDETAILID><FLDCALLFLOWID>1</FLDCALLFLOWID><FLDCALLFLOWDATETIME></FLDCALLFLOWDATETIME><FLDCFFIRSTINPUTSTARTDATETIME></FLDCFFIRSTINPUTSTARTDATETIME><FLDCFFIRSTINPUTENDDATETIME></FLDCFFIRSTINPUTENDDATETIME><FLDFIRSTINPUTID></FLDFIRSTINPUTID><FLDFIRSTINPUTVALUE></FLDFIRSTINPUTVALUE><FLDCFSECONDINPUTSTARTDATETIME></FLDCFSECONDINPUTSTARTDATETIME><FLDCFSECONDINPUTENDDATETIME></FLDCFSECONDINPUTENDDATETIME><FLDSECONDINPUTID></FLDSECONDINPUTID><FLDSECONDINPUTVALUE></FLDSECONDINPUTVALUE><FLDCFTHIRDINPUTSTARTDATETIME></FLDCFTHIRDINPUTSTARTDATETIME><FLDCFTHIRDINPUTENDDATETIME></FLDCFTHIRDINPUTENDDATETIME><FLDTHIRDINPUTID></FLDTHIRDINPUTID> <FLDTHIRDINPUTVALUE></FLDTHIRDINPUTVALUE><FLDNOOFATTEMPTS></FLDNOOFATTEMPTS><FLDRULEID>1</FLDRULEID><FLDISSUCCESS>Y</FLDISSUCCESS></TBLCALLFLOWDETAIL><TBLCALLFLOWDETAIL><FLDCALLDETAILID>13</FLDCALLDETAILID><FLDCALLFLOWID>1</FLDCALLFLOWID><FLDCALLFLOWDATETIME></FLDCALLFLOWDATETIME><FLDCFFIRSTINPUTSTARTDATETIME></FLDCFFIRSTINPUTSTARTDATETIME><FLDCFFIRSTINPUTENDDATETIME></FLDCFFIRSTINPUTENDDATETIME><FLDFIRSTINPUTID></FLDFIRSTINPUTID><FLDFIRSTINPUTVALUE></FLDFIRSTINPUTVALUE><FLDCFSECONDINPUTSTARTDATETIME></FLDCFSECONDINPUTSTARTDATETIME><FLDCFSECONDINPUTENDDATETIME></FLDCFSECONDINPUTENDDATETIME><FLDSECONDINPUTID></FLDSECONDINPUTID><FLDSECONDINPUTVALUE></FLDSECONDINPUTVALUE><FLDCFTHIRDINPUTSTARTDATETIME></FLDCFTHIRDINPUTSTARTDATETIME><FLDCFTHIRDINPUTENDDATETIME></FLDCFTHIRDINPUTENDDATETIME><FLDTHIRDINPUTID></FLDTHIRDINPUTID> <FLDTHIRDINPUTVALUE></FLDTHIRDINPUTVALUE><FLDNOOFATTEMPTS></FLDNOOFATTEMPTS><FLDRULEID>1</FLDRULEID><FLDISSUCCESS>Y</FLDISSUCCESS></TBLCALLFLOWDETAIL></ROOT>");
//                String insertCallFlowDetail = new InsertCallFlowDetailDAO().insertCallFlowDetail("<ROOT><TBLCALLFLOWDETAIL><FLDCALLDETAILID>15</FLDCALLDETAILID><FLDCALLFLOWID>51</FLDCALLFLOWID><FLDCALLFLOWDATETIME>2013-11-05 10:53:45.567</FLDCALLFLOWDATETIME><FLDCFFIRSTINPUTSTARTDATETIME>2013-11-05 10:53:45.567</FLDCFFIRSTINPUTSTARTDATETIME><FLDCFFIRSTINPUTENDDATETIME>2013-11-05 10:53:45.567</FLDCFFIRSTINPUTENDDATETIME><FLDFIRSTINPUTID></FLDFIRSTINPUTID><FLDFIRSTINPUTVALUE></FLDFIRSTINPUTVALUE><FLDCFSECONDINPUTSTARTDATETIME>2013-11-05 10:53:45.567</FLDCFSECONDINPUTSTARTDATETIME><FLDCFSECONDINPUTENDDATETIME>2013-11-05 10:53:45.567</FLDCFSECONDINPUTENDDATETIME><FLDSECONDINPUTID></FLDSECONDINPUTID><FLDSECONDINPUTVALUE></FLDSECONDINPUTVALUE><FLDCFTHIRDINPUTSTARTDATETIME>2013-11-05 10:53:45.567</FLDCFTHIRDINPUTSTARTDATETIME><FLDCFTHIRDINPUTENDDATETIME>2013-11-05 10:53:45.567</FLDCFTHIRDINPUTENDDATETIME><FLDTHIRDINPUTID></FLDTHIRDINPUTID><FLDTHIRDINPUTVALUE></FLDTHIRDINPUTVALUE><FLDNOOFATTEMPTS></FLDNOOFATTEMPTS><FLDRULEID>18</FLDRULEID><FLDISSUCCESS>Y</FLDISSUCCESS></TBLCALLFLOWDETAIL><TBLCALLFLOWDETAIL><FLDCALLDETAILID>12</FLDCALLDETAILID><FLDCALLFLOWID>1</FLDCALLFLOWID><FLDCALLFLOWDATETIME>2013-11-05 10:53:45.567</FLDCALLFLOWDATETIME><FLDCFFIRSTINPUTSTARTDATETIME>2013-11-05 10:53:45.567</FLDCFFIRSTINPUTSTARTDATETIME><FLDCFFIRSTINPUTENDDATETIME>2013-11-05 10:53:45.567</FLDCFFIRSTINPUTENDDATETIME><FLDFIRSTINPUTID></FLDFIRSTINPUTID><FLDFIRSTINPUTVALUE></FLDFIRSTINPUTVALUE><FLDCFSECONDINPUTSTARTDATETIME>2013-11-05 10:53:45.567</FLDCFSECONDINPUTSTARTDATETIME><FLDCFSECONDINPUTENDDATETIME>2013-11-05 10:53:45.567</FLDCFSECONDINPUTENDDATETIME><FLDSECONDINPUTID></FLDSECONDINPUTID><FLDSECONDINPUTVALUE></FLDSECONDINPUTVALUE><FLDCFTHIRDINPUTSTARTDATETIME>2013-11-05 10:53:45.567</FLDCFTHIRDINPUTSTARTDATETIME><FLDCFTHIRDINPUTENDDATETIME>2013-11-05 10:53:45.567</FLDCFTHIRDINPUTENDDATETIME><FLDTHIRDINPUTID></FLDTHIRDINPUTID> <FLDTHIRDINPUTVALUE></FLDTHIRDINPUTVALUE><FLDNOOFATTEMPTS></FLDNOOFATTEMPTS><FLDRULEID>1</FLDRULEID><FLDISSUCCESS>Y</FLDISSUCCESS></TBLCALLFLOWDETAIL><TBLCALLFLOWDETAIL><FLDCALLDETAILID>13</FLDCALLDETAILID><FLDCALLFLOWID>1</FLDCALLFLOWID><FLDCALLFLOWDATETIME>2013-11-05 10:53:45.567</FLDCALLFLOWDATETIME><FLDCFFIRSTINPUTSTARTDATETIME>2013-11-05 10:53:45.567</FLDCFFIRSTINPUTSTARTDATETIME><FLDCFFIRSTINPUTENDDATETIME>2013-11-05 10:53:45.567</FLDCFFIRSTINPUTENDDATETIME><FLDFIRSTINPUTID></FLDFIRSTINPUTID><FLDFIRSTINPUTVALUE></FLDFIRSTINPUTVALUE><FLDCFSECONDINPUTSTARTDATETIME>2013-11-05 10:53:45.567</FLDCFSECONDINPUTSTARTDATETIME><FLDCFSECONDINPUTENDDATETIME></FLDCFSECONDINPUTENDDATETIME><FLDSECONDINPUTID></FLDSECONDINPUTID><FLDSECONDINPUTVALUE></FLDSECONDINPUTVALUE><FLDCFTHIRDINPUTSTARTDATETIME></FLDCFTHIRDINPUTSTARTDATETIME><FLDCFTHIRDINPUTENDDATETIME></FLDCFTHIRDINPUTENDDATETIME><FLDTHIRDINPUTID></FLDTHIRDINPUTID> <FLDTHIRDINPUTVALUE></FLDTHIRDINPUTVALUE><FLDNOOFATTEMPTS></FLDNOOFATTEMPTS><FLDRULEID>1</FLDRULEID><FLDISSUCCESS>Y</FLDISSUCCESS></TBLCALLFLOWDETAIL></ROOT>");
//                System.out.println("insertCallFlowDetail: " + insertCallFlowDetail);


//                ********************* USP_UPDATECALLDETAILTBL *********************  
//                String updateCallDetail = new UpdateCallDetailDAO().updateCallDetail("14838", "2013-12-27 12:35:39.6441", "English", "", "", "NonRMN", "", "", "", "1", "Transferred", "", "701004", "", "","","","","1234567890");



//                System.out.println("xml=" + updateCallDetail);


//                ********************* USPGETPROFILEBYSUBSCRIBERID *********************	
//                String xml = new DBAccess().getProfileBySubscriberId("20000000094","1"); //20000000094
//                System.out.println("xml=" + xml);


//                ********************* USPGETWODETAILS *********************
//                xml = new DBAccess().getWorkOrderDetails("3000737027");
//                System.out.println("xml=" + xml);


//                ********************* USPGETACCOUNTDETAIL *********************

//
//                xml = new DBAccess().getAccountDetail("3000578900");//3000071666 3000741615 3000606131
//                System.out.println("xml=" + xml);


//                *********************USPGETDETAILBYSUBSCRIBERID*********************
//                xml = new DBAccess().getDetailBySubscriberId("2000000023"); //2000000094 // 2000007985
//                System.out.println("xml=" + xml);


                //               *********************USPGETSUBSCRIBERPROFILEBYRMN*********************	
//                xml = new DBAccess().getSubscriberProfileByRmn("2344555","23444");//9900668523 // 9892398472  //6666666666 //8758456123
//                System.out.println("xml=" + xml);
//                System.out.println("=======================================================================");

//                *********************USPGETSTAS_STATECODE_BYSUBSCID*********************
//                 xml = new DBAccess().getStasStateCodeBySubscId("3000011225");
//                 System.out.println("xml=" + xml);
//                xml = new DBAccess().getProfileBySubscriberId("3000728018");


//                ********************* MULTITV *********************
//                xml = new GetMultiTvFlagDAO().getMultiTvFlag("3000728018");
//                System.out.println("xml=" + xml);


//                ********************* WRITE TEXT TO FILE *********************
//                new WriteXML().writeTextFile("<ROOT><TBLCALLFLOWDETAIL><FLDCALLDETAILID>15</FLDCALLDETAILID><FLDCALLFLOWID>9</FLDCALLFLOWID><FLDCALLFLOWDATETIME></FLDCALLFLOWDATETIME><FLDCFFIRSTINPUTSTARTDATETIME></FLDCFFIRSTINPUTSTARTDATETIME><FLDCFFIRSTINPUTENDDATETIME></FLDCFFIRSTINPUTENDDATETIME><FLDFIRSTINPUTID></FLDFIRSTINPUTID><FLDFIRSTINPUTVALUE></FLDFIRSTINPUTVALUE><FLDCFSECONDINPUTSTARTDATETIME></FLDCFSECONDINPUTSTARTDATETIME><FLDCFSECONDINPUTENDDATETIME></FLDCFSECONDINPUTENDDATETIME><FLDSECONDINPUTID></FLDSECONDINPUTID><FLDSECONDINPUTVALUE></FLDSECONDINPUTVALUE><FLDCFTHIRDINPUTSTARTDATETIME></FLDCFTHIRDINPUTSTARTDATETIME><FLDCFTHIRDINPUTENDDATETIME></FLDCFTHIRDINPUTENDDATETIME><FLDTHIRDINPUTID></FLDTHIRDINPUTID><FLDTHIRDINPUTVALUE></FLDTHIRDINPUTVALUE><FLDNOOFATTEMPTS></FLDNOOFATTEMPTS><FLDRULEID>1</FLDRULEID><FLDISSUCCESS>Y</FLDISSUCCESS></TBLCALLFLOWDETAIL><TBLCALLFLOWDETAIL><FLDCALLDETAILID>12</FLDCALLDETAILID><FLDCALLFLOWID>1</FLDCALLFLOWID><FLDCALLFLOWDATETIME></FLDCALLFLOWDATETIME><FLDCFFIRSTINPUTSTARTDATETIME></FLDCFFIRSTINPUTSTARTDATETIME><FLDCFFIRSTINPUTENDDATETIME></FLDCFFIRSTINPUTENDDATETIME><FLDFIRSTINPUTID></FLDFIRSTINPUTID><FLDFIRSTINPUTVALUE></FLDFIRSTINPUTVALUE><FLDCFSECONDINPUTSTARTDATETIME></FLDCFSECONDINPUTSTARTDATETIME><FLDCFSECONDINPUTENDDATETIME></FLDCFSECONDINPUTENDDATETIME><FLDSECONDINPUTID></FLDSECONDINPUTID><FLDSECONDINPUTVALUE></FLDSECONDINPUTVALUE><FLDCFTHIRDINPUTSTARTDATETIME></FLDCFTHIRDINPUTSTARTDATETIME><FLDCFTHIRDINPUTENDDATETIME></FLDCFTHIRDINPUTENDDATETIME><FLDTHIRDINPUTID></FLDTHIRDINPUTID> <FLDTHIRDINPUTVALUE></FLDTHIRDINPUTVALUE><FLDNOOFATTEMPTS></FLDNOOFATTEMPTS><FLDRULEID>1</FLDRULEID><FLDISSUCCESS>Y</FLDISSUCCESS></TBLCALLFLOWDETAIL><TBLCALLFLOWDETAIL><FLDCALLDETAILID>13</FLDCALLDETAILID><FLDCALLFLOWID>1</FLDCALLFLOWID><FLDCALLFLOWDATETIME></FLDCALLFLOWDATETIME><FLDCFFIRSTINPUTSTARTDATETIME></FLDCFFIRSTINPUTSTARTDATETIME><FLDCFFIRSTINPUTENDDATETIME></FLDCFFIRSTINPUTENDDATETIME><FLDFIRSTINPUTID></FLDFIRSTINPUTID><FLDFIRSTINPUTVALUE></FLDFIRSTINPUTVALUE><FLDCFSECONDINPUTSTARTDATETIME></FLDCFSECONDINPUTSTARTDATETIME><FLDCFSECONDINPUTENDDATETIME></FLDCFSECONDINPUTENDDATETIME><FLDSECONDINPUTID></FLDSECONDINPUTID><FLDSECONDINPUTVALUE></FLDSECONDINPUTVALUE><FLDCFTHIRDINPUTSTARTDATETIME></FLDCFTHIRDINPUTSTARTDATETIME><FLDCFTHIRDINPUTENDDATETIME></FLDCFTHIRDINPUTENDDATETIME><FLDTHIRDINPUTID></FLDTHIRDINPUTID> <FLDTHIRDINPUTVALUE></FLDTHIRDINPUTVALUE><FLDNOOFATTEMPTS></FLDNOOFATTEMPTS><FLDRULEID>1</FLDRULEID><FLDISSUCCESS>Y</FLDISSUCCESS></TBLCALLFLOWDETAIL></ROOT>", "123451");


//                ********************* USPGETAGENTFLAG *********************
//                DatabaseProcessorDAO dbProcessorDAO = new DatabaseProcessorDAO();                               
//                String LZ_AgentFlag = dbProcessorDAO.agentIdValidation("10101");


//                ********************* USPGETWODETAILS *********************
//                GetWorkOrderDetailsDAO getWorkOrderDetailsDAO = new GetWorkOrderDetailsDAO();
//                ArrayList stateCodeList = getWorkOrderDetailsDAO.getWorkOrderDetails("3000741821", "");
//                Iterator stateCodeItr = stateCodeList.iterator();
//                while (stateCodeItr.hasNext()) {
//                    getWorkOrderDetailsDAO = (GetWorkOrderDetailsDAO) stateCodeItr.next();
//                    LZ_WO_no = getWorkOrderDetailsDAO.getWorkOrderNumber();
//                    LZ_WO_status = getWorkOrderDetailsDAO.getWorkOrderStatus();
//                    LZ_WO_scheduleDate = getWorkOrderDetailsDAO.getWorkOrderScheduledDate();
//                }
//                System.out.println("LZ_WO_no=" + LZ_WO_no);
//                System.out.println("LZ_WO_status=" + LZ_WO_status);
//                System.out.println("LZ_WO_scheduleDate=" + LZ_WO_scheduleDate);
//                //LZ_WO_scheduleDate = Util.getCurrentDateTime();
//                if (LZ_WO_status.equalsIgnoreCase("Scheduled")) {
//
//                    String difference = Util.getDateDifference(Util.getCurrentDateTime(), LZ_WO_scheduleDate, "yyyy-MM-dd HH:mm:ss");
//                    
//                    difference = difference.substring(0, 1);
//                    
//                    if(difference.equals("-")){
//                     System.out.println("difference=" + difference);   
//                    } 
//                    // if(LZ_WO_scheduleDate)
//
//                }
//                

//                ********************* USPGETBANKNAME *********************
//                BankIdDAO dbBankIdDAO = new BankIdDAO();
//                ArrayList bankIdlist = dbBankIdDAO.bankIdValidation("31");
//                Iterator bankIdlistItr = bankIdlist.iterator();
//                while (bankIdlistItr.hasNext()) {
//                    dbBankIdDAO = (BankIdDAO) bankIdlistItr.next();
//                    LZ_BankFlag = dbBankIdDAO.getBankFlage();
//                    LZ_EMITenure = dbBankIdDAO.getBankEmiDetails();
//                }
//                System.out.println("LZ_BankFlag=" + LZ_BankFlag);
//                System.out.println("LZ_EMITenure=" + LZ_EMITenure);
//                if(!LZ_BankFlag.equalsIgnoreCase("N")) {
//                    
//                }


//                ********************* pricePointDAO *********************
//                PricePointDAO pricePointDAO = new PricePointDAO();
//                ArrayList pricePointlist = pricePointDAO.pricePoint("990");
//                Iterator pricePointlistItr = pricePointlist.iterator();
//                while (pricePointlistItr.hasNext()) {
//
//                    pricePointDAO = (PricePointDAO) pricePointlistItr.next();
//                    LZ_NoOfBoxes = pricePointDAO.getBoxNo();
//                    LZ_PackName = pricePointDAO.getProductCode();
//                    LZ_HardwareAmount = pricePointDAO.getHardWareAmount();
//                    LZ_ActivityFee = pricePointDAO.getActivationAmount();
//                    LZ_BonusAmount = pricePointDAO.getBonusAmount();
//                    LZ_PackageAmount = pricePointDAO.getInstallationAmount();
//                    LZ_AccessoriesAmount = pricePointDAO.getAccessoriesAmount();
//                    LZ_TotalAmount = pricePointDAO.getTotalAmount();
//                }
//                System.out.println("LZ_NoOfBoxes=" + LZ_NoOfBoxes);
//                System.out.println("LZ_PackName=" + LZ_PackName);
//                System.out.println("LZ_HardwareAmount=" + LZ_HardwareAmount);
//                System.out.println("LZ_ActivityFee=" + LZ_ActivityFee);
//                System.out.println("LZ_BonusAmount=" + LZ_BonusAmount);
//                System.out.println("LZ_PackageAmount=" + LZ_PackageAmount);
//                System.out.println("LZ_AccessoriesAmount=" + LZ_AccessoriesAmount);
//                System.out.println("LZ_TotalAmount=" + LZ_TotalAmount);


//                ********************* USP_GETCLIREPEAT *********************
//                Flage = new GetCliRepeatDAO().cliRepeatFlage("", ""); // CLI // Book or Buy
//                System.out.println("Flage=" + Flage);

                //                *********************USPGETSTAS_STATECODE_BYSUBSCID*********************
                //xml = new DBAccess().getPartnerDetailMobile("9320071462");
//                xml = new DBAccess().getPartnerDetailId("199852");
//                System.out.println("xml=" + xml);
//                xml = new DBAccess().getProfileBySubscriberId("3000728018");

                //                ********************* USPGETCALLFLOWVALUE *********************
//                callFlowName = new GetCallFlowValueDAO().getCallFlowValue(""); 
//                System.out.println("callFlowName=" + callFlowName);

                //                *********************USPGETDETAILBYSUBSCRIBERID*********************
//                xml = new GetPremiumBySubscriberId().getPremiumBySubscriberId("3000011225"); //2000000094 // 2000007985
//                System.out.println("xml=" + xml);

//                xml = new StatServerCommunication().AgentInfo("SHEBDINI6240MBS");
//                System.out.println("xml=" + xml);

//                if (!LZ_SubscriberIDCount.isEmpty()) {
//
//                    String premiumFlage = new GetPremiumBySubscriberId().getPremiumBySubscriberId("","");
//
//                    if (!premiumFlage.equalsIgnoreCase("N")) {
//                    }
//
//                }

                String LZ_FirstInputID = ""; // This is used to store the first input ID.
                String LZ_FirstInputValue = ""; // This is used to store the first input value.
                String LZ_SecondInputID = ""; // This is used to store the second input ID.
                String LZ_SecondInputValue = ""; // This is used to store the second input value.

                String LZ_ThirdInputID = ""; // This is used to store the third input ID.
                String LZ_ThirdInputValue = ""; // This is used to store the third input value.
                String LZ_CallFlowID = "216"; // This is used to store the call flow ID.
                LZ_FirstInputValue = "5246500004612";
                if (LZ_CallFlowID.equals("216")) {
                    MaskCardNumber maskCardNumber = new MaskCardNumber();
                    if (LZ_FirstInputValue.length() == 16) {
                        LZ_FirstInputValue = maskCardNumber.maskCardNumber(LZ_FirstInputValue, "######xxxxxx####");
                    
                    } else if (LZ_FirstInputValue.length() == 15) {
                        LZ_FirstInputValue = maskCardNumber.maskCardNumber(LZ_FirstInputValue, "#####xxxxxx####");
                    
                    } else if (LZ_SecondInputValue.length() == 16) {
                        LZ_SecondInputValue = maskCardNumber.maskCardNumber(LZ_SecondInputValue, "######xxxxxx####");
                    
                    } else if (LZ_SecondInputValue.length() == 15) {
                        LZ_SecondInputValue = maskCardNumber.maskCardNumber(LZ_SecondInputValue, "#####xxxxxx####");
                    
                    } else if (LZ_ThirdInputValue.length() == 16) {
                        LZ_ThirdInputValue = maskCardNumber.maskCardNumber(LZ_ThirdInputValue, "######xxxxxx####");
                    
                    } else if (LZ_ThirdInputValue.length() == 15) {
                        LZ_ThirdInputValue = maskCardNumber.maskCardNumber(LZ_ThirdInputValue, "#####xxxxxx####");
                    }
                }
            } catch (Exception ex) {
                System.out.println(" Exception in HostRechargeAccValidator_jsp" + ex.getMessage());
                ex.printStackTrace();

            }
        %>
    </body>
</html>
