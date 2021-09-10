-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Sep 10, 2021 at 10:43 PM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 8.0.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `university`
--

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `course_id` int(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `class_duration` varchar(255) NOT NULL,
  `price` varchar(255) NOT NULL,
  `credits_number` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`course_id`, `name`, `class_duration`, `price`, `credits_number`) VALUES
(1, 'programming', '2', '500000', 3),
(2, 'network', '2', '450000', 3),
(3, 'database', '2.5', '550000', 3),
(4, 'web design 1', '1.5', '350000', 2),
(5, 'web design 2', '2', '400000', 2),
(6, 'digital marketing', '1.5', '420000', 2),
(7, 'mathematic', '2.5', '480000', 3),
(8, 'islamic 1', '1', '100000', 1),
(9, 'islamic 2', '1', '120000', 1),
(10, 'quran', '1.5', '150000', 1);

-- --------------------------------------------------------

--
-- Table structure for table `courses_list`
--

CREATE TABLE `courses_list` (
  `course_list_id` int(255) NOT NULL,
  `course_id` int(255) NOT NULL,
  `professor_id` int(255) NOT NULL,
  `class_start_time` varchar(255) NOT NULL COMMENT 'example : (Sun Jan 31 2021 08:00:00) = class_has_been_started at 8 am\r\n(Sun Jan 31 2021 10:00:00) = class_has_been_finished at 10 am',
  `class_finish_time` varchar(255) NOT NULL COMMENT 'example : (Sat May 15 2021 00:00:00) = 1621062000000',
  `number_of_students` int(255) NOT NULL,
  `used` int(255) NOT NULL,
  `semester_id` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `courses_list`
--

INSERT INTO `courses_list` (`course_list_id`, `course_id`, `professor_id`, `class_start_time`, `class_finish_time`, `number_of_students`, `used`, `semester_id`) VALUES
(1, 2, 1, '1612067400000', '1621062000000', 5, 1, 1),
(2, 2, 1, '1612076400000', '1621062000000', 5, 0, 1),
(3, 2, 1, '1612087200000', '1621062000000', 5, 0, 1),
(4, 4, 2, '1612069200000', '1621062000000', 20, 0, 1),
(5, 4, 2, '1612076400000', '1621062000000', 20, 2, 1),
(6, 4, 2, '1612085400000', '1621062000000', 20, 2, 1),
(7, 3, 3, '1612240200000', '1621062000000', 8, 0, 1),
(8, 3, 3, '1612258200000', '1621062000000', 8, 0, 1),
(9, 3, 3, '1612332000000', '1621062000000', 8, 0, 1),
(10, 3, 3, '1612346400000', '1621062000000', 8, 2, 1),
(11, 3, 4, '1612240200000', '1621062000000', 8, 0, 1),
(12, 3, 4, '1612258200000', '1621062000000', 8, 0, 1),
(13, 3, 4, '1612332000000', '1621062000000', 8, 1, 1),
(14, 3, 4, '1612346400000', '1621062000000', 8, 0, 1),
(15, 6, 5, '1612240200000', '1621062000000', 5, 1, 1),
(16, 6, 5, '1612249200000', '1621062000000', 5, 0, 1),
(17, 6, 5, '1612260000000', '1621062000000', 5, 0, 1),
(18, 6, 5, '1612344600000', '1621062000000', 5, 0, 1),
(19, 6, 5, '1612352700000', '1621062000000', 5, 1, 1),
(20, 6, 5, '1612360800000', '1621062000000', 5, 2, 1),
(21, 2, 6, '1612413000000', '1621062000000', 15, 0, 1),
(22, 2, 6, '1612421100000', '1621062000000', 15, 1, 1),
(23, 2, 6, '1612432800000', '1621062000000', 15, 0, 1),
(24, 2, 6, '1611981000000', '1621062000000', 15, 0, 1),
(25, 2, 7, '1611990000000', '1621062000000', 15, 0, 1),
(26, 2, 7, '1612000800000', '1621062000000', 15, 0, 1),
(27, 2, 7, '1612009800000', '1621062000000', 15, 0, 1),
(28, 2, 7, '1612010700000', '1621062000000', 15, 0, 1),
(29, 1, 9, '1612153800000', '1621062000000', 10, 0, 1),
(30, 1, 9, '1612161900000', '1621062000000', 10, 0, 1),
(31, 1, 9, '1612171800000', '1621062000000', 10, 0, 1),
(32, 1, 9, '1612179900000', '1621062000000', 10, 0, 1),
(33, 1, 9, '1612188000000', '1621062000000', 10, 0, 1),
(34, 1, 9, '1612067400000', '1621062000000', 10, 1, 1),
(35, 1, 9, '1612075500000', '1621062000000', 10, 0, 1),
(36, 1, 9, '1612086300000', '1621062000000', 10, 0, 1),
(37, 7, 8, '1612240200000', '1621062000000', 15, 0, 1),
(38, 7, 8, '1612250100000', '1621062000000', 15, 0, 1),
(39, 7, 8, '1612260000000', '1621062000000', 15, 0, 1),
(40, 7, 8, '1612269900000', '1621062000000', 15, 0, 1),
(41, 7, 10, '1612413000000', '1621062000000', 15, 0, 1),
(42, 7, 10, '1612422900000', '1621062000000', 15, 0, 1),
(43, 7, 10, '1612432800000', '1621062000000', 15, 1, 1),
(44, 7, 10, '1612442700000', '1621062000000', 15, 0, 1),
(45, 8, 11, '1612071000000', '1621062000000', 7, 0, 1),
(46, 8, 11, '1612075500000', '1621062000000', 7, 0, 1),
(47, 8, 11, '1612080000000', '1621062000000', 7, 0, 1),
(48, 8, 11, '1612087200000', '1621062000000', 7, 1, 1),
(49, 8, 11, '1612091700000', '1621062000000', 7, 0, 1),
(50, 8, 11, '1612071000000', '1621062000000', 7, 0, 1),
(51, 8, 11, '1612075500000', '1621062000000', 7, 0, 1),
(52, 8, 11, '1612080000000', '1621062000000', 7, 0, 1),
(53, 9, 11, '1612089000000', '1621062000000', 7, 0, 1),
(54, 9, 11, '1612093500000', '1621062000000', 7, 0, 1),
(55, 9, 11, '1612098000000', '1621062000000', 7, 0, 1),
(56, 9, 11, '1612102500000', '1621062000000', 7, 0, 1),
(57, 9, 11, '1612157400000', '1621062000000', 7, 0, 1),
(58, 9, 11, '1612161900000', '1621062000000', 7, 0, 1),
(59, 9, 11, '1612166400000', '1621062000000', 7, 0, 1),
(60, 10, 12, '1612175400000', '1621062000000', 15, 0, 1),
(61, 10, 12, '1612181700000', '1621062000000', 15, 0, 1),
(62, 10, 12, '1612185300000', '1621062000000', 15, 0, 1),
(63, 10, 12, '1612188000000', '1621062000000', 15, 1, 1),
(64, 5, 4, '1612258200000', '1621062000000', 10, 0, 1),
(65, 5, 4, '1612266300000', '1621062000000', 10, 0, 1),
(66, 5, 4, '1612274400000', '1621062000000', 10, 0, 1),
(67, 5, 4, '1612344600000', '1621062000000', 10, 0, 1),
(68, 5, 4, '1612352700000', '1621062000000', 10, 0, 1),
(69, 5, 4, '1612360800000', '1621062000000', 10, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `professors`
--

CREATE TABLE `professors` (
  `professor_id` int(255) NOT NULL,
  `fullname` varchar(255) NOT NULL,
  `date` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `professors`
--

INSERT INTO `professors` (`professor_id`, `fullname`, `date`) VALUES
(1, 'Jake', '1630827070784'),
(2, 'Charlie', '1630827111752'),
(3, 'Robert', '1630827125904'),
(4, 'William', '1630827162431'),
(5, 'David', '1630827179191'),
(6, 'Richard', '1630827195679'),
(7, 'Joseph', '1630827214167'),
(8, 'Charles', '1630827226255'),
(9, 'Thomas', '1630827240606'),
(10, 'Daniel', '1630827254990'),
(11, 'James', '1630827269102'),
(12, 'Alexander', '1630827285214');

-- --------------------------------------------------------

--
-- Table structure for table `selected_courses`
--

CREATE TABLE `selected_courses` (
  `selected_course_id` int(255) NOT NULL,
  `user_id` int(255) NOT NULL,
  `course_list_id` int(255) NOT NULL,
  `semester_id` int(255) NOT NULL,
  `date` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `semesters`
--

CREATE TABLE `semesters` (
  `semester_id` int(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `start` varchar(255) NOT NULL COMMENT 'example : new Date(2021, 00, 01, 00, 00, 00).getTime()',
  `end` varchar(255) NOT NULL COMMENT 'example : new Date(2021, 05, 30, 23, 59, 59).getTime()'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `semesters`
--

INSERT INTO `semesters` (`semester_id`, `name`, `start`, `end`) VALUES
(1, 'first_mid_year', '1609488000000', '1625122799000');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`course_id`);

--
-- Indexes for table `courses_list`
--
ALTER TABLE `courses_list`
  ADD PRIMARY KEY (`course_list_id`);

--
-- Indexes for table `professors`
--
ALTER TABLE `professors`
  ADD PRIMARY KEY (`professor_id`);

--
-- Indexes for table `selected_courses`
--
ALTER TABLE `selected_courses`
  ADD PRIMARY KEY (`selected_course_id`);

--
-- Indexes for table `semesters`
--
ALTER TABLE `semesters`
  ADD PRIMARY KEY (`semester_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `course_id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `courses_list`
--
ALTER TABLE `courses_list`
  MODIFY `course_list_id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT for table `professors`
--
ALTER TABLE `professors`
  MODIFY `professor_id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `selected_courses`
--
ALTER TABLE `selected_courses`
  MODIFY `selected_course_id` int(255) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `semesters`
--
ALTER TABLE `semesters`
  MODIFY `semester_id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
