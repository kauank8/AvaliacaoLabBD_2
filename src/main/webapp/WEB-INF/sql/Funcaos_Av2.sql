Use AvLabBd
go

-- Criações de UDF Para avaliação 2;

-- Função que define qual é a turma atual, ou seja qual o ano semestre da chamada!
Create function fn_turma()
returns varchar(6)
As
Begin
	Declare @ano_atual varchar(6),
			@mes_atual varchar(2),
			@ano_semetre varchar(6)

	set @ano_atual = (Select YEAR(GETDATE()))
	set @mes_atual = (Select MONTH(GETDATE()))

	If(@mes_atual > 6) Begin
		set @mes_atual = 2
	End
	Else Begin
		set @mes_atual = 1
	End

	set @ano_semetre = @ano_atual + @mes_atual
	return @ano_semetre
End

Go
-- Função para trazer alunos para realização da chamada

Create function fn_alunosChamada(@codigo_disciplina int)
returns @tabela Table(
turma varchar(10),
ra_aluno char(9),
nome_aluno varchar(150),
aulas_semanais int,
primeira_aula varchar(5),
segunda_aula varchar(5),
terceira_aula varchar(5),
quarta_aula varchar(5)
)
Begin
	Declare @turma varchar(6),
			@aulas_semanais int,
			@primeira_aula time(7),
			@segunda_aula time(7),
			@terceira_aula time(7),
			@quarta_aula time(7)
		
	
	set @turma = (Select dbo.fn_turma())
	set @primeira_aula = (Select hora_inicio from Disciplina where codigo = @codigo_disciplina)
	set @aulas_semanais = (Select aulas_semanais from Disciplina where codigo = @codigo_disciplina)

	if(@aulas_semanais = 2) Begin
		set @segunda_aula = (Select DATEADD(MINUTE, 50, @primeira_aula))
		set @terceira_aula = null;
		set @quarta_aula = null;
	End
	Else Begin
		set @segunda_aula = (Select DATEADD(MINUTE, 50, @primeira_aula))
		set @terceira_aula = (Select DATEADD(MINUTE, 50, @segunda_aula))
		set @quarta_aula = (Select DATEADD(MINUTE, 50, @terceira_aula))
	End


	Insert into @tabela(turma,ra_aluno, nome_aluno, aulas_semanais, primeira_aula, segunda_aula, terceira_aula , quarta_aula)
	select @turma as turma, a.ra, a.nome, @aulas_semanais, 
	convert(varchar(5), @primeira_aula, 108), convert(varchar(5), @segunda_aula, 108), 
	convert(varchar(5), @terceira_aula, 108), convert(varchar(5), @quarta_aula, 108) 
	from Aluno a, Matricula m  
	where a.ra = m.aluno_ra and m.ano_semestre_matricula = @turma and m.codigo_disciplina = @codigo_disciplina
	and m.situacao = 'Em Andamento'

	Return
End

Go
-- Criando procedure que controla inserção na chamada

Create procedure sp_insereChamada(@ra char(9), @codigo_disciplina int, @primeira_aula bit, @segunda_aula bit, 
@terceira_aula bit, @quarta_aula bit, @saida varchar(100) output)
as
	Declare @ano_semestre int,
			@aulas_semanais int
	set @ano_semestre = (Select dbo.fn_turma())
	set @aulas_semanais = (Select aulas_semanais from Disciplina where codigo = @codigo_disciplina)
	
	If(@aulas_semanais = 2) Begin
		set @terceira_aula = null
		set @quarta_aula = null
	End

	Begin try
		Insert into Chamada Values(@primeira_aula, @segunda_aula, @terceira_aula, @quarta_aula, GETDATE(),
		@codigo_disciplina, @ra, @ano_semestre)
		set @saida = 'Chamada feita com sucesso'
	End try
	Begin Catch
		set @saida = ERROR_MESSAGE()
		if(@saida Like '%Primary%') Begin
			set @saida = 'Ja foi realizada uma chamada nessa data para essa disciplina'
		End
	End Catch

Go
-- Criando procedure que atualiza chamada
Create procedure sp_atualizaChamada(@ra char(9), @codigo_disciplina int, @primeira_aula bit, @segunda_aula bit, 
@terceira_aula bit, @quarta_aula bit, @data_aula varchar(10), @saida varchar(100) output)
as
Declare @ano_semestre int,
			@aulas_semanais int
	set @ano_semestre = (Select dbo.fn_turma())
	set @aulas_semanais = (Select aulas_semanais from Disciplina where codigo = @codigo_disciplina)
	
	If(@aulas_semanais = 2) Begin
		set @terceira_aula = null
		set @quarta_aula = null
	End

	Begin try
		Update Chamada set presenca_primeira_aula = @primeira_aula, presenca_segunda_aula = @segunda_aula, 
		presenca_terceira_aula = @terceira_aula, presenca_quarta_aula = @quarta_aula where aluno_ra = @ra
		and codigo_disciplina = @codigo_disciplina and data_aula = @data_aula
		set @saida = 'Chamada Atualizada com sucesso'
	End try
	Begin Catch
		set @saida = ERROR_MESSAGE()
	End Catch

	Go
	-- Criando udf que traz historico de um aluno
Create function fn_historico(@ra char(9))
returns @tabela Table(
ra_aluno char(9),
nome_aluno varchar(150),
nome_curso varchar(170),
primeira_matricula int,
pontuacao_vestibular decimal(7,2),
posicao_vestibular int,
codigo_disciplina int,
nome_disciplina varchar(100),
nome_professor varchar(150),
nota_final varchar(5),
quantidade_faltas int
)
Begin
	declare @primeira_matricula int
	
	set @primeira_matricula = (Select top 1 ano_semestre_matricula from Matricula where aluno_ra = @ra
							   order by ano_semestre_matricula asc)

	Insert into @tabela 
		Select a.ra, a.nome, c.nome, @primeira_matricula, a.pontuacao_vestibular, a.posicao_vestibular, d.codigo, d.nome, p.nome, m.nota, m.quantidade_falta
		from Aluno a, Professor p, Disciplina d, Matricula m, Curso c
		where a.curso_codigo = c.codigo and a.ra = m.aluno_ra and d.codigo = m.codigo_disciplina and d.matricula_professor = p.matricula
		and a.ra = @ra and m.situacao = 'Aprovado'
	
	return
End
