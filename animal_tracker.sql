-- MySQL dump 10.13  Distrib 8.0.36, for Linux (x86_64)
--
-- Host: localhost    Database: animal_tracker
-- ------------------------------------------------------
-- Server version	8.0.36-0ubuntu0.23.10.1

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
-- Table structure for table `alarm`
--

DROP TABLE IF EXISTS `alarm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alarm` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `schedule_start` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `schedule_end` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config` json DEFAULT NULL,
  `telegram` tinyint(1) NOT NULL DEFAULT '0',
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `alarm_user_fk` (`user_id`),
  CONSTRAINT `alarm_user_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alarm`
--

LOCK TABLES `alarm` WRITE;
/*!40000 ALTER TABLE `alarm` DISABLE KEYS */;
/*!40000 ALTER TABLE `alarm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alarm_notification`
--

DROP TABLE IF EXISTS `alarm_notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alarm_notification` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `config` json DEFAULT NULL,
  `point` point NOT NULL /*!80003 SRID 4326 */,
  `telegram` tinyint(1) NOT NULL DEFAULT '0',
  `date_at` datetime NOT NULL,
  `date_utc_at` datetime NOT NULL,
  `closed_at` datetime DEFAULT NULL,
  `sent_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `alarm_id` bigint unsigned DEFAULT NULL,
  `position_id` bigint unsigned DEFAULT NULL,
  `trip_id` bigint unsigned DEFAULT NULL,
  `vehicle_id` bigint unsigned NOT NULL,
  `latitude` double GENERATED ALWAYS AS (round(st_latitude(`point`),5)) STORED,
  `longitude` double GENERATED ALWAYS AS (round(st_longitude(`point`),5)) STORED,
  PRIMARY KEY (`id`),
  SPATIAL KEY `alarm_notification_point_spatialindex` (`point`),
  KEY `alarm_notification_latitude_index` (`latitude`),
  KEY `alarm_notification_longitude_index` (`longitude`),
  KEY `alarm_notification_alarm_fk` (`alarm_id`),
  KEY `alarm_notification_position_fk` (`position_id`),
  KEY `alarm_notification_trip_fk` (`trip_id`),
  KEY `alarm_notification_vehicle_fk` (`vehicle_id`),
  CONSTRAINT `alarm_notification_alarm_fk` FOREIGN KEY (`alarm_id`) REFERENCES `alarm` (`id`) ON DELETE SET NULL,
  CONSTRAINT `alarm_notification_position_fk` FOREIGN KEY (`position_id`) REFERENCES `position` (`id`) ON DELETE SET NULL,
  CONSTRAINT `alarm_notification_trip_fk` FOREIGN KEY (`trip_id`) REFERENCES `trip` (`id`) ON DELETE SET NULL,
  CONSTRAINT `alarm_notification_vehicle_fk` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicle` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alarm_notification`
--

LOCK TABLES `alarm_notification` WRITE;
/*!40000 ALTER TABLE `alarm_notification` DISABLE KEYS */;
/*!40000 ALTER TABLE `alarm_notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alarm_vehicle`
--

DROP TABLE IF EXISTS `alarm_vehicle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alarm_vehicle` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `alarm_id` bigint unsigned NOT NULL,
  `vehicle_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `alarm_vehicle_alarm_fk` (`alarm_id`),
  KEY `alarm_vehicle_vehicle_fk` (`vehicle_id`),
  CONSTRAINT `alarm_vehicle_alarm_fk` FOREIGN KEY (`alarm_id`) REFERENCES `alarm` (`id`) ON DELETE CASCADE,
  CONSTRAINT `alarm_vehicle_vehicle_fk` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicle` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alarm_vehicle`
--

LOCK TABLES `alarm_vehicle` WRITE;
/*!40000 ALTER TABLE `alarm_vehicle` DISABLE KEYS */;
/*!40000 ALTER TABLE `alarm_vehicle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `animals`
--

DROP TABLE IF EXISTS `animals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `animals` (
  `id` int NOT NULL AUTO_INCREMENT,
  `species` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `age` int DEFAULT NULL,
  `gender` enum('Male','Female','Other') DEFAULT NULL,
  `habitat` varchar(100) DEFAULT NULL,
  `weight` decimal(8,2) DEFAULT NULL,
  `date_added` date DEFAULT NULL,
  `tag` varchar(50) DEFAULT NULL,
  `timezone_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `animals`
--

LOCK TABLES `animals` WRITE;
/*!40000 ALTER TABLE `animals` DISABLE KEYS */;
/*!40000 ALTER TABLE `animals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `city` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `alias` json DEFAULT NULL,
  `point` point NOT NULL /*!80003 SRID 4326 */,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `country_id` bigint unsigned NOT NULL,
  `state_id` bigint unsigned NOT NULL,
  `latitude` double GENERATED ALWAYS AS (round(st_latitude(`point`),5)) STORED,
  `longitude` double GENERATED ALWAYS AS (round(st_longitude(`point`),5)) STORED,
  PRIMARY KEY (`id`),
  KEY `city_name_index` (`name`),
  SPATIAL KEY `city_point_spatialindex` (`point`),
  KEY `city_latitude_index` (`latitude`),
  KEY `city_longitude_index` (`longitude`),
  KEY `city_country_fk` (`country_id`),
  KEY `city_state_fk` (`state_id`),
  CONSTRAINT `city_country_fk` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`) ON DELETE CASCADE,
  CONSTRAINT `city_state_fk` FOREIGN KEY (`state_id`) REFERENCES `state` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `city`
--

LOCK TABLES `city` WRITE;
/*!40000 ALTER TABLE `city` DISABLE KEYS */;
/*!40000 ALTER TABLE `city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `configuration`
--

