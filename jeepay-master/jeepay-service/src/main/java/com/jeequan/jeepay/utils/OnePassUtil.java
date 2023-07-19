package com.jeequan.jeepay.utils;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.map.MapUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.http.HttpRequest;
import com.alibaba.fastjson.JSONObject;
import com.jeequan.jeepay.core.cache.RedisUtil;
import com.jeequan.jeepay.core.constants.OnePassConstants;
import com.jeequan.jeepay.core.exception.BizException;
import com.jeequan.jeepay.core.vo.OnePassLoginVo;
import org.apache.commons.lang3.StringUtils;
import org.apache.http.client.methods.HttpPost;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

/**
 * 一号通工具类
 */
@Component
public class OnePassUtil {

    @Autowired
    private RestTemplate restTemplate;

    /**
     * 获取一号通token
     */
    public String getToken(OnePassLoginVo loginVo) {
        boolean exists = RedisUtil.hasKey(StrUtil.format(OnePassConstants.ONE_PASS_TOKEN_KEY_PREFIX, loginVo.getSecret()));
        if (exists) {
            Object token = RedisUtil.getString(StrUtil.format(OnePassConstants.ONE_PASS_TOKEN_KEY_PREFIX, loginVo.getSecret()));
            return token.toString();
        }
        // 缓存中不存在token，重新获取，存入缓存
        MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
        map.add("account", loginVo.getAccount());
        map.add("secret", loginVo.getSecret());
        JSONObject jsonObject = postFrom("https://sms.crmeb.net/api/user/login", map, null);
        String accessToken = "";
        Long expiresIn = 0L;
        accessToken = OnePassConstants.ONE_PASS_USER_TOKEN_PREFIX.concat(jsonObject.getJSONObject("data").getString("access_token"));
        expiresIn = jsonObject.getJSONObject("data").getLong("expires_in");
        expiresIn = expiresIn - System.currentTimeMillis() / 1000L;
        RedisUtil.setString(StrUtil.format(OnePassConstants.ONE_PASS_TOKEN_KEY_PREFIX, loginVo.getSecret()), accessToken, expiresIn, TimeUnit.SECONDS);
        return accessToken;
    }


    /**
     * 清除token
     */
    public void removeToken(OnePassLoginVo loginVo) {
        boolean exists = RedisUtil.hasKey(StrUtil.format(OnePassConstants.ONE_PASS_TOKEN_KEY_PREFIX, loginVo.getSecret()));
        if (exists) {
            RedisUtil.del(StrUtil.format(OnePassConstants.ONE_PASS_TOKEN_KEY_PREFIX, loginVo.getSecret()));
        }
    }

    /**
     * post请求from表单模式提交
     */
    public JSONObject postFrom(String url, MultiValueMap<String, Object> param, Map<String, String> header) {
        String result = postFromUrlencoded(url, param, header);
        return checkResult(result);
    }

    /**
     * 检测结构请求返回的数据
     *
     * @param result 接口返回的结果
     * @return JSONObject
     */
    private JSONObject checkResult(String result) {
        if (StringUtils.isBlank(result)) {
            throw new BizException("一号通平台接口异常，没任何数据返回！");
        }
        JSONObject jsonObject = null;
        try {
            jsonObject = JSONObject.parseObject(result);
        } catch (Exception e) {
            throw new BizException("一号通平台接口异常！");
        }
        if (OnePassConstants.ONE_PASS_ERROR_CODE.equals(jsonObject.getInteger("status"))) {
            throw new BizException("一号通平台接口" + jsonObject.getString("msg"));
        }
        return jsonObject;
    }

    /**
     * 获取请求的headerMap
     *
     * @param accessToken accessToken
     * @return header
     */
    public HashMap<String, String> getCommonHeader(String accessToken) {
        HashMap<String, String> header = MapUtil.newHashMap();
        header.put("Authorization", accessToken);
        return header;
    }

    /**
     * post——from-urlencoded格式请求
     */
    public String postFromUrlencoded(String url, MultiValueMap<String, Object> params, Map<String, String> header) {
        HttpHeaders headers = new HttpHeaders();
        headers.add("user-agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36");
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

        if (CollUtil.isNotEmpty(header)) {
            for (Map.Entry<String, String> entry : header.entrySet()) {
                headers.add(entry.getKey(), entry.getValue());
            }
        }

        HttpEntity<MultiValueMap<String, Object>> requestEntity =
                new HttpEntity<>(params, headers);

        return restTemplate.postForEntity(url, requestEntity, String.class).getBody();
    }
}
