-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema youtube
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema youtube
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `youtube` DEFAULT CHARACTER SET utf8 ;
USE `youtube` ;

-- -----------------------------------------------------
-- Table `youtube`.`usuari`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`usuari` (
  `id_usuari` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `e-mail` VARCHAR(45) NOT NULL,
  `password` VARCHAR(20) NOT NULL,
  `data_naixement` DATE NULL,
  `sexe` VARCHAR(20) NULL,
  `pais` VARCHAR(45) NULL,
  `codi postal` VARCHAR(15) NULL,
  PRIMARY KEY (`id_usuari`),
  UNIQUE INDEX `id_usuari_UNIQUE` (`id_usuari` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`videos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`videos` (
  `id_videos` INT NOT NULL AUTO_INCREMENT,
  `estat` ENUM('PUBLIC', 'PRIVAT', 'OCULT') NULL,
  `titol` VARCHAR(45) NULL,
  `grandaria` INT NULL,
  `descripcio` LONGTEXT NULL,
  `nom_arxiu` VARCHAR(45) NULL,
  `durada` INT NULL,
  `thumbnail` BLOB NULL,
  `nombre_reproduccions` INT NULL,
  `likes` INT NULL,
  `dislikes` INT NULL,
  `data_publicacio` DATE NULL,
  `usuari_id` INT NOT NULL,
  PRIMARY KEY (`id_videos`),
  UNIQUE INDEX `id_videos_UNIQUE` (`id_videos` ASC) VISIBLE,
  INDEX `usuari_video_id_idx` (`usuari_id` ASC) VISIBLE,
  CONSTRAINT `usuari_video_id`
    FOREIGN KEY (`usuari_id`)
    REFERENCES `youtube`.`usuari` (`id_usuari`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`Etiqueta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`Etiqueta` (
  `id_etiqueta` INT NOT NULL AUTO_INCREMENT,
  `video_id` INT NOT NULL,
  `nom` VARCHAR(45) NULL,
  PRIMARY KEY (`id_etiqueta`),
  UNIQUE INDEX `id_etiqueta_UNIQUE` (`id_etiqueta` ASC) VISIBLE,
  UNIQUE INDEX `video_id_UNIQUE` (`video_id` ASC) VISIBLE,
  CONSTRAINT `video_id`
    FOREIGN KEY (`video_id`)
    REFERENCES `youtube`.`videos` (`id_videos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`Canal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`Canal` (
  `id_canal` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL,
  `descripcio` LONGTEXT NULL,
  `data_creacio` DATE NULL,
  `usuari_id` INT NOT NULL,
  PRIMARY KEY (`id_canal`),
  UNIQUE INDEX `id_canal_UNIQUE` (`id_canal` ASC) VISIBLE,
  CONSTRAINT `usuari_canal_id`
    FOREIGN KEY (`usuari_id`)
    REFERENCES `youtube`.`usuari` (`id_usuari`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`Subscripcions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`Subscripcions` (
  `id_subscripcio` INT NOT NULL AUTO_INCREMENT,
  `canal_id` INT NOT NULL,
  `usuari_subs_id` INT NULL,
  PRIMARY KEY (`id_subscripcio`),
  UNIQUE INDEX `id_subscripcions_UNIQUE` (`id_subscripcio` ASC) VISIBLE,
  CONSTRAINT `canal_id`
    FOREIGN KEY (`canal_id`)
    REFERENCES `youtube`.`Canal` (`id_canal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `usuari_subs_id`
    FOREIGN KEY (`usuari_subs_id`)
    REFERENCES `youtube`.`usuari` (`id_usuari`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`Likes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`Likes` (
  `id_likes` INT NOT NULL AUTO_INCREMENT,
  `usuari_id` INT NOT NULL,
  `video_id` INT NOT NULL,
  `data` DATETIME NULL,
  PRIMARY KEY (`id_likes`),
  UNIQUE INDEX `id_likes_UNIQUE` (`id_likes` ASC) VISIBLE,
  CONSTRAINT `usuari_like_id`
    FOREIGN KEY (`usuari_id`)
    REFERENCES `youtube`.`usuari` (`id_usuari`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `video_like_id`
    FOREIGN KEY (`video_id`)
    REFERENCES `youtube`.`videos` (`id_videos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`Dislikes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`Dislikes` (
  `id_dislikes` INT NOT NULL AUTO_INCREMENT,
  `video_id` INT NOT NULL,
  `usuari_id` INT NOT NULL,
  `data` DATETIME NULL,
  PRIMARY KEY (`id_dislikes`),
  UNIQUE INDEX `id_dislikes_UNIQUE` (`id_dislikes` ASC) VISIBLE,
  CONSTRAINT `usuari_dislike_id`
    FOREIGN KEY (`usuari_id`)
    REFERENCES `youtube`.`usuari` (`id_usuari`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `video_dislike_id`
    FOREIGN KEY (`video_id`)
    REFERENCES `youtube`.`videos` (`id_videos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`Playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`Playlist` (
  `id_playlist` INT NOT NULL AUTO_INCREMENT,
  `usuari_id` INT NOT NULL,
  `video_id` INT NOT NULL,
  `data_creacio` DATE NULL,
  `estat` ENUM('PUBLIC', 'PRIVAT') NULL,
  PRIMARY KEY (`id_playlist`),
  UNIQUE INDEX `id_playlist_UNIQUE` (`id_playlist` ASC) VISIBLE,
  CONSTRAINT `usuari_list_id`
    FOREIGN KEY (`usuari_id`)
    REFERENCES `youtube`.`usuari` (`id_usuari`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `video_list_id`
    FOREIGN KEY (`video_id`)
    REFERENCES `youtube`.`videos` (`id_videos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`Comentaris`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`Comentaris` (
  `id_comentari` INT NOT NULL AUTO_INCREMENT,
  `usuari_id` INT NOT NULL,
  `video_id` INT NOT NULL,
  `text` LONGTEXT NULL,
  `data_creacio` DATE NULL,
  PRIMARY KEY (`id_comentari`),
  UNIQUE INDEX `id_comentari_UNIQUE` (`id_comentari` ASC) VISIBLE,
  CONSTRAINT `video_coment_id`
    FOREIGN KEY (`video_id`)
    REFERENCES `youtube`.`videos` (`id_videos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `usuari_coment_id`
    FOREIGN KEY (`usuari_id`)
    REFERENCES `youtube`.`usuari` (`id_usuari`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`Opinions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`Opinions` (
  `id_opinio` INT NOT NULL AUTO_INCREMENT,
  `usuari_id` INT NOT NULL,
  `comentari_id` INT NOT NULL,
  `opinio` ENUM('LIKE', 'DISLIKE') NULL,
  `data` DATE NULL,
  PRIMARY KEY (`id_opinio`),
  UNIQUE INDEX `id_opinio_UNIQUE` (`id_opinio` ASC) VISIBLE,
  CONSTRAINT `usuari_opinio_id`
    FOREIGN KEY (`usuari_id`)
    REFERENCES `youtube`.`usuari` (`id_usuari`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `comentari_id`
    FOREIGN KEY (`comentari_id`)
    REFERENCES `youtube`.`Comentaris` (`id_comentari`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
