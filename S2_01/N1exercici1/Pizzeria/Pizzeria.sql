-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8 ;
USE `pizzeria` ;

-- -----------------------------------------------------
-- Table `pizzeria`.`Clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`Clients` (
  `id_client` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(20) NULL,
  `cognoms` VARCHAR(45) NULL,
  `adreça` VARCHAR(145) NULL,
  `codi_postal` VARCHAR(5) NULL,
  `localitat` VARCHAR(25) NULL,
  `provincia` VARCHAR(10) NULL,
  `telefon` VARCHAR(20) NULL,
  PRIMARY KEY (`id_client`),
  INDEX `id_client` (`id_client` ASC) VISIBLE,
  UNIQUE INDEX `id_client_UNIQUE` (`id_client` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`Botiga`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`Botiga` (
  `id_botiga` INT NOT NULL AUTO_INCREMENT,
  `adreça` VARCHAR(145) NULL,
  `codi_postal` VARCHAR(5) NULL,
  `localitat` VARCHAR(25) NULL,
  `provincia` VARCHAR(10) NULL,
  PRIMARY KEY (`id_botiga`),
  INDEX `id_botiga` (`id_botiga` ASC) VISIBLE,
  UNIQUE INDEX `id_botiga_UNIQUE` (`id_botiga` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`Empleats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`Empleats` (
  `id_empleat` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(20) NULL,
  `cognoms` VARCHAR(45) NULL,
  `nif` VARCHAR(10) NULL,
  `telefon` VARCHAR(20) NULL,
  `botiga_id` INT NOT NULL,
  `tipus` ENUM('CUINER', 'REPARTIDOR') NOT NULL,
  PRIMARY KEY (`id_empleat`),
  INDEX `id_empleat` (`id_empleat` ASC) VISIBLE,
  INDEX `botigue_id_idx` (`botiga_id` ASC) VISIBLE,
  UNIQUE INDEX `id_empleat_UNIQUE` (`id_empleat` ASC) VISIBLE,
  CONSTRAINT `botigue_id`
    FOREIGN KEY (`botiga_id`)
    REFERENCES `pizzeria`.`Botiga` (`id_botiga`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`Comandes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`Comandes` (
  `id_comanda` INT NOT NULL AUTO_INCREMENT,
  `client_id` INT NOT NULL,
  `botiga_id` INT NOT NULL,
  `data_comanda` DATETIME NOT NULL,
  `preu_total` INT(4) NOT NULL,
  `tipus` ENUM('DOMICILI', 'RECOLLIR') NOT NULL,
  `empleat_id` INT NOT NULL,
  `data_lliurament` DATETIME NULL,
  PRIMARY KEY (`id_comanda`),
  INDEX `id_comanda` (`id_comanda` ASC) INVISIBLE,
  INDEX `botiga_id_idx` (`botiga_id` ASC) VISIBLE,
  UNIQUE INDEX `id_comanda_UNIQUE` (`id_comanda` ASC) VISIBLE,
  INDEX `empleat_id_idx` (`empleat_id` ASC) VISIBLE,
  CONSTRAINT `client_id`
    FOREIGN KEY (`client_id`)
    REFERENCES `pizzeria`.`Clients` (`id_client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `botiga_id`
    FOREIGN KEY (`botiga_id`)
    REFERENCES `pizzeria`.`Botiga` (`id_botiga`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `empleat_id`
    FOREIGN KEY (`empleat_id`)
    REFERENCES `pizzeria`.`Empleats` (`id_empleat`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`Categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`Categories` (
  `id_categoria` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) CHARACTER SET 'ascii' NULL,
  PRIMARY KEY (`id_categoria`),
  INDEX `id_categoria` (`id_categoria` ASC) INVISIBLE,
  UNIQUE INDEX `id_categoria_UNIQUE` (`id_categoria` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`Productes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`Productes` (
  `id_producte` INT NOT NULL AUTO_INCREMENT,
  `tipus` ENUM('PIZZA', 'HAMBURGUESA', 'BEGUDA') NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  `descripcio` LONGTEXT NULL,
  `imatge` LONGBLOB NULL,
  `preu` INT(4) NOT NULL,
  `categoria_id` INT NULL,
  PRIMARY KEY (`id_producte`),
  INDEX `id_producte` (`id_producte` ASC) INVISIBLE,
  UNIQUE INDEX `id_producte_UNIQUE` (`id_producte` ASC) VISIBLE,
  INDEX `categoria_id_idx` (`categoria_id` ASC) VISIBLE,
  CONSTRAINT `categoria_id`
    FOREIGN KEY (`categoria_id`)
    REFERENCES `pizzeria`.`Categories` (`id_categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`Quantitats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`Quantitats` (
  `id_quantitats` INT NOT NULL AUTO_INCREMENT,
  `comanda_id` INT NOT NULL,
  `producte_id` INT NOT NULL,
  `quantitat` INT(3) NOT NULL,
  PRIMARY KEY (`id_quantitats`),
  UNIQUE INDEX `id_quantitats_UNIQUE` (`id_quantitats` ASC) VISIBLE,
  INDEX `producte_id_idx` (`producte_id` ASC) VISIBLE,
  INDEX `comanda_id_idx` (`comanda_id` ASC) VISIBLE,
  CONSTRAINT `producte_id`
    FOREIGN KEY (`producte_id`)
    REFERENCES `pizzeria`.`Productes` (`id_producte`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `comanda_id`
    FOREIGN KEY (`comanda_id`)
    REFERENCES `pizzeria`.`Comandes` (`id_comanda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
