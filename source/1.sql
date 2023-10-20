-- bdp_schedule.bdp_job_script_info definition

CREATE TABLE `bdp_job_script_info` (
  `job_id` int(11) NOT NULL,
  `glue_source` mediumtext COMMENT 'GLUE源代码',
  `executor_param` varchar(512) DEFAULT NULL COMMENT '执行器任务参数',
  `address` varchar(64) DEFAULT NULL COMMENT '主执行器IP',
  `script_path` varchar(255) DEFAULT NULL COMMENT '脚本路径',
  `sql_content` mediumtext COMMENT 'GLUE源代码',
  `desc` varchar(128) DEFAULT NULL COMMENT '脚本描述',
  `database_name` varchar(255) DEFAULT NULL,
  `table_name` varchar(255) DEFAULT NULL,
  `table_tree` mediumtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='任务脚本信息';


-- bdp_schedule.bdp_job_table_info definition

CREATE TABLE `bdp_job_table_info` (
  `job_id` int(11) NOT NULL,
  `database_name` varchar(255) DEFAULT NULL,
  `table_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='任务数据表信息';


-- bdp_schedule.clear_tables definition

CREATE TABLE `clear_tables` (
  `table_name` varchar(100) DEFAULT NULL,
  `file_path` varchar(500) DEFAULT NULL,
  `job_id` int(11) DEFAULT NULL,
  `desc` varchar(500) DEFAULT NULL,
  `author` varchar(20) DEFAULT NULL,
  `ori` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- bdp_schedule.clear_tables_hive definition

CREATE TABLE `clear_tables_hive` (
  `table_name` varchar(100) DEFAULT NULL,
  `size` float DEFAULT NULL,
  `type` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- bdp_schedule.clear_tables_mysql definition

CREATE TABLE `clear_tables_mysql` (
  `table_name` varchar(100) DEFAULT NULL,
  `size` float(12,5) DEFAULT NULL,
  `type` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- bdp_schedule.config definition

CREATE TABLE `config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tablename` varchar(255) NOT NULL,
  `sourcetable` text,
  `tablecolumns` text,
  `sourcecolumns` text,
  `column_cnv` text,
  `column_roles` text,
  `perimarykeys` text,
  `hdfspath` text,
  `type` text,
  `from_tab_name` varchar(255) DEFAULT NULL COMMENT '原始表名',
  `bussiness_name` varchar(255) DEFAULT NULL COMMENT '企业英文简称',
  `cron` varchar(255) DEFAULT NULL COMMENT '抽取数据cron时间',
  `tablename_chs` varchar(255) DEFAULT NULL COMMENT '表中文名',
  `inc_conditions` varchar(255) DEFAULT NULL COMMENT '增量条件',
  `extract_rate` varchar(255) DEFAULT NULL COMMENT '抽取频率',
  `data_str_time` varchar(255) DEFAULT NULL COMMENT '数据起始时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- bdp_schedule.help_topic definition

CREATE TABLE `help_topic` (
  `help_topic_id` int(10) unsigned NOT NULL,
  `name` char(64) NOT NULL,
  `help_category_id` smallint(5) unsigned NOT NULL,
  `description` text NOT NULL,
  `example` text NOT NULL,
  `url` text NOT NULL,
  PRIMARY KEY (`help_topic_id`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='help topics';


-- bdp_schedule.jira_lixiang_info definition

CREATE TABLE `jira_lixiang_info` (
  `project_num` varchar(20) NOT NULL COMMENT '立项号',
  `summary` varchar(500) DEFAULT NULL COMMENT '立项Title',
  `description` text COMMENT '立项描述',
  `issue_type` varchar(100) DEFAULT NULL COMMENT '需求类型（基础保障、优化、新需求）',
  `mokuai` varchar(100) DEFAULT NULL COMMENT '业务部门',
  `reporter_email` varchar(100) DEFAULT NULL,
  `issue_status` varchar(50) DEFAULT NULL COMMENT '立项状态',
  `rentian` varchar(10) DEFAULT NULL COMMENT '人天',
  `rentian_des` text COMMENT '人天描述',
  `yewufuzeren` varchar(100) DEFAULT NULL COMMENT '业务负责人',
  `bu` varchar(100) DEFAULT NULL COMMENT '立项所属BU',
  `qidongshijian` varchar(100) DEFAULT NULL COMMENT '启动时间',
  `jiaofushijian` varchar(100) DEFAULT NULL COMMENT '交付时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- bdp_schedule.job_monitor definition

CREATE TABLE `job_monitor` (
  `id` int(20) DEFAULT NULL,
  `hive_id` varchar(50) DEFAULT NULL,
  `job_desc` varchar(255) DEFAULT NULL,
  `title` varchar(20) DEFAULT NULL,
  `alarm_description` varchar(255) DEFAULT NULL,
  `trigger_time` datetime DEFAULT NULL,
  `author` varchar(65) DEFAULT NULL,
  `alarm_email` varchar(255) DEFAULT NULL,
  `phone` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- bdp_schedule.job_script_info definition

CREATE TABLE `job_script_info` (
  `job_id` int(11) NOT NULL COMMENT '任务id',
  `script` varchar(255) DEFAULT NULL COMMENT '脚本地址',
  `author` varchar(64) DEFAULT NULL COMMENT '作者',
  `content` longtext COMMENT '脚本内容',
  `createDate` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='任务脚本信息';


-- bdp_schedule.job_state_table definition

CREATE TABLE `job_state_table` (
  `job_id` int(11) NOT NULL COMMENT '作业id',
  `job_group` int(11) NOT NULL COMMENT '调度器id',
  `job_state` varchar(30) NOT NULL COMMENT '作业状态：RUN/PAUSED/ERROR/COMPLETE/STOP/NORMAL',
  `parent_time` varchar(30) DEFAULT NULL,
  `run_time` varchar(30) DEFAULT NULL COMMENT '启动时间',
  `end_time` varchar(30) DEFAULT NULL COMMENT '停止时间',
  `user_id` int(30) DEFAULT NULL COMMENT '操作人id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- bdp_schedule.job_state_table_20190403 definition

CREATE TABLE `job_state_table_20190403` (
  `job_id` int(11) NOT NULL COMMENT '作业id',
  `job_group` int(11) NOT NULL COMMENT '调度器id',
  `job_state` varchar(30) NOT NULL COMMENT '作业状态：RUN/PAUSED/ERROR/COMPLETE/STOP/NORMAL',
  `parent_time` varchar(30) DEFAULT NULL,
  `run_time` varchar(30) DEFAULT NULL COMMENT '启动时间',
  `end_time` varchar(30) DEFAULT NULL COMMENT '停止时间',
  `user_id` int(30) DEFAULT NULL COMMENT '操作人id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- bdp_schedule.job_trigger_script_path definition

CREATE TABLE `job_trigger_script_path` (
  `title` varchar(255) DEFAULT NULL COMMENT '执行器名称',
  `ip` varchar(255) DEFAULT NULL COMMENT '主服务器IP',
  `ip_list` varchar(255) DEFAULT NULL,
  `path_list` text COMMENT '文件路径列表，多地址逗号分隔',
  `user_name` varchar(255) DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) DEFAULT NULL COMMENT '密码'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='执行器脚本路径信息';


-- bdp_schedule.keyjobinfo definition

CREATE TABLE `keyjobinfo` (
  `job_id` int(11) DEFAULT NULL,
  `job_desc` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- bdp_schedule.ods_zw_caiyang definition

CREATE TABLE `ods_zw_caiyang` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `xuhao` int(10) DEFAULT NULL,
  `zw_name` varchar(255) DEFAULT NULL,
  `ods_name` varchar(255) DEFAULT NULL,
  `data_from` varchar(255) DEFAULT NULL,
  `status` int(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8;


-- bdp_schedule.sys_menu definition

CREATE TABLE `sys_menu` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `parent_id` varchar(64) NOT NULL COMMENT '父级编号',
  `parent_ids` varchar(2000) NOT NULL COMMENT '所有父级编号',
  `name` varchar(100) NOT NULL COMMENT '名称',
  `sort` decimal(10,0) NOT NULL COMMENT '排序',
  `href` varchar(2000) DEFAULT NULL COMMENT '链接',
  `target` varchar(20) DEFAULT NULL COMMENT '目标',
  `icon` varchar(100) DEFAULT NULL COMMENT '图标',
  `is_show` varchar(1) NOT NULL COMMENT '是否在菜单中显示',
  `permission` varchar(200) DEFAULT NULL COMMENT '权限标识',
  `create_by` varchar(64) NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` varchar(1) NOT NULL DEFAULT '0' COMMENT '删除标记',
  `menu_level` int(3) NOT NULL DEFAULT '0' COMMENT '标签等级',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `menuid` (`id`) USING BTREE,
  KEY `sys_menu_parent_id` (`parent_id`) USING BTREE,
  KEY `sys_menu_del_flag` (`del_flag`) USING BTREE,
  KEY `names` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='菜单表';


-- bdp_schedule.sys_role definition

CREATE TABLE `sys_role` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `name` varchar(100) NOT NULL COMMENT '角色名称',
  `enname` varchar(255) DEFAULT NULL COMMENT '英文名称',
  `role_type` varchar(255) DEFAULT NULL COMMENT '角色类型',
  `useable` varchar(64) DEFAULT NULL COMMENT '是否可用',
  `create_by` varchar(64) NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` int(1) NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `sys_role_del_flag` (`del_flag`) USING BTREE,
  KEY `sys_role_enname` (`enname`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色表';


-- bdp_schedule.sys_role_menu definition

CREATE TABLE `sys_role_menu` (
  `role_id` varchar(64) NOT NULL COMMENT '角色编号',
  `menu_id` varchar(64) NOT NULL COMMENT '菜单编号',
  PRIMARY KEY (`role_id`,`menu_id`) USING BTREE,
  KEY `roleids` (`role_id`) USING BTREE,
  KEY `menuid` (`menu_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色-菜单';


-- bdp_schedule.sys_user definition

CREATE TABLE `sys_user` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `login_name` varchar(100) NOT NULL COMMENT '登录名',
  `password` varchar(100) NOT NULL COMMENT '密码',
  `name` varchar(100) NOT NULL COMMENT '姓名',
  `email` varchar(200) DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(200) DEFAULT NULL COMMENT '电话',
  `mobile` varchar(200) DEFAULT NULL COMMENT '手机',
  `user_type` varchar(3200) DEFAULT NULL COMMENT '用户类型',
  `login_ip` varchar(100) DEFAULT NULL COMMENT '最后登陆IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登陆时间',
  `create_by` varchar(64) NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` varchar(1) NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `sys_user_login_name` (`login_name`) USING BTREE,
  KEY `sys_user_update_date` (`update_date`) USING BTREE,
  KEY `sys_user_del_flag` (`del_flag`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户表';


-- bdp_schedule.sys_user_role definition

CREATE TABLE `sys_user_role` (
  `user_id` varchar(64) NOT NULL COMMENT '用户编号',
  `role_id` varchar(64) NOT NULL COMMENT '角色编号',
  PRIMARY KEY (`user_id`,`role_id`) USING BTREE,
  KEY `roleid` (`role_id`) USING BTREE,
  KEY `userid` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户-角色';


-- bdp_schedule.t_job_hdfs definition

CREATE TABLE `t_job_hdfs` (
  `data_from` varchar(255) DEFAULT NULL,
  `hdfs_sum` varchar(255) DEFAULT NULL,
  `every_day` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- bdp_schedule.t_job_task definition

CREATE TABLE `t_job_task` (
  `xuhao` int(11) DEFAULT NULL,
  `company` varchar(255) DEFAULT NULL,
  `max_time` varchar(20) DEFAULT NULL,
  `every_day` varchar(255) DEFAULT NULL,
  `shuliang` varchar(255) DEFAULT NULL,
  `no_shuliang` varchar(255) DEFAULT NULL,
  `zhuangtai` varchar(255) DEFAULT NULL,
  `data_from` varchar(255) DEFAULT NULL,
  `renwu_qk` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- bdp_schedule.tmp_new definition

CREATE TABLE `tmp_new` (
  `id` int(11) NOT NULL DEFAULT '0',
  `job_desc` text NOT NULL,
  `title` varchar(128) DEFAULT NULL COMMENT '执行器名称',
  `parent_jobid_2` mediumtext,
  `parent_job_desc` text,
  `tst` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- bdp_schedule.tmp_old definition

CREATE TABLE `tmp_old` (
  `id` int(11) NOT NULL DEFAULT '0',
  `job_desc` text NOT NULL,
  `title` varchar(128) DEFAULT NULL COMMENT '执行器名称',
  `parent_jobid_2` mediumtext,
  `parent_job_desc` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- bdp_schedule.xxl_action_log definition

CREATE TABLE `xxl_action_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userName` varchar(50) DEFAULT NULL COMMENT '用户名',
  `url` text COMMENT '访问的Url',
  `ip` varchar(50) DEFAULT NULL COMMENT '用户的Ip地址',
  `methodName` varchar(100) DEFAULT NULL COMMENT '访问方法名称',
  `createDate` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `msg` text COMMENT '操作内容',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4921356 DEFAULT CHARSET=utf8;


-- bdp_schedule.xxl_action_log_select_rule definition

CREATE TABLE `xxl_action_log_select_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plan_id` varchar(50) NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `job_id` varchar(11) DEFAULT NULL,
  `msg` text,
  `status` varchar(100) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `ip` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=364062 DEFAULT CHARSET=utf8;


-- bdp_schedule.xxl_job_qrtz_calendars definition

CREATE TABLE `xxl_job_qrtz_calendars` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `CALENDAR_NAME` varchar(200) NOT NULL,
  `CALENDAR` blob NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`CALENDAR_NAME`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- bdp_schedule.xxl_job_qrtz_fired_triggers definition

CREATE TABLE `xxl_job_qrtz_fired_triggers` (
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
  PRIMARY KEY (`SCHED_NAME`,`ENTRY_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- bdp_schedule.xxl_job_qrtz_job_details definition

CREATE TABLE `xxl_job_qrtz_job_details` (
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
  PRIMARY KEY (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- bdp_schedule.xxl_job_qrtz_locks definition

CREATE TABLE `xxl_job_qrtz_locks` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `LOCK_NAME` varchar(40) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`LOCK_NAME`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- bdp_schedule.xxl_job_qrtz_paused_trigger_grps definition

CREATE TABLE `xxl_job_qrtz_paused_trigger_grps` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_GROUP`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- bdp_schedule.xxl_job_qrtz_scheduler_state definition

CREATE TABLE `xxl_job_qrtz_scheduler_state` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL,
  `CHECKIN_INTERVAL` bigint(13) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`INSTANCE_NAME`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- bdp_schedule.xxl_job_qrtz_trigger_group definition

CREATE TABLE `xxl_job_qrtz_trigger_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_name` varchar(128) NOT NULL COMMENT '执行器AppName',
  `title` varchar(128) NOT NULL COMMENT '执行器名称',
  `order` tinyint(4) NOT NULL DEFAULT '0' COMMENT '排序',
  `address_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '执行器地址类型：0=自动注册、1=手动录入',
  `address_list` varchar(512) DEFAULT NULL COMMENT '执行器地址列表，多地址逗号分隔',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=276 DEFAULT CHARSET=utf8;


-- bdp_schedule.xxl_job_qrtz_trigger_group_copy definition

CREATE TABLE `xxl_job_qrtz_trigger_group_copy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_name` varchar(128) NOT NULL COMMENT '执行器AppName',
  `title` varchar(128) NOT NULL COMMENT '执行器名称',
  `order` tinyint(4) NOT NULL DEFAULT '0' COMMENT '排序',
  `address_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '执行器地址类型：0=自动注册、1=手动录入',
  `address_list` varchar(512) DEFAULT NULL COMMENT '执行器地址列表，多地址逗号分隔',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=249 DEFAULT CHARSET=utf8;


-- bdp_schedule.xxl_job_qrtz_trigger_info definition

CREATE TABLE `xxl_job_qrtz_trigger_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_group` int(11) NOT NULL COMMENT '执行器主键ID',
  `job_cron` varchar(128) NOT NULL COMMENT '任务执行CRON',
  `job_desc` text NOT NULL,
  `add_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `author` varchar(64) DEFAULT NULL COMMENT '作者',
  `alarm_email` varchar(500) DEFAULT NULL COMMENT '报警邮件',
  `executor_route_strategy` varchar(50) DEFAULT NULL COMMENT '执行器路由策略',
  `executor_handler` varchar(255) DEFAULT NULL COMMENT '执行器任务handler',
  `executor_param` varchar(512) DEFAULT NULL COMMENT '执行器任务参数',
  `executor_block_strategy` varchar(50) DEFAULT NULL COMMENT '阻塞处理策略',
  `executor_fail_strategy` varchar(50) DEFAULT NULL COMMENT '失败处理策略',
  `glue_type` varchar(50) NOT NULL COMMENT 'GLUE类型',
  `glue_source` mediumtext COMMENT 'GLUE源代码',
  `glue_remark` varchar(128) DEFAULT NULL COMMENT 'GLUE备注',
  `glue_updatetime` datetime DEFAULT NULL COMMENT 'GLUE更新时间',
  `child_jobid` text COMMENT '子任务ID，多个逗号分隔',
  `parent_jobid` text COMMENT '父任务id，多个以逗号分隔',
  `again_num` varchar(5) DEFAULT NULL COMMENT '失败重试次数',
  `again_time` int(100) DEFAULT NULL COMMENT '失败重试间隔时间',
  `executor_timeout` int(11) NOT NULL DEFAULT '0' COMMENT '任务执行超时时间，单位秒',
  `nums` int(5) NOT NULL DEFAULT '0' COMMENT '重试次数',
  `job_source` varchar(20) DEFAULT NULL,
  `task_business` varchar(50) DEFAULT NULL COMMENT '任务所属业务域',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=58214 DEFAULT CHARSET=utf8;


-- bdp_schedule.xxl_job_qrtz_trigger_info_20210804 definition

CREATE TABLE `xxl_job_qrtz_trigger_info_20210804` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_group` int(11) NOT NULL COMMENT '执行器主键ID',
  `job_cron` varchar(128) NOT NULL COMMENT '任务执行CRON',
  `job_desc` text NOT NULL,
  `add_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `author` varchar(64) DEFAULT NULL COMMENT '作者',
  `alarm_email` varchar(255) DEFAULT NULL COMMENT '报警邮件',
  `executor_route_strategy` varchar(50) DEFAULT NULL COMMENT '执行器路由策略',
  `executor_handler` varchar(255) DEFAULT NULL COMMENT '执行器任务handler',
  `executor_param` varchar(512) DEFAULT NULL COMMENT '执行器任务参数',
  `executor_block_strategy` varchar(50) DEFAULT NULL COMMENT '阻塞处理策略',
  `executor_fail_strategy` varchar(50) DEFAULT NULL COMMENT '失败处理策略',
  `glue_type` varchar(50) NOT NULL COMMENT 'GLUE类型',
  `glue_source` mediumtext COMMENT 'GLUE源代码',
  `glue_remark` varchar(128) DEFAULT NULL COMMENT 'GLUE备注',
  `glue_updatetime` datetime DEFAULT NULL COMMENT 'GLUE更新时间',
  `child_jobid` text COMMENT '子任务ID，多个逗号分隔',
  `parent_jobid` text COMMENT '父任务id，多个以逗号分隔',
  `again_num` varchar(5) DEFAULT NULL COMMENT '失败重试次数',
  `again_time` int(100) DEFAULT NULL COMMENT '失败重试间隔时间',
  `executor_timeout` int(11) NOT NULL DEFAULT '0' COMMENT '任务执行超时时间，单位秒',
  `nums` int(5) NOT NULL DEFAULT '0' COMMENT '重试次数',
  `job_source` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40021 DEFAULT CHARSET=utf8;


-- bdp_schedule.xxl_job_qrtz_trigger_info_20210824 definition

CREATE TABLE `xxl_job_qrtz_trigger_info_20210824` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_group` int(11) NOT NULL COMMENT '执行器主键ID',
  `job_cron` varchar(128) NOT NULL COMMENT '任务执行CRON',
  `job_desc` text NOT NULL,
  `add_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `author` varchar(64) DEFAULT NULL COMMENT '作者',
  `alarm_email` varchar(500) DEFAULT NULL COMMENT '报警邮件',
  `executor_route_strategy` varchar(50) DEFAULT NULL COMMENT '执行器路由策略',
  `executor_handler` varchar(255) DEFAULT NULL COMMENT '执行器任务handler',
  `executor_param` varchar(512) DEFAULT NULL COMMENT '执行器任务参数',
  `executor_block_strategy` varchar(50) DEFAULT NULL COMMENT '阻塞处理策略',
  `executor_fail_strategy` varchar(50) DEFAULT NULL COMMENT '失败处理策略',
  `glue_type` varchar(50) NOT NULL COMMENT 'GLUE类型',
  `glue_source` mediumtext COMMENT 'GLUE源代码',
  `glue_remark` varchar(128) DEFAULT NULL COMMENT 'GLUE备注',
  `glue_updatetime` datetime DEFAULT NULL COMMENT 'GLUE更新时间',
  `child_jobid` text COMMENT '子任务ID，多个逗号分隔',
  `parent_jobid` text COMMENT '父任务id，多个以逗号分隔',
  `again_num` varchar(5) DEFAULT NULL COMMENT '失败重试次数',
  `again_time` int(100) DEFAULT NULL COMMENT '失败重试间隔时间',
  `executor_timeout` int(11) NOT NULL DEFAULT '0' COMMENT '任务执行超时时间，单位秒',
  `nums` int(5) NOT NULL DEFAULT '0' COMMENT '重试次数',
  `job_source` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43535 DEFAULT CHARSET=utf8;


-- bdp_schedule.xxl_job_qrtz_trigger_info_20210906_lblv definition

CREATE TABLE `xxl_job_qrtz_trigger_info_20210906_lblv` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_group` int(11) NOT NULL COMMENT '执行器主键ID',
  `job_cron` varchar(128) NOT NULL COMMENT '任务执行CRON',
  `job_desc` text NOT NULL,
  `add_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `author` varchar(64) DEFAULT NULL COMMENT '作者',
  `alarm_email` varchar(500) DEFAULT NULL COMMENT '报警邮件',
  `executor_route_strategy` varchar(50) DEFAULT NULL COMMENT '执行器路由策略',
  `executor_handler` varchar(255) DEFAULT NULL COMMENT '执行器任务handler',
  `executor_param` varchar(512) DEFAULT NULL COMMENT '执行器任务参数',
  `executor_block_strategy` varchar(50) DEFAULT NULL COMMENT '阻塞处理策略',
  `executor_fail_strategy` varchar(50) DEFAULT NULL COMMENT '失败处理策略',
  `glue_type` varchar(50) NOT NULL COMMENT 'GLUE类型',
  `glue_source` mediumtext COMMENT 'GLUE源代码',
  `glue_remark` varchar(128) DEFAULT NULL COMMENT 'GLUE备注',
  `glue_updatetime` datetime DEFAULT NULL COMMENT 'GLUE更新时间',
  `child_jobid` text COMMENT '子任务ID，多个逗号分隔',
  `parent_jobid` text COMMENT '父任务id，多个以逗号分隔',
  `again_num` varchar(5) DEFAULT NULL COMMENT '失败重试次数',
  `again_time` int(100) DEFAULT NULL COMMENT '失败重试间隔时间',
  `executor_timeout` int(11) NOT NULL DEFAULT '0' COMMENT '任务执行超时时间，单位秒',
  `nums` int(5) NOT NULL DEFAULT '0' COMMENT '重试次数',
  `job_source` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46564 DEFAULT CHARSET=utf8;


-- bdp_schedule.xxl_job_qrtz_trigger_info_20220719 definition

CREATE TABLE `xxl_job_qrtz_trigger_info_20220719` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_group` int(11) NOT NULL COMMENT '执行器主键ID',
  `job_cron` varchar(128) NOT NULL COMMENT '任务执行CRON',
  `job_desc` text NOT NULL,
  `add_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `author` varchar(64) DEFAULT NULL COMMENT '作者',
  `alarm_email` varchar(500) DEFAULT NULL COMMENT '报警邮件',
  `executor_route_strategy` varchar(50) DEFAULT NULL COMMENT '执行器路由策略',
  `executor_handler` varchar(255) DEFAULT NULL COMMENT '执行器任务handler',
  `executor_param` varchar(512) DEFAULT NULL COMMENT '执行器任务参数',
  `executor_block_strategy` varchar(50) DEFAULT NULL COMMENT '阻塞处理策略',
  `executor_fail_strategy` varchar(50) DEFAULT NULL COMMENT '失败处理策略',
  `glue_type` varchar(50) NOT NULL COMMENT 'GLUE类型',
  `glue_source` mediumtext COMMENT 'GLUE源代码',
  `glue_remark` varchar(128) DEFAULT NULL COMMENT 'GLUE备注',
  `glue_updatetime` datetime DEFAULT NULL COMMENT 'GLUE更新时间',
  `child_jobid` text COMMENT '子任务ID，多个逗号分隔',
  `parent_jobid` text COMMENT '父任务id，多个以逗号分隔',
  `again_num` varchar(5) DEFAULT NULL COMMENT '失败重试次数',
  `again_time` int(100) DEFAULT NULL COMMENT '失败重试间隔时间',
  `executor_timeout` int(11) NOT NULL DEFAULT '0' COMMENT '任务执行超时时间，单位秒',
  `nums` int(5) NOT NULL DEFAULT '0' COMMENT '重试次数',
  `job_source` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53505 DEFAULT CHARSET=utf8;


-- bdp_schedule.xxl_job_qrtz_trigger_info_bak definition

CREATE TABLE `xxl_job_qrtz_trigger_info_bak` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_group` int(11) NOT NULL COMMENT '执行器主键ID',
  `job_cron` varchar(128) NOT NULL COMMENT '任务执行CRON',
  `job_desc` text NOT NULL,
  `add_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `author` varchar(64) DEFAULT NULL COMMENT '作者',
  `alarm_email` varchar(500) DEFAULT NULL COMMENT '报警邮件',
  `executor_route_strategy` varchar(50) DEFAULT NULL COMMENT '执行器路由策略',
  `executor_handler` varchar(255) DEFAULT NULL COMMENT '执行器任务handler',
  `executor_param` varchar(512) DEFAULT NULL COMMENT '执行器任务参数',
  `executor_block_strategy` varchar(50) DEFAULT NULL COMMENT '阻塞处理策略',
  `executor_fail_strategy` varchar(50) DEFAULT NULL COMMENT '失败处理策略',
  `glue_type` varchar(50) NOT NULL COMMENT 'GLUE类型',
  `glue_source` mediumtext COMMENT 'GLUE源代码',
  `glue_remark` varchar(128) DEFAULT NULL COMMENT 'GLUE备注',
  `glue_updatetime` datetime DEFAULT NULL COMMENT 'GLUE更新时间',
  `child_jobid` text COMMENT '子任务ID，多个逗号分隔',
  `parent_jobid` text COMMENT '父任务id，多个以逗号分隔',
  `again_num` varchar(5) DEFAULT NULL COMMENT '失败重试次数',
  `again_time` int(100) DEFAULT NULL COMMENT '失败重试间隔时间',
  `executor_timeout` int(11) NOT NULL DEFAULT '0' COMMENT '任务执行超时时间，单位秒',
  `nums` int(5) NOT NULL DEFAULT '0' COMMENT '重试次数',
  `job_source` varchar(20) DEFAULT NULL,
  `task_business` varchar(50) DEFAULT NULL COMMENT '任务所属业务域',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=58213 DEFAULT CHARSET=utf8;


-- bdp_schedule.xxl_job_qrtz_trigger_info_copy definition

CREATE TABLE `xxl_job_qrtz_trigger_info_copy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_group` int(11) NOT NULL COMMENT '执行器主键ID',
  `job_cron` varchar(128) NOT NULL COMMENT '任务执行CRON',
  `job_desc` text NOT NULL,
  `add_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `author` varchar(64) DEFAULT NULL COMMENT '作者',
  `alarm_email` varchar(500) DEFAULT NULL COMMENT '报警邮件',
  `executor_route_strategy` varchar(50) DEFAULT NULL COMMENT '执行器路由策略',
  `executor_handler` varchar(255) DEFAULT NULL COMMENT '执行器任务handler',
  `executor_param` varchar(512) DEFAULT NULL COMMENT '执行器任务参数',
  `executor_block_strategy` varchar(50) DEFAULT NULL COMMENT '阻塞处理策略',
  `executor_fail_strategy` varchar(50) DEFAULT NULL COMMENT '失败处理策略',
  `glue_type` varchar(50) NOT NULL COMMENT 'GLUE类型',
  `glue_source` mediumtext COMMENT 'GLUE源代码',
  `glue_remark` varchar(128) DEFAULT NULL COMMENT 'GLUE备注',
  `glue_updatetime` datetime DEFAULT NULL COMMENT 'GLUE更新时间',
  `child_jobid` text COMMENT '子任务ID，多个逗号分隔',
  `parent_jobid` text COMMENT '父任务id，多个以逗号分隔',
  `again_num` varchar(5) DEFAULT NULL COMMENT '失败重试次数',
  `again_time` int(100) DEFAULT NULL COMMENT '失败重试间隔时间',
  `executor_timeout` int(11) NOT NULL DEFAULT '0' COMMENT '任务执行超时时间，单位秒',
  `nums` int(5) NOT NULL DEFAULT '0' COMMENT '重试次数',
  `job_source` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43519 DEFAULT CHARSET=utf8;


-- bdp_schedule.xxl_job_qrtz_trigger_info_dongkun definition

CREATE TABLE `xxl_job_qrtz_trigger_info_dongkun` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_group` int(11) NOT NULL COMMENT '执行器主键ID',
  `job_cron` varchar(128) NOT NULL COMMENT '任务执行CRON',
  `job_desc` text NOT NULL,
  `add_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `author` varchar(64) DEFAULT NULL COMMENT '作者',
  `alarm_email` varchar(255) DEFAULT NULL COMMENT '报警邮件',
  `executor_route_strategy` varchar(50) DEFAULT NULL COMMENT '执行器路由策略',
  `executor_handler` varchar(255) DEFAULT NULL COMMENT '执行器任务handler',
  `executor_param` varchar(512) DEFAULT NULL COMMENT '执行器任务参数',
  `executor_block_strategy` varchar(50) DEFAULT NULL COMMENT '阻塞处理策略',
  `executor_fail_strategy` varchar(50) DEFAULT NULL COMMENT '失败处理策略',
  `glue_type` varchar(50) NOT NULL COMMENT 'GLUE类型',
  `glue_source` mediumtext COMMENT 'GLUE源代码',
  `glue_remark` varchar(128) DEFAULT NULL COMMENT 'GLUE备注',
  `glue_updatetime` datetime DEFAULT NULL COMMENT 'GLUE更新时间',
  `child_jobid` text COMMENT '子任务ID，多个逗号分隔',
  `parent_jobid` text COMMENT '父任务id，多个以逗号分隔',
  `again_num` varchar(5) DEFAULT NULL COMMENT '失败重试次数',
  `again_time` int(100) DEFAULT NULL COMMENT '失败重试间隔时间',
  `executor_timeout` int(11) NOT NULL DEFAULT '0' COMMENT '任务执行超时时间，单位秒',
  `nums` int(5) NOT NULL DEFAULT '0' COMMENT '重试次数',
  `job_source` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31965 DEFAULT CHARSET=utf8;


-- bdp_schedule.xxl_job_qrtz_trigger_info_kdong definition

CREATE TABLE `xxl_job_qrtz_trigger_info_kdong` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_group` int(11) NOT NULL COMMENT '执行器主键ID',
  `job_cron` varchar(128) NOT NULL COMMENT '任务执行CRON',
  `job_desc` text NOT NULL,
  `add_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `author` varchar(64) DEFAULT NULL COMMENT '作者',
  `alarm_email` varchar(255) DEFAULT NULL COMMENT '报警邮件',
  `executor_route_strategy` varchar(50) DEFAULT NULL COMMENT '执行器路由策略',
  `executor_handler` varchar(255) DEFAULT NULL COMMENT '执行器任务handler',
  `executor_param` varchar(512) DEFAULT NULL COMMENT '执行器任务参数',
  `executor_block_strategy` varchar(50) DEFAULT NULL COMMENT '阻塞处理策略',
  `executor_fail_strategy` varchar(50) DEFAULT NULL COMMENT '失败处理策略',
  `glue_type` varchar(50) NOT NULL COMMENT 'GLUE类型',
  `glue_source` mediumtext COMMENT 'GLUE源代码',
  `glue_remark` varchar(128) DEFAULT NULL COMMENT 'GLUE备注',
  `glue_updatetime` datetime DEFAULT NULL COMMENT 'GLUE更新时间',
  `child_jobid` text COMMENT '子任务ID，多个逗号分隔',
  `parent_jobid` text COMMENT '父任务id，多个以逗号分隔',
  `again_num` varchar(5) DEFAULT NULL COMMENT '失败重试次数',
  `again_time` int(100) DEFAULT NULL COMMENT '失败重试间隔时间',
  `executor_timeout` int(11) NOT NULL DEFAULT '0' COMMENT '任务执行超时时间，单位秒',
  `nums` int(5) NOT NULL DEFAULT '0' COMMENT '重试次数',
  `job_source` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35122 DEFAULT CHARSET=utf8;


-- bdp_schedule.xxl_job_qrtz_trigger_info_lblv definition

CREATE TABLE `xxl_job_qrtz_trigger_info_lblv` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_group` int(11) NOT NULL COMMENT '执行器主键ID',
  `job_cron` varchar(128) NOT NULL COMMENT '任务执行CRON',
  `job_desc` text NOT NULL,
  `add_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `author` varchar(64) DEFAULT NULL COMMENT '作者',
  `alarm_email` varchar(255) DEFAULT NULL COMMENT '报警邮件',
  `executor_route_strategy` varchar(50) DEFAULT NULL COMMENT '执行器路由策略',
  `executor_handler` varchar(255) DEFAULT NULL COMMENT '执行器任务handler',
  `executor_param` varchar(512) DEFAULT NULL COMMENT '执行器任务参数',
  `executor_block_strategy` varchar(50) DEFAULT NULL COMMENT '阻塞处理策略',
  `executor_fail_strategy` varchar(50) DEFAULT NULL COMMENT '失败处理策略',
  `glue_type` varchar(50) NOT NULL COMMENT 'GLUE类型',
  `glue_source` mediumtext COMMENT 'GLUE源代码',
  `glue_remark` varchar(128) DEFAULT NULL COMMENT 'GLUE备注',
  `glue_updatetime` datetime DEFAULT NULL COMMENT 'GLUE更新时间',
  `child_jobid` text COMMENT '子任务ID，多个逗号分隔',
  `parent_jobid` text COMMENT '父任务id，多个以逗号分隔',
  `again_num` varchar(5) DEFAULT NULL COMMENT '失败重试次数',
  `again_time` int(100) DEFAULT NULL COMMENT '失败重试间隔时间',
  `executor_timeout` int(11) NOT NULL DEFAULT '0' COMMENT '任务执行超时时间，单位秒',
  `nums` int(5) NOT NULL DEFAULT '0' COMMENT '重试次数',
  `job_source` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35822 DEFAULT CHARSET=utf8;


-- bdp_schedule.xxl_job_qrtz_trigger_info_lblv_dw definition

CREATE TABLE `xxl_job_qrtz_trigger_info_lblv_dw` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_group` int(11) NOT NULL COMMENT '执行器主键ID',
  `job_cron` varchar(128) NOT NULL COMMENT '任务执行CRON',
  `job_desc` text NOT NULL,
  `add_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `author` varchar(64) DEFAULT NULL COMMENT '作者',
  `alarm_email` varchar(255) DEFAULT NULL COMMENT '报警邮件',
  `executor_route_strategy` varchar(50) DEFAULT NULL COMMENT '执行器路由策略',
  `executor_handler` varchar(255) DEFAULT NULL COMMENT '执行器任务handler',
  `executor_param` varchar(512) DEFAULT NULL COMMENT '执行器任务参数',
  `executor_block_strategy` varchar(50) DEFAULT NULL COMMENT '阻塞处理策略',
  `executor_fail_strategy` varchar(50) DEFAULT NULL COMMENT '失败处理策略',
  `glue_type` varchar(50) NOT NULL COMMENT 'GLUE类型',
  `glue_source` text COMMENT 'GLUE源代码',
  `glue_remark` varchar(128) DEFAULT NULL COMMENT 'GLUE备注',
  `glue_updatetime` datetime DEFAULT NULL COMMENT 'GLUE更新时间',
  `child_jobid` text COMMENT '子任务ID，多个逗号分隔',
  `parent_jobid` text COMMENT '父任务id，多个以逗号分隔',
  `again_num` varchar(5) DEFAULT NULL COMMENT '失败重试次数',
  `again_time` int(100) DEFAULT NULL COMMENT '失败重试间隔时间',
  `executor_timeout` int(11) NOT NULL DEFAULT '0' COMMENT '任务执行超时时间，单位秒',
  `nums` int(5) NOT NULL DEFAULT '0' COMMENT '重试次数',
  `job_source` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21468 DEFAULT CHARSET=utf8;


-- bdp_schedule.xxl_job_qrtz_trigger_info_lblv_round definition

CREATE TABLE `xxl_job_qrtz_trigger_info_lblv_round` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_group` int(11) NOT NULL COMMENT '执行器主键ID',
  `job_cron` varchar(128) NOT NULL COMMENT '任务执行CRON',
  `job_desc` text NOT NULL,
  `add_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `author` varchar(64) DEFAULT NULL COMMENT '作者',
  `alarm_email` varchar(255) DEFAULT NULL COMMENT '报警邮件',
  `executor_route_strategy` varchar(50) DEFAULT NULL COMMENT '执行器路由策略',
  `executor_handler` varchar(255) DEFAULT NULL COMMENT '执行器任务handler',
  `executor_param` varchar(512) DEFAULT NULL COMMENT '执行器任务参数',
  `executor_block_strategy` varchar(50) DEFAULT NULL COMMENT '阻塞处理策略',
  `executor_fail_strategy` varchar(50) DEFAULT NULL COMMENT '失败处理策略',
  `glue_type` varchar(50) NOT NULL COMMENT 'GLUE类型',
  `glue_source` text COMMENT 'GLUE源代码',
  `glue_remark` varchar(128) DEFAULT NULL COMMENT 'GLUE备注',
  `glue_updatetime` datetime DEFAULT NULL COMMENT 'GLUE更新时间',
  `child_jobid` text COMMENT '子任务ID，多个逗号分隔',
  `parent_jobid` text COMMENT '父任务id，多个以逗号分隔',
  `again_num` varchar(5) DEFAULT NULL COMMENT '失败重试次数',
  `again_time` int(100) DEFAULT NULL COMMENT '失败重试间隔时间',
  `executor_timeout` int(11) NOT NULL DEFAULT '0' COMMENT '任务执行超时时间，单位秒',
  `nums` int(5) NOT NULL DEFAULT '0' COMMENT '重试次数',
  `job_source` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21469 DEFAULT CHARSET=utf8;


-- bdp_schedule.xxl_job_qrtz_trigger_info_phxu definition

CREATE TABLE `xxl_job_qrtz_trigger_info_phxu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_group` int(11) NOT NULL COMMENT '执行器主键ID',
  `job_cron` varchar(128) NOT NULL COMMENT '任务执行CRON',
  `job_desc` text NOT NULL,
  `add_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `author` varchar(64) DEFAULT NULL COMMENT '作者',
  `alarm_email` varchar(255) DEFAULT NULL COMMENT '报警邮件',
  `executor_route_strategy` varchar(50) DEFAULT NULL COMMENT '执行器路由策略',
  `executor_handler` varchar(255) DEFAULT NULL COMMENT '执行器任务handler',
  `executor_param` varchar(512) DEFAULT NULL COMMENT '执行器任务参数',
  `executor_block_strategy` varchar(50) DEFAULT NULL COMMENT '阻塞处理策略',
  `executor_fail_strategy` varchar(50) DEFAULT NULL COMMENT '失败处理策略',
  `glue_type` varchar(50) NOT NULL COMMENT 'GLUE类型',
  `glue_source` mediumtext COMMENT 'GLUE源代码',
  `glue_remark` varchar(128) DEFAULT NULL COMMENT 'GLUE备注',
  `glue_updatetime` datetime DEFAULT NULL COMMENT 'GLUE更新时间',
  `child_jobid` text COMMENT '子任务ID，多个逗号分隔',
  `parent_jobid` text COMMENT '父任务id，多个以逗号分隔',
  `again_num` varchar(5) DEFAULT NULL COMMENT '失败重试次数',
  `again_time` int(100) DEFAULT NULL COMMENT '失败重试间隔时间',
  `executor_timeout` int(11) NOT NULL DEFAULT '0' COMMENT '任务执行超时时间，单位秒',
  `nums` int(5) NOT NULL DEFAULT '0' COMMENT '重试次数',
  `job_source` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31817 DEFAULT CHARSET=utf8;


-- bdp_schedule.xxl_job_qrtz_trigger_info_ycai definition

CREATE TABLE `xxl_job_qrtz_trigger_info_ycai` (
  `id` int(11) NOT NULL DEFAULT '0',
  `job_group` int(11) NOT NULL COMMENT '执行器主键ID',
  `job_cron` varchar(128) NOT NULL COMMENT '任务执行CRON',
  `job_desc` text NOT NULL,
  `add_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `author` varchar(64) DEFAULT NULL COMMENT '作者',
  `alarm_email` varchar(255) DEFAULT NULL COMMENT '报警邮件',
  `executor_route_strategy` varchar(50) DEFAULT NULL COMMENT '执行器路由策略',
  `executor_handler` varchar(255) DEFAULT NULL COMMENT '执行器任务handler',
  `executor_param` varchar(512) DEFAULT NULL COMMENT '执行器任务参数',
  `executor_block_strategy` varchar(50) DEFAULT NULL COMMENT '阻塞处理策略',
  `executor_fail_strategy` varchar(50) DEFAULT NULL COMMENT '失败处理策略',
  `glue_type` varchar(50) NOT NULL COMMENT 'GLUE类型',
  `glue_source` text COMMENT 'GLUE源代码',
  `glue_remark` varchar(128) DEFAULT NULL COMMENT 'GLUE备注',
  `glue_updatetime` datetime DEFAULT NULL COMMENT 'GLUE更新时间',
  `child_jobid` text COMMENT '子任务ID，多个逗号分隔',
  `parent_jobid` text COMMENT '父任务id，多个以逗号分隔',
  `again_num` varchar(5) DEFAULT NULL COMMENT '失败重试次数',
  `again_time` int(100) DEFAULT NULL COMMENT '失败重试间隔时间',
  `executor_timeout` int(11) NOT NULL DEFAULT '0' COMMENT '任务执行超时时间，单位秒',
  `nums` int(5) NOT NULL DEFAULT '0' COMMENT '重试次数'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- bdp_schedule.xxl_job_qrtz_trigger_log definition

CREATE TABLE `xxl_job_qrtz_trigger_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_group` int(11) NOT NULL COMMENT '执行器主键ID',
  `job_id` int(11) NOT NULL COMMENT '任务，主键ID',
  `glue_type` varchar(50) DEFAULT NULL COMMENT 'GLUE类型',
  `executor_address` varchar(255) DEFAULT NULL COMMENT '执行器地址，本次执行的地址',
  `executor_handler` varchar(255) DEFAULT NULL COMMENT '执行器任务handler',
  `executor_param` varchar(512) DEFAULT NULL COMMENT '执行器任务参数',
  `trigger_time` datetime DEFAULT NULL COMMENT '调度-时间',
  `trigger_code` int(11) NOT NULL COMMENT '调度-结果',
  `trigger_msg` varchar(2048) DEFAULT NULL COMMENT '调度-日志',
  `handle_time` datetime DEFAULT NULL COMMENT '执行-时间',
  `handle_code` int(11) NOT NULL COMMENT '执行-状态',
  `handle_msg` varchar(2048) DEFAULT NULL COMMENT '执行-日志',
  `diff_time` float(11,0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `logid` (`id`) USING BTREE,
  KEY `jobid` (`job_id`) USING BTREE,
  KEY `startTime` (`trigger_time`,`handle_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=56763280 DEFAULT CHARSET=utf8;


-- bdp_schedule.xxl_job_qrtz_trigger_logglue definition

CREATE TABLE `xxl_job_qrtz_trigger_logglue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_id` int(11) NOT NULL COMMENT '任务，主键ID',
  `glue_type` varchar(50) DEFAULT NULL COMMENT 'GLUE类型',
  `glue_source` mediumtext COMMENT 'GLUE源代码',
  `glue_remark` varchar(128) NOT NULL COMMENT 'GLUE备注',
  `add_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=96244 DEFAULT CHARSET=utf8;


-- bdp_schedule.xxl_job_qrtz_trigger_registry definition

CREATE TABLE `xxl_job_qrtz_trigger_registry` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `registry_group` varchar(255) NOT NULL,
  `registry_key` varchar(255) NOT NULL,
  `registry_value` varchar(255) NOT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1232 DEFAULT CHARSET=utf8;


-- bdp_schedule.xxl_job_qrtz_triggers_cy definition

CREATE TABLE `xxl_job_qrtz_triggers_cy` (
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
  `JOB_DATA` blob
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- bdp_schedule.xxl_job_relation definition

CREATE TABLE `xxl_job_relation` (
  `job_id` int(11) NOT NULL,
  `job_desc` varchar(1000) DEFAULT NULL,
  `new_job_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`job_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- bdp_schedule.xxl_job_qrtz_triggers definition

CREATE TABLE `xxl_job_qrtz_triggers` (
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
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) USING BTREE,
  KEY `SCHED_NAME` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`) USING BTREE,
  CONSTRAINT `XXL_JOB_QRTZ_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `xxl_job_qrtz_job_details` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- bdp_schedule.xxl_job_qrtz_blob_triggers definition

CREATE TABLE `xxl_job_qrtz_blob_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `BLOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `XXL_JOB_QRTZ_BLOB_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `xxl_job_qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- bdp_schedule.xxl_job_qrtz_cron_triggers definition

CREATE TABLE `xxl_job_qrtz_cron_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `CRON_EXPRESSION` varchar(200) NOT NULL,
  `TIME_ZONE_ID` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `XXL_JOB_QRTZ_CRON_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `xxl_job_qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- bdp_schedule.xxl_job_qrtz_simple_triggers definition

CREATE TABLE `xxl_job_qrtz_simple_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `REPEAT_COUNT` bigint(7) NOT NULL,
  `REPEAT_INTERVAL` bigint(12) NOT NULL,
  `TIMES_TRIGGERED` bigint(10) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `XXL_JOB_QRTZ_SIMPLE_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `xxl_job_qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- bdp_schedule.xxl_job_qrtz_simprop_triggers definition

CREATE TABLE `xxl_job_qrtz_simprop_triggers` (
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
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `XXL_JOB_QRTZ_SIMPROP_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `xxl_job_qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;