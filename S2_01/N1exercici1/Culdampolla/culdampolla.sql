-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema culdampolla
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema culdampolla
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `culdampolla` DEFAULT CHARACTER SET utf8 ;
USE `culdampolla` ;

-- -----------------------------------------------------
-- Table `culdampolla`.`proveidor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `culdampolla`.`proveidor` (
  `idproveidor` INT NOT NULL AUTO_INCREMENT,
  `Nom` TEXT NULL,
  `Carrer` VARCHAR(150) NULL,
  `Numero` INT(11) NULL,
  `Pis` VARCHAR(3) NULL,
  `Porta` VARCHAR(3) NULL,
  `Ciutat` VARCHAR(150) NULL,
  `Codi_Postal` INT(10) NULL,
  `Pais` TEXT NULL,
  `Telefon` INT(20) NULL,
  `Fax` INT(20) NULL,
  `NIF` TEXT NULL,
  PRIMARY KEY (`idproveidor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `culdampolla`.`cristal_dret`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `culdampolla`.`cristal_dret` (
  `id_cristal_dret` INT NOT NULL AUTO_INCREMENT,
  `color` VARCHAR(15) NULL,
  `graduacio` VARCHAR(15) NULL,
  `preu` INT(11) NULL,
  PRIMARY KEY (`id_cristal_dret`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `culdampolla`.`montura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `culdampolla`.`montura` (
  `id_montura` INT(11) NOT NULL AUTO_INCREMENT,
  `color` VARCHAR(15) NULL,
  `tipus` ENUM('FLOTANT', 'PASTA', 'METAL·LICA') NULL,
  `preu` INT(11) NULL,
  PRIMARY KEY (`id_montura`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `culdampolla`.`cristal_esq`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `culdampolla`.`cristal_esq` (
  `id_cristal_esq` INT(11) NOT NULL AUTO_INCREMENT,
  `color` VARCHAR(15) NULL,
  `graduacio` VARCHAR(15) NULL,
  `preu` INT(11) NULL,
  PRIMARY KEY (`id_cristal_esq`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `culdampolla`.`ulleres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `culdampolla`.`ulleres` (
  `id_ulleres` INT NOT NULL AUTO_INCREMENT,
  `marca` TEXT NULL,
  `preu_total` INT(11) NULL,
  `proveidor_id` INT(11) NULL,
  `cristal_dret_id` INT(11) NULL,
  `cristal_esq_id` INT(11) NULL,
  `montura_id` INT(11) NULL,
  PRIMARY KEY (`id_ulleres`),
  INDEX `proveidor_id_idx` (`proveidor_id` ASC) VISIBLE,
  INDEX `cristal_dret_id_idx` (`cristal_dret_id` ASC) VISIBLE,
  INDEX `montura_id_idx` (`montura_id` ASC) VISIBLE,
  INDEX `cristal_esq_id_idx` (`cristal_esq_id` ASC) VISIBLE,
  CONSTRAINT `proveidor_id`
    FOREIGN KEY (`proveidor_id`)
    REFERENCES `culdampolla`.`proveidor` (`idproveidor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `cristal_dret_id`
    FOREIGN KEY (`cristal_dret_id`)
    REFERENCES `culdampolla`.`cristal_dret` (`id_cristal_dret`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `montura_id`
    FOREIGN KEY (`montura_id`)
    REFERENCES `culdampolla`.`montura` (`id_montura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `cristal_esq_id`
    FOREIGN KEY (`cristal_esq_id`)
    REFERENCES `culdampolla`.`cristal_esq` (`id_cristal_esq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `culdampolla`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `culdampolla`.`client` (
  `id_client` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` TEXT NULL,
  `codi_postal` TEXT NULL,
  `Telefon` INT(10) NULL,
  `e-mail` VARCHAR(45) NULL,
  `data_registre` DATE NULL,
  `client_nou` TINYINT(1) NULL,
  `recomanador_id` INT(11) NULL,
  PRIMARY KEY (`id_client`),
  INDEX `recomanador_id_idx` (`recomanador_id` ASC) VISIBLE,
  CONSTRAINT `recomanador_id`
    FOREIGN KEY (`recomanador_id`)
    REFERENCES `culdampolla`.`client` (`id_client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `culdampolla`.`empleat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `culdampolla`.`empleat` (
  `id_empleat` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` TEXT NULL,
  PRIMARY KEY (`id_empleat`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `culdampolla`.`factura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `culdampolla`.`factura` (
  `id_factura` INT(11) NOT NULL AUTO_INCREMENT,
  `usuari_id` INT(11) NULL,
  `ulleres_id` INT(11) NULL,
  `preu` INT(11) NULL,
  `empleat_id` INT(11) NULL,
  PRIMARY KEY (`id_factura`),
  INDEX `usuari_id_idx` (`usuari_id` ASC) VISIBLE,
  INDEX `ulleres_id_idx` (`ulleres_id` ASC) VISIBLE,
  INDEX `empleat_id_idx` (`empleat_id` ASC) VISIBLE,
  CONSTRAINT `usuari_id`
    FOREIGN KEY (`usuari_id`)
    REFERENCES `culdampolla`.`client` (`id_client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ulleres_id`
    FOREIGN KEY (`ulleres_id`)
    REFERENCES `culdampolla`.`ulleres` (`id_ulleres`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `empleat_id`
    FOREIGN KEY (`empleat_id`)
    REFERENCES `culdampolla`.`empleat` (`id_empleat`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
