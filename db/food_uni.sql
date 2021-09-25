-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 24, 2021 at 03:18 PM
-- Server version: 10.4.20-MariaDB
-- PHP Version: 8.0.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `food_uni`
--

-- --------------------------------------------------------

--
-- Table structure for table `getting_food`
--

CREATE TABLE `getting_food` (
  `getfoodID` int(10) NOT NULL,
  `userID` int(10) NOT NULL,
  `date` varchar(100) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

--
-- Dumping data for table `getting_food`
--

INSERT INTO `getting_food` (`getfoodID`, `userID`, `date`) VALUES
(1, 1, 'Fri Sep 24 2021 16:33:16 GMT+0330 (وقت عادی ایران)'),
(2, 1, 'Fri Sep 24 2021 16:36:18 GMT+0330 (وقت عادی ایران)'),
(3, 1, 'Fri Sep 24 2021 16:36:47 GMT+0330 (وقت عادی ایران)'),
(4, 1, 'Fri Sep 24 2021 16:37:49 GMT+0330 (وقت عادی ایران)'),
(5, 1, 'Fri Sep 24 2021 16:38:29 GMT+0330 (وقت عادی ایران)'),
(6, 2, 'Fri Sep 24 2021 16:44:55 GMT+0330 (وقت عادی ایران)'),
(7, 2, 'Fri Sep 24 2021 16:44:56 GMT+0330 (وقت عادی ایران)'),
(8, 2, 'Fri Sep 24 2021 16:44:58 GMT+0330 (وقت عادی ایران)'),
(9, 6, 'Fri Sep 24 2021 16:45:01 GMT+0330 (وقت عادی ایران)'),
(10, 6, 'Fri Sep 24 2021 16:45:03 GMT+0330 (وقت عادی ایران)'),
(11, 6, 'Fri Sep 24 2021 16:45:04 GMT+0330 (وقت عادی ایران)'),
(12, 6, 'Fri Sep 24 2021 16:45:05 GMT+0330 (وقت عادی ایران)'),
(13, 6, 'Fri Sep 24 2021 16:45:06 GMT+0330 (وقت عادی ایران)'),
(14, 6, 'Fri Sep 24 2021 16:45:07 GMT+0330 (وقت عادی ایران)'),
(15, 7, 'Fri Sep 24 2021 16:45:23 GMT+0330 (وقت عادی ایران)'),
(16, 7, 'Fri Sep 24 2021 16:45:24 GMT+0330 (وقت عادی ایران)'),
(17, 7, 'Fri Sep 24 2021 16:45:25 GMT+0330 (وقت عادی ایران)'),
(18, 7, 'Fri Sep 24 2021 16:45:26 GMT+0330 (وقت عادی ایران)'),
(19, 7, 'Fri Sep 24 2021 16:45:27 GMT+0330 (وقت عادی ایران)'),
(20, 3, 'Fri Sep 24 2021 16:45:39 GMT+0330 (وقت عادی ایران)'),
(21, 3, 'Fri Sep 24 2021 16:45:41 GMT+0330 (وقت عادی ایران)');

-- --------------------------------------------------------

--
-- Table structure for table `reservation_food`
--

CREATE TABLE `reservation_food` (
  `resID` int(10) NOT NULL,
  `userID` int(10) NOT NULL,
  `reserve` int(100) NOT NULL,
  `taken` int(100) NOT NULL,
  `date` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `reservation_food`
--

INSERT INTO `reservation_food` (`resID`, `userID`, `reserve`, `taken`, `date`) VALUES
(1, 1, 5, 5, 'Fri Sep 24 2021 16:33:11 GMT+0330 (وقت عادی ایران)'),
(2, 1, 15, 0, 'Fri Sep 24 2021 16:41:53 GMT+0330 (وقت عادی ایران)'),
(3, 2, 5, 3, 'Fri Sep 24 2021 16:42:58 GMT+0330 (وقت عادی ایران)'),
(4, 3, 3, 2, 'Fri Sep 24 2021 16:43:21 GMT+0330 (وقت عادی ایران)'),
(5, 3, 3, 0, 'Fri Sep 24 2021 16:43:24 GMT+0330 (وقت عادی ایران)'),
(6, 5, 2, 0, 'Fri Sep 24 2021 16:43:29 GMT+0330 (وقت عادی ایران)'),
(7, 4, 14, 0, 'Fri Sep 24 2021 16:43:36 GMT+0330 (وقت عادی ایران)'),
(8, 6, 6, 6, 'Fri Sep 24 2021 16:43:46 GMT+0330 (وقت عادی ایران)'),
(9, 7, 12, 5, 'Fri Sep 24 2021 16:43:51 GMT+0330 (وقت عادی ایران)'),
(10, 4, 12, 0, 'Fri Sep 24 2021 16:44:02 GMT+0330 (وقت عادی ایران)');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `getting_food`
--
ALTER TABLE `getting_food`
  ADD PRIMARY KEY (`getfoodID`);

--
-- Indexes for table `reservation_food`
--
ALTER TABLE `reservation_food`
  ADD PRIMARY KEY (`resID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `getting_food`
--
ALTER TABLE `getting_food`
  MODIFY `getfoodID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `reservation_food`
--
ALTER TABLE `reservation_food`
  MODIFY `resID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
