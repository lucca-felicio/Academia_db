INSERT INTO planos (nome, valor_mensal_base) VALUES
('Essencial', 89.90),
('Fit Total', 135.00),
('Performance', 190.00);


INSERT INTO alunos (nome, cpf, email, telefone) VALUES
('Lucas Martins', '12345678901', 'lucas.martins@gmail.com', '48991234567'),
('Carolina Souza', '23456789012', 'carol.souza@gmail.com', '48992345678'),
('Gabriel Oliveira', '34567890123', 'gabriel.oliveira@gmail.com', '48993456789');


INSERT INTO modalidades
(nome, plano_id, sala, capacidade_maxima, disponivel)
VALUES
('Musculacao', 2, 'Sala Principal', 25, TRUE),
('Pilates', 1, 'Studio 02', 12, TRUE),
('Cross Training', 3, 'Arena 01', 18, TRUE);


INSERT INTO matriculas (aluno_id, status) VALUES
(1, 'Ativa'),
(2, 'Ativa'),
(3, 'Cancelada'),
(1, 'Ativa');


INSERT INTO itens_matricula 
(matricula_id, modalidade_id, duracao_meses, valor_mensal_aplicado, taxa_adesao) VALUES
(1, 3, 12, 190.00, 80.00),
(2, 1, 8, 135.00, 50.00),
(3, 2, 3, 89.90, 0.00),
(4, 1, 12, 135.00, 40.00);
