-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: littlelemondb
-- ------------------------------------------------------
-- Server version	8.0.32

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
-- Temporary view structure for view `anyview`
--

DROP TABLE IF EXISTS `anyview`;
/*!50001 DROP VIEW IF EXISTS `anyview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `anyview` AS SELECT 
 1 AS `MenuItems_Name`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings` (
  `Booking_ID` int NOT NULL,
  `Booking_Date` datetime DEFAULT NULL,
  `TableNum` int DEFAULT NULL,
  `B_Order_ID` int DEFAULT NULL,
  `B_Client_ID` int DEFAULT NULL,
  PRIMARY KEY (`Booking_ID`),
  KEY `Order_ID_idx` (`B_Order_ID`),
  KEY `B_Client_ID_idx` (`B_Client_ID`),
  CONSTRAINT `B_Client_ID` FOREIGN KEY (`B_Client_ID`) REFERENCES `clients` (`Client_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `B_Order_ID` FOREIGN KEY (`B_Order_ID`) REFERENCES `orders` (`Order_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings`
--

LOCK TABLES `bookings` WRITE;
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clients` (
  `Client_ID` int NOT NULL,
  `Client_Name` varchar(255) DEFAULT NULL,
  `ContactNumber` varchar(45) DEFAULT NULL,
  `Email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Client_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `fourtablesview`
--

DROP TABLE IF EXISTS `fourtablesview`;
/*!50001 DROP VIEW IF EXISTS `fourtablesview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `fourtablesview` AS SELECT 
 1 AS `Client_ID`,
 1 AS `Client_Name`,
 1 AS `Order_ID`,
 1 AS `Total_Cost`,
 1 AS `Menu_Name`,
 1 AS `MenuItems_Name`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `menuitems`
--

DROP TABLE IF EXISTS `menuitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menuitems` (
  `MenuItems_ID` int NOT NULL,
  `MenuItems_Name` varchar(255) DEFAULT NULL,
  `Composition` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`MenuItems_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menuitems`
--

LOCK TABLES `menuitems` WRITE;
/*!40000 ALTER TABLE `menuitems` DISABLE KEYS */;
/*!40000 ALTER TABLE `menuitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menus`
--

DROP TABLE IF EXISTS `menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menus` (
  `Menu_ID` int NOT NULL,
  `Menu_Name` varchar(255) DEFAULT NULL,
  `Description` varchar(255) DEFAULT NULL,
  `Cost` decimal(5,2) DEFAULT NULL,
  `M_MenuItem_ID` int NOT NULL,
  PRIMARY KEY (`Menu_ID`),
  KEY `MenuItem_ID_idx` (`M_MenuItem_ID`),
  CONSTRAINT `MenuItem_ID` FOREIGN KEY (`M_MenuItem_ID`) REFERENCES `menuitems` (`MenuItems_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menus`
--

LOCK TABLES `menus` WRITE;
/*!40000 ALTER TABLE `menus` DISABLE KEYS */;
/*!40000 ALTER TABLE `menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `Order_ID` int NOT NULL,
  `Order_Date` datetime DEFAULT NULL,
  `Quantity` int DEFAULT NULL,
  `Total_Cost` decimal(5,2) DEFAULT NULL,
  `O_Client_ID` int DEFAULT NULL,
  `O_Staff_ID` int DEFAULT NULL,
  `O_Menu_ID` int DEFAULT NULL,
  PRIMARY KEY (`Order_ID`),
  KEY `Client_ID_idx` (`O_Client_ID`),
  KEY `Staff_ID_idx` (`O_Staff_ID`),
  KEY `Menu_ID_idx` (`O_Menu_ID`),
  CONSTRAINT `O_Client_ID` FOREIGN KEY (`O_Client_ID`) REFERENCES `clients` (`Client_ID`),
  CONSTRAINT `O_Menu_ID` FOREIGN KEY (`O_Menu_ID`) REFERENCES `menus` (`Menu_ID`),
  CONSTRAINT `O_Staff_ID` FOREIGN KEY (`O_Staff_ID`) REFERENCES `staff` (`Staff_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_status`
--

DROP TABLE IF EXISTS `orders_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_status` (
  `Orders_Status_ID` int NOT NULL,
  `Delivery_Date` datetime DEFAULT NULL,
  `Status` varchar(45) DEFAULT NULL,
  `S_Order_ID` int DEFAULT NULL,
  PRIMARY KEY (`Orders_Status_ID`),
  KEY `Order_ID_idx` (`S_Order_ID`),
  CONSTRAINT `S_Order_ID` FOREIGN KEY (`S_Order_ID`) REFERENCES `orders` (`Order_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_status`
--

LOCK TABLES `orders_status` WRITE;
/*!40000 ALTER TABLE `orders_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `ordersview`
--

DROP TABLE IF EXISTS `ordersview`;
/*!50001 DROP VIEW IF EXISTS `ordersview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `ordersview` AS SELECT 
 1 AS `Order_ID`,
 1 AS `Quantity`,
 1 AS `Total_Cost`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `Staff_ID` int NOT NULL,
  `Role` varchar(45) DEFAULT NULL,
  `Salary` decimal(5,2) DEFAULT NULL,
  `Sf_Client_ID` int NOT NULL,
  PRIMARY KEY (`Staff_ID`),
  KEY `Client_ID_idx` (`Sf_Client_ID`),
  CONSTRAINT `Client_ID` FOREIGN KEY (`Sf_Client_ID`) REFERENCES `clients` (`Client_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `anyview`
--

/*!50001 DROP VIEW IF EXISTS `anyview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`Project_Admin_Meta`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `anyview` AS select `menuitems`.`MenuItems_Name` AS `MenuItems_Name` from `menuitems` where `menuitems`.`MenuItems_ID` in (select `menus`.`M_MenuItem_ID` from (`menus` join `orders` on((`menus`.`M_MenuItem_ID` = `menuitems`.`MenuItems_ID`))) where (`orders`.`Quantity` >= 2)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `fourtablesview`
--

/*!50001 DROP VIEW IF EXISTS `fourtablesview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`Project_Admin_Meta`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `fourtablesview` AS select `clients`.`Client_ID` AS `Client_ID`,`clients`.`Client_Name` AS `Client_Name`,`orders`.`Order_ID` AS `Order_ID`,`orders`.`Total_Cost` AS `Total_Cost`,`menus`.`Menu_Name` AS `Menu_Name`,`menuitems`.`MenuItems_Name` AS `MenuItems_Name` from (((`orders` join `clients` on((`clients`.`Client_ID` = `orders`.`O_Client_ID`))) join `menus` on((`orders`.`O_Menu_ID` = `menus`.`Menu_ID`))) join `menuitems` on((`menuitems`.`MenuItems_ID` = `menus`.`M_MenuItem_ID`))) where (`orders`.`Total_Cost` >= 150) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `ordersview`
--

/*!50001 DROP VIEW IF EXISTS `ordersview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`Project_Admin_Meta`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `ordersview` AS select `orders`.`Order_ID` AS `Order_ID`,`orders`.`Quantity` AS `Quantity`,`orders`.`Total_Cost` AS `Total_Cost` from `orders` where (`orders`.`Quantity` >= 2) */;
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

-- Dump completed on 2023-04-18 13:44:46
