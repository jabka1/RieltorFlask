-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: rieltoronline
-- ------------------------------------------------------
-- Server version	8.0.37

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
-- Table structure for table `apartment_images`
--

DROP TABLE IF EXISTS `apartment_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `apartment_images` (
  `ImageID` int NOT NULL AUTO_INCREMENT,
  `ApartmentID` int DEFAULT NULL,
  `ImageURL` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ImageID`),
  KEY `ApartmentID` (`ApartmentID`),
  CONSTRAINT `apartment_images_ibfk_1` FOREIGN KEY (`ApartmentID`) REFERENCES `apartments` (`ApartmentID`)
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `apartmentcomments`
--

DROP TABLE IF EXISTS `apartmentcomments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `apartmentcomments` (
  `CommentID` int NOT NULL AUTO_INCREMENT,
  `UserID` int NOT NULL,
  `ApartmentID` int NOT NULL,
  `Content` text NOT NULL,
  `Rating` int DEFAULT NULL,
  `DateAdded` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`CommentID`),
  KEY `UserID` (`UserID`),
  KEY `ApartmentID` (`ApartmentID`),
  CONSTRAINT `apartmentcomments_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`) ON DELETE CASCADE,
  CONSTRAINT `apartmentcomments_ibfk_2` FOREIGN KEY (`ApartmentID`) REFERENCES `apartments` (`ApartmentID`) ON DELETE CASCADE,
  CONSTRAINT `apartmentcomments_chk_1` CHECK (((`Rating` >= 1) and (`Rating` <= 5)))
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `apartments`
--

DROP TABLE IF EXISTS `apartments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `apartments` (
  `ApartmentID` int NOT NULL AUTO_INCREMENT,
  `OwnerID` int NOT NULL,
  `Type` enum('Квартира','Приватний будинок') DEFAULT NULL,
  `City` varchar(255) NOT NULL,
  `Street` varchar(255) NOT NULL,
  `HouseNum` varchar(20) NOT NULL,
  `FlatNum` varchar(20) DEFAULT NULL,
  `Price` decimal(10,2) NOT NULL,
  `RoomCount` int NOT NULL,
  `Description` text,
  `Comfort` text,
  `Infrastructure` text,
  `Renovation` text,
  `Appliances` text,
  `MaxResidents` int NOT NULL,
  `CurrentResidents` int DEFAULT NULL,
  `IsRented` enum('вільна','зайнята','відкрита для співмешканців') NOT NULL,
  `CreationDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `LastUpdated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `FavoriteCount` int DEFAULT '0',
  PRIMARY KEY (`ApartmentID`),
  KEY `OwnerID` (`OwnerID`),
  CONSTRAINT `apartments_ibfk_1` FOREIGN KEY (`OwnerID`) REFERENCES `users` (`UserID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `favorites`
--

DROP TABLE IF EXISTS `favorites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favorites` (
  `FavoriteID` int NOT NULL AUTO_INCREMENT,
  `UserID` int NOT NULL,
  `ApartmentID` int NOT NULL,
  PRIMARY KEY (`FavoriteID`),
  KEY `UserID` (`UserID`),
  KEY `ApartmentID` (`ApartmentID`),
  CONSTRAINT `favorites_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`) ON DELETE CASCADE,
  CONSTRAINT `favorites_ibfk_2` FOREIGN KEY (`ApartmentID`) REFERENCES `apartments` (`ApartmentID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `roommates`
--

DROP TABLE IF EXISTS `roommates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roommates` (
  `RoommateID` int NOT NULL AUTO_INCREMENT,
  `UserID` int NOT NULL,
  `ApartmentID` int NOT NULL,
  PRIMARY KEY (`RoommateID`),
  KEY `UserID` (`UserID`),
  KEY `ApartmentID` (`ApartmentID`),
  CONSTRAINT `roommates_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`) ON DELETE CASCADE,
  CONSTRAINT `roommates_ibfk_2` FOREIGN KEY (`ApartmentID`) REFERENCES `apartments` (`ApartmentID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usercomments`
--

DROP TABLE IF EXISTS `usercomments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usercomments` (
  `CommentID` int NOT NULL AUTO_INCREMENT,
  `AuthorID` int NOT NULL,
  `TargetUserID` int NOT NULL,
  `Content` text NOT NULL,
  `Rating` int DEFAULT NULL,
  `DateAdded` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`CommentID`),
  KEY `AuthorID` (`AuthorID`),
  KEY `TargetUserID` (`TargetUserID`),
  CONSTRAINT `usercomments_ibfk_1` FOREIGN KEY (`AuthorID`) REFERENCES `users` (`UserID`) ON DELETE CASCADE,
  CONSTRAINT `usercomments_ibfk_2` FOREIGN KEY (`TargetUserID`) REFERENCES `users` (`UserID`) ON DELETE CASCADE,
  CONSTRAINT `usercomments_chk_1` CHECK (((`Rating` >= 1) and (`Rating` <= 5)))
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `UserID` int NOT NULL AUTO_INCREMENT,
  `Email` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `IsStudent` tinyint(1) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `PhoneNumber` varchar(20) DEFAULT NULL,
  `UserType` enum('орендар','власник','admin') DEFAULT NULL,
  `RegistrationDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UserImage` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`UserID`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-12 18:14:05
