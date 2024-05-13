Use AvLabBd
go
--Populandos tabelas necessarias;
Insert into Curso Values
(1,'Analise e Desenvolvimento de Sistemas', 2800, 'ADS', 4),
(2, 'Engenharia de Computação', 3600, 'ECOM', 4),
(3, 'Administração', 3200, 'ADM', 3)
GO

-- Inserir professores
INSERT INTO Professor (matricula, nome, cpf, data_nasc, formacao_academica)
VALUES
    (1001, 'Ana Silva', '12345678901', '1970-05-15', 'Doutorado em Ciência da Computação'),
    (1002, 'Carlos Oliveira', '23456789012', '1982-08-20', 'Mestrado em Engenharia de Software'),
    (1003, 'Fernanda Santos', '34567890123', '1975-11-10', 'Especialização em Desenvolvimento Web'),
    (1004, 'Gabriel Almeida', '45678901234', '1987-03-25', 'Doutorado em Engenharia de Software'),
    (1005, 'Isabela Lima', '56789012345', '1980-09-08', 'Mestrado em Sistemas de Informação'),
    (1006, 'João Souza', '67890123456', '1973-12-02', 'Especialização em Inteligência Artificial'),
    (1007, 'Mariana Oliveira', '78901234567', '1985-06-18', 'Doutorado em Ciência da Computação'),
    (1008, 'Paulo Mendes', '89012345678', '1978-02-14', 'Mestrado em Engenharia de Software'),
    (1009, 'Rafaela Costa', '90123456789', '1983-10-30', 'Especialização em Desenvolvimento Web'),
    (1010, 'Sandra Ferreira', '01234567890', '1971-04-12', 'Doutorado em Engenharia de Software'),
    (1011, 'Tiago Santos', '09876543210', '1984-07-28', 'Mestrado em Sistemas de Informação'),
    (1012, 'Viviane Alves', '98765432109', '1977-11-05', 'Especialização em Inteligência Artificial'),
    (1013, 'Wagner Pereira', '87654321098', '1974-01-19', 'Doutorado em Ciência da Computação'),
    (1014, 'Xavier Silva', '76543210987', '1979-08-23', 'Mestrado em Engenharia de Software'),
    (1015, 'Yasmin Lima', '65432109876', '1986-12-07', 'Especialização em Desenvolvimento Web'),
    (1016, 'Zeca Souza', '54321098765', '1972-05-31', 'Doutorado em Engenharia de Software'),
    (1017, 'Alice Oliveira', '43210987654', '1976-10-15', 'Mestrado em Sistemas de Informação'),
    (1018, 'Bernardo Costa', '32109876543', '1981-02-28', 'Especialização em Inteligência Artificial'),
    (1019, 'Camila Ferreira', '21098765432', '1970-06-13', 'Doutorado em Ciência da Computação'),
    (1020, 'Daniel Alves', '10987654321', '1989-03-07', 'Mestrado em Engenharia de Software');
Go

-- Inserir disciplinas do primeiro semestre para ADS
INSERT INTO Disciplina (nome, aulas_semanais, hora_inicio, hora_fim, dia_semana, semestre, codigo_curso, matricula_professor)
VALUES
('Introdução à Programação', 4, '13:00', '16:30', 'Segunda-feira', 1, 1, 1001),
('Matemática Discreta', 4, '13:00', '16:30', 'Terça-feira', 1, 1, 1002),
('Banco de Dados', 4, '13:00', '16:30', 'Quarta-feira', 1, 1, 1003),
('Sistemas Operacionais', 4, '13:00', '16:30', 'Quinta-feira', 1, 1, 1004),
('Redes de Computadores', 4, '13:00', '16:30', 'Sexta-feira', 1, 1, 1005),
('Comunicação e Expressão', 2, '16:40', '18:20', 'Quarta-feira', 1, 1, 1018),
('Gestão da Qualidade', 2, '16:40', '18:20', 'Sexta-feira', 1, 1, 1019);

