/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tsg.atom;

import com.tsg.log.Logger;
import java.util.ArrayList;

/**
 *
 * @author Rajesh
 */
public class TransactionRecharge {

    MaskCardNumber maskCardNumber = new MaskCardNumber();
//    Encryption objEncryption = new Encryption();

    public TransactionRechargeResponse requestTransactionRecharge(String atomMerchantId, String methodType, String serviceId, String getAmount,
            String SubscriberId, String userANI, String cardNumber, String expiryDate,
            String cvvNumber, String batchCode, String otp, String paymentType,
            String TransId, String atomTransUniqueId, String cardType, String EMITenure,
            String mobileNo, String BAPin, String rechargeOption, String rechargeOptionAgent,
            String pricePoint, String tataSkyTransId, String product, String hardwareAmount, String packageAmount,
            String bonusAmount, String packageName, String srNumber, String dbCallDetailId) throws Exception {


        return makeTransactionRechargeRequest(atomMerchantId, methodType, serviceId, getAmount,
                SubscriberId, userANI, cardNumber, expiryDate, cvvNumber, batchCode, otp, paymentType,
                TransId, atomTransUniqueId, cardType, EMITenure, mobileNo, BAPin, rechargeOption, rechargeOptionAgent,
                pricePoint, tataSkyTransId, product, hardwareAmount, packageAmount, bonusAmount, packageName, srNumber, dbCallDetailId);

    }

