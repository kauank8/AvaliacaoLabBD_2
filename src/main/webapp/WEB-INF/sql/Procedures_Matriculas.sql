Use AvLabBd
go

--Criando função responsavel por listar as disciplinas disponiveis para a matricula
Create function fn_listaDisciplina(@ra char(9))
returns @tabela table (
	cod_disciplina	int,
	nome	varchar(100),
	aula_semanais	int,
	dia_semana	varchar(25),
	hora_inicio	varchar(5),
	hora_fim	varchar(5)
)
Begin
		declare @cod_curso int
		set @cod_curso = (select curso_codigo from Aluno where ra = @ra)

		Insert Into @tabela (cod_disciplina, nome, aula_semanais, dia_semana, hora_inicio, hora_fim)
					select  d.codigo, d.nome, d.aulas_semanais, d.dia_semana, convert(varchar(5), d.hora_inicio, 108) as hora_inicio, convert(varchar(5), d.hora_fim, 108) as hora_fim
					from Disciplina d left outer join Matricula m on d.codigo = m.codigo_disciplina and m.aluno_ra = @ra
					where m.aluno_ra is null and d.codigo_curso = @cod_curso
	
		Insert Into @tabela (cod_disciplina, nome, aula_semanais, dia_semana, hora_inicio, hora_fim)
					select d.codigo, d.nome, d.aulas_semanais, d.dia_semana, convert(varchar(5), d.hora_inicio, 108) as horaInicio, convert(varchar(5), d.hora_fim, 108) as hora_fim
					from Disciplina d, Matricula m
					left join Matricula m1 on m1.aluno_ra = m.aluno_ra
							  and m1.codigo_disciplina = m.codigo_disciplina
							  and m1.ano_semestre_matricula > m.ano_semestre_matricula
							  and m1.situacao = 'Aprovado'
					where d.codigo_curso = @cod_curso and
						  m.situacao = 'Reprovado'
						  and m1.ano_semestre_matricula is null and 
						  d.codigo = m.codigo_disciplina

		Return
End



Go
-- Criando procedure que controla insert de matricula
Create procedure sp_insereMatricula(@ra varchar(9), @codigo_disciplina int,@hora_inicio varchar(5), @hora_fim varchar(5), 
@dia_semana varchar(25), @saida varchar(100) output)
as
	Declare @cod_curso int,
			@cons_horaInicio time(7),
			@cons_horaFim time(7),
			@contador int,
			@ano_atual varchar(4),
			@mes_atual varchar(2),
			@cons_disciplina int,
			@qtd_matriculas int,
			@status bit
			
	set @cod_curso = (Select curso_codigo from Aluno where ra = @ra)
	set @contador = 1
	set @ano_atual = (Select YEAR(GETDATE()))
	set @mes_atual = (Select MONTH(GETDATE()))
	set @status = 1

	If(@mes_atual > 6) Begin
		set @mes_atual = 2
	End
	Else Begin
		set @mes_atual = 1
	End
	
	If(@dia_semana = 'ter?a-feira') Begin
		set @dia_semana = 'Terça-feira'
	End

	create table #verificaMatriculas(
		codigo int not null identity(1,1) Primary Key,
		hora_inicio time(7) not null,
		hora_fim time(7) not null,
	)

	Insert into #verificaMatriculas(hora_inicio, hora_fim) 
	Select d.hora_inicio, d.hora_fim from Disciplina d, Matricula m where m.aluno_ra = @ra and m.dia_semana = @dia_semana and d.codigo_curso = @cod_curso and  m.codigo_disciplina = d.codigo
	
	set @qtd_matriculas = (Select COUNT(codigo) from #verificaMatriculas)
	
	While(@contador<= @qtd_matriculas) Begin
		set @cons_horaInicio = (Select hora_inicio From #verificaMatriculas where codigo = @contador)
		set @cons_horaFim = (Select hora_fim From #verificaMatriculas where codigo = @contador)

		If(CONVERT(TIME, @hora_inicio) Between @cons_horaInicio and @cons_horaFim and @cons_horaInicio is not null) Begin
			set @saida = 'Conflito de horarios, você ja está matriculado em uma materia'
			set @status = 0
			return
		End
		Else begin
			set @status = 1
		End
		
		set @contador = @contador +1
	End
	Drop table #verificaMatriculas
	If(@status = 1) Begin
		Begin Try
			Insert into Matricula Values
			(@ra, @codigo_disciplina, @ano_atual+@mes_atual, @dia_semana, 0, 'Em Andamento', 0, 0, 0)
			set @saida = 'Matricula feita com sucesso'
		End Try
		Begin Catch
			set @saida = ERROR_MESSAGE()
		End Catch
	End

