
-- Q1
CREATE OR REPLACE VIEW vw_modalidades_custo_estimado AS
SELECT
    modalidades.nome,
    modalidades.sala,
    planos.nome AS plano,
    planos.valor_mensal_base * 1.10 AS valor_ajustado
FROM modalidades
JOIN planos ON modalidades.plano_id = planos.id;


-- Q2
CREATE OR REPLACE VIEW vw_matriculas_ativas AS
SELECT
    alunos.nome AS aluno,
    alunos.cpf,
    modalidades.nome AS modalidade,
    modalidades.sala,
    itens_matricula.duracao_meses,
    matriculas.data_inicio
FROM matriculas
JOIN alunos ON matriculas.aluno_id = alunos.id
JOIN itens_matricula ON matriculas.id = itens_matricula.matricula_id
JOIN modalidades ON itens_matricula.modalidade_id = modalidades.id
WHERE matriculas.status = 'Ativa';


-- Q3
CREATE OR REPLACE VIEW vw_alunos_vip AS
SELECT
    alunos.nome,
    COUNT(DISTINCT matriculas.id) AS quantidade_contratos,
    SUM(itens_matricula.valor_mensal_aplicado * itens_matricula.duracao_meses + itens_matricula.taxa_adesao) AS valor_total
FROM alunos
JOIN matriculas ON alunos.id = matriculas.aluno_id
JOIN itens_matricula ON matriculas.id = itens_matricula.matricula_id
WHERE matriculas.status = 'Ativa'
GROUP BY alunos.id, alunos.nome
HAVING SUM(itens_matricula.valor_mensal_aplicado * itens_matricula.duracao_meses + itens_matricula.taxa_adesao) > 1000;


-- Q4
SELECT
    modalidades.nome,
    modalidades.sala,
    modalidades.capacidade_maxima,
    planos.nome AS plano,
    planos.valor_mensal_base
FROM modalidades
JOIN planos ON modalidades.plano_id = planos.id
WHERE modalidades.capacidade_maxima >= 15
AND planos.valor_mensal_base > 100
AND modalidades.disponivel = TRUE;


-- Q5
CREATE OR REPLACE VIEW vw_faturamento_medio_plano AS
SELECT
    planos.nome AS plano,
    SUM(itens_matricula.valor_mensal_aplicado * itens_matricula.duracao_meses + itens_matricula.taxa_adesao) AS faturamento_total,
    AVG(itens_matricula.duracao_meses) AS media_meses
FROM planos
JOIN modalidades ON planos.id = modalidades.plano_id
JOIN itens_matricula ON modalidades.id = itens_matricula.modalidade_id
JOIN matriculas ON itens_matricula.matricula_id = matriculas.id
WHERE matriculas.status = 'Ativa'
GROUP BY planos.nome;


-- SELECTS
SELECT * FROM vw_modalidades_custo_estimado;
SELECT * FROM vw_matriculas_ativas;
SELECT * FROM vw_alunos_vip;
SELECT * FROM vw_faturamento_medio_plano;
