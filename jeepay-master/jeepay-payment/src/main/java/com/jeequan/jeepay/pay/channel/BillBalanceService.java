package com.jeequan.jeepay.pay.channel;

import com.jeequan.jeepay.core.entity.TransferOrder;
import com.jeequan.jeepay.pay.model.MchAppConfigContext;
import com.jeequan.jeepay.pay.rqrs.msg.ChannelRetMsg;

public interface BillBalanceService {

    ChannelRetMsg query(TransferOrder transferOrder, MchAppConfigContext mchAppConfigContext);
}
