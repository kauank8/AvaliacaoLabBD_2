Use AvLabBd
go
--Gerador de Ra
Create Procedure sp_geraRa(@saida varchar(100) output)
as
Declare @ano varchar(4),
		@semestre int,
		@ra varchar(9),
		@num varchar(1),
		@num2 varchar(1),
		@num3 varchar(1),
		@num4 varchar(1),
		@consultaRa varchar(9),
		@status char(1)

		set @ano = (Select YEAR(GETDATE()))
		set @semestre = (Select MONTH(GETDATE()))
		set @status = 'f'

		If(@semestre > 6) Begin
			set @semestre = 2
		End 
		Else Begin
			set @semestre = 1
		End
		
		set @ra= @ano + Cast(@semestre as varchar(1))
		While(@status = 'f') Begin
			set @num = (SELECT CAST(RAND() * 10 AS int))
			set @num2 = (SELECT CAST(RAND() * 10 AS int))
			set @num3 = (SELECT CAST(RAND() * 10 AS int))
			set @num4 = (SELECT CAST(RAND() * 10 AS int))

			set @ra = @ra + Cast(@num as varchar(1)) + Cast(@num2 as varchar(1)) + Cast(@num3 as varchar(1)) + Cast(@num4 as varchar(1))
			set @consultaRa = (Select ra from Aluno where ra = @ra)
			If(@consultaRa is null and LEN(@ra)=9) Begin
				set @status = 't'
			End
			Else Begin
				set @ra = NULL
				set @ra= @ano + Cast(@semestre as varchar(1))
			End
		End
		set @saida = @ra
GO
--Procedure que valida data de nascimento
CREATE PROCEDURE sp_validaIdade(@dt_nasc DATE, @status BIT OUTPUT)
AS
	DECLARE @hoje	DATE,
			@idade	INT
	set @idade = DATEDIFF(YEAR, @dt_nasc, GETDATE())
	If(@idade >= 16)
	Begin
		set @status = 1
	End
	Else
	Begin
		Set @status = 0
	End

-- Algoritmo que valida cpf
GO
Create Procedure sp_algoritmoCPF(@cpf char(11), @saida varchar(100) output )
As
--Declarações de Variaveis
Declare @cont int,
		@valor int,
		@status int,
		@x int

-- Atribuindo Valores
set @status = 0
set @cont = 0 
set @x = 2

-- Verifica se contem 11 digitos
	If(LEN(@cpf) = 11) Begin
		-- Verificando se os 11 digitos são iguais
		While(@cont<10) begin
			If(SUBSTRING(@cpf,1,1) = SUBSTRING(@cpf,@x,1) ) begin	
				set @status = @status + 1
			end
		set @cont = @cont + 1
		set @x = @x+1
		End
		If(@status < 10) Begin
			-- Realizando calculo do primeiro digito
			Declare @valorMutiplicado int
			set @valor = 10
			set @cont = 0
			set @x = 1
			set @valorMutiplicado = 0

			While(@cont<9) Begin
				set @valorMutiplicado = CAST(SUBSTRING(@cpf,@x,1) as int) * @valor + @valorMutiplicado
				set @x = @x+1
				set @cont = @cont + 1
				set @valor = @valor - 1
			End

			Declare @valorDivido int,
					@primeiroDigito int
			set @valorDivido = @valorMutiplicado % 11

			If (@valorDivido < 2) Begin
				set @primeiroDigito = 0
			End
			Else Begin
				set @primeiroDigito = 11 - @valorDivido
			End

			-- Verifica se o digito calculado é igual o digito inserido
			If( CAST(SUBSTRING(@cpf,10,1)as int) = @primeiroDigito) Begin
				-- Calculando o segundo digito
				set @valor = 11
				set @cont = 0
				set @x = 1
				set @valorMutiplicado = 0

				While(@cont<10) Begin
				set @valorMutiplicado = CAST(SUBSTRING(@cpf,@x,1) as int) * @valor + @valorMutiplicado
				set @x = @x+1
				set @cont = @cont + 1
				set @valor = @valor - 1
				End
				
				Declare @segundoDigito int
				set @valorDivido = @valorMutiplicado % 11

				If (@valorDivido < 2) Begin
				set @segundoDigito = 0
				End
				Else Begin
				set @segundoDigito = 11 - @valorDivido
				End

				-- Verifica se o ultimo digito calculado correponde a o ultimo digito inserido
				If( CAST(SUBSTRING(@cpf,11,1)as int) = @segundoDigito) Begin
					set @saida = 'CPF Valido'
				End
				Else Begin
					RaisError('CPF Invalido', 16,1)
				End

			End
			Else Begin
				RaisError('CPF Invalido', 16,1)
			End
		End
		Else Begin
		RaisError('Todos os digitos são iguais ', 16,1)
		End
	End
	Else Begin
	RaisError('Numero de digitos invalido', 16,1)
	End

Go		
-- Calcula Ano limite
Create Procedure sp_verificaLimite (@ano int, @semestre int, @ano_limite date output)
as
	If(@semestre = 1) Begin
		set @semestre = 6
	End
	Else Begin
		set @semestre = 12
	End
	set @ano_limite = (Select DATEADD(YEAR, 5, (SELECT DATEFROMPARTS(@ano, @semestre, 1))))
