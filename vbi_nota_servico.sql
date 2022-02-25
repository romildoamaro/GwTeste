CREATE OR REPLACE VIEW vbi_nota_servico AS
SELECT 
s.id, 
s.especie, 
s.serie, 
s.numero, 
s.emissao_em, 
s.created_at, 
uc.nome AS sales_created_by, 
s.updated_at, 
uu.nome AS sales_updated_by, 
s.historico, 
f.abreviatura AS sales_filial_abreviatura, 
f.razaosocial AS sales_filial_razaosocial, 
formatcgc(f.cnpj) AS sales_filial_cnpj, 
c.cfop AS sales_cfop, 
consig.razaosocial AS sales_consignatario_razaosocial,
formatcgc(consig.cnpj) AS sales_consignatario_cnpj, 
s.observacao, 
s.is_cancelado, 
s.is_impresso, 
forn.razaosocial AS sales_vendedor_razaosocial,
formatcgc(forn.cpf_cnpj) AS sales_vendedor_cpf_cnpj,
CASE
WHEN s.categoria = 'ct' THEN 'Conhecimento'
WHEN s.categoria = 'ns' THEN 'Nota de Serviço'
WHEN s.categoria = 'fn' THEN 'Receita Financeira'
END AS categoria, 
a.abreviatura AS sales_agency_abreviatura,
s.xref_mastermaq,
s.comissao_vendedor,
s.last_updated, 
s.protocol_sync, 
s.pedido_cliente,
s.emissao_as, 
s.total_receita,
svs.numero AS sales_venda_subs_numero,
s.numero_rps, 
s.motivo_cancelamento,
CASE
WHEN s.tipo = 'n' THEN 'Normal'
WHEN s.tipo = 'l' THEN 'Entrega Local(Cobrança)'
WHEN s.tipo = 'b' THEN 'Cortesia'
WHEN s.tipo = 'i' THEN 'Diárias'
WHEN s.tipo = 'p' THEN 'Pallets'
WHEN s.tipo = 'c' THEN 'Complementar'
WHEN s.tipo = 'r' THEN 'Reentrega'
WHEN s.tipo = 'd' THEN 'Devolução'
WHEN s.tipo = 's' THEN 'Substituição'
WHEN s.tipo = 'a' THEN 'Anulação'
WHEN s.tipo = 't' THEN 'Substituído'
END AS tipo, 
s.numero_selo, 
cee.logradouro AS sales_endereco_entrega_logradouro,
cee.bairro AS sales_endereco_entrega_bairro,
ceee.cidade AS sales_endereco_entrega_cidade,
ceee.uf AS sales_endereco_entrega_uf, 
CASE
WHEN s.natureza_operacao = 0 THEN 'Não Informado'
WHEN s.natureza_operacao = 1 THEN 'Tributação no Município'
WHEN s.natureza_operacao = 2 THEN 'Tributação Fora do Município'
WHEN s.natureza_operacao = 3 THEN 'Isenção'
WHEN s.natureza_operacao = 4 THEN 'Imune'
WHEN s.natureza_operacao = 5 THEN 'Exigibilidade Suspensa por Decisão Judicial'
WHEN s.natureza_operacao = 6 THEN 'Exigibilidade Suspensa por Procedimento Administrativo'
END AS natureza_operacao, 
s.cancelado_em,
sva.numero AS sales_venda_aproveitada_numero,
cec.logradouro AS sales_endereco_coleta_logradouro,
cec.bairro AS sales_endereco_coleta_bairro,
ceec.cidade AS sales_endereco_coleta_cidade,
ceec.uf AS sales_endereco_coleta_uf,
ss.numero AS sales_ctrc_substituido_numero,
sa.numero AS ctrc_anulacao_numero, 
ov.numero AS sales_orcamento_numero,
s.valor_outros_custos_coleta, 
s.valor_outros_custos_entrega,
s.chave_rps_g2ka, 
s.is_ja_contabilizado, 
s.descricao_servico_nfse_g2ka, 
cpn.cidade AS sales_cidade_prestacao_nfse, 
cpn.uf AS sales_uf_prestacao_nfse, 
s.is_retirar_vinculo_cte_nfse,
ap.veiculo_apropriacao,

