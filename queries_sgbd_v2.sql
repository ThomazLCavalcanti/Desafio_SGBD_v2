use OficinaMecanica;

-- Inserir valores na tabela Conserto
INSERT INTO Conserto (idConserto, Descricao_conserto)
VALUES (1, 'Troca de óleo');

-- Inserir valores na tabela Revisao
INSERT INTO Revisao (idRevisao, descricao_revisao)
VALUES (1, 'Revisão completa');

-- Inserir valores na tabela Pecas
INSERT INTO Pecas (idPecas, descricao, valor)
VALUES (1, 'Filtro de óleo', 15.99);

-- Inserir valores na tabela Servicos
INSERT INTO Servicos (idServicos, descricao, valor)
VALUES (1, 'Troca de óleo', 30.00);

-- Inserir valores na tabela OrdemServico
INSERT INTO OrdemServico (idOrdemServico, data, valor_servico, valor_peca, valor_total, status, data_conclusao)
VALUES (1, '2023-08-15', 30.00, 15.99, 45.99, 'Concluído', '2023-08-16');

-- Inserir valores na tabela referencia_precos
INSERT INTO referencia_precos (idTabelaReferencia, ordem_servico)
VALUES (1, 1);

-- Inserir valores na tabela Mecanico
INSERT INTO Mecanico (idMecanico, nome, endereco, especialidade)
VALUES (1, 'Carlos Oliveira', 'Av. B, 456', 'Motor');

-- Inserir valores na tabela EquipeMecanicos
INSERT INTO EquipeMecanicos (idEquipe, Mecanico_idMecanico, ordem_servico)
VALUES (1, 1, 1);

-- Inserir valores na tabela Veiculo
INSERT INTO Veiculo (idVeiculo, EquipeMecanicos_idEquipe, Mecanico_idMecanico, Conserto_idConserto, Revisao_idRevisao, PlacaVeiculo)
VALUES (1, 1, 1, 1, 1, 'ABC1234');

-- Inserir valores na tabela Clientes
INSERT INTO Clientes (idClientes, Veiculo_idVeiculo)
VALUES (1, 1);

-- Inserir valores na tabela PessoaFisica
INSERT INTO PessoaFisica (idPessoaFisica, Nome, CPF, Endereco, Contato, Clientes_idClientes, Clientes_Veiculo_idVeiculo)
VALUES (1, 'João da Silva', '12345678901', 'Rua A, 123', '987654321', 1, 1);


-- Inserir valores na tabela PessoaJuridica
INSERT INTO PessoaJuridica (idPessoaJuridica, RazaoSocial, CNPJ, Endereco, Contato, Clientes_idClientes, Clientes_Veiculo_idVeiculo)
VALUES (1, 'Oficina Exemplo', '12345678901234', 'Rua C, 789', '987654321', 1, 1);

-- Inserir valores na tabela AutorizacaoCliente
INSERT INTO AutorizacaoCliente (Clientes_idClientes, Clientes_Veiculo_idVeiculo, ordem_servico, autorizado)
VALUES (1, 1, 1, 1);

-- Inserir valores na tabela OS_Servicos
INSERT INTO OS_Servicos (ordem_servicos, servicos_idServicos)
VALUES (1, 1);

-- Inserir valores na tabela OS_Pecas
INSERT INTO OS_Pecas (idOS_Pecas, ordem_servico, pecas_idPecas)
VALUES (1, 1, 1);


-- Recupere todos os nomes e CPFs das pessoas físicas
SELECT Nome, CPF
FROM PessoaFisica;

-- Recupere todas as descrições de serviços
SELECT descricao
FROM Servicos;

-- Recupere as ordens de serviço com status "Concluído"
SELECT idOrdemServico, status
FROM OrdemServico
WHERE status = 'Concluído';

-- Recupere as peças com valor maior que 50
SELECT descricao, valor
FROM Pecas
WHERE valor < 50;

-- Crie um atributo derivado "ValorTotal" que seja a soma de valor_servico e valor_peca
SELECT idOrdemServico, valor_servico, valor_peca, (valor_servico + valor_peca) AS ValorTotal
FROM OrdemServico;

-- Recupere todas as revisões ordenadas por ID de revisão em ordem decrescente
SELECT idRevisao, descricao_revisao
FROM Revisao
ORDER BY idRevisao DESC;

-- Recupere a quantidade de ordens de serviço por status, somente aqueles com mais de 5 ordens
SELECT status, COUNT(*) AS Total
FROM OrdemServico
GROUP BY status
HAVING Total < 5;

-- Recupere os nomes dos clientes e placas de veículos, juntamente com a descrição do serviço realizado
SELECT pf.Nome AS Cliente, v.PlacaVeiculo, s.descricao AS ServicoRealizado
FROM PessoaFisica pf
JOIN Clientes c ON pf.Clientes_idClientes = c.idClientes
JOIN Veiculo v ON c.Veiculo_idVeiculo = v.idVeiculo
JOIN OS_Servicos os ON v.idVeiculo = os.ordem_servicos
JOIN Servicos s ON os.servicos_idServicos = s.idServicos;
