<%@page language="java" contentType="text/xml" pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.tsg.requesthandler.requestDelegator"%>
<%@page import="com.tatasky.eai.CreateRelocationWorkOrderResponse"%>
<%@page import="com.tatasky.eai.CreateRelocationWorkOrder"%>
<%@page import="com.tatasky.log.Logger"%>

<%!
//static Logger log = Logger.getLogger(HostEAICreateRelocationWO_jsp.class);
private boolean b_SimulatorMode = false; // Simulator Mode by default is set to true.
// Input varibales
String LZ_ivrid="";
String BA_SUBSCRIBER_ID="";
String LZ_type="";
String LZ_subType="";
String LZ_priority="";
DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
String LZ_DateTime=dateFormat.format(new Date());

// output varibales
String LZ_activity_Id="";
String LZ_errorMsg="";
String LZ_errorcode="";
%>
<%


        try
        {
                if(b_SimulatorMode)
                {
					//  Test method
                                           
                }
                else
                {
                        // Realtime scenario
                //LZ_ivrid = state.getString("LZ_ivrid");
                //BA_SUBSCRIBER_ID=state.getString("BA_SUBSCRIBER_ID");
                //LZ_type=state.getString("LZ_type");
                //LZ_subType=state.getString("LZ_subType");
                //LZ_priority=state.getString("LZ_priority");
                
                Logger.log("HostEAICreateRelocationWO_jsp output IVR Id " +  LZ_ivrid 
                + " BA_SUBSCRIBER_ID " + BA_SUBSCRIBER_ID + " LZ_subType" + LZ_activity_Id
                + " LZ_priority " + LZ_priority, true, true);
                        
                        // Send the request to Tatasky
                CreateRelocationWorkOrderResponse objDataService = new CreateRelocationWorkOrder().requestCreateRelocationWorkOrder(LZ_ivrid, 
                        BA_SUBSCRIBER_ID, LZ_type, LZ_subType, LZ_DateTime,  LZ_priority);
                
                // Response from Tatasky 
                LZ_ivrid=objDataService.getIvrId();
                BA_SUBSCRIBER_ID=objDataService.getSubscriberNumber();
                LZ_activity_Id=objDataService.getActivityId();
                LZ_errorcode=objDataService.getErrorCode();
                LZ_errorMsg=objDataService.getErrorDescription();
                       
                }
        }
        catch (Exception ex)
        {
                // Log Exception
        }
    
  
	//System.out.println("HostEAICreateRelocationWO_jsp output ="+LZ_IVR_ID  + "|" +  BA_SUBSCRIBER_ID  + "|" +  LZ_WO_Description + "|" + LZ_WorkOrderNumber + "|" +  LZ_Status + "|" +  LZ_ScheduledDateTime + "|" +  LZ_ErrorDescription + "|" +  LZ_ErrorCode + "|" +  LZ_DateTime);

    

%>
<%-- GENERATED: DO NOT REMOVE --%> 
<%@page import="java.util.Map"%>
