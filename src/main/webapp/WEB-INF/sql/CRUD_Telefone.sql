Use AvLabBd
go

-- Cadastrar Telefone
Create Procedure sp_insereTelefone (@ra char(9), @numero char(11), @saida varchar(100) output)
As
	If (LEN(@numero) = 11) Begin
		Declare @consultaRa varchar(9)
		
		set @consultaRa = (Select ra from Aluno where ra = @ra)

		If(@consultaRa is not null) Begin
			Begin Try
				Insert into Telefone Values
				(@numero, @ra)
				set @saida = 'Telefone Cadastrado com sucesso'
			End Try
			Begin catch
			set @saida = ERROR_MESSAGE();
				If(@saida like '%primary%') Begin
					RaisError('Esse numero ja esta cadastrado para esse aluno',16,1)
				End
			End catch
		End
		Else Begin 
			RaisError ('Ra Inexistente',16,1)
		End
	End
	Else Begin
		RaisError ('Telefone Invalido, O numero de digitos de ser exatamente 11',16,1)
	End


Go
-- Excluir Telefone
Create Procedure sp_excluiTelefone (@ra char(9), @numero char(11), @saida varchar(100) output)
As
	Declare @consultaRa varchar(9),
			@consultaNumero varchar(11)

		set @consultaRa = (Select ra from Aluno where ra = @ra)

		If(@consultaRa is not null) Begin
			set @consultaNumero = (Select numero from Telefone where aluno_ra = @ra and numero = @numero)
			If (@consultaNumero is not null) Begin
				Delete from Telefone where aluno_ra = @ra and numero = @numero;
				set @saida = 'Telefone excluido com sucesso'
			End
			Else Begin
				RaisError ('Esse numero não existe',16,1)
			End
		End
		Else Begin 
			RaisError ('Ra Inexistente',16,1)
		End
	
	
Go
-- Alterar Telefone

Create Procedure sp_alterarTelefone (@ra varchar(9), @numero_novo char(11), @numero_antigo varchar(11), @saida varchar(100) output)
as
	Declare @consultaRa varchar(9),
			@consultaNumero varchar(11)

		set @consultaRa = (Select ra from Aluno where ra = @ra)

		If(@consultaRa is not null) Begin
			set @consultaNumero = (Select numero from Telefone where aluno_ra = @ra and numero = @numero_antigo)
			If (@consultaNumero is not null) Begin
				If(LEN(@numero_novo)=11) Begin
					Begin Try
						Update Telefone set numero = @numero_novo where aluno_ra = @ra and numero = @numero_antigo
						set @saida = 'Telefone atualizado com sucesso'
					End Try
					Begin catch
						set @saida = ERROR_MESSAGE();
						If(@saida like '%primary%') Begin
							RaisError('Esse numero ja esta cadastrado para esse aluno',16,1)
						End
					End catch
				End
				Else begin
					RaisError ('O numero novo não contem 11 digitos.',16,1)
				End
			End
			Else Begin
				RaisError ('Esse numero não existe',16,1)
			End
		End
		Else Begin 
			RaisError ('Ra Inexistente',16,1)
		End
