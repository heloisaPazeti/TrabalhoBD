-- INSERTS NA TABELA PESSOA

INSERT INTO pessoa (cpf, nome, uf, cidade, bairro, rua, numero, telefone1, telefone2, data_nasc, senha) VALUES
('12345678901', 'Ana Silva', 'SP', 'São Paulo', 'Centro', 'Rua A', '100', '11987654321', NULL, '1990-05-12', 'senha123'),
('23456789012', 'Bruno Santos', 'RJ', 'Rio de Janeiro', 'Copacabana', 'Rua B', '200', '21998765432', '21912345678', '1988-11-03', 'abc123'),
('34567890123', 'Carla Ferreira', 'MG', 'Belo Horizonte', 'Savassi', 'Rua C', '150', '31987651234', NULL, '1995-02-20', 'pass001'),
('45678901234', 'Daniel Oliveira', 'RS', 'Porto Alegre', 'Moinhos', 'Rua D', '300', '51992341234', NULL, '1983-07-18', 'senha321'),
('56789012345', 'Eduarda Costa', 'SC', 'Florianópolis', 'Trindade', 'Rua E', '50', '48991234567', '48999887766', '1999-10-10', 'minhasenha'),
('67890123456', 'Felipe Rocha', 'PR', 'Curitiba', 'Centro', 'Rua F', '90', '41988776655', NULL, '1992-03-08', 'teste123'),
('78901234567', 'Gabriela Lima', 'BA', 'Salvador', 'Barra', 'Rua G', '77', '71987654321', NULL, '1987-01-14', 'senha456'),
('89012345678', 'Henrique Castro', 'PE', 'Recife', 'Boa Viagem', 'Rua H', '300', '81991234567', '81991112222', '1994-06-25', 'pass777'),
('90123456789', 'Isabela Souza', 'CE', 'Fortaleza', 'Meireles', 'Rua I', '122', '85992341234', NULL, '1990-08-30', 'key123'),
('01234567890', 'João Mendes', 'PA', 'Belém', 'Nazaré', 'Rua J', '210', '91999887766', NULL, '1985-12-05', 'senhaabc'),
('11122233344', 'Karen Pereira', 'GO', 'Goiânia', 'Setor Oeste', 'Rua K', '88', '62998776655', NULL, '1993-09-15', 'teste789'),
('22233344455', 'Leonardo Braga', 'MT', 'Cuiabá', 'Centro Sul', 'Rua L', '65', '65991234567', NULL, '1988-04-02', 'login123'),
('33344455566', 'Mariana Duarte', 'MS', 'Campo Grande', 'Vilas Boas', 'Rua M', '132', '67992341234', '67999887766', '1997-07-22', 'senha987'),
('44455566677', 'Nicolas Silva', 'PI', 'Teresina', 'Horto', 'Rua N', '41', '86988776655', NULL, '1991-11-11', 'abc456'),
('55566677788', 'Olivia Martins', 'MA', 'São Luís', 'Renascença', 'Rua O', '300', '98991234567', NULL, '1996-03-19', 'pass222'),
('66677788899', 'Paulo Teixeira', 'TO', 'Palmas', 'Plano Diretor', 'Rua P', '500', '63992347654', NULL, '1984-08-01', 'senha000'),
('77788899900', 'Queila Andrade', 'AL', 'Maceió', 'Ponta Verde', 'Rua Q', '55', '82988776655', NULL, '1998-01-17', 'qwerty'),
('88899900011', 'Rafael Barbosa', 'RO', 'Porto Velho', 'Embratel', 'Rua R', '17', '69991234567', NULL, '1989-05-29', 'abcabc'),
('99900011122', 'Sara Nogueira', 'RR', 'Boa Vista', 'Centro', 'Rua S', '12', '95988771234', '95991112222', '1995-10-08', 'senha880'),
('11223344556', 'Thiago Farias', 'AC', 'Rio Branco', 'Bosque', 'Rua T', '78', '68992347654', NULL, '1993-02-14', 'pass555');