DROP TABLE IF EXISTS `configuration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `configuration` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `configuration_key_unique` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `configuration`
--

LOCK TABLES `configuration` WRITE;
/*!40000 ALTER TABLE `configuration` DISABLE KEYS */;
INSERT INTO `configuration` VALUES (1,'position_filter_distance','5','Discard positions if the previous position for same trip is less than X meters from the current one','2024-02-26 13:59:20','2024-02-26 13:59:20'),(2,'trip_wait_minutes','15','Wait X minutes between positions to create a new trip','2024-02-26 13:59:20','2024-02-26 13:59:20'),(3,'position_filter_signal','1','Discard positions that do not contain a valid signal','2024-02-26 13:59:20','2024-02-26 13:59:20'),(4,'shared_enabled','0','Enable or Disable the public panel of shared devices (/shared)','2024-02-26 13:59:20','2024-02-26 13:59:20'),(5,'shared_slug','','Add a slug to the /shared path to avoid direct access in the generic URL','2024-02-26 13:59:20','2024-02-26 13:59:20');
/*!40000 ALTER TABLE `configuration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `country` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `alias` json DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `country_code_unique` (`code`),
  KEY `country_name_index` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country`
--

LOCK TABLES `country` WRITE;
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
/*!40000 ALTER TABLE `country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device`
--

DROP TABLE IF EXISTS `device`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `device` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `serial` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `shared` tinyint(1) NOT NULL DEFAULT '0',
  `shared_public` tinyint(1) NOT NULL DEFAULT '0',
  `connected_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` bigint unsigned NOT NULL,
  `vehicle_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `device_serial_unique` (`serial`),
  KEY `device_code_index` (`code`),
  KEY `device_name_index` (`name`),
  KEY `device_model_index` (`model`),
  KEY `device_user_fk` (`user_id`),
  KEY `device_vehicle_fk` (`vehicle_id`),
  CONSTRAINT `device_user_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `device_vehicle_fk` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicle` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device`
--

LOCK TABLES `device` WRITE;
/*!40000 ALTER TABLE `device` DISABLE KEYS */;
INSERT INTO `device` VALUES (1,'7b2d6cc5-89f8-463e-9b36-c1c734bc0398','Test Device','T243','09023987434898','0782150448','StrongPassword2',1,1,1,NULL,'2024-02-26 14:04:58','2024-02-26 14:04:58',1,1);
/*!40000 ALTER TABLE `device` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device_alarm`
--

DROP TABLE IF EXISTS `device_alarm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `device_alarm` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `config` json DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `device_id` bigint unsigned NOT NULL,
  `telegram` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `device_alarm_device_fk` (`device_id`),
  CONSTRAINT `device_alarm_device_fk` FOREIGN KEY (`device_id`) REFERENCES `device` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_alarm`
--

