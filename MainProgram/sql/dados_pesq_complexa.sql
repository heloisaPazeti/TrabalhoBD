BEGIN;

-- 1) Agências de fomento (CNPJ no formato válido, ABRANGENCIA e PUBLICA)
INSERT INTO AG_FOMENTO (cnpj, nome, abrangencia, publica) VALUES
('11111111/0001-01', 'FAPESP', 'NACIONAL', 'S'),
('22222222/0001-02', 'CNPq',   'NACIONAL', 'S'),
('33333333/0001-03', 'CAPES',  'NACIONAL', 'S');

-- 2) Universidades (para usar em EXECUCAO.cnpj)
INSERT INTO UNIVERSIDADE (cnpj, nome, campus, uf, cidade, bairro, numero) VALUES
('44444444/0001-44', 'Universidade X', 'Campus A', 'SP', 'Sao Paulo', 'Centro', 100);

-- 3) Pesquisas (OBS: DESCRICAO é NOT NULL)
INSERT INTO PESQUISA (data_criacao, titulo, area, descricao) VALUES
('2020-01-01', 'COVID-Estudo1', 'Virologia', 'Estudo sobre SARS-CoV-2 - amostras iniciais'),
('2020-02-01', 'COVID-Estudo2', 'Virologia', 'Segunda fase sem execucao'),
('2020-03-01', 'Oncologia-Geracao1', 'Saude', 'Estudo piloto oncologia'),
('2020-04-01', 'Neuro-Memoria', 'Neuro', 'Estudo sobre memoria e envelhecimento'),
('2020-05-01', 'Metabolismo-Avancado', 'Fisiologia', 'Estudo metabolic avancado; sem execucao');

-- 4) Financiamentos (ordem de colunas: CNPJ, DATA_CRIACAO, TITULO, AREA, VALOR)
INSERT INTO FINANCIA (cnpj, data_criacao, titulo, area, valor) VALUES
('11111111/0001-01','2020-01-01','COVID-Estudo1','Virologia',100000),
('11111111/0001-01','2020-02-01','COVID-Estudo2','Virologia',150000),
('22222222/0001-02','2020-03-01','Oncologia-Geracao1','Saude',200000),
('33333333/0001-03','2020-04-01','Neuro-Memoria','Neuro',180000),
('22222222/0001-02','2020-05-01','Metabolismo-Avancado','Fisiologia',230000);

-- 5) Estabelecimentos de Saude (CNES 7 dígitos, TELEFONE1 preenchido, FUNCAO válida)
INSERT INTO ESTAB_SAUDE (cnes, nome, telefone1, funcao) VALUES
('0000010','Hospital Central','11999990000','HOSPITAL/CLINICA'),
('0000011','Hospital Universitario','11988880000','HOSPITAL/CLINICA'),
('0000012','Clinica Zona Norte','11977770000','HOSPITAL/CLINICA'),
('0000013','Laboratorio Alfa','11966660000','LAB_EXT');

-- 6) Tornar esses estabelecimentos hospitais/clinica — insere ID buscando pelo CNES
INSERT INTO HOSPITAL_CLINICA (id)
SELECT id FROM ESTAB_SAUDE WHERE cnes IN ('0000010','0000011','0000012');

-- 7) Tipo de coleta necessário para AMOSTRA
INSERT INTO TIPO_COLETA (categoria, periculosidade) VALUES
('SANGUE','ALTA'),
('SALIVA','BAIXA'),
('URINA','BAIXA');

-- 8) Pessoas (pacientes e enfermeiro). CPF no formato xxx.xxx.xxx-xx
INSERT INTO PESSOA (cpf, nome, telefone1, data_nasc, senha) VALUES
('111.111.111-11','Paciente A','11990001111','1980-05-01','pwd1'),
('222.222.222-22','Paciente B','11990002222','1975-07-10','pwd2'),
('333.333.333-33','Enfermeiro X','11990003333','1990-02-20','pwd3');

-- 9) Criar PACIENTE a partir das PESSOA inseridas
INSERT INTO PACIENTE (id)
SELECT id FROM PESSOA WHERE cpf IN ('111.111.111-11','222.222.222-22');

-- 10) Criar ENFERMEIRO (usa pessoa existente). COREN deve respeitar CHECK (UF + espaço + 9 dígitos)
INSERT INTO ENFERMEIRO (id, coren)
SELECT id, 'SP 123456789' FROM PESSOA WHERE cpf = '333.333.333-33';

