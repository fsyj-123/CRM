/*
MySQL Data Transfer
Source Host: localhost
Source Database: crm
Target Host: localhost
Target Database: crm
Date: 2021/8/24 15:06:33
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for tbl_activity
-- ----------------------------
DROP TABLE IF EXISTS `tbl_activity`;
CREATE TABLE `tbl_activity` (
  `id` char(32) NOT NULL,
  `owner` char(32) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `startDate` char(10) DEFAULT NULL,
  `endDate` char(10) DEFAULT NULL,
  `cost` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `createBy` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editBy` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tbl_activity_remark
-- ----------------------------
DROP TABLE IF EXISTS `tbl_activity_remark`;
CREATE TABLE `tbl_activity_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `createBy` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editBy` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL COMMENT '0表示未修改，1表示已修改',
  `activityId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tbl_clue
-- ----------------------------
DROP TABLE IF EXISTS `tbl_clue`;
CREATE TABLE `tbl_clue` (
  `id` char(32) NOT NULL,
  `fullname` varchar(255) DEFAULT NULL,
  `appellation` varchar(255) DEFAULT NULL,
  `owner` char(32) DEFAULT NULL,
  `company` varchar(255) DEFAULT NULL,
  `job` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `mphone` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `createBy` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `contactSummary` varchar(255) DEFAULT NULL,
  `nextContactTime` char(10) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tbl_clue_activity_relation
-- ----------------------------
DROP TABLE IF EXISTS `tbl_clue_activity_relation`;
CREATE TABLE `tbl_clue_activity_relation` (
  `id` char(32) NOT NULL,
  `clueId` char(32) DEFAULT NULL,
  `activityId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tbl_clue_remark
-- ----------------------------
DROP TABLE IF EXISTS `tbl_clue_remark`;
CREATE TABLE `tbl_clue_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createBy` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL,
  `clueId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tbl_contacts
-- ----------------------------
DROP TABLE IF EXISTS `tbl_contacts`;
CREATE TABLE `tbl_contacts` (
  `id` char(32) NOT NULL,
  `owner` char(32) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `customerId` char(32) DEFAULT NULL,
  `fullname` varchar(255) DEFAULT NULL,
  `appellation` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mphone` varchar(255) DEFAULT NULL,
  `job` varchar(255) DEFAULT NULL,
  `birth` char(10) DEFAULT NULL,
  `createBy` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `contactSummary` varchar(255) DEFAULT NULL,
  `nextContactTime` char(10) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tbl_contacts_activity_relation
-- ----------------------------
DROP TABLE IF EXISTS `tbl_contacts_activity_relation`;
CREATE TABLE `tbl_contacts_activity_relation` (
  `id` char(32) NOT NULL,
  `contactsId` char(32) DEFAULT NULL,
  `activityId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tbl_contacts_remark
-- ----------------------------
DROP TABLE IF EXISTS `tbl_contacts_remark`;
CREATE TABLE `tbl_contacts_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL,
  `contactsId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tbl_customer
-- ----------------------------
DROP TABLE IF EXISTS `tbl_customer`;
CREATE TABLE `tbl_customer` (
  `id` char(32) NOT NULL,
  `owner` char(32) DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `website` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `createBy` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `contactSummary` varchar(255) DEFAULT NULL,
  `nextContactTime` char(10) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tbl_customer_remark
-- ----------------------------
DROP TABLE IF EXISTS `tbl_customer_remark`;
CREATE TABLE `tbl_customer_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL,
  `customerId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tbl_dic_type
-- ----------------------------
DROP TABLE IF EXISTS `tbl_dic_type`;
CREATE TABLE `tbl_dic_type` (
  `code` varchar(255) NOT NULL COMMENT '编码是主键，不能为空，不能含有中文。',
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tbl_dic_value
-- ----------------------------
DROP TABLE IF EXISTS `tbl_dic_value`;
CREATE TABLE `tbl_dic_value` (
  `id` char(32) NOT NULL COMMENT '主键，采用UUID',
  `value` varchar(255) DEFAULT NULL COMMENT '不能为空，并且要求同一个字典类型下字典值不能重复，具有唯一性。',
  `text` varchar(255) DEFAULT NULL COMMENT '可以为空',
  `orderNo` varchar(255) DEFAULT NULL COMMENT '可以为空，但不为空的时候，要求必须是正整数',
  `typeCode` varchar(255) DEFAULT NULL COMMENT '外键',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tbl_tran
-- ----------------------------
DROP TABLE IF EXISTS `tbl_tran`;
CREATE TABLE `tbl_tran` (
  `id` char(32) NOT NULL,
  `owner` char(32) DEFAULT NULL,
  `money` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `expectedDate` char(10) DEFAULT NULL,
  `customerId` char(32) DEFAULT NULL,
  `stage` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `activityId` char(32) DEFAULT NULL,
  `contactsId` char(32) DEFAULT NULL,
  `createBy` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `contactSummary` varchar(255) DEFAULT NULL,
  `nextContactTime` char(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tbl_tran_history
-- ----------------------------
DROP TABLE IF EXISTS `tbl_tran_history`;
CREATE TABLE `tbl_tran_history` (
  `id` char(32) NOT NULL,
  `stage` varchar(255) DEFAULT NULL,
  `money` varchar(255) DEFAULT NULL,
  `expectedDate` char(10) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `tranId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tbl_tran_remark
-- ----------------------------
DROP TABLE IF EXISTS `tbl_tran_remark`;
CREATE TABLE `tbl_tran_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL,
  `tranId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tbl_user
-- ----------------------------
DROP TABLE IF EXISTS `tbl_user`;
CREATE TABLE `tbl_user` (
  `id` char(32) NOT NULL COMMENT 'uuid\r\n            ',
  `loginAct` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `loginPwd` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '密码不能采用明文存储，采用密文，MD5加密之后的数据',
  `email` varchar(255) DEFAULT NULL,
  `expireTime` char(19) DEFAULT NULL COMMENT '失效时间为空的时候表示永不失效，失效时间为2018-10-10 10:10:10，则表示在该时间之前该账户可用。',
  `lockState` char(1) DEFAULT NULL COMMENT '锁定状态为空时表示启用，为0时表示锁定，为1时表示启用。',
  `deptno` char(4) DEFAULT NULL,
  `allowIps` varchar(255) DEFAULT NULL COMMENT '允许访问的IP为空时表示IP地址永不受限，允许访问的IP可以是一个，也可以是多个，当多个IP地址的时候，采用半角逗号分隔。允许IP是192.168.100.2，表示该用户只能在IP地址为192.168.100.2的机器上使用。',
  `createTime` char(19) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `tbl_activity` VALUES ('1acaf1c1c29b4718afa157ca91ea2900', '40f6cdea0bd34aceb77492a1656d9fb3', '测试（属于格力）', '2021-08-22', '2021-08-22', '1000', '无', '2021-08-22 09:53:12', '40f6cdea0bd34aceb77492a1656d9fb3', null, null), ('486d25ff26f84a6094b9827fd31bc1b3', '06f5fc056eac41558a964f96daa7f27c', '扫垃圾', '2021-07-13', '2021-07-22', '3', '扫办公垃圾', '2021-07-13 22:45:13', '40f6cdea0bd34aceb77492a1656d9fb3', null, null), ('6ac45865739a4afe977eefe2ab7fa5bf', '40f6cdea0bd34aceb77492a1656d9fb3', '扫垃圾2', '2021-07-16', '2021-07-17', '10', '扫垃圾', '2021-07-16 17:46:01', '40f6cdea0bd34aceb77492a1656d9fb3', null, null), ('6c5a72953bfb404a9b36b289e8c6b247', '40f6cdea0bd34aceb77492a1656d9fb3', '扫垃圾3', '2021-07-16', '2021-07-17', '10', '扫垃圾', '2021-07-16 17:46:08', '40f6cdea0bd34aceb77492a1656d9fb3', null, null), ('6c5cbe26a6914e65a8ab5676ba6952ec', '40f6cdea0bd34aceb77492a1656d9fb3', '扫垃圾44', '2021-07-13', '2021-07-22', '12', '打扫大楼的垃圾', '2021-07-13 22:44:00', '40f6cdea0bd34aceb77492a1656d9fb3', null, null), ('8035ca94bb144ee7af24cd137c81d054', '40f6cdea0bd34aceb77492a1656d9fb3', '扫垃圾4', '2021-07-16', '2021-07-17', '10', '扫垃圾', '2021-07-16 17:46:16', '40f6cdea0bd34aceb77492a1656d9fb3', null, null), ('9fbb23844e674b38823ce983c133f28e', '40f6cdea0bd34aceb77492a1656d9fb3', '扫垃圾6', '2021-07-16', '2021-07-17', '10', '扫垃圾', '2021-07-16 17:46:39', '40f6cdea0bd34aceb77492a1656d9fb3', null, null), ('b086787e6c72456d8a3d67504fc36831', '40f6cdea0bd34aceb77492a1656d9fb3', '测试（属于阿里）', '2021-08-22', '2021-08-22', '159', '159', '2021-08-22 10:05:42', '40f6cdea0bd34aceb77492a1656d9fb3', null, null), ('bb7db0de07484a50a03ed6071c3430df', '40f6cdea0bd34aceb77492a1656d9fb3', '测试（属于腾讯）', '2021-08-22', '2021-08-22', '123', '123', '2021-08-22 10:06:01', '40f6cdea0bd34aceb77492a1656d9fb3', null, null), ('c074185986764470baff7dcacd3970bb', '40f6cdea0bd34aceb77492a1656d9fb3', '测试（属于万达）', '2021-08-22', '2021-08-22', '5000', '', '2021-08-22 15:24:35', '40f6cdea0bd34aceb77492a1656d9fb3', null, null), ('d5b03fef150e41c9a6d08ae62913f994', '06f5fc056eac41558a964f96daa7f27c', '扫垃圾7123', '2021-07-16', '2021-07-17', '100', '扫垃圾', '2021-07-16 17:46:43', '40f6cdea0bd34aceb77492a1656d9fb3', '2021-07-19 13:55:45', '40f6cdea0bd34aceb77492a1656d9fb3'), ('ff4c4fed6c1949a29ffeaff63cba8585', '40f6cdea0bd34aceb77492a1656d9fb3', '扫垃圾5', '2021-07-16', '2021-07-17', '10', '扫垃圾', '2021-07-16 17:46:21', '40f6cdea0bd34aceb77492a1656d9fb3', null, null);
INSERT INTO `tbl_activity_remark` VALUES ('1380050d66ef461d8300bc3c4330b6d4', '福岛事故发生', '2021-07-20 15:22:10', '40f6cdea0bd34aceb77492a1656d9fb3', null, null, '0', 'd5b03fef150e41c9a6d08ae62913f994'), ('41f6cdea0bd34aceb77492a1656d9fb1', '扫垃圾2', '2017-01-22 10:10:10', '40f6cdea0bd34aceb77492a1656d9fb3', null, null, '0', '6ac45865739a4afe977eefe2ab7fa5bf'), ('41f6cdea0bd34aceb77492a1656d9fb3', '打扫垃圾666888', '2017-01-22 10:12:10', '06f5fc056eac41558a964f96daa7f27c', '2021-07-20 14:51:39', '40f6cdea0bd34aceb77492a1656d9fb3', '1', 'd5b03fef150e41c9a6d08ae62913f994'), ('41f6cdea0bd34aceb77492a1656d9fb4', '扫7785', '2017-01-22 10:13:10', '40f6cdea0bd34aceb77492a1656d9fb3', '2021-07-20 14:51:53', '40f6cdea0bd34aceb77492a1656d9fb3', '1', 'd5b03fef150e41c9a6d08ae62913f994'), ('41f6cdea0bd34aceb77492a1656d9fb5', '这个不是扫垃圾', '2017-01-22 10:10:10', '40f6cdea0bd34aceb77492a1656d9fb3', null, null, '0', '486d25ff26f84a6094b9827fd31bc1b3'), ('4448cfed73dc47dba26265ef6a02d31a', '绕过', '2021-07-20 15:20:51', '40f6cdea0bd34aceb77492a1656d9fb3', null, null, '0', 'd5b03fef150e41c9a6d08ae62913f994'), ('517c99ba2a5d466c814fac18d5e6eb5d', '爱的发声', '2021-07-20 15:22:31', '40f6cdea0bd34aceb77492a1656d9fb3', null, null, '0', '6c5cbe26a6914e65a8ab5676ba6952ec'), ('8a75384eb3e34489ad2696a08cc60dc8', '爱的方式', '2021-07-20 15:22:02', '40f6cdea0bd34aceb77492a1656d9fb3', null, null, '0', 'd5b03fef150e41c9a6d08ae62913f994'), ('bac61b722baa40aeac5de2065ed92f91', '但是发射点', '2021-07-20 15:24:26', '40f6cdea0bd34aceb77492a1656d9fb3', null, null, '0', '6c5a72953bfb404a9b36b289e8c6b247'), ('db0e73e14f474965b3173054e21a23b2', '撒打发但是', '2021-07-20 15:22:24', '40f6cdea0bd34aceb77492a1656d9fb3', null, null, '0', '9fbb23844e674b38823ce983c133f28e'), ('f4902f652dee48589b4451fc6f170e7b', '撒法大使', '2021-07-20 15:22:16', '40f6cdea0bd34aceb77492a1656d9fb3', null, null, '0', 'd5b03fef150e41c9a6d08ae62913f994');
INSERT INTO `tbl_clue` VALUES ('264cf18f303d4606b00bd31e9bd89b13', '李', '教授', '06f5fc056eac41558a964f96daa7f27c', '阿里', 'ceo', '123@123.com', '1234', '1234', '123456', '未联系', '公开媒介', '40f6cdea0bd34aceb77492a1656d9fb3', '2021-07-22 23:17:16', null, null, '阿里巴巴', '', '2021-07-23', '杭州'), ('4faaaea0b48c4d06ad57bf3deda73e07', '发v的', '教授', '06f5fc056eac41558a964f96daa7f27c', '阿拉放松的地方', 'ceo', '123456', '123456789', 'www.yyds.com', '151', '未联系', '公开媒介', '40f6cdea0bd34aceb77492a1656d9fb3', '2021-07-23 15:48:29', null, null, 'fsdfs', '', '2021-07-24', '无'), ('6926262364cd453d95e4bbfebb04eb24', '的方式', '教授', '06f5fc056eac41558a964f96daa7f27c', '阿拉放松的地方', 'ceo', '123456', '123456789', 'www.yyds.com', '151', '未联系', '公开媒介', '40f6cdea0bd34aceb77492a1656d9fb3', '2021-07-23 15:48:20', null, null, 'fsdfs', '', '2021-07-24', '无'), ('92a231c6f6a84472b08d8a2ac089fe95', '章', '教授', '06f5fc056eac41558a964f96daa7f27c', 'ali', 'ceo', '123456', '123456789', 'www.yyds.com', '151', '未联系', '公开媒介', '40f6cdea0bd34aceb77492a1656d9fb3', '2021-07-23 15:46:51', null, null, 'fsdfs', '', '2021-07-24', '无'), ('a6203b1eacd141778b39141bfe3f05ee', '浮点数', '教授', '06f5fc056eac41558a964f96daa7f27c', '阿拉放松的地方', 'ceo', '123456', '123456789', 'www.yyds.com', '151', '未联系', '公开媒介', '40f6cdea0bd34aceb77492a1656d9fb3', '2021-07-23 15:47:53', null, null, 'fsdfs', '', '2021-07-24', '无'), ('ad47625e99df4123a8d55638be6c27d0', '浮点数', '教授', '06f5fc056eac41558a964f96daa7f27c', '阿拉蕾', 'ceo', '123456', '123456789', 'www.yyds.com', '151', '未联系', '公开媒介', '40f6cdea0bd34aceb77492a1656d9fb3', '2021-07-23 15:47:41', null, null, 'fsdfs', '', '2021-07-24', '无'), ('b5e5a5895a4547a987fb48d6fcd8ee23', 'fsd', '教授', '06f5fc056eac41558a964f96daa7f27c', 'fsd', 'fds', 'fds', 'fds', 'fds', 'fds', '虚假线索', '销售邮件', '40f6cdea0bd34aceb77492a1656d9fb3', '2021-08-08 22:51:36', null, null, 'fds', 'fdsfds', '1899-12-31', 'fds'), ('e6a07660b0d545ec93cf780ccbd38d34', '的方式浮点数', '教授', '06f5fc056eac41558a964f96daa7f27c', '阿拉放松的地方', 'ceo', '123456', '123456789', 'www.yyds.com', '151', '未联系', '公开媒介', '40f6cdea0bd34aceb77492a1656d9fb3', '2021-07-23 15:48:24', null, null, 'fsdfs', '', '2021-07-24', '无');
INSERT INTO `tbl_clue_activity_relation` VALUES ('', null, null), ('10b839dd5307475c91e3b7a5023f7db5', '4faaaea0b48c4d06ad57bf3deda73e07', '8035ca94bb144ee7af24cd137c81d054'), ('409dc8949a934b05abffdf1ccf04ecb2', '4faaaea0b48c4d06ad57bf3deda73e07', '6ac45865739a4afe977eefe2ab7fa5bf'), ('5b5a56d650bd4b4f9fae06bfe961eeb7', 'e6a07660b0d545ec93cf780ccbd38d34', 'd5b03fef150e41c9a6d08ae62913f994'), ('76d2fabe7ae341678c1b2c6b1508a648', '4faaaea0b48c4d06ad57bf3deda73e07', '9fbb23844e674b38823ce983c133f28e'), ('7dc9c644a08e41549528268fe4868bd5', '4faaaea0b48c4d06ad57bf3deda73e07', '6c5cbe26a6914e65a8ab5676ba6952ec'), ('830f22b5f9a04b329719124467074940', 'e6a07660b0d545ec93cf780ccbd38d34', '6ac45865739a4afe977eefe2ab7fa5bf'), ('961174bdf6e54723a9e5d991147d3d91', 'ad47625e99df4123a8d55638be6c27d0', '6ac45865739a4afe977eefe2ab7fa5bf'), ('ad47625e99df4123a8d55638be6c27d1', 'e6a07660b0d545ec93cf780ccbd38d34', '8035ca94bb144ee7af24cd137c81d054'), ('c88a2b0cbdc54f8ca39e0c808415f6a7', '4faaaea0b48c4d06ad57bf3deda73e07', '486d25ff26f84a6094b9827fd31bc1b3'), ('ce224c8babe84c01a66b93b49c70c3cb', '4faaaea0b48c4d06ad57bf3deda73e07', '6c5a72953bfb404a9b36b289e8c6b247');
INSERT INTO `tbl_contacts` VALUES ('6369569ed4db44c2be348428ec5f122e', '06f5fc056eac41558a964f96daa7f27c', 'web下载', '058732f8b86b44f9abfa93af16e4086f', '董', '女士', '撒法大使', '43145', 'CEO', null, '40f6cdea0bd34aceb77492a1656d9fb3', '2021-08-22 15:45:12', null, null, '', '', '2021-08-25', ''), ('90ba5a65b37d46dbac3a5211d5958d94', '06f5fc056eac41558a964f96daa7f27c', 'web下载', 'd72f2eea2abe46f2a4647c114ab86b85', '王', '先生', '7894@496', '789521', 'CO', null, '40f6cdea0bd34aceb77492a1656d9fb3', '2021-08-22 15:43:04', null, null, '', '', '2021-08-03', ''), ('aeaa511fda344d5f861cf0828e4e0062', '06f5fc056eac41558a964f96daa7f27c', 'web下载', 'e1e73e109d264a5f848ee95698d72ce5', '马化腾', '先生', '156789@123', '1567', 'CEO', null, '40f6cdea0bd34aceb77492a1656d9fb3', '2021-08-22 15:35:35', null, null, 'sn', 'fsfsfdd', '2021-08-13', '深圳'), ('fe707cbfa0fb44b5ae9a13c2bed66cf4', '06f5fc056eac41558a964f96daa7f27c', 'web下载', '2f86796e5e904bcc9c221359b6e3a914', '马云', '先生', '15978@159', '1598', 'CEO', null, '40f6cdea0bd34aceb77492a1656d9fb3', '2021-08-22 15:35:55', null, null, 'fake news', 'no', '2021-08-25', '杭州');
INSERT INTO `tbl_contacts_activity_relation` VALUES ('29542686fba74399be029035e9753b62', 'aeaa511fda344d5f861cf0828e4e0062', 'bb7db0de07484a50a03ed6071c3430df'), ('39cf8663f7a24832b3547c663918861d', '6369569ed4db44c2be348428ec5f122e', '1acaf1c1c29b4718afa157ca91ea2900'), ('42db818ea22f45778e536b057bde7db5', '90ba5a65b37d46dbac3a5211d5958d94', 'c074185986764470baff7dcacd3970bb'), ('6a61492264834e0ba81b3db814e94b64', 'fe707cbfa0fb44b5ae9a13c2bed66cf4', 'b086787e6c72456d8a3d67504fc36831');
INSERT INTO `tbl_contacts_remark` VALUES ('703507fc99fd4580bf784a0212efd6bc', '属于阿里123456', '张三', '2021-08-22 15:35:25', null, null, '0', null), ('a3ff30b5243947e5851b2a8ecfbe8920', '属于腾讯123', '张三', '2021-08-22 15:35:25', null, null, '0', null), ('b6bc514f96584d99bdcbbcf09fca4798', '属于万达', '张三', '2021-08-22 15:43:01', null, null, '0', null), ('f9fa8a7d2eb04c3ca9d8cb2cd29c170d', '属于格力', '张三', '2021-08-22 15:45:01', null, null, '0', null);
INSERT INTO `tbl_customer` VALUES ('058732f8b86b44f9abfa93af16e4086f', '06f5fc056eac41558a964f96daa7f27c', '格力', 'www.geli.com', '74561', '40f6cdea0bd34aceb77492a1656d9fb3', '2021-08-22 15:45:12', null, null, '', '2021-08-25', '', ''), ('2f86796e5e904bcc9c221359b6e3a914', '06f5fc056eac41558a964f96daa7f27c', '阿里123', 'www.ali.com', '159', '40f6cdea0bd34aceb77492a1656d9fb3', '2021-08-22 15:35:55', null, null, 'no', '2021-08-25', 'fake news', '杭州'), ('d72f2eea2abe46f2a4647c114ab86b85', '06f5fc056eac41558a964f96daa7f27c', '万达123', 'www.wanda.com', '15674', '40f6cdea0bd34aceb77492a1656d9fb3', '2021-08-22 15:43:04', null, null, '', '2021-08-03', '', ''), ('e1e73e109d264a5f848ee95698d72ce5', '06f5fc056eac41558a964f96daa7f27c', '腾讯123', 'www.tencent.com', '1566', '40f6cdea0bd34aceb77492a1656d9fb3', '2021-08-22 15:35:35', null, null, 'fsfsfdd', '2021-08-13', 'sn', '深圳');
INSERT INTO `tbl_customer_remark` VALUES ('703507fc99fd4580bf784a0212efd6bc', '属于阿里123456', '张三', '2021-08-22 15:35:25', null, null, '0', null), ('a3ff30b5243947e5851b2a8ecfbe8920', '属于腾讯123', '张三', '2021-08-22 15:35:25', null, null, '0', null), ('b6bc514f96584d99bdcbbcf09fca4798', '属于万达', '张三', '2021-08-22 15:43:01', null, null, '0', null), ('f9fa8a7d2eb04c3ca9d8cb2cd29c170d', '属于格力', '张三', '2021-08-22 15:45:01', null, null, '0', null);
INSERT INTO `tbl_dic_type` VALUES ('appellation', '称呼', ''), ('clueState', '线索状态', ''), ('returnPriority', '回访优先级', ''), ('returnState', '回访状态', ''), ('source', '来源', ''), ('stage', '阶段', ''), ('transactionType', '交易类型', '');
INSERT INTO `tbl_dic_value` VALUES ('06e3cbdf10a44eca8511dddfc6896c55', '虚假线索', '虚假线索', '4', 'clueState'), ('0fe33840c6d84bf78df55d49b169a894', '销售邮件', '销售邮件', '8', 'source'), ('12302fd42bd349c1bb768b19600e6b20', '交易会', '交易会', '11', 'source'), ('1615f0bb3e604552a86cde9a2ad45bea', '最高', '最高', '2', 'returnPriority'), ('176039d2a90e4b1a81c5ab8707268636', '教授', '教授', '5', 'appellation'), ('1e0bd307e6ee425599327447f8387285', '将来联系', '将来联系', '2', 'clueState'), ('2173663b40b949ce928db92607b5fe57', '丢失线索', '丢失线索', '5', 'clueState'), ('2876690b7e744333b7f1867102f91153', '未启动', '未启动', '1', 'returnState'), ('29805c804dd94974b568cfc9017b2e4c', '07成交', '07成交', '7', 'stage'), ('31539e7ed8c848fc913e1c2c93d76fd1', '博士', '博士', '4', 'appellation'), ('37ef211719134b009e10b7108194cf46', '01资质审查', '01资质审查', '1', 'stage'), ('37ef211719134b009e10b7108194cf47', '试图联系', '试图联系', '1', 'clueState'), ('391807b5324d4f16bd58c882750ee632', '08丢失的线索', '08丢失的线索', '8', 'stage'), ('3a39605d67da48f2a3ef52e19d243953', '聊天', '聊天', '14', 'source'), ('474ab93e2e114816abf3ffc596b19131', '低', '低', '3', 'returnPriority'), ('48512bfed26145d4a38d3616e2d2cf79', '广告', '广告', '1', 'source'), ('4d03a42898684135809d380597ed3268', '合作伙伴研讨会', '合作伙伴研讨会', '9', 'source'), ('59795c49896947e1ab61b7312bd0597c', '先生', '先生', '1', 'appellation'), ('5c6e9e10ca414bd499c07b886f86202a', '高', '高', '1', 'returnPriority'), ('67165c27076e4c8599f42de57850e39c', '夫人', '夫人', '2', 'appellation'), ('68a1b1e814d5497a999b8f1298ace62b', '09因竞争丢失关闭', '09因竞争丢失关闭', '9', 'stage'), ('6b86f215e69f4dbd8a2daa22efccf0cf', 'web调研', 'web调研', '13', 'source'), ('72f13af8f5d34134b5b3f42c5d477510', '合作伙伴', '合作伙伴', '6', 'source'), ('7c07db3146794c60bf975749952176df', '未联系', '未联系', '6', 'clueState'), ('86c56aca9eef49058145ec20d5466c17', '内部研讨会', '内部研讨会', '10', 'source'), ('9095bda1f9c34f098d5b92fb870eba17', '进行中', '进行中', '3', 'returnState'), ('954b410341e7433faa468d3c4f7cf0d2', '已有业务', '已有业务', '1', 'transactionType'), ('966170ead6fa481284b7d21f90364984', '已联系', '已联系', '3', 'clueState'), ('96b03f65dec748caa3f0b6284b19ef2f', '推迟', '推迟', '2', 'returnState'), ('97d1128f70294f0aac49e996ced28c8a', '新业务', '新业务', '2', 'transactionType'), ('9ca96290352c40688de6596596565c12', '完成', '完成', '4', 'returnState'), ('9e6d6e15232549af853e22e703f3e015', '需要条件', '需要条件', '7', 'clueState'), ('9ff57750fac04f15b10ce1bbb5bb8bab', '02需求分析', '02需求分析', '2', 'stage'), ('a70dc4b4523040c696f4421462be8b2f', '等待某人', '等待某人', '5', 'returnState'), ('a83e75ced129421dbf11fab1f05cf8b4', '推销电话', '推销电话', '2', 'source'), ('ab8472aab5de4ae9b388b2f1409441c1', '常规', '常规', '5', 'returnPriority'), ('ab8c2a3dc05f4e3dbc7a0405f721b040', '05提案/报价', '05提案/报价', '5', 'stage'), ('b924d911426f4bc5ae3876038bc7e0ad', 'web下载', 'web下载', '12', 'source'), ('c13ad8f9e2f74d5aa84697bb243be3bb', '03价值建议', '03价值建议', '3', 'stage'), ('c83c0be184bc40708fd7b361b6f36345', '最低', '最低', '4', 'returnPriority'), ('db867ea866bc44678ac20c8a4a8bfefb', '员工介绍', '员工介绍', '3', 'source'), ('e44be1d99158476e8e44778ed36f4355', '04确定决策者', '04确定决策者', '4', 'stage'), ('e5f383d2622b4fc0959f4fe131dafc80', '女士', '女士', '3', 'appellation'), ('e81577d9458f4e4192a44650a3a3692b', '06谈判/复审', '06谈判/复审', '6', 'stage'), ('fb65d7fdb9c6483db02713e6bc05dd19', '在线商场', '在线商场', '5', 'source'), ('fd677cc3b5d047d994e16f6ece4d3d45', '公开媒介', '公开媒介', '7', 'source'), ('ff802a03ccea4ded8731427055681d48', '外部介绍', '外部介绍', '4', 'source');
INSERT INTO `tbl_tran` VALUES ('15beae00ebb04060ab0fe3fd9fbfc11d', '40f6cdea0bd34aceb77492a1656d9fb3', '77777', '测试2', '2021-08-26', 'd72f2eea2abe46f2a4647c114ab86b85', '04确定决策者', '新业务', '公开媒介', 'b086787e6c72456d8a3d67504fc36831', 'fe707cbfa0fb44b5ae9a13c2bed66cf4', '40f6cdea0bd34aceb77492a1656d9fb3', '2021-08-22 17:04:45', null, null, '万达测试', '就将计就计', '2021-09-28'), ('be2292692f1c42c5b59c7ee056be203d', '40f6cdea0bd34aceb77492a1656d9fb3', '745684', '测试', '2021-08-24', '2f86796e5e904bcc9c221359b6e3a914', '08丢失的线索', '新业务', '合作伙伴', 'b086787e6c72456d8a3d67504fc36831', 'fe707cbfa0fb44b5ae9a13c2bed66cf4', '40f6cdea0bd34aceb77492a1656d9fb3', '2021-08-22 17:01:05', '40f6cdea0bd34aceb77492a1656d9fb3', '2021-08-24 10:29:24', '交易测试', '文件夹', '2021-08-22');
INSERT INTO `tbl_tran_history` VALUES ('04ecbbe7a3bb4b61a6745bfb3f74f08f', '04确定决策者', '77777', '2021-08-26', '2021-08-22 17:04:45', '40f6cdea0bd34aceb77492a1656d9fb3', '15beae00ebb04060ab0fe3fd9fbfc11d'), ('053c1f239faa416aa43511e4d66b19a6', '06谈判/复审', '745684', '2021-08-24', '2021-08-23 21:58:21', '40f6cdea0bd34aceb77492a1656d9fb3', 'be2292692f1c42c5b59c7ee056be203d'), ('117ddbfab0f040d9b0549aee2d61ce4d', '05提案/报价', '745684', '2021-08-24', '2021-08-23 21:34:16', '40f6cdea0bd34aceb77492a1656d9fb3', 'be2292692f1c42c5b59c7ee056be203d'), ('11afa0b1b5304ce99c56e12fceaf1a2e', '03价值建议', '745684', '2021-08-24', '2021-08-23 21:32:41', '40f6cdea0bd34aceb77492a1656d9fb3', 'be2292692f1c42c5b59c7ee056be203d'), ('14e486ba247f42ca92774d1005328619', '05提案/报价', '745684', '2021-08-24', '2021-08-23 21:52:27', '40f6cdea0bd34aceb77492a1656d9fb3', 'be2292692f1c42c5b59c7ee056be203d'), ('1bfd1847c8874617ba93b0f7564ce3ec', '06谈判/复审', '745684', '2021-08-24', '2021-08-23 21:26:42', '40f6cdea0bd34aceb77492a1656d9fb3', 'be2292692f1c42c5b59c7ee056be203d'), ('1c1010507826456d98a3ff90e30e43fa', '06谈判/复审', '745684', '2021-08-24', '2021-08-24 10:27:41', '40f6cdea0bd34aceb77492a1656d9fb3', 'be2292692f1c42c5b59c7ee056be203d'), ('1d0331f88b054977a6af05182d026b77', '07成交', '745684', '2021-08-24', '2021-08-23 21:34:14', '40f6cdea0bd34aceb77492a1656d9fb3', 'be2292692f1c42c5b59c7ee056be203d'), ('1e5183c878bc451a9d5ced2a71b1dcb2', '01资质审查', '745684', '2021-08-24', '2021-08-23 21:32:44', '40f6cdea0bd34aceb77492a1656d9fb3', 'be2292692f1c42c5b59c7ee056be203d'), ('201defd03f464ba6a974558591f0b057', '02需求分析', '745684', '2021-08-24', '2021-08-23 21:28:26', '40f6cdea0bd34aceb77492a1656d9fb3', 'be2292692f1c42c5b59c7ee056be203d'), ('20f175dae96b484da88608ae82e9c605', '05提案/报价', '745684', '2021-08-24', '2021-08-23 21:52:37', '40f6cdea0bd34aceb77492a1656d9fb3', 'be2292692f1c42c5b59c7ee056be203d'), ('283d4af1b65f40459f28033422eae8bf', '02需求分析', '745684', '2021-08-24', '2021-08-23 21:27:06', '40f6cdea0bd34aceb77492a1656d9fb3', 'be2292692f1c42c5b59c7ee056be203d'), ('496a791f83b84bd48ed8ffacd4058c58', '04确定决策者', '745684', '2021-08-24', '2021-08-23 21:28:28', '40f6cdea0bd34aceb77492a1656d9fb3', 'be2292692f1c42c5b59c7ee056be203d'), ('4c5fd27032864b62868cd9d5fbf67309', '05提案/报价', '745684', '2021-08-24', '2021-08-23 21:32:33', '40f6cdea0bd34aceb77492a1656d9fb3', 'be2292692f1c42c5b59c7ee056be203d'), ('53814cef15dd44968ab33ed043db1c80', '02需求分析', '745684', '2021-08-24', '2021-08-23 21:33:51', '40f6cdea0bd34aceb77492a1656d9fb3', 'be2292692f1c42c5b59c7ee056be203d'), ('57f9418d14e84a1c8f30870384153e36', '04确定决策者', '745684', '2021-08-24', '2021-08-23 21:28:25', '40f6cdea0bd34aceb77492a1656d9fb3', 'be2292692f1c42c5b59c7ee056be203d'), ('6a31f70283164ed4bcbcb04028d0b4f8', '07成交', '745684', '2021-08-24', '2021-08-23 21:26:44', '40f6cdea0bd34aceb77492a1656d9fb3', 'be2292692f1c42c5b59c7ee056be203d'), ('6f5a5fd1b60e42c086ffede6417a05d8', '06谈判/复审', '745684', '2021-08-24', '2021-08-23 21:28:31', '40f6cdea0bd34aceb77492a1656d9fb3', 'be2292692f1c42c5b59c7ee056be203d'), ('7356bf36df324529a761671563e85928', '05提案/报价', '745684', '2021-08-24', '2021-08-23 21:25:29', '40f6cdea0bd34aceb77492a1656d9fb3', 'be2292692f1c42c5b59c7ee056be203d'), ('92ba31e84f0e4462a6189c43b3105311', '05提案/报价', '745684', '2021-08-24', '2021-08-23 21:28:29', '40f6cdea0bd34aceb77492a1656d9fb3', 'be2292692f1c42c5b59c7ee056be203d'), ('92c22d5af988447c83c59778f5e207d1', '04确定决策者', '745684', '2021-08-24', '2021-08-23 21:26:48', '40f6cdea0bd34aceb77492a1656d9fb3', 'be2292692f1c42c5b59c7ee056be203d'), ('9b3fbc6042f743319d50684d8f1d0593', '04确定决策者', '745684', '2021-08-24', '2021-08-23 21:33:50', '40f6cdea0bd34aceb77492a1656d9fb3', 'be2292692f1c42c5b59c7ee056be203d'), ('a4241ef76b7c4aec8d1930db55a851e7', '08丢失的线索', '745684', '2021-08-24', '2021-08-24 10:27:38', '40f6cdea0bd34aceb77492a1656d9fb3', 'be2292692f1c42c5b59c7ee056be203d'), ('aadba7f2901f435b8313d91156e88929', '06谈判/复审', '745684', '2021-08-24', '2021-08-23 21:34:15', '40f6cdea0bd34aceb77492a1656d9fb3', 'be2292692f1c42c5b59c7ee056be203d'), ('aae72f6ebde54e018ceb9f4e4dae1cca', '03价值建议', '745684', '2021-08-24', '2021-08-23 21:28:11', '40f6cdea0bd34aceb77492a1656d9fb3', 'be2292692f1c42c5b59c7ee056be203d'), ('ab36dcf38d154950a487474fd09f28da', '08丢失的线索', '745684', '2021-08-24', '2021-08-23 21:34:09', '40f6cdea0bd34aceb77492a1656d9fb3', 'be2292692f1c42c5b59c7ee056be203d'), ('ad12d1698002438d8d24293c803db602', '05提案/报价', '745684', '2021-08-24', '2021-08-22 17:01:05', '40f6cdea0bd34aceb77492a1656d9fb3', 'be2292692f1c42c5b59c7ee056be203d'), ('ad6ed8a1e17e49fab7c6dd3431bf8b90', '05提案/报价', '745684', '2021-08-24', '2021-08-23 21:34:08', '40f6cdea0bd34aceb77492a1656d9fb3', 'be2292692f1c42c5b59c7ee056be203d'), ('c053d2e0548c44d495c341043407ba5b', '02需求分析', '745684', '2021-08-24', '2021-08-23 21:32:42', '40f6cdea0bd34aceb77492a1656d9fb3', 'be2292692f1c42c5b59c7ee056be203d'), ('c314aeea72e94dc49a906e3e28a6a577', '09因竞争丢失关闭', '745684', '2021-08-24', '2021-08-23 21:34:11', '40f6cdea0bd34aceb77492a1656d9fb3', 'be2292692f1c42c5b59c7ee056be203d'), ('c62e8197f3284c7184b8141d05a8d2ba', '04确定决策者', '745684', '2021-08-24', '2021-08-23 21:34:07', '40f6cdea0bd34aceb77492a1656d9fb3', 'be2292692f1c42c5b59c7ee056be203d'), ('c7e9beff81134050a639e7063a6359c3', '01资质审查', '745684', '2021-08-24', '2021-08-23 21:28:27', '40f6cdea0bd34aceb77492a1656d9fb3', 'be2292692f1c42c5b59c7ee056be203d'), ('d3e46eec602a4ddb94a34c1164fb5c66', '01资质审查', '745684', '2021-08-24', '2021-08-23 21:27:00', '40f6cdea0bd34aceb77492a1656d9fb3', 'be2292692f1c42c5b59c7ee056be203d'), ('e23e884a447c491f840841cd50f9fd3c', '03价值建议', '745684', '2021-08-24', '2021-08-23 21:34:05', '40f6cdea0bd34aceb77492a1656d9fb3', 'be2292692f1c42c5b59c7ee056be203d'), ('ed424427caac4b3da92c801850202e9f', '09因竞争丢失关闭', '745684', '2021-08-24', '2021-08-24 10:27:39', '40f6cdea0bd34aceb77492a1656d9fb3', 'be2292692f1c42c5b59c7ee056be203d'), ('ed9eb2fd678c42289e34e1812a528a88', '07成交', '745684', '2021-08-24', '2021-08-23 21:32:46', '40f6cdea0bd34aceb77492a1656d9fb3', 'be2292692f1c42c5b59c7ee056be203d'), ('eebe044990a244e099a20b307d244778', '08丢失的线索', '745684', '2021-08-24', '2021-08-24 10:29:24', '40f6cdea0bd34aceb77492a1656d9fb3', 'be2292692f1c42c5b59c7ee056be203d'), ('f4e14d1d18c2469e90c702cc6af4052a', '04确定决策者', '745684', '2021-08-24', '2021-08-23 21:48:03', '40f6cdea0bd34aceb77492a1656d9fb3', 'be2292692f1c42c5b59c7ee056be203d'), ('f5fb8129a8254239b37e6a41d034bdb3', '05提案/报价', '745684', '2021-08-24', '2021-08-23 21:26:47', '40f6cdea0bd34aceb77492a1656d9fb3', 'be2292692f1c42c5b59c7ee056be203d'), ('fc09970a54e747ba971ca21b911cf7b8', '03价值建议', '745684', '2021-08-24', '2021-08-23 21:26:50', '40f6cdea0bd34aceb77492a1656d9fb3', 'be2292692f1c42c5b59c7ee056be203d');
INSERT INTO `tbl_user` VALUES ('06f5fc056eac41558a964f96daa7f27c', 'ls', '李四', '202cb962ac59075b964b07152d234b70', 'ls@163.com', '2018-11-27 21:50:05', '1', 'A001', '192.168.1.1', '2018-11-22 12:11:40', '李四', null, null), ('40f6cdea0bd34aceb77492a1656d9fb3', 'zs', '张三', '202cb962ac59075b964b07152d234b70', 'zs@qq.com', '2022-11-30 23:50:55', '1', 'A001', '192.168.1.1,192.168.1.2,127.0.0.1', '2018-11-22 11:37:34', '张三', null, null);
