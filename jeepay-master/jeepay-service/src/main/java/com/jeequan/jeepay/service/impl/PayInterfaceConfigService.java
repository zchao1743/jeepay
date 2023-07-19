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
package com.jeequan.jeepay.service.impl;

import cn.hutool.core.date.DateTime;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.ReUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.crypto.SecureUtil;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jeequan.jeepay.core.cache.RedisUtil;
import com.jeequan.jeepay.core.constants.*;
import com.jeequan.jeepay.core.entity.*;
import com.jeequan.jeepay.core.exception.BizException;
import com.jeequan.jeepay.core.vo.OnePassLoginVo;
import com.jeequan.jeepay.core.vo.OnePassUserInfoVo;
import com.jeequan.jeepay.core.vo.OnePassUserSmsVo;
import com.jeequan.jeepay.core.vo.SendSmsVo;
import com.jeequan.jeepay.service.mapper.PayInterfaceConfigMapper;
import com.jeequan.jeepay.utils.OnePassUtil;
import com.jeequan.jeepay.utils.RestTemplateUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

/**
 * <p>
 * 支付接口配置参数表 服务实现类
 * </p>
 *
 * @author [mybatis plus generator]
 * @since 2021-04-27
 */
@Service
public class PayInterfaceConfigService extends ServiceImpl<PayInterfaceConfigMapper, PayInterfaceConfig> {

    @Value("${sms.account}")
    private String account;
    @Value("${sms.token}")
    private String token;
    @Value("${sms.code_expire}")
    private String sms_code_expire;
    @Autowired
    private OnePassUtil onePassUtil;
    @Autowired
    private RestTemplateUtil restTemplateUtil;

    private static final Logger logger = LoggerFactory.getLogger(MchPayPassageService.class);

    // 一号通token
    public static final String ONE_PASS_TOKEN_KEY_PREFIX = "one_pass_token_{}";

    //只校验手机为11位
    public static final String PHONE_TWO = "^1\\d{10}$";


    @Autowired
    private PayInterfaceDefineService payInterfaceDefineService;

    @Autowired
    private MchInfoService mchInfoService;

    @Autowired
    private MchAppService mchAppService;


    /**
     * @Author: ZhuXiao
     * @Description: 根据 账户类型、账户号、接口类型 获取支付参数配置
     * @Date: 17:20 2021/4/27
    */
    public PayInterfaceConfig getByInfoIdAndIfCode(Byte infoType, String infoId, String ifCode) {
        return getOne(PayInterfaceConfig.gw()
                .eq(PayInterfaceConfig::getInfoType, infoType)
                .eq(PayInterfaceConfig::getInfoId, infoId)
                .eq(PayInterfaceConfig::getIfCode, ifCode)
        );
    }

    /**
     * @Author: ZhuXiao
     * @Description: 根据 账户类型、账户号 获取支付参数配置列表
     * @Date: 14:19 2021/5/7
    */
    public List<PayInterfaceDefine> selectAllPayIfConfigListByIsvNo(Byte infoType, String infoId) {

        // 支付定义列表
        LambdaQueryWrapper<PayInterfaceDefine> queryWrapper = PayInterfaceDefine.gw();
        queryWrapper.eq(PayInterfaceDefine::getState, CS.YES);
        queryWrapper.eq(PayInterfaceDefine::getIsIsvMode, CS.YES); // 支持服务商模式

        List<PayInterfaceDefine> defineList = payInterfaceDefineService.list(queryWrapper);

        // 支付参数列表
        LambdaQueryWrapper<PayInterfaceConfig> wrapper = PayInterfaceConfig.gw();
        wrapper.eq(PayInterfaceConfig::getInfoId, infoId);
        wrapper.eq(PayInterfaceConfig::getInfoType, infoType);
        List<PayInterfaceConfig> configList = this.list(wrapper);

        for (PayInterfaceDefine define : defineList) {
            for (PayInterfaceConfig config : configList) {
                if (define.getIfCode().equals(config.getIfCode())) {
                    define.addExt("ifConfigState", config.getState()); // 配置状态
                }
            }
        }
        return defineList;
    }


