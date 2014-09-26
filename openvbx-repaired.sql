/*
** Corrected SQL to install OpenVBX on MySQL 5.5.xx.xx
**
** INET2800
*/



SET foreign_key_checks=0;


DROP TABLE IF EXISTS `annotations`;
CREATE TABLE `annotations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `annotation_type` tinyint(4) NOT NULL,
  `message_id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `description` text CHARACTER SET latin1 NOT NULL,
  `created` datetime NOT NULL,
  `tenant_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `annotation_type_message_id` (`annotation_type`,`message_id`,`created`),
  KEY `created` (`created`),
  KEY `tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;


DROP TABLE IF EXISTS `annotation_types`;
CREATE TABLE `annotation_types` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `description` varchar(32) NOT NULL,
  `tenant_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tenant_id` (`tenant_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;


DROP TABLE IF EXISTS `audio_files`;
CREATE TABLE `audio_files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(255) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `recording_call_sid` varchar(100) DEFAULT NULL,
  `tag` varchar(100) DEFAULT NULL,
  `cancelled` tinyint(4) DEFAULT '0',
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `tenant_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `url` (`url`),
  KEY `recording_call_sid` (`recording_call_sid`),
  KEY `tag` (`tag`),
  KEY `tenant_id` (`tenant_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=49 ;


DROP TABLE IF EXISTS `auth_types`;
CREATE TABLE `auth_types` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) NOT NULL,
  `tenant_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tenant_id` (`tenant_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;


DROP TABLE IF EXISTS `cache`;
CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL DEFAULT '',
  `group` varchar(255) NOT NULL DEFAULT '',
  `value` mediumblob NOT NULL,
  `tenant_id` int(11) NOT NULL,
  PRIMARY KEY (`key`(80),`group`(80),`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `flows`;
CREATE TABLE `flows` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `data` text,
  `sms_data` text,
  `tenant_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`tenant_id`),
  KEY `user_id` (`user_id`),
  KEY `tenant_id` (`tenant_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;


DROP TABLE IF EXISTS `flow_store`;
CREATE TABLE `flow_store` (
  `key` varchar(255) NOT NULL,
  `value` text,
  `flow_id` int(11) NOT NULL,
  `tenant_id` bigint(20) NOT NULL,
  UNIQUE KEY `key_flow` (`key`,`flow_id`),
  KEY `key` (`key`,`flow_id`),
  KEY `tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `groups`;
CREATE TABLE `groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT '1',
  `tenant_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tenant_id` (`tenant_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;


DROP TABLE IF EXISTS `groups_users`;
CREATE TABLE `groups_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `tenant_id` bigint(20) NOT NULL,
  `order` tinyint(3) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `group_id` (`group_id`),
  KEY `tenant_id` (`tenant_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=18 ;


DROP TABLE IF EXISTS `group_annotations`;
CREATE TABLE `group_annotations` (
  `group_id` int(11) NOT NULL,
  `annotation_id` bigint(20) NOT NULL,
  `tenant_id` bigint(20) NOT NULL,
  PRIMARY KEY (`group_id`,`annotation_id`),
  KEY `tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `group_messages`;
CREATE TABLE `group_messages` (
  `group_id` int(11) NOT NULL,
  `message_id` int(11) NOT NULL,
  `tenant_id` bigint(20) NOT NULL,
  PRIMARY KEY (`group_id`,`message_id`),
  KEY `tenant_id` (`tenant_id`),
  KEY `message_id` (`message_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `messages`;
CREATE TABLE `messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `read` datetime DEFAULT NULL,
  `call_sid` varchar(40) DEFAULT NULL,
  `caller` varchar(20) DEFAULT NULL,
  `called` varchar(20) DEFAULT NULL,
  `type` varchar(10) DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL,
  `content_url` varchar(255) DEFAULT NULL,
  `content_text` varchar(5000) DEFAULT NULL,
  `notes` varchar(5000) DEFAULT NULL,
  `size` smallint(6) DEFAULT NULL,
  `assigned_to` bigint(20) DEFAULT NULL,
  `archived` tinyint(4) NOT NULL DEFAULT '0',
  `ticket_status` enum('open','closed','pending') NOT NULL DEFAULT 'open',
  `tenant_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `call_sid` (`call_sid`),
  KEY `tenant_id` (`tenant_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;


DROP TABLE IF EXISTS `numbers`;
CREATE TABLE `numbers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `value` text NOT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `sms` tinyint(1) DEFAULT '0',
  `sequence` smallint(6) DEFAULT NULL,
  `tenant_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `tenant_id` (`tenant_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;


DROP TABLE IF EXISTS `plugin_store`;
CREATE TABLE `plugin_store` (
  `key` varchar(255) NOT NULL,
  `value` text,
  `plugin_id` varchar(34) NOT NULL,
  `tenant_id` bigint(20) NOT NULL,
  UNIQUE KEY `key_plugin` (`key`,`plugin_id`,`tenant_id`),
  KEY `key` (`key`,`plugin_id`),
  KEY `tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `rest_access`;
CREATE TABLE `rest_access` (
  `key` varchar(32) NOT NULL,
  `locked` tinyint(4) NOT NULL DEFAULT '0',
  `created` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `tenant_id` bigint(20) NOT NULL,
  PRIMARY KEY (`key`),
  KEY `tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `settings`;
CREATE TABLE `settings` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tenant_id` bigint(20) NOT NULL,
  `name` varchar(32) NOT NULL,
  `value` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `tenant_id` (`tenant_id`,`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=24 ;


DROP TABLE IF EXISTS `tenants`;
CREATE TABLE `tenants` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `url_prefix` varchar(255) NOT NULL,
  `local_prefix` varchar(1000) NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `type` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `url_prefix` (`url_prefix`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;


DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `is_admin` tinyint(1) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `password` varchar(128) DEFAULT NULL,
  `invite_code` varchar(32) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `pin` varchar(40) DEFAULT NULL,
  `notification` varchar(20) DEFAULT NULL,
  `auth_type` tinyint(4) NOT NULL DEFAULT '1',
  `voicemail` text NOT NULL,
  `tenant_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`,`tenant_id`),
  KEY `tenant_id` (`tenant_id`),
  KEY `auth_type` (`auth_type`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;


DROP TABLE IF EXISTS `user_annotations`;
CREATE TABLE `user_annotations` (
  `user_id` int(11) NOT NULL,
  `annotation_id` bigint(20) NOT NULL,
  `tenant_id` bigint(20) NOT NULL,
  PRIMARY KEY (`user_id`,`annotation_id`),
  KEY `tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `user_messages`;
CREATE TABLE `user_messages` (
  `user_id` int(11) NOT NULL,
  `message_id` int(11) NOT NULL,
  `tenant_id` bigint(20) NOT NULL,
  PRIMARY KEY (`user_id`,`message_id`),
  KEY `tenant_id` (`tenant_id`),
  KEY `message_id` (`message_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `user_settings`;
CREATE TABLE `user_settings` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `key` varchar(255) DEFAULT NULL,
  `value` text,
  `tenant_id` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `user_key` (`user_id`,`key`),
  KEY `key` (`key`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13 ;


ALTER TABLE `annotations`
  ADD CONSTRAINT `annotations_idx_fk_1` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`);

ALTER TABLE `annotation_types`
  ADD CONSTRAINT `annotation_types_idx_fk_1` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`);

ALTER TABLE `audio_files`
  ADD CONSTRAINT `audio_files_idx_fk_1` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`);

ALTER TABLE `auth_types`
  ADD CONSTRAINT `auth_types_idx_fk_1` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`);

ALTER TABLE `flows`
  ADD CONSTRAINT `flows_idx_fk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `flows_idx_fk_2` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`);

ALTER TABLE `flow_store`
  ADD CONSTRAINT `flow_store_idx_fk_1` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`);

ALTER TABLE `groups`
  ADD CONSTRAINT `groups_idx_fk_1` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`);

ALTER TABLE `groups_users`
  ADD CONSTRAINT `groups_users_idx_fk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `groups_users_idx_fk_2` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`),
  ADD CONSTRAINT `groups_users_idx_fk_3` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`);

ALTER TABLE `group_annotations`
  ADD CONSTRAINT `group_annotations_idx_fk_1` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`);

ALTER TABLE `group_messages`
  ADD CONSTRAINT `group_messages_idx_fk_1` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`),
  ADD CONSTRAINT `group_messages_idx_fk_2` FOREIGN KEY (`message_id`) REFERENCES `messages` (`id`),
  ADD CONSTRAINT `group_messages_idx_fk_3` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`);

ALTER TABLE `messages`
  ADD CONSTRAINT `messages_idx_fk_1` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`);

ALTER TABLE `numbers`
  ADD CONSTRAINT `numbers_idx_fk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `numbers_idx_fk_2` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`);

ALTER TABLE `plugin_store`
  ADD CONSTRAINT `plugin_store_idx_fk_1` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`);

ALTER TABLE `rest_access`
  ADD CONSTRAINT `rest_access_idx_fk_1` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`);

ALTER TABLE `settings`
  ADD CONSTRAINT `settings_idx_fk_1` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`);

ALTER TABLE `users`
  ADD CONSTRAINT `users_idx_fk_1` FOREIGN KEY (`auth_type`) REFERENCES `auth_types` (`id`),
  ADD CONSTRAINT `users_idx_fk_2` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`);

ALTER TABLE `user_annotations`
  ADD CONSTRAINT `user_annotations_idx_fk_1` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`);

ALTER TABLE `user_messages`
  ADD CONSTRAINT `user_messages_idx_fku_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `user_messages_idx_fku_2` FOREIGN KEY (`message_id`) REFERENCES `messages` (`id`),
  ADD CONSTRAINT `user_messages_idx_fku_3` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`);


/*
** Load base OpenVBX data
*/

INSERT INTO tenants
	   (name, url_prefix, local_prefix)
	   VALUES
	   ('default', '', '');

INSERT INTO annotation_types (description, tenant_id)
	   VALUES
	   ('called', 1),
	   ('read', 1),
	   ('noted', 1),
	   ('changed', 1),
	   ('labeled', 1),
	   ('sms', 1);

INSERT INTO auth_types (description, tenant_id)
	   VALUES
	   ('openvbx', 1),
	   ('google', 1);

INSERT INTO settings
	   (name, value, tenant_id)
	   VALUES
	   ('dash_rss', '', 1),
	   ('theme', '', 1),
	   ('iphone_theme', '', 1),
	   ('enable_sandbox_number', 0, 0),
	   ('twilio_endpoint', 'https://api.twilio.com/2010-04-01', 1),
	   ('recording_host','',1),
	   ('transcriptions', '1', 1),
	   ('voice', 'man', 1),
	   ('voice_language', 'en', 1),
	   ('numbers_country', 'US', 1),
	   ('gravatars', 0, 1),
	   ('connect_application_sid', 0, 1),
	   ('dial_timeout', 15, 1),
	   ('email_notifications_voice', 1, 1),
	   ('email_notifications_sms', 1, 1);

INSERT INTO groups
       (name, is_active, tenant_id)
       VALUES
       ('Sales', 1, 1),
       ('Support', 1, 1);

SET foreign_key_checks = 1;