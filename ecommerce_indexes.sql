			-- INDEXES NA TABELA PRODUTO

-- ambos indexes foram criados por serem meio comuns de busca em sites de ecommerce: categoria, nome do produto e marca.

-- add index relacionado a categorias de produto via alter table
alter table produto add index index_categoria(categoria);

-- add index relacionado ao nome do produto via create index
create index index_nome on produto(pNome) using btree;

-- add index relacionado a marca via create index
create index index_marca on produto(marca) using btree;

-- add fulltext index de marca
create fulltext index fulltext_index on produto (marca);

-- add fulltext index com dua colunas
create fulltext index index_teste on produto (pNome, marca);

-- testando index com duas colunas
insert into produto (pNome, marca, categoria, valor, avaliacao) values ('Patinete', 'Specialized ultra', 'esportes', 7000, 5);
insert into produto (pNome, marca, categoria, valor, avaliacao) values ('Patins Specialized', 'Marca x', 'esportes', 4000, 4.5);

select * from produto;
		-- Essa query consulta em ambas colunas se existe a palavra 'Specialized'
		select pNome, marca from produto 
			where match (pNome, marca) against ('Specialized');


-- Utilizando o fulltext index
select * from produto where match (marca) against ('D*' in boolean mode);

select * from produto where match (marca) against ('Spe*' in boolean mode);

		-- Perguntas 
        
-- Em ordem crescente, qual é a marca que mais vende por quantidade
select pt.marca marca, sum(pp.quantidade) quantidade from pedido pd
	inner join produtopedido pp
    on pd.idPedido = pp.idPedido
    right join produto pt
    on pp.idProduto = pt.idProduto
    group by marca
    order by quantidade desc;
    
-- Lista dos produtos por ordem decrescende de valor
select pNome Produto, valor from produto
	order by valor desc;

-- Estoque da marca por ordem crescente para sabermos qual está acabando
select p.pnome Produto, sum(pe.QuantidadeEstoque) Quantidade from produto p
	inner join produtoestoque pe
    on p.idProduto = pe.idProduto
    group by Produto
    order by Quantidade;
    
-- Qual é o ticket médio de nossas vendas
select (sum(p.valor * pe.quantidade) / count(*)) ticket_medio from produto p
	inner join produtopedido pe
    on p.idProduto = pe.idProduto;
    -- 8555
    
    
