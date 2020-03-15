/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50528
Source Host           : localhost:3306
Source Database       : wx_send_article

Target Server Type    : MYSQL
Target Server Version : 50528
File Encoding         : 65001

Date: 2020-03-15 19:22:27
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for area_tb
-- ----------------------------
DROP TABLE IF EXISTS `area_tb`;
CREATE TABLE `area_tb` (
  `id` bigint(20) NOT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `creator` varchar(255) DEFAULT NULL,
  `creator_id` varchar(255) DEFAULT NULL,
  `valid` varchar(1) DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `updator` varchar(255) DEFAULT NULL,
  `updator_id` varchar(255) DEFAULT NULL,
  `pid` varchar(255) DEFAULT NULL,
  `short_map_name` varchar(255) DEFAULT NULL,
  `short_name` varchar(255) DEFAULT NULL,
  `spelling` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `zip` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for article_file
-- ----------------------------
DROP TABLE IF EXISTS `article_file`;
CREATE TABLE `article_file` (
  `article_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `person_id` bigint(20) DEFAULT NULL,
  `article_name` varchar(255) DEFAULT NULL,
  `article_url` varchar(255) DEFAULT NULL,
  `article_type` varchar(255) DEFAULT NULL,
  `article_wj` longblob,
  `article_state` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`article_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for person_info
-- ----------------------------
DROP TABLE IF EXISTS `person_info`;
CREATE TABLE `person_info` (
  `person_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `person_name` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `county` varchar(255) DEFAULT NULL,
  `school` varchar(255) DEFAULT NULL,
  `wschool` varchar(255) DEFAULT NULL,
  `person_class` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for school
-- ----------------------------
DROP TABLE IF EXISTS `school`;
CREATE TABLE `school` (
  `school_id` varchar(255) NOT NULL,
  `county_id` varchar(255) DEFAULT NULL,
  `school_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`school_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
