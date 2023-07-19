package com.jeequan.jeepay.pay.ctrl.bill;

import com.alibaba.fastjson.JSONObject;
import com.alipay.api.domain.AlipayFundAccountQueryModel;
import com.alipay.api.request.AlipayDataBillBalanceQueryRequest;
import com.alipay.api.request.AlipayFundAccountQueryRequest;
import com.alipay.api.response.AlipayDataBillBalanceQueryResponse;
import com.alipay.api.response.AlipayFundAccountQueryResponse;
import com.jeequan.jeepay.core.constants.ApiCodeEnum;
import com.jeequan.jeepay.core.constants.CS;
import com.jeequan.jeepay.core.entity.PayInterfaceConfig;
import com.jeequan.jeepay.core.exception.BizException;
import com.jeequan.jeepay.core.model.ApiRes;
import com.jeequan.jeepay.pay.channel.alipay.AlipayKit;
import com.jeequan.jeepay.pay.ctrl.ApiController;
import com.jeequan.jeepay.pay.model.MchAppConfigContext;
import com.jeequan.jeepay.pay.rqrs.AlipayFundAccountQueryRQ;
import com.jeequan.jeepay.pay.service.ConfigContextQueryService;
import com.jeequan.jeepay.service.impl.PayInterfaceConfigService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import java.text.SimpleDateFormat;
import java.util.Date;

@Slf4j
@RestController
public class AlipayFundAccountQueryController extends ApiController {

    @Autowired
    private ConfigContextQueryService configContextQueryService;
    @Autowired
    private PayInterfaceConfigService payInterfaceConfigService;
    @PostMapping("/api/billBalanceQuery")
    public ApiRes transferOrder(){


        AlipayFundAccountQueryRQ bizRQ = getRQByWithMchSign(AlipayFundAccountQueryRQ.class);

        String mchNo = bizRQ.getMchNo();
        String appId = bizRQ.getAppId();

        PayInterfaceConfig payInterfaceConfig= payInterfaceConfigService.getByInfoIdAndIfCode(CS.INFO_TYPE_MCH_APP,appId, "alipay");

        MchAppConfigContext mchAppConfigContext = configContextQueryService.queryMchInfoAndAppInfo(mchNo, appId);
            // 调起上游接口
        AlipayFundAccountQueryRequest request = new AlipayFundAccountQueryRequest();
        AlipayFundAccountQueryModel model = new AlipayFundAccountQueryModel();
        model.setAlipayUserId(payInterfaceConfig.getRemark());
        model.setAccountType("ACCTRANS_ACCOUNT");
        request.setBizModel(model);
        //统一放置 isv接口必传信息
        AlipayKit.putApiIsvInfo(mchAppConfigContext, request, model);

        // 调起支付宝接口
        AlipayFundAccountQueryResponse response = configContextQueryService.getAlipayClientWrapper(mchAppConfigContext).execute(request);
        if(response.isSuccess()){
            JSONObject jsonObject = JSONObject.parseObject(response.getBody());
            JSONObject query_response = JSONObject.parseObject(jsonObject.getString("alipay_fund_account_query_response"));
            String availableAmount = query_response.getString("available_amount");
            log.info("账户可用余额:"+availableAmount);
            // 调用成功
            return ApiRes.ok(query_response);
        }else{
            return ApiRes.fail(ApiCodeEnum.SYSTEM_ERROR);
        }
    }
}
