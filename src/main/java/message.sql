/*
Navicat MySQL Data Transfer

Source Server         : orcl
Source Server Version : 50505
Source Host           : localhost:3306
Source Database       : user

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2017-09-13 13:13:06
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `usermessage`
-- ----------------------------
DROP TABLE IF EXISTS `usermessage`;
CREATE TABLE `usermessage` (
  `author` varchar(10) NOT NULL,
  `message` varchar(100) NOT NULL,
  `floor` int(2) NOT NULL,
  `time` date DEFAULT NULL,
  PRIMARY KEY (`floor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of usermessage
-- ----------------------------
INSERT INTO `usermessage` VALUES ('chenxin', 'qwe', '1', '2017-08-18');
INSERT INTO `usermessage` VALUES ('陈鑫', '你好', '2', '2017-09-03');
INSERT INTO `usermessage` VALUES ('11', '11', '3', '2017-08-23');
INSERT INTO `usermessage` VALUES ('查重率', '惨', '4', '2017-08-08');
INSERT INTO `usermessage` VALUES ('缺勤', '缺勤', '5', '2017-08-27');
INSERT INTO `usermessage` VALUES ('sss ', 'sss', '6', '2017-08-02');
INSERT INTO `usermessage` VALUES ('3412', '4132', '7', '2017-08-21');
INSERT INTO `usermessage` VALUES ('34213', '3124134', '8', '2017-09-06');
INSERT INTO `usermessage` VALUES ('午饭晚饭', '额外发二分', '9', '2017-09-06');
INSERT INTO `usermessage` VALUES ('134132', '43241', '10', '2017-09-06');
INSERT INTO `usermessage` VALUES ('1', '自行车', '11', '2017-09-06');
INSERT INTO `usermessage` VALUES ('2', '自行车', '12', '2017-09-06');
INSERT INTO `usermessage` VALUES ('3', '自行车', '13', '2017-09-06');
INSERT INTO `usermessage` VALUES ('4', '自行车', '14', '2017-09-06');
INSERT INTO `usermessage` VALUES ('5', '自行车', '15', '2017-09-06');
INSERT INTO `usermessage` VALUES ('6', '自行车', '16', '2017-09-06');
INSERT INTO `usermessage` VALUES ('而且二无', '范文芳', '17', '2017-09-06');
