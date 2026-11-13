
CREATE TABLE alunos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    cpf VARCHAR(11) UNIQUE NOT NULL CHECK (LENGTH(cpf) = 11),
    telefone VARCHAR(20) NOT NULL,
    data_cadastro TIMESTAMP NOT NULL DEFAULT NOW()
);


CREATE TABLE planos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(60) NOT NULL UNIQUE,
    valor_mensal_base NUMERIC(10,2) CHECK (valor_mensal_base > 0) NOT NULL
);


CREATE TABLE modalidades (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    plano_id INTEGER NOT NULL,
    sala VARCHAR(50) NOT NULL,
    capacidade_maxima INTEGER NOT NULL,
    disponivel BOOLEAN DEFAULT TRUE,

    FOREIGN KEY (plano_id) REFERENCES planos(id), CHECK (capacidade_maxima > 0)
);


CREATE TABLE matriculas (
    id SERIAL PRIMARY KEY,
    aluno_id INTEGER NOT NULL,
    data_inicio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'Ativa' NOT NULL,
    FOREIGN KEY (aluno_id) REFERENCES alunos(id),
    CHECK (status IN ('Ativa', 'Cancelada', 'Trancada'))
);


CREATE TABLE itens_matricula (
    id SERIAL PRIMARY KEY,
    matricula_id INTEGER NOT NULL REFERENCES matriculas(id),
    modalidade_id INTEGER NOT NULL REFERENCES modalidades(id),
    duracao_meses INTEGER NOT NULL CHECK (duracao_meses > 0),
    valor_mensal_aplicado NUMERIC(10,2) NOT NULL,
    taxa_adesao NUMERIC(10,2) DEFAULT 0.00,

    CHECK (valor_mensal_aplicado > 0),
    CHECK (taxa_adesao >= 0)
);