    public String transactionRecharge(String atomMerchantId, String methodType, String serviceId, String getAmount,
            String SubscriberId, String userANI, String cardNumber, String expiryDate,
            String cvvNumber, String batchCode, String otp, String paymentType,
            String TransId, String atomTransUniqueId, String cardType, String EMITenure,
            String mobileNo, String BAPin, String rechargeOption, String rechargeOptionAgent,
            String pricePoint, String tataSkyTransId, String product, String hardwareAmount, String packageAmount,
            String bonusAmount, String packageName, String srNumber, String dbCallDetailId) 
             {

        StringBuilder builder = new StringBuilder();

        if (product.equalsIgnoreCase("Recharge")) {

            //builder.append("<?xml version=\"1.0\" encoding=\"UTF-8\" ?>");

            builder.append("<Request>");

            builder.append("<atom>").append(atomMerchantId).append("</atom>");

            builder.append("<Method_type>").append(methodType).append("</Method_type>");

            builder.append("<Service_id>").append(serviceId).append("</Service_id>");

            builder.append("<Amount>").append(getAmount).append("</Amount>");

            builder.append("<UDF0>").append(SubscriberId).append("</UDF0>");

            builder.append("<UDF1>").append(userANI).append("</UDF1>");

            if (rechargeOptionAgent.equalsIgnoreCase("4") || (rechargeOptionAgent.equalsIgnoreCase("3"))) {

                if (paymentType.equalsIgnoreCase("AXISDB")) {

                    builder.append("<UDF2>").append(EMITenure).append("|").append(maskCardNumber.maskCardNumber(cardNumber, "######xxxxxx####")).append("|")
                            .append(BAPin).append("</UDF2>");
                    
//                    builder.append("<UDF2>").append(EMITenure).append("|").append(objEncryption.encrypt(cardNumber)).append("|")
//                            .append(BAPin).append("</UDF2>");
                    
                } else {

                    builder.append("<UDF2>").append(EMITenure).append("|").append(mobileNo).append("|")
                            .append(BAPin).append("</UDF2>");
                }

            } else {

                if (cardType.equalsIgnoreCase("AMEX")) {

                    builder.append("<UDF2>").append(EMITenure).append("|").append(maskCardNumber.maskCardNumber(cardNumber, "######xxxxx####")).append("|").append(maskCardNumber.maskCardNumber(expiryDate,"xxxx")).append("|").
                            append(maskCardNumber.maskCardNumber(batchCode,"xxxx")).append("|").append(otp).append("</UDF2>");
                    
//                    builder.append("<UDF2>").append(EMITenure).append("|").append(objEncryption.encrypt(cardNumber)).append("|").append(objEncryption.encrypt(expiryDate)).append("|").
//                            append(objEncryption.encrypt(batchCode)).append("|").append(otp).append("</UDF2>");
                    
                } else {

                    builder.append("<UDF2>").append(EMITenure).append("|").append(maskCardNumber.maskCardNumber(cardNumber, "######xxxxxx####")).append("|").append(maskCardNumber.maskCardNumber(expiryDate,"xxxx")).append("|").
                            append(maskCardNumber.maskCardNumber(cvvNumber,"xxx")).append("|").append(otp).append("</UDF2>");
                    
//                    builder.append("<UDF2>").append(EMITenure).append("|").append(objEncryption.encrypt(cardNumber)).append("|").append(objEncryption.encrypt(expiryDate)).append("|").
//                            append(objEncryption.encrypt(cvvNumber)).append("|").append(otp).append("</UDF2>");
                    
                    
                }
            }

            builder.append("<UDF3>").append(paymentType).append("</UDF3>");

            builder.append("<UDF4>").append(TransId).append("</UDF4>");

            builder.append("<UDF5>").append(atomTransUniqueId).append("</UDF5>");

            builder.append("</Request>");

        } else if (product.equalsIgnoreCase("DirectSales")) {

//            builder.append("<?xml version=\"1.0\" encoding=\"UTF-8\" ?>");

            builder.append("<Request>");

            builder.append("<atom>").append(atomMerchantId).append("</atom>");

            builder.append("<Method_type>").append(methodType).append("</Method_type>");

            builder.append("<Service_id>").append(serviceId).append("</Service_id>");

            builder.append("<Amount>").append(pricePoint).append("</Amount>");

            builder.append("<UDF0>").append(SubscriberId).append("</UDF0>");

            builder.append("<UDF1>").append(userANI).append("</UDF1>");

            if (rechargeOptionAgent.equalsIgnoreCase("4") || (rechargeOptionAgent.equalsIgnoreCase("3"))) {

                if (paymentType.equalsIgnoreCase("AXISDB")) {

                    builder.append("<UDF2>").append(EMITenure).append("|").append(maskCardNumber.maskCardNumber(cardNumber, "######xxxxxx####")).append("|")
                            .append(BAPin).append("</UDF2>");
                    
//                    builder.append("<UDF2>").append(EMITenure).append("|").append(objEncryption.encrypt(cardNumber)).append("|")
//                            .append(BAPin).append("</UDF2>");
                    
                } else {

                    builder.append("<UDF2>").append(EMITenure).append("|").append(mobileNo).append("|")
                            .append(BAPin).append("</UDF2>");
                }

            } else {

                if (cardType.equalsIgnoreCase("AMEX")) {
                                        builder.append("<UDF2>").append(EMITenure).append("|").append(maskCardNumber.maskCardNumber(cardNumber, "######xxxxx####")).append("|").append(maskCardNumber.maskCardNumber(expiryDate,"xxxx")).append("|").
                                                append(maskCardNumber.maskCardNumber(batchCode,"xxxx")).append("|").append(otp).append("</UDF2>");
                    
//                    builder.append("<UDF2>").append(EMITenure).append("|").append(objEncryption.encrypt(cardNumber)).append("|").append(objEncryption.encrypt(expiryDate)).append("|").
//                                                   append(objEncryption.encrypt(batchCode)).append("|").append(otp).append("</UDF2>");
                    
                    
                    
                } else {

                    builder.append("<UDF2>").append(EMITenure).append("|").append(maskCardNumber.maskCardNumber(cardNumber, "######xxxxxx####")).append("|").append(maskCardNumber.maskCardNumber(expiryDate,"xxxx")).append("|").
                            append(maskCardNumber.maskCardNumber(cvvNumber,"xxx")).append("|").append(otp).append("</UDF2>");
                    
//                    builder.append("<UDF2>").append(EMITenure).append("|").append(objEncryption.encrypt(cardNumber)).append("|").append(objEncryption.encrypt(expiryDate)).append("|").
//                            append(objEncryption.encrypt(cvvNumber)).append("|").append(otp).append("</UDF2>");
                    
                    
                }
            }

            builder.append("<UDF3>").append(paymentType).append("</UDF3>");

            builder.append("<UDF4>").append(tataSkyTransId).append("</UDF4>");

            builder.append("<UDF5>").append(hardwareAmount).append("</UDF5>");

            builder.append("<UDF6>").append(packageAmount).append("</UDF6>");

            builder.append("<UDF7>").append(bonusAmount).append("</UDF7>");

            builder.append("<UDF8>").append(packageName).append("</UDF8>");

            builder.append("</Request>");
        }

        atomMerchantId = methodType = serviceId = getAmount =
                SubscriberId = userANI = cardNumber = expiryDate = cvvNumber = batchCode = otp = paymentType =
                TransId = atomTransUniqueId = cardType = EMITenure = mobileNo = BAPin = rechargeOption = rechargeOptionAgent =
                pricePoint = tataSkyTransId = product = hardwareAmount = packageAmount = bonusAmount = packageName = srNumber = dbCallDetailId = null;

        return new String(builder);

    }

