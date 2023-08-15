CREATE DATABASE OficinaMecanica;
USE OficinaMecanica;

CREATE TABLE Conserto (
    idConserto INT PRIMARY KEY,
    Descricao_conserto VARCHAR(45)
);

CREATE TABLE Revisao (
    idRevisao INT PRIMARY KEY,
    descricao_revisao VARCHAR(45)
);

CREATE TABLE OrdemServico (
    idOrdemServico INT PRIMARY KEY,
    data DATE,
    valor_servico FLOAT,
    valor_peca FLOAT,
    valor_total FLOAT,
    status VARCHAR(45),
    data_conclusao DATE
);

CREATE TABLE referencia_precos (
    idTabelaReferencia INT PRIMARY KEY,
    ordem_servico INT,
    FOREIGN KEY (ordem_servico) REFERENCES OrdemServico(idOrdemServico)
);

CREATE TABLE Pecas (
    idPecas INT PRIMARY KEY,
    descricao VARCHAR(45),
    valor FLOAT
);

CREATE TABLE Servicos (
    idServicos INT PRIMARY KEY,
    descricao VARCHAR(45),
    valor FLOAT
);

CREATE TABLE OS_Servicos (
    ordem_servicos INT,
    servicos_idServicos INT,
    FOREIGN KEY (ordem_servicos) REFERENCES OrdemServico(idOrdemServico),
    FOREIGN KEY (servicos_idServicos) REFERENCES Servicos(idServicos)
);

CREATE TABLE OS_Pecas (
    idOS_Pecas INT PRIMARY KEY, -- Adicionado uma chave primária
    ordem_servico INT,
    pecas_idPecas INT,
    FOREIGN KEY (ordem_servico) REFERENCES OrdemServico(idOrdemServico),
    FOREIGN KEY (pecas_idPecas) REFERENCES Pecas(idPecas)
);

CREATE TABLE Mecanico (
    idMecanico INT PRIMARY KEY,
    nome VARCHAR(45),
    endereco VARCHAR(45),
    especialidade VARCHAR(45)
);


CREATE TABLE EquipeMecanicos (
    idEquipe INT PRIMARY KEY,
    Mecanico_idMecanico INT,
    ordem_servico INT,
    FOREIGN KEY (Mecanico_idMecanico) REFERENCES Mecanico(idMecanico),
    FOREIGN KEY (ordem_servico) REFERENCES OrdemServico(idOrdemServico)
);

CREATE TABLE Veiculo (
    idVeiculo INT PRIMARY KEY,
    EquipeMecanicos_idEquipe INT,
    Mecanico_idMecanico INT,
    Conserto_idConserto INT,
    Revisao_idRevisao INT,
    PlacaVeiculo CHAR(7),
    FOREIGN KEY (EquipeMecanicos_idEquipe) REFERENCES EquipeMecanicos(idEquipe),
    FOREIGN KEY (Conserto_idConserto) REFERENCES Conserto(idConserto),
    FOREIGN KEY (Revisao_idRevisao) REFERENCES Revisao(idRevisao)
);

CREATE TABLE Clientes (
    idClientes INT PRIMARY KEY,
    Veiculo_idVeiculo INT,
    FOREIGN KEY (Veiculo_idVeiculo) REFERENCES Veiculo(idVeiculo)
);

CREATE TABLE PessoaFisica (
    idPessoaFisica INT PRIMARY KEY,
    Nome VARCHAR(45),
    CPF CHAR(11),
    Endereco VARCHAR(45),
    Contato CHAR(11),
    Clientes_idClientes INT,
    Clientes_Veiculo_idVeiculo INT,
    FOREIGN KEY (Clientes_idClientes) REFERENCES Clientes(idClientes),
    FOREIGN KEY (Clientes_Veiculo_idVeiculo) REFERENCES Veiculo(idVeiculo)
);

CREATE TABLE PessoaJuridica (
    idPessoaJuridica INT PRIMARY KEY,
    RazaoSocial VARCHAR(45),
    CNPJ CHAR(15),
    Endereco VARCHAR(45),
    Contato CHAR(11),
    Clientes_idClientes INT,
    Clientes_Veiculo_idVeiculo INT,
    FOREIGN KEY (Clientes_idClientes) REFERENCES Clientes(idClientes),
    FOREIGN KEY (Clientes_Veiculo_idVeiculo) REFERENCES Veiculo(idVeiculo)
);

CREATE TABLE AutorizacaoCliente (
    Clientes_idClientes INT,
    Clientes_Veiculo_idVeiculo INT,
    ordem_servico INT,
    autorizado TINYINT,
    FOREIGN KEY (Clientes_idClientes) REFERENCES Clientes(idClientes),
    FOREIGN KEY (Clientes_Veiculo_idVeiculo) REFERENCES Veiculo(idVeiculo),
    FOREIGN KEY (ordem_servico) REFERENCES OrdemServico(idOrdemServico)
);