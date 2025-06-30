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
-- 使用您的数据库
-- 切换到目标数据库
-- 切换到目标数据库
USE `carsale`;


-- =================================================================
---- 1. 插入品牌信息 (brand)
INSERT INTO `brand` (`brand_name`, `status`) 1. 插入品牌信息 (brand) - 【已修正】
--    显式指定 brand_id，以 VALUES
('丰田', '1'), ('本田', '1'), ('宝马', '1'), ('奥迪', '1'), ('奔驰', '1'),
('大众', '1'), ('福特', '确保后续引用的正确性。
-- =================================================================
INSERT INTO `brand` (`brand_id`, `1'), ('日产', '1'), ('比亚迪', '1'), ('吉利', '1');

brand_name`, `status`) VALUES
(1, '丰田', '1'), (2, '本田', '1'), (3, '宝马', '1'), (4, '奥迪', '1-- 2. 插入车系信息 (series) - 依赖于 brand 表
-- 此时，丰田ID'), (5, '奔驰', '1'),
(6, '大众', '1'), (7, '=1, 本田ID=2, ..., 比亚迪ID=9, 吉利ID=10
INSERT INTO `福特', '1'), (8, '日产', '1'), (9, '比亚迪', 'series` (`brand_id`, `series_name`, `status`) VALUES
(1, '凯美瑞1'), (10, '吉利', '1');

-- =================================================================
-- 2', '1'), (1, '卡罗拉', '1'), (1, 'RAV4荣放. 插入车系信息 (series) - 现在可以安全地引用已知的 brand_id
-- =================================================================
INSERT INTO `series` (`brand_id`, `series_name`, `status`) VALUES
(1', '1'),
(2, '雅阁', '1'), (2, '思域', '1'), (2, 'CR-V', '1'),
(3, '3系', '1'), (3, '5系', '1'), (3, 'X3', '1'),
(4, ', '凯美瑞', '1'), (1, '卡罗拉', '1'), (1, 'RAV4A4L', '1'), (4, 'A6L', '1'), (4, 'Q5荣放', '1'),
(2, '雅阁', '1'), (2, '思域',L', '1'),
(5, 'C级', '1'), (5, 'E级', ' '1'), (2, 'CR-V', '1'),
(3, '3系', '1'), (3, '5系', '1'), (3, 'X3', '1'),
(41'), (5, 'GLC', '1'),
(6, '帕萨特', '1'), (6, '迈腾', '1'), (6, '途观L', '1'),
(9, 'A4L', '1'), (4, 'A6L', '1'), (4, 'Q5, '汉', '1'), (9, '唐', '1'), (9, '宋PLUS', 'L', '1'),
(5, 'C级', '1'), (5, 'E级', '1'),
(10, '星越L', '1'), (10, '帝豪', '1'), (5, 'GLC', '1'),
(6, '帕萨特', '1'),1'), (10, '博越', '1');

-- 3. 插入员工信息 (employee (6, '迈腾', '1'), (6, '途观L', '1'),
(9)
INSERT INTO `employee` (`id`, `role`, `name`, `password`, `id_card`,, '汉', '1'), (9, '唐', '1'), (9, '宋PLUS', ' `phone`, `gender`, `salary`, `entry_time`, `status`) VALUES
(10011'),
(10, '星越L', '1'), (10, '帝豪', ', '0', '王经理', '123456', '1101011981'), (10, '博越', '1');

-- =================================================================
-- 3. 插入员工信息 (employee)
-- =================================================================
INSERT INTO `employee` (`id`,001011234', '13800138000', '男', 25000.00, '2018-05-10', `role`, `name`, `password`, `id_card`, `phone`, `gender`, `salary`, ` '1'),
(1002, '1', '李明', '123456entry_time`, `status`) VALUES
(1001, '0', '王经理', '1', '110102199503154321', '1323456', '110101198001011234', '13800138000', '男', 25000900139001', '男', 8200.00, '2.00, '2018-05-10', '1'),
(100021-07-22', '1'),
(1003, '1', '2, '1', '李明', '123456', '110102张丽', '123456', '110103199208199503154321', '139001390010111X', '13700137002', '女', 1', '男', 8200.00, '2021-07-29500.00, '2020-03-01', '1'),
2', '1'),
(1003, '1', '张丽', '1234(1004, '1', '赵强', '123456', '4456', '11010319920810111X', '0301199602282235', '136001313700137002', '女', 9500.00,6003', '男', 7800.00, '2022-11- '2020-03-01', '1'),
(1004, '115', '1'),
(1005, '1', '孙静', '123', '赵强', '123456', '4403011996022456', '310101199407193348',82235', '13600136003', '男', 7 '13500135004', '女', 11000.00, '800.00, '2022-11-15', '1'),
(2019-09-01', '1'),
(1006, '1',1005, '1', '孙静', '123456', '310 '周伟', '123456', '42010119910101199407193348', '13500131015566', '15900159005', '男', 85004', '女', 11000.00, '2019-09-800.00, '2023-02-20', '1'),
(01', '1'),
(1006, '1', '周伟', '1231007, '1', '吴芳', '123456', '510456', '420101199101015566', '15101199312307789', '1880018900159005', '男', 8800.00, '20238006', '女', 0.00, '2021-04-11', '-02-20', '1'),
(1007, '1', '吴芳',0'); -- 离职员工

-- 4. 插入顾客信息 (customer)
INSERT INTO `customer '123456', '510101199312307` (`id`, `name`, `phone`, `id_card`) VALUES
(202300789', '18800188006', '女', 0.00, '01, '陈先生', '18600186001', '320101199005202233'),
(2023002021-04-11', '0'); -- 离职员工

-- =================================02, '刘女士', '18500185002', '440================================
-- 4. 插入顾客信息 (customer)
-- =================================================================
INSERT INTO101198811115566'),
(202300 `customer` (`id`, `name`, `phone`, `id_card`) VALUES
(202303, '黄总', '18900189003', '3300001, '陈先生', '18600186001', '3201101197508083321'),
(20230001199005202233'),
(202300004, '林小姐', '18700187004', '3502, '刘女士', '18500185002', '4401101199901014455'),
(20230001198811115566'),
(202300005, '郑师傅', '13300133005', '6103, '黄总', '18900189003', '3301101198506156677'),
(20230001197508083321'),
(202300006, '马学生', '17700177006', '2104, '林小姐', '18700187004', '3501101200209018899');

-- 5. 插入401199901014455'),
(20230005, 'S店信息 (carshop)
INSERT INTO `carshop` (`name`, `address`, `phone`, `郑师傅', '13300133005', '6101011business_hours`, `latitude`, `longitude`, `created_time`, `updated_time`, `brand`) VALUES98506156677'),
(20230006, '
('北京中达丰田4S店', '北京市朝阳区东三环中路1号',马学生', '17700177006', '2101012 '010-88886666', '08:30-18:00209018899');

-- =================================================================
-- 5.30', 39.908722, 116.45201 插入4S店信息 (carshop) - 【已修正】
--    显式指定 id，以确保后续1, NOW(), NOW(), '丰田, 本田'),
('上海永达宝马中心', '上海市引用的正确性。
-- =================================================================
INSERT INTO `carshop` (`id`, `name`, `address浦东新区龙阳路2277号', '021-9999888`, `phone`, `business_hours`, `latitude`, `longitude`, `created_time`, `updated_time8', '09:00-19:00', 31.20458`, `brand`) VALUES
(1, '北京中达丰田4S店', '北京市朝阳区0, 121.551380, NOW(), NOW(), '宝马'),
('东三环中路1号', '010-88886666', '0深圳大兴奥迪旗舰店', '深圳市南山区深南大道1001号', '0758:30-18:30', 39.908722, 15-26668888', '09:00-18:00', 216.452011, NOW(), NOW(), '丰田, 本田'),
(2, '上海2.534890, 113.947230, NOW(), NOW永达宝马中心', '上海市浦东新区龙阳路2277号', '02(), '奥迪, 大众'),
('广州龙星行奔驰', '广州市天河区天河1-99998888', '09:00-19:00',路238号', '020-38889999', '09:30- 31.204580, 121.551380, NOW(), NOW(), '宝马'),
(3, '深圳大兴奥迪旗舰店', '深圳市南山区深18:30', 23.132220, 113.324560, NOW(), NOW(), '奔驰'),
('成都建国比亚迪王朝网', '成都市武侯南大道1001号', '0755-26668888', '09:区科华南路50号', '028-66667777', '0900-18:00', 22.534890, 113.94:00-18:00', 30.624790, 104.07230, NOW(), NOW(), '奥迪, 大众'),
(4, '广州龙星行奔驰72910, NOW(), NOW(), '比亚迪');

-- 6. 插入车辆信息 (', '广州市天河区天河路238号', '020-3888car) - 依赖于 series 表
-- 此时, 凯美瑞ID=1, 卡罗拉ID=9999', '09:30-18:30', 23.132, ..., 汉ID=19, ...
INSERT INTO `car` (`id`, `series_id`, `2220, 113.324560, NOW(), NOW(), '奔驰'),type`, `color`, `price`, `sale_price`, `repertory`, `status`) VALUES
(
(5, '成都建国比亚迪王朝网', '成都市武侯区科华南路50号',20240101001, 1, '2023款 2.0G  '028-66667777', '09:00-18:豪华版', '黑色', 170000.00, 19580000', 30.624790, 104.07291.00, 8, '1'),
(20240101002,0, NOW(), NOW(), '比亚迪');

-- =================================================================
-- 6. 插入 1, '2023款 2.5G 豪华版', '白色', 19车辆信息 (car)
-- =================================================================
INSERT INTO `car` (`id`, `series_id`, `0000.00, 219800.00, 5, '1type`, `color`, `price`, `sale_price`, `repertory`, `status`) VALUES
('),
(20240101003, 7, '2024款20240101001, 1, '2023款 2.0G  325i M运动套装', '墨尔本红', 290000.00, 豪华版', '黑色', 170000.00, 195800318000.00, 3, '1'),
(202401.00, 8, '1'),
(20240101002, 1, '2023款 2.5G 豪华版', '白色', 1901004, 8, '2024款 530Li 领先型 M0000.00, 219800.00, 5, '1运动', '碳黑色', 410000.00, 455000.00'),
(20240101003, 7, '2024款 325i M运动套装', '墨尔本红', 290000.00, , 4, '1'),
(20240101005, 11, '2023款 45 TFSI quattro 豪华动感', '天云灰', 318000.00, 3, '1'),
(202401380000.00, 415000.00, 2,01004, 8, '2024款 530Li 领先型 M '1'),
(20240101006, 13, '20运动', '碳黑色', 410000.00, 45500023款 C260L 运动版', '北极白', 310000.00, 4, '1'),
(20240101005, 11, '2023款 45 TFSI quattro 豪华动感', '天云灰', .00, 335000.00, 6, '1'),
(20240101007, 19, '2023款 DM-i380000.00, 415000.00, 2, 冠军版 121KM 尊贵型', '灰色', 175000.00, '1'),
(20240101006, 13, '20 189800.00, 15, '1'),
(20240101008, 22, '2023款 2.0TD DCT23款 C260L 运动版', '北极白', 310000 EVO两驱旗舰型', '翠羽蓝', 130000.00, 1.00, 335000.00, 6, '1'),
(245700.00, 10, '1'),
(2024010240101007, 19, '2023款 DM-i01009, 5, '2022款 1.5T HATCHBACK  冠军版 121KM 尊贵型', '灰色', 175000.00,燃擎版', '闪烈黄', 135000.00, 150 189800.00, 15, '1'),
(2024000.00, 1, '2'),
(202401010100101008, 22, '2023款 2.0TD DCT, 21, '2023款 DM-i 冠军版 110KM 旗舰型PLUS', EVO两驱旗舰型', '翠羽蓝', 130000.00, 1 '赤帝红', 140000.00, 153800.45700.00, 10, '1'),
(20240100, 12, '1');

-- 7. 插入订单信息 (order) - 01009, 5, '2022款 1.5T HATCHBACK 依赖于 customer 和 employee 表
INSERT INTO `order` (`id`, `customer_id`, `employee_id燃擎版', '闪烈黄', 135000.00, 150`, `total_price`, `status`, `create_time`, `pay_time`) VALUES
(32024000.00, 1, '2'),
(202401010100520001, 20230001, 1002,, 21, '2023款 DM-i 冠军版 110KM 旗舰型PLUS', 195800.00, '1', '2024-05-2 '赤帝红', 140000.00, 153800.0 10:30:00', '2024-05-20 100, 12, '1');

-- =================================================================
-- 7. 插入1:00:00'),
(320240521001, 订单信息 (order)
-- =================================================================
INSERT INTO `order` (`id`, `customer_20230003, 1005, 455000.0id`, `employee_id`, `total_price`, `status`, `create_time`, `pay_time0, '1', '2024-05-21 14:00:00', '`) VALUES
(320240520001, 2023002024-05-21 16:30:00'),
(3201, 1002, 195800.00, '1', '0240522001, 20230002, 102024-05-20 10:30:00', '20203, 335000.00, '0', '2024-05-22 09:45:00', NULL),
(3202404-05-20 11:00:00'),
(320240521001, 20230003, 1005,523001, 20230004, 1004,  455000.00, '1', '2024-05-21 14:00:00', '2024-05-21 1189800.00, '2', '2024-05-236:30:00'),
(320240522001, 20230002, 1003, 335000.0 11:10:00', NULL),
(320240524001, 20230005, 1006, 14570, '0', '2024-05-22 09:45:00', NULL),
(320240523001, 202300.00, '1', '2024-05-24 16:00:00', '2024-05-25 10:00:0004, 1004, 189800.00, '2', '200'),
(320240526001, 20230024-05-23 11:10:00', NULL),
(3001, 1002, 307600.00, '0', '2024-05-26 13:00:00', NULL);

-- 20240524001, 20230005, 18. 插入订单详情 (order_details) - 依赖于 order 和 car 表
INSERT INTO `order_details`006, 145700.00, '1', '2024-05-24 16:00:00', '2024-05- (`id`, `order_id`, `car_id`, `car_number`) VALUES
('OD-202425 10:00:00'),
(3202405260-0001', 320240520001, 20201, 20230001, 1002, 307600.40101001, 1),
('OD-2024-00000, '0', '2024-05-26 13:00:2', 320240521001, 202401000', NULL);

-- =================================================================
-- 8. 插入订单详情 (order_details)1004, 1),
('OD-2024-0003', 320240522001, 20240101006
-- =================================================================
INSERT INTO `order_details` (`id`, `order_id`, `, 1),
('OD-2024-0004', 32024car_id`, `car_number`) VALUES
('OD-2024-0001', 320240520001, 2024010100523001, 20240101007, 1),
('OD-2024-0005', 32024052401, 1),
('OD-2024-0002', 320001, 20240101008, 1),
('OD-240521001, 20240101004, 2024-0006', 320240526001,1),
('OD-2024-0003', 3202405 20240101010, 2);

-- 9. 插入预约信息 (reservation)
INSERT INTO `reservation` (`shopid`, `username`, `start`, `end`, `22001, 20240101006, 1),
('OD-2024-0004', 32024052300day`, `shopname`, `empid`) VALUES
('2', '黄总', '10:001, 20240101007, 1),
('OD-20', '11:00', '2024-06-10', '上海永达宝马24-0005', 320240524001, 2中心', 1005),
('3', '林小姐', '14:30', '0240101008, 1),
('OD-2024-0006', 320240526001, 2024015:30', '2024-06-11', '深圳大兴奥迪101010, 2);

-- =================================================================
-- 9. 插入旗舰店', 1004),
('1', '陈先生', '09:00', '10预约信息 (reservation)
-- =================================================================
INSERT INTO `reservation` (`shopid`, `username:00', '2024-06-12', '北京中达丰田4S店', `, `start`, `end`, `day`, `shopname`, `empid`) VALUES
('2', '黄1002),
('5', '游客A', '11:00', '12:总', '10:00', '11:00', '2024-0600', '2024-06-12', '成都建国比亚迪王朝网',-10', '上海永达宝马中心', 1005),
('3', '林小姐', 1006);

-- 10. 插入基础月份 (base_month)
INSERT INTO '14:30', '15:30', '2024-06-1 `base_month` (`date`) VALUES
('2023-01'), ('2023-021', '深圳大兴奥迪旗舰店', 1004),
('1', '陈先生', '0'), ('2023-03'), ('2023-04'), ('20239:00', '10:00', '2024-06-12',-05'), ('2023-06'),
('2023-07'), (' '北京中达丰田4S店', 1002),
('5', '游客A', '12023-08'), ('2023-09'), ('2023-11:00', '12:00', '2024-06-12',0'), ('2023-11'), ('2023-12'),
('20 '成都建国比亚迪王朝网', 1006);

-- =================================================================
-- 1024-01'), ('2024-02'), ('2024-03'),. 插入基础月份 (base_month)
-- =================================================================
INSERT INTO `base_month ('2024-04'), ('2024-05'), ('2024-` (`date`) VALUES
('2023-01'), ('2023-02'), ('2006'),
('2024-07'), ('2024-08'), ('223-03'), ('2023-04'), ('2023-05'),024-09'), ('2024-10'), ('2024-11 ('2023-06'),
('2023-07'), ('2023-08'), ('2023-09'), ('2023-10'), ('2023-11'), ('2023-12'),
('2024-01'), ('2024-02'), ('2024-03'), ('2024-04'), ('2024-05'), ('2024-06'),
'), ('2024-12');