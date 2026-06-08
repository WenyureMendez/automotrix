CREATE DATABASE  IF NOT EXISTS `automotrix` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `automotrix`;
-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: automotrix
-- ------------------------------------------------------
-- Server version	8.0.46

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
-- Table structure for table `appointments`
--

DROP TABLE IF EXISTS `appointments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `vehicle_id` int NOT NULL,
  `mechanic_id` int DEFAULT NULL,
  `appointment_date` datetime NOT NULL,
  `reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Pendiente',
  `tipo` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Cita previa',
  PRIMARY KEY (`id`),
  KEY `customer_id` (`customer_id`),
  KEY `vehicle_id` (`vehicle_id`),
  KEY `mechanic_id` (`mechanic_id`),
  CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  CONSTRAINT `appointments_ibfk_2` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`id`),
  CONSTRAINT `appointments_ibfk_3` FOREIGN KEY (`mechanic_id`) REFERENCES `mechanics` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointments`
--

LOCK TABLES `appointments` WRITE;
/*!40000 ALTER TABLE `appointments` DISABLE KEYS */;
INSERT INTO `appointments` VALUES (111,102,115,101,'2026-06-04 19:23:00','MOTOR','Pendiente','Cita previa'),(112,131,123,110,'2026-06-03 19:38:00','MOTOR','Pendiente','Llegada directa'),(113,131,123,102,'2026-06-04 09:32:00','MOT','Pendiente','Llegada directa');
/*!40000 ALTER TABLE `appointments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` VALUES (1,'Administrador'),(3,'Mecánico'),(2,'Recepcionista');
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
INSERT INTO `auth_group_permissions` VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,1,5),(6,1,6),(7,1,7),(8,1,8),(9,1,9),(10,1,10),(11,1,11),(12,1,12),(13,1,13),(14,1,14),(15,1,15),(16,1,16),(17,1,17),(18,1,18),(19,1,19),(20,1,20),(21,1,21),(22,1,22),(23,1,23),(24,1,24),(29,2,25),(30,2,26),(31,2,27),(32,2,28),(33,2,29),(34,2,30),(35,2,31),(28,2,52),(25,2,69),(26,2,70),(27,2,71),(36,3,77),(37,3,78);
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',3,'add_permission'),(6,'Can change permission',3,'change_permission'),(7,'Can delete permission',3,'delete_permission'),(8,'Can view permission',3,'view_permission'),(9,'Can add group',2,'add_group'),(10,'Can change group',2,'change_group'),(11,'Can delete group',2,'delete_group'),(12,'Can view group',2,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add appointments',7,'add_appointments'),(26,'Can change appointments',7,'change_appointments'),(27,'Can delete appointments',7,'delete_appointments'),(28,'Can view appointments',7,'view_appointments'),(29,'Can add customers',8,'add_customers'),(30,'Can change customers',8,'change_customers'),(31,'Can delete customers',8,'delete_customers'),(32,'Can view customers',8,'view_customers'),(33,'Can add insurances',9,'add_insurances'),(34,'Can change insurances',9,'change_insurances'),(35,'Can delete insurances',9,'delete_insurances'),(36,'Can view insurances',9,'view_insurances'),(37,'Can add insurancesaudit',10,'add_insurancesaudit'),(38,'Can change insurancesaudit',10,'change_insurancesaudit'),(39,'Can delete insurancesaudit',10,'delete_insurancesaudit'),(40,'Can view insurancesaudit',10,'view_insurancesaudit'),(41,'Can add invoices',11,'add_invoices'),(42,'Can change invoices',11,'change_invoices'),(43,'Can delete invoices',11,'delete_invoices'),(44,'Can view invoices',11,'view_invoices'),(45,'Can add invoicesaudit',12,'add_invoicesaudit'),(46,'Can change invoicesaudit',12,'change_invoicesaudit'),(47,'Can delete invoicesaudit',12,'delete_invoicesaudit'),(48,'Can view invoicesaudit',12,'view_invoicesaudit'),(49,'Can add mechanics',13,'add_mechanics'),(50,'Can change mechanics',13,'change_mechanics'),(51,'Can delete mechanics',13,'delete_mechanics'),(52,'Can view mechanics',13,'view_mechanics'),(53,'Can add payments',14,'add_payments'),(54,'Can change payments',14,'change_payments'),(55,'Can delete payments',14,'delete_payments'),(56,'Can view payments',14,'view_payments'),(57,'Can add paymentsaudit',15,'add_paymentsaudit'),(58,'Can change paymentsaudit',15,'change_paymentsaudit'),(59,'Can delete paymentsaudit',15,'delete_paymentsaudit'),(60,'Can view paymentsaudit',15,'view_paymentsaudit'),(61,'Can add services',16,'add_services'),(62,'Can change services',16,'change_services'),(63,'Can delete services',16,'delete_services'),(64,'Can view services',16,'view_services'),(65,'Can add spareparts',17,'add_spareparts'),(66,'Can change spareparts',17,'change_spareparts'),(67,'Can delete spareparts',17,'delete_spareparts'),(68,'Can view spareparts',17,'view_spareparts'),(69,'Can add vehicles',18,'add_vehicles'),(70,'Can change vehicles',18,'change_vehicles'),(71,'Can delete vehicles',18,'delete_vehicles'),(72,'Can view vehicles',18,'view_vehicles'),(73,'Can add vehiclesaudit',19,'add_vehiclesaudit'),(74,'Can change vehiclesaudit',19,'change_vehiclesaudit'),(75,'Can delete vehiclesaudit',19,'delete_vehiclesaudit'),(76,'Can view vehiclesaudit',19,'view_vehiclesaudit'),(77,'Can add workorders',20,'add_workorders'),(78,'Can change workorders',20,'change_workorders'),(79,'Can delete workorders',20,'delete_workorders'),(80,'Can view workorders',20,'view_workorders'),(81,'Can add workordersaudit',21,'add_workordersaudit'),(82,'Can change workordersaudit',21,'change_workordersaudit'),(83,'Can delete workordersaudit',21,'delete_workordersaudit'),(84,'Can view workordersaudit',21,'view_workordersaudit'),(85,'Can add workorderservices',22,'add_workorderservices'),(86,'Can change workorderservices',22,'change_workorderservices'),(87,'Can delete workorderservices',22,'delete_workorderservices'),(88,'Can view workorderservices',22,'view_workorderservices'),(89,'Can add workporderspareparts',23,'add_workporderspareparts'),(90,'Can change workporderspareparts',23,'change_workporderspareparts'),(91,'Can delete workporderspareparts',23,'delete_workporderspareparts'),(92,'Can view workporderspareparts',23,'view_workporderspareparts');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$1200000$5h4XQOkCBz76HbtrgXrz3c$am2ob6dPXg9Ble18d5KVE2LNGnRMPFC02Rnr8aLfYUc=','2026-06-04 14:32:12.047862',1,'wesly','','','weslyarevalo@gmail.com',1,1,'2026-05-30 03:53:42.991697'),(2,'pbkdf2_sha256$1200000$VaI6w6rarOThmTEv5jTInX$U7S9j+t51rzl08NLDyOzl9x14esZWJtyvwunXYaXpbI=','2026-06-04 00:15:30.000000',0,'recepcionista','','','',1,1,'2026-05-30 04:06:56.000000'),(3,'pbkdf2_sha256$1200000$X72JyKqLaAQQIJNiatu1R6$6MIxdN8XEGdGC085g3gsamM8bLmp3U7iwGL4zn+xJSU=','2026-06-04 00:58:33.363986',0,'mecanicos-jefe','','','',1,1,'2026-05-30 04:08:05.000000');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
INSERT INTO `auth_user_groups` VALUES (1,2,2),(2,3,3);
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=134 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'wesly','arevalo','555000001','ana1@mail.com'),(2,'WENYURE','Martínez','555000002','luis2@mail.com'),(3,'María','López','555000003','maría3@mail.com'),(4,'Camila','Ramírez','555000004','carlos4@mail.com'),(5,'Sofía','Torres','555000005','sofía5@mail.com'),(6,'Pedro','Hernández','555000006','pedro6@mail.com'),(7,'Lucía','Ruiz','555000007','lucía7@mail.com'),(8,'Diego','Vargas','555000008','diego8@mail.com'),(9,'Laura','Mendoza','555000009','laura9@mail.com'),(10,'Juan','Pérez','555000010','juan10@mail.com'),(11,'Ana','Gómez','555000011','ana11@mail.com'),(12,'Luis','Martínez','555000012','luis12@mail.com'),(13,'María','López','555000013','maría13@mail.com'),(14,'Carlos','Suarez','555000014','carlos14@mail.com'),(15,'Sofía','Torres','555000015','sofía15@mail.com'),(16,'Pedro','Hernández','555000016','pedro16@mail.com'),(17,'Lucía','Ruiz','555000017','lucía17@mail.com'),(18,'Diego','Vargas','555000018','diego18@mail.com'),(19,'Laura','Mendoza','555000019','laura19@mail.com'),(20,'Juan','Pérez','555000020','juan20@mail.com'),(21,'Ana','Gómez','555000021','ana21@mail.com'),(22,'Luis','Martínez','555000022','luis22@mail.com'),(23,'María','López','555000023','maría23@mail.com'),(24,'Camilo','Ramírez','555000024','carlos24@mail.com'),(25,'Sofía','Torres','555000025','sofía25@mail.com'),(26,'Pedro','Hernández','555000026','pedro26@mail.com'),(27,'Lucía','Ruiz','555000027','lucía27@mail.com'),(28,'Diego','Vargas','555000028','diego28@mail.com'),(29,'Laura','Mendoza','555000029','laura29@mail.com'),(30,'Juan','Pérez','555000030','juan30@mail.com'),(31,'Ana','Gómez','555000031','ana31@mail.com'),(32,'Luis','Martínez','555000032','luis32@mail.com'),(33,'María','López','555000033','maría33@mail.com'),(34,'Cesar','lopez','555000034','carlos34@mail.com'),(35,'Sofía','Torres','555000035','sofía35@mail.com'),(36,'Pedro','Hernández','555000036','pedro36@mail.com'),(37,'Lucía','Ruiz','555000037','lucía37@mail.com'),(38,'Diego','Vargas','555000038','diego38@mail.com'),(39,'Laura','Mendoza','555000039','laura39@mail.com'),(40,'Juan','Pérez','555000040','juan40@mail.com'),(41,'Ana','Gómez','555000041','ana41@mail.com'),(42,'Luis','Martínez','555000042','luis42@mail.com'),(43,'María','López','555000043','maría43@mail.com'),(44,'Catalina','Castro','555000044','carlos44@mail.com'),(45,'Sofía','Torres','555000045','sofía45@mail.com'),(46,'Pedro','Hernández','555000046','pedro46@mail.com'),(47,'Lucía','Ruiz','555000047','lucía47@mail.com'),(48,'Diego','Vargas','555000048','diego48@mail.com'),(49,'Laura','Mendoza','555000049','laura49@mail.com'),(50,'Juan','Pérez','555000050','juan50@mail.com'),(51,'Ana','Gómez','555000051','ana51@mail.com'),(52,'Luis','Martínez','555000052','luis52@mail.com'),(53,'María','López','555000053','maría53@mail.com'),(54,'Casandra','Ramírez','555000054','carlos54@mail.com'),(55,'Sofía','Torres','555000055','sofía55@mail.com'),(56,'Pedro','Hernández','555000056','pedro56@mail.com'),(57,'Lucía','Ruiz','555000057','lucía57@mail.com'),(58,'Diego','Vargas','555000058','diego58@mail.com'),(59,'Laura','Mendoza','555000059','laura59@mail.com'),(60,'Juan','Pérez','555000060','juan60@mail.com'),(61,'Ana','Gómez','555000061','ana61@mail.com'),(62,'Luis','Martínez','555000062','luis62@mail.com'),(63,'María','López','555000063','maría63@mail.com'),(64,'Carlos','Martinez','555000064','carlos64@mail.com'),(65,'Sofía','Torres','555000065','sofía65@mail.com'),(66,'Pedro','Hernández','555000066','pedro66@mail.com'),(67,'Lucía','Ruiz','555000067','lucía67@mail.com'),(68,'Diego','Vargas','555000068','diego68@mail.com'),(69,'Laura','Mendoza','555000069','laura69@mail.com'),(70,'Juan','Pérez','555000070','juan70@mail.com'),(71,'Ana','Gómez','555000071','ana71@mail.com'),(72,'Luis','Martínez','555000072','luis72@mail.com'),(73,'María','López','555000073','maría73@mail.com'),(74,'Carlota','Miranda','555000074','carlos74@mail.com'),(75,'Sofía','Torres','555000075','sofía75@mail.com'),(76,'Pedro','Hernández','555000076','pedro76@mail.com'),(77,'Lucía','Ruiz','555000077','lucía77@mail.com'),(78,'Diego','Vargas','555000078','diego78@mail.com'),(79,'Laura','Mendoza','555000079','laura79@mail.com'),(80,'Juan','Pérez','555000080','juan80@mail.com'),(81,'Ana','Gómez','555000081','ana81@mail.com'),(82,'Luis','Martínez','555000082','luis82@mail.com'),(83,'María','López','555000083','maría83@mail.com'),(84,'Carlos','Ramírez','555000084','carlos84@mail.com'),(85,'Sofía','Torres','555000085','sofía85@mail.com'),(86,'Pedro','Hernández','555000086','pedro86@mail.com'),(87,'Lucía','Ruiz','555000087','lucía87@mail.com'),(88,'Diego','Vargas','555000088','diego88@mail.com'),(89,'Laura','Mendoza','555000089','laura89@mail.com'),(90,'Juan','Pérez','555000090','juan90@mail.com'),(91,'Ana','Gómez','555000091','ana91@mail.com'),(92,'Luis','Martínez','555000092','luis92@mail.com'),(93,'María','López','555000093','maría93@mail.com'),(94,'Cesar','Rojas','555000094','carlos94@mail.com'),(95,'Sofía','Torres','555000095','sofía95@mail.com'),(96,'Pedro','Hernández','555000096','pedro96@mail.com'),(97,'Lucía','Ruiz','555000097','lucía97@mail.com'),(98,'Diego','Vargas','555000098','diego98@mail.com'),(99,'Laura','Mendoza','555000099','laura99@mail.com'),(100,'Juan','Pérez','555000100','juan100@mail.com'),(102,'Wesly','Arevalo','3113001500','weslyarevalo00@gmail.com'),(107,'Wesly','Arevalo','3113001500','weslyarevalo@gmail.com'),(108,'Wesly','Arevalo','3113001500','wesly@gmail.com'),(109,'Wesly','Arevalo','3113001500','wesly56th@gmail.com'),(110,'wen','firu','44244141','wen@gmail.com'),(111,'wen','firu','44244141','wen21313@gmail.com'),(112,'alvaro','Arevalo','3113001501','alvaro0@gmail.com'),(113,'paola','palacio','320596343','pao@gmail.com'),(114,'luciana','aaa','3113001500','luci@gmail.com'),(115,'luciana','aaa','31130015','luciana@gmail.com'),(116,'Wesly','Arevalo','442441419','weslyareva@gmail.com'),(117,'Wesly','Arevalo','442441419','weslyarevawrww@gmail.com'),(118,'Wesly','Arevalo','3113001500','weslyarevalo00@gmail.com'),(119,'Wesly','Arevalo','3113001500','weslyarevalo00@gmail.com'),(120,'Wesly','Arevalo','3113001500','weslyarevalo00@gmail.com'),(122,'Wesly','Arevalo','3113001500','weslyarevalo00@gmail.com'),(123,'Wesly','Arevalo','3113001500','weslyarevalo00@gmail.com'),(124,'Wesly','Arevalo','3113001500','weslyarevalo00@gmail.com'),(125,'jair','diaz','328495203','jjdiaz@gmail.com'),(126,'dei','castañeda','3234231304','dei@gmail.com'),(127,'wenyu','lafuerie','3242424424','wenyu@gmail.com'),(128,'jhon','suarez','32490202','jhon@gmail.com'),(129,'JHON','SUAREZ','42505035','jhons@gmail.com'),(130,'Jhon','sUAREZ','SDFSDF45645','4564S56SDQ@SDSD.COM'),(131,'Wesly','Palacio','3113001500','warevalo@uniguajira.edu.co'),(132,'Alvaro','Arevalo','3113001504','alv@gmail.com'),(133,'alvaro','riva','3113001501','al@gmail.com');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers_audit`
--