-- 11) Amostras (usa categoria em TIPO_COLETA; ID_PAC e ID_ENF obtidos via subqueries)
INSERT INTO AMOSTRA (categoria, data_coleta, id_pac, validade, info, estado, qtde, id_enf) VALUES
('SANGUE','2020-06-01', (SELECT id FROM PACIENTE WHERE id = (SELECT id FROM PESSOA WHERE cpf='111.111.111-11')), '2021-06-01', 'COVID A - col1', 'CONSERVADO', 1, (SELECT id FROM ENFERMEIRO WHERE id = (SELECT id FROM PESSOA WHERE cpf='333.333.333-33'))),
('SANGUE','2020-06-02', (SELECT id FROM PACIENTE WHERE id = (SELECT id FROM PESSOA WHERE cpf='111.111.111-11')), '2021-06-02', 'COVID B - col2', 'CONSERVADO', 1, (SELECT id FROM ENFERMEIRO WHERE id = (SELECT id FROM PESSOA WHERE cpf='333.333.333-33'))),
('SANGUE','2020-07-10', (SELECT id FROM PACIENTE WHERE id = (SELECT id FROM PESSOA WHERE cpf='222.222.222-22')), '2021-07-10', 'Oncologia A', 'CONSERVADO', 1, (SELECT id FROM ENFERMEIRO WHERE id = (SELECT id FROM PESSOA WHERE cpf='333.333.333-33'))),
('SALIVA','2020-08-15', (SELECT id FROM PACIENTE WHERE id = (SELECT id FROM PESSOA WHERE cpf='222.222.222-22')), '2021-08-15', 'Neuro A', 'CONSERVADO', 1, (SELECT id FROM ENFERMEIRO WHERE id = (SELECT id FROM PESSOA WHERE cpf='333.333.333-33'))),
('URINA','2020-09-01', (SELECT id FROM PACIENTE WHERE id = (SELECT id FROM PESSOA WHERE cpf='111.111.111-11')), '2021-09-01', 'Fisio A', 'CONSERVADO', 1, (SELECT id FROM ENFERMEIRO WHERE id = (SELECT id FROM PESSOA WHERE cpf='333.333.333-33'));

-- 12) Execucoes: para algumas pesquisas (obs: não criar execucao para COVID-Estudo2 e Metabolismo-Avancado para ativar "sem execução")
INSERT INTO EXECUCAO (data_criacao, titulo, area, cnpj, data_inicio, data_conclusao) VALUES
('2020-01-01','COVID-Estudo1','Virologia','44444444/0001-44','2020-06-01','2020-07-01'),
('2020-03-01','Oncologia-Geracao1','Saude','44444444/0001-44','2020-07-01','2020-08-01'),
('2020-04-01','Neuro-Memoria','Neuro','44444444/0001-44','2020-08-01','2020-09-01');

-- 13) Vincular amostras às execuções via EXEC_DISP_AMOSTRA
-- usamos subqueries para obter ids de AMOSTRA e EXECUCAO
INSERT INTO EXEC_DISP_AMOSTRA (id_amostra, id_exec, data_entrega, data_devol) VALUES
(
  (SELECT id FROM AMOSTRA WHERE info = 'COVID A - col1'),
  (SELECT id FROM EXECUCAO WHERE data_criacao='2020-01-01' AND titulo='COVID-Estudo1' AND area='Virologia'),
  '2020-06-05','2020-06-20'
),
(
  (SELECT id FROM AMOSTRA WHERE info = 'COVID B - col2'),
  (SELECT id FROM EXECUCAO WHERE data_criacao='2020-01-01' AND titulo='COVID-Estudo1' AND area='Virologia'),
  '2020-06-06','2020-06-21'
),
(
  (SELECT id FROM AMOSTRA WHERE info = 'Oncologia A'),
  (SELECT id FROM EXECUCAO WHERE data_criacao='2020-03-01' AND titulo='Oncologia-Geracao1' AND area='Saude'),
  '2020-07-10','2020-07-25'
),
(
  (SELECT id FROM AMOSTRA WHERE info = 'Neuro A'),
  (SELECT id FROM EXECUCAO WHERE data_criacao='2020-04-01' AND titulo='Neuro-Memoria' AND area='Neuro'),
  '2020-08-10','2020-08-20'
);

-- 14) Dados_amostra (liga amostra ao estabelecimento em que os dados foram gerados)
INSERT INTO DADOS_AMOSTRA (id_estab, data_proc, id_amostra, dados) VALUES
(
  (SELECT id FROM ESTAB_SAUDE WHERE cnes='0000010'),
  '2020-06-05',
  (SELECT id FROM AMOSTRA WHERE info = 'COVID A - col1'),
  'Processado em Hospital Central - batch1'
),
(
  (SELECT id FROM ESTAB_SAUDE WHERE cnes='0000010'),
  '2020-06-06',
  (SELECT id FROM AMOSTRA WHERE info = 'COVID B - col2'),
  'Processado em Hospital Central - batch2'
),
(
  (SELECT id FROM ESTAB_SAUDE WHERE cnes='0000011'),
  '2020-07-10',
  (SELECT id FROM AMOSTRA WHERE info = 'Oncologia A'),
  'Processado em Hospital Universitario'
),
(
  (SELECT id FROM ESTAB_SAUDE WHERE cnes='0000012'),
  '2020-08-10',
  (SELECT id FROM AMOSTRA WHERE info = 'Neuro A'),
  'Processado em Clinica Zona Norte'
);

-- 15) Disponibilizacao (liga dados_amostra <-> execucao). DATA_ENTREGA < DATA_DEVOL
INSERT INTO DISPONIBILIZACAO (id_exec, id_dados, data_entrega, data_devol) VALUES
(
  (SELECT id FROM EXECUCAO WHERE data_criacao='2020-01-01' AND titulo='COVID-Estudo1'),
  (SELECT id FROM DADOS_AMOSTRA WHERE dados LIKE 'Processado em Hospital Central - batch1'),
  '2020-06-07','2020-06-30'
),
(
  (SELECT id FROM EXECUCAO WHERE data_criacao='2020-01-01' AND titulo='COVID-Estudo1'),
  (SELECT id FROM DADOS_AMOSTRA WHERE dados LIKE 'Processado em Hospital Central - batch2'),
  '2020-06-08','2020-06-30'
),
(
  (SELECT id FROM EXECUCAO WHERE data_criacao='2020-03-01' AND titulo='Oncologia-Geracao1'),
  (SELECT id FROM DADOS_AMOSTRA WHERE dados LIKE 'Processado em Hospital Universitario'),
  '2020-07-15','2020-07-30'
),
(
  (SELECT id FROM EXECUCAO WHERE data_criacao='2020-04-01' AND titulo='Neuro-Memoria'),
  (SELECT id FROM DADOS_AMOSTRA WHERE dados LIKE 'Processado em Clinica Zona Norte'),
  '2020-08-12','2020-08-25'
);

COMMIT;
