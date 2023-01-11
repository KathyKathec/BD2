	CREATE DATABASE vendas;
    
CREATE TABLE vendas.PRODUTO (
  ID           int        NOT NULL AUTO_INCREMENT,
  NOME_PRODUTO         VARCHAR(50)  NOT NULL,
  PRECO_COMPRA DECIMAL(10,2)  NOT NULL,
  PRECO_VENDA  DECIMAL(10,2)  NOT NULL,
  QUANTIDADE_ESTOQUE   INT  NOT NULL DEFAULT 0,
  CONSTRAINT PK_PRODUTO PRIMARY KEY (ID)
)ENGINE = InnoDB;

INSERT INTO VENDAS.PRODUTO VALUES(1,'Xiaomi',1200, 2000, 20);

CREATE TABLE Vendas.ACCESO (
  ID INT NOT NULL AUTO_INCREMENT,
  Acceso DATETIME NOT NULL,
  idUsuario INT NOT NULL,
  PRIMARY KEY (ID),
  CONSTRAINT fk_Usuario1
    FOREIGN KEY (idUsuario)
    REFERENCES Vendas.Usuario (ID)
    )
ENGINE = InnoDB;
CREATE TABLE ACCESO;
CREATE TABLE Vendas.Usuario (
  ID INT NOT NULL AUTO_INCREMENT,
  Nome_completo VARCHAR(50) NOT NULL,
  Senha VARCHAR(45) NOT NULL,
  Login VARCHAR(45) NOT NULL,
  cpf INT NOT NULL,
  PRIMARY KEY (ID))
ENGINE = InnoDB;

insert into vendas.usuario values(1, 'Pedro Antonio', 'xmlp12', 'PAntonio23',788772727);



CREATE TABLE Vendas.Cliente (
  ID INT NOT NULL,
  Nome VARCHAR(45) NOT NULL,
  Email VARCHAR(45) NOT NULL,
  PRIMARY KEY (ID))
ENGINE = InnoDB;

INSERT INTO vendas.CLIENTE VALUES(1, 'Sara','saraii@outlook.com');



CREATE TABLE vendas.COMPRAS (
  ID int NOT NULL AUTO_INCREMENT,
  DATA_COMPRA DATE  NOT NULL,
  DESCRICAO NVARCHAR(120)  NOT NULL,
	idFornecedor INT NOT NULL,
  idUsuario INT NOT NULL,
  Valor_total DECIMAL(10,2) NOT NULL,
  CONSTRAINT PK_COMPRAS
  PRIMARY KEY (ID),
  CONSTRAINT fk_Fornecedor
    FOREIGN KEY (idFornecedor)
    REFERENCES Vendas.FORNECEDOR (id),
 CONSTRAINT fk_Usuario
    FOREIGN KEY (idUsuario)
    REFERENCES Vendas.USUARIO (id)
)ENGINE = InnoDB;

INSERT INTO VENDAS.COMPRAS VALUES(1,'2022-06-05','Reposicao de verduras', 1, 1,300.00);

CREATE TABLE Vendas.Vendas (
  ID INT NOT NULL AUTO_INCREMENT,
  `Data` DATE NOT NULL,
  Total_vendido DECIMAL(10,2) NOT NULL,
  idUsuario INT NOT NULL,
  idCliente INT NOT NULL,
  PRIMARY KEY (ID),
  CONSTRAINT fk_Vendas_Cliente

    FOREIGN KEY (idCliente)
    REFERENCES VENDAS.CLIENTE (ID)
    )
ENGINE = InnoDB;

insert into vendas.vendas values(1,'2022-07-05',2000,1,1);
insert into vendas.vendas values(2,'2022-08-05',350,1,1);


CREATE TABLE Vendas.Historico_preco (
  ID INT NOT NULL AUTO_INCREMENT,
  Valor DECIMAL(10,2) NOT NULL,
  Data_inicial DATE NOT NULL,
  Data_finaliza DATE NOT NULL,
  idVendas INT NOT NULL,
  idUsuario INT NOT NULL,
  PRIMARY KEY (ID),
  CONSTRAINT fk_Historico_preco_Vendas
    FOREIGN KEY (idVendas , idUsuario)
    REFERENCES Vendas.Vendas (ID , idUsuario))
ENGINE = InnoDB;

CREATE TABLE Vendas.Fornecedor (
  ID INT NOT NULL AUTO_INCREMENT,
  Endereco NVARCHAR(150) NOT NULL,
  Nome VARCHAR(50) NOT NULL,
  Email VARCHAR(45) NOT NULL,
  PRIMARY KEY (ID))
ENGINE = InnoDB;

insert into vendas.fornecedor values(1, 'Av Laloli 432', 'VendeBem', 'vendebem@hotmail.com');

CREATE TABLE `Vendas`.`Detalhe_Compra` (
  Desconto INT NULL,
	idCompras INT NOT NULL,
  idFornecedor INT NOT NULL,
  idUsuario INT NOT NULL,
  idProduto INT NOT NULL,
  Quantidade_comprada INT NOT NULL,
  Preco_compra DECIMAL(10,2) NOT NULL,
  Item INT NOT NULL UNIQUE,
  PRIMARY KEY (idCompras, idFornecedor, idUsuario, idProduto),
  CONSTRAINT fk_Detalhe_Compra_Compras
    FOREIGN KEY (idCompras , idFornecedor , idUsuario)
    REFERENCES Vendas.Compras (ID , idFornecedor , idUsuario),
  CONSTRAINT fk_Detalhe_Compra_Produto
    FOREIGN KEY (idProduto)
    REFERENCES Vendas.Produto (ID))
ENGINE = InnoDB;

CREATE TABLE `Vendas`.`Detalhe_Venda` (
  `Quantidade_vendida` INT NOT NULL,
  `Preco_venda` DECIMAL(10,2) NOT NULL,
  `Desconto` DECIMAL(6,2) NULL,
  `Total` DECIMAL(10,2) NOT NULL,
  `Item` INT NOT NULL,
  `idProduto` INT NOT NULL,
  `idVendas` INT NOT NULL,
  `idUsuario` INT NOT NULL,
  PRIMARY KEY (idProduto, idVendas, idUsuario),
    FOREIGN KEY (`idProduto`)
    REFERENCES `Vendas`.`Produto` (`id`),
    FOREIGN KEY (`idVendas` , `idUsuario`)
    REFERENCES `Vendas`.`Vendas` (ID , idUsuario))
ENGINE = InnoDB;



