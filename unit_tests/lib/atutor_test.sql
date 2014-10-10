-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Oct 08, 2014 at 11:43 PM
-- Server version: 5.5.24-log
-- PHP Version: 5.4.3

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `atutor_test`
--

-- --------------------------------------------------------

--
-- Table structure for table `AT_admins`
--

CREATE TABLE IF NOT EXISTS `AT_admins` (
  `login` varchar(30) NOT NULL DEFAULT '',
  `password` varchar(40) NOT NULL DEFAULT '',
  `real_name` varchar(120) NOT NULL DEFAULT '',
  `email` varchar(50) NOT NULL DEFAULT '',
  `language` varchar(5) NOT NULL DEFAULT '',
  `privileges` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `last_login` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`login`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `AT_admins`
--

INSERT INTO `AT_admins` (`login`, `password`, `real_name`, `email`, `language`, `privileges`, `last_login`) VALUES
('admin', '67f74ff9ce17dd8de3bf6bc439205d08bb02f8e1', '', 'admin@localhost.com', 'en', 1, '2014-10-02 19:19:54');

-- --------------------------------------------------------

--
-- Table structure for table `AT_admin_log`
--

CREATE TABLE IF NOT EXISTS `AT_admin_log` (
  `login` varchar(30) NOT NULL DEFAULT '',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `operation` varchar(20) NOT NULL DEFAULT '',
  `table` varchar(30) NOT NULL DEFAULT '',
  `num_affected` tinyint(3) NOT NULL DEFAULT '0',
  `details` text,
  KEY `login` (`login`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `AT_assignments`
--

CREATE TABLE IF NOT EXISTS `AT_assignments` (
  `assignment_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `course_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `title` varchar(240) NOT NULL DEFAULT '',
  `assign_to` mediumint(8) unsigned DEFAULT '0',
  `date_due` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_cutoff` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `multi_submit` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`assignment_id`),
  KEY `course_id` (`course_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_auto_enroll`
--

CREATE TABLE IF NOT EXISTS `AT_auto_enroll` (
  `auto_enroll_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `associate_string` varchar(10) NOT NULL,
  `name` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`auto_enroll_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_auto_enroll_courses`
--

CREATE TABLE IF NOT EXISTS `AT_auto_enroll_courses` (
  `auto_enroll_courses_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `auto_enroll_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `course_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`auto_enroll_courses_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_backups`
--

CREATE TABLE IF NOT EXISTS `AT_backups` (
  `backup_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `course_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `description` text,
  `file_size` int(10) unsigned NOT NULL DEFAULT '0',
  `system_file_name` varchar(50) NOT NULL DEFAULT '',
  `file_name` text,
  `contents` text,
  PRIMARY KEY (`backup_id`),
  KEY `course_id` (`course_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_basiclti_content`
--

CREATE TABLE IF NOT EXISTS `AT_basiclti_content` (
  `id` mediumint(10) NOT NULL AUTO_INCREMENT,
  `content_id` mediumint(10) NOT NULL DEFAULT '0',
  `course_id` mediumint(10) NOT NULL DEFAULT '0',
  `toolid` varchar(32) NOT NULL DEFAULT '',
  `preferheight` mediumint(4) NOT NULL DEFAULT '0',
  `sendname` mediumint(1) NOT NULL DEFAULT '0',
  `sendemailaddr` mediumint(1) NOT NULL DEFAULT '0',
  `gradebook_test_id` mediumint(10) NOT NULL DEFAULT '0',
  `allowroster` mediumint(1) NOT NULL DEFAULT '0',
  `allowsetting` mediumint(1) NOT NULL DEFAULT '0',
  `customparameters` text,
  `launchinpopup` mediumint(1) NOT NULL DEFAULT '0',
  `debuglaunch` mediumint(1) NOT NULL DEFAULT '0',
  `placementsecret` varchar(1023) DEFAULT NULL,
  `timeplacementsecret` mediumint(10) NOT NULL DEFAULT '0',
  `oldplacementsecret` varchar(1023) DEFAULT NULL,
  `setting` text,
  `xmlimport` text,
  PRIMARY KEY (`id`,`course_id`,`content_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_basiclti_tools`
--

CREATE TABLE IF NOT EXISTS `AT_basiclti_tools` (
  `id` mediumint(10) NOT NULL AUTO_INCREMENT,
  `toolid` varchar(32) NOT NULL,
  `course_id` mediumint(10) NOT NULL DEFAULT '0',
  `title` varchar(255) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `timecreated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `timemodified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `toolurl` varchar(1023) NOT NULL,
  `resourcekey` varchar(1023) NOT NULL,
  `password` varchar(1023) NOT NULL,
  `preferheight` mediumint(4) NOT NULL DEFAULT '0',
  `allowpreferheight` mediumint(1) NOT NULL DEFAULT '0',
  `sendname` mediumint(1) NOT NULL DEFAULT '0',
  `sendemailaddr` mediumint(1) NOT NULL DEFAULT '0',
  `acceptgrades` mediumint(1) NOT NULL DEFAULT '0',
  `allowroster` mediumint(1) NOT NULL DEFAULT '0',
  `allowsetting` mediumint(1) NOT NULL DEFAULT '0',
  `allowcustomparameters` mediumint(1) NOT NULL DEFAULT '0',
  `customparameters` text,
  `organizationid` varchar(64) DEFAULT NULL,
  `organizationurl` varchar(255) DEFAULT NULL,
  `organizationdescr` varchar(255) DEFAULT NULL,
  `launchinpopup` mediumint(1) NOT NULL DEFAULT '0',
  `debuglaunch` mediumint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`toolid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_blog_posts`
--

CREATE TABLE IF NOT EXISTS `AT_blog_posts` (
  `post_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `member_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `owner_type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `owner_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `private` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `num_comments` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `title` varchar(255) NOT NULL,
  `body` text,
  PRIMARY KEY (`post_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_blog_posts_comments`
--

CREATE TABLE IF NOT EXISTS `AT_blog_posts_comments` (
  `comment_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `member_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `private` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `comment` text,
  PRIMARY KEY (`comment_id`),
  KEY `post_id` (`post_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_blog_subscription`
--

CREATE TABLE IF NOT EXISTS `AT_blog_subscription` (
  `group_id` mediumint(9) NOT NULL,
  `member_id` mediumint(9) NOT NULL,
  PRIMARY KEY (`group_id`,`member_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `AT_calendar_bookmark`
--

CREATE TABLE IF NOT EXISTS `AT_calendar_bookmark` (
  `memberid` int(11) DEFAULT NULL,
  `ownerid` int(8) DEFAULT NULL,
  `courseid` int(8) DEFAULT NULL,
  `calname` varchar(256) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `AT_calendar_events`
--

CREATE TABLE IF NOT EXISTS `AT_calendar_events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(256) DEFAULT NULL,
  `start` datetime DEFAULT NULL,
  `end` datetime DEFAULT NULL,
  `allDay` varchar(20) DEFAULT NULL,
  `userid` int(8) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_calendar_google_sync`
--

CREATE TABLE IF NOT EXISTS `AT_calendar_google_sync` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` varchar(256) DEFAULT NULL,
  `userid` int(8) DEFAULT NULL,
  `calids` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_calendar_notification`
--

CREATE TABLE IF NOT EXISTS `AT_calendar_notification` (
  `memberid` int(11) DEFAULT NULL,
  `status` int(8) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `AT_config`
--

CREATE TABLE IF NOT EXISTS `AT_config` (
  `name` char(30) NOT NULL DEFAULT '',
  `value` text,
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `AT_config`
--

INSERT INTO `AT_config` (`name`, `value`) VALUES
('encyclopedia', 'http://www.wikipedia.org'),
('dictionary', 'http://dictionary.reference.com/'),
('thesaurus', 'http://thesaurus.reference.com/'),
('atlas', 'http://maps.google.ca/'),
('calculator', 'http://www.calculateforfree.com/'),
('note_taking', 'http://www.aypwip.org/webnote/'),
('abacas', 'http://www.mandarintools.com/abacus.html'),
('pa_max_memory_per_member', '50'),
('transformable_uri', 'http://acontent.atutorspaces.com/'),
('transformable_web_service_id', '987f65dddffa43abd43b30426e6c7c1c'),
('transformable_oauth_expire', '93600'),
('home_url', 'http://www.atutorspaces.com'),
('site_name', 'Course Server'),
('contact_email', 'abhinav.koppula@gmail.com'),
('set_utf8', '1'),
('session_path', '/open_source/new_AT/ATutor_test/');

-- --------------------------------------------------------

--
-- Table structure for table `AT_content`
--

CREATE TABLE IF NOT EXISTS `AT_content` (
  `content_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `course_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `content_parent_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ordering` mediumint(8) NOT NULL DEFAULT '0',
  `last_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `revision` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `formatting` tinyint(4) NOT NULL DEFAULT '0',
  `release_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `keywords` text,
  `content_path` text,
  `title` varchar(255) NOT NULL,
  `text` text,
  `head` text,
  `use_customized_head` tinyint(4) NOT NULL,
  `test_message` text,
  `allow_test_export` tinyint(1) unsigned NOT NULL,
  `content_type` tinyint(1) unsigned NOT NULL,
  PRIMARY KEY (`content_id`),
  KEY `course_id` (`course_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_content_forums_assoc`
--

CREATE TABLE IF NOT EXISTS `AT_content_forums_assoc` (
  `content_id` int(10) unsigned NOT NULL,
  `forum_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`content_id`,`forum_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `AT_content_prerequisites`
--

CREATE TABLE IF NOT EXISTS `AT_content_prerequisites` (
  `content_id` mediumint(9) NOT NULL,
  `type` varchar(50) NOT NULL DEFAULT '',
  `item_id` mediumint(9) NOT NULL,
  PRIMARY KEY (`content_id`,`type`,`item_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `AT_content_tests_assoc`
--

CREATE TABLE IF NOT EXISTS `AT_content_tests_assoc` (
  `content_id` int(10) unsigned NOT NULL,
  `test_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`content_id`,`test_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `AT_courses`
--

CREATE TABLE IF NOT EXISTS `AT_courses` (
  `course_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `member_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `cAT_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `content_packaging` enum('none','top','all') NOT NULL DEFAULT 'top',
  `access` enum('public','protected','private') NOT NULL DEFAULT 'public',
  `created_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `title` varchar(255) NOT NULL,
  `description` text,
  `course_dir_name` varchar(255) NOT NULL,
  `notify` tinyint(4) NOT NULL DEFAULT '0',
  `max_quota` varchar(30) NOT NULL DEFAULT '',
  `max_file_size` varchar(30) NOT NULL DEFAULT '',
  `hide` tinyint(4) NOT NULL DEFAULT '0',
  `copyright` text,
  `primary_language` varchar(5) NOT NULL DEFAULT '',
  `rss` tinyint(4) NOT NULL DEFAULT '0',
  `icon` varchar(75) NOT NULL DEFAULT '',
  `home_links` text,
  `main_links` text,
  `side_menu` varchar(255) NOT NULL DEFAULT '',
  `release_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `end_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `banner` text,
  `home_view` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`course_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_course_access`
--

CREATE TABLE IF NOT EXISTS `AT_course_access` (
  `password` char(8) NOT NULL,
  `course_id` mediumint(8) unsigned NOT NULL,
  `expiry_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `enabled` tinyint(4) NOT NULL,
  PRIMARY KEY (`password`),
  UNIQUE KEY `course_id` (`course_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `AT_course_cats`
--

CREATE TABLE IF NOT EXISTS `AT_course_cats` (
  `cAT_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `cAT_name` varchar(255) NOT NULL,
  `cAT_parent` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `theme` varchar(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`cAT_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_course_enrollment`
--

CREATE TABLE IF NOT EXISTS `AT_course_enrollment` (
  `member_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `course_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `approved` enum('y','n','a') NOT NULL DEFAULT 'n',
  `privileges` int(10) unsigned NOT NULL DEFAULT '0',
  `role` varchar(35) NOT NULL DEFAULT '',
  `last_cid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`member_id`,`course_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `AT_course_stats`
--

CREATE TABLE IF NOT EXISTS `AT_course_stats` (
  `course_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `login_date` date NOT NULL DEFAULT '0000-00-00',
  `guests` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `members` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`course_id`,`login_date`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `AT_external_resources`
--

CREATE TABLE IF NOT EXISTS `AT_external_resources` (
  `resource_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `course_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `title` varchar(255) NOT NULL,
  `author` varchar(150) NOT NULL,
  `publisher` varchar(150) NOT NULL,
  `date` varchar(20) NOT NULL DEFAULT '',
  `comments` text,
  `id` varchar(50) NOT NULL DEFAULT '',
  `url` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`resource_id`),
  KEY `course_id` (`course_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_faq_entries`
--

CREATE TABLE IF NOT EXISTS `AT_faq_entries` (
  `entry_id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `topic_id` mediumint(8) NOT NULL DEFAULT '0',
  `revised_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `approved` tinyint(4) NOT NULL DEFAULT '0',
  `question` text,
  `answer` text,
  PRIMARY KEY (`entry_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_faq_topics`
--

CREATE TABLE IF NOT EXISTS `AT_faq_topics` (
  `topic_id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `course_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `name` text,
  PRIMARY KEY (`topic_id`),
  KEY `course_id` (`course_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_feeds`
--

CREATE TABLE IF NOT EXISTS `AT_feeds` (
  `feed_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `url` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`feed_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_fha_student_tools`
--

CREATE TABLE IF NOT EXISTS `AT_fha_student_tools` (
  `course_id` mediumint(8) unsigned NOT NULL,
  `links` text,
  `home_view` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`course_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `AT_files`
--

CREATE TABLE IF NOT EXISTS `AT_files` (
  `file_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `owner_type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `owner_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `member_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `folder_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `parent_file_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `num_comments` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `num_revisions` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `file_name` varchar(80) NOT NULL DEFAULT '',
  `file_size` int(11) NOT NULL DEFAULT '0',
  `description` text,
  PRIMARY KEY (`file_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_files_comments`
--

CREATE TABLE IF NOT EXISTS `AT_files_comments` (
  `comment_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `file_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `member_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `comment` text,
  PRIMARY KEY (`comment_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_file_storage_groups`
--

CREATE TABLE IF NOT EXISTS `AT_file_storage_groups` (
  `group_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `AT_folders`
--

CREATE TABLE IF NOT EXISTS `AT_folders` (
  `folder_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `parent_folder_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `owner_type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `owner_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `title` varchar(120) NOT NULL DEFAULT '',
  PRIMARY KEY (`folder_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_forums`
--

CREATE TABLE IF NOT EXISTS `AT_forums` (
  `forum_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(240) NOT NULL DEFAULT '',
  `description` text,
  `num_topics` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `num_posts` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `last_post` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `mins_to_edit` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`forum_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_forums_accessed`
--

CREATE TABLE IF NOT EXISTS `AT_forums_accessed` (
  `post_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `member_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `last_accessed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `subscribe` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`post_id`,`member_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `AT_forums_courses`
--

CREATE TABLE IF NOT EXISTS `AT_forums_courses` (
  `forum_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `course_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`forum_id`,`course_id`),
  KEY `course_id` (`course_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `AT_forums_groups`
--

CREATE TABLE IF NOT EXISTS `AT_forums_groups` (
  `forum_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `group_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`forum_id`,`group_id`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `AT_forums_subscriptions`
--

CREATE TABLE IF NOT EXISTS `AT_forums_subscriptions` (
  `forum_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `member_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`forum_id`,`member_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `AT_forums_threads`
--

CREATE TABLE IF NOT EXISTS `AT_forums_threads` (
  `post_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `member_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `forum_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `last_comment` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `num_comments` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `subject` varchar(255) NOT NULL,
  `body` text,
  `date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `locked` tinyint(4) NOT NULL DEFAULT '0',
  `sticky` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`post_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_glossary`
--

CREATE TABLE IF NOT EXISTS `AT_glossary` (
  `word_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `course_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `word` varchar(240) NOT NULL DEFAULT '',
  `definition` text,
  `related_word_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`word_id`),
  KEY `course_id` (`course_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_gradebook_detail`
--

CREATE TABLE IF NOT EXISTS `AT_gradebook_detail` (
  `gradebook_test_id` mediumint(8) unsigned NOT NULL,
  `member_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `grade` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`gradebook_test_id`,`member_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `AT_gradebook_tests`
--

CREATE TABLE IF NOT EXISTS `AT_gradebook_tests` (
  `gradebook_test_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Values: 0, tests.test_id or assignments.assignment_id. 0 for external tests/assignments. tests.test_id for ATutor tests, assignments.assignment_id for ATutor assignments.',
  `type` varchar(50) NOT NULL DEFAULT '' COMMENT 'Values: ATutor Test, ATutor Assignment, External',
  `course_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Values: 0 or courses.course_id. Only has value for external tests/assignments. When ATutor internal assignments/tests/surveys, always 0.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'Values: Null or test name. Always null if ATutor internal assignments/tests/surveys.',
  `due_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `grade_scale_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`gradebook_test_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_grade_scales`
--

CREATE TABLE IF NOT EXISTS `AT_grade_scales` (
  `grade_scale_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `member_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `scale_name` varchar(255) NOT NULL DEFAULT '',
  `created_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`grade_scale_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `AT_grade_scales`
--

INSERT INTO `AT_grade_scales` (`grade_scale_id`, `member_id`, `scale_name`, `created_date`) VALUES
(1, 0, 'Letter Grade', '2014-10-03 00:49:12'),
(2, 0, 'Competency 1', '2014-10-03 00:49:12'),
(3, 0, 'Competency 2', '2014-10-03 00:49:12');

-- --------------------------------------------------------

--
-- Table structure for table `AT_grade_scales_detail`
--

CREATE TABLE IF NOT EXISTS `AT_grade_scales_detail` (
  `grade_scale_id` mediumint(8) unsigned NOT NULL,
  `scale_value` varchar(50) NOT NULL DEFAULT '',
  `percentage_from` mediumint(9) NOT NULL DEFAULT '0',
  `percentage_to` mediumint(9) NOT NULL DEFAULT '0',
  PRIMARY KEY (`grade_scale_id`,`scale_value`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `AT_grade_scales_detail`
--

INSERT INTO `AT_grade_scales_detail` (`grade_scale_id`, `scale_value`, `percentage_from`, `percentage_to`) VALUES
(1, 'A+', 90, 100),
(1, 'A', 80, 89),
(1, 'B', 70, 79),
(1, 'C', 60, 69),
(1, 'D', 50, 59),
(1, 'E', 0, 49),
(2, 'Pass', 75, 100),
(2, 'Fail', 0, 74),
(3, 'Excellent', 80, 100),
(3, 'Good', 70, 79),
(3, 'Adequate', 60, 69),
(3, 'Inadequate', 0, 59);

-- --------------------------------------------------------

--
-- Table structure for table `AT_groups`
--

CREATE TABLE IF NOT EXISTS `AT_groups` (
  `group_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `type_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `title` varchar(80) NOT NULL DEFAULT '',
  `description` text,
  `modules` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_groups_members`
--

CREATE TABLE IF NOT EXISTS `AT_groups_members` (
  `group_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `member_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`group_id`,`member_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `AT_groups_types`
--

CREATE TABLE IF NOT EXISTS `AT_groups_types` (
  `type_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `course_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `title` varchar(80) NOT NULL,
  PRIMARY KEY (`type_id`),
  KEY `course_id` (`course_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_guests`
--

CREATE TABLE IF NOT EXISTS `AT_guests` (
  `guest_id` varchar(10) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `organization` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `focus` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`guest_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `AT_handbook_notes`
--

CREATE TABLE IF NOT EXISTS `AT_handbook_notes` (
  `note_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `section` varchar(15) NOT NULL DEFAULT '',
  `page` varchar(50) NOT NULL DEFAULT '',
  `approved` tinyint(4) NOT NULL DEFAULT '0',
  `email` varchar(50) NOT NULL DEFAULT '',
  `note` text,
  PRIMARY KEY (`note_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_instructor_approvals`
--

CREATE TABLE IF NOT EXISTS `AT_instructor_approvals` (
  `member_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `request_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `notes` text,
  PRIMARY KEY (`member_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `AT_languages`
--

CREATE TABLE IF NOT EXISTS `AT_languages` (
  `language_code` varchar(20) NOT NULL DEFAULT '',
  `char_set` varchar(80) NOT NULL DEFAULT '',
  `direction` varchar(16) NOT NULL DEFAULT '',
  `reg_exp` varchar(124) NOT NULL DEFAULT '',
  `native_name` varchar(80) NOT NULL DEFAULT '',
  `english_name` varchar(80) NOT NULL DEFAULT '',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`language_code`,`char_set`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `AT_language_pages`
--

CREATE TABLE IF NOT EXISTS `AT_language_pages` (
  `term` varchar(50) NOT NULL DEFAULT '',
  `page` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`term`,`page`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `AT_language_pages`
--

INSERT INTO `AT_language_pages` (`term`, `page`) VALUES
('about_atutor', '/login.php'),
('announcement_date_format', '/login.php'),
('assignment_dropbox_text', '/login.php'),
('basiclti_content_text', '/login.php'),
('basiclti_tool', '/login.php'),
('browse_courses', '/login.php'),
('content', '/login.php'),
('copyright', '/login.php'),
('course_admin_tools', '/login.php'),
('date_friday', '/login.php'),
('date_october', '/login.php'),
('export_content_text', '/login.php'),
('general_help', '/login.php'),
('google_search_text', '/login.php'),
('goto_content', '/login.php'),
('goto_main_nav', '/login.php'),
('goto_menu', '/login.php'),
('gradebook_text', '/login.php'),
('groups_text', '/login.php'),
('guest', '/login.php'),
('help', '/login.php'),
('hide', '/login.php'),
('hide_sub_navigation', '/login.php'),
('home', '/login.php'),
('login', '/login.php'),
('login_name_or_email', '/login.php'),
('login_text', '/login.php'),
('navigation', '/login.php'),
('new_user', '/login.php'),
('open_sub_navigation', '/login.php'),
('password', '/login.php'),
('password_reminder', '/login.php'),
('register', '/login.php'),
('registration_text', '/login.php'),
('returning_user', '/login.php'),
('search', '/login.php'),
('show', '/login.php'),
('sitemap_text', '/login.php'),
('social', '/login.php'),
('student_tools_text', '/login.php'),
('sub_nav_hidden', '/login.php'),
('sub_nav_opened', '/login.php'),
('test', '/login.php'),
('tile_search_text', '/login.php'),
('tools', '/login.php');

-- --------------------------------------------------------

--
-- Table structure for table `AT_language_text`
--

CREATE TABLE IF NOT EXISTS `AT_language_text` (
  `language_code` varchar(5) NOT NULL DEFAULT '',
  `variable` varchar(30) NOT NULL DEFAULT '',
  `term` varchar(50) NOT NULL DEFAULT '',
  `text` blob NOT NULL,
  `revised_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `context` text NOT NULL,
  PRIMARY KEY (`language_code`,`variable`,`term`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `AT_language_text`
--

INSERT INTO `AT_language_text` (`language_code`, `variable`, `term`, `text`, `revised_date`, `context`) VALUES
('en', '_module', 'bbb_admin_setup', 0x426967426c7565427574746f6e20436f6e66696775726174696f6e, '2013-08-01 10:18:14', ''),
('en', '_module', 'bbb_config', 0x426967426c7565427574746f6e20436f6e66696775726174696f6e, '2013-08-01 10:18:14', ''),
('en', '_module', 'bbb_config_text', 0x456e746572207468652055524c20746f2074686520426967426c7565427574746f6e2062617365206c6f636174696f6e2c20616e64207468652053414c5420736563757269747920746f6b656e2e205468652053414c5420746f6b656e20697320612033322063686172616374657220737472696e6720666f756e6420696e2074686520626967626c7565627574746f6e2e70726f706572746965732066696c65206f6620796f75722042424220696e7374616c6c6174696f6e2e20456e74657220746865206d6178696d756d206e756d626572206f66207265636f7264696e677320616c6c6f7765642070657220636f7572736520746f206c696d69742074686520616d6f756e74206f66207370616365206f6363757069656420627920424242206d656574696e67207265636f7264696e67732e20536574206d6178696d756d207265636f7264696e677320746f203020746f2064697361626c65207265636f7264696e67732e20, '2013-08-01 10:18:14', ''),
('en', '_module', 'bbb_continue_text', 0x596f75206172652061626f757420746f206c6561766520415475746f7220616e64206163636573732074686520426967426c7565427574746f6e20766964656f20636f6e666572656e63696e672073797374656d2c206120466c6173682d6261736564206170706c69636174696f6e2e20496620796f752066696e6420796f752061726520756e61626c6520746f206163636573732074686520766964656f20636f6e666572656e63696e672073797374656d207769746820796f75722061737369737469766520746563686e6f6c6f67792c2075736520796f75722062726f77736572206261636b20627574746f6e2c20746f206261636b206f7574206f66207468652073797374656d2e20436f6e7461637420796f757220696e7374727563746f7220666f722064657461696c73206f6e20686f7720746f20616363657373207265636f7264696e6773206f6620766964656f20636f6e666572656e6365206d656574696e67732e, '2013-08-01 10:18:14', ''),
('en', '_module', 'bbb_continue_yes', 0x446f20796f75207769736820746f20636f6e74696e75653a, '2013-08-01 10:18:14', ''),
('en', '_module', 'bbb_course_name', 0x436f75727365205469746c65, '2013-08-01 10:18:14', ''),
('en', '_module', 'bbb_course_title', 0x436f75727365205469746c65, '2013-08-01 10:18:14', ''),
('en', '_module', 'bbb_create_edit_meeting', 0x4372656174652f45646974204d656574696e67, '2013-08-01 10:18:14', ''),
('en', '_module', 'bbb_create_meeting', 0x437265617465204d656574696e67, '2013-08-01 10:18:14', ''),
('en', '_module', 'bbb_create_meeting_text', 0x437265617465204d656574696e6773, '2013-08-01 10:18:14', ''),
('en', '_module', 'bbb_current_meetings', 0x4d616e61676520426967426c7565427574746f6e204d656574696e6773, '2013-08-01 10:18:14', ''),
('en', '_module', 'bbb_delete_recording', 0x44656c657465205265636f7264696e67, '2013-08-01 10:18:14', ''),
('en', '_module', 'bbb_edit_meeting', 0x45646974204d656574696e67, '2013-08-01 10:18:14', ''),
('en', '_module', 'bbb_join', 0x4a6f696e, '2013-08-01 10:18:14', ''),
('en', '_module', 'bbb_join_conference', 0x4a6f696e20436f6e666572656e6365, '2013-08-01 10:18:14', ''),
('en', '_module', 'bbb_join_meeting', 0x4a6f696e206173204d656574696e67, '2013-08-01 10:18:14', ''),
('en', '_module', 'bbb_join_meeting_moderate', 0x4a6f696e206173204d6f64657261746f72, '2013-08-01 10:18:14', ''),
('en', '_module', 'bbb_max_recording', 0x4d6178696d756d205265636f7264696e67732070657220436f75727365, '2013-08-01 10:18:14', ''),
('en', '_module', 'bbb_meeting_ended', 0x456e646564, '2013-08-01 10:18:14', ''),
('en', '_module', 'bbb_meeting_name', 0x4d656574696e67205469746c65, '2013-08-01 10:18:14', ''),
('en', '_module', 'bbb_meeting_over', 0x456e646564, '2013-08-01 10:18:14', ''),
('en', '_module', 'bbb_meeting_pending', 0x50656e64696e67, '2013-08-01 10:18:14', ''),
('en', '_module', 'bbb_meeting_running', 0x52756e6e696e67, '2013-08-01 10:18:14', ''),
('en', '_module', 'bbb_meeting_status', 0x537461747573, '2013-08-01 10:18:14', ''),
('en', '_module', 'bbb_meeting_time', 0x4d656574696e672054696d65, '2013-08-01 10:18:14', ''),
('en', '_module', 'bbb_message', 0x4d656574696e67204465736372697074696f6e, '2013-08-01 10:18:14', ''),
('en', '_module', 'bbb_no_cancel', 0x4e6f2c2043616e63656c, '2013-08-01 10:18:14', ''),
('en', '_module', 'bbb_no_meeting', 0x54686973206d656574696e6720686173206e6f742073746172746564207965742e2049742077696c6c206265636f6d6520617661696c61626c65207768656e20746865206d6f64657261746f72206c6f677320696e2e20436865636b206261636b206865726520617420746865207363686564756c6564206d656574696e672074696d652e203c6120687265663d226d6f64732f626967626c7565627574746f6e2f696e6465782e706870223e52657475726e204d656574696e6773204c6973743c2f613e, '2013-08-01 10:18:14', ''),
('en', '_module', 'bbb_no_recording', 0x4e6f205265636f7264696e6773, '2013-08-01 10:18:14', ''),
('en', '_module', 'bbb_open_new_win', 0x4f70656e20426967426c7565427574746f6e20696e2061204e65772057696e646f77, '2013-08-01 10:18:14', ''),
('en', '_module', 'bbb_recordings', 0x5265636f7264696e6773, '2013-08-01 10:18:14', ''),
('en', '_module', 'bbb_record_conference', 0x5265636f726420436f6e666572656e6365, '2013-08-01 10:18:14', ''),
('en', '_module', 'bbb_salt ', 0x426967426c7565427574746f6e2053414c5420536563757269747920546f6b656e, '2013-08-01 10:18:14', ''),
('en', '_module', 'bbb_url', 0x426967426c7565427574746f6e2055524c, '2013-08-01 10:18:14', ''),
('en', '_module', 'bbb_view_meeting', 0x56696577204d656574696e67, '2013-08-01 10:18:14', ''),
('en', '_module', 'bbb_view_recording', 0x56696577205265636f7264696e67, '2013-08-01 10:18:14', ''),
('en', '_module', 'bbb_welcome', 0x596f752068617665206a6f696e656420746865206d656574696e672e, '2013-08-01 10:18:14', ''),
('en', '_module', 'bbb_yes_join', 0x5965732c204a6f696e, '2013-08-01 10:18:14', ''),
('en', '_module', 'bigbluebutton', 0x426967426c7565427574746f6e, '2013-08-01 10:18:14', ''),
('en', '_module', 'bigbluebutton_text', 0x412073616d706c6520424242207465787420666f722064657461696c656420686f6d65706167652e, '2013-08-01 10:18:14', ''),
('en', '_module', 'calendar', 0x43616c656e646172, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_assignment_cut', 0x437574206f66662064617465206f6620, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_assignment_due', 0x4475652064617465206f6620, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_bookmarkd', 0x426f6f6b6d61726b65642043616c656e64617273, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_bookmark_this', 0x426f6f6b6d61726b20746869732043616c656e646172, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_cancel_e', 0x43616e63656c, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_connect_gcal', 0x436f6e6e656374207769746820476f6f676c652043616c656e646172, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_course_end', 0x456e642064617465206f6620, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_course_start', 0x52656c656173652064617465206f6620, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_course_token', 0x20636f75727365, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_creAT_e', 0x437265617465204576656e74, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_day', 0x446179, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_del_bookmark', 0x52656d6f766520426f6f6b6d61726b, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_del_e', 0x44656c657465204576656e74, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_disconnect_gcal', 0x446973636f6e6e6563742066726f6d20476f6f676c652043616c656e646172, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_edit_e', 0x53617665, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_edit_title', 0x45646974205469746c65, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_email_part1', 0x206861732073686172656420, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_email_part2', 0x207769746820796f752e20596f75206d61792062726f7773652063616c656e6461722061743a200d0a, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_error', 0x4572726f723a20, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_events_assign_cut', 0x41737369676e6d656e7420437574206f66662044617465, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_events_assign_due', 0x41737369676e6d656e74204475652044617465, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_events_course_end', 0x436f7572736520456e642044617465, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_events_course_rel', 0x436f757273652052656c656173652044617465, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_events_persnl', 0x506572736f6e616c204576656e7473, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_events_test_end', 0x5465737420456e642044617465, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_events_test_start', 0x546573742053746172742044617465, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_export_file', 0x4578706f7274206963732066696c65, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_form_end_d', 0x456e6420446174652028797979792d6d6d2d646429, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_form_end_t', 0x456e642054696d6520283234686f75727329, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_form_start_d', 0x537461727420446174652028797979792d6d6d2d646429, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_form_start_t', 0x53746172742054696d6520283234686f75727329, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_form_title', 0x4576656e74205469746c65, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_form_title_def', 0x4576656e74204e616d65, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_gcals', 0x476f6f676c652043616c656e64617273, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_header', 0x43616c656e646172, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_import_file', 0x496d706f7274206963732066696c65, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_internal_events', 0x415475746f7220496e7465726e616c204576656e7473, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_mailtxt', 0x456e74657220656d61696c, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_mail_title', 0x5368617265642043616c656e646172, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_manemail', 0x456e74657220656d61696c2061646472657373, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_membrselect', 0x53656c656374206d656d626572, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_month', 0x4d6f6e7468, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_next', 0x4e657874, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_notification', 0x456d61696c204e6f74696669636174696f6e73, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_noti_mail_1', 0x4576656e747320666f7220746f6d6f72726f773a20, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_noti_mail_2', 0x4576656e74, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_noti_mail_3', 0x5374617274, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_noti_mail_4', 0x456e64, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_noti_mail_5', 0x4576656e74, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_noti_off', 0x4f6666, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_noti_on', 0x4f6e, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_noti_title', 0x415475746f722043616c656e646172204e6f74696669636174696f6e, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_noti_turn', 0x5475726e, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_no_one_else', 0x596f752061726520746865206f6e6c79206f6e6520696e207468697320636f757273652c206e6f20617661696c61626c6520726563697069656e74732e, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_nxt_day', 0x4e65787420446179, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_nxt_mnth', 0x4e657874204d6f6e7468, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_nxt_week', 0x4e657874205765656b, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_of', 0x43616c656e646172206f66, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_optional_fld', 0x4f7074696f6e616c3a20496620746865207469746c65206973206e6f74207370656369666965642c2064656661756c74207469746c652077696c6c2062652073657420746f202243616c656e646172206f6620, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_options', 0x43616c656e646172204f7074696f6e73, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_patch_error', 0x496e7374616c6c2050617463682046697273742e, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_prev', 0x50726576696f7573, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_prv_day', 0x50726576696f757320446179, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_prv_mnth', 0x50726576696f7573204d6f6e7468, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_prv_week', 0x50726576696f7573205765656b, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_public_note1', 0x596f752063616e, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_public_note2', 0x6c6f67696e, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_public_note3', 0x746f20626f6f6b6d61726b20746869732063616c656e6461722e, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_pub_def_msg', 0x55736520746869732074616220746f2076696577207368617265642063616c656e6461722e, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_save', 0x53617665, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_sellist', 0x53656c6563742066726f6d206c697374, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_sendall', 0x53656e6420746f20616c6c206f746865722073747564656e747320696e207468697320636f75727365, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_share', 0x53686172652043616c656e646172, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_submit', 0x5375626d6974, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_test_end', 0x456e642064617465206f6620, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_test_start', 0x53746172742064617465206f6620, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_test_token', 0x2074657374, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_titletxt', 0x5469746c65206f662043616c656e646172, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_today', 0x546f646179, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_tooltip_cell', 0x436c69636b206f7220707265737320656e74657220746f20637265617465206576656e74, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_tooltip_event', 0x436c69636b206f7220707265737320656e74657220746f2065646974206576656e74, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_uneditable', 0x556e6564697461626c65206576656e74, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_upload_file', 0x55706c6f6164206963732066696c65, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_viewcal', 0x56696577, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_view_title', 0x56696577205368617265642043616c656e646172, '2013-09-11 17:54:32', ''),
('en', '_module', 'calendar_week', 0x5765656b, '2013-09-11 17:54:32', ''),
('en', '_module', 'ecomm', 0x5061796d656e7473, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_acceptmastercard', 0x416363657074696e67204d61737465722043617264, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_acceptvisa', 0x416363657074696e672056697361, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_action', 0x416374696f6e, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_address', 0x41646472657373, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_admin_payment_mail_instruction', 0x41207061796d656e7420686173206265656e206d61646520666f7220636f757273653a2025732e20546f2072657669657720746865207061796d656e74206c6f67696e20746f20415475746f7220617320616e2061646d696e6973747261746f7220616e642073656c65637420746865205061796d656e7473207461622e, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_allow_instructors', 0x416c6c6f7720696e7374727563746f727320746f206d616e616765207061796d656e747320, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_amount', 0x416d6f756e74, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_amount_recieved', 0x416d6f756e74205265636569766564, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_approve_manually', 0x417070726f7665204d616e75616c6c79, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_auto_approve', 0x4175746f20617070726f766520656e726f6c6c6d656e74207768656e2066656520686173206265656e207061696420, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_auto_email', 0x456d61696c20696e7374727563746f72207768656e2061207061796d656e7420686173206265656e207265636569766564, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_balance_due', 0x42616c616e636520447565, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_cancel', 0x43616e63656c, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_cc_cvd_info', 0x2833206f722034206469676974206e756d626572206f6e20746865206261636b206f6620746865206361726429, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_cc_cvd_number', 0x4361726420435644204e756d626572, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_cc_expiry_month', 0x457870697279204d6f6e7468, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_cc_expiry_year', 0x4578706972792059656172, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_cc_number', 0x4372656469742043617264204e756d626572, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_comments', 0x436f6d6d656e7473, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_complete_thisinfo', 0x436f6d706c6574652074686520696e666f726d6174696f6e2062656c6f772e20, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_confirm_info', 0x5265766965772074686520666f6c6c6f77696e6720696e666f726d6174696f6e206265666f72652070726f63656564696e672e2049662074686520696e666f726d6174696f6e20697320636f72726563742c20636c69636b207468652050617920627920437265646974204361726420627574746f6e20286f72205061792062792043686571756520696620656e61626c65642920746f206d6f7665206f6e20746f20746865206e65787420737465702e, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_contact_address', 0x4164647265737320776865726520636865717565732073686f756c642062652073656e742e20286c6561766520656d70747920746f2064697361626c656420636865717565207061796d656e747329, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_contact_email', 0x454d61696c206e6f74696669636174696f6e206f66207061796d656e747320746f3a2028696620646966666572656e742066726f6d2074686520415475746f7220636f6e7461637420656d61696c2c2073657420696e2053797374656d20507265666572656e63657329, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_country', 0x436f756e747279, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_course', 0x436f75727365, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_course_fee', 0x46656520746f2063686172676520666f72207468697320636f7572736520, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_course_name', 0x436f75727365205469746c65, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_currency', 0x43757272656e637920, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_currency_other', 0x4f746865722043757272656e637920, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_currency_symbol', 0x43757272656e63792053796d626f6c20, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_date', 0x446174652050616964, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_date_picker', 0x53656c656374206120646174652072616e676520746f20646973706c61792e2028652e672e20323030372d322d3629, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_email', 0x456d61696c, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_email_admin', 0x456d61696c207061796d656e74206e6f746963657320746f207468652061646d696e6973747261746f72, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_end_date', 0x456e642044617465, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_enrollpay_confirmed_auto', 0x596f7572207061796d656e7420686173206265656e2072656365697665642c20616e6420796f752068617665206265656e20656e726f6c6c656420696e203c7374726f6e673e25733c2f7374726f6e673e2e20596f752063616e206e6f77203c6120687265663d226c6f67696e2e7068703f636f757273653d2573223e6c6f67696e20746f2074686520636f757273653c2f613e2e20, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_enrollpay_confirmed_manual', 0x596f7572207061796d656e7420686173206265656e2072656365697665642c20616e6420796f752068617665206265656e20656e726f6c6c656420696e203c7374726f6e673e25733c2f7374726f6e673e2e20596f752073686f756c64207265636569766520636f6e6669726d6174696f6e20627920656d61696c2c20616e642061636365737320746f2074686520636f757273652c206f6e636520617070726f7665642062792074686520696e7374727563746f722e20, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_enroll_approved', 0x456e726f6c6c6d656e7420417070726f766564, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_export_data', 0x4578706f7274204461746120446973706c617965642042656c6f77, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_fees', 0x46656573, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_firstname', 0x4669727374204e616d65, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_full_payment_recieved', 0x466565732050616964, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_gateway', 0x5061796d656e74204761746577617920, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_invalid_fields', 0x54686520666f6c6c6f77696e67206669656c64732061726520696e76616c6964, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_invoice', 0x496e766f696365, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_lastname', 0x4c617374204e616d65, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_location', 0x43726564697420636172642070726f63657373696e67206c6f636174696f6e2055524c20, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_location_text', 0x456e7465722074686520666f6c6c6f77696e672073657474696e677320666f7220796f75722063726564697420636172642070726f63657373696e6720736572766963652e20, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_login', 0x6c6f67696e, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_log_file', 0x46756c6c207061746820746f207772697461626c65207472616e73616374696f6e206c6f672066696c652e20287265717569726564206966206c6f6720697320656e61626c652c20637265617465207772697461626c65202066696c65206d616e75616c6c79206966206e65636573736172792920, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_make_payment', 0x4d616b65205061796d656e74, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_modify', 0x4d6f6469667920, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_more_info_required', 0x3c7374726f6e673e54686520666f6c6c6f77696e67206164646974696f6e616c20696e666f726d6174696f6e206973206e656564656420746f20636f6d706c65746520796f7572207061796d656e7420726571756573743a3c2f7374726f6e673e3c62722f3e, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_next_step', 0x4e657874205374657020, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_next_toproceed', 0x55736520746865203c656d3e4e65787420537465703c2f656d3e20627574746f6e20746f2072657669657720796f757220696e666f726d6174696f6e206265666f72652070726f636564696e6720746f2074686520736563757265206372656469742063617264207061796d656e7420736974652e, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_organization', 0x4f7267616e697a6174696f6e, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_password', 0x50617373776f72642061737369676e6564206279206372656469742063617264207061796d656e74207365727669636520, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_paybycheque', 0x50617920627920436865717565, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_paybycredit', 0x506179206279204372656469742043617264, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_paybypaypal', 0x5061792062792050617950616c, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_payfeesfor', 0x5061792046656573, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_payments', 0x5061796d656e7473, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_payments_courses', 0x436f75727365205061796d656e742053657474696e6773, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_payments_received', 0x5061796d656e7473205265636569766564, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_payments_settings', 0x5061796d656e742053657474696e6773, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_payment_confirmation', 0x5061796d656e7420436f6e6669726d6174696f6e20, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_payment_failed', 0x5061796d656e74204661696c65642f43616e63656c6c6564, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_payment_made', 0x436f75727365204665657320526563656976656420, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_payment_mail_instruction', 0x436f7572736520666565732068617665206265656e20726563656976656420666f722074686520636f757273653a2025732e204c6f67696e2061732074686520636f7572736520696e7374727563746f7220616e642072657669657720746865207061796d656e74207468726f75676820746865204d616e616765207461622c207468656e2063686f6f7365205061796d656e74732e20, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_payment_message', 0x257320686173207265676973746572656420696e2074686520636f757273652025732e20546f2072657669657720746865207061796d656e742c206c6f67696e20746f20415475746f7220617320616e2041646d696e6973747261746f72207468656e20636c69636b206f6e20746865205061796d656e7473207461622e, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_payment_received', 0x416e20415475746f72205061796d656e7420526563656976656420, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_payment_retrieve_admin', 0x416e20415475746f72207061796d656e7420686173206265656e2072656365697665642e20546f2072657669657720746865207061796d656e74206c6f67696e20746f20415475746f72206173207468652061646d696e6973747261746f722c2063686f6f736520746865205061796d656e7473207461622c207468656e2073656c65637420526576696577205061796d656e74732020, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_postal', 0x506f7374616c2f5a697020436f6465, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_print_invoice', 0x5072696e745f696e766f696365, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_province', 0x53746174652f50726f76696e6365, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_purchaser_info', 0x50757263686173657220496e666f726d6174696f6e, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_remove', 0x52656d6f76652f556e2d456e726f6c6c, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_required', 0x526571756972656420, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_requirements', 0x526571756972656d656e747320746f2070726f63656564, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_requirements_comment', 0x4e6f74652074686174206d6f73742063757272656e742062726f77736572732077696c6c206861766520746865736520656e61626c65642062792064656661756c742e20496620796f752061726520756e61626c6520746f20636f6d706c65746520746865207472616e73616374696f6e2c20636865636b2074686573652073657474696e677320696e20796f75722062726f7773657220746f206265207375726520746865792061726520656e61626c65642e, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_requirements_comments', 0x4e6f74652074686174206d6f73742063757272656e742062726f77736572732077696c6c206861766520746865736520656e61626c65642062792064656661756c742e20496620796f752061726520756e61626c6520746f20636f6d706c65746520746865207472616e73616374696f6e2c20636865636b2074686573652073657474696e677320696e20796f75722062726f7773657220746f206265207375726520746865792061726520656e61626c65642e, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_requirements_cookies', 0x436f6f6b69657320656e61626c65642e, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_requirements_javascript', 0x4a61766173637269707420656e61626c65642e, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_requirements_ssl', 0x53534c20656e61626c65642c2077697468203132382d62697420656e6372797074696f6e2e20, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_return_to_payments', 0x52657475726e20746f205061796d656e7473, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_select_course', 0x53656c65637420436f75727365, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_select_creditcard', 0x53656c656374207468652050617920627920437265646974204361726420627574746f6e2062656c6f7720746f206d6f766520746f2074686520736563757265206372656469742063617264207061796d656e7420736974652e20466f6c6c6f77696e672061207061796d656e742c202061207072696e7461626c6520726563656970742077696c6c2062652067656e65726174656420616e6420656d61696c2077696c6c2062652073656e7420746f2074686520706179656520776974682064657461696c73206f6620746865207472616e73616374696f6e2e204f722c2073656c656374205061792062792043686571756520746f2073656e64207061796d656e7420627920726567756c6172206d61696c2e, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_settings', 0x53657474696e6773, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_set_date', 0x536574204461746573, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_start_date', 0x53746172742044617465, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_store_log', 0x4b656570207472616e73616374696f6e206c6f6720, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_student_name', 0x4e616d65, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_telephone', 0x54656c6570686f6e65, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_this_course_fee', 0x436f757273652046656520, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_transaction_id', 0x5472616e73616374696f6e204944, '2013-08-01 10:18:14', ''),
('en', '_module', 'ec_vendor_id', 0x56656e646f722049442061737369676e6564206279206372656469742063617264207061796d656e74207365727669636520, '2013-08-01 10:18:14', ''),
('en', '_module', 'gradebook', 0x4772616465626f6f6b, '2008-09-25 15:59:56', 'gradebook'),
('en', '_module', 'ol_admin_lpanel', 0x5468652070616e656c206f6e20746865206c65667420736964652073686f7773207768656e20746865206c6f63616c20415475746f7220646174616261736520776173206c61737420757064617465642e20546f206d616e75616c6c79207570646174652074686520646174616261736520746f20696e636c75646520746865206d6f737420726563656e74206368616e676573206f6e204f70656e4c6561726e2c20636c69636b207468652027557064617465204e6f772720627574746f6e2e, '2013-08-01 10:18:14', ''),
('en', '_module', 'ol_admin_main', 0x546869732069732061646d696e2070616e656c206f6620536561726368204f70656e4c6561726e206d6f64756c652c20776865726520796f752063616e206368616e67652073657474696e677320666f7220746865206d6f64756c652e205468652074776f2070616e656c7320617265206465736372696265642062656c6f773a, '2013-08-01 10:18:14', ''),
('en', '_module', 'ol_admin_rpanel', 0x5468652070616e656c206f6e2074686520726967687420736964652073686f777320706172616d657465727320666f7220746865206d6f64756c652e204f6e20746865206669727374206c696e6520796f752063616e206d6f6469667920746865204f70656e4c6561726e207265706f7369746f72792055524c2e204f6e20746865207365636f6e64206c696e6520796f752063616e206d6f6469667920686f77206f6674656e20746865206c6f63616c20415475746f72206461746162617365206973206175746f6d61746963616c6c7920757064617465642077697468206e657720696e666f726d6174696f6e2066726f6d204f70656e4c6561726e2e205468652064656661756c742074696d65206265747765656e20757064617465732069732073657420746f2031343430206d696e7574657320286f6e63652070657220646179292e2020496620796f752077616e7420746f2064697361626c65206175746f6d617469632075706461746573207468656e20656e746572203020696e207468652074657874626f782e20466f72206175746f6d61746963207570646174657320796f75206e65656420746f2073657475702063726f6e2e20466f72206d6f726520696e666f726d6174696f6e207365652074686520203c6120687265663d27646f63756d656e746174696f6e2f61646d696e2f63726f6e5f73657475702e7068703f27206f6e636c69636b3d22706f707461737469632827646f63756d656e746174696f6e2f61646d696e2f63726f6e5f73657475702e7068703f293b2072657475726e2066616c73653b22207461726765743d275f6e6577273e2043726f6e205365747570203c2f613e207061676520696e207468652041646d696e6973747261746f722048616e64626f6f6b, '2013-08-01 10:18:14', ''),
('en', '_module', 'ol_all_form', 0x416c6c, '2013-08-01 10:18:14', ''),
('en', '_module', 'ol_and', 0x414e44, '2013-08-01 10:18:14', ''),
('en', '_module', 'ol_at', 0x6174, '2013-08-01 10:18:14', ''),
('en', '_module', 'ol_bool', 0x426f6f6c65616e204f7065726174696f6e, '2013-08-01 10:18:14', ''),
('en', '_module', 'ol_change_btn', 0x4368616e6765, '2013-08-01 10:18:14', ''),
('en', '_module', 'ol_close_tip', 0x436c6f73653a20, '2013-08-01 10:18:14', ''),
('en', '_module', 'ol_cron_interval', 0x55706461746520446174616261736520496e74657276616c, '2013-08-01 10:18:14', ''),
('en', '_module', 'ol_date_asc', 0x4461746520417363656e64696e67, '2013-08-01 10:18:14', ''),
('en', '_module', 'ol_date_desc', 0x446174652044657363656e64696e67, '2013-08-01 10:18:14', ''),
('en', '_module', 'ol_def', 0x44656661756c74, '2013-08-01 10:18:14', ''),
('en', '_module', 'ol_descri', 0x4465736372697074696f6e3a, '2013-08-01 10:18:14', ''),
('en', '_module', 'ol_desc_form', 0x4465736372697074696f6e, '2013-08-01 10:18:14', ''),
('en', '_module', 'ol_doc_avail', 0x54686520756e697420697320617661696c61626c6520666f7220646f776e6c6f61643a, '2013-08-01 10:18:14', ''),
('en', '_module', 'ol_dwnld', 0x446f776e6c6f6164, '2013-08-01 10:18:14', ''),
('en', '_module', 'ol_import_btn', 0x496d706f7274, '2013-08-01 10:18:14', ''),
('en', '_module', 'ol_import_unit', 0x496d706f727420556e6974, '2013-08-01 10:18:14', ''),
('en', '_module', 'ol_keywords', 0x4b6579776f7264733a, '2013-08-01 10:18:14', ''),
('en', '_module', 'ol_key_form', 0x4b6579776f726473, '2013-08-01 10:18:14', ''),
('en', '_module', 'ol_last_modi', 0x4c617374206d6f646966696564206f6e2844442d4d4d2d59595959293a, '2013-08-01 10:18:14', ''),
('en', '_module', 'ol_last_update', 0x4c6173742055706461746564206f6e, '2013-08-01 10:18:14', ''),
('en', '_module', 'ol_max_reco', 0x4d6178696d756d205265636f726473, '2013-08-01 10:18:14', ''),
('en', '_module', 'ol_min', 0x6d696e75746573, '2013-08-01 10:18:14', ''),
('en', '_module', 'ol_mod_def', 0x54686973206d6f64756c6520616c6c6f777320796f7520746f2073656172636820746865204f70656e4c6561726e207265706f7369746f72792c20616e642066696e64204f70656e20456475636174696f6e205265736f757263657320284f45527329206f6e206120776964652072616e6765206f6620746f706963732e20, '2013-08-01 10:18:14', ''),
('en', '_module', 'ol_no', 0x4e6f20726573756c747320666f756e6420666f723a, '2013-08-01 10:18:14', ''),
('en', '_module', 'ol_not_doc', 0x556e697420646f6573206e6f742070726f76696465202e646f632066696c652e, '2013-08-01 10:18:14', ''),
('en', '_module', 'ol_of', 0x6f66, '2013-08-01 10:18:14', ''),
('en', '_module', 'ol_open_tip', 0x4f70656e3a20, '2013-08-01 10:18:14', ''),
('en', '_module', 'ol_or', 0x4f52, '2013-08-01 10:18:14', ''),
('en', '_module', 'ol_order', 0x4f72646572204279, '2013-08-01 10:18:14', ''),
('en', '_module', 'ol_repo_url', 0x5265706f7369746f72792055524c, '2013-08-01 10:18:14', ''),
('en', '_module', 'ol_save', 0x53617665, '2013-08-01 10:18:14', ''),
('en', '_module', 'ol_search_btn', 0x536561726368, '2013-08-01 10:18:14', ''),
('en', '_module', 'ol_search_fields_form', 0x536561726368206669656c6473, '2013-08-01 10:18:14', ''),
('en', '_module', 'ol_search_open_learn', 0x4f70656e4c6561726e20436f6e74656e74, '2013-08-01 10:18:14', ''),
('en', '_module', 'ol_search_open_learn_text', 0x536561726368204f70656e4c6561726e20436f6e74656e74, '2013-08-01 10:18:14', ''),
('en', '_module', 'ol_search_open_learn_tool', 0x4f70656e4c6561726e20436f6e74656e7420546f6f6c20, '2013-08-01 10:18:14', ''),
('en', '_module', 'ol_title_asc', 0x5469746c6520417363656e64696e67, '2013-08-01 10:18:14', ''),
('en', '_module', 'ol_title_desc', 0x5469746c652044657363656e64696e67, '2013-08-01 10:18:14', ''),
('en', '_module', 'ol_title_form', 0x5469746c65, '2013-08-01 10:18:14', ''),
('en', '_module', 'ol_tool_1', 0x446f776e6c6f616420436f6e74656e74205061636b616765, '2013-08-01 10:18:14', ''),
('en', '_module', 'ol_tool_2', 0x446f776e6c6f616420436f6d6d6f6e20436172747269646765, '2013-08-01 10:18:14', ''),
('en', '_module', 'ol_tool_3', 0x50726576696577206f6e204f70656e4c6561726e28706f7075702077696e646f7729, '2013-08-01 10:18:14', ''),
('en', '_module', 'ol_tool_4', 0x52535320666f7220556e697428706f7075702077696e646f7729, '2013-08-01 10:18:14', ''),
('en', '_module', 'ol_tool_5', 0x446f776e6c6f616420646f632066696c6528706f7075702077696e646f7729, '2013-08-01 10:18:14', ''),
('en', '_module', 'ol_update', 0x557064617465204e6f77, '2013-08-01 10:18:14', ''),
('en', '_module', 'payments', 0x5061796d656e7473, '2013-08-01 10:18:14', ''),
('en', '_module', 'phpmyadmin', 0x7068704d7941646d696e, '2013-12-09 20:42:09', ''),
('en', '_module', 'phpmyadmin_atutor_db', 0x415475746f722069732063757272656e746c79207573696e6720746865206461746162617365206e616d65643a203c6b62643e25733c2f6b62643e2e, '2013-12-09 20:42:09', ''),
('en', '_module', 'phpmyadmin_location', 0x546865206c6f636174696f6e206f6620796f7572207068704d7941646d696e20696e7374616c6c6174696f6e3a, '2013-12-09 20:42:09', ''),
('en', '_module', 'phpmyadmin_missing_url', 0x596f75206d75737420737570706c79207468652055524c20746f20796f7572207068704d7941646d696e20696e7374616c6c6174696f6e20696e20746865206669656c642062656c6f772e, '2013-12-09 20:42:09', ''),
('en', '_module', 'phpmyadmin_open', 0x4f70656e207068704d7941646d696e, '2013-12-09 20:42:09', ''),
('en', '_module', 'phpmyadmin_text', 0x557365207068704d7941646d696e20746f206163636573732074686520415475746f722064617461626173652e203c7374726f6e673e436172652073686f756c642062652074616b656e207768656e206d6f64696679696e6720646174616261736520656e7472696573206469726563746c792e3c2f7374726f6e673e20496e206d6f737420636173657320415475746f7220746f6f6c732073686f756c64206265207573656420696e7374656164206f66206d6f64696679696e6720746865206461746162617365206469726563746c792e, '2013-12-09 20:42:09', ''),
('en', '_module', 'services', 0x5365727669636573, '2013-08-01 10:18:14', ''),
('en', '_module', 'services_text', 0x4d616e61676520796f757220415475746f72537061636573205365727669636573, '2013-08-01 10:18:14', ''),
('en', '_module', 'update_param', 0x55706461746520506172616d6574657273, '2013-08-01 10:18:14', ''),
('en', '_msgs', 'AT_CONFIRM_ADD_FEED', 0x41726520796f75207375726520796f752077616e7420746f2061646420746869732073796e6469636174656420666565643f, '2005-11-15 13:19:26', ''),
('en', '_msgs', 'AT_CONFIRM_ADD_MODULE', 0x41726520796f75207375726520796f752077616e7420746f20696e7374616c6c20746865206d6f64756c6520696e203c7374726f6e673e3c636f64653e25733c2f636f64653e3c2f7374726f6e673e3f, '2005-08-17 12:59:04', ''),
('en', '_msgs', 'AT_CONFIRM_ADD_TEST_QUESTIONS', 0x41726520796f75207375726520796f752077616e7420746f203c656d3e6164643c2f656d3e2074686520666f6c6c6f77696e67207175657374696f6e733f200d0a3c756c3e25733c2f756c3e, '2004-11-23 12:38:56', ''),
('en', '_msgs', 'AT_CONFIRM_ALUMNI', 0x41726520796f75207375726520796f752077616e7420746f206d61726b2074686520666f6c6c6f77696e6720757365727320617320636f7572736520616c756d6e693a203c756c3e202573203c2f756c3e, '2004-11-23 12:17:53', 'enrollment_manager, make students into alumi'),
('en', '_msgs', 'AT_CONFIRM_BBB_DELETE_CONFIRM', 0x41726520796f75207375726520796f752077616e7420746f2064656c6574652074686973206d656574696e673f, '2013-08-01 10:18:14', ''),
('en', '_msgs', 'AT_CONFIRM_DELETE', 0x41726520796f75207375726520796f752077616e7420746f2064656c657465207468657365206974656d733f3c6272202f3e0d0a0d0a203c756c3e202573203c2f756c3e, '2008-05-08 12:19:32', 'generic delete confirmation msg'),
('en', '_msgs', 'AT_CONFIRM_DELETE_ADMIN', 0x41726520796f75207375726520796f752077616e7420746f2064656c6574652074686520666f6c6c6f77696e672061646d696e6973747261746f723f0d0a3c6272202f3e0d0a3c7374726f6e673e25733c2f7374726f6e673e, '2008-01-22 09:38:06', ''),
('en', '_msgs', 'AT_CONFIRM_DELETE_ASSIGNMENT', 0x41726520796f75207375726520796f752077616e7420746f2064656c6574652061737369676e6d656e74203c656d3e25733c2f656d3e3f, '2006-05-23 13:10:30', ''),
('en', '_msgs', 'AT_CONFIRM_DELETE_AUTO_ENROLL', 0x41726520796f75207375726520796f752077616e7420746f203c7374726f6e673e64656c6574653c2f7374726f6e673e206175746f20656e726f6c6c6d656e7420666f72203c7374726f6e673e25733c2f7374726f6e673e, '2008-03-10 11:52:57', 'confirm message when deleting an auto enroll definition'),
('en', '_msgs', 'AT_CONFIRM_DELETE_CATEGORY', 0x41726520796f75207375726520796f752077616e7420746f2064656c6574652063617465676f727920203c7374726f6e673e25733c2f7374726f6e673e3f, '2005-02-17 14:57:18', ''),
('en', '_msgs', 'AT_CONFIRM_DELETE_COURSE_1', 0x41726520796f75207375726520796f752077616e7420746f203c7374726f6e673e44656c6574653c2f7374726f6e673e2074686520636f75727365203c7374726f6e673e3c656d3e25733c2f656d3e3c2f7374726f6e673e3f, '2005-03-04 11:27:35', ''),
('en', '_msgs', 'AT_CONFIRM_DELETE_COURSE_2', 0x41726520796f75203c7374726f6e673e7265616c6c79207265616c6c793c2f7374726f6e673e207375726520796f752077616e7420746f203c623e44656c6574653c2f623e2074686520636f75727365203c7374726f6e673e3c656d3e25733c2f656d3e3c2f7374726f6e673e3f2044656c6574656420636f75727365732063616e206e6f74206265207265636f76657265642e, '2005-03-04 11:31:35', ''),
('en', '_msgs', 'AT_CONFIRM_DELETE_FAQ_QUESTION', 0x41726520796f75207375726520796f752077616e7420746f2064656c65746520746865207175657374696f6e203c7374726f6e673e25733c2f7374726f6e673e3f, '2005-10-19 12:49:55', ''),
('en', '_msgs', 'AT_CONFIRM_DELETE_FAQ_TOPIC', 0x41726520796f75207375726520796f752077616e7420746f2064656c6574652074686520746f706963203c7374726f6e673e25733c2f7374726f6e673e20616e6420697473207175657374696f6e733f, '2005-11-08 13:42:33', ''),
('en', '_msgs', 'AT_CONFIRM_DELETE_FEED', 0x41726520796f75207375726520796f752077616e7420746f2064656c6574652066656564203c7374726f6e673e25733c2f7374726f6e673e2e3f, '2005-12-07 09:36:25', ''),
('en', '_msgs', 'AT_CONFIRM_DELETE_FORUM', 0x41726520796f75207375726520796f752077616e7420746f2064656c657465203c7374726f6e673e25733c2f7374726f6e673e20666f72756d3f20416c6c206d6573736167657320706f7374656420746f207468697320666f72756d2077696c6c206265206572617365642e, '2005-12-07 09:36:15', 'deleting a forum'),
('en', '_msgs', 'AT_CONFIRM_DELETE_GRADE_SCALE', 0x41726520796f75207375726520796f752077616e7420746f203c7374726f6e673e64656c6574653c2f7374726f6e673e206772616465207363616c65203c7374726f6e673e25733c2f7374726f6e673e3f, '2008-09-25 16:01:17', 'gradebook'),
('en', '_msgs', 'AT_CONFIRM_DELETE_GROUP', 0x41726520796f75207375726520796f752077616e7420746f2064656c657465207468652067726f75703a203c7374726f6e673e25733c2f7374726f6e673e3f, '2005-02-21 12:07:05', 'deletep enrollment group'),
('en', '_msgs', 'AT_CONFIRM_DELETE_GROUP_TYPE', 0x41726520796f75207375726520796f752077616e7420746f2064656c6574652067726f75702074797065203c656d3e25733c2f656d3e20616e6420616c6c206974732067726f7570733f, '2006-03-23 11:27:52', ''),
('en', '_msgs', 'AT_CONFIRM_DELETE_LANG', 0x41726520796f75207375726520796f752077616e7420746f2064656c65746520746865206c616e67756167652028203c7374726f6e673e2573203c2f7374726f6e673e293f, '2004-11-24 13:19:50', ''),
('en', '_msgs', 'AT_CONFIRM_DELETE_LINK', 0x41726520796f75207375726520796f752077616e7420746f2064656c65746520746865206c696e6b2025733f, '2005-02-21 16:55:38', ''),
('en', '_msgs', 'AT_CONFIRM_DELETE_MSGS', 0x41726520796f75207375726520796f752077616e7420746f2064656c657465207468652073656c6563746564206d657373616765733f, '2007-02-22 13:09:14', ''),
('en', '_msgs', 'AT_CONFIRM_DELETE_MYOWN_PATCH', 0x41726520796f75207375726520796f752077616e7420746f203c7374726f6e673e64656c6574653c2f7374726f6e673e207061746368203c7374726f6e673e25733c2f7374726f6e673e, '2008-04-21 15:11:31', ''),
('en', '_msgs', 'AT_CONFIRM_DELETE_NEWS', 0x41726520796f75207375726520796f752077616e7420746f2064656c6574652025733f, '2004-11-24 13:37:55', 'news deletion in editor'),
('en', '_msgs', 'AT_CONFIRM_DELETE_PAYMENT', 0x41726520796f75207375726520796f752077616e7420746f2064656c6574652074686973207061796d656e74207265636f72643f, '2013-08-01 10:18:14', ''),
('en', '_msgs', 'AT_CONFIRM_DELETE_POLL', 0x41726520796f75207375726520796f752077616e7420746f2064656c657465207468697320706f6c6c20272573273f202049742063616e6e6f74206265207265636f7665726564206f6e63652064656c657465642e, '2004-11-24 14:03:36', 'editor'),
('en', '_msgs', 'AT_CONFIRM_DELETE_RECORDING', 0x41726520796f75207375726520796f752077616e7420746f2064656c6574652074686973207265636f7264696e673f, '2013-08-01 10:18:14', ''),
('en', '_msgs', 'AT_CONFIRM_DELETE_TEST', 0x41726520796f75207375726520796f752077616e7420746f2064656c6574652074686520746573742f737572766579203c7374726f6e673e3c656d3e25733c2f656d3e3c2f7374726f6e673e20616e6420616e7920726573756c74733f20546865207175657374696f6e732c20686f77657665722c2077696c6c206e6f742062652064656c657465642e, '2004-12-15 10:42:13', 'Deleting Test'),
('en', '_msgs', 'AT_CONFIRM_DELETE_TEST_CATEGORY', 0x41726520796f75207375726520796f752077616e7420746f2064656c65746520746573742063617465676f7279203c7374726f6e673e25733c2f7374726f6e673e3f, '2005-03-07 11:58:48', ''),
('en', '_msgs', 'AT_CONFIRM_DELETE_TEST_FROM_GRADEBOOK', 0x41726520796f75207375726520796f752077616e7420746f203c7374726f6e673e64656c6574653c2f7374726f6e673e2074657374203c7374726f6e673e25733c2f7374726f6e673e2066726f6d206772616465626f6f6b3f, '2008-09-25 16:01:17', 'gradebook'),
('en', '_msgs', 'AT_CONFIRM_DELETE_THEME', 0x41726520796f75207375726520796f752077616e7420746f2064656c6574652074686520666f6c6c6f77696e67207468656d653a203c623e20252073203c2f623e, '2004-11-23 09:30:03', 'confirm message for delete theme'),
('en', '_msgs', 'AT_CONFIRM_DELETE_TOOL_1', 0x41726520796f75207375726520796f752077616e7420746f2064656c6574652074686520746f6f6c203c7374726f6e673e2025733c2f7374726f6e673e3f, '2011-05-27 16:09:45', ''),
('en', '_msgs', 'AT_CONFIRM_DELETE_TRACKING', 0x41726520796f75207375726520796f75722077616e7420746f2064656c6574652074686520636f6e74656e74207573616765206461746120666f72207468697320636f757273653f, '2005-08-11 10:08:50', 'reset tracking session'),
('en', '_msgs', 'AT_CONFIRM_DELETE_TRANSCRIPT', 0x41726520796f75207375726520796f752077616e7420746f2064656c65746520746865207472616e736372697074203c7374726f6e673e25733c2f7374726f6e673e3f, '2005-03-30 14:21:00', 'delete chat transcript'),
('en', '_msgs', 'AT_CONFIRM_DELETE_USER', 0x41726520796f75207375726520796f752077616e7420746f2064656c6574652074686520666f6c6c6f77696e672075736572733f2053656c656374656420696e7374727563746f72732077686f206f776e20636f75727365732077696c6c206e6f742062652064656c657465642e3c7374726f6e673e25733c2f7374726f6e673e, '2007-02-19 11:44:45', 'deleting user from admin'),
('en', '_msgs', 'AT_CONFIRM_DIR_DELETE', 0x41726520796f75207375726520796f752077616e7420746f2064656c6574652074686520666f6c6c6f77696e6720666f6c64657228732920616e6420616c6c20746865697220636f6e74656e74733f203c756c3e3c7374726f6e673e25733c2f7374726f6e673e3c2f756c3e, '2004-12-15 09:59:39', 'filemanager'),
('en', '_msgs', 'AT_CONFIRM_DIR_MOVE', 0x41726520796f75207375726520796f752077616e7420746f206d6f7665203c7374726f6e673e2531733c2f7374726f6e673e20746f2074686520666f6c646572203c7374726f6e673e2532733c2f7374726f6e673e3f, '2005-01-10 10:35:17', 'filemanager'),
('en', '_msgs', 'AT_CONFIRM_EDIT_STATUS', 0x41726520796f75207375726520796f752077616e7420746f206368616e67652074686520666f6c6c6f77696e67207573657273272073746174757320746f20203c7374726f6e673e25733c2f7374726f6e673e3f20537461747573206f662073656c656374656420696e7374727563746f72732077686f206f776e20636f75727365732077696c6c206e6f74206265206368616e6765642e202573, '2007-02-19 11:43:37', ''),
('en', '_msgs', 'AT_CONFIRM_ENROLL_STUDENT', 0x41726520796f75207375726520796f752077616e7420746f20656e726f6c6c2074686520666f6c6c6f77696e672075736572733a203c756c3e202573203c2f756c3e, '2004-11-23 12:21:00', 'enrollment manager, enroll confirm'),
('en', '_msgs', 'AT_CONFIRM_FILE_DELETE', 0x41726520796f75207375726520796f752077616e7420746f2064656c6574652074686520666f6c6c6f77696e672066696c652873293f203c756c3e25733c2f756c3e, '2006-07-05 11:44:15', 'filemanager'),
('en', '_msgs', 'AT_CONFIRM_FILE_EXISTS', 0x5468652066696c65203c7374726f6e673e25733c2f7374726f6e673e20616c7265616479206578697374732e20446f20796f752077616e7420746f206f7665727772697465207468652066696c653f, '2005-03-09 16:26:11', 'filemanager'),
('en', '_msgs', 'AT_CONFIRM_FILE_MOVE', 0x41726520796f75207375726520796f752077616e7420746f206d6f7665203c7374726f6e673e2531733c2f7374726f6e673e20746f2074686520666f6c646572203c7374726f6e673e2532733c2f7374726f6e673e3f, '2005-01-10 10:33:21', 'file_manager'),
('en', '_msgs', 'AT_CONFIRM_GLOSSARY_REMAINS', 0x44656c6574696e672061207465726d2077696c6c206e6f742072656d6f76652074686520656d62656464656420676c6f737361727920636f6465732066726f6d20796f757220636f6e74656e742e, '2005-02-24 10:34:33', 'content deletion'),
('en', '_msgs', 'AT_CONFIRM_GRANT_WRITE_PERMISSION', 0x506c65617365206772616e74203c7374726f6e673e77726974653c2f7374726f6e673e207065726d697373696f6e20746f20666f6c6465723a2025733c703e3c7374726f6e673e4e6f74653a3c2f7374726f6e673e20546f206368616e6765207065726d697373696f6e73206f6e20556e697820757365203c6b62643e63686d6f6420612b72773c2f6b62643e207468656e207468652066696c65206e616d652e3c2f703e, '2008-10-21 15:41:53', ''),
('en', '_msgs', 'AT_CONFIRM_LIST_DELETE', 0x41726520796f75207375726520796f752077616e7420746f2064656c657465203c7374726f6e673e25733c2f7374726f6e673e2053747564656e742049442066726f6d20746865206d61737465722073747564656e74206c6973743f, '2005-04-04 15:47:51', ''),
('en', '_msgs', 'AT_CONFIRM_LOGIN_INSTRUCTOR', 0x3c68333e253224733c2f68333e0d0a596f752077696c6c206265206c6f6767656420696e2061732074686520696e7374727563746f7220666f72207468697320636f757273652e202041726520796f75207375726520796f752077616e7420746f20636f6e74696e75653f, '2006-04-10 13:12:29', 'viewing courses from admin'),
('en', '_msgs', 'AT_CONFIRM_NO_ANSWER', 0x596f75206172652061626f757420746f206164642061207175657374696f6e2077697468206e6f20636f72726563742063686f6963652e20436f6e74696e75653f, '2004-12-06 14:35:10', 'adding a question without specifying answer'),
('en', '_msgs', 'AT_CONFIRM_PA_DELETE_ALBUM', 0x41726520796f75207375726520796f752077616e7420746f2064656c6574652074686520616c62756d203c7374726f6e673e25733c2f7374726f6e673e3f204f6e63652064656c657465642c2070686f746f732063616e206e6f74206265207265636f76657265642e, '2010-03-17 16:08:25', 'photo album'),
('en', '_msgs', 'AT_CONFIRM_PA_DELETE_COMMENT', 0x41726520796f75207375726520796f752077616e7420746f2064656c657465207468697320636f6d6d656e743f, '2010-03-17 16:09:08', 'photo album'),
('en', '_msgs', 'AT_CONFIRM_PA_DELETE_PHOTO', 0x41726520796f75207375726520796f752077616e7420746f2064656c65746520746869732050686f746f3f, '2010-03-17 16:08:50', 'photo album'),
('en', '_msgs', 'AT_CONFIRM_REMOVE_STUDENT', 0x41726520796f75207375726520796f752077616e7420746f2072656d6f76652074686520666f6c6c6f77696e672073747564656e74733a203c756c3e202573203c2f756c3e, '2004-11-23 12:21:12', 'removing a student'),
('en', '_msgs', 'AT_CONFIRM_REMOVE_TEST_QUESTION', 0x41726520796f75207375726520796f752077616e7420746f2072656d6f76652074686973207175657374696f6e2066726f6d207468697320746573743f2052656d6f76696e6720746865207175657374696f6e2077696c6c206e6f742064656c6574652069742066726f6d20746865207175657374696f6e2064617461626173652e, '2004-11-25 10:31:52', '');
INSERT INTO `AT_language_text` (`language_code`, `variable`, `term`, `text`, `revised_date`, `context`) VALUES
('en', '_msgs', 'AT_CONFIRM_REMOVE_WRITE_PERMISSION', 0x3c7370616e207374796c653d22636f6c6f723a726564223e466f7220796f75722073656375726974792c20706c65617365203c7374726f6e673e52454d4f56453c2f7374726f6e673e207772697465207065726d697373696f6e206f6e2074686520666f6c6465723a2025733c2f7370616e3e3c703e3c7374726f6e673e4e6f74653a3c2f7374726f6e673e20546f2072656d6f7665207065726d697373696f6e73206f6e20556e697820757365203c6b62643e63686d6f64203735353c2f6b62643e207468656e207468652066696c65206f7220666f6c646572206e616d652e3c2f703e, '2008-10-21 15:41:53', ''),
('en', '_msgs', 'AT_CONFIRM_RESET_ADMIN_LOG', 0x41726520796f75207375726520796f752077616e7420746f2064656c657465207468652041646d696e6973747261746f72204163746976697479204c6f673f, '2005-03-03 10:42:50', ''),
('en', '_msgs', 'AT_CONFIRM_RESET_ERROR_LOG', 0x41726520796f75207375726520796f752077616e7420746f2064656c65746520616c6c20746865206572726f72206c6f67733f, '2005-03-10 15:49:02', 'error log reset (delete logs folder0'),
('en', '_msgs', 'AT_CONFIRM_RL_DELETE_READING', 0x41726520796f75207375726520796f752077616e7420746f2064656c65746520746869732072656164696e673a203c7374726f6e673e25733c2f7374726f6e673e3f, '2006-10-04 10:48:51', ''),
('en', '_msgs', 'AT_CONFIRM_RL_DELETE_RESOURCE', 0x41726520796f75207375726520796f752077616e7420746f2064656c6574652074686973207265736f757263653a203c7374726f6e673e25733c2f7374726f6e673e3f3c62722f3e4e6f74653a20416e792072656164696e67732074686174207573652074686973207265736f757263652077696c6c20616c736f2062652064656c657465642e, '2006-10-04 10:48:36', ''),
('en', '_msgs', 'AT_CONFIRM_STUDENT_GROUP', 0x41726520796f75207375726520796f752077616e7420746f206164642074686520666f6c6c6f77696e6720757365727320746f2067726f757020272573273f203c756c3e202573203c2f756c3e, '2005-06-02 12:07:05', ''),
('en', '_msgs', 'AT_CONFIRM_STUDENT_REMOVE_GROUP', 0x41726520796f75207375726520796f752077616e7420746f203c7374726f6e673e72656d6f76653c2f7374726f6e673e2074686520666f6c6c6f77696e672075736572732066726f6d2067726f757020272573273f203c756c3e202573203c2f756c3e, '2005-06-02 12:06:56', 'Enrollment'),
('en', '_msgs', 'AT_CONFIRM_SUB_CONTENT_DELETE', 0x5468697320636f6e74656e742070616765206861732073756220636f6e74656e742e20496620796f752064656c6574652074686973207061676520616c6c20697473207375622070616765732077696c6c2062652064656c657465642061732077656c6c2e3c6272202f3e, '2004-11-24 13:31:34', 'content deletion'),
('en', '_msgs', 'AT_CONFIRM_UNENROLL', 0x41726520796f75207375726520796f752077616e7420746f20756e2d656e726f6c6c2066726f6d203c7374726f6e673e25733c2f7374726f6e673e3f, '2005-03-24 12:43:34', ''),
('en', '_msgs', 'AT_CONFIRM_UNENROLL_PRIV', 0x41726520796f75207375726520796f752077616e7420746f20756e2d656e726f6c6c2074686520666f6c6c6f77696e6720757365727320287468652075736572732077696c6c206861766520746865697220726f6c657320616e642070726976696c656765732072656d6f766564293a203c756c3e202573203c2f756c3e, '2004-11-23 12:23:22', 'enrollment manager, unenrolling a TA'),
('en', '_msgs', 'AT_CONFIRM_UNENROLL_STUDENT', 0x41726520796f75207375726520796f752077616e7420746f20756e2d656e726f6c6c2074686520666f6c6c6f77696e672073747564656e74733a203c756c3e202573203c2f756c3e, '2004-11-23 12:21:36', 'enrollment manager, confirm unenroll'),
('en', '_msgs', 'AT_ERROR_ACCESS_DENIED', 0x596f7520646f206e6f742068617665207065726d697373696f6e20746f20616363657373207468697320617265612e, '2005-06-15 15:13:59', 'error msg'),
('en', '_msgs', 'AT_ERROR_ACCOUNT_DISABLED', 0x54686174206163636f756e7420686173206265656e2064697361626c65642e, '2005-04-01 10:30:12', ''),
('en', '_msgs', 'AT_ERROR_ADMIN_EDIT_OWN_ACCOUNT', 0x546f206564697420796f7572206f776e206163636f756e742075736520746865203c6120687265663d226d6f64732f5f636f72652f75736572732f61646d696e732f6d795f656469742e706870223e4d79204163636f756e743c2f613e20706167652e, '2010-03-09 14:25:28', ''),
('en', '_msgs', 'AT_ERROR_ALREADY_BOOKMARKED', 0x43616c656e64617220697320616c726561647920626f6f6b6d61726b65642e, '2013-09-11 12:34:03', ''),
('en', '_msgs', 'AT_ERROR_ALREADY_ENROLED', 0x596f75206861766520616c7265616479206d6164652061207265717565737420746f20656e726f6c6c20696e207468697320636f7572736520616e6420796f752068617665206e6f7420796574206265656e20617070726f7665642062792074686520696e7374727563746f722e20596f752077696c6c206265206e6f746966696564207768656e20796f7572207265717565737420686173206265656e20617070726f7665642e, '2009-09-17 14:47:14', 'error msg'),
('en', '_msgs', 'AT_ERROR_ALREADY_INSTALLED', 0x53656c6563746564206974656d206170706561727320746f2068617665206265656e20696e7374616c6c65642e, '2008-10-21 15:41:53', ''),
('en', '_msgs', 'AT_ERROR_ALREADY_OWNED', 0x596f75206f776e207468697320636f757273652c20616e642063616e6e6f7420656e726f6c6c2e, '2004-11-26 14:30:22', 'error msg'),
('en', '_msgs', 'AT_ERROR_ALREADY_UNINSTALLED', 0x53656c6563746564206974656d206170706561727320746f2068617665206265656e20756e696e7374616c6c65642e204d6f64756c65206469726563746f727920646f6573206e6f742065786973742e, '2008-10-21 15:41:53', ''),
('en', '_msgs', 'AT_ERROR_ALTERNATIVE_ALREADY_DECLARED', 0x5468652066696c6520796f752073656c65637465642068617320616c7265616479206265656e206465636c6172656420617320616e20616c7465726e617469766520746f207468652073656c6563746564207072696d617279207265736f757263652e, '2008-09-08 15:25:02', ''),
('en', '_msgs', 'AT_ERROR_ALTERNATIVE_NOT_DEFINED', 0x596f75206d7573742073656c65637420616e20616c7465726e61746976652066726f6d2066696c657320617661696c61626c6520696e207468652046696c65204d616e6167657220746f207468652072696768742e, '2009-12-01 11:02:01', ''),
('en', '_msgs', 'AT_ERROR_ASSIGNMENT_CUTOFF', 0x5468652061737369676e6d656e74206375742d6f666620646174652068617320706173742e205375626d697373696f6e7320617265206e6f206c6f6e6765722061636365707465642e, '2006-03-20 14:41:46', ''),
('en', '_msgs', 'AT_ERROR_BACKUP_RESTORE', 0x526573746f7265206661696c6564202d2066696c65206973206e6f7420612076616c6964206261636b75702e204261636b757073206f6c646572207468616e2076657273696f6e20312e3320617265206e6f7420737570706f727465642e, '2005-11-29 14:33:56', ''),
('en', '_msgs', 'AT_ERROR_BACKUP_UNSUPPORTED_GREATER_VERSION', 0x4261636b75707320637265617465642066726f6d2076657273696f6e73206f6620415475746f722067726561746572207468616e20746869732076657273696f6e20617265206e6f7420737570706f727465642e, '2005-05-11 15:56:50', ''),
('en', '_msgs', 'AT_ERROR_BAD_DATE', 0x546861742064617465206973206e6f742076616c69642e, '2003-05-16 13:42:17', 'error msg'),
('en', '_msgs', 'AT_ERROR_BAD_FILE_TYPE', 0x556e737570706f727465642066696c6520747970652e20506c61696e2054657874206f722048544d4c2066696c6573206f6e6c792e, '2003-05-16 13:42:17', 'error msg'),
('en', '_msgs', 'AT_ERROR_BAD_FOLDER_NAME', 0x54686520666f6c646572206e616d6520636f6e7461696e7320696c6c6567616c20636861726163746572732e20596f75206d61792063686f6f73652066726f6d20616c7068616e756d65726963206368617261637465727320616e6420756e64657273636f7265732c20646173686573206f7220706572696f64732e, '2005-01-10 13:13:55', 'filemanager, foilder with illegal chars'),
('en', '_msgs', 'AT_ERROR_BBB_ACTION_FAILED', 0x4661696c656420746f2073617665206d656574696e672064657461696c732e, '2013-08-01 10:18:14', ''),
('en', '_msgs', 'AT_ERROR_BBB_SETTINGS_FAILED', 0x426967426c7565427574746f6e20636f6e66696775726174696f6e2073657474696e6773206661696c656420746f20736176652e205472792061646a757374696e67207468652055524c20616e6420646f75626c6520636865636b696e67207468652053616c7420746f6b656e2e, '2013-08-01 10:18:14', ''),
('en', '_msgs', 'AT_ERROR_CACHE_DIR_BAD', 0x4361636865206469722063616e6e6f7420626520637265617465642e2043616368652064697361626c65642e205365652074686520636f6e66696775726174696f6e206f7074696f6e7320746f206569746865722064697361626c65206f7220666978207468652070726f626c656d2e, '2003-05-27 13:10:53', 'global'),
('en', '_msgs', 'AT_ERROR_CACHE_DIR_NOT_EXIST', 0x4361636865206469726563746f727920646f6573206e6f74206578697374206f72206973206e6f74207772697461626c652e2043726561746520697420616e6420736574207772697465207065726d697373696f6e7320746f206d616b6520746865206469726563746f7279207772697461626c65206279207468652073797374656d2773205765622073657276657220757365722e2028652e672e2063686d6f6420612b72777820636163686529, '2010-03-04 14:41:51', ''),
('en', '_msgs', 'AT_ERROR_CAL_FILE_DELETE', 0x4572726f7220696e2072656d6f76696e67206475706c69636174652066696c652e, '2013-09-11 12:34:03', ''),
('en', '_msgs', 'AT_ERROR_CAL_FILE_ERROR', 0x4572726f7220696e2066696c652070726f63657373696e672e, '2013-09-11 12:34:03', ''),
('en', '_msgs', 'AT_ERROR_CANNOT_BE_EMPTY', 0x536561726368206669656c642063616e6e6f7420626520656d7074792e, '2009-05-27 12:01:11', ''),
('en', '_msgs', 'AT_ERROR_CANNOT_CONNECT_SERVER', 0x4661696c656420746f20636f6e6e65637420746f207365727665723a202573, '2008-10-21 15:41:53', ''),
('en', '_msgs', 'AT_ERROR_CANNOT_CREATE_DIR', 0x43616e6e6f742063726561746520636f6e74656e74206469726563746f72792e, '2003-10-15 12:20:51', ''),
('en', '_msgs', 'AT_ERROR_CANNOT_DELETE_OWN_ACCOUNT', 0x596f752063616e6e6f742064656c65746520796f7572206f776e206163636f756e742e, '2005-03-03 10:59:44', ''),
('en', '_msgs', 'AT_ERROR_CANNOT_OPEN_DIR', 0x556e61626c6520746f206f70656e20636f6e74656e74206469726563746f72792e20596f75206d61792074727920746f203c6120687265663d226d6f64732f5f636f72652f66696c655f6d616e616765722f6e65772e706870223e637265617465206974206e6f773c2f613e2e, '2010-03-09 14:26:18', 'error msg'),
('en', '_msgs', 'AT_ERROR_CANNOT_OPEN_FILE', 0x43616e6e6f74206f70656e207468652066696c653a203c623e202573203c2f623e, '2004-10-18 14:38:00', 'Theme Manager'),
('en', '_msgs', 'AT_ERROR_CANNOT_OVERWRITE_FILE', 0x43616e6e6f74206f766572726964652066696c652e, '2003-05-16 13:42:17', 'error msg'),
('en', '_msgs', 'AT_ERROR_CANNOT_READ_FILE', 0x43616e6e6f7420726561642066726f6d2066696c653a203c623e202573203c2f623e, '2004-11-19 13:00:03', 'admin/error_logging.php'),
('en', '_msgs', 'AT_ERROR_CANNOT_RENAME', 0x46696c65206f72206469726563746f72792063616e6e6f742062652072656e616d65642e2045697468657220612066696c65206f72206469726563746f727920776974682074686174206e616d6520616c7265616479206578697374732c20746865206f726967696e616c2066696c65206f72206469726563746f727920646f6573206e6f742065786973742c206f72207468652066696c65206f72206469726563746f7279206e616d6520686173206e6f74206368616e6765642e, '2004-08-20 12:05:15', ''),
('en', '_msgs', 'AT_ERROR_CANNOT_UNINSTALL_MANUAL_MODULE', 0x54686973206d6f64756c65206e6565647320746f20626520756e696e7374616c6c6564206d616e75616c6c7920696e7374656164206f66207573696e672074686520415475746f72206d6f64756c6520696e7374616c6c65722e20506c6561736520756e696e7374616c6c206974206d616e75616c6c792e, '2008-10-21 15:41:53', 'error msg'),
('en', '_msgs', 'AT_ERROR_CANNOT_UNZIP', 0x43616e204e4f5420756e7a6970207468652075706c6f616465642066696c652e, '2008-04-21 15:08:55', 'error msg'),
('en', '_msgs', 'AT_ERROR_CANNOT_WRITE_FILE', 0x43616e6e6f7420777269746520746f2066696c653a203c623e202573203c2f623e, '2004-10-18 14:39:10', 'Theme Manager'),
('en', '_msgs', 'AT_ERROR_CANT_DELETE_GROUP', 0x596f752063616e6e6f742064656c65746520746869732067726f75702e, '2009-05-27 12:01:11', ''),
('en', '_msgs', 'AT_ERROR_CHAT_TRAN_REJECTED', 0x5472616e7363726970742066696c656e616d652072656a65637465642e20506c6561736520656e7375726520746861742069742069732020616c7068616e756d6572696320616e6420636f6e7461696e73206e6f207370616365732e, '2003-06-02 13:47:39', 'achat'),
('en', '_msgs', 'AT_ERROR_CHECKSUM_ERROR_BBB', 0x4120636865636b73756d206572726f72206f6363757265642e204d616b65207375726520796f7520656e74657265642074686520636f72726563742073616c742e, '2013-08-01 10:18:14', ''),
('en', '_msgs', 'AT_ERROR_CHOICES_EMPTY', 0x456e746572206174206c656173742074776f20616e737765722063686f696365732e, '2005-03-08 15:41:49', ''),
('en', '_msgs', 'AT_ERROR_CHOOSE_UNINSTALLED_PATCH', 0x506c656173652063686f6f736520616e20756e696e7374616c6c65642070617463682e, '2008-04-21 15:08:55', 'error msg'),
('en', '_msgs', 'AT_ERROR_COMBINE_TESTS', 0x223c7374726f6e673e253124733c2f7374726f6e673e222063616e6e6f7420626520636f6d62696e656420626563617573652074686520666f6c6c6f77696e672073747564656e747320686176652074616b656e206974206d6f7265207468616e206f6e63653a3c6272202f3e0d0a253224732e, '2008-09-25 16:01:17', 'gradebook'),
('en', '_msgs', 'AT_ERROR_CONFIG_NOT_WRITEABLE', 0x4974206973206e6f7420706f737369626c6520746f20656469742074686573652073657474696e677320626563617573652074686520636f6e66696775726174696f6e2066696c65206973206c6f636b656420666f7220736563757269747920726561736f6e732e20496620796f752077616e7420746f206d616b65206368616e6765732c20796f75206e65656420746f20756e6c6f636b2074686520636f6e6669672e696e632e7068702066696c65206669727374206279206368616e67696e6720697473207065726d697373696f6e7320776974682074686520636f6d6d616e64203c6b62643e63686d6f6420612b727720636f6e6669672e696e632e7068703c2f6b62643e2e, '2005-03-03 10:14:48', ''),
('en', '_msgs', 'AT_ERROR_CONFIRM_BAD', 0x596f757220656d61696c206164647265737320616e64206163636f756e7420636f756c64206e6f7420626520636f6e6669726d65642e, '2005-05-31 12:55:25', ''),
('en', '_msgs', 'AT_ERROR_CONTACT_INFO_NOT_FOUND', 0x436f6e7461637420537570706f7274206973206e6f7420617661696c61626c652c206265636175736520616e20656d61696c206164647265737320686173206e6f74206265656e207370656369666965642e, '2005-03-17 11:33:38', ''),
('en', '_msgs', 'AT_ERROR_COULD_NOT_LOAD_TOOL', 0x436f756c64206e6f74206c6f616420746f6f6c2e, '2013-09-07 10:12:08', 'admin edit LTI tool'),
('en', '_msgs', 'AT_ERROR_COURSE_DIR_NAME_INVALID', 0x54686520636f75727365206469726563746f7279206e616d6520697320696e76616c69642e204974206d617920636f6e7461696e206f6e6c79206c6574746572732c206e756d626572732c20616e6420756e64657273636f7265732c20616e64206d6179206e6f7420636f6e7461696e2073706163657320616e642068797068656e732e, '2012-07-26 13:58:12', ''),
('en', '_msgs', 'AT_ERROR_COURSE_DIR_NAME_IN_USE', 0x54686520636f75727365206469726563746f7279206e616d6520697320616c726561647920696e207573652e20506c656173652074727920616e6f746865722e, '2008-10-06 13:19:17', ''),
('en', '_msgs', 'AT_ERROR_COURSE_ENDED', 0x5468697320636f7572736520656e646564206f6e2025732e, '2007-07-16 11:53:27', ''),
('en', '_msgs', 'AT_ERROR_COURSE_NOT_RELEASED', 0x5468697320636f757273652063616e206f6e6c79206265206163636573736564206f6e2025732e, '2006-04-10 14:28:27', ''),
('en', '_msgs', 'AT_ERROR_CREATE_MASTER_USED', 0x5468652053747564656e7420494420796f75206861766520656e746572656420616c72656164792062656c6f6e677320746f20616e6f7468657220757365722e20496620796f75207769736820746f206f7665722d77726974652074686973206173736f63696174696f6e207769746820746865206e6577206163636f756e742c2075736520746865206f7665722d777269746520636865636b626f782e, '2006-06-12 15:39:43', ''),
('en', '_msgs', 'AT_ERROR_CURL_NOT_INSTALLED', 0x546865206375726c206c696272617279206e6565647320746f20626520696e7374616c6c656420666f72206761646765747320746f2062652061646465642e2020506c6561736520636f6e7461637420796f75722061646d696e6973747261746f7220666f72206d6f726520696e666f726d6174696f6e2e, '2009-06-09 14:44:50', ''),
('en', '_msgs', 'AT_ERROR_CUTOFF_DATE_WRONG', 0x546865204c617465205375626d697373696f6e732064617465206170706561727320746f2062652077726f6e672e204974206d757374206f63637572206166746572207468652044756520446174652c20616e64206d75737420626520696e20746865206675747572652e, '2012-07-23 12:10:15', ''),
('en', '_msgs', 'AT_ERROR_DB_NOT_UPDATED', 0x496e666f726d6174696f6e20636f756c64206e6f7420626520616464656420746f207468652064617461626173652e, '2003-05-16 13:42:17', 'error msg'),
('en', '_msgs', 'AT_ERROR_DB_QUERY', 0x415475746f722077617320756e61626c6520746f20616363657373207468652064617461626173652e204966207468652070726f626c656d2070657273697374732c20706c65617365207265706f7274207468697320746f20616e2041646d696e6973747261746f72207769746820746869732064617465207265666572656e63652028257329, '2013-10-16 18:50:46', 'queryDB failure'),
('en', '_msgs', 'AT_ERROR_DIR_NOT_DELETED', 0x43616e6e6f74206f70656e206469726563746f727920746f2062652064656c657465642e, '2003-05-16 13:42:17', 'error msg'),
('en', '_msgs', 'AT_ERROR_DIR_NOT_EXIST', 0x4469726563746f7279203c7374726f6e673e25733c2f7374726f6e673e20646f6573206e6f742065786973742e20506c65617365206372656174652069742e, '2005-09-22 14:08:05', 'file manager'),
('en', '_msgs', 'AT_ERROR_DIR_NOT_WRITEABLE', 0x4469726563746f7279203c7374726f6e673e25733c2f7374726f6e673e206973206e6f7420777269746561626c652e204f6e20556e69782069737375652074686520636f6d6d616e64203c6b62643e63686d6f6420612b72773c2f6b62643e206f6e20746865206469726563746f72792e, '2005-09-22 14:22:24', ''),
('en', '_msgs', 'AT_ERROR_DIR_NO_PERMISSION', 0x43616e6e6f742064656c65746520666f6c6465722e20596f75206d6179206e6f742068617665207072656d697373696f6e2c206f72206974206d6179206e6f7420626520656d7074792e, '2003-05-22 12:20:14', 'error msg'),
('en', '_msgs', 'AT_ERROR_DISABLE_CORE_MODULE', 0x436f7265206d6f64756c65732063616e6e6f742062652064697361626c65642e, '2005-08-25 14:00:13', ''),
('en', '_msgs', 'AT_ERROR_DISABLE_MISSING_MODULE', 0x596f752063616e6e6f742064697361626c652061206d697373696e67206d6f64756c652e20546f20636f6e74696e7565206d616e6167696e672074686973206d6f64756c6520796f75206d75737420666972737420726573746f726520697473206469726563746f72792e, '2005-10-05 16:22:01', ''),
('en', '_msgs', 'AT_ERROR_DISABLE_PARTIALLY_UNINSTALLED_MODULE', 0x596f752063616e6e6f742064697361626c652061207061727469616c6c7920756e696e7374616c6c6564206d6f64756c652e20546f20636f6e74696e7565206d616e6167696e672074686973206d6f64756c6520796f75206d75737420666972737420726573746f72652069742e, '2008-10-21 15:41:53', 'error msg'),
('en', '_msgs', 'AT_ERROR_DOB_INVALID', 0x44617465206f662062697274682068617320696e76616c696420666f726d61742e, '2004-06-24 12:53:34', ''),
('en', '_msgs', 'AT_ERROR_EC_INVOICE_APPROVED', 0x496e766f696365206e756d6265722068617320616c7265616479206265656e20617070726f7665642e, '2013-08-01 10:18:14', ''),
('en', '_msgs', 'AT_ERROR_EC_INVOICE_NOT_FOUND', 0x496e766f696365206e756d6265722063616e6e6f7420626520666f756e642e, '2013-08-01 10:18:14', ''),
('en', '_msgs', 'AT_ERROR_EC_PAYMENTS_NO_COURSE_SELECTED', 0x4e6f20636f75727365207761732073656c65637465642e20, '2013-08-01 10:18:14', ''),
('en', '_msgs', 'AT_ERROR_EC_PAYMENT_FAILED', 0x546865207061796d656e74207761732063616e63656c6c6564206f7220206661696c65642e, '2013-08-01 10:18:14', ''),
('en', '_msgs', 'AT_ERROR_EMAIL_EXISTS', 0x416e206163636f756e742077697468207468617420656d61696c206164647265737320616c7265616479206578697374732e, '2005-03-01 11:36:57', 'error msg'),
('en', '_msgs', 'AT_ERROR_EMAIL_INVALID', 0x456d61696c20616464726573732077617320696e76616c69642e, '2003-05-16 13:42:17', 'error msg'),
('en', '_msgs', 'AT_ERROR_EMAIL_MISMATCH', 0x456d61696c2061646472657373657320646f206e6f74206d617463682e20506c656173652072652d74797065207468656d2e, '2009-11-04 14:12:12', ''),
('en', '_msgs', 'AT_ERROR_EMAIL_NOT_FOUND', 0x4e6f206163636f756e7420666f756e642077697468207468617420656d61696c20616464726573732e, '2003-05-16 13:42:17', 'error msg'),
('en', '_msgs', 'AT_ERROR_EMPTY_FIELDS', 0x54686520666f6c6c6f77696e67207265717569726564206669656c642873292061726520656d7074793a3c6272202f3e0d0a25732e, '2006-10-05 15:51:52', ''),
('en', '_msgs', 'AT_ERROR_EMPTY_ZIP_FILE', 0x446f776e6c6f61646564207a69702066696c6520697320656d7074792e, '2008-10-21 15:41:53', ''),
('en', '_msgs', 'AT_ERROR_END_DATE_INVALID', 0x5468617420656e642064617465206973206e6f742076616c69642e, '2003-05-16 13:42:17', 'error msg'),
('en', '_msgs', 'AT_ERROR_ENROLLMENT_NONE_FOUND', 0x5468657265206973206e6f206f6e6520746f206578706f72742e, '2006-06-27 11:53:26', ''),
('en', '_msgs', 'AT_ERROR_FEEDBACK_AUTOHIDE_NEGATIVE_VALUE', 0x5468652076616c756520666f72206175746f6869646520666565646261636b207761732073657420746f206e656761746976652e20506c6561736520656e746572206120706f7369746976652076616c75652e, '2013-12-18 18:39:32', ''),
('en', '_msgs', 'AT_ERROR_FEED_NO_CONTENT', 0x5468652066656564206569746865722063616e6e6f7420626520666f756e6420617420746861742055524c206f72206973206e6f742076616c69642e, '2005-11-23 10:59:56', ''),
('en', '_msgs', 'AT_ERROR_FILE_EMPTY', 0x596f7520646964206e6f742073656c65637420612066696c6520746f20696d706f7274206f72207468652066696c652077617320656d7074792e, '2004-12-09 14:44:43', 'enrollment manager'),
('en', '_msgs', 'AT_ERROR_FILE_ILLEGAL', 0x25732066696c657320617265206e6f7420616c6c6f7765642e, '2003-05-22 11:52:08', 'error msg'),
('en', '_msgs', 'AT_ERROR_FILE_MAX_SIZE', 0x5468652066696c6520657863656564656420746865206d6178696d756d20616c6c6f7761626c652073697a65206c696d6974206f662025732e, '2004-05-06 13:18:19', ''),
('en', '_msgs', 'AT_ERROR_FILE_NOT_DELETED', 0x4572726f722064656c6574696e672066696c652e2043616e6e6f742064656c6574652066696c652e, '2004-11-08 16:33:12', 'file manager'),
('en', '_msgs', 'AT_ERROR_FILE_NOT_EXIST', 0x5468652073656c65637465642066696c6520646f6573206e6f742065786973742e, '2005-01-07 09:51:45', 'filemanager, fiule to be edited does not exist'),
('en', '_msgs', 'AT_ERROR_FILE_NOT_FOUND', 0x46696c65206e6f7420666f756e642e, '2006-03-20 14:45:12', ''),
('en', '_msgs', 'AT_ERROR_FILE_NOT_SAVED', 0x5468652066696c652063616e6e6f742062652073617665642e, '2003-05-16 13:42:17', 'error msg'),
('en', '_msgs', 'AT_ERROR_FILE_NOT_SELECTED', 0x596f7520646964206e6f742073656c65637420612066696c6520746f2075706c6f61642e, '2003-05-16 13:42:17', 'error msg'),
('en', '_msgs', 'AT_ERROR_FILE_TOO_BIG', 0x5468652066696c652073697a65206578636565647320746865206c696d6974206f66203c7374726f6e673e2573203c2f7374726f6e673e2e20436f6e7461637420796f757220415475746f722041646d696e6973747261746f7220746f20686176652074686973206c696d697420696e637265617365642e, '2005-01-15 18:49:53', 'error msg'),
('en', '_msgs', 'AT_ERROR_FIRST_LAST_NAME_UNIQUE', 0x46697273742c207365636f6e642c20616e64206c617374206e616d657320636f6d62696e6174696f6e206d75737420626520756e697175652e, '2006-03-27 14:55:34', ''),
('en', '_msgs', 'AT_ERROR_FOLDER_NOT_CREATED', 0x54686520666f6c6465722022202573202220636f756c64206e6f7420626520637265617465642e, '2006-06-02 13:43:53', 'error msg'),
('en', '_msgs', 'AT_ERROR_FOLDER_NOT_EXIST', 0x466f6c646572206e6f7420666f756e642e, '2006-03-20 15:37:24', ''),
('en', '_msgs', 'AT_ERROR_FORUM_DENIED', 0x596f7520646f206e6f74202068617665207065726d697373696f6e20746f20706f737420696e207468697320666f72756d2e, '2005-08-10 13:48:14', ''),
('en', '_msgs', 'AT_ERROR_FORUM_NOT_FOUND', 0x466f72756d2063616e206e6f7420626520666f756e642e, '2003-05-16 13:42:17', 'error msg'),
('en', '_msgs', 'AT_ERROR_FORUM_NO_DEL_SHARE', 0x596f7520646f206e6f742068617665207065726d697373696f6e20746f2064656c65746520612073686172656420666f72756d2e, '2004-12-10 11:10:25', ''),
('en', '_msgs', 'AT_ERROR_FORUM_NO_EDIT_SHARE', 0x596f7520646f206e6f742068617665207065726d697373696f6e20746f206564697420612053686172656420666f72756d2e, '2004-12-10 11:15:41', ''),
('en', '_msgs', 'AT_ERROR_FORUM_NO_SUBSCRIBE', 0x43616e6e6f742073756273637269626520746f2074686520726571756573746564207468726561642e204f6e6c7920737562736372697074696f6e20746f2074686520746f702d6c6576656c20706f737420697320616c6c6f7765642e, '2004-12-10 13:44:57', 'forum/subscribe.php'),
('en', '_msgs', 'AT_ERROR_GADGET_ADDED_FAILURE', 0x54686520666f6c6c6f77696e67206572726f72206f636375726564207768696c6520616464696e672061206761646765743a0d0a2573, '2009-06-22 11:19:44', 'gadget error'),
('en', '_msgs', 'AT_ERROR_GADGET_DELETED_CANNOT_BE_EMPTY', 0x596f75206e65656420746f2073656c656374206174206c65617374206f6e65206170706c69636174696f6e20746f2064656c6574652e, '2009-05-27 12:01:11', ''),
('en', '_msgs', 'AT_ERROR_GENERAL', 0x5468697320697320612073656172636820616e6420257320415475746f72206572726f722e, '2003-05-22 11:52:28', 'error msg'),
('en', '_msgs', 'AT_ERROR_GOOGLE_KEY_INVALID', 0x496e76616c6964206b65792e, '2005-11-30 14:35:03', ''),
('en', '_msgs', 'AT_ERROR_GOOGLE_KEY_MISSING', 0x4120476f6f676c65204b6579206d75737420626520656e746572656420696e206f7264657220666f722074686520656e61626c6564205765622053656172636820746f20626520617661696c61626c6520696e20636f75727365732e20456e7465722074686973206b657920627920676f696e6720746f20476f6f676c65204b657920756e6465722074686520436f6e66696775726174696f6e207461622e, '2005-11-30 14:40:38', ''),
('en', '_msgs', 'AT_ERROR_GOOGLE_QUERY_FAILED', 0x5175657279206661696c65642e, '2005-10-20 10:52:04', ''),
('en', '_msgs', 'AT_ERROR_GROUP_CREATION_FAILED', 0x47726f7570206372656174696f6e206661696c65642e, '2009-05-27 12:01:11', ''),
('en', '_msgs', 'AT_ERROR_GROUP_EDIT_FAILED', 0x47726f75702065646974206661696c65642e, '2009-05-27 12:01:11', ''),
('en', '_msgs', 'AT_ERROR_GROUP_HAS_BEEN_REMOVED', 0x47726f757020686173206265656e2072656d6f7665642e, '2009-05-27 12:01:11', ''),
('en', '_msgs', 'AT_ERROR_GROUP_NOT_FOUND', 0x47726f7570206e6f7420666f756e642e, '2004-11-25 16:03:01', ''),
('en', '_msgs', 'AT_ERROR_GROUP_NO_STUDENTS', 0x546865726520617265206e6f2073747564656e747320746f206372656174652067726f75707320666f722e, '2006-03-22 13:33:24', ''),
('en', '_msgs', 'AT_ERROR_HAND_IN_FOLDER', 0x466f6c646572732063616e6e6f742062652068616e64656420696e2e, '2006-03-20 15:43:06', ''),
('en', '_msgs', 'AT_ERROR_ID_ZERO', 0x436f6e74656e7420494420776173207a65726f2c206f7220776173206d697373696e672e, '2003-05-16 13:42:17', 'error msg'),
('en', '_msgs', 'AT_ERROR_IMPORTDIR_FAILED', 0x556e61626c6520746f2063726561746520696d706f7274206469726563746f72792e, '2005-07-20 14:02:57', 'error msg'),
('en', '_msgs', 'AT_ERROR_IMPORTDIR_IMS_NOTVALID', 0x5468652066696c6520646f6573206e6f742061707065617220746f20626520612076616c6964205a49502066696c652e, '2005-06-27 11:37:47', 'IMS file is not a ZIP file.'),
('en', '_msgs', 'AT_ERROR_IMPORTFILE_EMPTY', 0x54686520696d706f72742066696c65206d757374206e6f7420626520656d7074792e, '2003-05-16 13:42:17', 'error msg'),
('en', '_msgs', 'AT_ERROR_IMPORT_CARTRIDGE_FAILED', 0x496d706f7274206661696c65642e20446f6573206e6f742061707065617220746f20626520612076616c696420636f6e74656e74207061636b616765206f7220636f6d6d6f6e206361727472696467653a0d0a0d0a2573, '2009-12-03 09:55:01', ''),
('en', '_msgs', 'AT_ERROR_IMPORT_ERROR_IN_ZIP', 0x5a69702066696c6520636f756c64206e6f742062652065787472616374656420626563617573653a203c623e202573203c2f623e, '2006-06-28 10:30:50', 'theme manager'),
('en', '_msgs', 'AT_ERROR_IMPORT_FAILED', 0x496d706f7274204661696c6564, '2005-01-15 09:50:40', ''),
('en', '_msgs', 'AT_ERROR_IMPORT_NOT_PROPER_FORMAT', 0x5468652073656c65637465642066696c6520646f6573206e6f742061707065617220746f20626520612076616c6964207468656d65207061636b6167652e, '2004-12-09 11:34:27', 'admin/themes/import.php'),
('en', '_msgs', 'AT_ERROR_IMS_AUTHORIZATION_NOT_SUPPORT', 0x496d706f7274206661696c65642e2020415475746f7220646f6573206e6f7420737570706f7274207061636b6167652061757468656e7469636174696f6e732e, '2009-12-10 12:19:12', ''),
('en', '_msgs', 'AT_ERROR_INCOMPLETE', 0x506c656173652066696c6c206f75742074686520666f726d732061732064697265637465642062656c6f77, '2004-10-18 11:14:50', 'enrollment Manager, incomplete info in create list'),
('en', '_msgs', 'AT_ERROR_INCORRECT_FILE_FORMAT', 0x46696c6520697320696e2074686520696e636f727265637420666f726d61742e20526576696577206c696e65202573206f6620796f757220636f75727365206c6973742066696c6520616e64206d616b65207375726520697420666f6c6c6f777320666f726d61742067756964656c696e65732e, '2006-06-28 10:43:48', ''),
('en', '_msgs', 'AT_ERROR_INST_INFO_NOT_FOUND', 0x496e7374727563746f7220696e666f726d6174696f6e2063616e6e6f7420626520666f756e642e, '2003-05-16 13:42:17', 'error msg'),
('en', '_msgs', 'AT_ERROR_INVALID_EMAIL', 0x456d61696c206164647265737320697320696e76616c69642e, '2013-09-11 12:34:03', ''),
('en', '_msgs', 'AT_ERROR_INVALID_LINK', 0x546865206c696e6b2069732065697468657220696e76616c6964206f7220657870697265642e, '2006-05-10 09:08:50', ''),
('en', '_msgs', 'AT_ERROR_INVALID_LOGIN', 0x496e76616c6964206c6f67696e2f70617373776f726420636f6d62696e6174696f6e2e, '2003-05-16 13:42:17', 'error msg'),
('en', '_msgs', 'AT_ERROR_INVALID_URL', 0x4c6f63616c686f7374206973206e6f7420612076616c69642055524c, '2004-11-05 10:22:37', 'AChecker'),
('en', '_msgs', 'AT_ERROR_ITEM_NOT_FOUND', 0x4974656d206e6f7420666f756e642e, '2006-10-04 10:52:48', 'generic something not found msg.'),
('en', '_msgs', 'AT_ERROR_JOIN_REQUEST_FAILED', 0x5265717565737420746f206a6f696e2067726f7570206661696c65642e205065726861707320796f75206861766520616c72656164792072657175657374656420746f206a6f696e20746869732067726f75702e, '2009-05-27 12:01:11', ''),
('en', '_msgs', 'AT_ERROR_LANG_EXISTS', 0x546865206c616e6775616765207061636b20796f752061726520747279696e6720746f20696d706f727420616c7265616479206578697374732e204c616e677561676520616c7265616479206578697374732e20596f752063616e2065646974206c616e67756167652070726f7065727469657320627920666f6c6c6f77696e6720746865203c656d3e7472616e736c6174653c2f656d3e20696e2074686520737562206d656e752061626f76652e, '2007-02-06 15:44:17', ''),
('en', '_msgs', 'AT_ERROR_LANG_IMPORT_FAILED', 0x4c616e677561676520696d706f7274206661696c65642e, '2003-06-06 11:23:51', 'admin language manager'),
('en', '_msgs', 'AT_ERROR_LANG_NOT_COMPLETE', 0x546865206c616e6775616765207061636b20796f752061726520747279696e6720746f20696d706f727420686173206e6f74206265656e206d61726b656420617320636f6d706c65746520616e64207075626c69736865642e20546f2075736520696e636f6d706c657465206c616e6775616765207061636b7320796f75206d75737420656e61626c65203c656d3e7472616e736c6174696e673c2f656d3e207573696e672074686520696e737472756374696f6e732061742074686520626f74746f6d206f66207468697320706167652e, '2005-11-30 14:49:00', ''),
('en', '_msgs', 'AT_ERROR_LANG_WRONG_VERSION', 0x546865206c616e6775616765207061636b20796f752061726520747279696e6720746f20696d706f7274206973206e6f7420636f6d70617469626c65207769746820746869732076657273696f6e206f6620415475746f722e20496620796f75207374696c6c2077616e7420746f20696d706f72742074686973206c616e6775616765207061636b20796f75206d75737420656e61626c65203c656d3e7472616e736c6174696e673c2f656d3e20666f6c6c6f77696e672074686520696e737472756374696f6e7320756e64657220746865205472616e736c617465205461622e, '2011-09-08 16:21:58', ''),
('en', '_msgs', 'AT_ERROR_LAST_LANGUAGE', 0x43616e6e6f742064656c65746520746865206c617374206c616e67756167652e204174206c65617374206f6e65206c616e6775616765206d75737420626520617661696c61626c652e, '2006-06-29 16:50:59', ''),
('en', '_msgs', 'AT_ERROR_LINK_CAT_EMPTY', 0x43616e6e6f74206164642061206c696e6b206265636175736520746865726520617265206e6f2063617465676f726965732e, '2005-03-09 13:05:25', 'adding link but no cats'),
('en', '_msgs', 'AT_ERROR_LINK_CAT_NOT_EMPTY', 0x4c696e6b2063617465676f72792063616e6e6f742062652064656c65746564206265636175736520697420636f6e7461696e73207375622d63617465676f7269657320616e642f6f72206c696e6b732e, '2005-02-22 15:22:44', 'error msg'),
('en', '_msgs', 'AT_ERROR_LOGIN_CHARS', 0x596f7572204c6f67696e204e616d65206d757374206f6e6c7920636f6e7461696e206c6574746572732c206e756d626572732c20706572696f64732c206f7220756e64657273636f72657320285f2773292e, '2006-07-11 10:40:57', 'error msg'),
('en', '_msgs', 'AT_ERROR_LOGIN_ENROL', 0x596f75206d757374206265206c6f6767656420696e20746f20656e726f6c6c20696e206120636f757273652e, '2003-05-16 13:42:17', 'error msg'),
('en', '_msgs', 'AT_ERROR_LOGIN_EXISTS', 0x54686174206c6f67696e20616c7265616479206578697374732c20706c656173652063686f6f736520616e6f746865722e, '2003-05-16 13:42:17', 'error msg'),
('en', '_msgs', 'AT_ERROR_LOGIN_TO_POST', 0x596f75206d757374206265206c6f6767656420696e20746f20706f73742e, '2003-05-16 13:42:17', 'error msg'),
('en', '_msgs', 'AT_ERROR_LOG_NOT_RESET', 0x546865206572726f72206c6f6720636f756c64206e6f742062652072657365742e, '2005-03-10 15:54:03', 'error logging'),
('en', '_msgs', 'AT_ERROR_MAX_LOGIN_ATTEMPT', 0x4d6178696d756d206c6f67696e20617474656d70747320686173206265656e20726561636865642e204c6f67696e20686173206265656e2074656d706f726172696c792064697361626c656420666f72203120686f75722e2020506c656173652074727920616761696e206c617465722e, '2009-06-17 11:59:49', ''),
('en', '_msgs', 'AT_ERROR_MAX_LOGIN_ATTEMPT_1', 0x496e76616c696420757365726e616d65206f722070617373776f72642e20596f752068617665206f6e65206d6f726520617474656d7074206265666f726520746865206c6f67696e20706167652069732064697361626c65642e, '2009-06-26 16:37:13', ''),
('en', '_msgs', 'AT_ERROR_MAX_LOGIN_ATTEMPT_2', 0x596f75206861766520656e746572656420616e20756e7265636f676e697a6564206c6f67696e20616e642070617373776f726420636f6d62696e6174696f6e2e20596f7520686176652074776f206d6f726520617474656d707473206265666f726520746865206c6f67696e20706167652069732064697361626c65642e, '2009-06-26 16:35:44', ''),
('en', '_msgs', 'AT_ERROR_MAX_STORAGE_EXCEEDED', 0x416464696e6720746869732066696c65206578636565647320746865206d6178696d756d20636f757273652073746f72616765206c696d69742e, '2003-10-03 16:00:08', 'error msg'),
('en', '_msgs', 'AT_ERROR_MISSING_TEST', 0x54776f207465737473206d7573742062652073656c656374656420746f20636f6d62696e652074657374732e, '2013-09-23 19:28:04', 'gradebook combine test'),
('en', '_msgs', 'AT_ERROR_MISSING_THEMEXML', 0x43616e6e6f7420696d706f72742e2054686520696d706f7274207061636b616765206973206d697373696e67206120766974616c20636f6d706f6e656e743a207468656d65732e786d6c2e20436865636b207468617420746865207468656d65207061636b61676520697320666f722076657273696f6e20312e342e33206f722061626f76652e, '2004-12-09 11:59:21', 'admin/themese/import.php'),
('en', '_msgs', 'AT_ERROR_MODULE_INSTALL', 0x54686520666f6c6c6f77696e67206572726f72287329207765726520656e636f756e7465726564207768656e20747279696e6720746f20696e7374616c6c2074686973206d6f64756c653a0d0a3c756c3e25733c2f756c3e, '2005-10-11 10:48:49', ''),
('en', '_msgs', 'AT_ERROR_MODULE_UNINSTALL', 0x54686520666f6c6c6f77696e67206572726f72287329207765726520656e636f756e7465726564207768656e20747279696e6720746f20696e7374616c6c2074686973206d6f64756c653a0d0a3c756c3e25733c2f756c3e, '2008-10-21 15:41:53', 'error msg'),
('en', '_msgs', 'AT_ERROR_MYSQL_FAILED', 0x436f6e6e656374696f6e20746f204d7953514c206661696c65642e, '2009-12-01 11:07:33', ''),
('en', '_msgs', 'AT_ERROR_NEED_FILENAME', 0x46696c656e616d6520776173206c65667420656d7074792e204e65656420612066696c656e616d6520746f20637265617465206e65772066696c652e, '2004-11-09 16:19:24', 'file manager'),
('en', '_msgs', 'AT_ERROR_NEED_UNIQUE_TOOLID', 0x54686520546f6f6c494420697320616c726561647920696e207573652e2043686f6f736520616e6f746865722e, '2013-09-07 09:50:48', 'admin create LTI'),
('en', '_msgs', 'AT_ERROR_NODELETE_USER', 0x43616e6e6f742064656c6574652074686973207573657220626563617573652074686579206f776e20636f75727365732e2044656c6574652074686520636f75727365732066697273742e, '2003-05-16 13:42:17', 'error msg'),
('en', '_msgs', 'AT_ERROR_NOT_CONFIRMED', 0x596f7572206163636f756e74277320656d61696c206164647265737320686173206e6f7420796574206265656e20636f6e6669726d65642e2020506c6561736520636865636b20796f757220656d61696c206163636f756e7420666f72206120636f6e6669726d6174696f6e206d6573736167652e2020506c6561736520636f6e7461637420757320696620796f7520646f206e6f7420726563656976652069742e, '2006-06-21 10:59:56', ''),
('en', '_msgs', 'AT_ERROR_NOT_IN_ANY_GROUPS', 0x596f7520617265206e6f7420696e20616e792067726f7570732e, '2006-04-11 13:34:20', ''),
('en', '_msgs', 'AT_ERROR_NOT_OWNER', 0x596f7520646f206e6f74206f776e207468697320636f75727365206f7220697420646f6573206e6f742065786973742e, '2003-05-16 13:42:17', 'error msg'),
('en', '_msgs', 'AT_ERROR_NOT_RELEASED', 0x5468697320636f6e74656e7420686173206e6f7420796574206265656e2072656c65617365642e202573, '2003-05-22 11:52:38', 'error msg'),
('en', '_msgs', 'AT_ERROR_NO_ACTION_SELECTED', 0x4e6f20616374696f6e2073656c65637465642e, '2007-02-21 14:12:39', ''),
('en', '_msgs', 'AT_ERROR_NO_ASSIGNMENTS_FOUND', 0x4e6f2061737369676e6d656e7473206172652064756520696e207468697320776f726b73706163652e20596f75206d696768742074727920616e6f7468657220776f726b73706163652e, '2007-12-13 16:12:07', ''),
('en', '_msgs', 'AT_ERROR_NO_BOXES_CHECKED', 0x596f75206d7573742073656c656374206174206c65617374206f6e6520636865636b626f782e, '2010-04-12 16:39:34', ''),
('en', '_msgs', 'AT_ERROR_NO_CHILD_AS_PARENT', 0x43616e6e6f74206d6f76652074686520636f6e74656e7420746f20626520746865206368696c64206f6620697473206f776e206368696c6472656e2e, '2009-09-16 13:14:12', ''),
('en', '_msgs', 'AT_ERROR_NO_CONTENT_SPACE', 0x4e6f7420656e6f75676820737061636520746f20696d706f727420636f6e74656e74206469726563746f72792e202573204b42206f76657220746865206c696d69742e, '2003-10-03 15:58:38', 'error msg'),
('en', '_msgs', 'AT_ERROR_NO_COURSE_FLOAT', 0x496e76616c6964204d6178696d756d20436f7572736520466c6f61742076616c75652e, '2005-06-20 10:44:45', 'Admin did not specify a float for course size.'),
('en', '_msgs', 'AT_ERROR_NO_FAQ_TOPICS', 0x596f75206d75737420666972737420616464206120746f7069632e, '2005-10-19 12:44:36', ''),
('en', '_msgs', 'AT_ERROR_NO_IMSMANIFEST', 0x494d53206d616e69666573742066696c65206973206d697373696e672e205468697320646f6573206e6f742061707065617220746f20626520612076616c696420494d5320636f6e74656e74207061636b616765206f7220636f6d6d6f6e206361727472696467652e, '2009-11-17 12:38:14', ''),
('en', '_msgs', 'AT_ERROR_NO_IMS_BACKUP', 0x546869732066696c65206170706561727320746f2062652061203c6120687265663d226d6f64732f5f636f72652f6261636b7570732f223e636f75727365206261636b75703c2f613e20726174686572207468616e206120636f6e74656e74207061636b6167652e, '2010-03-09 14:27:08', ''),
('en', '_msgs', 'AT_ERROR_NO_ITEM_SELECTED', 0x596f75206d7573742073656c65637420616e206974656d206265666f7265207573696e67206120627574746f6e2e, '2005-03-07 16:36:43', ''),
('en', '_msgs', 'AT_ERROR_NO_LANGUAGE', 0x53656c6563746564206c616e6775616765206973206e6f7420737570706f727465642e, '2003-05-16 13:42:17', 'error msg'),
('en', '_msgs', 'AT_ERROR_NO_LOGS_SELECTED', 0x596f75206d7573742073656c656374206174206c65617374206f6e652070726f66696c6520746f2063726561746520612062756e646c652e, '2004-11-25 11:18:19', 'admin/error_logging_details.php'),
('en', '_msgs', 'AT_ERROR_NO_LOG_SELECTED', 0x596f7520646964206e6f742073656c6563742061206c6f672066696c652e, '2004-11-23 15:59:57', 'admin/error_logging_details.php'),
('en', '_msgs', 'AT_ERROR_NO_MEMBERS', 0x4e6f20757365727320666f756e642e, '2005-05-18 12:43:40', ''),
('en', '_msgs', 'AT_ERROR_NO_PROFILE_SELECTED', 0x596f7520646964206e6f742073656c65637420612070726f66696c652e, '2004-11-23 16:01:27', 'admin/error_logging_details.php'),
('en', '_msgs', 'AT_ERROR_NO_QUESTIONS', 0x4e6f207175657374696f6e73207765726520666f756e6420666f72207468697320746573742e, '2003-05-16 13:42:17', 'error msg'),
('en', '_msgs', 'AT_ERROR_NO_QUESTIONS_SELECTED', 0x596f7520646964206e6f742073656c65637420616e79207175657374696f6e7320746f2061646420746f207468697320746573742e, '2004-11-23 11:56:45', ''),
('en', '_msgs', 'AT_ERROR_NO_RECIPIENTS', 0x546865726520617265206e6f20726563697069656e7473206f66207468697320656d61696c2e, '2013-09-11 12:34:03', ''),
('en', '_msgs', 'AT_ERROR_NO_SELF_AS_PARENT', 0x43616e6e6f74206d6f76652074686520636f6e74656e7420746f20626520697473206f776e206368696c642e, '2009-09-16 13:14:00', ''),
('en', '_msgs', 'AT_ERROR_NO_SPACE_LEFT', 0x5468657265206973206e6f206d6f726520737061636520696e207468697320636f7572736520746f2065787472616374207468697320617263686976652e, '2003-05-16 13:42:17', 'error msg'),
('en', '_msgs', 'AT_ERROR_NO_STUDENT_SELECTED', 0x596f7520646964206e6f742073656c65637420616e792073747564656e74732e, '2006-06-27 12:18:13', 'enrollment manager, no students selected'),
('en', '_msgs', 'AT_ERROR_NO_SUCH_USER', 0x546865207573657220796f752073656c656374656420646f6573206e6f742065786973742e, '2005-03-17 15:34:30', 'veiwing profile but no such user'),
('en', '_msgs', 'AT_ERROR_OL_CRON_NOT_VAL', 0x55706461746520646174616261736520696e74657276616c206973206e6f742076616c6964, '2013-08-01 10:18:14', ''),
('en', '_msgs', 'AT_ERROR_OL_DB_NOT_UPDATED', 0x4572726f7220696e207570646174696e67206461746162617365, '2013-08-01 10:18:14', ''),
('en', '_msgs', 'AT_ERROR_OL_URL_NOT_VAL', 0x456e74657265642055524c206973206e6f742076616c6964, '2013-08-01 10:18:14', ''),
('en', '_msgs', 'AT_ERROR_ONLY_EXPORT_EXTRA_MODULE', 0x596f752063616e206f6e6c79206578706f7274204578747261206d6f64756c65732e, '2013-01-19 16:16:18', ''),
('en', '_msgs', 'AT_ERROR_ONLY_UNINSTALL_EXTRA_MODULE', 0x4f6e6c79206d6f64756c65732077697468207479706520224578747261222063616e20626520756e696e7374616c6c65642e, '2008-10-21 15:41:53', ''),
('en', '_msgs', 'AT_ERROR_PACKAGE_DIR_FAILED', 0x50726f626c656d2077697468205061636b616765204469726563746f72792e, '2005-05-17 12:02:28', ''),
('en', '_msgs', 'AT_ERROR_PAGE_NOT_FOUND', 0x506167652063616e6e6f7420626520666f756e642e, '2005-09-19 12:18:06', 'error msg'),
('en', '_msgs', 'AT_ERROR_PASSWORD_CHARS', 0x5468652070617373776f7264206d75737420636f6e7461696e206120636f6d62696e6174696f6e206f66206c6574746572732c20616e64206e756d62657273206f722073796d626f6c732e, '2010-10-07 09:26:30', ''),
('en', '_msgs', 'AT_ERROR_PASSWORD_LENGTH', 0x50617373776f7264206d757374206265206174206c6561737420382063686172616374657273206c6f6e672e, '2006-04-10 11:43:46', ''),
('en', '_msgs', 'AT_ERROR_PASSWORD_MISMATCH', 0x50617373776f72647320646964206e6f74206d617463682e, '2003-05-16 13:42:17', 'error msg'),
('en', '_msgs', 'AT_ERROR_PATCH_ALREADY_INSTALLED', 0x5468652073656c656374656420706174636820697320616c726561647920696e7374616c6c65642e, '2008-04-21 15:08:55', 'error msg'),
('en', '_msgs', 'AT_ERROR_PATCH_DEPENDENCY', 0x44756520746f20706174636820646570656e64656e63792c20706c6561736520696e7374616c6c20746865206c69737465642070617463686573206265666f726520696e7374616c6c696e6720746869732070617463683a202573, '2008-04-21 15:08:55', 'error msg'),
('en', '_msgs', 'AT_ERROR_PATCH_XML_NOT_FOUND', 0x506174636820584d4c2066696c65206973206e6f7420666f756e642e, '2008-04-21 15:08:55', 'error msg'),
('en', '_msgs', 'AT_ERROR_PA_ADD_COMMENT_FAILED', 0x436f6d6d656e7420636f756c64206e6f742062652061646465642064756520746f20616e20696e7465726e616c206572726f722e2020506c656173652074727920616761696e2e, '2010-03-17 16:05:53', 'photo album'),
('en', '_msgs', 'AT_ERROR_PA_ADD_PHOTO_FAILED', 0x50686f746f20636f756c64206e6f742062652061646465642064756520746f20616e20696e7465726e616c206572726f722e2020506c656173652074727920616761696e2e, '2010-03-17 16:06:23', 'photo album'),
('en', '_msgs', 'AT_ERROR_PA_CREATE_ALBUM_FAILED', 0x416c62756d20636f756c64206e6f7420626520637265617465642064756520746f20616e20696e7465726e616c206572726f722e2020506c656173652074727920616761696e2e, '2010-03-17 16:06:36', 'photo album'),
('en', '_msgs', 'AT_ERROR_PA_EDIT_ALBUM_FAILED', 0x416c62756d20636f756c64206e6f74206265206564697465642064756520746f20616e20696e7465726e616c206572726f722e2020506c656173652074727920616761696e2e, '2010-03-17 16:06:49', 'photo album'),
('en', '_msgs', 'AT_ERROR_PA_EDIT_PHOTO_FAILED', 0x50686f746f20636f756c64206e6f74206265206564697465642064756520746f20616e20696e7465726e616c206572726f722e2020506c656173652074727920616761696e2e, '2010-03-17 16:07:01', 'photo album'),
('en', '_msgs', 'AT_ERROR_PA_EMPTY_COMMENT', 0x436f6d6d656e742063616e206e6f7420626520656d7074792e, '2010-03-17 16:06:10', 'photo album'),
('en', '_msgs', 'AT_ERROR_PA_EMTPY_ALBUM_NAME', 0x416c62756d206e616d652063616e206e6f7420626520656d7074792e, '2010-03-17 16:07:15', 'photo album'),
('en', '_msgs', 'AT_ERROR_PA_EXCEEDED_MAX_USAGE', 0x596f75206861766520657863656564656420746865206d6178696d756d20616c6c6f7761626c65206d656d6f727920757361676520666f72207468652070686f746f20616c62756d2e, '2010-03-17 16:08:06', 'photo album'),
('en', '_msgs', 'AT_ERROR_PA_MEMORY_INPUT_ERROR', 0x496e76616c696420696e7075742e2020506c6561736520656e74657220612076616c696420496e74656765722e, '2010-03-17 16:07:40', 'photo album'),
('en', '_msgs', 'AT_ERROR_PA_MEMORY_SQL_ERROR', 0x507265666572656e6365732077657265206e6f7420757064617465642064756520746f20616e20696e7465726e616c206572726f722e2020506c656173652074727920616761696e2e, '2010-03-17 16:07:52', 'photo album'),
('en', '_msgs', 'AT_ERROR_PA_PHOTO_NOT_FOUND', 0x50686f746f2063616e206e6f7420626520666f756e642e, '2010-03-17 16:07:27', 'photo album'),
('en', '_msgs', 'AT_ERROR_PHPMYADMINURL_ADD_EMPTY', 0x596f75206d75737420656e74657220612055524c20746f20746865206c6f636174696f6e206f6620796f7572207068704d7941646d696e20696e7374616c6c6174696f6e2e, '2013-12-09 20:42:09', ''),
('en', '_msgs', 'AT_ERROR_POLL_QUESTION_MINIMUM', 0x54686520706f6c6c206d7573742068617665206174206c656173742074776f207175657374696f6e732e, '2005-07-20 10:12:40', ''),
('en', '_msgs', 'AT_ERROR_QTI_WRONG_PACKAGE', 0x496d706f7274206661696c65642e2020506c65617365206e6f7465207468617420415475746f72206f6e6c7920737570706f7274732051544920312e322e3120696d706f72742e, '2008-12-15 10:04:05', ''),
('en', '_msgs', 'AT_ERROR_RAND_TEST_Q_WEIGHT', 0x546865206e6f6e2d7265717569726564207175657374696f6e73206d75737420616c6c2068617665207468652073616d65207765696768742e, '2007-07-09 15:03:55', ''),
('en', '_msgs', 'AT_ERROR_REGISTER_MASTER_USED', 0x5468652073747564656e7420494420616e642050494e20636f6d62696e6174696f6e20796f752070726f766964656420697320656974686572206265696e672075736564206f7220697320696e636f72726563742e, '2005-04-04 13:01:33', ''),
('en', '_msgs', 'AT_ERROR_REMOVE_WRITE_PERMISSION', 0x506c656173652072656d6f7665207772697465207065726d697373696f6e2066726f6d20746865206c69737465642066696c65732e, '2008-04-21 15:08:55', 'error msg'),
('en', '_msgs', 'AT_ERROR_RESOURCE_NOT_DEFINED', 0x596f7520646964206e6f742073656c6563742061207265736f7572636520746f206164642e, '2008-09-08 14:44:09', ''),
('en', '_msgs', 'AT_ERROR_RESTORE_TOO_BIG', 0x54686520636f7572736520697320746f6f20736d616c6c20746f20726573746f72652074686973206261636b757020696e746f2e, '2004-10-15 16:42:23', ''),
('en', '_msgs', 'AT_ERROR_RESULTS_NOT_RELEASED', 0x596f7520617265206e6f74207065726d697474656420746f2076696577207468657365207465737420726573756c747320617420746869732074696d652e, '2004-12-15 10:13:06', ''),
('en', '_msgs', 'AT_ERROR_RETURNED_ROWS', 0x517565727920222573222077686963682073686f756c6420686176652072657475726e6564206f6e6c79203120726f77206861732072657475726e6564206d6f726520726f77732e, '2013-10-16 18:57:57', ''),
('en', '_msgs', 'AT_ERROR_SAME_LOCATION', 0x54686520636f6e74656e7420697320616c726561647920617420746865206d6f766564206c6f636174696f6e2e, '2009-09-16 13:14:24', ''),
('en', '_msgs', 'AT_ERROR_SAVE_BEFORE_PROCEED', 0x506c6561736520736176652074686520636f6e74656e74206265666f72652070726f63656564696e672e, '2013-03-22 16:12:34', ''),
('en', '_msgs', 'AT_ERROR_SCORM_SETTINGS_SAVE_FAILED', 0x536176652053434f524d2073657474696e6773206661696c65642e205468697320636f756c64206d65616e207468652053434f524d206469726563746f727920686173206e6f74206265656e2073657475702070726f7065726c792e20536565207468652053434f524d206d6f64756c6520726561646d6520666f722064657461696c732e, '2009-11-04 14:13:40', ''),
('en', '_msgs', 'AT_ERROR_SCO_DIR_NOT_EXIST', 0x5468652053434f524d20525445206469726563746f727920646f6573206e6f742065786973742e20506c65617365206372656174652061206469726563746f72792063616c6c6564203c656d3e73636f3c2f656d3e20696e20796f757220696e7374616c6c6174696f6e7320746f70206469726563746f727920286578616d706c653a203c636f64653e7365727665722e636f6d2f415475746f722f73636f3c2f636f64653e292e, '2005-05-10 10:58:58', ''),
('en', '_msgs', 'AT_ERROR_SCO_DIR_NOT_WRITEABLE', 0x5468652053434f524d20525445206469726563746f7279206973206e6f7420777269746561626c652e20506c6561736520657865637574652074686520636f6d6d616e64203c636f64653e63686d6f6420612b7277782073636f3c2f636f64653e207768696c6520696e20415475746f72277320746f70206469726563746f72792e, '2005-05-10 11:00:08', ''),
('en', '_msgs', 'AT_ERROR_SCO_DISABLED', 0x5468652053434f524d20312e322052544520686173206e6f74206265656e20656e61626c6564206279207468652041646d696e6973747261746f722e, '2005-05-10 11:06:09', ''),
('en', '_msgs', 'AT_ERROR_SEARCH_TERM_REQUIRED', 0x596f75206d7573742073706563696679206174206c65617374206f6e6520736561726368207465726d2e, '2003-08-22 12:03:29', 'search form'),
('en', '_msgs', 'AT_ERROR_SECRET_ERROR', 0x4c657474657273206f72206e756d6265727320656e74657265642066726f6d20746865204341505443484120696d6167652061726520696e636f72726563742e2054727920616761696e2e, '2009-07-16 09:01:08', ''),
('en', '_msgs', 'AT_ERROR_SELECT_MEETING', 0x4e6f206d656574696e67207761732073656c65637465642e, '2013-08-01 10:18:14', ''),
('en', '_msgs', 'AT_ERROR_SELECT_ONE_ITEM', 0x4f6e6c79203c656d3e6f6e653c2f656d3e206974656d206d7573742062652073656c65637465642e, '2007-02-21 14:07:53', ''),
('en', '_msgs', 'AT_ERROR_SENDING_ERROR', 0x54686572652077617320616e206572726f722073656e64696e672074686520656d61696c206d6573736167652e, '2005-01-18 13:34:23', 'mail failed to be sent'),
('en', '_msgs', 'AT_ERROR_SEND_ENROL', 0x596f752063616e206f6e6c792073656e642061206d65737361676520746f206f74686572206d656d6265727320616674657220796f7520656e726f6c6c20696e206120636f757273652e, '2003-05-16 13:42:17', 'error msg'),
('en', '_msgs', 'AT_ERROR_SEND_MEMBERS', 0x596f752063616e206f6e6c792073656e642061206d65737361676520746f206f74686572732077686f2061726520656e726f6c6c656420696e207468652073616d6520636f757273657320617320796f75206f7220796f757220636f6e74616374732e, '2009-06-12 11:37:40', 'error msg'),
('en', '_msgs', 'AT_ERROR_SESSION_COOKIES', 0x53657373696f6e20636f6f6b696573206d75737420626520656e61626c656420696e20796f75722062726f7773657220746f206c6f67696e2e, '2005-07-22 13:04:11', ''),
('en', '_msgs', 'AT_ERROR_SOCIAL_SETTINGS_NOT_SAVED', 0x536f6369616c206e6574776f726b696e672073657474696e67732077657265206e6f742073617665642e, '2009-05-27 12:01:11', ''),
('en', '_msgs', 'AT_ERROR_START_DATE_INVALID', 0x546861742073746172742064617465206973206e6f742076616c69642e, '2003-05-16 13:42:17', 'error msg'),
('en', '_msgs', 'AT_ERROR_STUD_INFO_NOT_FOUND', 0x53747564656e7420696e666f726d6174696f6e2063616e6e6f7420626520666f756e642e, '2003-05-16 13:42:17', 'error msg'),
('en', '_msgs', 'AT_ERROR_TERM_EXISTS', 0x546865207465726d203c7374726f6e673e25733c2f7374726f6e673e20616c7265616479206578697374732e, '2004-07-22 16:55:03', ''),
('en', '_msgs', 'AT_ERROR_THEME_NOT_DELETED', 0x546865207468656d6520636f756c64206e6f742062652064656c65746564206265636175736520697420697320656974686572207468652063757272656e742064656661756c74207468656d65206f7220746865206f726967696e616c2064656661756c74207468656d652e, '2005-05-10 09:27:02', 'theme manager deleting theme'),
('en', '_msgs', 'AT_ERROR_THEME_NOT_DISABLED', 0x5468656d652063616e6e6f742062652064697361626c656420626563617573652069742069732063757272656e746c79207468652064656661756c74207468656d652e, '2005-05-09 14:27:23', ''),
('en', '_msgs', 'AT_ERROR_THEME_PREVIEW_DISABLED', 0x5468656d65206d75737420626520656e61626c6564206265666f72652070726576696577696e67, '2013-12-28 10:06:02', ''),
('en', '_msgs', 'AT_ERROR_TILE_AUTHENTICATION_FAIL', 0x5468652041436f6e74656e742061757468656e7469636174696f6e206661696c732061743a3c6272202f3e25732e, '2010-06-25 12:46:10', 'tile search'),
('en', '_msgs', 'AT_ERROR_TILE_IMPORT_FAIL', 0x41436f6e74656e74206c6573736f6e20696d706f7274206661696c65642061743a3c6272202f3e2573, '2010-06-25 12:46:28', 'tile search'),
('en', '_msgs', 'AT_ERROR_TIME_REQUIRED_BBB', 0x416c6c206669656c6473206172652072657175697265642e, '2013-08-01 10:18:14', '');
INSERT INTO `AT_language_text` (`language_code`, `variable`, `term`, `text`, `revised_date`, `context`) VALUES
('en', '_msgs', 'AT_ERROR_TOO_BIG_TO_UPLOAD', 0x5468652066696c652073697a652025317320697320746f6f2062696720746f2062652075706c6f616465642e, '2012-07-25 11:42:21', ''),
('en', '_msgs', 'AT_ERROR_TRANSCRIPT_ACTIVE', 0x596f75206d6179206e6f742064656c65746520616e20616374697665207472616e7363726970742e, '2005-05-16 12:46:32', ''),
('en', '_msgs', 'AT_ERROR_TRANSFORMABLE_URI_INVALID', 0x5468652041436f6e74656e742055524c206170706561727320746f20626520696e76616c69642e2049742073686f756c6420706f696e7420746f207468652062617365206469726563746f7279206f6620796f75722041436f6e74656e7420696e7374616c6c6174696f6e2c206c696b653a0d0a0d0a687474703a2f2f7777772e6d79736974652e636f6d2f41436f6e74656e742f, '2010-09-20 11:58:40', ''),
('en', '_msgs', 'AT_ERROR_UNABLE_TO_CONNECT_TO_BBB', 0x556e61626c6520746f206a6f696e20746865206d656574696e672e20506c6561736520636865636b207468652075726c206f662074686520626967626c7565627574746f6e2073657276657220414e4420636865636b20746f207365652069662074686520626967626c7565627574746f6e207365727665722069732072756e6e696e672e, '2013-08-01 10:18:14', ''),
('en', '_msgs', 'AT_ERROR_UNABLE_TO_FIND_TOOL', 0x556e61626c6520746f2066696e6420746f6f6c2e, '2013-09-07 09:58:35', 'admin delete LTI tool'),
('en', '_msgs', 'AT_ERROR_UNKNOWN', 0x416e20756e64657465726d696e6564206572726f7220686173206f636375727265642e, '2003-05-16 14:24:59', 'error msg'),
('en', '_msgs', 'AT_ERROR_USER_NOT_FOUND', 0x55736572206e6f7420666f756e642e, '2005-03-09 15:56:27', ''),
('en', '_msgs', 'AT_ERROR_WRONG_PASSWORD', 0x496e636f72726563742070617373776f72642e, '2006-05-11 11:34:11', ''),
('en', '_msgs', 'AT_FEEDBACK_ACCEPT_GROUP_INVITATION', 0x496e7669746174696f6e20746f206a6f696e2067726f7570207761732061636365707465642e, '2009-05-27 12:01:11', ''),
('en', '_msgs', 'AT_FEEDBACK_ACCEPT_GROUP_REQUEST', 0x5265717565737420746f206a6f696e2067726f7570207761732061636365707465642e, '2009-05-27 12:01:11', ''),
('en', '_msgs', 'AT_FEEDBACK_ACCOUNT_APPROVED', 0x596f752068617665207375636365737366756c6c7920757067726164656420746f20616e20696e7374727563746f72206163636f756e742e, '2004-11-05 10:25:41', 'feedback msg'),
('en', '_msgs', 'AT_FEEDBACK_ACCOUNT_CONFIRMED', 0x4163636f756e7420686173206265656e20636f6e6669726d65642e, '2005-03-30 11:56:59', ''),
('en', '_msgs', 'AT_FEEDBACK_ACTION_COMPLETED_SUCCESSFULLY', 0x416374696f6e20636f6d706c65746564207375636365737366756c6c792e, '2006-09-28 11:26:07', ''),
('en', '_msgs', 'AT_FEEDBACK_ACTION_PENDING_CC_CONFIRM', 0x596f757220656e726f6c6c6d656e7420697320636f6e646974696f6e616c206f6e20796f7572206372656469742063617264207061796d656e74206265696e6720617070726f766564, '2013-08-01 10:18:14', ''),
('en', '_msgs', 'AT_FEEDBACK_ADD_TEST_INTO_GRADEBOOK', 0x223c7374726f6e673e253124733c2f7374726f6e673e222063616e6e6f7420626520616464656420696e746f206772616465626f6f6b20626563617573652074686520666f6c6c6f77696e672073747564656e747320686176652074616b656e206974206d6f7265207468616e206f6e63653a3c6272202f3e0d0a253224732e, '2008-09-25 16:01:17', 'gradebook'),
('en', '_msgs', 'AT_FEEDBACK_ADMIN_CREATED', 0x41646d696e6973747261746f72206163636f756e742063726561746564207375636365737366756c6c792e, '2005-03-03 16:12:49', ''),
('en', '_msgs', 'AT_FEEDBACK_ADMIN_DELETED', 0x41646d696e6973747261746f72206163636f756e742064656c65746564207375636365737366756c6c792e, '2005-03-03 10:49:25', ''),
('en', '_msgs', 'AT_FEEDBACK_ADMIN_LOG_RESET', 0x41646d696e6973747261746f72204163746976697479204c6f6720686173206265656e207265736574207375636365737366756c6c792e, '2005-03-03 10:43:36', ''),
('en', '_msgs', 'AT_FEEDBACK_ADMIN_NO_COURSES', 0x546865726520617265206e6f20636f75727365206f6e20746869732073797374656d2e20546f20637265617465206120636f757273652c20636c69636b206f6e20746865203c7374726f6e673e436f75727365733c2f7374726f6e673e207461622061626f76652c207468656e20696e2074686520436f757273657320737562206d656e7520636c69636b203c7374726f6e673e43726561746520436f757273653c2f7374726f6e673e2e, '2013-01-30 14:19:25', ''),
('en', '_msgs', 'AT_FEEDBACK_ALREADY_ENROLLED', 0x54686520666f6c6c6f77696e672073747564656e74732061726520616c726561647920656e726f6c6c65643a203c756c3e202573203c2f756c3e, '2005-06-23 12:50:58', 'enrollment manager, students added were alread enrolled'),
('en', '_msgs', 'AT_FEEDBACK_ALREADY_REQUESTED', 0x596f75206861766520616c7265616479206d6164652061207265717565737420746f20656e726f6c6c20696e207468697320636f7572736520616e6420796f752068617665206e6f7420796574206265656e20617070726f7665642062792074686520696e7374727563746f722e20596f752077696c6c206265206e6f7469666564207768656e20796f7572207265717565737420686173206265656e20617070726f7665642e, '2005-03-17 12:55:24', 'private enroll, already requested approval once'),
('en', '_msgs', 'AT_FEEDBACK_ALTERNATIVE_ADDED', 0x416c7465726e6174652061646465642e204265207375726520746f20646566696e6520746865207265736f75726365207479706520666f722074686520616c7465726e61746976652e, '2008-09-08 14:43:50', ''),
('en', '_msgs', 'AT_FEEDBACK_ALTERNATIVE_DELETED', 0x416c7465726e617469766520776173207375636365737366756c6c792072656d6f7665642e, '2008-09-08 14:56:39', ''),
('en', '_msgs', 'AT_FEEDBACK_APPROVAL_PENDING', 0x596f7572207265717565737420686173206265656e206d6164652e20596f752077696c6c206265206e6f746966696564207768656e20796f7572207265717565737420686173206265656e20617070726f7665642e, '2009-09-17 14:47:54', 'feedback msg'),
('en', '_msgs', 'AT_FEEDBACK_ARCHIVE_EXTRACTED', 0x4172636869766520686173206265656e20657874726163746564207375636365737366756c6c792e, '2003-05-16 13:47:01', 'feedback msg'),
('en', '_msgs', 'AT_FEEDBACK_ASSIGNMENT_ADDED', 0x41737369676e6d656e7420776173207375636365737366756c6c792061646465642e, '2006-04-20 14:42:13', ''),
('en', '_msgs', 'AT_FEEDBACK_ASSIGNMENT_HANDED_IN', 0x41737369676e6d656e742066696c6573207375626d6974746564207375636365737366756c6c792e, '2006-03-20 14:35:53', ''),
('en', '_msgs', 'AT_FEEDBACK_ATUTOR_SOCIAL_LMS', 0x415475746f72206973206e6f7720636f6e666967757265642061732061206c6561726e696e67206d616e6167656d656e742073797374656d20284c4d5329207769746820736f6369616c206e6574776f726b696e672061732061206d6f64756c652e, '2009-07-17 14:20:59', ''),
('en', '_msgs', 'AT_FEEDBACK_ATUTOR_SOCIAL_ONLY', 0x415475746f72206973206e6f7720636f6e66696775726564206173206120736f6369616c206e6574776f726b696e6720656e7669726f6e6d656e742e204c6561726e696e67206d616e6167656d656e7420746f6f6c7320617265207475726e6564206f66662e, '2009-07-17 14:22:01', ''),
('en', '_msgs', 'AT_FEEDBACK_ATUTOR_UPDATE_AVAILABLE', 0x416e20757064617465642076657273696f6e206f6620415475746f7220697320617661696c61626c6521205669657720746865203c6120687265663d22687474703a2f2f617475746f722e63612f617475746f722f6368616e67655f6c6f672e706870223e4368616e6765204c6f673c2f613e20666f722064657461696c732e, '2005-11-21 12:36:30', ''),
('en', '_msgs', 'AT_FEEDBACK_AUTO_DISABLED', 0x4175746f2d4c6f67696e20686173206265656e2064697361626c6564, '2003-05-16 13:47:01', 'feedback msg'),
('en', '_msgs', 'AT_FEEDBACK_AUTO_ENABLED', 0x4175746f2d4c6f67696e20686173206265656e20656e61626c65642e204e6578742074696d6520796f7520656e74657220415475746f72207573696e67207468697320636f6d70757465722c20796f752077696c6c2062797061737320746865206c6f67696e2073637265656e2e20, '2003-05-16 13:47:01', 'feedback msg'),
('en', '_msgs', 'AT_FEEDBACK_BASICLTI_DELETED', 0x45787465726e616c20746f6f6c2072656d6f7665642061732061204c6561726e696e672041637469766974792066726f6d207468697320636f6e74656e7420706167652e, '2011-05-27 16:09:15', ''),
('en', '_msgs', 'AT_FEEDBACK_BASICLTI_SAVED', 0x45787465726e616c20746f6f6c2061646465642061732061204c6561726e696e6720416374697669747920666f72207468697320636f6e74656e7420706167652e, '2011-05-27 16:08:58', ''),
('en', '_msgs', 'AT_FEEDBACK_BLOG_SUBSCRIBED', 0x5375627363726962656420746f20626c6f6720666565642e, '2009-06-24 11:57:05', ''),
('en', '_msgs', 'AT_FEEDBACK_BLOG_UNSUBSCRIBED', 0x556e7375627363726962656420746f20626c6f6720666565642e, '2009-06-24 11:57:20', ''),
('en', '_msgs', 'AT_FEEDBACK_CANCELLED', 0x5375636365737366756c6c792063616e63656c6c656420776974686f757420616e79206368616e6765732e, '2003-12-10 10:40:21', ''),
('en', '_msgs', 'AT_FEEDBACK_CLOSED', 0x5375636365737366756c6c7920636c6f736564, '2004-05-03 11:26:52', ''),
('en', '_msgs', 'AT_FEEDBACK_CONFIG_SAVED', 0x53797374656d20707265666572656e6365732068617665206265656e207361766564207375636365737366756c6c792e2041206261636b7570206f6620746865206f6c6420636f6e66696775726174696f6e2066696c6520776173206372656174656420616e6420736176656420617320257320286974277320696e20796f757220636f6e74656e74206469726563746f7279292e, '2005-03-29 15:22:14', ''),
('en', '_msgs', 'AT_FEEDBACK_CONFIRMATION_SENT', 0x416e20656d61696c20636f6e6669726d6174696f6e206d65737361676520686173206265656e2073656e742e, '2005-03-22 12:07:10', ''),
('en', '_msgs', 'AT_FEEDBACK_CONFIRM_EMAIL', 0x416e20656d61696c206d65737361676520686173206265656e2073656e7420746f20746865206e657720656d61696c206164647265737320796f75207370656369666965642e20596f75206d75737420666f6c6c6f772074686520696e737472756374696f6e7320696e207468617420656d61696c20666f7220746865206368616e67657320746f2074616b65206566666563742e, '2006-05-11 15:55:32', ''),
('en', '_msgs', 'AT_FEEDBACK_CONFIRM_EMAIL2', 0x416e20656d61696c207769746820696e737472756374696f6e73206f6e2072657472696576696e6720796f75722070617373776f726420686173206265656e2073656e742e, '2006-05-10 10:23:41', ''),
('en', '_msgs', 'AT_FEEDBACK_CONFIRM_GOOD', 0x596f757220656d61696c206164647265737320686173206265656e20636f6e6669726d6564207375636365737366756c6c792e, '2005-04-11 10:29:29', ''),
('en', '_msgs', 'AT_FEEDBACK_CONTACTS_UNCHANGED', 0x596f757220636f6e74616374732077657265203c7374726f6e673e756e6368616e6765642e3c2f7374726f6e673e, '2013-10-16 19:21:55', ''),
('en', '_msgs', 'AT_FEEDBACK_CONTACTS_UPDATED', 0x596f757220636f6e74616374732077657265207375636365737366756c6c7920757064617465642e, '2013-10-16 19:20:05', ''),
('en', '_msgs', 'AT_FEEDBACK_CONTENT_DELETED', 0x436f6e74656e7420776173207375636365737366756c6c792064656c65746564, '2003-05-16 13:47:01', 'feedback msg'),
('en', '_msgs', 'AT_FEEDBACK_CONTENT_DIR_CREATED', 0x436f6e74656e74206469726563746f72792063726561746564207375636365737366756c6c792e, '2003-10-15 12:20:11', ''),
('en', '_msgs', 'AT_FEEDBACK_COURSES_REMAINING', 0x54686572652061726520257320636f757273652073706163652873292072656d61696e696e672e, '2013-08-01 10:18:14', ''),
('en', '_msgs', 'AT_FEEDBACK_COURSE_DEFAULT_FSIZE', 0x54686520274d61782046696c652053697a6527207761732073657420746f202744656661756c74272061732074686520656e74657265642066696c652073697a65207761732065697468657220656d707479206f72206e656761746976652e, '2003-10-14 16:13:40', 'course properites: file size was set to default'),
('en', '_msgs', 'AT_FEEDBACK_COURSE_EMAIL_RECIPIENT_LIST', 0x436f7572736520656d61696c732077657265207375636365737366756c6c792073656e7420746f3a203c756c3e202573203c2f756c3e, '2013-12-06 18:37:08', ''),
('en', '_msgs', 'AT_FEEDBACK_COURSE_PREFS_SAVED', 0x436f7572736520707265666572656e6365732077657265207361766564, '2003-05-16 13:47:01', 'feedback msg'),
('en', '_msgs', 'AT_FEEDBACK_COURSE_PROPERTIES', 0x436f757273652070726f706572746965732077657265207375636365737366756c6c7920757064617465642e, '2003-05-16 13:47:01', 'feedback msg'),
('en', '_msgs', 'AT_FEEDBACK_COURSE_REMOVED', 0x436f75727365207761732072656d6f766564207375636365737366756c6c792e, '2003-05-16 13:47:01', 'feedback msg'),
('en', '_msgs', 'AT_FEEDBACK_CREATE_NEW_COURSE', 0x546f206372656174652061206e657720636f757273652c20656e746572206174206c65617374206120636f75727365207469746c6520696e2074686520666f726d2062656c6f772e20466f72206164646974696f6e616c2064657461696c7320736565207468652043726561746520436f757273652068616e64626f6f6b2070616765206c696e6b65642061626f76652e, '2012-08-20 10:33:46', 'bounce'),
('en', '_msgs', 'AT_FEEDBACK_DIRS_MOVED', 0x4469726563746f72696573207375636365737366756c6c79206d6f7665642e, '2004-11-10 14:12:11', 'file manager'),
('en', '_msgs', 'AT_FEEDBACK_DIR_DELETED', 0x466f6c64657220776173207375636365737366756c6c792064656c657465642e, '2003-05-16 13:47:01', 'feedback msg'),
('en', '_msgs', 'AT_FEEDBACK_EC_ADD_SAVED', 0x5061796d656e742073657474696e67732077657265207375636365737366756c6c792073617665642e20, '2013-08-01 10:18:14', ''),
('en', '_msgs', 'AT_FEEDBACK_EC_COURSE_PAYMENT_SETTINGS_NOT_SAVED', 0x556e61626c6520746f207361766520636f75727365207061796d656e742073657474696e67732e20436f6e7461637420796f75722073797374656d2061646d696e6973747261746f7220746f207265706f7274207468652070726f626c656d, '2013-08-01 10:18:14', ''),
('en', '_msgs', 'AT_FEEDBACK_EC_COURSE_PAYMENT_SETTINGS_SAVED', 0x436f75727365207061796d656e742073657474696e67732068617665206265656e2073617665642e, '2013-08-01 10:18:14', ''),
('en', '_msgs', 'AT_FEEDBACK_EC_PAYMENTS_CONFIG_NEEDED', 0x596f752077696c6c206e65656420746f20636f6e66696775726520746865205061796d656e7473206d6f64756c65206265666f7265207573696e672069742e205365652074686520524541444d452066696c65206c696e6b206e65787420746f20746865205061796d656e7473206d6f64756c6520696e20746865203c6120687265663d222e2e2f6d6f64732f5f636f72652f6d6f64756c65732f696e6465782e706870223e4d6f64756c65204d616e616765723c2f613e2e20, '2013-08-01 10:18:14', ''),
('en', '_msgs', 'AT_FEEDBACK_EC_PAYMENT_CONFIRMED_AUTO', 0x596f7572207061796d656e7420686173206265656e2072656365697665642c20616e6420796f757220636f7572736520656e726f6c6c6d656e7420686173206265656e20617070726f7665642e20596f75206d6179206e6f77203c6120687265663d226c6f67696e2e7068703f636f757273653d257322207374796c653d22636f6c6f723a7265643b223e6c6f67696e20746f2074686520636f757273653c2f613e2e20, '2013-08-01 10:18:14', ''),
('en', '_msgs', 'AT_FEEDBACK_EC_PAYMENT_CONFIRMED_MANUAL', 0x596f7572207061796d656e7420686173206265656e2072656365697665642e20596f752077696c6c20726563656976652061206e6f7469636520627920656d61696c207768656e20796f757220656e726f6c6c6d656e7420696e2074686520636f7572736520686173206265656e206d616e75616c6c7920617070726f7665642e20, '2013-08-01 10:18:14', ''),
('en', '_msgs', 'AT_FEEDBACK_ENROLLED', 0x54686520666f6c6c6f77696e6720756e69717565206163636f756e74732077657265207375636365737366756c6c7920616464656420746f2074686520636f75727365206c6973743a203c756c3e202573203c2f756c3e, '2005-06-23 12:51:35', 'enrollment manager, confirm enrollmnet'),
('en', '_msgs', 'AT_FEEDBACK_ERROR_LOG_RESET', 0x546865206572726f72206c6f6720776173207265736574207375636365737366756c6c792e, '2005-03-10 15:53:27', 'error logging'),
('en', '_msgs', 'AT_FEEDBACK_EXPORT_CANCELLED', 0x4578706f72742063616e63656c6c6564207375636365737366756c6c792e, '2003-05-16 13:47:01', 'feedback msg'),
('en', '_msgs', 'AT_FEEDBACK_FILES_MOVED', 0x46696c6573206d6f766564207375636365737366756c6c792e, '2006-03-20 16:10:58', ''),
('en', '_msgs', 'AT_FEEDBACK_FILEUPLOAD_DONE', 0x46696c652873292075706c6f616465642e, '2008-07-22 16:45:58', 'Files uploaded'),
('en', '_msgs', 'AT_FEEDBACK_FILE_EDITED', 0x46696c65207375636365737366756c6c79206564697465642e, '2006-08-29 11:07:02', ''),
('en', '_msgs', 'AT_FEEDBACK_FILE_EDITED_SUCCESSFULLY', 0x46696c6520656469746564207375636365737366756c6c792e, '2006-03-20 15:05:28', ''),
('en', '_msgs', 'AT_FEEDBACK_FILE_EXISTS', 0x5468652066696c65203c7374726f6e673e253124733c2f7374726f6e673e20616c7265616479206578697374732e20546865206e65776c792075706c6f616465642066696c6520776173207361766564206173203c7374726f6e673e253224733c2f7374726f6e673e2e203c6120687265663d226d6f64732f5f636f72652f66696c655f6d616e616765722f696e6465782e7068703f6f76657277726974653d2532247325352473706174686578743d2533247325352473706f7075703d25342473223e4f76657277726974653c2f613e20746865206f6c64206578697374696e672066696c65207769746820746865206e65776572206f6e652e, '2010-03-09 14:27:41', 'feedback msg'),
('en', '_msgs', 'AT_FEEDBACK_FILE_OVERWRITE', 0x46696c65206f7665727772697465207375636365737366756c2e, '2003-05-16 13:47:01', 'feedback msg'),
('en', '_msgs', 'AT_FEEDBACK_FILE_PASTED', 0x5468652066696c6520776173207375636365737366756c6c792070617374656420696e746f207468652074657874617265612062656c6f772e203c7374726f6e673e3c656d3e5361766520746f206170706c79206368616e6765733c2f656d3e3c2f7374726f6e673e2c206f722043616e63656c20746f2072657475726e20746f207468652070726576696f75736c7920736176656420636f6e74656e742e, '2003-05-16 13:47:01', 'feedback msg'),
('en', '_msgs', 'AT_FEEDBACK_FILE_SAVED', 0x5468652066696c6520776173207375636365737366756c6c79207361766564206173203c7374726f6e673e25733c2f7374726f6e673e, '2005-01-10 09:35:48', 'file manager'),
('en', '_msgs', 'AT_FEEDBACK_FILE_UPLOADED', 0x46696c6520776173207375636365737366756c6c792075706c6f616465642e, '2003-05-16 13:47:01', 'feedback msg'),
('en', '_msgs', 'AT_FEEDBACK_FILE_UPLOADED_ZIP', 0x46696c6520776173207375636365737366756c6c792075706c6f616465642e20596f75206d6179206e6f77203c6120687265663d226d6f64732f5f636f72652f66696c655f6d616e616765722f7a69702e7068703f706174686578743d253124732534247366696c653d2532247325342473706f7075703d25332473223e657874726163743c2f613e207468652066696c652e, '2010-03-09 14:28:13', 'feedback msg'),
('en', '_msgs', 'AT_FEEDBACK_FOLDER_EDITED_SUCCESSFULLY', 0x466f6c64657220656469746564207375636365737366756c6c792e, '2006-03-20 15:42:30', ''),
('en', '_msgs', 'AT_FEEDBACK_FORUM_POSTING', 0x546f20706f7374206d6573736167657320746f20746865206e657720666f72756d2c206c6f6720696e746f20415475746f7220617320726567756c6172207573657273206f7220696e7374727563746f722e, '2004-11-21 10:08:55', ''),
('en', '_msgs', 'AT_FEEDBACK_FORUM_SUBSCRIBED', 0x596f752068617665207375636365737366756c6c79207375627363726962656420746f20746865203c7374726f6e673e25733c2f7374726f6e673e20666f72756d2e204d6573736167657320706f7374656420746f207468697320666f72756d2077696c6c2062652064656c69766572656420746f20796f7572207265676973746572656420656d61696c20616464726573732e205669657720796f75722070726f66696c6520746f206d6f6469667920796f757220656d61696c20616464726573732e, '2004-12-02 15:04:51', ''),
('en', '_msgs', 'AT_FEEDBACK_FORUM_UNSUBSCRIBED', 0x596f752068617665207375636365737366756c6c7920756e737562736372696265642066726f6d20746865203c7374726f6e673e25733c2f7374726f6e673e20666f72756d2e204d6573736167657320706f7374656420746f207468697320666f72756d2077696c6c206e6f206c6f6e6765722062652064656c69766572656420746f20796f757220656d61696c20616464726573732e, '2004-12-03 17:25:43', ''),
('en', '_msgs', 'AT_FEEDBACK_GADGET_ADDED_SUCCESSFULLY', 0x4761646765742077617320737563636573737366756c6c792061646465642e, '2009-05-27 12:01:11', ''),
('en', '_msgs', 'AT_FEEDBACK_GADGET_REMOVED_SUCCESSFULLY', 0x4761646765742077617320737563636573737366756c6c792072656d6f7665642e, '2009-05-27 12:01:11', ''),
('en', '_msgs', 'AT_FEEDBACK_GADGET_SETTINGS_SAVED', 0x4761646765742073657474696e67732068617665206265656e2073617665642e, '2009-05-28 17:21:14', ''),
('en', '_msgs', 'AT_FEEDBACK_GOOGLE_KEY_SAVED', 0x476f6f676c65206b6579207361766564207375636365737366756c6c792e, '2005-10-20 11:07:29', ''),
('en', '_msgs', 'AT_FEEDBACK_GRADEBOOK_UPDATED', 0x54686520666f6c6c6f77696e67206772616465732068617665206265656e207375636365737366756c6c79207570646174656420696e746f206772616465626f6f6b3a203c756c3e202573203c2f756c3e, '2008-09-25 16:01:17', 'gradebook'),
('en', '_msgs', 'AT_FEEDBACK_GROUP_CREATED', 0x47726f757020776173207375636365737366756c6c7920637265617465642e, '2009-05-27 12:01:11', ''),
('en', '_msgs', 'AT_FEEDBACK_GROUP_DELETED', 0x47726f75702064656c657465642e, '2004-11-25 15:48:40', ''),
('en', '_msgs', 'AT_FEEDBACK_GROUP_EDITED_SUCCESSFULLY', 0x47726f757020656469746564207375636365737366756c6c792e, '2006-03-23 11:09:18', ''),
('en', '_msgs', 'AT_FEEDBACK_GROUP_JOINED', 0x47726f7570207375636365737366756c6c79206a6f696e65642e, '2009-05-27 12:01:11', ''),
('en', '_msgs', 'AT_FEEDBACK_GROUP_MEMBERS_SAVED', 0x47726f7570206d656d62657273207361766564207375636365737366756c6c792e, '2006-04-17 11:43:39', ''),
('en', '_msgs', 'AT_FEEDBACK_GROUP_MEMBER_REMOVED', 0x47726f7570206d656d626572207375636365737366756c6c792072656d6f7665642e, '2013-10-19 19:11:25', 'social'),
('en', '_msgs', 'AT_FEEDBACK_GROUP_TYPE_DELETED', 0x47726f75702077617320737563636573737366756c6c792064656c657465642e, '2006-05-23 15:33:56', ''),
('en', '_msgs', 'AT_FEEDBACK_GROUP_TYPE_EDITED_SUCCESSFULLY', 0x47726f7570207479706520656469746564207375636365737366756c6c792e, '2006-03-23 11:18:02', ''),
('en', '_msgs', 'AT_FEEDBACK_GROUP_UPDATED', 0x47726f75702075706461746564207375636365737366756c6c792e, '2004-11-25 15:49:09', ''),
('en', '_msgs', 'AT_FEEDBACK_IMPORT_CANCELLED', 0x496d706f72742063616e63656c6c6564207375636365737366756c6c792e, '2003-05-16 13:47:01', 'feedback msg'),
('en', '_msgs', 'AT_FEEDBACK_IMPORT_LANG_SUCCESS', 0x4e6577206c616e677561676520776173207375636365737366756c6c7920696d706f727465642e20596f75206d617920656e61626c6520746865206c616e6775616765207573696e6720746865205472616e736c6174652073656c656374696f6e206d656e752062656c6f772e, '2010-10-07 08:52:40', 'admin language manager'),
('en', '_msgs', 'AT_FEEDBACK_IMPORT_SUCCEEDED', 0x496d706f727420776173207375636365737366756c2e, '2008-10-02 13:48:16', ''),
('en', '_msgs', 'AT_FEEDBACK_INVITATION_SENT', 0x496e7669746174696f6e207375636365737366756c6c792073656e742e20506572736f6e2077696c6c206265206164646564207768656e2074686520696e7669746174696f6e20686173206265656e2061636365707465642e, '2009-05-27 12:01:11', ''),
('en', '_msgs', 'AT_FEEDBACK_JOIN_REQUEST_SENT', 0x5265717565737420746f206a6f696e2067726f757020686173206265656e2073656e742e20596f752077696c6c20626520616464656420746f207468652067726f7570207768656e20796f7572207265717565737420686173206265656e20617070726f7665642e, '2009-05-27 12:01:11', ''),
('en', '_msgs', 'AT_FEEDBACK_LANG_ADDED', 0x4e6577206c616e677561676520776173207375636365737366756c6c7920637265617465642e2055736520746865206c616e67756167652073656c6563746f7220746f2063686f6f736520746865206e6577206c616e67756167652c207468656e20626567696e6e696e6720616464696e67207472616e736c61746564207465726d732e205472616e736c6174696f6e20746f6f6c732061726520656e61626c656420696e20696e636c7564652f766974616c732e696e632e706870, '2004-11-20 20:14:55', ''),
('en', '_msgs', 'AT_FEEDBACK_LANG_DELETED', 0x4c616e677561676520776173207375636365737366756c6c792072656d6f7665642e, '2003-06-05 19:38:01', 'admin language manager'),
('en', '_msgs', 'AT_FEEDBACK_LANG_UPDATED', 0x4c616e6775616765207375636365737366756c6c7920757064617465642e, '2005-04-26 16:04:36', ''),
('en', '_msgs', 'AT_FEEDBACK_LEFT_GROUP_SUCCESSFULLY', 0x5375636365737366756c6c792072656d6f7665642066726f6d2067726f75702e, '2009-05-27 12:01:11', ''),
('en', '_msgs', 'AT_FEEDBACK_LINK_ADDED', 0x4c696e6b206164646564207375636365737366756c6c792e20204c696e6b2077696c6c206265636f6d652076697369626c6520696620617070726f7665642e, '2005-02-23 12:07:59', ''),
('en', '_msgs', 'AT_FEEDBACK_LOGIN_SUCCESS', 0x596f752068617665206c6f6767656420696e207375636365737366756c6c792e, '2012-08-20 10:38:28', ''),
('en', '_msgs', 'AT_FEEDBACK_LOGIN_SUCCESS_AUTO_ENROLL', 0x596f752068617665207375636365737366756c6c79206c6f6767656420696e20616e642068617665206265656e207375636365737366756c6c7920656e726f6c6c656420696e2074686520666f6c6c6f77696e6720636f75727365733a203c756c3e202573203c2f756c3e, '2013-12-18 18:08:32', ''),
('en', '_msgs', 'AT_FEEDBACK_LOGOUT', 0x596f752068617665207375636365737366756c6c79206265656e206c6f67676564206f75742e, '2003-10-29 10:00:12', 'after logging out'),
('en', '_msgs', 'AT_FEEDBACK_MASTER_LIST_NO_CHANGES', 0x4e6f206368616e676573207765726520646f6e6520746f20746865204d61737465722053747564656e74204c6973742e, '2005-06-16 12:32:19', 'When action to master list yields no changes'),
('en', '_msgs', 'AT_FEEDBACK_MASTER_LIST_UPLOADED', 0x4d61737465722053747564656e74204c69737420686173206265656e2075706461746564207375636365737366756c6c792e, '2005-04-04 16:12:52', ''),
('en', '_msgs', 'AT_FEEDBACK_MEETING_ENDED', 0x4d656574696e6720686173206265656e20656e6465642e20546f2072652d656e61626c652063686f6f73652074686520726164696f20627574746f6e20666f7220746865206d656574696e6720616e6420707265737320656469742c207468656e20696e2074686520537461747573206d656e752063686f6f73652050656e64696e672e20, '2013-08-01 10:18:14', ''),
('en', '_msgs', 'AT_FEEDBACK_MEETING_ENDED_OTHER', 0x596f752068617665207375636365737366756c6c792065786974656420746865206d656574696e672c2074686f75676820697420636f6e74696e75657320746f2072756e2e20546865206d656574696e672077696c6c20626520656e646564207768656e20746865206d6f64657261746f72206c6f6773206f75742e, '2013-08-01 10:18:14', ''),
('en', '_msgs', 'AT_FEEDBACK_MEMBERS_ALUMNI', 0x53747564656e7420686173206265656e2061737369676e656420616c756d6e69207374617475732e, '2004-12-02 11:42:06', ''),
('en', '_msgs', 'AT_FEEDBACK_MEMBERS_ENROLLED', 0x5468652073656c65637465642073747564656e74732077657265207375636365737366756c6c7920656e726f6c6c656420696e2074686520636f757273652e, '2004-12-02 11:42:37', 'enrollment manager, confirm enrollment'),
('en', '_msgs', 'AT_FEEDBACK_MEMBERS_REMOVED', 0x5468652073656c65637465642075736572732077657265207375636365737366756c6c792072656d6f7665642066726f6d2074686520636f75727365, '2004-10-18 10:58:17', 'enrollment manager, confirm removal'),
('en', '_msgs', 'AT_FEEDBACK_MEMBERS_UNENROLLED', 0x5468652073656c65637465642075736572732077657265207375636365737366756c6c7920756e2d656e726f6c6c65642066726f6d2074686520636f75727365, '2004-10-18 10:59:09', 'enrollemnt manager, confrm unenrollment'),
('en', '_msgs', 'AT_FEEDBACK_MOBILE_OFF', 0x4d6f62696c65207468656d65207475726e6564206f66662e205573696e6720726573706f6e73697665207468656d652e, '2013-12-15 11:00:42', ''),
('en', '_msgs', 'AT_FEEDBACK_MOBILE_ON', 0x4d6f62696c65207468656d65207475726e6564206f6e2e, '2013-12-15 11:01:04', ''),
('en', '_msgs', 'AT_FEEDBACK_MOD_INSTALLED', 0x4d6f64756c65207375636365737366756c6c7920696e7374616c6c65642e2053656c6563742074686520696e7374616c6c6564206d6f64756c652066726f6d20746865206c6973742062656c6f772c20616e64207072657373203c7374726f6e673e456e61626c653c2f7374726f6e673e20746f207475726e206974206f6e2e, '2008-10-24 14:05:27', ''),
('en', '_msgs', 'AT_FEEDBACK_MOVED_FILES', 0x46696c6573207375636365737366756c6c79206d6f7665642e, '2004-11-10 14:11:19', 'file manager'),
('en', '_msgs', 'AT_FEEDBACK_NOADMIN_COURSES_REMAINING', 0x54686572652061726520257320636f757273652073706163652873292072656d61696e696e672e20416464206d6f726520636f75727365732074686f75676820746865205365727669636573207461622061626f76652e, '2013-08-01 10:18:14', ''),
('en', '_msgs', 'AT_FEEDBACK_NOTIFY_OFF', 0x43616c656e646172206e6f74696669636174696f6e73206e6f77207475726e6564206f66662e, '2013-09-17 15:44:39', 'turn off calendar notification'),
('en', '_msgs', 'AT_FEEDBACK_NOTIFY_ON', 0x43616c656e646172206e6f74696669636174696f6e7320617265206e6f77207475726e6564206f6e2e, '2013-09-17 15:43:27', 'calendar enalbe feedback'),
('en', '_msgs', 'AT_FEEDBACK_NOT_ENROLLED', 0x54686520666f6c6c6f77696e672073747564656e74732077657265206e6f7420656e726f6c6c65643a203c756c3e202573203c2f756c3e, '2005-06-23 12:50:31', 'When a student was not enrolled when imported/created.'),
('en', '_msgs', 'AT_FEEDBACK_NOUSER_COURSES_REMAINING', 0x54686572652061726520257320636f757273652073706163652873292072656d61696e696e672e2041736b20796f757220415475746f7253706163657320736974652061646d696e6973747261746f7220746f20616464206d6f726520636f75727365732e20, '2013-08-01 10:18:14', ''),
('en', '_msgs', 'AT_FEEDBACK_NOW_ENROLLED', 0x596f7520617265206e6f7720656e726f6c6c656420696e2074686520257320636f757273652e20596f75206d617920656e7465722074686520636f7572736520617420616e792074696d652e20546f20756e2d656e726f6c6c2c2073656c6563742022556e2d456e726f6c6c22206e65787420746f2074686520636f75727365206c697374696e6720696e204d7920436f75727365732e, '2010-06-02 10:39:43', ''),
('en', '_msgs', 'AT_FEEDBACK_NO_A4A_FOR_PLAIN_TEXT', 0x446566696e696e67206164617074656420636f6e74656e74206973206f6e6c7920617661696c61626c6520666f7220636f6e74656e742074797065202268746d6c222e, '2010-10-18 14:52:08', 'adapted content'),
('en', '_msgs', 'AT_FEEDBACK_NO_MEETINGS', 0x4e6f206d656574696e67732061726520617661696c61626c652e, '2013-08-01 10:18:14', ''),
('en', '_msgs', 'AT_FEEDBACK_NO_RESOURCES', 0x4e6f207265736f757263657320666f756e6420696e207468697320636f6e74656e7420706167652e, '2010-10-18 14:49:41', 'adapted content'),
('en', '_msgs', 'AT_FEEDBACK_OL_DB_UPDATED', 0x44617461626173652075706461746564207375636365737366756c6c79, '2013-08-01 10:18:14', ''),
('en', '_msgs', 'AT_FEEDBACK_PACKAGES_IMPORT_SUCCESS', 0x546865207061636b616765733c6f6c3e202573203c2f6f6c3e7765726520696d706f72746564207375636365737366756c6c792e, '2005-05-17 12:03:34', ''),
('en', '_msgs', 'AT_FEEDBACK_PACKAGE_IMPORT_SUCCESS', 0x546865207061636b616765202671756f743b25732671756f743b2077617320696d706f72746564207375636365737366756c6c792e, '2005-05-17 12:03:10', ''),
('en', '_msgs', 'AT_FEEDBACK_PASSWORD_CHANGED', 0x50617373776f7264206368616e676564207375636365737366756c6c792e20596f75206d6179206e6f77206c6f67696e207573696e6720746865206e65772070617373776f72642e, '2006-05-09 14:22:35', ''),
('en', '_msgs', 'AT_FEEDBACK_PASSWORD_SUCCESS', 0x596f7572206c6f67696e20616e642070617373776f72642068617665206265656e207375636365737366756c6c7920656d61696c65642e, '2005-01-18 14:29:55', ''),
('en', '_msgs', 'AT_FEEDBACK_PATCH_CREATED_SUCCESSFULLY', 0x54686520706174636820686173206265656e2063726561746564207375636365737366756c6c792e, '2008-04-21 15:11:31', 'feedback msg'),
('en', '_msgs', 'AT_FEEDBACK_PATCH_INSTALLED_SUCCESSFULLY', 0x54686520706174636820686173206265656e20696e7374616c6c6564207375636365737366756c6c792e, '2008-04-21 15:08:55', 'feedback msg'),
('en', '_msgs', 'AT_FEEDBACK_PHPMYADMINURL_ADD_SAVED', 0x4c6f636174696f6e206f66207068704d7941646d696e20776173207375636365737366756c6c792073617665642e, '2013-12-09 20:42:09', ''),
('en', '_msgs', 'AT_FEEDBACK_POST_ADDED_SUCCESSFULLY', 0x426c6f67206d65737361676520776173207375636365737366756c6c7920706f737465642e, '2006-05-22 12:35:15', ''),
('en', '_msgs', 'AT_FEEDBACK_PREFS_LOGIN', 0x596f752063616e6e6f74207361766520746865736520707265666572656e636573206265636175736520796f7520617265206e6f74206c6f6767656420696e2e, '2003-05-16 13:47:01', 'feedback msg'),
('en', '_msgs', 'AT_FEEDBACK_PRIVS_CHANGED', 0x50726976696c656765732075706461746564207375636365737366756c6c792e, '2005-08-24 11:21:49', ''),
('en', '_msgs', 'AT_FEEDBACK_PROFILE_CREATED_ADMIN', 0x55736572206163636f756e742063726561746564207375636365737366756c6c792e, '2005-03-29 15:19:07', 'admin create user'),
('en', '_msgs', 'AT_FEEDBACK_PROFILE_UNCHANGED', 0x50726f66696c65207761732073617665642062757420756e6368616e6765642e, '2013-10-14 15:11:01', ''),
('en', '_msgs', 'AT_FEEDBACK_PROFILE_UPDATED', 0x596f75722050726f66696c6520776173207375636365737366756c6c7920757064617465642e, '2003-05-16 13:47:01', 'feedback msg'),
('en', '_msgs', 'AT_FEEDBACK_PROFILE_UPDATED_ADMIN', 0x54686520757365722070726f66696c6520776173207375636365737366756c6c792075706461746564, '2004-12-17 11:47:52', 'change user profile from admin area'),
('en', '_msgs', 'AT_FEEDBACK_QUESTION_DELETED', 0x5175657374696f6e20776173207375636365737366756c6c792064656c657465642e, '2003-05-16 13:47:01', 'feedback msg'),
('en', '_msgs', 'AT_FEEDBACK_QUESTION_REMOVED', 0x5175657374696f6e20776173207375636365737366756c6c792072656d6f7665642066726f6d20746573742f7375727665792e, '2004-11-24 10:03:12', ''),
('en', '_msgs', 'AT_FEEDBACK_QUESTION_UPDATED', 0x5175657374696f6e20776173207375636365737366756c6c7920757064617465642e, '2003-05-16 13:47:01', 'feedback msg'),
('en', '_msgs', 'AT_FEEDBACK_RECORDING_IN_PROGRESS', 0x5265636f7264696e6773206d61792074616b652061207768696c6520746f2070726f63657373206265666f7265206265636f6d696e6720617661696c61626c652c20696620656e61626c656420666f722074686973206d656574696e672e, '2013-08-01 10:18:14', ''),
('en', '_msgs', 'AT_FEEDBACK_REG_THANKS', 0x5468616e6b20796f7520666f72207265676973746572696e672c20706c65617365203c6120687265663d226c6f67696e2e706870223e6c6f67696e3c2f613e2e, '2003-09-25 14:39:50', 'feedback msg'),
('en', '_msgs', 'AT_FEEDBACK_REG_THANKS_CONFIRM', 0x5468616e6b2d796f7520666f72207265676973746572696e672e20506c6561736520666f6c6c6f772074686520696e737472756374696f6e7320696e2074686520656d61696c2077652073656e7420796f75206f6e20686f7720746f20636f6e6669726d20796f7572206163636f756e742e20596f752077696c6c206e65656420746f20636f6e6669726d20796f7572206163636f756e74206265666f726520796f752063616e206c6f67696e2e, '2005-03-22 11:29:22', ''),
('en', '_msgs', 'AT_FEEDBACK_REJECT_GROUP_INVITATION', 0x496e7669746174696f6e20746f206a6f696e2067726f7570207761732072656a65637465642e, '2009-05-27 12:01:11', ''),
('en', '_msgs', 'AT_FEEDBACK_REJECT_GROUP_REQUEST', 0x5265717565737420746f206a6f696e2067726f7570207761732072656a65637465642e, '2009-05-27 12:01:11', ''),
('en', '_msgs', 'AT_FEEDBACK_REQUEST_FRIEND_ADDED', 0x596f7572207265717565737420686173206265656e2073656e742e20596f7572206e657720636f6e746163742077696c6c206265206164646564207768656e2074686520706572736f6e2068617320616363657074656420796f757220726571756573742e, '2009-05-27 12:01:11', ''),
('en', '_msgs', 'AT_FEEDBACK_RESOURCE_PROPERTIES_UPDATED', 0x5265736f757263652070726f706572746965732068617665206265656e207375636365737366756c6c7920757064617465642e, '2008-10-19 14:20:47', ''),
('en', '_msgs', 'AT_FEEDBACK_RESULTS_UPDATED', 0x526573756c7420776173207375636365737366756c6c7920757064617465642e, '2003-05-16 13:47:01', 'feedback msg'),
('en', '_msgs', 'AT_FEEDBACK_RESULT_DELETED', 0x5375636365737366756c6c792064656c657465642073656c656374656420726573756c74732e, '2008-08-20 15:02:07', 'feedback msg'),
('en', '_msgs', 'AT_FEEDBACK_SCORM_SETTINGS_SAVED', 0x53434f524d2073657474696e67732068617665206265656e2073617665642e, '2010-12-08 19:22:28', ''),
('en', '_msgs', 'AT_FEEDBACK_SETTINGS_CHANGED', 0x53657474696e6773206368616e676564207375636365737366756c6c79, '2013-08-01 10:18:14', ''),
('en', '_msgs', 'AT_FEEDBACK_SOCIAL_GROUP_UPDATED', 0x47726f7570207375636365737366756c6c7920757064617465642e, '2009-05-27 12:01:11', ''),
('en', '_msgs', 'AT_FEEDBACK_SOCIAL_SETTINGS_SAVED', 0x536f6369616c206e6574776f726b696e672073657474696e67732068617665206265656e2073617665642e, '2009-05-27 12:01:11', ''),
('en', '_msgs', 'AT_FEEDBACK_STUDENT_TOOLS_SAVED', 0x53747564656e7420746f6f6c73207375636365737366756c6c792075706461746564, '2008-11-07 09:56:08', ''),
('en', '_msgs', 'AT_FEEDBACK_SUBSITE_INSTALL_MODULE', 0x436f6e74616374203c6120687265663d226d61696c746f3a2573223e415475746f722073797374656d2061646d696e6973747261746f723c2f613e20746f207265717565737420666f722074686520696e7374616c6c6174696f6e206f662061206e6577206d6f64756c652074686174206973206e6f74206f6e2074686973206c6973742e, '2012-07-24 09:49:41', ''),
('en', '_msgs', 'AT_FEEDBACK_THEME_DEFAULT', 0x546865207468656d652c203c623e25733c2f623e2c206973206e6f77207468652064656661756c74207468656d652e, '2004-10-18 15:17:47', 'Theme Manager'),
('en', '_msgs', 'AT_FEEDBACK_THEME_DISABLED', 0x546865207468656d652c203c623e2025733c2f623e2c20686173206265656e2064697361626c6564207375636365737366756c6c79203c623e2875736572732063757272656e746c79207573696e6720746865207468656d652077696c6c207374696c6c2062652061626c6520746f2075736520746865207468656d6520756e74696c2069742069732064656c65746564293c2f623e, '2004-10-19 16:55:20', 'theme manager'),
('en', '_msgs', 'AT_FEEDBACK_THREAD_LOCKED', 0x54687265616420686173206265656e207375636365737366756c6c79203c7374726f6e673e3c656d3e6c6f636b65643c2f656d3e3c2f7374726f6e673e2e, '2003-05-16 13:47:01', 'feedback msg'),
('en', '_msgs', 'AT_FEEDBACK_THREAD_SUBSCRIBED', 0x596f752068617665207375636365737366756c6c79207375627363726962656420746f20746865203c7374726f6e673e25733c2f7374726f6e673e207468726561642e204d6573736167657320706f7374656420746f2074686973207468726561642077696c6c20626520666f7277617264656420746f20796f7572207265676973746572656420656d61696c20616464726573732e205669657720796f75722070726f66696c6520746f206d6f6469667920796f757220656d61696c20616464726573732e, '2004-12-02 16:21:03', 'forum threads'),
('en', '_msgs', 'AT_FEEDBACK_THREAD_UNLOCKED', 0x54687265616420686173206265656e207375636365737366756c6c79203c7374726f6e673e3c656d3e756e6c6f636b65643c2f656d3e3c2f7374726f6e673e2e, '2003-05-16 13:47:01', 'feedback msg'),
('en', '_msgs', 'AT_FEEDBACK_THREAD_UNSUBSCRIBED', 0x596f752068617665207375636365737366756c6c7920756e737562736372696265642066726f6d20746865203c7374726f6e673e25733c2f7374726f6e673e207468726561642e204d657373616765732077696c6c206e6f206c6f6e6765722062652073656e7420746f20796f757220656d61696c20616464726573732e, '2004-12-02 16:34:13', 'forum threads'),
('en', '_msgs', 'AT_FEEDBACK_TILE_IMPORT_SUCCESS', 0x436f6e74656e7420696d706f7274656420696e746f2041436f6e74656e74207375636365737366756c6c792e203c6272202f3e3c6120687265663d22257322207461726765743d225f6e6577223e5669657720696d706f7274656420636f6e74656e7420696e2041436f6e74656e7420696e2061206e65772077696e646f773c2f613e, '2010-06-25 12:47:25', 'tile search'),
('en', '_msgs', 'AT_FEEDBACK_TOOLS_OFF', 0x436f75727365206d616e6167656d656e7420746f6f6c732068617665206265656e207475726e6564206f66662e20596f752063616e207374696c6c2061636365737320746f6f6c7320756e64657220746865203c7374726f6e673e4d616e6167653c2f7374726f6e673e207461622061626f76652e, '2013-09-30 16:32:13', 'course admin switch'),
('en', '_msgs', 'AT_FEEDBACK_TOOLS_ON', 0x436f75727365206d616e6167656d656e7420746f6f6c732068617665206265656e207475726e6564206f6e2e, '2013-09-30 16:30:59', ''),
('en', '_msgs', 'AT_FEEDBACK_TRANSFORMABLE_CONFIG_SAVED', 0x596f75722041436f6e74656e742073657474696e67732068617665206265656e2073617665642e, '2010-06-09 15:25:01', ''),
('en', '_msgs', 'AT_FEEDBACK_UPDATE_GRADEBOOK', 0x223c7374726f6e673e253124733c2f7374726f6e673e222063616e6e6f74206265207570646174656420696e746f206772616465626f6f6b20626563617573652074686520666f6c6c6f77696e672073747564656e747320686176652074616b656e206974206d6f7265207468616e206f6e63653a3c6272202f3e0d0a253224732e, '2008-09-25 16:01:17', 'gradebook'),
('en', '_msgs', 'AT_FEEDBACK_UPGRADE_IE', 0x466f7220616e206f7074696d616c20657870657269656e63652c2074686973207468656d652062652075736564207769746820496e7465726e6574204578706c6f7265722038206f72206869676865722e, '2012-06-29 13:04:12', ''),
('en', '_msgs', 'AT_INFOS_404_BLURB', 0x546865207061676520796f752061726520747279696e6720746f20616363657373203c693e25733c2f693e20646f6573206e6f742065786973742c206f7220686173206265656e206d6f7665642e20547279207573696e6720746865203c6120687265663d226d6f64732f5f7374616e646172642f736974656d61702f736974656d61702e706870223e536974654d61703c2f613e20746f2066696e642069742e, '2010-03-09 14:29:53', '/404.php'),
('en', '_msgs', 'AT_INFOS_ACCESS_PUBLIC', 0x546869732066656174757265206973206f6e6c7920617661696c61626c6520666f722070726f746563746564206f72207072697661746520636f75727365732e, '2007-02-13 15:55:47', ''),
('en', '_msgs', 'AT_INFOS_ACCOUNT_APPROVED', 0x596f752068617665207375636365737366756c6c7920757067726164656420746f20616e20696e7374727563746f72206163636f756e742e, '2004-02-12 12:52:57', ''),
('en', '_msgs', 'AT_INFOS_ALREADY_ENROLLED', 0x596f75206861766520616c7265616479206d6164652061207265717565737420746f20656e726f6c6c20696e207468697320636f7572736520616e6420796f752068617665206e6f7420796574206265656e20617070726f7665642062792074686520696e7374727563746f722e20596f752077696c6c206265206e6f7469666564207768656e20796f7572207265717565737420686173206265656e20617070726f7665642e, '2004-11-05 10:29:01', ''),
('en', '_msgs', 'AT_INFOS_APPROVAL_PENDING', 0x596f7572207265717565737420686173206265656e206d6164652e20596f752077696c6c206265206e6f746966696564207768656e20796f7572207265717565737420686173206265656e20617070726f7665642e3c6272202f3e3c6272202f3e52657475726e20746f203c6120687265663d2275736572732f696e6465782e706870223e4d7920436f75727365733c2f613e2e, '2009-09-17 14:48:30', ''),
('en', '_msgs', 'AT_INFOS_ASSIGNMENT_FS_SUBMISSIONS', 0x41737369676e6d656e74732063616e206265207375626d6974746564207573696e67207468652041737369676e6d656e742044726f70626f78206f72207468726f756768204d792046696c657320696e20746865202046696c652053746f7261676520746f6f6c2e2041737369676e20616e2061737369676e6d656e7420746f20616c6c2073747564656e74732c206f722063726561746520612067726f757020616e6420656e61626c652046696c652053746f7261676520666f7220746861742067726f75702c20746f2061646420616e2061737369676e6d656e742064726f702d626f782e, '2011-05-30 10:08:46', ''),
('en', '_msgs', 'AT_INFOS_AUTO_ENROLL_ALREADY_ENROLLED', 0x596f752061726520616c726561647920656e726f6c6c656420746f2074686520666f6c6c6f77696e6720636f75727365733a203c756c3e202573203c2f756c3e, '2013-12-16 10:39:43', ''),
('en', '_msgs', 'AT_INFOS_CANNOT_CONNECT_GITHUB_SERVER', 0x4661696c656420746f20636f6e6e65637420746f204769744875622073657276657220746f2064657465726d696e65206966207468652066696c657320746861742077696c6c206265206d6f646966696564206279207468652050617463686572206469666665722066726f6d20746865206f726967696e616c2076657273696f6e73206f662074686f73652066696c65732e20536f2c20746f2070726f7465637420616e7920637573746f6d697a6174696f6e7320796f752068617665206d6164652c20796f7572206c6f63616c2066696c65732061726520617373756d656420746f20626520637573746f6d697a65642e20596f75206d61792063686f6f736520746f2069676e6f726520616e6420636f6e74696e75652c206f7220637265617465206261636b757073206f6620796f75722066696c65206a75737420696e20636173652e, '2013-12-10 18:01:45', ''),
('en', '_msgs', 'AT_INFOS_CANNOT_CONNECT_MOD_SERVER', 0x556e61626c6520746f20636f6e6e65637420746f206d6f64756c65207365727665722e204265207375726520796f757220496e7465726e657420636f6e6e656374696f6e2069732066756e6374696f6e696e672c20616e6420796f7572206669726577616c6c206973206e6f7420626c6f636b696e67206163636573732e, '2009-12-16 18:45:05', ''),
('en', '_msgs', 'AT_INFOS_CANNOT_CONNECT_PATCH_SERVER', 0x4661696c656420746f20636f6e6e65637420746f207061746368207365727665723a20257320736f20706174636865732070726f766964656420627920746865207061746368207365727665722063616e206e6f74206265206c69737465642e20506c656173652070726f63656564207769746820696e7374616c6c696e6720707269766174652070617463682e, '2008-10-08 12:51:54', ''),
('en', '_msgs', 'AT_INFOS_COURSE_ENDED', 0x5468697320636f757273652068617320656e646564206f6e2025732e, '2007-07-16 11:56:16', ''),
('en', '_msgs', 'AT_INFOS_COURSE_RELEASE', 0x5468697320636f7572736520686173206e6f7420796574206265656e2072656c65617365642e204974206973207363686564756c656420746f2062652072656c6561736564206f6e2025732e, '2006-04-11 12:36:49', ''),
('en', '_msgs', 'AT_INFOS_CREATE_TESTS', 0x546865726520617265206e6f20746573747320696e207468697320636f757273652e20466f6c6c6f7720746865736520737465707320746f20637265617465206120746573743a0d0a3c6f6c3e0d0a3c6c693e4f70656e20746865205175657374696f6e2042616e6b2074616220746f20637265617465207175657374696f6e732e3c2f6c693e0d0a3c6c693e4f70656e207468652043726561746520546573742f5375727665792074616220616e6420646566696e65207468652070726f7065727469657320666f722074686520746573742e2028646f6e277420666f7267657420746f20736574207468652073746172742064617465293c2f6c693e0d0a3c6c693e43686f6f7365207468652074657374206a75737420637265617465642c20636c69636b206f6e20746865205175657374696f6e7320627574746f6e207468656e206f70656e2074686520416464205175657374696f6e732074616220746f2063686f6f736520746865207175657374696f6e7320796f75206a75737420637265617465642e3c2f6c693e0d0a3c6c693e4f70656e20746865205465737473202620537572766579732068616e64626f6f6b20706167652061626f766520666f72206164646974696f6e616c2064657461696c732061626f7574206372656174696e6720616e6420636f6e6669677572696e672074657374732e3c2f6c693e0d0a3c2f6f6c3e, '2013-12-28 19:04:13', ''),
('en', '_msgs', 'AT_INFOS_DECISION_NOT_REVERSED', 0x4465636973696f6e7320636f756c64206e6f742062652072657665727365642e, '2004-08-18 12:08:25', 'AChecker - can''t reverse decision'),
('en', '_msgs', 'AT_INFOS_DECISION_NOT_SAVED', 0x4465636973696f6e7320636f756c64206e6f742062652073617665642e, '2004-08-18 12:09:38', 'AChecker - can''t save decision'),
('en', '_msgs', 'AT_INFOS_DECISION_REVERSED', 0x4465636973696f6e207265766572736564207375636365737366756c6c792e, '2004-08-18 12:07:27', 'AChecker - reverse decision'),
('en', '_msgs', 'AT_INFOS_EC_NO_PAID_COURSES', 0x596f752068617665206e6f7420656e726f6c6c656420696e20616e7920636f757273657320746861742072657175697265206665657320746f20626520706169642e203c6120687265663d222e2f75736572732f62726f7773652e706870223e42726f7773653c2f613e20636f75727365732e20, '2013-08-01 10:18:14', ''),
('en', '_msgs', 'AT_INFOS_EC_NO_STUDENTS_ENROLLED', 0x4e6f2073747564656e747320686176652072657175657374656420656e726f6c6c6d656e742e20, '2013-08-01 10:18:14', ''),
('en', '_msgs', 'AT_INFOS_EC_PAYMENTS_TURNED_OFF', 0x436f75727365206665657320617265206265696e67206d616e61676564206279207468652073797374656d732061646d696e6973747261746f722e, '2013-08-01 10:18:14', ''),
('en', '_msgs', 'AT_INFOS_FEATURE_NOT_AVAILABLE', 0x546869732066656174757265206973206e6f7420617661696c61626c652e, '2007-02-26 11:12:45', ''),
('en', '_msgs', 'AT_INFOS_FIRST_PREFS', 0x596f757220706572736f6e616c20707265666572656e6365732068617665206e6f74206265656e207365747570207965742e20596f752063616e20636c69636b206f6e207468652069636f6e206e65787420746f20796f75206e616d652061626f766520746f206f70656e2074686520706572736f6e616c20707265666572656e6365732077697a6172642c206f722069676e6f72652074686973206d65737361676520616e6420757365207468652064656661756c742073657474696e67732e20596f752063616e2061646a75737420796f757220707265666572656e636573206c6174657220756e64657220746865203c6120687265663d2275736572732f707265666572656e6365732e70687022207374796c653d22636f6c6f723a7265643b223e507265666572656e6365733c2f613e20746162206f6e204d7920537461727420506167652e, '2013-12-29 12:25:09', 'pref wizard'),
('en', '_msgs', 'AT_INFOS_GLOSSARY_REMAINS', 0x4e6f746520746861742072656d6f76696e672061206c696e6b656420676c6f7373617279207465726d2066726f6d20796f757220636f6e74656e742077696c6c203c7374726f6e673e6e6f743c2f7374726f6e673e2064656c65746520746865207465726d2066726f6d2074686520676c6f73736172792e, '2003-05-16 13:45:50', 'info msg'),
('en', '_msgs', 'AT_INFOS_INBOX_SENT_MSGS_TTL', 0x53656e74206d6573736167657320617265206175746f6d61746963616c6c792064656c6574656420657665727920257320646179732e, '2007-02-20 14:19:34', ''),
('en', '_msgs', 'AT_INFOS_INVALID_URL', 0x4c6f63616c686f7374206973206e6f7420612076616c69642055524c, '2004-08-18 12:03:14', 'Used when AChecker reading URL'),
('en', '_msgs', 'AT_INFOS_INVALID_USER', 0x596f75206d757374203c6120687265663d226c6f67696e2e7068703f636f757273653d2573223e6c6f67696e3c2f613e20746f2075736520746869732073656374696f6e2e, '2004-04-15 13:52:32', ''),
('en', '_msgs', 'AT_INFOS_LOGIN_TO_POST', 0x596f75206d757374206265206c6f6767656420696e20746f20706f73742e, '2004-11-05 10:29:51', 'info msg'),
('en', '_msgs', 'AT_INFOS_MASTER_LIST_DISABLED', 0x546865206d6173746572206c69737420686173206265656e2064697361626c65642e2020546f20656e61626c6520746869732066756e6374696f6e616c69747920676f20746f203c6120687265663d2261646d696e2f636f6e6669675f656469742e706870223e53797374656d20507265666572656e6365733c2f613e2e, '2005-05-10 15:16:13', ''),
('en', '_msgs', 'AT_INFOS_MAX_ATTEMPTS', 0x546869732074657374206973206e6f742063757272656e746c7920617661696c61626c6520617420746869732074696d652e2020496620796f75206861766520616c726561647920636f6d706c65746564207468697320746573742e20506c65617365207669736974203c6120687265663d226d6f64732f5f7374616e646172642f74657374732f6d795f74657374732e706870223e5465737473202620537572766579733c2f613e20746f2073656520796f757220726573756c74732e, '2010-10-05 12:23:45', ''),
('en', '_msgs', 'AT_INFOS_MAX_REACHED', 0x54686973206d656574696e672077696c6c206e6f74206265207265636f72646564206265636175736520746865206d6178696d756d206e756d626572206f66207265636f7264696e677320686173206265656e207265616368656420666f72207468697320636f757273652e20546f207265636f72642074686973206d656574696e672c2064656c65746520616e206578697374696e67207265636f7264696e672c20616e6420737461727420616761696e2e, '2013-08-01 10:18:14', ''),
('en', '_msgs', 'AT_INFOS_MEETING_ENDED', 0x546865206d656574696e6720796f752061726520747279696e6720746f206163636573732068617320656e6465642c206f72206973206f746865727769736520756e617661696c61626c652e, '2013-08-01 10:18:14', ''),
('en', '_msgs', 'AT_INFOS_MEETING_ENDED_MOD', 0x546865206d656574696e6720796f752061726520747279696e6720746f206163636573732068617320656e6465642c206f72206973206f746865727769736520756e617661696c61626c652e20596f752063616e206d616b6520746865206d656574696e6720617661696c61626c6520616761696e2062792073656c656374696e672069742066726f6d20746865206c6973742062656c6f772c2063686f6f73696e6720656469742c207468656e20726573657474696e6720697427732073746174757320746f202270656e64696e6722, '2013-08-01 10:18:14', ''),
('en', '_msgs', 'AT_INFOS_MSG_SEND_LOGIN', 0x596f75206d757374206265206c6f6767656420696e20746f2073656e64206d657373616765732e, '2003-05-16 13:42:17', 'info msg'),
('en', '_msgs', 'AT_INFOS_NOT_ENROLLED', 0x596f75206e65656420746f20626520656e726f6c6c656420696e207468697320636f7572736520746f20616363657373207468697320617265612e, '2004-05-12 11:35:43', ''),
('en', '_msgs', 'AT_INFOS_NOT_IN_ANY_GROUPS', 0x596f7520617265206e6f7420696e20616e792067726f7570732c206f7220746865726520617265206e6f2067726f757073206372656174656420696e207468697320636f757273652e, '2013-12-14 10:44:40', 'groups'),
('en', '_msgs', 'AT_INFOS_NOT_RELEASED', 0x5468697320636f6e74656e7420686173206e6f7420796574206265656e2072656c65617365642e204974206973207363686564756c656420746f2062652072656c6561736564206f6e2025732e, '2005-11-22 15:21:27', 'info msg'),
('en', '_msgs', 'AT_INFOS_NO_CONTENT', 0x5468697320636f7572736520686173206e6f20636f6e74656e74207965742e, '2003-05-16 13:45:50', 'info msg'),
('en', '_msgs', 'AT_INFOS_NO_COURSES', 0x4e6f20636f757273657320666f756e642e203c6120687265663d222e2f75736572732f62726f7773652e706870223e42726f7773653c2f613e206578697374696e6720636f75727365732e, '2006-11-24 15:24:59', ''),
('en', '_msgs', 'AT_INFOS_NO_COURSES_INST', 0x4e6f20636f757273657320666f756e642e203c6120687265663d222e2f62726f7773652e706870223e42726f7773653c2f613e206578697374696e6720636f7572736573206f72203c6120687265663d222e2f6d6f64732f5f636f72652f636f75727365732f75736572732f6372656174655f636f757273652e706870223e6372656174653c2f613e2061206e6577206f6e652e, '2010-03-09 14:07:35', ''),
('en', '_msgs', 'AT_INFOS_NO_FORUMS', 0x546865726520617265206e6f20666f72756d7320746861742065786973742e, '2008-11-07 10:43:18', ''),
('en', '_msgs', 'AT_INFOS_NO_LINK_CATEGORIES', 0x5468657265206172652063757272656e746c79206e6f206c696e6b2063617465676f726965732e202041206c696e6b206d6179206e6f742062652073756767657374656420756e74696c206c696e6b2063617465676f726965732068617665206265656e20637265617465642e, '2005-03-16 16:47:22', ''),
('en', '_msgs', 'AT_INFOS_NO_PACKAGES', 0x4e6f207061636b6167657320666f756e642e, '2005-05-17 12:03:52', ''),
('en', '_msgs', 'AT_INFOS_NO_PAGE_CONTENT', 0x5468657265206973206e6f20636f6e74656e74206f6e207468697320706167652e, '2003-05-16 13:45:50', 'info msg'),
('en', '_msgs', 'AT_INFOS_NO_PERMISSION', 0x596f7520646f206e6f742068617665207065726d697373696f6e20746f20616363657373207468697320706167652e, '2003-05-16 13:45:50', 'info msg'),
('en', '_msgs', 'AT_INFOS_NO_POLLS', 0x4e6f20706f6c6c732061726520617661696c61626c65207269676874206e6f772e, '2005-03-22 10:52:43', 'no active polls');
INSERT INTO `AT_language_text` (`language_code`, `variable`, `term`, `text`, `revised_date`, `context`) VALUES
('en', '_msgs', 'AT_INFOS_NO_POSTS_FOUND', 0x546865726520617265206e6f20706f73747320696e207468697320666f72756d2e, '2003-05-16 13:45:50', 'info msg'),
('en', '_msgs', 'AT_INFOS_NO_SEARCH_RESULTS', 0x4e6f2073656172636820726573756c74732e, '2003-08-22 11:31:53', 'search page'),
('en', '_msgs', 'AT_INFOS_NO_STUDENTS', 0x546865726520617265206e6f2073747564656e747320656e726f6c6c656420696e207468697320636f757273652e, '2005-03-22 11:09:35', ''),
('en', '_msgs', 'AT_INFOS_NO_TESTS', 0x4e6f20746573747320617661696c61626c652e20437265617465207465737473207573696e672074686520546573747320262053757276657973206d616e616765722e, '2010-06-17 12:29:49', ''),
('en', '_msgs', 'AT_INFOS_NO_TOOLS_FOUND', 0x4e6f2073747564656e7420746f6f6c7320617265207475726e6564206f6e2e205475726e207468656d206f6e207468726f756768204d616e6167653e53747564656e7420546f6f6c73, '2008-12-11 11:02:22', 'FHA student tools screen'),
('en', '_msgs', 'AT_INFOS_OVER_QUOTA', 0x596f7520686176652072656163686564206f722070617373656420796f7572206d6178696d756d2071756f746120666f72207468697320636f757273652e20596f752077696c6c206861766520746f2064656c65746520736f6d652066696c6573206265666f726520796f752077696c6c2062652061626c6520746f2075706c6f616420616761696e2e, '2003-10-07 15:06:28', ''),
('en', '_msgs', 'AT_INFOS_PATCH_INSTALLED_AND_REMOVE_PERMISSION', 0x54686520706174636820686173206265656e20696e7374616c6c65642e20506c656173652072656d6f7665207772697465207065726d697373696f6e20617320696e73747275637465642062656c6f772e, '2008-04-22 14:10:33', 'info msg'),
('en', '_msgs', 'AT_INFOS_PRETEST', 0x596f75206d7573742074616b652074686520707265726571756973697465207465737420696e206f7264657220746f20766965772074686520636f6e74656e742e, '2009-11-13 15:52:44', 'content'),
('en', '_msgs', 'AT_INFOS_PRETEST_EXPIRED', 0x596f752063616e27742076696577207468697320636f6e74656e74206265636175736520746865207072657265717569736974652074657374203c7370616e207374796c653d22666f6e742d7765696768743a626f6c64223e222573223c2f7370616e3e2068617320657870697265642e20506c6561736520636f6e7461637420796f757220696e7374727563746f722e, '2009-11-30 14:40:06', ''),
('en', '_msgs', 'AT_INFOS_PRETEST_FAILED', 0x596f7520746869732063616e6e6f742076696577207468697320636f6e74656e74206265636175736520796f752068617665206e6f742070617373656420746865207072657265717569736974652074657374203c7370616e207374796c653d22666f6e742d7765696768743a626f6c64223e222573223c2f7370616e3e2e, '2009-11-13 15:51:50', 'edit/create folder'),
('en', '_msgs', 'AT_INFOS_PRETEST_NO_PRIV', 0x596f752063616e27742076696577207468697320636f6e74656e74206265666f72652074616b696e6720746865207072657265717569736974652074657374203c7370616e207374796c653d22666f6e742d7765696768743a626f6c64223e222573223c2f7370616e3e2e, '2009-11-13 15:51:15', ''),
('en', '_msgs', 'AT_INFOS_PRIVATE_ENROL', 0x54686520636f7572736520796f752061726520747279696e6720746f20616363657373206973203c7374726f6e673e707269766174653c2f7374726f6e673e2e20456e726f6c6c6d656e7420696e207468697320636f7572736520726571756972657320696e7374727563746f7220617070726f76616c2e3c6272202f3e, '2003-10-24 15:31:11', 'info msg'),
('en', '_msgs', 'AT_INFOS_REG_DISABLED', 0x5075626c696320726567697374726174696f6e2069732064697361626c65642e, '2008-09-10 14:09:17', 'registration form'),
('en', '_msgs', 'AT_INFOS_REMEDIAL_CONTENT_AVAILABLE', 0x52656d656469616c20436f6e74656e7420617661696c61626c6520666f7220746869732074657374202573, '2013-01-23 14:52:04', ''),
('en', '_msgs', 'AT_INFOS_SAVE_CONTENT', 0x436f6e74656e74206d757374206265207361766564206265666f7265207573696e67207468697320746f6f6c2e, '2008-11-11 15:49:25', 'AChecker requirement in ATutor content'),
('en', '_msgs', 'AT_INFOS_SERVICE_UNAVAILABLE', 0x536572766963652063757272656e746c7920756e617661696c61626c652e, '2004-08-18 12:00:53', 'Used for AChecker'),
('en', '_msgs', 'AT_INFOS_TRACKING_NO', 0x547261636b696e6720696e666f726d6174696f6e206973203c7374726f6e673e6e6f743c2f7374726f6e673e20636f6c6c656374656420666f7220636f7572736520696e7374727563746f72732e20536565204d616e6167653e436f6e74656e743e557361676520666f722073747564656e7420747261636b696e6720646174612e, '2013-11-12 19:14:55', 'My Tracker'),
('en', '_msgs', 'AT_INFOS_TRACKING_NO_INST', 0x596f7520686176652063686f73656e20796f7572206f776e204944206e756d6265722e20547261636b696e6720696e666f726d6174696f6e206973206e6f74207265636f7264656420666f7220636f7572736520696e7374727563746f72732e2043686f6f736520616e6f7468657220757365722e, '2003-10-24 15:31:44', 'info msg'),
('en', '_msgs', 'AT_INFOS_TRACKING_NO_INST1', 0x547261636b696e6720696e666f726d6174696f6e206973206e6f74207265636f7264656420666f7220636f7572736520696e7374727563746f72732e2053656520746865203c6120687265663d226d6f64732f5f7374616e646172642f747261636b65722f636f757273655f747261636b65722e706870223e436f7572736520547261636b65723c2f613e20666f722061207265636f7264206f6620636f757273652061637469766974792e, '2010-03-09 14:33:16', 'info msg'),
('en', '_msgs', 'AT_INFOS_TRACKING_OFFIN', 0x547261636b696e67206973206e6f7420656e61626c656420666f72207468697320636f757273652e20436f6e7461637420796f75722073797374656d2061646d696e6973747261746f7220746f2068617665206974207475726e6564206f6e2e, '2003-05-16 13:45:50', 'info msg'),
('en', '_msgs', 'AT_INFOS_TRACKING_OFFST', 0x547261636b696e67206973206e6f7420656e61626c656420666f72207468697320636f757273652e, '2003-05-16 13:45:50', 'info msg'),
('en', '_msgs', 'AT_WARNING_CANNOT_REGISTER_LOGGEDIN', 0x596f752063616e6e6f742061636365737320746869732070616765207768696c6520796f7520617265206c6f6767656420696e2e, '2013-02-01 11:44:08', ''),
('en', '_msgs', 'AT_WARNING_CHAT_TRAN_EXISTS', 0x41207472616e736372697074207769746820746865206e616d6520257320616c72656164792065786974732e204569746865722064656c65746520746865206f726967696e616c207472616e7363726970742c207468656e2072657375626d69742c206f722072656e616d6520796f7572206e6577207472616e7363726970742e, '2003-06-02 14:05:26', 'achat instructor transcript tool'),
('en', '_msgs', 'AT_WARNING_DELETE_CATEGORY', 0x41726520796f75207375726520796f752077616e7420746f2064656c65746520746869732063617465676f7279207769746820616c6c20697473206c696e6b733f, '2003-05-16 13:46:16', 'warning msg'),
('en', '_msgs', 'AT_WARNING_LANG_EXISTS', 0x546865206c616e677561676520796f75206172652075706c6f6164696e6720697320616c726561647920696e7374616c6c6564206f6e20746869732073797374656d2e2044656c65746520746865206578697374696e67206c616e67756167652066697273742062792073656c656374696e672074686520223c7374726f6e673e52656d6f76653c2f7374726f6e673e22206c696e6b206e65787420746f20697473206c697374696e672062656c6f772e, '2003-06-06 09:40:14', 'admin language manager'),
('en', '_msgs', 'AT_WARNING_MAIL_NOT_ON', 0x4d61696c20636f6e66696775726174696f6e206973206e6f74207365742070726f7065726c792e20596f75206d6179206e6f742062652061626c6520746f2073656e64206f757420656d61696c732e20536565203c6120687265663d22687474703a2f2f7777772e617475746f722e63612f617475746f722f646f63732f6661712e706870223e415475746f72204641513c2f613e20666f722064657461696c732e, '2009-12-08 16:18:50', ''),
('en', '_msgs', 'AT_WARNING_QUESTION_WEIGHT', 0x4f6e65206f72206d6f7265206f6620746865207175657374696f6e73206f6e2074686973207465737420646f206e6f74206861766520706f696e7473206173736f6369617465642077697468207468656d2e2020456e737572652074686174207468697320697320636f72726563742c206f7220656e7465722076616c75657320666f72207175657374696f6e73207468617420646f206e6f74206861766520706f696e74732e, '2007-03-05 15:52:54', ''),
('en', '_msgs', 'AT_WARNING_SAVE_YOUR_WORK', 0x5361766520796f757220776f726b206265666f7265206f70656e696e67206f7220636c6f73696e67207468652046696c65204d616e616765722e, '2003-05-16 13:46:16', 'warning msg'),
('en', '_msgs', 'AT_WARNING_THEME_VERSION_DIFF', 0x546865207468656d652c203c623e25733c2f623e2c206d6179206e6f7420626520636f6d70617469626c65207769746820746869732076657273696f6e206f6620417475746f722e, '2004-10-19 14:34:35', 'Theme Manager'),
('en', '_msgs', 'AT_WARNING_TRANSLATE_ON', 0x596f75206172652063757272656e746c7920696e205472616e736c6174696f6e204d6f64652e20416e7920757365722063616e2061636365737320746865207472616e736c6174696f6e207061676520617420746869732074696d652e20546f207475726e206f666620746865205472616e736c617465206d6f646520706c65617365207365742041545f444556454c5f5452414e534c41544520696e202f696e636c7564652f766974616c732e696e632e70687020746f207a65726f2e, '2004-12-09 10:53:02', 'admin index and admin language manager'),
('en', '_template', '15_max_chars', 0x382063686172616374657273206d696e696d756d2c2031352063686172616374657273206d6178696d756d, '2010-07-28 19:26:52', ''),
('en', '_template', '20_max_chars', 0x323020636861726163746572206d6178696d756d, '2003-06-04 14:52:27', 'login name registration screen'),
('en', '_template', '404', 0x4572726f723a204d697373696e672050616765, '2004-03-10 11:24:10', ''),
('en', '_template', 'a', 0x41, '2007-01-10 13:47:54', ''),
('en', '_template', 'a4a_export', 0x4578706f727420416363657373466f72416c6c206164617074656420636f6e74656e742e, '2008-10-19 15:12:28', 'content editor'),
('en', '_template', 'a4a_import_package', 0x496d706f727420617661696c61626c6520416363657373466f72416c6c206164617074656420636f6e74656e742e, '2008-10-21 11:44:08', ''),
('en', '_template', 'abacus', 0x416261637573, '2008-09-09 09:03:56', ''),
('en', '_template', 'about_atutor', 0x41626f757420415475746f72, '2004-01-14 10:25:40', ''),
('en', '_template', 'about_atutor_help_text', 0x4c6561726e2061626f757420766172696f757320736f7572636573206f6620415475746f722068656c702c20616e64207468652068656c7020646973706c6179206f7074696f6e7320617661696c61626c652e, '2004-05-19 10:40:00', ''),
('en', '_template', 'about_content_tests', 0x4c696e6b20617661696c61626c6520746573747320746f207468697320636f6e74656e7420706167652e, '2008-09-23 13:46:28', 'content editor tests tab'),
('en', '_template', 'about_content_tools', 0x53656c6563742066726f6d2074686520617661696c61626c652065787465726e616c20746f6f6c732c206f6e6520746861742063616e206265206173736f6369617465642077697468207468697320636f6e74656e7420706167652061732061206c6561726e696e672061637469766974792e204f722c2074686f75676820204d616e6167653e494d53204261736963204c54492061646420796f7572206f776e2065787465726e616c20746f6f6c7320746f206d616b65207468656d20617661696c61626c6520686572652e, '2011-05-27 16:08:42', ''),
('en', '_template', 'about_pretest', 0x53656c6563742066726f6d2074686520617661696c61626c65207465737473206f6e65206f72206d6f72652074686174206d75737420626520706173736564206265666f7265207468652073747564656e742063616e2076696577207468697320636f6e74656e742e, '2010-09-28 16:29:00', 'edit/create folder'),
('en', '_template', 'about_private', 0x417661696c61626c65206f6e6c7920746f207573657273207769746820616e20415475746f722053797374656d204163636f756e742c20616e6420496e7374727563746f7220617070726f76656420656e726f6c6c6d656e742e204c6f67696e2072657175697265642e20456e726f6c6c6d656e742069732072657175697265642e, '2004-01-22 14:54:29', ''),
('en', '_template', 'about_protected', 0x417661696c61626c65206f6e6c7920746f207573657273207769746820616e20415475746f722053797374656d204163636f756e742e204c6f67696e2072657175697265642e20456e726f6c6c6d656e74206973206f7074696f6e616c2e, '2004-02-05 09:43:13', ''),
('en', '_template', 'about_public', 0x417661696c61626c6520746f20616c6c2075736572732077697468206f7220776974686f757420616e20415475746f722053797374656d204163636f756e742e204c6f67696e206e6f742072657175697265642e20456e726f6c6c6d656e74206973206f7074696f6e616c2e, '2004-02-05 09:42:59', ''),
('en', '_template', 'accept_late_submissions', 0x416363657074204c617465205375626d697373696f6e73, '2006-03-23 11:38:02', ''),
('en', '_template', 'accept_request', 0x4163636570742052657175657374, '2009-05-27 12:01:11', ''),
('en', '_template', 'access', 0x416363657373, '2007-01-27 13:45:44', 'create a new course'),
('en', '_template', 'accessibility', 0x4163636573736962696c697479, '2003-05-21 13:56:28', 'help page'),
('en', '_template', 'accessibility_disabled', 0x4163636573736962696c6974792056616c69646174696f6e2064697361626c6564, '2010-05-03 18:50:09', ''),
('en', '_template', 'accessibility_enabled', 0x4163636573736962696c6974792056616c69646174696f6e20656e61626c6564, '2011-08-23 10:57:54', ''),
('en', '_template', 'accessibility_features', 0x4163636573736962696c697479204665617475726573, '2003-05-21 14:28:03', 'help'),
('en', '_template', 'accessibility_features_text', 0x5573696e6720415475746f7220776974682061737369737469766520746563686e6f6c6f677920616e64206f74686572206163636573736962696c6974792066656174757265732e, '2003-05-21 14:00:59', 'help'),
('en', '_template', 'access_credit', 0x4163636573736962696c697479207265706f72742070726f7669646564206279203c61207469746c653d2241436865636b657220576562204163636573736962696c69747920436865636b657220286c696e6b206f70656e7320696e2061206e65772077696e646f772922207461726765743d225f6e65772220687265663d22687474703a2f2f7777772e61636865636b65722e6361223e41436865636b65723c2f613e2e, '2009-11-04 16:20:03', 'include/html/editor_tabs/accessibility.inc.php'),
('en', '_template', 'access_method', 0x416363657373204d6574686f64, '2003-05-18 09:07:28', 'tracker'),
('en', '_template', 'access_stats', 0x416363657373204d6574686f64205374617469737469637320666f72, '2005-02-07 16:22:32', 'context (?)'),
('en', '_template', 'account_authorization', 0x4163636f756e74204372656174696f6e20417574686f72697a6174696f6e, '2005-05-27 13:33:38', 'registration page'),
('en', '_template', 'account_information', 0x4163636f756e7420496e666f726d6174696f6e, '2003-05-18 09:14:11', 'control centre/registration'),
('en', '_template', 'account_settings', 0x4163636f756e742073657474696e6773, '2009-05-27 12:01:11', ''),
('en', '_template', 'account_status', 0x4163636f756e7420537461747573, '2005-04-14 11:09:36', ''),
('en', '_template', 'action', 0x416374696f6e, '2004-10-14 14:10:28', ''),
('en', '_template', 'active_admin', 0x4163746976652041646d696e6973747261746f72, '2005-03-03 11:00:47', ''),
('en', '_template', 'activities', 0x41637469766974696573, '2009-05-27 12:01:11', ''),
('en', '_template', 'ac_access_groups', 0x4163636573732047726f757073, '2004-03-09 14:22:58', ''),
('en', '_template', 'add', 0x416464, '2004-11-24 14:28:53', ''),
('en', '_template', 'add_custom_logo', 0x41646420437573746f6d204c6f676f, '2014-01-27 14:28:53', ''),
('en', '_template', 'added', 0x6164646564, '2010-04-21 14:36:43', ''),
('en', '_template', 'added_members', 0x43757272656e742047726f7570204d656d62657273, '2009-05-27 12:01:11', ''),
('en', '_template', 'add_announcement', 0x41646420416e6e6f756e63656d656e74, '2003-05-18 09:17:38', 'course announcments/home page'),
('en', '_template', 'add_application', 0x41646420476164676574, '2009-05-27 12:01:11', ''),
('en', '_template', 'add_application_url', 0x416464206761646765742062792055524c, '2009-05-27 12:01:11', ''),
('en', '_template', 'add_assignment', 0x4164642041737369676e6d656e74, '2006-03-23 11:36:30', ''),
('en', '_template', 'add_atutor_test', 0x41646420415475746f722041737369676e6d656e74732f546573742f53757276657973, '2008-09-25 16:01:17', 'gradebook'),
('en', '_template', 'add_atutor_test_info', 0x53656c6563742066726f6d2074686520617661696c61626c65207465737420616e642061737369676e6d656e74207469746c65732c207468656e206f7074696f6e616c6c792063686f6f736520612020224772616465205363616c65222c20746f2061646420612074657374206f722061737369676e6d656e7420746f20746865206772616465626f6f6b2e202e20496620224772616465205363616c65222069732073657420746f206e6f6e652c20746865207261772066696e616c2073636f72652077696c6c206265207573656420696e20706c616365206f662061206772616465207363616c652e204f6e6c7920746573747320776974682074686520746573742070726f70657274792022417474656d70747320416c6c6f776564222073657420746f20312063616e20626520616464656420746f20746865204772616465626f6f6b2e20437265617465207465737473207573696e672074686520415475746f7220546573747320262053757276657973204d616e61676572, '2008-09-25 16:01:17', 'gradebook'),
('en', '_template', 'add_a_file', 0x41646420412046696c65, '2008-04-21 15:11:31', ''),
('en', '_template', 'add_a_new_language', 0x4164642061206e6577206c616e67756167652e, '2004-10-28 13:05:59', ''),
('en', '_template', 'add_code', 0x41646420436f6465, '2004-05-06 12:22:57', 'Title for code tags in code picker'),
('en', '_template', 'add_content', 0x437265617465, '2010-05-02 09:10:36', 'heading/submit button on Add Content screen'),
('en', '_template', 'add_content_folder', 0x41646420466f6c646572, '2010-05-03 13:26:05', ''),
('en', '_template', 'add_dependent_patch', 0x416464204120446570656e64656e74205061746368, '2008-04-21 15:11:31', ''),
('en', '_template', 'add_external_test', 0x4164642045787465726e616c2041737369676e6d656e74732f5465737473, '2008-09-25 16:01:17', 'gradebook'),
('en', '_template', 'add_file_folder', 0x4164642046696c65206f7220466f6c646572, '2008-07-22 16:45:15', 'Title text used in File Manager'),
('en', '_template', 'add_glossary', 0x41646420476c6f7373617279205465726d, '2005-03-07 11:42:42', 'glossary screen'),
('en', '_template', 'add_grade_scale', 0x416464204772616465205363616c65, '2008-09-25 15:59:56', 'gradebook'),
('en', '_template', 'add_language', 0x416464204c616e6775616765, '2004-09-01 15:42:32', ''),
('en', '_template', 'add_link', 0x416464204c696e6b, '2005-02-22 10:13:06', ''),
('en', '_template', 'add_media', 0x416464204d65646961, '2009-11-04 12:48:56', 'content editor'),
('en', '_template', 'add_more', 0x416464204d6f72652053747564656e7473, '2004-10-15 14:10:59', 'create student list manually in enrollment manager'),
('en', '_template', 'add_new_association', 0x416464206e6577206173736f63696174696f6e, '2009-05-27 12:01:11', ''),
('en', '_template', 'add_new_award', 0x416464206e6577206177617264, '2009-05-27 12:01:11', ''),
('en', '_template', 'add_new_contact', 0x416464206e657720616c7465726e61746520636f6e74616374, '2009-12-10 10:17:43', ''),
('en', '_template', 'add_new_content', 0x41646420416c7465726e61746520436f6e74616374, '2009-12-03 15:38:00', ''),
('en', '_template', 'add_new_education', 0x416464206e657720656475636174696f6e, '2009-05-27 12:01:11', ''),
('en', '_template', 'add_new_interest', 0x416464206e657720696e746572657374, '2009-05-27 12:01:11', ''),
('en', '_template', 'add_new_personal', 0x41646420706572736f6e616c20696e666f726d6174696f6e, '2009-12-07 13:47:05', 'Social personal info'),
('en', '_template', 'add_new_position', 0x416464206e657720706f736974696f6e, '2009-05-27 12:01:11', ''),
('en', '_template', 'add_new_representation', 0x416464206e657720726570726573656e746174697665, '2009-12-10 10:17:05', ''),
('en', '_template', 'add_new_representative', 0x416464204e657720526570726573656e746174697665, '2009-12-03 15:41:25', ''),
('en', '_template', 'add_new_website', 0x416464206e65772077656273697465, '2009-05-27 12:01:11', ''),
('en', '_template', 'add_poll', 0x41646420506f6c6c, '2004-06-14 14:41:26', ''),
('en', '_template', 'add_question', 0x416464205175657374696f6e, '2005-10-19 12:44:11', ''),
('en', '_template', 'add_questions', 0x416464205175657374696f6e73, '2003-05-18 10:27:45', 'test manager add questions screen'),
('en', '_template', 'add_sibling_folder', 0x41646420466f6c646572, '2010-05-03 13:26:20', ''),
('en', '_template', 'add_sibling_page', 0x4164642050616765, '2010-05-03 13:26:30', ''),
('en', '_template', 'add_sub_folder', 0x4164642053756220466f6c646572, '2009-09-16 13:13:00', ''),
('en', '_template', 'add_sub_page', 0x416464205375622050616765, '2005-03-31 14:17:33', 'content page shortcuts'),
('en', '_template', 'add_term', 0x416464205465726d, '2003-05-18 10:28:38', 'glossary'),
('en', '_template', 'add_tests', 0x4164642054657374732f41737369676e6d656e7473, '2008-09-25 16:01:17', 'gradebook'),
('en', '_template', 'add_topic', 0x41646420546f706963, '2005-10-19 12:43:01', ''),
('en', '_template', 'add_top_folder', 0x41646420466f6c646572, '2010-08-09 08:38:27', ''),
('en', '_template', 'add_top_page', 0x4164642050616765, '2010-08-09 08:38:45', ''),
('en', '_template', 'add_to_friends', 0x41646420746f20636f6e7461637473, '2009-05-27 12:01:11', ''),
('en', '_template', 'add_to_mygadgets', 0x41646420746f204d792047616467657473, '2009-05-27 12:01:11', ''),
('en', '_template', 'add_to_test_survey', 0x41646420746f20546573742f537572766579, '2004-11-22 16:38:53', ''),
('en', '_template', 'administration', 0x41646d696e697374726174696f6e, '2003-06-04 10:51:48', 'admin home page'),
('en', '_template', 'administrators', 0x41646d696e6973747261746f7273, '2005-03-03 10:40:40', ''),
('en', '_template', 'admin_bundle_instructions', 0x506c656173652073656c656374207468652070726f66696c6528732920796f75207769736820746f2062756e646c6520616e642073656e642076696120652d6d61696c2e20416c6c206572726f72206c6f677320636f75706c656420776974682074686573652070726f66696c65732077696c6c20616c736f20626520696e636c756465642e, '2005-03-10 15:29:13', 'admin error reporting'),
('en', '_template', 'admin_email', 0x456d61696c205573657273, '2005-01-06 14:57:16', ''),
('en', '_template', 'admin_home', 0x486f6d65, '2010-10-08 13:33:07', ''),
('en', '_template', 'admin_log', 0x41646d696e6973747261746f72204163746976697479204c6f67, '2005-03-03 10:40:27', ''),
('en', '_template', 'admin_new_account', 0x412075736572206163636f756e7420686173206265656e206372656174656420666f7220796f75206174202531732e20546f206163636573732074686973206163636f756e742c20706c65617365206c6f6720696e746f2074686520736974652e204974206973207374726f6e676c792073756767657374656420796f75206368616e676520796f75722070617373776f72642075706f6e206c6f6767696e6720696e2e, '2005-06-21 16:38:21', 'Admin creates a new user account.'),
('en', '_template', 'admin_new_account_confirm', 0x416e206163636f756e7420686173206265656e206372656174656420666f7220796f75206174202531732e20546f2061636365737320796f7572206163636f756e742c20796f75206d75737420666972737420636f6e6669726d20796f757220656d61696c206279207573696e672074686520666f6c6c6f77696e67206c696e6b3a202532732e204974206973207374726f6e676c792073756767657374656420796f75206368616e676520796f75722070617373776f72642075706f6e206c6f6767696e6720696e2e, '2005-06-21 16:37:44', 'Admin creates a new user and confirm is ON'),
('en', '_template', 'admin_social', 0x536f6369616c204e6574776f726b2053657474696e6773, '2009-05-27 12:01:11', ''),
('en', '_template', 'affected_entries', 0x416666656374656420456e7472696573, '2005-03-03 12:14:33', ''),
('en', '_template', 'after_topic', 0x41667465723a202573, '2004-01-16 13:19:46', 'content editor'),
('en', '_template', 'age', 0x416765, '2003-05-18 10:38:32', 'registration, profile'),
('en', '_template', 'all', 0x416c6c, '2003-05-18 11:35:37', 'glossary'),
('en', '_template', 'allow_browse', 0x436f757273652042726f77736572, '2009-07-23 15:48:57', ''),
('en', '_template', 'allow_editing', 0x416c6c6f772045646974696e67, '2007-02-20 10:30:01', ''),
('en', '_template', 'allow_guests', 0x416c6c6f7720477565737473, '2007-03-06 14:44:45', ''),
('en', '_template', 'allow_instructor_create_course', 0x416c6c6f7720496e7374727563746f727320746f20437265617465205468656972206f776e20436f7572736573, '2013-01-30 12:12:34', 'sys prefs'),
('en', '_template', 'allow_instructor_registration', 0x416c6c6f7720496e7374727563746f727320746f20456e726f6c6c2055736572732066726f6d207468652053797374656d20526567697374726174696f6e204c697374, '2008-11-14 11:51:02', ''),
('en', '_template', 'allow_instructor_requests', 0x416c6c6f7720496e7374727563746f72205265717565737473, '2005-03-03 10:51:13', ''),
('en', '_template', 'allow_registration', 0x416c6c6f772053656c662d526567697374726174696f6e, '2008-09-10 14:14:38', ''),
('en', '_template', 'allow_test_export', 0x416c6c6f772073747564656e747320746f206578706f7274207465737473207769746820636f6e74656e74207061636b616765733a, '2008-09-26 13:43:42', ''),
('en', '_template', 'allow_unenroll', 0x416c6c6f7720557365727320746f20556e656e726f6c6c205468656d73656c7665732066726f6d20436f75727365732e, '2008-09-10 14:16:06', ''),
('en', '_template', 'all_atutor_assignments', 0x416c6c20415475746f722041737369676e6d656e7473, '2008-09-25 16:01:17', 'gradebook'),
('en', '_template', 'all_atutor_tests', 0x416c6c204170706c696361626c6520415475746f722054657374732026616d703b2053757276657973, '2008-09-25 16:01:17', 'gradebook'),
('en', '_template', 'all_available_courses', 0x416c6c20617661696c61626c6520636f7572736573, '2004-08-18 12:03:26', ''),
('en', '_template', 'all_courses', 0x416c6c20436f7572736573, '2005-04-01 14:08:29', 'forums'),
('en', '_template', 'all_failed_students', 0x416c6c204661696c65642053747564656e7473, '2008-03-10 11:52:03', 'Test/Survey Property'),
('en', '_template', 'all_forums', 0x5368617265207769746820616c6c20636f75727365732c206f72, '2006-06-01 14:31:37', 'admin create shared forum'),
('en', '_template', 'all_label', 0x416c6c2028257329, '2005-05-12 10:26:10', ''),
('en', '_template', 'all_passed_students', 0x416c6c205061737365642053747564656e7473, '2008-03-10 11:51:36', 'Test/Survey Property'),
('en', '_template', 'all_questions_on_page', 0x416c6c207175657374696f6e73206f6e206f6e652070616765, '2007-08-20 15:46:22', 'create/edit test'),
('en', '_template', 'all_students', 0x416c6c2053747564656e7473, '2006-03-23 13:39:11', ''),
('en', '_template', 'all_users', 0x416c6c205573657273, '2005-03-10 15:24:33', ''),
('en', '_template', 'already_registered', 0x496620616c7265616479207265676973746572656420636c69636b2068657265, '2014-01-16 15:24:33', ''),
('en', '_template', 'alter', 0x416c746572, '2008-04-21 15:11:31', ''),
('en', '_template', 'alternate_text', 0x416c7465726e6174652054657874, '2004-12-08 12:39:27', 'filemanager, image inset alt field'),
('en', '_template', 'alternatives', 0x416c7465726e617469766573, '2010-03-09 16:16:55', 'adapted content'),
('en', '_template', 'alternatives_to', 0x41646170746174696f6e206f66, '2008-10-21 10:56:51', ''),
('en', '_template', 'alternative_content', 0x4164617074656420436f6e74656e74, '2008-10-19 12:03:00', ''),
('en', '_template', 'alt_contact', 0x416c7465726e61746520436f6e74616374, '2009-12-03 15:40:35', ''),
('en', '_template', 'alt_to_audio', 0x416c7465726e61746976657320546f20417564696f, '2010-04-12 16:36:06', ''),
('en', '_template', 'alt_to_text', 0x416c7465726e61746976657320546f2054657874, '2010-04-12 16:35:54', ''),
('en', '_template', 'alt_to_visual', 0x416c7465726e61746976657320546f2056697375616c, '2010-04-12 16:35:59', ''),
('en', '_template', 'alumni', 0x416c756d6e69, '2004-10-22 15:56:39', ''),
('en', '_template', 'always', 0x416c77617973, '2006-03-23 11:38:33', ''),
('en', '_template', 'american-asl', 0x416d65726963616e2d41534c, '2008-09-09 09:01:12', ''),
('en', '_template', 'announcements', 0x416e6e6f756e63656d656e7473, '2003-05-18 11:36:24', 'course home page'),
('en', '_template', 'announcement_date_format', 0x25256c202525462025256a2c20252559202d202525483a252569, '2006-04-11 14:10:57', 'course home page'),
('en', '_template', 'anonymous', 0x416e6f6e796d6f7573, '2004-08-26 13:24:12', ''),
('en', '_template', 'anonymous_test', 0x416e6f6e796d6f7573, '2004-08-26 12:31:05', ''),
('en', '_template', 'answer', 0x416e73776572, '2003-05-18 11:38:10', 'test question add/edit screens'),
('en', '_template', 'answers', 0x416e7377657273, '2007-01-10 13:47:41', ''),
('en', '_template', 'answer_size', 0x416e737765722053697a65, '2003-05-18 11:38:55', 'add/edit open ended question'),
('en', '_template', 'apache_mod_rewrite', 0x417061636865206d6f645f72657772697465, '2008-05-14 12:04:49', ''),
('en', '_template', 'append', 0x417070656e64, '2008-09-09 09:02:05', ''),
('en', '_template', 'append_content', 0x417070656e642073656c6563746564206d6174657269616c, '2004-10-15 14:18:20', ''),
('en', '_template', 'append_or_replace', 0x417070656e64206f72205265706c616365204f726967696e616c20436f6e74656e74, '2008-09-09 08:56:34', ''),
('en', '_template', 'applications', 0x47616467657473, '2009-05-27 12:01:11', ''),
('en', '_template', 'application_control_blurb', 0x43686f6f7365207768696368206761646765747320746f20646973706c6179206f6e20796f7572206e6574776f726b696e6720686f6d6520706167652e, '2009-05-27 12:01:11', ''),
('en', '_template', 'application_settings', 0x4761646765742053657474696e6773, '2009-05-27 12:01:11', ''),
('en', '_template', 'applies_to_all_sub_pages', 0x4170706c69657320746f20616c6c207375622070616765732e, '2007-03-01 10:23:22', 'edit/create content page. release date.'),
('en', '_template', 'apply', 0x4170706c79, '2005-02-10 11:25:17', ''),
('en', '_template', 'apply_audio_alternatives', 0x4170706c7920417564696f20416c7465726e617469766573, '2010-04-21 14:34:24', 'alternative switcher'),
('en', '_template', 'apply_sign_lang_alternatives', 0x4170706c79205369676e204c616e677561676520416c7465726e617469766573, '2010-04-21 14:35:03', 'alternative switcher'),
('en', '_template', 'apply_text_alternatives', 0x4170706c79205465787420416c7465726e617469766573, '2010-04-21 14:34:04', 'alternative switcher'),
('en', '_template', 'apply_theme_subcategories', 0x4170706c79207468656d6520746f2073756263617465676f726965732e, '2004-08-04 11:35:11', ''),
('en', '_template', 'apply_to_all_results', 0x4170706c7920746f20616c6c20726573756c7473, '2007-02-21 11:49:40', ''),
('en', '_template', 'apply_visual_alternatives', 0x4170706c792056697375616c20416c7465726e617469766573, '2010-04-21 14:34:43', 'alternative switcher'),
('en', '_template', 'approve', 0x417070726f7665, '2003-05-18 11:41:29', 'enrol administration'),
('en', '_template', 'approved', 0x417070726f766564, '2005-02-23 12:17:50', ''),
('en', '_template', 'approve_request', 0x417070726f76652052657175657374, '2009-05-27 12:01:11', ''),
('en', '_template', 'archive_total', 0x4172636869766520546f74616c, '2003-05-18 11:42:55', 'file manager zip tool'),
('en', '_template', 'arrange_content', 0x417272616e6765, '2010-05-02 08:53:12', ''),
('en', '_template', 'assigned_to', 0x41737369676e656420546f, '2005-06-02 12:18:18', ''),
('en', '_template', 'assignment', 0x41737369676e6d656e74, '2006-03-20 14:38:37', ''),
('en', '_template', 'assignments', 0x41737369676e6d656e7473, '2006-03-20 14:40:50', ''),
('en', '_template', 'assignment_dropbox', 0x41737369676e6d656e742044726f70626f78, '2011-05-30 10:06:32', ''),
('en', '_template', 'assignment_dropbox_text', 0x5375626d69742061737369676e6d656e74732e, '2011-05-30 10:06:54', ''),
('en', '_template', 'assignment_due', 0x41737369676e6d656e74204475653a202573202d2044756520446174653a202573, '2010-03-25 15:32:59', ''),
('en', '_template', 'assign_to', 0x41737369676e20546f, '2006-03-23 11:37:44', ''),
('en', '_template', 'assign_unassigned', 0x41737369676e20556e61737369676e6564, '2006-03-23 11:07:42', ''),
('en', '_template', 'assistant', 0x417373697374616e74, '2006-05-23 15:24:15', ''),
('en', '_template', 'assistants', 0x417373697374616e7473, '2004-10-15 11:45:31', 'Assistants tab in enrollment manager'),
('en', '_template', 'associations', 0x4173736f63696174696f6e73, '2009-05-27 12:01:11', ''),
('en', '_template', 'as_individual_content', 0x417320696e646976696475616c20636f6e74656e74207061676573, '2004-08-18 12:04:21', ''),
('en', '_template', 'at', 0x6174, '2003-05-18 11:44:08', 'release date tool/links database'),
('en', '_template', 'atlas', 0x41746c6173, '2008-09-10 12:26:11', 'tool prefs'),
('en', '_template', 'attempts', 0x417474656d707473, '2004-08-30 11:31:40', ''),
('en', '_template', 'atutor_accessibility_text', 0x3c703e415475746f7220696e636c7564657320612076617269657479206f662066656174757265732064657369676e656420746f20656e73757265207468617420636f6e74656e742069732061636365737369626c6520746f20616c6c20706f74656e7469616c2075736572732c20696e636c7564696e672074686f7365207769746820736c6f7720496e7465726e657420636f6e6e656374696f6e732c206f6c646572205765622062726f77736572732c20616e642070656f706c652077697468206469736162696c6974696573207573696e672061737369737469766520746563686e6f6c6f6769657320746f2061636365737320746865205765622e205468657365206665617475726573206172652064657363726962656420696e2064657461696c2062656c6f772e20446570656e64696e67206f6e20746865207468656d65206265696e6720757365642c20415475746f72206d617920696e636c75646520616c6c206f7220736f6d65206f6620746865206665617475726573206c697374656420686572652e205468652064656661756c74207468656d6520696e636c75646573207468656d20616c6c2e3c2f703e0d0a3c68333e53637265656e205265616465722053657474696e67733c2f68333e0d0a3c703e54686f7567682073637265656e2072656164657273207479706963616c6c7920776f726b2077656c6c207769746820415475746f722c20736f6d652064656661756c742073657474696e67732073686f756c642062652061646a75737465643a3c2f703e0d0a3c6f6c3e0d0a3c6c693e5365742073637265656e20726561646572204c696e6b20546578742073657474696e6720746f207265616420746865206c6f6e676572206f6620656974686572206c696e6b2074657874206f72206173736f636961746564207469746c6520746578742e2020496e206d616e79206361736573206c696e6b2074657874206e6565647320746f206265207472756e636174656420736f2069742077696c6c2066697420696e2074686520617661696c61626c652073706163652e205469746c652074657874206173736f63696174656420776974682074686f73652073686f7274656e6564206c696e6b732077696c6c20636f6e7461696e207468652066756c6c20746578742e3c2f6c693e0d0a3c2f6f6c3e0d0a0d0a3c68333e46656174757265733c2f68333e0d0a3c6f6c3e0d0a3c6c693e3c7374726f6e673e427950617373204c696e6b733a3c2f7374726f6e673e20496e2074686520746f70206c65667420636f726e6572206f6620415475746f722069732061202068696464656e20627970617373206c696e6b207468617420616c6c6f77732061737369737469766520746563686e6f6c6f677920757365727320746f20736b6970206f76657220746865206e617669676174696f6e20656c656d656e747320616e64206a756d70206469726563746c7920746f20616e20616e63686f722061742074686520746f70206f662074686520636f6e74656e74206265696e6720646973706c617965642e2050726573732074686520546162206b6579206f6e636520616674657220612070616765206861732066696e6973686564206c6f6164696e6720746f20616476616e636520746f2074686520666972737420627970617373206c696e6b207468656e20707265737320456e74657220746f207265706f736974696f6e2074686520636f6e74656e7420746f2074686520746f70206f6620796f75722073637265656e2e2054686520636f6e74656e7420616e63686f722063616e20616c736f206265206163636573736564207769746820616e206163636573736b6579205b416c742d635d2c20736f20697420697320706f737369626c6520746f206a756d7020746f2074686520746f70206f662074686520636f6e74656e742061726561206e6f206d61747465722077686572652074686520637572736f72206d69676874206265206c6f6361746564206f6e207468652073637265656e2e3c6272202f3e3c6272202f3e0d0a0d0a4f7468657220627970617373206c696e6b7320696e636c7564653a20226a756d702070617374207461626c652220736f2075736572732063616e20736b6970206f76657220766172696f75732064617461207461626c6520746f20717569636b6c792061636365737320636f6e74656e742074686174206d61792061707065617220616674657220746865207461626c653b20226a756d70207061737420636f646573222c20736f2075736572732063616e20736b6970206f7665722074686520656d6f7469636f6e20636f646573206e6561722074686520626f74746f6d206f66206d65737361676520706f7374696e6720666f726d20696e2074686520466f72756d732e3c6272202f3e3c6272202f3e3c6272202f3e0d0a0d0a5573657273206f662063757272656e742062726f777365727320616e642061737369737469766520746563686e6f6c6f67696573207468617420737570706f7274205741492d41524941206c616e646d61726b732063616e2074616b6520616476616e74616765206f66207468697320616c7465726e617465206d65616e73206f66206e617669676174696e67207468726f7567682074686520415475746f7220696e746572666163652e205072657373696e67207468652073656d692d636f6c6f6e206b65792072657065617465646c792077696c6c206379636c65207468726f75676820616c6c20746865206c616e646d61726b732c20616e64206f6e6365207468652064657369726564206c616e646d61726b20697320616e6e6f756e63656420636f6e74696e75652072656164696e672066726f6d207468617420706f696e742e203c6272202f3e0d0a0d0a3c2f6c693e0d0a0d0a3c6c693e3c7374726f6e673e4163636573736b6579733a3c2f7374726f6e673e204b6579626f617264206163636573736962696c69747920686173206265656e20616464656420746f206d616e7920415475746f722066656174757265732e20546f206163746976617465206163636573736b6579732c20707265737320416c7420706c7573207468652061737369676e6564206e756d6265722c206c65747465722c206f72206368617261637465722e204163636573736b657973206172652061737369676e65642064796e616d6963616c6c7920746f20746865207461627320696e20746865204d61696e204e617669676174696f6e2e20546865206669727374207461622077696c6c2062652061737369676e6564205b416c742d315d2c20746865207365636f6e64207461622077696c6c2062652061737369676e6564205b416c742d325d2c20616e6420736f206f6e2e20204e6f74652074686174206e6f7420616c6c2062726f777365727320737570706f7274206163636573736b6579732e3c6272202f3e3c6272202f3e0d0a0d0a47656e6572616c204163636573734b6579730d0a3c756c3e0d0a3c6c693e5b416c742d3120746f20416c742d305d204d61696e204e617669676174696f6e20546162733c2f6c693e0d0a3c6c693e5b416c742d2c5d2050726576696f757320746f7069632028692e652e204c65667420616e676c6520627261636b6574203c293c2f6c693e0d0a3c6c693e5b416c742d2e5d204e65787420746f7069632028692e652e20526967687420616e676c6520627261636b6574203e20293c2f6c693e0d0a3c6c693e5b416c742d2e5d20526573756d652028692e652e20526967687420616e676c6520627261636b6574203e207768696c65206f7574736964652074686520636f7572736520636f6e74656e74293c2f6c693e0d0a3c6c693e5b416c742d6a5d204a756d70204d656e753c2f6c693e0d0a3c6c693e5b416c742d735d205375626d69742028616374697665206f6e206d616e7920666f726d207061676573293c2f6c693e0d0a3c6c693e5b416c742d635d204a756d7020746f20636f6e74656e7420746f702028746f7020616e64206e617669676174696f6e20627970617373206c696e6b293c2f6c693e0d0a3c2f756c3e0d0a0d0a436f6e74656e7420456469746f72204163636573734b6579730d0a3c756c3e0d0a3c6c693e5b416c742d6e5d20436f6e74656e74205461623c2f6c693e0d0a3c6c693e5b416c742d705d2050726f70657274696573205461623c2f6c693e0d0a3c6c693e5b416c742d675d20476c6f7373617279205461623c2f6c693e0d0a3c6c693e5b416c742d725d2050726576696577205461623c2f6c693e0d0a3c6c693e5b416c742d615d204163636573736962696c697479205461623c2f6c693e0d0a3c6c693e5b416c742d735d20536176653c2f6c693e0d0a3c2f756c3e0d0a0d0a43686174204163636573734b6579730d0a3c756c3e0d0a3c6c693e5b416c742d635d204a756d7020746f20436f6d706f7365204d657373616765206669656c643c2f6c693e0d0a3c6c693e5b416c742d725d2052656672657368204d657373616765733c2f6c693e0d0a3c6c693e5b416c742d6d5d204a756d7020746f204d657373616765204c6973743c2f6c693e0d0a3c6c693e5b416c742d715d205175697420436861743c2f6c693e0d0a3c2f756c3e0d0a0d0a496e626f78204163636573734b6579730d0a3c756c3e0d0a3c6c693e5b416c742d725d205265706c7920746f204d657373616765733c2f6c693e0d0a3c2f756c3e0d0a3c6272202f3e0d0a0d0a56697375616c20456469746f72204163636573734b6579730d0a3c756c3e0d0a3c6c693e5b416c742d715d206a756d7020746f20627574746f6e206261723c2f6c693e0d0a3c6c693e5b416c742d7a5d206a756d7020746f20636f6e74656e742061726561206f6620656469746f723c2f6c693e0d0a3c6c693e5b416c742d785d206a756d7020746f20656c656d656e7420706174682028626f74746d293c2f6c693e0d0a3c2f756c3e0d0a3c2f6c693e0d0a0d0a3c6c693e3c7374726f6e673e4163636573736962696c6974792056657269666965723a203c2f7374726f6e673e5768696c65207573696e672074686520415475746f7220436f6e74656e7420456469746f722c20696e7374727563746f72732063616e20636865636b20746865206163636573736962696c697479206f6620746865697220636f6e74656e7420746f20626520737572652069742063616e20616363657373656420627920616c6c2073747564656e74732c20696e636c7564696e672074686f7365207573696e672061737369737469766520746563686e6f6c6f676965732c206f72206f6c64657220746563686e6f6c6f676965732e205768696c65207573696e672074686520436f6e74656e7420456469746f722c2073656c656374205b416c742d615d20746f206f70656e20746865206163636573736962696c6974792076657269666965722e3c2f6c693e0d0a0d0a3c6c693e3c7374726f6e673e416c7465726e617469766520546578743a203c2f7374726f6e673e416c6c206d65616e696e6766756c20696d6167657320696e20415475746f7220696e636c7564652061207465787420616c7465726e61746976652074686174206465736372696265732074686520696d616765206f72206974732066756e6374696f6e2e20576865726520696d6167657320617265206e6f74206d65616e696e6766756c2074686520416c7420617474726962757465206973206c65667420656d70747920736f2061737369737469766520746563686e6f6c6f67696573202077696c6c2069676e6f72652074686520696d6167652e3c2f6c693e0d0a0d0a3c6c693e3c7374726f6e673e416c7465726e6174697665204e617669676174696f6e3a203c2f7374726f6e673e476c6f62616c2c2068696572617263686963616c2c20616e642073657175656e7469616c206e617669676174696f6e20746f6f6c732061726520617661696c61626c6520736f2075736572732063616e2076696577206f722073747275637475726520636f6e74656e7420696e2061206d616e6e65722074686174207375697473207468656972207374796c65206f66206c6561726e696e672e202054686520415475746f7220536974654d61702070726f766964657320612066756c6c206c697374206f6620616c6c20636f6e74656e7420616e6420746f6f6c7320617661696c61626c652c20736f20616c6c20666561747572657320696e206120636f757273652063616e2062652061636365737365642066726f6d20612073696e676c65206c6f636174696f6e2e3c2f6c693e0d0a0d0a3c6c693e3c7374726f6e673e526573756d652f436f6e74696e75653a203c2f7374726f6e673e415475746f722072656d656d6265727320746865206c6173742070616765206163636573736564207768656e207573657273206c656176652074686520636f7572736520636f6e74656e742c20746f20676f20746f2074686520466f72756d7320666f7220696e7374616e63652c20736f20746865792063616e20717569636b6c792066696e6420746865697220776179206261636b20746f2077686572652074686579206c656674206f66662e2054686520636f6e74656e74206c6f636174696f6e20697320616c736f2072656d656d6265726564206265747765656e2073657373696f6e732c20736f207768656e2072657475726e696e6720746f20415475746f722c2075736572732063616e2073696d706c792063686f6f73652074686520526573756d65206c696e6b20696e2074686520636f75727365206c697374696e67206f6e204d7920436f75727365732c206f722073656c656374207468652074686520726573756d65206c696e6b20696e207468652062726561646372756d62732061742074686520746f70206f66207468652073637265656e206f6e636520696e206120636f757273652e205573696e6720746865205b416c742d2e5d206163636573736b65792077696c6c20616c736f2072657475726e2061207573657220746f20746865206c61737420636f6e74656e742070616765207468657920776572652076696577696e672061667465722074686579206861766520656e746572656420696e746f206120636f757273652e3c2f6c693e0d0a0d0a3c6c693e3c7374726f6e673e48696465204d656e75733a3c2f7374726f6e673e20466f72207573657273206f66206f6c6465722061737369737469766520746563686e6f6c6f67696573207468617420646f206e6f7420737570706f727420636f6c756d6e61722074657874206c616964206f757420696e207461626c65732c20697420697320706f737369626c6520746f206869646520415475746f72277320636f6e74656e74206e617669676174696f6e206d656e7520736f207468617420636f6e74656e742077696c6c20626520646973706c6179656420696e2061206c696e6561722070726573656e746174696f6e2e20486964696e672074686520636f6e74656e74206d656e7520616c736f20636f6e73657276657320737061636520666f722075736572732076696577696e6720415475746f72206f6e20736d616c6c65722073637265656e732e3c2f6c693e0d0a0d0a3c6c693e3c7374726f6e673e53656172636820616e6420536f72743a3c2f7374726f6e673e204d6f73742064617461207461626c657320617265206163636f6d70616e69656420627920612073656172636820746f6f6c2c206f722066696c7465722c20736f207370656369666963207265636f7264732063616e20626520646973706c6179656420696e20746865207461626c652c207265647563696e672074686520616d6f756e74206f66206461746120646973706c6179656420617420616e7920676976656e2074696d652e204d6f73742064617461207461626c65732063616e20616c736f20626520736f727465642062792073656c656374696e672074686520636f6c756d6e20686561646572206c6162656c2c20616761696e20616c6c6f77696e6720757365727320746f206e6172726f7720646f776e20746865206461746120646973706c61792e3c2f6c693e0d0a0d0a3c6c693e3c7374726f6e673e5461626c652020486561646572204173736f63696174696f6e733a203c2f7374726f6e673e416c6c2064617461207461626c657320617265206d61726b656420757020776974682074686520544820656c656d656e7420616e64207468652073636f70652061747472696275746520746f20656e7375726520746861742073637265656e20726561646572207573657273206172652061626c6520746f206e61766967617465207468726f756768206461746120646973706c61797320616e6420756e6465727374616e642077686174206561636820646174612063656c6c20726570726573656e74732e3c2f6c693e0d0a0d0a3c6c693e3c7374726f6e673e466f726d204c6162656c733a203c2f7374726f6e673e416c6c20666f726d206669656c6473207468726f7567686f757420415475746f7220617265206d61726b6564207570207573696e6720746865204c4142454c20656c656d656e7420746f20656e7375726520746861742074686579206172652070726f7065726c792064657363726962656420666f722061737369737469766520746563686e6f6c6f67792075736572732e204578706c69636974206c6162656c696e6720696e2074686973206d616e6e657220616c736f206d616b657320697420706f737369626c6520746f20636c69636b206f6e206120666f726d206669656c642773206c6162656c20746f20616374697661746520746865206669656c642e20546869732070726f76696465732061206c617267657220746172676574206172656120666f722074686f73652070656f706c652077686f206861766520646966666963756c747920706f736974696f6e696e672061206d6f75736520706f696e746572206f6e206120736d616c6c20666f726d206669656c642073756368206173206120726164696f20627574746f6e206f72206120636865636b626f782e3c2f6c693e0d0a0d0a3c6c693e3c7374726f6e673e5374796c65205368656574733a203c2f7374726f6e673e576865726576657220706f737369626c652c207468652070726573656e746174696f6e206f6620636f6e74656e7420696e20415475746f7220697320636f6e74726f6c6c6564206279207374796c6520736865657420656c656d656e74732e205468697320616c6c6f777320757365727320746f206f7665727269646520415475746f7227732064656661756c7420617070656172616e636520616e64206170706c79207468656972206f776e207072656665727265642070726573656e746174696f6e207374796c65732028692e652e20696e6372656173656420666f6e742073697a65732c20646966666572656e7420666f6e74207374796c65732c20636f6c6f7572732c206574632e293c2f6c693e0d0a0d0a3c6c693e3c7374726f6e673e466f726d204669656c6420466f6375733a203c2f7374726f6e673e466f7220706167657320776865726520746865207072696d61727920636f6e74656e74206973206120666f726d2c2074686520637572736f722077696c6c206175746f6d61746963616c6c7920626520706c6163656420696e20746865206669727374206669656c6420736f2074686174206166746572206120666f726d2070616765206c6f6164732c2075736572732063616e20626567696e20747970696e6720696e746f2074686520666f726d2e20205573657273206d61792063686f6f736520746f2064697361626c6520666f726d20666f63757320696e20746865697220707265666572656e63652073657474696e677320696620697420696e7465726665726573207769746820746865697220757365206f6620666f726d2073637265656e732e3c2f6c693e0d0a0d0a3c6c693e3c7374726f6e673e52656c61746976652053697a696e67206f6620496d616765733a203c2f7374726f6e673e576974682062726f7773657273207468617420737570706f727420726573697a696e67206f6620696d616765732c20415475746f722069636f6e732063616e206265206d61676e696669656420666f722075736572732077697468206c6f7720766973696f6e2c206d616b696e67207468656d206d6f726520656173696c792076697369626c652e2028652e672e204e65747363617065203720707265737320416c74202b29202e20576865726576657220706f737369626c652072656c6174697665206d65617375726573206861766520616c736f206265656e207573656420666f72206f7468657220666561747572652077697468696e20415475746f7220736f207768656e2074686520696e74657266616365206973206d61676e6966696564206f7220726564756365642c20616c6c20666561747572657320726573697a652072656c617469766520746f2065616368206f746865722c206d61696e7461696e696e67207468652073637265656e27732073796d6d657472792e3c2f6c693e0d0a0d0a3c2f6f6c3e, '2013-02-06 16:22:44', ''),
('en', '_template', 'atutor_assignment', 0x415475746f722041737369676e6d656e74, '2011-08-29 13:33:13', 'gradebook type'),
('en', '_template', 'atutor_handbook', 0x4f6666696369616c20415475746f722048616e64626f6f6b, '2005-07-12 10:42:58', ''),
('en', '_template', 'atutor_home', 0x415475746f7220686f6d65, '2003-05-18 11:49:37', 'mail response link text'),
('en', '_template', 'atutor_is', 0x3c7374726f6e673e3c656d3e415475746f723c2f656d3e3c2f7374726f6e673e20697320616e204f70656e20536f75726365205765622d6261736564203c7374726f6e673e4c6561726e696e67204d616e6167656d656e742053797374656d20284c4d53293c2f7374726f6e673e2064657369676e65642077697468206163636573736962696c69747920616e642061646170746162696c69747920696e206d696e642e2041646d696e6973747261746f72732063616e20696e7374616c6c206f722075706461746520415475746f7220696e206d696e757465732c2063726561746520637573746f6d207468656d657320746f20676976652069742061206e6577206c6f6f6b2c20616e6420657874656e74206974732066756e6374696f6e616c69747920627920656e61626c696e67206f7220646576656c6f70696e672066656174757265206d6f64756c65732e204564756361746f72732063616e20717569636b6c7920617373656d626c652c207061636b6167652c20616e642072656469737472696275746520696e737472756374696f6e616c20636f6e74656e742c20616e6420636f6e6475637420746865697220636f7572736573206f6e6c696e652e2053747564656e7473206c6561726e20696e20616e206164617074697665206c6561726e696e6720656e7669726f6e6d656e742e, '2011-08-02 15:51:40', ''),
('en', '_template', 'atutor_links', 0x3c703e4c6561726e206d6f72652061626f7574203c6120687265663d22687474703a2f2f617475746f722e63612f696e6465782e706870223e415475746f723c2f613e2062792062726f7773696e672074686520666f6c6c6f77696e67206c696e6b733a3c2f703e0d0a0d0a3c756c3e0d0a3c6c693e3c6120687265663d22687474703a2f2f617475746f722e63612f666f72756d732f696e6465782e706870223e537570706f727420466f72756d733c2f613e202d20506f737420746f20746865207573657220666f72756d733c2f6c693e0d0a3c6c693e3c6120687265663d22687474703a2f2f617475746f722e63612f73657276696365732f696e6465782e706870223e537570706f72742053657276696365733c2f613e202d20496620796f75206e656564206f75722068656c702c20737570706f727420697320617661696c61626c653c2f6c693e09090d0a3c6c693e3c6120687265663d22687474703a2f2f617475746f722e63612f617475746f722f7472616e736c6174652f696e6465782e706870223e5472616e736c6174696f6e3c2f613e202d20446f776e6c6f6164206c616e6775616765207061636b732c206265636f6d652061207472616e736c61746f723c2f6c693e0d0a3c6c693e3c6120687265663d22687474703a2f2f617475746f722e63612f73657276696365732f6c6963656e73696e672e706870223e4c6963656e73696e673c2f613e202d20415475746f7220736f66747761726520697320617661696c61626c6520666f72206672656520756e646572206365727461696e207465726d733c2f6c693e0d0a3c6c693e3c6120687265663d22687474703a2f2f617475746f722e63612f617475746f722f646f776e6c6f61642e706870223e446f776e6c6f616420415475746f723c2f613e202d20416c6c206f66207468652073797374656d20736f66747761726520726571756972656420746f2072756e20415475746f722063616e20626520646f776e6c6f6164656420686572653c2f6c693e0d0a3c2f756c3e, '2007-12-14 11:22:47', ''),
('en', '_template', 'atutor_patch_id', 0x415475746f72205061746368204944, '2008-04-21 15:08:55', ''),
('en', '_template', 'atutor_settings', 0x415475746f722053657474696e6773, '2008-09-09 08:56:34', ''),
('en', '_template', 'atutor_test', 0x415475746f722054657374, '2011-08-29 13:32:34', 'gredebook type'),
('en', '_template', 'atutor_version', 0x415475746f722056657273696f6e, '2005-03-10 11:21:25', ''),
('en', '_template', 'atutor_version_tested_with', 0x4c617374205465737465642057697468, '2008-10-21 15:41:53', ''),
('en', '_template', 'atutor_version_text', 0x25732e203c6120687265663d22687474703a2f2f617475746f722e63612f636865636b5f617475746f725f76657273696f6e2e7068703f763d2573223e436865636b204c61746573742056657273696f6e3c2f613e2e, '2007-07-26 13:52:25', ''),
('en', '_template', 'atutor_version_to_apply', 0x415475746f722056657273696f6e20746f204170706c79, '2008-04-21 15:11:31', ''),
('en', '_template', 'AT_tools', 0x415475746f7220546f6f6c73, '2003-05-18 11:51:40', 'tracker column heading');
INSERT INTO `AT_language_text` (`language_code`, `variable`, `term`, `text`, `revised_date`, `context`) VALUES
('en', '_template', 'audible_captcha', 0x41756469626c652056657273696f6e206f662043415054434841, '2009-07-16 08:50:02', ''),
('en', '_template', 'audio', 0x417564696f, '2008-09-09 08:56:34', ''),
('en', '_template', 'auditory', 0x41756469746f7279, '2008-09-08 14:18:54', ''),
('en', '_template', 'australian-auslan', 0x4175737472616c69616e2d4175736c616e, '2008-09-09 09:01:12', ''),
('en', '_template', 'austrian', 0x417573747269616e, '2008-09-09 09:01:12', ''),
('en', '_template', 'authenticated_access', 0x41757468656e7469636174656420416363657373, '2007-02-13 15:37:33', ''),
('en', '_template', 'author', 0x417574686f72, '2006-03-20 14:36:23', ''),
('en', '_template', 'auth_access_text', 0x476976652074686973206c696e6b20746f2074686f736520796f75207769736820746f2068617665206c696d697465642061636365737320746f20796f75722070726f746563746564206f72207072697661746520636f757273652e, '2007-02-13 15:54:02', ''),
('en', '_template', 'auto_approve_instructors', 0x4175746f20417070726f766520496e7374727563746f72205265717565737473, '2005-03-03 10:51:27', ''),
('en', '_template', 'auto_check_new_version', 0x436865636b20666f7220415475746f722055706461746573204175746f6d61746963616c6c79, '2005-11-21 12:37:42', ''),
('en', '_template', 'auto_enroll', 0x4175746f20456e726f6c6c6d656e74, '2010-05-03 14:58:37', 'Auto Enroll Property'),
('en', '_template', 'auto_enrolled_msg', 0x596f752068617665206265656e20656e726f6c6c656420696e746f20746865736520636f75727365733a, '2008-03-10 12:02:23', 'auto enroll property'),
('en', '_template', 'auto_enroll_delete', 0x44656c657465204175746f20456e726f6c6c6d656e74, '2008-03-10 11:54:52', 'Auto Enroll label'),
('en', '_template', 'auto_enroll_edit', 0x4372656174652f45646974204175746f20456e726f6c6c6d656e74, '2008-03-10 12:01:18', 'Auto Enroll property'),
('en', '_template', 'auto_enroll_msg', 0x596f752077696c6c20626520656e726f6c6c656420696e746f20746865736520636f75727365732e, '2008-03-10 12:01:55', 'auto enroll property'),
('en', '_template', 'auto_install_languages', 0x4175746f6d61746963616c6c7920496e7374616c6c204e6577204c616e6775616765205061636b73, '2006-07-26 12:08:03', ''),
('en', '_template', 'auto_install_languages_cron', 0x596f75206d757374207365742d757020746865203c6120687265663d2261646d696e2f63726f6e5f636f6e6669672e706870223e63726f6e3c2f613e20746f20757365207468697320666561747572652e, '2006-07-26 12:08:37', ''),
('en', '_template', 'auto_login1', 0x4175746f2d4c6f67696e, '2003-05-18 11:53:47', 'control centre'),
('en', '_template', 'availability', 0x417661696c6162696c697479, '2007-03-06 14:24:05', ''),
('en', '_template', 'available_applications', 0x417661696c61626c652047616467657473, '2009-05-27 12:01:11', ''),
('en', '_template', 'available_immediately', 0x52656c6561736520696d6d6564696174656c79, '2006-04-10 14:37:47', ''),
('en', '_template', 'available_on_my_courses', 0x4c696e6b2046726f6d20546865203c656d3e4d7920436f75727365733c2f656d3e2050616765, '2005-05-02 12:12:35', ''),
('en', '_template', 'available_patches', 0x417661696c61626c652050617463686573, '2008-04-21 15:08:55', ''),
('en', '_template', 'available_patches_text', 0x546865726520617265203c7374726f6e673e25733c2f7374726f6e673e207061746368657320617661696c61626c6520746f20696e7374616c6c2e, '2008-04-21 15:08:55', ''),
('en', '_template', 'available_to', 0x417661696c61626c6520546f, '2008-04-21 15:08:55', ''),
('en', '_template', 'average', 0x41766572616765, '2003-05-18 11:56:58', 'test results / tracker courses statistics'),
('en', '_template', 'avg_duration', 0x4176672e204475726174696f6e, '2005-03-01 12:40:29', 'tracker column heading'),
('en', '_template', 'awards', 0x417761726473, '2009-05-27 12:01:11', ''),
('en', '_template', 'b', 0x42, '2007-12-18 14:39:06', ''),
('en', '_template', 'back', 0x4261636b, '2003-05-18 12:02:02', 'file manager back up to previous directory'),
('en', '_template', 'backups', 0x4261636b757073, '2004-10-15 11:40:09', ''),
('en', '_template', 'backup_manager', 0x4261636b7570204d616e61676572, '2004-10-14 13:59:50', ''),
('en', '_template', 'back_to', 0x4261636b20546f3a, '2005-03-22 16:08:47', ''),
('en', '_template', 'back_to_main', 0x4261636b20746f204d61696e, '2004-12-06 12:07:06', ''),
('en', '_template', 'back_to_profile', 0x4261636b20746f2050726f66696c65, '2004-12-06 12:09:00', ''),
('en', '_template', 'back_to_summary', 0x4261636b20746f2053756d6d617279, '2003-05-18 12:05:32', 'tracker'),
('en', '_template', 'banner', 0x42616e6e6572, '2006-03-28 14:32:22', ''),
('en', '_template', 'basiclti', 0x45787465726e616c20546f6f6c73, '2011-05-27 15:50:32', ''),
('en', '_template', 'basiclti_comment', 0x596f752063616e2063686f6f736520616e6420636f6e66696775726520616e2045787465726e616c20546f6f6c206173736f6369617465642077697468207468697320436f6e74656e74204974656d2e, '2011-05-27 15:54:01', ''),
('en', '_template', 'basiclti_content_text', 0x45787465726e616c20546f6f6c, '2011-05-27 15:53:39', ''),
('en', '_template', 'basiclti_text', 0x537570706f727420666f7220696e746567726174696e672045787465726e616c20546f6f6c73207468617420737570706f727420494d53204261736963204c6561726e696e6720546f6f6c7320496e7465726f7065726162696c697479, '2011-05-27 15:50:55', ''),
('en', '_template', 'basiclti_tool', 0x45787465726e616c20546f6f6c, '2011-05-27 15:53:21', ''),
('en', '_template', 'basic_profile', 0x42617369632050726f66696c65, '2009-05-27 12:01:11', ''),
('en', '_template', 'before_topic', 0x4265666f72653a202573, '2004-01-16 13:19:20', 'content editor'),
('en', '_template', 'bg_colour', 0x4261636b67726f756e6420436f6c6f7572, '2008-09-09 09:01:13', ''),
('en', '_template', 'black', 0x426c61636b, '2008-09-09 09:01:13', ''),
('en', '_template', 'blogcomment_notify_body', 0x2a444f204e4f54205245504c5920544f2054484953204d4553534147452a20203c6272202f3e3c6272202f3e0d0a41206e657720626c6f6720636f6d6d656e7420686173206265656e20706f7374656420696e207468652067726f75702025732e3c6272202f3e3c6272202f3e436c69636b2074686520666f6c6c6f77696e67206c696e6b20746f2076697369742074686520636f757273652e3c6272202f3e3c6272202f3e2573, '2009-06-24 11:59:01', ''),
('en', '_template', 'blogcomment_notify_subject', 0x4e657720626c6f6720636f6d6d656e74, '2009-06-24 11:57:46', ''),
('en', '_template', 'blogs', 0x426c6f6773, '2006-05-22 12:10:42', ''),
('en', '_template', 'blog_notify_body', 0x2a444f204e4f54205245504c5920544f2054484953204d4553534147452a20203c6272202f3e3c6272202f3e0d0a41206e657720626c6f6720706f737420686173206265656e207075626c697368656420696e207468652067726f75702025732e3c6272202f3e3c6272202f3e436c69636b2074686520666f6c6c6f77696e67206c696e6b20746f2076697369742074686520636f757273652e3c6272202f3e3c6272202f3e2573, '2009-06-24 11:58:46', ''),
('en', '_template', 'blog_notify_subject', 0x4e657720626c6f6720706f7374, '2009-06-24 11:57:33', ''),
('en', '_template', 'blog_subscribe', 0x537562736372696265, '2009-06-24 11:53:15', ''),
('en', '_template', 'blog_unsubscribe', 0x556e737562736372696265, '2009-06-24 11:53:29', ''),
('en', '_template', 'blti_missing_tool', 0x45787465726e616c20546f6f6c20636f6e66696775726174696f6e20686173206973206d697373696e6720746f6f6c69643a, '2011-05-27 15:54:37', ''),
('en', '_template', 'blue', 0x426c7565, '2003-05-18 12:09:34', 'global code picker tool'),
('en', '_template', 'blue_guests', 0x426c7565203d20477565737473, '2003-05-18 12:10:38', 'instructor course statistics'),
('en', '_template', 'bl_acceptgrades', 0x416363657074204772616465732046726f6d2045787465726e616c20546f6f6c, '2011-05-27 15:55:10', ''),
('en', '_template', 'bl_acceptgrades_off', 0x446f206e6f7420616c6c6f77, '2011-05-27 15:55:21', ''),
('en', '_template', 'bl_acceptgrades_on', 0x416c6c6f77, '2011-05-27 15:55:35', ''),
('en', '_template', 'bl_allowcustomparameters', 0x416c6c6f77204164646974696f6e616c20437573746f6d20506172616d657465727320696e20436f6e74656e74204974656d, '2011-05-27 15:55:51', ''),
('en', '_template', 'bl_allowcustomparameters_off', 0x446f206e6f7420616c6c6f77, '2011-05-27 15:56:13', ''),
('en', '_template', 'bl_allowcustomparameters_on', 0x416c6c6f77, '2011-05-27 15:56:27', ''),
('en', '_template', 'bl_allowpreferheight', 0x416c6c6f77204672616d652048656967687420746f206265204368616e676564, '2011-05-27 15:56:39', ''),
('en', '_template', 'bl_allowpreferheight_off', 0x446f206e6f7420616c6c6f77, '2011-05-27 15:56:53', ''),
('en', '_template', 'bl_allowpreferheight_on', 0x416c6c6f77, '2011-05-27 15:57:06', ''),
('en', '_template', 'bl_allowroster', 0x416c6c6f772045787465726e616c20546f6f6c20546f20526574726965766520526f73746572, '2011-05-27 15:57:22', ''),
('en', '_template', 'bl_allowroster_content', 0x5370656369667920696e206561636820436f6e74656e74204974656d, '2011-05-27 15:57:37', ''),
('en', '_template', 'bl_allowroster_instructor', 0x44656c656761746520746f20496e7374727563746f72, '2011-05-27 15:57:51', ''),
('en', '_template', 'bl_allowroster_off', 0x4e65766572, '2011-05-27 15:58:04', ''),
('en', '_template', 'bl_allowroster_on', 0x416c77617973, '2011-05-27 15:58:16', ''),
('en', '_template', 'bl_allowsetting', 0x416c6c6f772045787465726e616c20546f6f6c20746f20757365207468652053657474696e672053657276696365, '2011-05-27 15:58:31', ''),
('en', '_template', 'bl_allowsetting_content', 0x5370656369667920696e206561636820436f6e74656e74204974656d, '2011-05-27 15:58:46', ''),
('en', '_template', 'bl_allowsetting_instructor', 0x44656c656761746520746f20496e7374727563746f72, '2011-05-27 15:58:59', ''),
('en', '_template', 'bl_allowsetting_off', 0x4e65766572, '2011-05-27 15:59:12', ''),
('en', '_template', 'bl_allowsetting_on', 0x416c77617973, '2011-05-27 15:59:26', ''),
('en', '_template', 'bl_choose_gradbook_entry', 0x53656c656374204772616465626f6f6b20456e747279, '2011-05-27 15:54:53', ''),
('en', '_template', 'bl_choose_tool', 0x53656c6563742045787465726e616c20546f6f6c, '2011-05-27 15:54:19', ''),
('en', '_template', 'bl_content_title', 0x45787465726e616c20546f6f6c2053657474696e6773, '2011-05-27 15:53:07', ''),
('en', '_template', 'bl_count', 0x55736520436f756e74, '2011-05-27 15:52:47', ''),
('en', '_template', 'bl_create', 0x4372656174652045787465726e616c20546f6f6c, '2011-05-27 15:51:13', ''),
('en', '_template', 'bl_customparameters', 0x437573746f6d20506172616d6574657273, '2011-05-27 15:59:40', ''),
('en', '_template', 'bl_debuglaunch', 0x4c61756e636820546f6f6c20696e204465627567204d6f6465, '2011-05-27 15:59:52', ''),
('en', '_template', 'bl_debuglaunch_content', 0x5370656369667920696e206561636820436f6e74656e74204974656d, '2011-05-27 16:00:08', ''),
('en', '_template', 'bl_debuglaunch_instructor', 0x44656c656761746520746f20496e7374727563746f72, '2011-05-27 16:00:22', ''),
('en', '_template', 'bl_debuglaunch_off', 0x4e65766572, '2011-05-27 16:00:33', ''),
('en', '_template', 'bl_debuglaunch_on', 0x416c77617973, '2011-05-27 16:00:45', ''),
('en', '_template', 'bl_delete', 0x44656c6574696e672045787465726e616c20546f6f6c, '2011-05-27 15:52:01', ''),
('en', '_template', 'bl_description', 0x4465736372697074696f6e, '2011-05-27 16:00:57', ''),
('en', '_template', 'bl_edit', 0x456469742045787465726e616c20546f6f6c, '2011-05-27 15:52:14', ''),
('en', '_template', 'bl_launchinpopup', 0x4c61756e636820546f6f6c20696e20506f702055702057696e646f77, '2011-05-27 16:01:12', ''),
('en', '_template', 'bl_launchinpopup_content', 0x5370656369667920696e206561636820436f6e74656e74204974656d, '2011-05-27 16:01:27', ''),
('en', '_template', 'bl_launchinpopup_instructor', 0x44656c656761746520746f20496e7374727563746f72, '2011-05-27 16:01:42', ''),
('en', '_template', 'bl_launchinpopup_off', 0x4e65766572, '2011-05-27 16:01:54', ''),
('en', '_template', 'bl_launchinpopup_on', 0x416c77617973, '2011-05-27 16:02:07', ''),
('en', '_template', 'bl_organizationdescr', 0x4f7267616e697a6174696f6e204465736372697074696f6e, '2011-05-27 16:02:22', ''),
('en', '_template', 'bl_organizationid', 0x4f7267616e697a6174696f6e204964656e74696669657220287479706963616c6c7920444e5329, '2011-05-27 16:02:37', ''),
('en', '_template', 'bl_organizationurl', 0x4f7267616e697a6174696f6e2055524c, '2011-05-27 16:02:51', ''),
('en', '_template', 'bl_password', 0x546f6f6c20536563726574, '2011-05-27 16:03:05', ''),
('en', '_template', 'bl_preferheight', 0x4672616d6520486569676874, '2011-05-27 16:03:18', ''),
('en', '_template', 'bl_resourcekey', 0x546f6f6c204b657920286f617574685f636f6e73756d65725f6b657929, '2011-05-27 16:03:32', ''),
('en', '_template', 'bl_sendemailaddr', 0x53656e642055736572204d61696c2041646472657373657320746f2045787465726e616c20546f6f6c, '2011-05-27 16:03:45', ''),
('en', '_template', 'bl_sendemailaddr_content', 0x5370656369667920696e206561636820436f6e74656e74204974656d, '2011-05-27 16:04:07', ''),
('en', '_template', 'bl_sendemailaddr_instructor', 0x44656c656761746520746f20496e7374727563746f72, '2011-05-27 16:04:22', ''),
('en', '_template', 'bl_sendemailaddr_off', 0x4e65766572, '2011-05-27 16:04:36', ''),
('en', '_template', 'bl_sendemailaddr_on', 0x416c77617973, '2011-05-27 16:04:48', ''),
('en', '_template', 'bl_sendname', 0x53656e642055736572204e616d657320746f2045787465726e616c20546f6f6c, '2011-05-27 16:05:03', ''),
('en', '_template', 'bl_sendname_content', 0x5370656369667920696e206561636820436f6e74656e74204974656d, '2011-05-27 16:05:15', ''),
('en', '_template', 'bl_sendname_instructor', 0x44656c656761746520746f20496e7374727563746f72, '2011-05-27 16:05:28', ''),
('en', '_template', 'bl_sendname_off', 0x4e65766572, '2011-05-27 16:05:38', ''),
('en', '_template', 'bl_sendname_on', 0x416c77617973, '2011-05-27 16:05:51', ''),
('en', '_template', 'bl_settings', 0x53657474696e6773, '2011-05-27 15:51:46', ''),
('en', '_template', 'bl_title', 0x5469746c65, '2011-05-27 16:06:01', ''),
('en', '_template', 'bl_toolid', 0x546f6f6c496420286d75737420626520756e69717565206163726f73732073797374656d29, '2011-05-27 16:06:17', ''),
('en', '_template', 'bl_toolid_header', 0x546f6f6c4944, '2011-05-27 15:52:32', ''),
('en', '_template', 'bl_toolurl', 0x546f6f6c204c61756e63682055524c, '2011-05-27 16:06:30', ''),
('en', '_template', 'bl_view', 0x45787465726e616c20546f6f6c2053657474696e6773, '2011-05-27 15:51:31', ''),
('en', '_template', 'body', 0x426f6479, '2003-05-18 12:11:16', 'add/edit forms for body field label'),
('en', '_template', 'bold', 0x426f6c64, '2003-05-18 12:11:41', 'global code picker'),
('en', '_template', 'bottom', 0x426f74746f6d, '2003-05-23 16:58:31', 'preference settings option'),
('en', '_template', 'breadcrumb_links', 0x42726561646372756d62206c696e6b73, '2014-01-01 17:39:43', 'aria-label for breadcrumbs'),
('en', '_template', 'british-bsl', 0x427269746973682d42534c, '2008-09-09 09:01:12', ''),
('en', '_template', 'browse_all', 0x42726f77736520416c6c, '2009-07-16 10:57:49', 'browse all'),
('en', '_template', 'browse_courses', 0x42726f77736520436f7572736573, '2003-05-18 12:13:27', 'control centre, about, login screens'),
('en', '_template', 'browse_files', 0x42726f7773652046696c6573, '2008-07-22 16:43:56', 'For "Browse Files" button in Fluid''''s multiple file uploader'),
('en', '_template', 'browse_for_upload', 0x42726f77736520666f722066696c6520746f2075706c6f6164, '2010-04-21 14:36:58', ''),
('en', '_template', 'bt', 0x3c6163726f6e796d207469746c653d2242797465223e423c2f6163726f6e796d3e, '2007-12-18 14:39:47', 'byte, file manager/storage'),
('en', '_template', 'bug_count', 0x42756720436f756e74, '2004-12-06 12:23:46', 'admin/error_logging.php'),
('en', '_template', 'bug_identifier', 0x427567204964656e746966696572, '2004-12-06 12:05:07', ''),
('en', '_template', 'builtin_icons', 0x4275696c74696e2049636f6e73, '2008-08-21 10:38:41', 'course properties'),
('en', '_template', 'business', 0x427573696e657373, '2009-05-27 12:01:11', ''),
('en', '_template', 'by', 0x6279, '2008-07-25 15:59:13', 'anouncements by a users'),
('en', '_template', 'bytes', 0x4279746573, '2003-05-18 12:15:45', 'admin course size quote, course properties screen'),
('en', '_template', 'c', 0x43, '2007-01-10 13:48:02', ''),
('en', '_template', 'cache_directory', 0x4361636865204469726563746f7279, '2005-03-03 10:52:26', ''),
('en', '_template', 'cache_life', 0x4361636865204c6562656e737a65697420696e2053656b756e64656e, '2013-02-12 16:31:13', ''),
('en', '_template', 'calculator', 0x43616c63756c61746f72, '2008-09-09 09:03:56', ''),
('en', '_template', 'calendar', 0x43616c656e646172, '2013-09-11 12:34:02', ''),
('en', '_template', 'calendar_assignment_cut', 0x437574206f66662064617465206f6620, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_assignment_due', 0x4475652064617465206f6620, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_bookmarkd', 0x426f6f6b6d61726b65642043616c656e64617273, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_bookmark_this', 0x426f6f6b6d61726b20746869732043616c656e646172, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_cancel_e', 0x43616e63656c, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_connect_gcal', 0x436f6e6e656374207769746820476f6f676c652043616c656e646172, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_course_end', 0x456e642064617465206f6620, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_course_start', 0x52656c656173652064617465206f6620, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_course_token', 0x20636f75727365, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_create_event', 0x437265617465204576656e74, '2013-12-31 13:44:40', ''),
('en', '_template', 'calendar_creAT_e', 0x437265617465204576656e74, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_day', 0x446179, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_del_bookmark', 0x52656d6f766520426f6f6b6d61726b, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_del_e', 0x44656c657465204576656e74, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_disconnect_gcal', 0x446973636f6e6e6563742066726f6d20476f6f676c652043616c656e646172, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_edit_e', 0x53617665, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_edit_title', 0x45646974205469746c65, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_email_part1', 0x206861732073686172656420, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_email_part2', 0x207769746820796f752e20596f75206d61792062726f7773652063616c656e6461722061743a20, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_error', 0x4572726f723a20, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_events_assign_cut', 0x41737369676e6d656e7420437574206f66662044617465, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_events_assign_due', 0x41737369676e6d656e74204475652044617465, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_events_course_end', 0x436f7572736520456e642044617465, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_events_course_rel', 0x436f757273652052656c656173652044617465, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_events_persnl', 0x506572736f6e616c204576656e7473, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_events_test_end', 0x5465737420456e642044617465, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_events_test_start', 0x546573742053746172742044617465, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_export_file', 0x4578706f7274206963732066696c65, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_form_end_d', 0x456e6420446174652028797979792d6d6d2d646429, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_form_end_t', 0x456e642054696d6520283234686f75727329, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_form_start_d', 0x537461727420446174652028797979792d6d6d2d646429, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_form_start_t', 0x53746172742054696d6520283234686f75727329, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_form_title', 0x4576656e74205469746c65, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_form_title_def', 0x4576656e74204e616d65, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_gcals', 0x476f6f676c652043616c656e64617273, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_header', 0x43616c656e646172, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_import_file', 0x496d706f7274206963732066696c65, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_internal_events', 0x415475746f7220496e7465726e616c204576656e7473, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_mailtxt', 0x456e74657220656d61696c, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_mail_title', 0x5368617265642043616c656e646172, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_manemail', 0x456e74657220656d61696c2061646472657373, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_membrselect', 0x53656c656374206d656d626572, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_month', 0x4d6f6e7468, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_next', 0x4e657874, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_notification', 0x456d61696c204e6f74696669636174696f6e73, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_noti_mail_1', 0x4576656e747320666f7220746f6d6f72726f773a20, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_noti_mail_2', 0x4576656e74, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_noti_mail_3', 0x5374617274, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_noti_mail_4', 0x456e64, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_noti_mail_5', 0x4576656e74, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_noti_off', 0x4f6666, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_noti_on', 0x4f6e, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_noti_title', 0x415475746f722043616c656e646172204e6f74696669636174696f6e, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_noti_turn', 0x5475726e, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_no_one_else', 0x596f752061726520746865206f6e6c79206f6e6520696e207468697320636f757273652c206e6f20617661696c61626c6520726563697069656e74732e, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_nxt_day', 0x4e65787420446179, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_nxt_mnth', 0x4e657874204d6f6e7468, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_nxt_week', 0x4e657874205765656b, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_of', 0x43616c656e646172206f66, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_optional_fld', 0x4f7074696f6e616c3a20496620746865207469746c65206973206e6f74207370656369666965642c2064656661756c74207469746c652077696c6c2062652073657420746f202243616c656e646172206f6620, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_options', 0x43616c656e646172204f7074696f6e73, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_patch_error', 0x496e7374616c6c2050617463682046697273742e, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_prev', 0x50726576696f7573, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_prv_day', 0x50726576696f757320446179, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_prv_mnth', 0x50726576696f7573204d6f6e7468, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_prv_week', 0x50726576696f7573205765656b, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_public_note1', 0x596f752063616e, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_public_note2', 0x6c6f67696e, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_public_note3', 0x746f20626f6f6b6d61726b20746869732063616c656e6461722e, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_pub_def_msg', 0x55736520746869732074616220746f2076696577207368617265642063616c656e6461722e, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_save', 0x53617665, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_sellist', 0x53656c6563742066726f6d206c697374, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_sendall', 0x53656e6420746f20616c6c206f746865722073747564656e747320696e207468697320636f75727365, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_share', 0x53686172652043616c656e646172, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_submit', 0x5375626d6974, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_test_end', 0x456e642064617465206f6620, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_test_start', 0x53746172742064617465206f6620, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_test_token', 0x2074657374, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_titletxt', 0x5469746c65206f662043616c656e646172, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_today', 0x546f646179, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_tooltip_cell', 0x436c69636b206f7220707265737320656e74657220746f20637265617465206576656e74, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_tooltip_event', 0x436c69636b206f7220707265737320656e74657220746f2065646974206576656e74, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_uneditable', 0x556e6564697461626c65206576656e74, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_upload_file', 0x55706c6f6164206963732066696c65, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_viewcal', 0x56696577, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_view_title', 0x56696577205368617265642043616c656e646172, '2013-09-11 12:34:03', ''),
('en', '_template', 'calendar_week', 0x5765656b, '2013-09-11 12:34:03', ''),
('en', '_template', 'cancel', 0x43616e63656c, '2003-05-18 12:16:07', 'global cancel button'),
('en', '_template', 'cannot_find_remote_languages', 0x415475746f722077617320756e61626c6520746f20636f6e6e65637420746f2074686520415475746f722e6361207765627369746520746f20726574726965766520746865206c697374206f6620617661696c61626c65206c616e6775616765732e, '2004-10-18 14:28:15', ''),
('en', '_template', 'categories', 0x43617465676f72696573, '2005-02-22 10:12:23', ''),
('en', '_template', 'category', 0x43617465676f7279, '2003-05-18 12:16:54', 'links database'),
('en', '_template', 'cats_all', 0x416c6c2043617465676f72696573, '2005-02-23 10:22:07', ''),
('en', '_template', 'cats_categories', 0x43617465676f72696573, '2003-09-24 18:21:26', 'admin course categories'),
('en', '_template', 'cats_none', 0x4e6f6e65, '2003-09-24 18:13:50', 'admin course categories'),
('en', '_template', 'cats_no_categories', 0x4e6f2043617465676f72696573, '2003-09-24 18:28:32', 'admin course categories'),
('en', '_template', 'cats_parent_category', 0x506172656e742043617465676f7279, '2003-09-24 18:04:38', 'admin course categories'),
('en', '_template', 'cats_uncategorized', 0x556e63617465676f72697a6564, '2003-09-24 18:17:50', 'admin course categories'),
('en', '_template', 'cats_view_links', 0x53686f77204c696e6b732062792043617465676f7279, '2005-03-29 14:08:08', ''),
('en', '_template', 'cAT_theme', 0x43617465676f7279205468656d65, '2004-08-04 11:34:15', ''),
('en', '_template', 'center', 0x43656e746572, '2003-05-18 12:20:08', 'global code picker option'),
('en', '_template', 'change_email', 0x4368616e676520456d61696c, '2006-05-10 11:11:26', ''),
('en', '_template', 'change_password', 0x4368616e67652050617373776f7264, '2006-05-10 11:11:41', ''),
('en', '_template', 'charset', 0x43686172616374657220536574, '2004-11-20 19:36:01', 'admin new language'),
('en', '_template', 'chat', 0x43686174, '2003-05-18 12:20:29', 'global chat label'),
('en', '_template', 'chAT_altc', 0x416c74202b20433a204a756d7020746f20436f6d706f7365204d657373616765, '2003-05-30 12:41:06', 'chat options frame'),
('en', '_template', 'chAT_altm', 0x416c74202b204d3a204a756d7020746f204d65737361676573, '2004-08-18 10:58:16', ''),
('en', '_template', 'chAT_altq', 0x416c74202b20513a2020517569742043686174, '2005-05-30 15:04:01', ''),
('en', '_template', 'chAT_altr', 0x416c74202b20523a2052656672657368204d65737361676573, '2004-08-18 10:58:42', ''),
('en', '_template', 'chAT_auto180_checking', 0x4175746f6d617469632028313830207365636f6e6420696e74657276616c29, '2003-05-15 14:23:13', 'chat message checking preference'),
('en', '_template', 'chAT_auto20_checking', 0x4175746f6d6174696320283230207365636f6e6420696e74657276616c29, '2003-05-15 14:22:22', 'chat message checking preference'),
('en', '_template', 'chAT_auto5_checking', 0x4175746f6d61746963202835207365636f6e6420696e74657276616c29, '2003-05-27 09:09:57', 'chat message checking preferences'),
('en', '_template', 'chAT_auto60_checking', 0x4175746f6d6174696320283630207365636f6e6420696e74657276616c29, '2003-05-15 14:22:53', 'chat message checking preference'),
('en', '_template', 'chAT_chime_help', 0x53657420746f20225965732220746f207265636965766520616e20617564696f20746f6e65207768656e206e6577206d65737373616765732061726520706f737465642e20446f6573206e6f7420776f726b20696e20616c6c205765622062726f77736572732e, '2003-05-15 19:33:11', 'chat message checking preferences'),
('en', '_template', 'chAT_compose_message', 0x436f6d706f7365204d657373616765, '2003-05-15 13:12:38', 'chat message compose frame'),
('en', '_template', 'chAT_currently_active', 0x43757272656e746c7920616374697665, '2003-05-15 12:40:47', 'chat hompage transcript activated'),
('en', '_template', 'chAT_current_tran', 0x41207472616e73637269707420697320616c7265616479206265696e67207265636f726465642e2020596f75206d61792076696577207468652063757272656e74207472616e736372697074206174, '2005-03-30 14:04:45', 'achat'),
('en', '_template', 'chAT_delete_transcript', 0x44656c657465205472616e736372697074, '2003-06-30 17:53:55', 'chat home page'),
('en', '_template', 'chAT_edit_prefs', 0x4564697420507265666572656e636573, '2003-05-15 13:47:05', 'chat options frame'),
('en', '_template', 'chAT_enter', 0x456e7465722043686174, '2003-05-15 14:50:48', 'chat preferences pages'),
('en', '_template', 'chAT_exit', 0x457869742043686174, '2003-05-15 13:48:43', 'chat options frame'),
('en', '_template', 'chAT_full_history', 0x46756c6c20486973746f7279, '2003-05-15 14:00:02', 'chat options frame'),
('en', '_template', 'chAT_help_display_blurb', 0x3c703e4e6f74653a203c656d3e4a756d7020546f3c2f656d3e206c696e6b7320616e6420746865203c656d3e517569636b204b65793c2f656d3e206c697374206f6e6c792061707065617220696620796f752068617665207475726e6564206f6e203c656d3e4e617669676174696f6e20416964733c2f656d3e20696e20796f7520707265666572656e6365732e3c2f703e0d0a200d0a3c756c3e0d0a093c6c693e546865203c656d3e4a756d7020746f20517569636b204b6579733c2f656d3e206c696e6b2061742074686520746f702074616b657320796f7520746f2061206c697374206f6620717569636b206b65797320666f722074686520436861742e203c2f6c693e0d0a093c6c693e546865203c656d3e4d65737361676520417265613c2f656d3e20646973706c61797320746865206d6f737420726563656e74206d657373616765732028757020746f2074656e292e203c2f6c693e0d0a202020203c6c693e546865203c656d3e4a756d7020746f204d657373616765733c2f656d3e206c696e6b732074616b6520796f7520746f2074686520626567696e6e696e67206f6620746865206c697374206f66206d657373616765732e2028416c742b4d29203c2f6c693e0d0a202020203c6c693e546865203c656d3e52656672657368204d657373616765733c2f656d3e206c696e6b206c65747320796f7520636865636b20666f72206e6577206d657373616765732028416c742b52292e203c2f6c693e0d0a202020203c6c693e546865203c656d3e436f6d706f7365204d6573736167653c2f656d3e204669656c6420616e64203c656d3e53656e6420427574746f6e3c2f656d3e206c657420796f7520656e74657220616e642073656e64206d657373616765732028416c742b4320746f20656e7465722074686520436f6d706f7365204669656c642c20456e74657220746f2073656e64206120636f6d706c65746564206d657373616765292e203c2f6c693e0d0a3c2f756c3e, '2004-08-18 11:00:36', ''),
('en', '_template', 'chAT_help_display_frame', 0x446973706c6179204672616d652048656c702028746f70206c65667429, '2003-05-15 15:24:02', 'chat help screen'),
('en', '_template', 'chAT_help_display_jump', 0x4a756d7020746f20446973706c6179204672616d652048656c70, '2003-05-27 09:14:57', 'chat help screen'),
('en', '_template', 'chAT_help_history_blurb', 0x546865203c656d3e55736572204c6973743c2f656d3e2073686f777320746865204368617420494473206f6620616c6c2074686520757365727320696e2074686520636861742e20436c69636b206f6e2061204368617420494420746f2073656520746865206d657373616765732073656e742062792074686174207061727469636970616e742c20616c6f6e67207769746820796f7572206f776e206d657373616765732e20436c69636b206f6e203c656d3e416c6c2055736572733c2f656d3e20746f2073656520746865206d657373616765732073656e7420627920616c6c207061727469636970616e74732e, '2003-05-15 15:34:10', 'chat help screen'),
('en', '_template', 'chAT_help_history_frame', 0x55736572204c69737420616e6420486973746f72792048656c70, '2003-05-15 15:32:14', 'chat help screen'),
('en', '_template', 'chAT_help_history_jump', 0x4a756d7020746f2055736572204c69737420616e6420486973746f72792048656c70, '2003-05-15 15:22:23', 'chat help screen'),
('en', '_template', 'chAT_help_jump_top', 0x4a756d7020746f20546f70, '2003-05-15 15:25:48', 'chAT_help screen'),
('en', '_template', 'chAT_help_options_blurb', 0x3c756c3e0d0a093c6c693e546865203c656d3e4564697420507265666572656e6365733c2f656d3e206c696e6b206f70656e732074686520707265666572656e63657320736f20796f752063616e206d6f6469667920796f757220636f6e74726f6c20616e6420646973706c61792073657474696e67732e203c2f6c693e0d0a202020203c6c693e546865203c656d3e4578697420436861743c2f656d3e206c696e6b20656e647320796f757220636861742073657373696f6e2e3c2f6c693e0d0a202020203c6c693e546865203c656d3e48656c703c2f656d3e206c696e6b206272696e677320796f7520746f20746869732073637265656e2e2028416c742b51293c2f6c693e0d0a3c2f756c3e, '2004-08-18 11:01:04', ''),
('en', '_template', 'chAT_help_options_frame', 0x4f7074696f6e732048656c702028746f7020726967687429, '2003-05-15 15:24:50', 'chat help screen'),
('en', '_template', 'chAT_help_options_jump', 0x4a756d7020746f204f7074696f6e732048656c70, '2003-05-27 09:15:04', 'chat help screen'),
('en', '_template', 'chAT_help_screen', 0x48656c702053637265656e, '2003-05-15 15:19:33', 'chat help'),
('en', '_template', 'chAT_history_messages', 0x486973746f7279202d204d6573736167657320257320746f202573206f66202573, '2003-05-15 15:59:13', 'chat full history screen'),
('en', '_template', 'chAT_inactive', 0x496e616374697665, '2005-03-30 14:47:25', ''),
('en', '_template', 'chAT_jump_to_message', 0x4a756d7020746f204d6573736167652041726561, '2003-05-15 13:14:01', 'chat display frame'),
('en', '_template', 'chAT_keep_tran', 0x546869732073656374696f6e20616c6c6f777320796f7520746f206b6565702061207472616e736372697074206f6620746865206368617420696e2070726f67726573732e, '2003-05-28 11:10:47', 'achat'),
('en', '_template', 'chAT_layout_prefs', 0x507265666572656e6365733a204c61796f75742053657474696e6773, '2003-05-15 14:53:04', 'chat layout preferences'),
('en', '_template', 'chAT_list_and_history', 0x55736572204c69737420616e6420486973746f7279, '2003-05-15 13:49:37', 'chat options frame'),
('en', '_template', 'chAT_logged_out', 0x5573657220257320686173206c6f67676564206f75742e, '2003-05-15 16:01:51', 'logout'),
('en', '_template', 'chAT_manual_checking', 0x4d616e75616c2052656672657368, '2003-05-15 14:23:42', 'chat message checking preference'),
('en', '_template', 'chAT_messages', 0x4d65737361676573, '2003-05-15 13:05:28', 'chat message display frame'),
('en', '_template', 'chAT_message_checking', 0x4d65737361676520436865636b696e673a, '2003-05-15 14:19:45', 'chat message checking preferences'),
('en', '_template', 'chAT_message_check_help', 0x53656c6563742074686520696e74657276616c2072617465206174207768696368206e6577206d6573736167657320617265207265747269657665642066726f6d20746865207365727665722e2053637265656e20726561646572207573657273207365742074686973206f7074696f6e20746f204d616e75616c20526566726573682e, '2003-05-15 14:39:17', 'chat message checking preferences'),
('en', '_template', 'chAT_message_chime', 0x4e6577204d657373616765204368696d653a, '2003-05-15 14:43:05', 'chat message checking preferences'),
('en', '_template', 'chAT_message_new_help', 0x53637265656e207265616465722075736572732063686f6f73652022596573222c20616c6f6e67207769746820746865204d616e75616c20526566726573682073657474696e672e, '2003-05-15 15:05:32', 'chat layout preferences'),
('en', '_template', 'chAT_message_order_help', 0x53656c656374204e657720746f204f6c6420746f20646973706c6179206e6577206d657373616765732061742074686520746f70206f66207468652073637265656e2c20616e64204f6c6420746f204e657720746f20646973706c6179206e6577206d657373616765732061742074686520626f74746f6d206f66207468652073637265656e2e, '2003-05-15 14:58:48', 'chat layout preferences'),
('en', '_template', 'chAT_newmsg_prefs', 0x53686f77204f6e6c79204e6577204d657373616765733f, '2003-05-15 15:00:44', 'chat layout preferences'),
('en', '_template', 'chAT_newold_prefs', 0x4e657720746f204f6c64, '2003-05-15 14:55:15', 'chat layout preferences'),
('en', '_template', 'chAT_none_found', 0x4e6f207472616e7363726970747320666f756e642e, '2005-03-31 11:32:44', 'chat home page'),
('en', '_template', 'chAT_no_new_messages', 0x4e6f206e6577206d657373616765732e, '2003-05-15 13:09:01', 'chat display frames'),
('en', '_template', 'chAT_oldnew_prefs', 0x4f6c6420746f204e6577, '2003-05-15 14:54:48', 'chat layout preferences'),
('en', '_template', 'chAT_options', 0x4f7074696f6e73, '2003-05-15 13:45:35', 'chat options frame'),
('en', '_template', 'chAT_order_prefs', 0x4f72646572206f66204d657373616765733a, '2003-05-15 14:53:59', 'chat layout preferences'),
('en', '_template', 'chAT_post', 0x456e7465723a20506f7374206120636f6d706c65746564206d657373616765, '2003-05-15 14:07:17', 'chat options frame'),
('en', '_template', 'chAT_prefs_checking', 0x507265666572656e6365733a204d65737361676520436865636b696e672053657474696e6773, '2003-05-15 14:18:37', 'chat checking preferences'),
('en', '_template', 'chAT_quick_keys', 0x517569636b204b657973, '2003-05-15 14:03:24', 'chat options frame'),
('en', '_template', 'chAT_refresh_message', 0x52656672657368204d65737361676573, '2003-05-15 13:16:05', 'chat display frame'),
('en', '_template', 'chAT_refresh_user_list', 0x526566726573682055736572204c697374, '2003-05-15 14:01:12', 'chat options frame'),
('en', '_template', 'chAT_return', 0x52657475726e20746f2043686174, '2003-05-15 15:20:17', 'chat help screen'),
('en', '_template', 'chAT_start_tran', 0x5374617274206b656570696e672061207472616e736372697074, '2003-05-28 11:20:12', 'achat'),
('en', '_template', 'chAT_start_transcript', 0x53746172742f53746f70205472616e736372697074, '2005-05-16 10:55:23', ''),
('en', '_template', 'chAT_stop_tran', 0x53746f70206b656570696e67207472616e7363726970742e, '2003-05-28 12:48:38', 'achat'),
('en', '_template', 'chAT_system', 0x73797374656d, '2003-05-15 13:07:42', 'chat display frame system message'),
('en', '_template', 'chAT_transcript', 0x5472616e736372697074, '2003-05-30 11:27:26', 'achat'),
('en', '_template', 'chAT_transcript_end', 0x5472616e73637269707420456e643a, '2003-05-30 11:30:10', 'achat'),
('en', '_template', 'chAT_transcript_start', 0x5472616e7363726970742053746172743a, '2003-05-30 11:29:26', 'achat'),
('en', '_template', 'chAT_tran_file_name', 0x5472616e736372697074206e616d652028616c7068616e756d657269632c206e6f20737061636573293a, '2003-05-28 18:36:35', 'achat'),
('en', '_template', 'chAT_user_logged_in', 0x5573657220257320686173206c6f6767656420696e2e, '2003-05-15 16:02:29', 'chat display system login message'),
('en', '_template', 'chAT_user_logged_out', 0x5573657220257320686173206265656e206c6f67676564206f75742064756520746f20696e61637469766974792e, '2003-05-15 16:02:16', 'chat logout system message'),
('en', '_template', 'chAT_you', 0x796f75, '2003-05-15 13:53:10', 'chat users online list'),
('en', '_template', 'checked', 0x436865636b6564, '2006-06-26 14:55:53', ''),
('en', '_template', 'child_of', 0x4368696c64206f663a202573, '2004-01-16 13:21:25', ''),
('en', '_template', 'choice', 0x43686f696365, '2003-05-18 12:25:24', 'test manager, multiple choice question editor'),
('en', '_template', 'chunks_not_found', 0x3c736d616c6c3e285761726e696e673a204f6e65206f72206d6f726520636f6465206368756e6b7320746f2062652064656c65746564206f72207265706c6163656420617265206e6f7420666f756e642e293c2f736d616c6c3e, '2008-10-27 11:35:01', 'patcher message'),
('en', '_template', 'cid', 0x434944, '2003-05-18 13:17:08', 'global code picker url content id indentifier'),
('en', '_template', 'city', 0x43697479, '2003-05-18 13:17:52', 'registration, edit profile'),
('en', '_template', 'class_avg', 0x436c61737320417667, '2008-09-25 16:01:17', 'gradebook'),
('en', '_template', 'click_browse_files', 0x436c69636b203c656d3e42726f7773652046696c65733c2f656d3e20746f206164642066696c657320746f20746865207175657565, '2008-07-22 16:44:21', 'Instructional text for using fluid''''s multiple file uploader'),
('en', '_template', 'click_code', 0x436c69636b206f6e2074686520636f6465206f7220656d6f7469636f6e20796f752077616e7420746f207573652e, '2003-05-22 15:42:52', 'global code picker instructions'),
('en', '_template', 'click_hide_tools', 0x436c69636b20746f206869646520746f6f6c20626172, '2010-03-30 15:32:01', 'content editor'),
('en', '_template', 'click_show_head', 0x436c69636b20746f20637573746f6d697a652048544d4c2068656164, '2010-03-30 15:01:59', 'content editor'),
('en', '_template', 'click_show_tools', 0x436c69636b20746f2073686f7720746f6f6c732e, '2010-03-30 14:48:25', 'content editor'),
('en', '_template', 'close', 0x436c6f7365, '2005-08-10 16:13:36', ''),
('en', '_template', 'close_after_saving', 0x436c6f736520616674657220736176696e67, '2004-05-11 11:01:40', ''),
('en', '_template', 'close_help_window', 0x436c6f73652048656c702057696e646f77, '2003-05-18 13:21:37', 'close help window link text'),
('en', '_template', 'close_menus', 0x4d656e7573, '2005-03-05 18:29:54', 'Menus'),
('en', '_template', 'close_related_topics', 0x52656c6174656420546f70696373, '2005-03-05 18:30:15', 'Menus'),
('en', '_template', 'close_window', 0x436c6f73652057696e646f77, '2004-12-08 12:04:59', ''),
('en', '_template', 'codes', 0x436f646573, '2003-05-18 13:23:57', 'global code picker label'),
('en', '_template', 'code_to_replace_from', 0x436f646520546f205265706c6163652046726f6d, '2008-04-21 15:11:31', ''),
('en', '_template', 'code_to_replace_to', 0x436f646520546f205265706c61636520546f, '2008-04-21 15:11:31', ''),
('en', '_template', 'collapse', 0x436f6c6c61707365, '2003-05-18 13:24:36', 'Menus'),
('en', '_template', 'colors', 0x436f6c6f757273, '2003-05-18 13:25:02', 'global code picker label'),
('en', '_template', 'combination', 0x4d75737420757365206120636f6d62696e6174696f6e206f66206c6574746572732c20616e64206e756d62657273206f722073796d626f6c73, '2010-10-07 09:23:45', ''),
('en', '_template', 'combine', 0x436f6d62696e65, '2008-09-25 16:01:17', 'gradebook'),
('en', '_template', 'combine_from', 0x436f6d62696e652046726f6d, '2008-09-25 16:01:17', 'gradebook'),
('en', '_template', 'combine_into', 0x436f6d62696e6520496e746f, '2008-09-25 16:01:17', 'gradebook'),
('en', '_template', 'combine_tests', 0x436f6d62696e6520415475746f72205465737473, '2008-09-25 16:01:17', 'gradebook'),
('en', '_template', 'combine_tests_info', 0x4265666f726520636f6d62696e696e672074657374732c20706c656173652072756e2073656374696f6e2061626f766520746f20757064617465206d61726b73206f662022436f6d62696e6520496e746f20546573742f5375727665792e22, '2008-09-25 16:01:17', 'gradebook'),
('en', '_template', 'comment', 0x436f6d6d656e74, '2006-03-20 14:42:32', ''),
('en', '_template', 'comments', 0x436f6d6d656e7473, '2006-03-20 14:36:45', ''),
('en', '_template', 'comments_num', 0x257320436f6d6d656e74287329, '2006-05-25 14:01:48', ''),
('en', '_template', 'common_cartridge', 0x436f6d6d6f6e20436172747269646765, '2008-12-02 11:57:49', ''),
('en', '_template', 'common_interest', 0x436f6d6d6f6e20496e746572657374, '2009-05-27 12:01:11', ''),
('en', '_template', 'company', 0x436f6d70616e79, '2009-05-27 12:01:11', ''),
('en', '_template', 'completed', 0x436f6d706c65746564, '2008-09-25 16:01:17', 'gradebook'),
('en', '_template', 'completed_date', 0x436f6d706c657465642044617465, '2008-09-25 16:01:17', 'gradebook'),
('en', '_template', 'completed_tests', 0x596f7572205375626d697373696f6e73, '2005-05-11 11:19:25', ''),
('en', '_template', 'configuration', 0x436f6e66696775726174696f6e, '2005-02-07 16:04:01', ''),
('en', '_template', 'confirm', 0x436f6e6669726d, '2004-10-18 11:50:20', 'enrollment manager, confirm action'),
('en', '_template', 'confirm_account_text', 0x496620796f75206861766520616c7265616479206372656174656420616e206163636f756e742c20796f752077696c6c206861766520746f203c6120687265663d22636f6e6669726d2e706870223e636f6e6669726d20796f757220656d61696c20616464726573733c2f613e2e, '2005-07-27 15:05:53', ''),
('en', '_template', 'confirm_admin_create', 0x41726520796f75207375726520796f752077616e7420746f2063726561746520612053757065722041646d696e6973747261746f72206163636f756e743f, '2005-03-03 10:34:16', ''),
('en', '_template', 'confirm_deny_instructor', 0x596f75206172652061626f757420746f2064656e792074686520696e7374727563746f722072657175657374206f662074686520666f6c6c6f77696e6720757365723a, '2005-07-21 16:16:48', ''),
('en', '_template', 'confirm_password', 0x436f6e6669726d2050617373776f7264, '2005-03-03 10:47:28', ''),
('en', '_template', 'connections', 0x4d7920436f6e7461637473, '2009-05-27 12:01:11', ''),
('en', '_template', 'contact_accepted', 0x415475746f7220536f6369616c20436f6e74616374204163636570746564, '2009-05-27 12:01:11', ''),
('en', '_template', 'contact_email', 0x436f6e7461637420456d61696c, '2005-03-03 10:50:32', ''),
('en', '_template', 'contact_instructor', 0x436f6e7461637420436f7572736520496e7374727563746f72, '2003-05-18 13:29:00', 'student contact instructor form'),
('en', '_template', 'contact_name', 0x436f6e74616374204e616d65, '2003-05-18 13:30:04', 'student contact instructor form'),
('en', '_template', 'contact_request', 0x415475746f7220536f6369616c20436f6e746163742052657175657374, '2009-05-27 12:01:11', ''),
('en', '_template', 'contact_support', 0x436f6e7461637420537570706f7274, '2005-07-19 10:27:52', ''),
('en', '_template', 'contain_only', 0x4d617920636f6e7461696e206f6e6c79206c6574746572732c206e756d626572732c20756e64657273636f7265732c2068797068656e73206f7220706572696f64732e, '2006-07-17 11:01:46', 'registration login name format'),
('en', '_template', 'content', 0x436f6e74656e74, '2003-05-18 13:32:22', 'sitemap/delete course'),
('en', '_template', 'contents', 0x436f6e74656e7473, '2003-05-18 13:35:43', 'content page table of content menu heading'),
('en', '_template', 'content_editor', 0x436f6e74656e7420456469746f72, '2006-11-23 13:17:41', 'user prefs'),
('en', '_template', 'content_folder_title', 0x436f6e74656e7420466f6c646572205469746c65, '2009-09-16 13:11:45', ''),
('en', '_template', 'content_navigation', 0x436f6e74656e74204e617669676174696f6e, '2005-03-29 12:18:45', 'menu content nav drop down'),
('en', '_template', 'content_package', 0x436f6e74656e74205061636b616765, '2008-12-02 11:57:28', ''),
('en', '_template', 'content_packaging', 0x496d706f7274204578706f7274, '2013-12-23 18:24:27', ''),
('en', '_template', 'content_packaging_all', 0x417661696c61626c65206f6e2065766572792070616765, '2003-10-15 10:10:17', 'option3'),
('en', '_template', 'content_packaging_disabled', 0x436f6e74656e74207061636b6167696e6720686173206265656e2064697361626c656420666f72207468697320636f757273652e, '2007-11-27 15:29:41', ''),
('en', '_template', 'content_packaging_none', 0x4e6f7420617661696c61626c65206f6e20616e79206f6620746865207061676573, '2003-10-15 10:09:27', 'option1'),
('en', '_template', 'content_packaging_top', 0x417661696c61626c65206f6e6c7920666f7220746f70206c6576656c207061676573, '2007-11-27 15:29:26', 'option2'),
('en', '_template', 'content_settings', 0x436f6e74656e7420416c7465726e617469766573, '2010-04-12 16:30:55', ''),
('en', '_template', 'content_usage', 0x5573616765, '2010-05-02 08:52:22', ''),
('en', '_template', 'continue', 0x436f6e74696e7565, '2006-03-21 16:22:28', ''),
('en', '_template', 'control_settings', 0x4e617669676174696f6e, '2010-04-12 16:29:22', ''),
('en', '_template', 'copyright', 0x576562207369746520656e67696e65277320636f646520697320636f7079726967687420c2a92020415475746f72c2ae, '2008-09-18 13:02:58', ''),
('en', '_template', 'core', 0x436f7265, '2005-08-30 10:17:41', ''),
('en', '_template', 'correct_answer', 0x436f727265637420416e73776572, '2003-05-18 13:38:45', 'test manager add/edit questions'),
('en', '_template', 'count', 0x436f756e74, '2003-05-18 13:40:35', 'tracker'),
('en', '_template', 'country', 0x436f756e747279, '2003-05-18 13:41:28', 'registration / profile edit'),
('en', '_template', 'course', 0x436f75727365, '2003-05-18 13:42:31', 'delete course warning screen'),
('en', '_template', 'courses', 0x436f7572736573, '2003-05-18 13:43:44', 'admin users/courses manager'),
('en', '_template', 'courses_below', 0x4d7920436f7572736573, '2008-04-16 19:44:10', 'jump menu divider'),
('en', '_template', 'course_admin_tools', 0x546f67676c6520636f757273652061646d696e697374726174696f6e20746f6f6c73206f6e206f72206f66662e, '2013-12-26 17:59:59', ''),
('en', '_template', 'course_available', 0x436f7572736520417661696c61626c65, '2003-05-18 13:46:03', 'file manager, server space available'),
('en', '_template', 'course_available_zip1', 0x436f7572736520417661696c61626c6520286265666f72652065787472616374696f6e29, '2003-05-18 13:46:37', 'file manager zip tool'),
('en', '_template', 'course_available_zip2', 0x436f7572736520417661696c61626c65202861667465722065787472616374696f6e29, '2003-05-18 13:47:06', 'file manager zip tool'),
('en', '_template', 'course_backups', 0x436f75727365204261636b757073, '2005-03-03 10:21:39', ''),
('en', '_template', 'course_copyright', 0x4f7074696f6e616c20436f70797269676874204e6f74696365, '2003-05-18 13:47:33', 'course copyright label'),
('en', '_template', 'course_dir_name', 0x436f75727365204469726563746f7279204e616d65, '2008-05-14 12:03:39', ''),
('en', '_template', 'course_dir_name_contain_only', 0x4d617920636f6e7461696e206f6e6c79206c6574746572732c206e756d6265727320616e6420756e64657273636f72652e, '2012-07-26 13:56:52', ''),
('en', '_template', 'course_email', 0x436f7572736520456d61696c, '2003-05-18 13:51:48', 'taught courses table in instructor control centre'),
('en', '_template', 'course_enrolment', 0x456e726f6c6c6d656e74204d616e61676572, '2003-10-01 18:54:09', 'instructor - course enrollment (previously ATutor Course Enrollment)'),
('en', '_template', 'course_files', 0x436f757273652046696c6573, '2006-03-20 14:40:32', ''),
('en', '_template', 'course_forums', 0x436f7572736520466f72756d73, '2004-11-13 19:55:06', ''),
('en', '_template', 'course_home', 0x436f7572736520486f6d65, '2010-10-08 13:32:24', 'course main nav menu'),
('en', '_template', 'course_id', 0x436f75727365204944, '2003-05-18 13:54:57', 'admin course manager'),
('en', '_template', 'course_instructor', 0x436f7572736520496e7374727563746f72, '2003-05-18 13:57:00', 'student contact instructor form'),
('en', '_template', 'course_list', 0x436f75727365204c697374, '2005-03-23 15:17:14', 'enrollment manager');
INSERT INTO `AT_language_text` (`language_code`, `variable`, `term`, `text`, `revised_date`, `context`) VALUES
('en', '_template', 'course_polls_summary', 0x436f7572736520706f6c6c73206c6973746564206279207175657374696f6e2c206372656174696f6e206461746520616e6420766f746573, '2013-12-28 12:21:48', ''),
('en', '_template', 'course_properties', 0x436f757273652050726f70657274696573, '2003-05-18 14:00:23', 'course properties, admin course manager'),
('en', '_template', 'course_quota', 0x436f757273652051756f7461, '2003-05-18 14:01:10', 'course properties, admin course manager'),
('en', '_template', 'course_stats', 0x436f757273652053746174697374696373, '2003-05-18 14:01:59', 'delete course'),
('en', '_template', 'course_summaries', 0x436f757273652053756d6d6172696573, '2004-08-20 15:08:40', ''),
('en', '_template', 'course_title_instructor_enrolment', 0x436f75727365207469746c652c20696e7374727563746f722c20616e6420656e726f6c6c6d656e742e, '2013-12-28 12:12:23', 'table summary admin mobile courses tmpl'),
('en', '_template', 'course_title_instructor_enrolment_long', 0x4c697374206f6620636f7572736573206279207469746c652c20696e7374727563746f722c206163636573732c2063617465676f72792c206372656174696f6e20646174652c20656e726f6c6c6d656e742c20616e6420616c756d6e69, '2013-12-28 12:13:14', 'admin courses tmpl default template'),
('en', '_template', 'course_tools', 0x436f7572736520546f6f6c73, '2008-11-07 09:18:55', ''),
('en', '_template', 'course_total', 0x436f7572736520546f74616c, '2003-05-18 14:03:39', 'file manager, zip tool'),
('en', '_template', 'course_total_zip', 0x436f7572736520546f74616c20286265666f72652065787472616374696f6e29, '2003-05-18 14:04:10', 'file manager zip tool'),
('en', '_template', 'course_to_auto_enroll', 0x436f757273657320746f20456e726f6c6c, '2008-03-12 11:11:57', 'Auto Enroll label'),
('en', '_template', 'create', 0x437265617465, '2003-05-18 14:06:29', 'links database submit button'),
('en', '_template', 'created', 0x43726561746564, '2003-05-18 14:07:28', 'browse courses, control centre'),
('en', '_template', 'created_by', 0x43726561746564204279, '2009-05-27 12:01:11', ''),
('en', '_template', 'created_date', 0x43726561746564, '2003-05-18 14:09:05', 'admin course managers, profile editor'),
('en', '_template', 'create_admin', 0x4372656174652041646d696e6973747261746f72204163636f756e74, '2005-03-03 10:40:10', ''),
('en', '_template', 'create_backup', 0x437265617465204261636b7570, '2004-10-15 14:19:55', ''),
('en', '_template', 'create_backup_about', 0x3c703e4372656174696e672061206261636b7570206f66207468697320636f757273652077696c6c206172636869766520616c6c20617661696c61626c65206d6174657269616c20696e746f20612073696e676c6520636f6d70726573736564205a49502066696c652e204f6e636520746865206261636b75702066696c6520697320637265617465642c2069742077696c6c20626520617661696c61626c65207468726f75676820746865204261636b7570204d616e6167657220666f7220646f776e6c6f616420616e6420736166652d6b656570696e672c206f7220617661696c61626c6520746f20626520726573746f726564206261636b20696e746f2074686973206f7220616e79206f7468657220636f757273652e3c2f703e0d0a0d0a3c703e446570656e64696e67206f6e2074686520636f757273652073697a6520616e6420617661696c61626c6520736572766572207265736f75726365732c207468652074696d65206e656564656420746f206261636b7570207468697320636f75727365206d61792074616b652020736f6d652074696d652e3c2f703e0d0a09090d0a3c703e4e6f74653a20596f75206172652063757272656e746c79207265737472696374656420746f202573206261636b7570732070657220636f757273652e3c2f703e, '2005-05-30 15:04:45', ''),
('en', '_template', 'create_basic', 0x43726561746520626173696320616e6e6f756e63656d656e742c20636f6e74656e742c20616e6420666f72756d2e, '2004-10-20 14:28:44', ''),
('en', '_template', 'create_category', 0x4372656174652043617465676f7279, '2005-02-18 10:28:39', ''),
('en', '_template', 'create_course', 0x43726561746520436f75727365, '2005-02-15 13:16:16', 'instructor control centre'),
('en', '_template', 'create_folder', 0x43726561746520466f6c646572, '2003-05-18 14:12:40', 'file manager'),
('en', '_template', 'create_folder_here', 0x546f20637265617465206120666f6c6465722c20656e746572206e616d6520686572653a, '2009-11-05 14:42:23', ''),
('en', '_template', 'create_forum', 0x43726561746520466f72756d, '2005-02-16 12:23:16', ''),
('en', '_template', 'create_group', 0x4372656174652047726f7570, '2005-02-22 16:51:56', ''),
('en', '_template', 'create_groups', 0x4372656174652047726f757073, '2006-03-21 14:57:08', ''),
('en', '_template', 'create_group_blurb', 0x4372656174652061206e65772067726f7570206f6e206120706172746963756c617220746f7069632c207468656e20696e766974652070656f706c6520746f20706f7374206e657773206974656d73206f7220646973637573732074686520746f7069632e20, '2009-05-27 12:01:11', ''),
('en', '_template', 'create_module', 0x437265617465204d6f64756c65, '2005-08-17 13:06:07', ''),
('en', '_template', 'create_new_file', 0x437265617465204e65772046696c65, '2005-02-22 15:33:12', ''),
('en', '_template', 'create_new_question', 0x437265617465204e6577205175657374696f6e, '2005-03-07 16:42:11', ''),
('en', '_template', 'create_patch', 0x437265617465205061746368, '2008-04-21 15:11:31', ''),
('en', '_template', 'create_test', 0x43726561746520546573742f537572766579, '2004-11-24 10:00:42', 'instructor test manager'),
('en', '_template', 'create_user', 0x4372656174652055736572204163636f756e74, '2005-03-10 15:12:12', ''),
('en', '_template', 'creation_date', 0x4372656174696f6e2044617465, '2009-06-17 13:32:26', 'admin/users.php'),
('en', '_template', 'creative_commons', 0x437265617469766520436f6d6d6f6e73, '2010-07-20 14:56:49', ''),
('en', '_template', 'credits_and_work_experience', 0x4372656469747320616e6420576f726b20457870657269656e6365, '2009-05-27 12:01:11', ''),
('en', '_template', 'cron', 0x43726f6e, '2006-03-31 15:42:46', ''),
('en', '_template', 'cron_config', 0x43726f6e205365742d7570, '2006-04-03 14:22:14', ''),
('en', '_template', 'cron_url', 0x5468652055524c20746f20796f75722063726f6e20736572766963652069733a, '2006-06-14 12:47:32', ''),
('en', '_template', 'cron_url_usage', 0x5468652055524c2062656c6f77206d7573742062652075736564207768656e2073657474696e672d7570207468652063726f6e20736572766963652e2053656520746865203c656d3e43726f6e205365742d55703c2f656d3e2073656374696f6e20696e20746865203c656d3e415475746f722048616e64626f6f6b3c2f656d3e20666f7220696e737472756374696f6e732e, '2006-06-14 12:49:11', ''),
('en', '_template', 'current_course_size', 0x43757272656e7420636f757273652073697a65, '2003-10-07 15:41:36', 'admin course info'),
('en', '_template', 'current_location', 0x2843757272656e74206c6f636174696f6e29, '2004-01-16 13:22:03', 'content editor'),
('en', '_template', 'current_path', 0x5061746820746f2043757272656e74204469726563746f72793a, '2003-05-18 14:13:52', 'file manager'),
('en', '_template', 'curren_tests_surveys', 0x4f6e676f696e6720546573747320262053757276657973, '2005-01-03 09:57:07', ''),
('en', '_template', 'cursive', 0x43757273697665, '2008-09-09 09:01:13', ''),
('en', '_template', 'custom', 0x437573746f6d, '2008-09-25 15:59:56', 'gradebook'),
('en', '_template', 'customized_head', 0x536372697074732f435353, '2010-05-03 10:42:26', ''),
('en', '_template', 'customized_head_disabled_title', 0x536372697074732f4353532064697361626c6564, '2010-05-03 10:42:37', ''),
('en', '_template', 'customized_head_enabled_title', 0x546f67676c6520536372697074732f435353, '2010-05-03 10:42:50', ''),
('en', '_template', 'customized_head_note', 0x4564697420796f7572206f776e207374796c6573206f72206a617661736372697074, '2008-05-01 08:57:49', ''),
('en', '_template', 'custom_duration', 0x437573746f6d204475726174696f6e, '2014-08-20 15:59:56', 'Test/Survey custom duration property'),
('en', '_template', 'custom_grade_scale', 0x437573746f6d204772616465205363616c65, '2008-09-25 15:59:56', 'gradebook'),
('en', '_template', 'custom_icons', 0x437573746f6d2049636f6e73, '2008-08-21 10:38:11', 'course properties'),
('en', '_template', 'custom_logo', 0x437573746f6d204c6f676f, '2014-01-27 10:38:11', 'admin custom logo'),
('en', '_template', 'custom_logo_alt_text', 0x416c7465726e61746976652054657874, '2014-02-11 10:38:11', 'admin custom logo alt text'),
('en', '_template', 'custom_logo_enabled', 0x437573746f6d204c6f676f205374617465, '2014-02-11 10:38:11', 'admin custom logo state'),
('en', '_template', 'custom_logo_instructions', 0x5265706c6163652074686520415475746f72206c6f676f20696e2074686520666f6f7465722061726561207769746820796f7572206f776e20637573746f6d206c6f676f2e205468652064696d656e73696f6e73206f6620746865206c6f676f2073686f756c64206265203135332062792034362c20616e642073686f756c64206265206120706e672c206a70672c206f722067696620696d6167652066696c652e, '2014-02-10 10:38:11', 'admin custom logo instructions'),
('en', '_template', 'custom_logo_url', 0x55524c, '2014-02-11 10:38:11', 'admin custom logo url'),
('en', '_template', 'custom_test_message', 0x496e636c7564652061206d65737361676520746f2061707065617220616c6f6e67207769746820746865206c696e6b20746f2074686520746573742e, '2008-10-10 15:30:19', ''),
('en', '_template', 'cyan', 0x4379616e, '2008-09-09 09:01:13', ''),
('en', '_template', 'd', 0x44, '2007-01-10 13:48:05', ''),
('en', '_template', 'danish-dsl', 0x44616e6973682d44534c, '2008-09-09 09:01:12', ''),
('en', '_template', 'dark_gray', 0x4461726b2047726179, '2008-09-09 09:01:13', ''),
('en', '_template', 'database', 0x4461746162617365, '2007-07-26 13:39:36', ''),
('en', '_template', 'database_table', 0x4461746162617365205461626c65, '2005-03-03 12:14:20', ''),
('en', '_template', 'date', 0x44617465, '2003-05-19 17:44:42', 'global date label'),
('en', '_template', 'date_apr', 0x417072, '2003-05-20 12:32:27', 'date'),
('en', '_template', 'date_april', 0x417072696c, '2003-05-20 12:28:03', 'date'),
('en', '_template', 'date_aug', 0x417567, '2003-05-20 12:33:34', 'date'),
('en', '_template', 'date_august', 0x417567757374, '2003-05-20 12:29:12', 'date'),
('en', '_template', 'date_created', 0x446174652043726561746564, '2003-05-19 17:45:18', 'view profile'),
('en', '_template', 'date_dec', 0x446563, '2003-05-20 12:34:03', 'date'),
('en', '_template', 'date_december', 0x446563656d626572, '2003-05-20 12:30:35', 'date'),
('en', '_template', 'date_feb', 0x466562, '2003-05-20 12:32:12', 'date'),
('en', '_template', 'date_february', 0x4665627275617279, '2003-05-20 12:27:33', 'date'),
('en', '_template', 'date_fri', 0x467269, '2003-05-20 12:26:47', 'date'),
('en', '_template', 'date_friday', 0x467269646179, '2003-05-20 12:24:40', 'date'),
('en', '_template', 'date_jan', 0x4a616e, '2003-05-20 12:32:05', 'date'),
('en', '_template', 'date_january', 0x4a616e75617279, '2003-05-20 12:27:11', 'date'),
('en', '_template', 'date_jul', 0x4a756c, '2003-05-20 12:33:27', 'date'),
('en', '_template', 'date_july', 0x4a756c79, '2003-05-20 12:28:56', 'date'),
('en', '_template', 'date_jun', 0x4a756e, '2003-05-20 12:33:21', 'date'),
('en', '_template', 'date_june', 0x4a756e65, '2003-05-20 12:28:41', 'date'),
('en', '_template', 'date_mar', 0x4d6172, '2003-05-20 12:32:22', 'date'),
('en', '_template', 'date_march', 0x4d61726368, '2003-05-20 12:27:48', 'date'),
('en', '_template', 'date_may', 0x4d6179, '2003-05-20 12:28:20', 'date'),
('en', '_template', 'date_may_short', 0x4d6179, '2003-05-20 12:33:14', 'date'),
('en', '_template', 'date_mon', 0x4d6f6e, '2003-05-20 12:26:18', 'date'),
('en', '_template', 'date_monday', 0x4d6f6e646179, '2003-05-20 12:24:00', 'date'),
('en', '_template', 'date_nov', 0x4e6f76, '2003-05-20 12:33:56', 'date'),
('en', '_template', 'date_november', 0x4e6f76656d626572, '2003-05-20 12:30:20', 'date'),
('en', '_template', 'date_oct', 0x4f6374, '2003-05-20 12:33:49', 'date'),
('en', '_template', 'date_october', 0x4f63746f626572, '2003-05-20 12:30:02', 'date'),
('en', '_template', 'date_of_birth', 0x44617465206f66206269727468, '2004-06-24 12:31:02', ''),
('en', '_template', 'date_sat', 0x536174, '2003-05-20 12:26:55', 'date'),
('en', '_template', 'date_saturday', 0x5361747572646179, '2003-05-20 12:24:48', 'date'),
('en', '_template', 'date_sep', 0x536570, '2003-05-20 12:33:42', 'date'),
('en', '_template', 'date_september', 0x53657074656d626572, '2003-05-20 12:29:44', 'date'),
('en', '_template', 'date_sun', 0x53756e, '2003-05-20 12:26:09', 'date'),
('en', '_template', 'date_sunday', 0x53756e646179, '2003-05-20 12:23:52', 'date'),
('en', '_template', 'date_taken', 0x446174652054616b656e, '2003-05-19 17:46:06', 'My Tests'),
('en', '_template', 'date_thu', 0x546875, '2003-05-20 12:26:40', 'date'),
('en', '_template', 'date_thursday', 0x5468757273646179, '2003-05-20 12:24:32', 'date'),
('en', '_template', 'date_tue', 0x547565, '2003-05-20 12:26:24', 'date'),
('en', '_template', 'date_tuesday', 0x54756573646179, '2003-05-20 12:24:12', 'date'),
('en', '_template', 'date_wed', 0x576564, '2003-05-20 12:26:32', 'date'),
('en', '_template', 'date_wednesday', 0x5765646e6573646179, '2003-05-20 12:24:21', 'date'),
('en', '_template', 'day', 0x446179, '2004-06-24 15:45:56', ''),
('en', '_template', 'days', 0x64617973, '2007-02-21 14:04:48', ''),
('en', '_template', 'default', 0x44656661756c74, '2003-05-19 17:47:07', 'edit header/admin course manager'),
('en', '_template', 'default_announcement', 0x5468697320697320612077656c636f6d6520616e6e6f756e63656d656e742e20596f752063616e20616363657373206164646974696f6e616c2068656c70206279207573696e67207468652048656c70206c696e6b20617661696c61626c65207468726f7567686f757420415475746f722e, '2005-05-11 14:52:19', ''),
('en', '_template', 'default_description', 0x44656661756c74204465736372697074696f6e, '2006-03-22 11:47:28', ''),
('en', '_template', 'default_language', 0x44656661756c74204c616e6775616765, '2005-03-03 10:50:22', ''),
('en', '_template', 'default_modules', 0x44656661756c7420546f6f6c73, '2010-05-03 14:56:46', ''),
('en', '_template', 'default_preferences', 0x44656661756c7420507265666572656e636573, '2005-10-05 12:19:22', ''),
('en', '_template', 'default_side_menu', 0x44656661756c74204d656e75, '2010-05-03 14:56:55', ''),
('en', '_template', 'define_pretest', 0x5072657265717569736974652054657374732e, '2009-11-13 15:43:11', 'create/edit folder'),
('en', '_template', 'define_resource_type', 0x446566696e65207265736f757263652074797065, '2008-09-08 14:18:36', ''),
('en', '_template', 'degree', 0x4465677265652f50726f6772616d2f436f7572736573, '2009-05-27 12:01:11', ''),
('en', '_template', 'degrees', 0x44656772656573, '2009-05-27 12:01:11', ''),
('en', '_template', 'delete', 0x44656c657465, '2003-05-19 18:25:41', 'global delete label'),
('en', '_template', 'deleted', 0x44656c65746564, '2003-05-19 18:26:45', 'links database'),
('en', '_template', 'delete_admin', 0x44656c6574652041646d696e6973747261746f72204163636f756e74, '2005-03-03 10:48:32', ''),
('en', '_template', 'delete_announcement', 0x44656c65746520416e6e6f756e63656d656e74, '2003-05-19 18:27:52', 'delete news screen'),
('en', '_template', 'delete_applications', 0x44656c657465206170706c69636174696f6e73, '2009-05-27 12:01:11', ''),
('en', '_template', 'delete_category', 0x44656c6574652043617465676f7279, '2003-05-19 18:28:24', 'links database'),
('en', '_template', 'delete_content', 0x44656c65746520436f6e74656e74, '2003-05-19 18:29:01', 'delete content screen'),
('en', '_template', 'delete_course', 0x44656c65746520436f75727365, '2003-05-19 18:29:37', 'delete course screen'),
('en', '_template', 'delete_forum', 0x44656c65746520466f72756d, '2003-05-19 18:30:40', 'instructor delete forum screen'),
('en', '_template', 'delete_from', 0x44656c6574652046726f6d, '2005-03-03 12:16:04', ''),
('en', '_template', 'delete_glossary', 0x44656c65746520476c6f7373617279205465726d, '2005-03-07 11:33:35', ''),
('en', '_template', 'delete_grade_scale', 0x44656c657465204772616465205363616c65, '2008-09-25 15:59:56', 'gradebook'),
('en', '_template', 'delete_group', 0x44656c6574652047726f7570, '2005-01-15 16:01:10', ''),
('en', '_template', 'delete_language', 0x44656c657465204c616e6775616765, '2003-06-05 18:59:51', 'admin language manager'),
('en', '_template', 'delete_link', 0x44656c657465204c696e6b, '2005-03-29 14:09:36', 'links manager'),
('en', '_template', 'delete_module_data', 0x416c736f2064656c657465206d6f64756c652064617461, '2008-10-21 15:41:53', ''),
('en', '_template', 'delete_package', 0x44656c657465205061636b616765, '2005-05-17 12:06:21', ''),
('en', '_template', 'delete_patch', 0x44656c657465205061746368, '2008-04-21 15:11:31', ''),
('en', '_template', 'delete_poll', 0x44656c65746520506f6c6c, '2004-06-14 16:16:15', ''),
('en', '_template', 'delete_post', 0x44656c65746520506f7374, '2006-06-14 11:53:29', ''),
('en', '_template', 'delete_profile', 0x44656c6574652050726f66696c65, '2004-12-06 11:53:06', 'admin/error_logging.php'),
('en', '_template', 'delete_results', 0x44656c657465205465737420526573756c7473, '2003-05-19 18:31:51', 'test manager'),
('en', '_template', 'delete_selected_package_s', 0x44656c6574652073656c6563746564207061636b61676573, '2005-07-19 09:54:28', ''),
('en', '_template', 'delete_test', 0x44656c65746520546573742f537572766579, '2004-08-25 14:09:40', ''),
('en', '_template', 'delete_text', 0x4e6f74653a202244656c6574652220627574746f6e206973206f6e6c7920617661696c61626c65206265666f7265207468652061737369676e6d656e742064756520646174652e, '2011-05-30 10:07:41', ''),
('en', '_template', 'delete_this_file', 0x44656c65746520546869732046696c65, '2008-04-21 15:11:31', ''),
('en', '_template', 'delete_this_folder', 0x44656c657465205468697320466f6c646572, '2009-11-25 10:53:28', 'Content'),
('en', '_template', 'delete_this_page', 0x44656c65746520546869732050616765, '2005-03-31 14:18:22', 'content page shortcuts'),
('en', '_template', 'delete_thread', 0x44656c65746520546f706963, '2014-01-02 15:40:03', 'forums'),
('en', '_template', 'delete_user', 0x44656c6574652055736572, '2003-05-19 18:35:55', 'admin user manager'),
('en', '_template', 'deny', 0x44656e79, '2005-03-30 15:26:27', ''),
('en', '_template', 'deny_instructor_request', 0x44656e7920496e7374727563746f722052657175657374, '2005-07-21 16:17:35', ''),
('en', '_template', 'dependent_patches', 0x446570656e64656e742050617463686573, '2008-04-21 15:11:31', ''),
('en', '_template', 'dependent_patch_id', 0x446570656e64656e74205061746368204944, '2008-04-21 15:11:31', ''),
('en', '_template', 'depth_reached', 0x4469726563746f7279206465707468206c696d697420686173206265656e20726561636865642e, '2003-05-19 18:36:54', 'file manager'),
('en', '_template', 'description', 0x4465736372697074696f6e, '2003-05-19 18:37:34', 'global description label'),
('en', '_template', 'desktop_theme', 0x4465736b746f70205468656d65, '2010-06-18 15:46:31', ''),
('en', '_template', 'detailed_on', 0x64657461696c65642076696577207475726e6564206f6e, '2014-01-01 15:19:45', 'icon/detailed view switch'),
('en', '_template', 'detailed_profile', 0x44657461696c65642050726f66696c65, '2009-05-27 12:01:11', ''),
('en', '_template', 'details', 0x44657461696c73, '2003-05-19 18:38:03', 'instructor taught course table of the control panel'),
('en', '_template', 'detail_view', 0x44657461696c2056696577, '2009-06-30 16:13:37', ''),
('en', '_template', 'dictionary', 0x44696374696f6e617279, '2008-09-09 09:03:56', ''),
('en', '_template', 'direction', 0x446972656374696f6e, '2004-11-20 19:36:34', ''),
('en', '_template', 'directory', 0x4469726563746f7279, '2005-03-09 15:28:11', ''),
('en', '_template', 'directory_name', 0x4469726563746f7279204e616d65, '2003-05-19 18:38:42', 'file manager zip utility'),
('en', '_template', 'directory_total', 0x4469726563746f727920546f74616c, '2003-05-19 18:39:15', 'file manager'),
('en', '_template', 'disable', 0x44697361626c65, '2004-10-15 15:46:20', 'to disable a theme in theme manager'),
('en', '_template', 'disabled', 0x44697361626c6564, '2005-04-01 10:39:58', ''),
('en', '_template', 'disable_syndicate', 0x44697361626c6520416e6e6f756e63656d656e74732073796e6469636174696f6e, '2005-01-04 09:48:31', ''),
('en', '_template', 'disband_group', 0x44697362616e642047726f7570, '2009-05-27 12:01:11', ''),
('en', '_template', 'discussions', 0x44697363757373696f6e73, '2003-05-19 18:43:39', 'global text for discussions label'),
('en', '_template', 'disk_usage', 0x4469736b205573616765, '2007-07-26 17:02:11', ''),
('en', '_template', 'display', 0x446973706c6179, '2004-08-18 12:03:48', ''),
('en', '_template', 'display_name_format', 0x446973706c6179204e616d6520466f726d6174, '2006-09-07 10:21:44', ''),
('en', '_template', 'display_name_formAT_fl', 0x2532247320282531247329, '2006-08-21 15:29:17', ''),
('en', '_template', 'display_name_formAT_fst', 0x2532247320253324732025342473, '2006-08-21 15:27:41', ''),
('en', '_template', 'display_name_formAT_fstl', 0x253224732025332473202534247320282531247329, '2006-08-21 15:28:21', ''),
('en', '_template', 'display_name_formAT_l', 0x2573, '2006-08-21 15:25:55', ''),
('en', '_template', 'display_name_formAT_lf', 0x2531247320282532247329, '2006-08-21 15:29:46', ''),
('en', '_template', 'display_name_formAT_lfst', 0x253124732028253224732025332473202534247329, '2006-08-21 15:30:22', ''),
('en', '_template', 'display_settings', 0x546578742053657474696e6773, '2010-04-12 16:32:09', ''),
('en', '_template', 'dob', 0x44617465206f66204269727468, '2009-05-27 12:01:11', ''),
('en', '_template', 'donate', 0x446f6e617465, '2008-09-12 10:51:45', 'admin home'),
('en', '_template', 'donate_text', 0x546865203c6120687265663d22687474703a2f2f696472632e6f6361642e6361223e494452433c2f613e2069732061206e6f742d666f722d70726f666974206f7267616e697a6174696f6e20746861742072656c696573206f6e20636f6d6d756e69747920737570706f727420746f206d61696e7461696e20415475746f722c20616e64206b65657020697420667265652e20496620796f75206861766520666f756e6420415475746f722075736566756c2c20706c6561736520636f6e7369646572206d616b696e67206120646f6e6174696f6e2e, '2011-02-09 13:06:37', 'admin home'),
('en', '_template', 'done', 0x446f6e65, '2003-05-19 18:44:34', 'enrolment manager'),
('en', '_template', 'download', 0x446f776e6c6f6164, '2004-04-30 15:35:13', ''),
('en', '_template', 'download_content_package', 0x446f776e6c6f616420636f6e74656e74207061636b6167653a, '2010-06-10 11:28:18', ''),
('en', '_template', 'download_file', 0x446f776e6c6f61642046696c65, '2005-01-10 15:40:00', ''),
('en', '_template', 'download_test_csv', 0x446f776e6c6f616420435356206f6620526573756c7473, '2005-05-30 14:32:27', ''),
('en', '_template', 'drag', 0x44726167, '2008-05-22 09:15:04', 'alt text for fluid theme drag icon'),
('en', '_template', 'due', 0x447565, '2006-03-20 14:38:46', ''),
('en', '_template', 'due_date', 0x4475652044617465, '2006-03-23 11:36:41', ''),
('en', '_template', 'duplicate', 0x4475706c6963617465, '2014-08-20 11:36:41', 'Test/Survey Index'),
('en', '_template', 'duplicate_custom_duration', 0x4475706c696361746520637573746f6d206475726174696f6e, '2014-08-20 11:36:41', 'Test/Survey'),
('en', '_template', 'duration', 0x546f74616c204475726174696f6e, '2005-03-01 12:40:00', 'tracker'),
('en', '_template', 'duration_sec', 0x4475726174696f6e202873656329, '2003-05-19 18:45:37', 'tracker'),
('en', '_template', 'e', 0x45, '2007-01-10 13:48:09', ''),
('en', '_template', 'edit', 0x45646974, '2004-05-26 18:31:10', ''),
('en', '_template', 'editor', 0x456469746f72, '2003-10-22 15:01:19', ''),
('en', '_template', 'editor_properties_instructions', 0x53656c6563742074686520726164696f20627574746f6e206f662074686520636f6e74656e7420796f752077616e7420746f206d6f76652e2055736520746865202531247320616e64202532247320627574746f6e7320746f20706c616365207468697320746f706963206166746572206f72206265666f7265207468652073656c6563746564206c6f636174696f6e2c20726573706563746976656c792e2055736520746865202533247320627574746f6e20746f20616464207468697320746f7069632061732061206368696c64206f66207468652073656c6563746564206c6f636174696f6e2e, '2009-09-16 13:13:40', ''),
('en', '_template', 'editor_properties_insturctions_related', 0x4164642052656c6174656420546f706963732062792073656c656374696e672074686520746f7069632066726f6d20746865206c6973742e, '2004-02-11 12:33:28', 'editor properties instructions'),
('en', '_template', 'edit_admin', 0x456469742041646d696e6973747261746f72204163636f756e74, '2005-03-03 11:06:16', ''),
('en', '_template', 'edit_announcement', 0x4564697420416e6e6f756e63656d656e74, '2003-05-19 18:47:32', 'instructor announcement editor'),
('en', '_template', 'edit_backup', 0x45646974202d202573, '2004-10-19 12:46:00', ''),
('en', '_template', 'edit_category', 0x456469742043617465676f7279, '2003-05-19 18:49:44', 'links database'),
('en', '_template', 'edit_contact', 0x4564697420416c7465726e61746520436f6e74616374, '2009-12-03 15:38:52', ''),
('en', '_template', 'edit_content', 0x4564697420436f6e74656e74, '2003-05-19 18:50:07', 'instructor content editor'),
('en', '_template', 'edit_content_folder', 0x4564697420436f6e74656e7420466f6c646572, '2009-11-25 11:36:02', 'Content'),
('en', '_template', 'edit_education', 0x4564697420456475636174696f6e, '2009-05-27 12:01:11', ''),
('en', '_template', 'edit_forum', 0x4564697420466f72756d, '2003-05-19 18:50:54', 'instructor forum editor'),
('en', '_template', 'edit_for_minutes', 0x666f7220616e6f74686572202573206d696e75746573, '2007-02-23 11:53:28', ''),
('en', '_template', 'edit_glossary', 0x4564697420476c6f7373617279205465726d, '2003-05-19 18:54:15', 'instructor edit glossary term screen'),
('en', '_template', 'edit_grade_scale', 0x45646974204772616465205363616c65, '2008-09-25 15:59:56', 'gradebook'),
('en', '_template', 'edit_group', 0x456469742047726f7570, '2009-05-27 12:01:11', ''),
('en', '_template', 'edit_language', 0x45646974204c616e6775616765, '2005-01-21 18:24:19', ''),
('en', '_template', 'edit_link', 0x45646974204c696e6b, '2003-05-19 18:54:44', 'links database'),
('en', '_template', 'edit_marks', 0x45646974204d61726b73, '2008-09-25 16:01:17', 'gradebook'),
('en', '_template', 'edit_patch', 0x45646974205061746368, '2008-04-21 15:11:31', ''),
('en', '_template', 'edit_personal', 0x4564697420506572736f6e616c20496e666f726d6174696f6e, '2009-12-07 13:43:15', ''),
('en', '_template', 'edit_poll', 0x4564697420506f6c6c, '2004-06-14 14:53:54', ''),
('en', '_template', 'edit_position', 0x4564697420506f736974696f6e, '2009-05-28 14:21:31', ''),
('en', '_template', 'edit_post', 0x4564697420506f7374, '2003-09-25 12:54:59', 'instructor edit forum post'),
('en', '_template', 'edit_profile', 0x456469742050726f66696c65, '2009-05-27 12:01:11', ''),
('en', '_template', 'edit_question', 0x45646974205175657374696f6e, '2004-12-14 17:58:58', ''),
('en', '_template', 'edit_representation', 0x4564697420526570726573656e746174697665, '2009-12-03 15:42:24', 'social profile'),
('en', '_template', 'edit_test', 0x4564697420546573742f537572766579, '2004-08-25 14:08:30', ''),
('en', '_template', 'edit_tests', 0x456469742054657374732f41737369676e6d656e7473, '2008-09-25 16:01:17', 'gradebook'),
('en', '_template', 'edit_this_page', 0x4564697420546869732050616765, '2005-03-31 14:16:42', 'content page shortcuts'),
('en', '_template', 'edit_user', 0x45646974204d656d626572, '2004-03-29 11:49:10', ''),
('en', '_template', 'edit_websites', 0x45646974205765627369746573, '2009-05-28 14:21:57', ''),
('en', '_template', 'education', 0x456475636174696f6e, '2009-05-27 12:01:11', ''),
('en', '_template', 'email', 0x456d61696c, '2003-05-19 19:07:59', 'global email label'),
('en', '_template', 'email_address', 0x456d61696c2041646472657373, '2003-05-19 19:09:06', 'profile, password reminder'),
('en', '_template', 'email_again', 0x456d61696c204164647265737320416761696e, '2009-06-03 15:33:17', ''),
('en', '_template', 'email_approvals', 0x456d61696c206d65207768656e206e657720656e726f6c6c6d656e7473207265717569726520617070726f76616c2e, '2004-01-22 14:57:19', ''),
('en', '_template', 'email_confirmation_message', 0x596f752068617665207265676973746572656420666f7220616e206163636f756e74206f6e202531732e20506c656173652066696e6973682074686520726567697374726174696f6e2070726f6365737320627920636f6e6669726d696e6720796f757220656d61696c2061646472657373206279207573696e672074686520666f6c6c6f77696e67206c696e6b3a20253273202e, '2005-06-24 15:32:49', ''),
('en', '_template', 'email_confirmation_message2', 0x546f2066696e697368206368616e67696e6720796f7572206163636f756e74277320656d61696c2061646472657373206f6e202531732c20706c6561736520636f6e6669726d20796f757220656d61696c2061646472657373206279207573696e672074686520666f6c6c6f77696e67206c696e6b3a20253273202e, '2006-05-11 16:08:25', ''),
('en', '_template', 'email_confirmation_subject', 0x456d61696c20436f6e6669726d6174696f6e, '2005-03-22 11:35:30', ''),
('en', '_template', 'email_enrollment_message', 0x416e20656e726f6c6d656e74207265717565737420686173206265656e206d61646520696e2074686520636f757273652025732e, '2010-01-07 13:06:23', ''),
('en', '_template', 'email_enrollment_subject', 0x436f7572736520456e726f6c6d656e74, '2010-01-07 13:06:34', ''),
('en', '_template', 'emoticons', 0x456d6f7469636f6e73, '2003-05-22 15:43:20', 'code picker'),
('en', '_template', 'empty', 0x656d707479, '2003-05-19 19:10:56', 'prefs page, menu options'),
('en', '_template', 'empty_gradebook', 0x4772616465626f6f6b20697320656d7074792e, '2008-09-25 16:01:17', 'gradebook'),
('en', '_template', 'empty_url', 0x506c656173652070726f7669646520612072656d6f74652055524c2e, '2010-06-18 13:28:57', ''),
('en', '_template', 'enable', 0x456e61626c65, '2004-10-15 15:52:29', 'enable button in theme'),
('en', '_template', 'enabled', 0x456e61626c6564, '2005-05-06 12:49:07', 'theme'),
('en', '_template', 'enable_mail_queue', 0x456e61626c65204d61696c205175657565, '2006-04-03 14:21:43', ''),
('en', '_template', 'enable_sco_rte', 0x456e61626c65207468652053434f524d20312e3220525445, '2005-05-10 10:52:42', ''),
('en', '_template', 'enable_syndicate', 0x456e61626c6520416e6e6f756e63656d656e74732073796e6469636174696f6e20766961203c6163726f6e796d207469746c653d225269636820536974652053756d6d617279223e5253533c2f6163726f6e796d3e, '2005-01-04 10:27:41', ''),
('en', '_template', 'enable_uploader', 0x456e61626c65206d756c74692d66696c652075706c6f6164657220746f6f6c, '2008-07-24 16:19:54', 'Used for toggling between Fluid''s Uploader and the basic uploader'),
('en', '_template', 'encyclopedia', 0x456e6379636c6f7065646961, '2008-09-10 12:25:52', 'tool prefs'),
('en', '_template', 'end_date', 0x456e642044617465, '2003-05-19 19:13:46', 'mytests'),
('en', '_template', 'end_on', 0x456e64206f6e, '2007-07-16 14:26:34', ''),
('en', '_template', 'enroll', 0x456e726f6c6c, '2003-05-19 19:16:50', 'link text for enroll function'),
('en', '_template', 'enrolled', 0x456e726f6c6c6564, '2003-05-19 19:18:28', 'control centre, delete course, admin course manager, text label'),
('en', '_template', 'enrolled_list_includes_assistants', 0x456e726f6c6c65642053747564656e74732028696e636c7564657320417373697374616e747329, '2004-10-15 11:56:23', 'enrolled students list in list exporter in enrollement manager'),
('en', '_template', 'enrolled_privileges', 0x456e726f6c6c656420576974682050726976696c65676573, '2005-06-10 10:58:01', ''),
('en', '_template', 'enrollment', 0x456e726f6c6c6d656e74, '2005-12-07 11:19:38', ''),
('en', '_template', 'enroll_me', 0x456e726f6c6c204d65, '2005-04-14 13:15:58', ''),
('en', '_template', 'enroll_to_post', 0x596f75206d75737420626520656e726f6c6c656420746f20706f737420746f2074686520666f72756d732e, '2004-12-09 11:07:43', ''),
('en', '_template', 'enrolment', 0x456e726f6c6c6d656e74, '2006-10-18 11:47:33', ''),
('en', '_template', 'enrol_login', 0x596f75206d757374206c6f67696e20746f20796f757220636f7572736520746f20617070726f766520746865206e657720656e726f6c6c6d656e742072657175657374207573696e672074686520456e726f6c6c6d656e742073656374696f6e2e, '2005-07-05 12:15:39', 'instructor enrolment screen'),
('en', '_template', 'enrol_message3', 0x415475746f7220436f7572736520456e726f6c6c6d656e74, '2003-04-21 15:03:49', 'context'),
('en', '_template', 'enrol_messagenew', 0x416e20656e726f6c6c6d656e74207265717565737420776173206d61646520666f722074686520415475746f7220636f757273652025732e204c6f6720696e746f20796f757220636f75727365206174202573202c20676f20746f204d616e61676520616e64207468656e20746f2074686520756e656e726f6c6c65642074616220696e2074686520456e726f6c6c6d656e74204d616e616765722e, '2005-03-29 12:23:47', 'instructor enrolment email notice'),
('en', '_template', 'enrol_message_approved', 0x596f757220656e726f6c6c6d656e74207265717565737420666f722074686520636f757273652025317320686173206265656e20617070726f7665642e0d0a4c6f6720696e746f20415475746f722c207468656e2073656c6563742074686520636f757273652066726f6d204d7920436f7572736573206f722075736520746865206c6f67696e206c696e6b2062656c6f773a0d0a0d0a253273, '2005-03-30 11:49:50', 'email message sent to enrollee once approved'),
('en', '_template', 'enrol_message_subject', 0x436f7572736520656e726f6c6c6d656e7420617070726f766564, '2003-05-20 11:18:15', 'enroll email approval'),
('en', '_template', 'enrol_msg', 0x41206e657720656e726f6c6c6d656e74207265717565737420686173206265656e206d61646520666f7220796f757220636f757273652025732e, '2005-07-05 12:15:49', 'instructor email enrollment notification message'),
('en', '_template', 'entertainment_arts', 0x4172747320616e6420456e7465727461696e6d656e74, '2009-05-27 12:01:11', ''),
('en', '_template', 'enter_chat', 0x456e746572207468652043686174, '2003-05-27 14:20:24', 'achat entry page'),
('en', '_template', 'enter_course', 0x456e74657220436f75727365, '2005-03-14 15:15:57', ''),
('en', '_template', 'enter_edit_mode', 0x456e7465722045646974204d6f6465, '2009-09-16 13:12:12', ''),
('en', '_template', 'enter_search_terms', 0x456e74657220736561726368207465726d73, '2014-01-01 13:13:36', ''),
('en', '_template', 'entire_course', 0x456e7469726520436f75727365, '2006-07-24 10:44:01', ''),
('en', '_template', 'error', 0x4572726f72, '2003-05-19 20:20:07', 'global error label'),
('en', '_template', 'error_logging', 0x4572726f72204c6f6767696e67, '2005-02-07 16:11:55', ''),
('en', '_template', 'everyone', 0x45766572796f6e65, '2004-12-07 17:54:16', ''),
('en', '_template', 'existing_type', 0x4578697374696e6720547970653a, '2006-03-22 15:11:15', ''),
('en', '_template', 'exit_edit_mode', 0x457869742045646974204d6f6465, '2009-09-16 13:12:24', ''),
('en', '_template', 'expand', 0x457870616e64, '2003-05-19 20:20:35', 'menu toggle alt text'),
('en', '_template', 'experimental', 0x4578706572696d656e74616c, '2008-12-02 11:58:25', ''),
('en', '_template', 'expertise', 0x457870657274697365, '2009-05-27 12:01:11', ''),
('en', '_template', 'expired', 0x45787069726564, '2003-05-19 20:21:08', 'mytests'),
('en', '_template', 'expire_never', 0x4e6576657220657870697265, '2007-02-13 15:38:14', ''),
('en', '_template', 'expire_on', 0x457870697265206f6e, '2007-02-13 15:38:24', ''),
('en', '_template', 'expiry_date', 0x4578706972792044617465, '2007-02-13 15:37:50', ''),
('en', '_template', 'export', 0x4578706f7274, '2003-05-19 20:21:32', 'instructor control centre'),
('en', '_template', 'export_content', 0x4578706f727420436f6e74656e74, '2003-10-03 11:00:51', ''),
('en', '_template', 'export_content_info', 0x4578706f727420636f6e74656e7420617320616e203c7374726f6e673e494d53206f722053434f524d20636f6e666f726d616e7420636f6e74656e74207061636b6167653c2f7374726f6e673e2c206f7220617320616e203c7374726f6e673e494d5320436f6d6d6f6e204361727472696467653c2f7374726f6e673e2e20496d706f727420746865207a6970706564207061636b616765206f722063617274726964676520696e746f20616e6f7468657220415475746f722073797374656d206f7220616e6f7468657220636f757273652c206f7220696e746f20616e6f7468657220636f6e666f726d616e74204c4d53206f72204c434d532e, '2009-11-12 16:52:35', ''),
('en', '_template', 'export_content_package_what', 0x5768617420746f206578706f7274, '2003-10-14 11:11:11', ''),
('en', '_template', 'export_content_text', 0x446f776e6c6f616420636f6e74656e742c20756e7a6970206974206f6e746f20796f757220636f6d70757465722c207468656e20636c69636b2022696e6465782e68746d6c2220746f20766965772e, '2009-07-02 14:15:47', ''),
('en', '_template', 'export_entire_course_or_chap', 0x456e7469726520636f757273652c206f722073656c656374206120636861707465722062656c6f77, '2003-10-07 15:14:52', ''),
('en', '_template', 'export_marks_info', 0x546f2073696d706c6966792074686520696d706f72742070726f636573732c20796f752063616e206578706f727420616e20656d707479206373762066696c65206f6e20746865207465737420796f752077616e7420746f20696d706f72742c2066696c6c20696e20746865206d61726b732c20696d706f7274206261636b20696e746f20415475746f722e, '2008-09-25 16:01:17', 'gradebook'),
('en', '_template', 'external', 0x45787465726e616c, '2011-08-29 13:32:04', 'gradebook type'),
('en', '_template', 'external_help', 0x45787465726e616c2048656c70, '2005-03-17 10:31:39', ''),
('en', '_template', 'external_tests', 0x45787465726e616c205465737473, '2008-09-25 16:01:17', 'gradebook'),
('en', '_template', 'extra', 0x4578747261, '2005-09-21 13:35:05', ''),
('en', '_template', 'extract', 0x45787472616374, '2003-05-19 20:23:33', 'file manager zip utility'),
('en', '_template', 'extract_archive', 0x457874726163742041726368697665, '2003-05-19 20:23:58', 'file manager zip utility'),
('en', '_template', 'extract_tip', 0x5469703a2055736520616e20656d707479206469726563746f7279206e616d6520746f20657874726163742074686520636f6e74656e747320696e746f207468652063757272656e74206469726563746f72792e, '2003-05-19 20:24:27', 'file manager zip utility'),
('en', '_template', 'f', 0x46, '2007-01-10 13:48:14', ''),
('en', '_template', 'factory_default', 0x526573657420746f20707265666572656e63652064656661756c7473, '2010-04-20 13:58:25', ''),
('en', '_template', 'fail_feedback', 0x4661696c20466565646261636b, '2008-03-10 11:49:51', 'Test/Survey Property'),
('en', '_template', 'false', 0x46616c7365, '2003-05-20 08:52:19', 'textmanager, mytests t/f label'),
('en', '_template', 'fantasy', 0x46616e74617379, '2008-09-09 09:01:13', ''),
('en', '_template', 'faq', 0x4672657175656e746c792041736b6564205175657374696f6e73202846415129, '2005-10-19 12:41:54', ''),
('en', '_template', 'farchive', 0x466f72756d204172636869766572, '2008-11-07 10:41:59', ''),
('en', '_template', 'farchive_export', 0x4578706f727420466f72756d, '2008-11-07 10:42:18', ''),
('en', '_template', 'farchive_select_forum', 0x53656c65637420466f72756d20746f204578706f72743a, '2008-11-07 10:42:50', ''),
('en', '_template', 'feedback', 0x466565646261636b, '2003-05-20 09:09:40', 'global feedback label'),
('en', '_template', 'feedback_autohide', 0x4175746f48696465, '2013-12-18 18:40:27', ''),
('en', '_template', 'feedback_manual', 0x4d616e75616c, '2013-12-18 18:40:56', ''),
('en', '_template', 'feedback_placeholder', 0x456e74657220696e666f726d6174696f6e20746f2070726573656e7420746f2073747564656e747320616674657220636f72726563746c7920616e73776572696e672074686973207175657374696f6e2e, '2013-01-23 14:13:44', 'remedial content'),
('en', '_template', 'female', 0x46656d616c65, '2003-05-20 09:18:03', 'registration, profile'),
('en', '_template', 'fg_colour', 0x466f726567726f756e6420436f6c6f7572, '2008-09-09 09:01:13', ''),
('en', '_template', 'field', 0x41726561206f66205374756479, '2009-05-27 12:01:11', ''),
('en', '_template', 'file', 0x46696c65, '2003-05-20 09:18:31', 'file manager, zip tool'),
('en', '_template', 'filemanager_date_format', 0x2525592d25256d2d252564202525483a252569, '2009-06-30 16:05:29', 'file manager date'),
('en', '_template', 'fileman_disabled_title', 0x46696c65204d616e616765722064697361626c6564, '2010-04-14 11:26:27', ''),
('en', '_template', 'fileman_enabled_title', 0x4f70656e2046696c65204d616e616765722077696e646f77, '2010-04-14 11:26:05', ''),
('en', '_template', 'files', 0x46696c6573, '2005-08-16 15:27:36', ''),
('en', '_template', 'file_manager', 0x46696c65204d616e61676572, '2003-05-20 09:27:19', 'global file manager label'),
('en', '_template', 'file_manager_frame', 0x46696c65204d616e61676572204672616d65, '2005-01-31 11:14:37', 'viewing files in filemanger frame'),
('en', '_template', 'file_manager_new', 0x4372656174652061204e65772046696c65, '2004-10-29 14:53:13', 'file manager'),
('en', '_template', 'file_name', 0x46696c65204e616d65, '2004-10-15 12:08:25', ''),
('en', '_template', 'file_placeholder', 0x46696c65204e616d6520506c616365686f6c646572, '2008-07-22 16:44:59', 'Placeholder text used in Fluid''''s multiple file uploader.'),
('en', '_template', 'file_size', 0x46696c652053697a65, '2004-10-14 13:57:59', ''),
('en', '_template', 'file_storage', 0x46696c652053746f72616765, '2010-06-29 14:30:00', ''),
('en', '_template', 'file_storage_edit_file', 0x46696c652053746f72616765202d20456469742046696c65, '2010-12-08 20:15:04', 'File Storage'),
('en', '_template', 'file_storage_edit_folder', 0x46696c652053746f72616765202d204564697420466f6c646572, '2010-12-08 20:15:31', 'File Storage'),
('en', '_template', 'file_storage_move', 0x46696c652053746f72616765202d204d6f7665, '2010-12-08 20:15:52', 'File Storage'),
('en', '_template', 'file_storage_new_file', 0x46696c652053746f72616765202d204e65772046696c65, '2010-12-08 20:21:53', 'File Storage'),
('en', '_template', 'file_storage_version_control', 0x4d61696e7461696e2046696c652053746f726167652056657273696f6e20436f6e74726f6c, '2010-06-29 14:29:49', ''),
('en', '_template', 'file_to_read', 0x46696c6520546f2052656164, '2006-04-13 11:03:16', ''),
('en', '_template', 'fill_groups', 0x46696c6c2047726f757073, '2006-03-22 11:52:47', ''),
('en', '_template', 'fill_groups_randomly', 0x46696c6c2067726f7570732072616e646f6d6c792075706f6e206372656174696f6e2e, '2006-03-22 11:53:14', ''),
('en', '_template', 'filter', 0x46696c746572, '2005-03-30 14:52:33', ''),
('en', '_template', 'final_score', 0x46696e616c2053636f7265, '2007-03-16 14:10:05', ''),
('en', '_template', 'find_gadgets', 0x46696e642047616467657473, '2009-07-13 14:55:51', ''),
('en', '_template', 'find_results_in', 0x46696e6420726573756c747320696e, '2004-08-18 12:02:16', ''),
('en', '_template', 'first_name', 0x4669727374204e616d65, '2003-05-20 09:58:26', 'registration, profile'),
('en', '_template', 'fix_content_ordering', 0x46697820436f6e74656e74204f72646572696e67, '2004-10-18 14:03:47', ''),
('en', '_template', 'fix_content_ordering_text', 0x4f63636173696f6e616c6c792c20636f6e74656e742070616765732063616e20676574206469736f7264657265642064756520746f206d697363616c63756c6174696f6e2e205468697320697320616e206f6e676f696e6720697373756520746861742077696c6c206265207265736f6c76656420696e20616e207570636f6d696e672076657273696f6e206f6620415475746f722062757420756e74696c207468656e2c2077652068617665206d616465206120706174636820617661696c61626c6520746861742063616e206265207573656420746f20666978207468652069737375652e20496620796f752061726520657870657269656e63696e6720746869732070726f626c656d2c20706c65617365207573652074686520627574746f6e2062656c6f772e, '2005-03-10 11:19:41', ''),
('en', '_template', 'flag_text', 0x3c736d616c6c3e257320696e646963617465732066696c65732068617665206265656e2068616e64656420696e2e3c2f736d616c6c3e, '2011-05-30 10:07:17', ''),
('en', '_template', 'flowplayer', 0x466c6f77706c61796572, '2010-03-18 11:46:30', ''),
('en', '_template', 'focus', 0x466f637573, '2008-10-06 13:41:36', ''),
('en', '_template', 'folder', 0x466f6c646572, '2003-05-20 10:05:51', 'file manager, zip utility'),
('en', '_template', 'font_face', 0x466f6e742046616365, '2008-09-09 09:01:13', ''),
('en', '_template', 'font_size', 0x466f6e742053697a65, '2008-09-09 09:01:13', ''),
('en', '_template', 'formatting', 0x466f726d617474696e67, '2003-05-20 10:07:25', 'add/ edit content, news, export'),
('en', '_template', 'form_editor', 0x417475746f7220466f726d20456469746f72, '2005-03-11 10:31:45', 'Form editor for test questions'),
('en', '_template', 'form_focus', 0x466f726d20466f637573204f6e2050616765204c6f6164, '2005-03-29 12:38:11', ''),
('en', '_template', 'forum', 0x466f72756d, '2004-04-16 10:54:23', 'Forum list header'),
('en', '_template', 'forums', 0x466f72756d73, '2003-05-20 10:08:05', 'global forums label'),
('en', '_template', 'forum_date_format', 0x2525442025254d2025256a202525483a252569, '2004-05-26 15:18:29', ''),
('en', '_template', 'forum_email_links', 0x416c6c20656d61696c2061646472657373657320617265206d61646520696e746f206c696e6b732e, '2003-05-20 10:11:14', 'forums email address links instruction'),
('en', '_template', 'forum_general_discussion', 0x47656e6572616c2044697363757373696f6e, '2004-12-16 11:07:19', 'default forum in forum list'),
('en', '_template', 'forum_html_disabled', 0x48544d4c2069732064697361626c65642e, '2003-05-20 10:11:42', 'forum compose message'),
('en', '_template', 'forum_links', 0x416c6c20776f726473207374617274696e67207769746820687474703a2f2f20617265206d61646520696e746f206c696e6b732e, '2003-05-20 10:12:23', 'forum compose link creation instruction'),
('en', '_template', 'forum_new_submsg', 0x2a444f204e4f54205245504c5920544f2054484953204d4553534147452a0d0a412064697363757373696f6e2074687265616420696e2074686520415475746f7220636f757273652022257322206861732072656369657665642061207265706c792e204c6f67696e20746f2061636365737320746865202225732220666f72756d20616e642076696577207468652022257322207468726561642e20436c69636b20616e64207669657720746865206d6573736167652061743a202573, '2009-12-16 11:51:02', 'forum email message to thread subscribers'),
('en', '_template', 'forum_posts', 0x466f72756d20506f737473, '2005-03-16 14:59:41', ''),
('en', '_template', 'forum_reply_to', 0x5265706c79696e6720546f, '2003-05-20 10:12:48', 'forum reply to label for quoted messages'),
('en', '_template', 'forward', 0x466f7277617264, '2007-02-20 16:21:52', ''),
('en', '_template', 'french', 0x4672656e6368, '2008-09-09 09:01:12', ''),
('en', '_template', 'french-lsf', 0x4672656e63682d4c5346, '2008-09-09 09:01:12', ''),
('en', '_template', 'friends', 0x4d7920436f6e7461637473, '2009-05-27 12:01:11', ''),
('en', '_template', 'friends_of_friends', 0x436f6e7461637473206f6620596f757220436f6e7461637473, '2009-05-27 12:01:11', ''),
('en', '_template', 'from', 0x46726f6d, '2003-05-20 10:17:19', 'global from label'),
('en', '_template', 'from_atutor', 0x54686973206d657373616765207761732073656e74207468726f7567682074686520415475746f722073797374656d2066726f6d20636f757273652025732e, '2003-05-20 10:19:30', 'instructor/admin contact for email message'),
('en', '_template', 'from_email', 0x46726f6d20456d61696c, '2003-05-20 10:21:35', 'instructor/admin contact form'),
('en', '_template', 'from_name', 0x46726f6d204e616d65, '2003-05-20 10:22:02', 'instrcutor/admin contact from'),
('en', '_template', 'fs_comment', 0x257320436f6d6d656e74, '2006-06-29 10:09:37', ''),
('en', '_template', 'fs_comments', 0x257320436f6d6d656e7473, '2006-06-29 09:55:11', ''),
('en', '_template', 'fs_revision', 0x2573205265766973696f6e, '2006-06-29 10:05:39', ''),
('en', '_template', 'fs_revisions', 0x2573205265766973696f6e73, '2006-06-29 09:52:36', ''),
('en', '_template', 'full_name', 0x46756c6c204e616d65, '2006-03-27 15:55:44', ''),
('en', '_template', 'fwd', 0x467764, '2007-02-20 16:20:07', ''),
('en', '_template', 'g', 0x47, '2007-01-10 13:48:18', ''),
('en', '_template', 'gender', 0x536578, '2003-05-20 10:22:19', 'registration, profile'),
('en', '_template', 'general_help', 0x466f722067756964616e6365206f6e207573696e6720415475746f722073656520746865206f6666696369616c203c6120687265663d222531247322206f6e636c69636b3d22706f7074617374696328272531247327293b2072657475726e2066616c73653b22207461726765743d225f6e6577223e3c7374726f6e673e415475746f722048616e64626f6f6b3c2f7374726f6e673e3c2f613e2e, '2010-09-17 13:53:17', 'atutor default footer'),
('en', '_template', 'geography', 0x47656f67726170686963, '2009-05-27 12:01:11', ''),
('en', '_template', 'german', 0x4765726d616e, '2008-09-09 09:01:12', ''),
('en', '_template', 'german-dgs', 0x4765726d616e2d444753, '2008-09-09 09:01:12', ''),
('en', '_template', 'give_description', 0x4272696566206465736372697074696f6e206f6620796f75722070726f706f73656420636f75727365287329, '2005-03-09 12:19:48', 'control centre request instructor account form'),
('en', '_template', 'global_more_than_10_pages', 0x476c6f62616c3a204d6f7265207468616e2031302070616765732e, '2006-09-27 12:42:43', ''),
('en', '_template', 'glossary', 0x476c6f7373617279, '2003-05-20 10:24:33', 'global glossary label'),
('en', '_template', 'glossary_definition', 0x446566696e6974696f6e, '2003-05-20 10:25:13', 'glossary add/edit term'),
('en', '_template', 'glossary_related', 0x52656c61746564205465726d, '2003-05-20 10:26:35', 'add/edit glossary term'),
('en', '_template', 'glossary_term', 0x5465726d, '2003-05-20 10:27:01', 'add/edit glossary term'),
('en', '_template', 'glossary_terms', 0x476c6f7373617279205465726d73, '2003-05-20 10:27:47', 'delete course feedback for terms deleted'),
('en', '_template', 'glossary_term_limit', 0x54686973207465726d20657863656564732074686520363020636861726163746572206c696d697420616e642063616e6e6f742062652061646465642e, '2005-12-12 11:39:08', ''),
('en', '_template', 'go', 0x476f21, '2006-04-26 13:47:29', ''),
('en', '_template', 'google_key', 0x476f6f676c65204b6579, '2005-10-20 11:02:40', ''),
('en', '_template', 'google_key_txt', 0x546f206163636573732074686520476f6f676c652073656172636820617320616e203c656d3e656d62656464656420736572766963653c2f656d3e2c20796f75206d7573742066697273742063726561746520616e206163636f756e7420616e64206f627461696e2061206c6963656e7365206b6579206174203c6120687265663d22687474703a2f2f636f64652e676f6f676c652e636f6d2f617069732f616a61787365617263682f7369676e75702e68746d6c22207461726765743d225f6e6577223e676f6f676c652e636f6d2f617069733c2f613e20616e6420656e7465722069742062656c6f772e0d0a3c6272202f3e3c6272202f3e0d0a546865207365617263682063616e206265207573656420617320616e2065787465726e616c207365727669636520627920636c656172696e6720746865206b6579206669656c642062656c6f772e, '2007-09-04 15:14:30', ''),
('en', '_template', 'google_new_window', 0x536561726368206f70656e7320696e2061206e65772077696e646f772e, '2005-11-30 16:45:26', ''),
('en', '_template', 'google_search', 0x57656220536561726368, '2005-10-20 10:35:41', ''),
('en', '_template', 'google_search_ajax', 0x476f6f676c6520414a415820536561726368203c656d3e287265717569726573206c6963656e7365206b65793c2f656d3e203c7374726f6e673e61667465723c2f7374726f6e673e203c656d3e446563203574682c2032303036293c2f656d3e, '2008-07-28 10:51:24', 'Google search'),
('en', '_template', 'google_search_attn', 0x506c65617365206e6f7465207468617420746865206f6c6420476f6f676c6520736561726368206973206f6e6c79206170706c696361626c6520746f2074686f73652077686f2068617665206f627461696e65642061206c6963656e7365206b6579206265666f726520446563203574682c20323030363b20616e79206e6577206c6963656e7365206b6579206f627461696e656420616674657220446563656d626572203574682c2032303036206973206f6e6c79206170706c696361626c6520746f20746865206e657720476f6f676c6520414a4158207365617263682e, '2007-09-04 14:55:56', 'Google search'),
('en', '_template', 'google_search_books', 0x426f6f6b73, '2007-08-31 11:25:12', 'Google search'),
('en', '_template', 'google_search_images', 0x496d61676573, '2007-08-31 11:22:38', 'Google search'),
('en', '_template', 'google_search_local', 0x4c6f63616c, '2007-08-31 11:57:07', 'Google search'),
('en', '_template', 'google_search_news', 0x4e657773, '2007-08-31 11:23:30', 'Google search');
INSERT INTO `AT_language_text` (`language_code`, `variable`, `term`, `text`, `revised_date`, `context`) VALUES
('en', '_template', 'google_search_soap', 0x4f6c6420476f6f676c6520536561726368203c656d3e287265717569726573206c6963656e7365206b65793c2f656d3e203c623e6265666f72653c2f623e203c656d3e446563203574682c2032303036293c2f656d3e, '2008-07-28 10:51:46', 'Google search'),
('en', '_template', 'google_search_text', 0x5365617263682074686520576562206f757473696465207468697320636f7572736520666f72206164646974696f6e616c20696e666f726d6174696f6e2e, '2009-07-02 14:17:14', ''),
('en', '_template', 'google_search_txt', 0x546f2073656172636820666f7220737065636966696320776f7264732077697468696e206120776562736974652c20656e746572207468656d2062656c6f77207468656e207573652074686520275365617263682720627574746f6e2e2020496620796f75207769736820746f2073656172636820636f7572736520636f6e74656e742c2075736520746865203c6120687265663d227365617263682e706870223e636f6e74656e74207365617263683c2f613e2e, '2005-10-20 11:02:02', ''),
('en', '_template', 'google_search_type_txt', 0x506c656173652073656c656374206f6e65206f662074686520476f6f676c652073656172636820696e74657266616365732e, '2007-08-31 14:36:30', 'Google search'),
('en', '_template', 'google_search_videos', 0x566964656f73, '2007-08-31 11:22:53', 'Google search'),
('en', '_template', 'goto_content', 0x476f20746f20636f6e74656e74, '2004-05-11 15:18:23', ''),
('en', '_template', 'goto_main_nav', 0x4a756d7020746f204d61696e204e617669676174696f6e, '2014-01-01 17:34:51', 'bypass link'),
('en', '_template', 'goto_menu', 0x476f20746f204d656e75, '2006-07-14 10:14:57', '2nd invisible link on the page'),
('en', '_template', 'goto_top', 0x476f20746f20546f70, '2003-05-20 10:34:03', 'bypass link text in ATutor header'),
('en', '_template', 'go_to_my_start_page', 0x476f20546f204d792053746172742050616765, '2008-03-10 12:02:45', 'auto enroll property'),
('en', '_template', 'grade', 0x4772616465, '2008-09-25 16:01:17', 'gradebook'),
('en', '_template', 'gradebook', 0x4772616465626f6f6b, '2011-05-11 14:40:35', ''),
('en', '_template', 'gradebook_text', 0x526576696577206d61726b7320666f7220796f757220746573747320616e642061737369676e6d656e74732e, '2009-07-02 14:16:20', ''),
('en', '_template', 'grades_uncomparable', 0x4772616465732061726520756e636f6d70617261626c652e2043686f6f736520616e6f746865722077617920746f20736f6c766520636f6e666c696374, '2008-09-25 16:01:17', 'gradebook'),
('en', '_template', 'grade_already_exists', 0x436f6e666c6963743a20477261646520616c726561647920657869737473202d202573, '2008-09-25 16:01:17', 'gradebook'),
('en', '_template', 'grade_info', 0x4e6f74653a2022477261646522206669656c642063616e20626520677261646520646566696e656420696e20224772616465205363616c6522206f722070657263656e74616765206c696b6520353025252e, '2008-09-25 16:01:17', 'gradebook'),
('en', '_template', 'grade_scale', 0x4772616465205363616c65, '2008-09-25 15:59:56', 'gradebook'),
('en', '_template', 'grant_write_permission', 0x506c65617365206772616e74203c7374726f6e673e77726974653c2f7374726f6e673e207065726d697373696f6e20746f20666f6c6465727320616e642066696c6573206c69737465642062656c6f773a3c703e3c7374726f6e673e4e6f74653a3c2f7374726f6e673e20546f206368616e6765207065726d697373696f6e73206f6e20556e697820757365203c6b62643e63686d6f6420612b72773c2f6b62643e207468656e207468652066696c65206e616d652e3c2f703e, '2008-04-21 15:08:55', 'patcher'),
('en', '_template', 'graph', 0x4772617068, '2003-05-20 10:36:18', 'instructor course details graph label'),
('en', '_template', 'gray', 0x47726179, '2003-05-20 10:36:32', 'global code picker'),
('en', '_template', 'green', 0x477265656e, '2003-05-20 10:36:45', 'global code picker'),
('en', '_template', 'group', 0x47726f7570, '2005-05-03 15:42:38', ''),
('en', '_template', 'grouped_by_course', 0x47726f7570656420627920636f75727365, '2004-08-18 12:04:40', ''),
('en', '_template', 'groups', 0x47726f757073, '2004-11-25 15:45:26', ''),
('en', '_template', 'groups_create_automatic', 0x437265617465206d756c7469706c652067726f757073206175746f6d61746963616c6c79, '2006-03-21 15:36:08', ''),
('en', '_template', 'groups_create_manual', 0x43726561746520612073696e676c652067726f7570206d616e75616c6c79, '2006-03-21 15:36:58', ''),
('en', '_template', 'groups_text', 0x506172746963697061746520696e2067726f7570206c6561726e696e6720616374697669746965732e, '2009-07-02 14:16:03', ''),
('en', '_template', 'groups_type', 0x47726f7570732054797065, '2006-03-22 11:16:01', ''),
('en', '_template', 'group_about_private', 0x55736572732077696c6c206861766520746f20626520617070726f76656420627920746865206d6f64657261746f7220746f206a6f696e20746869732067726f75702e, '2009-05-27 12:01:11', ''),
('en', '_template', 'group_about_public', 0x5468652067726f7570206973206f70656e656420746f20616c6c2075736572732e20204e6f20617070726f76616c206973206e65656465642e, '2009-05-27 12:01:11', ''),
('en', '_template', 'group_admin', 0x47726f7570204d6f64657261746f72, '2009-05-27 12:01:11', ''),
('en', '_template', 'group_forums', 0x47726f757020466f72756d73, '2006-05-24 08:48:58', ''),
('en', '_template', 'group_info', 0x47726f75702044657461696c73, '2009-05-27 12:01:11', ''),
('en', '_template', 'group_invitation', 0x415475746f7220536f6369616c2047726f757020496e7669746174696f6e, '2009-05-27 12:01:11', ''),
('en', '_template', 'group_invitation_accepted', 0x415475746f7220536f6369616c2047726f757020496e7669746174696f6e204163636570746564, '2009-05-27 12:01:11', ''),
('en', '_template', 'group_joined', 0x596f75206172652061206d656d626572206f6620746869732067726f75702e, '2009-05-27 12:01:11', ''),
('en', '_template', 'group_last_update', 0x4c61737420557064617465, '2009-05-27 12:01:11', ''),
('en', '_template', 'group_last_updated', 0x4c617374205570646174656420, '2009-05-27 12:01:11', ''),
('en', '_template', 'group_logo', 0x47726f7570204c6f676f, '2009-05-27 12:01:11', ''),
('en', '_template', 'group_members', 0x47726f7570204d656d62657273, '2005-06-10 10:34:56', ''),
('en', '_template', 'group_name', 0x47726f7570204e616d65, '2009-05-27 12:01:11', ''),
('en', '_template', 'group_prefix', 0x47726f757020507265666978, '2006-03-22 11:17:12', ''),
('en', '_template', 'group_request', 0x415475746f7220536f6369616c204a6f696e2047726f75702052657175657374, '2009-05-27 12:01:11', ''),
('en', '_template', 'group_request_accepted', 0x415475746f7220536f6369616c2047726f75702052657175657374204163636570746564, '2009-05-27 12:01:11', ''),
('en', '_template', 'group_type', 0x47726f75702054797065, '2009-05-27 12:01:11', ''),
('en', '_template', 'guest', 0x4775657374, '2003-05-20 10:37:10', 'name assigned to non-registered users'),
('en', '_template', 'guests', 0x477565737473, '2003-05-20 10:38:19', 'instructor course stats/details'),
('en', '_template', 'guests_not_listed', 0x47756573747320617265206e6f74206c6973746564, '2003-05-20 10:38:32', 'who''s on menu'),
('en', '_template', 'guest_information', 0x477565737420496e666f726d6174696f6e, '2008-10-06 13:40:43', ''),
('en', '_template', 'guest_name', 0x4775657374204e616d65, '2008-10-06 13:41:12', ''),
('en', '_template', 'guide', 0x4775696465, '2010-09-21 11:46:53', 'mobile header.tmpl'),
('en', '_template', 'h', 0x48, '2007-01-10 13:48:22', ''),
('en', '_template', 'handout_to_read', 0x48616e646f757420746f2052656164, '2006-04-13 11:58:39', ''),
('en', '_template', 'hand_in', 0x48616e6420496e, '2006-03-20 14:36:56', ''),
('en', '_template', 'has_added_app', 0x68617320616464656420746865203c6120687265663d222573223e25733c2f613e2020676164676574, '2009-05-27 12:01:11', ''),
('en', '_template', 'has_added_group', 0x686173206164646564207468652067726f75702025732e, '2009-07-22 14:35:24', ''),
('en', '_template', 'has_invited_join', 0x25732068617320696e766974656420796f7520746f206a6f696e207468652067726f75702025732e, '2009-07-22 14:36:55', ''),
('en', '_template', 'has_joined_group', 0x686173206a6f696e6564207468652067726f75702025732e, '2009-07-22 14:35:05', ''),
('en', '_template', 'has_requested_to', 0x2573206861732072657175657374656420746f206a6f696e207468652067726f75702025732e, '2009-05-27 12:01:11', ''),
('en', '_template', 'has_updated_group', 0x6861732075706461746564207468652067726f75702025732e, '2009-07-22 14:35:56', ''),
('en', '_template', 'have', 0x48617665, '2007-02-21 13:22:47', ''),
('en', '_template', 'have_not', 0x48617665206e6f74, '2007-02-21 14:06:25', ''),
('en', '_template', 'help', 0x48656c70, '2003-05-20 10:41:08', 'global help label'),
('en', '_template', 'hidden', 0x48696464656e, '2003-05-20 10:42:27', 'instructor/admin contact form'),
('en', '_template', 'hide', 0x48696465, '2005-03-15 11:37:50', ''),
('en', '_template', 'hide_all_remedial', 0x4869646520416c6c2052656d656469616c20436f6e74656e74, '2013-01-23 14:19:48', ''),
('en', '_template', 'hide_course', 0x48696465207468697320636f757273652066726f6d207468652042726f77736520436f7572736573206c697374, '2003-05-20 10:42:41', 'create course screen'),
('en', '_template', 'hide_feedback', 0x4869646520466565646261636b, '2013-12-18 18:41:36', ''),
('en', '_template', 'hide_sub_navigation', 0x2e20546f67676c6520737562206e617669676174696f6e20636c6f7365642e, '2013-12-26 17:30:46', ''),
('en', '_template', 'history', 0x486973746f7279, '2003-05-25 08:36:00', 'context (removed after v1.1)'),
('en', '_template', 'hits', 0x48697473, '2003-05-20 10:44:14', 'links database link hit count'),
('en', '_template', 'hit_count', 0x48697420436f756e74, '2003-05-20 10:45:17', 'tracker'),
('en', '_template', 'hl_colour', 0x486967686c6967687420436f6c6f7572, '2008-09-09 09:01:13', ''),
('en', '_template', 'home', 0x486f6d65, '2006-05-31 11:12:30', ''),
('en', '_template', 'home_url', 0x486f6d652055524c, '2005-03-03 10:50:09', ''),
('en', '_template', 'horizontal', 0x486f72697a6f6e74616c, '2004-12-01 13:35:05', 'edit/create option test questions'),
('en', '_template', 'hot', 0x486f7421, '2003-05-20 10:47:10', '(not used)'),
('en', '_template', 'hot_thread', 0x486f7420746f70696321, '2014-01-02 15:40:23', 'forum message for busy thread'),
('en', '_template', 'hours', 0x486f757273, '2014-06-04 10:48:10', ''),
('en', '_template', 'hours_24', 0x32346872, '2003-05-20 10:48:10', 'release date picker'),
('en', '_template', 'hour_short', 0x68, '2007-07-09 12:31:21', ''),
('en', '_template', 'howto_course', 0x3c6120687265663d22687474703a2f2f617475746f722e63612f617475746f722f646f63732f696e6465782e706870223e415475746f7220446f63756d656e746174696f6e3c2f613e, '2005-06-01 12:32:03', 'help'),
('en', '_template', 'howto_course_text', 0x496e206164646974696f6e20746f20746865203c6120687265663d22646f63756d656e746174696f6e2f22206f6e636c69636b3d22706f707461737469632827646f63756d656e746174696f6e2f27293b2072657475726e2066616c73653b22207461726765743d225f6e6577223e3c656d3e415475746f722048616e64626f6f6b3c2f656d3e3c2f613e2062756e646c6564207769746820415475746f722c206f7468657220646f63756d656e746174696f6e20736f75726365732061726520617661696c61626c65207468726f75676820746865203c6120687265663d22687474703a2f2f617475746f722e63612f617475746f722f646f63732f696e6465782e706870223e415475746f7220446f63756d656e746174696f6e3c2f613e20736974652e, '2005-07-06 10:04:29', ''),
('en', '_template', 'how_to_solve_conflict', 0x486f7720746f20736f6c766520636f6e666c696374, '2008-09-25 16:01:17', 'gradebook'),
('en', '_template', 'html', 0x48544d4c, '2003-05-20 10:48:48', 'global HTML label'),
('en', '_template', 'html_only', 0x20506c61696e2054657874206f722048544d4c2066696c6573206f6e6c792e, '2003-05-20 10:49:49', 'add/edit content, header'),
('en', '_template', 'i', 0x49, '2007-01-10 13:48:26', ''),
('en', '_template', 'icon', 0x49636f6e, '2005-03-03 11:19:49', ''),
('en', '_template', 'icon_on', 0x69636f6e2076696577207475726e6564206f6e, '2014-01-01 15:18:28', 'icon/detailed view switch'),
('en', '_template', 'icon_view', 0x69636f6e2076696577, '2014-01-01 14:43:12', ''),
('en', '_template', 'id', 0x4944, '2003-05-20 10:50:57', 'global ID (identification number) label'),
('en', '_template', 'ignore_validation', 0x49676e6f72652076616c69646174696f6e, '2010-06-16 10:01:11', ''),
('en', '_template', 'illegal_file', 0x496c6c6567616c2046696c652054797065, '2003-05-20 10:52:36', 'zip utility when archive contain illegal extension'),
('en', '_template', 'illegal_file_extensions', 0x496c6c6567616c2046696c6520457874656e73696f6e73, '2005-03-03 10:52:15', ''),
('en', '_template', 'image', 0x496d616765, '2003-05-20 10:53:28', 'global code picker image code link text'),
('en', '_template', 'image_validation_text', 0x496e207468652061626f766520696d61676520746865726520617265206e756d6265727320616e642f6f72206c65747465727320646973706c617965642e2020506c656173652074797065207468656d20696e746f2074686520666f6c6c6f77696e67206669656c642e, '2009-07-16 09:02:13', ''),
('en', '_template', 'image_validation_text2', 0x546869732068656c707320656e737572652061206c69766520706572736f6e206973207265676973746572696e67206f6e20746869732073797374656d2e, '2009-06-03 15:33:17', ''),
('en', '_template', 'import', 0x496d706f7274, '2003-05-20 11:56:51', 'instructor import/export screen'),
('en', '_template', 'import_a_new_lang', 0x496d706f72742061204e6577204c616e6775616765, '2003-06-04 15:34:43', 'admin language manager'),
('en', '_template', 'import_content', 0x496d706f727420436f6e74656e74, '2005-02-18 14:05:57', ''),
('en', '_template', 'import_content_info', 0x496d706f7274206120636f6e666f726d616e7420494d5320636f6e74656e74207061636b616765206f7220494d5320636f6d6d6f6e206361727472696467652e2053656c6563742061206c6f636174696f6e2077697468696e20746865206578697374696e6720636f6e74656e7420746f203c7374726f6e673e696d706f727420696e746f3c2f7374726f6e673e2e20204f7220656e74657220612055524c20746f20636f6e74656e74207061636b616765206f7220636f6d6d6f6e206361727472696467652c20746f20696d706f7274206469726563746c792066726f6d20746865205765622e, '2009-11-12 16:56:26', ''),
('en', '_template', 'import_content_package', 0x496d706f727420436f6e74656e74205061636b616765, '2003-10-03 13:07:38', ''),
('en', '_template', 'import_content_package_bottom_subcontent', 0x417320746f70206c6576656c20636f6e74656e742c206f7220617320737562636f6e74656e742073656c65637465642062656c6f77, '2003-10-20 13:36:27', ''),
('en', '_template', 'import_content_package_where', 0x496d706f727420696e746f, '2003-10-14 12:24:03', ''),
('en', '_template', 'import_err_email_exists', 0x4163636f756e74206578697374732e, '2004-01-30 15:38:42', ''),
('en', '_template', 'import_err_email_invalid', 0x456d61696c20696e76616c69642e, '2004-01-30 13:28:32', ''),
('en', '_template', 'import_err_email_missing', 0x456d61696c206d697373696e672e, '2004-01-30 13:28:40', ''),
('en', '_template', 'import_err_full_name_exists', 0x466972737420616e64204c617374206e616d652065786973742e, '2006-03-28 10:40:02', ''),
('en', '_template', 'import_err_username_exists', 0x557365726e616d6520616c72656164792074616b656e2e, '2004-01-30 13:28:48', ''),
('en', '_template', 'import_err_username_invalid', 0x557365726e616d6520636f6e7461696e7320696e76616c696420636861726163746572732e, '2004-01-30 13:28:56', ''),
('en', '_template', 'import_export_external_marks', 0x45787465726e616c204d61726b73, '2008-09-25 16:01:17', 'gradebook'),
('en', '_template', 'import_lang_howto', 0x596f75206d617920696d706f7274206164646974696f6e616c206c616e67756167657320696e746f207468697320696e7374616c6c6174696f6e206f6620415475746f7220627920646f776e6c6f6164696e6720746865206c616e6775616765207061636b2066726f6d2074686520415475746f722e63612077656273697465207468656e2075706c6f6164696e67206974207573696e672074686520666f726d2062656c6f772c206f72206966207468652064726f7020646f776e2062656c6f772069732061626c6520746f206465746563742074686520617661696c61626c65206c616e6775616765732072656d6f74656c79207468656e206974206d617920626520757365642061732077656c6c2e, '2004-10-18 14:25:21', 'admin language manager'),
('en', '_template', 'import_marks_info', 0x41206d61726b206c697374206d617920626520696d706f7274656420696e746f20415475746f722e2043726561746520746865206d61726b206c69737420696e206120636f6d6d61207365706172617465642076616c75657320284353562920666f726d617420617320666f6c6c6f77733a202266697273746e616d65222c20226c6173746e616d65222c2022656d61696c222c20226d61726b222077697468206f6e652073747564656e7420706572206c696e652e20506c65617365206c6561766520746865206669727374206c696e65206173207469746c652e20546865206d61726b20696e204353562066696c652063616e206265206772616465206f722070657263656e74616765206c696b6520353025252e20546f2073696d706c696679207468652070726f636573732c20796f752063616e206578706f727420746865204353562066696c652077697468206578706f72742066756e6374696f6e616c6974792c2075706461746520746865206d61726b7320696e746f206578706f727465642066696c6520616e6420696d706f7274206261636b20696e746f20415475746f722e, '2008-09-25 16:01:17', 'gradebook'),
('en', '_template', 'import_package', 0x496d706f7274205061636b616765, '2005-05-17 12:06:10', ''),
('en', '_template', 'import_question', 0x496d706f7274205175657374696f6e73, '2008-09-23 13:59:41', ''),
('en', '_template', 'import_remote_language', 0x4f722c20696d706f72742061206c616e6775616765206469726563746c792066726f6d2074686520415475746f722e636120776562736974652e, '2004-10-18 14:27:11', ''),
('en', '_template', 'import_sep_txt', 0x466f72206175746f2d67656e65726174656420757365726e616d65732c20736570617261746520666972737420616e64206c617374206e616d657320776974683a, '2004-06-22 12:07:48', ''),
('en', '_template', 'import_test', 0x496d706f72742054657374, '2008-09-23 13:52:19', ''),
('en', '_template', 'import_theme', 0x496d706f7274205468656d65, '2004-10-15 15:47:13', 'import theme button in theme manager'),
('en', '_template', 'ims_files_missing', 0x496e2074686973207061636b6167652c207468652066696c652c20253124732c206973206d697373696e67206f72206d6973706c616365642e, '2009-12-07 14:25:04', ''),
('en', '_template', 'ims_missing_references', 0x4d697373696e672066696c65207265666572656e636573, '2009-12-07 16:27:01', ''),
('en', '_template', 'inactive_admin', 0x496e6163746976652041646d696e6973747261746f72, '2005-03-03 11:00:55', ''),
('en', '_template', 'inbox', 0x496e626f78, '2003-05-20 11:59:47', 'global Inbox label'),
('en', '_template', 'inbox_date_format', 0x25256c2025254d2025256a2c20252559202d202525483a252569, '2003-05-20 12:00:47', 'inbox screen (see www.php.net/date for codes)'),
('en', '_template', 'inbox_notification', 0x496e626f78204e6f74696669636174696f6e, '2005-03-16 14:40:07', ''),
('en', '_template', 'info', 0x436f7572736520496e666f, '2005-04-01 15:09:41', 'global info message box label'),
('en', '_template', 'initial_content', 0x496e697469616c20436f6e74656e74, '2004-10-15 15:45:10', ''),
('en', '_template', 'insert', 0x496e73657274, '2003-05-20 12:02:16', 'instructor add content screen'),
('en', '_template', 'insert_into', 0x496e7365727420496e746f, '2005-03-03 12:15:49', ''),
('en', '_template', 'install', 0x496e7374616c6c, '2005-08-16 15:51:57', ''),
('en', '_template', 'installed', 0x496e7374616c6c6564, '2008-10-28 10:58:39', ''),
('en', '_template', 'installed_date', 0x496e7374616c6c65642044617465, '2008-11-17 10:41:34', ''),
('en', '_template', 'install_modules', 0x496e7374616c6c204d6f64756c6573, '2005-08-16 16:17:09', ''),
('en', '_template', 'install_module_text', 0x546f20696e7374616c6c2061206e6577206d6f64756c65206974206d7573742066697273742062652065787472616374656420696e746f20746865203c636f64653e25733c2f636f64653e206469726563746f727920666f7220697420746f2061707065617220696e20746865206c6973742062656c6f772e, '2005-08-17 13:47:02', ''),
('en', '_template', 'install_themes', 0x496e7374616c6c205468656d6573, '2008-11-14 11:47:00', ''),
('en', '_template', 'install_themes_text', 0x546f20696e7374616c6c206e6577207468656d657320746865203c636f64653e25733c2f636f64653e206469726563746f7279206d7573742062652073657420746f20777269746561626c652e205573652074686520636f6d6d616e64203c6b62643e63686d6f6420612b77207468656d65733c2f6b62643e206f6e20556e6978206d616368696e65732c207768696c65206f6e2057696e646f7773207468652077656220736572766572206d7573742068617665207772697465207065726d697373696f6e73206f6e2074686174206469726563746f72792e, '2005-12-14 12:36:08', ''),
('en', '_template', 'institution', 0x5363686f6f6c2f496e737469747574696f6e, '2009-05-27 12:01:11', ''),
('en', '_template', 'instructions', 0x496e737472756374696f6e73, '2005-04-05 14:25:07', ''),
('en', '_template', 'instructions_placeholder', 0x456e74657220696e666f726d6174696f6e2061626f757420686f772074686520746573742073686f756c642062652074616b656e2e, '2013-01-23 14:15:37', ''),
('en', '_template', 'instructor', 0x496e7374727563746f72, '2003-05-20 12:02:59', 'global instructor label'),
('en', '_template', 'instructors', 0x496e7374727563746f7273, '2003-05-20 12:03:37', 'admin general statistics label for number of instructors'),
('en', '_template', 'instructor_contact_form', 0x496e7374727563746f7220436f6e7461637420466f726d, '2003-05-20 12:12:32', 'instructor contact form heading'),
('en', '_template', 'instructor_request', 0x415475746f7220496e7374727563746f722052657175657374, '2003-05-25 08:37:50', 'subject line in email to admin when instructor request is made'),
('en', '_template', 'instructor_requests', 0x496e7374727563746f72205265717565737473, '2003-05-20 12:19:52', 'admin home page heading'),
('en', '_template', 'instructor_requests_text', 0x546865726520617265203c7374726f6e673e25733c2f7374726f6e673e20696e7374727563746f722072657175657374732070656e64696e6720617070726f76616c2e, '2005-03-30 15:30:02', ''),
('en', '_template', 'instructor_request_deny', 0x596f757220415475746f7220696e7374727563746f72207265717565737420686173206265656e2064656e6965642e, '2003-10-06 15:14:48', 'email message to denied instructor'),
('en', '_template', 'instructor_request_denymsg1', 0x526567697374726174696f6e20696e666f726d6174696f6e20697320696e636f6d706c6574652e, '2003-10-06 15:55:47', 'reason why denied'),
('en', '_template', 'instructor_request_denymsg2', 0x496e617070726f707269617465207375626a656374206d61747465722e, '2003-10-06 16:01:26', 'reason why denied'),
('en', '_template', 'instructor_request_denymsg3', 0x54686520636f75727365206465736372697074696f6e207265717569726573206d6f72652064657461696c2e, '2003-10-07 15:47:33', 'deny instructor request'),
('en', '_template', 'instructor_request_denymsg4', 0x596f7520686176652072657175657374656420656e726f6c6c6d656e742077697468207468652077726f6e6720666f726d2e, '2003-10-07 15:52:12', 'admin deny instructor request'),
('en', '_template', 'instructor_request_email_notification', 0x496e7374727563746f72205265717565737420456d61696c204e6f74696669636174696f6e, '2005-03-03 10:51:01', ''),
('en', '_template', 'instructor_request_enterdenymsg', 0x43686f6f73652061206d657373616765206578706c61696e696e672077687920746865207573657227732072657175657374207761732064656e696564206f7220656e74657220796f7572206f776e2e, '2003-10-06 15:19:05', 'Header text for deny message text area'),
('en', '_template', 'instructor_request_reply', 0x596f757220415475746f7220696e7374727563746f72207265717565737420686173206265656e20617070726f7665642e20476f20746f20257320746f206c6f67696e20746f204d7920436f75727365732c207468656e2073656c656374202243726561746520436f75727365222e, '2005-05-27 13:53:06', 'email in reply to instructor account approval'),
('en', '_template', 'interests', 0x496e74657265737473, '2009-05-27 12:01:11', ''),
('en', '_template', 'internet_technology', 0x496e7465726e657420546563686e6f6c6f6779, '2009-05-27 12:01:11', ''),
('en', '_template', 'invalid_session', 0x4e6f7420612056616c69642053657373696f6e, '2003-05-20 12:26:29', 'tracker'),
('en', '_template', 'invite', 0x496e76697465, '2009-05-27 12:01:11', ''),
('en', '_template', 'invite_groups', 0x496e76697465204e65772047726f7570204d656d62657273, '2009-05-27 12:01:11', ''),
('en', '_template', 'in_minutes', 0x4d696e75746573, '2007-02-20 10:30:20', ''),
('en', '_template', 'in_reply_to', 0x496e207265706c7920746f, '2003-05-20 12:27:21', 'replyto label for quoted forum or inbox message'),
('en', '_template', 'irish-isl', 0x49726973682d49534c, '2008-09-09 09:01:12', ''),
('en', '_template', 'italian', 0x4974616c69616e, '2008-09-09 09:01:12', ''),
('en', '_template', 'italian-lis', 0x4974616c69616e2d4c4953, '2008-09-09 09:01:12', ''),
('en', '_template', 'italic', 0x4974616c6963, '2003-05-20 12:27:44', 'global code picker link text'),
('en', '_template', 'item', 0x4974656d, '2007-01-10 13:46:39', ''),
('en', '_template', 'j', 0x4a, '2007-01-10 13:48:30', ''),
('en', '_template', 'japanese-jsl', 0x4a6170616e6573652d4a534c, '2008-09-09 09:01:12', ''),
('en', '_template', 'join_group', 0x4a6f696e2047726f7570, '2009-06-12 10:06:28', ''),
('en', '_template', 'jump', 0x4a756d70, '2003-05-20 12:28:03', 'jump menu submit button text'),
('en', '_template', 'jump_codes', 0x4a756d70206f7665722074686520636f6465207069636b6572, '2003-05-20 12:29:53', 'alt text for bypass link to jump over the code picker'),
('en', '_template', 'jump_redirect', 0x446972656374204a756d70, '2004-11-30 10:03:55', 'preferecnes'),
('en', '_template', 'jump_to_admin_tools', 0x6a756d7020746f206d616e61676520746f6f6c73, '2014-01-01 14:24:20', ''),
('en', '_template', 'just_social', 0x557365206a75737420415475746f7220536f6369616c, '2009-07-17 14:11:50', ''),
('en', '_template', 'kb', 0x3c6163726f6e796d207469746c653d224b696c6f6279746573223e4b423c2f6163726f6e796d3e, '2007-12-09 12:56:24', ''),
('en', '_template', 'keep_email_private', 0x4b65657020656d61696c2068696464656e2066726f6d206f74686572732e, '2006-03-28 11:29:07', ''),
('en', '_template', 'keep_it_short', 0x5469703a204b6565702069742073686f72742c206e6f207370616365732e, '2003-05-20 12:31:53', 'file manager suggestion for folder creation'),
('en', '_template', 'keywords', 0x4b6579776f726473, '2003-09-28 10:22:10', 'content add/edit'),
('en', '_template', 'language', 0x4c616e6775616765, '2003-05-20 12:32:05', 'profile, registration'),
('en', '_template', 'languages', 0x4c616e677561676573, '2005-03-03 11:07:50', ''),
('en', '_template', 'lang_code', 0x4c616e677561676520436f6465, '2006-09-27 14:12:11', ''),
('en', '_template', 'last_accessed', 0x4c617374204163636573736564, '2005-03-01 12:52:16', 'tracker'),
('en', '_template', 'last_comment', 0x4c61737420436f6d6d656e74, '2003-05-20 12:33:10', 'forums, thread view column label'),
('en', '_template', 'last_login', 0x4c617374204c6f67696e, '2005-03-03 11:03:12', ''),
('en', '_template', 'last_modified', 0x4c617374204d6f646966696564, '2003-05-20 12:36:35', 'instructor content editor link text'),
('en', '_template', 'last_name', 0x4c617374204e616d65, '2003-05-20 12:37:39', 'registration, profile, admin user manager'),
('en', '_template', 'last_post', 0x4c61737420506f7374, '2004-04-16 11:24:59', 'Refers to date of last post in forum'),
('en', '_template', 'last_updated', 0x4c61737420757064617465643a202573, '2006-05-19 14:54:08', ''),
('en', '_template', 'latex_server', 0x4d696d655465782053657276657220666f7220746865204c6154657820736572766963652e2020466f722070726f64756374696f6e20707572706f7365732c20706c6561736520696e7374616c6c206d696d65546558206f6e20796f7572206f776e207365727665722e2028687474703a2f2f7777772e617475746f722e63612f6367692f6d696d657465782e6367693f29, '2010-03-04 08:46:33', ''),
('en', '_template', 'leave_blank', 0x4c6561766520626c616e6b, '2003-05-20 12:39:07', 'mytest/test manager question option'),
('en', '_template', 'leave_group', 0x4c656176652047726f7570, '2009-05-27 12:01:11', ''),
('en', '_template', 'leave_unchanged', 0x4c6561766520756e6368616e676564, '2005-05-10 16:04:07', ''),
('en', '_template', 'left', 0x4c656674, '2004-04-27 11:00:35', ''),
('en', '_template', 'left_blank', 0x4c65667420626c616e6b, '2003-05-20 12:40:14', 'mytests/test manager question result text for unanswerd question'),
('en', '_template', 'legend', 0x4c6567656e64, '2003-05-20 12:41:00', 'instructor course statistics/details'),
('en', '_template', 'license', 0x4c6963656e7365, '2005-08-16 15:27:07', ''),
('en', '_template', 'light_gray', 0x4c696768742047726179, '2008-09-09 09:01:13', ''),
('en', '_template', 'limit_to_group', 0x41737369676e20546f2047726f757073, '2004-12-10 14:39:53', ''),
('en', '_template', 'link', 0x4c696e6b, '2003-05-20 12:41:18', 'links database'),
('en', '_template', 'links', 0x4c696e6b73, '2005-02-09 13:25:20', ''),
('en', '_template', 'link_alc', 0x4c696e6b2066726f6d2041436f6e74656e743a, '2012-09-07 10:56:48', 'tile search'),
('en', '_template', 'list_add_course_list', 0x41646420746f20436f75727365204c697374, '2004-10-19 14:39:08', 'Enrollment manager, add students manually button'),
('en', '_template', 'list_add_enrolled_list', 0x41646420746f20456e726f6c6c6564204c697374, '2004-10-19 14:51:02', 'enrollment manager, add to enrolled students list button'),
('en', '_template', 'list_add_unenrolled_list', 0x41646420746f20556e2d656e726f6c6c6564204c697374, '2004-10-19 14:47:31', 'enrollment manager, add to unenrolled students list button'),
('en', '_template', 'list_create_course_list', 0x43726561746520436f75727365204c697374, '2004-10-15 12:04:06', 'create list of students function in enrollement manager'),
('en', '_template', 'list_export_course_list', 0x4578706f727420436f75727365204c697374, '2003-09-16 10:15:29', 'enrol admin'),
('en', '_template', 'list_import_course_list', 0x496d706f727420436f75727365204c697374, '2003-09-16 09:35:35', 'import course list'),
('en', '_template', 'list_import_howto', 0x4120636f7572736520656e726f6c6c6d656e74206c697374206d617920626520696d706f7274656420696e746f20415475746f722e204372656174652074686520636f75727365206c69737420696e206120636f6d6d61207365706172617465642076616c75657320284353562920666f726d617420617320666f6c6c6f77733a203c636f64653e2266697273746e616d65222c20226c6173746e616d65222c2022656d61696c223c2f636f64653e2077697468206f6e652073747564656e7420706572206c696e652e20204e65772073747564656e74732077696c6c20726563656976652074686569722061636365737320696e737472756374696f6e7320627920656d61696c2e, '2004-02-05 10:22:29', ''),
('en', '_template', 'lk_agree', 0x4167726565, '2004-08-12 15:45:53', ''),
('en', '_template', 'lk_always', 0x416c77617973, '2004-08-26 12:23:31', ''),
('en', '_template', 'lk_disagree', 0x4469736167726565, '2004-08-12 15:46:29', ''),
('en', '_template', 'lk_excellent', 0x457863656c6c656e74, '2004-08-12 15:42:09', ''),
('en', '_template', 'lk_fair', 0x46616972, '2004-08-12 15:43:07', ''),
('en', '_template', 'lk_good', 0x476f6f64, '2004-08-12 15:42:50', ''),
('en', '_template', 'lk_important', 0x496d706f7274616e74, '2004-08-26 12:26:09', ''),
('en', '_template', 'lk_little_importance', 0x4f66204c6974746c6520496d706f7274616e6365, '2004-08-26 12:26:41', ''),
('en', '_template', 'lk_mod_important', 0x4d6f6465726174656c7920496d706f7274616e74, '2004-08-26 12:26:23', ''),
('en', '_template', 'lk_never', 0x4e65766572, '2004-08-26 12:25:30', ''),
('en', '_template', 'lk_occasionally', 0x4f63636173696f6e616c6c79, '2004-08-26 12:24:04', ''),
('en', '_template', 'lk_poor', 0x506f6f72, '2004-08-12 15:43:18', ''),
('en', '_template', 'lk_rarely', 0x526172656c79, '2004-08-26 12:24:21', ''),
('en', '_template', 'lk_strongly_agree', 0x5374726f6e676c79204167726565, '2004-08-12 15:45:38', ''),
('en', '_template', 'lk_strongly_disagree', 0x5374726f6e676c79204469736167726565, '2004-08-12 15:46:46', ''),
('en', '_template', 'lk_undecided', 0x556e64656369646564, '2004-08-26 11:46:00', ''),
('en', '_template', 'lk_unimportant', 0x556e696d706f7274616e74, '2004-08-26 12:27:06', ''),
('en', '_template', 'lk_very_frequently', 0x56657279204672657175656e746c79, '2004-08-26 12:23:46', ''),
('en', '_template', 'lk_very_good', 0x5665727920476f6f64, '2004-08-12 15:42:33', ''),
('en', '_template', 'lk_very_important', 0x5665727920496d706f7274616e74, '2004-08-26 12:25:52', ''),
('en', '_template', 'lk_very_poor', 0x5665727920506f6f72, '2004-08-12 15:43:37', ''),
('en', '_template', 'lk_very_rarely', 0x5665727920526172656c79, '2004-08-26 12:24:38', ''),
('en', '_template', 'locale', 0x4c6f63616c65, '2004-11-20 19:35:20', ''),
('en', '_template', 'local_network', 0x4c6f63616c204e6574776f726b, '2009-05-27 12:01:11', ''),
('en', '_template', 'location', 0x4c6f636174696f6e, '2005-03-04 14:06:25', ''),
('en', '_template', 'lock_no_post', 0x4e6f20706f7374696e672c2062757420616c6c6f772072656164696e672e, '2003-05-20 12:46:36', 'forum instructor lock text'),
('en', '_template', 'lock_no_post1', 0x5468697320746872656164206973206c6f636b65642066726f6d20706f7374696e672e, '2003-05-20 12:46:45', 'forum instructor lock text'),
('en', '_template', 'lock_no_read', 0x4e6f20706f7374696e6720616e64206e6f2072656164696e672e, '2003-05-20 12:46:56', 'context'),
('en', '_template', 'lock_no_read1', 0x5468697320746872656164206973206c6f636b65642066726f6d2072656164696e6720616e6420706f7374696e672e, '2003-05-20 12:47:24', 'forum thread display lock message'),
('en', '_template', 'lock_submit', 0x4170706c79204c6f636b, '2003-05-20 12:47:50', 'text for instructor forum lock button'),
('en', '_template', 'lock_thread', 0x4c6f636b20546f706963, '2014-01-02 15:40:37', 'Alt text for forum instructor lock icon'),
('en', '_template', 'logged_in_within', 0x6c6f6767656420696e2077697468696e, '2007-02-21 13:37:39', ''),
('en', '_template', 'login', 0x4c6f67696e, '2006-07-27 17:35:30', 'global login label'),
('en', '_template', 'login_into_atutor', 0x4c6f6720696e746f20796f757220415475746f72204163636f756e74, '2003-05-20 12:51:48', 'login after enrollment message'),
('en', '_template', 'login_name', 0x4c6f67696e204e616d65, '2003-05-20 12:52:32', 'control centre account information label'),
('en', '_template', 'login_name_or_email', 0x4c6f67696e204e616d65206f7220456d61696c, '2006-03-28 14:21:34', ''),
('en', '_template', 'login_statistics', 0x2573206c6f67696e207374617469737469637320666f7220202573, '2003-05-31 14:49:29', 'course login details'),
('en', '_template', 'login_text', 0x456e74657220796f7572206c6f67696e206e616d65206f7220796f757220656d61696c20616464726573732c20616e642020796f75722070617373776f72642e, '2010-10-07 09:00:45', ''),
('en', '_template', 'logout', 0x4c6f672d6f7574, '2003-05-20 12:53:44', 'global logout link text'),
('en', '_template', 'log_file_bundle', 0x4c6f672046696c652042756e646c65, '2005-03-10 16:36:31', 'error logging - email subject'),
('en', '_template', 'ltr', 0x4c65667420746f205269676874, '2004-11-20 19:37:04', ''),
('en', '_template', 'magenta', 0x4d6167656e7461, '2008-09-09 09:01:13', ''),
('en', '_template', 'mail_queue_cron', 0x596f75206d757374207365742d757020746865203c6120687265663d2261646d696e2f63726f6e5f636f6e6669672e706870223e63726f6e3c2f613e20746f20757365207468697320666561747572652e, '2006-04-03 14:21:30', ''),
('en', '_template', 'maintainers', 0x4d61696e7461696e657273, '2005-08-16 15:26:57', ''),
('en', '_template', 'main_navigation', 0x4d61696e204e617669676174696f6e, '2005-03-07 12:09:31', ''),
('en', '_template', 'malaysian-msl', 0x4d616c61797369616e2d4d534c, '2008-09-09 09:01:12', ''),
('en', '_template', 'male', 0x4d616c65, '2003-05-20 12:55:53', 'registration, profile, admin user manager'),
('en', '_template', 'manage', 0x4d616e616765, '2005-02-23 12:05:42', ''),
('en', '_template', 'manage_languages', 0x4d616e616765204578697374696e67204c616e677561676573, '2004-09-23 16:30:59', ''),
('en', '_template', 'manage_lang_howto', 0x42656c6f772061726520616c6c20746865206c616e6775616765732063757272656e746c7920617661696c61626c6520696e207468697320696e7374616c6c6174696f6e206f6620415475746f722e20596f75206d6179206578706f727420746865206c616e677561676520617320616e20415475746f72206c616e6775616765207061636b206f722064656c6574652069742066726f6d2074686520696e7374616c6c6174696f6e2e, '2004-10-18 14:23:43', ''),
('en', '_template', 'manage_links', 0x4d616e616765204c696e6b73, '2006-05-24 11:24:51', ''),
('en', '_template', 'manage_navigation_bar', 0x4d616e61676520746f6f6c73, '2014-01-01 17:16:47', 'aria-label for subnavmenu_i'),
('en', '_template', 'manage_off', 0x4d616e616765206f6666, '2014-01-01 13:00:21', 'instructor admin switch'),
('en', '_template', 'manage_on', 0x4d616e616765206f6e, '2014-01-01 12:59:55', 'instructor admin switch'),
('en', '_template', 'manage_tools_on', 0x4d616e61676520746f6f6c73207475726e6564206f6e, '2014-01-01 14:30:33', ''),
('en', '_template', 'mark', 0x4d61726b, '2003-05-20 12:56:19', 'mytests/test manager'),
('en', '_template', 'marked_label', 0x4d61726b65642028257329, '2005-05-12 10:25:44', ''),
('en', '_template', 'marks', 0x6d61726b73, '2003-05-20 12:56:34', 'mytests/test manager'),
('en', '_template', 'mark_alumni', 0x4d61726b20416c756d6e69, '2004-10-25 12:24:38', ''),
('en', '_template', 'mark_statistics', 0x5375626d697373696f6e2053746174697374696373, '2004-08-26 13:27:13', ''),
('en', '_template', 'master_list_authentication', 0x41757468656e74696361746520416761696e73742041204d61737465722053747564656e74204c697374, '2005-03-31 13:54:01', ''),
('en', '_template', 'master_not_in_list', 0x4966206578697374696e672075736572206e6f7420696e206e6577206c697374, '2005-05-10 16:04:31', ''),
('en', '_template', 'master_student_list', 0x4d61737465722053747564656e74204c697374, '2005-04-04 10:39:26', ''),
('en', '_template', 'material', 0x4d6174657269616c, '2004-10-14 14:10:13', ''),
('en', '_template', 'material_announcements', 0x416e6e6f756e63656d656e74732028257329, '2004-10-14 14:14:23', ''),
('en', '_template', 'material_content_pages', 0x436f6e74656e742050616765732028257329, '2004-10-14 14:12:47', ''),
('en', '_template', 'material_files', 0x46696c65732028257329, '2004-10-14 14:22:54', ''),
('en', '_template', 'material_glossary', 0x476c6f73736172792028257329, '2004-10-14 14:22:17', ''),
('en', '_template', 'material_groups', 0x47726f7570732028257329, '2004-11-25 15:43:53', ''),
('en', '_template', 'material_links', 0x4c696e6b732028253124732063617465676f726965732c202025322473206c696e6b7329, '2004-10-14 14:18:25', ''),
('en', '_template', 'material_polls', 0x506f6c6c732028257329, '2004-10-14 14:21:41', ''),
('en', '_template', 'material_select_all', 0x53656c65637420416c6c, '2004-10-14 14:11:39', ''),
('en', '_template', 'material_stats', 0x5374617469737469637320282573206461797329, '2004-10-14 14:23:22', ''),
('en', '_template', 'maximum', 0x4d6178696d756d, '2003-05-20 12:59:01', 'instructor course statistics/details'),
('en', '_template', 'maximum_course_float', 0x4d6178696d756d20436f7572736520466c6f6174, '2005-03-03 10:52:04', ''),
('en', '_template', 'maximum_course_size', 0x4d6178696d756d20436f757273652053697a65, '2005-03-03 10:51:52', ''),
('en', '_template', 'maximum_file_size', 0x4d6178696d756d2046696c652053697a65, '2005-03-03 10:51:39', ''),
('en', '_template', 'maximum_login_attempt', 0x4d6178696d756d204c6f67696e20417474656d707473, '2009-06-03 15:33:17', ''),
('en', '_template', 'max_backups_reached', 0x596f752068617665207265616368656420746865206d6178696d756d206e756d626572206f66206261636b75707320616c6c6f7765642e, '2004-10-15 14:16:57', ''),
('en', '_template', 'max_file_size', 0x4d61782046696c652053697a65, '2003-05-20 12:59:52', 'admin course manager properties'),
('en', '_template', 'max_file_size_system', 0x4d6178696d756d2073797374656d20616c6c6f7773, '2003-10-14 14:32:52', 'php''s max file size'),
('en', '_template', 'mb', 0x3c6163726f6e796d207469746c653d224d65676162797465223e4d423c2f6163726f6e796d3e, '2007-07-26 14:05:45', 'short for MB (megabytes)'),
('en', '_template', 'media', 0x4d65646961, '2007-06-15 14:41:08', ''),
('en', '_template', 'members', 0x4d656d62657273, '2003-05-20 13:00:39', 'instructor course statistics/details'),
('en', '_template', 'member_id', 0x4d656d626572204944, '2003-05-20 13:01:18', 'admin user manager column heading'),
('en', '_template', 'member_stats', 0x53747564656e74205370656369666963205573616765, '2005-03-03 15:25:57', ''),
('en', '_template', 'menu', 0x4d656e75, '2003-05-20 13:02:17', 'preferences option'),
('en', '_template', 'menu_menu', 0x436f6e74656e74204e617669676174696f6e, '2005-03-30 10:13:27', 'context (?)'),
('en', '_template', 'message', 0x4d657373616765, '2003-05-20 13:06:56', 'inbox send message screen'),
('en', '_template', 'message_board', 0x4d65737361676520426f617264, '2009-05-27 12:01:11', ''),
('en', '_template', 'message_notification', 0x4d657373616765204e6f74696669636174696f6e, '2005-03-14 15:31:15', 'preferences'),
('en', '_template', 'mexican-lsm', 0x4d65786963616e2d4c534d, '2008-09-09 09:01:12', ''),
('en', '_template', 'mfu_add_more', 0x416464204d6f7265, '2012-06-08 10:04:20', 'file manager'),
('en', '_template', 'mfu_add_to_queue', 0x43686f6f7365203c656d3e42726f7773652066696c65733c2f656d3e20746f206164642066696c657320746f207468652071756575652e, '2012-06-08 09:59:28', 'file manager'),
('en', '_template', 'mfu_browse_files', 0x42726f7773652046696c6573, '2012-06-08 10:03:37', 'file manager'),
('en', '_template', 'mfu_browse_to_add', 0x557365207468652042726f77736520627574746f6e20746f2061646420612066696c652c20616e6420746865205361766520627574746f6e20746f2075706c6f61642069742e, '2012-06-08 09:56:26', 'file manager'),
('en', '_template', 'mfu_cancel_uploads', 0x43616e63656c2072656d61696e696e672055706c6f616473, '2012-06-08 10:05:12', 'file manager'),
('en', '_template', 'mfu_default_total', 0x546f74616c3a20302066696c6573202830204b4229, '2012-06-08 10:06:05', 'file manager'),
('en', '_template', 'mfu_error', 0x6572726f72, '2012-06-08 10:02:50', 'file manager'),
('en', '_template', 'mfu_errors', 0x6572726f7273, '2012-06-08 10:03:13', 'file manager'),
('en', '_template', 'mfu_error_allowed', 0x46696c652075706c6f6164206572726f723a20796f7520686176652075706c6f61646564206173206d616e792066696c657320617320796f752061726520616c6c6f77656420647572696e6720746869732073657373696f6e, '2012-06-08 12:11:31', 'file manager'),
('en', '_template', 'mfu_error_failed', 0x46696c652075706c6f6164206572726f723a207468652075706c6f6164206661696c656420666f7220616e20756e6b6e6f776e20726561736f6e2e, '2012-06-08 12:12:01', 'file manager'),
('en', '_template', 'mfu_error_file_empty', 0x4f6e65206f72206d6f7265206f66207468652066696c6573207468617420796f7520617474656d7074656420746f2061646420636f6e7461696e6564206e6f20646174612e, '2012-06-08 12:13:30', 'file manager'),
('en', '_template', 'mfu_error_file_type', 0x4f6e65206f72206d6f72652066696c65732077657265206e6f7420616464656420746f20746865207175657565206265636175736520746865792077657265206f66207468652077726f6e6720747970652e, '2012-06-08 12:13:59', 'file manager'),
('en', '_template', 'mfu_error_msg', 0x2c2025317320253273, '2012-06-08 12:05:23', 'file manager'),
('en', '_template', 'mfu_error_network', 0x46696c652075706c6f6164206572726f723a2061206e6574776f726b206572726f72206f6363757265642e, '2012-06-08 12:11:06', 'file manager'),
('en', '_template', 'mfu_error_queue_limit', 0x596f752068617665206173206d616e792066696c657320696e207468652071756575652061732063616e206265206164646564206174206f6e652074696d652e2052656d6f76696e672066696c65732066726f6d20746865207175657565206d617920616c6c6f7720796f7520746f2061646420646966666572656e742066696c65732e, '2012-06-08 12:12:30', 'file manager'),
('en', '_template', 'mfu_error_size_limit', 0x4f6e65206f72206d6f7265206f66207468652066696c6573207468617420796f7520617474656d7074656420746f2061646420746f2074686520717565756520657863656564656420746865206c696d6974206f66202531732e, '2012-06-08 12:12:58', 'file manager'),
('en', '_template', 'mfu_error_unknown', 0x46696c652075706c6f6164206572726f723a2061206e6574776f726b206572726f72206f636375726564206f72207468652066696c65207761732072656a65637465642028726561736f6e20756e6b6e6f776e292e, '2012-06-08 12:10:26', 'file manager'),
('en', '_template', 'mfu_file', 0x66696c65, '2012-06-08 10:02:09', 'file manager'),
('en', '_template', 'mfu_filename', 0x46696c65204e616d65, '2012-06-08 09:56:54', 'file manager'),
('en', '_template', 'mfu_filename_placeholder', 0x46696c65204e616d6520506c616365686f6c646572, '2012-06-08 09:58:25', 'file manager'),
('en', '_template', 'mfu_files', 0x66696c6573, '2012-06-08 10:02:28', 'file manager'),
('en', '_template', 'mfu_files_not_added', 0x782066696c6573207765726520746f6f207920616e642077657265206e6f7420616464656420746f207468652071756575652e, '2012-06-08 10:08:03', 'file manager'),
('en', '_template', 'mfu_files_not_added2', 0x54686520666f6c6c6f77696e672066696c65732077657265206e6f742061646465643a, '2012-06-08 10:08:43', 'file manager'),
('en', '_template', 'mfu_file_list_waiting', 0x46696c65204c6973743a20202531732066696c65732075706c6f616465642c202532732066696c652077616974696e6720746f2062652075706c6f616465642e, '2012-06-08 12:05:54', 'file manager'),
('en', '_template', 'mfu_file_uploaded', 0x46696c652055706c6f61646564, '2012-06-08 12:07:48', 'file manager'),
('en', '_template', 'mfu_file_upload_error', 0x46696c652055706c6f6164204572726f72, '2012-06-08 12:08:12', 'file manager'),
('en', '_template', 'mfu_hide_list', 0x486964652074686973206c697374, '2012-06-08 10:09:27', 'file manager'),
('en', '_template', 'mfu_kb', 0x4b42, '2012-06-08 09:58:49', 'file manager'),
('en', '_template', 'mfu_no_file_list', 0x46696c65206c6973743a204e6f2066696c65732077616974696e6720746f2062652075706c6f616465642e, '2012-06-08 10:07:01', 'file manager'),
('en', '_template', 'mfu_press_delete', 0x50726573732044656c657465206b657920746f2072656d6f76652066696c65, '2012-06-08 12:09:02', 'file manager'),
('en', '_template', 'mfu_remove_error', 0x52656d6f7665204572726f72, '2012-06-08 10:09:56', 'file manager'),
('en', '_template', 'mfu_resume_uploads', 0x526573756d652055706c6f6164, '2012-06-08 10:05:34', 'file manager'),
('en', '_template', 'mfu_size', 0x53697a65, '2012-06-08 09:57:24', 'file manager'),
('en', '_template', 'mfu_stop_upload', 0x53746f702055706c6f6164, '2012-06-08 10:04:44', 'file manager'),
('en', '_template', 'mfu_tolarge_files', 0x2531732066696c6573207765726520746f6f206c6172676520616e642077657265206e6f7420616464656420746f207468652071756575652e, '2012-06-08 12:10:00', 'file manager'),
('en', '_template', 'mfu_tomany_files', 0x546f6f206d616e792066696c657320776572652073656c65637465642e202531732077657265206e6f7420616464656420746f207468652071756575652e, '2012-06-08 12:09:32', 'file manager'),
('en', '_template', 'mfu_to_upload', 0x546f2075706c6f61643a2025317320253273202825337329, '2012-06-08 12:03:38', 'file manager'),
('en', '_template', 'mfu_upload', 0x55706c6f6164, '2012-06-08 10:10:23', 'file manager'),
('en', '_template', 'mfu_uploaded', 0x55706c6f616465643a20253173206f662025327320253373202825347329253573, '2012-06-08 12:04:58', 'file manager'),
('en', '_template', 'mfu_uploading', 0x55706c6f6164696e673a20253173206f6620253273202533732028253473206f662025357329, '2012-06-08 12:04:11', 'file manager'),
('en', '_template', 'mfu_upload_limit', 0x25317320253273206d6178696d756d, '2012-06-08 12:03:07', 'file manager'),
('en', '_template', 'mfu_upload_queue', 0x46696c652055706c6f61642051756575653a, '2012-06-08 09:57:57', 'file manager'),
('en', '_template', 'mfu_warnings', 0x5761726e696e67733a, '2012-06-08 10:06:29', 'file manager'),
('en', '_template', 'minimum', 0x4d696e696d756d, '2003-05-20 13:08:57', 'instructor course statistics/details'),
('en', '_template', 'minutes', 0x2573206d696e2e, '2006-03-31 15:41:57', ''),
('en', '_template', 'minute_short', 0x6d, '2007-07-09 12:31:14', ''),
('en', '_template', 'missing', 0x4d697373696e67, '2005-10-05 14:02:53', ''),
('en', '_template', 'missing_content', 0x4d697373696e6720436f6e74656e74, '2005-03-07 15:25:10', ''),
('en', '_template', 'missing_info', 0x4d697373696e6720496e666f, '2005-08-17 13:23:48', ''),
('en', '_template', 'mobile', 0x4d6f62696c65, '2013-12-15 10:31:22', ''),
('en', '_template', 'mobile_active', 0x4d6f62696c6520616374697665, '2014-01-01 12:54:00', ''),
('en', '_template', 'mobile_disabled', 0x4d6f62696c652064697361626c6564, '2014-01-01 12:53:12', ''),
('en', '_template', 'mobile_theme', 0x4d6f62696c65205468656d65, '2010-06-18 15:46:42', ''),
('en', '_template', 'mobile_toggle', 0x546f67676c6520746f20737769746368206265747765656e206d6f62696c6520616e6420726573706f6e73697665207468656d6573, '2014-01-01 12:52:27', ''),
('en', '_template', 'modules', 0x4d6f64756c6573, '2005-08-16 13:40:42', ''),
('en', '_template', 'module_install_directory', 0x54686520666f6c6c6f77696e67206469726563746f7279206d757374206265206372656174656420666f722074686973206d6f64756c6520746f20696e7374616c6c20616e642066756e6374696f6e3a203c6b62643e25733c2f6b62643e2e, '2005-09-22 14:14:34', ''),
('en', '_template', 'module_name', 0x4d6f64756c65204e616d65, '2005-08-17 13:11:29', ''),
('en', '_template', 'module_uninstall', 0x556e696e7374616c6c204d6f64756c65, '2008-10-21 15:41:53', ''),
('en', '_template', 'mod_rewrite', 0x6d6f645f72657772697465, '2008-05-14 12:05:43', ''),
('en', '_template', 'monospaced', 0x4d6f6e6f737061636564, '2008-09-09 09:01:13', ''),
('en', '_template', 'month', 0x4d6f6e7468, '2004-06-24 15:45:43', ''),
('en', '_template', 'more_menu_items', 0x4d6f7265206d656e75206974656d73, '2013-12-28 12:30:39', ''),
('en', '_template', 'more_options', 0x4d6f7265206f7074696f6e732e2e2e, '2007-02-21 11:48:54', ''),
('en', '_template', 'move', 0x4d6f7665, '2004-01-15 13:31:18', 'editing content'),
('en', '_template', 'move_down', 0x4d6f766520446f776e, '2005-03-30 15:54:20', 'modules'),
('en', '_template', 'move_thread', 0x4d6f766520546f706963, '2014-01-02 15:40:51', ''),
('en', '_template', 'move_thread_to', 0x4d6f766520746f70696320746f3a, '2014-01-02 15:40:59', ''),
('en', '_template', 'move_to_inbox', 0x4d6f766520746f20496e626f78, '2007-02-22 13:09:26', ''),
('en', '_template', 'move_up', 0x4d6f7665205570, '2005-08-02 15:44:46', 'modules'),
('en', '_template', 'music', 0x4d75736963, '2009-05-27 12:01:11', ''),
('en', '_template', 'mutual_connections', 0x4d757475616c20436f6e6e656374696f6e73, '2009-06-12 15:42:42', ''),
('en', '_template', 'myown_patches', 0x4d79204f776e2050617463686573, '2008-04-21 15:08:55', ''),
('en', '_template', 'mysql_version', 0x4d7953514c2056657273696f6e, '2007-07-26 13:40:50', ''),
('en', '_template', 'my_account', 0x4d79204163636f756e74, '2005-03-28 14:04:37', ''),
('en', '_template', 'my_courses', 0x4d7920436f7572736573, '2004-04-15 12:05:31', ''),
('en', '_template', 'my_enrolled_courses', 0x4d7920656e726f6c6c656420636f7572736573, '2004-08-18 12:03:04', ''),
('en', '_template', 'my_files', 0x4d792046696c6573, '2006-03-20 14:40:42', ''),
('en', '_template', 'my_friends_only', 0x4f6e6c79206d7920636f6e7461637473, '2009-05-27 12:01:11', ''),
('en', '_template', 'my_groups', 0x4d79204e6574776f726b2047726f757073, '2009-05-27 12:01:11', ''),
('en', '_template', 'my_start_page', 0x4d792053746172742050616765, '2005-02-08 10:58:06', ''),
('en', '_template', 'my_tests', 0x4d7920546573747320616e642053757276657973, '2010-06-25 14:01:48', ''),
('en', '_template', 'my_tracker', 0x4d7920547261636b6572, '2003-05-20 13:12:27', 'global my tracker  heading'),
('en', '_template', 'na', 0x4e2f41, '2003-05-20 13:12:48', 'short form for "not applicable"'),
('en', '_template', 'name', 0x4e616d65, '2003-05-20 13:31:04', 'file manager, zip utility column heading'),
('en', '_template', 'name_in_english', 0x4c616e6775616765206e616d6520696e20456e676c697368, '2004-11-20 19:41:16', 'admin add language'),
('en', '_template', 'name_in_language', 0x4c616e6775616765206e616d65207472616e736c61746564, '2004-11-20 19:39:49', '');
INSERT INTO `AT_language_text` (`language_code`, `variable`, `term`, `text`, `revised_date`, `context`) VALUES
('en', '_template', 'native-american', 0x4e61746976652d416d65726963616e, '2008-09-09 09:01:12', ''),
('en', '_template', 'navigation', 0x4e617669676174696f6e, '2008-09-09 09:03:56', ''),
('en', '_template', 'nav_path', 0x4e617669676174696f6e205061746820666f722055736572, '2003-05-20 13:31:22', 'tracker'),
('en', '_template', 'nav_tendencies', 0x4e617669676174696f6e2054656e64656e6369657320666f722055736572, '2003-05-20 13:32:03', 'tracker'),
('en', '_template', 'netherlands-ngt', 0x4e65746865726c616e64732d4e4754, '2008-09-09 09:01:13', ''),
('en', '_template', 'network_home', 0x4d79204e6574776f726b, '2009-05-27 12:01:11', ''),
('en', '_template', 'network_updates', 0x4e6574776f726b204163746976697479, '2009-05-27 12:01:11', ''),
('en', '_template', 'never', 0x4e65766572, '2005-03-03 11:03:01', ''),
('en', '_template', 'new', 0x4e657721, '2003-05-20 13:32:52', 'forum/inbox new message indicator'),
('en', '_template', 'new_account_enroll', 0x412075736572206163636f756e7420686173206265656e206372656174656420666f7220796f752061742025317320616e6420796f752068617665206265656e20656e726f6c6c656420696e746f2074686520636f75727365202532732e20546f20616363657373207468697320636f757273652c20706c65617365206c6f6720696e746f2074686520736974652e204974206973207374726f6e676c792073756767657374656420796f75206368616e676520796f75722070617373776f72642075706f6e206c6f6767696e6720696e2e, '2005-06-24 15:33:45', 'Message emailed to new users as a result of enrollment.'),
('en', '_template', 'new_account_enroll_confirm', 0x596f752068617665206265656e20656e726f6c6c656420696e746f2074686520636f75727365202531732e20546f20616363657373207468697320636f757273652c20796f75206d75737420666972737420636f6e6669726d20796f7572206163636f756e74206279207573696e672074686520666f6c6c6f77696e67206c696e6b3a202532732e204974206973207374726f6e676c792073756767657374656420796f75206368616e676520796f75722070617373776f72642075706f6e206c6f6767696e6720696e2e, '2005-06-24 15:33:17', 'If new user created during enrollment and needs confirmation.'),
('en', '_template', 'new_file', 0x4e65772046696c65, '2006-03-20 14:36:14', ''),
('en', '_template', 'new_group_invitations', 0x4e65772047726f757020496e7669746174696f6e73, '2009-05-27 12:01:11', ''),
('en', '_template', 'new_group_requests', 0x4a6f696e2047726f7570205265717565737473, '2013-10-19 18:42:08', ''),
('en', '_template', 'new_name', 0x4e6577204e616d65, '2005-03-07 13:26:12', 'filemanager rename file'),
('en', '_template', 'new_thread', 0x4e657720546f706963, '2014-01-02 15:41:13', 'forum'),
('en', '_template', 'new_type', 0x4e657720547970653a, '2006-03-22 15:11:48', ''),
('en', '_template', 'new_user', 0x4e65772055736572, '2005-07-27 15:06:36', ''),
('en', '_template', 'new_window', 0x4f70656e7320696e2061206e65772077696e646f772e, '2010-04-22 13:41:52', ''),
('en', '_template', 'next', 0x4e657874, '2003-05-20 13:38:07', 'sequence arrow link text'),
('en', '_template', 'next_topic', 0x4e65787420546f706963, '2003-05-20 13:38:42', 'sequence arrow link text'),
('en', '_template', 'no', 0x4e6f, '2005-03-03 10:18:39', 'the word no, preferences, admin course manager'),
('en', '_template', 'no_item_selected', 0x596f75206d7573742073656c65637420616e206974656d206265666f7265207573696e67206120627574746f6e2e, '2014-08-20 10:18:39', 'message displayed when duplicate button on test/surveys index page is pressed'),
('en', '_template', 'none', 0x4e6f6e65, '2003-05-20 13:40:59', 'global message when no results were retrieved'),
('en', '_template', 'none_available', 0x4e6f6e6520617661696c61626c652e, '2003-05-20 13:41:46', 'instructor add/edit content, glossary'),
('en', '_template', 'none_found', 0x4e6f6e6520466f756e642e, '2005-05-18 13:12:47', 'glossary, related topis, users online'),
('en', '_template', 'non_group_members', 0x4e6f6e2d47726f7570204d656d62657273, '2005-06-10 10:51:55', ''),
('en', '_template', 'norwegian-nsl', 0x4e6f7277656769616e2d4e534c, '2008-09-09 09:01:13', ''),
('en', '_template', 'notes', 0x4e6f746573, '2003-05-20 13:43:39', 'admin hime, instructor request notes column heading'),
('en', '_template', 'note_taking', 0x4e6f74652054616b696e67, '2008-09-09 09:03:56', ''),
('en', '_template', 'notification_accept_contact', 0x257320686173206265656e20616464656420746f20796f757220415475746f7220536f6369616c20636f6e74616374732e20466f6c6c6f7720746865206c696e6b2062656c6f7720746f2072657669657720796f7572206e657720636f6e746163742e200d0a0d0a2d2d2d2d2d2d0d0a53656e742066726f6d20415475746f7220536f6369616c2061743a0d0a25730d0a, '2009-05-27 12:01:11', ''),
('en', '_template', 'notification_group_invite', 0x25732068617320696e766974656420796f7520746f206a6f696e207468652025732067726f75702e20466f6c6c6f7720746865206c696e6b2062656c6f7720746f206c6f67696e20616e6420616363657074206f722072656a6563742074686520696e7669746174696f6e2e200d0a0d0a2d2d2d2d2d2d0d0a53656e742066726f6d20415475746f7220536f6369616c2061743a0d0a25730d0a, '2009-05-27 12:01:11', ''),
('en', '_template', 'notification_group_invite_accepted', 0x25732068617320616363657074656420796f75722020696e7669746174696f6e20746f206a6f696e207468652025732067726f75702e20466f6c6c6f7720746865206c696e6b2062656c6f7720746f206c6f67696e20746f207468652067726f75702e0d0a0d0a2d2d2d2d2d2d0d0a4c6f67696e20746f20415475746f7220536f6369616c2061743a0d0a25730d0a, '2009-05-27 12:01:11', ''),
('en', '_template', 'notification_group_request', 0x41207265717565737420686173206265656e206d61646520746f206a6f696e207468652025732067726f757020466f6c6c6f7720746865206c696e6b2062656c6f7720746f206c6f67696e20616e6420616363657074206f722072656a6563742074686520726571756573742e0d0a0d0a2d2d2d2d2d2d0d0a4c6f67696e20746f20415475746f7220536f6369616c2061743a0d0a25730d0a, '2009-05-27 12:01:11', ''),
('en', '_template', 'notification_group_request_accepted', 0x596f7572207265717565737420746f206a6f696e207468652025732067726f757020686173206265656e2061636365707465642e20466f6c6c6f7720746865206c696e6b2062656c6f7720746f206c6f67696e20746f207468652067726f75702e0d0a0d0a2d2d2d2d2d2d0d0a4c6f67696e20746f20415475746f7220536f6369616c2061743a0d0a25730d0a, '2009-05-27 12:01:11', ''),
('en', '_template', 'notification_new_contact', 0x25732077616e747320746f2061646420796f7520746f206173206120415475746f7220536f6369616c20636f6e746163742e20466f6c6c6f7720746865206c696e6b2062656c6f7720746f206c6f67696e20616e6420616363657074206f722072656a6563742074686520726571756573742e200d0a0d0a2d2d2d2d2d2d0d0a53656e742066726f6d20415475746f7220536f6369616c2061743a0d0a25730d0a, '2009-05-27 12:01:11', ''),
('en', '_template', 'notification_new_inbox', 0x596f7520686176652072656365697665642061206e6577206d6573736167652066726f6d2025732e204c6f67696e20746f2061636365737320796f757220696e626f7820616e64207669657720746865206d6573736167652e204c6f67696e2061743a202573, '2005-05-17 14:20:35', 'notification message for new mail in inbox'),
('en', '_template', 'notify', 0x4e6f74696679, '2003-05-20 13:45:17', 'admin course properties'),
('en', '_template', 'not_added_members', 0x496e766974652047726f7570204d656d62657273, '2009-05-27 12:01:11', ''),
('en', '_template', 'not_created', 0x4e6f742043726561746564, '2005-05-10 15:23:30', ''),
('en', '_template', 'not_editable', 0x4e6f74206564697461626c652e, '2006-03-20 15:17:50', ''),
('en', '_template', 'not_enrolled', 0x4e6f7420456e726f6c6c6564, '2005-03-23 14:23:18', 'user status on my courses page'),
('en', '_template', 'not_installed', 0x4e6f7420496e7374616c6c6564, '2008-10-28 10:58:52', ''),
('en', '_template', 'not_overwrite', 0x4e6f74206f7665727772697465, '2008-09-25 16:01:17', 'gradebook'),
('en', '_template', 'not_specified', 0x4e6f7420737065636966696564, '2003-05-12 15:26:26', 'registration gender selection'),
('en', '_template', 'not_submitted_assessment', 0x596f7520686176656e2774207375626d697474656420746865206173736573736d656e742e20596f757220616e737765727320776f756c64206265206175746f6d61746963616c6c792073617665642e, '2014-08-20 15:26:26', 'leave test page without submitting'),
('en', '_template', 'now_friends1', 0x616e6420257320617265206e6f7720636f6e74616374732e, '2009-05-27 12:01:11', ''),
('en', '_template', 'now_friends2', 0x616e6420257320617265206e6f7720636f6e7461637473, '2009-05-27 12:01:11', ''),
('en', '_template', 'no_activities', 0x4e6f206e6574776f726b2061637469766974792e, '2009-05-27 12:01:11', ''),
('en', '_template', 'no_announcements', 0x4e6f20416e6e6f756e63656d656e747320466f756e64, '2003-05-20 13:55:19', 'course homepage when no announcments exist'),
('en', '_template', 'no_content_avail', 0x4e6f20636f6e74656e7420617661696c61626c652e, '2005-10-20 11:00:59', ''),
('en', '_template', 'no_courses', 0x546865726520617265206e6f20617661696c61626c6520636f75727365732e, '2003-05-20 13:57:26', 'browse message when no courses exist'),
('en', '_template', 'no_courses_found', 0x4e6f20636f757273657320666f756e642e, '2003-05-20 13:58:31', 'message when query resuylt in no courses found, admin course manager'),
('en', '_template', 'no_course_found', 0x436f75727365206e6f7420666f756e642e, '2003-10-15 14:31:39', 'course not found'),
('en', '_template', 'no_description', 0x4e6f206465736372697074696f6e20617661696c61626c652e, '2004-08-20 15:00:55', ''),
('en', '_template', 'no_due_date', 0x4e6f206475652064617465, '2006-05-30 12:37:39', ''),
('en', '_template', 'no_end_date', 0x4e6f20656e642064617465, '2007-07-16 14:27:07', ''),
('en', '_template', 'no_forums', 0x4e6f20466f72756d7320466f756e64, '2003-05-20 13:59:58', 'discussions message when no forums exist'),
('en', '_template', 'no_friends', 0x596f752068617665206e6f20636f6e7461637473207965742e, '2009-05-27 12:01:11', ''),
('en', '_template', 'no_gadgets_installed', 0x596f752068617665206e6f7420696e7374616c6c656420616e792067616467657473207965742e, '2009-05-27 12:01:11', ''),
('en', '_template', 'no_glossary_items', 0x4e6f20676c6f7373617279207465726d7320666f756e642e, '2005-03-07 10:52:11', 'edit glossary'),
('en', '_template', 'no_groups_yet', 0x596f752068617665206e6f74206a6f696e656420616e792067726f757073207965742e, '2009-05-27 12:01:11', ''),
('en', '_template', 'no_icon', 0x4e6f2049636f6e, '2005-03-03 11:20:05', ''),
('en', '_template', 'no_month_data', 0x5468657265206973206e6f206461746120666f722074686973206d6f6e74682e, '2003-05-20 14:01:42', 'instructor course statistics when nonne exist'),
('en', '_template', 'no_pass_score', 0x4e6f20706173732073636f7265, '2008-03-10 11:50:35', 'Test/Survey Property'),
('en', '_template', 'no_post', 0x4e6f20706f737420666f756e642e, '2003-05-20 14:02:44', 'forums message when attempting to view a post that no longer exists'),
('en', '_template', 'no_questions', 0x4e6f207175657374696f6e7320666f756e642e, '2003-05-20 14:04:01', 'test manager message when no questions exist for a test.'),
('en', '_template', 'no_results_available', 0x4e6f20526573756c747320417661696c61626c65, '2003-05-20 14:07:22', 'test manager'),
('en', '_template', 'no_results_yet', 0x4e6f20526573756c747320596574, '2003-05-20 14:07:32', 'my tests'),
('en', '_template', 'no_settings', 0x5468657265206973206e6f20617661696c61626c652073657474696e67732e, '2009-06-09 14:25:23', ''),
('en', '_template', 'no_student_tools', 0x4e6f2053747564656e7420546f6f6c7320466f756e64, '2010-12-07 16:51:03', ''),
('en', '_template', 'no_terms_found', 0x546865726520617265206e6f20676c6f7373617279207465726d73206265696e67207573656420696e207468697320636f6e74656e7420706167652e, '2004-01-16 10:52:51', 'content editor'),
('en', '_template', 'no_tests', 0x4e6f205465737473206f72205375727665797320417661696c61626c65, '2004-08-25 14:04:15', ''),
('en', '_template', 'no_title', 0x4e6f207469746c652e, '2005-10-20 11:00:45', ''),
('en', '_template', 'no_user_found', 0x4e6f207573657220666f756e64, '2003-05-20 14:09:41', 'admin user amanager, profile'),
('en', '_template', 'num', 0x4e6f2e, '2003-05-20 14:10:36', 'short form for the word number, test manager'),
('en', '_template', 'number_of_groups', 0x4e756d626572206f662047726f757073, '2006-03-22 11:48:03', ''),
('en', '_template', 'number_of_members', 0x4e756d626572206f66204d656d62657273, '2009-05-27 12:01:11', ''),
('en', '_template', 'number_of_students_per_group', 0x4e756d626572206f662053747564656e7473207065722047726f7570, '2006-03-22 11:52:10', ''),
('en', '_template', 'num_pages', 0x23207061676573, '2005-03-16 13:54:47', 'content manager'),
('en', '_template', 'num_posts', 0x4e756d626572206f6620506f737473, '2005-04-14 11:07:00', ''),
('en', '_template', 'num_questions_per_test', 0x7175657374696f6e732070657220746573742e, '2004-08-23 16:13:24', ''),
('en', '_template', 'num_students_currently_enrolled', 0x546865726520617265203c656d3e25733c2f656d3e2073747564656e74732063757272656e746c7920656e726f6c6c656420696e207468697320636f757273652e, '2006-03-22 13:02:01', ''),
('en', '_template', 'num_takes_test', 0x417474656d70747320416c6c6f776564, '2004-08-26 10:34:04', ''),
('en', '_template', 'num_threads', 0x4e756d626572206f6620546f70696373, '2014-01-02 15:41:28', ''),
('en', '_template', 'oauth_expire', 0x4f4175746820457870697265205468726573686f6c64, '2010-05-05 16:18:12', ''),
('en', '_template', 'oauth_expire_note', 0x4e6f74653a205768656e2022457870697265205468726573686f6c64222069732073657420746f20302c20746865206f6175746820746f6b656e206e6576657220657870697265732e, '2010-05-05 16:18:55', ''),
('en', '_template', 'off', 0x4f6666, '2013-10-06 20:03:36', 'switch off'),
('en', '_template', 'ok', 0x4f4b, '2004-01-30 11:54:41', ''),
('en', '_template', 'on', 0x6f6e, '2003-05-20 14:11:28', 'admin course manager properties tracking option'),
('en', '_template', 'one_page', 0x4f6e652050616765, '2003-05-20 14:12:22', 'test manager open ended question type'),
('en', '_template', 'one_question_per_page', 0x4f6e65207175657374696f6e207065722070616765, '2007-08-20 15:46:36', 'edit/create test'),
('en', '_template', 'one_sentence', 0x4f6e652053656e74656e6365, '2003-05-20 14:12:46', 'test manager open ended question type'),
('en', '_template', 'one_word', 0x4f6e6520576f7264, '2003-05-20 14:12:53', 'test manager open ended question type'),
('en', '_template', 'ongoing', 0x4f6e20476f696e6721, '2003-05-20 14:13:23', 'mytest currently running test indicator'),
('en', '_template', 'online_status', 0x4f6e6c696e6520537461747573, '2005-03-11 16:18:30', 'directory'),
('en', '_template', 'only_show_edited_terms', 0x4f6e6c792073686f772065646974207465726d732e, '2006-09-25 13:08:06', 'language editor filter form'),
('en', '_template', 'open_file_manager', 0x4f70656e2046696c65204d616e61676572, '2004-11-25 17:31:08', ''),
('en', '_template', 'open_sub_navigation', 0x2e20546f67676c6520737562206e617669676174696f6e206f70656e, '2013-12-26 17:30:05', ''),
('en', '_template', 'optional', 0x4f7074696f6e616c, '2003-05-20 14:40:09', 'registration screen'),
('en', '_template', 'optional_description', 0x4f7074696f6e616c204465736372697074696f6e, '2004-10-27 15:31:07', ''),
('en', '_template', 'optional_feedback', 0x4f7074696f6e616c20466565646261636b, '2004-11-24 14:33:15', ''),
('en', '_template', 'option_alignment', 0x416c69676e6d656e74, '2004-12-01 13:36:36', 'edit/create option in test questions'),
('en', '_template', 'or', 0x4f72, '2003-05-20 14:40:26', 'global word or'),
('en', '_template', 'orange', 0x4f72616e6765, '2003-05-20 14:40:40', 'global code picker'),
('en', '_template', 'order', 0x4f72646572, '2005-03-04 14:07:25', ''),
('en', '_template', 'organization', 0x4f7267616e697a6174696f6e, '2008-10-06 13:41:24', ''),
('en', '_template', 'original_resource', 0x4f726967696e616c207265736f75726365, '2010-03-09 16:16:17', 'adapted content'),
('en', '_template', 'original_term', 0x4f726967696e616c207465726d, '2006-09-25 13:09:48', ''),
('en', '_template', 'origin_page', 0x4f726967696e6174696e672050616765, '2003-05-20 14:40:57', 'tracker'),
('en', '_template', 'or_groups', 0x4f722c2047726f7570733a, '2006-08-28 15:58:14', ''),
('en', '_template', 'os', 0x3c6163726f6e796d207469746c653d224f7065726174696e672053797374656d223e4f533c2f6163726f6e796d3e, '2007-07-26 14:04:11', ''),
('en', '_template', 'other', 0x4f74686572, '2005-03-03 12:17:32', ''),
('en', '_template', 'others', 0x4f7468657273, '2009-05-27 12:01:11', ''),
('en', '_template', 'out_of', 0x4d6178696d756d2053636f7265, '2008-07-17 08:36:47', 'mytests, score out of ...'),
('en', '_template', 'override', 0x4f766572726964652073656c656374696f6e732077697468207468697320636f75727365277320637573746f6d20436f6c6f7572202620466f6e74207468656d652e20203c736d616c6c20636c6173733d22737061636572223e2820496620617661696c61626c652e20293c2f736d616c6c3e, '2003-05-20 14:42:37', 'preferences page'),
('en', '_template', 'overwite_content', 0x4f7665727772697465206578697374696e67206d6174657269616c20776974682074686f73652073656c6563746564, '2004-10-15 14:18:47', ''),
('en', '_template', 'overwrite', 0x4f7665727772697465, '2004-11-09 15:24:23', 'file manager'),
('en', '_template', 'overwrite_master', 0x496620616e206578697374696e67206163636f756e74206973207573696e6720746869732053747564656e742049442c206f7665727772697465206173736f63696174696f6e2077697468206e6577206163636f756e742e, '2006-06-12 13:58:31', ''),
('en', '_template', 'packaged_in', 0x436f6e74656e74205061636b616765, '2003-10-07 18:21:34', 'apckage label in edit content'),
('en', '_template', 'packages', 0x5061636b61676573, '2005-05-17 12:09:25', ''),
('en', '_template', 'packages_auto_advance', 0x4175746f6d61746963616c6c79207374617274206e657874204c6561726e696e67204f626a656374, '2005-05-17 12:10:27', ''),
('en', '_template', 'package_settings', 0x5061636b6167652053657474696e6773, '2005-05-17 12:06:33', ''),
('en', '_template', 'package_type', 0x5061636b6167652054797065, '2005-05-17 12:09:36', ''),
('en', '_template', 'package_type_info', 0x506c656173652073656c656374207468652074797065206f66207061636b61676520796f75207769736820746f2075706c6f61642e, '2005-05-17 12:07:10', ''),
('en', '_template', 'package_upload_file', 0x5061636b6167652046696c65, '2005-05-17 12:07:32', ''),
('en', '_template', 'package_upload_file_info', 0x53656c65637420746865207061636b6167652066696c652066726f6d20796f757220636f6d7075746572, '2005-05-17 12:07:20', ''),
('en', '_template', 'package_upload_url', 0x5061636b6167652055524c, '2005-05-17 12:06:58', ''),
('en', '_template', 'package_upload_url_info', 0x6f722073706563696679207468652055524c20746f20796f7572207765622061636365737369626c65207061636b6167652066696c65, '2005-05-17 12:06:47', ''),
('en', '_template', 'page', 0x50616765, '2003-05-20 14:43:17', 'forum thread pages menu, tracker pages menu'),
('en', '_template', 'pages_found', 0x257320706167657320666f756e64, '2004-08-20 15:09:44', ''),
('en', '_template', 'pages_stats', 0x5061676520547261636b696e67205374617469737469637320666f722025732e, '2003-06-08 09:20:38', 'tracker'),
('en', '_template', 'page_error', 0x416e206572726f72206f636375726564207768696c652067656e65726174696e672074686520706167696e61746f72, '2003-05-20 14:44:01', 'tracker'),
('en', '_template', 'page_info', 0x4c617374204d6f6469666965643a2025732e20205265766973696f6e3a2025732e202052656c6561736520446174653a2025732e, '2004-02-12 11:27:02', ''),
('en', '_template', 'page_stats', 0x436f6e74656e7420547261636b696e672053756d6d617279, '2003-05-20 14:44:48', 'tracker'),
('en', '_template', 'page_title', 0x50616765205469746c65, '2003-05-20 14:45:16', 'tracker column heading'),
('en', '_template', 'page_viewed', 0x5061676520566965776564, '2003-05-20 14:45:44', 'tracker'),
('en', '_template', 'parent', 0x506172656e74, '2005-03-29 13:04:13', 'categories'),
('en', '_template', 'partially_uninstalled', 0x5061727469616c6c7920556e696e7374616c6c6564, '2008-10-21 15:41:53', ''),
('en', '_template', 'password', 0x50617373776f7264, '2003-05-20 14:45:56', 'global password word'),
('en', '_template', 'password_again', 0x50617373776f726420416761696e, '2003-05-20 14:46:52', 'registration, edit profile'),
('en', '_template', 'password_blurb', 0x456e74657220796f7572206163636f756e74277320656d61696c20616464726573732062656c6f7720616e6420616e20656d61696c207769746820696e737472756374696f6e73206f6e2072657472696576696e6720796f75722070617373776f72642077696c6c2062652073656e7420746f20796f752e2054686520656d61696c2061646472657373206d757374206265207468652073616d6520617320746865206f6e6520796f75207573656420666f720d0a726567697374726174696f6e2e, '2006-06-08 11:20:16', ''),
('en', '_template', 'password_changed', 0x50617373776f7264204368616e6765, '2005-11-30 13:54:49', ''),
('en', '_template', 'password_change_confirm', 0x596f75722070617373776f7264206f6e20257320686173206265656e206368616e676564207375636365737366756c6c792e20476f20746f20257320746f206c6f67696e2e, '2006-05-09 15:28:37', ''),
('en', '_template', 'password_change_msg', 0x596f75722070617373776f726420686173206265656e20616c74657265642e20506c65617365207573652074686520696e666f726d6174696f6e2062656c6f772e, '2005-11-30 13:55:47', ''),
('en', '_template', 'password_forgot', 0x466f72676f742050617373776f7264, '2006-05-09 15:00:16', ''),
('en', '_template', 'password_new_blurb', 0x456e7465722061206e65772070617373776f726420666f7220796f7572206163636f756e742e, '2006-05-09 15:54:44', ''),
('en', '_template', 'password_old', 0x4f6c642050617373776f7264, '2006-05-11 11:34:39', ''),
('en', '_template', 'password_reminder', 0x466f72676f7420796f75722070617373776f72643f, '2006-05-09 14:29:49', 'password reminder screen heading, public login header'),
('en', '_template', 'password_reminder_text', 0x496620796f752068617665206c6f737420796f75722070617373776f72642c207573652074686520666f72676f7474656e2070617373776f7264206665617475726520746f2072656761696e2061636365737320746f20796f7572206163636f756e742e, '2006-05-09 14:56:46', ''),
('en', '_template', 'password_request2', 0x4465617220253124732c0d0a0d0a596f7572206c6f67696e206e616d6520697320253224732e0d0a0d0a546f207365742061206e65772070617373776f72642c20666f6c6c6f7720746865206c696e6b2062656c6f772e200d0a0d0a253424730d0a0d0a2849662074686973206c696e6b20646f6573206e6f742074616b6520796f7520746f2074686520736974652c20636f707920616e6420706173746520697420696e746f20746865206164647265737320626172206f6620796f757220696e7465726e65742062726f77736572290d0a0d0a546865206c696e6b2077696c6c206265636f6d6520696e76616c6964206166746572202533247320646179732e, '2009-01-23 10:49:55', 'password reminder'),
('en', '_template', 'pass_feedback', 0x5061737320466565646261636b, '2008-03-10 11:49:19', 'Test/Survey Property'),
('en', '_template', 'pass_score', 0x506173732053636f7265, '2008-03-10 08:46:46', 'Test/Survey property'),
('en', '_template', 'paste', 0x5061737465, '2004-12-03 10:30:28', 'form_editor in create question'),
('en', '_template', 'paste_disabled_title', 0x50617374652066726f6d2066696c652064697361626c6564, '2010-04-14 11:25:30', ''),
('en', '_template', 'paste_enabled_title', 0x546f67676c652070617374652066726f6d2066696c65, '2010-04-14 11:25:05', ''),
('en', '_template', 'paste_file', 0x50617374652046726f6d2046696c65, '2003-05-20 14:49:35', 'instructor content editor'),
('en', '_template', 'patcher', 0x50617463686572, '2008-04-21 15:08:55', ''),
('en', '_template', 'patcher_alter_modified_files', 0x546865206c69737465642066696c657320617265206d6f646966696564206c6f63616c6c792e20496620796f752063686f6f736520746f2070726f636565642c20796f7572206c6f63616c2066696c652077696c6c206265206d6f6469666965642e20546865206f726967696e616c0d0a66696c652077696c6c206265206261636b6564207570206265666f726520746865206d6f64696669636174696f6e2e20506c65617365206e6f7465207468617420746865206d6f64696669636174696f6e20746f20796f757220637573746f6d697a656420636f6465206d617920627265616b20796f757220637573746f6d697a6174696f6e2e3c6272202f3e, '2008-07-28 10:52:09', 'patcher'),
('en', '_template', 'patcher_overwrite_modified_files', 0x546865206c69737465642066696c65732068617665206265656e206d6f646966696564206c6f63616c6c792e20496620796f752063686f6f736520746f2070726f636565642c207468652070617463682066696c652077696c6c20626520636f7069656420746f20796f7572206c6f63616c206d616368696e652e200d0a596f75206861766520746f206d616e75616c6c79206d6572676520746869732066696c6520616e6420796f7572206c6f63616c20636f70792e3c6272202f3e, '2008-07-28 10:52:22', 'patcher'),
('en', '_template', 'patcher_show_backup_files', 0x42656c6f7720697320746865206c697374206f6620746865206261636b75702066696c657320637265617465642062792074686520506174636865722e20416674657220656e737572696e6720415475746f7220776f726b732070726f7065726c792077697468207468652070617463682c20796f75206d61792077616e7420746f200d0a64656c6574652074686573652066696c65732e2049662020415475746f7220646f6573206e6f7420776f726b2070726f7065726c792077697468207468652070617463682c20796f752063616e20616c7761797320726576657274206261636b20746f20746865206f6c642066696c65732062792072656e616d696e6720746865206261636b75702066696c6573200d0a746f20746865206f726967696e616c2066696c65206e616d65732c202072656d6f76696e6720746865205b70617463685f69645d2e6f6c6420706f7274696f6e206f66207468652066696c65206e616d652e203c6272202f3e, '2008-07-28 10:52:38', 'patcher'),
('en', '_template', 'patcher_show_patch_files', 0x42656c6f7720697320746865206c697374206f66207468652070617463682066696c657320636f7069656420746f20796f757220636f6d70757465722e200d0a506c65617365206d616e75616c6c79206d6572676520746865206368616e676573206265747765656e207468652070617463682066696c657320616e6420796f7572206c6f63616c20636f70792e203c6272202f3e, '2008-07-28 10:52:51', 'patcher'),
('en', '_template', 'patch_dependent_patch_not_installed', 0x3c62723e3c7370616e207374796c653d22636f6c6f723a20726564223e5761726e696e673a2054686572652061726520706174636820646570656e64656e636965732c20706c6561736520696e7374616c6c20746865206c697374656420706174636865732066697273743a203c2f7370616e3e, '2008-04-22 14:56:15', 'patcher'),
('en', '_template', 'patch_local_file_not_exist', 0x43616e6e6f742070726f636565642e20546865206c69737465642066696c657320646f206e6f74206578697374206f6e20796f7572206c6f63616c206d616368696e652e20496620796f752072656e616d6564207468652066696c652c20696e206f7264657220746f2070726f636565642c20706c656173652072656e616d65206261636b2e3c6272202f3e, '2008-07-28 10:53:03', 'patcher'),
('en', '_template', 'path_not_allowed', 0x43616e6e6f742070726f636565642120546865206c69737465642066696c652070617468287329206973206e6f7420616c6c6f7765643a3c6272202f3e, '2010-09-30 13:47:40', 'patcher'),
('en', '_template', 'pa_add_more_photos', 0x416464204d6f72652050686f746f73, '2010-03-17 15:53:59', 'photo album'),
('en', '_template', 'pa_albums', 0x416c62756d73, '2010-03-17 15:49:41', 'photo album'),
('en', '_template', 'pa_album_cover', 0x416c62756d20436f766572, '2010-03-17 15:57:45', 'photo album'),
('en', '_template', 'pa_album_description', 0x416c62756d204465736372697074696f6e, '2010-03-17 15:57:34', 'photo album'),
('en', '_template', 'pa_album_location', 0x416c62756d204c6f636174696f6e, '2010-03-17 15:57:24', 'photo album'),
('en', '_template', 'pa_album_name', 0x416c62756d204e616d65, '2010-03-17 15:57:02', 'photo album'),
('en', '_template', 'pa_album_permission', 0x416c62756d205065726d697373696f6e, '2010-03-17 16:04:31', 'photo album'),
('en', '_template', 'pa_album_type', 0x416c62756d2054797065, '2010-03-17 15:57:13', 'photo album'),
('en', '_template', 'pa_alt_text', 0x416c7465726e61746976652054657874, '2010-03-17 15:59:00', 'photo album'),
('en', '_template', 'pa_choose_profile_picture', 0x55706c6f61642050726f66696c652050696374757265, '2010-03-25 16:00:58', 'photo album'),
('en', '_template', 'pa_click_here_to_edit', 0x436c69636b206865726520746f2065646974, '2010-03-17 16:00:54', 'photo album'),
('en', '_template', 'pa_click_item_to_edit', 0x436c69636b206974656d20746f2065646974, '2010-03-17 16:01:06', 'photo album'),
('en', '_template', 'pa_close_upload_manager', 0x436c6f73652055706c6f6164204d616e61676572, '2010-03-17 16:04:18', 'photo album'),
('en', '_template', 'pa_course_albums', 0x436f7572736520416c62756d73, '2010-03-17 15:58:28', 'photo album'),
('en', '_template', 'pa_create_album', 0x43726561746520416c62756d, '2010-03-17 15:58:50', 'photo album'),
('en', '_template', 'pa_delete_album', 0x44656c65746520416c62756d, '2010-03-17 15:51:21', 'photo album'),
('en', '_template', 'pa_delete_comment', 0x44656c65746520436f6d6d656e74, '2010-03-17 15:51:34', 'photo album'),
('en', '_template', 'pa_delete_photo', 0x44656c6574652050686f746f, '2010-03-17 15:51:47', 'photo album'),
('en', '_template', 'pa_delete_profile_pic_blub', 0x596f752063616e2072656d6f7665207468697320706963747572652c20627574206265207375726520746f2075706c6f616420616e6f74686572206f722077652077696c6c20646973706c617920612073696c686f756574746520696e2069747320706c6163652e, '2010-03-25 16:04:19', 'photo album'),
('en', '_template', 'pa_delete_this_photo', 0x44656c65746520546869732050686f746f, '2010-03-17 15:53:32', 'photo album'),
('en', '_template', 'pa_edit_album', 0x4564697420416c62756d, '2010-03-17 15:51:09', 'photo album'),
('en', '_template', 'pa_edit_photo', 0x456469742050686f746f, '2010-03-17 15:50:55', 'photo album'),
('en', '_template', 'pa_edit_photos', 0x456469742050686f746f73, '2010-03-17 15:50:39', 'photo album'),
('en', '_template', 'pa_last_updated', 0x4c6173742055706461746564, '2010-03-17 15:58:00', 'photo album'),
('en', '_template', 'pa_max_memory', 0x4d6178696d756d204d656d6f72792053697a6520616c6c6f77656420706572206d656d626572, '2010-03-17 16:01:42', 'photo album'),
('en', '_template', 'pa_memory_usage', 0x4d656d6f7279205573616765, '2010-03-17 16:03:53', 'photo album'),
('en', '_template', 'pa_my_albums', 0x4d7920416c62756d73, '2010-03-17 15:58:14', 'photo album'),
('en', '_template', 'pa_no_album', 0x4e6f20416c62756d20417661696c61626c65, '2010-03-17 15:59:28', 'photo album'),
('en', '_template', 'pa_no_image', 0x4e6f20696d616765, '2010-03-17 15:59:52', 'photo album'),
('en', '_template', 'pa_no_photos', 0x4e6f2050686f746f7320417661696c61626c65, '2010-03-17 15:59:39', 'photo album'),
('en', '_template', 'pa_of', 0x6f66, '2010-03-17 16:00:19', 'photo album'),
('en', '_template', 'pa_open_upload_manager', 0x4f70656e2055706c6f6164204d616e61676572, '2010-03-17 16:04:07', 'photo album'),
('en', '_template', 'pa_organize_photos', 0x4f7267616e697a652050686f746f73, '2010-03-17 15:53:45', 'photo album'),
('en', '_template', 'pa_organize_photo_blurb', 0x4e6f74653a20447261672070686f746f73207573696e672061206d6f7573652c206f72205b4354524c5d2b5b4c6566742f52696768742f55702f446f776e204172726f775d206b65797320746f207265617272616e6765207468656d2e, '2010-03-17 16:00:09', 'photo album'),
('en', '_template', 'pa_photo', 0x50686f746f, '2010-03-17 15:49:57', 'photo album'),
('en', '_template', 'pa_photos', 0x50686f746f73, '2010-03-17 15:50:12', 'photo album'),
('en', '_template', 'pa_photo_gallery', 0x50686f746f2047616c6c657279, '2010-03-17 15:49:28', 'photo album'),
('en', '_template', 'pa_preferences', 0x416c62756d20507265666572656e636573, '2010-03-17 16:01:30', 'photo album'),
('en', '_template', 'pa_private', 0x50726976617465, '2010-03-17 16:04:46', 'photo album'),
('en', '_template', 'pa_processed', 0x50726f636573736564, '2010-03-17 15:59:14', 'photo album'),
('en', '_template', 'pa_profile_album', 0x50726f66696c6520416c62756d, '2010-03-17 15:50:26', 'photo album'),
('en', '_template', 'pa_redo', 0x5265646f, '2010-03-17 16:00:41', 'photo album'),
('en', '_template', 'pa_set_album_cover', 0x4d616b6520416c62756d20436f766572, '2013-10-11 15:11:08', ''),
('en', '_template', 'pa_set_profile_pic', 0x4d616b652050726f66696c652050696374757265, '2010-03-25 12:02:04', 'photo album'),
('en', '_template', 'pa_shared', 0x536861726564, '2010-03-17 16:04:58', 'photo album'),
('en', '_template', 'pa_shared_albums', 0x53686172656420416c62756d73, '2010-03-17 15:58:39', 'photo album'),
('en', '_template', 'pa_undo', 0x556e646f, '2010-03-17 16:00:31', 'photo album'),
('en', '_template', 'pa_uploaded_by', 0x55706c6f61646564206279, '2010-03-17 16:05:10', 'photo album'),
('en', '_template', 'pa_upload_blurb', 0x436c69636b202242726f7773652220746f206c6f6f6b20666f7220746865207069637475726520796f75207769736820746f2075706c6f61642e202054686573652070686f746f732077696c6c2062652070726f63657373656420616e6420646973706c61792062656c6f772e2020596f7520616c736f206861766520746865206f7074696f6e20746f2072656d6f7665207468652070656e64696e672070686f746f7320616e7974696d652e20205768656e20796f752061726520646f6e652c20636c69636b202255706c6f6164222e, '2010-03-17 15:56:41', 'photo album'),
('en', '_template', 'pa_write_a_comment', 0x5772697465206120636f6d6d656e742e2e2e, '2010-03-17 16:01:18', 'photo album'),
('en', '_template', 'peer_interaction', 0x5065657220496e746572616374696f6e, '2008-09-09 09:03:56', ''),
('en', '_template', 'pending', 0x50656e64696e67, '2003-05-20 14:50:41', 'mytests, control centre'),
('en', '_template', 'pending_approval', 0x2870656e64696e6720617070726f76616c29, '2003-05-20 14:51:49', 'control centre'),
('en', '_template', 'pending_enrollment', 0x50656e64696e6720456e726f6c6c6d656e74, '2005-06-10 10:14:46', ''),
('en', '_template', 'pending_friend_requests', 0x50656e64696e6720467269656e64205265717565737473, '2009-05-27 12:01:11', ''),
('en', '_template', 'people_you_may_know', 0x50656f706c6520796f75206d6179206b6e6f77, '2009-05-27 12:01:11', ''),
('en', '_template', 'percentage_from', 0x50657263656e746167652046726f6d, '2008-09-25 15:59:56', 'gradebook'),
('en', '_template', 'percentage_score', 0x70657263656e746167652073636f7265, '2008-03-10 11:50:57', 'Test/Survey Property'),
('en', '_template', 'percentage_to', 0x50657263656e7461676520546f, '2008-09-25 15:59:56', 'gradebook'),
('en', '_template', 'period', 0x506572696f64, '2004-06-22 12:09:54', ''),
('en', '_template', 'personal', 0x506572736f6e616c20496e666f726d6174696f6e, '2009-12-07 13:42:47', 'Social personal info'),
('en', '_template', 'personal_information', 0x506572736f6e616c20496e666f726d6174696f6e, '2003-05-20 14:53:12', 'registration, profile edit'),
('en', '_template', 'per_day', 0x70657220646179, '2003-05-20 14:54:04', 'instructor course statistics, details'),
('en', '_template', 'per_disabilities', 0x4469736162696c6974696573, '2009-12-07 13:42:04', ''),
('en', '_template', 'per_ethnicity', 0x4574686e6963697479, '2009-12-07 13:40:53', ''),
('en', '_template', 'per_eyes', 0x45796520436f6c6f7572, '2009-12-07 13:40:23', 'Social personal info'),
('en', '_template', 'per_hair', 0x4861697220436f6c6f7572, '2009-12-07 13:39:57', 'Social personal info'),
('en', '_template', 'per_height', 0x486569676874, '2009-12-07 13:39:21', 'social personal info'),
('en', '_template', 'per_languages', 0x4c616e6775616765732053706f6b656e, '2009-12-07 13:41:45', ''),
('en', '_template', 'per_weight', 0x426f647920576569676874, '2009-12-07 14:09:24', ''),
('en', '_template', 'phone', 0x54656c6570686f6e65204e756d626572, '2006-11-23 11:33:30', 'global phone number field label'),
('en', '_template', 'photos', 0x50686f746f2047616c6c657279, '2010-03-17 15:49:12', 'photo album'),
('en', '_template', 'php_version', 0x5048502056657273696f6e, '2007-07-26 13:40:22', ''),
('en', '_template', 'picture', 0x50696374757265, '2007-02-26 17:22:49', ''),
('en', '_template', 'pink', 0x50696e6b, '2008-09-09 09:01:13', ''),
('en', '_template', 'placelogo', 0x506c61636520686f6c646572206c6f676f, '2009-05-27 12:01:11', ''),
('en', '_template', 'plain_text', 0x506c61696e2054657874, '2006-11-23 13:16:30', 'instructor content editor, news, inbox, forum message format'),
('en', '_template', 'points', 0x506f696e7473, '2007-03-05 15:51:38', ''),
('en', '_template', 'points_score', 0x706f696e74732073636f7265, '2008-03-10 11:51:16', 'Test/Survey Property'),
('en', '_template', 'poll', 0x506f6c6c, '2004-06-25 13:17:51', ''),
('en', '_template', 'polls', 0x506f6c6c73, '2004-06-14 13:55:42', ''),
('en', '_template', 'position', 0x506f736974696f6e, '2009-05-27 12:01:11', ''),
('en', '_template', 'post', 0x506f7374, '2003-05-20 14:56:13', 'forum new thread post button'),
('en', '_template', 'postal_code', 0x506f7374616c2f5a697020436f6465, '2003-05-20 14:56:34', 'global postal code filed labal'),
('en', '_template', 'posted_by', 0x4279, '2003-05-20 14:57:31', 'forum message submitter'),
('en', '_template', 'posted_on', 0x6f6e, '2003-05-20 14:58:10', 'forum message post date, inbox'),
('en', '_template', 'posts', 0x466f72756d2054687265616473, '2005-03-07 13:37:56', 'Header for posts in Forum List'),
('en', '_template', 'post_lock', 0x4c6f636b65642066726f6d20706f7374696e67, '2003-05-20 14:58:32', 'forum lock thread message'),
('en', '_template', 'post_message', 0x506f7374204d657373616765, '2008-05-05 15:27:19', 'forum post fieldset'),
('en', '_template', 'powered_by_google', 0x526573756c7473206279203c6120687265663d22687474703a2f2f7777772e676f6f676c652e636f6d223e476f6f676c653c2f613e2e, '2005-10-20 10:52:51', ''),
('en', '_template', 'preferences', 0x507265666572656e636573, '2003-05-20 14:59:08', 'global preferences word'),
('en', '_template', 'prefer_alt', 0x50726566657272656420416c7465726e6174697665, '2008-09-09 08:56:34', ''),
('en', '_template', 'prefer_lang', 0x507265666572726564204c616e6775616765, '2008-09-09 08:56:34', ''),
('en', '_template', 'prefs_set_atutor', 0x536574757020796f75722067656e6572616c20415475746f7220636f6e66696775726174696f6e20206f7074696f6e732e, '2010-04-12 16:28:18', ''),
('en', '_template', 'prefs_set_audio', 0x496620796f752077616e7420616c7465726e61746976657320746f20617564696f20636f6e74656e74207768656e20697420697320617661696c61626c652c2073656c6563742022596573222c2063686f6f7365207468652074797065206f662050726566657272656420416c7465726e61746976652c207468656e2063686f6f736520746f20686176652074686520616c7465726e617469766520617070656e64656420746f2c206f72207265706c61636520746865206f726967696e616c20617564696f20636f6e74656e742e, '2010-04-12 16:23:16', ''),
('en', '_template', 'prefs_set_display', 0x53656c6563742074686520746578742073657474696e677320746f206d616b65207468652073637265656e2065617369657220746f207365652e, '2010-04-12 16:34:38', ''),
('en', '_template', 'prefs_set_init', 0x596f75206d61792075736520746869732077697a61726420746f20736574757020796f757220415475746f7220706572736f6e616c20707265666572656e6365732e2053656c6563742074686520636865636b626f78287329206e65787420746f20707265666572656e63657320796f7520776f756c64206c696b6520746f206d6f646966792c207468656e2063686f6f7365203c7374726f6e673e4e6578743c2f7374726f6e673e2c204f5220636c69636b203c7374726f6e673e436c6f73653c2f7374726f6e673e20746f20657869742e, '2010-04-12 16:08:38', ''),
('en', '_template', 'prefs_set_init_atutor', 0x4920776f756c64206c696b6520746f206368616e6765206f7220726576696577206d7920415475746f7220707265666572656e6365732e, '2010-04-12 16:15:51', ''),
('en', '_template', 'prefs_set_init_audio', 0x4920776f756c64206c696b6520616c7465726e61746976657320746f20617564696f20636f6e74656e742e, '2010-04-12 16:13:48', ''),
('en', '_template', 'prefs_set_init_legend', 0x5768617420707265666572656e63657320776f756c6420796f75206c696b6520746f2073657475703f, '2010-04-12 16:16:51', ''),
('en', '_template', 'prefs_set_init_nav', 0x4920776f756c64206c696b6520746f20656e68616e636520746865206e617669676174696f6e206f662074686520636f6e74656e742e, '2010-04-12 16:10:07', ''),
('en', '_template', 'prefs_set_init_see', 0x4920776f756c64206c696b6520746f206d616b65207468652074657874206f6e207468652073637265656e2065617369657220746f207365652e, '2010-04-12 16:09:35', ''),
('en', '_template', 'prefs_set_init_text', 0x4920776f756c64206c696b6520616c7465726e61746976657320746f207465787475616c20636f6e74656e742e, '2010-04-12 16:13:09', ''),
('en', '_template', 'prefs_set_init_tool', 0x4920776f756c64206c696b652061636365737320746f206c6561726e657220737570706f727420746f6f6c732e, '2010-04-12 16:15:10', ''),
('en', '_template', 'prefs_set_init_visual', 0x4920776f756c64206c696b6520616c7465726e61746976657320746f2076697375616c20636f6e74656e742e, '2010-04-12 16:14:32', ''),
('en', '_template', 'prefs_set_nav', 0x53656c65637420746865206e617669676174696f6e20666561747572657320796f7520776f756c64206c696b6520616464656420746f20415475746f722e, '2010-04-12 16:19:49', ''),
('en', '_template', 'prefs_set_text', 0x496620796f752077616e7420616c7465726e61746976657320746f207465787420636f6e74656e74207768656e20697420697320617661696c61626c652c2073656c6563742022596573222c2063686f6f7365207468652074797065206f662050726566657272656420416c7465726e61746976652c207468656e2063686f6f736520746f20686176652074686520616c7465726e617469766520617070656e64656420746f2c206f72207265706c61636520746865206f726967696e616c207465787420636f6e74656e74, '2010-04-12 16:21:58', ''),
('en', '_template', 'prefs_set_tools', 0x596f75206d61792063686f6f73652066726f6d2074686520617661696c61626c65204c6561726e657220537570706f727420546f6f6c7320746f206d616b65207468656d20617661696c61626c65207768696c6520696e206120636f757273652e, '2010-04-12 16:26:59', ''),
('en', '_template', 'prefs_set_visual', 0x496620796f752077616e7420616c7465726e61746976657320746f2076697375616c20636f6e74656e74207768656e20697420697320617661696c61626c652c2073656c6563742022596573222c2063686f6f7365207468652074797065206f662050726566657272656420416c7465726e61746976652c207468656e2063686f6f736520746f20686176652074686520616c7465726e617469766520617070656e64656420746f2c206f72207265706c61636520746865206f726967696e616c2076697375616c20636f6e74656e74, '2010-04-12 16:24:47', ''),
('en', '_template', 'presets', 0x50726573657473, '2004-08-24 11:56:35', ''),
('en', '_template', 'preset_grade_scale', 0x507265736574204772616465205363616c65, '2008-09-25 15:59:56', 'gradebook'),
('en', '_template', 'preset_scales', 0x5072657365742026616d703b2050726576696f75736c792055736564205363616c6573, '2004-08-24 13:48:44', ''),
('en', '_template', 'pretty_url', 0x5072657474792055524c, '2008-05-14 12:02:47', ''),
('en', '_template', 'preview', 0x50726576696577, '2003-05-20 14:59:52', 'test manager preview test'),
('en', '_template', 'preview_questions', 0x50726576696577205175657374696f6e73, '2005-06-21 14:06:13', ''),
('en', '_template', 'previous', 0x50726576696f7573, '2003-05-20 15:01:31', 'global sequence arrow alt/link text'),
('en', '_template', 'previous_posts', 0x50726576696f757320506f737473, '2006-06-14 10:47:00', ''),
('en', '_template', 'previous_topic', 0x50726576696f757320546f706963, '2003-05-20 15:02:06', 'global sequence arrow alt/link text'),
('en', '_template', 'prev_used', 0x50726576696f75736c792055736564, '2004-08-13 13:29:47', ''),
('en', '_template', 'primary_language', 0x4f726967696e616c204c616e6775616765, '2008-10-19 17:03:57', ''),
('en', '_template', 'primary_resource_language', 0x4f726967696e616c205265736f75726365204c616e6775616765, '2008-10-19 17:04:18', ''),
('en', '_template', 'primary_resource_type', 0x4f726967696e616c205265736f757263652054797065, '2008-10-19 17:04:34', ''),
('en', '_template', 'print_page', 0x5072696e742050616765, '2008-01-04 10:16:49', 'redux theme'),
('en', '_template', 'privacy_control_blurb', 0x436f6e74726f6c732077686f2063616e2073656520796f75722070726f66696c6520616e642072656c6174656420696e666f726d6174696f6e2e, '2009-05-27 12:01:11', ''),
('en', '_template', 'privacy_settings', 0x507269766163792053657474696e6773, '2009-05-27 12:01:11', ''),
('en', '_template', 'private', 0x50726976617465, '2003-05-20 15:03:14', 'global private course indicator'),
('en', '_template', 'private_enroll', 0x54686520636f7572736520796f752061726520747279696e6720746f20616363657373206973203c7374726f6e673e707269766174653c2f7374726f6e673e2e20456e726f6c6c6d656e7420696e207468697320636f7572736520726571756972657320696e7374727563746f7220617070726f76616c2e3c6272202f3e, '2005-03-17 11:51:06', 'requesting enrollment in private course'),
('en', '_template', 'privileges', 0x50726976696c65676573, '2004-03-05 12:29:02', ''),
('en', '_template', 'priv_ac_access_all', 0x41436f6c6c61623a2041636365737320616c6c2047726f757073, '2005-08-10 15:21:20', ''),
('en', '_template', 'priv_ac_create', 0x41436f6c6c61623a204372656174652047726f7570, '2005-08-10 15:20:47', ''),
('en', '_template', 'priv_admin_super', 0x53757065722041646d696e6973747261746f72, '2005-03-03 10:36:48', ''),
('en', '_template', 'priv_admin_themes', 0x5468656d6573, '2005-03-03 10:38:07', ''),
('en', '_template', 'priv_forums', 0x466f72756d7320262043686174, '2004-03-08 10:04:06', ''),
('en', '_template', 'priv_test_create', 0x54657374204372656174696f6e, '2005-08-10 15:20:29', ''),
('en', '_template', 'priv_test_mark', 0x54657374204d61726b696e67, '2005-08-10 15:22:12', ''),
('en', '_template', 'processing', 0x50726f63657373696e67, '2010-04-26 15:39:06', ''),
('en', '_template', 'profile', 0x50726f66696c65, '2003-05-20 16:24:30', 'control centre heading'),
('en', '_template', 'profile_bundle_select', 0x50726f66696c652042756e646c652053656c656374696f6e, '2004-12-06 12:13:34', ''),
('en', '_template', 'profile_control', 0x50726f66696c65205669736162696c697479, '2009-05-27 12:01:11', ''),
('en', '_template', 'profile_picture', 0x50726f66696c652050696374757265, '2009-05-27 12:01:11', ''),
('en', '_template', 'profile_pictures', 0x50726f66696c65205069637475726573, '2007-02-27 13:43:00', ''),
('en', '_template', 'profile_student_information', 0x53747564656e7420496e666f726d6174696f6e, '2003-09-16 11:49:35', 'view profile'),
('en', '_template', 'properties', 0x50726f70657274696573, '2003-05-21 12:15:58', 'instructor control centre'),
('en', '_template', 'protected', 0x50726f746563746564, '2003-05-21 12:16:46', 'browse, create coruse, control centre, course properties'),
('en', '_template', 'province', 0x50726f76696e63652f5374617465, '2003-05-21 12:17:22', 'registration, profile editor'),
('en', '_template', 'proxy', 0x4c6561726e696e67204163746976697479, '2011-05-27 16:08:21', ''),
('en', '_template', 'public', 0x5075626c6963, '2003-05-21 12:18:37', 'browse courses, create course, course properties, control centre'),
('en', '_template', 'publish_date', 0x5075626c6973682044617465, '2008-10-21 15:41:53', ''),
('en', '_template', 'purple', 0x507572706c65, '2003-05-21 12:18:50', 'global code picker'),
('en', '_template', 'put_link', 0x707574206c696e6b206e616d652068657265, '2004-12-08 12:38:42', 'filemanager, isert text'),
('en', '_template', 'quebec-lsq', 0x5175656265632d4c5351, '2008-09-09 09:01:13', ''),
('en', '_template', 'question', 0x5175657374696f6e, '2003-05-21 12:30:21', 'test manager'),
('en', '_template', 'questions', 0x5175657374696f6e73, '2003-05-21 12:30:40', 'test manager'),
('en', '_template', 'questions_for', 0x5175657374696f6e7320666f72, '2003-05-21 12:30:50', 'test manager'),
('en', '_template', 'question_categories', 0x5175657374696f6e2043617465676f72696573, '2005-02-22 14:17:33', ''),
('en', '_template', 'question_database', 0x5175657374696f6e2042616e6b, '2010-06-25 15:13:30', ''),
('en', '_template', 'question_statistics', 0x5175657374696f6e2053746174697374696373, '2004-08-26 13:26:17', ''),
('en', '_template', 'quote', 0x51756f7465, '2003-05-21 12:31:19', 'code picker alt text'),
('en', '_template', 'randomize_questions', 0x52616e646f6d697a65205175657374696f6e73, '2004-05-18 10:44:48', ''),
('en', '_template', 'raw', 0x526177, '2003-09-13 09:25:20', 'course tracker member picker'),
('en', '_template', 'raw_data', 0x5261772044617461, '2003-05-21 12:31:48', 'instructor course statistics/details'),
('en', '_template', 'raw_final_score', 0x5261772046696e616c2053636f7265, '2008-09-25 16:01:17', 'gradebook'),
('en', '_template', 're', 0x5265, '2007-02-20 16:20:00', ''),
('en', '_template', 'reading_list', 0x52656164696e67204c697374, '2006-05-09 14:19:55', ''),
('en', '_template', 'read_lock', 0x4c6f636b65642066726f6d20706f7374696e6720262072656164696e67, '2003-05-21 12:32:39', 'forum lock message in thread list'),
('en', '_template', 'real_name', 0x5265616c204e616d65, '2003-10-20 11:33:14', 'course properties'),
('en', '_template', 'reapply_default', 0x526573657420746f2053797374656d2044656661756c7473, '2008-10-29 12:18:43', ''),
('en', '_template', 'recent_first', 0x526563656e74204669727374, '2009-09-08 13:34:27', ''),
('en', '_template', 'recent_last', 0x526563656e74204c617374, '2009-09-08 13:34:44', ''),
('en', '_template', 'recipient_address', 0x526563697069656e742041646472657373, '2004-12-06 12:20:03', 'admin/error_logging_bundle.php'),
('en', '_template', 'red', 0x526564, '2003-05-21 12:32:57', 'global code picker'),
('en', '_template', 'red_members', 0x526564203d204d656d62657273, '2003-05-21 12:33:55', 'instructor course statistics/details'),
('en', '_template', 'refine_results', 0x526566696e6520526573756c7473, '2013-12-28 12:16:28', 'admin courses tmpl'),
('en', '_template', 'refresh_image', 0x5265667265736820496d616765, '2009-07-16 08:51:44', ''),
('en', '_template', 'regenerate', 0x526567656e6572617465, '2007-02-16 14:00:06', ''),
('en', '_template', 'register', 0x5265676973746572, '2003-11-26 15:09:00', ''),
('en', '_template', 'registered_members', 0x52656769737465726564204d656d62657273, '2008-10-06 13:42:00', ''),
('en', '_template', 'register_an_account', 0x526567697374657220616e20415475746f722053797374656d204163636f756e74, '2003-05-21 12:36:01', 'private course enrolment screen, login screen'),
('en', '_template', 'registration_text', 0x496620796f7520646f206e6f74206861766520616e206163636f756e74206f6e20746869732073797374656d2c2020706c65617365206372656174652061206e6577206163636f756e7420627920636c69636b696e67206f6e2074686520526567697374657220427574746f6e2062656c6f772e, '2005-07-27 15:11:59', ''),
('en', '_template', 'reg_exp', 0x526567756c61722045787072657373696f6e, '2004-11-20 19:38:23', ''),
('en', '_template', 'reject_request', 0x52656a6563742052657175657374, '2009-05-27 12:01:11', ''),
('en', '_template', 'related_topics', 0x52656c6174656420546f70696373, '2003-05-21 12:38:26', 'context(?)'),
('en', '_template', 'relative_directory', 0x4469726563746f72792069732072656c6174697665206469726563746f727920746f20415475746f7220726f6f742c20666f72206578616d706c653a20646f63732f696d616765732f206f7220746f6f6c732f74657374732f2e204c6561766520656d70747920696620697420697320415475746f7220726f6f74206469726563746f72792e, '2008-04-21 15:11:31', ''),
('en', '_template', 'release_date', 0x52656c656173652044617465, '2003-05-21 12:39:24', 'instructor add/edit content, control centre'),
('en', '_template', 'release_immediate', 0x4f6e6365207175697a20686173206265656e207375626d6974746564, '2004-12-13 13:55:49', ''),
('en', '_template', 'release_marked', 0x4f6e6365207175697a20686173206265656e207375626d697474656420616e6420616c6c207175657374696f6e732068617665206265656e206d61726b6564, '2004-12-13 13:55:57', ''),
('en', '_template', 'release_never', 0x446f206e6f742072656c6561736520726573756c7473, '2004-12-13 14:02:13', ''),
('en', '_template', 'release_on', 0x52656c65617365206f6e, '2006-04-10 14:37:58', ''),
('en', '_template', 'remedial_back_to_the_test', 0x476f206261636b20746f2074657374, '2013-01-23 14:16:48', ''),
('en', '_template', 'remedial_content', 0x52656d656469616c20436f6e74656e74, '2013-01-23 14:16:02', ''),
('en', '_template', 'remedial_content_goto_link', 0x476f20746f2072656d656469616c20636f6e74656e74, '2013-01-23 14:17:18', ''),
('en', '_template', 'remedial_content_hide', 0x446f206e6f742073686f772052656d656469616c20436f6e74656e7420746f2073747564656e7473206166746572206661696c696e67207468652074657374, '2013-01-23 14:18:37', '');
INSERT INTO `AT_language_text` (`language_code`, `variable`, `term`, `text`, `revised_date`, `context`) VALUES
('en', '_template', 'remedial_content_placeholder', 0x456e74657220696e666f726d6174696f6e20746f2070726573656e7420746f2073747564656e74732077686f20616e737765722074686973207175657374696f6e20696e636f72726563746c792e, '2013-01-23 14:15:02', ''),
('en', '_template', 'remedial_content_show', 0x53686f772052656d656469616c20436f6e74656e7420746f2073747564656e7473206166746572206661696c696e67207468652074657374, '2013-01-23 14:19:00', ''),
('en', '_template', 'remove', 0x52656d6f7665, '2003-05-21 12:40:11', 'control centre, admin user manager, instructor enrolment manager'),
('en', '_template', 'removed', 0x52656d6f766564, '2004-02-03 09:36:19', ''),
('en', '_template', 'remove_frame', 0x52656d6f7665204672616d65, '2005-01-10 14:31:34', 'filemanager preview'),
('en', '_template', 'remove_question', 0x52656d6f7665205175657374696f6e, '2004-11-25 10:30:59', ''),
('en', '_template', 'remove_queued_file', 0x52656d6f76652066696c652066726f6d207175657565, '2008-07-22 16:44:41', 'Instruction to remove file in Fluid''''s multiple file uploader'),
('en', '_template', 'remove_write_permission', 0x3c7370616e207374796c653d22636f6c6f723a726564223e506c65617365203c7374726f6e673e52454d4f56453c2f7374726f6e673e207772697465207065726d697373696f6e206f6e20746865206c697374656420666f6c6465727320616e642066696c657320666f7220796f75722073656375726974793a3c2f7370616e3e3c703e3c7374726f6e673e4e6f74653a3c2f7374726f6e673e20546f2072656d6f7665207065726d697373696f6e73206f6e20556e697820757365203c6b62643e63686d6f64203735353c2f6b62643e207468656e207468652066696c65206e616d652e2e3c2f703e, '2008-04-21 15:08:55', 'patcher'),
('en', '_template', 'rename', 0x52656e616d65, '2004-08-11 14:00:49', ''),
('en', '_template', 'replace', 0x5265706c616365, '2008-09-09 09:01:12', ''),
('en', '_template', 'replace_file', 0x5265706c6163652046696c65, '2008-04-21 15:11:31', ''),
('en', '_template', 'replace_into', 0x5265706c61636520496e746f, '2005-03-03 12:16:28', ''),
('en', '_template', 'replied', 0x5265706c696564, '2003-05-21 12:40:35', 'inbox message status label'),
('en', '_template', 'replies', 0x5265706c696573, '2003-05-21 12:40:50', 'forum'),
('en', '_template', 'reply', 0x5265706c79, '2003-05-21 12:41:20', 'forum, inbox'),
('en', '_template', 'report_errors', 0x5265706f7274204572726f7273, '2004-12-06 12:08:05', ''),
('en', '_template', 'representation', 0x526570726573656e746174697665, '2009-12-03 15:41:02', ''),
('en', '_template', 'request_enrollment', 0x5265717565737420456e726f6c6c6d656e74, '2003-10-21 13:04:17', ''),
('en', '_template', 'request_instructor', 0x596f7520646f206e6f74207965742068617665207065726d697373696f6e20746f2063726561746520636f75727365732e20496620796f7520776f756c64206c696b6520616e20696e7374727563746f72206163636f756e742c20656e74657220746865207265717569726564206465736372697074696f6e206f662074686520636f7572736520796f75207769736820746f206372656174652e, '2005-03-09 12:22:12', ''),
('en', '_template', 'request_instructor_account', 0x5265717565737420496e7374727563746f72204163636f756e74, '2003-05-21 12:43:12', 'control centre non-instructor'),
('en', '_template', 'request_instructor_pending', 0x596f757220696e7374727563746f72206163636f756e74207265717565737420686173206265656e206d6164652e20596f752077696c6c206265206e6f746966656420627920656d61696c207768656e20796f7572207265717565737420686173206265656e20617070726f7665642e, '2005-03-09 12:35:15', ''),
('en', '_template', 'request_instructor_priv', 0x5265717565737420496e7374727563746f72204163636f756e74, '2009-11-13 15:44:24', 'my start page'),
('en', '_template', 'request_services', 0x3c6120687265663d22687474703a2f2f7777772e617475746f722e63612f7365727669636573223e5265717565737420415475746f722053657276696365733c2f613e, '2008-11-14 13:43:45', ''),
('en', '_template', 'request_services_text', 0x507572636861736520796561726c7920737570706f7274207061636b616765732c20737570706f7274207469636b6574732c206f72206f7468657220415475746f722073657276696365732e205265717569726573203c6120687265663d22687474703a2f2f7777772e617475746f722e63612f6d792f72656769737465722e706870223e726567697374726174696f6e206f6e20617475746f722e63613c2f613e2e, '2008-11-14 14:04:23', ''),
('en', '_template', 'required', 0x5265717569726564, '2003-05-21 12:43:54', 'registration, export course, test manager question editor'),
('en', '_template', 'required_field', 0x5265717569726564204669656c64, '2005-03-04 12:52:17', ''),
('en', '_template', 'required_information', 0x526571756972656420496e666f726d6174696f6e, '2005-03-04 14:08:38', ''),
('en', '_template', 'require_email_confirmation', 0x5265717569726520456d61696c20436f6e6669726d6174696f6e2055706f6e20526567697374726174696f6e, '2005-03-22 10:55:04', ''),
('en', '_template', 'req_message9', 0x415475746f7220496e7374727563746f722052657175657374, '2003-05-21 18:52:38', 'email message subject line from control centre instructor request'),
('en', '_template', 'req_message_instructor', 0x41206e657720496e7374727563746f72206163636f756e74207265717565737420686173206265656e206d6164652062793a2025732e0d0a0d0a436f75727365204465736372697074696f6e3a2025730d0a0d0a596f75206d757374206c6f67696e206173207468652061646d696e6973747261746f7220617420257320746f20617070726f7665206f722072656a656374207468697320726571756573742e, '2004-02-16 16:38:30', ''),
('en', '_template', 'reset', 0x5265736574, '2003-05-21 18:53:27', 'global text for reset buttons'),
('en', '_template', 'reset_filter', 0x52657365742046696c746572, '2005-03-30 14:52:42', ''),
('en', '_template', 'reset_log', 0x5265736574204c6f67, '2005-03-03 10:42:24', ''),
('en', '_template', 'resource_categories', 0x5265736f757263652043617465676f72696573, '2003-05-21 18:57:43', 'instructor export course feedback'),
('en', '_template', 'resource_links', 0x5265736f75726365204c696e6b73, '2003-05-21 18:58:34', 'instructor export course feedback'),
('en', '_template', 'resource_type', 0x5265736f757263652074797065, '2010-03-09 16:16:42', 'adapted content'),
('en', '_template', 'response_text', 0x54686520666f6c6c6f77696e6720616e7377657273207765726520676976656e20696e20726573706f6e736520746f3a, '2004-08-25 12:20:59', ''),
('en', '_template', 'restore', 0x526573746f7265, '2003-05-21 18:59:34', 'preferences page (removed 1.2)'),
('en', '_template', 'restore_backup_about', 0x43686f6f73652074686520636865636b626f786573206e65787420746f2074686520636f6e74656e7420746f20626520726573746f7265642c2073656c65637420636f7572736520696e746f20776869636820746f20726573746f72652074686520636f6e74656e742c207468656e2063686f6f736520746f20617070656e642074686520636f6e74656e7420746f2074686520636f757273652c206f72207265706c6163652074686520636f6e74656e7420696e2074686520636f757273652e, '2004-12-10 09:53:40', ''),
('en', '_template', 'restore_upload', 0x546f2075706c6f61642061206261636b75702066696c652c20656e7465722061206465736372697074696f6e206f6620746865206261636b75702c2063686f6f736520612066696c6520746f2075706c6f61642c20616e642075736520746865202255706c6f61642220627574746f6e2e204f6e6c79206261636b7570732063726561746564207573696e6720415475746f7220312e3320616e64206c617465722061726520737570706f727465642e20446570656e64696e67206f6e207468652073697a65206f662074686520636f7572736520616e6420796f757220496e7465726e657420636f6e6e656374696f6e2073706565642c202075706c6f6164696e672061206261636b7570206d61792074616b652061206c6f6e672074696d652e, '2004-12-10 18:06:04', ''),
('en', '_template', 'resubmit', 0x52657375626d6974, '2004-01-30 16:34:56', ''),
('en', '_template', 'result', 0x526573756c74, '2004-08-12 15:22:08', 'single result in search engine'),
('en', '_template', 'results', 0x526573756c7473, '2003-05-21 19:00:51', 'test manager'),
('en', '_template', 'results_found', 0x526573756c747320466f756e643a202573, '2005-04-14 11:01:25', ''),
('en', '_template', 'results_from', 0x526573756c74732066726f6d202573, '2004-08-18 12:05:27', ''),
('en', '_template', 'result_release', 0x52656c6561736520526573756c7473, '2004-12-13 13:57:31', ''),
('en', '_template', 'resume', 0x526573756d65, '2003-05-21 19:01:48', 'alt/link text for the resume arrow'),
('en', '_template', 'return', 0x52657475726e, '2003-05-21 19:02:25', 'escape from delete course function'),
('en', '_template', 'returning_user', 0x52657475726e696e672055736572, '2010-10-19 10:06:09', 'login screen'),
('en', '_template', 'return_file_manager', 0x52657475726e20746f207468652046696c65204d616e61676572, '2004-11-05 11:20:30', 'file manager'),
('en', '_template', 'return_to_admin_area', 0x52657475726e20746f2041646d696e2041726561, '2006-03-28 12:31:38', ''),
('en', '_template', 'revision', 0x5265766973696f6e, '2003-05-21 19:04:01', 'instructor content editor statistics below embedded links'),
('en', '_template', 'revisions', 0x5265766973696f6e73, '2006-03-20 14:36:35', ''),
('en', '_template', 'revision_comment', 0x5265766973696f6e7320436f6d6d656e74, '2006-03-20 14:37:58', ''),
('en', '_template', 'right', 0x5269676874, '2004-04-27 11:00:46', ''),
('en', '_template', 'rl_add_av_material_to_resources', 0x416464204156204d6174657269616c20546f205265736f7572636573, '2006-02-23 09:18:51', ''),
('en', '_template', 'rl_add_resource_av', 0x416464205265736f75726365204156, '2006-02-23 09:18:51', ''),
('en', '_template', 'rl_add_resource_book', 0x416464205265736f7572636520426f6f6b, '2006-02-23 09:18:51', ''),
('en', '_template', 'rl_add_resource_file', 0x416464205265736f757263652046696c65, '2006-02-23 09:18:51', ''),
('en', '_template', 'rl_add_resource_handout', 0x416464205265736f757263652048616e646f7574, '2006-02-23 09:18:51', ''),
('en', '_template', 'rl_add_resource_url', 0x416464205265736f757263652055524c, '2006-02-23 09:18:51', ''),
('en', '_template', 'rl_av', 0x4156, '2006-02-23 09:18:51', ''),
('en', '_template', 'rl_av_material_to_view', 0x4156204d6174657269616c20746f2056696577, '2006-04-13 12:18:36', ''),
('en', '_template', 'rl_book', 0x626f6f6b, '2006-02-23 09:18:51', ''),
('en', '_template', 'rl_book_to_read', 0x426f6f6b20546f2052656164, '2006-02-23 09:18:51', ''),
('en', '_template', 'rl_create_new_av', 0x437265617465204e6577204156, '2006-02-23 09:18:51', ''),
('en', '_template', 'rl_create_new_book', 0x437265617465204e657720426f6f6b, '2006-02-23 09:18:51', ''),
('en', '_template', 'rl_create_new_file', 0x437265617465204e65772046696c65, '2006-02-23 09:18:51', ''),
('en', '_template', 'rl_create_new_handout', 0x437265617465204e65772048616e646f7574, '2006-02-23 09:18:51', ''),
('en', '_template', 'rl_create_new_url', 0x437265617465204e65772055524c, '2006-02-23 09:18:51', ''),
('en', '_template', 'rl_create_resources', 0x437265617465205265736f75726365, '2013-10-01 16:32:28', 'reading list'),
('en', '_template', 'rl_date_format', 0x25254d202525642c20252559, '2006-06-26 16:10:05', ''),
('en', '_template', 'rl_delete_reading', 0x44656c6574652052656164696e67, '2006-02-23 09:18:51', ''),
('en', '_template', 'rl_delete_resource', 0x44656c657465205265736f75726365, '2006-02-23 09:18:51', ''),
('en', '_template', 'rl_display_resource', 0x446973706c6179205265736f75726365, '2006-02-23 09:18:51', ''),
('en', '_template', 'rl_display_resources', 0x5265736f7572636573, '2006-02-23 09:18:51', ''),
('en', '_template', 'rl_edit_reading_av', 0x456469742052656164696e67204156, '2006-02-23 09:18:51', ''),
('en', '_template', 'rl_edit_reading_book', 0x456469742052656164696e6720426f6f6b, '2006-02-23 09:18:51', ''),
('en', '_template', 'rl_edit_reading_file', 0x456469742052656164696e672046696c65, '2006-02-23 09:18:51', ''),
('en', '_template', 'rl_edit_reading_handout', 0x456469742052656164696e672048616e646f7574, '2006-02-23 09:18:51', ''),
('en', '_template', 'rl_edit_reading_url', 0x456469742052656164696e672055524c, '2006-02-23 09:18:51', ''),
('en', '_template', 'rl_edit_resource_av', 0x45646974205265736f75726365, '2006-02-23 09:18:51', ''),
('en', '_template', 'rl_edit_resource_book', 0x45646974205265736f7572636520426f6f6b, '2006-02-23 09:18:51', ''),
('en', '_template', 'rl_edit_resource_file', 0x45646974205265736f757263652046696c65, '2006-02-23 09:18:51', ''),
('en', '_template', 'rl_edit_resource_handout', 0x45646974205265736f757263652048616e646f7574, '2006-02-23 09:18:51', ''),
('en', '_template', 'rl_edit_resource_url', 0x45646974205265736f757263652055524c, '2006-02-23 09:18:51', ''),
('en', '_template', 'rl_end', 0x456e64, '2006-02-23 09:18:51', ''),
('en', '_template', 'rl_file', 0x66696c65, '2006-02-23 09:18:51', ''),
('en', '_template', 'rl_goto_url', 0x766965772070616765, '2006-02-23 09:18:51', ''),
('en', '_template', 'rl_handout', 0x68616e646f7574, '2006-02-23 09:18:51', ''),
('en', '_template', 'rl_id', 0x4953424e, '2013-02-28 19:17:38', 'reading list ISBN number'),
('en', '_template', 'rl_isbn_number', 0x4953424e, '2006-02-23 09:18:51', ''),
('en', '_template', 'rl_name_reading', 0x4e616d65204f662052656164696e67, '2006-02-23 09:18:51', ''),
('en', '_template', 'rl_new_reading_av', 0x4e65772052656164696e67204156, '2006-02-23 09:18:51', ''),
('en', '_template', 'rl_new_reading_book', 0x4e65772052656164696e6720426f6f6b, '2006-02-23 09:18:51', ''),
('en', '_template', 'rl_new_reading_file', 0x4e65772052656164696e672046696c65, '2006-02-23 09:18:51', ''),
('en', '_template', 'rl_new_reading_handout', 0x4e65772052656164696e672048616e646f7574, '2006-02-23 09:18:51', ''),
('en', '_template', 'rl_new_reading_url', 0x4e65772052656164696e672055524c, '2006-02-23 09:18:51', ''),
('en', '_template', 'rl_no_read_by_date', 0x4e6f20526561642042792044617465, '2006-02-23 09:18:51', ''),
('en', '_template', 'rl_optional_reading', 0x4f7074696f6e616c2052656164696e67, '2006-02-23 09:18:51', ''),
('en', '_template', 'rl_or', 0x6f72, '2006-02-23 09:18:51', ''),
('en', '_template', 'rl_pages', 0x5061676573, '2006-02-23 09:18:51', ''),
('en', '_template', 'rl_publisher', 0x5075626c6973686572, '2006-02-23 09:18:51', ''),
('en', '_template', 'rl_reading_date', 0x52656164696e672044617465, '2006-02-23 09:18:51', ''),
('en', '_template', 'rl_read_by_date', 0x526561642062792044617465, '2006-04-13 10:58:30', ''),
('en', '_template', 'rl_select_book', 0x53656c65637420426f6f6b, '2006-07-25 09:08:20', ''),
('en', '_template', 'rl_select_file', 0x53656c6563742046696c65, '2006-07-25 09:15:44', ''),
('en', '_template', 'rl_select_handout', 0x53656c6563742048616e646f7574, '2006-07-25 09:13:13', ''),
('en', '_template', 'rl_select_url', 0x53656c6563742055524c, '2006-07-25 09:12:21', ''),
('en', '_template', 'rl_start', 0x5374617274, '2006-06-21 08:53:43', ''),
('en', '_template', 'rl_type_of_reading', 0x54797065206f662052656164696e67, '2006-07-31 15:23:22', ''),
('en', '_template', 'rl_type_of_resource', 0x54797065206f66205265736f75726365, '2006-07-14 10:24:21', ''),
('en', '_template', 'rl_url', 0x55524c, '2007-08-02 10:46:30', 'resource type picker'),
('en', '_template', 'rl_view_resource_details', 0x56696577205265736f757263652044657461696c73, '2008-06-10 14:23:50', 'reading list.'),
('en', '_template', 'rl_year_written', 0x59656172205772697474656e, '2006-06-21 08:55:34', ''),
('en', '_template', 'role', 0x526f6c65, '2004-03-05 12:26:47', ''),
('en', '_template', 'rss_feeds', 0x4e657773204665656473, '2010-05-03 15:01:37', ''),
('en', '_template', 'rtl', 0x526967687420746f204c656674, '2004-11-20 19:37:58', ''),
('en', '_template', 'russian-rsl', 0x5275737369616e2d52534c, '2008-09-09 09:01:13', ''),
('en', '_template', 'same_course_users', 0x4f6e6c7920757365727320696e207468652073616d6520636f757273657320617320796f7520617265206c69737465642e, '2003-05-21 19:05:32', 'inbox send message form'),
('en', '_template', 'sans_serif', 0x53616e73205365726966, '2008-09-09 09:01:13', ''),
('en', '_template', 'save', 0x53617665, '2004-10-29 14:57:46', 'file manager'),
('en', '_template', 'save_changes', 0x53617665204368616e676573, '2004-05-11 10:48:01', ''),
('en', '_template', 'save_changes_saved', 0x416c6c206368616e6765732068617665206265656e2073617665642e, '2004-02-16 14:06:16', ''),
('en', '_template', 'save_changes_unsaved', 0x556e7361766564206368616e6765732068617665206265656e206d6164652e, '2004-02-16 14:04:25', ''),
('en', '_template', 'save_types_and_language', 0x557064617465205265736f757263652050726f70657274696573, '2008-10-19 13:51:37', ''),
('en', '_template', 'scaffold_text', 0x4d6f64696679207468652055524c7320666f7220746865206c6561726e696e6720746f6f6c732062656c6f772e204c6561766520626c616e6b20746f2064697361626c652e, '2008-09-10 12:29:26', 'tool preferences'),
('en', '_template', 'scale', 0x5363616c65, '2008-09-25 15:59:56', 'gradebook'),
('en', '_template', 'scale_value', 0x5363616c652056616c7565, '2008-09-25 15:59:56', 'gradebook'),
('en', '_template', 'schema_error', 0x57726f6e6720736368656d61206c6f636174696f6e, '2009-12-07 13:09:06', 'common cartridge'),
('en', '_template', 'search', 0x536561726368, '2003-05-21 19:19:30', 'links database'),
('en', '_template', 'search_all_words', 0x416c6c20776f726473, '2003-08-11 11:22:04', ''),
('en', '_template', 'search_any_word', 0x416e7920776f7264, '2003-08-11 11:22:14', ''),
('en', '_template', 'search_connections', 0x53656172636820436f6e6e656374696f6e73, '2009-05-27 12:01:11', ''),
('en', '_template', 'search_control', 0x53656172636820436f6e74726f6c, '2009-11-06 15:53:36', 'networking settings'),
('en', '_template', 'search_education', 0x53656172636820456475636174696f6e, '2009-05-27 12:01:11', ''),
('en', '_template', 'search_for_friends', 0x5365617263682050656f706c65, '2009-05-27 12:01:11', ''),
('en', '_template', 'search_for_groups', 0x53656172636820666f722047726f757073, '2009-05-27 12:01:11', ''),
('en', '_template', 'search_in', 0x53656172636820696e, '2004-04-30 10:51:57', ''),
('en', '_template', 'search_match', 0x4d61746368, '2003-08-11 11:21:50', ''),
('en', '_template', 'search_position', 0x53656172636820506f736974696f6e, '2009-05-27 12:01:11', ''),
('en', '_template', 'search_profile', 0x5365617263682050726f66696c65, '2009-05-27 12:01:11', ''),
('en', '_template', 'search_results', 0x53656172636820526573756c7473, '2003-05-21 19:21:29', 'links database'),
('en', '_template', 'search_site', 0x4f6e6c79207365617263682077697468696e203c7374726f6e673e25733c2f7374726f6e673e2e, '2005-10-20 10:53:28', ''),
('en', '_template', 'search_visibility', 0x536561726368205669736962696c697479, '2009-05-27 12:01:11', ''),
('en', '_template', 'search_words', 0x576f726473, '2003-08-11 11:21:36', ''),
('en', '_template', 'secondary_resource_body', 0x426f6479, '2008-09-23 13:50:56', ''),
('en', '_template', 'secondary_resource_language', 0x41646170746564205265736f75726365204c616e6775616765, '2008-10-19 17:05:56', ''),
('en', '_template', 'secondary_resource_type', 0x41646170746564205265736f757263652054797065, '2008-10-19 17:06:06', ''),
('en', '_template', 'seconds', 0x5365636f6e6473, '2010-05-10 15:56:57', ''),
('en', '_template', 'second_name', 0x5365636f6e64204e616d65, '2006-03-27 14:53:50', ''),
('en', '_template', 'second_short', 0x73, '2007-07-09 12:31:07', ''),
('en', '_template', 'section', 0x53656374696f6e, '2005-03-04 14:06:06', ''),
('en', '_template', 'see', 0x536565, '2003-05-21 19:24:22', 'glossary - "see" related terms'),
('en', '_template', 'see_attached', 0x5365652061747461636865642e, '2005-03-10 16:37:04', 'error logging - email body'),
('en', '_template', 'select', 0x53656c656374, '2007-02-21 13:22:15', ''),
('en', '_template', 'select_all', 0x73656c6563742f756e73656c65637420616c6c, '2004-10-29 13:25:57', 'file manager and enrollment manager'),
('en', '_template', 'select_av', 0x53656c65637420417564696f2f56697375616c, '2006-07-25 09:14:57', ''),
('en', '_template', 'select_cat', 0x53656c6563742043617465676f7279, '2005-02-23 12:23:56', ''),
('en', '_template', 'select_directory', 0x506c656173652063686f6f73652074686520666f6c64657220796f752077616e7420746f206d6f7665207468652073656c65637465642066696c657320746f3a, '2004-11-30 11:40:08', 'Filamanger, moving a file'),
('en', '_template', 'select_member', 0x53656c6563742061204d656d62657220746f2056696577, '2003-05-21 19:29:27', 'instructor course tracker'),
('en', '_template', 'select_parent_topic', 0x53656c65637420706172656e7420746f706963, '2005-03-16 13:37:00', 'content manager'),
('en', '_template', 'select_term_to_edit', 0x53656c656374207465726d20746f20656469742e, '2006-09-25 13:08:38', ''),
('en', '_template', 'send', 0x53656e64, '2003-05-21 19:31:57', 'global message send button text'),
('en', '_template', 'send_bundle', 0x53656e642042756e646c65, '2004-12-06 12:16:19', ''),
('en', '_template', 'send_confirmation', 0x456e74657220796f757220656d61696c20616464726573732062656c6f7720616e6420746865206163636f756e7420636f6e6669726d6174696f6e206d6573736167652077696c6c20626520726573656e742e, '2005-03-24 09:57:32', ''),
('en', '_template', 'send_delete', 0x53656e6420262044656c657465, '2003-05-21 19:32:55', 'send a message from the inbox and delete the original'),
('en', '_template', 'send_message', 0x53656e64204d657373616765, '2003-05-21 19:34:13', 'inbox send message button text'),
('en', '_template', 'sent_messages', 0x53656e74204d65737361676573, '2007-02-20 16:21:09', ''),
('en', '_template', 'sent_msgs_ttl_text', 0x4e756d626572206f66204461797320746f204b65657020436f706965642053656e74204d6573736167657320666f72, '2007-02-20 14:00:45', ''),
('en', '_template', 'sent_via_atutor', 0x53656e742076696120616e20415475746f722073797374656d206174202573, '2003-05-21 20:04:50', 'global email message footer'),
('en', '_template', 'sequence', 0x53657175656e6365, '2003-05-21 20:05:50', 'context (removed 1.2)'),
('en', '_template', 'serif', 0x5365726966, '2008-09-09 09:01:13', ''),
('en', '_template', 'server_date_format', 0x2525592d25256d2d252564202525473a2525693a252573, '2008-10-01 15:02:49', 'date format'),
('en', '_template', 'session_end', 0x616e6420656e646564206f6e, '2003-05-21 20:12:12', 'tracker - to be updated ( started on [date] and ended on [date])'),
('en', '_template', 'session_start', 0x53657373696f6e2061626f76652073746172746564206f6e, '2003-05-21 20:11:35', 'tracker (to be updated)'),
('en', '_template', 'session_timeout', 0x53657373696f6e2054696d656f757420506572696f64, '2013-01-31 11:49:21', ''),
('en', '_template', 'session_timeout_logout_now', 0x4c6f676f7574204e6f77, '2012-06-07 14:32:20', 'timeout dialog'),
('en', '_template', 'session_timeout_stay_connected', 0x5374617920436f6e6e6563746564, '2012-06-07 14:32:41', ''),
('en', '_template', 'session_timeout_title', 0x53657373696f6e2054696d656f7574, '2012-06-07 14:31:51', 'timeout dialog'),
('en', '_template', 'session_will_expire', 0x596f75722073657373696f6e2069732061626f757420746f206578706972652e, '2012-06-07 11:00:24', 'timeout warning'),
('en', '_template', 'set', 0x536574, '2003-06-30 17:02:05', 'admin language manager'),
('en', '_template', 'settings', 0x53657474696e6773, '2009-05-27 12:01:11', ''),
('en', '_template', 'set_all_weights', 0x536574206120706f696e742076616c756520666f7220616c6c20746865207175657374696f6e73206f6e207468697320746573742e2020416674657220796f752061726520646f6e652c20636c69636b202273617665222e, '2010-06-16 11:22:11', 'test questions'),
('en', '_template', 'set_default', 0x5365742061732044656661756c74, '2004-10-15 15:48:04', 'set as default button in theme manager'),
('en', '_template', 'set_preset', 0x4170706c7920507265736574, '2003-05-24 10:52:43', 'preferences'),
('en', '_template', 'shared_forums', 0x53686172656420466f72756d73, '2004-11-03 11:18:31', ''),
('en', '_template', 'shindig_blurb', 0x496620796f75206861766520796f7572206f776e205368696e646967207365727665722073657475702c20796f75722063616e20656e746572207468652055524c20746f207468652073657276657220686572652e20496620796f7520646f206e6f74206861766520796f7572206f776e205368696e646967207365727665722c20796f752063616e20656974686572206c65617665207468652055524c20656d7074792c206f7220796f752063616e207573652022687474703a2f2f736f6369616c2e617475746f722e63612f7368696e6469672f7068702220746f20636f6e6e65637420746f2074686520415475746f7220736f6369616c206e6574776f726b2e205368696e64696720616c6c6f777320757365727320746f206c696e6b20676164676574732066726f6d206f7468657220736974657320696e746f20746865697220736f6369616c206e6574776f726b696e6720656e7669726f6e6d656e742c2061732077656c6c20617320636f6d6d756e696361746520776974682074686f736520696e206f7468657220736f6369616c206e6574776f726b732e20496620796f752063686f6f7365206e6f7420746f207573652061205368696e646967207365727665722c20796f757220736f6369616c206e6574776f726b2077696c6c2066756e6374696f6e20617320612073656c662d636f6e7461696e6564206e6574776f726b2c20776974686f75742061636365737320746f2065787465726e616c206e6574776f726b732e, '2010-12-14 16:15:48', ''),
('en', '_template', 'shindig_url', 0x55524c206f66204f7074696f6e616c205368696e446967207365727665722e, '2009-05-27 12:01:11', ''),
('en', '_template', 'shortcuts', 0x53686f727463757473, '2004-04-27 14:57:01', ''),
('en', '_template', 'short_paragraph', 0x53686f727420506172616772617068, '2003-05-21 20:13:03', 'test manager test type'),
('en', '_template', 'show', 0x53686f77, '2005-03-15 11:37:59', ''),
('en', '_template', 'show_all', 0x73686f7720616c6c, '2009-05-27 12:01:11', ''),
('en', '_template', 'show_all_remedial', 0x53686f7720416c6c2052656d656469616c20436f6e74656e74, '2013-01-23 14:19:21', ''),
('en', '_template', 'show_available_applications', 0x53686f7720417661696c61626c652047616467657473, '2009-05-27 12:01:11', ''),
('en', '_template', 'show_bread_crumbs', 0x53686f772042726561646372756d62204c696e6b204e617669676174696f6e, '2008-09-24 13:05:06', ''),
('en', '_template', 'show_contents', 0x53686f772070616765205461626c65206f6620436f6e74656e7473, '2010-10-07 10:42:22', ''),
('en', '_template', 'show_current', 0x446973706c6179205468696e67732043757272656e74206f6e204d792053746172742050616765, '2012-07-09 12:37:21', ''),
('en', '_template', 'show_guest_form', 0x53686f7720477565737420496e666f726d6174696f6e20436f6c6c656374696f6e20466f726d, '2008-10-09 14:13:38', ''),
('en', '_template', 'show_guide', 0x53686f7720436f6e746578742053656e736974697665204c696e6b7320746f2048616e64626f6f6b, '2008-09-24 12:09:33', ''),
('en', '_template', 'show_next_previous_buttons', 0x53686f77204e6578742f50726576696f7573204e617669676174696f6e20427574746f6e73, '2008-09-24 13:04:28', ''),
('en', '_template', 'show_numbers', 0x546f706963204e756d626572696e67, '2005-02-09 10:20:54', 'preference option'),
('en', '_template', 'show_on_home_page', 0x53686f77206f6e20486f6d652050616765, '2009-05-27 12:01:11', ''),
('en', '_template', 'show_pages', 0x53686f77205061676573, '2010-04-21 16:28:13', 'thing current'),
('en', '_template', 'show_raw_tracking', 0x53686f772072617720747261636b696e67, '2003-11-26 15:19:12', ''),
('en', '_template', 'show_summary_tracking', 0x53686f772073756d6d61727920747261636b696e67, '2003-11-26 15:18:39', ''),
('en', '_template', 'show_your_applications', 0x53686f7720596f75722047616467657473, '2009-05-27 12:01:11', ''),
('en', '_template', 'side_menu', 0x53696465204d656e75, '2005-03-04 14:37:00', ''),
('en', '_template', 'side_menu_closed', 0x53696465206d656e7520636c6f7365642e, '2014-01-01 18:16:50', 'sidemenu toggle aria-live message'),
('en', '_template', 'side_menu_opened', 0x53696465206d656e75206f70656e6564, '2014-01-01 18:16:10', 'sidemenu toggle aria-live message'),
('en', '_template', 'side_menu_text', 0x43686f6f7365207768696368206d656e75206974656d7320796f7520776f756c64206c696b6520646973706c617965642061742074686520736964652e, '2005-03-04 15:17:16', ''),
('en', '_template', 'sign_lang', 0x5369676e204c616e6775616765, '2008-09-09 08:56:34', ''),
('en', '_template', 'sign_language', 0x5369676e206c616e6775616765, '2008-09-08 14:19:39', ''),
('en', '_template', 'singapore-sls', 0x53696e6761706f72652d534c53, '2008-09-09 09:01:13', ''),
('en', '_template', 'sitemap', 0x536974652d6d6170, '2003-05-21 20:17:21', 'global site-map text'),
('en', '_template', 'sitemap_text', 0x42726f777365207468726f756768207468652077686f6c6520636f7572736520736974652066726f6d206f6e65206c6f636174696f6e2e, '2009-07-02 14:15:24', ''),
('en', '_template', 'site_name', 0x53697465204e616d65, '2005-03-03 10:49:59', ''),
('en', '_template', 'size', 0x53697a65, '2003-05-22 13:01:20', 'file manager, zip tool'),
('en', '_template', 'smile_angry', 0x616e677279, '2004-02-12 12:20:44', ''),
('en', '_template', 'smile_confused', 0x636f6e6675736564, '2004-02-12 12:21:15', ''),
('en', '_template', 'smile_crazy', 0x6372617a79, '2004-02-12 12:20:59', ''),
('en', '_template', 'smile_evil', 0x6576696c, '2004-02-12 12:20:37', ''),
('en', '_template', 'smile_frown', 0x66726f776e, '2004-02-12 12:20:14', ''),
('en', '_template', 'smile_lol', 0x6c61756768696e67206f7574206c6f7564, '2004-02-12 12:20:53', ''),
('en', '_template', 'smile_muah', 0x6d756168, '2004-02-12 12:21:23', ''),
('en', '_template', 'smile_oh_well', 0x6f682077656c6c, '2004-02-12 12:20:21', ''),
('en', '_template', 'smile_smile', 0x736d696c65, '2004-02-12 12:20:02', ''),
('en', '_template', 'smile_tired', 0x7469726564, '2004-02-12 12:21:06', ''),
('en', '_template', 'smile_tongue', 0x746f6e677565, '2004-02-12 12:20:27', ''),
('en', '_template', 'smile_wink', 0x77696e6b, '2004-02-12 12:20:08', ''),
('en', '_template', 'social', 0x4e6574776f726b696e67, '2009-05-27 12:01:11', ''),
('en', '_template', 'social_and_lms', 0x55736520415475746f72204c4d53207769746820415475746f7220536f6369616c206d6f64756c65, '2009-07-17 14:12:34', ''),
('en', '_template', 'social_groups', 0x4e6574776f726b2047726f757073, '2009-05-27 12:01:11', ''),
('en', '_template', 'social_profile', 0x4e6574776f726b2050726f66696c65, '2009-05-27 12:01:11', ''),
('en', '_template', 'social_switch', 0x536f6369616c204e6574776f726b696e67, '2009-07-17 14:11:16', ''),
('en', '_template', 'social_switch_text', 0x43686f6f736520746f2075736520415475746f72206173206120736f6369616c206e6574776f726b696e6720656e7669726f6e6d656e74206f6e6c792c206f722061732061206c6561726e696e67206d616e6167656d656e742073797374656d2077697468206120736f6369616c206e6574776f726b696e67206d6f64756c652e, '2009-07-17 14:19:22', ''),
('en', '_template', 'spanish', 0x5370616e697368, '2008-09-09 09:01:12', ''),
('en', '_template', 'spanish-lse', 0x5370616e6973682d4c5345, '2008-09-09 09:01:13', ''),
('en', '_template', 'specific_groups', 0x53706563696669632047726f757073, '2006-03-23 13:39:26', ''),
('en', '_template', 'specify_url_to_content_package', 0x4f722c205370656369667920612055524c20746f206120436f6e74656e74205061636b616765206f7220436f6d6d6f6e20436172747269646765, '2009-11-16 10:57:14', ''),
('en', '_template', 'specify_url_to_theme_package', 0x4f722c205370656369667920612055524c20746f2061205468656d65, '2004-10-18 15:10:35', ''),
('en', '_template', 'sports_recreation', 0x53706f72747320616e642052656372656174696f6e, '2009-05-27 12:01:11', ''),
('en', '_template', 'sql_statement', 0x53514c2053746174656d656e74, '2008-04-21 15:11:31', ''),
('en', '_template', 'standard', 0x5374616e64617264, '2005-09-21 13:35:25', ''),
('en', '_template', 'started_by', 0x53746172746564204279, '2003-05-22 13:02:38', 'forums thread display table column header'),
('en', '_template', 'startend_date_format', 0x25256a2f25256e2f252579202525473a252569, '2007-12-09 15:58:39', ''),
('en', '_template', 'startend_date_longs_format', 0x2525592d25256d2d252564202525483a252569, '2008-08-27 11:23:57', ''),
('en', '_template', 'startend_date_long_format', 0x2525592d25256d2d252564202525483a252569, '2008-08-27 11:24:04', ''),
('en', '_template', 'start_date', 0x53746172742044617465, '2003-05-22 13:03:05', 'mytests, test manager'),
('en', '_template', 'start_test', 0x426567696e, '2009-11-13 16:18:58', 'test intro'),
('en', '_template', 'state', 0x5374617465, '2005-08-16 15:27:15', ''),
('en', '_template', 'statement', 0x53746174656d656e74, '2003-05-22 13:07:22', 'test manager add/edit questions'),
('en', '_template', 'statistics', 0x53746174697374696373, '2003-05-22 13:08:06', 'instructor course statistics/details'),
('en', '_template', 'statistics_information', 0x537461746973746963732026616d703b20496e666f726d6174696f6e, '2007-07-26 13:39:49', ''),
('en', '_template', 'status', 0x537461747573, '2003-05-22 13:09:29', 'test manager, control center, profile, admin user manager'),
('en', '_template', 'sticky_thread', 0x537469636b7920546f706963202d20616c776179732061742074686520746f70, '2014-01-02 15:41:44', 'instructor forum option alt text'),
('en', '_template', 'stop_apply_audio_alternatives', 0x53746f70204170706c79696e6720417564696f20416c7465726e617469766573, '2010-04-21 14:35:40', 'alternative switcher'),
('en', '_template', 'stop_apply_sign_lang_alternatives', 0x53746f70204170706c79696e67205369676e204c616e677561676520416c7465726e617469766573, '2010-04-21 14:36:15', 'alternative switcher'),
('en', '_template', 'stop_apply_text_alternatives', 0x53746f70204170706c79696e67205465787420416c7465726e617469766573, '2010-04-21 14:35:20', 'alternative switcher'),
('en', '_template', 'stop_apply_visual_alternatives', 0x53746f70204170706c79696e672056697375616c20416c7465726e617469766573, '2010-04-21 14:35:57', 'alternative switcher'),
('en', '_template', 'street_address', 0x5374726565742041646472657373, '2003-05-22 13:10:43', 'registration, profile'),
('en', '_template', 'student', 0x53747564656e74, '2003-10-27 11:44:47', 'tracker'),
('en', '_template', 'student1', 0x53747564656e74, '2003-05-22 13:11:42', 'admin user manager'),
('en', '_template', 'students', 0x53747564656e7473, '2003-05-21 20:01:44', 'course email (removed 1.2)'),
('en', '_template', 'student_id', 0x53747564656e74204944, '2003-05-22 13:12:40', 'tracker'),
('en', '_template', 'student_not_exists', 0x53747564656e74206e6f7420657869737473, '2008-09-25 16:01:17', 'gradebook'),
('en', '_template', 'student_page_stats', 0x53747564656e742075736167652073746174697374696373206279206c6f67696e206e616d65, '2013-11-17 11:11:06', ''),
('en', '_template', 'student_pin', 0x53747564656e742050494e, '2005-05-27 13:35:11', ''),
('en', '_template', 'student_tools', 0x53747564656e7420546f6f6c73, '2008-11-07 09:17:23', ''),
('en', '_template', 'student_tools_text', 0x4163636573732074686520746f6f6c73207573656420696e207468697320636f757273652e, '2009-07-02 14:16:37', ''),
('en', '_template', 'style_editor', 0x5374796c65736865657420456469746f72, '2003-05-22 13:13:22', 'tool page/ stylesheet editor heading text'),
('en', '_template', 'subject', 0x5375626a656374, '2003-05-22 13:14:21', 'global message subject label'),
('en', '_template', 'submission', 0x5375626d697373696f6e, '2005-05-11 11:29:07', ''),
('en', '_template', 'submissions', 0x5375626d697373696f6e73, '2003-05-22 13:14:47', 'links database'),
('en', '_template', 'submit', 0x5375626d6974, '2003-05-22 13:15:05', 'global submit button text'),
('en', '_template', 'submitted_by', 0x5375626d6974746564204279, '2005-02-23 12:23:06', ''),
('en', '_template', 'submit_no', 0x4e6f, '2004-11-22 16:23:09', ''),
('en', '_template', 'submit_yes', 0x596573, '2004-11-22 16:23:00', ''),
('en', '_template', 'subscribe', 0x53756273637269626520746f20746869732074687265616420746f2072656365697665206e6f74696669636174696f6e2076696120656d61696c206f66206e6577207265706c6965732e, '2003-11-06 13:47:10', ''),
('en', '_template', 'subscribe1', 0x537562736372696265, '2004-12-02 15:32:01', ''),
('en', '_template', 'sub_topics', 0x537562746f70696373, '2005-03-16 13:55:12', 'content manager'),
('en', '_template', 'suggestions', 0x53756767657374696f6e73, '2009-05-27 12:01:11', ''),
('en', '_template', 'suggest_link', 0x5375676765737420436f75727365204c696e6b, '2006-05-25 11:40:32', ''),
('en', '_template', 'summary', 0x53756d6d617279, '2003-09-13 09:24:55', 'course tracker member picker'),
('en', '_template', 'support_tools', 0x4c6561726e657220546f6f6c73, '2010-05-03 14:59:19', ''),
('en', '_template', 'swedish', 0x53776564697368, '2008-09-09 09:01:13', ''),
('en', '_template', 'switch_icon_view', 0x537769746368206265747765656e2069636f6e20616e642064657461696c6564207669657773, '2014-01-01 14:43:41', ''),
('en', '_template', 'switch_text', 0x53776974636820746f207465787420656469746f72, '2004-05-27 10:50:47', 'Content editor'),
('en', '_template', 'switch_visual', 0x53776974636820746f2076697375616c20656469746f72, '2004-05-27 10:52:19', 'Used in content editor'),
('en', '_template', 'syndicate_announcements', 0x53796e64696361746520416e6e6f756e63656d656e7473, '2005-01-04 09:46:15', ''),
('en', '_template', 'system_preferences', 0x53797374656d20507265666572656e636573, '2005-03-03 10:49:44', ''),
('en', '_template', 'table_of_contents', 0x5061676520436f6e74656e7473, '2010-10-07 10:42:38', 'preferences'),
('en', '_template', 'take_test', 0x54616b652054657374, '2003-05-22 13:54:16', 'MyTests'),
('en', '_template', 'tamil', 0x54616d696c, '2008-09-09 09:01:12', ''),
('en', '_template', 'tech_support_forum', 0x436f6d6d756e69747920537570706f727420466f72756d, '2008-11-14 13:38:14', 'help'),
('en', '_template', 'tech_support_forum_text', 0x537570706f7274207175657374696f6e732073686f756c64206265206f66206120746563686e6963616c206e61747572652e, '2005-07-05 14:13:20', 'help'),
('en', '_template', 'template', 0x54656d706c617465, '2006-09-25 13:07:42', ''),
('en', '_template', 'tests', 0x546573747320616e642053757276657973, '2010-06-25 14:02:12', ''),
('en', '_template', 'test_anonymous', 0x5468697320746573742f73757276657920697320616e6f6e796d6f75732e, '2004-09-02 13:42:31', ''),
('en', '_template', 'test_confirm_submit', 0x596f75206172652061626f757420746f207375626d69742074686520746573742f7375727665792e2020506c65617365206e6f74652074686174206368616e67657320617265206e6f7420616c6c6f776564206f6e63652074686520746573742f737572766579206973207375626d69747465642c20646f20796f752077616e7420746f2070726f636565643f, '2010-05-07 10:53:46', 'test questions'),
('en', '_template', 'test_custom_duration_negative', 0x637573746f6d206475726174696f6e206f662074696d656420746573742063616e6e6f74206265206e65676174697665, '2014-08-20 13:14:51', 'Test/Survey Property'),
('en', '_template', 'test_custom_duration_zero', 0x637573746f6d206475726174696f6e206f662074696d65642074657374, '2014-08-20 13:14:51', 'Test/Survey Property'),
('en', '_template', 'test_description', 0x54657374204465736372697074696f6e, '2008-03-10 11:50:11', 'Test/Survey Property'),
('en', '_template', 'test_import_package', 0x496d706f727420617661696c61626c652074657374732e, '2008-10-21 11:43:37', ''),
('en', '_template', 'test_lk', 0x4c696b657274, '2004-08-12 15:55:22', ''),
('en', '_template', 'test_ma', 0x4d756c7469706c6520416e73776572, '2007-02-01 15:49:57', ''),
('en', '_template', 'test_matching', 0x4d61746368696e67202853696d706c6529, '2007-02-01 16:20:41', ''),
('en', '_template', 'test_matchingdd', 0x4d61746368696e67202847726170686963616c29, '2007-02-01 16:20:28', ''),
('en', '_template', 'test_mc', 0x4d756c7469706c652043686f696365, '2003-05-22 14:03:29', 'test manager question type'),
('en', '_template', 'test_open', 0x4f70656e20456e646564, '2003-05-22 14:03:45', 'test manager question type'),
('en', '_template', 'test_ordering', 0x4f72646572696e67, '2007-01-10 13:45:26', ''),
('en', '_template', 'test_tf', 0x54727565206f722046616c7365, '2003-05-22 14:09:05', 'test manager question type'),
('en', '_template', 'text', 0x54657874, '2004-04-20 16:40:07', ''),
('en', '_template', 'textual', 0x5465787475616c, '2008-09-08 14:19:22', ''),
('en', '_template', 'theme', 0x5468656d65, '2004-04-23 15:26:57', ''),
('en', '_template', 'themes', 0x5468656d6573, '2003-05-22 14:10:24', 'preferences'),
('en', '_template', 'themes_disabled', 0x54686520706572736f6e616c207468656d6520707265666572656e636520686173206265656e2064697361626c656420696e206661766f7572206f66207468656d652073706563696669632063617465676f726965732e, '2004-08-04 11:58:33', ''),
('en', '_template', 'themes_for_desktop', 0x5468656d657320666f72206465736b746f7020636f6d707574657273, '2010-06-18 15:45:59', ''),
('en', '_template', 'themes_for_mobile', 0x5468656d657320666f72206d6f62696c652064657669636573, '2010-06-18 15:46:14', ''),
('en', '_template', 'theme_screenshot', 0x53637265656e73686f74, '2005-05-06 14:18:00', 'theme manager, screentshot alt/title'),
('en', '_template', 'theme_specific_categories', 0x5468656d652053706563696669632043617465676f72696573, '2005-03-31 13:49:53', ''),
('en', '_template', 'there_are_entries', 0x54686572652061726520257320656e74726965732e, '2009-05-27 12:01:11', ''),
('en', '_template', 'thesaurus', 0x546865736175727573, '2008-09-09 09:03:56', ''),
('en', '_template', 'the_follow_errors_occurred', 0x54686520666f6c6c6f77696e67206572726f7273206f636375727265643a, '2005-03-07 12:41:09', ''),
('en', '_template', 'things_current', 0x43757272656e74204163746976697479, '2013-11-17 15:09:50', 'my start page'),
('en', '_template', 'this_course_only', 0x5468697320636f75727365206f6e6c79, '2004-08-18 12:02:37', ''),
('en', '_template', 'this_is_content', 0x54686973206973206120626c616e6b20636f6e74656e7420706167652e2055736520456469742074686973205061676520696e2074686520436f6e74656e7420456469746f72206c696e6b732061626f766520746f206d6f64696679207468697320706167652e2041732074686520696e7374727563746f72206f66207468697320636f757273652c20796f752063616e206d616e616765206974207468726f75676820746865204d616e616765207461622061626f76652e, '2010-10-19 10:16:29', 'default content insert when a new course is created'),
('en', '_template', 'thread', 0x546f706963, '2014-01-02 15:41:57', 'forums subscription email'),
('en', '_template', 'thread_already_subscribed', 0x596f752061726520616c7265616479207375627363726962656420746f207468697320746f7069632e, '2014-01-02 15:42:05', 'forum view thread subscribe feedback'),
('en', '_template', 'thread_locked', 0x546f706963204c6f636b6564, '2014-01-02 15:42:19', 'forum thread view thread lock message'),
('en', '_template', 'thread_notify1', 0x546f70696320537562736372697074696f6e, '2014-01-02 15:42:31', 'Thread email notify subject'),
('en', '_template', 'thread_subscribe', 0x53756273637269626520746f207468697320746f70696320746f2072656365697665206e6f74696669636174696f6e2076696120656d61696c206f66207265706c6965732e, '2014-01-02 15:42:41', 'forum thread subscribe description'),
('en', '_template', 'tile_any_field', 0x416e79204669656c64, '2004-05-03 13:14:02', ''),
('en', '_template', 'tile_author', 0x417574686f72, '2004-05-03 13:14:17', ''),
('en', '_template', 'tile_export', 0x4578706f727420636f6e74656e7420746f207468652041436f6e74656e74207265706f7369746f72792e20412076616c69642041436f6e74656e74206163636f756e742069732072657175697265642e, '2010-06-09 15:20:40', ''),
('en', '_template', 'tile_howto', 0x456e746572206b6579776f72647320746f207365617263682041436f6e74656e74207265706f7369746f72792e, '2010-06-09 15:21:01', 'tile search'),
('en', '_template', 'tile_import_content_package_about', 0x496d706f72742074686520636f6e74656e74206469726563746c7920696e746f207468697320636f757273652e, '2004-05-03 13:15:54', ''),
('en', '_template', 'tile_keyword', 0x4b6579776f7264, '2004-05-03 13:14:23', ''),
('en', '_template', 'tile_not_accessible', 0x41436f6e74656e74207265706f7369746f7279206973206e6f742061636365737369626c652e, '2010-06-09 15:21:48', 'tile search'),
('en', '_template', 'tile_no_response', 0x4e6f20726573706f6e73652066726f6d2041436f6e74656e742e204974206d6967687420626563617573652074686520636f7572736520697320746f6f2062696720746f206265206175746f2d696d706f7274656420696e746f2041436f6e74656e742c206f7220756e6b6e6f776e2070726f626c656d73206f636375727265642e20506c6561736520646f776e6c6f61642074686520415475746f72207061636b61676520616e64206d616e75616c6c7920696d706f727420696e746f2041436f6e74656e742e, '2010-07-12 11:48:07', ''),
('en', '_template', 'tile_progress', 0x41436f6e74656e7420496d706f7274696e6720696e2050726f67726573732e2e2e, '2010-06-09 15:22:31', ''),
('en', '_template', 'tile_search', 0x41436f6e74656e74, '2010-06-09 15:22:46', ''),
('en', '_template', 'tile_search_text', 0x5365617263682074686520636f6e74656e74207265706f7369746f727920666f72206164646974696f6e616c206c6561726e696e67206d6174657269616c732e20557365207265736572766564206b6579776f726420224f522220286d757374206265206361706974616c2920696e206265747765656e20736561726368696e6720776f72647320666f7220736561726368696e6720656974686572206f6e65206f66207365766572616c20776f7264732e, '2010-05-05 16:13:20', ''),
('en', '_template', 'tile_setup', 0x41436f6e74656e74205365747570, '2010-06-09 15:17:05', ''),
('en', '_template', 'tile_setup_txt', 0x456e74657220746865206c6f636174696f6e206f66207468652041436f6e74656e74207265706f7369746f72792028687474703a2f2f7777772e61636f6e74656e742e636f6d2920616e64207468652041436f6e74656e742077656220736572766963652049442e20416e2041436f6e74656e742077656220736572766963652049442063616e206265206f627461696e6564206279207265676973746572696e67206f6e20616e2041436f6e74656e742073797374656d2e204f722c20696620616c726561647920726567697374657265642c2069742063616e2062652061636365737365642066726f6d207468652041436f6e74656e74202250726f66696c652220706167652e, '2010-06-09 15:19:49', ''),
('en', '_template', 'tile_technical_format', 0x546563686e6963616c20466f726d6174, '2004-05-03 13:14:51', ''),
('en', '_template', 'timed_test', 0x54696d65642054657374, '2014-06-04 13:14:51', 'tests module'),
('en', '_template', 'timed_test_duration_negative', 0x6475726174696f6e206f662074696d656420746573742063616e6e6f74206265206e65676174697665, '2014-06-04 13:14:51', 'Test/Survey Property'),
('en', '_template', 'timed_test_duration_zero', 0x6475726174696f6e206f662074696d65642074657374, '2014-06-04 13:14:51', 'Test/Survey Property'),
('en', '_template', 'timed_test_emergency_mode', 0x456d657267656e6379204d6f6465, '2014-08-20 11:48:32', 'Test/Survey Property'),
('en', '_template', 'timed_test_intermediate_mode', 0x496e7465726d656469617465204d6f6465, '2014-08-20 11:48:32', 'Test/Survey Property'),
('en', '_template', 'timed_test_modes', 0x54696d65642054657374204d6f646573, '2014-08-20 11:48:32', 'Test/Survey Property'),
('en', '_template', 'timed_test_normal_mode', 0x4e6f726d616c204d6f6465, '2014-08-20 11:48:32', 'Test/Survey Property'),
('en', '_template', 'timeout_message', 0x54696d652055702e20596f757220616e73776572732077696c6c206265207375626d69747465642e, '2014-08-20 11:48:32', 'take test page'),
('en', '_template', 'timeout_minutes', 0x6d696e75746573, '2013-01-31 11:48:32', 'system preferences'),
('en', '_template', 'timeout_title', 0x54696d6520557021, '2014-08-20 11:48:32', 'take test page'),
('en', '_template', 'times', 0x54696d6573, '2009-10-26 15:03:31', ''),
('en', '_template', 'timestamp', 0x54696d657374616d70, '2004-12-06 12:04:30', ''),
('en', '_template', 'time_spent', 0x54696d65205370656e74, '2007-07-09 12:32:33', ''),
('en', '_template', 'time_zone', 0x54696d65205a6f6e652028646174652062656c6f772073686f756c64206d6174636820796f7572206c6f63616c2074696d6529, '2010-03-03 16:32:12', 'appears on the config page'),
('en', '_template', 'time_zones_not_supported', 0x596f757220736572766572206973206e6f74207365742d757020746f20737570706f72742074696d65207a6f6e65732e20536565207468652048616e64626f6f6b20666f72206d6f72652064657461696c732e, '2006-11-01 13:06:40', ''),
('en', '_template', 'title', 0x5469746c65, '2003-05-22 14:43:54', 'admin course manager column heading'),
('en', '_template', 'to', 0x546f, '2003-05-22 14:45:14', 'inbox send message "to" a user'),
('en', '_template', 'to1', 0x746f, '2003-05-22 14:48:13', 'login form header row login -to- some place'),
('en', '_template', 'toggle_disabled', 0x546f67676c652044697361626c6564, '2003-05-22 15:10:01', 'alt text for menu toggle'),
('en', '_template', 'tools', 0x546f6f6c73, '2006-03-22 12:52:10', ''),
('en', '_template', 'tools_details', 0x44657461696c7320666f7220546f6f6c205573616765, '2003-05-22 15:11:15', 'tracker'),
('en', '_template', 'tools_manager', 0x416464204163746976697479, '2009-10-22 16:17:01', 'content editor'),
('en', '_template', 'tool_manager', 0x546f6f6c2f4163746976697479204d616e61676572, '2009-11-19 16:12:28', 'core modules'),
('en', '_template', 'tool_man_comment', 0x43686f6f73652066726f6d2074686520746f6f6c7320617661696c61626c6520696e2074686520636f757273652c20746f20616464206163746976697469657320746f207468697320636f6e74656e742e, '2009-11-05 12:29:40', 'content tool manager'),
('en', '_template', 'tool_settings', 0x4c6561726e657220537570706f727473, '2010-04-12 16:29:59', ''),
('en', '_template', 'tool_summary', 0x546f6f6c732055736167652053756d6d617279, '2003-05-22 15:11:26', 'tracker'),
('en', '_template', 'top', 0x546f70, '2003-05-22 15:11:53', 'global alt text for jump to top link/icon'),
('en', '_template', 'topic', 0x546f706963, '2003-05-22 15:12:45', 'forum thread list column heading'),
('en', '_template', 'top_20', 0x4f6e6c792074686520746f7020323020726573756c74732068617665206265656e20646973706c617965642e, '2005-10-20 10:50:41', ''),
('en', '_template', 'top_level', 0x546f70204c6576656c, '2005-03-16 13:36:35', 'content manager'),
('en', '_template', 'total', 0x546f74616c, '2003-05-22 15:14:13', 'instructor course statistic/details, test manager'),
('en', '_template', 'total_votes', 0x546f74616c20566f746573, '2005-03-11 15:51:33', ''),
('en', '_template', 'to_2', 0x746f, '2003-05-22 15:15:16', 'test manager date'),
('en', '_template', 'to_email', 0x546f20456d61696c, '2003-05-22 15:17:02', 'help admin/instructor contact forms'),
('en', '_template', 'to_name', 0x546f204e616d65, '2003-05-22 15:17:20', 'help admin/instructor contact forms'),
('en', '_template', 'tracker', 0x436f6e74656e7420547261636b6572, '2005-11-25 18:36:21', ''),
('en', '_template', 'tracker_none_viewed', 0x4e6f20636f6e74656e742070616765732068617665206265656e2076696577656420696e207468697320636f75727365207965742e, '2003-09-15 11:53:06', 'mytracker summary view'),
('en', '_template', 'tracker_not_viewed', 0x4a756d7020746f207061676573206e6f7420796574207669657765642e, '2003-09-13 12:16:10', 'mytracker bypass to not viewed alt text'),
('en', '_template', 'tracker_pages_total', 0x546f74616c20706167657320696e207468697320636f757273652025732028706167657320766973697465643a2025732e29, '2003-09-13 09:11:43', 'tracker summary pages read'),
('en', '_template', 'tracker_percent_read', 0x50657263656e74616765206f66207061676573207669657765642025732e, '2003-09-13 12:09:57', 'tracker pages read'),
('en', '_template', 'tracker_summary_read', 0x53756d6d617279206f662070616765732076696577656420627920757365722025732e, '2003-09-13 12:30:44', 'tracker summary read'),
('en', '_template', 'tracking', 0x547261636b696e67, '2003-05-22 15:18:11', 'admin course manager '),
('en', '_template', 'tracking_all_page_viewed', 0x416c6c20706167657320696e207468697320636f757273652068617665206265656e207669657765642e, '2003-09-13 12:37:23', 'mytracker page not viewed'),
('en', '_template', 'training_and_education', 0x547261696e696e6720616e6420456475636174696f6e, '2009-05-27 12:01:11', ''),
('en', '_template', 'transformable_uri', 0x41436f6e74656e742055524c, '2010-06-09 15:32:25', ''),
('en', '_template', 'translate', 0x5472616e736c617465, '2004-12-07 13:59:44', 'language manager translate button');
INSERT INTO `AT_language_text` (`language_code`, `variable`, `term`, `text`, `revised_date`, `context`) VALUES
('en', '_template', 'translate_lang_howto', 0x496e206f7264657220746f207472616e736c6174652061206c616e677561676520796f75206d757374203a203c6272202f3e0d0a312e20536574207468652041545f444556454c5f5452414e534c41544520636f6e7374616e7420696e202f696e636c7564652f766974616c732e696e632e70687020746f20273127203c6272202f3e0d0a322e204d616b652073757265207468617420796f75206861766520616464656420746865206e6577206c616e677561676520746f207468652064617461626173653c6272202f3e0d0a332e2053656c6563742020746865206e6577206c616e677561676520617320746865206f6e6520796f752077616e7420746f207472616e736c6174652066726f6d2074686520277472616e736c61746520746f3a27206f7074696f6e2061742074686520626f74746f6d206f662074686520706167653c6272202f3e0d0a342e2055736520746865207472616e736c61746520627574746f6e20616e64207472616e736c61746520746865206e6577206c616e677561676520696e2061206e65772077696e646f773c6272202f3e, '2004-12-10 16:29:48', 'Language Manager, translation message'),
('en', '_template', 'translate_to', 0x5472616e736c61746520746f3a, '2003-05-22 15:19:14', 'footer'),
('en', '_template', 'true', 0x54727565, '2003-05-22 15:19:50', 'test manager question answer option'),
('en', '_template', 'type', 0x54797065, '2003-05-22 15:20:30', 'test manager questions column heading'),
('en', '_template', 'unchecked', 0x556e2d636865636b6564, '2006-06-26 14:56:06', ''),
('en', '_template', 'unconfirmed', 0x556e636f6e6669726d6564, '2005-04-01 10:39:51', ''),
('en', '_template', 'underline', 0x556e6465726c696e65, '2003-05-22 15:21:31', 'global code picker'),
('en', '_template', 'underscore', 0x556e64657273636f7265, '2004-06-22 12:09:46', ''),
('en', '_template', 'unenroll', 0x556e2d656e726f6c6c, '2004-10-15 11:51:25', 'unenroll button in enrollment manager'),
('en', '_template', 'unenrolled', 0x556e2d656e726f6c6c6564, '2004-10-15 11:50:06', 'unenrolled tab in enrollement manager'),
('en', '_template', 'unenroll_me', 0x556e656e726f6c6c, '2007-12-09 08:57:03', ''),
('en', '_template', 'uninstall', 0x556e696e7374616c6c, '2008-10-21 15:41:53', ''),
('en', '_template', 'uninstall_module_info', 0x596f75206172652061626f757420746f203c7374726f6e673e554e494e5354414c4c3c2f7374726f6e673e206d6f64756c65203c7374726f6e673e3c656d3e25733c2f656d3e3c2f7374726f6e673e2e, '2008-10-21 15:41:53', ''),
('en', '_template', 'unique_visits', 0x556e6971756520566973697473, '2005-03-01 12:41:13', 'tracker'),
('en', '_template', 'university', 0x5363686f6f6c2f496e737469747574696f6e, '2009-05-27 12:01:11', ''),
('en', '_template', 'unknown', 0x556e6b6e6f776e, '2003-06-06 10:41:35', 'links database , file upload progress window'),
('en', '_template', 'unknown_error', 0x416e20756e6b6e6f776e206572726f72206f636375726564, '2003-05-22 15:22:55', 'general catch all error message'),
('en', '_template', 'unlimited', 0x556e6c696d69746564, '2005-03-01 11:22:02', 'admin course properties & file manager'),
('en', '_template', 'unlock_thread', 0x556e6c6f636b20546f706963, '2014-01-02 15:42:55', 'forum instructor lock screen'),
('en', '_template', 'unmarked', 0x556e6d61726b6564, '2003-05-22 15:25:33', 'mytests, test manager'),
('en', '_template', 'unmarked_label', 0x556e6d61726b65642028257329, '2005-05-12 10:25:56', ''),
('en', '_template', 'unreleased', 0x556e72656c6561736564, '2005-05-04 13:59:37', ''),
('en', '_template', 'unshared_forums', 0x556e73686172656420466f72756d73, '2004-11-05 10:50:02', ''),
('en', '_template', 'unsubscribe', 0x556e5375627363726962652066726f6d20746869732074687265616420746f2063616e63656c20726563656976696e67206e6f74696669636174696f6e732076696120656d61696c206f66206e6577207265706c6965732e, '2003-11-06 13:47:20', ''),
('en', '_template', 'unsubscribe1', 0x556e737562736372696265, '2004-12-02 15:32:28', ''),
('en', '_template', 'until', 0x556e74696c, '2006-03-23 11:38:49', ''),
('en', '_template', 'unvisited_pages', 0x596f752068617665206e6f74207669657765642074686520666f6c6c6f77696e672070616765733a, '2003-09-13 11:56:50', 'mytracker summary'),
('en', '_template', 'update', 0x557064617465, '2004-11-24 14:28:45', ''),
('en', '_template', 'updated', 0x55706461746564, '2003-05-22 15:33:15', 'admin course manager'),
('en', '_template', 'update_gradebook', 0x55706461746520415475746f72204d61726b73, '2008-09-25 16:01:17', 'gradebook'),
('en', '_template', 'update_list', 0x557064617465204c697374, '2005-05-10 14:31:59', ''),
('en', '_template', 'update_to', 0x55706461746520546f, '2005-03-03 12:16:15', ''),
('en', '_template', 'upload', 0x55706c6f6164, '2003-05-22 15:56:16', 'global upload button/link text'),
('en', '_template', 'upload_backup', 0x55706c6f6164204261636b7570, '2008-05-20 12:44:13', ''),
('en', '_template', 'upload_content_package', 0x55706c6f6164206120436f6e74656e74205061636b616765206f7220436f6d6d6f6e20436172747269646765, '2009-11-16 10:54:04', ''),
('en', '_template', 'upload_custom_logo', 0x55706c6f616420437573746f6d204c6f676f, '2014-01-27 14:28:53', ''),
('en', '_template', 'upload_file', 0x55706c6f61642046696c65, '2006-03-20 14:37:46', ''),
('en', '_template', 'upload_files', 0x55706c6f61642066696c6573, '2008-07-22 16:43:38', 'Used in filemanager and any place that uses fluid for multiple file upload.'),
('en', '_template', 'upload_icon', 0x55706c6f616420437573746f6d20436f757273652049636f6e, '2007-11-09 13:05:42', 'Course Properties Custom Icon'),
('en', '_template', 'upload_icon_text', 0x546869732069636f6e2077696c6c2062652075706c6f6164656420746f207468652066696c65206d616e6167657220666f72207468697320636f7572736520756e6465722074686520666f6c64657220272f637573746f6d5f69636f6e73272e, '2008-07-28 10:36:03', 'Course Properties Custom Icon Text'),
('en', '_template', 'upload_module', 0x55706c6f61642061206d6f64756c65207a69702066696c6520746f20696e7374616c6c2069743a, '2008-11-05 08:48:45', 'Module installation message'),
('en', '_template', 'upload_new_picture', 0x55706c6f6164206e65772070696374757265, '2007-02-26 17:23:08', ''),
('en', '_template', 'upload_patch', 0x55706c6f61642061207a69702066696c6520746f20696e7374616c6c2070617463683a, '2008-04-21 15:08:55', 'patcher'),
('en', '_template', 'upload_progress', 0x46696c652055706c6f616420696e2050726f67726573732e2e2e, '2003-06-06 10:36:38', 'file upload progress window'),
('en', '_template', 'upload_question', 0x53656c656374205175657374696f6e205061636b61676520746f2055706c6f6164, '2008-09-23 14:00:24', ''),
('en', '_template', 'upload_test', 0x53656c6563742054657374205061636b61676520746f2055706c6f6164, '2008-09-23 13:58:43', ''),
('en', '_template', 'upload_theme_package', 0x55706c6f61642061205468656d65, '2004-10-18 15:09:32', 'Theme Manager'),
('en', '_template', 'urdu', 0x55726475, '2008-09-09 09:01:12', ''),
('en', '_template', 'url', 0x55524c, '2003-05-22 15:56:36', 'links database'),
('en', '_template', 'url_to_read', 0x55524c20546f2052656164, '2006-04-13 12:01:15', ''),
('en', '_template', 'usage', 0x5573616765, '2005-03-16 13:55:31', 'content manager'),
('en', '_template', 'usaved_changes_made', 0x556e7361766564206368616e676573206d616465, '2004-01-15 13:30:06', 'editing content'),
('en', '_template', 'user', 0x55736572, '2003-05-22 15:59:34', 'links database'),
('en', '_template', 'username', 0x557365726e616d65, '2003-05-22 16:00:31', 'global username label/link text'),
('en', '_template', 'users', 0x5573657273, '2003-05-22 16:02:26', 'forum, admin user manager'),
('en', '_template', 'users_online', 0x5573657273204f6e6c696e65, '2003-05-22 16:03:00', 'discussions page text'),
('en', '_template', 'user_contributed_notes', 0x5573657220436f6e74726962757465642048616e64626f6f6b204e6f746573, '2005-07-27 12:01:52', ''),
('en', '_template', 'user_offline', 0x4f66666c696e65, '2005-03-11 16:19:14', 'directory'),
('en', '_template', 'user_online', 0x4f6e6c696e65, '2005-03-11 16:19:28', 'directory'),
('en', '_template', 'user_type', 0x557365722054797065, '2008-10-06 13:41:48', ''),
('en', '_template', 'use_alt_to_audio', 0x55736520416c7465726e617469766520546f20417564696f, '2008-09-09 08:56:34', ''),
('en', '_template', 'use_alt_to_text', 0x55736520416c7465726e617469766520546f2054657874, '2008-09-09 08:56:34', ''),
('en', '_template', 'use_alt_to_visual', 0x55736520416c7465726e617469766520546f2056697375616c, '2008-09-09 08:56:34', ''),
('en', '_template', 'use_as_alternative', 0x55736520417320416c7465726e6174697665, '2010-03-09 16:15:53', 'adapted content'),
('en', '_template', 'use_captcha', 0x416c6c6f772074686520757365206f662043415054434841, '2009-06-03 15:33:17', ''),
('en', '_template', 'use_customized_head', 0x5475726e206f6e20637573746f6d20536372697074732f435353, '2010-05-03 10:44:56', ''),
('en', '_template', 'use_enrol_button', 0x5573652074686520627574746f6e2062656c6f7720746f20656e726f6c6c20696e207468697320636f757273652e, '2003-05-22 16:03:37', 'enrol screen instruction'),
('en', '_template', 'use_existing_logo', 0x557365204578697374696e67204c6f676f, '2014-02-21 16:03:37', 'admin custom logo'),
('en', '_template', 'use_higher_grade', 0x55736520686967686572206772616465, '2008-09-25 16:01:17', 'gradebook'),
('en', '_template', 'use_lower_grade', 0x557365206c6f776572206772616465, '2008-09-25 16:01:17', 'gradebook'),
('en', '_template', 'use_parent_theme', 0x55736520706172656e742063617465676f72792773207468656d652e, '2004-08-04 11:34:41', ''),
('en', '_template', 'use_system_time', 0x557365207468652073797374656d27732074696d65, '2006-11-01 13:06:01', ''),
('en', '_template', 'use_url_as_alternative', 0x55736520612072656d6f74652055524c20617320616e20616c7465726e6174697665, '2010-06-18 13:28:40', ''),
('en', '_template', 'use_visual_editor', 0x3c736d616c6c207374796c653d22746578742d6465636f726174696f6e3a756e6465726c696e653b223e28456469746f72293c2f736d616c6c3e, '2004-12-08 12:15:36', 'form editor in create test question'),
('en', '_template', 'version', 0x56657273696f6e, '2003-05-22 16:04:54', 'copyright notice in footer'),
('en', '_template', 'version_history', 0x56657273696f6e20486973746f7279, '2008-10-21 15:41:53', ''),
('en', '_template', 'version_not_match', 0x5468697320706174636820697320666f7220415475746f722076657273696f6e2025732e20446f6573206e6f74206d61746368207769746820796f75722063757272656e7420415475746f722076657273696f6e2e2054686520696e7374616c6c6174696f6e206f66206974206d617920627265616b20415475746f722e2041726520796f75207375726520796f752077616e7420746f2070726f636565643f, '2008-06-19 13:20:45', 'patcher warning message'),
('en', '_template', 'vertical', 0x566572746963616c, '2004-12-01 13:34:28', 'create/edit test question option'),
('en', '_template', 'view', 0x56696577, '2004-02-16 15:23:09', ''),
('en', '_template', 'viewing_errors', 0x56696577696e67204572726f72287329, '2004-12-06 12:10:05', ''),
('en', '_template', 'viewing_profile_bugs', 0x56696577696e672050726f66696c652042756773, '2004-12-06 12:03:33', ''),
('en', '_template', 'view_all', 0x5669657720416c6c, '2005-08-04 09:54:04', ''),
('en', '_template', 'view_course_content', 0x5669657720436f7572736520436f6e74656e74, '2013-10-02 11:07:20', 'mobile'),
('en', '_template', 'view_details', 0x566965772044657461696c73, '2005-03-11 11:27:43', ''),
('en', '_template', 'view_entire_post', 0x5669657720456e7469726520506f7374, '2003-05-22 16:07:57', 'forum message view'),
('en', '_template', 'view_groups', 0x566965772047726f7570, '2009-05-27 12:01:11', ''),
('en', '_template', 'view_log', 0x56696577204163746976697479204c6f67, '2005-03-03 10:44:12', ''),
('en', '_template', 'view_mark_test', 0x566965772026204d61726b2054657374, '2003-05-22 16:08:11', 'test manager'),
('en', '_template', 'view_message', 0x56696577204d657373616765, '2005-03-14 11:48:21', ''),
('en', '_template', 'view_profile_bugs', 0x566965772050726f66696c652042756773, '2004-12-06 11:51:58', 'admin/error_logging.php'),
('en', '_template', 'view_readme', 0x5669657720526561646d65, '2009-07-21 15:31:29', ''),
('en', '_template', 'view_responses', 0x5669657720526573706f6e736573, '2004-08-25 11:53:13', ''),
('en', '_template', 'view_results', 0x5669657720526573756c7473, '2003-05-22 16:09:09', 'mytests, test manager'),
('en', '_template', 'view_selected_bugs', 0x566965772053656c65637465642042756773, '2004-12-06 12:06:26', ''),
('en', '_template', 'view_sub_topics', 0x5669657720737562746f70696373, '2005-03-16 13:35:47', 'content manager'),
('en', '_template', 'view_tracking', 0x5669657720547261636b696e67, '2003-05-22 16:09:31', 'tracker'),
('en', '_template', 'vimeo', 0x56696d656f, '2010-11-30 18:09:48', 'module name'),
('en', '_template', 'visitor_counts', 0x56697369746f7220636f756e7473, '2009-05-27 12:01:11', ''),
('en', '_template', 'visits', 0x566973697473, '2003-09-13 09:19:09', 'tracker summary read'),
('en', '_template', 'visual', 0x56697375616c, '2008-09-08 14:19:07', ''),
('en', '_template', 'visual_editor', 0x56697375616c20456469746f72, '2006-11-23 13:31:56', ''),
('en', '_template', 'vote_to_see_results', 0x566f746520746f2073656520726573756c74732e, '2004-06-21 16:55:42', ''),
('en', '_template', 'warning', 0x5761726e696e67, '2003-05-22 16:09:47', 'text for warning message'),
('en', '_template', 'weblink', 0x576562204c696e6b, '2009-10-22 16:18:13', 'content editor'),
('en', '_template', 'websites', 0x5765627369746573, '2009-05-27 12:01:11', ''),
('en', '_template', 'web_service_id', 0x5765622053657276696365204944, '2010-05-05 16:17:46', ''),
('en', '_template', 'web_site', 0x5765622053697465, '2003-05-22 16:10:20', 'registration, profile'),
('en', '_template', 'weight', 0x576569676874, '2003-05-22 16:10:31', 'test manager'),
('en', '_template', 'welcome_to_atutor', 0x57656c636f6d6520546f20415475746f72, '2003-05-31 15:30:38', 'announcement default heading for new course'),
('en', '_template', 'white', 0x5768697465, '2008-09-09 09:01:13', ''),
('en', '_template', 'window_auto_close', 0x546869732077696e646f772077696c6c20636c6f7365206175746f6d61746963616c6c792e, '2003-06-06 10:37:43', 'file upload progress window'),
('en', '_template', 'workspace', 0x576f726b7370616365, '2006-03-20 14:38:08', ''),
('en', '_template', 'world_network', 0x576f726c64204e6574776f726b, '2009-05-27 12:01:11', ''),
('en', '_template', 'wrong_answer', 0x57726f6e6720416e73776572, '2003-05-22 16:11:51', 'test manager question editor'),
('en', '_template', 'wrong_request_token', 0x4d69736d617463686564207265717565737420746f6b656e2066726f6d204f41757468207365727665722e, '2010-02-23 10:03:11', 'oauth client'),
('en', '_template', 'year', 0x59656172, '2004-06-24 15:45:35', ''),
('en', '_template', 'yellow', 0x59656c6c6f77, '2008-09-09 09:01:13', ''),
('en', '_template', 'yes', 0x596573, '2005-03-03 10:18:48', 'preferences, admin course manager'),
('en', '_template', 'yes_delete', 0x596573202f2044656c657465, '2003-05-22 16:14:23', 'global delete response option'),
('en', '_template', 'your_applications', 0x4d792047616467657473, '2009-05-27 12:01:11', ''),
('en', '_template', 'your_mark', 0x596f7572204d61726b, '2008-09-25 16:01:17', 'gradebook'),
('en', '_template', 'you_are_here', 0x596f75206172652068657265, '2003-10-02 16:46:28', 'ALT text Global/Local Navigation link to self'),
('en', '_template', 'zip_archive', 0x5a69702041726368697665, '2003-05-22 16:20:01', 'file manager'),
('en', '_template', 'zip_file_manager', 0x5a69702046696c65204d616e61676572, '2003-05-22 16:20:14', 'file manager'),
('en', '_template', 'zip_illegal_contents', 0x54686520636f6e74656e7473206f662074686973206172636869766520617265206c69737465642062656c6f772e20496c6c6567616c2066696c652074797065732077696c6c206e6f74206265206578747261637465642c20616e642066696c65206e616d657320636f6e7461696e696e6720696c6c6567616c20636861726163746572732077696c6c206265207472616e736c617465642e, '2004-08-10 15:10:04', '');

-- --------------------------------------------------------

--
-- Table structure for table `AT_links`
--

CREATE TABLE IF NOT EXISTS `AT_links` (
  `link_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `cAT_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Url` varchar(255) NOT NULL DEFAULT '',
  `LinkName` varchar(64) NOT NULL DEFAULT '',
  `Description` text,
  `Approved` tinyint(8) DEFAULT '0',
  `SubmitName` varchar(64) NOT NULL DEFAULT '',
  `SubmitEmail` varchar(64) NOT NULL DEFAULT '',
  `SubmitDate` date NOT NULL DEFAULT '0000-00-00',
  `hits` int(11) DEFAULT '0',
  PRIMARY KEY (`link_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_links_categories`
--

CREATE TABLE IF NOT EXISTS `AT_links_categories` (
  `cAT_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `owner_type` tinyint(4) NOT NULL DEFAULT '0',
  `owner_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `parent_id` mediumint(8) unsigned DEFAULT NULL,
  PRIMARY KEY (`cAT_id`),
  KEY `owner_id` (`owner_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_mail_queue`
--

CREATE TABLE IF NOT EXISTS `AT_mail_queue` (
  `mail_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `to_email` varchar(50) NOT NULL DEFAULT '',
  `to_name` varchar(50) NOT NULL DEFAULT '',
  `from_email` varchar(50) NOT NULL DEFAULT '',
  `from_name` varchar(50) NOT NULL DEFAULT '',
  `char_set` varchar(20) NOT NULL DEFAULT '',
  `subject` varchar(255) NOT NULL,
  `body` text,
  PRIMARY KEY (`mail_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_master_list`
--

CREATE TABLE IF NOT EXISTS `AT_master_list` (
  `public_field` char(30) NOT NULL DEFAULT '',
  `hash_field` char(40) NOT NULL DEFAULT '',
  `member_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`public_field`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `AT_members`
--

CREATE TABLE IF NOT EXISTS `AT_members` (
  `member_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `login` varchar(20) NOT NULL DEFAULT '',
  `password` varchar(40) NOT NULL DEFAULT '',
  `email` varchar(50) NOT NULL DEFAULT '',
  `website` varchar(200) NOT NULL DEFAULT '',
  `first_name` varchar(100) NOT NULL,
  `second_name` varchar(100) NOT NULL DEFAULT '',
  `last_name` varchar(100) NOT NULL,
  `dob` date NOT NULL DEFAULT '0000-00-00',
  `gender` enum('m','f','n') NOT NULL DEFAULT 'n',
  `address` text,
  `postal` varchar(15) NOT NULL DEFAULT '',
  `city` varchar(100) NOT NULL DEFAULT '',
  `province` varchar(100) NOT NULL DEFAULT '',
  `country` varchar(100) NOT NULL DEFAULT '',
  `phone` varchar(15) NOT NULL DEFAULT '',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `preferences` text,
  `creation_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `language` varchar(5) NOT NULL DEFAULT '',
  `inbox_notify` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `private_email` tinyint(4) NOT NULL DEFAULT '1',
  `last_login` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`member_id`),
  UNIQUE KEY `login` (`login`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_member_login_attempt`
--

CREATE TABLE IF NOT EXISTS `AT_member_login_attempt` (
  `login` varchar(20) NOT NULL,
  `attempt` tinyint(3) unsigned DEFAULT NULL,
  `expiry` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`login`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `AT_member_track`
--

CREATE TABLE IF NOT EXISTS `AT_member_track` (
  `member_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `course_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `content_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `counter` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `duration` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `last_accessed` timestamp NULL DEFAULT NULL,
  KEY `member_id` (`member_id`),
  KEY `content_id` (`content_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `AT_messages`
--

CREATE TABLE IF NOT EXISTS `AT_messages` (
  `message_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `course_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `from_member_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `to_member_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `date_sent` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `new` tinyint(4) NOT NULL DEFAULT '0',
  `replied` tinyint(4) NOT NULL DEFAULT '0',
  `subject` varchar(255) NOT NULL,
  `body` text,
  PRIMARY KEY (`message_id`),
  KEY `to_member_id` (`to_member_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_messages_sent`
--

CREATE TABLE IF NOT EXISTS `AT_messages_sent` (
  `message_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `course_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `from_member_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `to_member_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `date_sent` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `subject` varchar(255) NOT NULL,
  `body` text,
  PRIMARY KEY (`message_id`),
  KEY `from_member_id` (`from_member_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_modules`
--

CREATE TABLE IF NOT EXISTS `AT_modules` (
  `dir_name` varchar(50) NOT NULL DEFAULT '',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `privilege` bigint(20) unsigned NOT NULL DEFAULT '0',
  `admin_privilege` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `cron_interval` smallint(5) unsigned NOT NULL DEFAULT '0',
  `cron_last_run` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`dir_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `AT_modules`
--

INSERT INTO `AT_modules` (`dir_name`, `status`, `privilege`, `admin_privilege`, `cron_interval`, `cron_last_run`) VALUES
('_core/properties', 2, 1, 0, 0, 0),
('_standard/statistics', 2, 1, 0, 0, 0),
('_core/content', 2, 2, 0, 0, 0),
('_core/glossary', 2, 4, 0, 0, 0),
('_standard/tests', 2, 8, 0, 0, 0),
('_standard/chat', 2, 16, 0, 0, 0),
('_core/file_manager', 2, 32, 0, 0, 0),
('_standard/links', 2, 64, 0, 0, 0),
('_standard/forums', 2, 128, 16, 0, 0),
('_standard/course_tools', 2, 256, 0, 0, 0),
('_core/enrolment', 2, 512, 512, 0, 0),
('_standard/course_email', 2, 1024, 0, 0, 0),
('_standard/announcements', 2, 2048, 0, 0, 0),
('_standard/polls', 2, 16384, 0, 0, 0),
('_standard/faq', 2, 32768, 0, 0, 0),
('_core/groups', 2, 65536, 0, 0, 0),
('_standard/reading_list', 2, 131072, 0, 0, 0),
('_standard/file_storage', 2, 262144, 0, 0, 0),
('_standard/assignments', 2, 524288, 0, 0, 0),
('_standard/gradebook', 2, 1048576, 4096, 0, 0),
('_standard/student_tools', 2, 2097152, 0, 0, 0),
('_standard/farchive', 2, 4194304, 0, 0, 0),
('_standard/social', 2, 8388608, 0, 0, 0),
('_standard/photos', 2, 16777216, 0, 0, 0),
('_standard/flowplayer', 2, 33554432, 0, 0, 0),
('_standard/basiclti', 2, 67108864, 16384, 0, 0),
('_standard/assignment_dropbox', 2, 134217728, 0, 0, 0),
('_standard/calendar', 2, 268435456, 0, 0, 0),
('_core/users', 2, 0, 2, 0, 0),
('_core/courses', 2, 0, 4, 0, 0),
('_core/backups', 2, 1, 8, 0, 0),
('_core/cats_categories', 2, 0, 32, 0, 0),
('_core/languages', 2, 0, 64, 1440, 0),
('_core/themes', 2, 0, 128, 0, 0),
('_standard/rss_feeds', 2, 0, 256, 0, 0),
('_standard/directory', 2, 0, 0, 0, 0),
('_standard/tile_search', 2, 0, 0, 0, 0),
('_standard/sitemap', 2, 0, 0, 0, 0),
('_standard/tracker', 2, 0, 0, 0, 0),
('_core/content_packaging', 2, 0, 0, 0, 0),
('_standard/google_search', 2, 0, 0, 0, 0),
('_standard/blogs', 2, 0, 0, 0, 0),
('_standard/profile_pictures', 2, 0, 0, 0, 0),
('_standard/patcher', 2, 0, 1024, 0, 0),
('_standard/support_tools', 2, 0, 2048, 0, 0),
('_core/tool_manager', 2, 0, 0, 0, 0),
('_core/modules', 2, 0, 8192, 0, 0),
('_standard/vimeo', 2, 0, 1, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `AT_myown_patches`
--

CREATE TABLE IF NOT EXISTS `AT_myown_patches` (
  `myown_patch_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `atutor_patch_id` varchar(20) NOT NULL DEFAULT '',
  `applied_version` varchar(10) NOT NULL DEFAULT '',
  `description` text,
  `sql_statement` text,
  `status` varchar(20) NOT NULL DEFAULT '',
  `last_modified` datetime NOT NULL,
  PRIMARY KEY (`myown_patch_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_myown_patches_dependent`
--

CREATE TABLE IF NOT EXISTS `AT_myown_patches_dependent` (
  `myown_patches_dependent_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `myown_patch_id` mediumint(8) unsigned NOT NULL,
  `dependent_patch_id` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`myown_patches_dependent_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_myown_patches_files`
--

CREATE TABLE IF NOT EXISTS `AT_myown_patches_files` (
  `myown_patches_files_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `myown_patch_id` mediumint(8) unsigned NOT NULL,
  `action` varchar(20) NOT NULL DEFAULT '',
  `name` varchar(250) NOT NULL,
  `location` varchar(250) NOT NULL DEFAULT '',
  `code_from` text,
  `code_to` text,
  `uploaded_file` text,
  PRIMARY KEY (`myown_patches_files_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_news`
--

CREATE TABLE IF NOT EXISTS `AT_news` (
  `news_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `course_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `member_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `formatting` tinyint(4) NOT NULL DEFAULT '0',
  `title` varchar(200) NOT NULL,
  `body` text,
  PRIMARY KEY (`news_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_oauth_client_servers`
--

CREATE TABLE IF NOT EXISTS `AT_oauth_client_servers` (
  `oauth_server_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `oauth_server` varchar(255) NOT NULL DEFAULT '',
  `consumer_key` text,
  `consumer_secret` text,
  `expire_threshold` int(11) NOT NULL DEFAULT '0',
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`oauth_server_id`),
  UNIQUE KEY `idx_consumer` (`oauth_server`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_oauth_client_tokens`
--

CREATE TABLE IF NOT EXISTS `AT_oauth_client_tokens` (
  `oauth_server_id` mediumint(8) unsigned NOT NULL,
  `token` varchar(50) NOT NULL DEFAULT '',
  `token_type` varchar(50) NOT NULL DEFAULT '',
  `token_secret` text,
  `member_id` mediumint(8) unsigned NOT NULL,
  `assign_date` datetime NOT NULL,
  PRIMARY KEY (`oauth_server_id`,`token`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `AT_patches`
--

CREATE TABLE IF NOT EXISTS `AT_patches` (
  `patches_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `atutor_patch_id` varchar(20) NOT NULL DEFAULT '',
  `applied_version` varchar(10) NOT NULL DEFAULT '',
  `patch_folder` varchar(250) NOT NULL DEFAULT '',
  `description` text,
  `available_to` varchar(250) NOT NULL DEFAULT '',
  `sql_statement` text,
  `status` varchar(20) NOT NULL DEFAULT '',
  `remove_permission_files` text,
  `backup_files` text,
  `patch_files` text,
  `author` varchar(255) NOT NULL,
  `installed_date` datetime NOT NULL,
  PRIMARY KEY (`patches_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_patches_files`
--

CREATE TABLE IF NOT EXISTS `AT_patches_files` (
  `patches_files_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `patches_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `action` varchar(20) NOT NULL DEFAULT '',
  `name` text,
  `location` varchar(250) NOT NULL DEFAULT '',
  PRIMARY KEY (`patches_files_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_patches_files_actions`
--

CREATE TABLE IF NOT EXISTS `AT_patches_files_actions` (
  `patches_files_actions_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `patches_files_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `action` varchar(20) NOT NULL DEFAULT '',
  `code_from` text,
  `code_to` text,
  PRIMARY KEY (`patches_files_actions_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_pa_albums`
--

CREATE TABLE IF NOT EXISTS `AT_pa_albums` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `description` text,
  `permission` tinyint(1) unsigned NOT NULL,
  `member_id` int(10) unsigned NOT NULL,
  `photo_id` int(10) unsigned NOT NULL,
  `type_id` tinyint(1) unsigned NOT NULL,
  `created_date` datetime NOT NULL,
  `last_updated` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_pa_album_comments`
--

CREATE TABLE IF NOT EXISTS `AT_pa_album_comments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `album_id` int(10) unsigned NOT NULL,
  `member_id` int(10) unsigned NOT NULL,
  `comment` text,
  `created_date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_pa_course_album`
--

CREATE TABLE IF NOT EXISTS `AT_pa_course_album` (
  `course_id` int(10) unsigned NOT NULL DEFAULT '0',
  `album_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`course_id`,`album_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `AT_pa_groups`
--

CREATE TABLE IF NOT EXISTS `AT_pa_groups` (
  `group_id` int(10) unsigned NOT NULL,
  `album_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`group_id`,`album_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `AT_pa_photos`
--

CREATE TABLE IF NOT EXISTS `AT_pa_photos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text,
  `alt_text` text,
  `member_id` int(10) unsigned NOT NULL,
  `album_id` int(10) unsigned NOT NULL,
  `ordering` smallint(5) unsigned NOT NULL,
  `created_date` datetime NOT NULL,
  `last_updated` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_pa_photo_comments`
--

CREATE TABLE IF NOT EXISTS `AT_pa_photo_comments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `photo_id` int(10) unsigned NOT NULL,
  `member_id` int(10) unsigned NOT NULL,
  `comment` text,
  `created_date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_polls`
--

CREATE TABLE IF NOT EXISTS `AT_polls` (
  `poll_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `course_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `question` varchar(255) NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `total` smallint(5) unsigned NOT NULL DEFAULT '0',
  `choice1` varchar(255) NOT NULL,
  `count1` smallint(5) unsigned NOT NULL DEFAULT '0',
  `choice2` varchar(255) NOT NULL,
  `count2` smallint(5) unsigned NOT NULL DEFAULT '0',
  `choice3` varchar(255) NOT NULL,
  `count3` smallint(5) unsigned NOT NULL DEFAULT '0',
  `choice4` varchar(255) NOT NULL,
  `count4` smallint(5) unsigned NOT NULL DEFAULT '0',
  `choice5` varchar(255) NOT NULL,
  `count5` smallint(5) unsigned NOT NULL DEFAULT '0',
  `choice6` varchar(255) NOT NULL,
  `count6` smallint(5) unsigned NOT NULL DEFAULT '0',
  `choice7` varchar(255) NOT NULL,
  `count7` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`poll_id`),
  KEY `course_id` (`course_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_polls_members`
--

CREATE TABLE IF NOT EXISTS `AT_polls_members` (
  `poll_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `member_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`poll_id`,`member_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `AT_primary_resources`
--

CREATE TABLE IF NOT EXISTS `AT_primary_resources` (
  `primary_resource_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `content_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `resource` text,
  `language_code` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`primary_resource_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_primary_resources_types`
--

CREATE TABLE IF NOT EXISTS `AT_primary_resources_types` (
  `primary_resource_id` mediumint(8) unsigned NOT NULL,
  `type_id` mediumint(8) unsigned NOT NULL,
  PRIMARY KEY (`primary_resource_id`,`type_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `AT_reading_list`
--

CREATE TABLE IF NOT EXISTS `AT_reading_list` (
  `reading_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `course_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `resource_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `required` enum('required','optional') NOT NULL DEFAULT 'required',
  `date_start` date NOT NULL DEFAULT '0000-00-00',
  `date_end` date NOT NULL DEFAULT '0000-00-00',
  `comment` text,
  PRIMARY KEY (`reading_id`),
  KEY `course_id` (`course_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_related_content`
--

CREATE TABLE IF NOT EXISTS `AT_related_content` (
  `content_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `related_content_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`content_id`,`related_content_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `AT_resource_types`
--

CREATE TABLE IF NOT EXISTS `AT_resource_types` (
  `type_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `type` text,
  PRIMARY KEY (`type_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `AT_resource_types`
--

INSERT INTO `AT_resource_types` (`type_id`, `type`) VALUES
(1, 'auditory'),
(2, 'sign_language'),
(3, 'textual'),
(4, 'visual');

-- --------------------------------------------------------

--
-- Table structure for table `AT_secondary_resources`
--

CREATE TABLE IF NOT EXISTS `AT_secondary_resources` (
  `secondary_resource_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `primary_resource_id` mediumint(8) unsigned NOT NULL,
  `secondary_resource` text,
  `language_code` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`secondary_resource_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_secondary_resources_types`
--

CREATE TABLE IF NOT EXISTS `AT_secondary_resources_types` (
  `secondary_resource_id` mediumint(8) unsigned NOT NULL,
  `type_id` mediumint(8) unsigned NOT NULL,
  PRIMARY KEY (`secondary_resource_id`,`type_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `AT_social_activities`
--

CREATE TABLE IF NOT EXISTS `AT_social_activities` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `member_id` int(10) unsigned NOT NULL,
  `application_id` int(10) unsigned NOT NULL,
  `title` text,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_social_applications`
--

CREATE TABLE IF NOT EXISTS `AT_social_applications` (
  `id` int(10) unsigned DEFAULT NULL,
  `url` varchar(255) NOT NULL DEFAULT '',
  `title` varchar(255) NOT NULL,
  `height` int(10) unsigned DEFAULT NULL,
  `scrolling` int(10) unsigned DEFAULT NULL,
  `screenshot` varchar(255) NOT NULL,
  `thumbnail` varchar(255) NOT NULL,
  `author` varchar(255) NOT NULL,
  `author_email` varchar(128) NOT NULL,
  `description` text,
  `settings` text,
  `views` text,
  `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`url`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `AT_social_application_settings`
--

CREATE TABLE IF NOT EXISTS `AT_social_application_settings` (
  `application_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `member_id` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `value` text,
  PRIMARY KEY (`application_id`,`member_id`,`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_social_friends`
--

CREATE TABLE IF NOT EXISTS `AT_social_friends` (
  `member_id` int(10) unsigned NOT NULL,
  `friend_id` int(10) unsigned NOT NULL,
  `relationship` int(10) unsigned NOT NULL,
  PRIMARY KEY (`member_id`,`friend_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `AT_social_friend_requests`
--

CREATE TABLE IF NOT EXISTS `AT_social_friend_requests` (
  `member_id` int(10) unsigned NOT NULL,
  `friend_id` int(10) unsigned NOT NULL,
  `relationship` int(10) unsigned NOT NULL,
  PRIMARY KEY (`member_id`,`friend_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `AT_social_groups`
--

CREATE TABLE IF NOT EXISTS `AT_social_groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `member_id` int(10) unsigned NOT NULL,
  `type_id` int(10) unsigned NOT NULL,
  `privacy` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `logo` varchar(255) NOT NULL,
  `description` text,
  `created_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_updated` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_social_groups_activities`
--

CREATE TABLE IF NOT EXISTS `AT_social_groups_activities` (
  `activity_id` int(10) unsigned NOT NULL,
  `group_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`activity_id`,`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `AT_social_groups_board`
--

CREATE TABLE IF NOT EXISTS `AT_social_groups_board` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `member_id` int(10) unsigned NOT NULL,
  `group_id` int(10) unsigned NOT NULL,
  `body` text,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_social_groups_invitations`
--

CREATE TABLE IF NOT EXISTS `AT_social_groups_invitations` (
  `sender_id` int(10) unsigned NOT NULL,
  `member_id` int(10) unsigned NOT NULL,
  `group_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`sender_id`,`member_id`,`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `AT_social_groups_members`
--

CREATE TABLE IF NOT EXISTS `AT_social_groups_members` (
  `group_id` int(10) unsigned NOT NULL,
  `member_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`group_id`,`member_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `AT_social_groups_requests`
--

CREATE TABLE IF NOT EXISTS `AT_social_groups_requests` (
  `sender_id` int(10) unsigned NOT NULL,
  `member_id` int(10) unsigned NOT NULL,
  `group_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`sender_id`,`member_id`,`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `AT_social_groups_types`
--

CREATE TABLE IF NOT EXISTS `AT_social_groups_types` (
  `type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(127) NOT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `AT_social_groups_types`
--

INSERT INTO `AT_social_groups_types` (`type_id`, `title`) VALUES
(1, 'business'),
(2, 'common_interest'),
(3, 'entertainment_arts'),
(4, 'geography'),
(5, 'internet_technology'),
(6, 'organization'),
(7, 'music'),
(8, 'sports_recreation');

-- --------------------------------------------------------

--
-- Table structure for table `AT_social_members_applications`
--

CREATE TABLE IF NOT EXISTS `AT_social_members_applications` (
  `member_id` int(10) unsigned NOT NULL,
  `application_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`member_id`,`application_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `AT_social_member_additional_information`
--

CREATE TABLE IF NOT EXISTS `AT_social_member_additional_information` (
  `member_id` int(10) unsigned NOT NULL,
  `expertise` varchar(255) NOT NULL,
  `interests` text,
  `associations` text,
  `awards` text,
  `others` text,
  PRIMARY KEY (`member_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `AT_social_member_contact`
--

CREATE TABLE IF NOT EXISTS `AT_social_member_contact` (
  `contact_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `member_id` int(10) unsigned NOT NULL,
  `con_name` varchar(200) NOT NULL,
  `con_phone` varchar(15) NOT NULL,
  `con_email` varchar(50) NOT NULL,
  `con_address` text,
  PRIMARY KEY (`contact_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_social_member_education`
--

CREATE TABLE IF NOT EXISTS `AT_social_member_education` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `member_id` int(10) unsigned NOT NULL,
  `university` varchar(255) NOT NULL,
  `country` varchar(128) DEFAULT NULL,
  `province` varchar(128) DEFAULT NULL,
  `degree` varchar(64) DEFAULT NULL,
  `field` varchar(64) DEFAULT NULL,
  `from` varchar(10) NOT NULL DEFAULT '0',
  `to` varchar(10) NOT NULL DEFAULT '0',
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_social_member_personal`
--

CREATE TABLE IF NOT EXISTS `AT_social_member_personal` (
  `per_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `member_id` int(10) unsigned NOT NULL,
  `per_weight` varchar(200) NOT NULL,
  `per_height` varchar(50) NOT NULL,
  `per_hair` varchar(15) NOT NULL,
  `per_eyes` varchar(50) NOT NULL,
  `per_ethnicity` varchar(50) NOT NULL,
  `per_languages` varchar(255) NOT NULL,
  `per_disabilities` varchar(255) NOT NULL,
  PRIMARY KEY (`per_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_social_member_position`
--

CREATE TABLE IF NOT EXISTS `AT_social_member_position` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `member_id` int(10) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `company` varchar(255) NOT NULL,
  `from` varchar(10) NOT NULL DEFAULT '0',
  `to` varchar(10) NOT NULL DEFAULT '0',
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_social_member_representation`
--

CREATE TABLE IF NOT EXISTS `AT_social_member_representation` (
  `rep_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `member_id` int(10) unsigned NOT NULL,
  `rep_name` varchar(200) NOT NULL,
  `rep_title` varchar(50) NOT NULL,
  `rep_phone` varchar(15) NOT NULL,
  `rep_email` varchar(50) NOT NULL,
  `rep_address` text,
  PRIMARY KEY (`rep_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_social_member_track`
--

CREATE TABLE IF NOT EXISTS `AT_social_member_track` (
  `member_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `visitor_id` int(10) unsigned NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`member_id`,`visitor_id`,`timestamp`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_social_member_websites`
--

CREATE TABLE IF NOT EXISTS `AT_social_member_websites` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `member_id` int(10) unsigned NOT NULL,
  `url` varchar(255) NOT NULL,
  `site_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_social_privacy_preferences`
--

CREATE TABLE IF NOT EXISTS `AT_social_privacy_preferences` (
  `member_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `preferences` text,
  PRIMARY KEY (`member_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_social_user_settings`
--

CREATE TABLE IF NOT EXISTS `AT_social_user_settings` (
  `member_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `app_settings` text,
  PRIMARY KEY (`member_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_tests`
--

CREATE TABLE IF NOT EXISTS `AT_tests` (
  `test_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `course_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `title` varchar(255) NOT NULL,
  `format` tinyint(4) NOT NULL DEFAULT '0',
  `start_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `end_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `randomize_order` tinyint(4) NOT NULL DEFAULT '0',
  `num_questions` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `instructions` text,
  `content_id` mediumint(8) NOT NULL DEFAULT '0',
  `result_release` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `random` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `difficulty` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `num_takes` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `anonymous` tinyint(4) NOT NULL DEFAULT '0',
  `out_of` varchar(4) NOT NULL DEFAULT '',
  `guests` tinyint(4) NOT NULL DEFAULT '0',
  `display` tinyint(4) NOT NULL DEFAULT '0',
  `description` text,
  `passscore` mediumint(9) NOT NULL DEFAULT '0',
  `passpercent` mediumint(9) NOT NULL DEFAULT '0',
  `passfeedback` text,
  `failfeedback` text,
  `show_guest_form` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `remedial_content` tinyint(1) unsigned DEFAULT '0',
  `timed_test` tinyint(1) NOT NULL DEFAULT '0',
  `timed_test_duration` int(11) NOT NULL DEFAULT '0',
  `timed_test_normal_mode` int(11) NOT NULL DEFAULT '60',
  `timed_test_intermediate_mode` int(11) NOT NULL DEFAULT '30',
  `timed_test_emergency_mode` int(11) NOT NULL DEFAULT '10',
  PRIMARY KEY (`test_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_tests_answers`
--

CREATE TABLE IF NOT EXISTS `AT_tests_answers` (
  `result_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `question_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `member_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `answer` text,
  `score` varchar(5) NOT NULL DEFAULT '',
  `notes` text,
  PRIMARY KEY (`result_id`,`question_id`,`member_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `AT_tests_custom_duration`
--

CREATE TABLE IF NOT EXISTS `AT_tests_custom_duration` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `test_id` mediumint(8) unsigned NOT NULL,
  `type` enum('group','student') NOT NULL DEFAULT 'group',
  `type_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `custom_duration` int(11) NOT NULL DEFAULT '-1',
  PRIMARY KEY (`id`,`type`,`type_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_tests_groups`
--

CREATE TABLE IF NOT EXISTS `AT_tests_groups` (
  `test_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `group_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`test_id`,`group_id`),
  KEY `test_id` (`test_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `AT_tests_questions`
--

CREATE TABLE IF NOT EXISTS `AT_tests_questions` (
  `question_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `course_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `feedback` text,
  `question` text,
  `choice_0` text,
  `choice_1` text,
  `choice_2` text,
  `choice_3` text,
  `choice_4` text,
  `choice_5` text,
  `choice_6` text,
  `choice_7` text,
  `choice_8` text,
  `choice_9` text,
  `answer_0` tinyint(4) NOT NULL DEFAULT '0',
  `answer_1` tinyint(4) NOT NULL DEFAULT '0',
  `answer_2` tinyint(4) NOT NULL DEFAULT '0',
  `answer_3` tinyint(4) NOT NULL DEFAULT '0',
  `answer_4` tinyint(4) NOT NULL DEFAULT '0',
  `answer_5` tinyint(4) NOT NULL DEFAULT '0',
  `answer_6` tinyint(4) NOT NULL DEFAULT '0',
  `answer_7` tinyint(4) NOT NULL DEFAULT '0',
  `answer_8` tinyint(4) NOT NULL DEFAULT '0',
  `answer_9` tinyint(4) NOT NULL DEFAULT '0',
  `option_0` text,
  `option_1` text,
  `option_2` text,
  `option_3` text,
  `option_4` text,
  `option_5` text,
  `option_6` text,
  `option_7` text,
  `option_8` text,
  `option_9` text,
  `properties` tinyint(4) NOT NULL DEFAULT '0',
  `content_id` mediumint(8) NOT NULL,
  `remedial_content` text,
  PRIMARY KEY (`question_id`),
  KEY `category_id` (`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_tests_questions_assoc`
--

CREATE TABLE IF NOT EXISTS `AT_tests_questions_assoc` (
  `test_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `question_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `weight` varchar(4) NOT NULL DEFAULT '',
  `ordering` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `required` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`test_id`,`question_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `AT_tests_questions_categories`
--

CREATE TABLE IF NOT EXISTS `AT_tests_questions_categories` (
  `category_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `course_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `title` char(200) NOT NULL DEFAULT '',
  PRIMARY KEY (`category_id`),
  KEY `course_id` (`course_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_tests_results`
--

CREATE TABLE IF NOT EXISTS `AT_tests_results` (
  `result_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `test_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `member_id` varchar(10) NOT NULL DEFAULT '',
  `date_taken` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `final_score` char(5) NOT NULL DEFAULT '',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `end_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `max_pos` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `test_timer` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`result_id`),
  KEY `test_id` (`test_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `AT_themes`
--

CREATE TABLE IF NOT EXISTS `AT_themes` (
  `title` varchar(80) NOT NULL DEFAULT '',
  `version` varchar(10) NOT NULL DEFAULT '',
  `dir_name` varchar(20) NOT NULL DEFAULT '',
  `type` varchar(20) NOT NULL DEFAULT 'Desktop',
  `last_updated` date NOT NULL DEFAULT '0000-00-00',
  `extra_info` text,
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `customized` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`title`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `AT_themes`
--

INSERT INTO `AT_themes` (`title`, `version`, `dir_name`, `type`, `last_updated`, `extra_info`, `status`, `customized`) VALUES
('ATutor', '2.2', 'default', 'Desktop', '2014-10-03', 'This is the default ATutor theme and cannot be deleted as other themes inherit from it. Please do not alter this theme directly as it would complicate upgrading. Instead, create a new theme derived from this one.', 2, 0),
('ATutor 2.1', '2.2', 'default21', 'Desktop', '2014-10-03', 'This is the ATutor 2.1 series defailt theme.', 1, 0),
('Fluid', '2.2', 'fluid', 'Desktop', '2014-10-03', 'Theme that implements the Fluid reorderer used to drag-and-drop the menu from side-to-side.', 1, 0),
('ATutor Classic', '2.2', 'default_classic', 'Desktop', '2014-10-03', 'This is the ATutor Classic theme which makes use of the custom Header and logo images. To customize those images you must edit the <code>theme.cfg.php</code> in this themes directory.', 1, 0),
('Blumin', '2.2', 'blumin', 'Desktop', '2014-10-03', 'This is the plone look-alike theme.', 1, 0),
('Greenmin', '2.2', 'greenmin', 'Desktop', '2014-10-03', 'This is the plone look-alike theme in green.', 1, 0),
('ATutor 2.0', '2.2', 'default20', 'Desktop', '2014-10-03', 'This is the ATutor 2.0 series Default theme.', 1, 0),
('ATutor 1.5', '2.2', 'default15', 'Desktop', '2014-10-03', 'This is the 1.5 series default theme.', 1, 0),
('ATutor 1.6', '2.2', 'default16', 'Desktop', '2014-10-03', 'This is the 1.6 series default theme.', 1, 0),
('IDI Theme', '2.2', 'idi', 'Desktop', '2014-10-03', 'The theme created for the IDI course server.', 1, 0),
('Mobile', '2.2', 'mobile', 'Mobile', '2014-10-03', 'This is the default theme for mobile devices.', 3, 0),
('Simple', '2.2', 'simplified_desktop', 'Desktop', '2014-10-03', 'An adapted version of the iPad theme, designed to make a desktop look like an iPad.', 1, 0),
('ATutorSpaces', '2.2', 'atspaces', 'Desktop', '2014-10-03', 'This is the default theme for the ATutorSpaces.com hosting service.', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `AT_users_online`
--

CREATE TABLE IF NOT EXISTS `AT_users_online` (
  `member_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `course_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `login` varchar(255) NOT NULL DEFAULT '',
  `expiry` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`member_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 MAX_ROWS=500;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
