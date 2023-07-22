/*
 * Copyright (c) 2021-2031, 河北计全科技有限公司 (https://www.jeequan.com & jeequan@126.com).
 * <p>
 * Licensed under the GNU LESSER GENERAL PUBLIC LICENSE 3.0;
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * <p>
 * http://www.gnu.org/licenses/lgpl.html
 * <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.jeequan.jeepay.mch.ctrl.transfer;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.util.ObjectUtil;
import com.alibaba.fastjson.JSONObject;
import com.jeequan.jeepay.JeepayClient;
import com.jeequan.jeepay.core.cache.RedisUtil;
import com.jeequan.jeepay.core.constants.CS;
import com.jeequan.jeepay.core.constants.SmsConstants;
import com.jeequan.jeepay.core.entity.*;
import com.jeequan.jeepay.core.exception.BizException;
import com.jeequan.jeepay.core.model.ApiRes;
import com.jeequan.jeepay.core.model.DBApplicationConfig;
import com.jeequan.jeepay.core.utils.JeepayKit;
import com.jeequan.jeepay.core.utils.StringKit;
import com.jeequan.jeepay.exception.JeepayException;
import com.jeequan.jeepay.mch.ctrl.CommonCtrl;
import com.jeequan.jeepay.mch.model.AlipayFundAccountQueryReqModel;
import com.jeequan.jeepay.mch.request.JeepayFundAccountQueryRequest;
import com.jeequan.jeepay.mch.response.JeepayFundAccountQueryResponse;
import com.jeequan.jeepay.model.TransferOrderCreateReqModel;
import com.jeequan.jeepay.request.TransferOrderCreateRequest;
import com.jeequan.jeepay.response.TransferOrderCreateResponse;
import com.jeequan.jeepay.service.impl.*;
import com.jeequan.jeepay.util.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

/**
* 转账api
*
* @author terrfly
* @site https://www.jeequan.com
* @date 2021/8/13 14:43
*/

@RestController
@RequestMapping("/api/mchTransfers")
public class MchTransferController extends CommonCtrl {

    @Autowired private MchAppService mchAppService;
    @Autowired private MchInfoService mchInfoService;
    @Autowired private PayInterfaceConfigService payInterfaceConfigService;
    @Autowired private PayInterfaceDefineService payInterfaceDefineService;
    @Autowired private SysConfigService sysConfigService;
    /** 查询商户对应应用下支持的支付通道 **/
    @PreAuthorize("hasAuthority('ENT_MCH_TRANSFER_IF_CODE_LIST')")
    @GetMapping("/ifCodes/{appId}")
    public ApiRes ifCodeList(@PathVariable("appId") String appId) {


        List<String> ifCodeList = new ArrayList<>();
        payInterfaceConfigService.list(
                PayInterfaceConfig.gw().select(PayInterfaceConfig::getIfCode)
                        .eq(PayInterfaceConfig::getInfoType, CS.INFO_TYPE_MCH_APP)
                        .eq(PayInterfaceConfig::getInfoId, appId)
                        .eq(PayInterfaceConfig::getState, CS.PUB_USABLE)
        ).stream().forEach(r -> ifCodeList.add(r.getIfCode()));

        if(ifCodeList.isEmpty()){
            return ApiRes.ok(ifCodeList);
        }

        List<PayInterfaceDefine> result = payInterfaceDefineService.list(PayInterfaceDefine.gw().in(PayInterfaceDefine::getIfCode, ifCodeList));
        return ApiRes.ok(result);
    }



    /** 获取渠道侧用户ID **/
    @PreAuthorize("hasAuthority('ENT_MCH_TRANSFER_CHANNEL_USER')")
    @GetMapping("/channelUserId")
    public ApiRes channelUserId() {

        String appId = getValStringRequired("appId");
        MchApp mchApp = mchAppService.getById(appId);
        if(mchApp == null || mchApp.getState() != CS.PUB_USABLE || !mchApp.getMchNo().equals(getCurrentMchNo())){
            throw new BizException("商户应用不存在或不可用");
        }

        JSONObject param = getReqParamJSON();
        param.put("mchNo", getCurrentMchNo());
        param.put("appId", appId);
        param.put("ifCode", getValStringRequired("ifCode"));
        param.put("extParam", getValStringRequired("extParam"));
        param.put("reqTime", System.currentTimeMillis() + "");
        param.put("version", "1.0");
        param.put("signType", "MD5");

        DBApplicationConfig dbApplicationConfig = sysConfigService.getDBApplicationConfig();

        param.put("redirectUrl", dbApplicationConfig.getMchSiteUrl() + "/api/anon/channelUserIdCallback");

        param.put("sign", JeepayKit.getSign(param, mchApp.getAppSecret()));
        String url = StringKit.appendUrlQuery(dbApplicationConfig.getPaySiteUrl() + "/api/channelUserId/jump", param);

        return ApiRes.ok(url);
    }


