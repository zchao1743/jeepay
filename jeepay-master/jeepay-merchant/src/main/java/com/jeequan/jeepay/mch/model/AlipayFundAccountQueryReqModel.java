package com.jeequan.jeepay.mch.model;

import com.jeequan.jeepay.ApiField;
import com.jeequan.jeepay.model.JeepayObject;

public class AlipayFundAccountQueryReqModel extends JeepayObject {
    @ApiField("mchNo")
    private String mchNo;
    @ApiField("appId")
    private String appId;

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
}
