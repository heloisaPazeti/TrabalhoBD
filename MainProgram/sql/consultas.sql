-- 1. SELECIONAR PARA UMA PESQUISA ESPECIFICA TODAS AS AMOSTRAS QUE AINDA NÃO FORAM DEVOLVIDAS
select A.* from PESQUISA P join EXECUCAO E on (E.titulo = P.titulo and E.area = P.area and E.data_criacao = P.data_criacao)
						   join DISPONIBILIZACAO D on E.id = D.id_exec
						   join DADOS_AMOSTRA DD on DD.id = D.id_dados
						   join AMOSTRA A on DD.id_amostra = A.id
where NOW()<D.data_devol AND P.titulo = {titulo} and P.area={area} AND P.data_criacao={data};

-- 2. RETORNAR AS 5 PESQUISAS QUE MAIS UTILIZARAM AMOSTRAS
select P.*, count(A.id) as total_amostras from PESQUISA P join EXECUCAO E on (E.titulo = P.titulo and E.area = P.area and E.data_criacao = P.data_criacao)
						   join DISPONIBILIZACAO D on E.id = D.id_exec
						   join DADOS_AMOSTRA DD on DD.id = D.id_dados
						   join AMOSTRA A on DD.id_amostra = A.id
group by P.data_criacao, P.tituLO, P.area , P.descricao
order by total_amostras desc limit 5;

-- 3. REUNIR TODAS AS AMOSTRAS DE TODOS OS PACIENTES NASCIDOS NUM MÊS ESPECIFICO
select A.* from AMOSTRA A join pessoa P on A.id_pac = P.id where EXTRACT(MONTH FROM p.data_nasc) = {mes};

-- 4. REUNIR TODAS AS EXECUÇÕES QUE RECEBE ACIMA DE UM VALOR ESPECÍFICO DA AG. DE FOMENTO
select E.*, COUNT(EX.ID) as total_exames from EXECUCAO E join PESQUISA P on (P.titulo = E.titulo and P.area = E.area and P.data_criacao = E.data_criacao)
						   join FINANCIA F on (P.titulo = F.titulo and P.area = F.area and P.data_criacao = F.data_criacao)
where F.valor > 2000;

-- 5. REUNIR TODAS AS PESQUISAS RELACIONADAS A UM TAL LABORATORIO QUE TEM PACIENTES RELACIONADOS A TODOS OS ESTADOS
select P.* from PESQUISA P join EXECUCAO E on (E.titulo = P.titulo and E.area = P.area and E.data_criacao = P.data_criacao)
						   join DISPONIBILIZACAO D on D.id_exec = E.id
						   join DADOS_AMOSTRA DA on DA.ID = D.id_dados
						   join AMOSTRA A on A.ID=DA.id_amostra
						   join PACIENTE Pa on A.id_pac = Pa.id
						   join Pessoa Pe on Pa.id=Pe.id,
						   join LAB_EXT LE on LE.ID = DA.id_estab
group by P.data_criacao, P.titulo, P.area, P.descricao having count(distinct Pe.uf)=27;
-- 6. DIVISÃO: RETORNAR TODAS AS UNIVERSIDADES QUE TEM VÍNCULO - PELA PESQUISA - COM TODAS AS AGÊNCIAS DE FOMENTO.
select U.* from UNIVERSIDADE U join EXECUCAO E on U.cnpj = E.cnpj
							   join FINANCIA F on (E.titulo = F.titulo and E.area = F.area and E.data_criacao = F.data_criacao)
							   join AG_FOMENTO A on A.CNPJ=F.CNPJ
group by U.CNPJ, U.NOME having COUNT(distinct F.CNPJ) = (select count(distinct cnpj) from ag_fomento);







--MIGASSSS
-- Pesquisas financiadas sem execução associada
SELECT 
    ag.nome,
    f.data_criacao,
    f.titulo,
    f.area,
    f.valor
FROM FINANCIA f
JOIN AG_FOMENTO ag 
      ON ag.cnpj = f.cnpj
LEFT JOIN EXECUCAO e
      ON e.data_criacao = f.data_criacao
     AND e.titulo       = f.titulo
     AND e.area         = f.area
