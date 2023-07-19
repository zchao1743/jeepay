/*
Navicat MySQL Data Transfer

Source Server         : qianrui88
Source Server Version : 50726
Source Host           : 8.134.162.229:3306
Source Database       : jeepaydb

Target Server Type    : MYSQL
Target Server Version : 50726
File Encoding         : 65001

Date: 2023-06-09 11:13:50
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_isv_info
-- ----------------------------
DROP TABLE IF EXISTS `t_isv_info`;
CREATE TABLE `t_isv_info` (
  `isv_no` varchar(64) NOT NULL COMMENT '服务商号',
  `isv_name` varchar(64) NOT NULL COMMENT '服务商名称',
  `isv_short_name` varchar(32) NOT NULL COMMENT '服务商简称',
  `contact_name` varchar(32) DEFAULT NULL COMMENT '联系人姓名',
  `contact_tel` varchar(32) DEFAULT NULL COMMENT '联系人手机号',
  `contact_email` varchar(32) DEFAULT NULL COMMENT '联系人邮箱',
  `state` tinyint(6) NOT NULL DEFAULT '1' COMMENT '状态: 0-停用, 1-正常',
  `remark` varchar(128) DEFAULT NULL COMMENT '备注',
  `created_uid` bigint(20) DEFAULT NULL COMMENT '创建者用户ID',
  `created_by` varchar(64) DEFAULT NULL COMMENT '创建者姓名',
  `created_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `updated_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  PRIMARY KEY (`isv_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='服务商信息表';

-- ----------------------------
-- Records of t_isv_info
-- ----------------------------
INSERT INTO `t_isv_info` VALUES ('V1685405970', '张三', '张三', '张三', '18670055200', null, '1', null, '801', '超管', '2023-05-30 08:19:30.000000', '2023-05-30 08:19:30.000000');

-- ----------------------------
-- Table structure for t_mch_app
-- ----------------------------
DROP TABLE IF EXISTS `t_mch_app`;
CREATE TABLE `t_mch_app` (
  `app_id` varchar(64) NOT NULL COMMENT '应用ID',
  `app_name` varchar(64) NOT NULL DEFAULT '' COMMENT '应用名称',
  `mch_no` varchar(64) NOT NULL COMMENT '商户号',
  `state` tinyint(6) NOT NULL DEFAULT '1' COMMENT '应用状态: 0-停用, 1-正常',
  `app_secret` varchar(128) NOT NULL COMMENT '应用私钥',
  `remark` varchar(128) DEFAULT NULL COMMENT '备注',
  `created_uid` bigint(20) DEFAULT NULL COMMENT '创建者用户ID',
  `created_by` varchar(64) DEFAULT NULL COMMENT '创建者姓名',
  `created_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `updated_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  PRIMARY KEY (`app_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商户应用表';

-- ----------------------------
-- Records of t_mch_app
-- ----------------------------
INSERT INTO `t_mch_app` VALUES ('6475415de4b0859a5a9aa134', '默认应用', 'M1685406045', '1', 'ugs3bqx1fivyerm6t4e35pivlggyae0h4xv4m74cwxvn4sen3qsjgerzakdbg7yalgrzzr7w79e5wejfcz446x3kzl3gkpljj4ngejswy0p40q3oxcu648rsn7vq9fuq', null, '100002', '李四', '2023-05-30 08:20:45.126768', '2023-05-30 08:20:45.126768');
INSERT INTO `t_mch_app` VALUES ('6481c574e4b073567be3d33f', '默认应用', 'M1686226292', '1', 'bz6irsx3y5efylqw0edrr3vuyph17h7kbp71rvp5enmvso3pnc83yqd5fl86xke8th8js3h0vucr95ldkvdqt519no66bcd3tcnurp9yt2ryvybws1yed5lsal6tisb8', null, '100003', '超超', '2023-06-08 20:11:32.527309', '2023-06-08 20:11:32.527309');

-- ----------------------------
-- Table structure for t_mch_division_receiver
-- ----------------------------
DROP TABLE IF EXISTS `t_mch_division_receiver`;
CREATE TABLE `t_mch_division_receiver` (
  `receiver_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '分账接收者ID',
  `receiver_alias` varchar(64) NOT NULL COMMENT '接收者账号别名',
  `receiver_group_id` bigint(20) DEFAULT NULL COMMENT '组ID（便于商户接口使用）',
  `receiver_group_name` varchar(64) DEFAULT NULL COMMENT '组名称',
  `mch_no` varchar(64) NOT NULL COMMENT '商户号',
  `isv_no` varchar(64) DEFAULT NULL COMMENT '服务商号',
  `app_id` varchar(64) NOT NULL COMMENT '应用ID',
  `if_code` varchar(20) NOT NULL COMMENT '支付接口代码',
  `acc_type` tinyint(6) NOT NULL COMMENT '分账接收账号类型: 0-个人(对私) 1-商户(对公)',
  `acc_no` varchar(50) NOT NULL COMMENT '分账接收账号',
  `acc_name` varchar(30) NOT NULL DEFAULT '' COMMENT '分账接收账号名称',
  `relation_type` varchar(30) NOT NULL COMMENT '分账关系类型（参考微信）， 如： SERVICE_PROVIDER 服务商等',
  `relation_type_name` varchar(30) NOT NULL COMMENT '当选择自定义时，需要录入该字段。 否则为对应的名称',
  `division_profit` decimal(20,6) DEFAULT NULL COMMENT '分账比例',
  `state` tinyint(6) NOT NULL COMMENT '分账状态（本系统状态，并不调用上游关联关系）: 1-正常分账, 0-暂停分账',
  `channel_bind_result` text COMMENT '上游绑定返回信息，一般用作查询账号异常时的记录',
  `channel_ext_info` text COMMENT '渠道特殊信息',
  `bind_success_time` datetime DEFAULT NULL COMMENT '绑定成功时间',
  `created_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `updated_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  PRIMARY KEY (`receiver_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商户分账接收者账号绑定关系表';

-- ----------------------------
-- Records of t_mch_division_receiver
-- ----------------------------

-- ----------------------------
-- Table structure for t_mch_division_receiver_group
-- ----------------------------
DROP TABLE IF EXISTS `t_mch_division_receiver_group`;
CREATE TABLE `t_mch_division_receiver_group` (
  `receiver_group_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '组ID',
  `receiver_group_name` varchar(64) NOT NULL COMMENT '组名称',
  `mch_no` varchar(64) NOT NULL COMMENT '商户号',
  `auto_division_flag` tinyint(6) NOT NULL DEFAULT '0' COMMENT '自动分账组（当订单分账模式为自动分账，改组将完成分账逻辑） 0-否 1-是',
  `created_uid` bigint(20) NOT NULL COMMENT '创建者用户ID',
  `created_by` varchar(64) NOT NULL COMMENT '创建者姓名',
  `created_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `updated_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  PRIMARY KEY (`receiver_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='分账账号组';

-- ----------------------------
-- Records of t_mch_division_receiver_group
-- ----------------------------

-- ----------------------------
-- Table structure for t_mch_info
-- ----------------------------
DROP TABLE IF EXISTS `t_mch_info`;
CREATE TABLE `t_mch_info` (
  `mch_no` varchar(64) NOT NULL COMMENT '商户号',
  `mch_name` varchar(64) NOT NULL COMMENT '商户名称',
  `mch_short_name` varchar(32) NOT NULL COMMENT '商户简称',
  `type` tinyint(6) NOT NULL DEFAULT '1' COMMENT '类型: 1-普通商户, 2-特约商户(服务商模式)',
  `isv_no` varchar(64) DEFAULT NULL COMMENT '服务商号',
  `contact_name` varchar(32) DEFAULT NULL COMMENT '联系人姓名',
  `contact_tel` varchar(32) DEFAULT NULL COMMENT '联系人手机号',
  `contact_email` varchar(32) DEFAULT NULL COMMENT '联系人邮箱',
  `state` tinyint(6) NOT NULL DEFAULT '1' COMMENT '商户状态: 0-停用, 1-正常',
  `remark` varchar(128) DEFAULT NULL COMMENT '商户备注',
  `init_user_id` bigint(20) DEFAULT NULL COMMENT '初始用户ID（创建商户时，允许商户登录的用户）',
  `created_uid` bigint(20) DEFAULT NULL COMMENT '创建者用户ID',
  `created_by` varchar(64) DEFAULT NULL COMMENT '创建者姓名',
  `created_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `updated_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  PRIMARY KEY (`mch_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商户信息表';

-- ----------------------------
-- Records of t_mch_info
-- ----------------------------
INSERT INTO `t_mch_info` VALUES ('M1685406045', '李四', '李四', '1', null, '李四', '19119290099', null, '1', null, '100002', '801', '超管', '2023-05-30 08:20:45.030847', '2023-05-30 08:20:45.130183');
INSERT INTO `t_mch_info` VALUES ('M1686226292', '王五', '王五', '2', 'V1685405970', '超超', '18670055200', null, '1', null, '100003', '801', '超管', '2023-06-08 20:11:32.314295', '2023-06-08 20:11:32.547558');

-- ----------------------------
-- Table structure for t_mch_notify_record
-- ----------------------------
DROP TABLE IF EXISTS `t_mch_notify_record`;
CREATE TABLE `t_mch_notify_record` (
  `notify_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '商户通知记录ID',
  `order_id` varchar(64) NOT NULL COMMENT '订单ID',
  `order_type` tinyint(6) NOT NULL COMMENT '订单类型:1-支付,2-退款',
  `mch_order_no` varchar(64) NOT NULL COMMENT '商户订单号',
  `mch_no` varchar(64) NOT NULL COMMENT '商户号',
  `isv_no` varchar(64) DEFAULT NULL COMMENT '服务商号',
  `app_id` varchar(64) NOT NULL COMMENT '应用ID',
  `notify_url` text NOT NULL COMMENT '通知地址',
  `res_result` text COMMENT '通知响应结果',
  `notify_count` int(11) NOT NULL DEFAULT '0' COMMENT '通知次数',
  `notify_count_limit` int(11) NOT NULL DEFAULT '6' COMMENT '最大通知次数, 默认6次',
  `state` tinyint(6) NOT NULL DEFAULT '1' COMMENT '通知状态,1-通知中,2-通知成功,3-通知失败',
  `last_notify_time` datetime DEFAULT NULL COMMENT '最后一次通知时间',
  `created_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `updated_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  PRIMARY KEY (`notify_id`),
  UNIQUE KEY `Uni_OrderId_Type` (`order_id`,`order_type`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='商户通知记录表';

-- ----------------------------
-- Records of t_mch_notify_record
-- ----------------------------
INSERT INTO `t_mch_notify_record` VALUES ('1', 'P1665702042877112321', '1', 'M16859692825044780', 'M1685406045', null, '6475415de4b0859a5a9aa134', 'http://mch.qianrui88.com/api/anon/paytestNotify/payOrder?ifCode=alipay&amount=1&payOrderId=P1665702042877112321&mchOrderNo=M16859692825044780&subject=%E6%8E%A5%E5%8F%A3%E8%B0%83%E8%AF%95%5BM1685406045%E5%95%86%E6%88%B7%E8%81%94%E8%B0%83%5D&wayCode=ALI_WAP&sign=65C6EF8D6CDA8E7F6D3C4E1CB0CA8FF6&channelOrderNo=2023060522001419441451453432&reqTime=1685969368604&body=%E6%8E%A5%E5%8F%A3%E8%B0%83%E8%AF%95%5BM1685406045%E5%95%86%E6%88%B7%E8%81%94%E8%B0%83%5D&createdAt=1685969288926&appId=6475415de4b0859a5a9aa134&clientIp=222.244.148.160&successTime=1685969369000&currency=CNY&state=2&mchNo=M1685406045', 'SUCCESS', '1', '6', '2', '2023-06-06 10:21:40', '2023-06-05 20:49:28.625856', '2023-06-06 10:21:40.574096');
INSERT INTO `t_mch_notify_record` VALUES ('2', 'P1666777119274196994', '1', 'M16862256045449537', 'M1685406045', null, '6475415de4b0859a5a9aa134', 'http://mch.qianrui88.com/api/anon/paytestNotify/payOrder?ifCode=alipay&amount=1&payOrderId=P1666777119274196994&mchOrderNo=M16862256045449537&subject=%E6%8E%A5%E5%8F%A3%E8%B0%83%E8%AF%95%5BM1685406045%E5%95%86%E6%88%B7%E8%81%94%E8%B0%83%5D&wayCode=ALI_WAP&sign=7176CC4D79A456A04B4EFB2B73685FEB&channelOrderNo=2023060822001472401416314047&reqTime=1686225682776&body=%E6%8E%A5%E5%8F%A3%E8%B0%83%E8%AF%95%5BM1685406045%E5%95%86%E6%88%B7%E8%81%94%E8%B0%83%5D&createdAt=1686225607114&appId=6475415de4b0859a5a9aa134&clientIp=61.186.97.58&successTime=1686225683000&currency=CNY&state=2&mchNo=M1685406045', 'SUCCESS', '1', '6', '2', '2023-06-08 20:17:04', '2023-06-08 20:01:22.799497', '2023-06-08 20:17:04.287727');

-- ----------------------------
-- Table structure for t_mch_pay_passage
-- ----------------------------
DROP TABLE IF EXISTS `t_mch_pay_passage`;
CREATE TABLE `t_mch_pay_passage` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `mch_no` varchar(64) NOT NULL COMMENT '商户号',
  `app_id` varchar(64) NOT NULL COMMENT '应用ID',
  `if_code` varchar(20) NOT NULL COMMENT '支付接口',
  `way_code` varchar(20) NOT NULL COMMENT '支付方式',
  `rate` decimal(20,6) NOT NULL COMMENT '支付方式费率',
  `risk_config` varchar(4096) NOT NULL COMMENT '风控数据',
  `state` tinyint(6) NOT NULL COMMENT '状态: 0-停用, 1-启用',
  `created_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `updated_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `Uni_AppId_WayCode` (`app_id`,`if_code`,`way_code`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COMMENT='商户支付通道表';

-- ----------------------------
-- Records of t_mch_pay_passage
-- ----------------------------
INSERT INTO `t_mch_pay_passage` VALUES ('1', 'M1685406045', '6475415de4b0859a5a9aa134', 'alipay', 'ALI_WAP', '0.006000', null, '1', '2023-05-30 08:57:15.455882');
INSERT INTO `t_mch_pay_passage` VALUES ('2', 'M1685406045', '6475415de4b0859a5a9aa134', 'alipay', 'ALI_APP', '0.006000', null, '1', '2023-05-30 08:57:33.855964');
INSERT INTO `t_mch_pay_passage` VALUES ('3', 'M1685406045', '6475415de4b0859a5a9aa134', 'alipay', 'ALI_BAR', '0.006000', null, '1', '2023-05-30 08:57:37.465290');
INSERT INTO `t_mch_pay_passage` VALUES ('4', 'M1685406045', '6475415de4b0859a5a9aa134', 'alipay', 'ALI_JSAPI', '0.006000', null, '1', '2023-05-30 08:57:42.228057');
INSERT INTO `t_mch_pay_passage` VALUES ('5', 'M1685406045', '6475415de4b0859a5a9aa134', 'alipay', 'ALI_PC', '0.006000', null, '1', '2023-05-30 08:57:49.409742');
INSERT INTO `t_mch_pay_passage` VALUES ('6', 'M1685406045', '6475415de4b0859a5a9aa134', 'alipay', 'ALI_QR', '0.006000', null, '1', '2023-05-30 08:57:58.072831');
INSERT INTO `t_mch_pay_passage` VALUES ('7', 'M1686226292', '6481c574e4b073567be3d33f', 'alipay', 'ALI_WAP', '0.001000', null, '1', '2023-06-08 23:34:34.591958');
INSERT INTO `t_mch_pay_passage` VALUES ('8', 'M1686226292', '6481c574e4b073567be3d33f', 'alipay', 'ALI_APP', '0.003800', null, '1', '2023-06-08 23:34:52.801758');

-- ----------------------------
-- Table structure for t_order_snapshot
-- ----------------------------
DROP TABLE IF EXISTS `t_order_snapshot`;
CREATE TABLE `t_order_snapshot` (
  `order_id` varchar(64) NOT NULL COMMENT '订单ID',
  `order_type` tinyint(6) NOT NULL COMMENT '订单类型: 1-支付, 2-退款',
  `mch_req_data` text COMMENT '下游请求数据',
  `mch_req_time` datetime DEFAULT NULL COMMENT '下游请求时间',
  `mch_resp_data` text COMMENT '向下游响应数据',
  `mch_resp_time` datetime DEFAULT NULL COMMENT '向下游响应时间',
  `channel_req_data` text COMMENT '向上游请求数据',
  `channel_req_time` datetime DEFAULT NULL COMMENT '向上游请求时间',
  `channel_resp_data` text COMMENT '上游响应数据',
  `channel_resp_time` datetime DEFAULT NULL COMMENT '上游响应时间',
  `created_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `updated_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  PRIMARY KEY (`order_id`,`order_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单接口数据快照';

-- ----------------------------
-- Records of t_order_snapshot
-- ----------------------------

-- ----------------------------
-- Table structure for t_pay_interface_config
-- ----------------------------
DROP TABLE IF EXISTS `t_pay_interface_config`;
CREATE TABLE `t_pay_interface_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `info_type` tinyint(6) NOT NULL COMMENT '账号类型:1-服务商 2-商户 3-商户应用',
  `info_id` varchar(64) NOT NULL COMMENT '服务商号/商户号/应用ID',
  `if_code` varchar(20) NOT NULL COMMENT '支付接口代码',
  `if_params` varchar(4096) NOT NULL COMMENT '接口配置参数,json字符串',
  `if_rate` decimal(20,6) DEFAULT NULL COMMENT '支付接口费率',
  `state` tinyint(6) NOT NULL DEFAULT '1' COMMENT '状态: 0-停用, 1-启用',
  `remark` varchar(128) DEFAULT NULL COMMENT '备注',
  `created_uid` bigint(20) DEFAULT NULL COMMENT '创建者用户ID',
  `created_by` varchar(64) DEFAULT NULL COMMENT '创建者姓名',
  `created_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `updated_uid` bigint(20) DEFAULT NULL COMMENT '更新者用户ID',
  `updated_by` varchar(64) DEFAULT NULL COMMENT '更新者姓名',
  `updated_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `Uni_InfoType_InfoId_IfCode` (`info_type`,`info_id`,`if_code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='支付接口配置参数表';

-- ----------------------------
-- Records of t_pay_interface_config
-- ----------------------------
INSERT INTO `t_pay_interface_config` VALUES ('1', '3', '6475415de4b0859a5a9aa134', 'alipay', '{\"privateKey\":\"MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCMfr8Tzc+g5jRD79qf3pjDEySpZ0u2hFlxPilGFAkCR9wa7xrz3JdNKo9HP2F2olnYLn9P4rVnkqy+UzuYujy6Ke0Iu8kFUchxLNX4Q0v7EAQhDswI1oFruBxylRAKkqi1xnRrxUXqM3JEx5kxsAzSaCyyu9Oa8r6YSUqpn8IaxVyTHkhq/ElzkA5vbcRYZaA5CYTqUvq9dsTjKQGcMyr3JEDv87AikrljNpSgApS+53v9+xtw0oOKV830Kae+A748SUKO/Sjvqhv7t+pI+6Ndqntsz9IRemZvVy4GyyphktUaru+5E4upcMk3f5j5Sn/0S6A5RCn2lA4YAEwWFbaVAgMBAAECggEAW1QBDfSZ5bP/gbInYgknMJf/GwgE1a6PHegUmHNpr8varr+Du8ZHrGfgH6Z5ys6arMb9B4cN+TgFhutAMHXQCAw9A5JeiFCzha5poSrN93Rf2sVtqMkX9FgIVgvEE7tmZFOPVoc0fZvXyhId6YjRrOz/MWibk3v8na33FPC/Evr/4GLUiBJmQQQoFtGRg6M8VEvTb5cUv5ABnGd++jH8cZsfmCLp0OLFsleGALJcAFFgWqYZ+h5YGDZCHZs1AOTFeXT5Z0ni1E6/2VPH2AxoZPpzRC3222kG5/tnfkMlN7yN107rkGLgZ8kcT2BZlEErNvdaPTDIwOS8QgrEZDtLwQKBgQDtwWdmMPVJUDzAb/OcVJ2L7J5e6Mkb0ztnhk13chjGxNiOWhmQFBC/WgV+sC6H7Cbuh1C161wMwaWnX3VqzxFEFEO9lTKCaZPFBDHDB1l/yR9HQqjyhuN9jb1EIexG3GlXFZfeVslFxvqdIpsru68B1FrMXesFK4+0TPX1p8pn7QKBgQCXRrUci69+c/QBb6IaVK8FgcQ3kXEKAifXDoQlnzb9q+kd8tJo6YxVOTJ6TLPx+4WNF0ARUgXaH4mTQy0ym/BPym7ampySaogzCC76at3IYLEuCylXvUJMr7xcauft+ICUK5eGflyuHVd9NrIQjXOxCHpPBzuLDta/KX9VFCvkSQKBgBkQg5MNZD53XAA5jSgU74r5xfRhfBoX2bJfQTlvaNdDl0TikMFUrDNQDTY+4pjnt278CvEyv8CEha8wbBN3gu13aXDKEsoW0UI63/gchT3oeQitKVxwBfmNgL93CA6sW9qXZyxEX/GgOXlpVYx1u8xok63p1MX1wq+SUXe1Waw9AoGAfaqFRWNcs+VLK+46cTkr850rDSZLCw9jXSl36XDr06r9ip1u4SwyIZHUNviE+14AQYaw+DJ1Hg/Yz3ack1ArP31gvUR3EMJixlHkBK7F8nEwfplTDMnxy5apGPTOGke3OF9GDrnl79X8Gc5X+ZwoIUZzpDbT5d670i1804ZgN9ECgYA7Uc79EHAHOBkGSYZsqP3zdooJKz/o8WGrDFjNeoI6oescrO7y0Whj81o5FPUrIkzzF/0mvJBBRfGF4b2lc2721SHXjX8xWD02mLJMAroRYdN4prTPKc35swhcubSyPRqApGmqKfYl7Vk++U4EpkUtdOelvm/nPIVlgYFJpB457Q==\",\"alipayPublicCert\":\"\",\"alipayPublicKey\":\"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA0masrzmVP733OM4id1E1K9cozg7WnsgaUwltu/NVh75RwWlafLfyG5urJiEPmpkCnGTYdZ/15OG/oh1impGgzlKMALjISav9VwwQB/YI6qgbzMaiUISu9VdQO0lonaqLn/8AdRu0xS0CLJoghcZdjeBohWdULP7Et5qqErZo4N8cY8PILSJyEG2nMbtYGKGtCqH1hYNd6T6abSNZ18s8SJCCzeJ3HoEjTnNiSEkhzHdRqGVtZaBOgJ6ith7MmtIxT9roUzTacuPY9TYcoJ2r5aIdlINnT8RKYhaTLVIBnQUhaCnwoMD7fxJvxqbNCY3GzxmdQHVsjdHXTt1uGKNH8wIDAQAB\",\"appPublicCert\":\"\",\"appId\":\"2021003127666952 \",\"sandbox\":0,\"alipayRootCert\":\"\",\"signType\":\"RSA2\",\"useCert\":0}', null, '1', null, '100002', '李四', '2023-05-30 08:56:28.502580', '100002', '李四', '2023-06-05 20:47:55.532439');
INSERT INTO `t_pay_interface_config` VALUES ('2', '1', 'V1685405970', 'alipay', '{\"privateKey\":\"MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCKD4tDQ3D7QsetvEp6bbC1PqtGOGfGg/JNOPJ4BENEVC5RPd0ARYgg/0X/4xg8y3IEgDBtlx96kY03NO/j+jVEuSLO5RYmVRW4mDX13DhISCJ2mplKO0FlmeofnQQ6RnCMJJVHeY7jex8OS+sUqG+NMbi/MdCgilHpABQKIselkCUpybmIe5Gx19FVd6xnoAsUDosqFC1/V7joVw+vpwNX86kkKETRq0y6YsaL31AbGghORsJGqkhWpGqvbtGcS9MqYKZZ0mfctmVpbJMFCAcOWPXM1+6F3YBk6z9ppLe9tj6Wssj5b5iPrfi7FUc9x54lYHMlwhHdSdjOWGVC3xJ1AgMBAAECggEAH4m7e2sdlRhFOwfnT55dHpopUAo0kqGzqTZYFViL8UD1r7NdF+HKXhdSa0j6UXD8I9EQvwgltb8oLjNWlZKjtoZAUFj+vVT0eE21Dev3o3NvA/7/A3kT0FzfocchnxpWPX1h6Ij5Pjfy+TYYhoiPqwZvuKVtji7q1ToiWcpmJwi3Z/2+XHM0GArN1G5YjUZX8bD4iwv54QJln8rRbVpq/86dfR5CNmN6Fbl8Sn5jZvkWXzWed6uKAkzwhdokXGz1br2+v/7d3IUv7YYRb/ezok2YTuQwE6QyB7CbsNyElyA4yJprE844ewWvA8uurGfdnjYJrJx35XSUmdBxMJ/IgQKBgQDNmRw2E4b9QLNaIDWAgs6X8L+MkzwcH2ElqqpR67xwFGxBI9O4Mo8vzAEYvwn6hC7PKSEFaMPeJ7jU2lIXbxSPGmsFHbpnJNtxCHxyLl2v9mHLIa9TA7IPcGlgqKbzhTisisWZb+y3lKWtLzEZqO9K1grivDEPL+f4C0eaNU6o4QKBgQCr5+9kiYineEH3AeNNbtCS7Pv0Rx3AImHh2FnwzhfiLNgcpbkfzg3K3bvYcnvezwPBZAGTzi9vpA3j7jQH0Rgc0tePYxZy/TGgHbx0HRRmRzDm6UGf+XPl/NLu9NWF6lS0JXy1izu0cuGu6/84x73fKtCqwH+/hygC9GXHW7o4FQKBgQCpMRLSPYec6Z2u0Uq2Eu9IgkpfuNqCmiAsCyJWgBR2d5gOkxksQA8tWkicwLnJevW6bTJLbUeijjXAlFlyB2t3yFnBwBEhyGb9weoHXLikkbEwpOvO+P+TTQKrFJ8vT7av5xNtjXnUKXOd7XQOlcM2ZqZWqGAHC3lt2np2IOA2gQKBgHQFAh2hcRhN4n9Zx9Xvz1cKGHXiNWMCEXvCb9lEzvu39ldHRe0APXDIO8o2YgGbR9aSrznZM0yutS07C+SmqxZw+kjswC71UTPWPeVD5wusSoXdsYvNaPo0qwvZM+7Am1BF6KgCA1ajHkvXPRZOQIhItjI330AdcNSlq7dj4geNAoGAY1r357dGRK+FtsLxwwncKCaFVMyWHBGoGWYaqfBrTwMbECiwxFawVCmDAvOidbU07c8SmYFXFjhwZ5edg0sXZDfAdR+de1S/3YbrFSk1OEDSS9OdCTiWhFbyiczVzIb8EXutEBSbgMvc9CxZPwzMo+NYip4sk/a1mkkyUvdN4OE=\",\"alipayPublicKey\":\"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA0masrzmVP733OM4id1E1K9cozg7WnsgaUwltu/NVh75RwWlafLfyG5urJiEPmpkCnGTYdZ/15OG/oh1impGgzlKMALjISav9VwwQB/YI6qgbzMaiUISu9VdQO0lonaqLn/8AdRu0xS0CLJoghcZdjeBohWdULP7Et5qqErZo4N8cY8PILSJyEG2nMbtYGKGtCqH1hYNd6T6abSNZ18s8SJCCzeJ3HoEjTnNiSEkhzHdRqGVtZaBOgJ6ith7MmtIxT9roUzTacuPY9TYcoJ2r5aIdlINnT8RKYhaTLVIBnQUhaCnwoMD7fxJvxqbNCY3GzxmdQHVsjdHXTt1uGKNH8wIDAQAB\",\"appId\":\"2021003145631330\",\"sandbox\":0,\"signType\":\"RSA2\",\"pid\":\"PID2088441939131900\",\"useCert\":0}', '0.001000', '1', null, '801', '超管', '2023-06-08 20:03:52.570465', '801', '超管', '2023-06-08 20:07:10.425450');
INSERT INTO `t_pay_interface_config` VALUES ('3', '3', '6481c574e4b073567be3d33f', 'alipay', '{\"alipayPublicCert\":\"\",\"appPublicCert\":\"\",\"appAuthToken\":\"202306BB223cae0f57d54bb686c95b2e318eaC38\",\"sandbox\":0,\"alipayRootCert\":\"\",\"signType\":\"RSA2\",\"useCert\":0}', null, '1', null, '801', '超管', '2023-06-08 23:27:39.881643', '801', '超管', '2023-06-08 23:33:54.430056');

-- ----------------------------
-- Table structure for t_pay_interface_define
-- ----------------------------
DROP TABLE IF EXISTS `t_pay_interface_define`;
CREATE TABLE `t_pay_interface_define` (
  `if_code` varchar(20) NOT NULL COMMENT '接口代码 全小写  wxpay alipay ',
  `if_name` varchar(20) NOT NULL COMMENT '接口名称',
  `is_mch_mode` tinyint(6) NOT NULL DEFAULT '1' COMMENT '是否支持普通商户模式: 0-不支持, 1-支持',
  `is_isv_mode` tinyint(6) NOT NULL DEFAULT '1' COMMENT '是否支持服务商子商户模式: 0-不支持, 1-支持',
  `config_page_type` tinyint(6) NOT NULL DEFAULT '1' COMMENT '支付参数配置页面类型:1-JSON渲染,2-自定义',
  `isv_params` varchar(4096) DEFAULT NULL COMMENT 'ISV接口配置定义描述,json字符串',
  `isvsub_mch_params` varchar(4096) DEFAULT NULL COMMENT '特约商户接口配置定义描述,json字符串',
  `normal_mch_params` varchar(4096) DEFAULT NULL COMMENT '普通商户接口配置定义描述,json字符串',
  `way_codes` json NOT NULL COMMENT '支持的支付方式 ["wxpay_jsapi", "wxpay_bar"]',
  `icon` varchar(256) DEFAULT NULL COMMENT '页面展示：卡片-图标',
  `bg_color` varchar(20) DEFAULT NULL COMMENT '页面展示：卡片-背景色',
  `state` tinyint(6) NOT NULL DEFAULT '1' COMMENT '状态: 0-停用, 1-启用',
  `remark` varchar(128) DEFAULT NULL COMMENT '备注',
  `created_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `updated_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  PRIMARY KEY (`if_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='支付接口定义表';

-- ----------------------------
-- Records of t_pay_interface_define
-- ----------------------------
INSERT INTO `t_pay_interface_define` VALUES ('alipay', '支付宝官方', '1', '1', '2', '[{\"name\":\"sandbox\",\"desc\":\"环境配置\",\"type\":\"radio\",\"verify\":\"\",\"values\":\"1,0\",\"titles\":\"沙箱环境,生产环境\",\"verify\":\"required\"},{\"name\":\"pid\",\"desc\":\"合作伙伴身份（PID）\",\"type\":\"text\",\"verify\":\"required\"},{\"name\":\"appId\",\"desc\":\"应用App ID\",\"type\":\"text\",\"verify\":\"required\"},{\"name\":\"privateKey\", \"desc\":\"应用私钥\", \"type\": \"textarea\",\"verify\":\"required\",\"star\":\"1\"},{\"name\":\"alipayPublicKey\", \"desc\":\"支付宝公钥(不使用证书时必填)\", \"type\": \"textarea\",\"star\":\"1\"},{\"name\":\"signType\",\"desc\":\"接口签名方式(推荐使用RSA2)\",\"type\":\"radio\",\"verify\":\"\",\"values\":\"RSA,RSA2\",\"titles\":\"RSA,RSA2\",\"verify\":\"required\"},{\"name\":\"useCert\",\"desc\":\"公钥证书\",\"type\":\"radio\",\"verify\":\"\",\"values\":\"1,0\",\"titles\":\"使用证书（请使用RSA2私钥）,不使用证书\"},{\"name\":\"appPublicCert\",\"desc\":\"应用公钥证书（.crt格式）\",\"type\":\"file\",\"verify\":\"\"},{\"name\":\"alipayPublicCert\",\"desc\":\"支付宝公钥证书（.crt格式）\",\"type\":\"file\",\"verify\":\"\"},{\"name\":\"alipayRootCert\",\"desc\":\"支付宝根证书（.crt格式）\",\"type\":\"file\",\"verify\":\"\"}]', '[{\"name\":\"appAuthToken\", \"desc\":\"子商户app_auth_token\", \"type\": \"text\",\"readonly\":\"readonly\"},{\"name\":\"refreshToken\", \"desc\":\"子商户刷新token\", \"type\": \"hidden\",\"readonly\":\"readonly\"},{\"name\":\"expireTimestamp\", \"desc\":\"authToken有效期（13位时间戳）\", \"type\": \"hidden\",\"readonly\":\"readonly\"}]', '[{\"name\":\"sandbox\",\"desc\":\"环境配置\",\"type\":\"radio\",\"verify\":\"\",\"values\":\"1,0\",\"titles\":\"沙箱环境,生产环境\",\"verify\":\"required\"},{\"name\":\"appId\",\"desc\":\"应用App ID\",\"type\":\"text\",\"verify\":\"required\"},{\"name\":\"privateKey\", \"desc\":\"应用私钥\", \"type\": \"textarea\",\"verify\":\"required\",\"star\":\"1\"},{\"name\":\"alipayPublicKey\", \"desc\":\"支付宝公钥(不使用证书时必填)\", \"type\": \"textarea\",\"star\":\"1\"},{\"name\":\"signType\",\"desc\":\"接口签名方式(推荐使用RSA2)\",\"type\":\"radio\",\"verify\":\"\",\"values\":\"RSA,RSA2\",\"titles\":\"RSA,RSA2\",\"verify\":\"required\"},{\"name\":\"useCert\",\"desc\":\"公钥证书\",\"type\":\"radio\",\"verify\":\"\",\"values\":\"1,0\",\"titles\":\"使用证书（请使用RSA2私钥）,不使用证书\"},{\"name\":\"appPublicCert\",\"desc\":\"应用公钥证书（.crt格式）\",\"type\":\"file\",\"verify\":\"\"},{\"name\":\"alipayPublicCert\",\"desc\":\"支付宝公钥证书（.crt格式）\",\"type\":\"file\",\"verify\":\"\"},{\"name\":\"alipayRootCert\",\"desc\":\"支付宝根证书（.crt格式）\",\"type\":\"file\",\"verify\":\"\"}]', '[{\"wayCode\": \"ALI_APP\"}, {\"wayCode\": \"ALI_PC\"}, {\"wayCode\": \"ALI_WAP\"}]', 'http://jeequan.oss-cn-beijing.aliyuncs.com/jeepay/img/alipay.png', '#1779FF', '1', '支付宝官方通道', '2023-05-29 10:39:10.000000');
INSERT INTO `t_pay_interface_define` VALUES ('plspay', '计全付', '1', '0', '1', null, null, '[{\"name\":\"signType\",\"desc\":\"签名方式\",\"type\":\"radio\",\"verify\":\"required\",\"values\":\"MD5,RSA2\",\"titles\":\"MD5,RSA2\"},{\"name\":\"merchantNo\",\"desc\":\"计全付商户号\",\"type\":\"text\",\"verify\":\"required\"},{\"name\":\"appId\",\"desc\":\"应用ID\",\"type\":\"text\",\"verify\":\"required\"},{\"name\":\"appSecret\",\"desc\":\"md5秘钥\",\"type\":\"textarea\",\"verify\":\"required\",\"star\":\"1\"},{\"name\":\"rsa2AppPrivateKey\",\"desc\":\"RSA2: 应用私钥\",\"type\":\"textarea\",\"verify\":\"required\",\"star\":\"1\"},{\"name\":\"rsa2PayPublicKey\",\"desc\":\"RSA2: 支付网关公钥\",\"type\":\"textarea\",\"verify\":\"required\",\"star\":\"1\"}]', '[{\"wayCode\": \"ALI_APP\"}, {\"wayCode\": \"ALI_BAR\"}, {\"wayCode\": \"ALI_JSAPI\"}, {\"wayCode\": \"ALI_LITE\"}, {\"wayCode\": \"ALI_PC\"}, {\"wayCode\": \"ALI_QR\"}, {\"wayCode\": \"ALI_WAP\"}, {\"wayCode\": \"WX_APP\"}, {\"wayCode\": \"WX_BAR\"}, {\"wayCode\": \"WX_H5\"}, {\"wayCode\": \"WX_JSAPI\"}, {\"wayCode\": \"WX_LITE\"}, {\"wayCode\": \"WX_NATIVE\"}]', 'http://jeequan.oss-cn-beijing.aliyuncs.com/jeepay/img/plspay.svg', '#0CACFF', '0', '计全付', '2023-05-29 10:39:10.000000');
INSERT INTO `t_pay_interface_define` VALUES ('pppay', 'PayPal支付', '1', '0', '1', null, null, '[{\"name\":\"sandbox\",\"desc\":\"环境配置\",\"type\":\"radio\",\"verify\":\"required\",\"values\":\"1,0\",\"titles\":\"沙箱环境, 生产环境\"},{\"name\":\"clientId\",\"desc\":\"Client ID（客户端ID）\",\"type\":\"text\",\"verify\":\"required\"},{\"name\":\"secret\",\"desc\":\"Secret（密钥）\",\"type\":\"text\",\"verify\":\"required\",\"star\":\"1\"},{\"name\":\"refundWebhook\",\"desc\":\"退款 Webhook id\",\"type\":\"text\",\"verify\":\"required\"},{\"name\":\"notifyWebhook\",\"desc\":\"支付 Webhook id\",\"type\":\"text\",\"verify\":\"required\"}]', '[{\"wayCode\": \"PP_PC\"}]', 'http://jeequan.oss-cn-beijing.aliyuncs.com/jeepay/img/paypal.png', '#005ea6', '0', 'PayPal官方通道', '2023-05-29 10:39:10.000000');
INSERT INTO `t_pay_interface_define` VALUES ('wxpay', '微信支付官方', '1', '1', '2', '[{\"name\":\"mchId\", \"desc\":\"微信支付商户号\", \"type\": \"text\",\"verify\":\"required\"},{\"name\":\"appId\",\"desc\":\"应用App ID\",\"type\":\"text\",\"verify\":\"required\"},{\"name\":\"appSecret\",\"desc\":\"应用AppSecret\",\"type\":\"text\",\"verify\":\"required\",\"star\":\"1\"},{\"name\":\"oauth2Url\", \"desc\":\"oauth2地址（置空将使用官方）\", \"type\": \"text\"},{\"name\":\"apiVersion\", \"desc\":\"微信支付API版本\", \"type\": \"radio\",\"values\":\"V2,V3\",\"titles\":\"V2,V3\",\"verify\":\"required\"},{\"name\":\"key\", \"desc\":\"APIv2密钥\", \"type\": \"textarea\",\"verify\":\"required\",\"star\":\"1\"},{\"name\":\"apiV3Key\", \"desc\":\"APIv3密钥（V3接口必填）\", \"type\": \"textarea\",\"verify\":\"\",\"star\":\"1\"},{\"name\":\"serialNo\", \"desc\":\"序列号（V3接口必填）\", \"type\": \"textarea\",\"verify\":\"\",\"star\":\"1\"},{\"name\":\"cert\", \"desc\":\"API证书(apiclient_cert.p12)\", \"type\": \"file\",\"verify\":\"\"},{\"name\":\"apiClientCert\", \"desc\":\"证书文件(apiclient_cert.pem) \", \"type\": \"file\",\"verify\":\"\"},{\"name\":\"apiClientKey\", \"desc\":\"私钥文件(apiclient_key.pem)\", \"type\": \"file\",\"verify\":\"\"}]', '[{\"name\":\"subMchId\",\"desc\":\"子商户ID\",\"type\":\"text\",\"verify\":\"required\"},{\"name\":\"subMchAppId\",\"desc\":\"子账户appID(线上支付必填)\",\"type\":\"text\",\"verify\":\"\"}]', '[{\"name\":\"mchId\", \"desc\":\"微信支付商户号\", \"type\": \"text\",\"verify\":\"required\"},{\"name\":\"appId\",\"desc\":\"应用App ID\",\"type\":\"text\",\"verify\":\"required\"},{\"name\":\"appSecret\",\"desc\":\"应用AppSecret\",\"type\":\"text\",\"verify\":\"required\",\"star\":\"1\"},{\"name\":\"oauth2Url\", \"desc\":\"oauth2地址（置空将使用官方）\", \"type\": \"text\"},{\"name\":\"apiVersion\", \"desc\":\"微信支付API版本\", \"type\": \"radio\",\"values\":\"V2,V3\",\"titles\":\"V2,V3\",\"verify\":\"required\"},{\"name\":\"key\", \"desc\":\"APIv2密钥\", \"type\": \"textarea\",\"verify\":\"required\",\"star\":\"1\"},{\"name\":\"apiV3Key\", \"desc\":\"APIv3密钥（V3接口必填）\", \"type\": \"textarea\",\"verify\":\"\",\"star\":\"1\"},{\"name\":\"serialNo\", \"desc\":\"序列号（V3接口必填）\", \"type\": \"textarea\",\"verify\":\"\",\"star\":\"1\" },{\"name\":\"cert\", \"desc\":\"API证书(apiclient_cert.p12)\", \"type\": \"file\",\"verify\":\"\"},{\"name\":\"apiClientCert\", \"desc\":\"证书文件(apiclient_cert.pem) \", \"type\": \"file\",\"verify\":\"\"},{\"name\":\"apiClientKey\", \"desc\":\"私钥文件(apiclient_key.pem)\", \"type\": \"file\",\"verify\":\"\"}]', '[{\"wayCode\": \"WX_APP\"}, {\"wayCode\": \"WX_H5\"}, {\"wayCode\": \"WX_NATIVE\"}, {\"wayCode\": \"WX_JSAPI\"}, {\"wayCode\": \"WX_BAR\"}, {\"wayCode\": \"WX_LITE\"}]', 'http://jeequan.oss-cn-beijing.aliyuncs.com/jeepay/img/wxpay.png', '#04BE02', '0', '微信官方通道', '2023-05-29 10:39:10.000000');
INSERT INTO `t_pay_interface_define` VALUES ('ysfpay', '云闪付官方', '0', '1', '1', '[{\"name\":\"sandbox\",\"desc\":\"环境配置\",\"type\":\"radio\",\"verify\":\"\",\"values\":\"1,0\",\"titles\":\"沙箱环境,生产环境\",\"verify\":\"required\"},{\"name\":\"serProvId\",\"desc\":\"服务商开发ID[serProvId]\",\"type\":\"text\",\"verify\":\"required\"},{\"name\":\"isvPrivateCertFile\",\"desc\":\"服务商私钥文件（.pfx格式）\",\"type\":\"file\",\"verify\":\"required\"},{\"name\":\"isvPrivateCertPwd\",\"desc\":\"服务商私钥文件密码\",\"type\":\"text\",\"verify\":\"required\",\"star\":\"1\"},{\"name\":\"ysfpayPublicKey\",\"desc\":\"云闪付开发公钥（证书管理页面可查询）\",\"type\":\"textarea\",\"verify\":\"required\",\"star\":\"1\"},{\"name\":\"acqOrgCode\",\"desc\":\"可用支付机构编号\",\"type\":\"text\",\"verify\":\"required\"}]', '[{\"name\":\"merId\",\"desc\":\"商户编号\",\"type\":\"text\",\"verify\":\"required\"}]', null, '[{\"wayCode\": \"YSF_BAR\"}, {\"wayCode\": \"ALI_JSAPI\"}, {\"wayCode\": \"WX_JSAPI\"}, {\"wayCode\": \"ALI_BAR\"}, {\"wayCode\": \"WX_BAR\"}]', 'http://jeequan.oss-cn-beijing.aliyuncs.com/jeepay/img/ysfpay.png', 'red', '0', '云闪付官方通道', '2023-05-29 10:39:10.000000');

-- ----------------------------
-- Table structure for t_pay_order
-- ----------------------------
DROP TABLE IF EXISTS `t_pay_order`;
CREATE TABLE `t_pay_order` (
  `pay_order_id` varchar(30) NOT NULL COMMENT '支付订单号',
  `mch_no` varchar(64) NOT NULL COMMENT '商户号',
  `isv_no` varchar(64) DEFAULT NULL COMMENT '服务商号',
  `app_id` varchar(64) NOT NULL COMMENT '应用ID',
  `mch_name` varchar(30) NOT NULL COMMENT '商户名称',
  `mch_type` tinyint(6) NOT NULL COMMENT '类型: 1-普通商户, 2-特约商户(服务商模式)',
  `mch_order_no` varchar(64) NOT NULL COMMENT '商户订单号',
  `if_code` varchar(20) DEFAULT NULL COMMENT '支付接口代码',
  `way_code` varchar(20) NOT NULL COMMENT '支付方式代码',
  `amount` bigint(20) NOT NULL COMMENT '支付金额,单位分',
  `mch_fee_rate` decimal(20,6) NOT NULL COMMENT '商户手续费费率快照',
  `mch_fee_amount` bigint(20) NOT NULL COMMENT '商户手续费,单位分',
  `currency` varchar(3) NOT NULL DEFAULT 'cny' COMMENT '三位货币代码,人民币:cny',
  `state` tinyint(6) NOT NULL DEFAULT '0' COMMENT '支付状态: 0-订单生成, 1-支付中, 2-支付成功, 3-支付失败, 4-已撤销, 5-已退款, 6-订单关闭',
  `notify_state` tinyint(6) NOT NULL DEFAULT '0' COMMENT '向下游回调状态, 0-未发送,  1-已发送',
  `client_ip` varchar(32) DEFAULT NULL COMMENT '客户端IP',
  `subject` varchar(64) NOT NULL COMMENT '商品标题',
  `body` varchar(256) NOT NULL COMMENT '商品描述信息',
  `channel_extra` varchar(512) DEFAULT NULL COMMENT '特定渠道发起额外参数',
  `channel_user` varchar(64) DEFAULT NULL COMMENT '渠道用户标识,如微信openId,支付宝账号',
  `channel_order_no` varchar(64) DEFAULT NULL COMMENT '渠道订单号',
  `refund_state` tinyint(6) NOT NULL DEFAULT '0' COMMENT '退款状态: 0-未发生实际退款, 1-部分退款, 2-全额退款',
  `refund_times` int(11) NOT NULL DEFAULT '0' COMMENT '退款次数',
  `refund_amount` bigint(20) NOT NULL DEFAULT '0' COMMENT '退款总金额,单位分',
  `division_mode` tinyint(6) DEFAULT '0' COMMENT '订单分账模式：0-该笔订单不允许分账, 1-支付成功按配置自动完成分账, 2-商户手动分账(解冻商户金额)',
  `division_state` tinyint(6) DEFAULT '0' COMMENT '订单分账状态：0-未发生分账, 1-等待分账任务处理, 2-分账处理中, 3-分账任务已结束(不体现状态)',
  `division_last_time` datetime DEFAULT NULL COMMENT '最新分账时间',
  `err_code` varchar(128) DEFAULT NULL COMMENT '渠道支付错误码',
  `err_msg` varchar(256) DEFAULT NULL COMMENT '渠道支付错误描述',
  `ext_param` varchar(128) DEFAULT NULL COMMENT '商户扩展参数',
  `notify_url` varchar(128) NOT NULL DEFAULT '' COMMENT '异步通知地址',
  `return_url` varchar(128) DEFAULT '' COMMENT '页面跳转地址',
  `expired_time` datetime DEFAULT NULL COMMENT '订单失效时间',
  `success_time` datetime DEFAULT NULL COMMENT '订单支付成功时间',
  `created_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `updated_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  PRIMARY KEY (`pay_order_id`),
  UNIQUE KEY `Uni_MchNo_MchOrderNo` (`mch_no`,`mch_order_no`),
  KEY `created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='支付订单表';

-- ----------------------------
-- Records of t_pay_order
-- ----------------------------
INSERT INTO `t_pay_order` VALUES ('P1665289970758529025', 'M1685406045', null, '6475415de4b0859a5a9aa134', '李四', '1', 'M16858710321359875', 'alipay', 'ALI_WAP', '1', '0.006000', '0', 'CNY', '6', '0', '222.244.148.160', '接口调试[M1685406045商户联调]', '接口调试[M1685406045商户联调]', null, null, null, '0', '0', '0', '0', '0', null, null, null, null, 'http://mch.qianrui88.com/api/anon/paytestNotify/payOrder', '', '2023-06-04 19:30:43', null, '2023-06-04 17:30:43.284000', '2023-06-04 19:31:00.097645');
INSERT INTO `t_pay_order` VALUES ('P1665702042877112321', 'M1685406045', null, '6475415de4b0859a5a9aa134', '李四', '1', 'M16859692825044780', 'alipay', 'ALI_WAP', '1', '0.006000', '0', 'CNY', '5', '1', '222.244.148.160', '接口调试[M1685406045商户联调]', '接口调试[M1685406045商户联调]', null, '2088002210619443', '2023060522001419441451453432', '2', '1', '1', '0', '0', null, null, null, null, 'http://mch.qianrui88.com/api/anon/paytestNotify/payOrder', '', '2023-06-05 22:48:09', '2023-06-05 20:49:29', '2023-06-05 20:48:08.926000', '2023-06-06 11:17:50.431025');
INSERT INTO `t_pay_order` VALUES ('P1665886610636746754', 'M1685406045', null, '6475415de4b0859a5a9aa134', '李四', '1', 'M16860132886195052', 'alipay', 'ALI_WAP', '1', '0.006000', '0', 'CNY', '6', '0', '61.186.97.58', '接口调试[M1685406045商户联调]', '接口调试[M1685406045商户联调]', null, null, null, '0', '0', '0', '0', '0', null, null, null, null, 'http://mch.qianrui88.com/api/anon/paytestNotify/payOrder', '', '2023-06-06 11:01:33', null, '2023-06-06 09:01:33.310000', '2023-06-06 11:02:01.203392');
INSERT INTO `t_pay_order` VALUES ('P1665886817143304194', 'M1685406045', null, '6475415de4b0859a5a9aa134', '李四', '1', 'M16860132940822975', 'alipay', 'ALI_WAP', '1', '0.006000', '0', 'CNY', '6', '0', '61.186.97.58', '接口调试[M1685406045商户联调]', '接口调试[M1685406045商户联调]', null, null, null, '0', '0', '0', '0', '0', null, null, null, null, 'http://mch.qianrui88.com/api/anon/paytestNotify/payOrder', '', '2023-06-06 11:02:23', null, '2023-06-06 09:02:22.545000', '2023-06-06 11:03:00.944061');
INSERT INTO `t_pay_order` VALUES ('P1665887155581693953', 'M1685406045', null, '6475415de4b0859a5a9aa134', '李四', '1', 'M16860133438085054', 'alipay', 'ALI_WAP', '1', '0.006000', '0', 'CNY', '6', '0', '61.186.97.58', '接口调试[M1685406045商户联调]', '接口调试[M1685406045商户联调]', null, null, null, '0', '0', '0', '0', '0', null, null, null, null, 'http://mch.qianrui88.com/api/anon/paytestNotify/payOrder', '', '2023-06-06 11:03:43', null, '2023-06-06 09:03:43.235000', '2023-06-06 11:04:01.068356');
INSERT INTO `t_pay_order` VALUES ('P1665908081136312322', 'M1685406045', null, '6475415de4b0859a5a9aa134', '李四', '1', 'M16860184077648041', 'alipay', 'ALI_WAP', '1', '0.006000', '0', 'CNY', '6', '0', '0:0:0:0:0:0:0:1', '接口调试[M1685406045商户联调]', '接口调试[M1685406045商户联调]', null, null, null, '0', '0', '0', '0', '0', null, null, null, null, 'http://mch.qianrui88.com/api/anon/paytestNotify/payOrder', '', '2023-06-06 12:26:52', null, '2023-06-06 10:26:52.278000', '2023-06-06 12:26:59.279480');
INSERT INTO `t_pay_order` VALUES ('P1665908363652046850', 'M1685406045', null, '6475415de4b0859a5a9aa134', '李四', '1', 'M16860184133959975', 'alipay', 'ALI_WAP', '1', '0.006000', '0', 'CNY', '6', '0', '0:0:0:0:0:0:0:1', '接口调试[M1685406045商户联调]', '接口调试[M1685406045商户联调]', null, null, null, '0', '0', '0', '0', '0', null, null, null, null, 'http://mch.qianrui88.com/api/anon/paytestNotify/payOrder', '', '2023-06-06 12:28:00', null, '2023-06-06 10:27:59.633000', '2023-06-06 12:28:00.485045');
INSERT INTO `t_pay_order` VALUES ('P1665908502244433921', 'M1685406045', null, '6475415de4b0859a5a9aa134', '李四', '1', 'M16860184804513364', 'alipay', 'ALI_WAP', '1', '0.006000', '0', 'CNY', '6', '0', '0:0:0:0:0:0:0:1', '接口调试[M1685406045商户联调]', '接口调试[M1685406045商户联调]', null, null, null, '0', '0', '0', '0', '0', null, null, null, null, 'http://mch.qianrui88.com/api/anon/paytestNotify/payOrder', '', '2023-06-06 12:28:33', null, '2023-06-06 10:28:32.676000', '2023-06-06 12:28:59.227549');
INSERT INTO `t_pay_order` VALUES ('P1665908699372527617', 'M1685406045', null, '6475415de4b0859a5a9aa134', '李四', '1', 'M16860185542734195', 'alipay', 'ALI_WAP', '1', '0.006000', '0', 'CNY', '6', '0', '0:0:0:0:0:0:0:1', '接口调试[M1685406045商户联调]', '接口调试[M1685406045商户联调]', null, null, null, '0', '0', '0', '0', '0', null, null, null, null, 'http://mch.qianrui88.com/api/anon/paytestNotify/payOrder', '', '2023-06-06 12:29:20', null, '2023-06-06 10:29:19.678000', '2023-06-06 12:29:59.232714');
INSERT INTO `t_pay_order` VALUES ('P1665909072069992449', 'M1685406045', null, '6475415de4b0859a5a9aa134', '李四', '1', 'M16860185609414363', 'alipay', 'ALI_WAP', '1', '0.006000', '0', 'CNY', '6', '0', '0:0:0:0:0:0:0:1', '接口调试[M1685406045商户联调]', '接口调试[M1685406045商户联调]', null, null, null, '0', '0', '0', '0', '0', null, null, null, null, 'http://mch.qianrui88.com/api/anon/paytestNotify/payOrder', '', '2023-06-06 12:30:49', null, '2023-06-06 10:30:48.533000', '2023-06-06 12:30:59.265650');
INSERT INTO `t_pay_order` VALUES ('P1665909948838912001', 'M1685406045', null, '6475415de4b0859a5a9aa134', '李四', '1', 'M16860186699694995', 'alipay', 'ALI_WAP', '1', '0.006000', '0', 'CNY', '6', '0', '0:0:0:0:0:0:0:1', '接口调试[M1685406045商户联调]', '接口调试[M1685406045商户联调]', null, null, null, '0', '0', '0', '0', '0', null, null, null, null, 'http://mch.qianrui88.com/api/anon/paytestNotify/payOrder', '', '2023-06-06 12:34:18', null, '2023-06-06 10:34:17.573000', '2023-06-06 12:34:59.802297');
INSERT INTO `t_pay_order` VALUES ('P1665919376178880513', 'M1685406045', null, '6475415de4b0859a5a9aa134', '李四', '1', 'M16860211047907439', 'alipay', 'ALI_WAP', '64', '0.006000', '0', 'CNY', '6', '0', '0:0:0:0:0:0:0:1', '接口调试[M1685406045商户联调]', '接口调试[M1685406045商户联调]', null, null, null, '0', '0', '0', '0', '0', null, null, null, null, 'http://mch.qianrui88.com/api/anon/paytestNotify/payOrder', '', '2023-06-06 13:11:45', null, '2023-06-06 11:11:45.225000', '2023-06-06 13:11:59.759307');
INSERT INTO `t_pay_order` VALUES ('P1665919465450446849', 'M1685406045', null, '6475415de4b0859a5a9aa134', '李四', '1', 'M16860211060607514', 'alipay', 'ALI_WAP', '64', '0.006000', '0', 'CNY', '6', '0', '0:0:0:0:0:0:0:1', '用户充值[M1685406045商户联调]', '用户充值[M1685406045商户联调]', null, null, null, '0', '0', '0', '0', '0', null, null, null, null, 'http://mch.qianrui88.com/api/anon/paytestNotify/payOrder', '', '2023-06-06 13:12:07', null, '2023-06-06 11:12:06.508000', '2023-06-06 13:12:59.433737');
INSERT INTO `t_pay_order` VALUES ('P1666776985022914561', 'M1685406045', null, '6475415de4b0859a5a9aa134', '李四', '1', 'M16862254107318482', 'alipay', 'ALI_WAP', '1', '0.006000', '0', 'CNY', '6', '0', '222.240.151.178', '接口调试[M1685406045商户联调]', '接口调试[M1685406045商户联调]', null, null, null, '0', '0', '0', '0', '0', null, null, null, null, 'http://mch.qianrui88.com/api/anon/paytestNotify/payOrder', '', '2023-06-08 21:59:35', null, '2023-06-08 19:59:35.110000', '2023-06-08 22:00:00.022678');
INSERT INTO `t_pay_order` VALUES ('P1666777119274196994', 'M1685406045', null, '6475415de4b0859a5a9aa134', '李四', '1', 'M16862256045449537', 'alipay', 'ALI_WAP', '1', '0.006000', '0', 'CNY', '2', '1', '61.186.97.58', '接口调试[M1685406045商户联调]', '接口调试[M1685406045商户联调]', null, '2088541469672404', '2023060822001472401416314047', '0', '0', '0', '0', '0', null, null, null, null, 'http://mch.qianrui88.com/api/anon/paytestNotify/payOrder', '', '2023-06-08 22:00:07', '2023-06-08 20:01:23', '2023-06-08 20:00:07.114000', '2023-06-08 20:17:04.266878');
INSERT INTO `t_pay_order` VALUES ('P1666782898463072257', 'M1685406045', null, '6475415de4b0859a5a9aa134', '李四', '1', 'M16862269731848826', 'alipay', 'ALI_WAP', '1', '0.006000', '0', 'CNY', '6', '0', '61.186.97.58', '接口调试[M1685406045商户联调]', '接口调试[M1685406045商户联调]', null, null, null, '0', '0', '0', '0', '0', null, null, null, null, 'http://mch.qianrui88.com/api/anon/paytestNotify/payOrder', '', '2023-06-08 22:23:05', null, '2023-06-08 20:23:04.980000', '2023-06-08 22:24:00.001224');

-- ----------------------------
-- Table structure for t_pay_order_division_record
-- ----------------------------
DROP TABLE IF EXISTS `t_pay_order_division_record`;
CREATE TABLE `t_pay_order_division_record` (
  `record_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '分账记录ID',
  `mch_no` varchar(64) NOT NULL COMMENT '商户号',
  `isv_no` varchar(64) DEFAULT NULL COMMENT '服务商号',
  `app_id` varchar(64) NOT NULL COMMENT '应用ID',
  `mch_name` varchar(30) NOT NULL COMMENT '商户名称',
  `mch_type` tinyint(6) NOT NULL COMMENT '类型: 1-普通商户, 2-特约商户(服务商模式)',
  `if_code` varchar(20) NOT NULL COMMENT '支付接口代码',
  `pay_order_id` varchar(30) NOT NULL COMMENT '系统支付订单号',
  `pay_order_channel_order_no` varchar(64) DEFAULT NULL COMMENT '支付订单渠道支付订单号',
  `pay_order_amount` bigint(20) NOT NULL COMMENT '订单金额,单位分',
  `pay_order_division_amount` bigint(20) NOT NULL COMMENT '订单实际分账金额, 单位：分（订单金额 - 商户手续费 - 已退款金额）',
  `batch_order_id` varchar(30) NOT NULL COMMENT '系统分账批次号',
  `channel_batch_order_id` varchar(64) DEFAULT NULL COMMENT '上游分账批次号',
  `state` tinyint(6) NOT NULL COMMENT '状态: 0-待分账 1-分账成功（明确成功）, 2-分账失败（明确失败）, 3-分账已受理（上游受理）',
  `channel_resp_result` text COMMENT '上游返回数据包',
  `receiver_id` bigint(20) NOT NULL COMMENT '账号快照》 分账接收者ID',
  `receiver_group_id` bigint(20) DEFAULT NULL COMMENT '账号快照》 组ID（便于商户接口使用）',
  `receiver_alias` varchar(64) DEFAULT NULL COMMENT '接收者账号别名',
  `acc_type` tinyint(6) NOT NULL COMMENT '账号快照》 分账接收账号类型: 0-个人 1-商户',
  `acc_no` varchar(50) NOT NULL COMMENT '账号快照》 分账接收账号',
  `acc_name` varchar(30) NOT NULL DEFAULT '' COMMENT '账号快照》 分账接收账号名称',
  `relation_type` varchar(30) NOT NULL COMMENT '账号快照》 分账关系类型（参考微信）， 如： SERVICE_PROVIDER 服务商等',
  `relation_type_name` varchar(30) NOT NULL COMMENT '账号快照》 当选择自定义时，需要录入该字段。 否则为对应的名称',
  `division_profit` decimal(20,6) NOT NULL COMMENT '账号快照》 配置的实际分账比例',
  `cal_division_amount` bigint(20) NOT NULL COMMENT '计算该接收方的分账金额,单位分',
  `created_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `updated_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  PRIMARY KEY (`record_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='分账记录表';

-- ----------------------------
-- Records of t_pay_order_division_record
-- ----------------------------

-- ----------------------------
-- Table structure for t_pay_way
-- ----------------------------
DROP TABLE IF EXISTS `t_pay_way`;
CREATE TABLE `t_pay_way` (
  `way_code` varchar(20) NOT NULL COMMENT '支付方式代码  例如： wxpay_jsapi',
  `way_name` varchar(20) NOT NULL COMMENT '支付方式名称',
  `created_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `updated_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  PRIMARY KEY (`way_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='支付方式表';

-- ----------------------------
-- Records of t_pay_way
-- ----------------------------
INSERT INTO `t_pay_way` VALUES ('ALI_APP', '支付宝APP', '2023-05-29 10:39:08.794485', '2023-05-29 10:39:08.794485');
INSERT INTO `t_pay_way` VALUES ('ALI_BAR', '支付宝条码', '2023-05-29 10:39:08.666222', '2023-05-29 10:39:08.666222');
INSERT INTO `t_pay_way` VALUES ('ALI_JSAPI', '支付宝生活号', '2023-05-29 10:39:08.725449', '2023-05-29 10:39:08.725449');
INSERT INTO `t_pay_way` VALUES ('ALI_LITE', '支付宝小程序', '2023-05-29 10:39:09.244479', '2023-05-29 10:39:09.244479');
INSERT INTO `t_pay_way` VALUES ('ALI_PC', '支付宝PC网站', '2023-05-29 10:39:08.885966', '2023-05-29 10:39:08.885966');
INSERT INTO `t_pay_way` VALUES ('ALI_QR', '支付宝二维码', '2023-05-29 10:39:08.936919', '2023-05-29 10:39:08.936919');
INSERT INTO `t_pay_way` VALUES ('ALI_WAP', '支付宝WAP', '2023-05-29 10:39:08.837938', '2023-05-29 10:39:08.837938');
INSERT INTO `t_pay_way` VALUES ('PP_PC', 'PayPal支付', '2023-05-29 10:39:09.830970', '2023-05-29 10:39:09.830970');
INSERT INTO `t_pay_way` VALUES ('UP_APP', '银联App支付', '2023-05-29 10:39:09.894702', '2023-05-29 10:39:09.894702');
INSERT INTO `t_pay_way` VALUES ('UP_B2B', '银联企业网银支付', '2023-05-29 10:39:10.193622', '2023-05-29 10:39:10.193622');
INSERT INTO `t_pay_way` VALUES ('UP_BAR', '银联二维码(被扫)', '2023-05-29 10:39:10.122373', '2023-05-29 10:39:10.122373');
INSERT INTO `t_pay_way` VALUES ('UP_JSAPI', '银联Js支付', '2023-05-29 10:39:10.299598', '2023-05-29 10:39:10.299598');
INSERT INTO `t_pay_way` VALUES ('UP_PC', '银联网关支付', '2023-05-29 10:39:10.243860', '2023-05-29 10:39:10.243860');
INSERT INTO `t_pay_way` VALUES ('UP_QR', '银联二维码(主扫)', '2023-05-29 10:39:10.052212', '2023-05-29 10:39:10.052212');
INSERT INTO `t_pay_way` VALUES ('UP_WAP', '银联手机网站支付', '2023-05-29 10:39:09.963708', '2023-05-29 10:39:09.963708');
INSERT INTO `t_pay_way` VALUES ('WX_APP', '微信APP', '2023-05-29 10:39:09.446987', '2023-05-29 10:39:09.446987');
INSERT INTO `t_pay_way` VALUES ('WX_BAR', '微信条码', '2023-05-29 10:39:09.315756', '2023-05-29 10:39:09.315756');
INSERT INTO `t_pay_way` VALUES ('WX_H5', '微信H5', '2023-05-29 10:39:09.516709', '2023-05-29 10:39:09.516709');
INSERT INTO `t_pay_way` VALUES ('WX_JSAPI', '微信公众号', '2023-05-29 10:39:09.384747', '2023-05-29 10:39:09.384747');
INSERT INTO `t_pay_way` VALUES ('WX_LITE', '微信小程序', '2023-05-29 10:39:09.638224', '2023-05-29 10:39:09.638224');
INSERT INTO `t_pay_way` VALUES ('WX_NATIVE', '微信扫码', '2023-05-29 10:39:09.575977', '2023-05-29 10:39:09.575977');
INSERT INTO `t_pay_way` VALUES ('YSF_BAR', '云闪付条码', '2023-05-29 10:39:09.703476', '2023-05-29 10:39:09.703476');
INSERT INTO `t_pay_way` VALUES ('YSF_JSAPI', '云闪付jsapi', '2023-05-29 10:39:09.762024', '2023-05-29 10:39:09.762024');

-- ----------------------------
-- Table structure for t_refund_order
-- ----------------------------
DROP TABLE IF EXISTS `t_refund_order`;
CREATE TABLE `t_refund_order` (
  `refund_order_id` varchar(30) NOT NULL COMMENT '退款订单号（支付系统生成订单号）',
  `pay_order_id` varchar(30) NOT NULL COMMENT '支付订单号（与t_pay_order对应）',
  `channel_pay_order_no` varchar(64) DEFAULT NULL COMMENT '渠道支付单号（与t_pay_order channel_order_no对应）',
  `mch_no` varchar(64) NOT NULL COMMENT '商户号',
  `isv_no` varchar(64) DEFAULT NULL COMMENT '服务商号',
  `app_id` varchar(64) NOT NULL COMMENT '应用ID',
  `mch_name` varchar(30) NOT NULL COMMENT '商户名称',
  `mch_type` tinyint(6) NOT NULL COMMENT '类型: 1-普通商户, 2-特约商户(服务商模式)',
  `mch_refund_no` varchar(64) NOT NULL COMMENT '商户退款单号（商户系统的订单号）',
  `way_code` varchar(20) NOT NULL COMMENT '支付方式代码',
  `if_code` varchar(20) NOT NULL COMMENT '支付接口代码',
  `pay_amount` bigint(20) NOT NULL COMMENT '支付金额,单位分',
  `refund_amount` bigint(20) NOT NULL COMMENT '退款金额,单位分',
  `currency` varchar(3) NOT NULL DEFAULT 'cny' COMMENT '三位货币代码,人民币:cny',
  `state` tinyint(6) NOT NULL DEFAULT '0' COMMENT '退款状态:0-订单生成,1-退款中,2-退款成功,3-退款失败,4-退款任务关闭',
  `client_ip` varchar(32) DEFAULT NULL COMMENT '客户端IP',
  `refund_reason` varchar(256) NOT NULL COMMENT '退款原因',
  `channel_order_no` varchar(32) DEFAULT NULL COMMENT '渠道订单号',
  `err_code` varchar(128) DEFAULT NULL COMMENT '渠道错误码',
  `err_msg` varchar(2048) DEFAULT NULL COMMENT '渠道错误描述',
  `channel_extra` varchar(512) DEFAULT NULL COMMENT '特定渠道发起时额外参数',
  `notify_url` varchar(128) DEFAULT NULL COMMENT '通知地址',
  `ext_param` varchar(64) DEFAULT NULL COMMENT '扩展参数',
  `success_time` datetime DEFAULT NULL COMMENT '订单退款成功时间',
  `expired_time` datetime DEFAULT NULL COMMENT '退款失效时间（失效后系统更改为退款任务关闭状态）',
  `created_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `updated_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  PRIMARY KEY (`refund_order_id`),
  UNIQUE KEY `Uni_MchNo_MchRefundNo` (`mch_no`,`mch_refund_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='退款订单表';

-- ----------------------------
-- Records of t_refund_order
-- ----------------------------
INSERT INTO `t_refund_order` VALUES ('R1665920903010394113', 'P1665702042877112321', '2023060522001419441451453432', 'M1685406045', null, '6475415de4b0859a5a9aa134', '李四', '1', 'M1665920902465134593', 'ALI_WAP', 'alipay', '1', '1', 'CNY', '2', '8.134.162.229', '测试', null, null, null, null, null, null, '2023-06-06 11:17:50', '2023-06-06 13:17:49', '2023-06-06 11:17:49.249000', '2023-06-06 11:17:50.419542');

-- ----------------------------
-- Table structure for t_sys_config
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_config`;
CREATE TABLE `t_sys_config` (
  `config_key` varchar(50) NOT NULL COMMENT '配置KEY',
  `config_name` varchar(50) NOT NULL COMMENT '配置名称',
  `config_desc` varchar(200) NOT NULL COMMENT '描述信息',
  `group_key` varchar(50) NOT NULL COMMENT '分组key',
  `group_name` varchar(50) NOT NULL COMMENT '分组名称',
  `config_val` text NOT NULL COMMENT '配置内容项',
  `type` varchar(20) NOT NULL DEFAULT 'text' COMMENT '类型: text-输入框, textarea-多行文本, uploadImg-上传图片, switch-开关',
  `sort_num` bigint(20) NOT NULL DEFAULT '0' COMMENT '显示顺序',
  `updated_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  PRIMARY KEY (`config_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统配置表';

-- ----------------------------
-- Records of t_sys_config
-- ----------------------------
INSERT INTO `t_sys_config` VALUES ('mchSiteUrl', '商户平台网址(不包含结尾/)', '商户平台网址(不包含结尾/)', 'applicationConfig', '系统应用配置', 'http://mch.qianrui88.com', 'text', '0', '2023-05-30 08:49:51.339502');
INSERT INTO `t_sys_config` VALUES ('mgrSiteUrl', '运营平台网址(不包含结尾/)', '运营平台网址(不包含结尾/)', 'applicationConfig', '系统应用配置', 'http://mgr.qianrui88.com', 'text', '0', '2023-05-30 08:49:51.334999');
INSERT INTO `t_sys_config` VALUES ('ossPublicSiteUrl', '公共oss访问地址(不包含结尾/)', '公共oss访问地址(不包含结尾/)', 'applicationConfig', '系统应用配置', 'http://mgr.qianrui88.com/api/anon/localOssFiles', 'text', '0', '2023-05-30 08:50:12.158757');
INSERT INTO `t_sys_config` VALUES ('paySiteUrl', '支付网关地址(不包含结尾/)', '支付网关地址(不包含结尾/)', 'applicationConfig', '系统应用配置', 'http://pay.qianrui88.com', 'text', '0', '2023-05-30 08:49:51.325756');

-- ----------------------------
-- Table structure for t_sys_entitlement
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_entitlement`;
CREATE TABLE `t_sys_entitlement` (
  `ent_id` varchar(64) NOT NULL COMMENT '权限ID[ENT_功能模块_子模块_操作], eg: ENT_ROLE_LIST_ADD',
  `ent_name` varchar(32) NOT NULL COMMENT '权限名称',
  `menu_icon` varchar(32) DEFAULT NULL COMMENT '菜单图标',
  `menu_uri` varchar(128) DEFAULT NULL COMMENT '菜单uri/路由地址',
  `component_name` varchar(32) DEFAULT NULL COMMENT '组件Name（前后端分离使用）',
  `ent_type` char(2) NOT NULL COMMENT '权限类型 ML-左侧显示菜单, MO-其他菜单, PB-页面/按钮',
  `quick_jump` tinyint(6) NOT NULL DEFAULT '0' COMMENT '快速开始菜单 0-否, 1-是',
  `state` tinyint(6) NOT NULL DEFAULT '1' COMMENT '状态 0-停用, 1-启用',
  `pid` varchar(32) NOT NULL COMMENT '父ID',
  `ent_sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序字段, 规则：正序',
  `sys_type` varchar(8) NOT NULL COMMENT '所属系统： MGR-运营平台, MCH-商户中心',
  `created_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `updated_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  PRIMARY KEY (`ent_id`,`sys_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统权限表';

-- ----------------------------
-- Records of t_sys_entitlement
-- ----------------------------
INSERT INTO `t_sys_entitlement` VALUES ('ENT_COMMONS', '系统通用菜单', 'no-icon', '', 'RouteView', 'MO', '0', '1', 'ROOT', '-1', 'MCH', '2023-05-29 10:39:03.000000', '2023-05-29 10:39:03.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_COMMONS', '系统通用菜单', 'no-icon', '', 'RouteView', 'MO', '0', '1', 'ROOT', '-1', 'MGR', '2023-05-29 10:38:58.000000', '2023-05-29 10:38:58.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_C_MAIN', '主页', 'home', '/main', 'MainPage', 'ML', '0', '1', 'ROOT', '1', 'MGR', '2023-05-29 10:38:58.000000', '2023-05-29 10:38:58.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_C_MAIN_NUMBER_COUNT', '主页数量总统计', 'no-icon', '', '', 'PB', '0', '1', 'ENT_C_MAIN', '0', 'MGR', '2023-05-29 10:38:58.000000', '2023-05-29 10:38:58.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_C_MAIN_PAY_AMOUNT_WEEK', '主页周支付统计', 'no-icon', '', '', 'PB', '0', '1', 'ENT_C_MAIN', '0', 'MGR', '2023-05-29 10:38:58.000000', '2023-05-29 10:38:58.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_C_MAIN_PAY_COUNT', '主页交易统计', 'no-icon', '', '', 'PB', '0', '1', 'ENT_C_MAIN', '0', 'MGR', '2023-05-29 10:38:58.000000', '2023-05-29 10:38:58.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_C_MAIN_PAY_TYPE_COUNT', '主页交易方式统计', 'no-icon', '', '', 'PB', '0', '1', 'ENT_C_MAIN', '0', 'MGR', '2023-05-29 10:38:58.000000', '2023-05-29 10:38:58.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_C_USERINFO', '个人中心', 'no-icon', '/current/userinfo', 'CurrentUserInfo', 'MO', '0', '1', 'ENT_COMMONS', '-1', 'MCH', '2023-05-29 10:39:03.000000', '2023-05-29 10:39:03.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_C_USERINFO', '个人中心', 'no-icon', '/current/userinfo', 'CurrentUserInfo', 'MO', '0', '1', 'ENT_COMMONS', '-1', 'MGR', '2023-05-29 10:38:58.000000', '2023-05-29 10:38:58.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_DIVISION', '分账管理', 'apartment', '', 'RouteView', 'ML', '0', '1', 'ROOT', '30', 'MCH', '2023-05-29 10:39:06.000000', '2023-05-29 10:39:06.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_DIVISION_RECEIVER', '收款账号管理', 'trademark', '/divisionReceiver', 'DivisionReceiverPage', 'ML', '0', '1', 'ENT_DIVISION', '20', 'MCH', '2023-05-29 10:39:06.000000', '2023-05-29 10:39:06.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_DIVISION_RECEIVER_ADD', '按钮：新增收款账号', 'no-icon', '', '', 'PB', '0', '1', 'ENT_DIVISION_RECEIVER', '0', 'MCH', '2023-05-29 10:39:06.000000', '2023-05-29 10:39:06.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_DIVISION_RECEIVER_DELETE', '按钮：删除收款账号', 'no-icon', '', '', 'PB', '0', '1', 'ENT_DIVISION_RECEIVER', '0', 'MCH', '2023-05-29 10:39:06.000000', '2023-05-29 10:39:06.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_DIVISION_RECEIVER_EDIT', '按钮：修改账号信息', 'no-icon', '', '', 'PB', '0', '1', 'ENT_DIVISION_RECEIVER', '0', 'MCH', '2023-05-29 10:39:06.000000', '2023-05-29 10:39:06.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_DIVISION_RECEIVER_GROUP', '账号组管理', 'team', '/divisionReceiverGroup', 'DivisionReceiverGroupPage', 'ML', '0', '1', 'ENT_DIVISION', '10', 'MCH', '2023-05-29 10:39:06.000000', '2023-05-29 10:39:06.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_DIVISION_RECEIVER_GROUP_ADD', '按钮：新增', 'no-icon', '', '', 'PB', '0', '1', 'ENT_DIVISION_RECEIVER_GROUP', '0', 'MCH', '2023-05-29 10:39:06.000000', '2023-05-29 10:39:06.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_DIVISION_RECEIVER_GROUP_DELETE', '按钮：删除', 'no-icon', '', '', 'PB', '0', '1', 'ENT_DIVISION_RECEIVER_GROUP', '0', 'MCH', '2023-05-29 10:39:06.000000', '2023-05-29 10:39:06.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_DIVISION_RECEIVER_GROUP_EDIT', '按钮：修改', 'no-icon', '', '', 'PB', '0', '1', 'ENT_DIVISION_RECEIVER_GROUP', '0', 'MCH', '2023-05-29 10:39:06.000000', '2023-05-29 10:39:06.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_DIVISION_RECEIVER_GROUP_LIST', '页面：数据列表', 'no-icon', '', '', 'PB', '0', '1', 'ENT_DIVISION_RECEIVER_GROUP', '0', 'MCH', '2023-05-29 10:39:06.000000', '2023-05-29 10:39:06.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_DIVISION_RECEIVER_GROUP_VIEW', '按钮：详情', 'no-icon', '', '', 'PB', '0', '1', 'ENT_DIVISION_RECEIVER_GROUP', '0', 'MCH', '2023-05-29 10:39:06.000000', '2023-05-29 10:39:06.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_DIVISION_RECEIVER_LIST', '页面：数据列表', 'no-icon', '', '', 'PB', '0', '1', 'ENT_DIVISION_RECEIVER', '0', 'MCH', '2023-05-29 10:39:06.000000', '2023-05-29 10:39:06.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_DIVISION_RECEIVER_VIEW', '按钮：详情', 'no-icon', '', '', 'PB', '0', '1', 'ENT_DIVISION_RECEIVER', '0', 'MCH', '2023-05-29 10:39:06.000000', '2023-05-29 10:39:06.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_DIVISION_RECORD', '分账记录', 'unordered-list', '/divisionRecord', 'DivisionRecordPage', 'ML', '0', '1', 'ENT_DIVISION', '30', 'MCH', '2023-05-29 10:39:06.000000', '2023-05-29 10:39:06.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_DIVISION_RECORD_LIST', '页面：数据列表', 'no-icon', '', '', 'PB', '0', '1', 'ENT_DIVISION_RECORD', '0', 'MCH', '2023-05-29 10:39:06.000000', '2023-05-29 10:39:06.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_DIVISION_RECORD_RESEND', '按钮：重试', 'no-icon', '', '', 'PB', '0', '1', 'ENT_DIVISION_RECORD', '0', 'MCH', '2023-05-29 10:39:07.000000', '2023-05-29 10:39:07.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_DIVISION_RECORD_VIEW', '按钮：详情', 'no-icon', '', '', 'PB', '0', '1', 'ENT_DIVISION_RECORD', '0', 'MCH', '2023-05-29 10:39:07.000000', '2023-05-29 10:39:07.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_ISV', '服务商管理', 'block', '', 'RouteView', 'ML', '0', '1', 'ROOT', '40', 'MGR', '2023-05-29 10:38:59.000000', '2023-05-29 10:38:59.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_ISV_INFO', '服务商列表', 'profile', '/isv', 'IsvListPage', 'ML', '0', '1', 'ENT_ISV', '10', 'MGR', '2023-05-29 10:38:59.000000', '2023-05-29 10:38:59.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_ISV_INFO_ADD', '按钮：新增', 'no-icon', '', '', 'PB', '0', '1', 'ENT_ISV_INFO', '0', 'MGR', '2023-05-29 10:38:59.000000', '2023-05-29 10:38:59.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_ISV_INFO_DEL', '按钮：删除', 'no-icon', '', '', 'PB', '0', '1', 'ENT_ISV_INFO', '0', 'MGR', '2023-05-29 10:39:00.000000', '2023-05-29 10:39:00.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_ISV_INFO_EDIT', '按钮：编辑', 'no-icon', '', '', 'PB', '0', '1', 'ENT_ISV_INFO', '0', 'MGR', '2023-05-29 10:38:59.000000', '2023-05-29 10:38:59.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_ISV_INFO_VIEW', '按钮：详情', 'no-icon', '', '', 'PB', '0', '1', 'ENT_ISV_INFO', '0', 'MGR', '2023-05-29 10:38:59.000000', '2023-05-29 10:38:59.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_ISV_LIST', '页面：服务商列表', 'no-icon', '', '', 'PB', '0', '1', 'ENT_ISV_INFO', '0', 'MGR', '2023-05-29 10:38:59.000000', '2023-05-29 10:38:59.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_ISV_PAY_CONFIG_ADD', '服务商支付参数配置', 'no-icon', '', '', 'PB', '0', '1', 'ENT_ISV_PAY_CONFIG_LIST', '0', 'MGR', '2023-05-29 10:39:00.000000', '2023-05-29 10:39:00.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_ISV_PAY_CONFIG_LIST', '服务商支付参数配置列表', 'no-icon', '', '', 'PB', '0', '1', 'ENT_ISV_INFO', '0', 'MGR', '2023-05-29 10:39:00.000000', '2023-05-29 10:39:00.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_ISV_PAY_CONFIG_VIEW', '服务商支付参数配置详情', 'no-icon', '', '', 'PB', '0', '1', 'ENT_ISV_PAY_CONFIG_LIST', '0', 'MGR', '2023-05-29 10:39:00.000000', '2023-05-29 10:39:00.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_LOG_LIST', '页面：系统日志列表', 'no-icon', '', '', 'PB', '0', '1', 'ENT_SYS_LOG', '0', 'MGR', '2023-05-29 10:39:03.000000', '2023-05-29 10:39:03.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_MCH', '商户管理', 'shop', '', 'RouteView', 'ML', '0', '1', 'ROOT', '30', 'MGR', '2023-05-29 10:38:58.000000', '2023-05-29 10:38:58.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_MCH_APP', '应用管理', 'appstore', '/apps', 'MchAppPage', 'ML', '0', '1', 'ENT_MCH_CENTER', '10', 'MCH', '2023-05-29 10:39:03.000000', '2023-05-29 10:39:03.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_MCH_APP', '应用列表', 'appstore', '/apps', 'MchAppPage', 'ML', '0', '1', 'ENT_MCH', '20', 'MGR', '2023-05-29 10:38:59.000000', '2023-05-29 10:38:59.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_MCH_APP_ADD', '按钮：新增', 'no-icon', '', '', 'PB', '0', '1', 'ENT_MCH_APP', '0', 'MCH', '2023-05-29 10:39:04.000000', '2023-05-29 10:39:04.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_MCH_APP_ADD', '按钮：新增', 'no-icon', '', '', 'PB', '0', '1', 'ENT_MCH_APP', '0', 'MGR', '2023-05-29 10:38:59.000000', '2023-05-29 10:38:59.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_MCH_APP_CONFIG', '应用配置', 'no-icon', '', '', 'PB', '0', '1', 'ENT_MCH_INFO', '0', 'MGR', '2023-05-29 10:38:59.000000', '2023-05-29 10:38:59.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_MCH_APP_DEL', '按钮：删除', 'no-icon', '', '', 'PB', '0', '1', 'ENT_MCH_APP', '0', 'MCH', '2023-05-29 10:39:04.000000', '2023-05-29 10:39:04.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_MCH_APP_DEL', '按钮：删除', 'no-icon', '', '', 'PB', '0', '1', 'ENT_MCH_APP', '0', 'MGR', '2023-05-29 10:38:59.000000', '2023-05-29 10:38:59.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_MCH_APP_EDIT', '按钮：编辑', 'no-icon', '', '', 'PB', '0', '1', 'ENT_MCH_APP', '0', 'MCH', '2023-05-29 10:39:04.000000', '2023-05-29 10:39:04.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_MCH_APP_EDIT', '按钮：编辑', 'no-icon', '', '', 'PB', '0', '1', 'ENT_MCH_APP', '0', 'MGR', '2023-05-29 10:38:59.000000', '2023-05-29 10:38:59.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_MCH_APP_LIST', '页面：应用列表', 'no-icon', '', '', 'PB', '0', '1', 'ENT_MCH_APP', '0', 'MCH', '2023-05-29 10:39:04.000000', '2023-05-29 10:39:04.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_MCH_APP_LIST', '页面：应用列表', 'no-icon', '', '', 'PB', '0', '1', 'ENT_MCH_APP', '0', 'MGR', '2023-05-29 10:38:59.000000', '2023-05-29 10:38:59.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_MCH_APP_VIEW', '按钮：详情', 'no-icon', '', '', 'PB', '0', '1', 'ENT_MCH_APP', '0', 'MCH', '2023-05-29 10:39:04.000000', '2023-05-29 10:39:04.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_MCH_APP_VIEW', '按钮：详情', 'no-icon', '', '', 'PB', '0', '1', 'ENT_MCH_APP', '0', 'MGR', '2023-05-29 10:38:59.000000', '2023-05-29 10:38:59.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_MCH_CENTER', '商户中心', 'team', '', 'RouteView', 'ML', '0', '1', 'ROOT', '10', 'MCH', '2023-05-29 10:39:03.000000', '2023-05-29 10:39:03.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_MCH_INFO', '商户列表', 'profile', '/mch', 'MchListPage', 'ML', '0', '1', 'ENT_MCH', '10', 'MGR', '2023-05-29 10:38:58.000000', '2023-05-29 10:38:58.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_MCH_INFO_ADD', '按钮：新增', 'no-icon', '', '', 'PB', '0', '1', 'ENT_MCH_INFO', '0', 'MGR', '2023-05-29 10:38:58.000000', '2023-05-29 10:38:58.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_MCH_INFO_DEL', '按钮：删除', 'no-icon', '', '', 'PB', '0', '1', 'ENT_MCH_INFO', '0', 'MGR', '2023-05-29 10:38:59.000000', '2023-05-29 10:38:59.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_MCH_INFO_EDIT', '按钮：编辑', 'no-icon', '', '', 'PB', '0', '1', 'ENT_MCH_INFO', '0', 'MGR', '2023-05-29 10:38:58.000000', '2023-05-29 10:38:58.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_MCH_INFO_VIEW', '按钮：详情', 'no-icon', '', '', 'PB', '0', '1', 'ENT_MCH_INFO', '0', 'MGR', '2023-05-29 10:38:59.000000', '2023-05-29 10:38:59.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_MCH_LIST', '页面：商户列表', 'no-icon', '', '', 'PB', '0', '1', 'ENT_MCH_INFO', '0', 'MGR', '2023-05-29 10:38:58.000000', '2023-05-29 10:38:58.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_MCH_MAIN', '主页', 'home', '/main', 'MainPage', 'ML', '0', '1', 'ROOT', '1', 'MCH', '2023-05-29 10:39:03.000000', '2023-05-29 10:39:03.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_MCH_MAIN_NUMBER_COUNT', '主页数量总统计', 'no-icon', '', '', 'PB', '0', '1', 'ENT_MCH_MAIN', '0', 'MCH', '2023-05-29 10:39:03.000000', '2023-05-29 10:39:03.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_MCH_MAIN_PAY_AMOUNT_WEEK', '主页周支付统计', 'no-icon', '', '', 'PB', '0', '1', 'ENT_MCH_MAIN', '0', 'MCH', '2023-05-29 10:39:03.000000', '2023-05-29 10:39:03.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_MCH_MAIN_PAY_COUNT', '主页交易统计', 'no-icon', '', '', 'PB', '0', '1', 'ENT_MCH_MAIN', '0', 'MCH', '2023-05-29 10:39:03.000000', '2023-05-29 10:39:03.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_MCH_MAIN_PAY_TYPE_COUNT', '主页交易方式统计', 'no-icon', '', '', 'PB', '0', '1', 'ENT_MCH_MAIN', '0', 'MCH', '2023-05-29 10:39:03.000000', '2023-05-29 10:39:03.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_MCH_MAIN_USER_INFO', '主页用户信息', 'no-icon', '', '', 'PB', '0', '1', 'ENT_MCH_MAIN', '0', 'MCH', '2023-05-29 10:39:03.000000', '2023-05-29 10:39:03.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_MCH_NOTIFY', '商户通知', 'notification', '/notify', 'MchNotifyListPage', 'ML', '0', '1', 'ENT_ORDER', '30', 'MGR', '2023-05-29 10:39:00.000000', '2023-05-29 10:39:00.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_MCH_NOTIFY_RESEND', '按钮：重发通知', 'no-icon', '', '', 'PB', '0', '1', 'ENT_MCH_NOTIFY', '0', 'MGR', '2023-05-29 10:39:00.000000', '2023-05-29 10:39:00.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_MCH_NOTIFY_VIEW', '按钮：详情', 'no-icon', '', '', 'PB', '0', '1', 'ENT_MCH_NOTIFY', '0', 'MGR', '2023-05-29 10:39:00.000000', '2023-05-29 10:39:00.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_MCH_PAY_CONFIG_ADD', '应用支付参数配置', 'no-icon', '', '', 'PB', '0', '1', 'ENT_MCH_PAY_CONFIG_LIST', '0', 'MCH', '2023-05-29 10:39:04.000000', '2023-05-29 10:39:04.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_MCH_PAY_CONFIG_ADD', '应用支付参数配置', 'no-icon', '', '', 'PB', '0', '1', 'ENT_MCH_PAY_CONFIG_LIST', '0', 'MGR', '2023-05-29 10:38:59.000000', '2023-05-29 10:38:59.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_MCH_PAY_CONFIG_LIST', '应用支付参数配置列表', 'no-icon', '', '', 'PB', '0', '1', 'ENT_MCH_APP', '0', 'MCH', '2023-05-29 10:39:04.000000', '2023-05-29 10:39:04.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_MCH_PAY_CONFIG_LIST', '应用支付参数配置列表', 'no-icon', '', '', 'PB', '0', '1', 'ENT_MCH_APP', '0', 'MGR', '2023-05-29 10:38:59.000000', '2023-05-29 10:38:59.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_MCH_PAY_CONFIG_VIEW', '应用支付参数配置详情', 'no-icon', '', '', 'PB', '0', '1', 'ENT_MCH_PAY_CONFIG_LIST', '0', 'MCH', '2023-05-29 10:39:04.000000', '2023-05-29 10:39:04.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_MCH_PAY_CONFIG_VIEW', '应用支付参数配置详情', 'no-icon', '', '', 'PB', '0', '1', 'ENT_MCH_PAY_CONFIG_LIST', '0', 'MGR', '2023-05-29 10:38:59.000000', '2023-05-29 10:38:59.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_MCH_PAY_PASSAGE_ADD', '应用支付通道配置保存', 'no-icon', '', '', 'PB', '0', '1', 'ENT_MCH_PAY_PASSAGE_LIST', '0', 'MCH', '2023-05-29 10:39:05.000000', '2023-05-29 10:39:05.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_MCH_PAY_PASSAGE_ADD', '应用支付通道配置保存', 'no-icon', '', '', 'PB', '0', '1', 'ENT_MCH_PAY_PASSAGE_LIST', '0', 'MGR', '2023-05-29 10:38:59.000000', '2023-05-29 10:38:59.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_MCH_PAY_PASSAGE_CONFIG', '应用支付通道配置入口', 'no-icon', '', '', 'PB', '0', '1', 'ENT_MCH_PAY_PASSAGE_LIST', '0', 'MCH', '2023-05-29 10:39:05.000000', '2023-05-29 10:39:05.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_MCH_PAY_PASSAGE_CONFIG', '应用支付通道配置入口', 'no-icon', '', '', 'PB', '0', '1', 'ENT_MCH_PAY_PASSAGE_LIST', '0', 'MGR', '2023-05-29 10:38:59.000000', '2023-05-29 10:38:59.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_MCH_PAY_PASSAGE_LIST', '应用支付通道配置列表', 'no-icon', '', '', 'PB', '0', '1', 'ENT_MCH_APP', '0', 'MCH', '2023-05-29 10:39:05.000000', '2023-05-29 10:39:05.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_MCH_PAY_PASSAGE_LIST', '应用支付通道配置列表', 'no-icon', '', '', 'PB', '0', '1', 'ENT_MCH_APP', '0', 'MGR', '2023-05-29 10:38:59.000000', '2023-05-29 10:38:59.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_MCH_PAY_TEST', '支付测试', 'transaction', '/paytest', 'PayTestPage', 'ML', '0', '1', 'ENT_MCH_CENTER', '20', 'MCH', '2023-05-29 10:39:05.000000', '2023-05-29 10:39:05.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_MCH_PAY_TEST_DO', '按钮：支付测试', 'no-icon', '', '', 'PB', '0', '1', 'ENT_MCH_PAY_TEST', '0', 'MCH', '2023-05-29 10:39:05.000000', '2023-05-29 10:39:05.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_MCH_PAY_TEST_PAYWAY_LIST', '页面：获取全部支付方式', 'no-icon', '', '', 'PB', '0', '1', 'ENT_MCH_PAY_TEST', '0', 'MCH', '2023-05-29 10:39:05.000000', '2023-05-29 10:39:05.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_MCH_TRANSFER', '转账', 'property-safety', '/doTransfer', 'MchTransferPage', 'ML', '0', '1', 'ENT_MCH_CENTER', '30', 'MCH', '2023-05-29 10:39:05.000000', '2023-05-29 10:39:05.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_MCH_TRANSFER_CHANNEL_USER', '按钮：获取渠道用户', 'no-icon', '', '', 'PB', '0', '1', 'ENT_MCH_TRANSFER', '0', 'MCH', '2023-05-29 10:39:05.000000', '2023-05-29 10:39:05.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_MCH_TRANSFER_DO', '按钮：发起转账', 'no-icon', '', '', 'PB', '0', '1', 'ENT_MCH_TRANSFER', '0', 'MCH', '2023-05-29 10:39:05.000000', '2023-05-29 10:39:05.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_MCH_TRANSFER_IF_CODE_LIST', '页面：获取全部代付通道', 'no-icon', '', '', 'PB', '0', '1', 'ENT_MCH_TRANSFER', '0', 'MCH', '2023-05-29 10:39:05.000000', '2023-05-29 10:39:05.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_NOTIFY_LIST', '页面：商户通知列表', 'no-icon', '', '', 'PB', '0', '1', 'ENT_MCH_NOTIFY', '0', 'MGR', '2023-05-29 10:39:00.000000', '2023-05-29 10:39:00.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_ORDER', '订单中心', 'transaction', '', 'RouteView', 'ML', '0', '1', 'ROOT', '20', 'MCH', '2023-05-29 10:39:05.000000', '2023-05-29 10:39:05.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_ORDER', '订单管理', 'transaction', '', 'RouteView', 'ML', '0', '1', 'ROOT', '50', 'MGR', '2023-05-29 10:39:00.000000', '2023-05-29 10:39:00.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_ORDER_LIST', '页面：订单列表', 'no-icon', '', '', 'PB', '0', '1', 'ENT_PAY_ORDER', '0', 'MCH', '2023-05-29 10:39:05.000000', '2023-05-29 10:39:05.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_ORDER_LIST', '页面：订单列表', 'no-icon', '', '', 'PB', '0', '1', 'ENT_PAY_ORDER', '0', 'MGR', '2023-05-29 10:39:00.000000', '2023-05-29 10:39:00.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_PAY_ORDER', '订单管理', 'account-book', '/pay', 'PayOrderListPage', 'ML', '0', '1', 'ENT_ORDER', '10', 'MCH', '2023-05-29 10:39:05.000000', '2023-05-29 10:39:05.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_PAY_ORDER', '支付订单', 'account-book', '/pay', 'PayOrderListPage', 'ML', '0', '1', 'ENT_ORDER', '10', 'MGR', '2023-05-29 10:39:00.000000', '2023-05-29 10:39:00.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_PAY_ORDER_REFUND', '按钮：订单退款', 'no-icon', '', '', 'PB', '0', '1', 'ENT_PAY_ORDER', '0', 'MCH', '2023-05-29 10:39:05.000000', '2023-05-29 10:39:05.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_PAY_ORDER_REFUND', '按钮：订单退款', 'no-icon', '', '', 'PB', '0', '1', 'ENT_PAY_ORDER', '0', 'MGR', '2023-05-29 10:39:00.000000', '2023-05-29 10:39:00.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_PAY_ORDER_SEARCH_PAY_WAY', '筛选项：支付方式', 'no-icon', '', '', 'PB', '0', '1', 'ENT_PAY_ORDER', '0', 'MCH', '2023-05-29 10:39:05.000000', '2023-05-29 10:39:05.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_PAY_ORDER_SEARCH_PAY_WAY', '筛选项：支付方式', 'no-icon', '', '', 'PB', '0', '1', 'ENT_PAY_ORDER', '0', 'MGR', '2023-05-29 10:39:00.000000', '2023-05-29 10:39:00.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_PAY_ORDER_VIEW', '按钮：详情', 'no-icon', '', '', 'PB', '0', '1', 'ENT_PAY_ORDER', '0', 'MCH', '2023-05-29 10:39:05.000000', '2023-05-29 10:39:05.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_PAY_ORDER_VIEW', '按钮：详情', 'no-icon', '', '', 'PB', '0', '1', 'ENT_PAY_ORDER', '0', 'MGR', '2023-05-29 10:39:00.000000', '2023-05-29 10:39:00.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_PC', '支付配置', 'file-done', '', 'RouteView', 'ML', '0', '1', 'ROOT', '60', 'MGR', '2023-05-29 10:39:01.000000', '2023-05-29 10:39:01.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_PC_IF_DEFINE', '支付接口', 'interaction', '/ifdefines', 'IfDefinePage', 'ML', '0', '1', 'ENT_PC', '10', 'MGR', '2023-05-29 10:39:01.000000', '2023-05-29 10:39:01.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_PC_IF_DEFINE_ADD', '按钮：新增', 'no-icon', '', '', 'PB', '0', '1', 'ENT_PC_IF_DEFINE', '0', 'MGR', '2023-05-29 10:39:01.000000', '2023-05-29 10:39:01.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_PC_IF_DEFINE_DEL', '按钮：删除', 'no-icon', '', '', 'PB', '0', '1', 'ENT_PC_IF_DEFINE', '0', 'MGR', '2023-05-29 10:39:01.000000', '2023-05-29 10:39:01.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_PC_IF_DEFINE_EDIT', '按钮：修改', 'no-icon', '', '', 'PB', '0', '1', 'ENT_PC_IF_DEFINE', '0', 'MGR', '2023-05-29 10:39:01.000000', '2023-05-29 10:39:01.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_PC_IF_DEFINE_LIST', '页面：支付接口定义列表', 'no-icon', '', '', 'PB', '0', '1', 'ENT_PC_IF_DEFINE', '0', 'MGR', '2023-05-29 10:39:01.000000', '2023-05-29 10:39:01.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_PC_IF_DEFINE_SEARCH', '页面：搜索', 'no-icon', '', '', 'PB', '0', '1', 'ENT_PC_IF_DEFINE', '0', 'MGR', '2023-05-29 10:39:01.000000', '2023-05-29 10:39:01.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_PC_IF_DEFINE_VIEW', '按钮：详情', 'no-icon', '', '', 'PB', '0', '1', 'ENT_PC_IF_DEFINE', '0', 'MGR', '2023-05-29 10:39:01.000000', '2023-05-29 10:39:01.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_PC_WAY', '支付方式', 'appstore', '/payways', 'PayWayPage', 'ML', '0', '1', 'ENT_PC', '20', 'MGR', '2023-05-29 10:39:01.000000', '2023-05-29 10:39:01.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_PC_WAY_ADD', '按钮：新增', 'no-icon', '', '', 'PB', '0', '1', 'ENT_PC_WAY', '0', 'MGR', '2023-05-29 10:39:02.000000', '2023-05-29 10:39:02.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_PC_WAY_DEL', '按钮：删除', 'no-icon', '', '', 'PB', '0', '1', 'ENT_PC_WAY', '0', 'MGR', '2023-05-29 10:39:02.000000', '2023-05-29 10:39:02.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_PC_WAY_EDIT', '按钮：修改', 'no-icon', '', '', 'PB', '0', '1', 'ENT_PC_WAY', '0', 'MGR', '2023-05-29 10:39:02.000000', '2023-05-29 10:39:02.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_PC_WAY_LIST', '页面：支付方式列表', 'no-icon', '', '', 'PB', '0', '1', 'ENT_PC_WAY', '0', 'MGR', '2023-05-29 10:39:01.000000', '2023-05-29 10:39:01.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_PC_WAY_SEARCH', '页面：搜索', 'no-icon', '', '', 'PB', '0', '1', 'ENT_PC_WAY', '0', 'MGR', '2023-05-29 10:39:01.000000', '2023-05-29 10:39:01.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_PC_WAY_VIEW', '按钮：详情', 'no-icon', '', '', 'PB', '0', '1', 'ENT_PC_WAY', '0', 'MGR', '2023-05-29 10:39:01.000000', '2023-05-29 10:39:01.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_REFUND_LIST', '页面：退款订单列表', 'no-icon', '', '', 'PB', '0', '1', 'ENT_REFUND_ORDER', '0', 'MCH', '2023-05-29 10:39:06.000000', '2023-05-29 10:39:06.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_REFUND_LIST', '页面：退款订单列表', 'no-icon', '', '', 'PB', '0', '1', 'ENT_REFUND_ORDER', '0', 'MGR', '2023-05-29 10:39:00.000000', '2023-05-29 10:39:00.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_REFUND_ORDER', '退款记录', 'exception', '/refund', 'RefundOrderListPage', 'ML', '0', '1', 'ENT_ORDER', '20', 'MCH', '2023-05-29 10:39:06.000000', '2023-05-29 10:39:06.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_REFUND_ORDER', '退款订单', 'exception', '/refund', 'RefundOrderListPage', 'ML', '0', '1', 'ENT_ORDER', '20', 'MGR', '2023-05-29 10:39:00.000000', '2023-05-29 10:39:00.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_REFUND_ORDER_VIEW', '按钮：详情', 'no-icon', '', '', 'PB', '0', '1', 'ENT_REFUND_ORDER', '0', 'MCH', '2023-05-29 10:39:06.000000', '2023-05-29 10:39:06.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_REFUND_ORDER_VIEW', '按钮：详情', 'no-icon', '', '', 'PB', '0', '1', 'ENT_REFUND_ORDER', '0', 'MGR', '2023-05-29 10:39:00.000000', '2023-05-29 10:39:00.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_SYS_CONFIG', '系统管理', 'setting', '', 'RouteView', 'ML', '0', '1', 'ROOT', '200', 'MCH', '2023-05-29 10:39:07.000000', '2023-05-29 10:39:07.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_SYS_CONFIG', '系统管理', 'setting', '', 'RouteView', 'ML', '0', '1', 'ROOT', '200', 'MGR', '2023-05-29 10:39:02.000000', '2023-05-29 10:39:02.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_SYS_CONFIG_EDIT', '按钮： 修改', 'no-icon', '', '', 'PB', '0', '1', 'ENT_SYS_CONFIG_INFO', '0', 'MGR', '2023-05-29 10:39:03.000000', '2023-05-29 10:39:03.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_SYS_CONFIG_INFO', '系统配置', 'setting', '/config', 'SysConfigPage', 'ML', '0', '1', 'ENT_SYS_CONFIG', '15', 'MGR', '2023-05-29 10:39:03.000000', '2023-05-29 10:39:03.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_SYS_LOG', '系统日志', 'file-text', '/log', 'SysLogPage', 'ML', '0', '1', 'ENT_SYS_CONFIG', '20', 'MGR', '2023-05-29 10:39:03.000000', '2023-05-29 10:39:03.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_SYS_LOG_DEL', '按钮：删除', 'no-icon', '', '', 'PB', '0', '1', 'ENT_SYS_LOG', '0', 'MGR', '2023-05-29 10:39:03.000000', '2023-05-29 10:39:03.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_SYS_LOG_VIEW', '按钮：详情', 'no-icon', '', '', 'PB', '0', '1', 'ENT_SYS_LOG', '0', 'MGR', '2023-05-29 10:39:03.000000', '2023-05-29 10:39:03.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_TRANSFER_ORDER', '转账订单', 'property-safety', '/transfer', 'TransferOrderListPage', 'ML', '0', '1', 'ENT_ORDER', '30', 'MCH', '2023-05-29 10:39:06.000000', '2023-05-29 10:39:06.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_TRANSFER_ORDER', '转账订单', 'property-safety', '/transfer', 'TransferOrderListPage', 'ML', '0', '1', 'ENT_ORDER', '25', 'MGR', '2023-05-29 10:39:00.000000', '2023-05-29 10:39:00.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_TRANSFER_ORDER_LIST', '页面：转账订单列表', 'no-icon', '', '', 'PB', '0', '1', 'ENT_TRANSFER_ORDER', '0', 'MCH', '2023-05-29 10:39:06.000000', '2023-05-29 10:39:06.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_TRANSFER_ORDER_LIST', '页面：转账订单列表', 'no-icon', '', '', 'PB', '0', '1', 'ENT_TRANSFER_ORDER', '0', 'MGR', '2023-05-29 10:39:00.000000', '2023-05-29 10:39:00.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_TRANSFER_ORDER_VIEW', '按钮：详情', 'no-icon', '', '', 'PB', '0', '1', 'ENT_TRANSFER_ORDER', '0', 'MCH', '2023-05-29 10:39:06.000000', '2023-05-29 10:39:06.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_TRANSFER_ORDER_VIEW', '按钮：详情', 'no-icon', '', '', 'PB', '0', '1', 'ENT_TRANSFER_ORDER', '0', 'MGR', '2023-05-29 10:39:00.000000', '2023-05-29 10:39:00.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_UR', '用户角色管理', 'team', '', 'RouteView', 'ML', '0', '1', 'ENT_SYS_CONFIG', '10', 'MCH', '2023-05-29 10:39:07.000000', '2023-05-29 10:39:07.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_UR', '用户角色管理', 'team', '', 'RouteView', 'ML', '0', '1', 'ENT_SYS_CONFIG', '10', 'MGR', '2023-05-29 10:39:02.000000', '2023-05-29 10:39:02.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_UR_ROLE', '角色管理', 'user', '/roles', 'RolePage', 'ML', '0', '1', 'ENT_UR', '20', 'MCH', '2023-05-29 10:39:07.000000', '2023-05-29 10:39:07.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_UR_ROLE', '角色管理', 'user', '/roles', 'RolePage', 'ML', '0', '1', 'ENT_UR', '20', 'MGR', '2023-05-29 10:39:02.000000', '2023-05-29 10:39:02.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_UR_ROLE_ADD', '按钮：添加角色', 'no-icon', '', '', 'PB', '0', '1', 'ENT_UR_ROLE', '0', 'MCH', '2023-05-29 10:39:07.000000', '2023-05-29 10:39:07.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_UR_ROLE_ADD', '按钮：添加角色', 'no-icon', '', '', 'PB', '0', '1', 'ENT_UR_ROLE', '0', 'MGR', '2023-05-29 10:39:02.000000', '2023-05-29 10:39:02.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_UR_ROLE_DEL', '按钮： 删除', 'no-icon', '', '', 'PB', '0', '1', 'ENT_UR_ROLE', '0', 'MCH', '2023-05-29 10:39:07.000000', '2023-05-29 10:39:07.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_UR_ROLE_DEL', '按钮： 删除', 'no-icon', '', '', 'PB', '0', '1', 'ENT_UR_ROLE', '0', 'MGR', '2023-05-29 10:39:03.000000', '2023-05-29 10:39:03.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_UR_ROLE_DIST', '按钮： 分配权限', 'no-icon', '', '', 'PB', '0', '1', 'ENT_UR_ROLE', '0', 'MCH', '2023-05-29 10:39:07.000000', '2023-05-29 10:39:07.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_UR_ROLE_DIST', '按钮： 分配权限', 'no-icon', '', '', 'PB', '0', '1', 'ENT_UR_ROLE', '0', 'MGR', '2023-05-29 10:39:03.000000', '2023-05-29 10:39:03.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_UR_ROLE_EDIT', '按钮： 修改名称', 'no-icon', '', '', 'PB', '0', '1', 'ENT_UR_ROLE', '0', 'MCH', '2023-05-29 10:39:07.000000', '2023-05-29 10:39:07.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_UR_ROLE_EDIT', '按钮： 修改基本信息', 'no-icon', '', '', 'PB', '0', '1', 'ENT_UR_ROLE', '0', 'MGR', '2023-05-29 10:39:03.000000', '2023-05-29 10:39:03.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_UR_ROLE_ENT', '权限管理', 'apartment', '/ents', 'EntPage', 'ML', '0', '1', 'ENT_UR', '30', 'MGR', '2023-05-29 10:39:03.000000', '2023-05-29 10:39:03.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_UR_ROLE_ENT_EDIT', '按钮： 权限变更', 'no-icon', '', '', 'PB', '0', '1', 'ENT_UR_ROLE_ENT', '0', 'MGR', '2023-05-29 10:39:03.000000', '2023-05-29 10:39:03.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_UR_ROLE_ENT_LIST', '页面： 权限列表', 'no-icon', '', '', 'PB', '0', '1', 'ENT_UR_ROLE_ENT', '0', 'MGR', '2023-05-29 10:39:03.000000', '2023-05-29 10:39:03.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_UR_ROLE_LIST', '页面：角色列表', 'no-icon', '', '', 'PB', '0', '1', 'ENT_UR_ROLE', '0', 'MCH', '2023-05-29 10:39:07.000000', '2023-05-29 10:39:07.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_UR_ROLE_LIST', '页面：角色列表', 'no-icon', '', '', 'PB', '0', '1', 'ENT_UR_ROLE', '0', 'MGR', '2023-05-29 10:39:02.000000', '2023-05-29 10:39:02.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_UR_ROLE_SEARCH', '页面：搜索', 'no-icon', '', '', 'PB', '0', '1', 'ENT_UR_ROLE', '0', 'MCH', '2023-05-29 10:39:07.000000', '2023-05-29 10:39:07.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_UR_ROLE_SEARCH', '页面：搜索', 'no-icon', '', '', 'PB', '0', '1', 'ENT_UR_ROLE', '0', 'MGR', '2023-05-29 10:39:02.000000', '2023-05-29 10:39:02.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_UR_USER', '操作员管理', 'contacts', '/users', 'SysUserPage', 'ML', '0', '1', 'ENT_UR', '10', 'MCH', '2023-05-29 10:39:07.000000', '2023-05-29 10:39:07.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_UR_USER', '操作员管理', 'contacts', '/users', 'SysUserPage', 'ML', '0', '1', 'ENT_UR', '10', 'MGR', '2023-05-29 10:39:02.000000', '2023-05-29 10:39:02.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_UR_USER_ADD', '按钮：添加操作员', 'no-icon', '', '', 'PB', '0', '1', 'ENT_UR_USER', '0', 'MCH', '2023-05-29 10:39:07.000000', '2023-05-29 10:39:07.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_UR_USER_ADD', '按钮：添加操作员', 'no-icon', '', '', 'PB', '0', '1', 'ENT_UR_USER', '0', 'MGR', '2023-05-29 10:39:02.000000', '2023-05-29 10:39:02.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_UR_USER_DELETE', '按钮： 删除操作员', 'no-icon', '', '', 'PB', '0', '1', 'ENT_UR_USER', '0', 'MCH', '2023-05-29 10:39:07.000000', '2023-05-29 10:39:07.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_UR_USER_DELETE', '按钮： 删除操作员', 'no-icon', '', '', 'PB', '0', '1', 'ENT_UR_USER', '0', 'MGR', '2023-05-29 10:39:02.000000', '2023-05-29 10:39:02.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_UR_USER_EDIT', '按钮： 修改基本信息', 'no-icon', '', '', 'PB', '0', '1', 'ENT_UR_USER', '0', 'MCH', '2023-05-29 10:39:07.000000', '2023-05-29 10:39:07.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_UR_USER_EDIT', '按钮： 修改基本信息', 'no-icon', '', '', 'PB', '0', '1', 'ENT_UR_USER', '0', 'MGR', '2023-05-29 10:39:02.000000', '2023-05-29 10:39:02.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_UR_USER_LIST', '页面：操作员列表', 'no-icon', '', '', 'PB', '0', '1', 'ENT_UR_USER', '0', 'MCH', '2023-05-29 10:39:07.000000', '2023-05-29 10:39:07.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_UR_USER_LIST', '页面：操作员列表', 'no-icon', '', '', 'PB', '0', '1', 'ENT_UR_USER', '0', 'MGR', '2023-05-29 10:39:02.000000', '2023-05-29 10:39:02.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_UR_USER_SEARCH', '按钮：搜索', 'no-icon', '', '', 'PB', '0', '1', 'ENT_UR_USER', '0', 'MCH', '2023-05-29 10:39:07.000000', '2023-05-29 10:39:07.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_UR_USER_SEARCH', '按钮：搜索', 'no-icon', '', '', 'PB', '0', '1', 'ENT_UR_USER', '0', 'MGR', '2023-05-29 10:39:02.000000', '2023-05-29 10:39:02.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_UR_USER_UPD_ROLE', '按钮： 角色分配', 'no-icon', '', '', 'PB', '0', '1', 'ENT_UR_USER', '0', 'MCH', '2023-05-29 10:39:07.000000', '2023-05-29 10:39:07.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_UR_USER_UPD_ROLE', '按钮： 角色分配', 'no-icon', '', '', 'PB', '0', '1', 'ENT_UR_USER', '0', 'MGR', '2023-05-29 10:39:02.000000', '2023-05-29 10:39:02.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_UR_USER_VIEW', '按钮： 详情', '', 'no-icon', '', 'PB', '0', '1', 'ENT_UR_USER', '0', 'MCH', '2023-05-29 10:39:07.000000', '2023-05-29 10:39:07.000000');
INSERT INTO `t_sys_entitlement` VALUES ('ENT_UR_USER_VIEW', '按钮： 详情', '', 'no-icon', '', 'PB', '0', '1', 'ENT_UR_USER', '0', 'MGR', '2023-05-29 10:39:02.000000', '2023-05-29 10:39:02.000000');

-- ----------------------------
-- Table structure for t_sys_log
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_log`;
CREATE TABLE `t_sys_log` (
  `sys_log_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` bigint(20) DEFAULT NULL COMMENT '系统用户ID',
  `user_name` varchar(32) DEFAULT NULL COMMENT '用户姓名',
  `user_ip` varchar(128) NOT NULL DEFAULT '' COMMENT '用户IP',
  `sys_type` varchar(8) NOT NULL COMMENT '所属系统： MGR-运营平台, MCH-商户中心',
  `method_name` varchar(128) NOT NULL DEFAULT '' COMMENT '方法名',
  `method_remark` varchar(128) NOT NULL DEFAULT '' COMMENT '方法描述',
  `req_url` varchar(256) NOT NULL DEFAULT '' COMMENT '请求地址',
  `opt_req_param` text COMMENT '操作请求参数',
  `opt_res_info` text COMMENT '操作响应结果',
  `created_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  PRIMARY KEY (`sys_log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8mb4 COMMENT='系统操作日志表';

-- ----------------------------
-- Records of t_sys_log
-- ----------------------------
INSERT INTO `t_sys_log` VALUES ('1', '801', '超管', '61.186.97.58', 'MGR', 'com.jeequan.jeepay.mgr.ctrl.anon.AuthController.validate', '登录认证', 'http://mgr.qianrui88.com/api/anon/auth/validate', '{\"ip\":\"amVlcGF5MTIz\",\"ia\":\"amVlcGF5\",\"vc\":\"eWdkZQ==\",\"vt\":\"YmZjNjRiMjQtZmI4My00NTVjLWE4MTYtZDI0OWMzNjhhN2Mx\"}', '{\"msg\":\"SUCCESS\",\"code\":0,\"data\":{\"iToken\":\"eyJhbGciOiJIUzUxMiJ9.eyJjYWNoZUtleSI6IlRPS0VOXzgwMV9kOWNmMTJiNy1hMmFlLTQwZTItOTVhYi04Nzk0OTY3OTE5YzkiLCJjcmVhdGVkIjoxNjg1MzQ3NTYwNTA4LCJzeXNVc2VySWQiOjgwMX0.LbOp-KpH_yt_OkkXxvmpI6xUGiV2viNfdJ8Bko4rUQeQEWdDmQyZDMfZPC0r6rPLMZMscG6vV7I5lURE7VKuww\"}}', '2023-05-29 16:06:00.623000');
INSERT INTO `t_sys_log` VALUES ('2', null, null, '222.240.113.121', 'MGR', 'com.jeequan.jeepay.mgr.ctrl.anon.AuthController.validate', '登录认证', 'http://mgr.qianrui88.com/api/anon/auth/validate', '{\"ip\":\"amVlcGE=\",\"ia\":\"amVlcGF5\",\"vc\":\"ZWhtcA==\",\"vt\":\"YzBkOTUzOTctYjBjYS00ZDU1LThiNDYtNGVlZmM1NTQ1YWUz\"}', '用户名/密码错误！', '2023-05-29 23:20:38.436000');
INSERT INTO `t_sys_log` VALUES ('3', '801', '超管', '222.240.113.121', 'MGR', 'com.jeequan.jeepay.mgr.ctrl.anon.AuthController.validate', '登录认证', 'http://mgr.qianrui88.com/api/anon/auth/validate', '{\"ip\":\"amVlcGF5MTIz\",\"ia\":\"amVlcGF5\",\"vc\":\"ZWhtcA==\",\"vt\":\"YzBkOTUzOTctYjBjYS00ZDU1LThiNDYtNGVlZmM1NTQ1YWUz\"}', '{\"msg\":\"SUCCESS\",\"code\":0,\"data\":{\"iToken\":\"eyJhbGciOiJIUzUxMiJ9.eyJjYWNoZUtleSI6IlRPS0VOXzgwMV80NDIxNTg2Yy03NGExLTRlYmEtOTUwYS1lZmNkZDAwODkzMWUiLCJjcmVhdGVkIjoxNjg1MzczNjUyOTA1LCJzeXNVc2VySWQiOjgwMX0.KGDJX2MmwuQIZbMyiqInGAkyU2Zy4-Ku8YA9ZXhiWvwkFT17riJdTQMMF9rWw0998Nh2Yd-N-hM6jHdSXhd9FQ\"}}', '2023-05-29 23:20:52.907000');
INSERT INTO `t_sys_log` VALUES ('4', '801', '超管', '222.240.113.121', 'MGR', 'com.jeequan.jeepay.mgr.ctrl.merchant.MchInfoController.add', '新增商户', 'http://mgr.qianrui88.com/api/mchInfo', '{\"loginUserName\":\"loongsir\",\"contactName\":\"loongsir\",\"mchName\":\"测试001\",\"state\":1,\"type\":1,\"mchShortName\":\"测试001\",\"contactTel\":\"18670055200\"}', '{\"msg\":\"SUCCESS\",\"code\":0}', '2023-05-30 00:45:34.332000');
INSERT INTO `t_sys_log` VALUES ('5', '801', '超管', '61.186.97.58', 'MGR', 'com.jeequan.jeepay.mgr.ctrl.anon.AuthController.validate', '登录认证', 'http://mgr.qianrui88.com/api/anon/auth/validate', '{\"ip\":\"amVlcGF5MTIz\",\"ia\":\"amVlcGF5\",\"vc\":\"dHR3cA==\",\"vt\":\"MzQwNzYxOTEtZTE5MC00NzMwLTljNTYtOTk4MzQ3YThhOGUy\"}', '{\"msg\":\"SUCCESS\",\"code\":0,\"data\":{\"iToken\":\"eyJhbGciOiJIUzUxMiJ9.eyJjYWNoZUtleSI6IlRPS0VOXzgwMV9iNWY0NGZjOC03ZWRkLTRmN2YtYTZhOS1hNzBiNDc5N2MxMWEiLCJjcmVhdGVkIjoxNjg1NDA1NzE2MTMyLCJzeXNVc2VySWQiOjgwMX0.DA2w4u92xdgJAEQuIgFJOkunQ1vKyvHsDQi8dO7aN9GfXadgwV4Xlhh8fmX9-lifR-L4cfxIsRNChPQgwRrTgg\"}}', '2023-05-30 08:15:16.133000');
INSERT INTO `t_sys_log` VALUES ('6', '801', '超管', '61.186.97.58', 'MGR', 'com.jeequan.jeepay.mgr.ctrl.isv.IsvInfoController.add', '新增服务商', 'http://mgr.qianrui88.com/api/isvInfo', '{\"contactName\":\"张三\",\"isvName\":\"张三\",\"isvShortName\":\"张三\",\"state\":1,\"contactTel\":\"18670055200\"}', '{\"msg\":\"SUCCESS\",\"code\":0}', '2023-05-30 08:19:30.769000');
INSERT INTO `t_sys_log` VALUES ('7', '801', '超管', '61.186.97.58', 'MGR', 'com.jeequan.jeepay.mgr.ctrl.merchant.MchInfoController.add', '新增商户', 'http://mgr.qianrui88.com/api/mchInfo', '{\"loginUserName\":\"lisi1234\",\"contactName\":\"李四\",\"mchName\":\"李四\",\"state\":1,\"type\":1,\"mchShortName\":\"李四\",\"contactTel\":\"19119290099\"}', '{\"msg\":\"SUCCESS\",\"code\":0}', '2023-05-30 08:20:45.132000');
INSERT INTO `t_sys_log` VALUES ('8', null, null, '61.186.97.58', 'MCH', 'com.jeequan.jeepay.mch.ctrl.anon.AuthController.validate', '登录认证', 'http://mch.qianrui88.com/api/anon/auth/validate', '{\"ip\":\"MTIzNDU2\",\"ia\":\"bGlzaTEyMzQ=\",\"vc\":\"czB4bQ==\",\"vt\":\"NGQ3NjRiYmEtNTBhOC00MTgxLTlkNDYtNzUyYjA1ODlkOTdh\"}', '用户名/密码错误！', '2023-05-30 08:30:25.120000');
INSERT INTO `t_sys_log` VALUES ('9', '100002', '李四', '61.186.97.58', 'MCH', 'com.jeequan.jeepay.mch.ctrl.anon.AuthController.validate', '登录认证', 'http://mch.qianrui88.com/api/anon/auth/validate', '{\"ip\":\"amVlcGF5NjY2\",\"ia\":\"bGlzaTEyMzQ=\",\"vc\":\"czB4bQ==\",\"vt\":\"NGQ3NjRiYmEtNTBhOC00MTgxLTlkNDYtNzUyYjA1ODlkOTdh\"}', '{\"msg\":\"SUCCESS\",\"code\":0,\"data\":{\"iToken\":\"eyJhbGciOiJIUzUxMiJ9.eyJjYWNoZUtleSI6IlRPS0VOXzEwMDAwMl82ZGU0ZTlmYi0wZTAyLTQ1ZjYtYmZkOC1kMzgzMDMyNmRlYzUiLCJjcmVhdGVkIjoxNjg1NDA2NjU0NTU3LCJzeXNVc2VySWQiOjEwMDAwMn0.dhkrXQj6kZIT5x-Y2szAb0_wUiKZ7CWHq_y8aB0bbMD3kFR7kSymj_M2IazIWilSSVm2fu95Co9ISItzF9A9EA\"}}', '2023-05-30 08:30:54.627000');
INSERT INTO `t_sys_log` VALUES ('10', '801', '超管', '61.186.97.58', 'MGR', 'com.jeequan.jeepay.mgr.ctrl.config.SysConfigController.update', '系统配置修改', 'http://mgr.qianrui88.com/api/sysConfigs/applicationConfig', '{\"paySiteUrl\":\"http://pay.qianrui88.com\",\"ossPublicSiteUrl\":\"http://127.0.0.1:9217/api/anon/localOssFiles\",\"mgrSiteUrl\":\"http://mgr.qianrui88.com\",\"mchSiteUrl\":\"http://mch.qianrui88.com\"}', '{\"msg\":\"SUCCESS\",\"code\":0}', '2023-05-30 08:49:51.343000');
INSERT INTO `t_sys_log` VALUES ('11', '801', '超管', '61.186.97.58', 'MGR', 'com.jeequan.jeepay.mgr.ctrl.config.SysConfigController.update', '系统配置修改', 'http://mgr.qianrui88.com/api/sysConfigs/applicationConfig', '{\"paySiteUrl\":\"http://pay.qianrui88.com\",\"ossPublicSiteUrl\":\"http://mgr.qianrui88.com/api/anon/localOssFiles\",\"mgrSiteUrl\":\"http://mgr.qianrui88.com\",\"mchSiteUrl\":\"http://mch.qianrui88.com\"}', '{\"msg\":\"SUCCESS\",\"code\":0}', '2023-05-30 08:50:12.165000');
INSERT INTO `t_sys_log` VALUES ('12', '801', '超管', '61.186.97.58', 'MGR', 'com.jeequan.jeepay.mgr.ctrl.config.SysConfigController.update', '系统配置修改', 'http://mgr.qianrui88.com/api/sysConfigs/applicationConfig', '{\"paySiteUrl\":\"http://pay.qianrui88.com\",\"ossPublicSiteUrl\":\"http://mgr.qianrui88.com/api/anon/localOssFiles\",\"mgrSiteUrl\":\"http://mgr.qianrui88.com\",\"mchSiteUrl\":\"http://mch.qianrui88.com\"}', '{\"msg\":\"SUCCESS\",\"code\":0}', '2023-05-30 08:50:27.758000');
INSERT INTO `t_sys_log` VALUES ('13', '100002', '李四', '61.186.97.58', 'MCH', 'com.jeequan.jeepay.mch.ctrl.merchant.MchPayInterfaceConfigController.saveOrUpdate', '更新商户支付参数', 'http://mch.qianrui88.com/api/mch/payConfigs', '{\"ifCode\":\"alipay\",\"infoId\":\"6475415de4b0859a5a9aa134\",\"ifParams\":\"{\\\"sandbox\\\":1,\\\"signType\\\":\\\"RSA2\\\",\\\"useCert\\\":0,\\\"privateKey\\\":\\\"MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCk+QP/WToRoEfgHml5XXV/Ths5axRob6VbEsbrcEZvT6uSORjOhw+KxP9XpASvS1s35Tx4GbLxrJbOR91lvl8MuWbzfnoQhAtQeztMN8LsMxEEJ4IDyJrkLp57Ig3zFFjKSJk6gqARXrrNj5HxQUAxADLvz2TAdfl3dN+t2uOQxvsvEpIVv37vARSkUN53d5BDeJOyf8uZI62C+giZrzWm0pvi76yZZyy075Ii+lW+LPOXbCynN1JlDJ0qSegfUxGIIFAhghuLcZeh0osNJSWp9+RxmLGhv+Ft5WIY44bf7bINRiuGJfdFlGS6gMDgYRM9LDizTugXMEOsTCkslVf1AgMBAAECggEAR/XjG4AlR0j98THy2iC9PvGoCGy/8yo4G7jeEhbgcm9zLI5BVt0tF2AE7Yq7DGe3e3M/5Dd5ide51HMejOH0fg1lbfMOdaPTd6C5Ze6w1O0VkBVXriTUA5KeSKG7KfwHGv198TrHbaw/maj1hSHsSTOIBHkXvqf3UHcnlqNzPlQJA7ZI792N5UCmoAyGOkSRDf+WdRwNfRemQgkadzLuvM+QpKEvEXfA7Ji1UpEERp4+g4t2b0Uy9I0VeX5e+MmxNOfoaXToe9HK4qtSDOAOw/4Wd0ypU+SXwuWxT5rDrpJ74RZnxyU/Fd9aV8KZVgUzA0GuOeMw7Ihf1zl2JQt7xQKBgQDmqizqWo9XdDj9v5G30MeU6SFv5Jt4+o6vqhIOYC+hWj+4Cs1Lg3pZ5+aZi47srqhcs3p8X3y1DDWx70U9+8Uve8krxiqnDJpjVK19t+3jXtyvpQ3Q8PXTfMqUAmpElVs6NMrw3/6yyCgX1JnSViRq6Qkym1WreHlkjieUv013gwKBgQC3F7auBnp0/OdO3aBDJe68hxVXrxmAd+dSYu2dW3hzmzS7WPSKaqj3jLIgAmvXdmztxl2Ufq5MoLjPwEWTeyNoHCUpIGoAa/FfsZer0Z6RhNUQzg4FEf0lgd59jT6ncgADF7X+aXbeFkq+XgtjIU4VeoDXntV9WZ0tDH1ZPOrhJwKBgQC7jnoxIOvXF5jTs3ZgObJfQeU/X2qPx2RIMAi4ibuQ/po7IwVlNoZBHpBiH5lamHYr0oBxKw9zA3eRtFXgHZ1ri8K7BkpeRKAwzoS3adxT+imF5LbEQ3oPujPaf9A67hsczBqMHAa1Bo2bOvLMleDM0an57VaOs8o5WmGS0K7D0wKBgCmUPg0pNXgJ0vGrDPES1TOFLcia4By3nhWsl6+LjUAbuA7vtaEVdce58N2qDxmAMF6TFL9bQXPvb+jmDibe6PyEn7/GN6xe1xLXPs1rLip30vcdBDwMiMOSyZcTk23tSqlpIhBjnPX0dAblToq1joj8J/RPgsYTqskHNBQm7GQzAoGAfGey7ciJHlsenHHuxeW91pGRvhtRvYCP1k9bH6kESrY5R4o5/VMtcC/cTs6ck5JNxDS8Xg2wpfcIR7RsVc/0uEkUmzCOs8tkeWYfP0nuQQ3WKjageSqwTkpyrsUVFJGX/VkeDAQlHX2AWq6LPzNGFqUm6l56qrez3AWt50ezWTM=\\\",\\\"alipayPublicKey\\\":\\\"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA0lgbLuX+xYODpgcn+ju7yzp2Qwa3QVNhF0tAZTSoBIN0u/aFGZp6gcQYuBgylY9AM2woortWnzIDbnxhgDmsjumKC2hpuIfRKTe6LS8w6GZsX7ucNd0x+ZW2UepLRasgFnp02YawzGliCcHzhKblbHc1x7dscz+LnYmn0pkU9GRTIPqZ5gm35K18ix4VHv1D+lxMgUv6Bh09hxwDOo3+dGr7Lo4jN/MR5irOV5CfqrQ/1noJROaWIba8ZE6/v5TWu8EGdGg1yU6VBXSuxKRY2sUoIzPewMzmsQKy43Gy0UOrG/IO+Fcexp2J8dbCxiiCB04rMUfh/JgS/EOCTmMlSwIDAQAB\\\",\\\"appPublicCert\\\":\\\"\\\",\\\"alipayPublicCert\\\":\\\"\\\",\\\"alipayRootCert\\\":\\\"\\\",\\\"appId\\\":\\\"9021000122673936\\\"}\",\"state\":1}', '{\"msg\":\"SUCCESS\",\"code\":0}', '2023-05-30 08:56:28.580000');
INSERT INTO `t_sys_log` VALUES ('14', '100002', '李四', '61.186.97.58', 'MCH', 'com.jeequan.jeepay.mch.ctrl.merchant.MchPayPassageConfigController.saveOrUpdate', '更新应用支付通道', 'http://mch.qianrui88.com/api/mch/payPassages', '{\"reqParams\":\"[{\\\"id\\\":\\\"\\\",\\\"appId\\\":\\\"6475415de4b0859a5a9aa134\\\",\\\"wayCode\\\":\\\"ALI_WAP\\\",\\\"ifCode\\\":\\\"alipay\\\",\\\"rate\\\":\\\"0.6\\\",\\\"state\\\":1}]\"}', '{\"msg\":\"SUCCESS\",\"code\":0}', '2023-05-30 08:57:15.460000');
INSERT INTO `t_sys_log` VALUES ('15', '100002', '李四', '61.186.97.58', 'MCH', 'com.jeequan.jeepay.mch.ctrl.merchant.MchPayPassageConfigController.saveOrUpdate', '更新应用支付通道', 'http://mch.qianrui88.com/api/mch/payPassages', '{\"reqParams\":\"[{\\\"id\\\":\\\"\\\",\\\"appId\\\":\\\"6475415de4b0859a5a9aa134\\\",\\\"wayCode\\\":\\\"ALI_APP\\\",\\\"ifCode\\\":\\\"alipay\\\",\\\"rate\\\":\\\"0.6\\\",\\\"state\\\":1}]\"}', '{\"msg\":\"SUCCESS\",\"code\":0}', '2023-05-30 08:57:33.859000');
INSERT INTO `t_sys_log` VALUES ('16', '100002', '李四', '61.186.97.58', 'MCH', 'com.jeequan.jeepay.mch.ctrl.merchant.MchPayPassageConfigController.saveOrUpdate', '更新应用支付通道', 'http://mch.qianrui88.com/api/mch/payPassages', '{\"reqParams\":\"[{\\\"id\\\":\\\"\\\",\\\"appId\\\":\\\"6475415de4b0859a5a9aa134\\\",\\\"wayCode\\\":\\\"ALI_BAR\\\",\\\"ifCode\\\":\\\"alipay\\\",\\\"rate\\\":\\\"0.6\\\",\\\"state\\\":1}]\"}', '{\"msg\":\"SUCCESS\",\"code\":0}', '2023-05-30 08:57:37.467000');
INSERT INTO `t_sys_log` VALUES ('17', '100002', '李四', '61.186.97.58', 'MCH', 'com.jeequan.jeepay.mch.ctrl.merchant.MchPayPassageConfigController.saveOrUpdate', '更新应用支付通道', 'http://mch.qianrui88.com/api/mch/payPassages', '{\"reqParams\":\"[{\\\"id\\\":\\\"\\\",\\\"appId\\\":\\\"6475415de4b0859a5a9aa134\\\",\\\"wayCode\\\":\\\"ALI_JSAPI\\\",\\\"ifCode\\\":\\\"alipay\\\",\\\"rate\\\":\\\"0.6\\\",\\\"state\\\":1}]\"}', '{\"msg\":\"SUCCESS\",\"code\":0}', '2023-05-30 08:57:42.230000');
INSERT INTO `t_sys_log` VALUES ('18', '100002', '李四', '61.186.97.58', 'MCH', 'com.jeequan.jeepay.mch.ctrl.merchant.MchPayPassageConfigController.saveOrUpdate', '更新应用支付通道', 'http://mch.qianrui88.com/api/mch/payPassages', '{\"reqParams\":\"[{\\\"id\\\":\\\"\\\",\\\"appId\\\":\\\"6475415de4b0859a5a9aa134\\\",\\\"wayCode\\\":\\\"ALI_PC\\\",\\\"ifCode\\\":\\\"alipay\\\",\\\"rate\\\":\\\"0.6\\\",\\\"state\\\":1}]\"}', '{\"msg\":\"SUCCESS\",\"code\":0}', '2023-05-30 08:57:49.412000');
INSERT INTO `t_sys_log` VALUES ('19', '100002', '李四', '61.186.97.58', 'MCH', 'com.jeequan.jeepay.mch.ctrl.merchant.MchPayPassageConfigController.saveOrUpdate', '更新应用支付通道', 'http://mch.qianrui88.com/api/mch/payPassages', '{\"reqParams\":\"[{\\\"id\\\":\\\"\\\",\\\"appId\\\":\\\"6475415de4b0859a5a9aa134\\\",\\\"wayCode\\\":\\\"ALI_QR\\\",\\\"ifCode\\\":\\\"alipay\\\",\\\"rate\\\":\\\"0.6\\\",\\\"state\\\":1}]\"}', '{\"msg\":\"SUCCESS\",\"code\":0}', '2023-05-30 08:57:58.075000');
INSERT INTO `t_sys_log` VALUES ('20', '100002', '李四', '61.186.97.58', 'MCH', 'com.jeequan.jeepay.mch.ctrl.merchant.MchPayInterfaceConfigController.saveOrUpdate', '更新商户支付参数', 'http://mch.qianrui88.com/api/mch/payConfigs', '{\"ifCode\":\"alipay\",\"infoId\":\"6475415de4b0859a5a9aa134\",\"ifParams\":\"{\\\"alipayPublicCert\\\":\\\"\\\",\\\"privateKey\\\":\\\"MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCk+QP/WToRoEfgHml5XXV/Ths5axRob6VbEsbrcEZvT6uSORjOhw+KxP9XpASvS1s35Tx4GbLxrJbOR91lvl8MuWbzfnoQhAtQeztMN8LsMxEEJ4IDyJrkLp57Ig3zFFjKSJk6gqARXrrNj5HxQUAxADLvz2TAdfl3dN+t2uOQxvsvEpIVv37vARSkUN53d5BDeJOyf8uZI62C+giZrzWm0pvi76yZZyy075Ii+lW+LPOXbCynN1JlDJ0qSegfUxGIIFAhghuLcZeh0osNJSWp9+RxmLGhv+Ft5WIY44bf7bINRiuGJfdFlGS6gMDgYRM9LDizTugXMEOsTCkslVf1AgMBAAECggEAR/XjG4AlR0j98THy2iC9PvGoCGy/8yo4G7jeEhbgcm9zLI5BVt0tF2AE7Yq7DGe3e3M/5Dd5ide51HMejOH0fg1lbfMOdaPTd6C5Ze6w1O0VkBVXriTUA5KeSKG7KfwHGv198TrHbaw/maj1hSHsSTOIBHkXvqf3UHcnlqNzPlQJA7ZI792N5UCmoAyGOkSRDf+WdRwNfRemQgkadzLuvM+QpKEvEXfA7Ji1UpEERp4+g4t2b0Uy9I0VeX5e+MmxNOfoaXToe9HK4qtSDOAOw/4Wd0ypU+SXwuWxT5rDrpJ74RZnxyU/Fd9aV8KZVgUzA0GuOeMw7Ihf1zl2JQt7xQKBgQDmqizqWo9XdDj9v5G30MeU6SFv5Jt4+o6vqhIOYC+hWj+4Cs1Lg3pZ5+aZi47srqhcs3p8X3y1DDWx70U9+8Uve8krxiqnDJpjVK19t+3jXtyvpQ3Q8PXTfMqUAmpElVs6NMrw3/6yyCgX1JnSViRq6Qkym1WreHlkjieUv013gwKBgQC3F7auBnp0/OdO3aBDJe68hxVXrxmAd+dSYu2dW3hzmzS7WPSKaqj3jLIgAmvXdmztxl2Ufq5MoLjPwEWTeyNoHCUpIGoAa/FfsZer0Z6RhNUQzg4FEf0lgd59jT6ncgADF7X+aXbeFkq+XgtjIU4VeoDXntV9WZ0tDH1ZPOrhJwKBgQC7jnoxIOvXF5jTs3ZgObJfQeU/X2qPx2RIMAi4ibuQ/po7IwVlNoZBHpBiH5lamHYr0oBxKw9zA3eRtFXgHZ1ri8K7BkpeRKAwzoS3adxT+imF5LbEQ3oPujPaf9A67hsczBqMHAa1Bo2bOvLMleDM0an57VaOs8o5WmGS0K7D0wKBgCmUPg0pNXgJ0vGrDPES1TOFLcia4By3nhWsl6+LjUAbuA7vtaEVdce58N2qDxmAMF6TFL9bQXPvb+jmDibe6PyEn7/GN6xe1xLXPs1rLip30vcdBDwMiMOSyZcTk23tSqlpIhBjnPX0dAblToq1joj8J/RPgsYTqskHNBQm7GQzAoGAfGey7ciJHlsenHHuxeW91pGRvhtRvYCP1k9bH6kESrY5R4o5/VMtcC/cTs6ck5JNxDS8Xg2wpfcIR7RsVc/0uEkUmzCOs8tkeWYfP0nuQQ3WKjageSqwTkpyrsUVFJGX/VkeDAQlHX2AWq6LPzNGFqUm6l56qrez3AWt50ezWTM=\\\",\\\"alipayPublicKey\\\":\\\"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA0lgbLuX+xYODpgcn+ju7yzp2Qwa3QVNhF0tAZTSoBIN0u/aFGZp6gcQYuBgylY9AM2woortWnzIDbnxhgDmsjumKC2hpuIfRKTe6LS8w6GZsX7ucNd0x+ZW2UepLRasgFnp02YawzGliCcHzhKblbHc1x7dscz+LnYmn0pkU9GRTIPqZ5gm35K18ix4VHv1D+lxMgUv6Bh09hxwDOo3+dGr7Lo4jN/MR5irOV5CfqrQ/1noJROaWIba8ZE6/v5TWu8EGdGg1yU6VBXSuxKRY2sUoIzPewMzmsQKy43Gy0UOrG/IO+Fcexp2J8dbCxiiCB04rMUfh/JgS/EOCTmMlSwIDAQAB\\\",\\\"appPublicCert\\\":\\\"\\\",\\\"appId\\\":\\\"9021000122673936\\\",\\\"alipayRootCert\\\":\\\"\\\",\\\"sandbox\\\":1,\\\"signType\\\":\\\"RSA2\\\",\\\"useCert\\\":0}\",\"state\":1}', '{\"msg\":\"SUCCESS\",\"code\":0}', '2023-05-30 09:01:22.576000');
INSERT INTO `t_sys_log` VALUES ('21', '801', '超管', '61.186.97.58', 'MGR', 'com.jeequan.jeepay.mgr.ctrl.payconfig.PayInterfaceDefineController.update', '更新支付接口', 'http://mgr.qianrui88.com/api/payIfDefines/alipay', '{\"ifCode\":\"alipay\",\"normalMchParams\":\"[{\\\"name\\\":\\\"sandbox\\\",\\\"desc\\\":\\\"环境配置\\\",\\\"type\\\":\\\"radio\\\",\\\"verify\\\":\\\"\\\",\\\"values\\\":\\\"1,0\\\",\\\"titles\\\":\\\"沙箱环境,生产环境\\\",\\\"verify\\\":\\\"required\\\"},{\\\"name\\\":\\\"appId\\\",\\\"desc\\\":\\\"应用App ID\\\",\\\"type\\\":\\\"text\\\",\\\"verify\\\":\\\"required\\\"},{\\\"name\\\":\\\"privateKey\\\", \\\"desc\\\":\\\"应用私钥\\\", \\\"type\\\": \\\"textarea\\\",\\\"verify\\\":\\\"required\\\",\\\"star\\\":\\\"1\\\"},{\\\"name\\\":\\\"alipayPublicKey\\\", \\\"desc\\\":\\\"支付宝公钥(不使用证书时必填)\\\", \\\"type\\\": \\\"textarea\\\",\\\"star\\\":\\\"1\\\"},{\\\"name\\\":\\\"signType\\\",\\\"desc\\\":\\\"接口签名方式(推荐使用RSA2)\\\",\\\"type\\\":\\\"radio\\\",\\\"verify\\\":\\\"\\\",\\\"values\\\":\\\"RSA,RSA2\\\",\\\"titles\\\":\\\"RSA,RSA2\\\",\\\"verify\\\":\\\"required\\\"},{\\\"name\\\":\\\"useCert\\\",\\\"desc\\\":\\\"公钥证书\\\",\\\"type\\\":\\\"radio\\\",\\\"verify\\\":\\\"\\\",\\\"values\\\":\\\"1,0\\\",\\\"titles\\\":\\\"使用证书（请使用RSA2私钥）,不使用证书\\\"},{\\\"name\\\":\\\"appPublicCert\\\",\\\"desc\\\":\\\"应用公钥证书（.crt格式）\\\",\\\"type\\\":\\\"file\\\",\\\"verify\\\":\\\"\\\"},{\\\"name\\\":\\\"alipayPublicCert\\\",\\\"desc\\\":\\\"支付宝公钥证书（.crt格式）\\\",\\\"type\\\":\\\"file\\\",\\\"verify\\\":\\\"\\\"},{\\\"name\\\":\\\"alipayRootCert\\\",\\\"desc\\\":\\\"支付宝根证书（.crt格式）\\\",\\\"type\\\":\\\"file\\\",\\\"verify\\\":\\\"\\\"}]\",\"isIsvMode\":1,\"ifName\":\"支付宝官方\",\"wayCodeStrs\":\"ALI_APP,ALI_PC,ALI_WAP\",\"icon\":\"http://jeequan.oss-cn-beijing.aliyuncs.com/jeepay/img/alipay.png\",\"remark\":\"支付宝官方通道\",\"configPageType\":2,\"isMchMode\":1,\"createdAt\":\"2023-05-29 10:39:10\",\"wayCodes\":[{\"wayCode\":\"ALI_JSAPI\"},{\"wayCode\":\"ALI_WAP\"},{\"wayCode\":\"ALI_BAR\"},{\"wayCode\":\"ALI_APP\"},{\"wayCode\":\"ALI_PC\"},{\"wayCode\":\"ALI_QR\"}],\"isvsubMchParams\":\"[{\\\"name\\\":\\\"appAuthToken\\\", \\\"desc\\\":\\\"子商户app_auth_token\\\", \\\"type\\\": \\\"text\\\",\\\"readonly\\\":\\\"readonly\\\"},{\\\"name\\\":\\\"refreshToken\\\", \\\"desc\\\":\\\"子商户刷新token\\\", \\\"type\\\": \\\"hidden\\\",\\\"readonly\\\":\\\"readonly\\\"},{\\\"name\\\":\\\"expireTimestamp\\\", \\\"desc\\\":\\\"authToken有效期（13位时间戳）\\\", \\\"type\\\": \\\"hidden\\\",\\\"readonly\\\":\\\"readonly\\\"}]\",\"bgColor\":\"#1779FF\",\"isvParams\":\"[{\\\"name\\\":\\\"sandbox\\\",\\\"desc\\\":\\\"环境配置\\\",\\\"type\\\":\\\"radio\\\",\\\"verify\\\":\\\"\\\",\\\"values\\\":\\\"1,0\\\",\\\"titles\\\":\\\"沙箱环境,生产环境\\\",\\\"verify\\\":\\\"required\\\"},{\\\"name\\\":\\\"pid\\\",\\\"desc\\\":\\\"合作伙伴身份（PID）\\\",\\\"type\\\":\\\"text\\\",\\\"verify\\\":\\\"required\\\"},{\\\"name\\\":\\\"appId\\\",\\\"desc\\\":\\\"应用App ID\\\",\\\"type\\\":\\\"text\\\",\\\"verify\\\":\\\"required\\\"},{\\\"name\\\":\\\"privateKey\\\", \\\"desc\\\":\\\"应用私钥\\\", \\\"type\\\": \\\"textarea\\\",\\\"verify\\\":\\\"required\\\",\\\"star\\\":\\\"1\\\"},{\\\"name\\\":\\\"alipayPublicKey\\\", \\\"desc\\\":\\\"支付宝公钥(不使用证书时必填)\\\", \\\"type\\\": \\\"textarea\\\",\\\"star\\\":\\\"1\\\"},{\\\"name\\\":\\\"signType\\\",\\\"desc\\\":\\\"接口签名方式(推荐使用RSA2)\\\",\\\"type\\\":\\\"radio\\\",\\\"verify\\\":\\\"\\\",\\\"values\\\":\\\"RSA,RSA2\\\",\\\"titles\\\":\\\"RSA,RSA2\\\",\\\"verify\\\":\\\"required\\\"},{\\\"name\\\":\\\"useCert\\\",\\\"desc\\\":\\\"公钥证书\\\",\\\"type\\\":\\\"radio\\\",\\\"verify\\\":\\\"\\\",\\\"values\\\":\\\"1,0\\\",\\\"titles\\\":\\\"使用证书（请使用RSA2私钥）,不使用证书\\\"},{\\\"name\\\":\\\"appPublicCert\\\",\\\"desc\\\":\\\"应用公钥证书（.crt格式）\\\",\\\"type\\\":\\\"file\\\",\\\"verify\\\":\\\"\\\"},{\\\"name\\\":\\\"alipayPublicCert\\\",\\\"desc\\\":\\\"支付宝公钥证书（.crt格式）\\\",\\\"type\\\":\\\"file\\\",\\\"verify\\\":\\\"\\\"},{\\\"name\\\":\\\"alipayRootCert\\\",\\\"desc\\\":\\\"支付宝根证书（.crt格式）\\\",\\\"type\\\":\\\"file\\\",\\\"verify\\\":\\\"\\\"}]\",\"state\":1,\"updatedAt\":\"2023-05-29 10:39:10\"}', '{\"msg\":\"SUCCESS\",\"code\":0}', '2023-05-30 09:07:39.202000');
INSERT INTO `t_sys_log` VALUES ('22', '801', '超管', '61.186.97.58', 'MGR', 'com.jeequan.jeepay.mgr.ctrl.anon.AuthController.validate', '登录认证', 'http://mgr.qianrui88.com/api/anon/auth/validate', '{\"ip\":\"amVlcGF5MTIz\",\"ia\":\"amVlcGF5\",\"vc\":\"anRmag==\",\"vt\":\"NGE5MTEwMDktNjM5Ny00ZjExLWEwYWEtNTVjN2RmNTQ5MDI4\"}', '{\"msg\":\"SUCCESS\",\"code\":0,\"data\":{\"iToken\":\"eyJhbGciOiJIUzUxMiJ9.eyJjYWNoZUtleSI6IlRPS0VOXzgwMV8yMmUxNWZmZS03MWUyLTQ1MmMtODc0Yy03ODI1MjljZTY2MDUiLCJjcmVhdGVkIjoxNjg1NDk5NTgyOTM3LCJzeXNVc2VySWQiOjgwMX0.FVJTD4f02mv3Y3g8icQAxlsoAUFmm-2jXejfh4Wec_b1QqaCK9xFv90PgOOGpzoJTFKx5vlhXHn9HhdFIn2VQA\"}}', '2023-05-31 10:19:42.939000');
INSERT INTO `t_sys_log` VALUES ('23', '100002', '李四', '61.186.97.58', 'MCH', 'com.jeequan.jeepay.mch.ctrl.anon.AuthController.validate', '登录认证', 'http://mch.qianrui88.com/api/anon/auth/validate', '{\"ip\":\"amVlcGF5NjY2\",\"ia\":\"bGlzaTEyMzQ=\",\"vc\":\"NWc5bQ==\",\"vt\":\"MmQyMmRiNGMtYjBhZC00OGM3LWI4ZTUtNzQ4YjM2NWJkMDc4\"}', '{\"msg\":\"SUCCESS\",\"code\":0,\"data\":{\"iToken\":\"eyJhbGciOiJIUzUxMiJ9.eyJjYWNoZUtleSI6IlRPS0VOXzEwMDAwMl80ZTE0ZjZlMi1hYWVlLTQ4NjUtYTg4Ni1mNDE0YTFlZTJmYTYiLCJjcmVhdGVkIjoxNjg1NDk5NzAwMzkwLCJzeXNVc2VySWQiOjEwMDAwMn0.ED6sN9kU34M6YWtUSMORiWck6TDTLu1B3GxEIoplMxADef0b8up8tPR1iH9jsOokCuAYftBb3sHBWTuIZcG06w\"}}', '2023-05-31 10:21:40.391000');
INSERT INTO `t_sys_log` VALUES ('24', '100002', '李四', '61.186.97.58', 'MCH', 'com.jeequan.jeepay.mch.ctrl.merchant.MchPayInterfaceConfigController.saveOrUpdate', '更新商户支付参数', 'http://mch.qianrui88.com/api/mch/payConfigs', '{\"ifCode\":\"alipay\",\"infoId\":\"6475415de4b0859a5a9aa134\",\"ifParams\":\"{\\\"alipayPublicCert\\\":\\\"\\\",\\\"appPublicCert\\\":\\\"\\\",\\\"appId\\\":\\\"9021000122673936\\\",\\\"alipayRootCert\\\":\\\"\\\",\\\"sandbox\\\":0,\\\"signType\\\":\\\"RSA2\\\",\\\"useCert\\\":0}\",\"state\":1}', '{\"msg\":\"SUCCESS\",\"code\":0}', '2023-05-31 10:23:08.383000');
INSERT INTO `t_sys_log` VALUES ('25', '801', '超管', '61.186.97.58', 'MGR', 'com.jeequan.jeepay.mgr.ctrl.payconfig.PayInterfaceDefineController.update', '更新支付接口', 'http://mgr.qianrui88.com/api/payIfDefines/pppay', '{\"ifCode\":\"pppay\",\"normalMchParams\":\"[{\\\"name\\\":\\\"sandbox\\\",\\\"desc\\\":\\\"环境配置\\\",\\\"type\\\":\\\"radio\\\",\\\"verify\\\":\\\"required\\\",\\\"values\\\":\\\"1,0\\\",\\\"titles\\\":\\\"沙箱环境, 生产环境\\\"},{\\\"name\\\":\\\"clientId\\\",\\\"desc\\\":\\\"Client ID（客户端ID）\\\",\\\"type\\\":\\\"text\\\",\\\"verify\\\":\\\"required\\\"},{\\\"name\\\":\\\"secret\\\",\\\"desc\\\":\\\"Secret（密钥）\\\",\\\"type\\\":\\\"text\\\",\\\"verify\\\":\\\"required\\\",\\\"star\\\":\\\"1\\\"},{\\\"name\\\":\\\"refundWebhook\\\",\\\"desc\\\":\\\"退款 Webhook id\\\",\\\"type\\\":\\\"text\\\",\\\"verify\\\":\\\"required\\\"},{\\\"name\\\":\\\"notifyWebhook\\\",\\\"desc\\\":\\\"支付 Webhook id\\\",\\\"type\\\":\\\"text\\\",\\\"verify\\\":\\\"required\\\"}]\",\"isIsvMode\":0,\"ifName\":\"PayPal支付\",\"wayCodeStrs\":\"PP_PC\",\"icon\":\"http://jeequan.oss-cn-beijing.aliyuncs.com/jeepay/img/paypal.png\",\"remark\":\"PayPal官方通道\",\"configPageType\":1,\"isMchMode\":1,\"createdAt\":\"2023-05-29 10:39:10\",\"wayCodes\":[{\"wayCode\":\"PP_PC\"}],\"bgColor\":\"#005ea6\",\"state\":0,\"updatedAt\":\"2023-05-29 10:39:10\"}', '{\"msg\":\"SUCCESS\",\"code\":0}', '2023-05-31 10:33:32.655000');
INSERT INTO `t_sys_log` VALUES ('26', '801', '超管', '61.186.97.58', 'MGR', 'com.jeequan.jeepay.mgr.ctrl.payconfig.PayInterfaceDefineController.update', '更新支付接口', 'http://mgr.qianrui88.com/api/payIfDefines/wxpay', '{\"ifCode\":\"wxpay\",\"normalMchParams\":\"[{\\\"name\\\":\\\"mchId\\\", \\\"desc\\\":\\\"微信支付商户号\\\", \\\"type\\\": \\\"text\\\",\\\"verify\\\":\\\"required\\\"},{\\\"name\\\":\\\"appId\\\",\\\"desc\\\":\\\"应用App ID\\\",\\\"type\\\":\\\"text\\\",\\\"verify\\\":\\\"required\\\"},{\\\"name\\\":\\\"appSecret\\\",\\\"desc\\\":\\\"应用AppSecret\\\",\\\"type\\\":\\\"text\\\",\\\"verify\\\":\\\"required\\\",\\\"star\\\":\\\"1\\\"},{\\\"name\\\":\\\"oauth2Url\\\", \\\"desc\\\":\\\"oauth2地址（置空将使用官方）\\\", \\\"type\\\": \\\"text\\\"},{\\\"name\\\":\\\"apiVersion\\\", \\\"desc\\\":\\\"微信支付API版本\\\", \\\"type\\\": \\\"radio\\\",\\\"values\\\":\\\"V2,V3\\\",\\\"titles\\\":\\\"V2,V3\\\",\\\"verify\\\":\\\"required\\\"},{\\\"name\\\":\\\"key\\\", \\\"desc\\\":\\\"APIv2密钥\\\", \\\"type\\\": \\\"textarea\\\",\\\"verify\\\":\\\"required\\\",\\\"star\\\":\\\"1\\\"},{\\\"name\\\":\\\"apiV3Key\\\", \\\"desc\\\":\\\"APIv3密钥（V3接口必填）\\\", \\\"type\\\": \\\"textarea\\\",\\\"verify\\\":\\\"\\\",\\\"star\\\":\\\"1\\\"},{\\\"name\\\":\\\"serialNo\\\", \\\"desc\\\":\\\"序列号（V3接口必填）\\\", \\\"type\\\": \\\"textarea\\\",\\\"verify\\\":\\\"\\\",\\\"star\\\":\\\"1\\\" },{\\\"name\\\":\\\"cert\\\", \\\"desc\\\":\\\"API证书(apiclient_cert.p12)\\\", \\\"type\\\": \\\"file\\\",\\\"verify\\\":\\\"\\\"},{\\\"name\\\":\\\"apiClientCert\\\", \\\"desc\\\":\\\"证书文件(apiclient_cert.pem) \\\", \\\"type\\\": \\\"file\\\",\\\"verify\\\":\\\"\\\"},{\\\"name\\\":\\\"apiClientKey\\\", \\\"desc\\\":\\\"私钥文件(apiclient_key.pem)\\\", \\\"type\\\": \\\"file\\\",\\\"verify\\\":\\\"\\\"}]\",\"isIsvMode\":1,\"ifName\":\"微信支付官方\",\"wayCodeStrs\":\"WX_APP,WX_H5,WX_NATIVE,WX_JSAPI,WX_BAR,WX_LITE\",\"icon\":\"http://jeequan.oss-cn-beijing.aliyuncs.com/jeepay/img/wxpay.png\",\"remark\":\"微信官方通道\",\"configPageType\":2,\"isMchMode\":1,\"createdAt\":\"2023-05-29 10:39:10\",\"wayCodes\":[{\"wayCode\":\"WX_APP\"},{\"wayCode\":\"WX_H5\"},{\"wayCode\":\"WX_NATIVE\"},{\"wayCode\":\"WX_JSAPI\"},{\"wayCode\":\"WX_BAR\"},{\"wayCode\":\"WX_LITE\"}],\"isvsubMchParams\":\"[{\\\"name\\\":\\\"subMchId\\\",\\\"desc\\\":\\\"子商户ID\\\",\\\"type\\\":\\\"text\\\",\\\"verify\\\":\\\"required\\\"},{\\\"name\\\":\\\"subMchAppId\\\",\\\"desc\\\":\\\"子账户appID(线上支付必填)\\\",\\\"type\\\":\\\"text\\\",\\\"verify\\\":\\\"\\\"}]\",\"bgColor\":\"#04BE02\",\"isvParams\":\"[{\\\"name\\\":\\\"mchId\\\", \\\"desc\\\":\\\"微信支付商户号\\\", \\\"type\\\": \\\"text\\\",\\\"verify\\\":\\\"required\\\"},{\\\"name\\\":\\\"appId\\\",\\\"desc\\\":\\\"应用App ID\\\",\\\"type\\\":\\\"text\\\",\\\"verify\\\":\\\"required\\\"},{\\\"name\\\":\\\"appSecret\\\",\\\"desc\\\":\\\"应用AppSecret\\\",\\\"type\\\":\\\"text\\\",\\\"verify\\\":\\\"required\\\",\\\"star\\\":\\\"1\\\"},{\\\"name\\\":\\\"oauth2Url\\\", \\\"desc\\\":\\\"oauth2地址（置空将使用官方）\\\", \\\"type\\\": \\\"text\\\"},{\\\"name\\\":\\\"apiVersion\\\", \\\"desc\\\":\\\"微信支付API版本\\\", \\\"type\\\": \\\"radio\\\",\\\"values\\\":\\\"V2,V3\\\",\\\"titles\\\":\\\"V2,V3\\\",\\\"verify\\\":\\\"required\\\"},{\\\"name\\\":\\\"key\\\", \\\"desc\\\":\\\"APIv2密钥\\\", \\\"type\\\": \\\"textarea\\\",\\\"verify\\\":\\\"required\\\",\\\"star\\\":\\\"1\\\"},{\\\"name\\\":\\\"apiV3Key\\\", \\\"desc\\\":\\\"APIv3密钥（V3接口必填）\\\", \\\"type\\\": \\\"textarea\\\",\\\"verify\\\":\\\"\\\",\\\"star\\\":\\\"1\\\"},{\\\"name\\\":\\\"serialNo\\\", \\\"desc\\\":\\\"序列号（V3接口必填）\\\", \\\"type\\\": \\\"textarea\\\",\\\"verify\\\":\\\"\\\",\\\"star\\\":\\\"1\\\"},{\\\"name\\\":\\\"cert\\\", \\\"desc\\\":\\\"API证书(apiclient_cert.p12)\\\", \\\"type\\\": \\\"file\\\",\\\"verify\\\":\\\"\\\"},{\\\"name\\\":\\\"apiClientCert\\\", \\\"desc\\\":\\\"证书文件(apiclient_cert.pem) \\\", \\\"type\\\": \\\"file\\\",\\\"verify\\\":\\\"\\\"},{\\\"name\\\":\\\"apiClientKey\\\", \\\"desc\\\":\\\"私钥文件(apiclient_key.pem)\\\", \\\"type\\\": \\\"file\\\",\\\"verify\\\":\\\"\\\"}]\",\"state\":0,\"updatedAt\":\"2023-05-29 10:39:10\"}', '{\"msg\":\"SUCCESS\",\"code\":0}', '2023-05-31 10:33:41.125000');
INSERT INTO `t_sys_log` VALUES ('27', '801', '超管', '61.186.97.58', 'MGR', 'com.jeequan.jeepay.mgr.ctrl.payconfig.PayInterfaceDefineController.update', '更新支付接口', 'http://mgr.qianrui88.com/api/payIfDefines/ysfpay', '{\"ifCode\":\"ysfpay\",\"isIsvMode\":1,\"ifName\":\"云闪付官方\",\"wayCodeStrs\":\"YSF_BAR,ALI_JSAPI,WX_JSAPI,ALI_BAR,WX_BAR\",\"icon\":\"http://jeequan.oss-cn-beijing.aliyuncs.com/jeepay/img/ysfpay.png\",\"remark\":\"云闪付官方通道\",\"configPageType\":1,\"isMchMode\":0,\"createdAt\":\"2023-05-29 10:39:10\",\"wayCodes\":[{\"wayCode\":\"YSF_BAR\"},{\"wayCode\":\"ALI_JSAPI\"},{\"wayCode\":\"WX_JSAPI\"},{\"wayCode\":\"ALI_BAR\"},{\"wayCode\":\"WX_BAR\"}],\"isvsubMchParams\":\"[{\\\"name\\\":\\\"merId\\\",\\\"desc\\\":\\\"商户编号\\\",\\\"type\\\":\\\"text\\\",\\\"verify\\\":\\\"required\\\"}]\",\"bgColor\":\"red\",\"isvParams\":\"[{\\\"name\\\":\\\"sandbox\\\",\\\"desc\\\":\\\"环境配置\\\",\\\"type\\\":\\\"radio\\\",\\\"verify\\\":\\\"\\\",\\\"values\\\":\\\"1,0\\\",\\\"titles\\\":\\\"沙箱环境,生产环境\\\",\\\"verify\\\":\\\"required\\\"},{\\\"name\\\":\\\"serProvId\\\",\\\"desc\\\":\\\"服务商开发ID[serProvId]\\\",\\\"type\\\":\\\"text\\\",\\\"verify\\\":\\\"required\\\"},{\\\"name\\\":\\\"isvPrivateCertFile\\\",\\\"desc\\\":\\\"服务商私钥文件（.pfx格式）\\\",\\\"type\\\":\\\"file\\\",\\\"verify\\\":\\\"required\\\"},{\\\"name\\\":\\\"isvPrivateCertPwd\\\",\\\"desc\\\":\\\"服务商私钥文件密码\\\",\\\"type\\\":\\\"text\\\",\\\"verify\\\":\\\"required\\\",\\\"star\\\":\\\"1\\\"},{\\\"name\\\":\\\"ysfpayPublicKey\\\",\\\"desc\\\":\\\"云闪付开发公钥（证书管理页面可查询）\\\",\\\"type\\\":\\\"textarea\\\",\\\"verify\\\":\\\"required\\\",\\\"star\\\":\\\"1\\\"},{\\\"name\\\":\\\"acqOrgCode\\\",\\\"desc\\\":\\\"可用支付机构编号\\\",\\\"type\\\":\\\"text\\\",\\\"verify\\\":\\\"required\\\"}]\",\"state\":0,\"updatedAt\":\"2023-05-29 10:39:10\"}', '{\"msg\":\"SUCCESS\",\"code\":0}', '2023-05-31 10:33:46.214000');
INSERT INTO `t_sys_log` VALUES ('28', '801', '超管', '61.186.97.58', 'MGR', 'com.jeequan.jeepay.mgr.ctrl.payconfig.PayInterfaceDefineController.update', '更新支付接口', 'http://mgr.qianrui88.com/api/payIfDefines/plspay', '{\"ifCode\":\"plspay\",\"normalMchParams\":\"[{\\\"name\\\":\\\"signType\\\",\\\"desc\\\":\\\"签名方式\\\",\\\"type\\\":\\\"radio\\\",\\\"verify\\\":\\\"required\\\",\\\"values\\\":\\\"MD5,RSA2\\\",\\\"titles\\\":\\\"MD5,RSA2\\\"},{\\\"name\\\":\\\"merchantNo\\\",\\\"desc\\\":\\\"计全付商户号\\\",\\\"type\\\":\\\"text\\\",\\\"verify\\\":\\\"required\\\"},{\\\"name\\\":\\\"appId\\\",\\\"desc\\\":\\\"应用ID\\\",\\\"type\\\":\\\"text\\\",\\\"verify\\\":\\\"required\\\"},{\\\"name\\\":\\\"appSecret\\\",\\\"desc\\\":\\\"md5秘钥\\\",\\\"type\\\":\\\"textarea\\\",\\\"verify\\\":\\\"required\\\",\\\"star\\\":\\\"1\\\"},{\\\"name\\\":\\\"rsa2AppPrivateKey\\\",\\\"desc\\\":\\\"RSA2: 应用私钥\\\",\\\"type\\\":\\\"textarea\\\",\\\"verify\\\":\\\"required\\\",\\\"star\\\":\\\"1\\\"},{\\\"name\\\":\\\"rsa2PayPublicKey\\\",\\\"desc\\\":\\\"RSA2: 支付网关公钥\\\",\\\"type\\\":\\\"textarea\\\",\\\"verify\\\":\\\"required\\\",\\\"star\\\":\\\"1\\\"}]\",\"isIsvMode\":0,\"ifName\":\"计全付\",\"wayCodeStrs\":\"ALI_APP,ALI_BAR,ALI_JSAPI,ALI_LITE,ALI_PC,ALI_QR,ALI_WAP,WX_APP,WX_BAR,WX_H5,WX_JSAPI,WX_LITE,WX_NATIVE\",\"icon\":\"http://jeequan.oss-cn-beijing.aliyuncs.com/jeepay/img/plspay.svg\",\"remark\":\"计全付\",\"configPageType\":1,\"isMchMode\":1,\"createdAt\":\"2023-05-29 10:39:10\",\"wayCodes\":[{\"wayCode\":\"ALI_APP\"},{\"wayCode\":\"ALI_BAR\"},{\"wayCode\":\"ALI_JSAPI\"},{\"wayCode\":\"ALI_LITE\"},{\"wayCode\":\"ALI_PC\"},{\"wayCode\":\"ALI_QR\"},{\"wayCode\":\"ALI_WAP\"},{\"wayCode\":\"WX_APP\"},{\"wayCode\":\"WX_BAR\"},{\"wayCode\":\"WX_H5\"},{\"wayCode\":\"WX_JSAPI\"},{\"wayCode\":\"WX_LITE\"},{\"wayCode\":\"WX_NATIVE\"}],\"bgColor\":\"#0CACFF\",\"state\":0,\"updatedAt\":\"2023-05-29 10:39:10\"}', '{\"msg\":\"SUCCESS\",\"code\":0}', '2023-05-31 10:33:50.678000');
INSERT INTO `t_sys_log` VALUES ('29', '801', '超管', '222.244.148.160', 'MGR', 'com.jeequan.jeepay.mgr.ctrl.anon.AuthController.validate', '登录认证', 'http://mgr.qianrui88.com/api/anon/auth/validate', '{\"ip\":\"amVlcGF5MTIz\",\"ia\":\"amVlcGF5\",\"vc\":\"ZDNlag==\",\"vt\":\"YWFhOWFhNGYtYWZlMS00MjVkLWI3ODEtZTM1ZGJiYjQ5NDk0\"}', '{\"msg\":\"SUCCESS\",\"code\":0,\"data\":{\"iToken\":\"eyJhbGciOiJIUzUxMiJ9.eyJjYWNoZUtleSI6IlRPS0VOXzgwMV9mNDI0MWNmMC1iZTMzLTQzZDctYWQ3MC00ZjQ4ZWJlZjI5ODgiLCJjcmVhdGVkIjoxNjg1ODY4NzQ2MzUxLCJzeXNVc2VySWQiOjgwMX0.8fV6T5b5v5pvkDcfQ5ZCs314gXOBPqOufY6kNiShxERP-47THTR35T_xHarPAAbOVEnHln9_HqvUhpyyD2fB3Q\"}}', '2023-06-04 16:52:26.444000');
INSERT INTO `t_sys_log` VALUES ('30', null, null, '222.244.148.160', 'MCH', 'com.jeequan.jeepay.mch.ctrl.anon.AuthController.validate', '登录认证', 'http://mch.qianrui88.com/api/anon/auth/validate', '{\"ip\":\"amVlcGF5MTIz\",\"ia\":\"amVlcGF5\",\"vc\":\"YnBxaA==\",\"vt\":\"YzY4ZmI1ZWUtMzAzOC00NjljLWIwMDMtZmQ0ZWI2YWZiNDgx\"}', '用户名/密码错误！', '2023-06-04 16:52:50.973000');
INSERT INTO `t_sys_log` VALUES ('31', null, null, '222.244.148.160', 'MCH', 'com.jeequan.jeepay.mch.ctrl.anon.AuthController.validate', '登录认证', 'http://mch.qianrui88.com/api/anon/auth/validate', '{\"ip\":\"MTIzNDU2\",\"ia\":\"bGlzaTEyMzQ=\",\"vc\":\"ZDl2OA==\",\"vt\":\"M2UzMjExYjEtYWRlYS00ZWRmLTg5ZTEtNWQ1NTNlNTczNmZk\"}', '用户名/密码错误！', '2023-06-04 16:53:50.734000');
INSERT INTO `t_sys_log` VALUES ('32', null, null, '222.244.148.160', 'MCH', 'com.jeequan.jeepay.mch.ctrl.anon.AuthController.validate', '登录认证', 'http://mch.qianrui88.com/api/anon/auth/validate', '{\"ip\":\"MTIzNDU2\",\"ia\":\"bGlzaTEyMzQ=\",\"vc\":\"ZDl2OA==\",\"vt\":\"M2UzMjExYjEtYWRlYS00ZWRmLTg5ZTEtNWQ1NTNlNTczNmZk\"}', '用户名/密码错误！', '2023-06-04 16:54:16.827000');
INSERT INTO `t_sys_log` VALUES ('33', null, null, '222.244.148.160', 'MCH', 'com.jeequan.jeepay.mch.ctrl.anon.AuthController.validate', '登录认证', 'http://mch.qianrui88.com/api/anon/auth/validate', '{\"ip\":\"MTIzNDU2\",\"ia\":\"bGlzaTEyMzQ=\",\"vc\":\"ZDl2OA==\",\"vt\":\"M2UzMjExYjEtYWRlYS00ZWRmLTg5ZTEtNWQ1NTNlNTczNmZk\"}', '验证码有误！', '2023-06-04 16:56:34.532000');
INSERT INTO `t_sys_log` VALUES ('34', '100002', '李四', '222.244.148.160', 'MCH', 'com.jeequan.jeepay.mch.ctrl.anon.AuthController.validate', '登录认证', 'http://mch.qianrui88.com/api/anon/auth/validate', '{\"ip\":\"amVlcGF5NjY2\",\"ia\":\"bGlzaTEyMzQ=\",\"vc\":\"aXZrdA==\",\"vt\":\"NTg1N2NkZTQtMTc0ZC00NjJiLWJhYzAtYmFiMjUzNWMzNGZm\"}', '{\"msg\":\"SUCCESS\",\"code\":0,\"data\":{\"iToken\":\"eyJhbGciOiJIUzUxMiJ9.eyJjYWNoZUtleSI6IlRPS0VOXzEwMDAwMl9hMTIwNzIwNC1lM2M1LTRkMGMtOTNlOS00MDYzOTNjYjY2Y2QiLCJjcmVhdGVkIjoxNjg1ODY5MTA2MzU1LCJzeXNVc2VySWQiOjEwMDAwMn0.PL7C4nlYKK0cx9uzc1FoIlECeRNqyNF-M9qnPydUYp7W5ft1wK3IlXjvvrgZpyoByvjwH1GXYP_syqxj31DAnQ\"}}', '2023-06-04 16:58:26.446000');
INSERT INTO `t_sys_log` VALUES ('35', null, null, '222.244.148.160', 'MGR', 'com.jeequan.jeepay.mgr.ctrl.anon.AuthController.validate', '登录认证', 'http://mgr.qianrui88.com/api/anon/auth/validate', '{\"ip\":\"amVlcGF5NjY2\",\"ia\":\"bGlzaTEyMzQ=\",\"vc\":\"YWR5eA==\",\"vt\":\"NTgzZDRhNjYtMjJhZS00NDBhLThjOWQtMTBmZWFlN2JhYjNk\"}', '用户名/密码错误！', '2023-06-05 20:43:46.193000');
INSERT INTO `t_sys_log` VALUES ('36', null, null, '222.244.148.160', 'MGR', 'com.jeequan.jeepay.mgr.ctrl.anon.AuthController.validate', '登录认证', 'http://mgr.qianrui88.com/api/anon/auth/validate', '{\"ip\":\"amVlcGF5NjY2\",\"ia\":\"bGlzaTEyMzQ=\",\"vc\":\"YWR5eA==\",\"vt\":\"NTgzZDRhNjYtMjJhZS00NDBhLThjOWQtMTBmZWFlN2JhYjNk\"}', '用户名/密码错误！', '2023-06-05 20:43:57.599000');
INSERT INTO `t_sys_log` VALUES ('37', null, null, '222.244.148.160', 'MCH', 'com.jeequan.jeepay.mch.ctrl.anon.AuthController.validate', '登录认证', 'http://mch.qianrui88.com/api/anon/auth/validate', '{\"ip\":\"amVlcGF5NjY2\",\"ia\":\"bGlzaTEyMzQ=\",\"vc\":\"SWZoNA==\",\"vt\":\"NTMxNzZhZDctYmQxOC00MDc1LWIwOGYtMzJlOTVjNjY0YjUz\"}', '验证码有误！', '2023-06-05 20:45:54.324000');
INSERT INTO `t_sys_log` VALUES ('38', '100002', '李四', '222.244.148.160', 'MCH', 'com.jeequan.jeepay.mch.ctrl.anon.AuthController.validate', '登录认证', 'http://mch.qianrui88.com/api/anon/auth/validate', '{\"ip\":\"amVlcGF5NjY2\",\"ia\":\"bGlzaTEyMzQ=\",\"vc\":\"ZXd6bA==\",\"vt\":\"NmM3NzAzYWEtNDkzNi00MzViLWJmMTUtZGMxOGUyMjQwMjM4\"}', '{\"msg\":\"SUCCESS\",\"code\":0,\"data\":{\"iToken\":\"eyJhbGciOiJIUzUxMiJ9.eyJjYWNoZUtleSI6IlRPS0VOXzEwMDAwMl84N2JhYzEzNS0zNDE2LTRlOTQtOTVmYi1jZDE3MjNhMTliYjciLCJjcmVhdGVkIjoxNjg1OTY5MTYwMDMzLCJzeXNVc2VySWQiOjEwMDAwMn0.NEom71yr54VKEitvYiR4kCUSJ5mrQruJMkT2hB54qkZoqJby_s6l3IoK8ywuBF_5vKb_CZbLKzEnWqKKiM4k4g\"}}', '2023-06-05 20:46:00.034000');
INSERT INTO `t_sys_log` VALUES ('39', '100002', '李四', '222.244.148.160', 'MCH', 'com.jeequan.jeepay.mch.ctrl.merchant.MchPayInterfaceConfigController.saveOrUpdate', '更新商户支付参数', 'http://mch.qianrui88.com/api/mch/payConfigs', '{\"ifCode\":\"alipay\",\"infoId\":\"6475415de4b0859a5a9aa134\",\"ifParams\":\"{\\\"alipayPublicCert\\\":\\\"\\\",\\\"privateKey\\\":\\\"MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCMfr8Tzc+g5jRD79qf3pjDEySpZ0u2hFlxPilGFAkCR9wa7xrz3JdNKo9HP2F2olnYLn9P4rVnkqy+UzuYujy6Ke0Iu8kFUchxLNX4Q0v7EAQhDswI1oFruBxylRAKkqi1xnRrxUXqM3JEx5kxsAzSaCyyu9Oa8r6YSUqpn8IaxVyTHkhq/ElzkA5vbcRYZaA5CYTqUvq9dsTjKQGcMyr3JEDv87AikrljNpSgApS+53v9+xtw0oOKV830Kae+A748SUKO/Sjvqhv7t+pI+6Ndqntsz9IRemZvVy4GyyphktUaru+5E4upcMk3f5j5Sn/0S6A5RCn2lA4YAEwWFbaVAgMBAAECggEAW1QBDfSZ5bP/gbInYgknMJf/GwgE1a6PHegUmHNpr8varr+Du8ZHrGfgH6Z5ys6arMb9B4cN+TgFhutAMHXQCAw9A5JeiFCzha5poSrN93Rf2sVtqMkX9FgIVgvEE7tmZFOPVoc0fZvXyhId6YjRrOz/MWibk3v8na33FPC/Evr/4GLUiBJmQQQoFtGRg6M8VEvTb5cUv5ABnGd++jH8cZsfmCLp0OLFsleGALJcAFFgWqYZ+h5YGDZCHZs1AOTFeXT5Z0ni1E6/2VPH2AxoZPpzRC3222kG5/tnfkMlN7yN107rkGLgZ8kcT2BZlEErNvdaPTDIwOS8QgrEZDtLwQKBgQDtwWdmMPVJUDzAb/OcVJ2L7J5e6Mkb0ztnhk13chjGxNiOWhmQFBC/WgV+sC6H7Cbuh1C161wMwaWnX3VqzxFEFEO9lTKCaZPFBDHDB1l/yR9HQqjyhuN9jb1EIexG3GlXFZfeVslFxvqdIpsru68B1FrMXesFK4+0TPX1p8pn7QKBgQCXRrUci69+c/QBb6IaVK8FgcQ3kXEKAifXDoQlnzb9q+kd8tJo6YxVOTJ6TLPx+4WNF0ARUgXaH4mTQy0ym/BPym7ampySaogzCC76at3IYLEuCylXvUJMr7xcauft+ICUK5eGflyuHVd9NrIQjXOxCHpPBzuLDta/KX9VFCvkSQKBgBkQg5MNZD53XAA5jSgU74r5xfRhfBoX2bJfQTlvaNdDl0TikMFUrDNQDTY+4pjnt278CvEyv8CEha8wbBN3gu13aXDKEsoW0UI63/gchT3oeQitKVxwBfmNgL93CA6sW9qXZyxEX/GgOXlpVYx1u8xok63p1MX1wq+SUXe1Waw9AoGAfaqFRWNcs+VLK+46cTkr850rDSZLCw9jXSl36XDr06r9ip1u4SwyIZHUNviE+14AQYaw+DJ1Hg/Yz3ack1ArP31gvUR3EMJixlHkBK7F8nEwfplTDMnxy5apGPTOGke3OF9GDrnl79X8Gc5X+ZwoIUZzpDbT5d670i1804ZgN9ECgYA7Uc79EHAHOBkGSYZsqP3zdooJKz/o8WGrDFjNeoI6oescrO7y0Whj81o5FPUrIkzzF/0mvJBBRfGF4b2lc2721SHXjX8xWD02mLJMAroRYdN4prTPKc35swhcubSyPRqApGmqKfYl7Vk++U4EpkUtdOelvm/nPIVlgYFJpB457Q==\\\",\\\"alipayPublicKey\\\":\\\"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA0masrzmVP733OM4id1E1K9cozg7WnsgaUwltu/NVh75RwWlafLfyG5urJiEPmpkCnGTYdZ/15OG/oh1impGgzlKMALjISav9VwwQB/YI6qgbzMaiUISu9VdQO0lonaqLn/8AdRu0xS0CLJoghcZdjeBohWdULP7Et5qqErZo4N8cY8PILSJyEG2nMbtYGKGtCqH1hYNd6T6abSNZ18s8SJCCzeJ3HoEjTnNiSEkhzHdRqGVtZaBOgJ6ith7MmtIxT9roUzTacuPY9TYcoJ2r5aIdlINnT8RKYhaTLVIBnQUhaCnwoMD7fxJvxqbNCY3GzxmdQHVsjdHXTt1uGKNH8wIDAQAB\\\",\\\"appPublicCert\\\":\\\"\\\",\\\"appId\\\":\\\"2021003127666952 \\\",\\\"alipayRootCert\\\":\\\"\\\",\\\"sandbox\\\":0,\\\"signType\\\":\\\"RSA2\\\",\\\"useCert\\\":0}\",\"state\":1}', '{\"msg\":\"SUCCESS\",\"code\":0}', '2023-06-05 20:47:55.612000');
INSERT INTO `t_sys_log` VALUES ('40', '100002', '李四', '61.186.97.58', 'MCH', 'com.jeequan.jeepay.mch.ctrl.anon.AuthController.validate', '登录认证', 'http://mch.qianrui88.com/api/anon/auth/validate', '{\"ip\":\"amVlcGF5NjY2\",\"ia\":\"bGlzaTEyMzQ=\",\"vc\":\"czdsbw==\",\"vt\":\"YTVhOGQ2MjEtNDEwZi00MDQ3LTk0YjQtMWFhMjllZDBjYWQz\"}', '{\"msg\":\"SUCCESS\",\"code\":0,\"data\":{\"iToken\":\"eyJhbGciOiJIUzUxMiJ9.eyJjYWNoZUtleSI6IlRPS0VOXzEwMDAwMl82NGYzZjJlZS03ZjExLTRmMjEtYjI4ZS01ZTdmYThjYzVhMWUiLCJjcmVhdGVkIjoxNjg2MDEzMTU4MTg0LCJzeXNVc2VySWQiOjEwMDAwMn0.7zGlJEo6Mbie0fSvWJeslTyonJCyB1cJjVE-1e5e2MS6tYWKjdN55ulni0DTLmdOuRJXCgQ8gOn9wQMBGjICzw\"}}', '2023-06-06 08:59:18.186000');
INSERT INTO `t_sys_log` VALUES ('41', '100002', '李四', '0:0:0:0:0:0:0:1', 'MCH', 'com.jeequan.jeepay.mch.ctrl.anon.AuthController.validate', '登录认证', 'http://localhost:9218/api/anon/auth/validate', '{\"ip\":\"amVlcGF5NjY2\",\"ia\":\"bGlzaTEyMzQ=\",\"vc\":\"cXlteQ==\",\"vt\":\"NGJiOTlhYzktZWI3My00NTJhLWEzMmYtNDFlZjMzZjBhZTZm\"}', '请求异常', '2023-06-06 10:09:20.037000');
INSERT INTO `t_sys_log` VALUES ('42', '100002', '李四', '0:0:0:0:0:0:0:1', 'MCH', 'com.jeequan.jeepay.mch.ctrl.anon.AuthController.validate', '登录认证', 'http://localhost:9218/api/anon/auth/validate', '{\"ip\":\"amVlcGF5NjY2\",\"ia\":\"bGlzaTEyMzQ=\",\"vc\":\"Ynp0ZA==\",\"vt\":\"MDNjMzNlZjUtZDJlZC00YzRhLTg2YWQtNTFmNzcxMjc3NzY1\"}', '请求异常', '2023-06-06 10:11:43.575000');
INSERT INTO `t_sys_log` VALUES ('43', '100002', '李四', '0:0:0:0:0:0:0:1', 'MCH', 'com.jeequan.jeepay.mch.ctrl.anon.AuthController.validate', '登录认证', 'http://localhost:9218/api/anon/auth/validate', '{\"ip\":\"amVlcGF5NjY2\",\"ia\":\"bGlzaTEyMzQ=\",\"vc\":\"ZGhoNw==\",\"vt\":\"YmU0YjZjZTAtNjY5Zi00MmVkLWExZGItZDdmODkwZTBhMzM5\"}', '请求异常', '2023-06-06 10:16:22.411000');
INSERT INTO `t_sys_log` VALUES ('44', '100002', '李四', '0:0:0:0:0:0:0:1', 'MCH', 'com.jeequan.jeepay.mch.ctrl.anon.AuthController.validate', '登录认证', 'http://localhost:9218/api/anon/auth/validate', '{\"ip\":\"amVlcGF5NjY2\",\"ia\":\"bGlzaTEyMzQ=\",\"vc\":\"MmFzMw==\",\"vt\":\"OGNiMjA5MTUtNzY4Zi00NjY1LTk1NGYtNGZmOTNiMzExYjA5\"}', '请求异常', '2023-06-06 10:17:34.290000');
INSERT INTO `t_sys_log` VALUES ('45', '100002', '李四', '0:0:0:0:0:0:0:1', 'MCH', 'com.jeequan.jeepay.mch.ctrl.anon.AuthController.validate', '登录认证', 'http://localhost:9218/api/anon/auth/validate', '{\"ip\":\"amVlcGF5NjY2\",\"ia\":\"bGlzaTEyMzQ=\",\"vc\":\"MjQzdQ==\",\"vt\":\"ZTM0MjAzNmUtODVkOC00YjJhLTk2YjYtNTE3OGFkODg5NWQ5\"}', '请求异常', '2023-06-06 10:23:20.485000');
INSERT INTO `t_sys_log` VALUES ('46', '100002', '李四', '0:0:0:0:0:0:0:1', 'MCH', 'com.jeequan.jeepay.mch.ctrl.anon.AuthController.validate', '登录认证', 'http://localhost:9218/api/anon/auth/validate', '{\"ip\":\"amVlcGF5NjY2\",\"ia\":\"bGlzaTEyMzQ=\",\"vc\":\"dXptZA==\",\"vt\":\"NDQ0ODQxYWMtZDIzYy00MDg3LWFlOGItODc3MjU4NGYyNzRj\"}', '{\"msg\":\"SUCCESS\",\"code\":0,\"data\":{\"iToken\":\"eyJhbGciOiJIUzUxMiJ9.eyJjYWNoZUtleSI6IlRPS0VOXzEwMDAwMl85NmY2ODIzZS1hMmZhLTQ4ZjYtOTJlNC1iNWU5NGQ2YWY1YTUiLCJjcmVhdGVkIjoxNjg2MDE4NDAyMTg1LCJzeXNVc2VySWQiOjEwMDAwMn0.fUunDJJ2BsgjCzkswo2kcMDa4saL_Gd-BBbs0J7hwXqJ8bDU4ODg4yDb6S-2Qc2bNmRz1RtaTd6QWCVwMg7yTA\"}}', '2023-06-06 10:26:42.332000');
INSERT INTO `t_sys_log` VALUES ('47', '100002', '李四', '0:0:0:0:0:0:0:1', 'MCH', 'com.jeequan.jeepay.mch.ctrl.anon.AuthController.validate', '登录认证', 'http://localhost:9218/api/anon/auth/validate', '{\"ip\":\"amVlcGF5NjY2\",\"ia\":\"bGlzaTEyMzQ=\",\"vc\":\"Z2ZoaQ==\",\"vt\":\"Y2VmYWZjZGUtNDliNS00YmU0LThkNjEtYmM2ZTQxNjk4MDhk\"}', '{\"msg\":\"SUCCESS\",\"code\":0,\"data\":{\"iToken\":\"eyJhbGciOiJIUzUxMiJ9.eyJjYWNoZUtleSI6IlRPS0VOXzEwMDAwMl82OTU4YzNiOC0yYjkyLTRmNmMtODQzMS1hM2M1Mzc0NDFjZmUiLCJjcmVhdGVkIjoxNjg2MDE4NTUwNDQ0LCJzeXNVc2VySWQiOjEwMDAwMn0.IgSHXKhIYWwwUOQVr3NmWHJkPlWE-lScvv8DV5P7GyQGLXTG_7cp35gVaTBg6jIIK2aEDBgN1S_nrRnTl1JY_w\"}}', '2023-06-06 10:29:10.466000');
INSERT INTO `t_sys_log` VALUES ('48', '801', '超管', '61.186.97.58', 'MGR', 'com.jeequan.jeepay.mgr.ctrl.anon.AuthController.validate', '登录认证', 'http://mgr.qianrui88.com/api/anon/auth/validate', '{\"ip\":\"amVlcGF5MTIz\",\"ia\":\"amVlcGF5\",\"vc\":\"eHdpcA==\",\"vt\":\"YjA4Y2E2NDgtZDc1My00NjVkLTk0ZDktZGU4YTAyOGVmNzQz\"}', '{\"msg\":\"SUCCESS\",\"code\":0,\"data\":{\"iToken\":\"eyJhbGciOiJIUzUxMiJ9.eyJjYWNoZUtleSI6IlRPS0VOXzgwMV9lYTVhMWFkOC1lODQwLTQ0ZTQtOWRjZS0wMDIwODE3MDgyM2EiLCJjcmVhdGVkIjoxNjg2MDIxNDMxNDU1LCJzeXNVc2VySWQiOjgwMX0.OYDLFqlU9vwNphc6oh6i0j17oHi-naWxGm4MBKVs_C9cg9g79f0UXAZZ4bGKnaRzbsgTptffuoGJrsemsj-KkQ\"}}', '2023-06-06 11:17:11.485000');
INSERT INTO `t_sys_log` VALUES ('49', '801', '超管', '61.186.97.58', 'MGR', 'com.jeequan.jeepay.mgr.ctrl.order.PayOrderController.refund', '发起订单退款', 'http://mgr.qianrui88.com/api/payOrder/refunds/P1665702042877112321', '{\"refundReason\":\"测试\",\"refundAmount\":0.01}', '{\"msg\":\"SUCCESS\",\"code\":0,\"data\":{\"refundOrderId\":\"R1665920903010394113\",\"payAmount\":1,\"mchRefundNo\":\"M1665920902465134593\",\"state\":2,\"refundAmount\":1}}', '2023-06-06 11:17:50.485000');
INSERT INTO `t_sys_log` VALUES ('50', '100002', '李四', '61.186.97.58', 'MCH', 'com.jeequan.jeepay.mch.ctrl.anon.AuthController.validate', '登录认证', 'http://mch.qianrui88.com/api/anon/auth/validate', '{\"ip\":\"amVlcGF5NjY2\",\"ia\":\"bGlzaTEyMzQ=\",\"vc\":\"MnNkcA==\",\"vt\":\"YTBkYzFlZGQtYzNlOS00OTAxLWJmN2UtYjZjNjk0NThkMjNk\"}', '{\"msg\":\"SUCCESS\",\"code\":0,\"data\":{\"iToken\":\"eyJhbGciOiJIUzUxMiJ9.eyJjYWNoZUtleSI6IlRPS0VOXzEwMDAwMl82Y2UwYTRmNC0yMzhhLTQyZmItYjY5MC1kOTQ4YTcyOTkzN2EiLCJjcmVhdGVkIjoxNjg2MDIxNTM5NTU0LCJzeXNVc2VySWQiOjEwMDAwMn0.1mR_CMzx8Rbkvbf9XB7f6OejkFayorJBxCzDS8nybsao6LwHi7CulVwUgELeC0g0Hi1nziz-AC-K0LKCklNiAQ\"}}', '2023-06-06 11:18:59.578000');
INSERT INTO `t_sys_log` VALUES ('51', '100002', '李四', '0:0:0:0:0:0:0:1', 'MCH', 'com.jeequan.jeepay.mch.ctrl.anon.AuthController.validate', '登录认证', 'http://localhost:9218/api/anon/auth/validate', '{\"ip\":\"amVlcGF5NjY2\",\"ia\":\"bGlzaTEyMzQ=\",\"vc\":\"MlBPNA==\",\"vt\":\"ZDYzYWMyM2QtOWExYi00NWY2LTkzNTAtMWJiOGI2ZDg2YTQ2\"}', '{\"msg\":\"SUCCESS\",\"code\":0,\"data\":{\"iToken\":\"eyJhbGciOiJIUzUxMiJ9.eyJjYWNoZUtleSI6IlRPS0VOXzEwMDAwMl8zYzY1ZWU2OC0yZDU3LTQxMDEtOTUyMy1mMzJkZjQ0YWY1NzYiLCJjcmVhdGVkIjoxNjg2MDM2NDgyOTc3LCJzeXNVc2VySWQiOjEwMDAwMn0.iQm2afztueWUqj6TnKYd0nhwgFxEYk3jeCMXNcn0ExLkx09OFu3S-nNsSKgbqjnuIMb3lQFDecxdqmLCebmRjg\"}}', '2023-06-06 15:28:02.997000');
INSERT INTO `t_sys_log` VALUES ('52', '100002', '李四', '0:0:0:0:0:0:0:1', 'MCH', 'com.jeequan.jeepay.mch.ctrl.anon.AuthController.validate', '登录认证', 'http://localhost:9218/api/anon/auth/validate', '{\"ip\":\"amVlcGF5NjY2\",\"ia\":\"bGlzaTEyMzQ=\",\"vc\":\"eHBteA==\",\"vt\":\"ZWY5YjNjZGMtZTE0Mi00ZTlmLWI5MDMtMDJmNmEzOTQ3ZjE4\"}', '{\"msg\":\"SUCCESS\",\"code\":0,\"data\":{\"iToken\":\"eyJhbGciOiJIUzUxMiJ9.eyJjYWNoZUtleSI6IlRPS0VOXzEwMDAwMl9hNzMxYmRmZC1hMTMyLTQzZWYtYmYwMC1kOGVjOGQ0MWQ2NDUiLCJjcmVhdGVkIjoxNjg2MTIxOTU4OTgxLCJzeXNVc2VySWQiOjEwMDAwMn0.ihMF0dPuGiMoKa2PzPAhA-Wg52qPZnLIMtDR_-Nf5p0tXOVKLdwbplQHMKSjcYVNTF6Zq0z_riOb4F_8_nlY8A\"}}', '2023-06-07 15:12:39.019000');
INSERT INTO `t_sys_log` VALUES ('53', null, null, '175.2.27.231', 'MCH', 'com.jeequan.jeepay.mch.ctrl.anon.AuthController.validate', '登录认证', 'http://mch.qianrui88.com/api/anon/auth/validate', '{\"ip\":\"amVlcGF5NjY2\",\"ia\":\"bGlzaTEyMw==\",\"vc\":\"a2h2Yg==\",\"vt\":\"MDVkZGZiZmItMGRiMC00OTEzLTk3NmUtZWE5MGZmZThmNTlj\"}', '用户名/密码错误！', '2023-06-08 18:34:34.406000');
INSERT INTO `t_sys_log` VALUES ('54', null, null, '175.2.27.231', 'MCH', 'com.jeequan.jeepay.mch.ctrl.anon.AuthController.validate', '登录认证', 'http://mch.qianrui88.com/api/anon/auth/validate', '{\"ip\":\"amVlcGF5NjY2\",\"ia\":\"bGlzaTEyMw==\",\"vc\":\"a2h2Yg==\",\"vt\":\"MDVkZGZiZmItMGRiMC00OTEzLTk3NmUtZWE5MGZmZThmNTlj\"}', '用户名/密码错误！', '2023-06-08 18:34:35.293000');
INSERT INTO `t_sys_log` VALUES ('55', '801', '超管', '222.240.151.178', 'MGR', 'com.jeequan.jeepay.mgr.ctrl.anon.AuthController.validate', '登录认证', 'http://mgr.qianrui88.com/api/anon/auth/validate', '{\"ip\":\"amVlcGF5MTIz\",\"ia\":\"amVlcGF5\",\"vc\":\"ZG45dg==\",\"vt\":\"ODgyYTFmODctMzZiOC00ZmM5LWE2YmItNWJiYmY1MTZhM2I3\"}', '{\"msg\":\"SUCCESS\",\"code\":0,\"data\":{\"iToken\":\"eyJhbGciOiJIUzUxMiJ9.eyJjYWNoZUtleSI6IlRPS0VOXzgwMV9mMDJlMzc3ZS04NjQyLTQ3MTctOTNkMi1kZDE1Y2NhYjgzYzgiLCJjcmVhdGVkIjoxNjg2MjI1MzQ4MjYzLCJzeXNVc2VySWQiOjgwMX0.FF-ghfsvpMP-nR8Olaz8dH-kxyyHAcVPypsiVyH1HiWd6JolcFZhKhNf9675ch6zZclMY2qKwW2RJFix6sDgYQ\"}}', '2023-06-08 19:55:48.335000');
INSERT INTO `t_sys_log` VALUES ('56', null, null, '222.240.151.178', 'MCH', 'com.jeequan.jeepay.mch.ctrl.anon.AuthController.validate', '登录认证', 'http://mch.qianrui88.com/api/anon/auth/validate', '{\"ip\":\"cGF5NjY2\",\"ia\":\"bGlzaTEyMzQ=\",\"vc\":\"cmdscWxw\",\"vt\":\"YzQ4NzRlMGEtNTMzMy00NDlhLWI5NGUtNDYwYjViMWY2YjQw\"}', '验证码有误！', '2023-06-08 19:56:29.785000');
INSERT INTO `t_sys_log` VALUES ('57', null, null, '222.240.151.178', 'MCH', 'com.jeequan.jeepay.mch.ctrl.anon.AuthController.validate', '登录认证', 'http://mch.qianrui88.com/api/anon/auth/validate', '{\"ip\":\"cGF5NjY2\",\"ia\":\"bGlzaTEyMzQ=\",\"vc\":\"ZHJsNg==\",\"vt\":\"YWY2YmI3NDUtYWQ3ZS00OGFiLWE3YjAtYmYwYjFlMWYxNTE5\"}', '用户名/密码错误！', '2023-06-08 19:56:34.591000');
INSERT INTO `t_sys_log` VALUES ('58', null, null, '222.240.151.178', 'MCH', 'com.jeequan.jeepay.mch.ctrl.anon.AuthController.validate', '登录认证', 'http://mch.qianrui88.com/api/anon/auth/validate', '{\"ip\":\"cGF5NjY2\",\"ia\":\"bGlzaTEyMzQ=\",\"vc\":\"ZHJJNg==\",\"vt\":\"YWY2YmI3NDUtYWQ3ZS00OGFiLWE3YjAtYmYwYjFlMWYxNTE5\"}', '验证码有误！', '2023-06-08 19:56:39.497000');
INSERT INTO `t_sys_log` VALUES ('59', '100002', '李四', '222.240.151.178', 'MCH', 'com.jeequan.jeepay.mch.ctrl.anon.AuthController.validate', '登录认证', 'http://mch.qianrui88.com/api/anon/auth/validate', '{\"ip\":\"amVlcGF5NjY2\",\"ia\":\"bGlzaTEyMzQ=\",\"vc\":\"eTJ1Nw==\",\"vt\":\"YjBkMzFjZWYtOGRkMi00NDIxLWE1NjMtOGNlOTgyMmEzNGVm\"}', '{\"msg\":\"SUCCESS\",\"code\":0,\"data\":{\"iToken\":\"eyJhbGciOiJIUzUxMiJ9.eyJjYWNoZUtleSI6IlRPS0VOXzEwMDAwMl8yNzIwYTMxZi0wZjIyLTRmMDYtYThjNC1hOGE3M2ViYzFiMjkiLCJjcmVhdGVkIjoxNjg2MjI1NDEwMjA5LCJzeXNVc2VySWQiOjEwMDAwMn0.Sy1-SYKRdCfaJI9BLCoCszvf6gm_lbl0vic4Sr_goDmjsiJho5Hwb2-xkgPsX1C_QhEfgdpAGHY6fl_bj9scxg\"}}', '2023-06-08 19:56:50.284000');
INSERT INTO `t_sys_log` VALUES ('60', '100002', '李四', '61.186.97.58', 'MCH', 'com.jeequan.jeepay.mch.ctrl.anon.AuthController.validate', '登录认证', 'http://mch.qianrui88.com/api/anon/auth/validate', '{\"ip\":\"amVlcGF5NjY2\",\"ia\":\"bGlzaTEyMzQ=\",\"vc\":\"aHV3ag==\",\"vt\":\"NjM4OWMzZjUtNDJmNy00MmI2LWEyMmMtMzk4M2ZiOTNlMWQz\"}', '{\"msg\":\"SUCCESS\",\"code\":0,\"data\":{\"iToken\":\"eyJhbGciOiJIUzUxMiJ9.eyJjYWNoZUtleSI6IlRPS0VOXzEwMDAwMl82NTI2NjBlZS0zZmVkLTRjNmMtODg0My0xZTFhOTRjMGMyYzUiLCJjcmVhdGVkIjoxNjg2MjI1NjAxNDcyLCJzeXNVc2VySWQiOjEwMDAwMn0.6-621NOCm2OqVRsCzrmKXKEUKDPO2Of1mkQQ2ZOogjNHu8v4_WUzxxb4_FLMRX1FTvnoXtyKlnvBeZSTMV2-mQ\"}}', '2023-06-08 20:00:01.486000');
INSERT INTO `t_sys_log` VALUES ('61', '801', '超管', '61.186.97.58', 'MGR', 'com.jeequan.jeepay.mgr.ctrl.anon.AuthController.validate', '登录认证', 'http://mgr.qianrui88.com/api/anon/auth/validate', '{\"ip\":\"amVlcGF5MTIz\",\"ia\":\"amVlcGF5\",\"vc\":\"MGE5Mw==\",\"vt\":\"OGQzMDhkMDAtODFmMC00NjliLWEyMWYtMGEzN2IxODk3YTA0\"}', '{\"msg\":\"SUCCESS\",\"code\":0,\"data\":{\"iToken\":\"eyJhbGciOiJIUzUxMiJ9.eyJjYWNoZUtleSI6IlRPS0VOXzgwMV84NDkwZjFlNS1jNjVkLTQ2NDAtYjY2NS1iODNjYTBmYTI4NTgiLCJjcmVhdGVkIjoxNjg2MjI1NzI4OTI3LCJzeXNVc2VySWQiOjgwMX0.J2Xpav2lhKUTZbXxMPnRLBRCbCsvxJRyRtzcPdym7VZDoNb1SkgJoQb1NkLOc8O_AsuZu4_f85gdPatUp7NCdQ\"}}', '2023-06-08 20:02:08.936000');
INSERT INTO `t_sys_log` VALUES ('62', '801', '超管', '61.186.97.58', 'MGR', 'com.jeequan.jeepay.mgr.ctrl.isv.IsvPayInterfaceConfigController.saveOrUpdate', '更新服务商支付参数', 'http://mgr.qianrui88.com/api/isv/payConfigs', '{\"ifCode\":\"alipay\",\"infoId\":\"V1685405970\",\"ifParams\":\"{\\\"appId\\\":\\\"2021003145631330\\\",\\\"sandbox\\\":0,\\\"signType\\\":\\\"RSA2\\\",\\\"pid\\\":\\\"PID2088441939131900\\\",\\\"useCert\\\":0}\",\"state\":1,\"ifRate\":0.1}', '{\"msg\":\"SUCCESS\",\"code\":0}', '2023-06-08 20:07:10.508000');
INSERT INTO `t_sys_log` VALUES ('63', '801', '超管', '61.186.97.58', 'MGR', 'com.jeequan.jeepay.mgr.ctrl.isv.IsvPayInterfaceConfigController.saveOrUpdate', '更新服务商支付参数', 'http://mgr.qianrui88.com/api/isv/payConfigs', '{\"ifCode\":\"alipay\",\"infoId\":\"V1685405970\",\"ifParams\":\"{\\\"appId\\\":\\\"2021003145631330\\\",\\\"sandbox\\\":0,\\\"signType\\\":\\\"RSA2\\\",\\\"pid\\\":\\\"PID2088441939131900\\\",\\\"useCert\\\":0}\",\"state\":1,\"ifRate\":0.1}', '{\"msg\":\"SUCCESS\",\"code\":0}', '2023-06-08 20:07:18.013000');
INSERT INTO `t_sys_log` VALUES ('64', '801', '超管', '61.186.97.58', 'MGR', 'com.jeequan.jeepay.mgr.ctrl.isv.IsvPayInterfaceConfigController.saveOrUpdate', '更新服务商支付参数', 'http://mgr.qianrui88.com/api/isv/payConfigs', '{\"ifCode\":\"alipay\",\"infoId\":\"V1685405970\",\"ifParams\":\"{\\\"appId\\\":\\\"2021003145631330\\\",\\\"sandbox\\\":0,\\\"signType\\\":\\\"RSA2\\\",\\\"pid\\\":\\\"PID2088441939131900\\\",\\\"useCert\\\":0}\",\"state\":1,\"ifRate\":0.1}', '{\"msg\":\"SUCCESS\",\"code\":0}', '2023-06-08 20:07:32.615000');
INSERT INTO `t_sys_log` VALUES ('65', '801', '超管', '61.186.97.58', 'MGR', 'com.jeequan.jeepay.mgr.ctrl.merchant.MchInfoController.add', '新增商户', 'http://mgr.qianrui88.com/api/mchInfo', '{\"isvNo\":\"V1685405970\",\"loginUserName\":\"wangwu1234\",\"contactName\":\"超超\",\"mchName\":\"王五\",\"state\":1,\"type\":2,\"mchShortName\":\"王五\",\"contactTel\":\"19119290099\"}', '手机号已存在！', '2023-06-08 20:11:23.647000');
INSERT INTO `t_sys_log` VALUES ('66', '801', '超管', '61.186.97.58', 'MGR', 'com.jeequan.jeepay.mgr.ctrl.merchant.MchInfoController.add', '新增商户', 'http://mgr.qianrui88.com/api/mchInfo', '{\"isvNo\":\"V1685405970\",\"loginUserName\":\"wangwu1234\",\"contactName\":\"超超\",\"mchName\":\"王五\",\"state\":1,\"type\":2,\"mchShortName\":\"王五\",\"contactTel\":\"18670055200\"}', '{\"msg\":\"SUCCESS\",\"code\":0}', '2023-06-08 20:11:32.568000');
INSERT INTO `t_sys_log` VALUES ('67', null, null, '61.186.97.58', 'MGR', 'com.jeequan.jeepay.mgr.ctrl.anon.AuthController.validate', '登录认证', 'http://mgr.qianrui88.com/api/anon/auth/validate', '{\"ip\":\"amVlcGF5NjY2\",\"ia\":\"amVlcGF5\",\"vc\":\"aW1qbA==\",\"vt\":\"NThkODgzOTgtMDYwNS00ZmEwLWI0MjgtZmM5MGQxNTMwNzZl\"}', '用户名/密码错误！', '2023-06-08 20:20:27.161000');
INSERT INTO `t_sys_log` VALUES ('68', '801', '超管', '61.186.97.58', 'MGR', 'com.jeequan.jeepay.mgr.ctrl.anon.AuthController.validate', '登录认证', 'http://mgr.qianrui88.com/api/anon/auth/validate', '{\"ip\":\"amVlcGF5MTIz\",\"ia\":\"amVlcGF5\",\"vc\":\"aW1qbA==\",\"vt\":\"NThkODgzOTgtMDYwNS00ZmEwLWI0MjgtZmM5MGQxNTMwNzZl\"}', '{\"msg\":\"SUCCESS\",\"code\":0,\"data\":{\"iToken\":\"eyJhbGciOiJIUzUxMiJ9.eyJjYWNoZUtleSI6IlRPS0VOXzgwMV8zMmIwN2RmMS05YzA4LTQ4NjUtYTM1My0yZDYxMmEwM2IyNzkiLCJjcmVhdGVkIjoxNjg2MjI2ODUwMjczLCJzeXNVc2VySWQiOjgwMX0.-VHRthqXQ50QvQmGWZPfREBE5XkBwK6uPVn0crf_tKkWv0W39oI6guZtITQD34KmIshuN2pC48nelLaU_ysx_w\"}}', '2023-06-08 20:20:50.303000');
INSERT INTO `t_sys_log` VALUES ('69', '100003', '超超', '61.186.97.58', 'MCH', 'com.jeequan.jeepay.mch.ctrl.anon.AuthController.validate', '登录认证', 'http://mch.qianrui88.com/api/anon/auth/validate', '{\"ip\":\"amVlcGF5NjY2\",\"ia\":\"d2FuZ3d1MTIzNA==\",\"vc\":\"ZG1xZA==\",\"vt\":\"ZGNiNjNiMTYtZDE3NC00YzY3LThjZTktMDJmNDkyOWFmN2Qy\"}', '{\"msg\":\"SUCCESS\",\"code\":0,\"data\":{\"iToken\":\"eyJhbGciOiJIUzUxMiJ9.eyJjYWNoZUtleSI6IlRPS0VOXzEwMDAwM19iMTcwNGI3OS05NmYwLTQ1M2ItOGU4OC1jMjVmMWRiN2EyYWIiLCJjcmVhdGVkIjoxNjg2MjI2OTM2NzA4LCJzeXNVc2VySWQiOjEwMDAwM30.yoClqkocsU6VaeAP-qYZYlSyLNi9NAJvy3fvgHhDjlLkm0tgfZefeZ-q9dsD9OTyGOd-iHZN-04OmsoLLgcRVw\"}}', '2023-06-08 20:22:16.719000');
INSERT INTO `t_sys_log` VALUES ('70', '100002', '李四', '61.186.97.58', 'MCH', 'com.jeequan.jeepay.mch.ctrl.anon.AuthController.validate', '登录认证', 'http://mch.qianrui88.com/api/anon/auth/validate', '{\"ip\":\"amVlcGF5NjY2\",\"ia\":\"bGlzaTEyMzQ=\",\"vc\":\"bnRqaQ==\",\"vt\":\"ODIxYzcxNzAtNzM2MC00NjcwLThlYTMtZGNlYWVjZjA0Nzgw\"}', '{\"msg\":\"SUCCESS\",\"code\":0,\"data\":{\"iToken\":\"eyJhbGciOiJIUzUxMiJ9.eyJjYWNoZUtleSI6IlRPS0VOXzEwMDAwMl80OGZkNzJmYi00MDVhLTQyM2ItOWQ1ZS0yZWVlNGQ5ZjIyNDAiLCJjcmVhdGVkIjoxNjg2MjI2OTY5Njk4LCJzeXNVc2VySWQiOjEwMDAwMn0.mRBbvpiXCb3QovTLeiSe1DYLMSPJgb_xmZ5mESGkBA7g2j4_-aEGDmkzLM7Yb2EqbiI0gs94agZMXgpNX2t2wg\"}}', '2023-06-08 20:22:49.710000');
INSERT INTO `t_sys_log` VALUES ('71', '100003', '超超', '222.240.151.178', 'MCH', 'com.jeequan.jeepay.mch.ctrl.anon.AuthController.validate', '登录认证', 'http://mch.qianrui88.com/api/anon/auth/validate', '{\"ip\":\"amVlcGF5NjY2\",\"ia\":\"d2FuZ3d1MTIzNA==\",\"vc\":\"M3c5bQ==\",\"vt\":\"ODA1NmRmYjItMmMyYi00MjlmLTk0ODQtYTAxMzEyZjdkOTdm\"}', '{\"msg\":\"SUCCESS\",\"code\":0,\"data\":{\"iToken\":\"eyJhbGciOiJIUzUxMiJ9.eyJjYWNoZUtleSI6IlRPS0VOXzEwMDAwM19iNmI0ZTA4Zi1kYjE1LTRkOTAtOGQyMi02OWNmNDNiNmNlMGEiLCJjcmVhdGVkIjoxNjg2MjI5NDA4NTAyLCJzeXNVc2VySWQiOjEwMDAwM30.5SBJXqVywCdPx3Su69syEmT9wup0PW7SSGfpEeSqt-x9L5ZiZAnLKlEP64hwS4hW1z0YnS0RzIYxyDNuNyQ-PA\"}}', '2023-06-08 21:03:28.514000');
INSERT INTO `t_sys_log` VALUES ('72', '801', '超管', '222.240.151.178', 'MGR', 'com.jeequan.jeepay.mgr.ctrl.anon.AuthController.validate', '登录认证', 'http://mgr.qianrui88.com/api/anon/auth/validate', '{\"ip\":\"amVlcGF5MTIz\",\"ia\":\"amVlcGF5\",\"vc\":\"azRidg==\",\"vt\":\"ZGQ1OWFlMzMtM2EwMy00MGFmLWJmMjEtNjFiZDUwYzY2MzQz\"}', '{\"msg\":\"SUCCESS\",\"code\":0,\"data\":{\"iToken\":\"eyJhbGciOiJIUzUxMiJ9.eyJjYWNoZUtleSI6IlRPS0VOXzgwMV85Mjc0ZTFkOS03ZWI3LTQ4OWUtOTcwYS01ZDc2M2Y4ZWU1YzIiLCJjcmVhdGVkIjoxNjg2MjI5NDQ0NjAwLCJzeXNVc2VySWQiOjgwMX0.rSvz_oOIQj1_MWMnaMzYKHLXFhj757rK7zQEdr8zL7eOhHGdcrp0ZDwCyteasM_a8JwxXCFzlw_mNrrodU79TQ\"}}', '2023-06-08 21:04:04.611000');
INSERT INTO `t_sys_log` VALUES ('73', '801', '超管', '45.158.180.141', 'MGR', 'com.jeequan.jeepay.mgr.ctrl.anon.AuthController.validate', '登录认证', 'http://mgr.qianrui88.com/api/anon/auth/validate', '{\"ip\":\"amVlcGF5MTIz\",\"ia\":\"amVlcGF5\",\"vc\":\"NXhiMQ==\",\"vt\":\"OWUzYTA5M2ItNTAyOS00ZGRmLTg1MmUtZjJmNmFkYmUyNTAz\"}', '{\"msg\":\"SUCCESS\",\"code\":0,\"data\":{\"iToken\":\"eyJhbGciOiJIUzUxMiJ9.eyJjYWNoZUtleSI6IlRPS0VOXzgwMV9hZmU3YmUzMy01MTgyLTRhNGYtOTkyMC05OGJkYzUxMDA1NmMiLCJjcmVhdGVkIjoxNjg2MjM1NTE2MTU0LCJzeXNVc2VySWQiOjgwMX0.ZP04PmHlHDKOWbaGZ4I36jp1VCwwJZWyL4fUjG4f70OGSX9lkogd4SIIZIPfVxAHX8ILEzaQ-tZ-571Zz__ZyQ\"}}', '2023-06-08 22:45:16.164000');
INSERT INTO `t_sys_log` VALUES ('74', '801', '超管', '222.244.148.160', 'MGR', 'com.jeequan.jeepay.mgr.ctrl.anon.AuthController.validate', '登录认证', 'http://mgr.qianrui88.com/api/anon/auth/validate', '{\"ip\":\"amVlcGF5MTIz\",\"ia\":\"amVlcGF5\",\"vc\":\"Mjh0Zg==\",\"vt\":\"ZDg4YzFlOTktNGJhNy00NDllLTk4MmItNzJjOTYyOWJkNzAw\"}', '{\"msg\":\"SUCCESS\",\"code\":0,\"data\":{\"iToken\":\"eyJhbGciOiJIUzUxMiJ9.eyJjYWNoZUtleSI6IlRPS0VOXzgwMV9hY2RkODZkMi1jY2YyLTRlNDAtYTE5ZC05MTBiZDhlNDE3MjciLCJjcmVhdGVkIjoxNjg2MjM3NTE2ODgyLCJzeXNVc2VySWQiOjgwMX0.dDPJ5VcMLTTdgs4Pq2nN677OMK4FalucoN_5kjZRoHq6vhcdfpuzcKGiQ2h7VmvhWS6lA0Qk9I53ubJI2-6xAg\"}}', '2023-06-08 23:18:36.893000');
INSERT INTO `t_sys_log` VALUES ('75', '801', '超管', '222.244.178.108', 'MGR', 'com.jeequan.jeepay.mgr.ctrl.merchant.MchPayInterfaceConfigController.saveOrUpdate', '更新应用支付参数', 'http://mgr.qianrui88.com/api/mch/payConfigs', '{\"ifCode\":\"alipay\",\"infoId\":\"6481c574e4b073567be3d33f\",\"ifParams\":\"{\\\"sandbox\\\":0,\\\"signType\\\":\\\"RSA2\\\",\\\"useCert\\\":0,\\\"appPublicCert\\\":\\\"\\\",\\\"alipayPublicCert\\\":\\\"\\\",\\\"alipayRootCert\\\":\\\"\\\",\\\"appAuthToken\\\":\\\"202306BB3eef3541ef2c4eb588ea44f56d422X90\\\"}\",\"state\":1}', '{\"msg\":\"SUCCESS\",\"code\":0}', '2023-06-08 23:27:39.940000');
INSERT INTO `t_sys_log` VALUES ('76', '801', '超管', '222.244.178.108', 'MGR', 'com.jeequan.jeepay.mgr.ctrl.merchant.MchPayInterfaceConfigController.saveOrUpdate', '更新应用支付参数', 'http://mgr.qianrui88.com/api/mch/payConfigs', '{\"ifCode\":\"alipay\",\"infoId\":\"6481c574e4b073567be3d33f\",\"ifParams\":\"{\\\"sandbox\\\":0,\\\"signType\\\":\\\"RSA2\\\",\\\"useCert\\\":0,\\\"appPublicCert\\\":\\\"\\\",\\\"alipayPublicCert\\\":\\\"\\\",\\\"alipayRootCert\\\":\\\"\\\",\\\"appAuthToken\\\":\\\"202306BB223cae0f57d54bb686c95b2e318eaC38\\\"}\",\"state\":1}', '{\"msg\":\"SUCCESS\",\"code\":0}', '2023-06-08 23:33:54.487000');
INSERT INTO `t_sys_log` VALUES ('77', '801', '超管', '222.244.178.108', 'MGR', 'com.jeequan.jeepay.mgr.ctrl.merchant.MchPayPassageConfigController.saveOrUpdate', '更新商户支付通道', 'http://mgr.qianrui88.com/api/mch/payPassages', '{\"reqParams\":\"[{\\\"id\\\":\\\"\\\",\\\"appId\\\":\\\"6481c574e4b073567be3d33f\\\",\\\"wayCode\\\":\\\"ALI_WAP\\\",\\\"ifCode\\\":\\\"alipay\\\",\\\"rate\\\":\\\"0.1\\\",\\\"state\\\":1}]\"}', '{\"msg\":\"SUCCESS\",\"code\":0}', '2023-06-08 23:34:34.612000');
INSERT INTO `t_sys_log` VALUES ('78', '801', '超管', '222.244.178.108', 'MGR', 'com.jeequan.jeepay.mgr.ctrl.merchant.MchPayPassageConfigController.saveOrUpdate', '更新商户支付通道', 'http://mgr.qianrui88.com/api/mch/payPassages', '{\"reqParams\":\"[{\\\"id\\\":\\\"\\\",\\\"appId\\\":\\\"6481c574e4b073567be3d33f\\\",\\\"wayCode\\\":\\\"ALI_APP\\\",\\\"ifCode\\\":\\\"alipay\\\",\\\"rate\\\":\\\"0.38\\\",\\\"state\\\":1}]\"}', '{\"msg\":\"SUCCESS\",\"code\":0}', '2023-06-08 23:34:52.822000');

-- ----------------------------
-- Table structure for t_sys_role
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_role`;
CREATE TABLE `t_sys_role` (
  `role_id` varchar(32) NOT NULL COMMENT '角色ID, ROLE_开头',
  `role_name` varchar(32) NOT NULL COMMENT '角色名称',
  `sys_type` varchar(8) NOT NULL COMMENT '所属系统： MGR-运营平台, MCH-商户中心',
  `belong_info_id` varchar(64) NOT NULL DEFAULT '0' COMMENT '所属商户ID / 0(平台)',
  `updated_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统角色表';

-- ----------------------------
-- Records of t_sys_role
-- ----------------------------
INSERT INTO `t_sys_role` VALUES ('ROLE_ADMIN', '系统管理员', 'MGR', '0', '2021-05-01 00:00:00.000000');
INSERT INTO `t_sys_role` VALUES ('ROLE_OP', '普通操作员', 'MGR', '0', '2021-05-01 00:00:00.000000');

-- ----------------------------
-- Table structure for t_sys_role_ent_rela
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_role_ent_rela`;
CREATE TABLE `t_sys_role_ent_rela` (
  `role_id` varchar(32) NOT NULL COMMENT '角色ID',
  `ent_id` varchar(64) NOT NULL COMMENT '权限ID',
  PRIMARY KEY (`role_id`,`ent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统角色权限关联表';

-- ----------------------------
-- Records of t_sys_role_ent_rela
-- ----------------------------

-- ----------------------------
-- Table structure for t_sys_user
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_user`;
CREATE TABLE `t_sys_user` (
  `sys_user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '系统用户ID',
  `login_username` varchar(32) NOT NULL COMMENT '登录用户名',
  `realname` varchar(32) NOT NULL COMMENT '真实姓名',
  `telphone` varchar(32) NOT NULL COMMENT '手机号',
  `sex` tinyint(6) NOT NULL DEFAULT '0' COMMENT '性别 0-未知, 1-男, 2-女',
  `avatar_url` varchar(128) DEFAULT NULL COMMENT '头像地址',
  `user_no` varchar(32) DEFAULT NULL COMMENT '员工编号',
  `is_admin` tinyint(6) NOT NULL DEFAULT '0' COMMENT '是否超管（超管拥有全部权限） 0-否 1-是',
  `state` tinyint(6) NOT NULL DEFAULT '0' COMMENT '状态 0-停用 1-启用',
  `sys_type` varchar(8) NOT NULL COMMENT '所属系统： MGR-运营平台, MCH-商户中心',
  `belong_info_id` varchar(64) NOT NULL DEFAULT '0' COMMENT '所属商户ID / 0(平台)',
  `created_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `updated_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  PRIMARY KEY (`sys_user_id`),
  UNIQUE KEY `sys_type` (`sys_type`,`login_username`),
  UNIQUE KEY `sys_type_2` (`sys_type`,`telphone`),
  UNIQUE KEY `sys_type_3` (`sys_type`,`user_no`)
) ENGINE=InnoDB AUTO_INCREMENT=100004 DEFAULT CHARSET=utf8mb4 COMMENT='系统用户表';

-- ----------------------------
-- Records of t_sys_user
-- ----------------------------
INSERT INTO `t_sys_user` VALUES ('801', 'jeepay', '超管', '13000000001', '1', 'https://jeequan.oss-cn-beijing.aliyuncs.com/jeepay/img/defava_m.png', 'D0001', '1', '1', 'MGR', '0', '2020-06-13 00:00:00.000000', '2020-06-13 00:00:00.000000');
INSERT INTO `t_sys_user` VALUES ('100002', 'lisi1234', '李四', '19119290099', '1', 'https://jeequan.oss-cn-beijing.aliyuncs.com/jeepay/img/defava_m.png', 'M1685406045', '1', '1', 'MCH', 'M1685406045', '2023-05-30 08:20:45.042234', '2023-05-30 08:20:45.042234');
INSERT INTO `t_sys_user` VALUES ('100003', 'wangwu1234', '超超', '18670055200', '1', 'https://jeequan.oss-cn-beijing.aliyuncs.com/jeepay/img/defava_m.png', 'M1686226292', '1', '1', 'MCH', 'M1686226292', '2023-06-08 20:11:32.370797', '2023-06-08 20:11:32.370797');

-- ----------------------------
-- Table structure for t_sys_user_auth
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_user_auth`;
CREATE TABLE `t_sys_user_auth` (
  `auth_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` bigint(20) NOT NULL COMMENT 'user_id',
  `identity_type` tinyint(6) NOT NULL DEFAULT '0' COMMENT '登录类型  1-登录账号 2-手机号 3-邮箱  10-微信  11-QQ 12-支付宝 13-微博',
  `identifier` varchar(128) NOT NULL COMMENT '认证标识 ( 用户名 | open_id )',
  `credential` varchar(128) NOT NULL COMMENT '密码凭证',
  `salt` varchar(128) NOT NULL COMMENT 'salt',
  `sys_type` varchar(8) NOT NULL COMMENT '所属系统： MGR-运营平台, MCH-商户中心',
  PRIMARY KEY (`auth_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1007 DEFAULT CHARSET=utf8mb4 COMMENT='系统用户认证表';

-- ----------------------------
-- Records of t_sys_user_auth
-- ----------------------------
INSERT INTO `t_sys_user_auth` VALUES ('801', '801', '1', 'jeepay', '$2a$10$WKuPJKE1XhX15ibqDM745eOCaZZVUiRitUjEyX6zVNd9k.cQXfzGa', 'testkey', 'MGR');
INSERT INTO `t_sys_user_auth` VALUES ('1003', '100002', '1', 'lisi1234', '$2a$10$07zVDPJTJbgAccSXOyM10O8QPwCbZY8D9c8gM3A3jJwgTvhIXwp1O', '485fa2', 'MCH');
INSERT INTO `t_sys_user_auth` VALUES ('1004', '100002', '2', '19119290099', '$2a$10$MUA7wtWEur3xYgVoXL0ENOtltlEr35LDBPS4ALjoHTtsV1WiCw8hy', '485fa2', 'MCH');
INSERT INTO `t_sys_user_auth` VALUES ('1005', '100003', '1', 'wangwu1234', '$2a$10$C2Hk8PGirvO5nwlCmH7NNObbjH1O8A7/lvPIYcdx79qFvPc.SBREO', '58daf7', 'MCH');
INSERT INTO `t_sys_user_auth` VALUES ('1006', '100003', '2', '18670055200', '$2a$10$C2Hk8PGirvO5nwlCmH7NNObbjH1O8A7/lvPIYcdx79qFvPc.SBREO', '58daf7', 'MCH');

-- ----------------------------
-- Table structure for t_sys_user_role_rela
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_user_role_rela`;
CREATE TABLE `t_sys_user_role_rela` (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `role_id` varchar(32) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='操作员<->角色 关联表';

-- ----------------------------
-- Records of t_sys_user_role_rela
-- ----------------------------

-- ----------------------------
-- Table structure for t_transfer_order
-- ----------------------------
DROP TABLE IF EXISTS `t_transfer_order`;
CREATE TABLE `t_transfer_order` (
  `transfer_id` varchar(32) NOT NULL COMMENT '转账订单号',
  `mch_no` varchar(64) NOT NULL COMMENT '商户号',
  `isv_no` varchar(64) DEFAULT NULL COMMENT '服务商号',
  `app_id` varchar(64) NOT NULL COMMENT '应用ID',
  `mch_name` varchar(30) NOT NULL COMMENT '商户名称',
  `mch_type` tinyint(6) NOT NULL COMMENT '类型: 1-普通商户, 2-特约商户(服务商模式)',
  `mch_order_no` varchar(64) NOT NULL COMMENT '商户订单号',
  `if_code` varchar(20) NOT NULL COMMENT '支付接口代码',
  `entry_type` varchar(20) NOT NULL COMMENT '入账方式： WX_CASH-微信零钱; ALIPAY_CASH-支付宝转账; BANK_CARD-银行卡',
  `amount` bigint(20) NOT NULL COMMENT '转账金额,单位分',
  `currency` varchar(3) NOT NULL DEFAULT 'cny' COMMENT '三位货币代码,人民币:cny',
  `account_no` varchar(64) NOT NULL COMMENT '收款账号',
  `account_name` varchar(64) DEFAULT NULL COMMENT '收款人姓名',
  `bank_name` varchar(32) DEFAULT NULL COMMENT '收款人开户行名称',
  `transfer_desc` varchar(128) NOT NULL DEFAULT '' COMMENT '转账备注信息',
  `client_ip` varchar(32) DEFAULT NULL COMMENT '客户端IP',
  `state` tinyint(6) NOT NULL DEFAULT '0' COMMENT '支付状态: 0-订单生成, 1-转账中, 2-转账成功, 3-转账失败, 4-订单关闭',
  `channel_extra` varchar(512) DEFAULT NULL COMMENT '特定渠道发起额外参数',
  `channel_order_no` varchar(64) DEFAULT NULL COMMENT '渠道订单号',
  `err_code` varchar(128) DEFAULT NULL COMMENT '渠道支付错误码',
  `err_msg` varchar(256) DEFAULT NULL COMMENT '渠道支付错误描述',
  `ext_param` varchar(128) DEFAULT NULL COMMENT '商户扩展参数',
  `notify_url` varchar(128) NOT NULL DEFAULT '' COMMENT '异步通知地址',
  `success_time` datetime DEFAULT NULL COMMENT '转账成功时间',
  `created_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `updated_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  PRIMARY KEY (`transfer_id`),
  UNIQUE KEY `Uni_MchNo_MchOrderNo` (`mch_no`,`mch_order_no`),
  KEY `created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='转账订单表';

-- ----------------------------
-- Records of t_transfer_order
-- ----------------------------