    public List<PayInterfaceDefine> selectAllPayIfConfigListByAppId(String appId) {

        MchApp mchApp = mchAppService.getById(appId);
        if (mchApp == null|| mchApp.getState() != CS.YES) {
            throw new BizException(ApiCodeEnum.SYS_OPERATION_FAIL_SELETE);
        }
        MchInfo mchInfo = mchInfoService.getById(mchApp.getMchNo());
        if (mchInfo == null || mchInfo.getState() != CS.YES) {
            throw new BizException(ApiCodeEnum.SYS_OPERATION_FAIL_SELETE);
        }
        // 支付定义列表
        LambdaQueryWrapper<PayInterfaceDefine> queryWrapper = PayInterfaceDefine.gw();
        queryWrapper.eq(PayInterfaceDefine::getState, CS.YES);

        Map<String, PayInterfaceConfig> isvPayConfigMap = new HashMap<>(); // 服务商支付参数配置集合

        // 根据商户类型，添加接口是否支持该商户类型条件
        if (mchInfo.getType() == CS.MCH_TYPE_NORMAL) {
            queryWrapper.eq(PayInterfaceDefine::getIsMchMode, CS.YES); // 支持普通商户模式
        }
        if (mchInfo.getType() == CS.MCH_TYPE_ISVSUB) {
            queryWrapper.eq(PayInterfaceDefine::getIsIsvMode, CS.YES); // 支持服务商模式
            // 商户类型为特约商户，服务商应已经配置支付参数
            List<PayInterfaceConfig> isvConfigList = this.list(PayInterfaceConfig.gw()
                    .eq(PayInterfaceConfig::getInfoId, mchInfo.getIsvNo())
                    .eq(PayInterfaceConfig::getInfoType, CS.INFO_TYPE_ISV)
                    .eq(PayInterfaceConfig::getState, CS.YES)
                    .ne(PayInterfaceConfig::getIfParams, "")
                    .isNotNull(PayInterfaceConfig::getIfParams));

            for (PayInterfaceConfig config : isvConfigList) {
                config.addExt("mchType", mchInfo.getType());
                isvPayConfigMap.put(config.getIfCode(), config);
            }
        }

        List<PayInterfaceDefine> defineList = payInterfaceDefineService.list(queryWrapper);

        // 支付参数列表
        LambdaQueryWrapper<PayInterfaceConfig> wrapper = PayInterfaceConfig.gw();
        wrapper.eq(PayInterfaceConfig::getInfoId, appId);
        wrapper.eq(PayInterfaceConfig::getInfoType, CS.INFO_TYPE_MCH_APP);
        List<PayInterfaceConfig> configList = this.list(wrapper);

        for (PayInterfaceDefine define : defineList) {
            define.addExt("mchType", mchInfo.getType()); // 所属商户类型

            for (PayInterfaceConfig config : configList) {
                if (define.getIfCode().equals(config.getIfCode())) {
                    define.addExt("ifConfigState", config.getState()); // 配置状态
                }
            }

            if (mchInfo.getType() == CS.MCH_TYPE_ISVSUB && isvPayConfigMap.get(define.getIfCode()) == null) {
                define.addExt("subMchIsvConfig", CS.NO); // 特约商户，服务商支付参数的配置状态，0表示未配置
            }
        }
        return defineList;
    }



    /** 查询商户app使用已正确配置了通道信息 */
    public boolean mchAppHasAvailableIfCode(String appId, String ifCode){

        return this.count(
                PayInterfaceConfig.gw()
                        .eq(PayInterfaceConfig::getIfCode, ifCode)
                        .eq(PayInterfaceConfig::getState, CS.PUB_USABLE)
                        .eq(PayInterfaceConfig::getInfoId, appId)
                        .eq(PayInterfaceConfig::getInfoType, CS.INFO_TYPE_MCH_APP)
                ) > 0;

    }

    public static void isPhoneException(String phone) {
        boolean match = ReUtil.isMatch(PHONE_TWO, phone);
        if (!match) {
            throw new BizException("请输入正确的手机号");
        }
    }