LOCK TABLES `device_alarm` WRITE;
/*!40000 ALTER TABLE `device_alarm` DISABLE KEYS */;
/*!40000 ALTER TABLE `device_alarm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device_alarm_notification`
--

DROP TABLE IF EXISTS `device_alarm_notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `device_alarm_notification` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `config` json DEFAULT NULL,
  `closed_at` datetime DEFAULT NULL,
  `sent_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `device_id` bigint unsigned NOT NULL,
  `device_alarm_id` bigint unsigned DEFAULT NULL,
  `position_id` bigint unsigned DEFAULT NULL,
  `trip_id` bigint unsigned DEFAULT NULL,
  `telegram` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `device_alarm_notification_device_fk` (`device_id`),
  KEY `device_alarm_notification_position_fk` (`position_id`),
  KEY `device_alarm_notification_trip_fk` (`trip_id`),
  KEY `device_alarm_notification_device_alarm_fk` (`device_alarm_id`),
  CONSTRAINT `device_alarm_notification_device_alarm_fk` FOREIGN KEY (`device_alarm_id`) REFERENCES `device_alarm` (`id`) ON DELETE SET NULL,
  CONSTRAINT `device_alarm_notification_device_fk` FOREIGN KEY (`device_id`) REFERENCES `device` (`id`) ON DELETE CASCADE,
  CONSTRAINT `device_alarm_notification_position_fk` FOREIGN KEY (`position_id`) REFERENCES `position` (`id`) ON DELETE SET NULL,
  CONSTRAINT `device_alarm_notification_trip_fk` FOREIGN KEY (`trip_id`) REFERENCES `trip` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_alarm_notification`
--

LOCK TABLES `device_alarm_notification` WRITE;
/*!40000 ALTER TABLE `device_alarm_notification` DISABLE KEYS */;
/*!40000 ALTER TABLE `device_alarm_notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device_message`
--

DROP TABLE IF EXISTS `device_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `device_message` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `message` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `response` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `sent_at` datetime DEFAULT NULL,
  `response_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `device_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `device_message_device_fk` (`device_id`),
  CONSTRAINT `device_message_device_fk` FOREIGN KEY (`device_id`) REFERENCES `device` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_message`
--

LOCK TABLES `device_message` WRITE;
/*!40000 ALTER TABLE `device_message` DISABLE KEYS */;
INSERT INTO `device_message` VALUES (1,'{PASSWORD}{SERIAL}',NULL,NULL,NULL,'2024-02-26 14:05:12','2024-02-26 14:05:12',1);
/*!40000 ALTER TABLE `device_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `file`
--

DROP TABLE IF EXISTS `file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `file` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `size` bigint unsigned NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `related_table` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `related_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `file_name_index` (`name`),
  KEY `file_related_table_related_id_index` (`related_table`,`related_id`),
  KEY `file_user_fk` (`user_id`),
  CONSTRAINT `file_user_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file`
--

LOCK TABLES `file` WRITE;
/*!40000 ALTER TABLE `file` DISABLE KEYS */;
/*!40000 ALTER TABLE `file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ip_lock`
--

DROP TABLE IF EXISTS `ip_lock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ip_lock` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `end_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `ip_lock_ip_index` (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ip_lock`
--

LOCK TABLES `ip_lock` WRITE;
/*!40000 ALTER TABLE `ip_lock` DISABLE KEYS */;
/*!40000 ALTER TABLE `ip_lock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `language`
--

DROP TABLE IF EXISTS `language`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `language` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `language_code_unique` (`code`),
  UNIQUE KEY `language_locale_unique` (`locale`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `language`
--

LOCK TABLES `language` WRITE;
/*!40000 ALTER TABLE `language` DISABLE KEYS */;
INSERT INTO `language` VALUES (1,'Castellano','es','es_ES',1,'2024-02-26 13:59:20','2024-02-26 13:59:20'),(2,'English','en','en_US',1,'2024-02-26 13:59:20','2024-02-26 13:59:20');
/*!40000 ALTER TABLE `language` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenance`
--

DROP TABLE IF EXISTS `maintenance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `maintenance` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `workshop` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_at` date NOT NULL,
  `amount` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `distance` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `distance_next` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` bigint unsigned NOT NULL,
  `vehicle_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `maintenance_name_index` (`name`),
  KEY `maintenance_user_fk` (`user_id`),
  KEY `maintenance_vehicle_fk` (`vehicle_id`),
  CONSTRAINT `maintenance_user_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `maintenance_vehicle_fk` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicle` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenance`
--

LOCK TABLES `maintenance` WRITE;
/*!40000 ALTER TABLE `maintenance` DISABLE KEYS */;
/*!40000 ALTER TABLE `maintenance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenance_item`
--

DROP TABLE IF EXISTS `maintenance_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `maintenance_item` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `maintenance_item_name_user_id_unique` (`name`,`user_id`),
  KEY `maintenance_item_name_index` (`name`),
  KEY `maintenance_item_user_fk` (`user_id`),
  CONSTRAINT `maintenance_item_user_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenance_item`
--

LOCK TABLES `maintenance_item` WRITE;
/*!40000 ALTER TABLE `maintenance_item` DISABLE KEYS */;
INSERT INTO `maintenance_item` VALUES (1,'Test maintainance','2024-02-26 14:08:28','2024-02-26 14:08:28',1);
/*!40000 ALTER TABLE `maintenance_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenance_maintenance_item`
--

DROP TABLE IF EXISTS `maintenance_maintenance_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `maintenance_maintenance_item` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `quantity` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `amount_gross` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `amount_net` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `tax_percent` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `tax_amount` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `subtotal` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `total` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `maintenance_id` bigint unsigned NOT NULL,
  `maintenance_item_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `maintenance_maintenance_i_maintenance_maintenance_item_unique` (`maintenance_id`,`maintenance_item_id`),
  KEY `maintenance_maintenance_item_maintenance_item_fk` (`maintenance_item_id`),
  CONSTRAINT `maintenance_maintenance_item_maintenance_fk` FOREIGN KEY (`maintenance_id`) REFERENCES `maintenance` (`id`) ON DELETE CASCADE,
  CONSTRAINT `maintenance_maintenance_item_maintenance_item_fk` FOREIGN KEY (`maintenance_item_id`) REFERENCES `maintenance_item` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenance_maintenance_item`
--

LOCK TABLES `maintenance_maintenance_item` WRITE;
/*!40000 ALTER TABLE `maintenance_maintenance_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `maintenance_maintenance_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2021_01_14_000000_base',1),(2,'2021_01_14_000001_seed',1),(3,'2022_10_04_184500_device_password_port',1),(4,'2022_10_06_183000_trip_distance_time',1),(5,'2022_10_06_183000_trip_sleep',1),(6,'2022_10_07_190000_city_state_country',1),(7,'2022_10_07_193000_position_city',1),(8,'2022_10_09_233000_device_timezone',1),(9,'2022_10_10_153000_point_4326',1),(10,'2022_10_11_173000_user_admin',1),(11,'2022_10_16_190000_timezone',1),(12,'2022_10_16_193000_device_timezone',1),(13,'2022_10_16_193000_position_date_utc_at',1),(14,'2022_10_16_193000_position_timezone',1),(15,'2022_10_17_193000_refuel_units',1),(16,'2022_10_17_193000_trip_dates_utc_at',1),(17,'2022_10_17_193000_trip_timezone',1),(18,'2022_10_17_230000_refuel_quantity_before',1),(19,'2022_10_17_233000_refuel_price',1),(20,'2022_11_01_193000_device_timezone_auto',1),(21,'2022_11_02_180000_timezone_unused',1),(22,'2022_11_02_183000_timezone_geojson',1),(23,'2022_11_04_183000_device_connected_at',1),(24,'2022_11_05_220000_position_trip_id',1),(25,'2022_11_07_183000_device_message',1),(26,'2022_11_08_190000_device_message_response',1),(27,'2022_11_09_183000_device_phone_number',1),(28,'2022_11_10_183000_device_alarm',1),(29,'2022_11_23_220000_device_alarm_keys',1),(30,'2022_11_23_233000_user_telegram',1),(31,'2022_11_24_183000_device_alarm_telegram',1),(32,'2022_11_24_220000_device_alarm_notification_foreign',1),(33,'2022_11_25_223000_device_alarm_rename',1),(34,'2022_11_25_224000_device_alarm_multiple',1),(35,'2022_11_27_190000_timezone_default',1),(36,'2022_11_27_220000_alarm_notification_date_at',1),(37,'2022_11_27_223000_alarm_notification_point',1),(38,'2022_12_02_183000_server',1),(39,'2022_12_20_183000_vehicle',1),(40,'2022_12_22_223000_configuration_socket_debug',1),(41,'2022_12_22_223000_device_port',1),(42,'2022_12_27_183000_server_debug',1),(43,'2022_12_29_220000_trip_stats',1),(44,'2023_01_02_230000_user_preferences',1),(45,'2023_02_01_230000_trip_shared',1),(46,'2023_02_07_234500_device_timezone_auto',1),(47,'2023_03_09_163000_alarm_schedule',1),(48,'2023_03_22_183000_ip_lock_index',1),(49,'2023_04_27_203000_position_point_swap',1),(50,'2023_09_13_223000_maintenance',1),(51,'2023_09_14_190000_file',1),(52,'2023_09_15_183000_maintenance_date_at',1),(53,'2023_09_25_200000_device_shared',1),(54,'2023_09_27_004500_device_maker_model',1),(55,'2023_09_27_005000_device_trip_shared_public',1),(56,'2023_09_27_185000_device_trip_code_uuid',1),(57,'2023_09_29_185000_position_index',1),(58,'2023_10_02_185000_position_index',1),(59,'2023_10_05_185000_user_fail',1),(60,'2023_10_05_190000_user_session_to_user_fail',1),(61,'2023_10_05_235000_trip_index',1),(62,'2023_10_23_235000_maintenance_item',1),(63,'2023_10_25_003000_maintenance_maintenance_item_amount_gross',1),(64,'2023_10_31_185000_user_admin_mode',1),(65,'2023_10_31_185000_user_manager',1),(66,'2023_11_23_003000_user_timezone_id',1),(67,'2023_11_30_003000_refuel_position_id',1),(68,'2023_11_30_230000_city_country_id',1),(69,'2023_11_30_230000_position_state_country',1),(70,'2023_12_08_133000_language_default',1),(71,'2023_12_27_203000_point_latitude_longitude',1),(72,'2024_01_04_193000_refuel_point',1),(73,'2024_01_04_203000_city_only',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `position`
--

DROP TABLE IF EXISTS `position`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `position` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `point` point NOT NULL /*!80003 SRID 4326 */,
  `speed` decimal(6,2) unsigned NOT NULL,
  `direction` int unsigned NOT NULL,
  `signal` int unsigned NOT NULL,
  `date_at` datetime NOT NULL,
  `date_utc_at` datetime NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `city_id` bigint unsigned DEFAULT NULL,
  `device_id` bigint unsigned DEFAULT NULL,
  `timezone_id` bigint unsigned NOT NULL,
  `trip_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `vehicle_id` bigint unsigned NOT NULL,
  `latitude` double GENERATED ALWAYS AS (round(st_latitude(`point`),5)) STORED,
  `longitude` double GENERATED ALWAYS AS (round(st_longitude(`point`),5)) STORED,
  PRIMARY KEY (`id`),
  SPATIAL KEY `position_point_spatialindex` (`point`),
  KEY `position_latitude_index` (`latitude`),
  KEY `position_longitude_index` (`longitude`),
  KEY `position_city_fk` (`city_id`),
  KEY `position_timezone_fk` (`timezone_id`),
  KEY `position_vehicle_fk` (`vehicle_id`),
  KEY `position_device_id_date_utc_at_index` (`device_id`,`date_utc_at`),
  KEY `position_trip_id_date_utc_at_index` (`trip_id`,`date_utc_at`),
  KEY `position_user_id_date_utc_at_index` (`user_id`,`date_utc_at`),
  CONSTRAINT `position_city_fk` FOREIGN KEY (`city_id`) REFERENCES `city` (`id`) ON DELETE SET NULL,
  CONSTRAINT `position_device_fk` FOREIGN KEY (`device_id`) REFERENCES `device` (`id`) ON DELETE SET NULL,
  CONSTRAINT `position_timezone_fk` FOREIGN KEY (`timezone_id`) REFERENCES `timezone` (`id`) ON DELETE CASCADE,
  CONSTRAINT `position_trip_fk` FOREIGN KEY (`trip_id`) REFERENCES `trip` (`id`) ON DELETE CASCADE,
  CONSTRAINT `position_user_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `position_vehicle_fk` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicle` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `position`
--

LOCK TABLES `position` WRITE;
/*!40000 ALTER TABLE `position` DISABLE KEYS */;
/*!40000 ALTER TABLE `position` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `queue_fail`
--

DROP TABLE IF EXISTS `queue_fail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `queue_fail` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `queue_fail`
--

