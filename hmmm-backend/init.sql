
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";
set character set utf8;

--
-- 数据库： `vue_element_admin`
--
CREATE DATABASE IF NOT EXISTS `vue_element_admin` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `vue_element_admin`;

-- --------------------------------------------------------

--
-- 表的结构 `a_permission_permission_group`
--
-- 创建时间： 2019-02-15 02:24:45
-- 最后更新： 2019-02-15 09:01:07
--

DROP TABLE IF EXISTS `a_permission_permission_group`;
CREATE TABLE IF NOT EXISTS `a_permission_permission_group` (
  `pgid` bigint(20) NOT NULL COMMENT '权限组ID',
  `pid` bigint(20) NOT NULL COMMENT '权限ID',
  PRIMARY KEY (`pgid`,`pid`),
  KEY `FK74qx7rkbtq2wqms78gljv87a0` (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 表的关系 `a_permission_permission_group`:
--   `pid`
--       `pe_permission` -> `id`
--   `pgid`
--       `pe_permission_group` -> `id`
--

--
-- 转存表中的数据 `a_permission_permission_group`
--

INSERT INTO `a_permission_permission_group` (`pgid`, `pid`) VALUES
(2, 28),
(2, 29),
(2, 30),
(2, 31),
(2, 32),
(2, 33),
(3, 33),
(2, 34),
(3, 34),
(2, 35),
(3, 35),
(2, 36),
(3, 36),
(2, 37),
(2, 38),
(2, 39),
(2, 40),
(2, 41),
(2, 42),
(2, 43),
(2, 44),
(2, 46),
(2, 47),
(2, 48),
(3, 48);

-- --------------------------------------------------------

--
-- 表的结构 `bs_user`
--
-- 创建时间： 2019-02-15 10:07:26
-- 最后更新： 2019-02-16 12:59:06
--

DROP TABLE IF EXISTS `bs_user`;
CREATE TABLE IF NOT EXISTS `bs_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `avatar` varchar(255) DEFAULT NULL COMMENT '头像',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `email` varchar(255) DEFAULT NULL COMMENT '邮箱',
  `introduction` text COMMENT '介绍',
  `last_update_time` datetime DEFAULT NULL COMMENT '最后修改时间',
  `password` text COMMENT '密码',
  `phone` varchar(255) DEFAULT NULL COMMENT '手机号码',
  `status` int(11) DEFAULT '0' COMMENT '账号状态 0为启用，1为禁用',
  `username` varchar(255) DEFAULT NULL COMMENT '用户名称',
  `role` varchar(50) DEFAULT NULL COMMENT '角色',
  `permission_group_id` bigint(20) DEFAULT NULL COMMENT '权限组ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_9d5myufq0sev17gw41fcio4jf` (`email`),
  UNIQUE KEY `UK_h2hvo40aswrpdlj6mrjw0jo17` (`phone`),
  KEY `FK9uhq7vr73fopxl940siqo037k` (`permission_group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- 表的关系 `bs_user`:
--   `permission_group_id`
--       `pe_permission_group` -> `id`
--

--
-- 转存表中的数据 `bs_user`
--

INSERT INTO `bs_user` (`id`, `avatar`, `create_time`, `email`, `introduction`, `last_update_time`, `password`, `phone`, `status`, `username`, `role`, `permission_group_id`) VALUES
(2, NULL, '2018-08-22 03:32:11', 'root@admin.com', NULL, '2019-02-16 12:59:06', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', NULL, 0, '超级管理员', 'admin', 2),
(3, '', '2019-02-14 10:26:17', 'editor@admin.com', '', '2019-02-15 10:14:02', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '', 0, '编辑', 'editor', 3);

-- --------------------------------------------------------

--
-- 表的结构 `pe_permission`
--
-- 创建时间： 2019-02-15 02:24:45
-- 最后更新： 2019-02-15 07:04:14
--

DROP TABLE IF EXISTS `pe_permission`;
CREATE TABLE IF NOT EXISTS `pe_permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `description` text COMMENT '权限描述',
  `name` varchar(255) DEFAULT NULL COMMENT '权限名称',
  `type` tinyint(4) DEFAULT NULL COMMENT '权限类型 1为菜单 2为功能 3为API',
  `pid` bigint(20) DEFAULT NULL COMMENT '主键',
  `permission_api_extend_id` bigint(20) DEFAULT NULL COMMENT '主键ID',
  `permission_menu_extend_id` bigint(20) DEFAULT NULL COMMENT '主键ID',
  `permission_point_extend_id` bigint(20) DEFAULT NULL COMMENT '主键ID',
  PRIMARY KEY (`id`),
  KEY `FKcl4mcrsqinb3q8iwsyr35u6nw` (`pid`),
  KEY `FKi0m9bwff032wcooqvql5frdbg` (`permission_point_extend_id`),
  KEY `FKkbf8xphs59e2lebopx3npjd2q` (`permission_menu_extend_id`),
  KEY `FKs1u37sxlynb8jsx1dfptwdnpo` (`permission_api_extend_id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;

--
-- 表的关系 `pe_permission`:
--   `pid`
--       `pe_permission` -> `id`
--   `permission_point_extend_id`
--       `pe_permission_point_extend` -> `id`
--   `permission_menu_extend_id`
--       `pe_permission_menu_extend` -> `id`
--   `permission_api_extend_id`
--       `pe_permission_api_extend` -> `id`
--

--
-- 转存表中的数据 `pe_permission`
--

INSERT INTO `pe_permission` (`id`, `create_time`, `description`, `name`, `type`, `pid`, `permission_api_extend_id`, `permission_menu_extend_id`, `permission_point_extend_id`) VALUES
(28, '2018-08-22 03:32:11', NULL, '后台框架', 1, NULL, NULL, 6, NULL),
(29, '2018-08-22 03:32:11', NULL, '用户管理', 1, 28, NULL, 7, NULL),
(30, '2018-08-22 03:32:11', NULL, '菜单管理', 1, 28, NULL, 8, NULL),
(31, '2018-08-22 03:32:11', NULL, '权限管理', 1, 28, NULL, 9, NULL),
(32, '2018-08-22 03:32:11', NULL, '日志管理', 1, 28, NULL, 10, NULL),
(33, '2019-02-14 08:47:29', NULL, '列表页', 1, NULL, NULL, 11, NULL),
(34, '2019-02-14 08:48:07', NULL, '查询表格', 1, 33, NULL, 12, NULL),
(35, '2019-02-14 08:51:06', NULL, '标准列表', 1, 33, NULL, 13, NULL),
(36, '2019-02-14 08:51:27', NULL, '卡片列表', 1, 33, NULL, 14, NULL),
(37, '2019-02-14 08:54:36', NULL, '表单页', 1, NULL, NULL, 15, NULL),
(38, '2019-02-14 08:55:00', NULL, '基础表单', 1, 37, NULL, 16, NULL),
(39, '2019-02-14 08:55:19', NULL, '分步表单', 1, 37, NULL, 17, NULL),
(40, '2019-02-14 08:55:38', NULL, '高级表单', 1, 37, NULL, 18, NULL),
(41, '2019-02-14 08:56:09', NULL, '详情页', 1, NULL, NULL, 19, NULL),
(42, '2019-02-14 08:56:31', NULL, '基础详情页', 1, 41, NULL, 20, NULL),
(43, '2019-02-14 08:56:52', NULL, '高级详情页', 1, 41, NULL, 21, NULL),
(44, '2019-02-14 09:25:12', NULL, '用户新增', 2, 29, NULL, NULL, 1),
(46, '2019-02-14 09:26:40', NULL, '用户搜索', 2, 29, NULL, NULL, 2),
(47, '2019-02-14 10:54:24', NULL, '用户列表', 2, 29, NULL, NULL, 3),
(48, '2019-02-15 07:04:14', NULL, '用户分页', 2, 29, NULL, NULL, 4);

-- --------------------------------------------------------

--
-- 表的结构 `pe_permission_api_extend`
--
-- 创建时间： 2019-02-15 02:24:45
--

DROP TABLE IF EXISTS `pe_permission_api_extend`;
CREATE TABLE IF NOT EXISTS `pe_permission_api_extend` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `api_level` int(11) DEFAULT NULL COMMENT '权限等级，1为通用接口权限，2为需校验接口权限',
  `api_method` varchar(255) DEFAULT NULL COMMENT '请求类型',
  `api_url` varchar(255) DEFAULT NULL COMMENT '链接',
  `permission_id` bigint(20) DEFAULT NULL COMMENT '主键',
  PRIMARY KEY (`id`),
  KEY `FKcuumocmq03no1grx1pp7mi0ya` (`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 表的关系 `pe_permission_api_extend`:
--   `permission_id`
--       `pe_permission` -> `id`
--

-- --------------------------------------------------------

--
-- 表的结构 `pe_permission_group`
--
-- 创建时间： 2019-02-15 02:24:45
-- 最后更新： 2019-02-15 09:01:07
--

DROP TABLE IF EXISTS `pe_permission_group`;
CREATE TABLE IF NOT EXISTS `pe_permission_group` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `name` varchar(255) DEFAULT NULL COMMENT '权限名称',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_k3beff7qglfn58qsf2yvbg41i` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- 表的关系 `pe_permission_group`:
--

--
-- 转存表中的数据 `pe_permission_group`
--

INSERT INTO `pe_permission_group` (`id`, `create_time`, `name`, `update_time`) VALUES
(2, '2018-08-22 03:32:11', '超级管理员组', '2019-02-15 07:24:30'),
(3, '2019-02-14 08:57:39', '编辑组', '2019-02-15 09:01:07');

-- --------------------------------------------------------

--
-- 表的结构 `pe_permission_menu_extend`
--
-- 创建时间： 2019-02-15 02:24:45
--

DROP TABLE IF EXISTS `pe_permission_menu_extend`;
CREATE TABLE IF NOT EXISTS `pe_permission_menu_extend` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `code` text COMMENT '权限代码',
  `permission_id` bigint(20) DEFAULT NULL COMMENT '主键',
  PRIMARY KEY (`id`),
  KEY `FK42ix9ooed2li4ig9ry78chkaq` (`permission_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

--
-- 表的关系 `pe_permission_menu_extend`:
--   `permission_id`
--       `pe_permission` -> `id`
--

--
-- 转存表中的数据 `pe_permission_menu_extend`
--

INSERT INTO `pe_permission_menu_extend` (`id`, `code`, `permission_id`) VALUES
(6, 'base', 28),
(7, 'base-users', 29),
(8, 'base-menus', 30),
(9, 'base-permissions', 31),
(10, 'base-logs', 32),
(11, 'list', 33),
(12, 'table-list', 34),
(13, 'base-list', 35),
(14, 'card-list', 36),
(15, 'form', 37),
(16, 'basic-form', 38),
(17, 'step-form', 39),
(18, 'senior-form', 40),
(19, 'details', 41),
(20, 'basics-details', 42),
(21, 'senior-details', 43);

-- --------------------------------------------------------

--
-- 表的结构 `pe_permission_point_extend`
--
-- 创建时间： 2019-02-15 02:24:45
-- 最后更新： 2019-02-15 07:04:14
--

DROP TABLE IF EXISTS `pe_permission_point_extend`;
CREATE TABLE IF NOT EXISTS `pe_permission_point_extend` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `code` text COMMENT '权限代码',
  `permission_id` bigint(20) DEFAULT NULL COMMENT '主键',
  PRIMARY KEY (`id`),
  KEY `FKml56235rji52opnlq6cr143l1` (`permission_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- 表的关系 `pe_permission_point_extend`:
--   `permission_id`
--       `pe_permission` -> `id`
--

--
-- 转存表中的数据 `pe_permission_point_extend`
--

INSERT INTO `pe_permission_point_extend` (`id`, `code`, `permission_id`) VALUES
(1, 'base-users-add', 44),
(2, 'base-users-search', 46),
(3, 'base-users-list', 47),
(4, 'base-users-paging', 48);

-- --------------------------------------------------------

--
-- 表的结构 `sys_log`
--
-- 创建时间： 2019-02-15 02:24:45
--

DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE IF NOT EXISTS `sys_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `method` varchar(255) DEFAULT NULL COMMENT 'method',
  `operation_date` datetime DEFAULT NULL COMMENT '操作时间',
  `operation_result` tinyint(1) DEFAULT NULL COMMENT '操作结果',
  `request_body` text COMMENT '参数内容',
  `url` varchar(255) DEFAULT NULL COMMENT 'url',
  `user_id` bigint(20) DEFAULT NULL COMMENT '操作人ID',
  PRIMARY KEY (`id`),
  KEY `FKlt2yft8n91ep783g16knhvilp` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 表的关系 `sys_log`:
--   `user_id`
--       `bs_user` -> `id`
--

--
-- 限制导出的表
--

--
-- 限制表 `a_permission_permission_group`
--
ALTER TABLE `a_permission_permission_group`
  ADD CONSTRAINT `FK74qx7rkbtq2wqms78gljv87a0` FOREIGN KEY (`pid`) REFERENCES `pe_permission` (`id`),
  ADD CONSTRAINT `FKee9dk0vg99shvsytflym6egxd` FOREIGN KEY (`pgid`) REFERENCES `pe_permission_group` (`id`);

--
-- 限制表 `bs_user`
--
ALTER TABLE `bs_user`
  ADD CONSTRAINT `FK9uhq7vr73fopxl940siqo037k` FOREIGN KEY (`permission_group_id`) REFERENCES `pe_permission_group` (`id`);

--
-- 限制表 `pe_permission`
--
ALTER TABLE `pe_permission`
  ADD CONSTRAINT `FKcl4mcrsqinb3q8iwsyr35u6nw` FOREIGN KEY (`pid`) REFERENCES `pe_permission` (`id`),
  ADD CONSTRAINT `FKi0m9bwff032wcooqvql5frdbg` FOREIGN KEY (`permission_point_extend_id`) REFERENCES `pe_permission_point_extend` (`id`),
  ADD CONSTRAINT `FKkbf8xphs59e2lebopx3npjd2q` FOREIGN KEY (`permission_menu_extend_id`) REFERENCES `pe_permission_menu_extend` (`id`),
  ADD CONSTRAINT `FKs1u37sxlynb8jsx1dfptwdnpo` FOREIGN KEY (`permission_api_extend_id`) REFERENCES `pe_permission_api_extend` (`id`);

--
-- 限制表 `pe_permission_api_extend`
--
ALTER TABLE `pe_permission_api_extend`
  ADD CONSTRAINT `FKcuumocmq03no1grx1pp7mi0ya` FOREIGN KEY (`permission_id`) REFERENCES `pe_permission` (`id`);

--
-- 限制表 `pe_permission_menu_extend`
--
ALTER TABLE `pe_permission_menu_extend`
  ADD CONSTRAINT `FK42ix9ooed2li4ig9ry78chkaq` FOREIGN KEY (`permission_id`) REFERENCES `pe_permission` (`id`);

--
-- 限制表 `pe_permission_point_extend`
--
ALTER TABLE `pe_permission_point_extend`
  ADD CONSTRAINT `FKml56235rji52opnlq6cr143l1` FOREIGN KEY (`permission_id`) REFERENCES `pe_permission` (`id`);

--
-- 限制表 `sys_log`
--
ALTER TABLE `sys_log`
  ADD CONSTRAINT `FKlt2yft8n91ep783g16knhvilp` FOREIGN KEY (`user_id`) REFERENCES `bs_user` (`id`);
COMMIT;
