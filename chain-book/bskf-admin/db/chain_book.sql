/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : chain_book

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2023-02-28 23:08:55
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `BLOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `SCHED_NAME` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `CALENDAR_NAME` varchar(200) NOT NULL,
  `CALENDAR` blob NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`CALENDAR_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `CRON_EXPRESSION` varchar(120) NOT NULL,
  `TIME_ZONE_ID` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------
INSERT INTO `qrtz_cron_triggers` VALUES ('bskfScheduler', 'TASK_1', 'DEFAULT', '0 0/30 * * * ?', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('bskfScheduler', 'TASK_2', 'DEFAULT', '0 0/30 * * * ?', 'Asia/Shanghai');

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `ENTRY_ID` varchar(95) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `FIRED_TIME` bigint(13) NOT NULL,
  `SCHED_TIME` bigint(13) NOT NULL,
  `PRIORITY` int(11) NOT NULL,
  `STATE` varchar(16) NOT NULL,
  `JOB_NAME` varchar(200) DEFAULT NULL,
  `JOB_GROUP` varchar(200) DEFAULT NULL,
  `IS_NONCONCURRENT` varchar(1) DEFAULT NULL,
  `REQUESTS_RECOVERY` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`ENTRY_ID`),
  KEY `IDX_QRTZ_FT_TRIG_INST_NAME` (`SCHED_NAME`,`INSTANCE_NAME`),
  KEY `IDX_QRTZ_FT_INST_JOB_REQ_RCVRY` (`SCHED_NAME`,`INSTANCE_NAME`,`REQUESTS_RECOVERY`),
  KEY `IDX_QRTZ_FT_J_G` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_FT_JG` (`SCHED_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_FT_T_G` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `IDX_QRTZ_FT_TG` (`SCHED_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `JOB_CLASS_NAME` varchar(250) NOT NULL,
  `IS_DURABLE` varchar(1) NOT NULL,
  `IS_NONCONCURRENT` varchar(1) NOT NULL,
  `IS_UPDATE_DATA` varchar(1) NOT NULL,
  `REQUESTS_RECOVERY` varchar(1) NOT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_J_REQ_RECOVERY` (`SCHED_NAME`,`REQUESTS_RECOVERY`),
  KEY `IDX_QRTZ_J_GRP` (`SCHED_NAME`,`JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------
INSERT INTO `qrtz_job_details` VALUES ('bskfScheduler', 'TASK_1', 'DEFAULT', null, 'com.bskf.modules.job.utils.ScheduleJob', '0', '0', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B45597372002D636F6D2E62736B662E6D6F64756C65732E6A6F622E656E746974792E5363686564756C654A6F62456E7469747900000000000000010200084C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000E63726F6E45787072657373696F6E71007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C000A6D6574686F644E616D6571007E00094C0006706172616D7371007E00094C000672656D61726B71007E00094C00067374617475737400134C6A6176612F6C616E672F496E74656765723B7870740008746573745461736B7372000E6A6176612E7574696C2E44617465686A81014B5974190300007870770800000158BAF593307874000E3020302F3330202A202A202A203F7372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000000000000017400047465737474000462736B6674000FE69C89E58F82E695B0E6B58BE8AF95737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E0013000000007800);
INSERT INTO `qrtz_job_details` VALUES ('bskfScheduler', 'TASK_2', 'DEFAULT', null, 'com.bskf.modules.job.utils.ScheduleJob', '0', '0', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B45597372002D636F6D2E62736B662E6D6F64756C65732E6A6F622E656E746974792E5363686564756C654A6F62456E7469747900000000000000010200084C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000E63726F6E45787072657373696F6E71007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C000A6D6574686F644E616D6571007E00094C0006706172616D7371007E00094C000672656D61726B71007E00094C00067374617475737400134C6A6176612F6C616E672F496E74656765723B7870740008746573745461736B7372000E6A6176612E7574696C2E44617465686A81014B5974190300007870770800000158C377C4607874000E3020302F3330202A202A202A203F7372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000000000000274000574657374327074000FE697A0E58F82E695B0E6B58BE8AF95737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E0013000000017800);

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `LOCK_NAME` varchar(40) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`LOCK_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------
INSERT INTO `qrtz_locks` VALUES ('bskfScheduler', 'STATE_ACCESS');
INSERT INTO `qrtz_locks` VALUES ('bskfScheduler', 'TRIGGER_ACCESS');

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL,
  `CHECKIN_INTERVAL` bigint(13) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`INSTANCE_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------
INSERT INTO `qrtz_scheduler_state` VALUES ('bskfScheduler', 'jstarseven1677595625290', '1677596934575', '15000');

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `REPEAT_COUNT` bigint(7) NOT NULL,
  `REPEAT_INTERVAL` bigint(12) NOT NULL,
  `TIMES_TRIGGERED` bigint(10) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `STR_PROP_1` varchar(512) DEFAULT NULL,
  `STR_PROP_2` varchar(512) DEFAULT NULL,
  `STR_PROP_3` varchar(512) DEFAULT NULL,
  `INT_PROP_1` int(11) DEFAULT NULL,
  `INT_PROP_2` int(11) DEFAULT NULL,
  `LONG_PROP_1` bigint(20) DEFAULT NULL,
  `LONG_PROP_2` bigint(20) DEFAULT NULL,
  `DEC_PROP_1` decimal(13,4) DEFAULT NULL,
  `DEC_PROP_2` decimal(13,4) DEFAULT NULL,
  `BOOL_PROP_1` varchar(1) DEFAULT NULL,
  `BOOL_PROP_2` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `NEXT_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PREV_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PRIORITY` int(11) DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) NOT NULL,
  `TRIGGER_TYPE` varchar(8) NOT NULL,
  `START_TIME` bigint(13) NOT NULL,
  `END_TIME` bigint(13) DEFAULT NULL,
  `CALENDAR_NAME` varchar(200) DEFAULT NULL,
  `MISFIRE_INSTR` smallint(2) DEFAULT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `IDX_QRTZ_T_J` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_T_JG` (`SCHED_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_T_C` (`SCHED_NAME`,`CALENDAR_NAME`),
  KEY `IDX_QRTZ_T_G` (`SCHED_NAME`,`TRIGGER_GROUP`),
  KEY `IDX_QRTZ_T_STATE` (`SCHED_NAME`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_N_STATE` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_N_G_STATE` (`SCHED_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_NEXT_FIRE_TIME` (`SCHED_NAME`,`NEXT_FIRE_TIME`),
  KEY `IDX_QRTZ_T_NFT_ST` (`SCHED_NAME`,`TRIGGER_STATE`,`NEXT_FIRE_TIME`),
  KEY `IDX_QRTZ_T_NFT_MISFIRE` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`),
  KEY `IDX_QRTZ_T_NFT_ST_MISFIRE` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_NFT_ST_MISFIRE_GRP` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `qrtz_job_details` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------
INSERT INTO `qrtz_triggers` VALUES ('bskfScheduler', 'TASK_1', 'DEFAULT', 'TASK_1', 'DEFAULT', null, '1677598200000', '1677596400000', '5', 'WAITING', 'CRON', '1554100602000', '0', null, '2', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B45597372002D636F6D2E62736B662E6D6F64756C65732E6A6F622E656E746974792E5363686564756C654A6F62456E7469747900000000000000010200084C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000E63726F6E45787072657373696F6E71007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C000A6D6574686F644E616D6571007E00094C0006706172616D7371007E00094C000672656D61726B71007E00094C00067374617475737400134C6A6176612F6C616E672F496E74656765723B7870740008746573745461736B7372000E6A6176612E7574696C2E44617465686A81014B5974190300007870770800000158BAF593307874000E3020302F3330202A202A202A203F7372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000000000000017400047465737474000462736B6674000FE69C89E58F82E695B0E6B58BE8AF95737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E0013000000007800);
INSERT INTO `qrtz_triggers` VALUES ('bskfScheduler', 'TASK_2', 'DEFAULT', 'TASK_2', 'DEFAULT', null, '1554102000000', '-1', '5', 'PAUSED', 'CRON', '1554100602000', '0', null, '2', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B45597372002D636F6D2E62736B662E6D6F64756C65732E6A6F622E656E746974792E5363686564756C654A6F62456E7469747900000000000000010200084C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000E63726F6E45787072657373696F6E71007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C000A6D6574686F644E616D6571007E00094C0006706172616D7371007E00094C000672656D61726B71007E00094C00067374617475737400134C6A6176612F6C616E672F496E74656765723B7870740008746573745461736B7372000E6A6176612E7574696C2E44617465686A81014B5974190300007870770800000158C377C4607874000E3020302F3330202A202A202A203F7372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000000000000274000574657374327074000FE697A0E58F82E695B0E6B58BE8AF95737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E0013000000017800);

-- ----------------------------
-- Table structure for schedule_job
-- ----------------------------
DROP TABLE IF EXISTS `schedule_job`;
CREATE TABLE `schedule_job` (
  `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务id',
  `bean_name` varchar(200) DEFAULT NULL COMMENT 'spring bean名称',
  `method_name` varchar(100) DEFAULT NULL COMMENT '方法名',
  `params` varchar(2000) DEFAULT NULL COMMENT '参数',
  `cron_expression` varchar(100) DEFAULT NULL COMMENT 'cron表达式',
  `status` tinyint(4) DEFAULT NULL COMMENT '任务状态  0：正常  1：暂停',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='定时任务';

-- ----------------------------
-- Records of schedule_job
-- ----------------------------
INSERT INTO `schedule_job` VALUES ('1', 'testTask', 'test', 'bskf', '0 0/30 * * * ?', '0', '有参数测试', '2016-12-01 23:16:46');
INSERT INTO `schedule_job` VALUES ('2', 'testTask', 'test2', null, '0 0/30 * * * ?', '1', '无参数测试', '2016-12-03 14:55:56');