-- INSERTS NA TABELA FUNCOES

INSERT INTO funcoes (id, funcao) VALUES
(1, 'ENERMEIRO'), (4, 'ENERMEIRO'), (5, 'ENERMEIRO'), (6, 'ENERMEIRO'), (7, 'ENERMEIRO'),
(8, 'MEDICO'), (9, 'MEDICO'), (10, 'MEDICO'), (11, 'MEDICO'), (12, 'MEDICO'), (13, 'MEDICO'), (14, 'MEDICO'),
(15, 'PACIENTE'), (16, 'PACIENTE'), (17, 'PACIENTE'), (18, 'PACIENTE'), (19, 'PACIENTE'), (20, 'PACIENTE'),
(21, 'PESQUISADOR'), (22, 'PESQUISADOR'), (23, 'PESQUISADOR'), (24, 'PESQUISADOR'), (25, 'PESQUISADOR'), (26, 'PESQUISADOR'), (27, 'PESQUISADOR');


-- INSERTS NA TABELA MEDICO

INSERT INTO medico (id, crm) VALUES
(8,  '12345 SP'),
(9,  '54321 RJ'),
(10, '11223 MG'),
(11, '99887 BA'),
(12, '111111 RS'),
(13, '22222 SC'),
(14, '7 PR');


-- INSERTS NA TABELA ENFERMEIRO

INSERT INTO enfermeiro (id, coren) VALUES
(1, 'SP 123456789'),
(4, 'BA 444555666'),
(5, 'RS 777888999'),
(6, 'SC 000111222'),
(7, 'PR 333444555');


-- INSERTS NA TABELA PESQUISADOR

INSERT INTO pesquisador (id, funcao) VALUES
(21, 'PESQUISADOR RESPONSÁVEL'),
(22, 'PESQUISADOR RESPONSÁVEL'),
(23, 'PESQUISADOR RESPONSÁVEL'),
(24, 'PESQUISADOR COMUM'),
(25, 'PESQUISADOR COMUM'),
(26, 'PESQUISADOR COMUM'),
(27, 'PESQUISADOR COMUM');


-- INSERTS NA TABELA PESQUISADOR COMUM

INSERT INTO pesquisador_comum (id) VALUES
(24),
(25),
(26),
(27);

-- INSERTS NA TABELA PESQUISADOR RESPONSAVEL

INSERT INTO pesquisador_responsavel (id) VALUES
(21),
(22),
(23);

-- INSERTS NA TABELA PACIENTES

INSERT INTO paciente (id) VALUES
(15),
(16),
(17),
(18),
(19),
(20);


-- INSERTAS NA TABELA DOENCAS

INSERT INTO doenca (id, doenca) VALUES
(15, 'Hipertensão'),
(15, 'Diabetes Tipo 2'),
(16, 'Asma'),
(17, 'Enxaqueca Crônica'),
(18, 'Artrite Reumatoide'),
(19, 'Distúrbio do Sono'),
(20, 'Alergia a Poeira');


-- INSERTS NA TABELA UNIVERSIDADES

INSERT INTO universidade (cnpj, nome, campus, uf, cidade, bairro, numero) VALUES
('12345678/0001-90', 'Universidade Aurora', 'Campus Central', 'SP', 'São Paulo', 'Vila Mariana', '1200'),
('23456789/0001-01', 'Instituto Tecnológico do Horizonte', 'Campus Leste', 'MG', 'Belo Horizonte', 'Savassi', '450'),
('34567890/0001-12', 'Universidade Vale Verde', 'Campus Norte', 'RS', 'Porto Alegre', 'Centro Histórico', '0089'),
('45678901/0001-23', 'Centro Acadêmico Solaris', 'Campus Alfa', 'RJ', 'Rio de Janeiro', 'Botafogo', '0702'),
('56789012/0001-34', 'Universidade do Litoral', 'Campus Praia', 'SC', 'Florianópolis', 'Trindade', '0301'),
('67890123/0001-45', 'Instituto Nacional de Pesquisas Aplicadas', 'Campus Tecnológico', 'PR', 'Curitiba', 'Batel', '0155'),
('78901234/0001-56', 'Universidade Monte Azul', 'Campus Serra', 'BA', 'Salvador', 'Barra', '0210'),
('89012345/0001-67', 'Faculdade Horizonte Aberto', 'Campus Delta', 'PE', 'Recife', 'Boa Viagem', '0980');