WHERE e.id IS NULL
ORDER BY f.data_criacao;


-- Seleciona pesquisas com número de amostras acima da média geral
WITH pesquisa_amostras AS (
    SELECT
        p.id_pesquisa,
        COUNT(eda.id_amostra) AS total_amostras
    FROM PESQUISA p
    LEFT JOIN EXECUCAO e
           ON e.data_criacao = p.data_criacao
          AND e.titulo       = p.titulo
          AND e.area         = p.area
    LEFT JOIN EXEC_DISP_AMOSTRA eda
           ON eda.id_exec = e.id
    GROUP BY p.id_pesquisa
),
pesquisas_acima_da_media AS (
    SELECT pa.id_pesquisa
    FROM pesquisa_amostras pa
    WHERE pa.total_amostras > (SELECT AVG(total_amostras) FROM pesquisa_amostras)
)
SELECT id_pesquisa
FROM pesquisas_acima_da_media

EXCEPT

SELECT DISTINCT p.id_pesquisa
FROM PESQUISA p
JOIN AMOSTRA a ON a.id_pesquisa = p.id_pesquisa
JOIN EXECUCAO e ON e.id_amostra = a.id_amostra
ORDER BY id_pesquisa;


--- Hospitais que receberam amostras de todas as pesquisas financiadas por uma agência específica
WITH pesquisas_agencia AS (
    SELECT id_pesquisa
    FROM PESQUISA
    WHERE id_agencia = 2
),
hospitais_que_receberam AS (
    SELECT DISTINCT id_hospital, id_pesquisa
    FROM AMOSTRA
)
SELECT h.id_hospital
FROM HOSPITAL h
WHERE NOT EXISTS (
    SELECT 1
    FROM pesquisas_agencia pa
    WHERE NOT EXISTS (
        SELECT 1
        FROM hospitais_que_receberam hq
        WHERE hq.id_hospital = h.id_hospital
          AND hq.id_pesquisa = pa.id_pesquisa
    )
);


-- Agências que financiam pesquisas executadas em hospitais onde nenhuma outra agência tem pesquisas
WITH hospital_agencias AS (
    SELECT DISTINCT
        est.id        AS hospital_id,
        f.cnpj        AS agencia_cnpj
    FROM HOSPITAL_CLINICA h
    JOIN ESTAB_SAUDE est ON est.id = h.id
    JOIN DADOS_AMOSTRA da ON da.id_estab = est.id
    JOIN DISPONIBILIZACAO dis ON dis.id_dados = da.id
    JOIN EXECUCAO e ON e.id = dis.id_exec
    JOIN FINANCIA f
      ON f.data_criacao = e.data_criacao
     AND f.titulo       = e.titulo
     AND f.area         = e.area
),
hospitais_unica_agencia AS (
    SELECT hospital_id
    FROM hospital_agencias
    GROUP BY hospital_id
    HAVING COUNT(DISTINCT agencia_cnpj) = 1
)
SELECT DISTINCT ha.agencia_cnpj AS cnpj, ag.nome
FROM hospital_agencias ha
JOIN hospitais_unica_agencia hua ON hua.hospital_id = ha.hospital_id
JOIN AG_FOMENTO ag ON ag.cnpj = ha.agencia_cnpj
ORDER BY ag.nome;


-- Hospitais que receberam amostras ligadas a pesquisas financiadas por >1 agência
SELECT 
    est.nome AS nome_hospital,
    COUNT(DISTINCT f.cnpj) AS n_agencias_distintas
FROM HOSPITAL_CLINICA h
JOIN ESTAB_SAUDE est ON est.id = h.id
JOIN DADOS_AMOSTRA da ON da.id_estab = est.id
JOIN DISPONIBILIZACAO dis ON dis.id_dados = da.id
JOIN EXECUCAO e ON e.id = dis.id_exec
JOIN FINANCIA f
  ON f.data_criacao = e.data_criacao
 AND f.titulo       = e.titulo
 AND f.area         = e.area
GROUP BY est.nome
HAVING COUNT(DISTINCT f.cnpj) > 1
ORDER BY n_agencias_distintas DESC, est.nome;