--Dados da Nota Fiscal

 array_to_string(nf.notas, ', ') as notas, array_to_string(nf.chave_acesso, ', ') as chave_acesso, nf.serie_notas[1] as serie_notas, array_to_string(nf.conteudo_notas, ', ') as conteudo_notas,
 nf.agendamento_notas[1] as agendamento_nota, nf.pedidos_notas[1] as pedidos_notas,
 (nf.emissao_notas[1])::date as emissao_nota ,
 COALESCE(nf.tot_volume::numeric(15,4),0) AS volume_notas,
 COALESCE(nf.tot_valor::numeric(15,2),0) AS valor_notas,
 COALESCE(nf.tot_peso::numeric(15,3),0) AS peso_notas,

--DESCRIÇÃO DO SERVIÇO
array_to_string(ts.descricao_servico, ', ') as descricao_servico

FROM sales s
LEFT JOIN sales AS sa ON s.ctrc_anulacao_id = sa.id
LEFT JOIN sales AS ss ON s.ctrc_substituido_id = ss.id
LEFT JOIN sales AS sva ON s.venda_aproveitada_id = sva.id
LEFT JOIN sales AS svs ON s.venda_subs_id = svs.id
LEFT JOIN agencies AS a ON s.agency_id = a.id
LEFT JOIN cfop AS c ON s.cfop_id = c.idcfop
LEFT JOIN cidade AS cpn ON s.cidade_prestacao_nfse_id = cpn.idcidade
LEFT JOIN cliente AS consig ON s.consignatario_id = consig.idcliente
LEFT JOIN cliente_endereco_entrega AS cec ON s.endereco_coleta_id = cec.id
	LEFT JOIN cidade AS ceec ON cec.cidade_id = ceec.idcidade
LEFT JOIN cliente_endereco_entrega AS cee ON s.endereco_entrega_id = cee.id
	LEFT JOIN cidade AS ceee ON cee.cidade_id = ceee.idcidade
LEFT JOIN usuario AS uc ON s.created_by = uc.idusuario
LEFT JOIN usuario AS uu ON s.updated_by = uu.idusuario
LEFT JOIN filial AS f ON s.filial_id = f.idfilial
LEFT JOIN orcamento_venda AS ov ON s.orcamento_id = ov.id
LEFT JOIN fornecedor AS forn ON s.vendedor_id = forn.idfornecedor
LEFT JOIN (SELECT ap.sale_id ,string_agg(distinct v.placa, ',') AS veiculo_apropriacao 
		FROM appropriations ap 
		LEFT JOIN veiculo v ON v.idveiculo = ap.veiculo_id
		GROUP BY ap.sale_id) AS ap ON (ap.sale_id = s.id)
LEFT JOIN (SELECT nf.idconhecimento
, array_agg(nf.numero::varchar ORDER BY nf.numero, ',') as notas
, array_agg(nf.chave_acesso::varchar ORDER BY nf.numero, ',') as chave_acesso
, array_agg(distinct nf.pedido::varchar) as pedidos_notas
, array_agg(distinct nf.serie::varchar) as serie_notas
, array_agg(distinct nf.conteudo::varchar) as conteudo_notas
, array_agg(distinct nf.emissao::varchar) as emissao_notas
, array_agg(distinct (coalesce(to_char(nf.data_agenda,'dd/MM/yyyy') || ' ' , '')  || COALESCE(nf.hora_agenda, ''))::varchar) as agendamento_notas
, sum(nf.volume) AS tot_volume, sum(nf.valor) AS tot_valor, sum(nf.peso) AS tot_peso
FROM nota_fiscal nf GROUP BY nf.idconhecimento ) nf on (nf.idconhecimento = s.id)
--SERVIÇOS
LEFT JOIN sale_services AS se ON se.sale_id = s.id
LEFT JOIN (SELECT ts.id
, array_agg(ts.descricao::varchar ORDER BY ts.descricao, ',') as descricao_servico
FROM type_services ts GROUP BY ts.id) ts on (ts.id = se.type_service_id)