-- INSERTS NA TABELA AG DE FOMENTO

INSERT INTO ag_fomento (cnpj, nome, abrangencia, publica) VALUES
('11223344/0001-00', 'Fundação Nacional de Pesquisa', 'Nacional', 'S'),
('22334455/0001-11', 'Agência de Inovação do Sul', 'Regional', 'S'),
('33445566/0001-22', 'Instituto Privado de Fomento Científico', 'Nacional', 'N'),
('44556677/0001-33', 'Fundo de Desenvolvimento Tecnológico', 'Estadual', 'S'),
('55667788/0001-44', 'Agência Horizonte de Fomento', 'Local', 'N'),
('66778899/0001-55', 'Instituto Internacional de Pesquisa', 'Internacional', 'N'),
('77889900/0001-66', 'Agência Brasil de Apoio Científico', 'Nacional', 'S'),
('88990011/0001-77', 'Centro de Fomento à Inovação', 'Regional', 'S')
('11111111/0001-01', 'CNPq', 'Nacional', 'S'),
('22222222/0001-02', 'CAPES', 'Nacional', 'S'),
('33333333/0001-03', 'FAPESP', 'Estadual', 'S');


-- INSERTS NA TABELA EST_SAUDE

INSERT INTO estab_saude (cnes, nome, uf, cidade, bairro, rua, numero, telefone1, telefone2, funcao) VALUES
('0000001', 'Hospital Santa Luzia', 'SP', 'São Paulo', 'Vila Mariana', 'Rua das Acácias', '120', '551199900001', '551199900002', 'HOSPITAL/CLINICA'),
('0000002', 'Clínica Esperança',     'RJ', 'Rio de Janeiro', 'Botafogo', 'Av. Atlântica',     '702', '552199900003', NULL,                  'HOSPITAL/CLINICA'),
('0000003', 'Hospital do Coração',   'MG', 'Belo Horizonte', 'Savassi', 'R. da Bahia',      '450', '553199900004', '553199900005', 'HOSPITAL/CLINICA'),
('0000004', 'LabEx - Laboratório Ext', 'SP', 'São Paulo', 'Centro', 'R. Direita',       '10',  '551199900006', NULL,                  'LAB_EXT');

-- INSERTS NA TABELA HOSPITAL/CLINICA
INSERT INTO hospital_clinica (id) VALUES (1), (2), (3);

-- INSERTS NA TABELA LAB_EXT
INSERT INTO lab_ext (id) VALUES (4);

-- INSERTS NA TABELA MED-HOSP
INSERT INTO med_hosp (id_med, id_hosp) VALUES
(8, 1),
(9, 1),
(10, 2),
(11, 2),
(12, 3),
(13, 3),
(14, 1);

-- INSERTS NA TABELA SOLICITA DADOS
INSERT INTO solicita_dados (id_hosp, id_pesq, situacao, descricao) VALUES
(1, 21, 'PENDENTE',  'Solicitação de amostras de sangue para estudo X'),
(2, 22, 'APROVADO',  'Solicitação de exames para pesquisa sobre Zika'),
(3, 23, 'RECUSADO',  'Pedido de dados demográficos - falta documentação');

