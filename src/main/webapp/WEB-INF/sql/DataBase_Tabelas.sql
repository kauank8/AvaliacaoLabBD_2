Create DataBase AvLabBd
go
Use AvLabBd
go

--Criando Tabelas
Create table Curso(
codigo int  not null Check(codigo >=0 and codigo <=100),
nome varchar(170) not null,
carga_horaria int not null,
sigla varchar(10) not null,
nota_enade int not null
Primary key(codigo)
)
go
Create Table Aluno(
ra char(9) not null,
cpf char(11) not null UNIQUE,
nome varchar(150) not null,
nome_social varchar(100) null,
data_nascimento date not null,
email_pessoal varchar(170) not null,
email_corporativo varchar(170) not null Unique,
conclusao_segundoGrau date not null,
instituicao_segundoGrau varchar(170) not null,
pontuacao_vestibular decimal(7,2) not null,
posicao_vestibular int not null,
ano_ingresso int not null,
semestre_ingresso int not null,
semestre_limite int not null,
ano_limite int not null,
curso_codigo int not null
Primary key(ra)
Foreign Key(curso_codigo) References Curso(codigo)
)
Go
Create table Telefone(
numero char(11) not null,
aluno_ra char(9) not null
Primary key(numero, aluno_ra)
Foreign Key(aluno_ra) References Aluno(ra)
)
Go
Create Table Professor(
matricula int not null,
nome varchar(150) not null,
cpf char(11) not null Unique,
data_nasc date not null,
formacao_academica varchar(255) not null
Primary Key(matricula)
)
Go
Create table Disciplina(
codigo int not null Identity(1001,1),
nome varchar(100) not null,
aulas_semanais integer not null,
hora_inicio time(7) not null,
hora_fim time(7) not null,
dia_semana varchar(25) not null,
semestre int not null,
codigo_curso int not null,
matricula_professor int not null
Primary Key(codigo)
Foreign Key(codigo_curso) References Curso(codigo),
Foreign Key(matricula_professor) References Professor(matricula)
)
Go
Create table Conteudo(
codigo int not null Identity(1,1),
descricao varchar(255) not null,
codigo_disciplina int not null
Primary Key(codigo)
Foreign Key (codigo_disciplina) References Disciplina(codigo)
)
Go
Create table Matricula(
aluno_ra char(9) not null,
codigo_disciplina int not null,
ano_semestre_matricula varchar(10) not null,
dia_semana varchar(25) not null,
nota varchar(5) not null,
situacao varchar(15) not null,
quantidade_presenca int not null,
quantidade_falta int not null,
frequencia decimal(7,2) not null
Primary Key(aluno_ra, codigo_disciplina, ano_semestre_matricula)
Foreign Key(aluno_ra) References Aluno(ra),
Foreign Key(codigo_disciplina) References Disciplina(codigo)
)
Go 
Create table Dispensa(
aluno_ra char(9) not null,
codigo_disciplina int not null,
motivo varchar(255) not null,
data_solicitacao date not null,
status_dispensa varchar(20) not null
Primary Key(aluno_ra, codigo_disciplina)
Foreign Key(aluno_ra) References Aluno(ra),
Foreign Key(codigo_disciplina) References Disciplina(codigo)
)
Go 
Create Table Chamada(
presenca_primeira_aula bit not null,
presenca_segunda_aula bit not null,
presenca_terceira_aula bit null,
presenca_quarta_aula bit null,
data_aula date not null,
codigo_disciplina int not null,
aluno_ra char(9) not null,
semestre varchar(10) not null
Primary key(codigo_disciplina,data_aula, aluno_ra)
Foreign key(aluno_ra) References Aluno(ra),
Foreign key(codigo_disciplina) References Disciplina(codigo),
FOREIGN KEY (aluno_ra, codigo_disciplina, semestre) REFERENCES Matricula (aluno_ra, codigo_disciplina, ano_semestre_matricula)
)
