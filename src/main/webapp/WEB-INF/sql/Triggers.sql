use AvLabBd
go

--Criando primeira trigger, assim que o aluno for cadastrado, ja se matricula na disciplina do 1º semestre
Create Trigger t_insereDisciplinasPrimeiroSemestre on Aluno
after insert 
as
Begin
	declare @ra char(9),
			@cod_curso int,
			@cod_disciplina int,
			@qtd_disciplinas int,
			@ano_atual varchar(4),
			@mes_atual varchar(2),
			@dia_semana varchar(25),
			@contador int

	set @ano_atual = (Select YEAR(GETDATE()))
	set @mes_atual = (Select MONTH(GETDATE()))
	set @ra = (select ra from inserted)
	set @contador = 1
	set @cod_curso = (select curso_codigo from inserted)

	If(@mes_atual > 6) Begin
		set @mes_atual = 2
	End
	Else Begin
		set @mes_atual = 1
	End

	create table #listaDisciplina(
		codigo int not null identity(1,1) Primary Key,
		codigo_disciplina int not null,
		dia_semana varchar(25) not null
	)
	Insert Into #listaDisciplina(codigo_disciplina, dia_semana)
	select codigo, dia_semana from Disciplina where codigo_curso = @cod_curso and semestre = 1

	set @qtd_disciplinas = (Select COUNT(codigo) from #listaDisciplina)

	while(@contador<=@qtd_disciplinas) Begin
		set @cod_disciplina = (select codigo_disciplina from #listaDisciplina where codigo = @contador)
		set @dia_semana = (select dia_semana from #listaDisciplina where codigo = @contador)

		Insert into Matricula Values
		(@ra, @cod_disciplina, @ano_atual+@mes_atual, @dia_semana, 0, 'Em Andamento', 0,0,0)

		set @contador = @contador +1
	End
End

--Segunda trigger, verifica se a dispensa do aluno foi aceita ou recusada, se aceita insire aprovado na matricula
GO
Create Trigger t_verificaDispensa on Dispensa
after update
as
Begin
	Declare @status varchar(20)

	set @status = (Select status_dispensa from inserted)

	if(@status = 'Aprovada') Begin 
		Declare @aluno_ra char(9),
				@codigo_disciplina int,
				@ano_semestre int,
				@dia_semana varchar(25),
				@consulta_matricula char(9)

		set @aluno_ra = (Select aluno_ra from inserted)
		set @codigo_disciplina = (Select codigo_disciplina from inserted)
		set @ano_semestre = (Select dbo.fn_turma())
		set @dia_semana = (Select dia_semana from Disciplina where codigo = @codigo_disciplina)
		set @consulta_matricula = (Select aluno_ra from Matricula where codigo_disciplina = @codigo_disciplina 
		and aluno_ra = @aluno_ra and ano_semestre_matricula = @ano_semestre)
		If(@consulta_matricula is not null) Begin
			Update Matricula set nota = 'D', situacao = 'Aprovado' where codigo_disciplina = @codigo_disciplina 
			and aluno_ra = @aluno_ra
		End
		Else Begin
			Insert into Matricula Values
			(@aluno_ra, @codigo_disciplina, @ano_semestre, @dia_semana, 'D', 'Aprovado',0,0,0)
		End
	End
End

-- criando uma triggers que ja registra quantas faltas e presencas o aluno tem assim que uma chamada é feita
GO
Create Trigger t_faltas_presencas on Chamada
after insert, update
as
Begin
	Declare @consulta_ra char(9),
			@ra char(9),
			@codigo_disciplina int,
			@semestre int,
			@primeira_aula int,
			@segunda_aula int,
			@terceira_aula int,
			@quarta_aula int,
			@qtd_presenca int,
			@qtd_falta int

	set @consulta_ra = (Select aluno_ra from deleted)
	set @ra = (Select aluno_ra from inserted)
	set @codigo_disciplina = (Select codigo_disciplina from inserted)
	set @semestre = (Select semestre from inserted)

	if(@consulta_ra is not null) Begin
		Declare @del_primeira_aula int,
				@del_segunda_aula int,
				@del_terceira_aula int,
				@del_quarta_aula int,
				@del_presenca int,
				@del_falta int,
				@soma_presenca int,
				@soma_falta int


		set @primeira_aula = (Select presenca_primeira_aula from inserted)
		set @segunda_aula = (Select presenca_segunda_aula from inserted)
		set @terceira_aula = (Select presenca_terceira_aula from inserted)
		set @quarta_aula = (Select presenca_quarta_aula from inserted)

		set @del_primeira_aula = (Select presenca_primeira_aula from deleted)
		set @del_segunda_aula = (Select presenca_segunda_aula from deleted)
		set @del_terceira_aula = (Select presenca_terceira_aula from deleted)
		set @del_quarta_aula = (Select presenca_quarta_aula from deleted)

		if(@terceira_aula is not null) Begin
			set @qtd_presenca = @primeira_aula + @segunda_aula + @terceira_aula + @quarta_aula
			set @qtd_falta = 4 - @qtd_presenca

			set @del_presenca = @del_primeira_aula + @del_segunda_aula + @del_terceira_aula + @del_quarta_aula
			set @del_falta = 4 - @del_presenca

			set @soma_presenca = @qtd_presenca - @del_presenca
			set @soma_falta = @qtd_falta - @del_falta
		End
		Else Begin
			set @qtd_presenca = @primeira_aula + @segunda_aula + @terceira_aula + @quarta_aula
			set @qtd_falta = 2 - @qtd_presenca

			set @del_presenca = @del_primeira_aula + @del_segunda_aula + @del_terceira_aula + @del_quarta_aula
			set @del_falta = 2 - @del_presenca

			set @soma_presenca = @qtd_presenca - @del_presenca
			set @soma_falta = @qtd_falta - @del_falta
		End

		Update Matricula set quantidade_presenca = quantidade_presenca + @soma_presenca, quantidade_falta = quantidade_falta + @soma_falta
		where aluno_ra = @ra and codigo_disciplina = @codigo_disciplina and ano_semestre_matricula = @semestre
	End


	Else Begin
		set @primeira_aula = (Select presenca_primeira_aula from inserted)
		set @segunda_aula = (Select presenca_segunda_aula from inserted)
		set @terceira_aula = (Select presenca_terceira_aula from inserted)
		set @quarta_aula = (Select presenca_quarta_aula from inserted)

		if(@terceira_aula is not null) Begin
			set @qtd_presenca = @primeira_aula + @segunda_aula + @terceira_aula + @quarta_aula
			set @qtd_falta = 4 - @qtd_presenca

		End
		Else Begin
			set @qtd_presenca = @primeira_aula + @segunda_aula
			set @qtd_falta = 2 - @qtd_presenca
		End

		Update Matricula set quantidade_presenca = quantidade_presenca + @qtd_presenca, quantidade_falta = quantidade_falta + @qtd_falta 
		where aluno_ra = @ra and codigo_disciplina = @codigo_disciplina and ano_semestre_matricula = @semestre
	End
End