-- ----------------------------
-- Table structure for schedule_job_log
-- ----------------------------
DROP TABLE IF EXISTS `schedule_job_log`;
CREATE TABLE `schedule_job_log` (
  `log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志id',
  `job_id` bigint(20) NOT NULL COMMENT '任务id',
  `bean_name` varchar(200) DEFAULT NULL COMMENT 'spring bean名称',
  `method_name` varchar(100) DEFAULT NULL COMMENT '方法名',
  `params` varchar(2000) DEFAULT NULL COMMENT '参数',
  `status` tinyint(4) NOT NULL COMMENT '任务状态    0：成功    1：失败',
  `error` varchar(2000) DEFAULT NULL COMMENT '失败信息',
  `times` int(11) NOT NULL COMMENT '耗时(单位：毫秒)',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`log_id`),
  KEY `job_id` (`job_id`)
) ENGINE=InnoDB AUTO_INCREMENT=272 DEFAULT CHARSET=utf8 COMMENT='定时任务日志';

-- ----------------------------
-- Records of schedule_job_log
-- ----------------------------
INSERT INTO `schedule_job_log` VALUES ('1', '1', 'testTask', 'test', 'bskf', '0', null, '1045', '2019-04-01 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('2', '1', 'testTask', 'test', 'bskf', '0', null, '1014', '2019-04-01 15:30:00');
INSERT INTO `schedule_job_log` VALUES ('247', '1', 'testTask', 'test', 'bskf', '0', null, '1024', '2021-03-03 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('248', '1', 'testTask', 'test', 'bskf', '0', null, '1035', '2021-03-03 15:30:00');
INSERT INTO `schedule_job_log` VALUES ('249', '1', 'testTask', 'test', 'bskf', '0', null, '1009', '2021-03-03 16:00:00');
INSERT INTO `schedule_job_log` VALUES ('250', '1', 'testTask', 'test', 'bskf', '0', null, '3615', '2021-03-03 16:30:01');
INSERT INTO `schedule_job_log` VALUES ('251', '1', 'testTask', 'test', 'bskf', '0', null, '1033', '2021-03-04 09:00:00');
INSERT INTO `schedule_job_log` VALUES ('252', '1', 'testTask', 'test', 'bskf', '0', null, '1020', '2021-03-04 09:30:00');
INSERT INTO `schedule_job_log` VALUES ('253', '1', 'testTask', 'test', 'bskf', '0', null, '1017', '2021-03-04 10:00:00');
INSERT INTO `schedule_job_log` VALUES ('254', '1', 'testTask', 'test', 'bskf', '0', null, '1032', '2021-03-04 11:00:00');
INSERT INTO `schedule_job_log` VALUES ('255', '1', 'testTask', 'test', 'bskf', '0', null, '1613', '2021-03-04 11:30:01');
INSERT INTO `schedule_job_log` VALUES ('256', '1', 'testTask', 'test', 'bskf', '0', null, '1019', '2021-03-04 12:00:00');
INSERT INTO `schedule_job_log` VALUES ('257', '1', 'testTask', 'test', 'bskf', '0', null, '1028', '2021-03-04 12:30:00');
INSERT INTO `schedule_job_log` VALUES ('258', '1', 'testTask', 'test', 'bskf', '0', null, '1028', '2021-03-04 13:00:00');
INSERT INTO `schedule_job_log` VALUES ('259', '1', 'testTask', 'test', 'bskf', '0', null, '1026', '2021-03-04 13:30:00');
INSERT INTO `schedule_job_log` VALUES ('260', '1', 'testTask', 'test', 'bskf', '0', null, '1037', '2021-03-04 14:00:00');
INSERT INTO `schedule_job_log` VALUES ('261', '1', 'testTask', 'test', 'bskf', '0', null, '1817', '2021-03-04 14:30:01');
INSERT INTO `schedule_job_log` VALUES ('262', '1', 'testTask', 'test', 'bskf', '0', null, '1050', '2021-03-04 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('263', '1', 'testTask', 'test', 'bskf', '0', null, '1004', '2021-03-04 15:30:00');
INSERT INTO `schedule_job_log` VALUES ('264', '1', 'testTask', 'test', 'bskf', '0', null, '1037', '2021-03-04 16:00:00');
INSERT INTO `schedule_job_log` VALUES ('265', '1', 'testTask', 'test', 'bskf', '0', null, '1397', '2021-03-04 16:30:01');
INSERT INTO `schedule_job_log` VALUES ('266', '1', 'testTask', 'test', 'bskf', '0', null, '1106', '2021-03-04 17:00:00');
INSERT INTO `schedule_job_log` VALUES ('267', '1', 'testTask', 'test', 'bskf', '0', null, '1063', '2021-03-04 22:00:00');
INSERT INTO `schedule_job_log` VALUES ('268', '1', 'testTask', 'test', 'bskf', '0', null, '1069', '2021-03-17 18:30:00');
INSERT INTO `schedule_job_log` VALUES ('269', '1', 'testTask', 'test', 'bskf', '0', null, '1032', '2021-03-17 20:30:00');
INSERT INTO `schedule_job_log` VALUES ('270', '1', 'testTask', 'test', 'bskf', '0', null, '1025', '2023-02-26 23:00:00');
INSERT INTO `schedule_job_log` VALUES ('271', '1', 'testTask', 'test', 'bskf', '0', null, '1037', '2023-02-28 23:00:00');

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `param_key` varchar(50) DEFAULT NULL COMMENT 'key',
  `param_value` varchar(2000) DEFAULT NULL COMMENT 'value',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态   0：隐藏   1：显示',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `param_key` (`param_key`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='系统配置信息表';

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES ('1', 'CLOUD_STORAGE_CONFIG_KEY', '{\"aliyunAccessKeyId\":\"\",\"aliyunAccessKeySecret\":\"\",\"aliyunBucketName\":\"\",\"aliyunDomain\":\"\",\"aliyunEndPoint\":\"\",\"aliyunPrefix\":\"\",\"qcloudBucketName\":\"\",\"qcloudDomain\":\"\",\"qcloudPrefix\":\"\",\"qcloudSecretId\":\"\",\"qcloudSecretKey\":\"\",\"qiniuAccessKey\":\"NrgMfABZxWLo5B-YYSjoE8-AZ1EISdi1Z3ubLOeZ\",\"qiniuBucketName\":\"ios-app\",\"qiniuDomain\":\"http://7xqbwh.dl1.z0.glb.clouddn.com\",\"qiniuPrefix\":\"upload\",\"qiniuSecretKey\":\"uIwJHevMRWU0VLxFvgy0tAcOdGqasdtVlJkdy6vV\",\"type\":1}', '0', '云存储配置信息');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept` (
  `dept_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) DEFAULT NULL COMMENT '上级部门ID，一级部门为0',
  `name` varchar(50) DEFAULT NULL COMMENT '部门名称',
  `order_num` int(11) DEFAULT NULL COMMENT '排序',
  `del_flag` tinyint(4) DEFAULT '0' COMMENT '是否删除  -1：已删除  0：正常',
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='部门管理';

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES ('1', '0', '区块链图书馆', '0', '0');
INSERT INTO `sys_dept` VALUES ('2', '1', '长沙分公司', '1', '0');
INSERT INTO `sys_dept` VALUES ('3', '1', '上海分公司', '2', '0');
INSERT INTO `sys_dept` VALUES ('4', '3', '技术部', '0', '0');
INSERT INTO `sys_dept` VALUES ('5', '3', '销售部', '1', '0');

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL COMMENT '字典名称',
  `type` varchar(100) NOT NULL COMMENT '字典类型',
  `code` varchar(100) NOT NULL COMMENT '字典码',
  `value` varchar(1000) NOT NULL COMMENT '字典值',
  `order_num` int(11) DEFAULT '0' COMMENT '排序',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `del_flag` tinyint(4) DEFAULT '0' COMMENT '删除标记  -1：已删除  0：正常',
  PRIMARY KEY (`id`),
  UNIQUE KEY `type` (`type`,`code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='数据字典表';

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict` VALUES ('1', '性别', 'sex', '0', '女', '0', null, '0');
INSERT INTO `sys_dict` VALUES ('2', '性别', 'sex', '1', '男', '1', null, '0');
INSERT INTO `sys_dict` VALUES ('3', '性别', 'sex', '2', '未知', '3', null, '0');

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL COMMENT '用户名',
  `operation` varchar(50) DEFAULT NULL COMMENT '用户操作',
  `method` varchar(200) DEFAULT NULL COMMENT '请求方法',
  `params` varchar(5000) DEFAULT NULL COMMENT '请求参数',
  `time` bigint(20) NOT NULL COMMENT '执行时长(毫秒)',
  `ip` varchar(64) DEFAULT NULL COMMENT 'IP地址',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=271 DEFAULT CHARSET=utf8 COMMENT='系统日志';

-- ----------------------------
-- Records of sys_log
-- ----------------------------
INSERT INTO `sys_log` VALUES ('1', 'admin', '保存菜单', 'com.bskf.modules.sys.controller.SysMenuController.save()', '{\"menuId\":41,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"农业管理\",\"type\":0,\"orderNum\":0}', '125', '127.0.0.1', '2023-02-26 00:00:00');
INSERT INTO `sys_log` VALUES ('2', 'admin', '修改菜单', 'com.bskf.modules.sys.controller.SysMenuController.update()', '{\"menuId\":41,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"农业管理\",\"type\":0,\"icon\":\"fa fa-cog\",\"orderNum\":0}', '102', '127.0.0.1', '2023-02-26 00:00:00');
INSERT INTO `sys_log` VALUES ('233', 'admin', '修改菜单', 'com.bskf.modules.sys.controller.SysMenuController.update()', '{\"menuId\":66,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"借阅书籍管理\",\"url\":\"modules/cases/wz_list.html\",\"type\":1,\"icon\":\"fa fa-cog\",\"orderNum\":1}', '240', '127.0.0.1', '2023-02-26 00:00:00');
INSERT INTO `sys_log` VALUES ('234', 'admin', '修改菜单', 'com.bskf.modules.sys.controller.SysMenuController.update()', '{\"menuId\":67,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"聚类图书推荐\",\"url\":\"modules/cases/wz_list.html?type\\u003dtj\",\"type\":1,\"icon\":\"fa fa-cog\",\"orderNum\":2}', '54', '127.0.0.1', '2023-02-26 00:00:00');
INSERT INTO `sys_log` VALUES ('235', 'admin', '修改菜单', 'com.bskf.modules.sys.controller.SysMenuController.update()', '{\"menuId\":68,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"冷门图书排行\",\"url\":\"modules/cases/wz_list.html?type\\u003dlm\",\"type\":1,\"icon\":\"fa fa-cog\",\"orderNum\":3}', '50', '127.0.0.1', '2023-02-26 00:00:00');
INSERT INTO `sys_log` VALUES ('236', 'admin', '修改菜单', 'com.bskf.modules.sys.controller.SysMenuController.update()', '{\"menuId\":83,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"热门图书排行\",\"url\":\"modules/cases/wz_list.html?type\\u003drm\",\"type\":1,\"icon\":\"fa fa-cog\",\"orderNum\":4}', '63', '127.0.0.1', '2023-02-26 00:00:00');
INSERT INTO `sys_log` VALUES ('237', 'admin', '修改菜单', 'com.bskf.modules.sys.controller.SysMenuController.update()', '{\"menuId\":69,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"我的借阅\",\"url\":\"modules/cases/my_list.html\",\"type\":1,\"icon\":\"fa fa-cog\",\"orderNum\":5}', '77', '127.0.0.1', '2023-02-26 00:00:00');
INSERT INTO `sys_log` VALUES ('238', 'admin', '修改菜单', 'com.bskf.modules.sys.controller.SysMenuController.update()', '{\"menuId\":41,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"论文来源统计\",\"url\":\"modules/cases/show.html\",\"perms\":\"\",\"type\":1,\"icon\":\"fa fa-cog\",\"orderNum\":0}', '52', '127.0.0.1', '2023-02-26 00:00:00');
INSERT INTO `sys_log` VALUES ('239', 'admin', '保存菜单', 'com.bskf.modules.sys.controller.SysMenuController.save()', '{\"menuId\":84,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"论文聚类图谱\",\"url\":\"modules/cases/show.html\",\"type\":1,\"icon\":\"fa fa-cog\",\"orderNum\":0}', '65', '127.0.0.1', '2023-02-26 00:00:00');
INSERT INTO `sys_log` VALUES ('240', 'admin', '修改菜单', 'com.bskf.modules.sys.controller.SysMenuController.update()', '{\"menuId\":66,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"论文文献管理\",\"url\":\"modules/cases/wz_list.html\",\"type\":1,\"icon\":\"fa fa-cog\",\"orderNum\":1}', '41', '127.0.0.1', '2023-02-26 00:00:00');
INSERT INTO `sys_log` VALUES ('241', 'admin', '修改菜单', 'com.bskf.modules.sys.controller.SysMenuController.update()', '{\"menuId\":67,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"聚类论文推荐\",\"url\":\"modules/cases/wz_list.html?type\\u003dtj\",\"type\":1,\"icon\":\"fa fa-cog\",\"orderNum\":2}', '41', '127.0.0.1', '2023-02-26 00:00:00');
INSERT INTO `sys_log` VALUES ('242', 'admin', '修改菜单', 'com.bskf.modules.sys.controller.SysMenuController.update()', '{\"menuId\":69,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"我的论文\",\"url\":\"modules/cases/my_list.html\",\"type\":1,\"icon\":\"fa fa-cog\",\"orderNum\":5}', '42', '127.0.0.1', '2023-02-26 00:00:00');
INSERT INTO `sys_log` VALUES ('243', 'admin', '删除菜单', 'com.bskf.modules.sys.controller.SysMenuController.delete()', '68', '1', '127.0.0.1', '2023-02-26 00:00:00');
INSERT INTO `sys_log` VALUES ('244', 'admin', '删除菜单', 'com.bskf.modules.sys.controller.SysMenuController.delete()', '81', '111', '127.0.0.1', '2023-02-26 00:00:00');
INSERT INTO `sys_log` VALUES ('245', 'admin', '删除菜单', 'com.bskf.modules.sys.controller.SysMenuController.delete()', '82', '54', '127.0.0.1', '2023-02-26 00:00:00');
INSERT INTO `sys_log` VALUES ('246', 'admin', '删除菜单', 'com.bskf.modules.sys.controller.SysMenuController.delete()', '68', '59', '127.0.0.1', '2023-02-26 00:00:00');
INSERT INTO `sys_log` VALUES ('247', 'admin', '修改菜单', 'com.bskf.modules.sys.controller.SysMenuController.update()', '{\"menuId\":83,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"热门论文排行\",\"url\":\"modules/cases/wz_list.html?type\\u003drm\",\"type\":1,\"icon\":\"fa fa-cog\",\"orderNum\":4}', '38', '127.0.0.1', '2023-02-26 00:00:00');
INSERT INTO `sys_log` VALUES ('248', 'admin', '修改菜单', 'com.bskf.modules.sys.controller.SysMenuController.update()', '{\"menuId\":67,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"相似论文推荐\",\"url\":\"modules/cases/wz_list.html?type\\u003dtj\",\"type\":1,\"icon\":\"fa fa-cog\",\"orderNum\":2}', '35', '127.0.0.1', '2023-02-26 00:00:00');
INSERT INTO `sys_log` VALUES ('249', 'admin', '修改菜单', 'com.bskf.modules.sys.controller.SysMenuController.update()', '{\"menuId\":41,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"论文专业统计\",\"url\":\"modules/cases/show.html\",\"perms\":\"\",\"type\":1,\"icon\":\"fa fa-cog\",\"orderNum\":0}', '57', '127.0.0.1', '2023-02-26 00:00:00');
INSERT INTO `sys_log` VALUES ('250', 'admin', '保存', 'com.bskf.modules.cases.controller.CaseController.save()', '{\"pid\":\"54694ccc627e0bd3fe0f706bcc2ad6d8\",\"name\":\"测试为第三方\",\"xx\":\"测试为第三方\",\"zz\":\"测试为第三方\",\"zy\":\"测试为第三方\",\"version\":1,\"pn\":52,\"wn\":5623,\"bsize\":16,\"paper\":\"PDF\",\"mark\":\"测试为第三方\",\"tjrq\":0,\"content\":\"测试为第三方测试为第三方测试为第三方测试为第三方\",\"ptime\":\"Mar 4, 2021 12:00:00 AM\",\"ct\":\"Mar 4, 2021 9:42:26 AM\",\"ut\":\"Mar 4, 2021 9:42:26 AM\"}', '222', '127.0.0.1', '2023-02-26 00:00:00');
INSERT INTO `sys_log` VALUES ('251', 'admin', '修改', 'com.bskf.modules.cases.controller.CaseController.update()', '{\"pid\":\"54694ccc627e0bd3fe0f706bcc2ad6d8\",\"name\":\"测试为第三方A\",\"xx\":\"测试为第三方A\",\"zz\":\"测试为第三方A\",\"zy\":\"测试为第三方A\",\"version\":1,\"pn\":52,\"wn\":5623,\"bsize\":16,\"paper\":\"PDF\",\"mark\":\"测试为第三方A\",\"tjrq\":0,\"content\":\"测试为第三方A测试为第三方A测试为第三方A测试为第三方A测试为第三方A\",\"status\":1,\"ptime\":\"Mar 4, 2021 12:00:00 AM\",\"ct\":\"Mar 4, 2021 12:00:00 AM\",\"ut\":\"Mar 4, 2021 12:00:00 AM\"}', '58', '127.0.0.1', '2023-02-26 00:00:00');
INSERT INTO `sys_log` VALUES ('252', 'admin', '删除', 'com.bskf.modules.cases.controller.CaseController.delete()', '[\"54694ccc627e0bd3fe0f706bcc2ad6d8\"]', '59', '127.0.0.1', '2023-02-26 00:00:00');
INSERT INTO `sys_log` VALUES ('253', 'admin', '修改菜单', 'com.bskf.modules.sys.controller.SysMenuController.update()', '{\"menuId\":67,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"相似论文推荐\",\"url\":\"modules/cases/xs_list.html?type\\u003dtj\",\"type\":1,\"icon\":\"fa fa-cog\",\"orderNum\":2}', '30', '127.0.0.1', '2023-02-26 00:00:00');
INSERT INTO `sys_log` VALUES ('254', 'admin', '借书', 'com.bskf.modules.cases.controller.CaseController.borrow()', '[\"0BE0707984014E66BD9F34F534FCE0F7\"]', '296', '127.0.0.1', '2023-02-26 00:00:00');
INSERT INTO `sys_log` VALUES ('255', 'admin', '借书', 'com.bskf.modules.cases.controller.CaseController.borrow()', '[\"113D0D1BB9174DD19A7DE7E2B37F677F\"]', '29', '127.0.0.1', '2023-02-26 00:00:00');
INSERT INTO `sys_log` VALUES ('256', 'admin', '借书', 'com.bskf.modules.cases.controller.CaseController.borrow()', '[\"3E1990E19989422E9DA735978CB1E4CE\"]', '107', '127.0.0.1', '2023-02-26 00:00:00');
INSERT INTO `sys_log` VALUES ('257', 'admin', '修改菜单', 'com.bskf.modules.sys.controller.SysMenuController.update()', '{\"menuId\":67,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"相似论文推荐\",\"url\":\"modules/cases/xs_list.html?type\\u003dtj\\u0026amp;wid\\u003dNOP\",\"type\":1,\"icon\":\"fa fa-cog\",\"orderNum\":2}', '111', '127.0.0.1', '2023-02-26 00:00:00');
INSERT INTO `sys_log` VALUES ('258', 'admin', '修改菜单', 'com.bskf.modules.sys.controller.SysMenuController.update()', '{\"menuId\":67,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"相似论文推荐\",\"url\":\"modules/cases/xs_list.html?type\\u003dtj\",\"type\":1,\"icon\":\"fa fa-cog\",\"orderNum\":2}', '93', '127.0.0.1', '2023-02-26 00:00:00');
INSERT INTO `sys_log` VALUES ('259', 'admin', '修改菜单', 'com.bskf.modules.sys.controller.SysMenuController.update()', '{\"menuId\":84,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"论文聚类图谱\",\"url\":\"modules/cases/map.html\",\"type\":1,\"icon\":\"fa fa-cog\",\"orderNum\":0}', '49', '127.0.0.1', '2023-02-26 00:00:00');
INSERT INTO `sys_log` VALUES ('260', 'admin', '修改菜单', 'com.bskf.modules.sys.controller.SysMenuController.update()', '{\"menuId\":41,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"书籍专业统计\",\"url\":\"modules/cases/show.html\",\"perms\":\"\",\"type\":1,\"icon\":\"fa fa-cog\",\"orderNum\":1}', '51', '127.0.0.1', '2023-02-26 00:00:00');
INSERT INTO `sys_log` VALUES ('261', 'admin', '修改菜单', 'com.bskf.modules.sys.controller.SysMenuController.update()', '{\"menuId\":84,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"书籍聚类图谱\",\"url\":\"modules/cases/map.html\",\"type\":1,\"icon\":\"fa fa-cog\",\"orderNum\":0}', '36', '127.0.0.1', '2023-02-26 00:00:00');
INSERT INTO `sys_log` VALUES ('262', 'admin', '修改菜单', 'com.bskf.modules.sys.controller.SysMenuController.update()', '{\"menuId\":66,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"书籍文献管理\",\"url\":\"modules/cases/wz_list.html\",\"type\":1,\"icon\":\"fa fa-cog\",\"orderNum\":2}', '37', '127.0.0.1', '2023-02-26 00:00:00');
INSERT INTO `sys_log` VALUES ('263', 'admin', '修改菜单', 'com.bskf.modules.sys.controller.SysMenuController.update()', '{\"menuId\":67,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"相似书籍推荐\",\"url\":\"modules/cases/xs_list.html?type\\u003dtj\",\"type\":1,\"icon\":\"fa fa-cog\",\"orderNum\":3}', '41', '127.0.0.1', '2023-02-26 00:00:00');
INSERT INTO `sys_log` VALUES ('264', 'admin', '修改菜单', 'com.bskf.modules.sys.controller.SysMenuController.update()', '{\"menuId\":83,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"热门书籍排行\",\"url\":\"modules/cases/wz_list.html?type\\u003drm\",\"type\":1,\"icon\":\"fa fa-cog\",\"orderNum\":4}', '29', '127.0.0.1', '2023-02-26 00:00:00');
INSERT INTO `sys_log` VALUES ('265', 'admin', '修改菜单', 'com.bskf.modules.sys.controller.SysMenuController.update()', '{\"menuId\":69,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"我的借阅\",\"url\":\"modules/cases/my_list.html\",\"type\":1,\"icon\":\"fa fa-cog\",\"orderNum\":5}', '45', '127.0.0.1', '2023-02-26 00:00:00');
INSERT INTO `sys_log` VALUES ('266', 'admin', '保存', 'com.bskf.modules.cases.controller.CaseController.save()', '{\"pid\":\"d8da99f82e08a2fba2d8d23cd04ea093\",\"name\":\"测试书籍\",\"xx\":\"清华大学\",\"zz\":\"张三\",\"zy\":\"计算机与科学技术\",\"version\":1,\"pn\":100,\"wn\":1630,\"bsize\":16,\"paper\":\"PDF\",\"mark\":\"测试书籍\",\"tjrq\":0,\"content\":\"测试书籍测试书籍测试书籍\",\"ptime\":\"Mar 20, 2021 12:00:00 AM\",\"ct\":\"Mar 20, 2021 9:42:53 PM\",\"ut\":\"Mar 20, 2021 9:42:53 PM\",\"tjd\":0.0}', '138', '127.0.0.1', '2023-02-26 00:00:00');
INSERT INTO `sys_log` VALUES ('267', 'admin', '修改', 'com.bskf.modules.cases.controller.CaseController.update()', '{\"pid\":\"d8da99f82e08a2fba2d8d23cd04ea093\",\"name\":\"测试书籍AAA\",\"xx\":\"清华大学\",\"zz\":\"张三\",\"zy\":\"计算机与科学技术\",\"version\":1,\"pn\":100,\"wn\":1630,\"bsize\":16,\"paper\":\"PDF\",\"mark\":\"测试书籍\",\"tjrq\":0,\"content\":\"测试书籍测试书籍测试书籍\",\"ptime\":\"Mar 20, 2021 12:00:00 AM\",\"tjd\":0.0}', '42', '127.0.0.1', '2023-02-26 00:00:00');
INSERT INTO `sys_log` VALUES ('268', 'admin', '删除', 'com.bskf.modules.cases.controller.CaseController.delete()', '[\"d8da99f82e08a2fba2d8d23cd04ea093\"]', '32', '127.0.0.1', '2023-02-26 00:00:00');
INSERT INTO `sys_log` VALUES ('269', 'admin', '删除菜单', 'com.bskf.modules.sys.controller.SysMenuController.delete()', '7', '0', '127.0.0.1', '2023-02-26 00:00:00');
INSERT INTO `sys_log` VALUES ('270', 'admin', '保存菜单', 'com.bskf.modules.sys.controller.SysMenuController.save()', '{\"menuId\":85,\"parentId\":0,\"parentName\":\"一级菜单\",\"name\":\"借阅热度分析\",\"url\":\"modules/cases/show.html?type\\u003djyrd\",\"type\":1,\"icon\":\"fa fa-cog\",\"orderNum\":0}', '56', '127.0.0.1', '2023-02-28 22:54:31');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) DEFAULT NULL COMMENT '父菜单ID，一级菜单为0',
  `name` varchar(50) DEFAULT NULL COMMENT '菜单名称',
  `url` varchar(200) DEFAULT NULL COMMENT '菜单URL',
  `perms` varchar(500) DEFAULT NULL COMMENT '授权(多个用逗号分隔，如：user:list,user:create)',
  `type` int(11) DEFAULT NULL COMMENT '类型   0：目录   1：菜单   2：按钮',
  `icon` varchar(50) DEFAULT NULL COMMENT '菜单图标',
  `order_num` int(11) DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8 COMMENT='菜单管理';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('1', '0', '系统管理', null, null, '0', 'fa fa-cog', '6');
INSERT INTO `sys_menu` VALUES ('2', '1', '用户管理', 'modules/sys/user.html', null, '1', 'fa fa-user', '1');
INSERT INTO `sys_menu` VALUES ('3', '1', '角色管理', 'modules/sys/role.html', null, '1', 'fa fa-user-secret', '2');
INSERT INTO `sys_menu` VALUES ('4', '1', '菜单管理', 'modules/sys/menu.html', null, '1', 'fa fa-th-list', '3');
INSERT INTO `sys_menu` VALUES ('5', '1', 'SQL监控', 'druid/sql.html', null, '1', 'fa fa-bug', '4');
INSERT INTO `sys_menu` VALUES ('6', '1', '定时任务', 'modules/job/schedule.html', null, '1', 'fa fa-tasks', '5');
INSERT INTO `sys_menu` VALUES ('7', '6', '查看', null, 'sys:schedule:list,sys:schedule:info', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('8', '6', '新增', null, 'sys:schedule:save', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('9', '6', '修改', null, 'sys:schedule:update', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('10', '6', '删除', null, 'sys:schedule:delete', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('11', '6', '暂停', null, 'sys:schedule:pause', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('12', '6', '恢复', null, 'sys:schedule:resume', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('13', '6', '立即执行', null, 'sys:schedule:run', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('14', '6', '日志列表', null, 'sys:schedule:log', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('15', '2', '查看', null, 'sys:user:list,sys:user:info', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('16', '2', '新增', null, 'sys:user:save,sys:role:select', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('17', '2', '修改', null, 'sys:user:update,sys:role:select', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('18', '2', '删除', null, 'sys:user:delete', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('19', '3', '查看', null, 'sys:role:list,sys:role:info', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('20', '3', '新增', null, 'sys:role:save,sys:menu:perms', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('21', '3', '修改', null, 'sys:role:update,sys:menu:perms', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('22', '3', '删除', null, 'sys:role:delete', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('23', '4', '查看', null, 'sys:menu:list,sys:menu:info', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('24', '4', '新增', null, 'sys:menu:save,sys:menu:select', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('25', '4', '修改', null, 'sys:menu:update,sys:menu:select', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('26', '4', '删除', null, 'sys:menu:delete', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('27', '1', '参数管理', 'modules/sys/config.html', 'sys:config:list,sys:config:info,sys:config:save,sys:config:update,sys:config:delete', '1', 'fa fa-sun-o', '6');
INSERT INTO `sys_menu` VALUES ('29', '1', '系统日志', 'modules/sys/log.html', 'sys:log:list', '1', 'fa fa-file-text-o', '7');
INSERT INTO `sys_menu` VALUES ('30', '1', '文件上传', 'modules/oss/oss.html', 'sys:oss:all', '1', 'fa fa-file-image-o', '6');
INSERT INTO `sys_menu` VALUES ('31', '1', '部门管理', 'modules/sys/dept.html', null, '1', 'fa fa-file-code-o', '1');
INSERT INTO `sys_menu` VALUES ('32', '31', '查看', null, 'sys:dept:list,sys:dept:info', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('33', '31', '新增', null, 'sys:dept:save,sys:dept:select', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('34', '31', '修改', null, 'sys:dept:update,sys:dept:select', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('35', '31', '删除', null, 'sys:dept:delete', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('36', '1', '字典管理', 'modules/sys/dict.html', null, '1', 'fa fa-bookmark-o', '6');
INSERT INTO `sys_menu` VALUES ('37', '36', '查看', null, 'sys:dict:list,sys:dict:info', '2', null, '6');
INSERT INTO `sys_menu` VALUES ('38', '36', '新增', null, 'sys:dict:save', '2', null, '6');
INSERT INTO `sys_menu` VALUES ('39', '36', '修改', null, 'sys:dict:update', '2', null, '6');
INSERT INTO `sys_menu` VALUES ('40', '36', '删除', null, 'sys:dict:delete', '2', null, '6');
INSERT INTO `sys_menu` VALUES ('41', '0', '书籍专业统计', 'modules/cases/show.html', '', '1', 'fa fa-cog', '1');
INSERT INTO `sys_menu` VALUES ('61', '41', '查询', null, null, '2', null, '0');
INSERT INTO `sys_menu` VALUES ('62', '41', '新增', null, null, '2', null, '0');
INSERT INTO `sys_menu` VALUES ('63', '41', '修改', null, null, '2', null, '0');
INSERT INTO `sys_menu` VALUES ('64', '41', '删除', null, null, '2', null, '0');
INSERT INTO `sys_menu` VALUES ('66', '0', '书籍文献管理', 'modules/cases/wz_list.html', null, '1', 'fa fa-cog', '2');
INSERT INTO `sys_menu` VALUES ('67', '0', '相似书籍推荐', 'modules/cases/xs_list.html?type=tj', null, '1', 'fa fa-cog', '3');
INSERT INTO `sys_menu` VALUES ('69', '0', '我的借阅', 'modules/cases/my_list.html', null, '1', 'fa fa-cog', '5');
INSERT INTO `sys_menu` VALUES ('74', '66', '借阅', null, null, '2', null, '0');
INSERT INTO `sys_menu` VALUES ('75', '66', '查询', null, null, '2', null, '0');
INSERT INTO `sys_menu` VALUES ('76', '66', '新增', null, 'data:cases:save', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('77', '66', '修改', null, 'data:cases:update', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('78', '66', '删除', null, 'data:cases:delete', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('79', '67', '查询', null, null, '2', null, '0');
INSERT INTO `sys_menu` VALUES ('80', '67', '借阅', null, null, '2', null, '0');
INSERT INTO `sys_menu` VALUES ('83', '0', '热门书籍排行', 'modules/cases/wz_list.html?type=rm', null, '1', 'fa fa-cog', '4');
INSERT INTO `sys_menu` VALUES ('84', '0', '书籍聚类图谱', 'modules/cases/map.html', null, '1', 'fa fa-cog', '0');
INSERT INTO `sys_menu` VALUES ('85', '0', '借阅热度分析', 'modules/cases/show.html?type=jyrd', null, '1', 'fa fa-cog', '0');

-- ----------------------------
-- Table structure for sys_oss
-- ----------------------------
DROP TABLE IF EXISTS `sys_oss`;
CREATE TABLE `sys_oss` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `url` varchar(200) DEFAULT NULL COMMENT 'URL地址',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文件上传';

-- ----------------------------
-- Records of sys_oss
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(100) DEFAULT NULL COMMENT '角色名称',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  `dept_id` bigint(20) DEFAULT NULL COMMENT '部门ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='角色';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', '管理员', '管理员', '1', '2019-04-08 17:14:37');
INSERT INTO `sys_role` VALUES ('2', '普通用户', '普通用户', '1', '2019-04-08 17:15:09');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色ID',
  `dept_id` bigint(20) DEFAULT NULL COMMENT '部门ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COMMENT='角色与部门对应关系';

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES ('21', '1', '1');
INSERT INTO `sys_role_dept` VALUES ('22', '1', '2');
INSERT INTO `sys_role_dept` VALUES ('23', '1', '3');
INSERT INTO `sys_role_dept` VALUES ('24', '1', '4');
INSERT INTO `sys_role_dept` VALUES ('25', '1', '5');
INSERT INTO `sys_role_dept` VALUES ('31', '2', '1');
INSERT INTO `sys_role_dept` VALUES ('32', '2', '2');
INSERT INTO `sys_role_dept` VALUES ('33', '2', '3');
INSERT INTO `sys_role_dept` VALUES ('34', '2', '4');
INSERT INTO `sys_role_dept` VALUES ('35', '2', '5');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色ID',
  `menu_id` bigint(20) DEFAULT NULL COMMENT '菜单ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=158 DEFAULT CHARSET=utf8 COMMENT='角色与菜单对应关系';

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES ('96', '1', '1');
INSERT INTO `sys_role_menu` VALUES ('97', '1', '2');
INSERT INTO `sys_role_menu` VALUES ('98', '1', '15');
INSERT INTO `sys_role_menu` VALUES ('99', '1', '16');
INSERT INTO `sys_role_menu` VALUES ('100', '1', '17');
INSERT INTO `sys_role_menu` VALUES ('101', '1', '18');
INSERT INTO `sys_role_menu` VALUES ('102', '1', '3');
INSERT INTO `sys_role_menu` VALUES ('103', '1', '19');
INSERT INTO `sys_role_menu` VALUES ('104', '1', '20');
INSERT INTO `sys_role_menu` VALUES ('105', '1', '21');
INSERT INTO `sys_role_menu` VALUES ('106', '1', '22');
INSERT INTO `sys_role_menu` VALUES ('107', '1', '4');
INSERT INTO `sys_role_menu` VALUES ('108', '1', '23');
INSERT INTO `sys_role_menu` VALUES ('109', '1', '24');
INSERT INTO `sys_role_menu` VALUES ('110', '1', '25');
INSERT INTO `sys_role_menu` VALUES ('111', '1', '26');
INSERT INTO `sys_role_menu` VALUES ('112', '1', '29');
INSERT INTO `sys_role_menu` VALUES ('113', '1', '30');
INSERT INTO `sys_role_menu` VALUES ('114', '1', '31');
INSERT INTO `sys_role_menu` VALUES ('115', '1', '32');
INSERT INTO `sys_role_menu` VALUES ('116', '1', '33');
INSERT INTO `sys_role_menu` VALUES ('117', '1', '34');
INSERT INTO `sys_role_menu` VALUES ('118', '1', '35');
INSERT INTO `sys_role_menu` VALUES ('119', '1', '36');
INSERT INTO `sys_role_menu` VALUES ('120', '1', '37');
INSERT INTO `sys_role_menu` VALUES ('121', '1', '38');
INSERT INTO `sys_role_menu` VALUES ('122', '1', '39');
INSERT INTO `sys_role_menu` VALUES ('123', '1', '40');
INSERT INTO `sys_role_menu` VALUES ('124', '1', '41');
INSERT INTO `sys_role_menu` VALUES ('125', '1', '61');
INSERT INTO `sys_role_menu` VALUES ('126', '1', '62');
INSERT INTO `sys_role_menu` VALUES ('127', '1', '63');
INSERT INTO `sys_role_menu` VALUES ('128', '1', '64');
INSERT INTO `sys_role_menu` VALUES ('129', '1', '66');
INSERT INTO `sys_role_menu` VALUES ('130', '1', '74');
INSERT INTO `sys_role_menu` VALUES ('131', '1', '67');
INSERT INTO `sys_role_menu` VALUES ('143', '2', '41');
INSERT INTO `sys_role_menu` VALUES ('144', '2', '61');
INSERT INTO `sys_role_menu` VALUES ('145', '2', '62');
INSERT INTO `sys_role_menu` VALUES ('146', '2', '63');
INSERT INTO `sys_role_menu` VALUES ('147', '2', '64');
INSERT INTO `sys_role_menu` VALUES ('148', '2', '66');
INSERT INTO `sys_role_menu` VALUES ('149', '2', '74');
INSERT INTO `sys_role_menu` VALUES ('150', '2', '75');
INSERT INTO `sys_role_menu` VALUES ('151', '2', '67');
INSERT INTO `sys_role_menu` VALUES ('152', '2', '79');
INSERT INTO `sys_role_menu` VALUES ('153', '2', '80');
INSERT INTO `sys_role_menu` VALUES ('157', '2', '69');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `password` varchar(100) DEFAULT NULL COMMENT '密码',
  `salt` varchar(20) DEFAULT NULL COMMENT '盐',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `mobile` varchar(100) DEFAULT NULL COMMENT '手机号',
  `age` int(4) DEFAULT '1',
  `sex` int(4) DEFAULT '1',
  `zy` varchar(100) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL COMMENT '状态  0：禁用   1：正常',
  `dept_id` bigint(20) DEFAULT NULL COMMENT '部门ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 COMMENT='系统用户';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', 'admin', 'e1153123d7d180ceeb820d577ff119876678732a68eef4e6ffc0b1f06a01f91b', 'YzcmCZNvbXocrsz9dm8e', 'root@bskf', '13612345678', '18', '1', '计算机', '1', '1', '2023-02-26 11:11:11');
INSERT INTO `sys_user` VALUES ('2', 'zhangsan', 'cd68d3db0629403e2cbb9e236b26d715c6df6ec0f50c97df4b24e154b6eec017', 'eG0qeE5QY1gAwJgL5W0v', '123456789@qq.com', '15662365698', '18', '1', '化学', '1', '1', '2023-02-26 11:11:11');
INSERT INTO `sys_user` VALUES ('3', 'lisi', 'a3443b4e63156b2c122016fa459a0acac69bf4aa6e6055991619eee2fe846d23', 'RMv12pRQABMYRZe9iJCG', '123456@qq.com', '15623659632', '24', '1', '生物科技', '1', '1', '2023-02-26 11:11:11');
INSERT INTO `sys_user` VALUES ('4', 'AAA', '25955dc105000db26c9a41cdf4aeef5791627695a7c6182c2dade31e60ca0219', 'InUSM8rMml8gTQ0N4TML', '14564@qq.com', '15632659865', '20', '0', '化学', '1', '1', '2023-02-26 11:11:11');
INSERT INTO `sys_user` VALUES ('6', 'BBB', 'a3443b4e63156b2c122016fa459a0acac69bf4aa6e6055991619eee2fe846d23', 'RMv12pRQABMYRZe9iJCG', '123456@qq.com', '15623659632', '24', '0', '生物科技', '1', '1', '2023-02-26 11:11:11');
INSERT INTO `sys_user` VALUES ('7', 'CCC', 'a3443b4e63156b2c122016fa459a0acac69bf4aa6e6055991619eee2fe846d23', 'RMv12pRQABMYRZe9iJCG', '123456@qq.com', '15623659632', '56', '0', '生物科技', '1', '1', '2023-02-26 11:11:11');
INSERT INTO `sys_user` VALUES ('8', 'DDD', 'a3443b4e63156b2c122016fa459a0acac69bf4aa6e6055991619eee2fe846d23', 'RMv12pRQABMYRZe9iJCG', '123456@qq.com', '15623659632', '24', '1', '生物科技', '1', '1', '2023-02-26 11:11:11');
INSERT INTO `sys_user` VALUES ('9', 'EEE', 'a3443b4e63156b2c122016fa459a0acac69bf4aa6e6055991619eee2fe846d23', 'RMv12pRQABMYRZe9iJCG', '123456@qq.com', '15623659632', '48', '1', '生物科技', '1', '1', '2023-02-26 11:11:11');
INSERT INTO `sys_user` VALUES ('10', 'FFF', 'a3443b4e63156b2c122016fa459a0acac69bf4aa6e6055991619eee2fe846d23', 'RMv12pRQABMYRZe9iJCG', '123456@qq.com', '15623659632', '24', '0', '生物科技', '1', '1', '2023-02-26 11:11:11');
INSERT INTO `sys_user` VALUES ('11', 'GGG', 'a3443b4e63156b2c122016fa459a0acac69bf4aa6e6055991619eee2fe846d23', 'RMv12pRQABMYRZe9iJCG', '123456@qq.com', '15623659632', '24', '0', '生物科技', '1', '1', '2023-02-26 11:11:11');
INSERT INTO `sys_user` VALUES ('12', 'HHH', 'a3443b4e63156b2c122016fa459a0acac69bf4aa6e6055991619eee2fe846d23', 'RMv12pRQABMYRZe9iJCG', '123456@qq.com', '15623659632', '36', '0', '生物科技', '1', '1', '2023-02-26 11:11:11');
INSERT INTO `sys_user` VALUES ('13', 'III', 'a3443b4e63156b2c122016fa459a0acac69bf4aa6e6055991619eee2fe846d23', 'RMv12pRQABMYRZe9iJCG', '123456@qq.com', '15623659632', '24', '0', '生物科技', '1', '1', '2023-02-26 11:11:11');
INSERT INTO `sys_user` VALUES ('14', 'JJJ', 'a3443b4e63156b2c122016fa459a0acac69bf4aa6e6055991619eee2fe846d23', 'RMv12pRQABMYRZe9iJCG', '123456@qq.com', '15623659632', '24', '1', '生物科技', '1', '1', '2023-02-26 11:11:11');
INSERT INTO `sys_user` VALUES ('15', 'KKK', 'a3443b4e63156b2c122016fa459a0acac69bf4aa6e6055991619eee2fe846d23', 'RMv12pRQABMYRZe9iJCG', '123456@qq.com', '15623659632', '24', '1', '生物科技', '1', '1', '2023-02-26 11:11:11');
INSERT INTO `sys_user` VALUES ('16', 'LLL', 'a3443b4e63156b2c122016fa459a0acac69bf4aa6e6055991619eee2fe846d23', 'RMv12pRQABMYRZe9iJCG', '123456@qq.com', '15623659632', '19', '1', '生物科技', '1', '1', '2023-02-26 11:11:11');
INSERT INTO `sys_user` VALUES ('17', 'OOO', 'a3443b4e63156b2c122016fa459a0acac69bf4aa6e6055991619eee2fe846d23', 'RMv12pRQABMYRZe9iJCG', '123456@qq.com', '15623659632', '24', '1', '生物科技', '1', '1', '2023-02-26 11:11:11');
INSERT INTO `sys_user` VALUES ('18', 'PPP', 'a3443b4e63156b2c122016fa459a0acac69bf4aa6e6055991619eee2fe846d23', 'RMv12pRQABMYRZe9iJCG', '123456@qq.com', '15623659632', '24', '1', '深度学习', '1', '1', '2023-02-26 11:11:11');
INSERT INTO `sys_user` VALUES ('19', 'QQQ', 'a3443b4e63156b2c122016fa459a0acac69bf4aa6e6055991619eee2fe846d23', 'RMv12pRQABMYRZe9iJCG', '123456@qq.com', '15623659632', '28', '1', '生物科技', '1', '1', '2023-02-26 11:11:11');
INSERT INTO `sys_user` VALUES ('20', 'RRR', 'a3443b4e63156b2c122016fa459a0acac69bf4aa6e6055991619eee2fe846d23', 'RMv12pRQABMYRZe9iJCG', '123456@qq.com', '15623659632', '24', '1', '生物科技', '1', '1', '2023-02-26 11:11:11');
INSERT INTO `sys_user` VALUES ('21', 'SSS', 'a3443b4e63156b2c122016fa459a0acac69bf4aa6e6055991619eee2fe846d23', 'RMv12pRQABMYRZe9iJCG', '123456@qq.com', '15623659632', '24', '1', '生物科技', '1', '1', '2023-02-26 11:11:11');
INSERT INTO `sys_user` VALUES ('22', 'TTT', 'a3443b4e63156b2c122016fa459a0acac69bf4aa6e6055991619eee2fe846d23', 'RMv12pRQABMYRZe9iJCG', '123456@qq.com', '15623659632', '16', '0', '深度学习', '1', '1', '2023-02-26 11:11:11');
INSERT INTO `sys_user` VALUES ('23', 'UUU', 'a3443b4e63156b2c122016fa459a0acac69bf4aa6e6055991619eee2fe846d23', 'RMv12pRQABMYRZe9iJCG', '123456@qq.com', '15623659632', '24', '0', '生物科技', '1', '1', '2023-02-26 11:11:11');
INSERT INTO `sys_user` VALUES ('24', 'VVV', 'a3443b4e63156b2c122016fa459a0acac69bf4aa6e6055991619eee2fe846d23', 'RMv12pRQABMYRZe9iJCG', '123456@qq.com', '15623659632', '24', '0', '生物科技', '1', '1', '2023-02-26 11:11:11');
INSERT INTO `sys_user` VALUES ('25', 'WWW', 'a3443b4e63156b2c122016fa459a0acac69bf4aa6e6055991619eee2fe846d23', 'RMv12pRQABMYRZe9iJCG', '123456@qq.com', '15623659632', '80', '0', '自然语言处理', '1', '1', '2023-02-26 11:11:11');
INSERT INTO `sys_user` VALUES ('26', 'XXX', 'a3443b4e63156b2c122016fa459a0acac69bf4aa6e6055991619eee2fe846d23', 'RMv12pRQABMYRZe9iJCG', '123456@qq.com', '15623659632', '24', '0', '生物科技', '1', '1', '2023-02-26 11:11:11');
INSERT INTO `sys_user` VALUES ('27', 'YYY', 'a3443b4e63156b2c122016fa459a0acac69bf4aa6e6055991619eee2fe846d23', 'RMv12pRQABMYRZe9iJCG', '123456@qq.com', '15623659632', '24', '0', '生物科技', '1', '1', '2023-02-26 11:11:11');
INSERT INTO `sys_user` VALUES ('28', 'ZZZ', 'a3443b4e63156b2c122016fa459a0acac69bf4aa6e6055991619eee2fe846d23', 'RMv12pRQABMYRZe9iJCG', '123456@qq.com', '15623659632', '75', '0', '自然语言处理', '1', '1', '2023-02-26 11:11:11');
INSERT INTO `sys_user` VALUES ('29', 'koko', 'a3443b4e63156b2c122016fa459a0acac69bf4aa6e6055991619eee2fe846d23', 'RMv12pRQABMYRZe9iJCG', '123456@qq.com', '15623659632', '24', '0', '生物科技', '1', '1', '2023-02-26 11:11:11');
INSERT INTO `sys_user` VALUES ('30', 'popo', 'a3443b4e63156b2c122016fa459a0acac69bf4aa6e6055991619eee2fe846d23', 'RMv12pRQABMYRZe9iJCG', '123456@qq.com', '15623659632', '69', '1', '生物科技', '1', '1', '2023-02-26 11:11:11');
INSERT INTO `sys_user` VALUES ('31', 'lklk', 'a3443b4e63156b2c122016fa459a0acac69bf4aa6e6055991619eee2fe846d23', 'RMv12pRQABMYRZe9iJCG', '123456@qq.com', '15623659632', '24', '1', '生物科技', '1', '1', '2023-02-26 11:11:11');
INSERT INTO `sys_user` VALUES ('32', 'cdcd', 'a3443b4e63156b2c122016fa459a0acac69bf4aa6e6055991619eee2fe846d23', 'RMv12pRQABMYRZe9iJCG', '123456@qq.com', '15623659632', '52', '1', '信息管理', '1', '1', '2023-02-26 11:11:11');
INSERT INTO `sys_user` VALUES ('33', 'erer', 'a3443b4e63156b2c122016fa459a0acac69bf4aa6e6055991619eee2fe846d23', 'RMv12pRQABMYRZe9iJCG', '123456@qq.com', '15623659632', '24', '1', '信息管理', '1', '1', '2023-02-26 11:11:11');
INSERT INTO `sys_user` VALUES ('34', 'fvfv', 'a3443b4e63156b2c122016fa459a0acac69bf4aa6e6055991619eee2fe846d23', 'RMv12pRQABMYRZe9iJCG', '123456@qq.com', '15623659632', '63', '1', '生物科技', '1', '1', '2023-02-26 11:11:11');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COMMENT='用户与角色对应关系';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES ('2', '2', '2');
INSERT INTO `sys_user_role` VALUES ('3', '3', '2');
INSERT INTO `sys_user_role` VALUES ('4', '4', '2');
INSERT INTO `sys_user_role` VALUES ('5', '8', '2');
INSERT INTO `sys_user_role` VALUES ('7', '10', '2');
INSERT INTO `sys_user_role` VALUES ('8', '6', '2');
INSERT INTO `sys_user_role` VALUES ('9', '7', '2');
INSERT INTO `sys_user_role` VALUES ('10', '9', '2');
INSERT INTO `sys_user_role` VALUES ('11', '11', '2');
INSERT INTO `sys_user_role` VALUES ('12', '12', '2');
INSERT INTO `sys_user_role` VALUES ('13', '13', '2');
INSERT INTO `sys_user_role` VALUES ('14', '14', '2');
INSERT INTO `sys_user_role` VALUES ('15', '15', '2');
INSERT INTO `sys_user_role` VALUES ('16', '16', '2');
INSERT INTO `sys_user_role` VALUES ('17', '17', '2');
INSERT INTO `sys_user_role` VALUES ('18', '18', '2');
INSERT INTO `sys_user_role` VALUES ('19', '19', '2');
INSERT INTO `sys_user_role` VALUES ('20', '20', '2');
INSERT INTO `sys_user_role` VALUES ('21', '21', '2');
INSERT INTO `sys_user_role` VALUES ('22', '22', '2');
INSERT INTO `sys_user_role` VALUES ('23', '23', '2');
INSERT INTO `sys_user_role` VALUES ('24', '24', '2');
INSERT INTO `sys_user_role` VALUES ('25', '25', '2');
INSERT INTO `sys_user_role` VALUES ('26', '26', '2');
INSERT INTO `sys_user_role` VALUES ('27', '27', '2');
INSERT INTO `sys_user_role` VALUES ('28', '28', '2');
INSERT INTO `sys_user_role` VALUES ('29', '29', '2');
INSERT INTO `sys_user_role` VALUES ('30', '30', '2');
INSERT INTO `sys_user_role` VALUES ('31', '31', '2');
INSERT INTO `sys_user_role` VALUES ('34', '34', '2');
INSERT INTO `sys_user_role` VALUES ('35', '32', '2');
INSERT INTO `sys_user_role` VALUES ('36', '33', '2');

-- ----------------------------
-- Table structure for t_book_bow
-- ----------------------------
DROP TABLE IF EXISTS `t_book_bow`;
CREATE TABLE `t_book_bow` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `bid` varchar(200) DEFAULT NULL COMMENT '名称',
  `uid` int(5) DEFAULT '1',
  `back` int(5) DEFAULT '0',
  `ct` datetime DEFAULT CURRENT_TIMESTAMP,
  `ut` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_book_bow
-- ----------------------------
INSERT INTO `t_book_bow` VALUES ('23', '000A18FDB38F470DBE9CD0972BADB23F', '1', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('24', '0BE0707984014E66BD9F34F534FCE0F7', '1', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('25', '0EE8A0AE69154287A378FB110FF2C780', '1', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('28', '113D0D1BB9174DD19A7DE7E2B37F677F', '1', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('29', '1286B13F0EA54E4CB75434762121486A', '1', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('30', '13EBF9B1FDE346A683A1C45BD6773ECB', '1', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('31', '1A15DC5E8A014A58862ED741D579B530', '1', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('32', '210A3DCA429049C78B623C3986BEB136', '1', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('33', '22234CECF15F4ECB813F0B433DDA5365', '1', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('34', '230A00EC22BF4A1DBA87C64800B54C8D', '1', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('35', '4491EA4832E04B8B94F334B71E871983', '1', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('36', '48BBFBFC07074ADE8CC906A45BE5D9A6', '1', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('37', '49D98E7916B94232862F7DCD1B0BAB66', '1', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('38', '4A9574F03A6B40C1B2A437237C17DEEC', '1', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('39', '4BF6D97DD18A4B77B8DED9B057577F8F', '1', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('40', '4C3331CAD5A5453787A94B8D7CCEAA29', '1', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('41', '4D20D2450B084113A331D909FF4975EB', '1', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('42', '4E44405DAFB7413E8A13BBFFBEE73AC7', '1', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('43', '504FB999B0444B339907090927FDBE8A', '1', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('44', '52077C8423B645A9BADA96A5E0B14422', '1', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('45', '52B0EDFF966E4A058BDA5B18EEC698C4', '1', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('46', '5315DA60D24042889400AD4C93A37501', '1', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('47', '56B1B7D8CD8740B098677C7216A673C4', '1', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('48', '57B6FF1B89C843C38BA39C717FA557D6', '1', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('49', '5C4A6F0F4A3B4672AD8C5F89BF5D37D2', '1', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('50', '5C68141786B84A4CB8929A2415040739', '1', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('51', '5EDB981339C342ED8DB17D5A198D50DC', '1', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('52', '6398A7BA400D40258796BCBB2B256068', '1', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('53', '676B56A612AF4E968CF0F6FFE289269D', '1', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('54', '7917F5B19A0948FD9551932909328E4E', '1', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('59', '28A03D28BAD449659A77330BE35FCD65', '3', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('60', '3AE5C8B976B6448A9D3A155C1BDE12BC', '3', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('61', '4D20D2450B084113A331D909FF4975EB', '8', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('62', '4E44405DAFB7413E8A13BBFFBEE73AC7', '8', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('63', 'D0E69F85ACAB4C15BB40966E5AA545F1', '7', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('64', 'D2ABA8B06C524632846F27C34568F3CE', '7', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('65', 'D8723405BA054C13B52357B8F6AEEC24', '7', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('66', 'DC36FD53A1514312A0A9ADD53A583886', '7', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('67', 'DCB64DF0084E486EBF173F729A3A630A', '7', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('68', 'DEE7BDC7E0E343149E3C3601D2658171', '7', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('69', 'DF4E74EEE89B43229BB8212F0B858C38', '7', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('70', 'E4F184188C8B4C7BB32D4E76603426AC', '7', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('71', 'EA695342393C4BE48B831FA5E6B0E5C4', '7', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('72', 'F0E34313BF304CCEBF198BD4E05307B8', '7', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('73', 'F6162799E913423EA5CB57BEC65AB1E9', '7', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('74', 'F693239BC3B3444C8538ABE7411BB38E', '7', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('75', 'F78C94641DB4475BBA1E72A07DF9B3AE', '7', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('76', 'FC232CD9B6E6411BBBB1A5B781D2C3C9', '7', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('77', 'FEC3740CF30E442A94021911A25EF0D7', '7', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('78', 'FFABBED1E5254BC0B2726EC4ED8ACCDA', '7', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('79', '000A18FDB38F470DBE9CD0972BADB23F', '8', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('80', '260F8A3594F741C1B0EB69616F65045B', '8', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('81', '33ACF97A9A374352AE9F5E89BB791262', '8', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('82', '4BF6D97DD18A4B77B8DED9B057577F8F', '8', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('83', '4C3331CAD5A5453787A94B8D7CCEAA29', '8', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('84', '4D20D2450B084113A331D909FF4975EB', '8', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('85', '52B0EDFF966E4A058BDA5B18EEC698C4', '8', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('86', '57B6FF1B89C843C38BA39C717FA557D6', '8', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('87', '7C0C785FFBEC4DEC802FA36E8B0BC87E', '8', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('88', '819FF56E4423462394E6F83882F78975', '8', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('89', '99BF63AC12AD48FCB673F1820888964E', '8', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('90', 'A3D464D1D1344ED5983920B472826730', '8', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('91', 'A7EFD99367C9434682A790635D3C5FDF', '8', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('92', 'AF28ED8F692C4288B32CF411CBDBFC23', '8', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('93', 'B329A14DDEF8455F82B3FDF25821D2BB', '8', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('94', 'F693239BC3B3444C8538ABE7411BB38E', '8', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('95', '0BE0707984014E66BD9F34F534FCE0F7', '15', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('96', '3AE5C8B976B6448A9D3A155C1BDE12BC', '33', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('97', '39F1D0803E8F4592AE1245CACE683214', '33', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('98', '0BE0707984014E66BD9F34F534FCE0F7', '1', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('99', '0BE0707984014E66BD9F34F534FCE0F7', '1', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('100', '113D0D1BB9174DD19A7DE7E2B37F677F', '1', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_bow` VALUES ('101', '3E1990E19989422E9DA735978CB1E4CE', '1', '0', '2023-02-26 00:00:00', '2023-02-26 00:00:00');

-- ----------------------------
-- Table structure for t_book_info
-- ----------------------------
DROP TABLE IF EXISTS `t_book_info`;
CREATE TABLE `t_book_info` (
  `pid` varchar(32) NOT NULL,
  `name` varchar(200) DEFAULT NULL COMMENT '论文名称',
  `xx` varchar(200) DEFAULT NULL COMMENT '学校',
  `zz` varchar(50) DEFAULT NULL COMMENT '作者',
  `zy` varchar(100) DEFAULT NULL COMMENT '所属专业',
  `version` int(11) DEFAULT NULL COMMENT '版本',
  `pn` int(11) DEFAULT NULL COMMENT '页数',
  `wn` int(11) DEFAULT NULL COMMENT '字数',
  `bsize` int(11) DEFAULT NULL COMMENT '书页大小',
  `paper` varchar(50) DEFAULT NULL COMMENT '格式 word pdf 等',
  `mark` text COMMENT '简介',
  `content` text,
  `tjrq` int(50) DEFAULT '10' COMMENT '推荐人气',
  `imgw` varchar(100) DEFAULT NULL COMMENT '封面',
  `ptime` datetime DEFAULT NULL COMMENT '发布时间',
  `status` int(5) NOT NULL DEFAULT '1',
  `ct` datetime DEFAULT NULL,
  `ut` datetime DEFAULT NULL,
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_book_info
-- ----------------------------
INSERT INTO `t_book_info` VALUES ('000A18FDB38F470DBE9CD0972BADB23F', 'Java Web整合开发实战--基于Struts 2+Hibernate+Spring（99个应用实例，4个项目开发案例，15.5小时配套教学视频，超值DVD光盘含大量开发资源。一本书搞定SSH框架整合开发！）', '清华大学', '贾蓓', '计算机科学与技术', '1', '640', '1030000', '16', 'PDF', '清华大学出版社', 'Java Web整合开发实战--基于Struts 2+Hibernate+Spring（99个应用实例，4个项目开发案例，15.5小时配套教学视频，超值DVD光盘含大量开发资源。一本书搞定SSH框架整合开发！）Java Web整合开发实战--基于Struts 2+Hibernate+Spring（99个应用实例，4个项目开发案例，15.5小时配套教学视频，超值DVD光盘含大量开发资源。一本书搞定SSH框架整合开发！）Java Web整合开发实战--基于Struts 2+Hibernate+Spring（99个应用实例，4个项目开发案例，15.5小时配套教学视频，超值DVD光盘含大量开发资源。一本书搞定SSH框架整合开发！）Java Web整合开发实战--基于Struts 2+Hibernate+Spring（99个应用实例，4个项目开发案例，15.5小时配套教学视频，超值DVD光盘含大量开发资源。一本书搞定SSH框架整合开发！）Java Web整合开发实战--基于Struts 2+Hibernate+Spring（99个应用实例，4个项目开发案例，15.5小时配套教学视频，超值DVD光盘含大量开发资源。一本书搞定SSH框架整合开发！）Java Web整合开发实战--基于Struts 2+Hibernate+Spring（99个应用实例，4个项目开发案例，15.5小时配套教学视频，超值DVD光盘含大量开发资源。一本书搞定SSH框架整合开发！）Java Web整合开发实战--基于Struts 2+Hibernate+Spring（99个应用实例，4个项目开发案例，15.5小时配套教学视频，超值DVD光盘含大量开发资源。一本书搞定SSH框架整合开发！）Java Web整合开发实战--基于Struts 2+Hibernate+Spring（99个应用实例，4个项目开发案例，15.5小时配套教学视频，超值DVD光盘含大量开发资源。一本书搞定SSH框架整合开发！）', '1065', 'book_img/23268958-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('0BE0707984014E66BD9F34F534FCE0F7', 'OSGi实战【OSGi规范制定者亲自撰写 汇集Apache项目技术实战经验】', '清华大学', 'Richard', '人文科学', '1', '468', '721000', '16', 'PDF', '人民邮电出版社', 'OSGi实战【OSGi规范制定者亲自撰写 汇集Apache项目技术实战经验】', '200', 'book_img/22938396-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('0EE8A0AE69154287A378FB110FF2C780', 'Java核心技术：卷Ⅰ基础知识（原书第8版）', '清华大学', '昊斯特曼', '数学', '1', '694', '0', '16', 'PDF', '机械工业出版社', 'Java核心技术：卷Ⅰ基础知识（原书第8版）', '200', 'book_img/20285763-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('113D0D1BB9174DD19A7DE7E2B37F677F', 'Java7入门经典（跟编程导师Ivor Horton学Java 预计到货日期9月初）', '清华大学', '霍尔顿', '数学', '1', '1124', '1918000', '16', 'PDF', '清华大学出版社', 'Java7入门经典（跟编程导师Ivor Horton学Java 预计到货日期9月初）', '200', 'book_img/22813026-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('1286B13F0EA54E4CB75434762121486A', 'Java核心技术 卷I：基础知识(第9版·英文版)(上、下册)', '清华大学', '霍斯特曼', '数学', '1', '0', '1197000', '16', 'PDF', '人民邮电出版社', 'Java核心技术 卷I：基础知识(第9版·英文版)(上、下册)', '200', 'book_img/23280479-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('13EBF9B1FDE346A683A1C45BD6773ECB', 'Java开发实战1200例（第Ⅱ卷）（史上最全的“编程实例”类图书，代码分析、实例速查、练习巩固的绝好帮手）', '清华大学', '无', '数学', '1', '0', '1754000', '16', 'PDF', '清华大学出版社', 'Java开发实战1200例（第Ⅱ卷）（史上最全的“编程实例”类图书，代码分析、实例速查、练习巩固的绝好帮手）', '200', 'book_img/21110930-1_w_1.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('1A15DC5E8A014A58862ED741D579B530', 'Java深入解析——透析Java本质的36个话题', '清华大学', '梁勇', '数学', '1', '298', '424000', '16', 'PDF', '电子工业出版社', 'Java深入解析——透析Java本质的36个话题', '200', 'book_img/23363997-1_w_1.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('210A3DCA429049C78B623C3986BEB136', 'JavaScript经典教程套装：JavaScript高级程序设计(第3版)+JavaScript DOM编程艺术(第2版)(套装共2册)(超值附赠《码农》光盘1张)', '清华大学', 'Nicholas C. Zakas', '人文科学', '1', '1048', '0', '16', 'PDF', '人民邮电出版社', 'JavaScript经典教程套装：JavaScript高级程序设计(第3版)+JavaScript DOM编程艺术(第2版)(套装共2册)(超值附赠《码农》光盘1张)', '200', 'book_img/23224089-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('22234CECF15F4ECB813F0B433DDA5365', 'JavaScript从入门到精通（附光盘1张）（连续8月JavaScript类全国零售排行前2名，13小时视频，400个经典实例、369项面试真题、138项测试史上最全资源库）', '清华大学', '明日科技', '人文科学', '1', '532', '939000', '16', 'PDF', '清华大学出版社', 'JavaScript从入门到精通（附光盘1张）（连续8月JavaScript类全国零售排行前2名，13小时视频，400个经典实例、369项面试真题、138项测试史上最全资源库）', '200', 'book_img/22862057-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('230A00EC22BF4A1DBA87C64800B54C8D', 'Struts2技术内幕：深入解析Struts架构设计与实现原理', '清华大学', '陆舟', '人文科学', '1', '379', '0', '16', 'PDF', '机械工业出版社', 'Struts2技术内幕：深入解析Struts架构设计与实现原理', '200', 'book_img/22577578-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('260F8A3594F741C1B0EB69616F65045B', 'Tomcat与Java Web开发技术详解（第2版）(含光盘1张)', '清华大学', '孙卫琴', '人文科学', '1', '734', '1216000', '16', 'PDF', '电子工业出版社', 'Tomcat与Java Web开发技术详解（第2版）(含光盘1张)', '200', 'book_img/20420983-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('28A03D28BAD449659A77330BE35FCD65', 'JAVA核心技术卷II：高级特性（原书第8版）', '清华大学', '霍斯特曼', '人文科学', '1', '852', '0', '16', 'PDF', '机械工业出版社', 'JAVA核心技术卷II：高级特性（原书第8版）', '200', 'book_img/20446562-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('2EE1A20A6AF742E387E18619D7E3BB94', 'Java虚拟机并发编程(Java并发编程领域的里程碑之作，资深Java技术专家、并发编程专家、敏捷开发专家和Jolt大奖得主撰写，Amazon五星畅销书)', '清华大学', 'Venkat Subramaniam', '人文科学', '1', '215', '0', '16', 'PDF', '机械工业出版社', 'Java虚拟机并发编程(Java并发编程领域的里程碑之作，资深Java技术专家、并发编程专家、敏捷开发专家和Jolt大奖得主撰写，Amazon五星畅销书)', '200', 'book_img/23239786-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('33ACF97A9A374352AE9F5E89BB791262', '基于MVC的JavaScript Web富应用开发', '清华大学', '麦卡劳', '计算机科学与技术', '1', '282', '462000', '16', 'PDF', '电子工业出版社', '基于MVC的JavaScript Web富应用开发', '200', 'book_img/22757564-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('37F75BEAE1FE46F2B14674923F1E7987', '数据结构与算法分析Java语言描述 第2版', '清华大学', '韦斯', '计算机科学与技术', '2', '440', '0', '16', 'PDF', '机械工业出版社', '数据结构与算法分析Java语言描述 第2版', '200', 'book_img/20417467-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('39F1D0803E8F4592AE1245CACE683214', 'Java程序员修炼之道', '清华大学', '埃文斯', '计算机科学与技术', '1', '395', '658000', '16', 'PDF', '人民邮电出版社', 'Java程序员修炼之道', '200', 'book_img/23301847-1_w_1.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('3AE5C8B976B6448A9D3A155C1BDE12BC', '深入理解Java虚拟机:JVM高级特性与最佳实践（超级畅销书，6个月5次印刷，从实践角度解析JVM工作原理，Java程序员必备）', '清华大学', '周志明', '计算机科学与技术', '1', '0', '0', '16', 'PDF', '机械工业出版社', '深入理解Java虚拟机:JVM高级特性与最佳实践（超级畅销书，6个月5次印刷，从实践角度解析JVM工作原理，Java程序员必备）', '200', 'book_img/21108671-1_w_1.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('3DD187217BF44A99B86DD18A4DC628BA', 'Java核心技术 卷1 基础知识（原书第9版）', '清华大学', '霍斯特曼，科内尔', '计算机科学与技术', '1', '704', '0', '16', 'PDF', '机械工业出版社', 'Java核心技术 卷1 基础知识（原书第9版）', '200', 'book_img/23362142-1_w_1.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('3E1990E19989422E9DA735978CB1E4CE', 'Effective Java中文版(第2版)', '清华大学', '布洛克', '计算机科学与技术', '2', '287', '0', '16', 'PDF', '机械工业出版社', 'Effective Java中文版(第2版)', '200', 'book_img/20459091-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('400D94DE5A0742B3A618FC76DF107183', 'JavaScript宝典（第7版）（配光盘）', '清华大学', '古德曼', '计算机科学与技术', '1', '1012', '1657000', '32', 'PDF', '清华大学出版社', 'JavaScript宝典（第7版）（配光盘）', '200', 'book_img/23169892-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('4491EA4832E04B8B94F334B71E871983', 'Java语言程序设计：进阶篇（原书第8版）', '清华大学', '梁勇', '计算机科学与技术', '1', '507', '0', '16', 'PDF', '机械工业出版社', 'Java语言程序设计：进阶篇（原书第8版）', '200', 'book_img/21117631-1_w_1.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('48BBFBFC07074ADE8CC906A45BE5D9A6', 'JavaScript权威指南（第6版）（淘宝前端团队倾情翻译！经典权威的JavaScript犀牛书！第6版特别涵盖了HTML5和ECMAScript5！）（经典巨著，当当独家首发）', '清华大学', '弗兰纳根', '机械电气', '1', '1004', '0', '16', 'PDF', '机械工业出版社', 'JavaScript权威指南（第6版）（淘宝前端团队倾情翻译！经典权威的JavaScript犀牛书！第6版特别涵盖了HTML5和ECMAScript5！）（经典巨著，当当独家首发）', '200', 'book_img/22722790-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('49D98E7916B94232862F7DCD1B0BAB66', 'HTML5+JavaScript动画基础', '清华大学', '兰贝塔', '机械电气', '1', '393', '553000', '16', 'PDF', '人民邮电出版社', 'HTML5+JavaScript动画基础', '200', 'book_img/23266633-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('4A9574F03A6B40C1B2A437237C17DEEC', 'Spring实战(第3版)（In Action系列中最畅销的Spring图书，近十万读者学习Spring的共同选择）', '清华大学', 'Craig Walls', '机械电气', '1', '374', '487000', '16', 'PDF', '人民邮电出版社', 'Spring实战(第3版)（In Action系列中最畅销的Spring图书，近十万读者学习Spring的共同选择）', '200', 'book_img/23254532-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('4BF6D97DD18A4B77B8DED9B057577F8F', 'Java Web从入门到精通（附光盘1张）（连续8月Java类全国零售排行前2名，27小时视频，951个经典实例、369项面试真题、596项测试史上最全资源库）', '清华大学', '明日科技', '机械电气', '1', '547', '979000', '16', 'PDF', '清华大学出版社', 'Java Web从入门到精通（附光盘1张）（连续8月Java类全国零售排行前2名，27小时视频，951个经典实例、369项面试真题、596项测试史上最全资源库）', '200', 'book_img/22862056-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('4C3331CAD5A5453787A94B8D7CCEAA29', 'Java Web整合开发王者归来（JSP+Servlet+Struts+Hibernate+Spring）（配光盘', '清华大学', '刘京华', '机械电气', '1', '1010', '1368000', '16', 'PDF', '清华大学出版社', 'Java Web整合开发王者归来（JSP+Servlet+Struts+Hibernate+Spring）（配光盘', '200', 'book_img/20756351-1_w_1.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('4D20D2450B084113A331D909FF4975EB', 'jQuery实战(第2版)(畅销书升级版，掌握Web开发利器必修宝典)', '清华大学', 'Bear Bibeault　Yehuda Katz ', '机械电气', '1', '394', '617000', '16', 'PDF', '人民邮电出版社', 'jQuery实战(第2版)(畅销书升级版，掌握Web开发利器必修宝典)', '200', 'book_img/22638286-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('4E44405DAFB7413E8A13BBFFBEE73AC7', 'JavaScript经典实例', '清华大学', '鲍尔斯', '机械电气', '1', '512', '625000', '16', 'PDF', '中国电力出版社', 'JavaScript经典实例', '200', 'book_img/22692811-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('504FB999B0444B339907090927FDBE8A', '深入浅出Ext JS(第3版)', '清华大学', '徐会生', '机械电气', '3', '413', '642000', '16', 'PDF', '人民邮电出版社', '深入浅出Ext JS(第3版)', '200', 'book_img/23351049-1_w_1.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('52077C8423B645A9BADA96A5E0B14422', 'Spring源码深度解析', '清华大学', '郝佳', '机械电气', '1', '386', '545000', '16', 'PDF', '人民邮电出版社', 'Spring源码深度解析', '200', 'book_img/23329703-1_w_1.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('52B0EDFF966E4A058BDA5B18EEC698C4', '亮剑Java Web项目开发案例导航(含DVD光盘1张)', '清华大学', '朱雪琴', '机械电气', '1', '526', '875000', '16', 'PDF', '电子工业出版社', '亮剑Java Web项目开发案例导航(含DVD光盘1张)', '200', 'book_img/22623766-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('5315DA60D24042889400AD4C93A37501', 'Spring 3.x企业应用开发实战(含CD光盘1张)', '清华大学', '陈雄华', '机械电气', '1', '710', '1158000', '16', 'PDF', '电子工业出版社', 'Spring 3.x企业应用开发实战(含CD光盘1张)', '200', 'book_img/22605701-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('56B1B7D8CD8740B098677C7216A673C4', '疯狂 Java 程序员的基本修养（《疯狂Java讲义》最佳拍档，扫清知识死角，夯实基本功）', '清华大学', '李刚', '机械电气', '1', '484', '7710000', '16', 'PDF', '电子工业出版社', '疯狂 Java 程序员的基本修养（《疯狂Java讲义》最佳拍档，扫清知识死角，夯实基本功）', '200', 'book_img/23042420-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('57B6FF1B89C843C38BA39C717FA557D6', '了不起的Node.js: 将JavaScript进行到底（Web开发首选实时 跨多服务器 高并发）', '清华大学', 'Guillermo Rauch', '机械电气', '1', '292', '436000', '16', 'PDF', '电子工业出版社', '了不起的Node.js: 将JavaScript进行到底（Web开发首选实时 跨多服务器 高并发）', '200', 'book_img/23368351-1_w_2.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('5C4A6F0F4A3B4672AD8C5F89BF5D37D2', 'Java从入门到精通（第3版）（附光盘1张）（连续8月Java类全国零售排行前2名，32小时视频，732个经典实例、369项面试真题、616项测试史上最全资源库）', '清华大学', '明日科技', '机械电气', '3', '564', '1013000', '16', 'PDF', '清华大学出版社', 'Java从入门到精通（第3版）（附光盘1张）（连续8月Java类全国零售排行前2名，32小时视频，732个经典实例、369项面试真题、616项测试史上最全资源库）', '200', 'book_img/22862060-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('5C68141786B84A4CB8929A2415040739', 'JavaScript高级程序设计(第3版)(JavaScript技术名著，国内JavasScript第一书，销量超过8万册)', '清华大学', 'Nicholas C. Zakas', '机械电气', '1', '730', '1092000', '16', 'PDF', '人民邮电出版社', 'JavaScript高级程序设计(第3版)(JavaScript技术名著，国内JavasScript第一书，销量超过8万册)', '200', 'book_img/22628333-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('5EDB981339C342ED8DB17D5A198D50DC', 'Java程序性能优化', '清华大学', '葛一鸣', '机械电气', '1', '400', '649000', '16', 'PDF', '清华大学出版社', 'Java程序性能优化', '200', 'book_img/22881618-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('6398A7BA400D40258796BCBB2B256068', 'JavaScript设计模式', '清华大学', 'Addy Osmani', '机械电气', '1', '241', '301000', '16', 'PDF', '人民邮电出版社', 'JavaScript设计模式', '200', 'book_img/23266635-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('676B56A612AF4E968CF0F6FFE289269D', 'JavaScript和jQuery实战手册（原书第2版）', '清华大学', '麦克法兰', '机械电气', '1', '504', '0', '16', 'PDF', '机械工业出版社', 'JavaScript和jQuery实战手册（原书第2版）', '200', 'book_img/23201813-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('7917F5B19A0948FD9551932909328E4E', 'Java项目开发案例全程实录（第2版）（配光盘）（软件项目开发全程实录丛书）', '清华大学', '明日科技', '机械电气', '2', '605', '1037000', '16', 'PDF', '清华大学出版社', 'Java项目开发案例全程实录（第2版）（配光盘）（软件项目开发全程实录丛书）', '200', 'book_img/20991549-1_w_1.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('7C0C785FFBEC4DEC802FA36E8B0BC87E', '深入分析Java Web技术内幕', '清华大学', '许令波', '机械电气', '1', '442', '746000', '16', 'PDF', '电子工业出版社', '深入分析Java Web技术内幕', '200', 'book_img/22881803-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('7CD79C20258F477AB841518D9312E843', 'Java程序员面试宝典（第三版）', '清华大学', '欧立奇', '机械电气', '1', '359', '446400', '16', 'PDF', '电子工业出版社', 'Java程序员面试宝典（第三版）', '200', 'book_img/23348683-1_w_1.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('7D7FE81293124793BDB2C6FF1F1C943D', '21天学通Java(第6版)（中文版累计销量超30000册）', '清华大学', 'Rogers Cadenhead', '机械电气', '1', '410', '781000', '16', 'PDF', '人民邮电出版社', '21天学通Java(第6版)（中文版累计销量超30000册）', '200', 'book_img/23219731-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('7FD7F50B15F74248AA769798909F8653', 'Java网络编程（第3版）——O’Reilly Java系列', '清华大学', '哈诺德', '机械电气', '1', '718', '668000', '16', 'PDF', '中国电力出版社', 'Java网络编程（第3版）——O’Reilly Java系列', '200', 'book_img/9062293-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('819FF56E4423462394E6F83882F78975', '学通Java Web的24堂课（配光盘）（软件开发羊皮卷）', '清华大学', '陈丹丹', '心理学', '1', '718', '1488000', '16', 'PDF', '清华大学出版社', '学通Java Web的24堂课（配光盘）（软件开发羊皮卷）', '200', 'book_img/21118835-1_w_1.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('81FADA99309342F4978D5C680B0C6E8C', 'Java入门很简单（配光盘）（入门很简单丛书）（打开Java编程之门 Java技术网推荐）', '清华大学', '李世民', '心理学', '1', '459', '745000', '16', 'PDF', '清华大学出版社', 'Java入门很简单（配光盘）（入门很简单丛书）（打开Java编程之门 Java技术网推荐）', '200', 'book_img/22839309-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('89A57D099EA14026A5C3D10CFC10C22C', 'Java 2实用教程（第4版）（21世纪高等学校计算机基础实用规划教材）', '清华大学', '耿祥义', '心理学', '4', '479', '782000', '16', 'PDF', '清华大学出版社', 'Java 2实用教程（第4版）（21世纪高等学校计算机基础实用规划教材）', '200', 'book_img/22844118-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('8A5B4042D5B14D6B87A34DABF327387F', 'Java核心技术 卷II：高级特性(第9版·英文版)(上、下册)', '清华大学', '霍斯特曼', '心理学', '1', '1118', '1370000', '16', 'PDF', '人民邮电出版社', 'Java核心技术 卷II：高级特性(第9版·英文版)(上、下册)', '200', 'book_img/23280478-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('8DD0ADF2665B40899E09ED2983DC3F7B', 'jQuery权威指南（被公认的权威的、易学的jQuery实战教程，多次重印，热销中）', '清华大学', '陶国荣', '心理学', '1', '385', '0', '16', 'PDF', '机械工业出版社', 'jQuery权威指南（被公认的权威的、易学的jQuery实战教程，多次重印，热销中）', '200', 'book_img/21006995-1_w_1.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('8E16D59BA4C34374A68029AE877613C4', '轻量级Java EE企业应用实战（第3版）：Struts 2＋Spring 3＋Hibernate整合开发(含CD光盘1张)', '清华大学', '李刚', '心理学', '1', '816', '1440000', '16', 'PDF', '电子工业出版社', '轻量级Java EE企业应用实战（第3版）：Struts 2＋Spring 3＋Hibernate整合开发(含CD光盘1张)', '200', 'book_img/22685703-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('8F1520F2CED94C679433B9C109E791CB', 'Java从入门到精通（实例版）（附光盘1张）（连续8月Java类全国零售排行前2名，14小时视频，732个经典实例、369项面试真题、616项测试史上最全资源库）', '清华大学', '明日科技', '心理学', '1', '548', '986000', '16', 'PDF', '清华大学出版社', 'Java从入门到精通（实例版）（附光盘1张）（连续8月Java类全国零售排行前2名，14小时视频，732个经典实例、369项面试真题、616项测试史上最全资源库）', '200', 'book_img/22862061-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('90E423DBE56042838806673DB3E86BD3', '《Spring技术内幕（第2版）》（畅销书全新升级，Spring类图书销量桂冠，从宏观和微观两个角度解析Spring架构设计和实现原理）', '清华大学', '计文柯', '心理学', '2', '399', '0', '16', 'PDF', '机械工业出版社', '《Spring技术内幕（第2版）》（畅销书全新升级，Spring类图书销量桂冠，从宏观和微观两个角度解析Spring架构设计和实现原理）', '200', 'book_img/22606836-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('926B8F31C5D04F61A72F66679A0CCFFD', 'JavaScript编程精解（华章程序员书库）（JavaScript之父高度评价并强力推荐，系统学习JS首选！）', '清华大学', '哈弗贝克', '心理学', '1', '162', '0', '16', 'PDF', '械工业出版社', 'JavaScript编程精解（华章程序员书库）（JavaScript之父高度评价并强力推荐，系统学习JS首选！）', '200', 'book_img/22873894-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('95AACC68D64D4D67B1E33E9EAC22B885', 'Head First Java（中文版）（JAVA经典畅销书 生动有趣 轻松学好JAVA）', '清华大学', '塞若', '心理学', '1', '689', '983000', '16', 'PDF', '中国电力出版社', 'Head First Java（中文版）（JAVA经典畅销书 生动有趣 轻松学好JAVA）', '200', 'book_img/9265169-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('97437DAD03FA456AA7D6154614A43B55', 'HTML、CSS、JavaScript网页制作从入门到精通（两万读者的选择，经久不衰的超级畅销书最新升级版！网页制作学习者入门必读经典！）', '清华大学', '刘西杰', '心理学', '1', '450', '705000', '16', 'PDF', '人民邮电出版社', 'HTML、CSS、JavaScript网页制作从入门到精通（两万读者的选择，经久不衰的超级畅销书最新升级版！网页制作学习者入门必读经典！）', '200', 'book_img/22928649-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('9923901FBF124623BC707920D8936BC8', 'JavaScript DOM编程艺术(第2版)', '清华大学', '基思', '心理学', '1', '286', '443000', '16', 'PDF', '人民邮电出版社', 'JavaScript DOM编程艺术(第2版)', '200', 'book_img/21049601-1_w_1.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('99BF63AC12AD48FCB673F1820888964E', 'Java Web开发实战1200例（第Ⅱ卷）（史上最全的“编程实例”类图书，代码分析、实例速查、练习巩固的绝好帮手）', '清华大学', '无', '心理学', '0', '0', '1746000', '16', 'PDF', '清华大学出版社', 'Java Web开发实战1200例（第Ⅱ卷）（史上最全的“编程实例”类图书，代码分析、实例速查、练习巩固的绝好帮手）', '200', 'book_img/21110929-1_w_1.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('9D257176A6934CB79427CEC37E69249F', '疯狂Ajax讲义（第3版）--jQuery/Ext JS/Prototype/DWR企业应用前端开发实战(含CD光盘1张)（畅销书升级版，企业应用前端开发实战指南）', '清华大学', '李刚', '心理学', '1', '624', '997000', '16', 'PDF', '电子工业出版社', '疯狂Ajax讲义（第3版）--jQuery/Ext JS/Prototype/DWR企业应用前端开发实战(含CD光盘1张)（畅销书升级版，企业应用前端开发实战指南）', '200', 'book_img/23184673-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('9FBD51A7C02D4F5B9862CD2EBBF5CA04', 'Flash ActionScript 3.0全站互动设计', '清华大学', '刘欢 ', '心理学', '1', '488', '760000', '16', 'PDF', '人民邮电出版社', 'Flash ActionScript 3.0全站互动设计', '200', 'book_img/22886581-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('9FF423101836438F874035A48498CF45', 'Java编程思想（英文版·第4版）', '清华大学', '埃克尔 ', '心理学', '1', '1482', '0', '16', 'PDF', '机械工业出版社', 'Java编程思想（英文版·第4版）', '200', 'book_img/9288920-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('A3D464D1D1344ED5983920B472826730', 'Java Web开发详解：XML+DTD+XML Schema+XSLT+Servlet 3 0+JSP 2 2深入剖析与实例应用(含CD光盘1张)', '清华大学', '孙鑫', '心理学', '1', '889', '1760000', '16', 'PDF', '电子工业出版社', 'Java Web开发详解：XML+DTD+XML Schema+XSLT+Servlet 3 0+JSP 2 2深入剖析与实例应用(含CD光盘1张)', '200', 'book_img/22788412-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('A46A0F48A4F649AE9008B38EA48FAEBA', 'Java编程全能词典(含DVD光盘2张)', '清华大学', '明日科技', '心理学', '1', '486', '496000', '32', 'PDF', '电子工业出版社', 'Java编程全能词典(含DVD光盘2张)', '200', 'book_img/20813806-1_w_1.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('A5A6F27DCD174614850B26633A0B4605', 'JavaScript模式', '清华大学', '斯特凡洛夫', '心理学', '1', '208', '253000', '16', 'PDF', '中国电力出版社', 'JavaScript模式', '200', 'book_img/22819430-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('A7220EF174704012830E066FDFAAD4AD', 'Spring 3.0就这么简单（国内原创的Java敏捷开发图书，展现作者Spring原创开源项目ROP开发的全过程，所有项目工程均以Maven组织）', '清华大学', '陈雄华', '心理学', '1', '380', '530000', '16', 'PDF', '人民邮电出版社', 'Spring 3.0就这么简单（国内原创的Java敏捷开发图书，展现作者Spring原创开源项目ROP开发的全过程，所有项目工程均以Maven组织）', '200', 'book_img/22938474-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('A7EFD99367C9434682A790635D3C5FDF', 'Java Web技术整合应用与项目实战（JSP+Servlet+Struts2+Hibernate+Spring3）', '清华大学', '张志锋', '心理学', '1', '878', '0', '16', 'PDF', '清华大学出版社', 'Java Web技术整合应用与项目实战（JSP+Servlet+Struts2+Hibernate+Spring3）', '200', 'book_img/23266270-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('A8EF76FD21A645109538614DEA85F3F7', 'Java语言程序设计：基础篇（原书第8版）', '清华大学', '梁勇', '电子信息', '1', '586', '0', '16', 'PDF', '机械工业出版社', 'Java语言程序设计：基础篇（原书第8版）', '200', 'book_img/21122188-1_w_1.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('AD6EA79CCB8240AAAF5B292AD7E5DCAA', 'jQuery Mobile权威指南（根据jQuery Mobile最新版本撰写的权威参考书！全面讲解jQuery Mobile的所有功能、特性、使用方法和开发技巧）', '清华大学', '陶国荣', '电子信息', '1', '249', '0', '16', 'PDF', '机械工业出版社', 'jQuery Mobile权威指南（根据jQuery Mobile最新版本撰写的权威参考书！全面讲解jQuery Mobile的所有功能、特性、使用方法和开发技巧）', '200', 'book_img/22847009-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('AE0935F13A214436B8599DE285A86220', 'JavaScript基础教程(第8版)(经典JavaScript入门书 涵盖Ajax和jQuery)', '清华大学', 'Tom Negrino　Dori Smith', '电子信息', '1', '392', '694000', '16', 'PDF', '人民邮电出版社', 'JavaScript基础教程(第8版)(经典JavaScript入门书 涵盖Ajax和jQuery)', '200', 'book_img/22717349-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('AF28ED8F692C4288B32CF411CBDBFC23', '经典Java EE企业应用实战——基于WebLogic/JBoss的JSF+EJB 3+JPA整合开发(含CD光盘1张)', '清华大学', '无', '电子信息', '1', '0', '0', '16', 'PDF', '电子工业出版社', '经典Java EE企业应用实战——基于WebLogic/JBoss的JSF+EJB 3+JPA整合开发(含CD光盘1张)', '200', 'book_img/20928547-1_w_1.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('B329A14DDEF8455F82B3FDF25821D2BB', '名师讲坛——Java Web开发实战经典基础篇（JSP、Servlet、Struts、Ajax）（32小时全真课堂培训，视频超级给力！390项实例及分析，北京魔乐科技培训中心Java Web全部精华）', '清华大学', '李兴华', '电子信息', '1', '554', '819000', '16', 'PDF', '清华大学出版社', '名师讲坛——Java Web开发实战经典基础篇（JSP、Servlet、Struts、Ajax）（32小时全真课堂培训，视频超级给力！390项实例及分析，北京魔乐科技培训中心Java Web全部精华）', '200', 'book_img/20915948-1_w_3.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('B7A7DA7A94E54054841EED1F70C3027C', '锋利的jQuery(第2版)(畅销书升级版，增加jQuery Mobile和性能优化)', '清华大学', '单东林', '电子信息', '2', '380', '598000', '16', 'PDF', '人民邮电出版社', '锋利的jQuery(第2版)(畅销书升级版，增加jQuery Mobile和性能优化)', '200', 'book_img/22786088-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('BD1CB005E4A04DCA881DA8689E21D4D0', 'jQuery UI开发指南', '清华大学', 'Eric Sarrion', '电子信息', '1', '212', '286000', '16', 'PDF', '人民邮电出版社', 'jQuery UI开发指南', '200', 'book_img/22910975-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('C23E6E8A6DB94E27B6E2ABD39DC21AF5', 'JavaScript:The Good Parts(影印版）', '清华大学', '克罗克福特', '电子信息', '1', '153', '181000', '16', 'PDF', '东南大学出版社', 'JavaScript:The Good Parts(影印版）', '200', 'book_img/20412979-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('C3CF52B3ED2D4187A16754551488D733', 'Java从入门到精通（附光盘）', '清华大学', '魔乐科技', '电子信息', '1', '519', '884000', '16', 'PDF', '人民邮电出版社', 'Java从入门到精通（附光盘）', '200', 'book_img/20810282-1_w_1.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('C86D3F6FACB449BEBD940D9307ED4A47', '编写高质量代码：改善Java程序的151个建议(从语法、程序设计和架构、工具和框架、编码风格、编程思想5个方面探讨编写高质量Java代码的技巧、禁忌和最佳实践)', '清华大学', '秦小波', '电子信息', '1', '303', '0', '16', 'PDF', '机械工业出版社', '编写高质量代码：改善Java程序的151个建议(从语法、程序设计和架构、工具和框架、编码风格、编程思想5个方面探讨编写高质量Java代码的技巧、禁忌和最佳实践)', '200', 'book_img/22579686-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('CB0AB3654945411EA69F368D0EA91A00', 'JavaScript语言精粹（修订版）', '清华大学', '道格拉斯·克罗克福德', '电子信息', '1', '155', '258000', '16', 'PDF', '电子工业出版社', 'JavaScript语言精粹（修订版）', '200', 'book_img/22872884-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('CD913617EE964D0DBAF20C60076D32FB', '名师讲坛——Java开发实战经典（配光盘）（60小时全真课堂培训，视频超级给力！790项实例及分析，北京魔乐科技培训中心Java全部精华）', '清华大学', '李兴华', '电子信息', '1', '831', '1222000', '16', 'PDF', '清华大学出版社', '名师讲坛——Java开发实战经典（配光盘）（60小时全真课堂培训，视频超级给力！790项实例及分析，北京魔乐科技培训中心Java全部精华）', '200', 'book_img/20637368-1_w_2.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('CE01F15D435A4C51B0AD8202A318DCA7', 'Java编程思想（第4版）', '清华大学', '布鲁斯.艾克尔', '电子信息', '1', '880', '0', '0', 'PDF', '机械工业出版社', 'Java编程思想（第4版）', '200', 'book_img/9317290-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('CF5546769F2842DABB2EF7A00D51F255', 'jQuery开发从入门到精通（配套视频327节，中小实例232个，实战案例7个商品详情手册11部，网页模版83类）（附1DVD）', '清华大学', '袁江', '电子信息', '1', '619', '1109000', '16', 'PDF', '清华大学出版社', 'jQuery开发从入门到精通（配套视频327节，中小实例232个，实战案例7个商品详情手册11部，网页模版83类）（附1DVD）', '200', 'book_img/23263012-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('D0DA36CEE42549FFB299B7C7129761D5', 'Java应用架构设计：模块化模式与OSGi(全球资深Java技术专家的力作，系统、全面地讲解如何将模块化设计思想引入开发中，涵盖18个有助于实现模块化软件架构的模式)', '清华大学', '克内恩席尔德', '电子信息', '1', '251', '0', '16', 'PDF', '机械工业出版社', 'Java应用架构设计：模块化模式与OSGi(全球资深Java技术专家的力作，系统、全面地讲解如何将模块化设计思想引入开发中，涵盖18个有助于实现模块化软件架构的模式)', '200', 'book_img/23339643-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('D0E69F85ACAB4C15BB40966E5AA545F1', 'Java并发编程实战（第16届Jolt大奖提名图书，Java并发编程必读佳作', '清华大学', 'Brian Goetz', '电子信息', '1', '290', '0', '32', 'PDF', '机械工业出版社', 'Java并发编程实战（第16届Jolt大奖提名图书，Java并发编程必读佳作', '200', 'book_img/22606835-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('D2ABA8B06C524632846F27C34568F3CE', 'Java 经典实例', '清华大学', '达尔文', '电子信息', '1', '784', '805000', '16', 'PDF', '中国电力出版社', 'Java 经典实例', '200', 'book_img/20500255-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('D8723405BA054C13B52357B8F6AEEC24', '深入理解Java虚拟机：JVM高级特性与最佳实践（第2版）', '清华大学', '周志明', '电子信息', '2', '433', '0', '16', 'PDF', '机械工业出版社', '深入理解Java虚拟机：JVM高级特性与最佳实践（第2版）', '200', 'book_img/23259731-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('DC36FD53A1514312A0A9ADD53A583886', 'JavaScript异步编程：设计快速响应的网络应用【掌握JavaScript异步编程必杀技，让代码更具响应度！ 】', '清华大学', 'Trevor Burnham ', '电子信息', '1', '118', '98000', '32', 'PDF', '人民邮电出版社', 'JavaScript异步编程：设计快速响应的网络应用【掌握JavaScript异步编程必杀技，让代码更具响应度！ 】', '200', 'book_img/23252196-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('DCB64DF0084E486EBF173F729A3A630A', 'Java设计模式(第2版)', '清华大学', 'Steven John Metsker', '电子信息', '1', '0', '0', '16', 'PDF', '电子工业出版社', 'Java设计模式(第2版)', '200', 'book_img/22868759-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('DEE7BDC7E0E343149E3C3601D2658171', '疯狂HTML 5/CSS 3/JavaScript讲义(含CD光盘1张)', '清华大学', '李刚', '电子信息', '1', '500', '819000', '16', 'PDF', '电子工业出版社', '疯狂HTML 5/CSS 3/JavaScript讲义(含CD光盘1张)', '200', 'book_img/22783904-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('DF4E74EEE89B43229BB8212F0B858C38', '精通Hibernate：Java对象持久化技术详解（第2版）(含光盘1张)', '清华大学', '孙卫琴', '电子信息', '1', '695', '1148800', '16', 'PDF', '电子工业出版社', '精通Hibernate：Java对象持久化技术详解（第2版）(含光盘1张)', '3000', 'book_img/20773347-1_w_1.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('E4F184188C8B4C7BB32D4E76603426AC', '疯狂Java讲义（第2版，附光盘）', '清华大学', '李刚', '电子信息', '1', '844', '1747000', '16', 'PDF', '电子工业出版社', '疯狂Java讲义（第2版，附光盘）', '200', 'book_img/22588603-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('EA695342393C4BE48B831FA5E6B0E5C4', '编写可维护的JavaScript《JavaScript高级程序设计》作者Nicholas Zakas最新力作，构建编码风格手册，帮助开发团队从“游击队”走向“正规军”）', '清华大学', 'Nicholas C. Zakas', '电子信息', '1', '227', '400000', '16', 'PDF', '人民邮电出版社', '编写可维护的JavaScript《JavaScript高级程序设计》作者Nicholas Zakas最新力作，构建编码风格手册，帮助开发团队从“游击队”走向“正规军”）', '200', 'book_img/23200995-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('F0E34313BF304CCEBF198BD4E05307B8', 'jQuery Cookbook中文版（jQuery之父鼎力推荐，社区数十位专家倾情力作', '清华大学', 'jQuery社区专家组', '电子信息', '1', '425', '573000', '16', 'PDF', '人民邮电出版社', 'jQuery Cookbook中文版（jQuery之父鼎力推荐，社区数十位专家倾情力作', '200', 'book_img/23219358-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('F6162799E913423EA5CB57BEC65AB1E9', 'JUnit实战(第2版)', '清华大学', '塔凯文', '电子信息', '1', '442', '640000', '16', 'PDF', '人民邮电出版社', 'JUnit实战(第2版)', '200', 'book_img/22633574-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('F693239BC3B3444C8538ABE7411BB38E', 'Java Web典型模块与项目实战大全（配光盘）', '清华大学', '常建功', '电子信息', '1', '922', '1473000', '16', 'PDF', '清华大学出版社', 'Java Web典型模块与项目实战大全（配光盘）', '200', 'book_img/20988080-1_w_1.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('F78C94641DB4475BBA1E72A07DF9B3AE', 'JAVA面向对象编程', '清华大学', '孙卫琴 ', '电子信息', '1', '625', '1030400', '16', 'PDF', '电子工业出版社', 'JAVA面向对象编程', '200', 'book_img/9186890-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('FC232CD9B6E6411BBBB1A5B781D2C3C9', 'Java与模式(含盘)（超多实例和习题，详解设计原则与设计模式）', '清华大学', '阎宏', '电子信息', '1', '1024', '16704000', '16', 'PDF', '电子工业出版社', 'Java与模式(含盘)（超多实例和习题，详解设计原则与设计模式）', '200', 'book_img/696673-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('FEC3740CF30E442A94021911A25EF0D7', 'Spring攻略(第2版)(Spring攻略(第2版))', '清华大学', 'Gary Mak　Josh Long　Daniel Rubio', '电子信息', '1', '938', '1322000', '16', 'PDF', '人民邮电出版社', 'Spring攻略(第2版)(Spring攻略(第2版))', '200', 'book_img/22623020-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_info` VALUES ('FFABBED1E5254BC0B2726EC4ED8ACCDA', '深入理解OSGi：Equinox原理、应用与最佳实践（《深入理解Java虚拟机》作者新作！全面解读最新OSGi R5.0规范，深入讲解OSGi原理和服务，以及Equinox框架的用法和原理）', '清华大学', '周志明', '电子信息', '1', '414', '0', '16', 'PDF', '机械工业出版社', '深入理解OSGi：Equinox原理、应用与最佳实践（《深入理解Java虚拟机》作者新作！全面解读最新OSGi R5.0规范，深入讲解OSGi原理和服务，以及Equinox框架的用法和原理）', '200', 'book_img/23179003-1_w.jpg', '2023-02-26 00:00:00', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');

-- ----------------------------
-- Table structure for t_book_lx
-- ----------------------------
DROP TABLE IF EXISTS `t_book_lx`;
CREATE TABLE `t_book_lx` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL COMMENT '名称',
  `status` int(5) DEFAULT '1',
  `ct` datetime DEFAULT CURRENT_TIMESTAMP,
  `ut` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_book_lx
-- ----------------------------
INSERT INTO `t_book_lx` VALUES ('1', '科技', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_lx` VALUES ('2', '文化', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_lx` VALUES ('3', '生物', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_lx` VALUES ('4', 'asfda', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_lx` VALUES ('6', 'dgfgn', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_lx` VALUES ('7', 'gjhfgj', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_lx` VALUES ('8', 'gjfg', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_lx` VALUES ('9', '25352', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_lx` VALUES ('10', 'dsgdsg', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_lx` VALUES ('11', 'juynrf', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_lx` VALUES ('12', '346', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_lx` VALUES ('13', '34634', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_lx` VALUES ('14', '4363463', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_lx` VALUES ('15', 'fsdsdg', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_lx` VALUES ('16', 'tryrey', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_lx` VALUES ('17', 'bgfgbfdg', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_lx` VALUES ('18', 'dgsdg', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_lx` VALUES ('19', 'fghtry', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_lx` VALUES ('20', 'hdfhsdb', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_lx` VALUES ('21', 'fdhertw', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_lx` VALUES ('22', 'hfdhdfh', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_lx` VALUES ('23', '测试为第三方', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
INSERT INTO `t_book_lx` VALUES ('24', '计算机与科学技术', '1', '2023-02-26 00:00:00', '2023-02-26 00:00:00');
