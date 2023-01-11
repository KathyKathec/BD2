-- tabelas escolhidas: vendas e clientes
DELIMITER $$
Create PROCEDURE sp_insere_dados_cliente(IN c_id int, IN c_nome varchar(45),IN c_Email Varchar(45))
	BEGIN
    insert into vendas.cliente(id, nome, email) values (c_id, c_nome,c_Email);
     END $$
     
   
     
Create PROCEDURE sp_insere_dados_vendas(IN v_id int, IN v_data date,IN v_total decimal(10,2),
 in v_usu int, IN v_cli int)
	BEGIN
    insert into vendas.vendas(id, `data`, total_vendido, idUsuario, idCliente) values (v_id ,  v_data, v_total,
  v_usu ,  v_cli );
     END $$
          