    private TransactionRechargeResponse makeTransactionRechargeRequest(String atomMerchantId, String methodType, String serviceId, String getAmount,
            String SubscriberId, String userANI, String cardNumber, String expiryDate,
            String cvvNumber, String batchCode, String otp, String paymentType,
            String TransId, String atomTransUniqueId, String cardType, String EMITenure,
            String mobileNo, String BAPin, String rechargeOption, String rechargeOptionAgent,
            String pricePoint, String tataSkyTransId, String product, String hardwareAmount, String packageAmount,
            String bonusAmount, String packageName, String srNumber, String dbCallDetailId) throws Exception {

        directcall directCall = new directcall();

        String strResponseXMLData = "";

        StringArray udfData = new StringArray();

        udfData.value = new ArrayList<String>();

        if (product.equalsIgnoreCase("Recharge")) {

            udfData.value.add(SubscriberId); // UDF[0]

            udfData.value.add(userANI);// UDF[1]

            if (rechargeOptionAgent.equalsIgnoreCase("4") || (rechargeOptionAgent.equalsIgnoreCase("3"))) {

                if (cardType.equalsIgnoreCase("AXISDB")) {

                    udfData.value.add("00" + "|" + cardNumber + "|" + BAPin); // UDF[2]

                } else {

                    udfData.value.add("00" + "|" + cardNumber + "|" + BAPin); // UDF[2]
                }

            } else {

                if (cardType.equalsIgnoreCase("AMEX")) {

                    udfData.value.add("90" + "|" + cardNumber + "|" + expiryDate + "|" + batchCode + "|" + otp); // UDF[2]

                } else {

                    udfData.value.add("00" + "|" + cardNumber + "|" + expiryDate + "|" + cvvNumber + "|" + otp); // UDF[2]
                }

            }

            udfData.value.add(paymentType);

            udfData.value.add(TransId);

            udfData.value.add(atomTransUniqueId);

            Logger.info(dbCallDetailId, "TransactionRecharge Request String 1 :" + atomMerchantId + " String 2 " + methodType + " String 3 "
                    + serviceId + " String 4 : " + getAmount + " UDF : " + udfData, false);

            //Call ATOM
            strResponseXMLData = directCall.delegate(atomMerchantId, methodType, serviceId, getAmount, udfData, dbCallDetailId);

        } else if (product.equalsIgnoreCase("DirectSales")) {

            udfData.value.add(srNumber);

            udfData.value.add(userANI);

            if (rechargeOptionAgent.equalsIgnoreCase("4") || (rechargeOptionAgent.equalsIgnoreCase("3"))) {

                if (cardType.equalsIgnoreCase("AXISDB")) {

                    udfData.value.add(EMITenure + "|" + cardNumber + "|" + BAPin); // UDF[2]

                } else {

                    udfData.value.add(EMITenure + "|" + cardNumber + "|" + BAPin); // UDF[2]
                }

            } else {

                if (cardType.equalsIgnoreCase("AMEX")) {

                    udfData.value.add(EMITenure + "|" + cardNumber + "|" + expiryDate + "|" + batchCode + "|" + otp); // UDF[2]

                } else {

                    udfData.value.add(EMITenure + "|" + cardNumber + "|" + expiryDate + "|" + cvvNumber + "|" + otp); // UDF[2]

                }

            }

            udfData.value.add(paymentType);

            udfData.value.add(tataSkyTransId);

            udfData.value.add(atomTransUniqueId);

            udfData.value.add(hardwareAmount);

            udfData.value.add(packageAmount);

            udfData.value.add(bonusAmount);

            udfData.value.add(packageName);

            Logger.info(dbCallDetailId, "TransactionRecharge Request String 1 :" + atomMerchantId + " String 2 : " + methodType + " String 3 : "
                    + serviceId + " String 4 : " + pricePoint + " UDF : " + udfData, false);

            //Call ATOM
            strResponseXMLData = directCall.delegate(atomMerchantId, methodType, serviceId, pricePoint, udfData, dbCallDetailId);
        }

        Logger.info(dbCallDetailId, "TransactionRecharge Response XML : " + strResponseXMLData, false);

        atomMerchantId = methodType = serviceId = getAmount =
                SubscriberId = userANI = cardNumber = expiryDate = cvvNumber = batchCode = otp = paymentType =
                TransId = atomTransUniqueId = cardType = EMITenure = mobileNo = BAPin = rechargeOption = rechargeOptionAgent =
                pricePoint = tataSkyTransId = product = hardwareAmount = packageAmount = bonusAmount = packageName = srNumber = dbCallDetailId = null;

        udfData = null;

        return new TransactionRechargeResponse(strResponseXMLData);

    }
}
