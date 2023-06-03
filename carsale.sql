/*
SQLyog Ultimate v12.08 (64 bit)
MySQL - 8.0.32 : Database - carsale
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`carsale` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `carsale`;

/*Table structure for table `base_month` */

DROP TABLE IF EXISTS `base_month`;

CREATE TABLE `base_month` (
  `date` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

/*Table structure for table `brand` */

DROP TABLE IF EXISTS `brand`;

CREATE TABLE `brand` (
  `brand_id` int NOT NULL AUTO_INCREMENT COMMENT '品牌编号',
  `brand_name` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '品牌名称',
  `status` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '1' COMMENT '品牌状态（0：删除状态，1：正常状态）',
  PRIMARY KEY (`brand_id`) USING BTREE,
  UNIQUE KEY `brand_name` (`brand_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

/*Table structure for table `car` */

DROP TABLE IF EXISTS `car`;

CREATE TABLE `car` (
  `id` bigint NOT NULL COMMENT '车辆编号',
  `series_id` int NOT NULL COMMENT '车系编号',
  `type` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '车辆型号',
  `color` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '车辆颜色',
  `price` decimal(12,2) NOT NULL COMMENT '车辆进价',
  `sale_price` decimal(12,2) NOT NULL COMMENT '车辆售价',
  `repertory` int NOT NULL COMMENT '车辆库存',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '车辆入库时间',
  `status` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '车辆状态（0：停售，1：在售，2：停售）',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `series_id` (`series_id`) USING BTREE,
  CONSTRAINT `car_ibfk_1` FOREIGN KEY (`series_id`) REFERENCES `series` (`series_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

/*Table structure for table `carshop` */

DROP TABLE IF EXISTS `carshop`;

CREATE TABLE `carshop` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '店铺ID',
  `name` varchar(50) NOT NULL COMMENT '店铺名称',
  `address` varchar(100) NOT NULL COMMENT '店铺地址',
  `phone` varchar(20) NOT NULL COMMENT '店铺电话',
  `business_hours` varchar(50) NOT NULL COMMENT '营业时间',
  `latitude` decimal(10,6) NOT NULL COMMENT '店铺纬度',
  `longitude` decimal(10,6) NOT NULL COMMENT '店铺经度',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  `updated_time` datetime NOT NULL COMMENT '更新时间',
  `brand` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='4S店基本信息表';

/*Table structure for table `customer` */

DROP TABLE IF EXISTS `customer`;

CREATE TABLE `customer` (
  `id` bigint NOT NULL COMMENT '顾客编号',
  `name` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '顾客姓名',
  `phone` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '顾客电话',
  `id_card` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '顾客身份证号',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '顾客信息创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `id_card` (`id_card`) USING BTREE,
  UNIQUE KEY `phone` (`phone`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

/*Table structure for table `employee` */

DROP TABLE IF EXISTS `employee`;

CREATE TABLE `employee` (
  `id` int NOT NULL COMMENT '员工编号',
  `role` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '员工角色（0：经理，1：销售）',
  `name` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '员工姓名',
  `password` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '员工登录密码',
  `id_card` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '员工身份证号',
  `phone` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '员工电话号码',
  `gender` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '员工性别：''男''&''女''',
  `salary` decimal(12,2) DEFAULT NULL COMMENT '员工薪资',
  `entry_time` date DEFAULT NULL COMMENT '员工入职时间',
  `status` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '员工状态（0：离职，1：在职）',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `id_card` (`id_card`) USING BTREE,
  UNIQUE KEY `phone` (`phone`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

/*Table structure for table `order` */

DROP TABLE IF EXISTS `order`;

CREATE TABLE `order` (
  `id` bigint NOT NULL COMMENT '订单编号',
  `customer_id` bigint NOT NULL COMMENT '顾客编号',
  `employee_id` int NOT NULL COMMENT '负责员工编号',
  `total_price` decimal(20,2) NOT NULL DEFAULT '0.00' COMMENT '订单总金额',
  `status` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '订单状态（0：未支付，1：已支付，2：已取消）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '订单创建时间',
  `pay_time` datetime DEFAULT NULL COMMENT '订单支付时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '订单更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `customer_id` (`customer_id`) USING BTREE,
  KEY `employee_id` (`employee_id`) USING BTREE,
  CONSTRAINT `order_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `order_ibfk_2` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

/*Table structure for table `order_details` */

DROP TABLE IF EXISTS `order_details`;

CREATE TABLE `order_details` (
  `id` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '订单详情编号',
  `order_id` bigint NOT NULL COMMENT '订单编号',
  `car_id` bigint NOT NULL COMMENT '车辆编号',
  `car_number` int NOT NULL COMMENT '车辆订单数',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `car_id` (`car_id`) USING BTREE,
  KEY `order_id` (`order_id`) USING BTREE,
  CONSTRAINT `order_details_ibfk_3` FOREIGN KEY (`car_id`) REFERENCES `car` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `order_details_ibfk_4` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

/*Table structure for table `reservation` */

DROP TABLE IF EXISTS `reservation`;

CREATE TABLE `reservation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `shopid` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `start` varchar(233) DEFAULT NULL,
  `end` varchar(233) DEFAULT NULL,
  `day` date DEFAULT NULL,
  `shopname` varchar(255) DEFAULT NULL,
  `empid` int DEFAULT NULL,
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Table structure for table `series` */

DROP TABLE IF EXISTS `series`;

CREATE TABLE `series` (
  `series_id` int NOT NULL AUTO_INCREMENT COMMENT '车系编号',
  `brand_id` int NOT NULL COMMENT '品牌编号',
  `series_name` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '车系名称',
  `status` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '1' COMMENT '车系状态（0：删除状态，1：正常状态）',
  PRIMARY KEY (`series_id`) USING BTREE,
  KEY `brand_id` (`brand_id`) USING BTREE,
  CONSTRAINT `series_ibfk_1` FOREIGN KEY (`brand_id`) REFERENCES `brand` (`brand_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