    private OnePassUserInfoVo getInfo() {

        OnePassLoginVo loginVo = new OnePassLoginVo();
        loginVo.setAccount(account);
        String secret = SecureUtil.md5(account + SecureUtil.md5(token));
        loginVo.setSecret(secret);

        String accessToken = onePassUtil.getToken(loginVo);
        HashMap<String, String> header = onePassUtil.getCommonHeader(accessToken);
        JSONObject jsonObject = onePassUtil.postFrom(OnePassConstants.ONE_PASS_API_URL + OnePassConstants.USER_INFO_URI, null, header);
        OnePassUserInfoVo userInfoVo = jsonObject.getObject("data", OnePassUserInfoVo.class);
        userInfoVo.setAccount(loginVo.getAccount());
        return userInfoVo;
    }



    /**
     * 发短信之前的校验
     */
    private void beforeSendMessage() {
        OnePassUserInfoVo userInfoVo = getInfo();
        OnePassUserSmsVo userSmsVo = userInfoVo.getSms();
        Integer open = userSmsVo.getOpen();
        if (!open.equals(1)) {
            logger.error("发送短信请先开通一号通账号服务");
            throw new BizException("发送短信请先开通一号通账号服务");
        }
        if (userSmsVo.getNum() <= 0) {
            logger.error("一号通账号服务余量不足");
            throw new BizException("一号通账号服务余量不足");
        }
    }

    /**
     * 发送公共验证码
     *
     * @param phone 手机号
     * @return Boolean
     * 1.校验后台是否配置一号通
     * 2.一号通是否剩余短信条数
     * 3.发送短信
     */
    public Boolean sendCommonCode(String phone) {
        isPhoneException(phone);
        beforeSendMessage();
        DateTime dateTime = DateUtil.date();
        String clientIp = "";
        beforeSendCommonCodeCheck(phone, clientIp, dateTime);
        //获取短信验证码过期时间
        String codeExpireStr = sms_code_expire;
        if (StrUtil.isBlank(codeExpireStr) || Integer.parseInt(codeExpireStr) == 0) {
            codeExpireStr = Constants.NUM_FIVE + "";// 默认5分钟过期
        }
        Integer code = randomCount(111111, 999999);
        HashMap<String, Object> justPram = new HashMap<>();
        justPram.put("code", code);
        justPram.put("time", codeExpireStr);
        Boolean aBoolean = push(phone, SmsConstants.SMS_CONFIG_VERIFICATION_CODE_TEMP_ID, justPram);
        if (!aBoolean) {
            throw new BizException("发送短信失败，请联系后台管理员");
        }
        // 将验证码存入redis
        RedisUtil.set(SmsConstants.SMS_VALIDATE_PHONE + phone, code, Long.valueOf(codeExpireStr), TimeUnit.MINUTES);
        RedisUtil.set(SmsConstants.SMS_VALIDATE_PHONE_NUM + phone, 1, 60L);
//        redisUtil.incrAndCreate(StrUtil.format(SmsConstants.SMS_PHONE_HOUR_NUM, phone, dateTime.toDateStr() + dateTime.hour(true)));
//        redisUtil.incrAndCreate(StrUtil.format(SmsConstants.SMS_PHONE_DAY_NUM, phone, dateTime.toDateStr()));
//        redisUtil.incrAndCreate(StrUtil.format(SmsConstants.SMS_IP_HOUR_NUM, clientIp, dateTime.toDateStr() + dateTime.hour(true)));
        return aBoolean;
    }

    /**
     * 发送公共验证码前校验
     * @param phone 手机号
     * @param clientIp IP
     * @param dateTime 时间
     */
    private void beforeSendCommonCodeCheck(String phone, String clientIp, DateTime dateTime) {
        if (RedisUtil.hasKey(SmsConstants.SMS_VALIDATE_PHONE_NUM + phone)) {
            throw new BizException("您的短信发送过于频繁，请稍后再试");
        }
    }