LOCK TABLES `queue_fail` WRITE;
/*!40000 ALTER TABLE `queue_fail` DISABLE KEYS */;
/*!40000 ALTER TABLE `queue_fail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `refuel`
--

DROP TABLE IF EXISTS `refuel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `refuel` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `distance_total` decimal(10,2) unsigned NOT NULL,
  `distance` decimal(6,2) unsigned NOT NULL,
  `quantity` decimal(6,2) unsigned NOT NULL,
  `quantity_before` decimal(6,2) unsigned NOT NULL,
  `price` decimal(7,3) unsigned NOT NULL,
  `total` decimal(6,2) unsigned NOT NULL,
  `point` point NOT NULL /*!80003 SRID 4326 */,
  `date_at` datetime NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `city_id` bigint unsigned DEFAULT NULL,
  `position_id` bigint unsigned DEFAULT NULL,
  `user_id` bigint unsigned NOT NULL,
  `vehicle_id` bigint unsigned NOT NULL,
  `latitude` double GENERATED ALWAYS AS (round(st_latitude(`point`),5)) STORED,
  `longitude` double GENERATED ALWAYS AS (round(st_longitude(`point`),5)) STORED,
  PRIMARY KEY (`id`),
  SPATIAL KEY `refuel_point_spatialindex` (`point`),
  KEY `refuel_city_fk` (`city_id`),
  KEY `refuel_position_fk` (`position_id`),
  KEY `refuel_user_fk` (`user_id`),
  KEY `refuel_vehicle_fk` (`vehicle_id`),
  CONSTRAINT `refuel_city_fk` FOREIGN KEY (`city_id`) REFERENCES `city` (`id`) ON DELETE SET NULL,
  CONSTRAINT `refuel_position_fk` FOREIGN KEY (`position_id`) REFERENCES `position` (`id`) ON DELETE SET NULL,
  CONSTRAINT `refuel_user_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `refuel_vehicle_fk` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicle` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `refuel`
--

