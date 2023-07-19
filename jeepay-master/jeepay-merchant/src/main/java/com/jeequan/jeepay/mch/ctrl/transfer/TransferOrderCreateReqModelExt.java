package com.jeequan.jeepay.mch.ctrl.transfer;

import com.jeequan.jeepay.ApiField;
import com.jeequan.jeepay.model.JeepayObject;

/**
 * 功能描述
 *
 * @author: scott
 * @date: 2023年06月27日 17:33
 */
public class TransferOrderCreateReqModelExt extends JeepayObject {
    private static final long serialVersionUID = -3998573128290306948L;
    @ApiField("phoneCode")
    private String phoneCode;      // 验证码

    @ApiField("phone")
    private String phone;      // 手机号

    @ApiField("mchNo")
    private String mchNo;      // 商户号
    @ApiField("appId")
    private String appId;      // 应用ID
    @ApiField("mchOrderNo")
    String mchOrderNo;          // 商户订单号
    @ApiField("ifCode")
    String ifCode;          // 支付接口代码
    @ApiField("entryType")
    String entryType;         // 入账方式
    @ApiField("amount")
    Long amount;          // 转账金额
    @ApiField("currency")
    String currency;            // 货币代码，当前只支持cny
    @ApiField("accountNo")
    String accountNo;        // 收款账号
    @ApiField("accountName")
    String accountName;        // 收款人姓名
    @ApiField("bankName")
    String bankName;        // 收款人开户行名称
    @ApiField("clientIp")
    String clientIp;            // 客户端IP
    @ApiField("transferDesc")
    String transferDesc;            // 转账备注信息
    @ApiField("notifyUrl")
    String notifyUrl;           // 异步通知地址
    @ApiField("channelExtra")
    String channelExtra;        // 特定渠道额外支付参数
    @ApiField("extParam")
    String extParam;            // 商户扩展参数

    public String getPhoneCode() {
        return phoneCode;
    }

    public void setPhoneCode(String phoneCode) {
        this.phoneCode = phoneCode;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getMchNo() {
        return mchNo;
    }

    public void setMchNo(String mchNo) {
        this.mchNo = mchNo;
    }

    public String getAppId() {
        return appId;
    }

    public void setAppId(String appId) {
        this.appId = appId;
    }

    public String getMchOrderNo() {
        return mchOrderNo;
    }

    public void setMchOrderNo(String mchOrderNo) {
        this.mchOrderNo = mchOrderNo;
    }

    public String getIfCode() {
        return ifCode;
    }

    public void setIfCode(String ifCode) {
        this.ifCode = ifCode;
    }

    public String getEntryType() {
        return entryType;
    }

    public void setEntryType(String entryType) {
        this.entryType = entryType;
    }

    public Long getAmount() {
        return amount;
    }

    public void setAmount(Long amount) {
        this.amount = amount;
    }

    public String getCurrency() {
        return currency;
    }

    public void setCurrency(String currency) {
        this.currency = currency;
    }

    public String getAccountNo() {
        return accountNo;
    }

    public void setAccountNo(String accountNo) {
        this.accountNo = accountNo;
    }

    public String getAccountName() {
        return accountName;
    }

    public void setAccountName(String accountName) {
        this.accountName = accountName;
    }

    public String getBankName() {
        return bankName;
    }

    public void setBankName(String bankName) {
        this.bankName = bankName;
    }

    public String getClientIp() {
        return clientIp;
    }

    public void setClientIp(String clientIp) {
        this.clientIp = clientIp;
    }

    public String getTransferDesc() {
        return transferDesc;
    }

    public void setTransferDesc(String transferDesc) {
        this.transferDesc = transferDesc;
    }

    public String getNotifyUrl() {
        return notifyUrl;
    }

    public void setNotifyUrl(String notifyUrl) {
        this.notifyUrl = notifyUrl;
    }

    public String getChannelExtra() {
        return channelExtra;
    }

    public void setChannelExtra(String channelExtra) {
        this.channelExtra = channelExtra;
    }

    public String getExtParam() {
        return extParam;
    }

    public void setExtParam(String extParam) {
        this.extParam = extParam;
    }
}