DROP TABLE IF EXISTS `customers_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers_audit` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `customer_id` bigint NOT NULL,
  `actionType` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `changed_at` datetime DEFAULT NULL,
  `changed_by` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `before_data` json DEFAULT NULL,
  `after_data` json DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers_audit`
--

LOCK TABLES `customers_audit` WRITE;
/*!40000 ALTER TABLE `customers_audit` DISABLE KEYS */;
INSERT INTO `customers_audit` VALUES (1,122,'INSERT','2026-05-30 20:54:17','root@172.17.0.1',NULL,'{\"email\": \"weslyarevalo00@gmail.com\", \"phone\": \"3113001500\", \"last_name\": \"Arevalo\", \"first_name\": \"Wesly\"}'),(2,123,'INSERT','2026-05-30 20:57:21','root@172.17.0.1',NULL,'{\"email\": \"weslyarevalo00@gmail.com\", \"phone\": \"3113001500\", \"last_name\": \"Arevalo\", \"first_name\": \"Wesly\"}');
/*!40000 ALTER TABLE `customers_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext COLLATE utf8mb4_unicode_ci,
  `object_repr` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2026-05-30 03:56:15.484022','1','Administrador',1,'[{\"added\": {}}]',2,1),(2,'2026-05-30 04:01:46.297262','2','Administradorr',1,'[{\"added\": {}}]',2,1),(3,'2026-05-30 04:02:18.159367','3','Mecánico',1,'[{\"added\": {}}]',2,1),(4,'2026-05-30 04:02:40.433944','2','Recepcionista',2,'[{\"changed\": {\"fields\": [\"Name\"]}}]',2,1),(5,'2026-05-30 04:06:57.297746','2','recepcionista',1,'[{\"added\": {}}]',4,1),(6,'2026-05-30 04:08:06.580813','3','mecanicos-jefe',1,'[{\"added\": {}}]',4,1),(7,'2026-06-04 00:51:40.639315','3','mecanicos-jefe',2,'[{\"changed\": {\"fields\": [\"Staff status\"]}}]',4,1),(8,'2026-06-04 00:52:00.878690','2','recepcionista',2,'[{\"changed\": {\"fields\": [\"Staff status\"]}}]',4,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(2,'auth','group'),(3,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(7,'core','appointments'),(8,'core','customers'),(9,'core','insurances'),(10,'core','insurancesaudit'),(11,'core','invoices'),(12,'core','invoicesaudit'),(13,'core','mechanics'),(14,'core','payments'),(15,'core','paymentsaudit'),(16,'core','services'),(17,'core','spareparts'),(18,'core','vehicles'),(19,'core','vehiclesaudit'),(20,'core','workorders'),(21,'core','workordersaudit'),(22,'core','workorderservices'),(23,'core','workporderspareparts'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2026-05-30 03:52:49.321114'),(2,'auth','0001_initial','2026-05-30 03:52:51.821410'),(3,'admin','0001_initial','2026-05-30 03:52:52.393987'),(4,'admin','0002_logentry_remove_auto_add','2026-05-30 03:52:52.419113'),(5,'admin','0003_logentry_add_action_flag_choices','2026-05-30 03:52:52.442788'),(6,'contenttypes','0002_remove_content_type_name','2026-05-30 03:52:52.817010'),(7,'auth','0002_alter_permission_name_max_length','2026-05-30 03:52:53.074108'),(8,'auth','0003_alter_user_email_max_length','2026-05-30 03:52:53.148389'),(9,'auth','0004_alter_user_username_opts','2026-05-30 03:52:53.171147'),(10,'auth','0005_alter_user_last_login_null','2026-05-30 03:52:53.353611'),(11,'auth','0006_require_contenttypes_0002','2026-05-30 03:52:53.369804'),(12,'auth','0007_alter_validators_add_error_messages','2026-05-30 03:52:53.407758'),(13,'auth','0008_alter_user_username_max_length','2026-05-30 03:52:53.642906'),(14,'auth','0009_alter_user_last_name_max_length','2026-05-30 03:52:53.891019'),(15,'auth','0010_alter_group_name_max_length','2026-05-30 03:52:53.951655'),(16,'auth','0011_update_proxy_permissions','2026-05-30 03:52:53.988889'),(17,'auth','0012_alter_user_first_name_max_length','2026-05-30 03:52:54.213350'),(18,'sessions','0001_initial','2026-05-30 03:52:54.365745');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `session_data` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('67jzlidr1xb6q84jru25j4layr9qbtya','.eJxVjEsOgjAUAO_y1qYp9kdZuucMTfs-FjWQUFgZ725IWOh2ZjJvSHnfatobr2kiGKCDyy8rGZ88H4Ieeb4vCpd5W6eijkSdtqlxIX7dzvZvUHOrMAAaTVoMR6uRbEA2weNVI7qYe-9ETG8kxC67wiKOI3m0jkmCphKJ4fMF-PY5Cg:1wV97E:v86H6UDCl-Iu11d3SM62Syx4d7Bjz9DjdPnGvPvk1XE','2026-06-18 14:32:12.062218'),('v18f115m6gt6dtnctcpmaxn06i9rmfmo','.eJxVjLsOwjAMAP_FM4qaOE7Sjux8Q-U6DimgVupjQvw7qtQB1rvTvaHnfav9vurSjxk6QLj8soHlqdMh8oOn-2xknrZlHMyRmNOu5jZnfV3P9m9Qea3QgW8xiLSE7IpFcRKEWTU6ToiKsS2KDVqJ1ASXQ3ExUaAiot56SgSfL-DWN3w:1wUwPp:sil-GLv3oR4545fKPP4RdWp-ltM4GcvhuBzaUf7qNLM','2026-06-18 00:58:33.383142');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `insurances`
--

DROP TABLE IF EXISTS `insurances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `insurances` (
  `id` int NOT NULL AUTO_INCREMENT,
  `company_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `policy_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `vehicle_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `vehicle_id` (`vehicle_id`),
  CONSTRAINT `insurances_ibfk_1` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `insurances`
--

LOCK TABLES `insurances` WRITE;
/*!40000 ALTER TABLE `insurances` DISABLE KEYS */;
INSERT INTO `insurances` VALUES (1,'InsuranCe 1','POL00001','2024-01-02','2025-01-02',1),(2,'InsuranceCo 2','POL00002','2024-01-03','2025-01-02',2),(5,'InsuranceCo 5','POL00005','2024-01-06','2025-01-05',5),(6,'InsuranceCo 6','POL00006','2024-01-07','2025-01-06',6),(7,'InsuranceCo 7','POL00007','2024-01-08','2025-01-07',7),(8,'InsuranceCo 8','POL00008','2024-01-09','2025-01-08',8),(9,'InsuranceCo 9','POL00009','2024-01-10','2025-01-09',9),(10,'InsuranceCo 10','POL00010','2024-01-11','2025-01-10',10),(11,'InsuranceCo 11','POL00011','2024-01-12','2025-01-11',11),(12,'InsuranceCo 12','POL00012','2024-01-13','2025-01-12',12),(13,'InsuranceCo 13','POL00013','2024-01-14','2025-01-13',13),(14,'InsuranceCo 14','POL00014','2024-01-15','2025-01-14',14),(15,'InsuranceCo 15','POL00015','2024-01-16','2025-01-15',15),(16,'InsuranceCo 16','POL00016','2024-01-17','2025-01-16',16),(17,'InsuranceCo 17','POL00017','2024-01-18','2025-01-17',17),(18,'InsuranceCo 18','POL00018','2024-01-19','2025-01-18',18),(19,'InsuranceCo 19','POL00019','2024-01-20','2025-01-19',19),(20,'InsuranceCo 20','POL00020','2024-01-21','2025-01-20',20),(21,'InsuranceCo 21','POL00021','2024-01-22','2025-01-21',21),(22,'InsuranceCo 22','POL00022','2024-01-23','2025-01-22',22),(23,'InsuranceCo 23','POL00023','2024-01-24','2025-01-23',23),(24,'InsuranceCo 24','POL00024','2024-01-25','2025-01-24',24),(25,'InsuranceCo 25','POL00025','2024-01-26','2025-01-25',25),(26,'InsuranceCo 26','POL00026','2024-01-27','2025-01-26',26),(27,'InsuranceCo 27','POL00027','2024-01-28','2025-01-27',27),(28,'InsuranceCo 28','POL00028','2024-01-29','2025-01-28',28),(29,'InsuranceCo 29','POL00029','2024-01-30','2025-01-29',29),(30,'InsuranceCo 30','POL00030','2024-01-31','2025-01-30',30),(31,'InsuranceCo 31','POL00031','2024-02-01','2025-01-31',31),(32,'InsuranceCo 32','POL00032','2024-02-02','2025-02-01',32),(33,'InsuranceCo 33','POL00033','2024-02-03','2025-02-02',33),(34,'InsuranceCo 34','POL00034','2024-02-04','2025-02-03',34),(35,'InsuranceCo 35','POL00035','2024-02-05','2025-02-04',35),(36,'InsuranceCo 36','POL00036','2024-02-06','2025-02-05',36),(37,'InsuranceCo 37','POL00037','2024-02-07','2025-02-06',37),(38,'InsuranceCo 38','POL00038','2024-02-08','2025-02-07',38),(39,'InsuranceCo 39','POL00039','2024-02-09','2025-02-08',39),(40,'InsuranceCo 40','POL00040','2024-02-10','2025-02-09',40),(41,'InsuranceCo 41','POL00041','2024-02-11','2025-02-10',41),(42,'InsuranceCo 42','POL00042','2024-02-12','2025-02-11',42),(43,'InsuranceCo 43','POL00043','2024-02-13','2025-02-12',43),(44,'InsuranceCo 44','POL00044','2024-02-14','2025-02-13',44),(45,'InsuranceCo 45','POL00045','2024-02-15','2025-02-14',45),(46,'InsuranceCo 46','POL00046','2024-02-16','2025-02-15',46),(47,'InsuranceCo 47','POL00047','2024-02-17','2025-02-16',47),(48,'InsuranceCo 48','POL00048','2024-02-18','2025-02-17',48),(49,'InsuranceCo 49','POL00049','2024-02-19','2025-02-18',49),(50,'InsuranceCo 50','POL00050','2024-02-20','2025-02-19',50),(51,'InsuranceCo 51','POL00051','2024-02-21','2025-02-20',51),(52,'InsuranceCo 52','POL00052','2024-02-22','2025-02-21',52),(53,'InsuranceCo 53','POL00053','2024-02-23','2025-02-22',53),(54,'InsuranceCo 54','POL00054','2024-02-24','2025-02-23',54),(55,'InsuranceCo 55','POL00055','2024-02-25','2025-02-24',55),(56,'InsuranceCo 56','POL00056','2024-02-26','2025-02-25',56),(57,'InsuranceCo 57','POL00057','2024-02-27','2025-02-26',57),(58,'InsuranceCo 58','POL00058','2024-02-28','2025-02-27',58),(59,'InsuranceCo 59','POL00059','2024-02-29','2025-02-28',59),(60,'InsuranceCo 60','POL00060','2024-03-01','2025-03-01',60),(61,'InsuranceCo 61','POL00061','2024-03-02','2025-03-02',61),(62,'InsuranceCo 62','POL00062','2024-03-03','2025-03-03',62),(63,'InsuranceCo 63','POL00063','2024-03-04','2025-03-04',63),(64,'InsuranceCo 64','POL00064','2024-03-05','2025-03-05',64),(65,'InsuranceCo 65','POL00065','2024-03-06','2025-03-06',65),(66,'InsuranceCo 66','POL00066','2024-03-07','2025-03-07',66),(67,'InsuranceCo 67','POL00067','2024-03-08','2025-03-08',67),(68,'InsuranceCo 68','POL00068','2024-03-09','2025-03-09',68),(69,'InsuranceCo 69','POL00069','2024-03-10','2025-03-10',69),(70,'InsuranceCo 70','POL00070','2024-03-11','2025-03-11',70),(71,'InsuranceCo 71','POL00071','2024-03-12','2025-03-12',71),(72,'InsuranceCo 72','POL00072','2024-03-13','2025-03-13',72),(73,'InsuranceCo 73','POL00073','2024-03-14','2025-03-14',73),(74,'InsuranceCo 74','POL00074','2024-03-15','2025-03-15',74),(75,'InsuranceCo 75','POL00075','2024-03-16','2025-03-16',75),(76,'InsuranceCo 76','POL00076','2024-03-17','2025-03-17',76),(77,'InsuranceCo 77','POL00077','2024-03-18','2025-03-18',77),(78,'InsuranceCo 78','POL00078','2024-03-19','2025-03-19',78),(79,'InsuranceCo 79','POL00079','2024-03-20','2025-03-20',79),(80,'InsuranceCo 80','POL00080','2024-03-21','2025-03-21',80),(81,'InsuranceCo 81','POL00081','2024-03-22','2025-03-22',81),(82,'InsuranceCo 82','POL00082','2024-03-23','2025-03-23',82),(83,'InsuranceCo 83','POL00083','2024-03-24','2025-03-24',83),(84,'InsuranceCo 84','POL00084','2024-03-25','2025-03-25',84),(85,'InsuranceCo 85','POL00085','2024-03-26','2025-03-26',85),(86,'InsuranceCo 86','POL00086','2024-03-27','2025-03-27',86),(87,'InsuranceCo 87','POL00087','2024-03-28','2025-03-28',87),(88,'InsuranceCo 88','POL00088','2024-03-29','2025-03-29',88),(89,'InsuranceCo 89','POL00089','2024-03-30','2025-03-30',89),(90,'InsuranceCo 90','POL00090','2024-03-31','2025-03-31',90),(91,'InsuranceCo 91','POL00091','2024-04-01','2025-04-01',91),(92,'InsuranceCo 92','POL00092','2024-04-02','2025-04-02',92),(93,'InsuranceCo 93','POL00093','2024-04-03','2025-04-03',93),(94,'InsuranceCo 94','POL00094','2024-04-04','2025-04-04',94),(95,'InsuranceCo 95','POL00095','2024-04-05','2025-04-05',95),(96,'InsuranceCo 96','POL00096','2024-04-06','2025-04-06',96),(97,'InsuranceCo 97','POL00097','2024-04-07','2025-04-07',97),(98,'InsuranceCo 98','POL00098','2024-04-08','2025-04-08',98),(99,'InsuranceCo 99','POL00099','2024-04-09','2025-04-09',99),(100,'InsuranceCo 100','POL00100','2024-04-10','2025-04-10',100),(101,'insurnuevo','POL006','2024-01-08','2025-01-08',4);
/*!40000 ALTER TABLE `insurances` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`wenm`@`%`*/ /*!50003 TRIGGER `ai_insurances_audit` AFTER INSERT ON `insurances` FOR EACH ROW BEGIN
  
  SET @from_insurances_trigger = 1;

  INSERT INTO insurances_audit (insurance_id, actionType, before_data, after_data)
  VALUES (
    NEW.id,
    'INSERT',
    NULL,
    JSON_OBJECT(
      'id', NEW.id,
      'company_name', NEW.company_name,
      'policy_number', NEW.policy_number,
      'start_date', NEW.start_date,
      'end_date', NEW.end_date,
      'vehicle_id', NEW.vehicle_id
    )
  );

  SET @from_insurances_trigger = NULL;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`wenm`@`%`*/ /*!50003 TRIGGER `au_insurances_audit` AFTER UPDATE ON `insurances` FOR EACH ROW BEGIN
  SET @from_insurances_trigger = 1;

  INSERT INTO insurances_audit (insurance_id, actionType, before_data, after_data)
  VALUES (
    NEW.id,
    'UPDATE',
    JSON_OBJECT(
      'id', OLD.id,
      'company_name', OLD.company_name,
      'policy_number', OLD.policy_number,
      'start_date', OLD.start_date,
      'end_date', OLD.end_date,
      'vehicle_id', OLD.vehicle_id
    ),
    JSON_OBJECT(
      'id', NEW.id,
      'company_name', NEW.company_name,
      'policy_number', NEW.policy_number,
      'start_date', NEW.start_date,
      'end_date', NEW.end_date,
      'vehicle_id', NEW.vehicle_id
    )
  );

  SET @from_insurances_trigger = NULL;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`wenm`@`%`*/ /*!50003 TRIGGER `ad_insurances_audit` AFTER DELETE ON `insurances` FOR EACH ROW BEGIN
  
  SET @from_insurances_trigger = 1;

  INSERT INTO insurances_audit (insurance_id, actionType, before_data, after_data)
  VALUES (
    OLD.id,
    'DELETE',
    JSON_OBJECT(
      'id', OLD.id,
      'company_name', OLD.company_name,
      'policy_number', OLD.policy_number,
      'start_date', OLD.start_date,
      'end_date', OLD.end_date,
      'vehicle_id', OLD.vehicle_id
    ),
    NULL
  );

  SET @from_insurances_trigger = NULL;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `insurances_audit`
--

DROP TABLE IF EXISTS `insurances_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `insurances_audit` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `insurance_id` bigint NOT NULL,
  `actionType` enum('INSERT','UPDATE','DELETE') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'INSERT',
  `changed_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `changed_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Admin',
  `before_data` json DEFAULT NULL,
  `after_data` json DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `insurances_audit`
--

LOCK TABLES `insurances_audit` WRITE;
/*!40000 ALTER TABLE `insurances_audit` DISABLE KEYS */;
INSERT INTO `insurances_audit` VALUES (1,1,'UPDATE','2025-10-16 04:52:44','Admin','{\"id\": 1, \"end_date\": \"2025-01-01\", \"start_date\": \"2024-01-02\", \"vehicle_id\": 1, \"company_name\": \"InsuranceCo 1\", \"policy_number\": \"POL00001\"}','{\"id\": 1, \"end_date\": \"2025-01-01\", \"start_date\": \"2024-01-02\", \"vehicle_id\": 1, \"company_name\": \"InsuranceCo 1\", \"policy_number\": \"POL00005\"}'),(2,1,'UPDATE','2025-10-16 05:18:43','Admin','{\"id\": 1, \"end_date\": \"2025-01-01\", \"start_date\": \"2024-01-02\", \"vehicle_id\": 1, \"company_name\": \"InsuranceCo 1\", \"policy_number\": \"POL00005\"}','{\"id\": 1, \"end_date\": \"2025-01-01\", \"start_date\": \"2024-01-02\", \"vehicle_id\": 1, \"company_name\": \"Insurwen 1\", \"policy_number\": \"POL00005\"}'),(3,3,'DELETE','2025-10-16 05:20:03','Admin','{\"id\": 3, \"end_date\": \"2025-01-03\", \"start_date\": \"2024-01-04\", \"vehicle_id\": 3, \"company_name\": \"InsuranceCo 3\", \"policy_number\": \"POL00003\"}',NULL),(4,4,'UPDATE','2025-10-16 08:36:24','Admin','{\"id\": 4, \"end_date\": \"2025-01-04\", \"start_date\": \"2024-01-05\", \"vehicle_id\": 4, \"company_name\": \"InsuranceCo 4\", \"policy_number\": \"POL00004\"}','{\"id\": 4, \"end_date\": \"2025-01-04\", \"start_date\": \"2024-01-05\", \"vehicle_id\": 4, \"company_name\": \"Insunuevo 4\", \"policy_number\": \"POL00004\"}'),(5,4,'UPDATE','2025-10-16 08:38:57','Admin','{\"id\": 4, \"end_date\": \"2025-01-04\", \"start_date\": \"2024-01-05\", \"vehicle_id\": 4, \"company_name\": \"Insunuevo 4\", \"policy_number\": \"POL00004\"}','{\"id\": 4, \"end_date\": \"2025-01-04\", \"start_date\": \"2024-01-05\", \"vehicle_id\": 4, \"company_name\": \"insunuevo4\", \"policy_number\": \"POL00004\"}'),(6,4,'DELETE','2025-10-16 08:40:05','Admin','{\"id\": 4, \"end_date\": \"2025-01-04\", \"start_date\": \"2024-01-05\", \"vehicle_id\": 4, \"company_name\": \"insunuevo4\", \"policy_number\": \"POL00004\"}',NULL),(7,101,'INSERT','2025-10-16 08:42:17','Admin',NULL,'{\"id\": 101, \"end_date\": \"2025-01-08\", \"start_date\": \"2024-01-08\", \"vehicle_id\": 4, \"company_name\": \"insurnuevo\", \"policy_number\": \"POL006\"}'),(8,1,'UPDATE','2025-10-16 08:45:25','Admin','{\"id\": 1, \"end_date\": \"2025-01-01\", \"start_date\": \"2024-01-02\", \"vehicle_id\": 1, \"company_name\": \"Insurwen 1\", \"policy_number\": \"POL00005\"}','{\"id\": 1, \"end_date\": \"2025-01-01\", \"start_date\": \"2024-01-02\", \"vehicle_id\": 1, \"company_name\": \"wen\", \"policy_number\": \"POL00005\"}'),(9,1,'UPDATE','2025-10-16 08:49:45','Admin','{\"id\": 1, \"end_date\": \"2025-01-01\", \"start_date\": \"2024-01-02\", \"vehicle_id\": 1, \"company_name\": \"wen\", \"policy_number\": \"POL00005\"}','{\"id\": 1, \"end_date\": \"2025-01-01\", \"start_date\": \"2024-01-02\", \"vehicle_id\": 1, \"company_name\": \"insurancenu1\", \"policy_number\": \"POL00005\"}'),(10,1,'DELETE','2025-10-16 08:50:46','Admin','{\"id\": 1, \"end_date\": \"2025-01-01\", \"start_date\": \"2024-01-02\", \"vehicle_id\": 1, \"company_name\": \"insurancenu1\", \"policy_number\": \"POL00005\"}',NULL),(11,1,'INSERT','2025-10-16 08:52:34','Admin',NULL,'{\"id\": 1, \"end_date\": \"2025-01-02\", \"start_date\": \"2024-01-02\", \"vehicle_id\": 1, \"company_name\": \"insurancenue 1\", \"policy_number\": \"POL00001\"}'),(12,1,'UPDATE','2025-10-16 08:58:26','Admin','{\"id\": 1, \"end_date\": \"2025-01-02\", \"start_date\": \"2024-01-02\", \"vehicle_id\": 1, \"company_name\": \"insurancenue 1\", \"policy_number\": \"POL00001\"}','{\"id\": 1, \"end_date\": \"2025-01-02\", \"start_date\": \"2024-01-02\", \"vehicle_id\": 1, \"company_name\": \"WEN\", \"policy_number\": \"POL00001\"}'),(13,1,'DELETE','2025-10-16 08:59:12','Admin','{\"id\": 1, \"end_date\": \"2025-01-02\", \"start_date\": \"2024-01-02\", \"vehicle_id\": 1, \"company_name\": \"WEN\", \"policy_number\": \"POL00001\"}',NULL),(14,1,'INSERT','2025-10-16 09:00:40','Admin',NULL,'{\"id\": 1, \"end_date\": \"2025-01-02\", \"start_date\": \"2024-01-02\", \"vehicle_id\": 1, \"company_name\": \"InsuranCe 1\", \"policy_number\": \"POL00001\"}');
/*!40000 ALTER TABLE `insurances_audit` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`wenm`@`%`*/ /*!50003 TRIGGER `bii_insurances_audit_guard_insert` BEFORE INSERT ON `insurances_audit` FOR EACH ROW BEGIN

  IF COALESCE(@from_insurances_trigger, 0) <> 1 THEN

    SIGNAL SQLSTATE '45000' 

    SET MESSAGE_TEXT = 'INSERT en insurances_audit solo permitido desde triggers de insurances.';

  END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`wenm`@`%`*/ /*!50003 TRIGGER `biu_insurances_audit_block_update` BEFORE UPDATE ON `insurances_audit` FOR EACH ROW BEGIN
  SIGNAL SQLSTATE '45000' 
  SET MESSAGE_TEXT = 'insurances_audit es inmutable: UPDATE prohibido.';
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`wenm`@`%`*/ /*!50003 TRIGGER `bid_insurances_audit_block_delete` BEFORE DELETE ON `insurances_audit` FOR EACH ROW BEGIN

  SIGNAL SQLSTATE '45000'

  SET MESSAGE_TEXT = 'insurances_audit es inmutable: DELETE prohibido.';

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `invoices`
--

DROP TABLE IF EXISTS `invoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoices` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `workorder_id` int NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT 'Pendiente',
  `payment_method` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_invoice_workorder` (`workorder_id`),
  CONSTRAINT `fk_invoice_workorder` FOREIGN KEY (`workorder_id`) REFERENCES `workorders` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoices`
--

LOCK TABLES `invoices` WRITE;
/*!40000 ALTER TABLE `invoices` DISABLE KEYS */;
INSERT INTO `invoices` VALUES (1,'2024-01-01',0.00,101,'Pendiente',NULL),(2,'2024-01-02',1065.09,102,'Pendiente',NULL),(3,'2024-01-03',1665.55,103,'Pendiente',NULL),(4,'2024-01-04',1132.73,104,'Pendiente',NULL),(5,'2024-01-05',1312.20,105,'Pendiente',NULL),(6,'2024-01-06',1104.90,106,'Pendiente',NULL),(7,'2024-01-07',963.60,107,'Pendiente',NULL),(8,'2024-01-08',1513.39,108,'Pendiente',NULL),(9,'2024-01-09',1999.56,109,'Pendiente',NULL),(10,'2024-01-10',625.46,110,'Pendiente',NULL),(11,'2024-01-11',809.23,111,'Pendiente',NULL),(12,'2024-01-12',1048.10,112,'Pendiente',NULL),(13,'2024-01-13',1158.33,113,'Pendiente',NULL),(14,'2024-01-14',1946.05,114,'Pendiente',NULL),(15,'2024-01-15',760.64,115,'Pendiente',NULL),(16,'2024-01-16',1334.97,116,'Pendiente',NULL),(17,'2024-01-17',1566.52,117,'Pendiente',NULL),(18,'2024-01-18',495.59,118,'Pendiente',NULL),(19,'2024-01-19',1885.72,119,'Pendiente',NULL),(20,'2024-01-20',1941.98,120,'Pendiente',NULL),(21,'2024-01-21',348.65,121,'Pendiente',NULL),(22,'2024-01-22',1169.63,122,'Pendiente',NULL),(23,'2024-01-23',1533.80,123,'Pendiente',NULL),(24,'2024-01-24',1402.64,124,'Pendiente',NULL),(25,'2024-01-25',946.54,125,'Pendiente',NULL),(26,'2024-01-26',1510.94,126,'Pendiente',NULL),(27,'2024-01-27',1437.50,127,'Pendiente',NULL),(28,'2024-01-28',1838.67,128,'Pendiente',NULL),(29,'2024-01-29',433.82,129,'Pendiente',NULL),(30,'2024-01-30',1082.55,130,'Pendiente',NULL),(31,'2024-01-31',1256.55,131,'Pendiente',NULL),(32,'2024-02-01',177.61,132,'Pendiente',NULL),(33,'2024-02-02',534.66,133,'Pendiente',NULL),(34,'2024-02-03',1804.78,134,'Pendiente',NULL),(35,'2024-02-04',866.96,135,'Pendiente',NULL),(36,'2024-02-05',431.26,136,'Pendiente',NULL),(37,'2024-02-06',928.44,137,'Pendiente',NULL),(38,'2024-02-07',1412.14,138,'Pendiente',NULL),(39,'2024-02-08',480.92,139,'Pendiente',NULL),(40,'2024-02-09',1481.47,140,'Pendiente',NULL),(41,'2024-02-10',600.73,141,'Pendiente',NULL),(42,'2024-02-11',1165.04,142,'Pendiente',NULL),(43,'2024-02-12',551.48,143,'Pendiente',NULL),(44,'2024-02-13',1314.16,144,'Pendiente',NULL),(45,'2024-02-14',980.39,145,'Pendiente',NULL),(46,'2024-02-15',1610.84,146,'Pendiente',NULL),(47,'2024-02-16',1493.75,147,'Pendiente',NULL),(48,'2024-02-17',1704.05,148,'Pendiente',NULL),(49,'2024-02-18',1611.81,149,'Pendiente',NULL),(50,'2024-02-19',1077.46,150,'Pendiente',NULL),(51,'2024-02-20',1775.20,151,'Pendiente',NULL),(52,'2024-02-21',992.77,152,'Pendiente',NULL),(53,'2024-02-22',659.86,153,'Pendiente',NULL),(54,'2024-02-23',296.49,154,'Pendiente',NULL),(55,'2024-02-24',1250.38,155,'Pendiente',NULL),(56,'2024-02-25',1705.36,156,'Pendiente',NULL),(57,'2024-02-26',874.95,157,'Pendiente',NULL),(58,'2024-02-27',1670.03,158,'Pendiente',NULL),(59,'2024-02-28',1158.35,159,'Pendiente',NULL),(60,'2024-02-29',1178.85,160,'Pendiente',NULL),(61,'2024-03-01',708.08,161,'Pendiente',NULL),(62,'2024-03-02',1087.02,162,'Pendiente',NULL),(63,'2024-03-03',408.80,163,'Pendiente',NULL),(64,'2024-03-04',895.95,164,'Pendiente',NULL),(65,'2024-03-05',1965.08,165,'Pendiente',NULL),(66,'2024-03-06',1140.92,166,'Pendiente',NULL),(67,'2024-03-07',1880.29,167,'Pendiente',NULL),(68,'2024-03-08',855.78,168,'Pendiente',NULL),(69,'2024-03-09',800.47,169,'Pendiente',NULL),(70,'2024-03-10',1979.38,170,'Pendiente',NULL),(71,'2024-03-11',1222.66,171,'Pendiente',NULL),(72,'2024-03-12',1559.02,172,'Pendiente',NULL),(73,'2024-03-13',262.80,173,'Pendiente',NULL),(74,'2024-03-14',1834.70,174,'Pendiente',NULL),(75,'2024-03-15',927.25,175,'Pendiente',NULL),(76,'2024-03-16',122.98,176,'Pendiente',NULL),(77,'2024-03-17',1365.40,177,'Pendiente',NULL),(78,'2024-03-18',118.57,178,'Pendiente',NULL),(79,'2024-03-19',406.00,179,'Pendiente',NULL),(80,'2024-03-20',1103.62,180,'Pendiente',NULL),(81,'2024-03-21',1312.71,181,'Pendiente',NULL),(82,'2024-03-22',1166.07,182,'Pendiente',NULL),(83,'2024-03-23',341.89,183,'Pendiente',NULL),(84,'2024-03-24',190.61,184,'Pendiente',NULL),(85,'2024-03-25',1516.93,185,'Pendiente',NULL),(86,'2024-03-26',1496.80,186,'Pendiente',NULL),(87,'2024-03-27',342.25,187,'Pendiente',NULL),(88,'2024-03-28',646.78,188,'Pendiente',NULL),(89,'2024-03-29',809.82,189,'Pendiente',NULL),(90,'2024-03-30',189.36,190,'Pendiente',NULL),(91,'2024-03-31',927.57,191,'Pendiente',NULL),(92,'2024-04-01',969.25,192,'Pendiente',NULL),(93,'2024-04-02',424.54,193,'Pendiente',NULL),(94,'2024-04-03',765.71,194,'Pendiente',NULL),(95,'2024-04-04',733.04,195,'Pendiente',NULL),(96,'2024-04-05',1065.09,196,'Pendiente',NULL),(97,'2024-04-06',1665.55,197,'Pendiente',NULL),(98,'2024-04-07',1132.73,198,'Pendiente',NULL),(99,'2024-04-08',1312.20,199,'Pendiente',NULL),(100,'2024-04-09',1104.90,200,'Pagada',NULL),(101,'2026-06-03',1800000.00,204,'Pendiente','Efectivo'),(102,'2026-06-04',1800000.00,205,'Pendiente','Efectivo');
/*!40000 ALTER TABLE `invoices` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`wenm`@`%`*/ /*!50003 TRIGGER `ai_invoices_audit` AFTER INSERT ON `invoices` FOR EACH ROW BEGIN

  SET @from_invoices_trigger = 1;



  INSERT INTO invoices_audit (invoice_id, actionType, before_data, after_data)

  VALUES (

    NEW.id,

    'INSERT',

    NULL,

    JSON_OBJECT(

      'id', NEW.id,

      'date', NEW.date,

      'total', NEW.total,

      'workorder_id', NEW.workorder_id

    )

  );



  SET @from_invoices_trigger = NULL;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`wenm`@`%`*/ /*!50003 TRIGGER `au_invoices_audit` AFTER UPDATE ON `invoices` FOR EACH ROW BEGIN

  SET @from_invoices_trigger = 1;



  INSERT INTO invoices_audit (invoice_id, actionType, before_data, after_data)

  VALUES (

    NEW.id,

    'UPDATE',

    JSON_OBJECT(

      'id', OLD.id,

      'date', OLD.date,

      'total', OLD.total,

      'workorder_id', OLD.workorder_id

    ),

    JSON_OBJECT(

      'id', NEW.id,

      'date', NEW.date,

      'total', NEW.total,

      'workorder_id', NEW.workorder_id

    )

  );



  SET @from_invoices_trigger = NULL;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`wenm`@`%`*/ /*!50003 TRIGGER `ad_invoices_audit` AFTER DELETE ON `invoices` FOR EACH ROW BEGIN

  SET @from_invoices_trigger = 1;



  INSERT INTO invoices_audit (invoice_id, actionType, before_data, after_data)

  VALUES (

    OLD.id,

    'DELETE',

    JSON_OBJECT(

      'id', OLD.id,

      'date', OLD.date,

      'total', OLD.total,

      'workorder_id', OLD.workorder_id

    ),

    NULL

  );



  SET @from_invoices_trigger = NULL;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `invoices_audit`
--

DROP TABLE IF EXISTS `invoices_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoices_audit` (
  `id` int NOT NULL AUTO_INCREMENT,
  `invoice_id` int NOT NULL,
  `actionType` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `changed_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `changed_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `before_data` json DEFAULT NULL,
  `after_data` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `invoice_id` (`invoice_id`),
  CONSTRAINT `invoices_audit_ibfk_1` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoices_audit`
--

LOCK TABLES `invoices_audit` WRITE;
/*!40000 ALTER TABLE `invoices_audit` DISABLE KEYS */;
INSERT INTO `invoices_audit` VALUES (1,1,'UPDATE','2025-10-16 08:54:43',NULL,'{\"id\": 1, \"date\": \"2024-01-01\", \"total\": 733.04, \"workorder_id\": 101}','{\"id\": 1, \"date\": \"2024-01-01\", \"total\": 0.0, \"workorder_id\": 101}'),(2,100,'UPDATE','2026-06-02 22:05:03',NULL,'{\"id\": 100, \"date\": \"2024-04-09\", \"total\": 1104.90, \"workorder_id\": 200}','{\"id\": 100, \"date\": \"2024-04-09\", \"total\": 1104.90, \"workorder_id\": 200}'),(3,101,'INSERT','2026-06-04 00:38:26',NULL,NULL,'{\"id\": 101, \"date\": \"2026-06-03\", \"total\": 1800000.00, \"workorder_id\": 204}'),(4,102,'INSERT','2026-06-04 14:32:43',NULL,NULL,'{\"id\": 102, \"date\": \"2026-06-04\", \"total\": 1800000.00, \"workorder_id\": 205}');
/*!40000 ALTER TABLE `invoices_audit` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`wenm`@`%`*/ /*!50003 TRIGGER `bii_invoices_audit_guard_insert` BEFORE INSERT ON `invoices_audit` FOR EACH ROW BEGIN

  IF COALESCE(@from_invoices_trigger, 0) <> 1 THEN

    SIGNAL SQLSTATE '45000'

    SET MESSAGE_TEXT = 'INSERT en invoices_audit solo permitido desde triggers de invoices.';

  END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`wenm`@`%`*/ /*!50003 TRIGGER `biu_invoices_audit_block_update` BEFORE UPDATE ON `invoices_audit` FOR EACH ROW BEGIN

  SIGNAL SQLSTATE '45000'

  SET MESSAGE_TEXT = 'invoices_audit es inmutable: UPDATE prohibido.';

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`wenm`@`%`*/ /*!50003 TRIGGER `bid_invoices_audit_block_delete` BEFORE DELETE ON `invoices_audit` FOR EACH ROW BEGIN

  SIGNAL SQLSTATE '45000'

  SET MESSAGE_TEXT = 'invoices_audit es inmutable: DELETE prohibido.';

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `mechanics`
--

DROP TABLE IF EXISTS `mechanics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mechanics` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `specialty` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mechanics`
--

LOCK TABLES `mechanics` WRITE;
/*!40000 ALTER TABLE `mechanics` DISABLE KEYS */;
INSERT INTO `mechanics` VALUES (101,'Luis','Herrera','Motor y Distribución'),(102,'Miguel','Castillo','Motor y Distribución'),(103,'Jorge','Mendoza','Frenos y Suspensión'),(104,'Ricardo','Vargas','Frenos y Suspensión'),(105,'Andrés','Morales','Eléctrico y Diagnóstico'),(106,'Felipe','Torres','Eléctrico y Diagnóstico'),(107,'Carlos','Ramírez','Aire Acondicionado y Refrigeración'),(108,'Sebastián','Díaz','Aire Acondicionado y Refrigeración'),(109,'David','Ospina','Alineación y Lavado'),(110,'Camilo','Reyes','Alineación y Lavado');
/*!40000 ALTER TABLE `mechanics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `amount` decimal(10,2) NOT NULL,
  `payment_date` date NOT NULL,
  `method` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `invoice_id` int NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT 'Pendiente',
  PRIMARY KEY (`id`),
  KEY `fk_payment_invoice` (`invoice_id`),
  CONSTRAINT `fk_payment_invoice` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (101,1800000.00,'2026-06-03','Efectivo',101,'Pendiente'),(102,1800000.00,'2026-06-04','Efectivo',102,'Pendiente');
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`wenm`@`%`*/ /*!50003 TRIGGER `ai_payments_audit` AFTER INSERT ON `payments` FOR EACH ROW BEGIN

  SET @from_payments_trigger = 1;



  INSERT INTO payments_audit (payment_id, actionType, before_data, after_data)

  VALUES (

    NEW.id,

    'INSERT',

    NULL,

    JSON_OBJECT(

      'id', NEW.id,

      'amount', NEW.amount,

      'payment_date', NEW.payment_date,

      'method', NEW.method,

      'invoice_id', NEW.invoice_id

    )

  );



  SET @from_payments_trigger = NULL;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`wenm`@`%`*/ /*!50003 TRIGGER `au_payments_audit` AFTER UPDATE ON `payments` FOR EACH ROW BEGIN

  SET @from_payments_trigger = 1;



  INSERT INTO payments_audit (payment_id, actionType, before_data, after_data)

  VALUES (

    NEW.id,

    'UPDATE',

    JSON_OBJECT(

      'id', OLD.id,

      'amount', OLD.amount,

      'payment_date', OLD.payment_date,

      'method', OLD.method,

      'invoice_id', OLD.invoice_id

    ),

    JSON_OBJECT(

      'id', NEW.id,

      'amount', NEW.amount,

      'payment_date', NEW.payment_date,

      'method', NEW.method,

      'invoice_id', NEW.invoice_id

    )

  );



  SET @from_payments_trigger = NULL;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`wenm`@`%`*/ /*!50003 TRIGGER `ad_payments_audit` BEFORE DELETE ON `payments` FOR EACH ROW BEGIN

  SET @from_payments_trigger = 1;



  INSERT INTO payments_audit (payment_id, actionType, before_data, after_data)

  VALUES (

    OLD.id,

    'DELETE',

    JSON_OBJECT(

      'id', OLD.id,

      'amount', OLD.amount,

      'payment_date', OLD.payment_date,

      'method', OLD.method,

      'invoice_id', OLD.invoice_id

    ),

    NULL

  );



  SET @from_payments_trigger = NULL;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `payments_audit`
--

DROP TABLE IF EXISTS `payments_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments_audit` (
  `id` int NOT NULL AUTO_INCREMENT,
  `payment_id` int NOT NULL,
  `actionType` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `changed_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `changed_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `before_data` json DEFAULT NULL,
  `after_data` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `payments_audit_ibfk_1` (`payment_id`),
  CONSTRAINT `payments_audit_ibfk_1` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments_audit`
--

LOCK TABLES `payments_audit` WRITE;
/*!40000 ALTER TABLE `payments_audit` DISABLE KEYS */;
INSERT INTO `payments_audit` VALUES (14,101,'INSERT','2026-06-04 00:38:26',NULL,NULL,'{\"id\": 101, \"amount\": 1800000.00, \"method\": \"Efectivo\", \"invoice_id\": 101, \"payment_date\": \"2026-06-03\"}'),(113,102,'INSERT','2026-06-04 14:32:43',NULL,NULL,'{\"id\": 102, \"amount\": 1800000.00, \"method\": \"Efectivo\", \"invoice_id\": 102, \"payment_date\": \"2026-06-04\"}');
/*!40000 ALTER TABLE `payments_audit` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`wenm`@`%`*/ /*!50003 TRIGGER `bii_payments_audit_guard_insert` BEFORE INSERT ON `payments_audit` FOR EACH ROW BEGIN

  IF COALESCE(@from_payments_trigger, 0) <> 1 THEN

    SIGNAL SQLSTATE '45000'

    SET MESSAGE_TEXT = 'INSERT en payments_audit solo permitido desde triggers de payments.';

  END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`wenm`@`%`*/ /*!50003 TRIGGER `biu_payments_audit_block_update` BEFORE UPDATE ON `payments_audit` FOR EACH ROW BEGIN

  SIGNAL SQLSTATE '45000'

  SET MESSAGE_TEXT = 'payments_audit es inmutable: UPDATE prohibido.';

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`wenm`@`%`*/ /*!50003 TRIGGER `bid_payments_audit_block_delete` BEFORE DELETE ON `payments_audit` FOR EACH ROW BEGIN

  SIGNAL SQLSTATE '45000'

  SET MESSAGE_TEXT = 'payments_audit es inmutable: DELETE prohibido.';

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `services` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=127 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` VALUES (101,'Cambio de aceite y filtro',85000.00),(102,'Alineación y balanceo',120000.00),(103,'Diagnóstico electrónico',80000.00),(104,'Cambio de frenos delanteros',220000.00),(105,'Cambio de frenos traseros',200000.00),(106,'Cambio de correa de distribución',380000.00),(107,'Cambio de bujías',95000.00),(108,'Revisión de suspensión',75000.00),(109,'Cambio de amortiguadores delanteros',450000.00),(110,'Cambio de amortiguadores traseros',420000.00),(111,'Cambio de filtro de aire',45000.00),(112,'Cambio de filtro de combustible',55000.00),(113,'Revisión del sistema eléctrico',90000.00),(114,'Cambio de batería',280000.00),(115,'Revisión de aire acondicionado',85000.00),(116,'Carga de aire acondicionado',150000.00),(117,'Cambio de líquido de frenos',65000.00),(118,'Cambio de líquido refrigerante',70000.00),(119,'Revisión general del motor',130000.00),(120,'Cambio de embrague',650000.00),(121,'Cambio de caja de velocidades',1200000.00),(122,'Rectificación de motor',1800000.00),(123,'Cambio de termostato',120000.00),(124,'Cambio de bomba de agua',280000.00),(125,'Lavado y desengrase de motor',95000.00),(126,'AGUA',2000.00);
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spareparts`
--

DROP TABLE IF EXISTS `spareparts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `spareparts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=201 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spareparts`
--

LOCK TABLES `spareparts` WRITE;
/*!40000 ALTER TABLE `spareparts` DISABLE KEYS */;
INSERT INTO `spareparts` VALUES (151,'Aceite de motor 5W-30 (litro)',18000.00,50),(152,'Aceite de motor 20W-50 (litro)',15000.00,50),(153,'Filtro de aceite',25000.00,30),(154,'Filtro de aire',35000.00,25),(155,'Filtro de combustible',40000.00,20),(156,'Filtro de habitáculo',30000.00,20),(157,'Bujía estándar',18000.00,40),(158,'Bujía de iridio',45000.00,20),(159,'Pastillas de freno delanteras',85000.00,15),(160,'Pastillas de freno traseras',75000.00,15),(161,'Disco de freno delantero',120000.00,10),(162,'Disco de freno trasero',110000.00,10),(163,'Amortiguador delantero',180000.00,8),(164,'Amortiguador trasero',160000.00,8),(165,'Correa de distribución',95000.00,10),(166,'Correa de accesorios',45000.00,15),(167,'Termostato',55000.00,12),(168,'Bomba de agua',120000.00,8),(169,'Bomba de combustible',180000.00,6),(170,'Batería 40Ah',220000.00,10),(171,'Batería 60Ah',280000.00,8),(172,'Batería 80Ah',350000.00,5),(173,'Líquido de frenos DOT4 (500ml)',22000.00,25),(174,'Líquido refrigerante (litro)',18000.00,30),(175,'Líquido de dirección hidráulica',20000.00,20),(176,'Bujía de precalentamiento',35000.00,15),(177,'Sensor de oxígeno',150000.00,6),(178,'Sensor MAP',120000.00,6),(179,'Sensor de temperatura',85000.00,8),(180,'Bobina de encendido',95000.00,10),(181,'Cable de bujías',65000.00,12),(182,'Banda de freno',55000.00,10),(183,'Rodamiento de rueda',85000.00,10),(184,'Terminal de dirección',65000.00,12),(185,'Rótula de suspensión',75000.00,10),(186,'Barra estabilizadora',95000.00,8),(187,'Manguera de radiador superior',45000.00,10),(188,'Manguera de radiador inferior',40000.00,10),(189,'Radiador',380000.00,4),(190,'Alternador remanufacturado',450000.00,4),(191,'Motor de arranque remanufacturado',380000.00,4),(192,'Compresor de aire acondicionado',650000.00,3),(193,'Gas refrigerante R134a',85000.00,15),(194,'Espejo retrovisor derecho',120000.00,6),(195,'Espejo retrovisor izquierdo',120000.00,6),(196,'Limpiaparabrisas delantero',35000.00,15),(197,'Limpiaparabrisas trasero',28000.00,15),(198,'Bombillo H4',25000.00,20),(199,'Bombillo LED H4',85000.00,15),(200,'Fusible automotriz kit',15000.00,30);
/*!40000 ALTER TABLE `spareparts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicles`
--

DROP TABLE IF EXISTS `vehicles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `brand` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `plate` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `problem` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `Vehicle_Customer_FK` (`customer_id`),
  CONSTRAINT `Vehicle_Customer_FK` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicles`
--

LOCK TABLES `vehicles` WRITE;
/*!40000 ALTER TABLE `vehicles` DISABLE KEYS */;
INSERT INTO `vehicles` VALUES (1,1,'Mazda','','AAA-001',NULL),(2,2,'Mazda','CX-5','AAA-002',NULL),(3,3,'Honda','Civic','AAA-003',NULL),(4,4,'Chevrolet','Aveo','AAA-004',NULL),(5,5,'Kia','Rio','AAA-005',NULL),(6,6,'Hyundai','Elantra','AAA-006',NULL),(7,7,'Ford','Focus','AAA-007',NULL),(8,8,'VW','Jetta','AAA-008',NULL),(9,9,'Peugeot','208','AAA-009',NULL),(10,10,'Toyota','Corolla','AAA-010',NULL),(11,11,'Nissan','Sentra','AAA-011',NULL),(12,12,'Mazda','CX-5','AAA-012',NULL),(13,13,'Honda','Civic','AAA-013',NULL),(14,14,'Chevrolet','Aveo','AAA-014',NULL),(15,15,'Kia','Rio','AAA-015',NULL),(16,16,'Hyundai','Elantra','AAA-016',NULL),(17,17,'Ford','Focus','AAA-017',NULL),(18,18,'VW','Jetta','AAA-018',NULL),(19,19,'Peugeot','208','AAA-019',NULL),(20,20,'Toyota','Corolla','AAA-020',NULL),(21,21,'Nissan','Sentra','AAA-021',NULL),(22,22,'Mazda','CX-5','AAA-022',NULL),(23,23,'Honda','Civic','AAA-023',NULL),(24,24,'Chevrolet','Aveo','AAA-024',NULL),(25,25,'Kia','Rio','AAA-025',NULL),(26,26,'Hyundai','Elantra','AAA-026',NULL),(27,27,'Ford','Focus','AAA-027',NULL),(28,28,'VW','Jetta','AAA-028',NULL),(29,29,'Peugeot','208','AAA-029',NULL),(30,30,'Toyota','Corolla','AAA-030',NULL),(31,31,'Nissan','Sentra','AAA-031',NULL),(32,32,'Mazda','CX-5','AAA-032',NULL),(33,33,'Honda','Civic','AAA-033',NULL),(34,34,'Chevrolet','Aveo','AAA-034',NULL),(35,35,'Kia','Rio','AAA-035',NULL),(36,36,'Hyundai','Elantra','AAA-036',NULL),(37,37,'Ford','Focus','AAA-037',NULL),(38,38,'VW','Jetta','AAA-038',NULL),(39,39,'Peugeot','208','AAA-039',NULL),(40,40,'Toyota','Corolla','AAA-040',NULL),(41,41,'Nissan','Sentra','AAA-041',NULL),(42,42,'Mazda','CX-5','AAA-042',NULL),(43,43,'Honda','Civic','AAA-043',NULL),(44,44,'Chevrolet','Aveo','AAA-044',NULL),(45,45,'Kia','Rio','AAA-045',NULL),(46,46,'Hyundai','Elantra','AAA-046',NULL),(47,47,'Ford','Focus','AAA-047',NULL),(48,48,'VW','Jetta','AAA-048',NULL),(49,49,'Peugeot','208','AAA-049',NULL),(50,50,'Toyota','Corolla','AAA-050',NULL),(51,51,'Nissan','Sentra','AAA-051',NULL),(52,52,'Mazda','CX-5','AAA-052',NULL),(53,53,'Honda','Civic','AAA-053',NULL),(54,54,'Chevrolet','Aveo','AAA-054',NULL),(55,55,'Kia','Rio','AAA-055',NULL),(56,56,'Hyundai','Elantra','AAA-056',NULL),(57,57,'Ford','Focus','AAA-057',NULL),(58,58,'VW','Jetta','AAA-058',NULL),(59,59,'Peugeot','208','AAA-059',NULL),(60,60,'Toyota','Corolla','AAA-060',NULL),(61,61,'Nissan','Sentra','AAA-061',NULL),(62,62,'Mazda','CX-5','AAA-062',NULL),(63,63,'Honda','Civic','AAA-063',NULL),(64,64,'Chevrolet','Aveo','AAA-064',NULL),(65,65,'Kia','Rio','AAA-065',NULL),(66,66,'Hyundai','Elantra','AAA-066',NULL),(67,67,'Ford','Focus','AAA-067',NULL),(68,68,'VW','Jetta','AAA-068',NULL),(69,69,'Peugeot','208','AAA-069',NULL),(70,70,'Toyota','Corolla','AAA-070',NULL),(71,71,'Nissan','Sentra','AAA-071',NULL),(72,72,'Mazda','CX-5','AAA-072',NULL),(73,73,'Honda','Civic','AAA-073',NULL),(74,74,'Chevrolet','Aveo','AAA-074',NULL),(75,75,'Kia','Rio','AAA-075',NULL),(76,76,'Hyundai','Elantra','AAA-076',NULL),(77,77,'Ford','Focus','AAA-077',NULL),(78,78,'VW','Jetta','AAA-078',NULL),(79,79,'Peugeot','208','AAA-079',NULL),(80,80,'Toyota','Corolla','AAA-080',NULL),(81,81,'Nissan','Sentra','AAA-081',NULL),(82,82,'Mazda','CX-5','AAA-082',NULL),(83,83,'Honda','Civic','AAA-083',NULL),(84,84,'Chevrolet','Aveo','AAA-084',NULL),(85,85,'Kia','Rio','AAA-085',NULL),(86,86,'Hyundai','Elantra','AAA-086',NULL),(87,87,'Ford','Focus','AAA-087',NULL),(88,88,'VW','Jetta','AAA-088',NULL),(89,89,'Peugeot','208','AAA-089',NULL),(90,90,'Toyota','Corolla','AAA-090',NULL),(91,91,'Nissan','Sentra','AAA-091',NULL),(92,92,'Mazda','CX-5','AAA-092',NULL),(93,93,'Honda','Civic','AAA-093',NULL),(94,94,'Chevrolet','Aveo','AAA-094',NULL),(95,95,'Kia','Rio','AAA-095',NULL),(96,96,'Hyundai','Elantra','AAA-096',NULL),(97,97,'Ford','Focus','AAA-097',NULL),(98,98,'VW','Jetta','AAA-098',NULL),(99,99,'Peugeot','208','AAA-099',NULL),(100,100,'Toyota','Corolla','AAA-100',NULL),(115,124,'toyota','corolla','wes-234','ewe'),(116,125,'toyota','corolla','LBK_123','Cambio de batería'),(117,126,'toyota','corolla','AAA-345',NULL),(118,127,'toyota','corolla','ZZZ-344',NULL),(119,128,'toyota','corolla','AAA-347',NULL),(120,129,'toyota','corolla','AAA-456',NULL),(121,129,'KIA','PICANTO','VAA855',NULL),(122,130,'SDFSDFSDF','SDFSDFSDF','ASDFSDFSDF',NULL),(123,131,'toyota','corolla','WESL123',NULL),(124,132,'toyota','corolla','DRE234',NULL),(125,133,'toyota','corolla','WES567',NULL);
/*!40000 ALTER TABLE `vehicles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicles_audit`
--

DROP TABLE IF EXISTS `vehicles_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicles_audit` (
  `id` int NOT NULL AUTO_INCREMENT,
  `vehicle_id` int NOT NULL,
  `actionType` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `changed_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `changed_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `before_data` json DEFAULT NULL,
  `after_data` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `vehicle_id` (`vehicle_id`),
  CONSTRAINT `vehicles_audit_ibfk_1` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicles_audit`
--

LOCK TABLES `vehicles_audit` WRITE;
/*!40000 ALTER TABLE `vehicles_audit` DISABLE KEYS */;
INSERT INTO `vehicles_audit` VALUES (1,1,'UPDATE','2025-10-16 09:10:23',NULL,'{\"id\": 1, \"brand\": \"Nissan\", \"model\": \"Sentra\", \"plate\": \"AAA-001\", \"customer_id\": 1}','{\"id\": 1, \"brand\": \"Mazda\", \"model\": \"Sentra\", \"plate\": \"AAA-001\", \"customer_id\": 1}'),(2,1,'UPDATE','2025-10-16 09:14:49',NULL,'{\"id\": 1, \"brand\": \"Mazda\", \"model\": \"Sentra\", \"plate\": \"AAA-001\", \"customer_id\": 1}','{\"id\": 1, \"brand\": \"Mazda\", \"model\": \"\", \"plate\": \"AAA-001\", \"customer_id\": 1}');
/*!40000 ALTER TABLE `vehicles_audit` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`wenm`@`%`*/ /*!50003 TRIGGER `bii_vehicles_audit_guard_insert` BEFORE INSERT ON `vehicles_audit` FOR EACH ROW BEGIN

  IF COALESCE(@from_vehicles_trigger, 0) <> 1 THEN

    SIGNAL SQLSTATE '45000'

    SET MESSAGE_TEXT = 'INSERT en vehicles_audit solo permitido desde triggers de vehicles.';

  END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`wenm`@`%`*/ /*!50003 TRIGGER `biu_vehicles_audit_block_update` BEFORE UPDATE ON `vehicles_audit` FOR EACH ROW BEGIN

  SIGNAL SQLSTATE '45000'

  SET MESSAGE_TEXT = 'vehicles_audit es inmutable: UPDATE prohibido.';

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`wenm`@`%`*/ /*!50003 TRIGGER `bid_vehicles_audit_block_delete` BEFORE DELETE ON `vehicles_audit` FOR EACH ROW BEGIN

  SIGNAL SQLSTATE '45000'

  SET MESSAGE_TEXT = 'vehicles_audit es inmutable: DELETE prohibido.';

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `workorders`
--

DROP TABLE IF EXISTS `workorders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `workorders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `vehicle_id` int NOT NULL,
  `mechanic_id` int NOT NULL,
  `status` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `WorkOrder_Vehicle_FK` (`vehicle_id`),
  KEY `WorkOrder_Mechanic_FK` (`mechanic_id`),
  CONSTRAINT `fk_workorders_vehicle` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `WorkOrder_Mechanic_FK` FOREIGN KEY (`mechanic_id`) REFERENCES `mechanics` (`id`),
  CONSTRAINT `WorkOrder_Vehicle_FK` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=206 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workorders`
--

LOCK TABLES `workorders` WRITE;
/*!40000 ALTER TABLE `workorders` DISABLE KEYS */;
INSERT INTO `workorders` VALUES (203,115,101,'Finalizada','2026-06-03','2026-06-03'),(204,123,110,'Reparación','2026-06-03',NULL),(205,123,102,'Diagnóstico','2026-06-04',NULL);
/*!40000 ALTER TABLE `workorders` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`wenm`@`%`*/ /*!50003 TRIGGER `ai_workorders_audit` AFTER INSERT ON `workorders` FOR EACH ROW BEGIN

  SET @from_workorders_trigger = 1;



  INSERT INTO workorders_audit (workorder_id, actionType, before_data, after_data)

  VALUES (

    NEW.id,

    'INSERT',

    NULL,

    JSON_OBJECT(

      'id', NEW.id,

      'vehicle_id', NEW.vehicle_id,

      'mechanic_id', NEW.mechanic_id,

      'status', NEW.status,

      'start_date', NEW.start_date,

      'end_date', NEW.end_date

    )

  );



  SET @from_workorders_trigger = NULL;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`wenm`@`%`*/ /*!50003 TRIGGER `au_workorders_audit` AFTER UPDATE ON `workorders` FOR EACH ROW BEGIN

  SET @from_workorders_trigger = 1;



  INSERT INTO workorders_audit (workorder_id, actionType, before_data, after_data)

  VALUES (

    NEW.id,

    'UPDATE',

    JSON_OBJECT(

      'id', OLD.id,

      'vehicle_id', OLD.vehicle_id,

      'mechanic_id', OLD.mechanic_id,

      'status', OLD.status,

      'start_date', OLD.start_date,

      'end_date', OLD.end_date

    ),

    JSON_OBJECT(

      'id', NEW.id,

      'vehicle_id', NEW.vehicle_id,

      'mechanic_id', NEW.mechanic_id,

      'status', NEW.status,

      'start_date', NEW.start_date,

      'end_date', NEW.end_date

    )

  );



  SET @from_workorders_trigger = NULL;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`wenm`@`%`*/ /*!50003 TRIGGER `ad_workorders_audit` AFTER DELETE ON `workorders` FOR EACH ROW BEGIN

  SET @from_workorders_trigger = 1;



  INSERT INTO workorders_audit (workorder_id, actionType, before_data, after_data)

  VALUES (

    OLD.id,

    'DELETE',

    JSON_OBJECT(

      'id', OLD.id,

      'vehicle_id', OLD.vehicle_id,

      'mechanic_id', OLD.mechanic_id,

      'status', OLD.status,

      'start_date', OLD.start_date,

      'end_date', OLD.end_date

    ),

    NULL

  );



  SET @from_workorders_trigger = NULL;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `workorders_audit`
--

DROP TABLE IF EXISTS `workorders_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `workorders_audit` (
  `id` int NOT NULL AUTO_INCREMENT,
  `workorder_id` int NOT NULL,
  `actionType` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `changed_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `changed_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `before_data` json DEFAULT NULL,
  `after_data` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `workorder_id` (`workorder_id`),
  CONSTRAINT `workorders_audit_ibfk_1` FOREIGN KEY (`workorder_id`) REFERENCES `workorders` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workorders_audit`
--

LOCK TABLES `workorders_audit` WRITE;
/*!40000 ALTER TABLE `workorders_audit` DISABLE KEYS */;
INSERT INTO `workorders_audit` VALUES (1,101,'UPDATE','2025-10-16 09:05:58',NULL,'{\"id\": 101, \"status\": \"Pending\", \"end_date\": null, \"start_date\": \"2023-01-02\", \"vehicle_id\": 1, \"mechanic_id\": 1}','{\"id\": 101, \"status\": \"In Progress\", \"end_date\": null, \"start_date\": \"2023-01-02\", \"vehicle_id\": 1, \"mechanic_id\": 1}'),(2,200,'UPDATE','2026-05-30 21:38:59',NULL,'{\"id\": 200, \"status\": \"Pending\", \"end_date\": null, \"start_date\": \"2023-01-17\", \"vehicle_id\": 100, \"mechanic_id\": 100}','{\"id\": 200, \"status\": \"Finalizada\", \"end_date\": \"2026-05-30\", \"start_date\": \"2023-01-17\", \"vehicle_id\": 100, \"mechanic_id\": 100}'),(3,199,'UPDATE','2026-05-30 21:39:08',NULL,'{\"id\": 199, \"status\": \"Completed\", \"end_date\": \"2023-01-17\", \"start_date\": \"2023-01-16\", \"vehicle_id\": 99, \"mechanic_id\": 99}','{\"id\": 199, \"status\": \"Reparación\", \"end_date\": \"2023-01-17\", \"start_date\": \"2023-01-16\", \"vehicle_id\": 99, \"mechanic_id\": 99}'),(4,201,'INSERT','2026-06-02 00:41:25',NULL,NULL,'{\"id\": 201, \"status\": \"Diagnóstico\", \"end_date\": null, \"start_date\": \"2026-06-01\", \"vehicle_id\": 118, \"mechanic_id\": 2}'),(5,201,'UPDATE','2026-06-02 00:54:04',NULL,'{\"id\": 201, \"status\": \"Diagnóstico\", \"end_date\": null, \"start_date\": \"2026-06-01\", \"vehicle_id\": 118, \"mechanic_id\": 2}','{\"id\": 201, \"status\": \"Finalizada\", \"end_date\": \"2026-06-01\", \"start_date\": \"2026-06-01\", \"vehicle_id\": 118, \"mechanic_id\": 2}'),(6,199,'UPDATE','2026-06-02 01:15:48',NULL,'{\"id\": 199, \"status\": \"Reparación\", \"end_date\": \"2023-01-17\", \"start_date\": \"2023-01-16\", \"vehicle_id\": 99, \"mechanic_id\": 99}','{\"id\": 199, \"status\": \"Finalizada\", \"end_date\": \"2023-01-17\", \"start_date\": \"2023-01-16\", \"vehicle_id\": 99, \"mechanic_id\": 99}'),(7,202,'INSERT','2026-06-02 01:18:41',NULL,NULL,'{\"id\": 202, \"status\": \"Diagnóstico\", \"end_date\": null, \"start_date\": \"2026-06-01\", \"vehicle_id\": 120, \"mechanic_id\": 4}'),(8,202,'UPDATE','2026-06-02 01:18:59',NULL,'{\"id\": 202, \"status\": \"Diagnóstico\", \"end_date\": null, \"start_date\": \"2026-06-01\", \"vehicle_id\": 120, \"mechanic_id\": 4}','{\"id\": 202, \"status\": \"Finalizada\", \"end_date\": \"2026-06-01\", \"start_date\": \"2026-06-01\", \"vehicle_id\": 120, \"mechanic_id\": 4}'),(9,101,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 101, \"status\": \"In Progress\", \"end_date\": null, \"start_date\": \"2023-01-02\", \"vehicle_id\": 1, \"mechanic_id\": 1}',NULL),(10,102,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 102, \"status\": \"In Progress\", \"end_date\": null, \"start_date\": \"2023-01-03\", \"vehicle_id\": 2, \"mechanic_id\": 2}',NULL),(11,103,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 103, \"status\": \"Completed\", \"end_date\": \"2023-01-05\", \"start_date\": \"2023-01-04\", \"vehicle_id\": 3, \"mechanic_id\": 3}',NULL),(12,104,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 104, \"status\": \"Pending\", \"end_date\": null, \"start_date\": \"2023-01-05\", \"vehicle_id\": 4, \"mechanic_id\": 4}',NULL),(13,105,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 105, \"status\": \"In Progress\", \"end_date\": null, \"start_date\": \"2023-01-06\", \"vehicle_id\": 5, \"mechanic_id\": 5}',NULL),(14,106,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 106, \"status\": \"Completed\", \"end_date\": \"2023-01-08\", \"start_date\": \"2023-01-07\", \"vehicle_id\": 6, \"mechanic_id\": 6}',NULL),(15,107,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 107, \"status\": \"Pending\", \"end_date\": null, \"start_date\": \"2023-01-08\", \"vehicle_id\": 7, \"mechanic_id\": 7}',NULL),(16,108,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 108, \"status\": \"In Progress\", \"end_date\": null, \"start_date\": \"2023-01-09\", \"vehicle_id\": 8, \"mechanic_id\": 8}',NULL),(17,109,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 109, \"status\": \"Completed\", \"end_date\": \"2023-01-11\", \"start_date\": \"2023-01-10\", \"vehicle_id\": 9, \"mechanic_id\": 9}',NULL),(18,110,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 110, \"status\": \"Pending\", \"end_date\": null, \"start_date\": \"2023-01-11\", \"vehicle_id\": 10, \"mechanic_id\": 10}',NULL),(19,111,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 111, \"status\": \"In Progress\", \"end_date\": null, \"start_date\": \"2023-01-12\", \"vehicle_id\": 11, \"mechanic_id\": 11}',NULL),(20,112,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 112, \"status\": \"Completed\", \"end_date\": \"2023-01-14\", \"start_date\": \"2023-01-13\", \"vehicle_id\": 12, \"mechanic_id\": 12}',NULL),(21,113,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 113, \"status\": \"Pending\", \"end_date\": null, \"start_date\": \"2023-01-14\", \"vehicle_id\": 13, \"mechanic_id\": 13}',NULL),(22,114,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 114, \"status\": \"In Progress\", \"end_date\": null, \"start_date\": \"2023-01-15\", \"vehicle_id\": 14, \"mechanic_id\": 14}',NULL),(23,115,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 115, \"status\": \"Completed\", \"end_date\": \"2023-01-17\", \"start_date\": \"2023-01-16\", \"vehicle_id\": 15, \"mechanic_id\": 15}',NULL),(24,116,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 116, \"status\": \"Pending\", \"end_date\": null, \"start_date\": \"2023-01-17\", \"vehicle_id\": 16, \"mechanic_id\": 16}',NULL),(25,117,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 117, \"status\": \"In Progress\", \"end_date\": null, \"start_date\": \"2023-01-18\", \"vehicle_id\": 17, \"mechanic_id\": 17}',NULL),(26,118,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 118, \"status\": \"Completed\", \"end_date\": \"2023-01-20\", \"start_date\": \"2023-01-19\", \"vehicle_id\": 18, \"mechanic_id\": 18}',NULL),(27,119,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 119, \"status\": \"Pending\", \"end_date\": null, \"start_date\": \"2023-01-20\", \"vehicle_id\": 19, \"mechanic_id\": 19}',NULL),(28,120,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 120, \"status\": \"In Progress\", \"end_date\": null, \"start_date\": \"2023-01-21\", \"vehicle_id\": 20, \"mechanic_id\": 20}',NULL),(29,121,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 121, \"status\": \"Completed\", \"end_date\": \"2023-01-23\", \"start_date\": \"2023-01-22\", \"vehicle_id\": 21, \"mechanic_id\": 21}',NULL),(30,122,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 122, \"status\": \"Pending\", \"end_date\": null, \"start_date\": \"2023-01-23\", \"vehicle_id\": 22, \"mechanic_id\": 22}',NULL),(31,123,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 123, \"status\": \"In Progress\", \"end_date\": null, \"start_date\": \"2023-01-24\", \"vehicle_id\": 23, \"mechanic_id\": 23}',NULL),(32,124,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 124, \"status\": \"Completed\", \"end_date\": \"2023-01-26\", \"start_date\": \"2023-01-25\", \"vehicle_id\": 24, \"mechanic_id\": 24}',NULL),(33,125,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 125, \"status\": \"Pending\", \"end_date\": null, \"start_date\": \"2023-01-26\", \"vehicle_id\": 25, \"mechanic_id\": 25}',NULL),(34,126,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 126, \"status\": \"In Progress\", \"end_date\": null, \"start_date\": \"2023-01-27\", \"vehicle_id\": 26, \"mechanic_id\": 26}',NULL),(35,127,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 127, \"status\": \"Completed\", \"end_date\": \"2023-01-29\", \"start_date\": \"2023-01-28\", \"vehicle_id\": 27, \"mechanic_id\": 27}',NULL),(36,128,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 128, \"status\": \"Pending\", \"end_date\": null, \"start_date\": \"2023-01-01\", \"vehicle_id\": 28, \"mechanic_id\": 28}',NULL),(37,129,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 129, \"status\": \"In Progress\", \"end_date\": null, \"start_date\": \"2023-01-02\", \"vehicle_id\": 29, \"mechanic_id\": 29}',NULL),(38,130,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 130, \"status\": \"Completed\", \"end_date\": \"2023-01-04\", \"start_date\": \"2023-01-03\", \"vehicle_id\": 30, \"mechanic_id\": 30}',NULL),(39,131,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 131, \"status\": \"Pending\", \"end_date\": null, \"start_date\": \"2023-01-04\", \"vehicle_id\": 31, \"mechanic_id\": 31}',NULL),(40,132,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 132, \"status\": \"In Progress\", \"end_date\": null, \"start_date\": \"2023-01-05\", \"vehicle_id\": 32, \"mechanic_id\": 32}',NULL),(41,133,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 133, \"status\": \"Completed\", \"end_date\": \"2023-01-07\", \"start_date\": \"2023-01-06\", \"vehicle_id\": 33, \"mechanic_id\": 33}',NULL),(42,134,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 134, \"status\": \"Pending\", \"end_date\": null, \"start_date\": \"2023-01-07\", \"vehicle_id\": 34, \"mechanic_id\": 34}',NULL),(43,135,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 135, \"status\": \"In Progress\", \"end_date\": null, \"start_date\": \"2023-01-08\", \"vehicle_id\": 35, \"mechanic_id\": 35}',NULL),(44,136,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 136, \"status\": \"Completed\", \"end_date\": \"2023-01-10\", \"start_date\": \"2023-01-09\", \"vehicle_id\": 36, \"mechanic_id\": 36}',NULL),(45,137,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 137, \"status\": \"Pending\", \"end_date\": null, \"start_date\": \"2023-01-10\", \"vehicle_id\": 37, \"mechanic_id\": 37}',NULL),(46,138,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 138, \"status\": \"In Progress\", \"end_date\": null, \"start_date\": \"2023-01-11\", \"vehicle_id\": 38, \"mechanic_id\": 38}',NULL),(47,139,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 139, \"status\": \"Completed\", \"end_date\": \"2023-01-13\", \"start_date\": \"2023-01-12\", \"vehicle_id\": 39, \"mechanic_id\": 39}',NULL),(48,140,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 140, \"status\": \"Pending\", \"end_date\": null, \"start_date\": \"2023-01-13\", \"vehicle_id\": 40, \"mechanic_id\": 40}',NULL),(49,141,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 141, \"status\": \"In Progress\", \"end_date\": null, \"start_date\": \"2023-01-14\", \"vehicle_id\": 41, \"mechanic_id\": 41}',NULL),(50,142,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 142, \"status\": \"Completed\", \"end_date\": \"2023-01-16\", \"start_date\": \"2023-01-15\", \"vehicle_id\": 42, \"mechanic_id\": 42}',NULL),(51,143,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 143, \"status\": \"Pending\", \"end_date\": null, \"start_date\": \"2023-01-16\", \"vehicle_id\": 43, \"mechanic_id\": 43}',NULL),(52,144,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 144, \"status\": \"In Progress\", \"end_date\": null, \"start_date\": \"2023-01-17\", \"vehicle_id\": 44, \"mechanic_id\": 44}',NULL),(53,145,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 145, \"status\": \"Completed\", \"end_date\": \"2023-01-19\", \"start_date\": \"2023-01-18\", \"vehicle_id\": 45, \"mechanic_id\": 45}',NULL),(54,146,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 146, \"status\": \"Pending\", \"end_date\": null, \"start_date\": \"2023-01-19\", \"vehicle_id\": 46, \"mechanic_id\": 46}',NULL),(55,147,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 147, \"status\": \"In Progress\", \"end_date\": null, \"start_date\": \"2023-01-20\", \"vehicle_id\": 47, \"mechanic_id\": 47}',NULL),(56,148,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 148, \"status\": \"Completed\", \"end_date\": \"2023-01-22\", \"start_date\": \"2023-01-21\", \"vehicle_id\": 48, \"mechanic_id\": 48}',NULL),(57,149,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 149, \"status\": \"Pending\", \"end_date\": null, \"start_date\": \"2023-01-22\", \"vehicle_id\": 49, \"mechanic_id\": 49}',NULL),(58,150,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 150, \"status\": \"In Progress\", \"end_date\": null, \"start_date\": \"2023-01-23\", \"vehicle_id\": 50, \"mechanic_id\": 50}',NULL),(59,151,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 151, \"status\": \"Completed\", \"end_date\": \"2023-01-25\", \"start_date\": \"2023-01-24\", \"vehicle_id\": 51, \"mechanic_id\": 51}',NULL),(60,152,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 152, \"status\": \"Pending\", \"end_date\": null, \"start_date\": \"2023-01-25\", \"vehicle_id\": 52, \"mechanic_id\": 52}',NULL),(61,153,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 153, \"status\": \"In Progress\", \"end_date\": null, \"start_date\": \"2023-01-26\", \"vehicle_id\": 53, \"mechanic_id\": 53}',NULL),(62,154,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 154, \"status\": \"Completed\", \"end_date\": \"2023-01-28\", \"start_date\": \"2023-01-27\", \"vehicle_id\": 54, \"mechanic_id\": 54}',NULL),(63,155,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 155, \"status\": \"Pending\", \"end_date\": null, \"start_date\": \"2023-01-28\", \"vehicle_id\": 55, \"mechanic_id\": 55}',NULL),(64,156,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 156, \"status\": \"In Progress\", \"end_date\": null, \"start_date\": \"2023-01-01\", \"vehicle_id\": 56, \"mechanic_id\": 56}',NULL),(65,157,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 157, \"status\": \"Completed\", \"end_date\": \"2023-01-03\", \"start_date\": \"2023-01-02\", \"vehicle_id\": 57, \"mechanic_id\": 57}',NULL),(66,158,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 158, \"status\": \"Pending\", \"end_date\": null, \"start_date\": \"2023-01-03\", \"vehicle_id\": 58, \"mechanic_id\": 58}',NULL),(67,159,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 159, \"status\": \"In Progress\", \"end_date\": null, \"start_date\": \"2023-01-04\", \"vehicle_id\": 59, \"mechanic_id\": 59}',NULL),(68,160,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 160, \"status\": \"Completed\", \"end_date\": \"2023-01-06\", \"start_date\": \"2023-01-05\", \"vehicle_id\": 60, \"mechanic_id\": 60}',NULL),(69,161,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 161, \"status\": \"Pending\", \"end_date\": null, \"start_date\": \"2023-01-06\", \"vehicle_id\": 61, \"mechanic_id\": 61}',NULL),(70,162,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 162, \"status\": \"In Progress\", \"end_date\": null, \"start_date\": \"2023-01-07\", \"vehicle_id\": 62, \"mechanic_id\": 62}',NULL),(71,163,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 163, \"status\": \"Completed\", \"end_date\": \"2023-01-09\", \"start_date\": \"2023-01-08\", \"vehicle_id\": 63, \"mechanic_id\": 63}',NULL),(72,164,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 164, \"status\": \"Pending\", \"end_date\": null, \"start_date\": \"2023-01-09\", \"vehicle_id\": 64, \"mechanic_id\": 64}',NULL),(73,165,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 165, \"status\": \"In Progress\", \"end_date\": null, \"start_date\": \"2023-01-10\", \"vehicle_id\": 65, \"mechanic_id\": 65}',NULL),(74,166,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 166, \"status\": \"Completed\", \"end_date\": \"2023-01-12\", \"start_date\": \"2023-01-11\", \"vehicle_id\": 66, \"mechanic_id\": 66}',NULL),(75,167,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 167, \"status\": \"Pending\", \"end_date\": null, \"start_date\": \"2023-01-12\", \"vehicle_id\": 67, \"mechanic_id\": 67}',NULL),(76,168,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 168, \"status\": \"In Progress\", \"end_date\": null, \"start_date\": \"2023-01-13\", \"vehicle_id\": 68, \"mechanic_id\": 68}',NULL),(77,169,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 169, \"status\": \"Completed\", \"end_date\": \"2023-01-15\", \"start_date\": \"2023-01-14\", \"vehicle_id\": 69, \"mechanic_id\": 69}',NULL),(78,170,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 170, \"status\": \"Pending\", \"end_date\": null, \"start_date\": \"2023-01-15\", \"vehicle_id\": 70, \"mechanic_id\": 70}',NULL),(79,171,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 171, \"status\": \"In Progress\", \"end_date\": null, \"start_date\": \"2023-01-16\", \"vehicle_id\": 71, \"mechanic_id\": 71}',NULL),(80,172,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 172, \"status\": \"Completed\", \"end_date\": \"2023-01-18\", \"start_date\": \"2023-01-17\", \"vehicle_id\": 72, \"mechanic_id\": 72}',NULL),(81,173,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 173, \"status\": \"Pending\", \"end_date\": null, \"start_date\": \"2023-01-18\", \"vehicle_id\": 73, \"mechanic_id\": 73}',NULL),(82,174,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 174, \"status\": \"In Progress\", \"end_date\": null, \"start_date\": \"2023-01-19\", \"vehicle_id\": 74, \"mechanic_id\": 74}',NULL),(83,175,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 175, \"status\": \"Completed\", \"end_date\": \"2023-01-21\", \"start_date\": \"2023-01-20\", \"vehicle_id\": 75, \"mechanic_id\": 75}',NULL),(84,176,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 176, \"status\": \"Pending\", \"end_date\": null, \"start_date\": \"2023-01-21\", \"vehicle_id\": 76, \"mechanic_id\": 76}',NULL),(85,177,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 177, \"status\": \"In Progress\", \"end_date\": null, \"start_date\": \"2023-01-22\", \"vehicle_id\": 77, \"mechanic_id\": 77}',NULL),(86,178,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 178, \"status\": \"Completed\", \"end_date\": \"2023-01-24\", \"start_date\": \"2023-01-23\", \"vehicle_id\": 78, \"mechanic_id\": 78}',NULL),(87,179,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 179, \"status\": \"Pending\", \"end_date\": null, \"start_date\": \"2023-01-24\", \"vehicle_id\": 79, \"mechanic_id\": 79}',NULL),(88,180,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 180, \"status\": \"In Progress\", \"end_date\": null, \"start_date\": \"2023-01-25\", \"vehicle_id\": 80, \"mechanic_id\": 80}',NULL),(89,181,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 181, \"status\": \"Completed\", \"end_date\": \"2023-01-27\", \"start_date\": \"2023-01-26\", \"vehicle_id\": 81, \"mechanic_id\": 81}',NULL),(90,182,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 182, \"status\": \"Pending\", \"end_date\": null, \"start_date\": \"2023-01-27\", \"vehicle_id\": 82, \"mechanic_id\": 82}',NULL),(91,183,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 183, \"status\": \"In Progress\", \"end_date\": null, \"start_date\": \"2023-01-28\", \"vehicle_id\": 83, \"mechanic_id\": 83}',NULL),(92,184,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 184, \"status\": \"Completed\", \"end_date\": \"2023-01-02\", \"start_date\": \"2023-01-01\", \"vehicle_id\": 84, \"mechanic_id\": 84}',NULL),(93,185,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 185, \"status\": \"Pending\", \"end_date\": null, \"start_date\": \"2023-01-02\", \"vehicle_id\": 85, \"mechanic_id\": 85}',NULL),(94,186,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 186, \"status\": \"In Progress\", \"end_date\": null, \"start_date\": \"2023-01-03\", \"vehicle_id\": 86, \"mechanic_id\": 86}',NULL),(95,187,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 187, \"status\": \"Completed\", \"end_date\": \"2023-01-05\", \"start_date\": \"2023-01-04\", \"vehicle_id\": 87, \"mechanic_id\": 87}',NULL),(96,188,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 188, \"status\": \"Pending\", \"end_date\": null, \"start_date\": \"2023-01-05\", \"vehicle_id\": 88, \"mechanic_id\": 88}',NULL),(97,189,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 189, \"status\": \"In Progress\", \"end_date\": null, \"start_date\": \"2023-01-06\", \"vehicle_id\": 89, \"mechanic_id\": 89}',NULL),(98,190,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 190, \"status\": \"Completed\", \"end_date\": \"2023-01-08\", \"start_date\": \"2023-01-07\", \"vehicle_id\": 90, \"mechanic_id\": 90}',NULL),(99,191,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 191, \"status\": \"Pending\", \"end_date\": null, \"start_date\": \"2023-01-08\", \"vehicle_id\": 91, \"mechanic_id\": 91}',NULL),(100,192,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 192, \"status\": \"In Progress\", \"end_date\": null, \"start_date\": \"2023-01-09\", \"vehicle_id\": 92, \"mechanic_id\": 92}',NULL),(101,193,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 193, \"status\": \"Completed\", \"end_date\": \"2023-01-11\", \"start_date\": \"2023-01-10\", \"vehicle_id\": 93, \"mechanic_id\": 93}',NULL),(102,194,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 194, \"status\": \"Pending\", \"end_date\": null, \"start_date\": \"2023-01-11\", \"vehicle_id\": 94, \"mechanic_id\": 94}',NULL),(103,195,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 195, \"status\": \"In Progress\", \"end_date\": null, \"start_date\": \"2023-01-12\", \"vehicle_id\": 95, \"mechanic_id\": 95}',NULL),(104,196,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 196, \"status\": \"Completed\", \"end_date\": \"2023-01-14\", \"start_date\": \"2023-01-13\", \"vehicle_id\": 96, \"mechanic_id\": 96}',NULL),(105,197,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 197, \"status\": \"Pending\", \"end_date\": null, \"start_date\": \"2023-01-14\", \"vehicle_id\": 97, \"mechanic_id\": 97}',NULL),(106,198,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 198, \"status\": \"In Progress\", \"end_date\": null, \"start_date\": \"2023-01-15\", \"vehicle_id\": 98, \"mechanic_id\": 98}',NULL),(107,199,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 199, \"status\": \"Finalizada\", \"end_date\": \"2023-01-17\", \"start_date\": \"2023-01-16\", \"vehicle_id\": 99, \"mechanic_id\": 99}',NULL),(108,200,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 200, \"status\": \"Finalizada\", \"end_date\": \"2026-05-30\", \"start_date\": \"2023-01-17\", \"vehicle_id\": 100, \"mechanic_id\": 100}',NULL),(109,201,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 201, \"status\": \"Finalizada\", \"end_date\": \"2026-06-01\", \"start_date\": \"2026-06-01\", \"vehicle_id\": 118, \"mechanic_id\": 2}',NULL),(110,202,'DELETE','2026-06-02 22:58:49',NULL,'{\"id\": 202, \"status\": \"Finalizada\", \"end_date\": \"2026-06-01\", \"start_date\": \"2026-06-01\", \"vehicle_id\": 120, \"mechanic_id\": 4}',NULL),(111,203,'INSERT','2026-06-04 00:23:11',NULL,NULL,'{\"id\": 203, \"status\": \"Diagnóstico\", \"end_date\": null, \"start_date\": \"2026-06-03\", \"vehicle_id\": 115, \"mechanic_id\": 101}'),(112,203,'UPDATE','2026-06-04 00:33:08',NULL,'{\"id\": 203, \"status\": \"Diagnóstico\", \"end_date\": null, \"start_date\": \"2026-06-03\", \"vehicle_id\": 115, \"mechanic_id\": 101}','{\"id\": 203, \"status\": \"Finalizada\", \"end_date\": \"2026-06-03\", \"start_date\": \"2026-06-03\", \"vehicle_id\": 115, \"mechanic_id\": 101}'),(113,204,'INSERT','2026-06-04 00:38:26',NULL,NULL,'{\"id\": 204, \"status\": \"Diagnóstico\", \"end_date\": null, \"start_date\": \"2026-06-03\", \"vehicle_id\": 123, \"mechanic_id\": 110}'),(114,204,'UPDATE','2026-06-04 00:38:37',NULL,'{\"id\": 204, \"status\": \"Diagnóstico\", \"end_date\": null, \"start_date\": \"2026-06-03\", \"vehicle_id\": 123, \"mechanic_id\": 110}','{\"id\": 204, \"status\": \"Reparación\", \"end_date\": null, \"start_date\": \"2026-06-03\", \"vehicle_id\": 123, \"mechanic_id\": 110}'),(115,205,'INSERT','2026-06-04 14:32:43',NULL,NULL,'{\"id\": 205, \"status\": \"Diagnóstico\", \"end_date\": null, \"start_date\": \"2026-06-04\", \"vehicle_id\": 123, \"mechanic_id\": 102}');
/*!40000 ALTER TABLE `workorders_audit` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`wenm`@`%`*/ /*!50003 TRIGGER `bii_workorders_audit_guard_insert` BEFORE INSERT ON `workorders_audit` FOR EACH ROW BEGIN

  IF COALESCE(@from_workorders_trigger, 0) <> 1 THEN

    SIGNAL SQLSTATE '45000'

    SET MESSAGE_TEXT = 'INSERT en workorders_audit solo permitido desde triggers de workorders.';

  END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`wenm`@`%`*/ /*!50003 TRIGGER `biu_workorders_audit_block_update` BEFORE UPDATE ON `workorders_audit` FOR EACH ROW BEGIN

  SIGNAL SQLSTATE '45000'

  SET MESSAGE_TEXT = 'workorders_audit es inmutable: UPDATE prohibido.';

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`wenm`@`%`*/ /*!50003 TRIGGER `bid_workorders_audit_block_delete` BEFORE DELETE ON `workorders_audit` FOR EACH ROW BEGIN

  SIGNAL SQLSTATE '45000'

  SET MESSAGE_TEXT = 'workorders_audit es inmutable: DELETE prohibido.';

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `workorderservices`
--

DROP TABLE IF EXISTS `workorderservices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `workorderservices` (
  `workorder_id` int NOT NULL,
  `service_id` int NOT NULL,
  KEY `WorkOrderService_WorkOrder_FK` (`workorder_id`),
  KEY `WorkOrderService_Service_FK` (`service_id`),
  CONSTRAINT `WorkOrderService_Service_FK` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`),
  CONSTRAINT `WorkOrderService_WorkOrder_FK` FOREIGN KEY (`workorder_id`) REFERENCES `workorders` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workorderservices`
--

LOCK TABLES `workorderservices` WRITE;
/*!40000 ALTER TABLE `workorderservices` DISABLE KEYS */;
INSERT INTO `workorderservices` VALUES (203,122),(204,122),(205,122);
/*!40000 ALTER TABLE `workorderservices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workporderspareparts`
--

DROP TABLE IF EXISTS `workporderspareparts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `workporderspareparts` (
  `workorder_id` int DEFAULT NULL,
  `sparepart_id` int DEFAULT NULL,
  `quantity` int NOT NULL,
  KEY `WorkOrderSparePart_WorkOrder_FK` (`workorder_id`),
  KEY `WorkOrderSparePart_SparePart_FK` (`sparepart_id`),
  CONSTRAINT `WorkOrderSparePart_SparePart_FK` FOREIGN KEY (`sparepart_id`) REFERENCES `spareparts` (`id`),
  CONSTRAINT `WorkOrderSparePart_WorkOrder_FK` FOREIGN KEY (`workorder_id`) REFERENCES `workorders` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workporderspareparts`
--

LOCK TABLES `workporderspareparts` WRITE;
/*!40000 ALTER TABLE `workporderspareparts` DISABLE KEYS */;
/*!40000 ALTER TABLE `workporderspareparts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'automotrix'
--

--
-- Dumping routines for database 'automotrix'
--
/*!50003 DROP PROCEDURE IF EXISTS `Costumer_mail` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`wenm`@`%` PROCEDURE `Costumer_mail`()
BEGIN

    SELECT *

    FROM `customers` AS C

    WHERE C.email LIKE CONCAT('%','mail','%');

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Customers_ini` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`wenm`@`%` PROCEDURE `Customers_ini`(IN ini CHAR(1))
BEGIN

    SELECT *

    FROM `customers` AS C

    WHERE C.email LIKE CONCAT(ini, '%');

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Customer_mail` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`wenm`@`%` PROCEDURE `Customer_mail`()
BEGIN

    SELECT *

    FROM customers AS C

    WHERE C.email LIKE '%mail%';

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `WorkOrders_DateJoin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`wenm`@`%` PROCEDURE `WorkOrders_DateJoin`(IN workDate DATE)
BEGIN

    SELECT 

        m.first_name, 

        w.*

    FROM `mechanics` AS m

    JOIN `workorders` AS w ON m.id = w.mechanic_id

    WHERE DATE(w.start_date) = workDate;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `WorkOrders_DateWhere` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`wenm`@`%` PROCEDURE `WorkOrders_DateWhere`(IN workDate DATE)
BEGIN

    SELECT 

        m.first_name, 

        w.*

    FROM `mechanics` AS m

    JOIN `workorders` AS w ON m.id = w.mechanic_id

    WHERE DATE(w.start_date) = workDate;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `WorkOrders_Joinrange` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`wenm`@`%` PROCEDURE `WorkOrders_Joinrange`(

    IN startDate DATE,

    IN endDate DATE

)
BEGIN

    SELECT 

        C.first_name AS customer_name,

        V.license_plate,

        W.id AS workorder_id,

        W.start_date,

        W.end_date,

        M.first_name AS mechanic_name,

        M.last_name AS mechanic_lastname

    FROM `customers` AS C

    JOIN `vehicles` AS V ON C.id = V.customer_id

    JOIN `workorders` AS W ON V.id = W.vehicle_id

    JOIN `mechanics` AS M ON M.id = W.mechanic_id

    WHERE W.start_date BETWEEN startDate AND endDate;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `WorkOrders_Range` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`wenm`@`%` PROCEDURE `WorkOrders_Range`(

    IN startDate DATE,

    IN endDate DATE

)
BEGIN

    SELECT 

        C.*, 

        V.*, 

        W.*, 

        M.*

    FROM `customers` AS C

    JOIN `vehicles` AS V ON C.id = V.customer_id

    JOIN `workorders` AS W ON V.id = W.vehicle_id

    JOIN `mechanics` AS M ON M.id = W.mechanic_id

    WHERE W.start_date BETWEEN startDate AND endDate

    ORDER BY W.start_date ASC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-04 19:03:06
