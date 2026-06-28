-- ============================================
-- 萌宠之家 - 宠物服务预约平台
-- 数据库完整导出脚本（建表语句 + 全部数据）
-- ============================================
-- 使用方法：
--   方法1(命令行): mysql -u root -p < create_tables.sql
--   方法2(Navicat/Workbench): 打开此文件直接运行全部SQL
-- 注意事项：
--   1. 确保已安装 MySQL 8.0+
--   2. 执行前请确保 MySQL 服务已启动
--   3. 执行后请修改 src/druid.properties 中的数据库连接配置
--      (用户名、密码、端口需与你的 MySQL 一致)
-- ============================================

CREATE DATABASE IF NOT EXISTS `pet_service_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `pet_service_db`;


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `pet_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pet_info` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '宠物ID',
  `user_id` int NOT NULL COMMENT '所属用户ID',
  `name` varchar(50) NOT NULL COMMENT '宠物昵称',
  `type` varchar(20) DEFAULT NULL COMMENT '种类：猫/狗/其他',
  `age` int DEFAULT NULL COMMENT '年龄(岁/月)',
  `weight` decimal(5,2) DEFAULT NULL COMMENT '体重(kg)',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '建档时间',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `pet_info_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='宠物档案表';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `pet_info` WRITE;
/*!40000 ALTER TABLE `pet_info` DISABLE KEYS */;
INSERT INTO `pet_info` VALUES (1,1,'旺财','狗',3,12.50,'2026-05-20 16:21:52'),(2,4,'小曲奇','猫咪',2,12.00,'2026-06-06 15:38:26'),(3,4,'小花','猫咪',2,9.00,'2026-06-07 21:38:31'),(4,7,'小曲奇','猫咪',2,5.50,'2026-06-09 23:17:39'),(5,7,'小花','猫咪',2,4.50,'2026-06-09 23:17:55'),(6,7,'蛋挞','异宠',4,3.50,'2026-06-10 17:05:51'),(7,8,'蛋挞','狗狗',4,4.00,'2026-06-10 17:24:00');
/*!40000 ALTER TABLE `pet_info` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `service_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_item` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '服务项目ID',
  `merchant_id` int NOT NULL COMMENT '所属商家ID',
  `title` varchar(100) NOT NULL COMMENT '服务名称(如：高级犬类美容)',
  `type` varchar(50) DEFAULT NULL COMMENT '服务类型',
  `price` decimal(10,2) NOT NULL COMMENT '服务价格',
  `description` text COMMENT '服务详细描述',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '发布时间',
  PRIMARY KEY (`id`),
  KEY `merchant_id` (`merchant_id`),
  CONSTRAINT `service_item_ibfk_1` FOREIGN KEY (`merchant_id`) REFERENCES `sys_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='服务项目表';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `service_item` WRITE;
/*!40000 ALTER TABLE `service_item` DISABLE KEYS */;
INSERT INTO `service_item` VALUES (1,2,'全套修剪洗护(中型犬)','美容护理',190.00,'包含洗澡、剪毛、剪指甲、清理耳朵','2026-05-20 16:21:52'),(3,2,'宠物驱虫',NULL,80.00,'体内外常规驱虫，专业药剂，保障宠物健康','2026-06-06 16:24:04'),(4,2,'宠物美容',NULL,120.00,'专业全身修剪造型，包含剪指甲、清理耳道','2026-06-06 16:24:04'),(5,2,'宠物寄养',NULL,100.00,'宽敞单间，每日两次遛狗，带视频汇报(按天计费)','2026-06-06 16:24:04'),(6,5,'宠物绝育',NULL,1200.00,'宠物绝育，包括猫、狗、异宠类','2026-06-08 21:51:59'),(7,5,'异宠检查',NULL,190.00,'异宠健康服务下，包括兔子、仓鼠等','2026-06-09 23:22:21'),(8,5,'宠物美容洁牙',NULL,199.00,'','2026-06-10 14:26:31'),(9,5,'进口猫粮1kg',NULL,159.00,'','2026-06-10 14:27:26');
/*!40000 ALTER TABLE `service_item` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `service_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_order` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '订单ID',
  `user_id` int NOT NULL COMMENT '预约用户ID',
  `pet_id` int NOT NULL COMMENT '预约宠物ID',
  `service_id` int NOT NULL COMMENT '预约服务项目ID',
  `title` varchar(100) NOT NULL COMMENT '服务名称快照',
  `price` decimal(10,2) NOT NULL COMMENT '服务价格快照',
  `description` text COMMENT '服务描述快照',
  `appoint_time` datetime NOT NULL COMMENT '预约服务时间',
  `status` varchar(20) DEFAULT '待接单' COMMENT '状态：待接单/已接单/服务中/已完成/已取消',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '订单创建时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '订单备注',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `service_id` (`service_id`),
  KEY `service_order_ibfk_2` (`pet_id`),
  CONSTRAINT `service_order_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `service_order_ibfk_2` FOREIGN KEY (`pet_id`) REFERENCES `pet_info` (`id`) ON DELETE CASCADE,
  CONSTRAINT `service_order_ibfk_3` FOREIGN KEY (`service_id`) REFERENCES `service_item` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='服务预约订单表';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `service_order` WRITE;
/*!40000 ALTER TABLE `service_order` DISABLE KEYS */;
INSERT INTO `service_order` VALUES (1,4,2,1,'',0.00,NULL,'2026-06-08 20:57:00','3','2026-06-07 20:57:42',NULL),(2,4,2,1,'全套修剪洗护(中型犬)',150.00,'包含洗澡、剪毛、剪指甲、清理耳朵','2026-06-09 21:08:00','4','2026-06-07 21:08:34',NULL),(5,4,3,3,'宠物驱虫',80.00,'体内外常规驱虫，专业药剂，保障宠物健康','2026-06-24 22:05:00','4','2026-06-07 22:05:44',NULL),(6,4,3,4,'宠物美容',120.00,'专业全身修剪造型，包含剪指甲、清理耳道','2026-06-26 22:12:00','3','2026-06-07 22:12:12',NULL),(7,4,3,1,'全套修剪洗护(中型犬)',150.00,'包含洗澡、剪毛、剪指甲、清理耳朵','2026-06-17 23:21:00','3','2026-06-07 23:21:57',NULL),(8,4,3,1,'全套修剪洗护(中型犬)',150.00,'包含洗澡、剪毛、剪指甲、清理耳朵','2026-06-20 23:30:00','4','2026-06-07 23:30:15',NULL),(9,4,3,5,'宠物寄养',100.00,'宽敞单间，每日两次遛狗，带视频汇报(按天计费)','2026-07-03 17:12:00','3','2026-06-08 17:12:27','宽敞单间，每日两次遛狗，带视频汇报(按天计费)'),(10,7,4,1,'全套修剪洗护(中型犬)',190.00,'包含洗澡、剪毛、剪指甲、清理耳朵','2026-06-10 23:18:00','4','2026-06-09 23:18:42','宽敞单间，每日两次遛狗，带视频汇报(按天计费)'),(11,7,5,3,'宠物驱虫',80.00,'体内外常规驱虫，专业药剂，保障宠物健康','2026-06-13 23:19:00','1','2026-06-09 23:19:22','宽敞单间，每日两次遛狗，带视频汇报(按天计费)'),(12,7,5,1,'全套修剪洗护(中型犬)',190.00,'包含洗澡、剪毛、剪指甲、清理耳朵','2026-06-12 23:39:00','3','2026-06-09 23:39:05','狗狗怕生'),(13,8,7,1,'全套修剪洗护(中型犬)',190.00,'包含洗澡、剪毛、剪指甲、清理耳朵','2026-06-11 17:24:00','4','2026-06-10 17:24:36','宽敞单间，每日两次遛狗，带视频汇报(按天计费)');
/*!40000 ALTER TABLE `service_order` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `sys_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `password` varchar(50) NOT NULL COMMENT '登录密码',
  `phone` varchar(20) DEFAULT NULL COMMENT '联系电话',
  `role` int DEFAULT '0' COMMENT '角色：0普通用户, 1商家, 2管理员',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户与商家表';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES (1,'张三','123456','13800138000',0,'2026-05-20 16:21:52'),(2,'萌宠美容店','123456','13900139000',1,'2026-05-20 16:21:52'),(3,'李四_Test','666888','13911112222',0,'2026-05-27 14:46:33'),(4,'lili','123456','15118966469',0,'2026-05-29 14:23:20'),(5,'Baby','111111','15118966469',1,'2026-06-08 20:49:47'),(6,'HYY','111111','15118966469',0,'2026-06-09 23:14:22'),(7,'HYY1','123456','151189664692',0,'2026-06-09 23:17:16'),(8,'Baby1','111111','15118966469',0,'2026-06-10 17:23:52');
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `user_favorite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_favorite` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '收藏ID',
  `user_id` int NOT NULL COMMENT '用户ID',
  `service_id` int NOT NULL COMMENT '服务项目ID',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '收藏时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_favorite_user_service` (`user_id`,`service_id`),
  KEY `idx_favorite_user_id` (`user_id`),
  KEY `idx_favorite_service_id` (`service_id`),
  CONSTRAINT `user_favorite_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_favorite_ibfk_2` FOREIGN KEY (`service_id`) REFERENCES `service_item` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户收藏表';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `user_favorite` WRITE;
/*!40000 ALTER TABLE `user_favorite` DISABLE KEYS */;
INSERT INTO `user_favorite` VALUES (1,4,1,'2026-06-09 23:05:57'),(2,4,3,'2026-06-09 23:06:01'),(3,4,4,'2026-06-09 23:09:45'),(5,7,5,'2026-06-09 23:39:11'),(6,7,3,'2026-06-10 17:07:32'),(7,8,1,'2026-06-10 17:24:39');
/*!40000 ALTER TABLE `user_favorite` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `user_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_review` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '评价ID',
  `order_id` int NOT NULL COMMENT '关联的订单ID',
  `rating` int NOT NULL COMMENT '评分：1-5星',
  `content` text COMMENT '评价文字内容',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '评价时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `user_review_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `service_order` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户评价表';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `user_review` WRITE;
/*!40000 ALTER TABLE `user_review` DISABLE KEYS */;
INSERT INTO `user_review` VALUES (1,9,5,'非常好的体验','2026-06-08 22:45:23');
/*!40000 ALTER TABLE `user_review` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

