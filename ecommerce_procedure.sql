delimiter %

create procedure edit_produto(indice int,
							  v_pNome varchar(40), 
                              v_marca varchar(20),
                              v_categoria varchar(20),
                              v_valor float,
							  v_avaliacao float,
                              v_idProduto int)
begin

case 
	when indice = 1 then
						insert into produto (pNome, marca, categoria, valor, avaliacao)
							values
							(v_pNome, v_marca, v_categoria, v_valor, v_avaliacao);
	
    when indice = 2 then
						update produto set pNome = v_pNome,
										   marca = v_marca,
                                           categoria = v_categoria,
                                           valor = v_valor,
                                           avaliacao = v_avaliacao where idProduto = v_idProduto;
                                           
	
    when indice = 3 then 
						delete from produto where idProduto = v_idProduto;
	end case;

select * from produto;

end %
delimiter ;

		-- TESTANDO A PROCEDURE

-- Inserindo - Indice(ação), pNome, marca, categoria, valor, avaliacao, id
call edit_produto(1, 'Calça', 'Levis', 'Vestuario', 350, 4, null);

-- atualizando um produto
call edit_produto(2, 'Calça', 'Lacoste', 'Vestuario', 450, 5, 7);

-- deletando um produto
call edit_produto(3, null, null, null, null, null, 7);

