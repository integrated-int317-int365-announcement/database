-- MySQL Script generated by MySQL Workbench
-- Fri Nov 18 21:19:32 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema announcement-uat
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `announcement-uat` ;

-- -----------------------------------------------------
-- Schema announcement-uat
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `announcement-uat` DEFAULT CHARACTER SET utf8 ;
USE `announcement-uat` ;

-- -----------------------------------------------------
-- Table `announcement-uat`.`staffs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement-uat`.`staffs` ;

CREATE TABLE IF NOT EXISTS `announcement-uat`.`staffs` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(100) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `firstname` VARCHAR(45) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `role` VARCHAR(45) NOT NULL,
  UNIQUE INDEX `student_id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `announcement-uat`.`categories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement-uat`.`categories` ;

CREATE TABLE IF NOT EXISTS `announcement-uat`.`categories` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `category_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `category_id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `category_name_UNIQUE` (`category_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `announcement-uat`.`groups`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement-uat`.`groups` ;

CREATE TABLE IF NOT EXISTS `announcement-uat`.`groups` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `group_name` VARCHAR(45) NOT NULL,
  `creator` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `category_id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `category_name_UNIQUE` (`group_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `announcement-uat`.`admins`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement-uat`.`admins` ;

CREATE TABLE IF NOT EXISTS `announcement-uat`.`admins` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(100) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `firstname` VARCHAR(45) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `role` VARCHAR(45) NOT NULL,
  UNIQUE INDEX `student_id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `announcement-uat`.`announcements`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement-uat`.`announcements` ;

CREATE TABLE IF NOT EXISTS `announcement-uat`.`announcements` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NOT NULL,
  `description` VARCHAR(1500) NULL,
  `created_date` DATETIME NOT NULL,
  `due_date` DATETIME NULL,
  `status` VARCHAR(20) NOT NULL,
  `category_id` INT NOT NULL,
  `staff_id` INT NULL,
  `admin_id` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `topic_id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_announce_category1_idx` (`category_id` ASC) VISIBLE,
  INDEX `fk_announce_staffs1_idx` (`staff_id` ASC) VISIBLE,
  INDEX `fk_announcements_admins1_idx` (`admin_id` ASC) VISIBLE,
  CONSTRAINT `fk_announce_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `announcement-uat`.`categories` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_announce_staffs1`
    FOREIGN KEY (`staff_id`)
    REFERENCES `announcement-uat`.`staffs` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_announcements_admins1`
    FOREIGN KEY (`admin_id`)
    REFERENCES `announcement-uat`.`admins` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `announcement-uat`.`announcement_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement-uat`.`announcement_group` ;

CREATE TABLE IF NOT EXISTS `announcement-uat`.`announcement_group` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `group_id` INT NOT NULL,
  `announcement_id` INT NOT NULL,
  INDEX `fk_annouce_to_group_groups1_idx` (`group_id` ASC) VISIBLE,
  INDEX `fk_annouce_to_group_announce1_idx` (`announcement_id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  CONSTRAINT `fk_annouce_to_group_groups1`
    FOREIGN KEY (`group_id`)
    REFERENCES `announcement-uat`.`groups` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_annouce_to_group_announce1`
    FOREIGN KEY (`announcement_id`)
    REFERENCES `announcement-uat`.`announcements` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `announcement-uat`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement-uat`.`users` ;

CREATE TABLE IF NOT EXISTS `announcement-uat`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(100) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `firstname` VARCHAR(45) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `role` VARCHAR(45) NOT NULL,
  `group_id` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `student_id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_users_groups1_idx` (`group_id` ASC) VISIBLE,
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  CONSTRAINT `fk_users_groups1`
    FOREIGN KEY (`group_id`)
    REFERENCES `announcement-uat`.`groups` (`id`)
    ON DELETE SET NULL
    ON UPDATE SET NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `announcement-uat`.`subjects`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement-uat`.`subjects` ;

CREATE TABLE IF NOT EXISTS `announcement-uat`.`subjects` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `subject_code` VARCHAR(45) NOT NULL,
  `subject_name` VARCHAR(45) NOT NULL,
  `year` INT NOT NULL,
  `semester` VARCHAR(45) NOT NULL,
  `creator` VARCHAR(45) NOT NULL,
  `status` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `announcement-uat`.`user_subject`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement-uat`.`user_subject` ;

CREATE TABLE IF NOT EXISTS `announcement-uat`.`user_subject` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `subject_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_student_subject_students1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_student_subject_subjects1_idx` (`subject_id` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  CONSTRAINT `fk_student_subject_students1`
    FOREIGN KEY (`user_id`)
    REFERENCES `announcement-uat`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_student_subject_subjects1`
    FOREIGN KEY (`subject_id`)
    REFERENCES `announcement-uat`.`subjects` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `announcement-uat`.`topic_types`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement-uat`.`topic_types` ;

CREATE TABLE IF NOT EXISTS `announcement-uat`.`topic_types` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type_name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `announcement-uat`.`topics`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement-uat`.`topics` ;

CREATE TABLE IF NOT EXISTS `announcement-uat`.`topics` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `description` VARCHAR(255) NULL,
  `created_date` DATETIME NOT NULL,
  `due_date` DATETIME NULL,
  `status` VARCHAR(20) NOT NULL,
  `subject_id` INT NOT NULL,
  `topic_types_id` INT NOT NULL,
  `staff_id` INT NULL,
  `admin_id` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `topic_id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_topics_subjects1_idx` (`subject_id` ASC) VISIBLE,
  INDEX `fk_topics_staffs1_idx` (`staff_id` ASC) VISIBLE,
  INDEX `fk_topics_topic_types1_idx` (`topic_types_id` ASC) VISIBLE,
  INDEX `fk_topics_admins1_idx` (`admin_id` ASC) VISIBLE,
  CONSTRAINT `fk_topics_subjects1`
    FOREIGN KEY (`subject_id`)
    REFERENCES `announcement-uat`.`subjects` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_topics_staffs1`
    FOREIGN KEY (`staff_id`)
    REFERENCES `announcement-uat`.`staffs` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_topics_topic_types1`
    FOREIGN KEY (`topic_types_id`)
    REFERENCES `announcement-uat`.`topic_types` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_topics_admins1`
    FOREIGN KEY (`admin_id`)
    REFERENCES `announcement-uat`.`admins` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `announcement-uat`.`staff_subject`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement-uat`.`staff_subject` ;

CREATE TABLE IF NOT EXISTS `announcement-uat`.`staff_subject` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `staff_id` INT NULL,
  `subject_id` INT NOT NULL,
  `admin_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_staff_subject_staff1_idx` (`staff_id` ASC) VISIBLE,
  INDEX `fk_staff_subject_subjects1_idx` (`subject_id` ASC) VISIBLE,
  INDEX `fk_staff_subject_admins1_idx` (`admin_id` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  CONSTRAINT `fk_staff_subject_staff1`
    FOREIGN KEY (`staff_id`)
    REFERENCES `announcement-uat`.`staffs` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_staff_subject_subjects1`
    FOREIGN KEY (`subject_id`)
    REFERENCES `announcement-uat`.`subjects` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_staff_subject_admins1`
    FOREIGN KEY (`admin_id`)
    REFERENCES `announcement-uat`.`admins` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `announcement-uat`.`staff_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement-uat`.`staff_group` ;

CREATE TABLE IF NOT EXISTS `announcement-uat`.`staff_group` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `staff_id` INT NULL,
  `group_id` INT NOT NULL,
  `admin_id` INT NULL,
  INDEX `fk_staff_group_groups1_idx` (`group_id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  INDEX `fk_staff_group_admins1_idx` (`admin_id` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  CONSTRAINT `fk_staff_group_staffs1`
    FOREIGN KEY (`staff_id`)
    REFERENCES `announcement-uat`.`staffs` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_staff_group_groups1`
    FOREIGN KEY (`group_id`)
    REFERENCES `announcement-uat`.`groups` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_staff_group_admins1`
    FOREIGN KEY (`admin_id`)
    REFERENCES `announcement-uat`.`admins` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `announcement-uat`.`announcement_images`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement-uat`.`announcement_images` ;

CREATE TABLE IF NOT EXISTS `announcement-uat`.`announcement_images` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `image_url` VARCHAR(255) NULL,
  `file_url` VARCHAR(255) NULL,
  `announcement_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `topic_id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_announcement_lists_announcements1_idx` (`announcement_id` ASC) VISIBLE,
  CONSTRAINT `fk_announcement_lists_announcements1`
    FOREIGN KEY (`announcement_id`)
    REFERENCES `announcement-uat`.`announcements` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `announcement-uat`.`announcement_users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement-uat`.`announcement_users` ;

CREATE TABLE IF NOT EXISTS `announcement-uat`.`announcement_users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `announcement_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `topic_id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_announcement_topics_users_users1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_announcement_topics_users_announcements1_idx` (`announcement_id` ASC) VISIBLE,
  CONSTRAINT `fk_announcement_users_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `announcement-uat`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_announcement_users_announcements1`
    FOREIGN KEY (`announcement_id`)
    REFERENCES `announcement-uat`.`announcements` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `announcement-uat`.`questions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement-uat`.`questions` ;

CREATE TABLE IF NOT EXISTS `announcement-uat`.`questions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `description` VARCHAR(255) NULL,
  `total_score` DECIMAL(6,2) NULL,
  `image_url` VARCHAR(255) NULL,
  `topic_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `topic_id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_topic_lists_topics1_idx` (`topic_id` ASC) VISIBLE,
  CONSTRAINT `fk_topic_lists_topics1`
    FOREIGN KEY (`topic_id`)
    REFERENCES `announcement-uat`.`topics` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `announcement-uat`.`scores`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement-uat`.`scores` ;

CREATE TABLE IF NOT EXISTS `announcement-uat`.`scores` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `score` DECIMAL(6,2) NULL,
  `note` VARCHAR(255) NULL,
  `question_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `topic_id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_topic_lists_copy1_topic_lists1_idx` (`question_id` ASC) VISIBLE,
  INDEX `fk_aswers_users1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_topic_lists_copy1_topic_lists1`
    FOREIGN KEY (`question_id`)
    REFERENCES `announcement-uat`.`questions` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_aswers_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `announcement-uat`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `announcement-uat`.`notifications`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement-uat`.`notifications` ;

CREATE TABLE IF NOT EXISTS `announcement-uat`.`notifications` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `topic` VARCHAR(255) NOT NULL,
  `description` VARCHAR(1500) NULL,
  `action` VARCHAR(255) NULL,
  `sender` VARCHAR(255) NULL,
  `created_date` DATETIME NULL,
  `url` VARCHAR(100) NULL,
  `user_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_notifications_users1_idx` (`user_id` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  CONSTRAINT `fk_notifications_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `announcement-uat`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