    /** 调起下单接口 **/
    @PreAuthorize("hasAuthority('ENT_MCH_PAY_TEST_DO')")
    @PostMapping("/doTransfer")
    public ApiRes doTransfer() {

        handleParamAmount("amount");
        TransferOrderCreateReqModel model = getObject(TransferOrderCreateReqModel.class);
        String str = model.getExtParam();
        DBApplicationConfig dbApplicationConfig = sysConfigService.getDBApplicationConfig();
        String companyName = dbApplicationConfig.getCompanyName();
        String accountName = dbApplicationConfig.getAccountNumber();
        String noPhone = dbApplicationConfig.getNoPhone();
        if(!StringUtils.isEmpty(str) && str.indexOf("_")>0){
            String[] strings = str.split("_");
            if(!noPhone.equals(strings[0])){
                checkValidateCode(strings[0],strings[1]);
            }
        }else{
            throw new BizException("请输入手机号及验证码！");
        }
        model.setExtParam("");
        MchApp mchApp = mchAppService.getById(model.getAppId());

        MchInfo mchInfo =  mchInfoService.getOne(MchInfo.gw()
                .eq(MchInfo::getMchNo, mchApp.getMchNo()));

        if(mchApp == null || mchApp.getState() != CS.PUB_USABLE || !mchApp.getMchNo().equals(getCurrentMchNo())){
            throw new BizException("商户应用不存在或不可用");
        }
        Long balance  = 0L;
        Long mchIntegral = mchInfo.getIntegral();
        BigDecimal amount = new BigDecimal(model.getAmount()/100);
        if(!model.getAccountNo().equals(accountName)){
            if(mchIntegral<=-25){
                throw new BizException("商户积分("+mchIntegral+")不足！请向收款人账号:"+accountName+",收款人姓名："+companyName+"   充值！");
            }
            if( mchInfo.getIntegral()  <= 0  && model.getAmount()>1000 ){
                throw new BizException("商户积分不足！转账金额不得超过10元！请向收款人账号:"+accountName+",收款人姓名："+companyName+"   充值！");
            }
             //税率
            BigDecimal accountRate = sysConfigService.getDBApplicationConfig().getAccountRate();
            //扣减积分  不足5分，按5分计算
            Long integral =  amount.multiply(accountRate).longValue();
            if(integral<5){
                integral = 5L;
            }
            balance = mchIntegral - integral;
            //积分余额-扣减的积分 如果小于1 则提示充值！
            if( balance  <= 1  &&  mchIntegral >= 1){
                throw new BizException("商户积分("+mchIntegral+")不足！请向收款人账号:"+accountName+",收款人姓名："+companyName+"  充值！");
            }
        }

        TransferOrderCreateRequest request = new TransferOrderCreateRequest();
        model.setMchNo(this.getCurrentMchNo());
        model.setAppId(mchApp.getAppId());
        model.setCurrency("CNY");
        request.setBizModel(model);
        String url = sysConfigService.getDBApplicationConfig().getPaySiteUrl();
        JeepayClient jeepayClient = new JeepayClient(url, mchApp.getAppSecret());

        try {
            TransferOrderCreateResponse response = jeepayClient.execute(request);
            if(response.getCode() != 0){
                throw new BizException(response.getMsg());
            }
          //充值成功后，需要扣减积分
            //            mchInfo.setIntegral(balance);
            //           asyncThread(mchInfo);
            return ApiRes.ok(response.get());
        } catch (JeepayException e) {
            throw new BizException(e.getMessage());
        }

    }






    /** 发送手机短信 **/
    @PreAuthorize("hasAuthority('ENT_MCH_PAY_TEST_DO')")
    @PostMapping("/send/code")
    public ApiRes sendCode() {
        String appId = getValStringRequired("appId");
        String phone = getValStringRequired("extParam");
        MchApp mchApp = mchAppService.getOne(MchApp.gw()
                .eq(MchApp::getPhone,phone)
                .eq(MchApp::getAppId,appId)
        );
        //根据手机号查询是否有对应的商户
        if(BeanUtil.isEmpty(mchApp)){
            throw new BizException("商户应用手机号不匹配！");
        }else{
            //发送短信验证码
            boolean temp = payInterfaceConfigService.sendCommonCode(phone);
            if(temp){
                return ApiRes.ok(1);
            }
        }
       throw new BizException("验证码发送失败!");
    }

    /**
     * 检测手机验证码
     *
     * @param phone 手机号
     * @param code  验证码
     */
    private void checkValidateCode(String phone, String code) {
        Object validateCode = RedisUtil.getString(SmsConstants.SMS_VALIDATE_PHONE + phone);
        if (ObjectUtil.isNull(validateCode)) {
            throw new BizException("验证码已过期");
        }
        if (!validateCode.toString().equals(code)) {
            throw new BizException("验证码错误");
        }
        //删除验证码
        RedisUtil.del(SmsConstants.SMS_VALIDATE_PHONE + phone);
    }


    /**
     *  查询余额
     */
    @PreAuthorize("hasAuthority('ENT_MCH_PAY_TEST_DO')")
    @PostMapping("/getbillBalance")
    public ApiRes getbillBalance() {
        String appId = getValStringRequired("appId");
        MchApp mchApp = mchAppService.getOne(MchApp.gw()
                .eq(MchApp::getAppId,appId)
        );
        AlipayFundAccountQueryReqModel model = getObject(AlipayFundAccountQueryReqModel.class);
        JeepayFundAccountQueryRequest request = new JeepayFundAccountQueryRequest();
        String url = sysConfigService.getDBApplicationConfig().getPaySiteUrl();
        JeepayClient jeepayClient = new JeepayClient(url, mchApp.getAppSecret());
        model.setMchNo(this.getCurrentMchNo());
        model.setAppId(mchApp.getAppId());
        request.setBizModel(model);
        JeepayFundAccountQueryResponse response = null;
        try {
            response = jeepayClient.execute(request);
        }  catch (JeepayException e) {
            throw new RuntimeException(e);
        }
        if(response.getCode() != 0){
            throw new BizException(response.getMsg());
        }
        return ApiRes.ok(response.get());
    }

}