Go
-- Inserir disciplinas do segundo semestre para ADS
INSERT INTO Disciplina (nome, aulas_semanais, hora_inicio, hora_fim, dia_semana, semestre, codigo_curso, matricula_professor)
VALUES
('Ética e Legislação em Informática', 2, '13:00', '14:40', 'Segunda-feira', 2, 1, 1006),
('Estrutura de Dados', 4, '13:00', '16:30', 'Terça-feira', 2, 1, 1002),
('Tópicos Especiais em Computação', 2, '13:00', '14:40', 'Sexta-feira', 2, 1, 1008),
('Sistemas Distribuídos', 4, '13:00', '16:30', 'Quarta-feira', 2, 1, 1003),
('Segurança da Informação', 4, '13:00', '16:30', 'Quinta-feira', 2, 1, 1004),
('Machine Learning', 4, '14:50', '18:20', 'Segunda-feira', 2, 1, 1009),
('Big Data e Analytics', 4, '14:50', '18:20', 'Sexta-feira', 2, 1, 1013)

Go
-- Inserindo alguns alunos em ADS
INSERT INTO Aluno (ra, cpf, nome, nome_social, data_nascimento, email_pessoal, email_corporativo, conclusao_segundoGrau, instituicao_segundoGrau, pontuacao_vestibular, posicao_vestibular, ano_ingresso, semestre_ingresso, semestre_limite, ano_limite, curso_codigo)
VALUES
    ('123456789', '12345678901', 'Fulano da Silva', NULL, '1990-01-01', 'fulano@gmail.com', 'fulano@empresa.com', '2010-01-01', 'Escola A', 8.5, 10, 2020, 1, 2, 2024, 1)
Go
INSERT INTO Aluno (ra, cpf, nome, nome_social, data_nascimento, email_pessoal, email_corporativo, conclusao_segundoGrau, instituicao_segundoGrau, pontuacao_vestibular, posicao_vestibular, ano_ingresso, semestre_ingresso, semestre_limite, ano_limite, curso_codigo)
VALUES
    ('234567890', '23456789012', 'Beltrano Pereira', NULL, '1991-02-02', 'beltrano@gmail.com', 'beltrano@empresa.com', '2011-02-02', 'Escola B', 8.0, 20, 2020, 1, 2, 2024, 1)
GO
INSERT INTO Aluno (ra, cpf, nome, nome_social, data_nascimento, email_pessoal, email_corporativo, conclusao_segundoGrau, instituicao_segundoGrau, pontuacao_vestibular, posicao_vestibular, ano_ingresso, semestre_ingresso, semestre_limite, ano_limite, curso_codigo)
VALUES
    ('345678901', '34567890123', 'Ciclana Oliveira', NULL, '1992-03-03', 'ciclana@gmail.com', 'ciclana@empresa.com', '2012-03-03', 'Escola C', 7.5, 30, 2020, 1, 2, 2024, 1)
Go
INSERT INTO Aluno (ra, cpf, nome, nome_social, data_nascimento, email_pessoal, email_corporativo, conclusao_segundoGrau, instituicao_segundoGrau, pontuacao_vestibular, posicao_vestibular, ano_ingresso, semestre_ingresso, semestre_limite, ano_limite, curso_codigo)
VALUES
    ('456789012', '45678901234', 'Doutrina Santos', NULL, '1993-04-04', 'doutrina@gmail.com', 'doutrina@empresa.com', '2013-04-04', 'Escola D', 7.0, 40, 2020, 1, 2, 2024, 1)
Go
INSERT INTO Aluno (ra, cpf, nome, nome_social, data_nascimento, email_pessoal, email_corporativo, conclusao_segundoGrau, instituicao_segundoGrau, pontuacao_vestibular, posicao_vestibular, ano_ingresso, semestre_ingresso, semestre_limite, ano_limite, curso_codigo)
VALUES
    ('567890123', '56789012345', 'Estudo Almeida', NULL, '1994-05-05', 'estudo@gmail.com', 'estudo@empresa.com', '2014-05-05', 'Escola E', 6.5, 50, 2020, 1, 2, 2024, 1);

