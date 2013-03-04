-- phpMyAdmin SQL Dump
-- version 3.2.5
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Feb 25, 2013 at 09:33 PM
-- Server version: 5.1.44
-- PHP Version: 5.3.2

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `utlimate_geo_tech`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_latest_news`
--

DROP TABLE IF EXISTS `tbl_latest_news`;
CREATE TABLE IF NOT EXISTS `tbl_latest_news` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `news` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `tbl_latest_news`
--

INSERT INTO `tbl_latest_news` (`id`, `news`) VALUES
(2, 'This is news for ultimate geotech.This is news for ultimate geotech.This is news for ultimate geotech.This is news for ultimate geotech.This is news for ultimate geotech.This is news for ultimate geotech.This is news for ultimate geotech.This is news for ultimate geotechThis is news for ultimate geotech'),
(3, 'thi si sthired.fdjfldsj fdlsfjdslfjdslfjdsl jf');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_question_type`
--

DROP TABLE IF EXISTS `tbl_question_type`;
CREATE TABLE IF NOT EXISTS `tbl_question_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` text NOT NULL COMMENT '(mcq-4 options,true/false,missing letter)',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `tbl_question_type`
--

INSERT INTO `tbl_question_type` (`id`, `type`) VALUES
(1, 'MCQ'),
(2, 'True/False'),
(3, 'Missing Character');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_race`
--

DROP TABLE IF EXISTS `tbl_race`;
CREATE TABLE IF NOT EXISTS `tbl_race` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `race_createdby` int(11) NOT NULL COMMENT 'user who created race',
  `race_name` text NOT NULL,
  `number_of_questions` int(11) NOT NULL,
  `race_info` text NOT NULL,
  `race_rating` int(2) NOT NULL COMMENT '(user will give this after he finishes race)',
  `race_difficulty` int(2) NOT NULL COMMENT '(user will give this after he finishes race)',
  `race_popularity` int(2) NOT NULL,
  `number_of_completion` int(11) NOT NULL COMMENT '(if user completes the race it will incremented by 1)',
  `race_latitude` double NOT NULL,
  `race_longitude` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `tbl_race`
--

INSERT INTO `tbl_race` (`id`, `race_createdby`, `race_name`, `number_of_questions`, `race_info`, `race_rating`, `race_difficulty`, `race_popularity`, `number_of_completion`, `race_latitude`, `race_longitude`) VALUES
(1, 0, 'race-1', 1, 'fdlsjfldj ldfjlsdj', 0, 0, 0, 0, -33.8634, 151.211),
(2, 1, '34', 34343, 'Dfdsf', 0, 0, 0, 0, 0, 0),
(3, 1, 'fsd', 232323, 'Sdfdsfdsf', 0, 0, 0, 0, 0, -122.4064),
(4, 1, 'fsd', 232323, 'Sdfdsfdsf', 0, 0, 0, 0, 0, -122.4064),
(9, 1, 'First race', 3, 'This race is belongs to test....', 0, 0, 0, 0, 51.50998, -0.1337);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_race_question`
--

DROP TABLE IF EXISTS `tbl_race_question`;
CREATE TABLE IF NOT EXISTS `tbl_race_question` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `race_id` int(11) NOT NULL,
  `race_question_text` text NOT NULL,
  `option_a` text NOT NULL COMMENT 'This will for mcq type question',
  `option_b` text NOT NULL COMMENT 'This will for mcq type question',
  `option_c` text NOT NULL COMMENT 'This will for mcq type question',
  `option_d` text NOT NULL COMMENT 'This will for mcq type question',
  `correct_answer` int(1) NOT NULL COMMENT 'This will for mcq type question',
  `answer_is_true_false` int(1) NOT NULL COMMENT 'for true or false type question,0 false 1 true',
  `missing_letter_word` text NOT NULL COMMENT 'Missing letter word',
  `number_of_character_to_show` int(11) NOT NULL COMMENT 'Missing letter word',
  `random_word` text NOT NULL COMMENT 'Missing letter word',
  `question_type` int(11) NOT NULL COMMENT '(mcq-4 options,true/false,missing letter)',
  `race_lat` text NOT NULL,
  `race_lon` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=15 ;

--
-- Dumping data for table `tbl_race_question`
--

