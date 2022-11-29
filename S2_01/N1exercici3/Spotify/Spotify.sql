-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema spotify
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema spotify
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `spotify` DEFAULT CHARACTER SET utf8 ;
USE `spotify` ;

-- -----------------------------------------------------
-- Table `spotify`.`usuaris`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`usuaris` (
  `id_usuari` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `password` VARCHAR(20) NOT NULL,
  `e-mail` VARCHAR(45) NOT NULL,
  `data_naixement` DATE NULL,
  `sexe` VARCHAR(10) NULL,
  `codi_postal` INT(5) NULL,
  `pais` VARCHAR(45) NULL,
  PRIMARY KEY (`id_usuari`),
  UNIQUE INDEX `id_usuari_UNIQUE` (`id_usuari` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`usuari_premium`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`usuari_premium` (
  `id_premium` INT NOT NULL AUTO_INCREMENT,
  `usuari_id` INT NOT NULL,
  `data_subsccripcio` DATE NOT NULL,
  `data_renovacio` DATE NOT NULL,
  PRIMARY KEY (`id_premium`),
  UNIQUE INDEX `id_premium_UNIQUE` (`id_premium` ASC) VISIBLE,
  CONSTRAINT `usuari_id`
    FOREIGN KEY (`usuari_id`)
    REFERENCES `spotify`.`usuaris` (`id_usuari`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`targeta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`targeta` (
  `id_targeta` INT NOT NULL AUTO_INCREMENT,
  `premium_id` INT NOT NULL,
  `mes_cad` INT(2) NOT NULL,
  `any_cad` INT(4) NOT NULL,
  `codi_seg` VARCHAR(3) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_targeta`),
  UNIQUE INDEX `id_targeta_UNIQUE` (`id_targeta` ASC) VISIBLE,
  CONSTRAINT `premium_id`
    FOREIGN KEY (`premium_id`)
    REFERENCES `spotify`.`usuari_premium` (`id_premium`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`Paypal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`Paypal` (
  `id_paypal` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `premium_id` INT NOT NULL,
  PRIMARY KEY (`id_paypal`),
  UNIQUE INDEX `id_paypal_UNIQUE` (`id_paypal` ASC) VISIBLE,
  CONSTRAINT `premium_paypal_id`
    FOREIGN KEY (`premium_id`)
    REFERENCES `spotify`.`usuari_premium` (`id_premium`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`Pagament`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`Pagament` (
  `id_pagament` INT NOT NULL AUTO_INCREMENT,
  `data_pagament` DATE NOT NULL,
  `premium_id` INT NOT NULL,
  `ordre` INT NOT NULL,
  `total` INT NOT NULL,
  PRIMARY KEY (`id_pagament`),
  UNIQUE INDEX `id_pagament_UNIQUE` (`id_pagament` ASC) VISIBLE,
  CONSTRAINT `premium_pag_id`
    FOREIGN KEY (`premium_id`)
    REFERENCES `spotify`.`usuari_premium` (`id_premium`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`Playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`Playlist` (
  `id_playlist` INT NOT NULL AUTO_INCREMENT,
  `titol` VARCHAR(45) NULL,
  `nombre_cançons` INT NULL,
  `data_creacio` DATE NULL,
  `usuari_id` INT NOT NULL,
  PRIMARY KEY (`id_playlist`),
  UNIQUE INDEX `id_playlist_UNIQUE` (`id_playlist` ASC) VISIBLE,
  UNIQUE INDEX `usuari_id_UNIQUE` (`usuari_id` ASC) VISIBLE,
  CONSTRAINT `usuari_list_id`
    FOREIGN KEY (`usuari_id`)
    REFERENCES `spotify`.`usuaris` (`id_usuari`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`Playlist_esborrades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`Playlist_esborrades` (
  `id_esborrades` INT NOT NULL AUTO_INCREMENT,
  `playlist_id` INT NOT NULL,
  `data` DATE NOT NULL,
  PRIMARY KEY (`id_esborrades`),
  UNIQUE INDEX `id_esborrades_UNIQUE` (`id_esborrades` ASC) VISIBLE,
  CONSTRAINT `playlist_id`
    FOREIGN KEY (`playlist_id`)
    REFERENCES `spotify`.`Playlist` (`id_playlist`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`playlist_actives`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`playlist_actives` (
  `id_actives` INT NOT NULL AUTO_INCREMENT,
  `playlist_id` INT NOT NULL,
  PRIMARY KEY (`id_actives`),
  UNIQUE INDEX `id_actives_UNIQUE` (`id_actives` ASC) VISIBLE,
  CONSTRAINT `playlist_act_id`
    FOREIGN KEY (`playlist_id`)
    REFERENCES `spotify`.`Playlist` (`id_playlist`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`cançons`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`cançons` (
  `id_canço` INT NOT NULL AUTO_INCREMENT,
  `titol` VARCHAR(45) NULL,
  `durada` TIME NULL,
  `vegades_introduida` INT NULL,
  PRIMARY KEY (`id_canço`),
  UNIQUE INDEX `id_canço_UNIQUE` (`id_canço` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`cançons_afegides`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`cançons_afegides` (
  `id_afegida` INT NOT NULL AUTO_INCREMENT,
  `usuari_id` INT NOT NULL,
  `data_afegida` DATE NOT NULL,
  `actives_id` INT NOT NULL,
  `canço_id` INT NOT NULL,
  PRIMARY KEY (`id_afegida`),
  INDEX `id_afegida` (`id_afegida` ASC) INVISIBLE,
  UNIQUE INDEX `id_afegida_UNIQUE` (`id_afegida` ASC) VISIBLE,
  CONSTRAINT `usuari_af_id`
    FOREIGN KEY (`usuari_id`)
    REFERENCES `spotify`.`usuaris` (`id_usuari`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `actives_af_id`
    FOREIGN KEY (`actives_id`)
    REFERENCES `spotify`.`playlist_actives` (`id_actives`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `canço_af_id`
    FOREIGN KEY (`canço_id`)
    REFERENCES `spotify`.`cançons` (`id_canço`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`Estils`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`Estils` (
  `id_estil` INT NOT NULL AUTO_INCREMENT,
  `estil` VARCHAR(45) NULL,
  PRIMARY KEY (`id_estil`),
  UNIQUE INDEX `id_estil_UNIQUE` (`id_estil` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`artistes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`artistes` (
  `id_artista` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL,
  `imatge` BLOB NULL,
  `estil_id` INT NOT NULL,
  PRIMARY KEY (`id_artista`),
  UNIQUE INDEX `id_artista_UNIQUE` (`id_artista` ASC) VISIBLE,
  CONSTRAINT `estil_id`
    FOREIGN KEY (`estil_id`)
    REFERENCES `spotify`.`Estils` (`id_estil`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`Album`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`Album` (
  `id_album` INT NOT NULL AUTO_INCREMENT,
  `canço_id` INT NOT NULL,
  `artista_id` INT NOT NULL,
  `titol` VARCHAR(45) NULL,
  `any_publicacio` INT(4) NULL,
  `portada` BLOB NULL,
  PRIMARY KEY (`id_album`),
  UNIQUE INDEX `id_album_UNIQUE` (`id_album` ASC) VISIBLE,
  CONSTRAINT `canço_id`
    FOREIGN KEY (`canço_id`)
    REFERENCES `spotify`.`cançons` (`id_canço`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `artista_id`
    FOREIGN KEY (`artista_id`)
    REFERENCES `spotify`.`artistes` (`id_artista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`Seguidors_artista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`Seguidors_artista` (
  `id_seguidors_artista` INT NOT NULL AUTO_INCREMENT,
  `usuari_id` INT NOT NULL,
  `artista_id` INT NOT NULL,
  PRIMARY KEY (`id_seguidors_artista`),
  UNIQUE INDEX `id_fan_UNIQUE` (`id_seguidors_artista` ASC) VISIBLE,
  CONSTRAINT `usuari_seg_id`
    FOREIGN KEY (`usuari_id`)
    REFERENCES `spotify`.`usuaris` (`id_usuari`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `artista_seg_id`
    FOREIGN KEY (`artista_id`)
    REFERENCES `spotify`.`artistes` (`id_artista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`Cançons_favorites`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`Cançons_favorites` (
  `id_canço_favorita` INT NOT NULL AUTO_INCREMENT,
  `canço_id` INT NOT NULL,
  `usuari_id` INT NOT NULL,
  PRIMARY KEY (`id_canço_favorita`),
  UNIQUE INDEX `id_canço_favorita_UNIQUE` (`id_canço_favorita` ASC) VISIBLE,
  CONSTRAINT `canço_fav_id`
    FOREIGN KEY (`canço_id`)
    REFERENCES `spotify`.`cançons` (`id_canço`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `usuari_fav_id`
    FOREIGN KEY (`usuari_id`)
    REFERENCES `spotify`.`usuaris` (`id_usuari`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`Albums_favorits`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`Albums_favorits` (
  `id_album_favorit` INT NOT NULL AUTO_INCREMENT,
  `usuari_id` INT NOT NULL,
  `album_id` INT NOT NULL,
  PRIMARY KEY (`id_album_favorit`),
  UNIQUE INDEX `id_album_favorit_UNIQUE` (`id_album_favorit` ASC) VISIBLE,
  CONSTRAINT `usuari_alb_fav_id`
    FOREIGN KEY (`usuari_id`)
    REFERENCES `spotify`.`usuaris` (`id_usuari`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `album_fav_id`
    FOREIGN KEY (`album_id`)
    REFERENCES `spotify`.`Album` (`id_album`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
