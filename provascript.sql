#Atividade 1

#CRIAÇÃO DO BANCO DE DADOS

#Fiz o Modelo Relacional e depois usei Forward Engineer para passar em codigo

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
-- Table `mydb`.`Status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Status` (
  `idStatus` INT NOT NULL AUTO_INCREMENT,
  `Descricao` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`idStatus`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Mesa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Mesa` (
  `idMesa` INT NOT NULL AUTO_INCREMENT,
  `Numero` INT NOT NULL,
  `idStatusMes` INT NOT NULL,
  PRIMARY KEY (`idMesa`),
  INDEX `idStatusMes_idx` (`idStatusMes` ASC) VISIBLE,
  CONSTRAINT `idStatusMes`
    FOREIGN KEY (`idStatusMes`)
    REFERENCES `mydb`.`Status` (`idStatus`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Produto` (
  `idProduto` INT NOT NULL AUTO_INCREMENT,
  `Codigo` VARCHAR(50) NOT NULL,
  `Descricao` VARCHAR(255) NOT NULL,
  `PrecoUni` DECIMAL(10,2) NOT NULL,
  `QuantidadeEstoque` INT NOT NULL,
  `EstoqueMin` INT NOT NULL,
  `Marca` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idProduto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pedido` (
  `idPedido` INT NOT NULL,
  `idMesaPed` INT NOT NULL,
  `idClientePed` INT NOT NULL,
  `DataPedido` DATETIME NOT NULL,
  PRIMARY KEY (`idPedido`),
  INDEX `idMesaFK_idx` (`idMesaPed` ASC) VISIBLE,
  INDEX `idClienteFK_idx` (`idClientePed` ASC) VISIBLE,
  CONSTRAINT `idMesaPed`
    FOREIGN KEY (`idMesaPed`)
    REFERENCES `mydb`.`Mesa` (`idMesa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idClientePed`
    FOREIGN KEY (`idClientePed`)
    REFERENCES `mydb`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ItemPedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ItemPedido` (
  `idItemPedido` INT NOT NULL AUTO_INCREMENT,
  `idPedidoItePed` INT NOT NULL,
  `idProdutoItPed` INT NOT NULL,
  `Quantidade` INT NOT NULL,
  `PrecoTotal` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`idItemPedido`),
  INDEX `idPedidoItPed_idx` (`idPedidoItePed` ASC) VISIBLE,
  INDEX `idProdutoItPed_idx` (`idProdutoItPed` ASC) VISIBLE,
  CONSTRAINT `idPedidoItePed`
    FOREIGN KEY (`idPedidoItePed`)
    REFERENCES `mydb`.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idProdutoItePed`
    FOREIGN KEY (`idProdutoItPed`)
    REFERENCES `mydb`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`FormaPagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`FormaPagamento` (
  `idFormaPagamento` INT NOT NULL AUTO_INCREMENT,
  `Descricao` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`idFormaPagamento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Fechamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Fechamento` (
  `idFechamento` INT NOT NULL AUTO_INCREMENT,
  `idMesaFec` INT NOT NULL,
  `idClienteFec` INT NOT NULL,
  `idForPagamentoFec` INT NOT NULL,
  `ValorTotal` DECIMAL(10,2) NOT NULL,
  `DataPagamento` DATETIME NOT NULL,
  PRIMARY KEY (`idFechamento`),
  INDEX `idMesaFec_idx` (`idMesaFec` ASC) VISIBLE,
  INDEX `idClienteFec_idx` (`idClienteFec` ASC) VISIBLE,
  INDEX `idPagamentoFec_idx` (`idForPagamentoFec` ASC) VISIBLE,
  CONSTRAINT `idMesaFec`
    FOREIGN KEY (`idMesaFec`)
    REFERENCES `mydb`.`Mesa` (`idMesa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idClienteFec`
    FOREIGN KEY (`idClienteFec`)
    REFERENCES `mydb`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idForPagamentoFec`
    FOREIGN KEY (`idForPagamentoFec`)
    REFERENCES `mydb`.`FormaPagamento` (`idFormaPagamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Funcionario` (
  `idFuncionario` INT NOT NULL AUTO_INCREMENT,
  `NomeFun` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`idFuncionario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`MesaFuncionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`MesaFuncionario` (
  `idMesaFuncionario` INT NOT NULL,
  `idMesaMesFun` INT NOT NULL,
  `IdFuncionarioMesFun` INT NOT NULL,
  PRIMARY KEY (`idMesaFuncionario`),
  INDEX `idMesaMesFun_idx` (`idMesaMesFun` ASC) VISIBLE,
  INDEX `idFuncionarioMesFun_idx` (`IdFuncionarioMesFun` ASC) VISIBLE,
  CONSTRAINT `idMesaMesFun`
    FOREIGN KEY (`idMesaMesFun`)
    REFERENCES `mydb`.`Mesa` (`idMesa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idFuncionarioMesFun`
    FOREIGN KEY (`IdFuncionarioMesFun`)
    REFERENCES `mydb`.`Funcionario` (`idFuncionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

#INSERTS DO BANCO

#Insers feitos com o intuito de testar os codigos de consulta e procedure

-- Tabela Status
INSERT INTO Status (Descricao) VALUES ('Livre');
INSERT INTO Status (Descricao) VALUES ('Ocupada');
INSERT INTO Status (Descricao) VALUES ('Sobremesa');
INSERT INTO Status (Descricao) VALUES ('Ocupada-Ociosa');

-- Tabela Mesa
INSERT INTO Mesa (Numero, idStatusMes) VALUES (1, 1); -- Livre
INSERT INTO Mesa (Numero, idStatusMes) VALUES (2, 2); -- Ocupada
INSERT INTO Mesa (Numero, idStatusMes) VALUES (3, 3); -- Sobremesa
INSERT INTO Mesa (Numero, idStatusMes) VALUES (4, 4); -- Ocupada-Ociosa

-- Tabela Cliente
INSERT INTO Cliente (Nome) VALUES ('Ana Silva');
INSERT INTO Cliente (Nome) VALUES ('Carlos Pereira');
INSERT INTO Cliente (Nome) VALUES ('Beatriz Santos');
INSERT INTO Cliente (Nome) VALUES ('Rafael Costa');

-- Tabela Produto
INSERT INTO Produto (Codigo, Descricao, PrecoUni, QuantidadeEstoque, EstoqueMin, Marca) 
VALUES ('P001', 'Coca-Cola 350ml', 5.00, 100, 10, 'Coca-Cola');
INSERT INTO Produto (Codigo, Descricao, PrecoUni, QuantidadeEstoque, EstoqueMin, Marca) 
VALUES ('P002', 'Pizza Marguerita', 25.00, 20, 5, 'Pizzaria Top');
INSERT INTO Produto (Codigo, Descricao, PrecoUni, QuantidadeEstoque, EstoqueMin, Marca) 
VALUES ('P003', 'Hambúrguer Duplo', 18.50, 30, 8, 'Burger Master');
INSERT INTO Produto (Codigo, Descricao, PrecoUni, QuantidadeEstoque, EstoqueMin, Marca) 
VALUES ('P004', 'Batata Frita Média', 8.00, 50, 10, 'Fry Lovers');

-- Tabela Pedido
INSERT INTO Pedido (idPedido, idMesaPed, idClientePed, DataPedido) VALUES (1, 1, 1, '2024-11-25 12:00:00');
INSERT INTO Pedido (idPedido, idMesaPed, idClientePed, DataPedido) VALUES (2, 2, 2, '2024-11-25 13:00:00');
INSERT INTO Pedido (idPedido, idMesaPed, idClientePed, DataPedido) VALUES (3, 3, 3, '2024-11-25 14:00:00');
INSERT INTO Pedido (idPedido, idMesaPed, idClientePed, DataPedido) VALUES (4, 4, 4, '2024-11-25 15:00:00');

-- Tabela ItemPedido
INSERT INTO ItemPedido (idPedidoItePed, idProdutoItPed, Quantidade, PrecoTotal) 
VALUES (1, 1, 2, 10.00); -- 2 Coca-Colas
INSERT INTO ItemPedido (idPedidoItePed, idProdutoItPed, Quantidade, PrecoTotal) 
VALUES (2, 2, 1, 25.00); -- 1 Pizza
INSERT INTO ItemPedido (idPedidoItePed, idProdutoItPed, Quantidade, PrecoTotal) 
VALUES (3, 3, 1, 18.50); -- 1 Hambúrguer
INSERT INTO ItemPedido (idPedidoItePed, idProdutoItPed, Quantidade, PrecoTotal) 
VALUES (4, 4, 3, 24.00); -- 3 Batatas Fritas

-- Tabela FormaPagamento
INSERT INTO FormaPagamento (Descricao) VALUES ('Dinheiro');
INSERT INTO FormaPagamento (Descricao) VALUES ('Cartão de Crédito');
INSERT INTO FormaPagamento (Descricao) VALUES ('Cartão de Débito');
INSERT INTO FormaPagamento (Descricao) VALUES ('Pix');

-- Tabela Fechamento
INSERT INTO Fechamento (idMesaFec, idClienteFec, idForPagamentoFec, ValorTotal, DataPagamento) 
VALUES (1, 1, 1, 10.00, '2024-11-25 12:30:00'); -- Dinheiro
INSERT INTO Fechamento (idMesaFec, idClienteFec, idForPagamentoFec, ValorTotal, DataPagamento) 
VALUES (2, 2, 2, 25.00, '2024-11-25 13:30:00'); -- Crédito
INSERT INTO Fechamento (idMesaFec, idClienteFec, idForPagamentoFec, ValorTotal, DataPagamento) 
VALUES (3, 3, 3, 18.50, '2024-11-25 14:30:00'); -- Débito
INSERT INTO Fechamento (idMesaFec, idClienteFec, idForPagamentoFec, ValorTotal, DataPagamento) 
VALUES (4, 4, 4, 24.00, '2024-11-25 15:30:00'); -- Pix

-- Tabela Funcionario
INSERT INTO Funcionario (NomeFun) VALUES ('João Almeida');
INSERT INTO Funcionario (NomeFun) VALUES ('Maria Fernanda');
INSERT INTO Funcionario (NomeFun) VALUES ('Lucas Andrade');
INSERT INTO Funcionario (NomeFun) VALUES ('Sofia Oliveira');

-- Tabela MesaFuncionario
INSERT INTO MesaFuncionario (idMesaFuncionario, idMesaMesFun, IdFuncionarioMesFun) VALUES (1, 1, 1);
INSERT INTO MesaFuncionario (idMesaFuncionario, idMesaMesFun, IdFuncionarioMesFun) VALUES (2, 2, 2);
INSERT INTO MesaFuncionario (idMesaFuncionario, idMesaMesFun, IdFuncionarioMesFun) VALUES (3, 3, 3);
INSERT INTO MesaFuncionario (idMesaFuncionario, idMesaMesFun, IdFuncionarioMesFun) VALUES (4, 4, 4);

#Atividade 2

#CONSULTAS E PROCEDURES

#Letra A 
SELECT Funcionario.NomeFun, Mesa.Numero, SUM(Fechamento.ValorTotal) 
FROM MesaFuncionario 
INNER JOIN Funcionario  
ON MesaFuncionario.IdFuncionarioMesFun = Funcionario.idFuncionario
INNER JOIN Mesa  
ON MesaFuncionario.idMesaMesFun = Mesa.idMesa
INNER JOIN Fechamento  
ON Fechamento.idMesaFec = Mesa.idMesa
GROUP BY Funcionario.NomeFun, Mesa.Numero;

#Letra B
SELECT Produto.Descricao , ItemPedido.Quantidade, ItemPedido.PrecoTotal 
FROM ItemPedido 
INNER JOIN Produto 
ON ItemPedido.idProdutoItPed = Produto.idProduto
INNER JOIN Pedido 
ON ItemPedido.idPedidoItePed = Pedido.idPedido
INNER JOIN Mesa 
ON Pedido.idMesaPed = Mesa.idMesa
WHERE Mesa.Numero = 1;

#Letra C 
DELIMITER //
CREATE PROCEDURE AtualizarMesa(IN AtualMesa INT)
BEGIN
	UPDATE Mesa
    SET Mesa.idStatusMes = 1
    WHERE Mesa.Numero = AtualMesa;
END //
DELIMITER ;