-- MySQL dump 10.13  Distrib 8.0.44, for Linux (x86_64)
--
-- Host: localhost    Database: ecom
-- ------------------------------------------------------
-- Server version	8.0.44-0ubuntu0.24.04.2

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

--
-- Current Database: `ecom`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `ecom` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `ecom`;

--
-- Table structure for table `admin_users`
--

DROP TABLE IF EXISTS `admin_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_users`
--

LOCK TABLES `admin_users` WRITE;
/*!40000 ALTER TABLE `admin_users` DISABLE KEYS */;
INSERT INTO `admin_users` VALUES (1,'admin','admin');
/*!40000 ALTER TABLE `admin_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `categories` varchar(255) NOT NULL,
  `status` tinyint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Mobile',1),(2,'Tablet',1),(3,'Laptop',1),(4,'Tv',1);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chatbot_keywords`
--

DROP TABLE IF EXISTS `chatbot_keywords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chatbot_keywords` (
  `keyword` varchar(64) NOT NULL,
  `hits` int NOT NULL DEFAULT '1',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`keyword`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chatbot_keywords`
--

LOCK TABLES `chatbot_keywords` WRITE;
/*!40000 ALTER TABLE `chatbot_keywords` DISABLE KEYS */;
INSERT INTO `chatbot_keywords` VALUES ('000',1,'2026-01-26 08:11:06'),('14s',1,'2026-01-26 06:48:38'),('200',1,'2026-01-26 07:59:05'),('300',2,'2026-01-26 08:08:25'),('50000',1,'2026-01-26 08:10:23'),('900',1,'2026-01-26 08:09:24'),('about',1,'2026-01-26 05:11:34'),('account',1,'2026-01-28 14:45:05'),('air',1,'2026-01-25 07:02:04'),('ant',1,'2026-01-26 06:48:13'),('app',1,'2026-01-27 23:50:30'),('apple',3,'2026-01-26 06:14:41'),('can',1,'2026-01-25 07:01:40'),('computer',1,'2026-01-26 08:10:01'),('dell',4,'2026-01-26 07:53:03'),('devices',1,'2026-01-25 14:57:03'),('g14',1,'2026-01-26 07:53:03'),('g15',3,'2026-01-26 06:47:57'),('get',1,'2026-01-25 07:01:40'),('have',4,'2026-01-27 23:47:02'),('hehehrhehrhehrrhrh',1,'2026-01-28 22:15:18'),('hp14s',2,'2026-01-26 06:48:25'),('into',1,'2026-01-27 23:50:30'),('jude',1,'2026-01-28 22:15:34'),('laptop',3,'2026-01-26 08:11:06'),('led',1,'2026-01-26 05:12:08'),('log',1,'2026-01-27 23:50:30'),('login',2,'2026-01-28 14:45:05'),('macbook',4,'2026-01-26 06:14:41'),('max',1,'2026-01-25 07:01:40'),('more',1,'2026-01-26 05:11:34'),('need',6,'2026-01-26 08:11:06'),('pavilion',1,'2026-01-26 05:11:15'),('phone',4,'2026-01-26 08:10:23'),('phones',3,'2026-01-26 06:12:44'),('pro',1,'2026-01-25 07:01:40'),('product',1,'2026-01-27 23:47:45'),('products',1,'2026-01-25 14:56:42'),('projects',1,'2026-01-27 23:47:02'),('samsung',3,'2026-01-27 23:47:45'),('sell',1,'2026-01-25 14:56:42'),('smart',1,'2026-01-26 05:12:08'),('tell',1,'2026-01-26 05:11:34'),('trying',1,'2026-01-28 14:45:05'),('unable',1,'2026-01-28 14:44:37'),('under',3,'2026-01-26 08:11:06'),('want',9,'2026-01-27 23:47:45'),('what',5,'2026-01-27 23:47:02'),('who',1,'2026-01-28 22:15:34'),('yes',1,'2026-01-26 05:11:34');
/*!40000 ALTER TABLE `chatbot_keywords` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chatbot_questions`
--

DROP TABLE IF EXISTS `chatbot_questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chatbot_questions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `session_id` varchar(128) DEFAULT NULL,
  `user_ip` varchar(64) DEFAULT NULL,
  `question` text NOT NULL,
  `matched_products` int NOT NULL DEFAULT '0',
  `out_of_scope` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `created_at` (`created_at`),
  FULLTEXT KEY `ft_question` (`question`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chatbot_questions`
--

LOCK TABLES `chatbot_questions` WRITE;
/*!40000 ALTER TABLE `chatbot_questions` DISABLE KEYS */;
INSERT INTO `chatbot_questions` VALUES (1,'3oi30oso7074vkd4amli5m969a','97.130.125.113','hi',2,0,'2026-01-25 07:01:20'),(2,'3oi30oso7074vkd4amli5m969a','97.130.125.113','can I get a macbook pro max',0,1,'2026-01-25 07:01:40'),(3,'3oi30oso7074vkd4amli5m969a','97.130.125.113','I want Apple MacBook air',0,1,'2026-01-25 07:02:04'),(4,'3oi30oso7074vkd4amli5m969a','97.130.125.113','I want DELL G15',0,1,'2026-01-25 07:02:26'),(5,'lrjp8fmi7pa353njl3qvbqcnam','184.155.154.178','what products do you sell?',0,1,'2026-01-25 14:56:42'),(6,'lrjp8fmi7pa353njl3qvbqcnam','184.155.154.178','what devices do you have?',0,1,'2026-01-25 14:57:03'),(7,'lrjp8fmi7pa353njl3qvbqcnam','184.155.154.178','what phones do you have?',0,1,'2026-01-25 14:57:22'),(8,'lrjp8fmi7pa353njl3qvbqcnam','184.155.154.178','samsung',4,0,'2026-01-25 14:58:31'),(9,'lrjp8fmi7pa353njl3qvbqcnam','184.155.154.178','phones',0,1,'2026-01-25 14:59:17'),(10,'3oi30oso7074vkd4amli5m969a','97.130.125.113','HP Pavilion',1,0,'2026-01-26 05:11:15'),(11,'3oi30oso7074vkd4amli5m969a','97.130.125.113','Yes, tell me more about it',0,1,'2026-01-26 05:11:34'),(12,'3oi30oso7074vkd4amli5m969a','97.130.125.113','LG LED Smart TV',3,0,'2026-01-26 05:12:08'),(13,'3oi30oso7074vkd4amli5m969a','97.130.125.113','DELL G15',1,0,'2026-01-26 06:11:33'),(14,'3oi30oso7074vkd4amli5m969a','97.130.125.113','Samsung',4,0,'2026-01-26 06:11:59'),(15,'3oi30oso7074vkd4amli5m969a','97.130.125.113','What phones do you have',0,1,'2026-01-26 06:12:44'),(16,'3oi30oso7074vkd4amli5m969a','97.130.125.113','I want Apple MacBook',0,1,'2026-01-26 06:14:21'),(17,'3oi30oso7074vkd4amli5m969a','97.130.125.113','Apple Macbook',3,0,'2026-01-26 06:14:41'),(18,'3oi30oso7074vkd4amli5m969a','97.130.125.113','hi',0,1,'2026-01-26 06:47:47'),(19,'3oi30oso7074vkd4amli5m969a','97.130.125.113','I want dell g15',2,0,'2026-01-26 06:47:57'),(20,'3oi30oso7074vkd4amli5m969a','97.130.125.113','i ant hp14s',0,1,'2026-01-26 06:48:13'),(21,'3oi30oso7074vkd4amli5m969a','97.130.125.113','I want hp14s',0,1,'2026-01-26 06:48:25'),(22,'3oi30oso7074vkd4amli5m969a','97.130.125.113','i want hp 14s',3,0,'2026-01-26 06:48:38'),(23,'3oi30oso7074vkd4amli5m969a','97.130.125.113','g',8,0,'2026-01-26 07:52:54'),(24,'3oi30oso7074vkd4amli5m969a','97.130.125.113','dell g14',2,0,'2026-01-26 07:53:03'),(25,'3oi30oso7074vkd4amli5m969a','97.130.125.113','I want a laptop under 300',0,1,'2026-01-26 07:58:42'),(26,'3oi30oso7074vkd4amli5m969a','97.130.125.113','I want a laptop under $200',0,1,'2026-01-26 07:59:05'),(27,'3oi30oso7074vkd4amli5m969a','97.130.125.113','I need a phone ₹300',4,0,'2026-01-26 08:08:25'),(28,'3oi30oso7074vkd4amli5m969a','97.130.125.113','I need a phone ₹900',4,0,'2026-01-26 08:09:24'),(29,'3oi30oso7074vkd4amli5m969a','97.130.125.113','I need a phone',4,0,'2026-01-26 08:09:45'),(30,'3oi30oso7074vkd4amli5m969a','97.130.125.113','I need a computer',8,0,'2026-01-26 08:10:01'),(31,'3oi30oso7074vkd4amli5m969a','97.130.125.113','I need a phone ₹50000',4,0,'2026-01-26 08:10:23'),(32,'3oi30oso7074vkd4amli5m969a','97.130.125.113','I need a HP laptop under ₹50,000',3,0,'2026-01-26 08:11:06'),(33,'kp0g731t3sb0a2grp8l0paeaus','52.95.4.12','Hi',8,0,'2026-01-26 17:55:24'),(34,'lrjp8fmi7pa353njl3qvbqcnam','184.155.154.178','What projects do you have ?',8,0,'2026-01-27 23:47:02'),(35,'lrjp8fmi7pa353njl3qvbqcnam','184.155.154.178','I want a samsung product',4,0,'2026-01-27 23:47:45'),(36,'lrjp8fmi7pa353njl3qvbqcnam','184.155.154.178','please log me into this app',8,0,'2026-01-27 23:50:30'),(37,'6c61j849q41dpq0n8bq3ptl0qa','102.91.93.254','Am unable to login',8,0,'2026-01-28 14:44:37'),(38,'6c61j849q41dpq0n8bq3ptl0qa','102.91.93.254','Am trying to login to my account',8,0,'2026-01-28 14:45:05'),(39,'9gn2vo34m26o29q6vvbngecval','209.10.192.124','Hehehrhehrhehrrhrh',8,0,'2026-01-28 22:15:18'),(40,'9gn2vo34m26o29q6vvbngecval','209.10.192.124','Who is jude',8,0,'2026-01-28 22:15:34');
/*!40000 ALTER TABLE `chatbot_questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact_us`
--

DROP TABLE IF EXISTS `contact_us`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact_us` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(75) NOT NULL,
  `mobile` varchar(15) NOT NULL,
  `comment` text NOT NULL,
  `added_on` datetime NOT NULL,
  `sentiment` varchar(20) DEFAULT NULL,
  `sentiment_score` decimal(5,2) DEFAULT NULL,
  `analyzed_at` datetime DEFAULT NULL,
  `response_text` text,
  `responded_at` datetime DEFAULT NULL,
  `response_status` varchar(20) DEFAULT NULL,
  `response_error` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact_us`
--

LOCK TABLES `contact_us` WRITE;
/*!40000 ALTER TABLE `contact_us` DISABLE KEYS */;
INSERT INTO `contact_us` VALUES (1,'John','john@gmail.com','9876543210','Testing','2021-11-05 09:08:18','Neutral',0.00,'2026-01-28 05:43:31',NULL,NULL,NULL,NULL),(2,'Jude Odion','judeodion@yahhoo.com','6114022843','I really like the products I bought from this store. They work perfectly. Thanks for all you do','2026-01-27 08:11:25','Positive',0.90,'2026-01-28 05:43:31',NULL,NULL,NULL,NULL),(3,'James','jamesaduro@aduro.com','543555222','This app sucks!','2026-01-28 05:49:55','Negative',-0.90,'2026-01-28 05:51:41',NULL,NULL,NULL,NULL),(4,'James','jamesaduro@aduro.com','543555222','The TV I bought from your store doesn\'t work well. Fake','2026-01-28 05:50:31','Negative',-0.85,'2026-01-28 05:51:42',NULL,NULL,NULL,NULL),(5,'Akala','Felix','543555222','The laptop I bought is broken. Only used it for 2 weeks','2026-01-28 05:51:06','Negative',-0.75,'2026-01-28 05:51:43',NULL,NULL,NULL,NULL),(6,'Emmanuel Madugo','emmanuelMadugo@donald.com','2223334221','This is the best store I\'ve ever bought anything from. Thanks for your services','2026-01-28 05:52:54','Positive',0.90,'2026-01-28 05:53:02',NULL,NULL,NULL,NULL),(7,'John','johndoe','2245687654','This laptop is not working, what steps do I need to follow to either return or have the laptop fixed?','2026-01-28 06:05:01',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(8,'John','johndoe','2245687654','This laptop is not working, what steps do I need to follow to either return or have the laptop fixed?','2026-01-28 06:05:25',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `contact_us` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `address` varchar(250) NOT NULL,
  `city` varchar(50) NOT NULL,
  `pincode` int NOT NULL,
  `payment_type` varchar(20) NOT NULL,
  `total_price` float NOT NULL,
  `payment_status` varchar(20) NOT NULL,
  `order_status` int NOT NULL,
  `txnid` varchar(20) NOT NULL,
  `mihpayid` varchar(20) NOT NULL,
  `payu_status` varchar(10) NOT NULL,
  `added_on` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_detail`
--

DROP TABLE IF EXISTS `order_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_detail` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `qty` int NOT NULL,
  `price` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_detail`
--

LOCK TABLES `order_detail` WRITE;
/*!40000 ALTER TABLE `order_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_status`
--

DROP TABLE IF EXISTS `order_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_status`
--

LOCK TABLES `order_status` WRITE;
/*!40000 ALTER TABLE `order_status` DISABLE KEYS */;
INSERT INTO `order_status` VALUES (1,'Pending'),(2,'Processing'),(3,'Shipped'),(4,'Canceled'),(5,'Complete');
/*!40000 ALTER TABLE `order_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `categories_id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `mrp` float NOT NULL,
  `price` float NOT NULL,
  `qty` int NOT NULL,
  `image` varchar(255) NOT NULL,
  `short_desc` varchar(2000) NOT NULL,
  `description` text NOT NULL,
  `meta_title` varchar(2000) NOT NULL,
  `meta_desc` varchar(2000) NOT NULL,
  `meta_keyword` varchar(2000) NOT NULL,
  `status` tinyint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,4,'LG LED Smart TV (55 inch)',75000,57990,5,'973338751_LG-139cm.jpg','139 cm / Ultra HD (4K) / 55%OFF','','','','',1),(2,4,'LG LED Smart TV (43 inch)',40990,33990,5,'960410002_LG-108cm.jpg','108 cm / Full HD / 17%OFF','','','','',1),(3,4,'LG LED Smart TV (32 inch)',21990,17999,5,'303148021_LG-80.jpg','80 cm / HD Ready / 18%OFF','','','','',1),(4,4,'Mi 4A (40 inch)',29999,24999,5,'513512761_Mi-4A.jpg','100 cm / Full HD LED / 16%OFF','','','','',1),(5,4,'SAMSUNG Crystal (43 inch)',52900,38990,5,'579341039_SAMSUNG-Crystal-4K-108cm.jpg','108 cm / Ultra HD (4K) / 26%OFF','','','','',1),(6,4,'SAMSUNG Series 7 (75 inch)',394900,239999,5,'748913576_SAMSUNG-Series7.jpg','189 cm / Ultra HD (4K) / 39%OFF','','','','',1),(7,4,'SONY BRAVIA (55 inch)',94900,69999,5,'669927559_SONY-BRAVIA-X7400H.jpg','138.8 cm / Ultra HD (4K) / 26%OFF','','','','',1),(8,4,'SONY Series (49 inch)',69900,49999,5,'618266821_SONY-W800G-Series.jpg','123.2 cm / Full HD / 28%OFF','','','','',1),(9,2,'Lenovo Tab M10',13900,10493,5,'343717260_Lenovo-Tab-M10.jpg','2 GB RAM / 32 GB ROM / Slate Black / 24%OFF','','','','',1),(10,2,'Lenovo Tab P11 Pro',60000,44990,5,'794584676_Lenovo-Tab-P11-Pro.jpg','6 GB RAM / 128 GB ROM / Slate Grey / 25%OFF','','','','',1),(11,2,'SAMSUNG Galaxy Tab A7',21999,18999,5,'492872912_SAMSUNG-Galaxy-TabA7.jpg','3 GB RAM / 64 GB ROM / Dark Grey / 13%OFF','','','','',1),(12,2,'SAMSUNG Galaxy Tab S7',76999,71999,5,'342801990_SAMSUNG-Galaxy-TabS7.jpg','6 GB RAM / 128 GB ROM / Mystic Black / 6%OFF','','','','',1),(13,3,'HP Pavilion',77141,66990,5,'914704118_HP-Pavilion.jpg','core i5 11th gen','','','','',1),(14,3,'HP 15s',48756,46990,5,'852702399_HP-15s.jpg','core i3 11th gen','','','','',1),(15,3,'HP 14s',45892,40000,5,'225993337_HP-14s.jpg','core i3 11th gen','','','','',1),(16,3,'DELL Inspiron Ryzen',49551,39990,5,'180164372_DELL-Inspiron-Ryzen.jpg','3 Dual Core\r\n(8 GB/1 TB HDD/Windows 10/Softmint)\r\n19% OFF','','','','',1),(17,3,'DELL G15',78324,69690,5,'348740139_DELL-G15.jpg','core i5 10th gen','','','','',1),(18,3,'APPLE MacBook Pro M1',122900,112990,5,'657014417_APPLE-MacBook-Pro-M1.jpg','core i3 11th gen','','','','',1),(19,3,'APPLE MacBook Air M1',92900,88990,5,'800395565_APPLE-MacBook-Air-M1.jpg','8-core CPU and 7-core GPU','','','','',1),(20,3,'APPLE MacBook Pro',199900,179990,5,'747252516_APPLE-MacBook-Pro.jpg','core i7 9th gen','','','','',1);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `password` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `mobile` varchar(15) NOT NULL,
  `added_on` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Shazia','shazia','shazia@gmail.com','9988776655','2021-11-05 09:11:01'),(2,'Zoya','zoya','zoya@gmail.com','9112233445','2021-11-05 09:12:04'),(3,'Mohd Sakib','mohdsakib','mohdsakib@gmail.com','9999988888','2021-11-05 09:13:22'),(4,'Mudassir','mudassir','mudassir@gmail.com','8888899999','2021-11-05 09:14:17'),(5,'Joseph Omo-Ojugo','Zeeworld','josephomoojugo@gmail.com','07032677957','2026-01-28 02:39:17'),(6,'Jude','odion','ojugo@jude','222333444','2026-01-28 05:40:03'),(7,'Join','johndoe','Johndoe@gmail.com','2124568765','2026-01-28 05:45:19'),(8,'','','','','2026-01-28 05:46:25'),(9,'john','john','john@doe','2222233333','2026-01-28 07:19:01'),(10,'james','james','james@doe','33333','2026-01-28 07:24:05'),(11,'james','jude','judes','1234567890','2026-01-28 07:36:36'),(12,'Od','od','od@jude','123455','2026-01-28 08:11:02');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wishlist`
--

DROP TABLE IF EXISTS `wishlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wishlist` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `product_id` int NOT NULL,
  `added_on` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wishlist`
--

LOCK TABLES `wishlist` WRITE;
/*!40000 ALTER TABLE `wishlist` DISABLE KEYS */;
INSERT INTO `wishlist` VALUES (4,1,7,'2021-11-06 07:35:33');
/*!40000 ALTER TABLE `wishlist` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-01-30  5:33:02
