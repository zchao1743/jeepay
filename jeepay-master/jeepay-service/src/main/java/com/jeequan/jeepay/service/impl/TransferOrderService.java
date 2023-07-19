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

import cn.hutool.core.util.StrUtil;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jeequan.jeepay.core.entity.MchInfo;
import com.jeequan.jeepay.core.entity.TransferOrder;
import com.jeequan.jeepay.service.mapper.PayOrderMapper;
import com.jeequan.jeepay.service.mapper.TransferOrderMapper;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * <p>
 * 转账订单表 服务实现类
 * </p>
 *
 * @author [mybatis plus generator]
 * @since 2021-08-11
 */
@Service
public class TransferOrderService extends ServiceImpl<TransferOrderMapper, TransferOrder> {
    @Autowired private TransferOrderMapper transferOrderMapper;
    @Autowired
    private SysConfigService sysConfigService;
    @Autowired private MchInfoService mchInfoService;

    /** 更新转账订单状态  【转账订单生成】 --》 【转账中】 **/
    public boolean updateInit2Ing(String transferId){

        TransferOrder updateRecord = new TransferOrder();
        updateRecord.setState(TransferOrder.STATE_ING);

        return update(updateRecord, new LambdaUpdateWrapper<TransferOrder>()
                .eq(TransferOrder::getTransferId, transferId).eq(TransferOrder::getState, TransferOrder.STATE_INIT));
    }


    /** 更新转账订单状态  【转账中】 --》 【转账成功】 **/
    @Transactional
    public boolean updateIng2Success(String transferId, String channelOrderNo){

        TransferOrder updateRecord = new TransferOrder();
        updateRecord.setState(TransferOrder.STATE_SUCCESS);
        updateRecord.setChannelOrderNo(channelOrderNo);
        updateRecord.setSuccessTime(new Date());

        //更新转账订单表数据
        if(! update(updateRecord, new LambdaUpdateWrapper<TransferOrder>()
                .eq(TransferOrder::getTransferId, transferId).eq(TransferOrder::getState, TransferOrder.STATE_ING))
        ){
            return false;
        }
        //异步处理积分扣减
        asyncSetIntegral(transferId);
        return true;
    }


    /** 更新转账订单状态  【转账中】 --》 【转账失败】 **/
    @Transactional
    public boolean updateIng2Fail(String transferId, String channelOrderNo, String channelErrCode, String channelErrMsg){

        TransferOrder updateRecord = new TransferOrder();
        updateRecord.setState(TransferOrder.STATE_FAIL);
        updateRecord.setErrCode(channelErrCode);
        updateRecord.setErrMsg(channelErrMsg);
        updateRecord.setChannelOrderNo(channelOrderNo);

        return update(updateRecord, new LambdaUpdateWrapper<TransferOrder>()
                .eq(TransferOrder::getTransferId, transferId).eq(TransferOrder::getState, TransferOrder.STATE_ING));
    }


    /** 更新转账订单状态  【转账中】 --》 【转账成功/转账失败】 **/
    @Transactional
    public boolean updateIng2SuccessOrFail(String transferId, Byte updateState, String channelOrderNo, String channelErrCode, String channelErrMsg){

        if(updateState == TransferOrder.STATE_ING){
            return true;
        }else if(updateState == TransferOrder.STATE_SUCCESS){
            return updateIng2Success(transferId, channelOrderNo);
        }else if(updateState == TransferOrder.STATE_FAIL){
            return updateIng2Fail(transferId, channelOrderNo, channelErrCode, channelErrMsg);
        }
        return false;
    }



    /** 查询商户订单 **/
    public TransferOrder queryMchOrder(String mchNo, String mchOrderNo, String transferId){

        if(StringUtils.isNotEmpty(transferId)){
            return getOne(TransferOrder.gw().eq(TransferOrder::getMchNo, mchNo).eq(TransferOrder::getTransferId, transferId));
        }else if(StringUtils.isNotEmpty(mchOrderNo)){
            return getOne(TransferOrder.gw().eq(TransferOrder::getMchNo, mchNo).eq(TransferOrder::getMchOrderNo, mchOrderNo));
        }else{
            return null;
        }
    }


