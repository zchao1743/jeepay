package com.jeequan.jeepay.mch.response;

import com.jeequan.jeepay.mch.model.AlipayFundAccountQueryResModel;
import com.jeequan.jeepay.response.JeepayResponse;

public class JeepayFundAccountQueryResponse extends JeepayResponse {

    public JeepayFundAccountQueryResponse() {
    }

    public AlipayFundAccountQueryResModel get() {
        return this.getData() == null ? new AlipayFundAccountQueryResModel() : (AlipayFundAccountQueryResModel)this.getData().toJavaObject(AlipayFundAccountQueryResModel.class);
    }

    public boolean isSuccess(String apiKey) {
        if (!super.isSuccess(apiKey)) {
            return false;
        } else {
            return true;
        }
    }
}
