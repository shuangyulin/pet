-- phpMyAdmin SQL Dump
-- version 3.0.1.1
-- http://www.phpmyadmin.net
--
-- 服务器版本: 5.1.29
-- PHP 版本: 5.2.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- --------------------------------------------------------

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL DEFAULT '',
  `password` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a'); 

CREATE TABLE IF NOT EXISTS `t_userInfo` (
  `user_name` varchar(20)  NOT NULL COMMENT 'user_name',
  `password` varchar(20)  NOT NULL COMMENT '登录密码',
  `name` varchar(20)  NOT NULL COMMENT '姓名',
  `gender` varchar(4)  NOT NULL COMMENT '性别',
  `birthDate` varchar(20)  NULL COMMENT '生日',
  `userImage` varchar(60)  NOT NULL COMMENT '用户照片',
  `telephone` varchar(20)  NOT NULL COMMENT '联系电话',
  `address` varchar(80)  NOT NULL COMMENT '家庭地址',
  `createTime` varchar(20)  NULL COMMENT '注册时间',
  PRIMARY KEY (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_notice` (
  `noticeId` int(11) NOT NULL AUTO_INCREMENT COMMENT '公告id',
  `noticeTitle` varchar(80)  NOT NULL COMMENT '标题',
  `noticeClass` varchar(40)  NOT NULL COMMENT '公告类别',
  `noticeContent` varchar(5000)  NOT NULL COMMENT '公告内容',
  `addDate` varchar(20)  NULL COMMENT '发布日期',
  PRIMARY KEY (`noticeId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_leaveword` (
  `leaveWordId` int(11) NOT NULL AUTO_INCREMENT COMMENT '留言id',
  `leaveTitle` varchar(80)  NOT NULL COMMENT '留言标题',
  `leaveContent` varchar(2000)  NOT NULL COMMENT '留言内容',
  `userObj` varchar(20)  NOT NULL COMMENT '留言人',
  `leaveTime` varchar(20)  NULL COMMENT '留言时间',
  `replyContent` varchar(1000)  NULL COMMENT '管理回复',
  `replyTime` varchar(20)  NULL COMMENT '回复时间',
  PRIMARY KEY (`leaveWordId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_pet` (
  `petId` int(11) NOT NULL AUTO_INCREMENT COMMENT '宠物id',
  `petClassObj` int(11) NOT NULL COMMENT '宠物类别',
  `petName` varchar(80)  NOT NULL COMMENT '宠物名称',
  `petPhoto` varchar(60)  NOT NULL COMMENT '宠物照片',
  `petDesc` varchar(5000)  NOT NULL COMMENT '宠物介绍',
  `petRequest` varchar(1000)  NOT NULL COMMENT '领养要求',
  `petState` varchar(20)  NOT NULL COMMENT '领养状态',
  `addTime` varchar(20)  NULL COMMENT '登记时间',
  PRIMARY KEY (`petId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_petClass` (
  `petClassId` int(11) NOT NULL AUTO_INCREMENT COMMENT '宠物类别id',
  `petClassName` varchar(20)  NOT NULL COMMENT '宠物类别名称',
  PRIMARY KEY (`petClassId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_food` (
  `foodId` int(11) NOT NULL AUTO_INCREMENT COMMENT '宠粮id',
  `foodName` varchar(80)  NOT NULL COMMENT '宠粮名称',
  `foodPhoto` varchar(60)  NOT NULL COMMENT '宠粮照片',
  `foodDesc` varchar(5000)  NOT NULL COMMENT '宠粮介绍',
  `foodNum` int(11) NOT NULL COMMENT '库存数量',
  `addDate` varchar(20)  NULL COMMENT '上架日期',
  PRIMARY KEY (`foodId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_foodOrder` (
  `orderId` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单id',
  `foodObj` int(11) NOT NULL COMMENT '宠粮名称',
  `userObj` varchar(20)  NOT NULL COMMENT '预订用户',
  `orderNumber` int(11) NOT NULL COMMENT '预订数量',
  `orderState` varchar(20)  NOT NULL COMMENT '订单状态',
  `orderTime` varchar(20)  NULL COMMENT '预订时间',
  PRIMARY KEY (`orderId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_adopt` (
  `adoptId` int(11) NOT NULL AUTO_INCREMENT COMMENT '领养id',
  `petObj` int(11) NOT NULL COMMENT '被领养宠物',
  `userObj` varchar(20)  NOT NULL COMMENT '领养人',
  `addTime` varchar(20)  NULL COMMENT '领养申请时间',
  `shenHe` varchar(20)  NOT NULL COMMENT '审核状态',
  PRIMARY KEY (`adoptId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

ALTER TABLE t_leaveword ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);
ALTER TABLE t_pet ADD CONSTRAINT FOREIGN KEY (petClassObj) REFERENCES t_petClass(petClassId);
ALTER TABLE t_foodOrder ADD CONSTRAINT FOREIGN KEY (foodObj) REFERENCES t_food(foodId);
ALTER TABLE t_foodOrder ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);
ALTER TABLE t_adopt ADD CONSTRAINT FOREIGN KEY (petObj) REFERENCES t_pet(petId);
ALTER TABLE t_adopt ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);