    public IPage<TransferOrder> pageList(IPage iPage, LambdaQueryWrapper<TransferOrder> wrapper, TransferOrder transferOrder, JSONObject paramJSON) {
        if (StringUtils.isNotEmpty(transferOrder.getTransferId())) {
            wrapper.eq(TransferOrder::getTransferId, transferOrder.getTransferId());
        }
        if (StringUtils.isNotEmpty(transferOrder.getMchOrderNo())) {
            wrapper.eq(TransferOrder::getMchOrderNo, transferOrder.getMchOrderNo());
        }
        if (StringUtils.isNotEmpty(transferOrder.getChannelOrderNo())) {
            wrapper.eq(TransferOrder::getChannelOrderNo, transferOrder.getChannelOrderNo());
        }
        if (StringUtils.isNotEmpty(transferOrder.getMchNo())) {
            wrapper.eq(TransferOrder::getMchNo, transferOrder.getMchNo());
        }
        if (transferOrder.getState() != null) {
            wrapper.eq(TransferOrder::getState, transferOrder.getState());
        }
        if (StringUtils.isNotEmpty(transferOrder.getAppId())) {
            wrapper.eq(TransferOrder::getAppId, transferOrder.getAppId());
        }
        if (paramJSON != null) {
            if (StringUtils.isNotEmpty(paramJSON.getString("createdStart"))) {
                wrapper.ge(TransferOrder::getCreatedAt, paramJSON.getString("createdStart"));
            }
            if (StringUtils.isNotEmpty(paramJSON.getString("createdEnd"))) {
                wrapper.le(TransferOrder::getCreatedAt, paramJSON.getString("createdEnd"));
            }
        }
        // 三合一订单
        if (paramJSON != null && StringUtils.isNotEmpty(paramJSON.getString("unionOrderId"))) {
            wrapper.and(wr -> {
                wr.eq(TransferOrder::getTransferId, paramJSON.getString("unionOrderId"))
                        .or().eq(TransferOrder::getMchOrderNo, paramJSON.getString("unionOrderId"))
                        .or().eq(TransferOrder::getChannelOrderNo, paramJSON.getString("unionOrderId"));
            });
        }
        wrapper.orderByDesc(TransferOrder::getCreatedAt);

        return page(iPage, wrapper);
    }

    @Async
    public void asyncSetIntegral(String transferId){
        //扣减积分
        TransferOrder transferOrder = this.getById(transferId);
        Long balance  = 0L;
        MchInfo mchInfo = mchInfoService.getById(transferOrder.getMchNo());
        BigDecimal amount = new BigDecimal(transferOrder.getAmount()/100);
        BigDecimal accountRate = sysConfigService.getDBApplicationConfig().getAccountRate();
        String accountNumber = sysConfigService.getDBApplicationConfig().getAccountNumber();
        Long integral =  amount.multiply(accountRate).longValue();
        if(integral<5){
            integral = 5L;
        }
        if(accountNumber.equals(transferOrder.getAccountNo())){
            balance = (mchInfo.getIntegral()>0?mchInfo.getIntegral():0) + amount.longValue();
        }else{
            balance = mchInfo.getIntegral() - integral;
        }
        mchInfo.setIntegral(balance);
        mchInfoService.updateById(mchInfo);
    }


    public Map transferPayCount(String mchNo, Byte state, Byte refundState, String dayStart, String dayEnd) {
        Map param = new HashMap<>();
        if (state != null) {
            param.put("state", state);
        }
        if (StrUtil.isNotBlank(mchNo)) {
            param.put("mchNo", mchNo);
        }
        if (StrUtil.isNotBlank(dayStart)) {
            param.put("createTimeStart", dayStart);
        }
        if (StrUtil.isNotBlank(dayEnd)) {
            param.put("createTimeEnd", dayEnd);
        }
        return transferOrderMapper.transferPayCount(param);
    }
}
