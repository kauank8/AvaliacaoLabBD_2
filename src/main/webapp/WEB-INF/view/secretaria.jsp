<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href='<c:url value = "./resources/secretaria.css"/>'>
<title>Secretaria</title>
</head>
<body>	
	<nav id = menu>
	<ul>
		<li><a href="index">Home</a>
		<li><a href="secretaria" class="ativa">Cadastrar Aluno</a>
		<li><a href="visualizarAluno">Visualizar/Alterar Aluno</a>
		<li><a href="telefone">Telefone</a>
		<li><a href="matricula">Matricula</a>
		<li><a href="consultarMatricula">Consulta Matricula</a>
		<li><a href="dispensaSecretaria">Dispensas</a>
		<li><a href="secretariaHistorico">Historico</a>
	</ul>
	</nav>
	
	<div class="container_aluno">
		<h1>Cadastrar Aluno</h1>
		<form action="secretaria" method="post">
		<table>
				<tr>
					<td colspan="1">
						<input class="id_input_data" type="number" min="0" step="1" id="codigo_curso" name="codigo_curso" placeholder="Codigo curso"
						 value='<c:out value="${aluno.curso.codigo }"></c:out>'> 
				</tr>
				<tr>
					<td colspan="2">
						<input class="input_data" type="text"   id="cpf" name="cpf" placeholder="Cpf" 
						pattern="[0-9]*" title="Por favor, digite apenas números."
						value='<c:out value="${aluno.cpf }"></c:out>'>
					</td>
				</tr>
				<tr>
					<td colspan="1">
						<input class="input_data" type="text" id="nome" name="nome" placeholder="Nome"
						value='<c:out value="${aluno.nome }"></c:out>'>
					</td>
					<td colspan="1">
						<input class="input_data" type="text" id="nome_social" name="nome_social" placeholder="Nome social"
						value='<c:out value="${aluno.nome_social }"></c:out>'>
					</td>
				</tr>
				<tr>
					<td colspan="1">
						<label class="label_data"> Data Nascimento:</label>
					</td>
					<td colspan="1">
						<input class="date_input_data" type="date"  id="data_nasc" name="data_nasc" placeholder="Data de nascimento"
						value='<c:out value="${aluno.data_nasc }"></c:out>'>
					</td>
				</tr>
				<tr>
					<td colspan="1">
					<label class="label_data"> Data Conclusão 2º Grau:</label>
					</td>
					<td colspan="1">
						<input class="input_data" type="date"  id="conclusao_segundo_grau" name="conclusao_segundo_grau" placeholder="Conclusão segundo grau"
						value='<c:out value="${aluno.conclusao_segundo_grau }"></c:out>'>
					</td>
				</tr>
				<tr>
					<td colspan="1">
						<input class="input_data" type="text"  id="email_pessoal" name="email_pessoal" placeholder="Email pessoal"
						value='<c:out value="${aluno.email_pessoal }"></c:out>'>
					</td>
					<td colspan="1">
						<input class="input_data" type="text"  id="email_corporativo" name="email_corporativo" placeholder="Email corporativo"
						value='<c:out value="${aluno.email_corporativo }"></c:out>'>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input class="input_data" type="text"  id="instituicao_segundo_grau" name="instituicao_segundo_grau" placeholder="Instituição segundo grau"
						value='<c:out value="${aluno.instituicao_segundo_grau }"></c:out>'>
					</td>
				</tr>
				<tr>
					<td colspan="1">
						<input class="input_data" type="number" min="0" step="any"  id="pontuacao_vestibular" name="pontuacao_vestibular" placeholder="Pontuação vestibular"
						value='<c:out value="${aluno.pontuacao_vestibular }"></c:out>'>
					</td>
					<td colspan="1">
						<input class="input_data" type="number"  id="posicao_vestibular" name="posicao_vestibular" placeholder="Posição vestibular"
						value='<c:out value="${aluno.posicao_vestibular }"></c:out>'>
					</td>
				</tr>
				<tr>
					<td colspan="4" >
						<input class="btn_cadastrar"  type="submit" id="botao" name="botao" value="Cadastrar">
					</td>	
				</tr>
			</table>
		</form>
	</div>
	
	<div align="center">
		<c:if test="${not empty erro }">
			<h2><b> <c:out value="${erro }" /> </b></h2>
		</c:if>
	</div>
	<div align="center">
		<c:if test="${not empty saida }">
			<h3><b> <c:out value="${saida }" /> </b></h3>	
		</c:if>
	</div>
	
	<div id="rodape">
		<p> Desenvolvido por: Kauan Paulino Farias. &copy Todos os Direitos reservados</p>
		<p>Contato para suporte: kauan.farias01@fatecsp.gov.br</p>
	</div>
	
</body>
</html>