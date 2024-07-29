-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 29, 2024 at 07:47 PM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 7.3.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `blogging_website`
--

-- --------------------------------------------------------

--
-- Table structure for table `blogs`
--

CREATE TABLE `blogs` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `category_id` int(11) NOT NULL,
  `sub_category_id` int(11) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `original_file_name` varchar(255) DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `created_on` datetime NOT NULL DEFAULT current_timestamp(),
  `blog_status` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `blogs`
--

INSERT INTO `blogs` (`id`, `title`, `description`, `category_id`, `sub_category_id`, `image_url`, `original_file_name`, `created_by`, `created_on`, `blog_status`) VALUES
(17, 'Bingham Report accuses Bank of England of failing to discharge its task of supervising BCCI', 'The Bingham report, published on October 24, launches a scathing attack, ironically, on the Bank of England which stands accused of having failed to discharge its task of supervising BCCI.', 3, 2, '0339004b1262fac57c3d7296dfa61cce.jpg', 'pexels-pixabay-33109.jpg', 1, '2024-07-11 22:57:41', 1),
(18, 'Laxmi Poruri: Indian-born tennis player on a comeback trail', 'Poruri with Seles in 1986\nIn a world where teen queens blitz their elders out of court with power play that gets quicker every year, 19-year-old Laxmi Poruri is an anachronism.\n\nThe Indian-born, Stanford University undergraduate who dominated the 14-and-under US tennis scene in the late \'80s, is now ready to roll again. The woman who once scalped Monica Seles, one year her junior and currently ranked number one, and Arantxa Sanchez Vicario in the finals of the US Junior Open in 1988, thinks she has it in her to be among the best on the tennis circuit.\n\n\"I\'d love to be in the top 10 in the world some day,\" says the 5ft 7in, 130-pound Poruri, who is currently number three among the nation\'s women college tennis players. \"But right now, I\'m going to continue playing the best I can and enjoy the game.\"', 3, 2, 'c59abcab6a11b2579f34f0c87182b4e3.png', 'c59abcab6a11b2579f34f0c87182b4e3.png', 1, '2024-07-11 22:57:41', 1),
(19, 'BCCI collapse: Asian clients suffer at the hands of liquidators', 'A store in Southall: the worst victims\nThe collapse of the Bank of Credit & Commerce International (BCCI) has left a trail of victims all over the world.\n\nThe disputes over depositors\' claims are mostly in the process of being sorted out and, in some cases, have even been resolved. But in the UK, where the South Asian population and businesses treated the bank as their very own, as understanding the special needs of a usually defensive ethnic group, there is a struggle to cope with life after BCCI. Especially as creditors come calling.', 3, 2, '989486e41ae62aa0c1a7d48cd9482db4.png', 'pexe-pixabay-33109.jpg', 1, '2024-07-11 22:57:41', 1),
(20, 'India-friendly Democrat Stephen Solarz may face tough fight for renomination', 'Solarz with Mehtani: friendly ties\nJust as New York Democrat Stephen Solarz was about to reach new heights in the US Congress, his political misfortunes in this election year come like a bad dream. Solarz, who is India\'s most vocal ally on Capitol Hill, has been disadvantaged by an electoral redistricting process that abolished his 13th district in Brooklyn, New York.', 3, 2, '0339004b1262fac57c3d7296dfa61cce.jpg', 'pexy-09.jpg', 1, '2024-07-11 22:57:41', 1);

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `category_name` varchar(100) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `category_name`, `status`) VALUES
(1, 'Home', 1),
(2, 'Elections', 1),
(3, 'TV', 1),
(4, 'Magezine', 1),
(5, 'All Sports', 1),
(6, 'Life+Style', 1),
(7, 'India', 1),
(8, 'South', 1),
(9, 'World', 1),
(10, 'Business', 1),
(11, 'Technology', 1),
(12, 'Entertainment', 1),
(13, 'Specials', 1),
(14, 'Videos', 1);

-- --------------------------------------------------------

--
-- Table structure for table `refresh_tokens`
--

CREATE TABLE `refresh_tokens` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `expiry_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `refresh_tokens`
--

INSERT INTO `refresh_tokens` (`id`, `user_id`, `token`, `expiry_date`) VALUES
(2, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEsInVzZXJuYW1lIjoidGVzdHVzZXIiLCJpYXQiOjE3MTkxNjQ2MjYsImV4cCI6MTcxOTE2NDc0Nn0.Bv8bhZKiP6Z-uXUn2bYwuH7qP18Cq5n7VglUxuvbydQ', '2024-06-23 23:15:46'),
(3, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEsInVzZXJuYW1lIjoidGVzdHVzZXIiLCJpYXQiOjE3MTkxNjQ3MTYsImV4cCI6MTcxOTE2NDgzNn0.7ez6f9xvNIJqXENKFidrukcPBCw4QjZCMxikjETQ5J0', '2024-06-23 23:17:16'),
(4, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEsInVzZXJuYW1lIjoidGVzdHVzZXIiLCJpYXQiOjE3MTkxNjUzNzAsImV4cCI6MTcxOTE2NTQ5MH0.a7pJDnKV18SJIsBaMblO7LZHIa-P584lDu3gRkK4ogI', '2024-06-23 23:28:10'),
(5, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEsInVzZXJuYW1lIjoidGVzdHVzZXIiLCJpYXQiOjE3MTkxNjU4MDAsImV4cCI6MTcxOTE2NTkyMH0.H1jwiKCNQnsystOk61BNVWsazg9xUdFwItjYy5IPNlU', '2024-06-23 23:35:20');

-- --------------------------------------------------------

--
-- Table structure for table `sub_category`
--

CREATE TABLE `sub_category` (
  `id` int(11) NOT NULL,
  `sub_category_name` varchar(100) NOT NULL,
  `category_id` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sub_category`