INSERT INTO `tbl_race_question` (`id`, `race_id`, `race_question_text`, `option_a`, `option_b`, `option_c`, `option_d`, `correct_answer`, `answer_is_true_false`, `missing_letter_word`, `number_of_character_to_show`, `random_word`, `question_type`, `race_lat`, `race_lon`) VALUES
(4, 6, 'True or false question', '', '', '', '', 0, 0, '', 0, '', 2, '0', '-122.4064'),
(3, 6, 'Mcq question', 'Option-1', 'Option-2', 'Opction-3', 'Option-4', 2, 0, '', 0, '', 1, '0', '-122.4064'),
(5, 6, 'Missing character question', '', '', '', '', 0, 0, 'Answer', 3, '', 3, '0', '-122.4064'),
(6, 7, 'Mcq question', 'Option-1', 'Option-2', 'Opction-3', 'Option-4', 2, 0, '', 0, '', 1, '0', '-122.4064'),
(7, 7, 'True or false question', '', '', '', '', 0, 0, '', 0, '', 2, '0', '-122.4064'),
(8, 7, 'Missing character question', '', '', '', '', 0, 0, 'Answer', 3, '', 3, '0', '-122.4064'),
(9, 8, 'Mcq question', 'Option-1', 'Option-2', 'Opction-3', 'Option-4', 2, 0, '', 0, '', 1, '0', '-122.4064'),
(10, 8, 'True or false question', '', '', '', '', 0, 0, '', 0, '', 2, '0', '-122.4064'),
(11, 8, 'Missing character question', '', '', '', '', 0, 0, 'Answer', 3, '', 3, '0', '-122.4064'),
(12, 9, 'Mcq-1', 'Opton-1', 'Option-2', 'Option-3', 'Option-4', 2, 0, '', 0, '', 1, '51.52627', '-0.08859872'),
(13, 9, 'This answer is true?Edited', '', '', '', '', 0, 0, '', 0, '', 2, '51.52627', '-0.08859872'),
(14, 9, 'Spell your name', '', '', '', '', 0, 0, 'Abracadabra', 5, '', 3, '51.52627', '-0.08859872');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_race_ratings_reviews`
--

DROP TABLE IF EXISTS `tbl_race_ratings_reviews`;
CREATE TABLE IF NOT EXISTS `tbl_race_ratings_reviews` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `race_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `rating` int(11) NOT NULL,
  `review` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tbl_race_ratings_reviews`
--


-- --------------------------------------------------------

--
-- Table structure for table `tbl_user`
--

DROP TABLE IF EXISTS `tbl_user`;
CREATE TABLE IF NOT EXISTS `tbl_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `full_name` text NOT NULL COMMENT 'User Full name',
  `fb_id` text NOT NULL COMMENT 'facebook id if logged in using facebook',
  `email` text NOT NULL COMMENT 'email addres',
  `city` text NOT NULL COMMENT 'user city',
  `user_name` text NOT NULL COMMENT 'username(most probably email address,if logged in using fb,fb id will be used',
  `password` text NOT NULL COMMENT 'user password',
  `race_completed` int(11) NOT NULL,
  `race_created` int(11) NOT NULL,
  `gps_rank` int(11) NOT NULL,
  `user_latitude` text NOT NULL,
  `user_longitude` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `tbl_user`
--

INSERT INTO `tbl_user` (`id`, `full_name`, `fb_id`, `email`, `city`, `user_name`, `password`, `race_completed`, `race_created`, `gps_rank`, `user_latitude`, `user_longitude`) VALUES
(1, 'test', '', 'test@gmail.com', 'test123', 'test@gmail.com', 'test', 0, 0, 0, '51.509980', '-0.133700'),
(2, 'Test', '', 'test@astroninfotech.com', 'Ahmedabad', 'test@astroninfotech.com', 'test123', 0, 0, 0, '', ''),
(6, 'Nirav Sun', '100003522159987', 'test@sunshineinfotech.com', 'ahmeda', 'test@sunshineinfotech.com', '', 0, 0, 0, '0.000000', '-122.406417'),
(7, 'Chirag purohit', '', 'chirag@test.com', 'ahmedabad', 'chirag@test.com', 'chirag', 0, 0, 0, '', '');
