package com.jeequan.jeepay.mch.request;

import com.jeequan.jeepay.mch.response.JeepayFundAccountQueryResponse;
import com.jeequan.jeepay.model.JeepayObject;
import com.jeequan.jeepay.net.RequestOptions;
import com.jeequan.jeepay.request.JeepayRequest;
public class JeepayFundAccountQueryRequest implements JeepayRequest<JeepayFundAccountQueryResponse> {

    private String apiVersion = "1.0";
    private String apiUri = "api/billBalanceQuery";

    private RequestOptions options;
    private JeepayObject bizModel = null;

    public JeepayFundAccountQueryRequest() {
    }

    public String getApiUri() {
        return this.apiUri;
    }

    public String getApiVersion() {
        return this.apiVersion;
    }

    public void setApiVersion(String apiVersion) {
        this.apiVersion = apiVersion;
    }

    public RequestOptions getRequestOptions() {
        return this.options;
    }

    public void setRequestOptions(RequestOptions options) {
        this.options = options;
    }

    public JeepayObject getBizModel() {
        return this.bizModel;
    }

    public void setBizModel(JeepayObject bizModel) {
        this.bizModel = bizModel;
    }

    public Class<JeepayFundAccountQueryResponse> getResponseClass() {
        return JeepayFundAccountQueryResponse.class;
    }
}