--

INSERT INTO `sub_category` (`id`, `sub_category_name`, `category_id`, `status`) VALUES
(1, 'Live TV', 3, 1),
(2, 'Prime Time', 3, 1),
(3, 'Latest Edition', 4, 1),
(4, 'Insight', 4, 1),
(5, 'Sports Today', 5, 1),
(6, 'Cricket', 5, 1),
(7, 'Football', 5, 1),
(8, 'Tennis', 5, 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(30) NOT NULL,
  `title` enum('Mr.','Miss.','Mrs.') NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `user_role` enum('User','Admin','Super Admin') NOT NULL,
  `email` varchar(255) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `created_on` datetime DEFAULT current_timestamp(),
  `user_status` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `title`, `first_name`, `last_name`, `user_role`, `email`, `user_password`, `created_on`, `user_status`) VALUES
(1, 'testuser', 'Mr.', 'test', 'user', 'User', 'testuser@gmail.com', '$2a$10$Ko61DGmZh1DY2sXVhExULOuRzeLoGCgFzDf.kOUZaWfadw7xgCxGe', '2024-06-02 12:37:35', 1),
(2, 'abin', 'Mr.', 'Abin', 'john', 'User', 'abin@gmail.com', '$2a$10$Ko61DGmZh1DY2sXVhExULOuRzeLoGCgFzDf.kOUZaWfadw7xgCxGe', '2024-06-18 09:45:19', 1),
(4, 'sandra', 'Mrs.', 'Sandra', 'Stani', 'User', 'sandra@gmail.com', '$2a$10$p3Eq/BQBClqCbDxRUPYMEe8POwWTTzKv0PFSvg14KYdxKmlwOpYue', '2024-06-18 09:48:08', 1),
(5, 'newuser', 'Miss.', 'New', 'User', 'User', 'new@user.com', '$2a$10$0.Bo4.MfAwXR.Dh4SaHf4.NiuRNKukbVFW9jdeGWR4o3RnyROliFq', '2024-06-18 09:50:57', 1),
(6, 'abc', 'Mrs.', 'Abc', 'User', 'User', 'abc@gmail.com', '$2a$10$8FDGeO9QTyptNviqc2Dofe4xUc1bgqXA/x89RM00VdDIvs2JGYveS', '2024-06-18 09:51:48', 1),
(7, 'test1', 'Mr.', 'test', 'first', 'User', 'test@gmail.com', '$2a$10$4ncj1qqRRsql0GdyjPMr/uuQJUdj1TdWBZ8K9F/cD0HXoRHzbBO92', '2024-06-18 09:53:03', 1),
(8, 'jibin', 'Mr.', 'Test', 'Jibin', 'User', 'jibin@gmail.com', '$2a$10$xRIDaUYOkaTZ0PeSCnBsruxP9tSqe5kTIcf91Y0sGf997ugwVf3M.', '2024-06-18 09:54:40', 1),
(9, 'freshtutorz', 'Mr.', 'Freshtutorz', 'User', 'User', 'user@freshtutorz.com', '$2a$10$8Cb5JtIWRHgADlPcRDLsPels0REjJiBB2onjKJsT4pb2PQvvtqo.6', '2024-06-18 09:55:58', 1),
(10, 'sdlfj', 'Mr.', 'sldfjlks', 'sdlkfjsd', 'User', 'sdf@sdj.com', '$2a$10$bwsbGcl1EXHhjGH5sQzf4.xJODkmfF3XVRp9VsJRP8tRtIr/.tyTK', '2024-06-19 08:41:45', 1),
(11, 'asdf3wes', 'Mr.', 'asdf2we', 'aasdf23wed', 'User', 'sd@sdw.com', '$2a$10$7MPTK7pu3tv1nSv3ASLoY./5BRjOezow2l.QfvcdZDfwpUMMyt2bq', '2024-06-19 08:42:55', 1),
(31, 'freshtutorz123213', 'Mr.', 'Jopsy', 'Varghese', 'User', 'asdf2@dls.com', '$2a$10$vEA1mVZKwwq/zw.CYp7IruFfUglSDzLxhtAsSjbKQCCt675W3iugu', '2024-06-19 08:57:39', 1),
(33, 'abinsdfsdfsd', 'Mr.', 'Jopsy', 'Varghese', 'User', 'jopsy@gmail.com', '$2a$10$FhnXWLzkdRdmsNyVGPogMOcFk8gzM6vKZ9h/rWD4B7N1LyKuiLL/y', '2024-06-19 08:59:05', 1),
(34, 'testuser22', 'Mrs.', 'sdfsdf', 'asdfwe', 'User', 'adsdfn@gmail.com', '$2a$10$Y10zvd7hQoYwuDf9Qfy9Oe3PnQRi7mpCkRfEVF0lOtx28Q/Ekyh3O', '2024-06-23 21:30:23', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `blogs`
--
ALTER TABLE `blogs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `refresh_tokens`
--
ALTER TABLE `refresh_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `sub_category`
--
ALTER TABLE `sub_category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `blogs`
--
ALTER TABLE `blogs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `refresh_tokens`
--
ALTER TABLE `refresh_tokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `sub_category`
--
ALTER TABLE `sub_category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `refresh_tokens`
--
ALTER TABLE `refresh_tokens`
  ADD CONSTRAINT `refresh_tokens_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
