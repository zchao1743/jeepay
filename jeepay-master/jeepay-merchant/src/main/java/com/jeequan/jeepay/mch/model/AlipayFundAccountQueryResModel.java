package com.jeequan.jeepay.mch.model;

import com.jeequan.jeepay.model.JeepayObject;

public class AlipayFundAccountQueryResModel extends JeepayObject {


    /**
     * 账户可用余额
     */
    private String availableAmount;
    /**
     * 冻结金额
     */
    private String freezeAmount;



    public AlipayFundAccountQueryResModel() {
    }

    public String getAvailableAmount() {
        return availableAmount;
    }

    public void setAvailableAmount(String availableAmount) {
        this.availableAmount = availableAmount;
    }

    public String getFreezeAmount() {
        return freezeAmount;
    }

    public void setFreezeAmount(String freezeAmount) {
        this.freezeAmount = freezeAmount;
    }

}