    /**
     * 发送短信
     *
     * @param sendSmsVo 短信参数
     */
    private Boolean sendMessage(SendSmsVo sendSmsVo) {
        String result;
        try {
            String token = getToken(sendSmsVo.getUid(),sendSmsVo.getToken());
            HashMap<String, String> header = onePassUtil.getCommonHeader(token);

            Map<String, Object> map = JSONObject.parseObject(sendSmsVo.getParam());
            MultiValueMap<String, Object> param = new LinkedMultiValueMap<>();
            param.add("phone", sendSmsVo.getMobile());
            param.add("temp_id", sendSmsVo.getTemplate());
            map.forEach((key, value) -> param.add(StrUtil.format(SmsConstants.SMS_COMMON_PARAM_FORMAT, key), value));
            result = restTemplateUtil.postFromUrlencoded(OnePassConstants.ONE_PASS_API_URL + OnePassConstants.ONE_PASS_API_SEND_URI, param, header);
            checkResult(result);
        } catch (Exception e) {
            //接口请求异常，需要重新发送
            e.printStackTrace();
            logger.error("发送短信失败,{}", e.getMessage());
            return false;
        }
        return true;
    }

    public String getToken(String username ,String secret) {
        boolean exists = RedisUtil.hasKey(StrUtil.format(OnePassConstants.ONE_PASS_TOKEN_KEY_PREFIX, secret));
        if (exists) {
            Object token = RedisUtil.getString(StrUtil.format(OnePassConstants.ONE_PASS_TOKEN_KEY_PREFIX, secret));
            return token.toString();
        }
        // 缓存中不存在token，重新获取，存入缓存
        MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
        map.add("account", username);
        map.add("secret", secret);
        JSONObject jsonObject = onePassUtil.postFrom("https://sms.crmeb.net/api/user/info", map, null);
        String accessToken = "";
        Long expiresIn = 0L;
        accessToken = OnePassConstants.ONE_PASS_USER_TOKEN_PREFIX.concat(jsonObject.getJSONObject("data").getString("access_token"));
        expiresIn = jsonObject.getJSONObject("data").getLong("expires_in");
        expiresIn = expiresIn - System.currentTimeMillis() / 1000L;
        RedisUtil.set(StrUtil.format(OnePassConstants.ONE_PASS_TOKEN_KEY_PREFIX, secret), accessToken, expiresIn, TimeUnit.SECONDS);
        return accessToken;
    }


    public static Integer randomCount(Integer start, Integer end) {
        return (int) (Math.random() * (end - start + 1) + start);
    }


    /**
     * 组装发送对象
     *
     * @param phone     手机号
     * @param msgTempId 模板id
     * @param mapPram   参数map
     */
    private Boolean push(String phone, Integer msgTempId, HashMap<String, Object> mapPram) {
        if (StrUtil.isBlank(phone) || msgTempId <= 0) {
            return false;
        }
        OnePassLoginVo loginVo = new OnePassLoginVo();
        loginVo.setAccount(account);
        String secret = SecureUtil.md5(account + SecureUtil.md5(token));
        loginVo.setSecret(secret);

        SendSmsVo smsVo = new SendSmsVo();
        smsVo.setUid(loginVo.getAccount());
        smsVo.setToken(loginVo.getSecret());
        smsVo.setMobile(phone);
        smsVo.setTemplate(msgTempId);
        smsVo.setParam(JSONObject.toJSONString(mapPram));
        return sendMessage(smsVo);
    }

    /**
     * 检测结构请求返回的数据
     *
     * @param result 接口返回的结果
     * @return JSONObject
     */
    private JSONObject checkResult(String result) {
        if (StrUtil.isBlank(result)) {
            throw new BizException("短信平台接口异常，没任何数据返回！");
        }
        JSONObject jsonObject;
        try {
            jsonObject = JSONObject.parseObject(result);
        } catch (Exception e) {
            throw new BizException("短信平台接口异常！");
        }
        if (SmsConstants.SMS_ERROR_CODE.equals(jsonObject.getInteger("status"))) {
            throw new BizException("短信平台接口" + jsonObject.getString("msg"));
        }
        return jsonObject;
    }


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

}
