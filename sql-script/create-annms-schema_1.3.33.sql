-- MySQL Script generated by MySQL Workbench
-- Wed Nov  2 21:40:54 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema announcement
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `announcement` ;

-- -----------------------------------------------------
-- Schema announcement
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `announcement` DEFAULT CHARACTER SET utf8 ;
USE `announcement` ;

-- -----------------------------------------------------
-- Table `announcement`.`staffs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement`.`staffs` ;

CREATE TABLE IF NOT EXISTS `announcement`.`staffs` (
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
-- Table `announcement`.`categories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement`.`categories` ;

CREATE TABLE IF NOT EXISTS `announcement`.`categories` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `category_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `category_id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `category_name_UNIQUE` (`category_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `announcement`.`groups`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement`.`groups` ;

CREATE TABLE IF NOT EXISTS `announcement`.`groups` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `group_name` VARCHAR(45) NOT NULL,
  `creator` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `category_id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `category_name_UNIQUE` (`group_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `announcement`.`admins`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement`.`admins` ;

CREATE TABLE IF NOT EXISTS `announcement`.`admins` (
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
-- Table `announcement`.`announcements`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement`.`announcements` ;

CREATE TABLE IF NOT EXISTS `announcement`.`announcements` (
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
    REFERENCES `announcement`.`categories` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_announce_staffs1`
    FOREIGN KEY (`staff_id`)
    REFERENCES `announcement`.`staffs` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_announcements_admins1`
    FOREIGN KEY (`admin_id`)
    REFERENCES `announcement`.`admins` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `announcement`.`announcement_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement`.`announcement_group` ;

CREATE TABLE IF NOT EXISTS `announcement`.`announcement_group` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `group_id` INT NOT NULL,
  `announcement_id` INT NOT NULL,
  INDEX `fk_annouce_to_group_groups1_idx` (`group_id` ASC) VISIBLE,
  INDEX `fk_annouce_to_group_announce1_idx` (`announcement_id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  CONSTRAINT `fk_annouce_to_group_groups1`
    FOREIGN KEY (`group_id`)
    REFERENCES `announcement`.`groups` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_annouce_to_group_announce1`
    FOREIGN KEY (`announcement_id`)
    REFERENCES `announcement`.`announcements` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `announcement`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement`.`users` ;

CREATE TABLE IF NOT EXISTS `announcement`.`users` (
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
    REFERENCES `announcement`.`groups` (`id`)
    ON DELETE SET NULL
    ON UPDATE SET NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `announcement`.`subjects`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement`.`subjects` ;

CREATE TABLE IF NOT EXISTS `announcement`.`subjects` (
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
-- Table `announcement`.`user_subject`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement`.`user_subject` ;

CREATE TABLE IF NOT EXISTS `announcement`.`user_subject` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `subject_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_student_subject_students1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_student_subject_subjects1_idx` (`subject_id` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  CONSTRAINT `fk_student_subject_students1`
    FOREIGN KEY (`user_id`)
    REFERENCES `announcement`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_student_subject_subjects1`
    FOREIGN KEY (`subject_id`)
    REFERENCES `announcement`.`subjects` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `announcement`.`topic_types`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement`.`topic_types` ;

CREATE TABLE IF NOT EXISTS `announcement`.`topic_types` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type_name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `announcement`.`topics`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement`.`topics` ;

CREATE TABLE IF NOT EXISTS `announcement`.`topics` (
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
    REFERENCES `announcement`.`subjects` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_topics_staffs1`
    FOREIGN KEY (`staff_id`)
    REFERENCES `announcement`.`staffs` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_topics_topic_types1`
    FOREIGN KEY (`topic_types_id`)
    REFERENCES `announcement`.`topic_types` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_topics_admins1`
    FOREIGN KEY (`admin_id`)
    REFERENCES `announcement`.`admins` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `announcement`.`staff_subject`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement`.`staff_subject` ;

CREATE TABLE IF NOT EXISTS `announcement`.`staff_subject` (
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
    REFERENCES `announcement`.`staffs` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_staff_subject_subjects1`
    FOREIGN KEY (`subject_id`)
    REFERENCES `announcement`.`subjects` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_staff_subject_admins1`
    FOREIGN KEY (`admin_id`)
    REFERENCES `announcement`.`admins` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `announcement`.`staff_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement`.`staff_group` ;

CREATE TABLE IF NOT EXISTS `announcement`.`staff_group` (
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
    REFERENCES `announcement`.`staffs` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_staff_group_groups1`
    FOREIGN KEY (`group_id`)
    REFERENCES `announcement`.`groups` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_staff_group_admins1`
    FOREIGN KEY (`admin_id`)
    REFERENCES `announcement`.`admins` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `announcement`.`announcement_images`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement`.`announcement_images` ;

CREATE TABLE IF NOT EXISTS `announcement`.`announcement_images` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `image_url` VARCHAR(255) NULL,
  `file_url` VARCHAR(255) NULL,
  `announcement_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `topic_id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_announcement_lists_announcements1_idx` (`announcement_id` ASC) VISIBLE,
  CONSTRAINT `fk_announcement_lists_announcements1`
    FOREIGN KEY (`announcement_id`)
    REFERENCES `announcement`.`announcements` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `announcement`.`announcement_users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement`.`announcement_users` ;

CREATE TABLE IF NOT EXISTS `announcement`.`announcement_users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `announcement_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `topic_id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_announcement_topics_users_users1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_announcement_topics_users_announcements1_idx` (`announcement_id` ASC) VISIBLE,
  CONSTRAINT `fk_announcement_users_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `announcement`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_announcement_users_announcements1`
    FOREIGN KEY (`announcement_id`)
    REFERENCES `announcement`.`announcements` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `announcement`.`questions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement`.`questions` ;

CREATE TABLE IF NOT EXISTS `announcement`.`questions` (
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
    REFERENCES `announcement`.`topics` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `announcement`.`scores`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement`.`scores` ;

CREATE TABLE IF NOT EXISTS `announcement`.`scores` (
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
    REFERENCES `announcement`.`questions` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_aswers_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `announcement`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `announcement`.`notifications`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement`.`notifications` ;

CREATE TABLE IF NOT EXISTS `announcement`.`notifications` (
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
    REFERENCES `announcement`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;






-----------------------------------------------------------------------------
-- MySQL Script generated by MySQL Workbench
-- Mon Nov 14 00:59:50 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema announcement-dev
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `announcement-dev` ;

-- -----------------------------------------------------
-- Schema announcement-dev
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `announcement-dev` DEFAULT CHARACTER SET utf8 ;
USE `announcement-dev` ;

-- -----------------------------------------------------
-- Table `announcement-dev`.`staffs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement-dev`.`staffs` ;

CREATE TABLE IF NOT EXISTS `announcement-dev`.`staffs` (
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
-- Table `announcement-dev`.`categories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement-dev`.`categories` ;

CREATE TABLE IF NOT EXISTS `announcement-dev`.`categories` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `category_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `category_id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `category_name_UNIQUE` (`category_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `announcement-dev`.`groups`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement-dev`.`groups` ;

CREATE TABLE IF NOT EXISTS `announcement-dev`.`groups` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `group_name` VARCHAR(45) NOT NULL,
  `group_type` VARCHAR(45) NOT NULL,
  `creator` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `category_id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `category_name_UNIQUE` (`group_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `announcement-dev`.`announcements`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement-dev`.`announcements` ;

CREATE TABLE IF NOT EXISTS `announcement-dev`.`announcements` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NOT NULL,
  `description` VARCHAR(1500) NULL,
  `created_date` DATETIME NOT NULL,
  `due_date` DATETIME NULL,
  `status` VARCHAR(20) NOT NULL,
  `category_id` INT NOT NULL,
  `staff_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `topic_id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_announce_category1_idx` (`category_id` ASC) VISIBLE,
  INDEX `fk_announce_staffs1_idx` (`staff_id` ASC) VISIBLE,
  CONSTRAINT `fk_announce_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `announcement-dev`.`categories` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_announce_staffs1`
    FOREIGN KEY (`staff_id`)
    REFERENCES `announcement-dev`.`staffs` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `announcement-dev`.`announcement_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement-dev`.`announcement_group` ;

CREATE TABLE IF NOT EXISTS `announcement-dev`.`announcement_group` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `group_id` INT NOT NULL,
  `announcement_id` INT NOT NULL,
  INDEX `fk_annouce_to_group_groups1_idx` (`group_id` ASC) VISIBLE,
  INDEX `fk_annouce_to_group_announce1_idx` (`announcement_id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_annouce_to_group_groups1`
    FOREIGN KEY (`group_id`)
    REFERENCES `announcement-dev`.`groups` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_annouce_to_group_announce1`
    FOREIGN KEY (`announcement_id`)
    REFERENCES `announcement-dev`.`announcements` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `announcement-dev`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement-dev`.`users` ;

CREATE TABLE IF NOT EXISTS `announcement-dev`.`users` (
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
    REFERENCES `announcement-dev`.`groups` (`id`)
    ON DELETE SET NULL
    ON UPDATE SET NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `announcement-dev`.`subjects`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement-dev`.`subjects` ;

CREATE TABLE IF NOT EXISTS `announcement-dev`.`subjects` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `subject_code` VARCHAR(45) NOT NULL,
  `subject_name` VARCHAR(45) NOT NULL,
  `year` INT NOT NULL,
  `semester` VARCHAR(45) NOT NULL,
  `creator` VARCHAR(45) NOT NULL,
  `status` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `announcement-dev`.`user_subject`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement-dev`.`user_subject` ;

CREATE TABLE IF NOT EXISTS `announcement-dev`.`user_subject` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `subject_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_student_subject_students1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_student_subject_subjects1_idx` (`subject_id` ASC) VISIBLE,
  CONSTRAINT `fk_student_subject_students1`
    FOREIGN KEY (`user_id`)
    REFERENCES `announcement-dev`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_student_subject_subjects1`
    FOREIGN KEY (`subject_id`)
    REFERENCES `announcement-dev`.`subjects` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `announcement-dev`.`topics`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement-dev`.`topics` ;

CREATE TABLE IF NOT EXISTS `announcement-dev`.`topics` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `type` VARCHAR(20) NOT NULL,
  `description` VARCHAR(255) NULL,
  `created_date` DATETIME NOT NULL,
  `due_date` DATETIME NULL,
  `status` VARCHAR(20) NOT NULL,
  `subject_id` INT NOT NULL,
  `staff_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `topic_id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_topics_subjects1_idx` (`subject_id` ASC) VISIBLE,
  INDEX `fk_topics_staffs1_idx` (`staff_id` ASC) VISIBLE,
  CONSTRAINT `fk_topics_subjects1`
    FOREIGN KEY (`subject_id`)
    REFERENCES `announcement-dev`.`subjects` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_topics_staffs1`
    FOREIGN KEY (`staff_id`)
    REFERENCES `announcement-dev`.`staffs` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `announcement-dev`.`staff_subject`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement-dev`.`staff_subject` ;

CREATE TABLE IF NOT EXISTS `announcement-dev`.`staff_subject` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `staff_id` INT NOT NULL,
  `subject_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_staff_subject_staff1_idx` (`staff_id` ASC) VISIBLE,
  INDEX `fk_staff_subject_subjects1_idx` (`subject_id` ASC) VISIBLE,
  CONSTRAINT `fk_staff_subject_staff1`
    FOREIGN KEY (`staff_id`)
    REFERENCES `announcement-dev`.`staffs` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_staff_subject_subjects1`
    FOREIGN KEY (`subject_id`)
    REFERENCES `announcement-dev`.`subjects` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `announcement-dev`.`staff_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement-dev`.`staff_group` ;

CREATE TABLE IF NOT EXISTS `announcement-dev`.`staff_group` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `staff_id` INT NOT NULL,
  `group_id` INT NOT NULL,
  INDEX `fk_staff_group_groups1_idx` (`group_id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_staff_group_staffs1`
    FOREIGN KEY (`staff_id`)
    REFERENCES `announcement-dev`.`staffs` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_staff_group_groups1`
    FOREIGN KEY (`group_id`)
    REFERENCES `announcement-dev`.`groups` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `announcement-dev`.`announcement_images`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement-dev`.`announcement_images` ;

CREATE TABLE IF NOT EXISTS `announcement-dev`.`announcement_images` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `image_url` VARCHAR(255) NULL,
  `file_url` VARCHAR(255) NULL,
  `announcement_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `topic_id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_announcement_lists_announcements1_idx` (`announcement_id` ASC) VISIBLE,
  CONSTRAINT `fk_announcement_lists_announcements1`
    FOREIGN KEY (`announcement_id`)
    REFERENCES `announcement-dev`.`announcements` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `announcement-dev`.`announcement_users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement-dev`.`announcement_users` ;

CREATE TABLE IF NOT EXISTS `announcement-dev`.`announcement_users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `announcement_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `topic_id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_announcement_topics_users_users1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_announcement_topics_users_announcements1_idx` (`announcement_id` ASC) VISIBLE,
  CONSTRAINT `fk_announcement_users_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `announcement-dev`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_announcement_users_announcements1`
    FOREIGN KEY (`announcement_id`)
    REFERENCES `announcement-dev`.`announcements` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `announcement-dev`.`questions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement-dev`.`questions` ;

CREATE TABLE IF NOT EXISTS `announcement-dev`.`questions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `list_no` INT NULL,
  `title` VARCHAR(45) NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  `score` DECIMAL(6,2) NULL,
  `total_score` DECIMAL(6,2) NULL,
  `image_url` VARCHAR(255) NULL,
  `topic_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `topic_id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_topic_lists_topics1_idx` (`topic_id` ASC) VISIBLE,
  CONSTRAINT `fk_topic_lists_topics1`
    FOREIGN KEY (`topic_id`)
    REFERENCES `announcement-dev`.`topics` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `announcement-dev`.`scores`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement-dev`.`scores` ;

CREATE TABLE IF NOT EXISTS `announcement-dev`.`scores` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `list_no` INT NULL,
  `score` DECIMAL(6,2) NOT NULL,
  `question_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `topic_id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_topic_lists_copy1_topic_lists1_idx` (`question_id` ASC) VISIBLE,
  INDEX `fk_aswers_users1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_topic_lists_copy1_topic_lists1`
    FOREIGN KEY (`question_id`)
    REFERENCES `announcement-dev`.`questions` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_aswers_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `announcement-dev`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `announcement-dev`.`notifications`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `announcement-dev`.`notifications` ;

CREATE TABLE IF NOT EXISTS `announcement-dev`.`notifications` (
  `id` INT NOT NULL,
  `topic` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NULL,
  `action` VARCHAR(45) NULL,
  `sender` VARCHAR(45) NULL,
  `created_date` DATETIME NULL,
  `user_id` INT NULL,
  `staff_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_notifications_users1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_notifications_staffs1_idx` (`staff_id` ASC) VISIBLE,
  CONSTRAINT `fk_notifications_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `announcement-dev`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_notifications_staffs1`
    FOREIGN KEY (`staff_id`)
    REFERENCES `announcement-dev`.`staffs` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
