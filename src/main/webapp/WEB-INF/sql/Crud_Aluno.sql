Use AvLabBd
go
Create Procedure sp_aluno(@op char(1),@cod_curso int,@ra char(9),@cpf char(11), @nome varchar(150), @nome_social varchar(100), @dt_nasc date, @dt_conclusao date, 
@email_pessoal varchar(170), @email_corporativo varchar(170), @instituicao varchar(170), @pontuacao decimal(7,2), @posicao int, 
@saida varchar(100) output)
as
IF (UPPER(@op) = 'I')
	BEGIN
		Declare @hoje date,
				@ano_ingresso int,
				@semestre_ingresso int,
				@ano_limite varchar(4),
				@semestre_limite varchar(2)
		
		set @hoje = GETDATE()
		Exec sp_algoritmoCPF @cpf, @saida output
		If(@saida Like 'CPF Valido') Begin
			declare @status bit,
					@data_limite date 

			exec sp_validaIdade @dt_nasc, @status output
			If(@status = 1) Begin
				set @ano_ingresso = (SUBSTRING(Cast(@hoje as varchar(12)),1,4))
				set @semestre_ingresso = (SUBSTRING(Cast(@hoje as varchar(12)),7,1))

				If(@semestre_ingresso >= 6) Begin
					set @semestre_ingresso = 2
				End
				Else Begin
					set @semestre_ingresso = 1
				End

				exec sp_verificaLimite @ano_ingresso , @semestre_ingresso , @data_limite output
				set @ano_limite = (SUBSTRING(Cast(@data_limite as varchar(12)),1,4))
				set @semestre_limite = (SUBSTRING(Cast(@data_limite as varchar(12)),6,2))

				If(@semestre_limite >6) Begin
					set @semestre_limite = 2
				End
				Else Begin
					set @semestre_limite = 1
				End
				
				Begin Try
					Insert Into Aluno Values
					(@ra, @cpf, @nome, @nome_social, @dt_nasc, @email_pessoal, @email_corporativo, @dt_conclusao, @instituicao, @pontuacao, @posicao,
					 @ano_ingresso, @semestre_ingresso, @semestre_limite, @ano_limite, @cod_curso)

					 set @saida = 'Aluno cadastrado com sucesso'
				End Try
				Begin Catch
					set @saida = ERROR_MESSAGE()
					If(@saida like '%UQ__Aluno__BC4C95453280E0F8%') Begin
						set @saida = 'Esse email corporativo já esta sendo usado'
					End
					If(@saida like '%UQ__Aluno__D836E71F52C8A53A%') Begin
						set @saida = 'Esse Cpf ja está cadastrado'
					End
					If(@saida like '%primary%') Begin
						set @saida = 'Esse RA ja está cadastrado'
					End
				End Catch
				
			End
			Else Begin
				RaisError('Idade Invalida',16,1)
			End
		End
END
IF(UPPER(@op) = 'U') Begin
	Declare @consultaCurso int,
			@status1 bit

	set @consultaCurso = (Select codigo from Curso where  codigo = @cod_curso)

	If(@consultaCurso is not null) Begin
		exec sp_validaIdade @dt_nasc, @status1 output
		If(@status1 = 1) Begin
			Begin Try
				Update Aluno set nome = @nome, nome_social = @nome_social, data_nascimento = @dt_nasc, email_pessoal = @email_pessoal,
				email_corporativo = @email_corporativo, conclusao_segundoGrau = @dt_conclusao, instituicao_segundoGrau = @instituicao,
				pontuacao_vestibular = @pontuacao, posicao_vestibular = @posicao
				where ra = @ra
				set @saida = 'Aluno Atualizado com sucesso'
			End Try
			Begin catch
				If(@saida like '%UQ__Aluno__BC4C95453280E0F8%') Begin
						set @saida = 'Esse email corporativo já esta sendo usado'
				End
			End Catch
		End
		Else Begin
			RaisError('Idade Invalida',16,1)
		End
	End
	Else Begin
		RaisError('Esse curso não existe',16,1)
	End
END



GO


