-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: studentsphere
-- ------------------------------------------------------
-- Server version	8.0.35

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
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `admin_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(10) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`admin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (1,'test','115dc3606fbf8691fb69f2aefec86f2ecd302362a0502b3a9648bf2c4dc8290f');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alumni`
--

DROP TABLE IF EXISTS `alumni`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alumni` (
  `alumni_id` int NOT NULL AUTO_INCREMENT,
  `alumni_name` varchar(255) DEFAULT NULL,
  `degree` varchar(255) DEFAULT NULL,
  `graduation_year` int DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`alumni_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alumni`
--

LOCK TABLES `alumni` WRITE;
/*!40000 ALTER TABLE `alumni` DISABLE KEYS */;
INSERT INTO `alumni` VALUES (1,'Asif Khan','CS',2010,'Distinguished alumni with a degree in Computer Science.'),(2,'Abdul Rehman','CS',2012,'Exemplary graduate in Computer Science, contributing to software development.'),(3,'Rubina Amir','AI',2015,'AI enthusiast holding a degree in Artificial Intelligence, making strides in machine learning.'),(4,'Ayesha Khan','AI',2018,'Innovative alumni specializing in AI and machine learning, with a Ph.D. in advanced algorithms and data-driven decision-making.');
/*!40000 ALTER TABLE `alumni` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alumnidates`
--

DROP TABLE IF EXISTS `alumnidates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alumnidates` (
  `alumni_id` int NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `student_id` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`alumni_id`,`date`,`time`),
  KEY `student_id` (`student_id`),
  CONSTRAINT `alumnidates_ibfk_1` FOREIGN KEY (`alumni_id`) REFERENCES `alumni` (`alumni_id`),
  CONSTRAINT `alumnidates_student_fk` FOREIGN KEY (`student_id`) REFERENCES `student_details` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alumnidates`
--

LOCK TABLES `alumnidates` WRITE;
/*!40000 ALTER TABLE `alumnidates` DISABLE KEYS */;
INSERT INTO `alumnidates` VALUES (1,'2023-02-15','14:30:00','Booked',NULL),(1,'2023-03-20','09:45:00','Not Booked',NULL),(1,'2023-05-10','10:00:00','Not Booked',NULL),(2,'2023-01-03','15:30:00','Not Booked',NULL),(2,'2023-02-18','11:45:00','Not Booked',NULL),(2,'2023-03-25','14:00:00','Not Booked',NULL),(2,'2023-04-10','16:30:00','Not Booked',NULL),(3,'2023-01-05','10:45:00','Not Booked',NULL),(3,'2023-02-20','13:15:00','Not Booked',NULL),(3,'2023-03-28','16:30:00','Not Booked',NULL),(3,'2023-04-15','09:00:00','Not Booked',NULL),(3,'2023-05-20','11:45:00','Not Booked',NULL),(4,'2023-01-08','11:00:00','Not Booked',NULL),(4,'2023-02-22','16:45:00','Not Booked',NULL),(4,'2023-03-30','10:15:00','Not Booked',NULL),(4,'2023-04-20','13:30:00','Not Booked',NULL),(4,'2023-05-25','15:45:00','Not Booked',NULL);
/*!40000 ALTER TABLE `alumnidates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attendances`
--

DROP TABLE IF EXISTS `attendances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attendances` (
  `enroll_id` int NOT NULL,
  `dates` date NOT NULL,
  `status` varchar(7) NOT NULL,
  PRIMARY KEY (`enroll_id`,`dates`),
  CONSTRAINT `attendance_student_fk` FOREIGN KEY (`enroll_id`) REFERENCES `enrollment` (`enroll_id`) ON DELETE CASCADE,
  CONSTRAINT `attendances_ibfk_1` FOREIGN KEY (`enroll_id`) REFERENCES `enrollment` (`enroll_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendances`
--

LOCK TABLES `attendances` WRITE;
/*!40000 ALTER TABLE `attendances` DISABLE KEYS */;
INSERT INTO `attendances` VALUES (7,'2023-12-01','Absent'),(7,'2023-12-05','Present'),(8,'2023-12-01','Present'),(8,'2023-12-05','Absent'),(9,'2023-12-01','Present'),(9,'2023-12-05','Present'),(10,'2023-12-01','Present'),(10,'2023-12-05','Present'),(11,'2023-12-05','Present'),(12,'2023-12-05','Present'),(13,'2023-12-05','Present'),(17,'2023-12-01','Present'),(17,'2023-12-04','Present'),(18,'2023-12-01','Present'),(18,'2023-12-04','Absent'),(19,'2023-12-01','Present'),(19,'2023-12-04','Absent'),(20,'2023-12-01','Present'),(20,'2023-12-04','Present');
/*!40000 ALTER TABLE `attendances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `available_dates_alumni_view`
--

DROP TABLE IF EXISTS `available_dates_alumni_view`;
/*!50001 DROP VIEW IF EXISTS `available_dates_alumni_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `available_dates_alumni_view` AS SELECT 
 1 AS `alumni_id`,
 1 AS `date`,
 1 AS `time`,
 1 AS `status`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `courses` (
  `courseid` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `coursename` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`courseid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
INSERT INTO `courses` VALUES ('AI2002','Artificial Intelligence'),('CL2005','Database Systems Lab'),('CS1004','OOP'),('CS2005','Database Systems'),('CS211','Discrete Structures'),('CS218','Data Structures'),('CS3001','Computer Networks'),('CS4048','Data Science'),('MT119','Calculus and Analytical Geometry'),('MT3001','Graph Theory');
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enrollment`
--

DROP TABLE IF EXISTS `enrollment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enrollment` (
  `enroll_id` int NOT NULL AUTO_INCREMENT,
  `student_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `course_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `teacher_id` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `section` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `admin_id` int DEFAULT NULL,
  PRIMARY KEY (`enroll_id`),
  KEY `student_enroll` (`student_id`),
  KEY `course_enroll` (`course_id`),
  KEY `teacher_enroll` (`teacher_id`),
  KEY `section_enroll` (`section`),
  KEY `admin_enroll` (`admin_id`),
  CONSTRAINT `admin_enroll` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`admin_id`),
  CONSTRAINT `course_enroll` FOREIGN KEY (`course_id`) REFERENCES `courses` (`courseid`) ON DELETE CASCADE,
  CONSTRAINT `enroll_student_fk` FOREIGN KEY (`student_id`) REFERENCES `student_details` (`id`) ON DELETE CASCADE,
  CONSTRAINT `section_enroll` FOREIGN KEY (`section`) REFERENCES `section` (`section_id`),
  CONSTRAINT `student_enroll` FOREIGN KEY (`student_id`) REFERENCES `student_details` (`id`),
  CONSTRAINT `teacher_enroll` FOREIGN KEY (`teacher_id`) REFERENCES `teacher_details` (`teacher_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enrollment`
--

LOCK TABLES `enrollment` WRITE;
/*!40000 ALTER TABLE `enrollment` DISABLE KEYS */;
INSERT INTO `enrollment` VALUES (7,'21k-3222','CS2005','CS01','5G',NULL),(8,'21k-3223','CS2005','CS01','5G',NULL),(9,'21k-3225','CS2005','CS01','5G',NULL),(10,'21k-3227','CS2005','CS01','5G',NULL),(11,'21k-3224','CS2005','CS01','5B',NULL),(12,'21k-3226','CS2005','CS01','5B',NULL),(13,'21k-3228','CS2005','CS01','5B',NULL),(14,'21k-3224','MT3001','MT01','5B',NULL),(15,'21k-3226','MT3001','MT01','5B',NULL),(16,'21k-3228','MT3001','MT01','5B',NULL),(17,'21k-3222','MT3001','MT02','5G',NULL),(18,'21k-3223','MT3001','MT02','5G',NULL),(19,'21k-3225','MT3001','MT02','5G',NULL),(20,'21k-3227','MT3001','MT02','5G',NULL);
/*!40000 ALTER TABLE `enrollment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `marks`
--

DROP TABLE IF EXISTS `marks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `marks` (
  `marks_id` int NOT NULL AUTO_INCREMENT,
  `enroll_id` int NOT NULL,
  `weightage` float NOT NULL,
  `obtained_marks` float DEFAULT NULL,
  `total_marks` float NOT NULL,
  `main_label` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `label_index` int NOT NULL,
  PRIMARY KEY (`marks_id`),
  KEY `marks_enroll` (`enroll_id`),
  CONSTRAINT `marks_student_fk` FOREIGN KEY (`enroll_id`) REFERENCES `enrollment` (`enroll_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marks`
--

LOCK TABLES `marks` WRITE;
/*!40000 ALTER TABLE `marks` DISABLE KEYS */;
INSERT INTO `marks` VALUES (41,7,5,20,20,'Assignment',1),(42,8,5,20,20,'Assignment',1),(43,9,5,19,20,'Assignment',1),(44,10,5,15,20,'Assignment',1),(45,8,5,20,20,'Assignment',2),(46,7,5,20,20,'Assignment',2),(47,9,5,20,20,'Assignment',2),(48,10,5,10,20,'Assignment',2),(49,7,5,20,20,'Assignment',3),(50,9,5,15,20,'Assignment',3),(51,8,5,20,20,'Assignment',3),(52,10,5,19,20,'Assignment',3),(53,17,3,5,5,'Mid-I',1),(54,19,3,2,5,'Mid-I',1),(55,20,3,1,5,'Mid-I',1),(56,18,3,5,5,'Mid-I',1),(57,17,8,15,15,'Mid-I',2),(58,18,8,12,15,'Mid-I',2),(59,19,8,10,15,'Mid-I',2),(60,20,8,11,15,'Mid-I',2),(61,18,4,8,8,'Mid-I',3),(62,17,4,7,8,'Mid-I',3),(63,20,4,8,8,'Mid-I',3),(64,19,4,8,8,'Mid-I',3),(65,8,2,4,5,'Quiz',1),(66,10,2,3,5,'Quiz',1),(67,9,2,2,5,'Quiz',1),(68,7,2,5,5,'Quiz',1);
/*!40000 ALTER TABLE `marks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parent_details`
--

DROP TABLE IF EXISTS `parent_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `parent_details` (
  `pid` int NOT NULL AUTO_INCREMENT,
  `sid` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `parent_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `relation` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `parent_phone` varchar(13) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`pid`),
  KEY `parent_student` (`sid`),
  CONSTRAINT `parent_student_fk` FOREIGN KEY (`sid`) REFERENCES `student_details` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parent_details`
--

LOCK TABLES `parent_details` WRITE;
/*!40000 ALTER TABLE `parent_details` DISABLE KEYS */;
INSERT INTO `parent_details` VALUES (1,'21k-3222','Palh','Grandparent','0333-1563986'),(2,'21k-3223','Ali Khan','Father','+1234567890'),(3,'21k-3224','Fatima Ahmed','Mother','+9876543210'),(4,'21k-3225','Imran Hassan','Father','+1112223333'),(5,'21k-3226','Ayesha Raza','Mother','+4445556666'),(6,'21k-3227','Tariq Malik','Father','+7778889999'),(7,'21k-3228','Saima Ali','Mother','+1011121314'),(8,'21k-4568','Farhan Khan','Brother','+1516171819');
/*!40000 ALTER TABLE `parent_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `section`
--

DROP TABLE IF EXISTS `section`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `section` (
  `section_id` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `semester` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `section` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`section_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `section`
--

LOCK TABLES `section` WRITE;
/*!40000 ALTER TABLE `section` DISABLE KEYS */;
INSERT INTO `section` VALUES ('1L','1','L'),('2F','2','F'),('3H','3','H'),('4E','4','E'),('5B','5','B'),('5G','5','G'),('6A','6','A'),('7D','7','D'),('8B','8','B');
/*!40000 ALTER TABLE `section` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_details`
--

DROP TABLE IF EXISTS `student_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_details` (
  `id` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `first_name` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `last_name` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `section` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `degree` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `campus` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `status` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `gender` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `dob` date NOT NULL,
  `email` varchar(70) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `nationality` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `phone` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `hashed_password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `student_section` (`section`),
  CONSTRAINT `student_section` FOREIGN KEY (`section`) REFERENCES `section` (`section_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_details`
--

LOCK TABLES `student_details` WRITE;
/*!40000 ALTER TABLE `student_details` DISABLE KEYS */;
INSERT INTO `student_details` VALUES ('21k-3222','Mubeen','Palh','5G','BSCS','Karachi','Current','Male','2003-11-12','mubeenpaul@gmail.com','Pakistani','0333-2222222','2cf24dba5fb0a30e26e83b2ac5b9e29e1b161e5c1fa7425e73043362938b9824'),('21k-3223','Alice','Smith','5G','BSCS','Karachi','Current','Female','2002-09-25','alicesmith@gmail.com','Pakistani','0333-2222222','2cf24dba5fb0a30e26e83b2ac5b9e29e1b161e5c1fa7425e73043362938b9824'),('21k-3224','Bob','Johnson','5B','BSCS','Karachi','Current','Male','2001-03-18','bobjohnson@gmail.com','Pakistani','0333-2222222','2cf24dba5fb0a30e26e83b2ac5b9e29e1b161e5c1fa7425e73043362938b9824'),('21k-3225','Eva','Williams','5G','BSCS','Karachi','Current','Female','2000-07-09','evawilliams@gmail.com','Pakistani','0333-2222222','2cf24dba5fb0a30e26e83b2ac5b9e29e1b161e5c1fa7425e73043362938b9824'),('21k-3226','Michael','Davis','5B','BSCS','Karachi','Current','Male','1999-12-30','michaeldavis@gmail.com','Pakistani','0333-2222222','2cf24dba5fb0a30e26e83b2ac5b9e29e1b161e5c1fa7425e73043362938b9824'),('21k-3227','Sara','Miller','5G','BSCS','Karachi','Current','Female','1998-06-22','saramiller@gmail.com','Pakistani','0333-2222222','2cf24dba5fb0a30e26e83b2ac5b9e29e1b161e5c1fa7425e73043362938b9824'),('21k-3228','David','Brown','5B','BSCS','Karachi','Current','Male','1997-01-15','davidbrown@gmail.com','Pakistani','0333-2222222','2cf24dba5fb0a30e26e83b2ac5b9e29e1b161e5c1fa7425e73043362938b9824'),('21k-4568','Imran','Amir','1L','BSCS','Main Campus','Current','Male','2000-05-15','imran@gmail.com','US','+1234567890','115dc3606fbf8691fb69f2aefec86f2ecd302362a0502b3a9648bf2c4dc8290f');
/*!40000 ALTER TABLE `student_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teacher_details`
--

DROP TABLE IF EXISTS `teacher_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teacher_details` (
  `teacher_id` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `first_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `last_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `hashed_password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phoneNumber` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `registerNumber` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `dateOfBirth` date DEFAULT NULL,
  `degree` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `specialization` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `yearsOfExperience` int DEFAULT NULL,
  `age` int DEFAULT NULL,
  `Department` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`teacher_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacher_details`
--

LOCK TABLES `teacher_details` WRITE;
/*!40000 ALTER TABLE `teacher_details` DISABLE KEYS */;
INSERT INTO `teacher_details` VALUES ('CS01','Amir','Sohail','2cf24dba5fb0a30e26e83b2ac5b9e29e1b161e5c1fa7425e73043362938b9824','+92384572548','North Karachi','amir.sohail@gmail.com','2024-ABCD-8789653','1983-12-01','P.H.D','CS',20,40,'CS'),('CS02','Moin','Khan','2cf24dba5fb0a30e26e83b2ac5b9e29e1b161e5c1fa7425e73043362938b9824','+92383532323','Defence','Moinkhan@gmail.com','2024-ABCD-7865325','1986-04-12','Masters','CS',12,37,'CS'),('MT01','Misbah','Khan','2cf24dba5fb0a30e26e83b2ac5b9e29e1b161e5c1fa7425e73043362938b9824','+92389653526','Gulshan E Iqbal','Misbah.Khan@gmail.com','2024-ABCD-875642','1993-05-08','PHD','Engineering',12,30,'EE'),('MT02','Shoaib','Ali','2cf24dba5fb0a30e26e83b2ac5b9e29e1b161e5c1fa7425e73043362938b9824','+923312345','block21, fbarea, Karachi','shoaibali@gmail.com','2024-ABCD-12356','1983-05-02','PHD','Space Engineering',18,40,'EE');
/*!40000 ALTER TABLE `teacher_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trigger_log`
--

DROP TABLE IF EXISTS `trigger_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trigger_log` (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `error_message` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `trigger_of` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trigger_log`
--

LOCK TABLES `trigger_log` WRITE;
/*!40000 ALTER TABLE `trigger_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `trigger_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `available_dates_alumni_view`
--

/*!50001 DROP VIEW IF EXISTS `available_dates_alumni_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `available_dates_alumni_view` AS select `alumnidates`.`alumni_id` AS `alumni_id`,`alumnidates`.`date` AS `date`,`alumnidates`.`time` AS `time`,`alumnidates`.`status` AS `status` from `alumnidates` where (`alumnidates`.`status` = 'Not Booked') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-07  6:38:53
