<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href='<c:url value = "./resources/telefone.css"/>'>
<title>Secrataria - Telefone</title>
</head>
<body>
	<nav id=menu>
		<ul>
			<li><a href="index">Home</a>
			<li><a href="secretaria">Cadastrar Aluno</a>
			<li><a href="visualizarAluno">Visualizar/Alterar Aluno</a>
			<li><a href="telefone" class="ativa">Telefone</a>
			<li><a href="matricula">Matricula</a>
			<li><a href="consultarMatricula">Consulta Matricula</a>
			<li><a href="dispensaSecretaria">Dispensas</a>
			<li><a href="secretariaHistorico">Historico</a>
		</ul>
	</nav>
	<div class="container_aluno">
		<h1>Telefone</h1>
		<form id="cadastrar" action="telefone" method="post" >
		<table>
			<h1>Cadastrar/Excluir</h1>
				<tr>
					<td colspan="2">
						<input class="id_input_data" type="text"  id="ra" name="ra" placeholder="Ra" 
						pattern="[0-9]*" title="Por favor, digite apenas números."
						 value='<c:out value="${telefone.aluno.ra }"></c:out>'> 
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input class="id_input_data" type="text" maxlength="11"  id="numero" name="numero" placeholder="Numero" 
						pattern="[0-9]*" title="Por favor, digite apenas números."
						 value='<c:out value="${telefone.numero }"></c:out>'> 
					</td>
				</tr>
				<tr>
					<td>
						<input class="botao" type="submit" id="botao" name="botao" value="Cadastrar">
					</td>
					<td>
						<input class="botao" type="submit" id="botao" name="botao" value="Excluir">
					</td>
				</tr>
				
			</table>
		</form>
		
		<form id="alterar" action="telefone" method="post" >
		<table>
			<h1>Alterar/Listar</h1>
				<tr>
					<td colspan="2">
						<input class="id_input_data" type="text"  id="ra" name="ra" placeholder="Ra" 
						pattern="[0-9]*" title="Por favor, digite apenas números."
						 value='<c:out value="${telefone.aluno.ra }"></c:out>'> 
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input class="id_input_data" type="text" maxlength="11"  id="numero_antigo" name="numero_antigo" placeholder="Numero-Antigo" 
						pattern="[0-9]*" title="Por favor, digite apenas números."
						 value='<c:out value="${telefone.numero }"></c:out>'> 
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input class="id_input_data" type="text" maxlength="11"  id="numero_novo" name="numero_novo" placeholder="Numero-Novo" 
						pattern="[0-9]*" title="Por favor, digite apenas números."
						 value='<c:out value="${telefone.numero }"></c:out>'> 
					</td>
				</tr>
				<tr>
					<td>
						<input class="botao" type="submit" id="botao" name="botao" value="Alterar">
					</td>
					<td>
						<input class="botao" type="submit" id="botao" name="botao" value="Listar">
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
	<div align="center" >
	<c:if test="${not empty telefones }">
			<table class="table_round">
				<thead>
					<tr>
						<th class="lista">Numeros</th>
						
					</tr>
				</thead>
				<tbody>
					<c:forEach var="t" items="${telefones }">
						<tr>
							<td class="lista"><c:out value="${t.numero } " /></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
	</div>	
	
	<div id="rodape">
		<p> Desenvolvido por: Kauan Paulino Farias. &copy Todos os Direitos reservados</p>
		<p>Contato para suporte: kauan.farias01@fatecsp.gov.br</p>
	</div>
	
</body>
</html>