-- INSERTS NA TABELA PESQUISA
INSERT INTO pesquisa (data_criacao, titulo, area, descricao) VALUES
('2024-03-01', 'Estudo Biomarcadores COVID', 'Infectologia', 'Avaliar biomarcadores associados à gravidade da COVID-19'),
('2024-06-15', 'Projeto Hipertensão Comunitária', 'Cardiologia', 'Intervenção comunitária para controle pressórico');

-- INSERTS NA TABELA EXECUCAO
INSERT INTO execucao (data_criacao, titulo, area, cnpj, data_inicio, data_conclusao) VALUES
('2024-03-01', 'Estudo Biomarcadores COVID', 'Infectologia', '12345678/0001-90', '2024-04-01', '2024-12-31'),
('2024-06-15', 'Projeto Hipertensão Comunitária', 'Cardiologia', '23456789/0001-01', '2024-07-01', '2025-06-30');

-- INSERTS NA TABELA PESQ_EXEC
INSERT INTO pesq_exec (id_pesq, id_exec, data_ingresso, data_saida) VALUES
(24, 1, '2024-04-01', NULL),
(25, 1, '2024-05-01', '2024-10-01'),
(26, 2, '2024-07-01', NULL),
(27, 2, '2024-08-01', '2025-01-15');


-- INSERTS NA TABELA FINANCIA
INSERT INTO financia (cnpj, data_criacao, titulo, area, valor) VALUES
('33333333/0001-03', '2024-03-01', 'Estudo Biomarcadores COVID', 'Infectologia', 150000.00),
('11111111/0001-01', '2024-06-15', 'Projeto Hipertensão Comunitária', 'Cardiologia',  80000.00);

-- INSERTS NA TABELA MED_EXEC
-- associando alguns médicos (8..14) às execuções (1 e 2)
INSERT INTO med_exec (id_med, id_exec) VALUES
(8, 1),
(9, 1),
(12, 2),
(13, 2);

-- INSERTS NA TABELA TIPO DE COLETA
INSERT INTO tipo_coleta (categoria, periculosidade) VALUES
('Sangue', 'ALTA'),
('Saliva', 'BAIXA');

-- INSERTS NA  TABELA AMOSTRA
INSERT INTO amostra (categoria, data_coleta, id_pac, validade, info, estado, qtde, id_enf) VALUES
('Sangue', '2024-05-10', 15, '2024-05-20', 'Amostra rotulada A', 'CONSERVADO', 1, 1),
('Sangue', '2024-06-01', 16, '2024-06-11', 'Amostra rotulada B', 'CONSERVADO', 2, 1),
('Saliva','2024-07-12', 17, '2024-07-22', 'Amostra rotulada C', 'ALTERADO', 1, 1);

-- INSERTS NA TABELA DADOS_AMOSTRAS
INSERT INTO dados_amostra (id_estab, data_proc, id_amostra, dados) VALUES
(1, '2024-05-11', 1001, 'Resultado preliminar A'),
(2, '2024-06-02', 1002, 'Resultado preliminar B');

-- INSERTS NA TABELA DISPONIBILIZACAO
INSERT INTO disponibilizacao (id_exec, id_dados, data_entrega, data_devol) VALUES
(1, 1, '2024-05-12', '2024-06-12'),
(1, 2, '2024-06-05', '2024-07-05');

-- INSERTS NA TABELA TIPO_EXAME
INSERT INTO tipo_exame (categoria, periculosidade) VALUES
('Hemograma', 'BAIXA'),
('PCR','ALTA');

-- INSERTS NA TABELA EXAME
INSERT INTO exame (categoria, data_proc, id_pac, resultado, id_med) VALUES
('Hemograma', '2024-05-11', 15, 'Normal', 8),
('PCR',      '2024-05-11', 15, 'Negativo', 9);

-- INSERTS NA TABELA EXEEC_DISP_EXAME
INSERT INTO exec_disp_exame (id_exame, id_exec, data_entrega, data_devol) VALUES
(1, 1, '2024-05-12', '2024-06-12'),
(2, 1, '2024-05-13', '2024-06-13');