LOCK TABLES `refuel` WRITE;
/*!40000 ALTER TABLE `refuel` DISABLE KEYS */;
/*!40000 ALTER TABLE `refuel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `server`
--

DROP TABLE IF EXISTS `server`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `server` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `port` int unsigned NOT NULL DEFAULT '0',
  `protocol` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `debug` tinyint(1) NOT NULL DEFAULT '0',
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `server`
--

LOCK TABLES `server` WRITE;
/*!40000 ALTER TABLE `server` DISABLE KEYS */;
INSERT INTO `server` VALUES (1,8091,'debug-http',1,1,'2024-02-26 13:59:20','2024-02-26 14:06:59');
/*!40000 ALTER TABLE `server` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `state`
--

DROP TABLE IF EXISTS `state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `state` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `alias` json DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `country_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `state_name_index` (`name`),
  KEY `state_country_fk` (`country_id`),
  CONSTRAINT `state_country_fk` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `state`
--

LOCK TABLES `state` WRITE;
/*!40000 ALTER TABLE `state` DISABLE KEYS */;
/*!40000 ALTER TABLE `state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timezone`
--

DROP TABLE IF EXISTS `timezone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `timezone` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `zone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `geojson` multipolygon NOT NULL,
  `default` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `timezone_zone_index` (`zone`),
  SPATIAL KEY `timezone_geojson_spatialindex` (`geojson`)
) ENGINE=InnoDB AUTO_INCREMENT=452 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timezone`
--

LOCK TABLES `timezone` WRITE;
/*!40000 ALTER TABLE `timezone` DISABLE KEYS */;
INSERT INTO `timezone` VALUES (1,'Africa/Abidjan',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:20','2024-02-26 13:59:20'),(2,'Africa/Accra',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:20','2024-02-26 13:59:20'),(3,'Africa/Addis_Ababa',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:20','2024-02-26 13:59:20'),(4,'Africa/Algiers',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:20','2024-02-26 13:59:20'),(5,'Africa/Asmara',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:20','2024-02-26 13:59:20'),(6,'Africa/Bamako',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:20','2024-02-26 13:59:20'),(7,'Africa/Bangui',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:20','2024-02-26 13:59:20'),(8,'Africa/Banjul',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:20','2024-02-26 13:59:20'),(9,'Africa/Bissau',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:20','2024-02-26 13:59:20'),(10,'Africa/Blantyre',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:20','2024-02-26 13:59:20'),(11,'Africa/Brazzaville',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:20','2024-02-26 13:59:20'),(12,'Africa/Bujumbura',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:20','2024-02-26 13:59:20'),(13,'Africa/Cairo',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:20','2024-02-26 13:59:20'),(14,'Africa/Casablanca',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:20','2024-02-26 13:59:20'),(15,'Africa/Ceuta',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:20','2024-02-26 13:59:20'),(16,'Africa/Conakry',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:20','2024-02-26 13:59:20'),(17,'Africa/Dakar',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:20','2024-02-26 13:59:20'),(18,'Africa/Dar_es_Salaam',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:20','2024-02-26 13:59:20'),(19,'Africa/Djibouti',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:20','2024-02-26 13:59:20'),(20,'Africa/Douala',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:20','2024-02-26 13:59:20'),(21,'Africa/El_Aaiun',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:20','2024-02-26 13:59:20'),(22,'Africa/Freetown',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:20','2024-02-26 13:59:20'),(23,'Africa/Gaborone',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:20','2024-02-26 13:59:20'),(24,'Africa/Harare',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:20','2024-02-26 13:59:20'),(25,'Africa/Johannesburg',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:20','2024-02-26 13:59:20'),(26,'Africa/Juba',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:20','2024-02-26 13:59:20'),(27,'Africa/Kampala',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:20','2024-02-26 13:59:20'),(28,'Africa/Khartoum',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:20','2024-02-26 13:59:20'),(29,'Africa/Kigali',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:20','2024-02-26 13:59:20'),(30,'Africa/Kinshasa',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:20','2024-02-26 13:59:20'),(31,'Africa/Lagos',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:20','2024-02-26 13:59:20'),(32,'Africa/Libreville',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:20','2024-02-26 13:59:20'),(33,'Africa/Lome',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:21','2024-02-26 13:59:21'),(34,'Africa/Luanda',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:21','2024-02-26 13:59:21'),(35,'Africa/Lubumbashi',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:21','2024-02-26 13:59:21'),(36,'Africa/Lusaka',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:21','2024-02-26 13:59:21'),(37,'Africa/Malabo',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:21','2024-02-26 13:59:21'),(38,'Africa/Maputo',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:21','2024-02-26 13:59:21'),(39,'Africa/Maseru',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:21','2024-02-26 13:59:21'),(40,'Africa/Mbabane',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:21','2024-02-26 13:59:21'),(41,'Africa/Mogadishu',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:21','2024-02-26 13:59:21'),(42,'Africa/Monrovia',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:21','2024-02-26 13:59:21'),(43,'Africa/Nairobi',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:21','2024-02-26 13:59:21'),(44,'Africa/Ndjamena',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:21','2024-02-26 13:59:21'),(45,'Africa/Niamey',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:21','2024-02-26 13:59:21'),(46,'Africa/Nouakchott',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:21','2024-02-26 13:59:21'),(47,'Africa/Ouagadougou',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:21','2024-02-26 13:59:21'),(48,'Africa/Porto-Novo',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:21','2024-02-26 13:59:21'),(49,'Africa/Sao_Tome',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:21','2024-02-26 13:59:21'),(50,'Africa/Tripoli',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:21','2024-02-26 13:59:21'),(51,'Africa/Tunis',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:21','2024-02-26 13:59:21'),(52,'Africa/Windhoek',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:21','2024-02-26 13:59:21'),(53,'America/Adak',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:21','2024-02-26 13:59:21'),(54,'America/Anchorage',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:21','2024-02-26 13:59:21'),(55,'America/Anguilla',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:21','2024-02-26 13:59:21'),(56,'America/Antigua',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:21','2024-02-26 13:59:21'),(57,'America/Araguaina',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:21','2024-02-26 13:59:21'),(58,'America/Argentina/Buenos_Aires',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:21','2024-02-26 13:59:21'),(59,'America/Argentina/Catamarca',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:21','2024-02-26 13:59:21'),(60,'America/Argentina/Cordoba',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:21','2024-02-26 13:59:21'),(61,'America/Argentina/Jujuy',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:21','2024-02-26 13:59:21'),(62,'America/Argentina/La_Rioja',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:21','2024-02-26 13:59:21'),(63,'America/Argentina/Mendoza',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:21','2024-02-26 13:59:21'),(64,'America/Argentina/Rio_Gallegos',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:21','2024-02-26 13:59:21'),(65,'America/Argentina/Salta',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:21','2024-02-26 13:59:21'),(66,'America/Argentina/San_Juan',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:21','2024-02-26 13:59:21'),(67,'America/Argentina/San_Luis',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:21','2024-02-26 13:59:21'),(68,'America/Argentina/Tucuman',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:21','2024-02-26 13:59:21'),(69,'America/Argentina/Ushuaia',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:21','2024-02-26 13:59:21'),(70,'America/Aruba',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:21','2024-02-26 13:59:21'),(71,'America/Asuncion',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:21','2024-02-26 13:59:21'),(72,'America/Atikokan',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:21','2024-02-26 13:59:21'),(73,'America/Bahia',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:21','2024-02-26 13:59:21'),(74,'America/Bahia_Banderas',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:21','2024-02-26 13:59:21'),(75,'America/Barbados',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:21','2024-02-26 13:59:21'),(76,'America/Belem',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:21','2024-02-26 13:59:21'),(77,'America/Belize',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:21','2024-02-26 13:59:21'),(78,'America/Blanc-Sablon',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:21','2024-02-26 13:59:21'),(79,'America/Boa_Vista',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:21','2024-02-26 13:59:21'),(80,'America/Bogota',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(81,'America/Boise',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(82,'America/Cambridge_Bay',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(83,'America/Campo_Grande',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(84,'America/Cancun',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(85,'America/Caracas',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(86,'America/Cayenne',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(87,'America/Cayman',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(88,'America/Chicago',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(89,'America/Chihuahua',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(90,'America/Costa_Rica',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(91,'America/Creston',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(92,'America/Cuiaba',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(93,'America/Curacao',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(94,'America/Danmarkshavn',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(95,'America/Dawson',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(96,'America/Dawson_Creek',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(97,'America/Denver',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(98,'America/Detroit',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(99,'America/Dominica',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(100,'America/Edmonton',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(101,'America/Eirunepe',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(102,'America/El_Salvador',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(103,'America/Fort_Nelson',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(104,'America/Fortaleza',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(105,'America/Glace_Bay',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(106,'America/Goose_Bay',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(107,'America/Grand_Turk',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(108,'America/Grenada',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(109,'America/Guadeloupe',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(110,'America/Guatemala',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(111,'America/Guayaquil',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(112,'America/Guyana',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(113,'America/Halifax',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(114,'America/Havana',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(115,'America/Hermosillo',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(116,'America/Indiana/Indianapolis',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(117,'America/Indiana/Knox',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(118,'America/Indiana/Marengo',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(119,'America/Indiana/Petersburg',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(120,'America/Indiana/Tell_City',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(121,'America/Indiana/Vevay',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(122,'America/Indiana/Vincennes',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(123,'America/Indiana/Winamac',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(124,'America/Inuvik',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(125,'America/Iqaluit',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(126,'America/Jamaica',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(127,'America/Juneau',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(128,'America/Kentucky/Louisville',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(129,'America/Kentucky/Monticello',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(130,'America/Kralendijk',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(131,'America/La_Paz',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(132,'America/Lima',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(133,'America/Los_Angeles',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(134,'America/Lower_Princes',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:22','2024-02-26 13:59:22'),(135,'America/Maceio',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(136,'America/Managua',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(137,'America/Manaus',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(138,'America/Marigot',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(139,'America/Martinique',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(140,'America/Matamoros',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(141,'America/Mazatlan',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(142,'America/Menominee',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(143,'America/Merida',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(144,'America/Metlakatla',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(145,'America/Mexico_City',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(146,'America/Miquelon',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(147,'America/Moncton',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(148,'America/Monterrey',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(149,'America/Montevideo',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(150,'America/Montserrat',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(151,'America/Nassau',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(152,'America/New_York',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(153,'America/Nipigon',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(154,'America/Nome',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(155,'America/Noronha',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(156,'America/North_Dakota/Beulah',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(157,'America/North_Dakota/Center',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(158,'America/North_Dakota/New_Salem',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(159,'America/Nuuk',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(160,'America/Ojinaga',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(161,'America/Panama',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(162,'America/Pangnirtung',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(163,'America/Paramaribo',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(164,'America/Phoenix',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(165,'America/Port_of_Spain',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(166,'America/Port-au-Prince',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(167,'America/Porto_Velho',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(168,'America/Puerto_Rico',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(169,'America/Punta_Arenas',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(170,'America/Rainy_River',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(171,'America/Rankin_Inlet',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(172,'America/Recife',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(173,'America/Regina',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(174,'America/Resolute',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(175,'America/Rio_Branco',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(176,'America/Santarem',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(177,'America/Santiago',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(178,'America/Santo_Domingo',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(179,'America/Sao_Paulo',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(180,'America/Scoresbysund',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(181,'America/Sitka',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(182,'America/St_Barthelemy',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(183,'America/St_Johns',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(184,'America/St_Kitts',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(185,'America/St_Lucia',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(186,'America/St_Thomas',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(187,'America/St_Vincent',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(188,'America/Swift_Current',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:23','2024-02-26 13:59:23'),(189,'America/Tegucigalpa',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(190,'America/Thule',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(191,'America/Thunder_Bay',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(192,'America/Tijuana',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(193,'America/Toronto',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(194,'America/Tortola',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(195,'America/Vancouver',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(196,'America/Whitehorse',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(197,'America/Winnipeg',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(198,'America/Yakutat',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(199,'America/Yellowknife',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(200,'Antarctica/Casey',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(201,'Antarctica/Davis',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(202,'Antarctica/DumontDUrville',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(203,'Antarctica/Macquarie',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(204,'Antarctica/Mawson',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(205,'Antarctica/McMurdo',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(206,'Antarctica/Palmer',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(207,'Antarctica/Rothera',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(208,'Antarctica/Syowa',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(209,'Antarctica/Troll',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(210,'Antarctica/Vostok',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(211,'Arctic/Longyearbyen',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(212,'Asia/Aden',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(213,'Asia/Almaty',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(214,'Asia/Amman',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(215,'Asia/Anadyr',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(216,'Asia/Aqtau',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(217,'Asia/Aqtobe',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(218,'Asia/Ashgabat',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(219,'Asia/Atyrau',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(220,'Asia/Baghdad',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(221,'Asia/Bahrain',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(222,'Asia/Baku',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(223,'Asia/Bangkok',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(224,'Asia/Barnaul',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(225,'Asia/Beirut',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(226,'Asia/Bishkek',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(227,'Asia/Brunei',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(228,'Asia/Chita',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(229,'Asia/Choibalsan',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(230,'Asia/Colombo',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(231,'Asia/Damascus',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(232,'Asia/Dhaka',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(233,'Asia/Dili',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(234,'Asia/Dubai',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(235,'Asia/Dushanbe',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(236,'Asia/Famagusta',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(237,'Asia/Gaza',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(238,'Asia/Hebron',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(239,'Asia/Ho_Chi_Minh',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(240,'Asia/Hong_Kong',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(241,'Asia/Hovd',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(242,'Asia/Irkutsk',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:24','2024-02-26 13:59:24'),(243,'Asia/Jakarta',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(244,'Asia/Jayapura',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(245,'Asia/Jerusalem',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(246,'Asia/Kabul',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(247,'Asia/Kamchatka',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(248,'Asia/Karachi',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(249,'Asia/Kathmandu',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(250,'Asia/Khandyga',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(251,'Asia/Kolkata',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(252,'Asia/Krasnoyarsk',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(253,'Asia/Kuala_Lumpur',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(254,'Asia/Kuching',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(255,'Asia/Kuwait',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(256,'Asia/Macau',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(257,'Asia/Magadan',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(258,'Asia/Makassar',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(259,'Asia/Manila',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(260,'Asia/Muscat',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(261,'Asia/Nicosia',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(262,'Asia/Novokuznetsk',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(263,'Asia/Novosibirsk',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(264,'Asia/Omsk',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(265,'Asia/Oral',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(266,'Asia/Phnom_Penh',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(267,'Asia/Pontianak',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(268,'Asia/Pyongyang',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(269,'Asia/Qatar',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(270,'Asia/Qostanay',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(271,'Asia/Qyzylorda',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(272,'Asia/Riyadh',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(273,'Asia/Sakhalin',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(274,'Asia/Samarkand',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(275,'Asia/Seoul',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(276,'Asia/Shanghai',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(277,'Asia/Singapore',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(278,'Asia/Srednekolymsk',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(279,'Asia/Taipei',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(280,'Asia/Tashkent',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(281,'Asia/Tbilisi',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(282,'Asia/Tehran',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(283,'Asia/Thimphu',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(284,'Asia/Tokyo',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(285,'Asia/Tomsk',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(286,'Asia/Ulaanbaatar',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(287,'Asia/Urumqi',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(288,'Asia/Ust-Nera',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(289,'Asia/Vientiane',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(290,'Asia/Vladivostok',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(291,'Asia/Yakutsk',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(292,'Asia/Yangon',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(293,'Asia/Yekaterinburg',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(294,'Asia/Yerevan',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(295,'Atlantic/Azores',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(296,'Atlantic/Bermuda',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:25','2024-02-26 13:59:25'),(297,'Atlantic/Canary',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(298,'Atlantic/Cape_Verde',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(299,'Atlantic/Faroe',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(300,'Atlantic/Madeira',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(301,'Atlantic/Reykjavik',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(302,'Atlantic/South_Georgia',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(303,'Atlantic/St_Helena',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(304,'Atlantic/Stanley',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(305,'Australia/Adelaide',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(306,'Australia/Brisbane',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(307,'Australia/Broken_Hill',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(308,'Australia/Darwin',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(309,'Australia/Eucla',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(310,'Australia/Hobart',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(311,'Australia/Lindeman',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(312,'Australia/Lord_Howe',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(313,'Australia/Melbourne',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(314,'Australia/Perth',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(315,'Australia/Sydney',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(316,'Etc/GMT',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(317,'Etc/GMT-1',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(318,'Etc/GMT-10',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(319,'Etc/GMT-11',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(320,'Etc/GMT-12',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(321,'Etc/GMT-2',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(322,'Etc/GMT-3',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(323,'Etc/GMT-4',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(324,'Etc/GMT-5',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(325,'Etc/GMT-6',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(326,'Etc/GMT-7',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(327,'Etc/GMT-8',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(328,'Etc/GMT-9',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(329,'Etc/GMT+1',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(330,'Etc/GMT+10',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(331,'Etc/GMT+11',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(332,'Etc/GMT+12',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(333,'Etc/GMT+2',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(334,'Etc/GMT+3',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(335,'Etc/GMT+4',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(336,'Etc/GMT+5',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(337,'Etc/GMT+6',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(338,'Etc/GMT+7',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(339,'Etc/GMT+8',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(340,'Etc/GMT+9',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(341,'Etc/UTC',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(342,'Europe/Amsterdam',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(343,'Europe/Andorra',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(344,'Europe/Astrakhan',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(345,'Europe/Athens',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(346,'Europe/Belgrade',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(347,'Europe/Berlin',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(348,'Europe/Bratislava',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(349,'Europe/Brussels',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:26','2024-02-26 13:59:26'),(350,'Europe/Bucharest',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(351,'Europe/Budapest',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(352,'Europe/Busingen',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(353,'Europe/Chisinau',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(354,'Europe/Copenhagen',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(355,'Europe/Dublin',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(356,'Europe/Gibraltar',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(357,'Europe/Guernsey',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(358,'Europe/Helsinki',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(359,'Europe/Isle_of_Man',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(360,'Europe/Istanbul',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(361,'Europe/Jersey',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(362,'Europe/Kaliningrad',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(363,'Europe/Kiev',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(364,'Europe/Kirov',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(365,'Europe/Kyiv',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(366,'Europe/Lisbon',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(367,'Europe/Ljubljana',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(368,'Europe/London',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(369,'Europe/Luxembourg',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(370,'Europe/Madrid',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',1,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(371,'Europe/Malta',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(372,'Europe/Mariehamn',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(373,'Europe/Minsk',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(374,'Europe/Monaco',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(375,'Europe/Moscow',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(376,'Europe/Oslo',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(377,'Europe/Paris',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(378,'Europe/Podgorica',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(379,'Europe/Prague',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(380,'Europe/Riga',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(381,'Europe/Rome',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(382,'Europe/Samara',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(383,'Europe/San_Marino',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(384,'Europe/Sarajevo',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(385,'Europe/Saratov',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(386,'Europe/Simferopol',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(387,'Europe/Skopje',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(388,'Europe/Sofia',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(389,'Europe/Stockholm',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(390,'Europe/Tallinn',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(391,'Europe/Tirane',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(392,'Europe/Ulyanovsk',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(393,'Europe/Uzhgorod',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(394,'Europe/Vaduz',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(395,'Europe/Vatican',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(396,'Europe/Vienna',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(397,'Europe/Vilnius',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(398,'Europe/Volgograd',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(399,'Europe/Warsaw',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(400,'Europe/Zagreb',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(401,'Europe/Zaporozhye',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:27','2024-02-26 13:59:27'),(402,'Europe/Zurich',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:28','2024-02-26 13:59:28'),(403,'Indian/Antananarivo',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:28','2024-02-26 13:59:28'),(404,'Indian/Chagos',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:28','2024-02-26 13:59:28'),(405,'Indian/Christmas',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:28','2024-02-26 13:59:28'),(406,'Indian/Cocos',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:28','2024-02-26 13:59:28'),(407,'Indian/Comoro',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:28','2024-02-26 13:59:28'),(408,'Indian/Kerguelen',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:28','2024-02-26 13:59:28'),(409,'Indian/Mahe',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:28','2024-02-26 13:59:28'),(410,'Indian/Maldives',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:28','2024-02-26 13:59:28'),(411,'Indian/Mauritius',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:28','2024-02-26 13:59:28'),(412,'Indian/Mayotte',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:28','2024-02-26 13:59:28'),(413,'Indian/Reunion',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:28','2024-02-26 13:59:28'),(414,'Pacific/Apia',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:28','2024-02-26 13:59:28'),(415,'Pacific/Auckland',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:28','2024-02-26 13:59:28'),(416,'Pacific/Bougainville',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:28','2024-02-26 13:59:28'),(417,'Pacific/Chatham',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:28','2024-02-26 13:59:28'),(418,'Pacific/Chuuk',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:28','2024-02-26 13:59:28'),(419,'Pacific/Easter',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:28','2024-02-26 13:59:28'),(420,'Pacific/Efate',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:28','2024-02-26 13:59:28'),(421,'Pacific/Fakaofo',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:28','2024-02-26 13:59:28'),(422,'Pacific/Fiji',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:28','2024-02-26 13:59:28'),(423,'Pacific/Funafuti',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:28','2024-02-26 13:59:28'),(424,'Pacific/Galapagos',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:28','2024-02-26 13:59:28'),(425,'Pacific/Gambier',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:28','2024-02-26 13:59:28'),(426,'Pacific/Guadalcanal',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:28','2024-02-26 13:59:28'),(427,'Pacific/Guam',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:28','2024-02-26 13:59:28'),(428,'Pacific/Honolulu',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:28','2024-02-26 13:59:28'),(429,'Pacific/Kanton',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:28','2024-02-26 13:59:28'),(430,'Pacific/Kiritimati',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:28','2024-02-26 13:59:28'),(431,'Pacific/Kosrae',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:28','2024-02-26 13:59:28'),(432,'Pacific/Kwajalein',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:28','2024-02-26 13:59:28'),(433,'Pacific/Majuro',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:28','2024-02-26 13:59:28'),(434,'Pacific/Marquesas',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:28','2024-02-26 13:59:28'),(435,'Pacific/Midway',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:28','2024-02-26 13:59:28'),(436,'Pacific/Nauru',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:28','2024-02-26 13:59:28'),(437,'Pacific/Niue',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:28','2024-02-26 13:59:28'),(438,'Pacific/Norfolk',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:28','2024-02-26 13:59:28'),(439,'Pacific/Noumea',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:28','2024-02-26 13:59:28'),(440,'Pacific/Pago_Pago',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:28','2024-02-26 13:59:28'),(441,'Pacific/Palau',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:28','2024-02-26 13:59:28'),(442,'Pacific/Pitcairn',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:28','2024-02-26 13:59:28'),(443,'Pacific/Pohnpei',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:28','2024-02-26 13:59:28'),(444,'Pacific/Port_Moresby',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:28','2024-02-26 13:59:28'),(445,'Pacific/Rarotonga',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:28','2024-02-26 13:59:28'),(446,'Pacific/Saipan',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:28','2024-02-26 13:59:28'),(447,'Pacific/Tahiti',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:28','2024-02-26 13:59:28'),(448,'Pacific/Tarawa',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:28','2024-02-26 13:59:28'),(449,'Pacific/Tongatapu',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:28','2024-02-26 13:59:28'),(450,'Pacific/Wake',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:28','2024-02-26 13:59:28'),(451,'Pacific/Wallis',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@\0\0\0\0\0\0\0\0\0\0\0\0\0�V@',0,'2024-02-26 13:59:28','2024-02-26 13:59:28');
/*!40000 ALTER TABLE `timezone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trip`
--

DROP TABLE IF EXISTS `trip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trip` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `distance` int unsigned NOT NULL DEFAULT '0',
  `time` int unsigned NOT NULL DEFAULT '0',
  `stats` json DEFAULT NULL,
  `start_at` datetime NOT NULL,
  `start_utc_at` datetime NOT NULL,
  `end_at` datetime NOT NULL,
  `end_utc_at` datetime NOT NULL,
  `shared` tinyint(1) NOT NULL DEFAULT '0',
  `shared_public` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `device_id` bigint unsigned DEFAULT NULL,
  `timezone_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `vehicle_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `trip_code_index` (`code`),
  KEY `trip_name_index` (`name`),
  KEY `trip_shared_public_shared_device_id_end_utc_at_index` (`shared_public`,`shared`,`device_id`,`end_utc_at`),
  KEY `trip_device_fk` (`device_id`),
  KEY `trip_timezone_fk` (`timezone_id`),
  KEY `trip_user_fk` (`user_id`),
  KEY `trip_vehicle_fk` (`vehicle_id`),
  CONSTRAINT `trip_device_fk` FOREIGN KEY (`device_id`) REFERENCES `device` (`id`) ON DELETE SET NULL,
  CONSTRAINT `trip_timezone_fk` FOREIGN KEY (`timezone_id`) REFERENCES `timezone` (`id`) ON DELETE CASCADE,
  CONSTRAINT `trip_user_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `trip_vehicle_fk` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicle` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trip`
--

LOCK TABLES `trip` WRITE;
/*!40000 ALTER TABLE `trip` DISABLE KEYS */;
/*!40000 ALTER TABLE `trip` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `preferences` json DEFAULT NULL,
  `telegram` json DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `admin_mode` tinyint(1) NOT NULL DEFAULT '0',
  `manager` tinyint(1) NOT NULL DEFAULT '0',
  `manager_mode` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `language_id` bigint unsigned NOT NULL,
  `timezone_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_email_unique` (`email`),
  KEY `user_language_fk` (`language_id`),
  KEY `user_timezone_fk` (`timezone_id`),
  CONSTRAINT `user_language_fk` FOREIGN KEY (`language_id`) REFERENCES `language` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_timezone_fk` FOREIGN KEY (`timezone_id`) REFERENCES `timezone` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Admin','user@animaltracker.com','$2y$12$nbi3kOQTtA3afzoSX3OWQeVcGMAH8lR8TgVSLrKWBhN/I5xO/okXa','Y0c1xcb0N845CqlwbCtKYWM7I3vpy7bKBqH2ys3PxO4F5sowKJkZtGoJdIUV','{\"units\": {\"money\": null, \"volume\": null, \"decimal\": null, \"distance\": null, \"thousand\": null}, \"user_id\": 1, \"device_id\": 1, \"vehicle_id\": \"\"}',NULL,1,1,1,0,0,'2024-02-26 14:01:56','2024-03-24 19:38:45',2,370);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_fail`
--

DROP TABLE IF EXISTS `user_fail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_fail` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `text` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_fail_type_index` (`type`),
  KEY `user_fail_ip_index` (`ip`),
  KEY `user_fail_user_fk` (`user_id`),
  CONSTRAINT `user_fail_user_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_fail`
--

LOCK TABLES `user_fail` WRITE;
/*!40000 ALTER TABLE `user_fail` DISABLE KEYS */;
INSERT INTO `user_fail` VALUES (1,'user-auth-credentials','user@animaltracker.com','127.0.0.1','2024-02-26 14:02:30','2024-02-26 14:02:30',1);
/*!40000 ALTER TABLE `user_fail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_session`
--

DROP TABLE IF EXISTS `user_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_session` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `auth` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_session_auth_index` (`auth`),
  KEY `user_session_ip_index` (`ip`),
  KEY `user_session_user_fk` (`user_id`),
  CONSTRAINT `user_session_user_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_session`
--

LOCK TABLES `user_session` WRITE;
/*!40000 ALTER TABLE `user_session` DISABLE KEYS */;
INSERT INTO `user_session` VALUES (1,'user@animaltracker.com','127.0.0.1','2024-02-26 14:02:49','2024-02-26 14:02:49',1);
/*!40000 ALTER TABLE `user_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicle`
--

DROP TABLE IF EXISTS `vehicle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicle` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `plate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `timezone_auto` tinyint(1) NOT NULL DEFAULT '0',
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `timezone_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `vehicle_name_index` (`name`),
  KEY `vehicle_timezone_fk` (`timezone_id`),
  KEY `vehicle_user_fk` (`user_id`),
  CONSTRAINT `vehicle_timezone_fk` FOREIGN KEY (`timezone_id`) REFERENCES `timezone` (`id`) ON DELETE CASCADE,
  CONSTRAINT `vehicle_user_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle`
--

LOCK TABLES `vehicle` WRITE;
/*!40000 ALTER TABLE `vehicle` DISABLE KEYS */;
INSERT INTO `vehicle` VALUES (1,'Cow 293','299',1,1,'2024-02-26 14:03:41','2024-02-26 14:03:41',43,1),(2,'Channing Warner','Aut sed consequatur',0,0,'2024-03-24 19:38:12','2024-03-24 19:38:12',421,1);
/*!40000 ALTER TABLE `vehicle` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-03-24 23:39:23
