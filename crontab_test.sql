/*
Navicat MySQL Data Transfer

Source Server         : centos6.5
Source Server Version : 50634
Source Host           : 192.168.10.29:3306
Source Database       : crontab_test

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2017-06-29 18:00:08
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for business_change_record
-- ----------------------------
DROP TABLE IF EXISTS `business_change_record`;
CREATE TABLE `business_change_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) DEFAULT NULL,
  `old_worker_id` int(11) DEFAULT NULL,
  `new_worker_id` int(11) DEFAULT NULL,
  `change_time` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `change_type` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `content` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `old_value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `new_value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `create_uid` int(11) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `update_uid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for business_contacts
-- ----------------------------
DROP TABLE IF EXISTS `business_contacts`;
CREATE TABLE `business_contacts` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_uid` int(11) DEFAULT NULL COMMENT '更新人',
  `create_uid` int(11) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL,
  `business_partner_id` int(11) DEFAULT NULL,
  `username` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '姓名',
  `email` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'email',
  `mobile` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '手机号码',
  `qq` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'QQ号码',
  `tel` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '家庭电话',
  `fax` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '传真',
  `wangwang` varchar(120) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '旺旺',
  `weixin` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '微信',
  `address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '家庭住址',
  `zip` int(11) DEFAULT NULL COMMENT '邮编',
  `category_id` int(11) DEFAULT NULL COMMENT '联系人分类',
  `operating_duty` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '负责业务',
  `type` tinyint(1) DEFAULT NULL COMMENT '类型(1 主要联系人 2 次要)',
  `department` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '部门',
  `position` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '职务',
  `job_phone` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '工作电话',
  `hobby` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '联系人爱好',
  `age` int(11) DEFAULT NULL COMMENT '年龄',
  `sex` char(1) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '性别',
  `remark` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `username` (`username`) USING BTREE,
  KEY `business_partner_id` (`business_partner_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='联系人';

-- ----------------------------
-- Table structure for business_demand
-- ----------------------------
DROP TABLE IF EXISTS `business_demand`;
CREATE TABLE `business_demand` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `update_uid` int(11) NOT NULL COMMENT '更新Uid',
  `create_uid` int(11) NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `product_code` varchar(128) COLLATE utf8_unicode_ci NOT NULL COMMENT '牌号名称',
  `business_id` int(11) DEFAULT NULL,
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `product_code` (`product_code`) USING BTREE,
  KEY `business_id` (`business_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='用户需求牌号表';

-- ----------------------------
-- Table structure for business_information
-- ----------------------------
DROP TABLE IF EXISTS `business_information`;
CREATE TABLE `business_information` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_uid` int(11) DEFAULT NULL COMMENT '数据创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_uid` int(11) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `key_no` varchar(255) NOT NULL COMMENT '公司内部关联主键KeyNo',
  `name` varchar(255) DEFAULT NULL COMMENT '公司名称',
  `oper_name` varchar(255) DEFAULT NULL COMMENT '法定代表人',
  `start_date` datetime DEFAULT NULL COMMENT '成立日期',
  `end_date` datetime DEFAULT NULL,
  `term_start` datetime DEFAULT NULL COMMENT '营业期限自',
  `team_end` datetime DEFAULT NULL COMMENT '营业期限至',
  `check_date` datetime DEFAULT NULL COMMENT '核准日期',
  `status` varchar(64) DEFAULT NULL COMMENT '登记状态',
  `belong_org` varchar(255) DEFAULT NULL COMMENT '登记机关',
  `province` varchar(255) DEFAULT NULL COMMENT '所在省份缩写',
  `updated_date` datetime DEFAULT NULL COMMENT '记录更新时间',
  `credit_code` varchar(255) DEFAULT NULL,
  `regist_no` varchar(255) DEFAULT NULL COMMENT '注册号或统一社会信用代码，默认统一社会信用代码',
  `regist_capi` varchar(255) DEFAULT NULL COMMENT '注册资本',
  `econ_kind` varchar(255) DEFAULT NULL COMMENT '类型',
  `address` varchar(255) DEFAULT NULL COMMENT '地址',
  `scope` varchar(255) DEFAULT NULL COMMENT '经营范围',
  `is_real` tinyint(4) DEFAULT NULL COMMENT '是否有效（1有效，0有效），查询时如无数据，也插入数据（只有name，且is_real=0），有数据时is_real=1',
  PRIMARY KEY (`id`),
  KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='企业工商数据';

-- ----------------------------
-- Table structure for business_partner
-- ----------------------------
DROP TABLE IF EXISTS `business_partner`;
CREATE TABLE `business_partner` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `update_uid` int(11) NOT NULL,
  `create_uid` int(11) NOT NULL,
  `audit_uid` int(11) NOT NULL COMMENT '审核人',
  `audit_time` datetime NOT NULL COMMENT '审核时间',
  `update_time` datetime NOT NULL,
  `create_time` datetime NOT NULL,
  `account_id` int(11) DEFAULT NULL,
  `department_id` int(11) NOT NULL COMMENT '部门',
  `organization_id` int(11) NOT NULL COMMENT '实业部',
  `user_id` int(11) DEFAULT NULL,
  `cate_id` int(11) DEFAULT NULL COMMENT '分类ID',
  `client_type` char(1) COLLATE utf8_unicode_ci NOT NULL COMMENT '客户类型 P:个人 B：公司',
  `business_key` varchar(60) COLLATE utf8_unicode_ci NOT NULL COMMENT '公司唯一标识SN 编号',
  `business_name` varchar(128) COLLATE utf8_unicode_ci NOT NULL COMMENT '公司名称',
  `business_entity` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '公司法人',
  `business_type` int(11) NOT NULL COMMENT '公司类型（1.工厂，2，贸易商）',
  `business_industry` tinyint(3) NOT NULL COMMENT '公司行业',
  `business_scope` tinyint(1) unsigned NOT NULL COMMENT '公司规模',
  `business_web` varchar(128) COLLATE utf8_unicode_ci NOT NULL COMMENT '公司网站',
  `business_paper` text COLLATE utf8_unicode_ci NOT NULL COMMENT '三证（JSON）',
  `license_new` text COLLATE utf8_unicode_ci COMMENT '三证合一',
  `business_capital` int(1) NOT NULL COMMENT '注册资金（1:10-50；2:50-100；3:100-150;4:）',
  `business_channel` char(1) COLLATE utf8_unicode_ci NOT NULL COMMENT '合作渠道(b,b2b,c,b2c)',
  `business_aptitude` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '资质证明(文件)',
  `sale_period` int(11) DEFAULT NULL COMMENT '销售账期（月）',
  `purchase_period` int(11) NOT NULL COMMENT '采购账期（月）',
  `is_supplier` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N' COMMENT '是否供应商',
  `is_protected` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N' COMMENT '是否保护',
  `is_customer` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N' COMMENT '是否客户',
  `group_id` int(11) NOT NULL COMMENT '客户组',
  `customer_service` text COLLATE utf8_unicode_ci NOT NULL COMMENT '售后保障',
  `business_from` int(5) NOT NULL COMMENT '客户来源',
  `business_valuation` int(1) NOT NULL COMMENT '价值评估:1低，2中，3高',
  `business_stage` int(11) NOT NULL COMMENT '跟进阶段：1售前跟踪，2合同执行，3售后服务，4合同期满（结束）',
  `business_regdate` datetime DEFAULT NULL,
  `business_regip` bigint(20) DEFAULT NULL,
  `worker_id` int(6) NOT NULL COMMENT '负责人',
  `status` char(1) COLLATE utf8_unicode_ci NOT NULL COMMENT '客户状态',
  `expired_time` datetime DEFAULT NULL COMMENT '过期时间',
  `province_id` mediumint(6) NOT NULL COMMENT '公司省ID',
  `city_id` mediumint(6) DEFAULT NULL COMMENT '公司市ID',
  `area_id` mediumint(6) DEFAULT NULL COMMENT '公司地区县级等ID',
  `addr_type` char(1) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '公司地址类型 X学校 C 公司 J家里 O 其他',
  `detail_addr` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '详细地址',
  `zip` char(6) COLLATE utf8_unicode_ci NOT NULL COMMENT '邮编号码',
  `tel` char(13) COLLATE utf8_unicode_ci NOT NULL COMMENT '固定电话',
  `fax` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '传真',
  `is_join` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N' COMMENT '是否对接',
  `is_join_222` int(11) DEFAULT NULL,
  `protect_time` datetime NOT NULL COMMENT '更新时间',
  `remark` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `delivery_area` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '交货地',
  `business_degree` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `main_product` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `old_status` int(11) DEFAULT NULL,
  `old_protect_time` datetime DEFAULT NULL COMMENT '原始保护时间',
  `old_expired_time` datetime DEFAULT NULL COMMENT '原保护时间',
  `release_protect_time` datetime DEFAULT NULL COMMENT '上一次解除保护的时间',
  `delete_time` datetime DEFAULT NULL COMMENT '删除时间',
  `is_public` tinyint(1) DEFAULT NULL COMMENT '是否公共客户(1是，0否）',
  `is_forbid` tinyint(1) DEFAULT '0' COMMENT '是否有效（1禁用，0不禁用）',
  `is_del` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N' COMMENT '是否删除',
  `forbid_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `prepay_rate` decimal(11,2) DEFAULT NULL COMMENT '预付货款比例',
  `amount_limit` decimal(21,2) DEFAULT NULL COMMENT '订单限额',
  `prepay_rate_apply` decimal(11,2) DEFAULT NULL COMMENT '预付比例申请',
  `amount_limit_apply` decimal(21,2) DEFAULT NULL COMMENT '额度申请',
  `check_process` int(11) DEFAULT NULL,
  `is_confirm` int(11) DEFAULT NULL COMMENT '是否已通过验证（0否1是）',
  `business_level` int(1) DEFAULT NULL COMMENT '客户等级',
  `is_join_out` int(1) DEFAULT NULL COMMENT '是否同步到外平台',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `business_name` (`business_name`) USING BTREE,
  KEY `worker_id` (`worker_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='客户主表';

-- ----------------------------
-- Table structure for business_partner_access
-- ----------------------------
DROP TABLE IF EXISTS `business_partner_access`;
CREATE TABLE `business_partner_access` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_uid` int(11) DEFAULT NULL COMMENT '数据创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_uid` int(11) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `partner_id` int(11) DEFAULT NULL,
  `account_id` int(11) DEFAULT NULL,
  `organization_id` int(11) DEFAULT NULL,
  `department_id` int(11) DEFAULT NULL,
  `worker_id` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL COMMENT '个人访问状态（1：潜在,2意向3正式）',
  `old_status` int(11) DEFAULT NULL COMMENT '原始状态',
  `old_protect_time` datetime DEFAULT NULL,
  `old_expired_time` datetime DEFAULT NULL COMMENT '原过期时间',
  `release_protect_time` datetime DEFAULT NULL COMMENT '上一次解除保护的时间',
  `protect_time` datetime DEFAULT NULL,
  `expired_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `partner_access-partner_id` (`partner_id`) USING BTREE,
  KEY `partner_access-worker_id` (`worker_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for crontab
-- ----------------------------
DROP TABLE IF EXISTS `crontab`;
CREATE TABLE `crontab` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime DEFAULT NULL,
  `ids` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
