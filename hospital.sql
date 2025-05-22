CREATE DATABASE IF NOT EXISTS hospital;
USE hospital;

-- Tabela FUNCIONARIOS
CREATE TABLE FUNCIONARIOS (
    cpf VARCHAR(14) PRIMARY KEY,
    nome VARCHAR(100),
    telefone VARCHAR(20),
    email VARCHAR(100)
);

-- Tabela ATENDENTE
CREATE TABLE ATENDENTE (
    cod_atendente INT PRIMARY KEY AUTO_INCREMENT,
    cpf VARCHAR(14),
    FOREIGN KEY (cpf) REFERENCES FUNCIONARIOS(cpf)
);

-- Tabela MEDICO
CREATE TABLE MEDICO (
    cod_medico INT PRIMARY KEY AUTO_INCREMENT,
    cpf VARCHAR(14),
    crm VARCHAR(20),
    especializacao VARCHAR(100),
    FOREIGN KEY (cpf) REFERENCES FUNCIONARIOS(cpf)
);

-- Tabela ENFERMEIRO
CREATE TABLE ENFERMEIRO (
    cod_enfermeiro INT PRIMARY KEY AUTO_INCREMENT,
    cpf VARCHAR(14),
    coren VARCHAR(20),
    turno VARCHAR(20),
    setor VARCHAR(50),
    FOREIGN KEY (cpf) REFERENCES FUNCIONARIOS(cpf)
);

-- Tabela PACIENTE
CREATE TABLE PACIENTE (
    cod_paciente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    email VARCHAR(100),
    telefone VARCHAR(20),
    sexo ENUM('M', 'F', 'Outro'),
    idade INT,
    cpf VARCHAR(14),
    condicao TEXT,
    tipo_sanguineo VARCHAR(3)
);

-- Tabela REMEDIO
CREATE TABLE REMEDIO (
    nome VARCHAR(100) PRIMARY KEY
);

-- Relacionamento: consulta (PACIENTE <-> MEDICO)
CREATE TABLE CONSULTA (
    fk_PACIENTE_cod_paciente INT,
    fk_MEDICO_cod_medico INT,
    PRIMARY KEY (fk_PACIENTE_cod_paciente, fk_MEDICO_cod_medico),
    FOREIGN KEY (fk_PACIENTE_cod_paciente) REFERENCES PACIENTE(cod_paciente),
    FOREIGN KEY (fk_MEDICO_cod_medico) REFERENCES MEDICO(cod_medico)
);

-- Relacionamento: atende (ATENDENTE <-> PACIENTE)
CREATE TABLE ATENDE (
    fk_PACIENTE_cod_paciente INT,
    fk_ATENDENTE_cod_atendente INT,
    PRIMARY KEY (fk_PACIENTE_cod_paciente, fk_ATENDENTE_cod_atendente),
    FOREIGN KEY (fk_PACIENTE_cod_paciente) REFERENCES PACIENTE(cod_paciente),
    FOREIGN KEY (fk_ATENDENTE_cod_atendente) REFERENCES ATENDENTE(cod_atendente)
);

-- Relacionamento: medica (PACIENTE <-> REMEDIO)
CREATE TABLE MEDICA (
    fk_PACIENTE_cod_paciente INT,
    fk_REMEDIO_nome VARCHAR(100),
    PRIMARY KEY (fk_PACIENTE_cod_paciente, fk_REMEDIO_nome),
    FOREIGN KEY (fk_PACIENTE_cod_paciente) REFERENCES PACIENTE(cod_paciente),
    FOREIGN KEY (fk_REMEDIO_nome) REFERENCES REMEDIO(nome)
);

-- Relacionamento: usa (ENFERMEIRO <-> REMEDIO)
CREATE TABLE USA (
    fk_ENFERMEIRO_cod_enfermeiro INT,
    fk_REMEDIO_nome VARCHAR(100),
    PRIMARY KEY (fk_ENFERMEIRO_cod_enfermeiro, fk_REMEDIO_nome),
    FOREIGN KEY (fk_ENFERMEIRO_cod_enfermeiro) REFERENCES ENFERMEIRO(cod_enfermeiro),
    FOREIGN KEY (fk_REMEDIO_nome) REFERENCES REMEDIO(nome)
);
