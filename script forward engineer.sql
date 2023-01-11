-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Vendas
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Vendas
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Vendas` DEFAULT CHARACTER SET utf8 ;
USE `Vendas` ;

-- -----------------------------------------------------
-- Table `Vendas`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Vendas`.`Usuario` (
  `idUsuario` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(50) NOT NULL,
  `Senha` VARCHAR(45) NOT NULL,
  `Login` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idUsuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Vendas`.`Acceso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Vendas`.`Acceso` (
  `idAcceso` INT NOT NULL AUTO_INCREMENT,
  `Acceso` DATETIME NOT NULL,
  `idUsuario` INT NOT NULL,
  PRIMARY KEY (`idAcceso`, `idUsuario`),
  INDEX `fk_Acceso_Usuario_idx` (`idUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_Acceso_Usuario`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `Vendas`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Vendas`.`Compras`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Vendas`.`Compras` (
  `idCompras` INT NOT NULL AUTO_INCREMENT,
  `Data_compra` DATE NOT NULL,
  `Descricao` NVARCHAR(120) NOT NULL,
  `idUsuario` INT NOT NULL,
  PRIMARY KEY (`idCompras`, `idUsuario`),
  INDEX `fk_Compras_Usuario1_idx` (`idUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_Compras_Usuario1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `Vendas`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Vendas`.`Fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Vendas`.`Fornecedor` (
  `idFornecedor` INT NOT NULL AUTO_INCREMENT,
  `Endereco` NVARCHAR(150) NOT NULL,
  `Nome` VARCHAR(50) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idFornecedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Vendas`.`Detalhe_Compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Vendas`.`Detalhe_Compra` (
  `Item` INT NOT NULL AUTO_INCREMENT,
  `idProduto` INT NOT NULL,
  `Preco_compra` DECIMAL(10,2) NOT NULL,
  `Desconto` DECIMAL(10,2) NULL,
  `Valor_total` DECIMAL(10,2) NOT NULL,
  `idCompras` INT NOT NULL,
  `idUsuario` INT NOT NULL,
  `Fornecedor_idFornecedor` INT NOT NULL,
  PRIMARY KEY (`idCompras`, `idUsuario`, `idProduto`, `Fornecedor_idFornecedor`),
  UNIQUE INDEX `Detalhe_Compracol_UNIQUE` (`Item` ASC) VISIBLE,
  INDEX `fk_Detalhe_Compra_Compras1_idx` (`idCompras` ASC, `idUsuario` ASC) VISIBLE,
  INDEX `fk_Detalhe_Compra_Fornecedor1_idx` (`Fornecedor_idFornecedor` ASC) VISIBLE,
  CONSTRAINT `fk_Detalhe_Compra_Compras1`
    FOREIGN KEY (`idCompras` , `idUsuario`)
    REFERENCES `Vendas`.`Compras` (`idCompras` , `idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Detalhe_Compra_Fornecedor1`
    FOREIGN KEY (`Fornecedor_idFornecedor`)
    REFERENCES `Vendas`.`Fornecedor` (`idFornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Vendas`.`Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Vendas`.`Produto` (
  `idProduto` INT NOT NULL AUTO_INCREMENT,
  `Nome_produto` NVARCHAR(50) NOT NULL,
  `Preco_produto` DECIMAL(10,2) NOT NULL,
  `Quantidade_Estoque` INT NOT NULL,
  `Compras_idCompras` INT NOT NULL,
  `Compras_idUsuario` INT NOT NULL,
  `Detalhe_Compra_idCompras` INT NOT NULL,
  `Detalhe_Compra_idUsuario` INT NOT NULL,
  `Detalhe_Compra_idForncedor` INT NOT NULL,
  `Detalhe_Compra_idProduto` INT NOT NULL,
  PRIMARY KEY (`idProduto`, `Compras_idCompras`, `Compras_idUsuario`, `Detalhe_Compra_idCompras`, `Detalhe_Compra_idUsuario`, `Detalhe_Compra_idForncedor`, `Detalhe_Compra_idProduto`),
  INDEX `fk_Produto_Detalhe_Compra1_idx` (`Detalhe_Compra_idCompras` ASC, `Detalhe_Compra_idUsuario` ASC, `Detalhe_Compra_idForncedor` ASC, `Detalhe_Compra_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_Detalhe_Compra1`
    FOREIGN KEY (`Detalhe_Compra_idCompras` , `Detalhe_Compra_idUsuario` , `Detalhe_Compra_idProduto`)
    REFERENCES `Vendas`.`Detalhe_Compra` (`idCompras` , `idUsuario` , `idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Vendas`.`Historico_preco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Vendas`.`Historico_preco` (
  `idHistorico_preco` INT NOT NULL AUTO_INCREMENT,
  `Valor` DECIMAL(10,2) NOT NULL,
  `Data_inicial` DATE NOT NULL,
  `Data_finaliza` DATE NOT NULL,
  `idProduto` INT NOT NULL,
  PRIMARY KEY (`idHistorico_preco`, `idProduto`),
  INDEX `fk_Historico_preco_Produto1_idx` (`idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Historico_preco_Produto1`
    FOREIGN KEY (`idProduto`)
    REFERENCES `Vendas`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Vendas`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Vendas`.`Cliente` (
  `idCliente` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Vendas`.`Vendas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Vendas`.`Vendas` (
  `idVendas` INT NOT NULL AUTO_INCREMENT,
  `Data` DATE NOT NULL,
  `Total_vendido` DECIMAL(10,2) NOT NULL,
  `Usuario_idUsuario` INT NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idVendas`, `Usuario_idUsuario`, `Cliente_idCliente`),
  INDEX `fk_Vendas_Usuario1_idx` (`Usuario_idUsuario` ASC) VISIBLE,
  INDEX `fk_Vendas_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Vendas_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `Vendas`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Vendas_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `Vendas`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Vendas`.`Detalhe_Venda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Vendas`.`Detalhe_Venda` (
  `Quantidade_comprada` DECIMAL(10,2) NOT NULL,
  `Preco_venda` DECIMAL(10,2) NOT NULL,
  `Desconto` DECIMAL(10,2) NULL,
  `Total_item` DECIMAL(10,2) NOT NULL,
  `Vendas_idVendas` INT NOT NULL,
  `Vendas_Usuario_idUsuario` INT NOT NULL,
  `Vendas_Cliente_idCliente` INT NOT NULL,
  `Produto_idProduto` INT NOT NULL,
  `Produto_Compras_idCompras` INT NOT NULL,
  `Produto_Compras_idUsuario` INT NOT NULL,
  `Produto_Detalhe_Compra_idCompras` INT NOT NULL,
  `Produto_Detalhe_Compra_idUsuario` INT NOT NULL,
  `Produto_Detalhe_Compra_idForncedor` INT NOT NULL,
  `Produto_Detalhe_Compra_idProduto` INT NOT NULL,
  `Item` INT NOT NULL,
  PRIMARY KEY (`Vendas_idVendas`, `Vendas_Usuario_idUsuario`, `Vendas_Cliente_idCliente`, `Produto_idProduto`, `Produto_Compras_idCompras`, `Produto_Compras_idUsuario`, `Produto_Detalhe_Compra_idCompras`, `Produto_Detalhe_Compra_idUsuario`, `Produto_Detalhe_Compra_idForncedor`, `Produto_Detalhe_Compra_idProduto`, `Item`),
  INDEX `fk_Detalhe_Venda_Vendas1_idx` (`Vendas_idVendas` ASC, `Vendas_Usuario_idUsuario` ASC, `Vendas_Cliente_idCliente` ASC) VISIBLE,
  INDEX `fk_Detalhe_Venda_Produto1_idx` (`Produto_idProduto` ASC, `Produto_Compras_idCompras` ASC, `Produto_Compras_idUsuario` ASC, `Produto_Detalhe_Compra_idCompras` ASC, `Produto_Detalhe_Compra_idUsuario` ASC, `Produto_Detalhe_Compra_idForncedor` ASC, `Produto_Detalhe_Compra_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Detalhe_Venda_Vendas1`
    FOREIGN KEY (`Vendas_idVendas` , `Vendas_Usuario_idUsuario` , `Vendas_Cliente_idCliente`)
    REFERENCES `Vendas`.`Vendas` (`idVendas` , `Usuario_idUsuario` , `Cliente_idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Detalhe_Venda_Produto1`
    FOREIGN KEY (`Produto_idProduto` , `Produto_Compras_idCompras` , `Produto_Compras_idUsuario` , `Produto_Detalhe_Compra_idCompras` , `Produto_Detalhe_Compra_idUsuario` , `Produto_Detalhe_Compra_idForncedor` , `Produto_Detalhe_Compra_idProduto`)
    REFERENCES `Vendas`.`Produto` (`idProduto` , `Compras_idCompras` , `Compras_idUsuario` , `Detalhe_Compra_idCompras` , `Detalhe_Compra_idUsuario` , `Detalhe_Compra_idForncedor` , `Detalhe_Compra_idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
