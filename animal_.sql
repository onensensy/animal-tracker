ALTER TABLE `alarm_notification` DROP FOREIGN KEY `alarm_notification_alarm_fk`;
ALTER TABLE `alarm_vehicle` DROP FOREIGN KEY `alarm_vehicle_alarm_fk`;
ALTER TABLE `position` DROP FOREIGN KEY `position_city_fk`;
ALTER TABLE `refuel` DROP FOREIGN KEY `refuel_city_fk`;
ALTER TABLE `city` DROP FOREIGN KEY `city_country_fk`;
ALTER TABLE `state` DROP FOREIGN KEY `state_country_fk`;
ALTER TABLE `device_alarm` DROP FOREIGN KEY `device_alarm_device_fk`;
ALTER TABLE `device_alarm_notification` DROP FOREIGN KEY `device_alarm_notification_device_fk`;
ALTER TABLE `device_message` DROP FOREIGN KEY `device_message_device_fk`;
ALTER TABLE `position` DROP FOREIGN KEY `position_device_fk`;
ALTER TABLE `trip` DROP FOREIGN KEY `trip_device_fk`;
ALTER TABLE `device_alarm_notification` DROP FOREIGN KEY `device_alarm_notification_device_alarm_fk`;
ALTER TABLE `user` DROP FOREIGN KEY `user_language_fk`;
ALTER TABLE `maintenance_maintenance_item` DROP FOREIGN KEY `maintenance_maintenance_item_maintenance_fk`;
ALTER TABLE `maintenance_maintenance_item` DROP FOREIGN KEY `maintenance_maintenance_item_maintenance_item_fk`;
ALTER TABLE `alarm_notification` DROP FOREIGN KEY `alarm_notification_position_fk`;
ALTER TABLE `device_alarm_notification` DROP FOREIGN KEY `device_alarm_notification_position_fk`;
ALTER TABLE `refuel` DROP FOREIGN KEY `refuel_position_fk`;
ALTER TABLE `city` DROP FOREIGN KEY `city_state_fk`;
ALTER TABLE `animal` DROP FOREIGN KEY `vehicle_timezone_fk`;
ALTER TABLE `position` DROP FOREIGN KEY `position_timezone_fk`;
ALTER TABLE `trip` DROP FOREIGN KEY `trip_timezone_fk`;
ALTER TABLE `user` DROP FOREIGN KEY `user_timezone_fk`;
ALTER TABLE `alarm_notification` DROP FOREIGN KEY `alarm_notification_trip_fk`;
ALTER TABLE `device_alarm_notification` DROP FOREIGN KEY `device_alarm_notification_trip_fk`;
ALTER TABLE `position` DROP FOREIGN KEY `position_trip_fk`;
ALTER TABLE `alarm` DROP FOREIGN KEY `alarm_user_fk`;
ALTER TABLE `animal` DROP FOREIGN KEY `vehicle_user_fk`;
ALTER TABLE `device` DROP FOREIGN KEY `device_user_fk`;
ALTER TABLE `file` DROP FOREIGN KEY `file_user_fk`;
ALTER TABLE `maintenance` DROP FOREIGN KEY `maintenance_user_fk`;
ALTER TABLE `maintenance_item` DROP FOREIGN KEY `maintenance_item_user_fk`;
ALTER TABLE `position` DROP FOREIGN KEY `position_user_fk`;
ALTER TABLE `refuel` DROP FOREIGN KEY `refuel_user_fk`;
ALTER TABLE `trip` DROP FOREIGN KEY `trip_user_fk`;
ALTER TABLE `user_fail` DROP FOREIGN KEY `user_fail_user_fk`;
ALTER TABLE `user_session` DROP FOREIGN KEY `user_session_user_fk`;
DROP TABLE `alarm`;
DROP TABLE `alarm_notification`;
DROP TABLE `alarm_vehicle`;
DROP TABLE `animal`;
DROP TABLE `city`;
DROP TABLE `configuration`;
DROP TABLE `country`;
DROP TABLE `device`;
DROP TABLE `device_alarm`;
DROP TABLE `device_alarm_notification`;
DROP TABLE `device_message`;
DROP TABLE `file`;
DROP TABLE `ip_lock`;
DROP TABLE `language`;
DROP TABLE `maintenance`;
DROP TABLE `maintenance_item`;
DROP TABLE `maintenance_maintenance_item`;
DROP TABLE `migrations`;
DROP TABLE `position`;
DROP TABLE `queue_fail`;
DROP TABLE `refuel`;
DROP TABLE `server`;
DROP TABLE `state`;
DROP TABLE `timezone`;
DROP TABLE `trip`;
DROP TABLE `user`;
DROP TABLE `user_fail`;
DROP TABLE `user_session`;
CREATE TABLE `alarm` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `type` VARCHAR(255) NOT NULL,
  `schedule_start` VARCHAR(255) NULL,
  `schedule_end` VARCHAR(255) NULL,
  `config` JSON NULL,
  `telegram` TINYINT NOT NULL DEFAULT 0 ,
  `enabled` TINYINT NOT NULL DEFAULT 0 ,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `user_id` BIGINT UNSIGNED NOT NULL,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`id`)
);
CREATE TABLE `alarm_notification` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `type` VARCHAR(255) NOT NULL,
  `config` JSON NULL,
  `point` POINT NOT NULL,
  `telegram` TINYINT NOT NULL DEFAULT 0 ,
  `date_at` DATETIME NOT NULL,
  `date_utc_at` DATETIME NOT NULL,
  `closed_at` DATETIME NULL,
  `sent_at` DATETIME NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `alarm_id` BIGINT UNSIGNED NULL,
  `position_id` BIGINT UNSIGNED NULL,
  `trip_id` BIGINT UNSIGNED NULL,
  `vehicle_id` BIGINT UNSIGNED NOT NULL,
  `latitude` DOUBLE NULL,
  `longitude` DOUBLE NULL,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`id`)
);
CREATE TABLE `alarm_vehicle` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `alarm_id` BIGINT UNSIGNED NOT NULL,
  `vehicle_id` BIGINT UNSIGNED NOT NULL,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`id`)
);
CREATE TABLE `animal` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `plate` VARCHAR(255) NOT NULL,
  `timezone_auto` TINYINT NOT NULL DEFAULT 0 ,
  `enabled` TINYINT NOT NULL DEFAULT 0 ,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `timezone_id` BIGINT UNSIGNED NOT NULL,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `species` VARCHAR(50) NULL,
  `age` INT NULL,
  `gender` ENUM NULL,
  `habitat` VARCHAR(100) NULL,
  `weight` DECIMAL(8,2) NULL,
  `date_added` DATE NULL,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`id`)
);
CREATE TABLE `city` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `alias` JSON NULL,
  `point` POINT NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `country_id` BIGINT UNSIGNED NOT NULL,
  `state_id` BIGINT UNSIGNED NOT NULL,
  `latitude` DOUBLE NULL,
  `longitude` DOUBLE NULL,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`id`)
);
CREATE TABLE `configuration` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `key` VARCHAR(255) NOT NULL,
  `value` VARCHAR(255) NOT NULL DEFAULT '' ,
  `description` VARCHAR(255) NOT NULL DEFAULT '' ,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`id`),
  CONSTRAINT `configuration_key_unique` UNIQUE (`key`)
);
CREATE TABLE `country` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `code` VARCHAR(255) NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `alias` JSON NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`id`),
  CONSTRAINT `country_code_unique` UNIQUE (`code`)
);
CREATE TABLE `device` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `code` VARCHAR(255) NULL,
  `name` VARCHAR(255) NOT NULL,
  `model` VARCHAR(255) NOT NULL,
  `serial` VARCHAR(255) NOT NULL,
  `phone_number` VARCHAR(255) NULL,
  `password` VARCHAR(255) NOT NULL DEFAULT '' ,
  `enabled` TINYINT NOT NULL DEFAULT 0 ,
  `shared` TINYINT NOT NULL DEFAULT 0 ,
  `shared_public` TINYINT NOT NULL DEFAULT 0 ,
  `connected_at` DATETIME NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `vehicle_id` BIGINT UNSIGNED NULL,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`id`),
  CONSTRAINT `device_serial_unique` UNIQUE (`serial`)
);
CREATE TABLE `device_alarm` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `type` VARCHAR(255) NOT NULL,
  `config` JSON NULL,
  `enabled` TINYINT NOT NULL DEFAULT 0 ,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `device_id` BIGINT UNSIGNED NOT NULL,
  `telegram` TINYINT NOT NULL DEFAULT 0 ,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`id`)
);
CREATE TABLE `device_alarm_notification` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `type` VARCHAR(255) NOT NULL,
  `config` JSON NULL,
  `closed_at` DATETIME NULL,
  `sent_at` DATETIME NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `device_id` BIGINT UNSIGNED NOT NULL,
  `device_alarm_id` BIGINT UNSIGNED NULL,
  `position_id` BIGINT UNSIGNED NULL,
  `trip_id` BIGINT UNSIGNED NULL,
  `telegram` TINYINT NOT NULL DEFAULT 0 ,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`id`)
);
CREATE TABLE `device_message` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `message` VARCHAR(255) NOT NULL,
  `response` TEXT NULL,
  `sent_at` DATETIME NULL,
  `response_at` DATETIME NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `device_id` BIGINT UNSIGNED NOT NULL,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`id`)
);
CREATE TABLE `file` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `path` VARCHAR(255) NOT NULL,
  `size` BIGINT UNSIGNED NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `related_table` VARCHAR(255) NOT NULL,
  `related_id` BIGINT UNSIGNED NOT NULL,
  `user_id` BIGINT UNSIGNED NOT NULL,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`id`)
);
CREATE TABLE `ip_lock` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `ip` VARCHAR(255) NOT NULL DEFAULT '' ,
  `end_at` DATETIME NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`id`)
);
CREATE TABLE `language` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `code` VARCHAR(255) NOT NULL,
  `locale` VARCHAR(255) NOT NULL,
  `enabled` TINYINT NOT NULL DEFAULT 0 ,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`id`),
  CONSTRAINT `language_locale_unique` UNIQUE (`locale`),
  CONSTRAINT `language_code_unique` UNIQUE (`code`)
);
CREATE TABLE `maintenance` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `workshop` VARCHAR(255) NOT NULL DEFAULT '' ,
  `description` TEXT NOT NULL,
  `date_at` DATE NOT NULL,
  `amount` DECIMAL(10,2) UNSIGNED NOT NULL DEFAULT 0.00 ,
  `distance` DECIMAL(10,2) UNSIGNED NOT NULL DEFAULT 0.00 ,
  `distance_next` DECIMAL(10,2) UNSIGNED NOT NULL DEFAULT 0.00 ,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `vehicle_id` BIGINT UNSIGNED NOT NULL,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`id`)
);
CREATE TABLE `maintenance_item` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `user_id` BIGINT UNSIGNED NOT NULL,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`id`),
  CONSTRAINT `maintenance_item_name_user_id_unique` UNIQUE (`name`, `user_id`)
);
CREATE TABLE `maintenance_maintenance_item` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `quantity` DECIMAL(10,2) UNSIGNED NOT NULL DEFAULT 0.00 ,
  `amount_gross` DECIMAL(10,2) UNSIGNED NOT NULL DEFAULT 0.00 ,
  `amount_net` DECIMAL(10,2) UNSIGNED NOT NULL DEFAULT 0.00 ,
  `tax_percent` DECIMAL(10,2) UNSIGNED NOT NULL DEFAULT 0.00 ,
  `tax_amount` DECIMAL(10,2) UNSIGNED NOT NULL DEFAULT 0.00 ,
  `subtotal` DECIMAL(10,2) UNSIGNED NOT NULL DEFAULT 0.00 ,
  `total` DECIMAL(10,2) UNSIGNED NOT NULL DEFAULT 0.00 ,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `maintenance_id` BIGINT UNSIGNED NOT NULL,
  `maintenance_item_id` BIGINT UNSIGNED NOT NULL,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`id`),
  CONSTRAINT `maintenance_maintenance_i_maintenance_maintenance_item_unique` UNIQUE (`maintenance_id`, `maintenance_item_id`)
);
CREATE TABLE `migrations` (
  `id` INT UNSIGNED AUTO_INCREMENT NOT NULL,
  `migration` VARCHAR(255) NOT NULL,
  `batch` INT NOT NULL,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`id`)
);
CREATE TABLE `position` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `point` POINT NOT NULL,
  `speed` DECIMAL(6,2) UNSIGNED NOT NULL,
  `direction` INT UNSIGNED NOT NULL,
  `signal` INT UNSIGNED NOT NULL,
  `date_at` DATETIME NOT NULL,
  `date_utc_at` DATETIME NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `city_id` BIGINT UNSIGNED NULL,
  `device_id` BIGINT UNSIGNED NULL,
  `timezone_id` BIGINT UNSIGNED NOT NULL,
  `trip_id` BIGINT UNSIGNED NOT NULL,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `vehicle_id` BIGINT UNSIGNED NOT NULL,
  `latitude` DOUBLE NULL,
  `longitude` DOUBLE NULL,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`id`)
);
CREATE TABLE `queue_fail` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `connection` TEXT NOT NULL,
  `queue` TEXT NOT NULL,
  `payload` LONGTEXT NOT NULL,
  `exception` LONGTEXT NOT NULL,
  `failed_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`id`)
);
CREATE TABLE `refuel` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `distance_total` DECIMAL(10,2) UNSIGNED NOT NULL,
  `distance` DECIMAL(6,2) UNSIGNED NOT NULL,
  `quantity` DECIMAL(6,2) UNSIGNED NOT NULL,
  `quantity_before` DECIMAL(6,2) UNSIGNED NOT NULL,
  `price` DECIMAL(7,3) UNSIGNED NOT NULL,
  `total` DECIMAL(6,2) UNSIGNED NOT NULL,
  `point` POINT NOT NULL,
  `date_at` DATETIME NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `city_id` BIGINT UNSIGNED NULL,
  `position_id` BIGINT UNSIGNED NULL,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `vehicle_id` BIGINT UNSIGNED NOT NULL,
  `latitude` DOUBLE NULL,
  `longitude` DOUBLE NULL,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`id`)
);
CREATE TABLE `server` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `port` INT UNSIGNED NOT NULL DEFAULT 0 ,
  `protocol` VARCHAR(255) NOT NULL,
  `debug` TINYINT NOT NULL DEFAULT 0 ,
  `enabled` TINYINT NOT NULL DEFAULT 0 ,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`id`)
);
CREATE TABLE `state` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `alias` JSON NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `country_id` BIGINT UNSIGNED NOT NULL,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`id`)
);
CREATE TABLE `timezone` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `zone` VARCHAR(255) NOT NULL,
  `geojson` MULTIPOLYGON NOT NULL,
  `default` TINYINT NOT NULL DEFAULT 0 ,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`id`)
);
CREATE TABLE `trip` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `code` VARCHAR(255) NULL,
  `name` VARCHAR(255) NOT NULL,
  `distance` INT UNSIGNED NOT NULL DEFAULT 0 ,
  `time` INT UNSIGNED NOT NULL DEFAULT 0 ,
  `stats` JSON NULL,
  `start_at` DATETIME NOT NULL,
  `start_utc_at` DATETIME NOT NULL,
  `end_at` DATETIME NOT NULL,
  `end_utc_at` DATETIME NOT NULL,
  `shared` TINYINT NOT NULL DEFAULT 0 ,
  `shared_public` TINYINT NOT NULL DEFAULT 0 ,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `device_id` BIGINT UNSIGNED NULL,
  `timezone_id` BIGINT UNSIGNED NOT NULL,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `vehicle_id` BIGINT UNSIGNED NOT NULL,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`id`)
);
CREATE TABLE `user` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `name` VARCHAR(255) NOT NULL DEFAULT '' ,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `remember_token` VARCHAR(255) NULL,
  `preferences` JSON NULL,
  `telegram` JSON NULL,
  `enabled` TINYINT NOT NULL DEFAULT 0 ,
  `admin` TINYINT NOT NULL DEFAULT 0 ,
  `admin_mode` TINYINT NOT NULL DEFAULT 0 ,
  `manager` TINYINT NOT NULL DEFAULT 0 ,
  `manager_mode` TINYINT NOT NULL DEFAULT 0 ,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `language_id` BIGINT UNSIGNED NOT NULL,
  `timezone_id` BIGINT UNSIGNED NOT NULL,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`id`),
  CONSTRAINT `user_email_unique` UNIQUE (`email`)
);
CREATE TABLE `user_fail` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `type` VARCHAR(255) NOT NULL,
  `text` VARCHAR(255) NULL,
  `ip` VARCHAR(255) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `user_id` BIGINT UNSIGNED NULL,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`id`)
);
CREATE TABLE `user_session` (
  `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
  `auth` VARCHAR(255) NOT NULL,
  `ip` VARCHAR(255) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `user_id` BIGINT UNSIGNED NOT NULL,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`id`)
);
CREATE INDEX `alarm_user_fk`
ON `alarm` (
  `user_id` ASC
);
CREATE INDEX `alarm_notification_vehicle_fk`
ON `alarm_notification` (
  `vehicle_id` ASC
);
CREATE INDEX `alarm_notification_trip_fk`
ON `alarm_notification` (
  `trip_id` ASC
);
CREATE INDEX `alarm_notification_position_fk`
ON `alarm_notification` (
  `position_id` ASC
);
CREATE INDEX `alarm_notification_point_spatialindex`
ON `alarm_notification` (
  `point` ASC
);
CREATE INDEX `alarm_notification_longitude_index`
ON `alarm_notification` (
  `longitude` ASC
);
CREATE INDEX `alarm_notification_latitude_index`
ON `alarm_notification` (
  `latitude` ASC
);
CREATE INDEX `alarm_notification_alarm_fk`
ON `alarm_notification` (
  `alarm_id` ASC
);
CREATE INDEX `alarm_vehicle_vehicle_fk`
ON `alarm_vehicle` (
  `vehicle_id` ASC
);
CREATE INDEX `alarm_vehicle_alarm_fk`
ON `alarm_vehicle` (
  `alarm_id` ASC
);
CREATE INDEX `vehicle_name_index`
ON `animal` (
  `name` ASC
);
CREATE INDEX `vehicle_timezone_fk`
ON `animal` (
  `timezone_id` ASC
);
CREATE INDEX `vehicle_user_fk`
ON `animal` (
  `user_id` ASC
);
CREATE INDEX `city_latitude_index`
ON `city` (
  `latitude` ASC
);
CREATE INDEX `city_state_fk`
ON `city` (
  `state_id` ASC
);
CREATE INDEX `city_point_spatialindex`
ON `city` (
  `point` ASC
);
CREATE INDEX `city_name_index`
ON `city` (
  `name` ASC
);
CREATE INDEX `city_longitude_index`
ON `city` (
  `longitude` ASC
);
CREATE INDEX `city_country_fk`
ON `city` (
  `country_id` ASC
);
CREATE INDEX `country_name_index`
ON `country` (
  `name` ASC
);
CREATE INDEX `device_name_index`
ON `device` (
  `name` ASC
);
CREATE INDEX `device_model_index`
ON `device` (
  `model` ASC
);
CREATE INDEX `device_code_index`
ON `device` (
  `code` ASC
);
CREATE INDEX `device_vehicle_fk`
ON `device` (
  `vehicle_id` ASC
);
CREATE INDEX `device_user_fk`
ON `device` (
  `user_id` ASC
);
CREATE INDEX `device_alarm_device_fk`
ON `device_alarm` (
  `device_id` ASC
);
CREATE INDEX `device_alarm_notification_trip_fk`
ON `device_alarm_notification` (
  `trip_id` ASC
);
CREATE INDEX `device_alarm_notification_position_fk`
ON `device_alarm_notification` (
  `position_id` ASC
);
CREATE INDEX `device_alarm_notification_device_fk`
ON `device_alarm_notification` (
  `device_id` ASC
);
CREATE INDEX `device_alarm_notification_device_alarm_fk`
ON `device_alarm_notification` (
  `device_alarm_id` ASC
);
CREATE INDEX `device_message_device_fk`
ON `device_message` (
  `device_id` ASC
);
CREATE INDEX `file_user_fk`
ON `file` (
  `user_id` ASC
);
CREATE INDEX `file_related_table_related_id_index`
ON `file` (
  `related_table` ASC,
  `related_id` ASC
);
CREATE INDEX `file_name_index`
ON `file` (
  `name` ASC
);
CREATE INDEX `ip_lock_ip_index`
ON `ip_lock` (
  `ip` ASC
);
CREATE INDEX `maintenance_vehicle_fk`
ON `maintenance` (
  `vehicle_id` ASC
);
CREATE INDEX `maintenance_user_fk`
ON `maintenance` (
  `user_id` ASC
);
CREATE INDEX `maintenance_name_index`
ON `maintenance` (
  `name` ASC
);
CREATE INDEX `maintenance_item_user_fk`
ON `maintenance_item` (
  `user_id` ASC
);
CREATE INDEX `maintenance_item_name_index`
ON `maintenance_item` (
  `name` ASC
);
CREATE INDEX `maintenance_maintenance_item_maintenance_item_fk`
ON `maintenance_maintenance_item` (
  `maintenance_item_id` ASC
);
CREATE INDEX `position_timezone_fk`
ON `position` (
  `timezone_id` ASC
);
CREATE INDEX `position_vehicle_fk`
ON `position` (
  `vehicle_id` ASC
);
CREATE INDEX `position_user_id_date_utc_at_index`
ON `position` (
  `user_id` ASC,
  `date_utc_at` ASC
);
CREATE INDEX `position_trip_id_date_utc_at_index`
ON `position` (
  `trip_id` ASC,
  `date_utc_at` ASC
);
CREATE INDEX `position_point_spatialindex`
ON `position` (
  `point` ASC
);
CREATE INDEX `position_longitude_index`
ON `position` (
  `longitude` ASC
);
CREATE INDEX `position_latitude_index`
ON `position` (
  `latitude` ASC
);
CREATE INDEX `position_device_id_date_utc_at_index`
ON `position` (
  `device_id` ASC,
  `date_utc_at` ASC
);
CREATE INDEX `position_city_fk`
ON `position` (
  `city_id` ASC
);
CREATE INDEX `refuel_vehicle_fk`
ON `refuel` (
  `vehicle_id` ASC
);
CREATE INDEX `refuel_user_fk`
ON `refuel` (
  `user_id` ASC
);
CREATE INDEX `refuel_position_fk`
ON `refuel` (
  `position_id` ASC
);
CREATE INDEX `refuel_point_spatialindex`
ON `refuel` (
  `point` ASC
);
CREATE INDEX `refuel_city_fk`
ON `refuel` (
  `city_id` ASC
);
CREATE INDEX `state_name_index`
ON `state` (
  `name` ASC
);
CREATE INDEX `state_country_fk`
ON `state` (
  `country_id` ASC
);
CREATE INDEX `timezone_geojson_spatialindex`
ON `timezone` (
  `geojson` ASC
);
CREATE INDEX `timezone_zone_index`
ON `timezone` (
  `zone` ASC
);
CREATE INDEX `trip_vehicle_fk`
ON `trip` (
  `vehicle_id` ASC
);
CREATE INDEX `trip_user_fk`
ON `trip` (
  `user_id` ASC
);
CREATE INDEX `trip_timezone_fk`
ON `trip` (
  `timezone_id` ASC
);
CREATE INDEX `trip_shared_public_shared_device_id_end_utc_at_index`
ON `trip` (
  `shared_public` ASC,
  `shared` ASC,
  `device_id` ASC,
  `end_utc_at` ASC
);
CREATE INDEX `trip_name_index`
ON `trip` (
  `name` ASC
);
CREATE INDEX `trip_device_fk`
ON `trip` (
  `device_id` ASC
);
CREATE INDEX `trip_code_index`
ON `trip` (
  `code` ASC
);
CREATE INDEX `user_language_fk`
ON `user` (
  `language_id` ASC
);
CREATE INDEX `user_timezone_fk`
ON `user` (
  `timezone_id` ASC
);
CREATE INDEX `user_fail_user_fk`
ON `user_fail` (
  `user_id` ASC
);
CREATE INDEX `user_fail_type_index`
ON `user_fail` (
  `type` ASC
);
CREATE INDEX `user_fail_ip_index`
ON `user_fail` (
  `ip` ASC
);
CREATE INDEX `user_session_user_fk`
ON `user_session` (
  `user_id` ASC
);
CREATE INDEX `user_session_ip_index`
ON `user_session` (
  `ip` ASC
);
CREATE INDEX `user_session_auth_index`
ON `user_session` (
  `auth` ASC
);
SET FOREIGN_KEY_CHECKS = 0;
INSERT INTO `animal` (`id`, `name`, `plate`, `timezone_auto`, `enabled`, `created_at`, `updated_at`, `timezone_id`, `user_id`, `species`, `age`, `gender`, `habitat`, `weight`, `date_added`) VALUES ('1', 'Cow 293', '299', 1, 1, '2024-02-26 14:03:41', '2024-02-26 14:03:41', '43', '1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `animal` (`id`, `name`, `plate`, `timezone_auto`, `enabled`, `created_at`, `updated_at`, `timezone_id`, `user_id`, `species`, `age`, `gender`, `habitat`, `weight`, `date_added`) VALUES ('2', 'Channing Warner', 'Aut sed consequatur', 0, 0, '2024-03-24 19:38:12', '2024-03-24 19:38:12', '421', '1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `animal` (`id`, `name`, `plate`, `timezone_auto`, `enabled`, `created_at`, `updated_at`, `timezone_id`, `user_id`, `species`, `age`, `gender`, `habitat`, `weight`, `date_added`) VALUES ('4', 'Ciara Carter', 'Dolor saepe earum qu', 0, 1, '2024-04-06 14:01:03', '2024-04-06 14:01:03', '428', '2', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `animal` (`id`, `name`, `plate`, `timezone_auto`, `enabled`, `created_at`, `updated_at`, `timezone_id`, `user_id`, `species`, `age`, `gender`, `habitat`, `weight`, `date_added`) VALUES ('5', 'Chantale Knox', 'Obcaecati libero lab', 0, 1, '2024-04-06 14:04:42', '2024-04-06 14:04:42', '140', '2', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `animal` (`id`, `name`, `plate`, `timezone_auto`, `enabled`, `created_at`, `updated_at`, `timezone_id`, `user_id`, `species`, `age`, `gender`, `habitat`, `weight`, `date_added`) VALUES ('6', 'Emily Shields', 'Quis aut adipisci in', 1, 1, '2024-04-06 14:05:36', '2024-04-06 14:05:36', '216', '2', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `animal` (`id`, `name`, `plate`, `timezone_auto`, `enabled`, `created_at`, `updated_at`, `timezone_id`, `user_id`, `species`, `age`, `gender`, `habitat`, `weight`, `date_added`) VALUES ('8', 'Oleg Leach', 'Eum dolorem voluptas', 1, 1, '2024-04-06 14:47:48', '2024-04-06 14:47:48', '53', '2', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `animal` (`id`, `name`, `plate`, `timezone_auto`, `enabled`, `created_at`, `updated_at`, `timezone_id`, `user_id`, `species`, `age`, `gender`, `habitat`, `weight`, `date_added`) VALUES ('9', 'Clementine Nolan', 'Fuga Consequuntur e', 1, 1, '2024-04-06 15:13:16', '2024-04-06 15:13:16', '32', '2', 'Voluptate minima mag', 15, 'M', NULL, NULL, NULL);
INSERT INTO `configuration` (`id`, `key`, `value`, `description`, `created_at`, `updated_at`) VALUES ('1', 'position_filter_distance', '5', 'Discard positions if the previous position for same trip is less than X meters from the current one', '2024-02-26 13:59:20', '2024-02-26 13:59:20');
INSERT INTO `configuration` (`id`, `key`, `value`, `description`, `created_at`, `updated_at`) VALUES ('2', 'trip_wait_minutes', '500', 'Wait X minutes between positions to create a new trip', '2024-02-26 13:59:20', '2024-04-06 15:17:55');
INSERT INTO `configuration` (`id`, `key`, `value`, `description`, `created_at`, `updated_at`) VALUES ('3', 'position_filter_signal', '1', 'Discard positions that do not contain a valid signal', '2024-02-26 13:59:20', '2024-02-26 13:59:20');
INSERT INTO `configuration` (`id`, `key`, `value`, `description`, `created_at`, `updated_at`) VALUES ('4', 'shared_enabled', '0', 'Enable or Disable the public panel of shared devices (/shared)', '2024-02-26 13:59:20', '2024-02-26 13:59:20');
INSERT INTO `configuration` (`id`, `key`, `value`, `description`, `created_at`, `updated_at`) VALUES ('5', 'shared_slug', '', 'Add a slug to the /shared path to avoid direct access in the generic URL', '2024-02-26 13:59:20', '2024-02-26 13:59:20');
INSERT INTO `device` (`id`, `code`, `name`, `model`, `serial`, `phone_number`, `password`, `enabled`, `shared`, `shared_public`, `connected_at`, `created_at`, `updated_at`, `user_id`, `vehicle_id`) VALUES ('1', '7b2d6cc5-89f8-463e-9b36-c1c734bc0398', 'Test Device', 'T243', '09023987434898', '0782150448', 'StrongPassword2', 1, 1, 1, NULL, '2024-02-26 14:04:58', '2024-02-26 14:04:58', '1', '1');
INSERT INTO `device` (`id`, `code`, `name`, `model`, `serial`, `phone_number`, `password`, `enabled`, `shared`, `shared_public`, `connected_at`, `created_at`, `updated_at`, `user_id`, `vehicle_id`) VALUES ('2', 'a1e06413-71ff-459d-9bf0-e648b81e21c2', 'Lucius England', 'Veniam laudantium', '218', '+1 (571) 251-6532', 'Pa$$w0rd!', 1, 1, 1, NULL, '2024-04-06 15:18:30', '2024-04-06 15:18:51', '2', '4');
INSERT INTO `device_message` (`id`, `message`, `response`, `sent_at`, `response_at`, `created_at`, `updated_at`, `device_id`) VALUES ('1', '{PASSWORD}{SERIAL}', NULL, NULL, NULL, '2024-02-26 14:05:12', '2024-02-26 14:05:12', '1');
INSERT INTO `language` (`id`, `name`, `code`, `locale`, `enabled`, `created_at`, `updated_at`) VALUES ('1', 'Castellano', 'es', 'es_ES', 1, '2024-02-26 13:59:20', '2024-02-26 13:59:20');
INSERT INTO `language` (`id`, `name`, `code`, `locale`, `enabled`, `created_at`, `updated_at`) VALUES ('2', 'English', 'en', 'en_US', 1, '2024-02-26 13:59:20', '2024-02-26 13:59:20');
INSERT INTO `maintenance_item` (`id`, `name`, `created_at`, `updated_at`, `user_id`) VALUES ('1', 'Test maintainance', '2024-02-26 14:08:28', '2024-02-26 14:08:28', '1');
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (1, '2021_01_14_000000_base', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (2, '2021_01_14_000001_seed', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (3, '2022_10_04_184500_device_password_port', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (4, '2022_10_06_183000_trip_distance_time', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (5, '2022_10_06_183000_trip_sleep', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (6, '2022_10_07_190000_city_state_country', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (7, '2022_10_07_193000_position_city', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (8, '2022_10_09_233000_device_timezone', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (9, '2022_10_10_153000_point_4326', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (10, '2022_10_11_173000_user_admin', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (11, '2022_10_16_190000_timezone', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (12, '2022_10_16_193000_device_timezone', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (13, '2022_10_16_193000_position_date_utc_at', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (14, '2022_10_16_193000_position_timezone', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (15, '2022_10_17_193000_refuel_units', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (16, '2022_10_17_193000_trip_dates_utc_at', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (17, '2022_10_17_193000_trip_timezone', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (18, '2022_10_17_230000_refuel_quantity_before', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (19, '2022_10_17_233000_refuel_price', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (20, '2022_11_01_193000_device_timezone_auto', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (21, '2022_11_02_180000_timezone_unused', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (22, '2022_11_02_183000_timezone_geojson', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (23, '2022_11_04_183000_device_connected_at', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (24, '2022_11_05_220000_position_trip_id', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (25, '2022_11_07_183000_device_message', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (26, '2022_11_08_190000_device_message_response', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (27, '2022_11_09_183000_device_phone_number', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (28, '2022_11_10_183000_device_alarm', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (29, '2022_11_23_220000_device_alarm_keys', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (30, '2022_11_23_233000_user_telegram', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (31, '2022_11_24_183000_device_alarm_telegram', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (32, '2022_11_24_220000_device_alarm_notification_foreign', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (33, '2022_11_25_223000_device_alarm_rename', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (34, '2022_11_25_224000_device_alarm_multiple', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (35, '2022_11_27_190000_timezone_default', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (36, '2022_11_27_220000_alarm_notification_date_at', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (37, '2022_11_27_223000_alarm_notification_point', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (38, '2022_12_02_183000_server', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (39, '2022_12_20_183000_vehicle', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (40, '2022_12_22_223000_configuration_socket_debug', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (41, '2022_12_22_223000_device_port', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (42, '2022_12_27_183000_server_debug', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (43, '2022_12_29_220000_trip_stats', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (44, '2023_01_02_230000_user_preferences', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (45, '2023_02_01_230000_trip_shared', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (46, '2023_02_07_234500_device_timezone_auto', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (47, '2023_03_09_163000_alarm_schedule', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (48, '2023_03_22_183000_ip_lock_index', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (49, '2023_04_27_203000_position_point_swap', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (50, '2023_09_13_223000_maintenance', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (51, '2023_09_14_190000_file', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (52, '2023_09_15_183000_maintenance_date_at', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (53, '2023_09_25_200000_device_shared', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (54, '2023_09_27_004500_device_maker_model', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (55, '2023_09_27_005000_device_trip_shared_public', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (56, '2023_09_27_185000_device_trip_code_uuid', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (57, '2023_09_29_185000_position_index', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (58, '2023_10_02_185000_position_index', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (59, '2023_10_05_185000_user_fail', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (60, '2023_10_05_190000_user_session_to_user_fail', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (61, '2023_10_05_235000_trip_index', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (62, '2023_10_23_235000_maintenance_item', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (63, '2023_10_25_003000_maintenance_maintenance_item_amount_gross', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (64, '2023_10_31_185000_user_admin_mode', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (65, '2023_10_31_185000_user_manager', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (66, '2023_11_23_003000_user_timezone_id', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (67, '2023_11_30_003000_refuel_position_id', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (68, '2023_11_30_230000_city_country_id', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (69, '2023_11_30_230000_position_state_country', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (70, '2023_12_08_133000_language_default', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (71, '2023_12_27_203000_point_latitude_longitude', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (72, '2024_01_04_193000_refuel_point', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (73, '2024_01_04_203000_city_only', 1);
INSERT INTO `server` (`id`, `port`, `protocol`, `debug`, `enabled`, `created_at`, `updated_at`) VALUES ('1', 8091, 'debug-http', 1, 1, '2024-02-26 13:59:20', '2024-02-26 14:06:59');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('1', 'Africa/Abidjan', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:20', '2024-02-26 13:59:20');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('2', 'Africa/Accra', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:20', '2024-02-26 13:59:20');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('3', 'Africa/Addis_Ababa', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:20', '2024-02-26 13:59:20');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('4', 'Africa/Algiers', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:20', '2024-02-26 13:59:20');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('5', 'Africa/Asmara', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:20', '2024-02-26 13:59:20');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('6', 'Africa/Bamako', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:20', '2024-02-26 13:59:20');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('7', 'Africa/Bangui', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:20', '2024-02-26 13:59:20');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('8', 'Africa/Banjul', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:20', '2024-02-26 13:59:20');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('9', 'Africa/Bissau', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:20', '2024-02-26 13:59:20');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('10', 'Africa/Blantyre', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:20', '2024-02-26 13:59:20');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('11', 'Africa/Brazzaville', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:20', '2024-02-26 13:59:20');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('12', 'Africa/Bujumbura', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:20', '2024-02-26 13:59:20');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('13', 'Africa/Cairo', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:20', '2024-02-26 13:59:20');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('14', 'Africa/Casablanca', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:20', '2024-02-26 13:59:20');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('15', 'Africa/Ceuta', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:20', '2024-02-26 13:59:20');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('16', 'Africa/Conakry', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:20', '2024-02-26 13:59:20');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('17', 'Africa/Dakar', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:20', '2024-02-26 13:59:20');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('18', 'Africa/Dar_es_Salaam', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:20', '2024-02-26 13:59:20');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('19', 'Africa/Djibouti', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:20', '2024-02-26 13:59:20');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('20', 'Africa/Douala', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:20', '2024-02-26 13:59:20');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('21', 'Africa/El_Aaiun', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:20', '2024-02-26 13:59:20');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('22', 'Africa/Freetown', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:20', '2024-02-26 13:59:20');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('23', 'Africa/Gaborone', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:20', '2024-02-26 13:59:20');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('24', 'Africa/Harare', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:20', '2024-02-26 13:59:20');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('25', 'Africa/Johannesburg', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:20', '2024-02-26 13:59:20');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('26', 'Africa/Juba', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:20', '2024-02-26 13:59:20');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('27', 'Africa/Kampala', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:20', '2024-02-26 13:59:20');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('28', 'Africa/Khartoum', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:20', '2024-02-26 13:59:20');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('29', 'Africa/Kigali', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:20', '2024-02-26 13:59:20');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('30', 'Africa/Kinshasa', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:20', '2024-02-26 13:59:20');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('31', 'Africa/Lagos', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:20', '2024-02-26 13:59:20');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('32', 'Africa/Libreville', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:20', '2024-02-26 13:59:20');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('33', 'Africa/Lome', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:21', '2024-02-26 13:59:21');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('34', 'Africa/Luanda', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:21', '2024-02-26 13:59:21');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('35', 'Africa/Lubumbashi', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:21', '2024-02-26 13:59:21');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('36', 'Africa/Lusaka', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:21', '2024-02-26 13:59:21');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('37', 'Africa/Malabo', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:21', '2024-02-26 13:59:21');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('38', 'Africa/Maputo', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:21', '2024-02-26 13:59:21');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('39', 'Africa/Maseru', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:21', '2024-02-26 13:59:21');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('40', 'Africa/Mbabane', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:21', '2024-02-26 13:59:21');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('41', 'Africa/Mogadishu', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:21', '2024-02-26 13:59:21');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('42', 'Africa/Monrovia', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:21', '2024-02-26 13:59:21');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('43', 'Africa/Nairobi', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:21', '2024-02-26 13:59:21');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('44', 'Africa/Ndjamena', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:21', '2024-02-26 13:59:21');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('45', 'Africa/Niamey', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:21', '2024-02-26 13:59:21');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('46', 'Africa/Nouakchott', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:21', '2024-02-26 13:59:21');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('47', 'Africa/Ouagadougou', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:21', '2024-02-26 13:59:21');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('48', 'Africa/Porto-Novo', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:21', '2024-02-26 13:59:21');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('49', 'Africa/Sao_Tome', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:21', '2024-02-26 13:59:21');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('50', 'Africa/Tripoli', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:21', '2024-02-26 13:59:21');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('51', 'Africa/Tunis', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:21', '2024-02-26 13:59:21');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('52', 'Africa/Windhoek', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:21', '2024-02-26 13:59:21');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('53', 'America/Adak', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:21', '2024-02-26 13:59:21');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('54', 'America/Anchorage', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:21', '2024-02-26 13:59:21');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('55', 'America/Anguilla', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:21', '2024-02-26 13:59:21');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('56', 'America/Antigua', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:21', '2024-02-26 13:59:21');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('57', 'America/Araguaina', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:21', '2024-02-26 13:59:21');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('58', 'America/Argentina/Buenos_Aires', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:21', '2024-02-26 13:59:21');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('59', 'America/Argentina/Catamarca', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:21', '2024-02-26 13:59:21');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('60', 'America/Argentina/Cordoba', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:21', '2024-02-26 13:59:21');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('61', 'America/Argentina/Jujuy', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:21', '2024-02-26 13:59:21');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('62', 'America/Argentina/La_Rioja', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:21', '2024-02-26 13:59:21');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('63', 'America/Argentina/Mendoza', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:21', '2024-02-26 13:59:21');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('64', 'America/Argentina/Rio_Gallegos', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:21', '2024-02-26 13:59:21');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('65', 'America/Argentina/Salta', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:21', '2024-02-26 13:59:21');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('66', 'America/Argentina/San_Juan', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:21', '2024-02-26 13:59:21');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('67', 'America/Argentina/San_Luis', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:21', '2024-02-26 13:59:21');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('68', 'America/Argentina/Tucuman', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:21', '2024-02-26 13:59:21');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('69', 'America/Argentina/Ushuaia', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:21', '2024-02-26 13:59:21');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('70', 'America/Aruba', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:21', '2024-02-26 13:59:21');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('71', 'America/Asuncion', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:21', '2024-02-26 13:59:21');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('72', 'America/Atikokan', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:21', '2024-02-26 13:59:21');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('73', 'America/Bahia', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:21', '2024-02-26 13:59:21');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('74', 'America/Bahia_Banderas', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:21', '2024-02-26 13:59:21');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('75', 'America/Barbados', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:21', '2024-02-26 13:59:21');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('76', 'America/Belem', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:21', '2024-02-26 13:59:21');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('77', 'America/Belize', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:21', '2024-02-26 13:59:21');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('78', 'America/Blanc-Sablon', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:21', '2024-02-26 13:59:21');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('79', 'America/Boa_Vista', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:21', '2024-02-26 13:59:21');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('80', 'America/Bogota', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('81', 'America/Boise', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('82', 'America/Cambridge_Bay', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('83', 'America/Campo_Grande', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('84', 'America/Cancun', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('85', 'America/Caracas', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('86', 'America/Cayenne', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('87', 'America/Cayman', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('88', 'America/Chicago', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('89', 'America/Chihuahua', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('90', 'America/Costa_Rica', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('91', 'America/Creston', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('92', 'America/Cuiaba', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('93', 'America/Curacao', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('94', 'America/Danmarkshavn', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('95', 'America/Dawson', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('96', 'America/Dawson_Creek', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('97', 'America/Denver', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('98', 'America/Detroit', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('99', 'America/Dominica', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('100', 'America/Edmonton', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('101', 'America/Eirunepe', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('102', 'America/El_Salvador', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('103', 'America/Fort_Nelson', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('104', 'America/Fortaleza', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('105', 'America/Glace_Bay', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('106', 'America/Goose_Bay', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('107', 'America/Grand_Turk', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('108', 'America/Grenada', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('109', 'America/Guadeloupe', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('110', 'America/Guatemala', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('111', 'America/Guayaquil', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('112', 'America/Guyana', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('113', 'America/Halifax', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('114', 'America/Havana', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('115', 'America/Hermosillo', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('116', 'America/Indiana/Indianapolis', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('117', 'America/Indiana/Knox', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('118', 'America/Indiana/Marengo', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('119', 'America/Indiana/Petersburg', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('120', 'America/Indiana/Tell_City', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('121', 'America/Indiana/Vevay', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('122', 'America/Indiana/Vincennes', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('123', 'America/Indiana/Winamac', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('124', 'America/Inuvik', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('125', 'America/Iqaluit', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('126', 'America/Jamaica', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('127', 'America/Juneau', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('128', 'America/Kentucky/Louisville', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('129', 'America/Kentucky/Monticello', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('130', 'America/Kralendijk', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('131', 'America/La_Paz', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('132', 'America/Lima', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('133', 'America/Los_Angeles', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('134', 'America/Lower_Princes', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:22', '2024-02-26 13:59:22');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('135', 'America/Maceio', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('136', 'America/Managua', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('137', 'America/Manaus', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('138', 'America/Marigot', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('139', 'America/Martinique', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('140', 'America/Matamoros', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('141', 'America/Mazatlan', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('142', 'America/Menominee', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('143', 'America/Merida', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('144', 'America/Metlakatla', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('145', 'America/Mexico_City', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('146', 'America/Miquelon', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('147', 'America/Moncton', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('148', 'America/Monterrey', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('149', 'America/Montevideo', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('150', 'America/Montserrat', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('151', 'America/Nassau', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('152', 'America/New_York', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('153', 'America/Nipigon', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('154', 'America/Nome', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('155', 'America/Noronha', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('156', 'America/North_Dakota/Beulah', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('157', 'America/North_Dakota/Center', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('158', 'America/North_Dakota/New_Salem', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('159', 'America/Nuuk', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('160', 'America/Ojinaga', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('161', 'America/Panama', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('162', 'America/Pangnirtung', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('163', 'America/Paramaribo', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('164', 'America/Phoenix', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('165', 'America/Port_of_Spain', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('166', 'America/Port-au-Prince', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('167', 'America/Porto_Velho', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('168', 'America/Puerto_Rico', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('169', 'America/Punta_Arenas', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('170', 'America/Rainy_River', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('171', 'America/Rankin_Inlet', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('172', 'America/Recife', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('173', 'America/Regina', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('174', 'America/Resolute', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('175', 'America/Rio_Branco', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('176', 'America/Santarem', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('177', 'America/Santiago', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('178', 'America/Santo_Domingo', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('179', 'America/Sao_Paulo', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('180', 'America/Scoresbysund', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('181', 'America/Sitka', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('182', 'America/St_Barthelemy', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('183', 'America/St_Johns', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('184', 'America/St_Kitts', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('185', 'America/St_Lucia', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('186', 'America/St_Thomas', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('187', 'America/St_Vincent', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('188', 'America/Swift_Current', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:23', '2024-02-26 13:59:23');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('189', 'America/Tegucigalpa', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('190', 'America/Thule', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('191', 'America/Thunder_Bay', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('192', 'America/Tijuana', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('193', 'America/Toronto', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('194', 'America/Tortola', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('195', 'America/Vancouver', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('196', 'America/Whitehorse', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('197', 'America/Winnipeg', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('198', 'America/Yakutat', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('199', 'America/Yellowknife', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('200', 'Antarctica/Casey', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('201', 'Antarctica/Davis', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('202', 'Antarctica/DumontDUrville', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('203', 'Antarctica/Macquarie', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('204', 'Antarctica/Mawson', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('205', 'Antarctica/McMurdo', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('206', 'Antarctica/Palmer', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('207', 'Antarctica/Rothera', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('208', 'Antarctica/Syowa', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('209', 'Antarctica/Troll', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('210', 'Antarctica/Vostok', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('211', 'Arctic/Longyearbyen', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('212', 'Asia/Aden', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('213', 'Asia/Almaty', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('214', 'Asia/Amman', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('215', 'Asia/Anadyr', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('216', 'Asia/Aqtau', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('217', 'Asia/Aqtobe', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('218', 'Asia/Ashgabat', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('219', 'Asia/Atyrau', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('220', 'Asia/Baghdad', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('221', 'Asia/Bahrain', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('222', 'Asia/Baku', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('223', 'Asia/Bangkok', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('224', 'Asia/Barnaul', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('225', 'Asia/Beirut', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('226', 'Asia/Bishkek', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('227', 'Asia/Brunei', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('228', 'Asia/Chita', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('229', 'Asia/Choibalsan', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('230', 'Asia/Colombo', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('231', 'Asia/Damascus', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('232', 'Asia/Dhaka', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('233', 'Asia/Dili', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('234', 'Asia/Dubai', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('235', 'Asia/Dushanbe', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('236', 'Asia/Famagusta', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('237', 'Asia/Gaza', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('238', 'Asia/Hebron', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('239', 'Asia/Ho_Chi_Minh', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('240', 'Asia/Hong_Kong', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('241', 'Asia/Hovd', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('242', 'Asia/Irkutsk', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:24', '2024-02-26 13:59:24');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('243', 'Asia/Jakarta', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('244', 'Asia/Jayapura', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('245', 'Asia/Jerusalem', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('246', 'Asia/Kabul', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('247', 'Asia/Kamchatka', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('248', 'Asia/Karachi', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('249', 'Asia/Kathmandu', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('250', 'Asia/Khandyga', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('251', 'Asia/Kolkata', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('252', 'Asia/Krasnoyarsk', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('253', 'Asia/Kuala_Lumpur', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('254', 'Asia/Kuching', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('255', 'Asia/Kuwait', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('256', 'Asia/Macau', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('257', 'Asia/Magadan', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('258', 'Asia/Makassar', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('259', 'Asia/Manila', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('260', 'Asia/Muscat', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('261', 'Asia/Nicosia', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('262', 'Asia/Novokuznetsk', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('263', 'Asia/Novosibirsk', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('264', 'Asia/Omsk', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('265', 'Asia/Oral', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('266', 'Asia/Phnom_Penh', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('267', 'Asia/Pontianak', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('268', 'Asia/Pyongyang', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('269', 'Asia/Qatar', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('270', 'Asia/Qostanay', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('271', 'Asia/Qyzylorda', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('272', 'Asia/Riyadh', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('273', 'Asia/Sakhalin', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('274', 'Asia/Samarkand', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('275', 'Asia/Seoul', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('276', 'Asia/Shanghai', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('277', 'Asia/Singapore', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('278', 'Asia/Srednekolymsk', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('279', 'Asia/Taipei', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('280', 'Asia/Tashkent', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('281', 'Asia/Tbilisi', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('282', 'Asia/Tehran', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('283', 'Asia/Thimphu', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('284', 'Asia/Tokyo', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('285', 'Asia/Tomsk', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('286', 'Asia/Ulaanbaatar', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('287', 'Asia/Urumqi', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('288', 'Asia/Ust-Nera', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('289', 'Asia/Vientiane', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('290', 'Asia/Vladivostok', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('291', 'Asia/Yakutsk', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('292', 'Asia/Yangon', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('293', 'Asia/Yekaterinburg', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('294', 'Asia/Yerevan', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('295', 'Atlantic/Azores', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('296', 'Atlantic/Bermuda', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:25', '2024-02-26 13:59:25');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('297', 'Atlantic/Canary', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('298', 'Atlantic/Cape_Verde', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('299', 'Atlantic/Faroe', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('300', 'Atlantic/Madeira', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('301', 'Atlantic/Reykjavik', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('302', 'Atlantic/South_Georgia', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('303', 'Atlantic/St_Helena', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('304', 'Atlantic/Stanley', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('305', 'Australia/Adelaide', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('306', 'Australia/Brisbane', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('307', 'Australia/Broken_Hill', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('308', 'Australia/Darwin', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('309', 'Australia/Eucla', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('310', 'Australia/Hobart', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('311', 'Australia/Lindeman', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('312', 'Australia/Lord_Howe', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('313', 'Australia/Melbourne', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('314', 'Australia/Perth', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('315', 'Australia/Sydney', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('316', 'Etc/GMT', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('317', 'Etc/GMT-1', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('318', 'Etc/GMT-10', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('319', 'Etc/GMT-11', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('320', 'Etc/GMT-12', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('321', 'Etc/GMT-2', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('322', 'Etc/GMT-3', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('323', 'Etc/GMT-4', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('324', 'Etc/GMT-5', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('325', 'Etc/GMT-6', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('326', 'Etc/GMT-7', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('327', 'Etc/GMT-8', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('328', 'Etc/GMT-9', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('329', 'Etc/GMT+1', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('330', 'Etc/GMT+10', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('331', 'Etc/GMT+11', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('332', 'Etc/GMT+12', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('333', 'Etc/GMT+2', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('334', 'Etc/GMT+3', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('335', 'Etc/GMT+4', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('336', 'Etc/GMT+5', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('337', 'Etc/GMT+6', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('338', 'Etc/GMT+7', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('339', 'Etc/GMT+8', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('340', 'Etc/GMT+9', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('341', 'Etc/UTC', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('342', 'Europe/Amsterdam', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('343', 'Europe/Andorra', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('344', 'Europe/Astrakhan', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('345', 'Europe/Athens', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('346', 'Europe/Belgrade', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('347', 'Europe/Berlin', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('348', 'Europe/Bratislava', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('349', 'Europe/Brussels', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:26', '2024-02-26 13:59:26');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('350', 'Europe/Bucharest', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('351', 'Europe/Budapest', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('352', 'Europe/Busingen', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('353', 'Europe/Chisinau', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('354', 'Europe/Copenhagen', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('355', 'Europe/Dublin', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('356', 'Europe/Gibraltar', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('357', 'Europe/Guernsey', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('358', 'Europe/Helsinki', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('359', 'Europe/Isle_of_Man', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('360', 'Europe/Istanbul', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('361', 'Europe/Jersey', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('362', 'Europe/Kaliningrad', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('363', 'Europe/Kiev', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('364', 'Europe/Kirov', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('365', 'Europe/Kyiv', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('366', 'Europe/Lisbon', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('367', 'Europe/Ljubljana', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('368', 'Europe/London', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('369', 'Europe/Luxembourg', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('370', 'Europe/Madrid', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 1, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('371', 'Europe/Malta', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('372', 'Europe/Mariehamn', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('373', 'Europe/Minsk', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('374', 'Europe/Monaco', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('375', 'Europe/Moscow', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('376', 'Europe/Oslo', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('377', 'Europe/Paris', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('378', 'Europe/Podgorica', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('379', 'Europe/Prague', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('380', 'Europe/Riga', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('381', 'Europe/Rome', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('382', 'Europe/Samara', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('383', 'Europe/San_Marino', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('384', 'Europe/Sarajevo', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('385', 'Europe/Saratov', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('386', 'Europe/Simferopol', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('387', 'Europe/Skopje', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('388', 'Europe/Sofia', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('389', 'Europe/Stockholm', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('390', 'Europe/Tallinn', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('391', 'Europe/Tirane', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('392', 'Europe/Ulyanovsk', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('393', 'Europe/Uzhgorod', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('394', 'Europe/Vaduz', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('395', 'Europe/Vatican', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('396', 'Europe/Vienna', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('397', 'Europe/Vilnius', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('398', 'Europe/Volgograd', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('399', 'Europe/Warsaw', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('400', 'Europe/Zagreb', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('401', 'Europe/Zaporozhye', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:27', '2024-02-26 13:59:27');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('402', 'Europe/Zurich', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:28', '2024-02-26 13:59:28');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('403', 'Indian/Antananarivo', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:28', '2024-02-26 13:59:28');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('404', 'Indian/Chagos', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:28', '2024-02-26 13:59:28');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('405', 'Indian/Christmas', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:28', '2024-02-26 13:59:28');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('406', 'Indian/Cocos', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:28', '2024-02-26 13:59:28');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('407', 'Indian/Comoro', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:28', '2024-02-26 13:59:28');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('408', 'Indian/Kerguelen', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:28', '2024-02-26 13:59:28');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('409', 'Indian/Mahe', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:28', '2024-02-26 13:59:28');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('410', 'Indian/Maldives', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:28', '2024-02-26 13:59:28');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('411', 'Indian/Mauritius', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:28', '2024-02-26 13:59:28');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('412', 'Indian/Mayotte', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:28', '2024-02-26 13:59:28');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('413', 'Indian/Reunion', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:28', '2024-02-26 13:59:28');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('414', 'Pacific/Apia', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:28', '2024-02-26 13:59:28');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('415', 'Pacific/Auckland', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:28', '2024-02-26 13:59:28');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('416', 'Pacific/Bougainville', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:28', '2024-02-26 13:59:28');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('417', 'Pacific/Chatham', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:28', '2024-02-26 13:59:28');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('418', 'Pacific/Chuuk', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:28', '2024-02-26 13:59:28');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('419', 'Pacific/Easter', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:28', '2024-02-26 13:59:28');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('420', 'Pacific/Efate', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:28', '2024-02-26 13:59:28');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('421', 'Pacific/Fakaofo', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:28', '2024-02-26 13:59:28');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('422', 'Pacific/Fiji', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:28', '2024-02-26 13:59:28');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('423', 'Pacific/Funafuti', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:28', '2024-02-26 13:59:28');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('424', 'Pacific/Galapagos', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:28', '2024-02-26 13:59:28');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('425', 'Pacific/Gambier', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:28', '2024-02-26 13:59:28');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('426', 'Pacific/Guadalcanal', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:28', '2024-02-26 13:59:28');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('427', 'Pacific/Guam', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:28', '2024-02-26 13:59:28');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('428', 'Pacific/Honolulu', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:28', '2024-02-26 13:59:28');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('429', 'Pacific/Kanton', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:28', '2024-02-26 13:59:28');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('430', 'Pacific/Kiritimati', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:28', '2024-02-26 13:59:28');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('431', 'Pacific/Kosrae', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:28', '2024-02-26 13:59:28');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('432', 'Pacific/Kwajalein', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:28', '2024-02-26 13:59:28');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('433', 'Pacific/Majuro', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:28', '2024-02-26 13:59:28');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('434', 'Pacific/Marquesas', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:28', '2024-02-26 13:59:28');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('435', 'Pacific/Midway', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:28', '2024-02-26 13:59:28');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('436', 'Pacific/Nauru', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:28', '2024-02-26 13:59:28');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('437', 'Pacific/Niue', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:28', '2024-02-26 13:59:28');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('438', 'Pacific/Norfolk', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:28', '2024-02-26 13:59:28');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('439', 'Pacific/Noumea', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:28', '2024-02-26 13:59:28');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('440', 'Pacific/Pago_Pago', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:28', '2024-02-26 13:59:28');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('441', 'Pacific/Palau', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:28', '2024-02-26 13:59:28');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('442', 'Pacific/Pitcairn', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:28', '2024-02-26 13:59:28');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('443', 'Pacific/Pohnpei', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:28', '2024-02-26 13:59:28');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('444', 'Pacific/Port_Moresby', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:28', '2024-02-26 13:59:28');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('445', 'Pacific/Rarotonga', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:28', '2024-02-26 13:59:28');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('446', 'Pacific/Saipan', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:28', '2024-02-26 13:59:28');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('447', 'Pacific/Tahiti', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:28', '2024-02-26 13:59:28');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('448', 'Pacific/Tarawa', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:28', '2024-02-26 13:59:28');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('449', 'Pacific/Tongatapu', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:28', '2024-02-26 13:59:28');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('450', 'Pacific/Wake', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:28', '2024-02-26 13:59:28');
INSERT INTO `timezone` (`id`, `zone`, `geojson`, `default`, `created_at`, `updated_at`) VALUES ('451', 'Pacific/Wallis', '[[[{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90},{"x":0,"y":90}]]]', 0, '2024-02-26 13:59:28', '2024-02-26 13:59:28');
INSERT INTO `user` (`id`, `name`, `email`, `password`, `remember_token`, `preferences`, `telegram`, `enabled`, `admin`, `admin_mode`, `manager`, `manager_mode`, `created_at`, `updated_at`, `language_id`, `timezone_id`) VALUES ('1', 'Admin1', 'user@animaltracker.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'f8YYuCUQ1Xgy7l8t9lg5xAPxTQ45BEHZW5mm4brjiPFD1f6bXteF3qP173p5', '{"units":{"money":null,"volume":null,"decimal":null,"distance":null,"thousand":null},"user_id":1,"device_id":1,"vehicle_id":"2"}', NULL, 1, 1, 1, 0, 0, '2024-02-26 14:01:56', '2024-04-06 17:23:07', '2', '370');
INSERT INTO `user` (`id`, `name`, `email`, `password`, `remember_token`, `preferences`, `telegram`, `enabled`, `admin`, `admin_mode`, `manager`, `manager_mode`, `created_at`, `updated_at`, `language_id`, `timezone_id`) VALUES ('2', 'Admin', 'user@domain.com', '$2y$12$eZNr9JRC6YW.ZBaQv7pPYedYH6rjodK1VHvh8P0g074pH2JwYZxcO', 'VEKxhtgFLEzTLX3dHUAUgBJ3HLHOc4bZD0sB8gEUySkRZ0hF4Qq1O9LVt7pi', '{"units":{"money":null,"volume":null,"decimal":null,"distance":null,"thousand":null},"user_id":2,"device_id":"","vehicle_id":"6"}', NULL, 1, 1, 1, 0, 0, '2024-04-04 21:39:31', '2024-04-06 15:16:19', '2', '370');
INSERT INTO `user` (`id`, `name`, `email`, `password`, `remember_token`, `preferences`, `telegram`, `enabled`, `admin`, `admin_mode`, `manager`, `manager_mode`, `created_at`, `updated_at`, `language_id`, `timezone_id`) VALUES ('3', 'Admin3', 'use2r@domain.com', '$2y$12$RoovcOwzHET59d6pqd.dieb2cR3sOXYCNEwdJwCIMpXy0iDUAZTpu', NULL, '{"units":{"money":null,"volume":null,"decimal":null,"distance":null,"thousand":null}}', NULL, 1, 1, 1, 1, 1, '2024-04-06 14:37:11', '2024-04-06 14:37:11', '2', '370');
INSERT INTO `user_fail` (`id`, `type`, `text`, `ip`, `created_at`, `updated_at`, `user_id`) VALUES ('1', 'user-auth-credentials', 'user@animaltracker.com', '127.0.0.1', '2024-02-26 14:02:30', '2024-02-26 14:02:30', '1');
INSERT INTO `user_fail` (`id`, `type`, `text`, `ip`, `created_at`, `updated_at`, `user_id`) VALUES ('2', 'user-auth-credentials', 'user@animaltracker.com', '127.0.0.1', '2024-04-04 21:38:03', '2024-04-04 21:38:03', '1');
INSERT INTO `user_fail` (`id`, `type`, `text`, `ip`, `created_at`, `updated_at`, `user_id`) VALUES ('3', 'user-auth-credentials', 'user@animaltracker.com', '127.0.0.1', '2024-04-04 21:38:11', '2024-04-04 21:38:11', '1');
INSERT INTO `user_fail` (`id`, `type`, `text`, `ip`, `created_at`, `updated_at`, `user_id`) VALUES ('4', 'user-auth-credentials', 'user@animaltracker.com', '127.0.0.1', '2024-04-04 21:38:59', '2024-04-04 21:38:59', '1');
INSERT INTO `user_session` (`id`, `auth`, `ip`, `created_at`, `updated_at`, `user_id`) VALUES ('1', 'user@animaltracker.com', '127.0.0.1', '2024-02-26 14:02:49', '2024-02-26 14:02:49', '1');
INSERT INTO `user_session` (`id`, `auth`, `ip`, `created_at`, `updated_at`, `user_id`) VALUES ('2', 'user@domain.com', '127.0.0.1', '2024-04-04 21:39:59', '2024-04-04 21:39:59', '2');
SET FOREIGN_KEY_CHECKS = 1;
ALTER TABLE `alarm` ADD CONSTRAINT `alarm_user_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE `alarm_notification` ADD CONSTRAINT `alarm_notification_position_fk` FOREIGN KEY (`position_id`) REFERENCES `position` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION;
ALTER TABLE `alarm_notification` ADD CONSTRAINT `alarm_notification_trip_fk` FOREIGN KEY (`trip_id`) REFERENCES `trip` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION;
ALTER TABLE `alarm_notification` ADD CONSTRAINT `alarm_notification_vehicle_fk` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicle` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE `alarm_notification` ADD CONSTRAINT `alarm_notification_alarm_fk` FOREIGN KEY (`alarm_id`) REFERENCES `alarm` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION;
ALTER TABLE `alarm_vehicle` ADD CONSTRAINT `alarm_vehicle_alarm_fk` FOREIGN KEY (`alarm_id`) REFERENCES `alarm` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE `alarm_vehicle` ADD CONSTRAINT `alarm_vehicle_vehicle_fk` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicle` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE `animal` ADD CONSTRAINT `vehicle_timezone_fk` FOREIGN KEY (`timezone_id`) REFERENCES `timezone` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE `animal` ADD CONSTRAINT `vehicle_user_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE `city` ADD CONSTRAINT `city_country_fk` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE `city` ADD CONSTRAINT `city_state_fk` FOREIGN KEY (`state_id`) REFERENCES `state` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE `device` ADD CONSTRAINT `device_user_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE `device` ADD CONSTRAINT `device_vehicle_fk` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicle` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION;
ALTER TABLE `device_alarm` ADD CONSTRAINT `device_alarm_device_fk` FOREIGN KEY (`device_id`) REFERENCES `device` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE `device_alarm_notification` ADD CONSTRAINT `device_alarm_notification_device_fk` FOREIGN KEY (`device_id`) REFERENCES `device` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE `device_alarm_notification` ADD CONSTRAINT `device_alarm_notification_device_alarm_fk` FOREIGN KEY (`device_alarm_id`) REFERENCES `device_alarm` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION;
ALTER TABLE `device_alarm_notification` ADD CONSTRAINT `device_alarm_notification_position_fk` FOREIGN KEY (`position_id`) REFERENCES `position` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION;
ALTER TABLE `device_alarm_notification` ADD CONSTRAINT `device_alarm_notification_trip_fk` FOREIGN KEY (`trip_id`) REFERENCES `trip` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION;
ALTER TABLE `device_message` ADD CONSTRAINT `device_message_device_fk` FOREIGN KEY (`device_id`) REFERENCES `device` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE `file` ADD CONSTRAINT `file_user_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE `maintenance` ADD CONSTRAINT `maintenance_vehicle_fk` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicle` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE `maintenance` ADD CONSTRAINT `maintenance_user_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE `maintenance_item` ADD CONSTRAINT `maintenance_item_user_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE `maintenance_maintenance_item` ADD CONSTRAINT `maintenance_maintenance_item_maintenance_fk` FOREIGN KEY (`maintenance_id`) REFERENCES `maintenance` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE `maintenance_maintenance_item` ADD CONSTRAINT `maintenance_maintenance_item_maintenance_item_fk` FOREIGN KEY (`maintenance_item_id`) REFERENCES `maintenance_item` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE `position` ADD CONSTRAINT `position_city_fk` FOREIGN KEY (`city_id`) REFERENCES `city` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION;
ALTER TABLE `position` ADD CONSTRAINT `position_device_fk` FOREIGN KEY (`device_id`) REFERENCES `device` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION;
ALTER TABLE `position` ADD CONSTRAINT `position_timezone_fk` FOREIGN KEY (`timezone_id`) REFERENCES `timezone` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE `position` ADD CONSTRAINT `position_trip_fk` FOREIGN KEY (`trip_id`) REFERENCES `trip` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE `position` ADD CONSTRAINT `position_user_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE `position` ADD CONSTRAINT `position_vehicle_fk` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicle` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE `refuel` ADD CONSTRAINT `refuel_city_fk` FOREIGN KEY (`city_id`) REFERENCES `city` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION;
ALTER TABLE `refuel` ADD CONSTRAINT `refuel_position_fk` FOREIGN KEY (`position_id`) REFERENCES `position` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION;
ALTER TABLE `refuel` ADD CONSTRAINT `refuel_user_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE `refuel` ADD CONSTRAINT `refuel_vehicle_fk` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicle` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE `state` ADD CONSTRAINT `state_country_fk` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE `trip` ADD CONSTRAINT `trip_device_fk` FOREIGN KEY (`device_id`) REFERENCES `device` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION;
ALTER TABLE `trip` ADD CONSTRAINT `trip_timezone_fk` FOREIGN KEY (`timezone_id`) REFERENCES `timezone` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE `trip` ADD CONSTRAINT `trip_user_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE `trip` ADD CONSTRAINT `trip_vehicle_fk` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicle` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE `user` ADD CONSTRAINT `user_language_fk` FOREIGN KEY (`language_id`) REFERENCES `language` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE `user` ADD CONSTRAINT `user_timezone_fk` FOREIGN KEY (`timezone_id`) REFERENCES `timezone` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE `user_fail` ADD CONSTRAINT `user_fail_user_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION;
ALTER TABLE `user_session` ADD CONSTRAINT `user_session_user_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
