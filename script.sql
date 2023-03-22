-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema control_tiendas
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `control_tiendas` ;

-- -----------------------------------------------------
-- Schema control_tiendas
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `control_tiendas` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `control_tiendas` ;

-- -----------------------------------------------------
-- Table `control_tiendas`.`devoluciones`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `control_tiendas`.`devoluciones` ;

CREATE TABLE IF NOT EXISTS `control_tiendas`.`devoluciones` (
  `Id` INT NOT NULL,
  `CodigoTienda` INT NOT NULL,
  `Fecha` DATE NOT NULL,
  `Total` DECIMAL(20,2) NOT NULL,
  `Estado` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `control_tiendas`.`envios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `control_tiendas`.`envios` ;

CREATE TABLE IF NOT EXISTS `control_tiendas`.`envios` (
  `Id` INT NOT NULL,
  `CodigoTienda` INT NOT NULL,
  `PedidoVinculado` INT NOT NULL,
  `Usuario` VARCHAR(45) NULL DEFAULT NULL,
  `FechaSalida` DATE NULL DEFAULT NULL,
  `FechaRecibida` DATE NULL DEFAULT NULL,
  `Total` DECIMAL(20,0) NOT NULL,
  `Estado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `control_tiendas`.`incidencias`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `control_tiendas`.`incidencias` ;

CREATE TABLE IF NOT EXISTS `control_tiendas`.`incidencias` (
  `Id` INT NOT NULL,
  `CodigoTienda` INT NOT NULL,
  `Fecha` DATE NOT NULL,
  `Estado` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `control_tiendas`.`listadeproductosdeiyd`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `control_tiendas`.`listadeproductosdeiyd` ;

CREATE TABLE IF NOT EXISTS `control_tiendas`.`listadeproductosdeiyd` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `IdDelSolicitante` INT NOT NULL,
  `CodigoDelProducto` INT NOT NULL,
  `Costo` DECIMAL(20,2) NOT NULL,
  `Cantidad` INT NOT NULL,
  `CostoTotal` DECIMAL(20,2) NOT NULL,
  `Motivo` VARCHAR(100) NOT NULL,
  `EsIncidencia` TINYINT NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `control_tiendas`.`listadeproductosenvios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `control_tiendas`.`listadeproductosenvios` ;

CREATE TABLE IF NOT EXISTS `control_tiendas`.`listadeproductosenvios` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `CodigoDelEnvio` INT NOT NULL,
  `CodigoDelProducto` INT NOT NULL,
  `Cantidad` INT NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB
AUTO_INCREMENT = 60
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `control_tiendas`.`listadeproductospedidos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `control_tiendas`.`listadeproductospedidos` ;

CREATE TABLE IF NOT EXISTS `control_tiendas`.`listadeproductospedidos` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `IdDelSolicitante` INT NOT NULL,
  `CodigoDelProducto` INT NOT NULL,
  `Cantidad` INT NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 94
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `control_tiendas`.`pedidos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `control_tiendas`.`pedidos` ;

CREATE TABLE IF NOT EXISTS `control_tiendas`.`pedidos` (
  `Id` INT NOT NULL,
  `CodigoTienda` INT NOT NULL,
  `Usuario` VARCHAR(45) NOT NULL,
  `Fecha` DATE NOT NULL,
  `Total` DECIMAL(20,2) NOT NULL,
  `Estado` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `control_tiendas`.`productos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `control_tiendas`.`productos` ;

CREATE TABLE IF NOT EXISTS `control_tiendas`.`productos` (
  `Codigo` INT NOT NULL,
  `Nombre` VARCHAR(45) NOT NULL,
  `Costo` DECIMAL(20,2) NOT NULL,
  `Precio` DECIMAL(20,2) NOT NULL,
  `Existencias` INT NOT NULL,
  PRIMARY KEY (`Codigo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `control_tiendas`.`tienda`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `control_tiendas`.`tienda` ;

CREATE TABLE IF NOT EXISTS `control_tiendas`.`tienda` (
  `Codigo` INT NOT NULL,
  `Nombre` VARCHAR(100) NOT NULL,
  `Direccion` VARCHAR(45) NOT NULL,
  `Tipo` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`Codigo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `control_tiendas`.`productosdecadatienda`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `control_tiendas`.`productosdecadatienda` ;

CREATE TABLE IF NOT EXISTS `control_tiendas`.`productosdecadatienda` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `CodigoDeTienda` INT NOT NULL,
  `CodigoDeProducto` INT NOT NULL,
  `Existencias` INT NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `CodigoDeProducto`
    FOREIGN KEY (`CodigoDeProducto`)
    REFERENCES `control_tiendas`.`productos` (`Codigo`),
  CONSTRAINT `CodigoDeTienda`
    FOREIGN KEY (`CodigoDeTienda`)
    REFERENCES `control_tiendas`.`tienda` (`Codigo`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `CodigoDeTienda_idx` ON `control_tiendas`.`productosdecadatienda` (`CodigoDeTienda` ASC) VISIBLE;

CREATE INDEX `CodigoDeProducto_idx` ON `control_tiendas`.`productosdecadatienda` (`CodigoDeProducto` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `control_tiendas`.`usuarios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `control_tiendas`.`usuarios` ;

CREATE TABLE IF NOT EXISTS `control_tiendas`.`usuarios` (
  `Codigo` INT NOT NULL,
  `Nombre` VARCHAR(45) NOT NULL,
  `UserName` VARCHAR(30) NOT NULL,
  `Password` VARCHAR(500) NOT NULL,
  `Email` VARCHAR(50) NULL DEFAULT NULL,
  `Tipo` VARCHAR(10) NOT NULL,
  `CodigoDeTienda` INT NULL DEFAULT NULL,
  PRIMARY KEY (`Codigo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `control_tiendas`.`tiendasdeusuariosdebodega`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `control_tiendas`.`tiendasdeusuariosdebodega` ;

CREATE TABLE IF NOT EXISTS `control_tiendas`.`tiendasdeusuariosdebodega` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `CodigoDeEncargado` INT NOT NULL,
  `CodigoDeTienda` INT NOT NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `CodigoTienda`
    FOREIGN KEY (`CodigoDeTienda`)
    REFERENCES `control_tiendas`.`tienda` (`Codigo`),
  CONSTRAINT `IDEncargado`
    FOREIGN KEY (`CodigoDeEncargado`)
    REFERENCES `control_tiendas`.`usuarios` (`Codigo`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `CodigoDeEncargado_idx` ON `control_tiendas`.`tiendasdeusuariosdebodega` (`CodigoDeEncargado` ASC) VISIBLE;

CREATE INDEX `CodigoDeTienda_idx` ON `control_tiendas`.`tiendasdeusuariosdebodega` (`CodigoDeTienda` ASC) VISIBLE;

CREATE INDEX `CodigoDeEncargado` ON `control_tiendas`.`tiendasdeusuariosdebodega` (`CodigoDeEncargado` ASC) VISIBLE;

CREATE INDEX `CodigoDeTienda` ON `control_tiendas`.`tiendasdeusuariosdebodega` (`CodigoDeTienda` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
