-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Employee` (
  `idEmployee` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NULL,
  `Type` VARCHAR(45) NULL,
  `Phone` VARCHAR(45) NULL,
  `Email` VARCHAR(45) NULL,
  PRIMARY KEY (`idEmployee`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Salary`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Salary` (
  `idSalary` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `idEmployee` INT NOT NULL,
  `Base_Salary` VARCHAR(45) NULL,
  `PF` VARCHAR(45) NULL,
  `DA` VARCHAR(45) NULL,
  `Special_Allowance` VARCHAR(45) NULL,
  PRIMARY KEY (`idSalary`),
  CONSTRAINT `idEmployee_Salary`
    FOREIGN KEY (`idSalary`)
    REFERENCES `mydb`.`Employee` (`idEmployee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Leaves`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Leaves` (
  `idLeaves` INT UNSIGNED NOT NULL,
  `Paid_Leaves` VARCHAR(45) NULL,
  `Earned_Leaves` VARCHAR(45) NULL,
  `Sick_Leaves` VARCHAR(45) NULL,
  `Vacations` VARCHAR(45) NULL,
  `idEmployee` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idLeaves`),
  INDEX `idEmployee_idx` (`idEmployee` ASC) VISIBLE,
  CONSTRAINT `idEmployee_leaves`
    FOREIGN KEY (`idEmployee`)
    REFERENCES `mydb`.`Employee` (`idEmployee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Entitlements`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Entitlements` (
  `idEntitlements` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `idEmployee` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEntitlements`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;