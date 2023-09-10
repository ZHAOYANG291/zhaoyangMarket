-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: zhaoyangmarket
-- ------------------------------------------------------
-- Server version	8.0.27

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `administrator`
--

DROP TABLE IF EXISTS `administrator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `administrator` (
  `username` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `nick_name` varchar(15) DEFAULT NULL COMMENT '网名',
  `level` tinyint DEFAULT '3',
  `headPortraitUrl` varchar(120) DEFAULT NULL,
  `lastOnline_date` varchar(25) DEFAULT NULL,
  `lastOnline_address` varchar(20) DEFAULT NULL,
  `currentOnline_date` varchar(25) DEFAULT NULL,
  `currentOnline_address` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `administrator`
--

LOCK TABLES `administrator` WRITE;
/*!40000 ALTER TABLE `administrator` DISABLE KEYS */;
INSERT INTO `administrator` VALUES ('123','123','狗头',2,'https://tse3-mm.cn.bing.net/th/id/OIP-C.12MmFldI3GfBRH9xld_EogHaLF?w=124&h=185&c=7&r=0&o=5&dpr=1.3&pid=1.7','2023-09-04 10:55:00',NULL,'2023-09-04 17:48:45',NULL),('124','124','Tom',3,'https://i02piccdn.sogoucdn.com/ab1f76b9c33f3b62','2023-09-04 17:00:36',NULL,'2023-09-04 18:50:30',NULL),('125','125','sao',3,'https://i03piccdn.sogoucdn.com/f300aa234062d870','2023-09-03 22:05:04',NULL,'2023-09-03 22:07:40',NULL),('126','126','GGBOOM',5,'https://th.bing.com/th/id/OIP.tOpC2VVVZbDC3WichmQL9QHaFn?pid=ImgDet&rs=1','2023-09-04 14:39:27',NULL,'2023-09-04 18:58:56',NULL),('127','127','血精灵',5,'https://i03piccdn.sogoucdn.com/7363d71bbe6e9f86','2023-09-03 22:13:56',NULL,'2023-09-04 18:20:58',NULL);
/*!40000 ALTER TABLE `administrator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `total_sale` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'游戏',10),(2,'小说',16),(3,'影视',66),(4,'漫画',3),(5,'音频',1),(6,'图片',82),(7,'神奇软件',109),(8,'神秘信息',103),(9,'其他',66);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `number` varchar(40) NOT NULL,
  `user_username` varchar(20) NOT NULL,
  `product_id` int NOT NULL,
  PRIMARY KEY (`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(120) NOT NULL,
  `description` varchar(300) DEFAULT NULL,
  `coverImage_url` varchar(300) DEFAULT NULL,
  `explainImage_urls` varchar(600) DEFAULT NULL,
  `new_price` int unsigned NOT NULL,
  `already_sale` int DEFAULT '0',
  `stock_quantity` int DEFAULT '-1' COMMENT '-1代表没有库存限制(电子信息资源，通常没有库存额概念)',
  `category_id` tinyint NOT NULL COMMENT '种类 对应Category表：  \\n1、游戏；2、小说；3、影视；4、漫画；5、音频；6、图片；7、神奇软件；8、神秘信息；9、其他',
  `on_sale` tinyint DEFAULT '1' COMMENT '是否在售：0表示false，1表示true  默认1',
  `level` tinyint unsigned DEFAULT '100' COMMENT '代表显示的优先级，范围在0-255，默认为100',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `resource` varchar(10000) NOT NULL DEFAULT '空空如也' COMMENT '资源(你有10000字以内的空间对自己的资源进行说明)，强烈推荐以百度网盘或其他网盘链接作为资源地址，并要求附上提取码。    如：\n**网盘地址:"........"         提取码:"...."  ',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=191 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (2,'我是你跌','这里是百威啤酒','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',2,3,105,2,1,109,'2023-05-11 15:30:00','2023-09-02 13:08:55','空空如也'),(3,'啤酒','我是啤酒000','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',15,2,105,2,1,108,'2023-05-11 15:30:01','2023-09-01 20:54:22','空空如也'),(4,'小罐茶','小罐茶，大师作','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',250,12,NULL,5,0,100,NULL,'2023-06-11 09:42:36','空空如也'),(93,'随便卖点啥','随便咯','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',1,0,NULL,1,1,100,NULL,'2023-09-02 09:58:43','空空如也'),(95,'随便卖点啥sss','随便咯','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',30,0,5,1,0,100,NULL,'2023-09-02 13:29:38','空空如也'),(97,'随便卖点啥啊啊啊','随便咯','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',5783,0,NULL,6,1,100,NULL,'2023-09-02 21:24:28','空空如也'),(98,'随便卖点啥','随便咯','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',6,0,66,3,1,100,NULL,'2023-08-01 23:12:01','空空如也'),(101,'随便卖点啥','随便咯','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',9,0,NULL,1,1,100,NULL,'2023-06-08 15:51:59','空空如也'),(102,'随便卖点啥','随便咯','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',10,0,NULL,1,0,100,NULL,NULL,'空空如也'),(103,'随便卖点啥','随便咯','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',11,0,NULL,1,0,100,NULL,NULL,'空空如也'),(104,'随便卖点啥','随便咯','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',12,0,NULL,1,0,100,NULL,NULL,'空空如也'),(105,'随便卖点啥','随便咯','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',13,0,NULL,1,0,100,NULL,'2023-07-12 17:08:34','空空如也'),(106,'随便卖点啥','随便咯','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',14,0,NULL,1,0,100,NULL,NULL,'空空如也'),(107,'随便卖点啥','随便咯','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',15,0,NULL,3,1,100,NULL,'2023-06-07 10:12:48','空空如也'),(108,'随便卖点啥','随便咯','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',16,0,NULL,1,1,100,NULL,'2023-07-02 20:07:36','空空如也'),(110,'随便卖点啥','随便咯','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',18,0,NULL,1,1,100,NULL,NULL,'空空如也'),(111,'随便卖点啥','随便咯','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',19,0,NULL,1,1,100,NULL,NULL,'空空如也'),(112,'随便卖点啥','随便咯','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',20,0,NULL,1,1,100,NULL,NULL,'空空如也'),(113,'随便卖点啥','随便咯','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',21,0,NULL,1,1,100,NULL,NULL,'空空如也'),(114,'随便卖点啥','随便咯','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',22,0,NULL,1,1,100,NULL,NULL,'空空如也'),(115,'随便卖点啥','随便咯','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',23,0,NULL,1,1,100,NULL,NULL,'空空如也'),(116,'随便卖点啥','随便咯','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',24,0,NULL,1,0,100,NULL,NULL,'空空如也'),(117,'随便卖点啥','随便咯','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',25,0,NULL,1,0,100,NULL,NULL,'空空如也'),(118,'随便卖点啥','随便咯','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',26,0,NULL,1,1,100,NULL,NULL,'空空如也'),(119,'随便卖点啥','随便咯','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',27,0,NULL,1,1,100,NULL,NULL,'空空如也'),(120,'随便卖点啥','随便咯','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',28,0,NULL,1,1,100,NULL,'2023-07-03 08:34:15','空空如也'),(121,'随便卖点啥','随便咯','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',29,0,NULL,1,1,100,NULL,NULL,'空空如也'),(122,'随便卖点啥','随便咯','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',30,0,NULL,1,1,100,NULL,NULL,'空空如也'),(124,'随便卖点啥','随便咯','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',32,0,NULL,1,1,100,NULL,'2023-09-01 15:42:41','空空如也'),(125,'随便卖点啥','随便咯','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',33,0,NULL,1,0,100,NULL,'2023-09-01 15:46:41','空空如也'),(126,'随便卖点啥','随便咯','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',34,0,NULL,1,1,100,NULL,NULL,'空空如也'),(127,'随便卖点啥','随便咯','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',35,0,NULL,1,1,100,NULL,NULL,'空空如也'),(128,'随便卖点啥','随便咯','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',36,0,NULL,1,1,100,NULL,NULL,'空空如也'),(129,'随便卖点啥','随便咯','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',37,0,NULL,1,1,100,NULL,NULL,'空空如也'),(130,'0','0','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',0,0,0,0,0,1,NULL,NULL,'空空如也'),(131,'3','3','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',3,3,3,33,1,33,NULL,'2023-07-12 19:02:49','空空如也'),(132,'s','2','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',22222,2,2,2,1,100,NULL,'2023-07-12 19:03:11','空空如也'),(133,'110','010101','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',110,1,NULL,101,1,100,NULL,'2023-07-12 18:57:05','空空如也'),(134,'33','33','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',33,3,33,33,0,2,NULL,NULL,'空空如也'),(135,'3666','2112222','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',66,0,NULL,5,1,100,NULL,'2023-07-12 18:59:08','空空如也'),(136,'暴风吸入，绝绝子！暴风吸入，绝绝子，',NULL,'https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',2,0,NULL,2,1,100,NULL,'2023-07-12 19:01:33','空空如也'),(137,'暴风吸入，绝绝子！暴风吸入，绝绝子！暴风吸入，绝绝子！暴风吸入，绝  绝子！暴风吸入，绝绝子！暴风吸入，绝绝子！暴风吸入','null','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',5,0,NULL,3,1,100,NULL,'2023-06-09 12:50:30','空空如也'),(138,'‘kkk','null','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',26,0,NULL,2,0,100,NULL,'2023-06-09 12:50:40','空空如也'),(139,'‘aa,,',NULL,'https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',1,0,NULL,1,0,100,NULL,NULL,'空空如也'),(140,'花花','花花的世界很美好','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',25,0,NULL,3,1,100,NULL,'2023-06-24 15:20:42','空空如也'),(141,'花花世界花花世界花花花花世界花花世界花花花花世界花花世界花花花花世界花花世界花花',NULL,'https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',26,0,NULL,22,1,100,NULL,NULL,'空空如也'),(142,'呼呼大睡','哒哒哒','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',12,0,NULL,1,1,100,NULL,NULL,'空空如也'),(143,'111',NULL,'https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',1,0,-1,2,1,100,NULL,NULL,'空空如也'),(144,'花花世界，有我有你','这是一款神奇的漫画','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',63,0,-1,4,0,66,NULL,NULL,'空空如也'),(145,'泪花','小说说','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',12,0,55,2,0,55,'2023-06-07 10:21:44','2023-06-07 10:21:44','空空如也'),(146,'孤独的根号三','这是一个孤独的根号三','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',3,0,-1,1,1,15,'2023-06-08 15:33:13','2023-06-08 15:33:13','空空如也'),(147,'测试','这是测试商品','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',7,0,-1,2,1,100,NULL,NULL,'空空如也'),(148,'测试','这是测试商品','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',7,0,-1,2,1,100,NULL,NULL,'空空如也'),(149,'测试','这是测试商品','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',7,0,-1,2,1,100,NULL,NULL,'空空如也'),(150,'测试','这是测试商品','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',7,0,-1,2,1,100,NULL,NULL,'空空如也'),(151,'测试','这是测试商品','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',7,0,-1,2,1,100,NULL,NULL,'空空如也'),(152,'测试','这是测试商品','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',7,0,-1,2,1,100,NULL,NULL,'空空如也'),(153,'测试','这是测试商品','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',7,0,-1,2,1,100,NULL,NULL,'空空如也'),(154,'测试','这是测试商品','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',7,0,-1,2,1,100,NULL,NULL,'空空如也'),(155,'测试','这是测试商品','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',7,0,-1,2,1,100,NULL,NULL,'空空如也'),(156,'测试','这是测试商品','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',7,0,-1,2,1,100,NULL,NULL,'空空如也'),(157,'测试','这是测试商品','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',7,0,-1,2,1,100,NULL,NULL,'空空如也'),(158,'测试','这是测试商品','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',7,0,-1,2,1,100,NULL,'2023-06-08 15:43:20','空空如也'),(159,'测试','这是测试商品','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',7,0,-1,2,1,100,NULL,NULL,'空空如也'),(160,'测试','这是测试商品','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',7,0,-1,2,1,100,NULL,NULL,'空空如也'),(161,'测试','这是测试商品','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',7,0,-1,2,1,100,NULL,NULL,'空空如也'),(162,'测试','这是测试商品','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',7,0,-1,2,1,100,NULL,NULL,'空空如也'),(163,'测试','这是测试商品','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',7,0,-1,2,1,100,NULL,NULL,'空空如也'),(164,'测试','这是测试商品','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',7,0,-1,2,1,100,NULL,NULL,'空空如也'),(165,'测试','这是测试商品','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',7,0,-1,2,1,100,NULL,NULL,'空空如也'),(166,'测试','这是测试商品','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',7,0,-1,2,1,100,NULL,NULL,'空空如也'),(167,'测试','这是测试商品','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',7,0,-1,2,1,100,NULL,NULL,'空空如也'),(168,'测试','这是测试商品','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',7,0,-1,2,1,100,NULL,NULL,'空空如也'),(169,'测试','这是测试商品','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',7,0,-1,2,1,100,NULL,NULL,'空空如也'),(171,'测试','这是测试商品','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',7,0,-1,2,1,100,NULL,NULL,'空空如也'),(172,'测试','这是测试商品','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',7,0,-1,2,1,100,NULL,NULL,'空空如也'),(174,'打啊泪大大大','无法描述','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',2,0,-1,4,1,100,'2023-06-10 18:24:10','2023-06-10 18:24:10','空空如也'),(175,'ada',NULL,'https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',33,0,-1,1,1,100,'2023-06-11 00:13:20','2023-06-11 00:13:20','空空如也'),(176,'逆天邪神.txt','由火星引力编写的玄幻小说，逆天邪神，连载中','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',13,0,-1,2,1,100,'2023-06-11 09:24:56','2023-06-11 09:24:56','空空如也'),(177,'醉古堂剑扫','由陆绍珩编写的千古奇书','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',4,0,-1,2,1,5,'2023-06-24 15:34:55','2023-06-24 15:34:55','空空如也'),(178,'方法','444','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',22,0,5,1,1,123,'2023-06-25 16:36:58','2023-07-02 21:47:51','空空如也'),(179,'2',NULL,'https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',2,0,-1,2,1,51,'2023-06-25 16:39:02','2023-07-02 21:58:20','空空如也'),(180,'咯咯',NULL,'https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',2,0,-1,2,1,101,'2023-06-25 16:39:02','2023-06-25 16:59:23','空空如也'),(181,'2',NULL,'https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',2,0,-1,2,1,127,'2023-06-25 16:39:02','2023-06-25 16:39:02','空空如也'),(182,'咯咯','没有描述','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',15,0,-1,1,1,255,'2023-06-25 16:59:01','2023-07-02 22:06:22','空空如也'),(183,'CPU-Z，检测电脑硬件信息的一款轻量级且实用的软件','','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',2,0,-1,7,1,100,'2023-07-02 20:20:06','2023-09-02 15:38:55','空空如也'),(184,'秦始皇陵','HAHAH','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',3,0,-1,2,0,100,'2023-09-02 11:16:50','2023-09-02 11:16:50','空空如也'),(185,'秦始皇陵','HAHAH','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',3,0,-1,2,0,100,'2023-09-02 11:16:52','2023-09-02 11:16:52','空空如也'),(186,'秦始皇陵','HAHAH','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',3,0,-1,2,0,100,'2023-09-02 11:16:56','2023-09-02 11:16:56','空空如也'),(187,'请始皇陵','ss','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',222,0,-1,1,1,100,'2023-09-02 11:18:16','2023-09-02 11:18:16','空空如也'),(189,'亲爱的展博 当你看到这封信的时候 我已经在去机场的路上了 请原谅我改签了航班 我知道 如果我看到你们 肯定就走不了了 因为我舍不得你们每一个人 尤其是你 和大家在一起的日子 是我一生中最快乐的时光 虽然我也不想结束 但是','遗憾','https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',520,0,-1,2,1,100,'2023-09-03 12:00:29','2023-09-03 12:00:29','空空如也'),(190,'s',NULL,'https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg','[\"https://img.zcool.cn/community/01d89d556899f60000012716e4364f.jpg@1280w_1l_2o_100sh.jpg\"]',5,0,-1,2,1,100,'2023-09-04 18:52:33','2023-09-04 18:52:33','空空如也');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `username` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `nick_name` varchar(15) DEFAULT NULL,
  `heart` int unsigned DEFAULT NULL,
  `registration_date` varchar(15) DEFAULT NULL,
  `latelyOnline_date` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('111','111g222','11',111,'2023-08-28','2023-09-02'),('1113','1123','花无缺',55,'2023-08-31','2023-08-07'),('1157','1157','雷霆',1157,'2023-08-29','2023-04-21'),('1212','1212','l理由',11123,NULL,'2023-09-02'),('123','123','44',444,NULL,'2023-09-02'),('1232','1232aa0','放逐',13,'2023-09-01','2023-09-02'),('19200','19200','吴凡',66,'2023-09-03',NULL),('2222','2222','二虎',16,NULL,'2023-09-03'),('260918','260918','朝阳',999999,'2023-09-02','2023-09-02'),('999','999','碧瑶',999,'2023-09-02','2023-09-03'),('aa','44','4',1,'2023-09-02','2023-09-02'),('pp','3','36',33,'2023-07-12','2023-09-01'),('sb','SB520','至尊情圣',112233,'2023-09-02','2023-09-02'),('sd','5','5',5,'2023-07-12',NULL),('sda','11','3',23,'2023-07-12',NULL),('ss','2','3',33,NULL,NULL),('ss0','16574','哗哗',70,NULL,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-09-10 16:54:43
