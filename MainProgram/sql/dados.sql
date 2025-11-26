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




